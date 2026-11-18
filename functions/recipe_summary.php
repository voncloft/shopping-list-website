<?php
require_once __DIR__ . '/get_servings.php';
require_once __DIR__ . '/form_checks.php';
function recipe_prep_portions() {
    static $portions;
    if ($portions === null) { getServings(); global $servings_from_db; $portions = max(1, (float)$servings_from_db); }
    return $portions;
}
function recipe_html($value) { return htmlspecialchars((string)$value, ENT_QUOTES, 'UTF-8'); }
function recipe_summary($recipe_name) {
    global $conn;
    static $cache = [];
    if (isset($cache[$recipe_name])) return $cache[$recipe_name];
    if (!preg_match('/^[A-Za-z0-9_]*_recipe_table$/D', $recipe_name)) throw new InvalidArgumentException('Invalid recipe name.');
    $problem='';
    try {
        $rows = $conn->query('SELECT r.id AS recipe_row_id,r.qty,r.used_servings,r.ingredient_name,i.ID AS item_id,i.price,i.servings,i.calories,i.fat,i.protein,i.carbs,i.fiber,i.grocery_item,i.department FROM `' . $recipe_name . '` r LEFT JOIN items i ON r.ingredient_name=i.ID')->fetch_all(MYSQLI_ASSOC);
    } catch (Throwable $e) { $rows=[]; $problem='This recipe could not be loaded. Its table may be missing or need repair.'; }
    if (!$rows && !$problem) $problem='This recipe has no ingredients yet. Add ingredients in the recipe editor before importing it.';
    $usable=false;
    foreach ($rows as $row) {
        if ($row['item_id'] === null) $problem='This recipe refers to an item that is no longer in the food database. Choose a replacement in the recipe editor.';
        if ((float)$row['qty']<0 || (float)$row['used_servings']<0) $problem='This recipe contains a negative quantity. Correct it in the recipe editor.';
        if ((float)$row['qty']>0 || (float)$row['used_servings']>0) $usable=true;
    }
    if (!$usable && !$problem) $problem='All ingredient quantities are zero. Add a usable quantity before importing this recipe.';
    $totals = ['price'=>0,'calories'=>0,'fat'=>0,'protein'=>0,'carbs'=>0,'fiber'=>0];
    $missing = array_fill_keys(array_keys($totals), false);
    foreach ($rows as $row) {
        $qty = (float)$row['qty'];
        $fallback = $row['used_servings'] === null || $row['used_servings'] === '';
        $used = $fallback ? $qty * (float)$row['servings'] : (float)$row['used_servings'];
        $missing['price'] = $missing['price'] || ($qty != 0 && ($row['price'] === null || $row['price'] === ''));
        $totals['price'] += $qty * (float)$row['price'];
        foreach (['calories','fat','protein','carbs','fiber'] as $key) {
            $missing[$key] = $missing[$key] || ($used != 0 && ($row[$key] === null || $row[$key] === '')) || ($qty != 0 && $fallback && ($row['servings'] === null || $row['servings'] === ''));
            $totals[$key] += $used * (float)$row[$key];
        }
    }
    $portion = [];
    foreach ($totals as $key=>$value) $portion[$key] = $missing[$key] ? null : round($value / ($key === 'price' ? 1 : recipe_prep_portions()), 2);
    $portion['net_carbs'] = $missing['carbs'] || $missing['fiber'] ? null : round($portion['carbs'] - $portion['fiber'], 2);
    return $cache[$recipe_name] = ['rows'=>$rows,'totals'=>$totals,'portion'=>$portion,'missing'=>$missing,'error'=>$problem];
}
