<?php
// Sessions start before any markup; only this new settings form requires a token.
session_start();
require_once __DIR__ . '/../functions/themes.php';
require_once __DIR__ . '/../include/passwords.php';
if (empty($_SESSION['theme_token'])) $_SESSION['theme_token'] = bin2hex(random_bytes(32));
$error = ''; $ready = true; $themes = []; $settings = ['active_theme_id'=>0,'mode'=>'fixed'];
try { $themes = shopping_theme_rows($conn); $settings = shopping_theme_settings($conn); }
catch (Throwable $e) { $ready = false; $error = 'Import sql/add_themes.sql into your existing shopping_list database first, then reload this page.'; }
$byId = []; foreach ($themes as $theme) $byId[(int)$theme['id']] = $theme;
$chosenId = isset($_GET['edit']) && is_scalar($_GET['edit']) ? (int)$_GET['edit'] : (int)$settings['active_theme_id'];
$editing = $byId[$chosenId] ?? reset($themes);
$formOptions = $editing ? $editing['options'] : shopping_theme_defaults();
$formName = $editing ? $editing['name'] : '';
if ($_SERVER['REQUEST_METHOD'] === 'POST' && $ready) {
    $transaction = false;
    try {
        if (!is_string($_POST['token'] ?? null) || !hash_equals($_SESSION['theme_token'], $_POST['token'])) throw new InvalidArgumentException('Your form expired. Reload this page and try again.');
        if (($_SERVER['HTTP_SEC_FETCH_SITE'] ?? '') === 'cross-site') throw new InvalidArgumentException('Open Themes on this website to make changes.');
        $action = $_POST['action'] ?? '';
        if ($action === 'choose') {
            $action = ($_POST['theme_id'] ?? '') === 'system' ? 'system' : 'activate';
            if ($action === 'system') $_POST['theme_id'] = (string)$settings['active_theme_id'];
        }
        $id = shopping_theme_id($_POST['theme_id'] ?? '');
        if (!isset($byId[$id])) throw new InvalidArgumentException('That theme no longer exists. Reload this page.');
        if ($action === 'edit') {
            header('Location: themes.php?edit=' . $id, true, 303); exit;
        }
        $conn->begin_transaction(); $transaction = true;
        $lock = $conn->query('SELECT active_theme_id FROM shopping_theme_settings WHERE id=1 FOR UPDATE');
        $activeId = (int)$lock->fetch_assoc()['active_theme_id'];
        if ($action === 'activate' || $action === 'system') {
            $mode = $action === 'system' ? 'system' : 'fixed';
            shopping_theme_write($conn, 'UPDATE shopping_theme_settings SET active_theme_id=?,mode=? WHERE id=1', 'is', $id, $mode);
        } elseif ($action === 'save' || $action === 'create') {
            $name = is_string($_POST['name'] ?? null) ? trim($_POST['name']) : '';
            if ($name === '' || strlen($name) > 80 || preg_match('/[\x00-\x1f]/', $name)) throw new InvalidArgumentException('Give the theme a name of 1–80 bytes without control characters.');
            if (!is_array($_POST['options'] ?? null)) throw new InvalidArgumentException('Theme options are missing.');
            $formName = $name; $formOptions = shopping_theme_validate($_POST['options']);
            foreach ($themes as $row) if (strcasecmp($row['name'], $name) === 0 && ($action === 'create' || (int)$row['id'] !== $id)) throw new InvalidArgumentException('That name is already saved. Use another name for a new theme.');
            $json = json_encode($formOptions, JSON_UNESCAPED_SLASHES | JSON_THROW_ON_ERROR);
            if ($action === 'create') {
                shopping_theme_write($conn, 'INSERT INTO shopping_themes (name,options_json) VALUES (?,?)', 'ss', $name, $json);
                $id = (int)$conn->insert_id;
            } else shopping_theme_write($conn, 'UPDATE shopping_themes SET name=?,options_json=? WHERE id=?', 'ssi', $name, $json, $id);
        } elseif ($action === 'delete') {
            if ($byId[$id]['builtin_key'] !== null) throw new InvalidArgumentException('Keep the built-in themes as starting points. You can edit them or save a copy.');
            $light = null; foreach ($themes as $row) if ($row['builtin_key'] === 'light') $light = (int)$row['id'];
            if (!$light) throw new RuntimeException('Light theme is unavailable.');
            if ($activeId === $id) {
                $mode = 'fixed'; shopping_theme_write($conn, 'UPDATE shopping_theme_settings SET active_theme_id=?,mode=? WHERE id=1', 'is', $light, $mode);
            }
            shopping_theme_write($conn, 'DELETE FROM shopping_themes WHERE id=? AND builtin_key IS NULL', 'i', $id);
            $id = $light;
        } else throw new InvalidArgumentException('Unknown theme action.');
        $conn->commit(); $transaction = false;
        $_SESSION['theme_saved'] = $action === 'activate' || $action === 'system' ? 'Theme applied across the website.' : ($action === 'delete' ? 'Theme deleted.' : 'Theme saved. Use “Apply theme” to select it for the website.');
        $returnTo = $_POST['return_to'] ?? '';
        $redirect = $returnTo === 'home' ? '../index.php' : ($returnTo === 'php_home' ? '../php/index.php' : 'themes.php?edit=' . $id);
        header('Location: ' . $redirect, true, 303); exit;
    } catch (InvalidArgumentException $e) { if ($transaction) $conn->rollback(); $error = $e->getMessage(); }
    catch (Throwable $e) { if ($transaction) $conn->rollback(); error_log('Shopping theme save failed.'); $error = 'The theme could not be saved. Check the database connection and make sure the theme name is unique.'; }
}
$notice = $_SESSION['theme_saved'] ?? ''; unset($_SESSION['theme_saved']);
function theme_hidden($id) { echo '<input type="hidden" name="token" value="'.shopping_theme_h($_SESSION['theme_token']).'"><input type="hidden" name="theme_id" value="'.(int)$id.'">'; }
?>
<!doctype html><html lang="en"><head><meta charset="utf-8"><meta name="viewport" content="width=device-width, initial-scale=1"><title>Themes · Shopping List</title>
<?php require_once __DIR__ . '/../include/theme-head.php'; ?>
<script src="../include/theme-editor.js?v=20261118" defer></script></head><body>
<?php include __DIR__ . '/../include/toolbar.html'; ?></center>
<main class="theme-page">
<h1>Your themes</h1>
<p class="theme-intro">Choose a starting point, change any colors, and save your own theme. Saved choices apply to this website on every device.</p>
<?php if ($error): ?><p role="alert" class="theme-error theme-notice"><?= shopping_theme_h($error) ?></p><?php endif; ?>
<?php if ($notice): ?><p role="status" class="theme-success theme-notice"><?= shopping_theme_h($notice) ?></p><?php endif; ?>
<?php if ($ready && $editing): ?>
<section class="theme-panel">
<h2>Choose a theme</h2>
<p>Currently applied: <strong><?= $settings['mode'] === 'system' ? 'Follow system (Light / Dark)' : shopping_theme_h($byId[(int)$settings['active_theme_id']]['name'] ?? 'Light') ?></strong></p>
<form action="themes.php" method="post" class="theme-actions">
<input type="hidden" name="token" value="<?= shopping_theme_h($_SESSION['theme_token']) ?>">
<label for="theme-picker">Saved themes</label>
<select id="theme-picker" name="theme_id"><?php foreach ($themes as $row): ?><option value="<?= (int)$row['id'] ?>"<?= (int)$row['id'] === (int)$editing['id'] ? ' selected' : '' ?>><?= shopping_theme_h($row['name']) ?></option><?php endforeach; ?></select>
<button name="action" value="activate">Apply theme</button>
<button name="action" value="edit">Load in editor</button>
<button name="action" value="system">Follow system</button>
</form>
<p class="theme-muted">Apply theme uses the selected saved theme immediately. Load in editor opens its colors for editing. Follow system switches between your saved Light and Dark presets.</p>
</section>
<form method="post" id="theme-editor">
<?php theme_hidden($editing['id']); ?>
<section class="theme-panel"><h2>Edit <?= shopping_theme_h($editing['name']) ?></h2>
<label for="theme-name">Theme name</label><input type="text" id="theme-name" name="name" value="<?= shopping_theme_h($formName) ?>" maxlength="80" required>
<p>Change a name and choose Save as new to keep the original. Color changes appear in the sample below while you edit.</p>
<?php $group = null; foreach (shopping_theme_schema() as $key => $field): ?>
<?php if ($group !== $field['group']): ?>
<?php if ($group !== null): ?></tbody></table></details><?php endif; $group = $field['group']; ?>
<details<?= $group === 'Page and links' ? ' open' : '' ?>><summary><?= shopping_theme_h($group) ?></summary><table class="theme-options"><thead><tr><th>Element</th><th>Appearance</th></tr></thead><tbody>
<?php endif; ?>
<tr><td><label for="opt-<?= $key ?>"><?= shopping_theme_h($field['label']) ?></label></td><td><div class="theme-value">
<?php if ($field['type'] === 'color'): ?>
<input type="color" id="opt-<?= $key ?>" name="options[<?= $key ?>]" data-option="<?= $key ?>" value="<?= shopping_theme_h($formOptions[$key]) ?>">
<input type="text" data-color-for="opt-<?= $key ?>" value="<?= shopping_theme_h($formOptions[$key]) ?>" pattern="#[0-9a-fA-F]{6}" maxlength="7" aria-label="<?= shopping_theme_h($field['label']) ?> hex color">
<?php elseif ($field['type'] === 'select'): ?>
<select id="opt-<?= $key ?>" name="options[<?= $key ?>]" data-option="<?= $key ?>"><?php foreach ($field['choices'] as $value=>$label): ?><option value="<?= $value ?>"<?= $formOptions[$key] === $value ? ' selected' : '' ?>><?= shopping_theme_h($label) ?></option><?php endforeach; ?></select>
<?php else: ?>
<input type="number" id="opt-<?= $key ?>" name="options[<?= $key ?>]" data-option="<?= $key ?>" value="<?= shopping_theme_h($formOptions[$key]) ?>" min="<?= $field['min'] ?>" max="<?= $field['max'] ?>" step="<?= $field['step'] ?>" required>
<?php endif; ?></div></td></tr>
<?php endforeach; ?></tbody></table></details></section>
<section id="theme-preview" class="theme-panel"><h2>Live sample</h2>
<p><a href="#theme-preview">Example link</a> · <span class="theme-muted">Secondary text</span></p>
<div class="theme-preview-controls"><button type="button">Example button</button><input aria-label="Example input" value="Example input"><label><input type="checkbox" checked> Got it</label><button type="button" disabled>Disabled</button></div>
<table class="theme-preview-table"><thead><tr><th>Description</th><th>Quantity</th><th>Price</th></tr></thead><tbody><tr><td>Bell peppers</td><td>3</td><td>$4.14</td></tr><tr><td>Chicken</td><td>1</td><td>$9.50</td></tr><tr class="theme-preview-covered"><td>Already in pantry</td><td>1</td><td>$0.00</td></tr></tbody></table>
<div class="theme-preview-controls"><div class="theme-preview-chart" aria-label="Sample nutrition chart"></div><p>Carbs · Protein · Fat · Fiber<br><span class="theme-muted">Uses the same colors as item nutrition.</span></p></div>
<p class="theme-error">Example error message</p><p class="theme-success">Example saved message</p>
</section>
<div class="theme-save-bar theme-actions"><button name="action" value="save">Save changes</button><button name="action" value="create">Save as new</button><button type="button" id="preview-reset">Undo unsaved changes</button></div>
</form>
<?php if ($editing['builtin_key'] === null): ?><form method="post" class="theme-panel" id="delete-theme-form"><?php theme_hidden($editing['id']); ?><p>Delete this custom theme. If it is active, the website returns to Light.</p><button name="action" value="delete">Delete <?= shopping_theme_h($editing['name']) ?></button></form><?php endif; ?>
<?php endif; ?></main></body></html>
