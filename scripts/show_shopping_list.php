<?php
require_once __DIR__ . '/../include/passwords.php';
require_once __DIR__ . '/../functions/recipe_summary.php';
require_once __DIR__ . '/../functions/loadFile.php';
$chosen = $_POST['recipes'] ?? [$_GET['recipe_name'] ?? ''];
if (!is_array($chosen)) $chosen = [];
$validRecipes = [];
foreach ($conn->query('SHOW TABLES')->fetch_all(MYSQLI_NUM) as $table) if (substr($table[0],-13) === '_recipe_table') $validRecipes[$table[0]] = true;
$chosen = array_values(array_unique(array_filter($chosen, function ($name) use ($validRecipes) { return is_string($name) && isset($validRecipes[$name]); })));
$urls = [];
foreach ($conn->query('SELECT recipe_name,url FROM recipe_lists')->fetch_all(MYSQLI_ASSOC) as $row) $urls[$row['recipe_name']] = $row['url'];
?>
<!doctype html><html lang="en"><head><meta charset="utf-8"><meta name="viewport" content="width=device-width, initial-scale=1"><?php require_once __DIR__ . '/../include/theme-head.php'; ?><title>Recipes and instructions</title></head><body>
<?php include __DIR__ . '/../include/toolbar.html'; ?></center>
<main class="recipe-detail-page">
<?php if (!$chosen): ?><p>Select a recipe to see its ingredients and steps.</p><?php endif; ?>
<?php $counter=0; foreach ($chosen as $recipe_name): $summary=recipe_summary($recipe_name); $totals=$summary['totals']; ?>
<article class="recipe-detail"><h1><?= recipe_html(str_replace('_',' ',substr($recipe_name,0,-13))) ?></h1>
<?php if ($summary['error']): ?><p class="theme-error theme-notice" role="alert"><?= recipe_html($summary['error']) ?></p><?php endif; ?>
<?php if (in_array(true,$summary['missing'],true)): ?><p class="theme-notice">Some item prices or nutrition values are missing. Totals include the information currently saved.</p><?php endif; ?>
<?php $fat=$totals['fat']; $protein=$totals['protein']; $carbs=$totals['carbs']; $fiber=$totals['fiber']; $calories=$totals['calories']; include __DIR__.'/../chart/macros.php'; $counter++; ?>
<?php $url=$urls[$recipe_name] ?? ''; if (is_string($url) && preg_match('~^https?://~i',$url)): ?><p><a href="<?= recipe_html($url) ?>" target="_blank" rel="noopener">Original recipe website</a></p><?php endif; ?>
<div class="recipe-table-scroll"><table border="2"><caption>Ingredients</caption><thead><tr><th>Qty</th><th>Used Servings</th><th>Item</th><th>Price</th><th>Department</th></tr></thead><tbody>
<?php foreach ($summary['rows'] as $row): $used=$row['used_servings']; if ($used === null || $used === '') $used='auto ('.((float)$row['qty']*(float)$row['servings']).')'; ?>
<tr><td><?= recipe_html($row['qty']) ?></td><td><?= recipe_html($used) ?></td><td><a href="https://www.walmart.com/search?q=<?= rawurlencode($row['grocery_item']) ?>&amp;facet=fulfillment_method_in_store%3AIn-store" target="_blank" rel="noopener"><?= recipe_html($row['grocery_item']) ?></a></td><td><?= $row['price'] === null ? 'Not set' : number_format($row['qty']*$row['price'],2) ?></td><td><?= recipe_html($row['department']) ?></td></tr>
<?php endforeach; ?><tr><td colspan="3">Total Cost<?= $summary['missing']['price'] ? ' (known prices)' : '' ?></td><td><?= number_format($totals['price'],2) ?></td><td></td></tr></tbody></table></div>
<?php loadFile($recipe_name); ?></article><?php endforeach; ?>
<p><a href="../php/show_recipe_no_editing.php">Show Recipe List</a> · <a href="../php/select_shopping_lists_for_week.php">Choose this week's recipes</a></p></main></body></html>
