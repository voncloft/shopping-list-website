<?php
// Theme values are data only: CSS/HTML/JavaScript cannot be saved as an option.
function shopping_theme_schema() {
    static $schema;
    if ($schema === null) $schema = json_decode(file_get_contents(__DIR__ . '/../include/theme-options.json'), true);
    return $schema;
}
function shopping_theme_defaults() {
    $out = [];
    foreach (shopping_theme_schema() as $key => $field) $out[$key] = $field['default'];
    return $out;
}
function shopping_theme_validate($input, $strict = true) {
    $out = [];
    foreach (shopping_theme_schema() as $key => $field) {
        $v = $input[$key] ?? $field['default'];
        $valid = is_scalar($v);
        if ($valid && $field['type'] === 'color') $valid = preg_match('/^#[0-9a-fA-F]{6}$/D', (string)$v) === 1;
        if ($valid && $field['type'] === 'select') $valid = isset($field['choices'][(string)$v]);
        if ($valid && $field['type'] === 'number') $valid = is_numeric($v) && is_finite((float)$v) && $v >= $field['min'] && $v <= $field['max'];
        if (!$valid && $strict) throw new InvalidArgumentException('Check the value for ' . $field['label'] . '.');
        if (!$valid) $v = $field['default'];
        $out[$key] = $field['type'] === 'number' ? (float)$v : strtolower((string)$v);
    }
    return $out;
}
function shopping_theme_rows($conn) {
    $result = $conn->query('SELECT id,builtin_key,name,options_json FROM shopping_themes ORDER BY id');
    if (!$result) throw new RuntimeException('Theme tables unavailable.');
    $rows = $result->fetch_all(MYSQLI_ASSOC);
    foreach ($rows as &$row) {
        $decoded = json_decode($row['options_json'], true);
        $row['options'] = shopping_theme_validate(is_array($decoded) ? $decoded : [], false);
        unset($row['options_json']);
    }
    return $rows;
}
function shopping_theme_settings($conn) {
    $result = $conn->query('SELECT active_theme_id,mode FROM shopping_theme_settings WHERE id=1');
    if (!$result || !($row = $result->fetch_assoc())) throw new RuntimeException('Theme settings unavailable.');
    return $row;
}
function shopping_theme_css($options) {
    $out = '';
    foreach (shopping_theme_validate($options, false) as $key => $value) {
        if ($key === 'font_family') $value = ['sans'=>'system-ui, sans-serif','serif'=>'Georgia, serif','mono'=>'ui-monospace, monospace'][$value];
        if (in_array($key, ['font_size','cell_padding','border_width','radius'], true)) $value .= 'px';
        $out .= '--' . str_replace('_', '-', $key) . ':' . $value . ';';
    }
    return $out;
}
function shopping_theme_h($s) { return htmlspecialchars((string)$s, ENT_QUOTES, 'UTF-8'); }
function shopping_theme_id($value) {
    if (!is_scalar($value) || !ctype_digit((string)$value) || (int)$value < 1) throw new InvalidArgumentException('Choose a saved theme.');
    return (int)$value;
}
function shopping_theme_write($conn, $sql, $types, &...$values) {
    $stmt = $conn->prepare($sql);
    if (!$stmt) throw new RuntimeException('Could not prepare theme update.');
    $stmt->bind_param($types, ...$values);
    if (!$stmt->execute()) throw new RuntimeException('Could not save theme.');
    $stmt->close();
}

// Used in the document head and by the legacy stylesheet URL. Saved values are
// validated before becoming CSS, and a missing migration keeps the site usable.
function shopping_theme_palette_css($conn) {
    $base = shopping_theme_defaults();
    $dark = null;
    try {
        $themes = shopping_theme_rows($conn);
        $settings = shopping_theme_settings($conn);
        foreach ($themes as $theme) {
            if ($settings['mode'] === 'system') {
                if ($theme['builtin_key'] === 'light') $base = $theme['options'];
                if ($theme['builtin_key'] === 'dark') $dark = $theme['options'];
            } elseif ((int)$theme['id'] === (int)$settings['active_theme_id']) $base = $theme['options'];
        }
    } catch (Throwable $e) {
        error_log('Shopping theme unavailable; using default appearance.');
    }
    $css = ':root{' . shopping_theme_css($base) . '}';
    if ($dark !== null) $css .= '@media(prefers-color-scheme:dark){:root{' . shopping_theme_css($dark) . '}}';
    return $css;
}
