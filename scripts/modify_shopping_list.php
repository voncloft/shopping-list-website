<?php
require_once __DIR__.'/../include/passwords.php';require_once __DIR__.'/../functions/form_checks.php';
$selected=$_POST['recipes'] ?? [];
if (!is_array($selected) || count($selected)!==1) throw new InvalidArgumentException('Choose one recipe to edit at a time.');
$name=site_recipe_name($conn,reset($selected));$items=site_items($conn);
$rows=$conn->query('SELECT id,qty,used_servings,ingredient_name FROM `'.$name.'`')->fetch_all(MYSQLI_ASSOC);
$url='';foreach($conn->query('SELECT recipe_name,url FROM recipe_lists')->fetch_all(MYSQLI_ASSOC) as $r)if($r['recipe_name']===$name)$url=$r['url'];
function recipe_edit_item_select($name,$chosen,$items) {
    echo '<select name="'.$name.'"><option value="">Choose an ingredient</option>';
    foreach($items as $id=>$item)echo '<option value="'.$id.'"'.((string)$id===(string)$chosen?' selected':'').'>'.site_html($item['grocery_item']).'</option>';
    echo '</select>';
}
?><!doctype html><html lang="en"><head><meta charset="utf-8"><meta name="viewport" content="width=device-width, initial-scale=1"><?php require_once __DIR__ . '/../include/theme-head.php'; ?><title>Edit recipe</title></head><body>
<?php include __DIR__.'/../include/toolbar.html'; ?></center><main class="theme-page recipe-editor-page"><h1>Edit <?= site_html(str_replace('_',' ',substr($name,0,-13))) ?></h1>
<form action="apply_changes_to_shopping_list.php" method="post"><input type="hidden" name="recipe_name" value="<?= site_html($name) ?>"><input type="hidden" name="row_count" value="<?= count($rows) ?>">
<p><label>URL (optional) <input type="url" name="url" value="<?= site_html($url) ?>"></label></p><p>Qty is what you buy. Used Servings is what the recipe consumes; leave it blank for the automatic Qty × servings-per-item calculation. Keep at least one ingredient with a positive quantity. Use Remove to delete a row.</p>
<div class="recipe-table-scroll"><table border="1" class="recipe-edit-table"><colgroup><col class="recipe-qty-column"><col class="recipe-servings-column"><col><col class="recipe-remove-column"></colgroup><thead><tr><th>Qty to buy</th><th>Used Servings</th><th>Ingredient</th><th>Remove</th></tr></thead><tbody>
<?php $i=0;foreach($rows as $row):$i++; ?><tr><td><input type="hidden" name="hidden<?= $i ?>" value="<?= (int)$row['id'] ?>"><input type="number" name="recipe_list<?= $i ?>" value="<?= site_html($row['qty']) ?>" required min="0" max="1000000" step="1"></td><td><input type="number" name="used_servings<?= $i ?>" value="<?= site_html($row['used_servings']) ?>" min="0" max="9999999.999" step="0.001" placeholder="auto"></td><td><?php recipe_edit_item_select('select'.$i,$row['ingredient_name'],$items); ?></td><td><input type="checkbox" name="remove<?= $i ?>" value="1" aria-label="Remove ingredient row <?= $i ?>"></td></tr><?php endforeach; ?>
<?php for($i=1;$i<=20;$i++): ?><tr><td><input type="number" name="qtext<?= $i ?>" min="0" max="1000000" step="1"></td><td><input type="number" name="used_add<?= $i ?>" min="0" max="9999999.999" step="0.001" placeholder="auto"></td><td><?php recipe_edit_item_select('select_add'.$i,'',$items); ?></td><td>New row</td></tr><?php endfor; ?>
</tbody></table></div><p><button type="submit">Save recipe changes</button></p></form></main></body></html>
