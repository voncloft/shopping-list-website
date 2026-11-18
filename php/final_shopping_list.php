<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1"><?php require_once __DIR__ . '/../include/theme-head.php'; ?>
<title>Shopping List</title>
<link rel="stylesheet" href="../include/final-shopping-list.css?v=20261118b">
<script src="../include/final-shopping-list.js?v=20261118d" defer></script>
</head>
<body>
<?php
include_once __DIR__ . '/../include/passwords.php';
include_once __DIR__ . '/../include/toolbar.html';
require_once __DIR__ . '/../functions/get_servings.php';
require_once __DIR__ . '/../functions/final_list_helpers.php';
getServings();
$servings_from_db = max(1, (float)$servings_from_db);
$rows = final_list_rows($conn);
$summary = final_list_summary($rows);
final_list_store_total($conn, $summary);
$fat = $protein = $carbs = $fiber = $calories = 0;
$counter = 0;
foreach ($rows as $row) {
    $used = (float)$row['total_used_servings'];
    $fat += $used * (float)$row['fat'];
    $protein += $used * (float)$row['protein'];
    $carbs += $used * (float)$row['carbs'];
    $fiber += $used * (float)$row['fiber'];
    $calories += $used * (float)$row['calories'];
}
?>
<form id="shopping-form" action="../scripts/clear_final.php" method="post">
<center>
<h1>Shopping List</h1>
<label for="portions">Portions for Prep:</label>
<select name="portions" id="portions">
<?php for ($i = 1; $i <= 10; $i++): ?>
<option value="<?= $i ?>"<?= $i == $servings_from_db ? ' selected' : '' ?>><?= $i ?></option>
<?php endfor; ?>
</select>
<?php
// Keep the nutrition notice from earlier upgrades when that helper is installed.
if (is_file(__DIR__ . '/../functions/recipe_nutrition.php')) {
    require_once __DIR__ . '/../functions/recipe_nutrition.php';
    show_incomplete_nutrition_notice($rows);
}
include __DIR__ . '/../chart/macros.php';
?>
<div class="shopping-actions">
    <button type="button" id="open-all-links">Open all Walmart links</button>
    <button type="button" id="clear-got-it"<?= count($summary['checkedIds']) === 0 ? ' disabled' : '' ?>>Clear all Got it</button>
    <button type="button" id="toggle-covered-items" aria-pressed="false" aria-controls="shopping-items" hidden>Hide grey items</button>
</div>
<p class="shopping-hint">Open all opens saved links from non-grey rows only. Grey pantry-covered items are skipped. Allow pop-ups for this shopping-list site if prompted.</p>
<p class="shopping-hint">Tap + beside an item for its nutrition in one prep portion.</p>
<p class="shopping-hint">Grey rows are covered by your pantry and stay at the bottom. Edit Pantry Qty and press Enter to update. Hide grey items only changes what you see; totals and nutrition stay the same.</p>
<p id="all-items-covered" hidden>All items are covered by your pantry. Choose Show grey items to see them.</p>
<p id="shopping-status" role="status" aria-live="polite"></p>
<noscript>Enable JavaScript to update checkmarks, sort items, and expand nutrition.</noscript>
<div class="shopping-layout-viewport"><div class="shopping-layout">
<div class="shopping-scroll">
<table id="shopping-items" class="searchable" border="2">
<thead><tr>
<?php
$headers = [
    ['Ignore?', 'text'], ['Got it', 'checked'], ['Qty', 'number'],
    ['Pantry Qty', 'number'], ['Description', 'text'], ['Price', 'number'],
    ['Location', 'text'], ['Recipe List(s)', 'text'], ['Link', 'text'],
];
foreach ($headers as $column => $header):
?>
<th scope="col" data-sort-type="<?= $header[1] ?>" aria-sort="none"><button type="button" class="sort-heading" data-column="<?= $column ?>"><?= $header[0] ?></button></th>
<?php endforeach; ?>
</tr></thead>
<tbody>
<?php foreach ($rows as $row):
    $covered = final_list_needed($row) <= 0;
    $id = (int)$row['IFRT'];
    $cents = final_list_row_cents($row);
    $url = final_list_item_url($row['url'], $id);
    $name = $row['grocery_item'];
    $macros = final_list_portion_macros($row, $servings_from_db);
    $recipes = $conn->query('SELECT DISTINCT recipe_table_name FROM final_list WHERE IFRT = ' . $id)->fetch_all(MYSQLI_ASSOC);
    $recipe_names = [];
    foreach ($recipes as $recipe) {
        $recipe_names[] = str_replace('_', ' ', str_replace('_recipe_table', '', $recipe['recipe_table_name']));
    }
?>
<tr class="<?= $covered ? 'pantry-covered' : 'needs-buying' ?>" data-pantry-covered="<?= $covered ? '1' : '0' ?>" data-item-id="<?= $id ?>" data-price-cents="<?= $cents ?>" data-missing-price="<?= !$covered && ($row['price'] === null || $row['price'] === '') ? '1' : '0' ?>">
<td class="center"><input type="checkbox" class="ignoreIt" value="<?= $id ?>" aria-label="Ignore <?= final_list_html($name) ?>"></td>
<td class="center"><input type="checkbox" class="checkIt" value="<?= $id ?>" aria-label="Got <?= final_list_html($name) ?>"<?= (int)$row['checked'] === 1 ? ' checked' : '' ?>></td>
<td class="center" data-sort-value="<?= final_list_html($row['totalsum']) ?>"><?= final_list_html($row['totalsum']) ?></td>
<td contenteditable="true" class="pantry-qty center" role="textbox" tabindex="0" inputmode="decimal" enterkeyhint="done" title="Edit pantry quantity and press Enter to save" data-item-id="<?= $id ?>" data-original="<?= final_list_html($row['pantryqty'] ?? 0) ?>" aria-label="Pantry quantity for <?= final_list_html($name) ?>"><?= final_list_html($row['pantryqty'] ?? 0) ?></td>
<td class="description-cell" data-sort-value="<?= final_list_html($name) ?>">
    <div class="item-heading">
        <button type="button" class="macro-toggle" aria-expanded="false" aria-controls="macros-<?= $id ?>" aria-label="Show nutrition for <?= final_list_html($name) ?>">+</button>
        <a target="_blank" rel="noopener" href="<?= final_list_html('https://www.walmart.com/search?q=' . rawurlencode($name) . '&facet=fulfillment_method_in_store%3AIn-store') ?>"><?= final_list_html($name) ?></a>
    </div>
    <div class="macro-details" id="macros-<?= $id ?>" hidden>
        <p><strong>Per prep portion (1 of <?= final_list_html($servings_from_db) ?>)</strong></p>
        <dl>
        <?php foreach (['calories' => 'Calories', 'fat' => 'Fat', 'protein' => 'Protein', 'carbs' => 'Carbs', 'fiber' => 'Fiber', 'net-carbs' => 'Net carbs'] as $field => $label): ?>
        <div class="macro-card macro-<?= $field ?>">
            <dt><?= $label ?></dt>
            <dd data-macro="<?= $field ?>"><?= $macros[$field] === null ? 'Not set' : number_format($macros[$field], 2, '.', '') . ($field === 'calories' ? ' kcal' : ' g') ?></dd>
        </div>
        <?php endforeach; ?>
        </dl>
        <p class="macro-missing">Recipe amount divided by <?= final_list_html($servings_from_db) ?> portions. Includes ingredients supplied from your pantry.</p>
        <?php if (in_array(null, $macros, true)): ?><p class="macro-missing">Some nutrition or serving information is missing from this food's entry.</p><?php endif; ?>
    </div>
</td>
<td class="center" data-sort-value="<?= $cents ?>"><?= number_format($cents / 100, 2, '.', '') ?></td>
<td class="center"><?= final_list_html($row['department']) ?></td>
<td data-sort-value="<?= final_list_html(implode(', ', $recipe_names)) ?>">
<?php foreach ($recipes as $index => $recipe): ?>
<?= $index > 0 ? ', ' : '' ?><a target="_blank" rel="noopener" href="../scripts/show_shopping_list.php?recipe_name=<?= rawurlencode($recipe['recipe_table_name']) ?>"><?= final_list_html($recipe_names[$index]) ?></a>
<?php endforeach; ?>
</td>
<td><?php if ($url !== ''): ?><a class="shopping-item-link" target="_blank" rel="noopener" href="<?= final_list_html($url) ?>">link</a><?php else: ?>No link<?php endif; ?></td>
</tr>
<?php endforeach; ?>
</tbody>
</table>
<?php if (count($rows) === 0): ?><p>Your shopping list is empty.</p><?php endif; ?>
</div>
<aside class="shopping-totals" aria-live="polite" aria-atomic="true">
<h2 title="Pantry quantities reduce the estimate. Got it checkmarks only reduce Still to buy.">Est total</h2>
<p><span>Bill:</span> <span id="estimated-bill">$<?= number_format($summary['fullSubtotalCents'] / 100, 2) ?></span></p>
<p><span>Tax (6%):</span> <span id="estimated-tax">$<?= number_format($summary['fullTaxCents'] / 100, 2) ?></span></p>
<p class="grand-total"><span>Total:</span> <strong id="full-list-total">$<?= number_format($summary['fullTotalCents'] / 100, 2) ?></strong></p>
<p><span>Still to buy:</span> <strong id="remaining-total">$<?= number_format($summary['totalCents'] / 100, 2) ?></strong></p>
<p id="missing-prices"<?= $summary['missingPrices'] === 0 ? ' hidden' : '' ?>>Some items have no saved price. These totals exclude their cost.</p>
</aside>
</div></div>
<p class="clear-table">Clear table <input type="submit" value="Submit"></p>
</center>
</form>
<script type="application/json" id="shopping-state"><?= json_encode($summary, JSON_HEX_TAG | JSON_HEX_AMP | JSON_HEX_APOS | JSON_HEX_QUOT) ?></script>
<a href="../index.php">Main Page</a>
</body>
</html>
