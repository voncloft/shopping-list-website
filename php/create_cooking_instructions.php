<?php
require_once __DIR__.'/../include/passwords.php';require_once __DIR__.'/../functions/form_checks.php';
$tables=site_recipe_tables($conn);$selected=$_GET['selected_recipe'] ?? '';$rows=[];$measurements=[];
if($selected!==''){
    $selected=site_recipe_name($conn,$selected);
    $rows=$conn->query('SELECT r.ingredient_name,i.grocery_item FROM `'.$selected.'` r LEFT JOIN items i ON r.ingredient_name=i.ID')->fetch_all(MYSQLI_ASSOC);
    if(!$rows)throw new InvalidArgumentException('Add ingredients to this recipe before creating its instructions.');
    foreach($rows as$r)if($r['grocery_item']===null)throw new InvalidArgumentException('Replace missing ingredients in the recipe editor first.');
    $measurements=$conn->query('SELECT unit_of_measurement FROM measurements')->fetch_all(MYSQLI_ASSOC);
}
?><!doctype html><html lang="en"><head><meta charset="utf-8"><meta name="viewport" content="width=device-width, initial-scale=1"><?php require_once __DIR__ . '/../include/theme-head.php'; ?><title>Recipe instructions</title></head><body>
<?php include __DIR__.'/../include/toolbar.html'; ?></center><main class="theme-page"><h1>Recipe instructions</h1>
<form method="get"><label>Recipe <select name="selected_recipe" required><option value="">Choose a recipe</option><?php foreach($tables as$name=>$ignored): ?><option value="<?= site_html($name) ?>"<?= $selected===$name?' selected':'' ?>><?= site_html(trim(str_replace('_',' ',substr($name,0,-13))) ?: 'Unnamed recipe') ?></option><?php endforeach; ?></select></label><button type="submit">Load ingredients</button></form>
<?php if($selected!==''): ?><form method="post" action="../scripts/save_recipe_instructions.php"><input type="hidden" name="recipe_table" value="<?= site_html($selected) ?>"><input type="hidden" name="count" value="<?= count($rows) ?>">
<table border="1"><thead><tr><th>Quantity used in instructions</th><th>Measurement</th><th>Ingredient</th></tr></thead><tbody><?php $i=0;foreach($rows as$row):$i++; ?><tr><td><input name="qty<?= $i ?>" type="number" step="any" min="0" required></td><td><select name="measurement<?= $i ?>" required><?php foreach($measurements as$m): ?><option><?= site_html($m['unit_of_measurement']) ?></option><?php endforeach; ?></select></td><td><?= site_html($row['grocery_item']) ?><input type="hidden" name="ingredient<?= $i ?>" value="<?= site_html($row['grocery_item']) ?>"></td></tr><?php endforeach; ?></tbody></table>
<p><label>Steps <textarea name="instructions" rows="18" required style="width:100%;box-sizing:border-box" placeholder="Write the steps in plain language. New lines will be kept."></textarea></label></p><p>Saving replaces this recipe's ingredient instructions and steps. The existing instructions can be viewed below before writing a replacement.</p><button type="submit">Save instructions</button></form>
<p><a target="_blank" rel="noopener" href="../scripts/show_shopping_list.php?recipe_name=<?= rawurlencode($selected) ?>">View current ingredients and steps</a></p><?php endif; ?></main></body></html>
