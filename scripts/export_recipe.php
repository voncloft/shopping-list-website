<?php
require_once __DIR__.'/../functions/form_checks.php';site_post();
$name=site_text($_POST['recipe_name'] ?? '', 'Recipe name',true,51);
$stem=trim(preg_replace('/[^A-Za-z0-9]+/','_',$name),'_');
if ($stem==='') throw new InvalidArgumentException('Recipe name must contain a letter or number.');
$table=$stem.'_recipe_table'; $url=site_url($_POST['url'] ?? '');
require_once __DIR__.'/../include/passwords.php';
foreach (array_keys(site_recipe_tables($conn)) as $existing) if (strcasecmp($existing,$table)===0) throw new InvalidArgumentException('A recipe with that name already exists. Choose another name or edit the existing recipe.');
foreach ($conn->query('SELECT recipe_name FROM recipe_lists')->fetch_all(MYSQLI_ASSOC) as $row) if (strcasecmp($row['recipe_name'],$table)===0) throw new InvalidArgumentException('That recipe name is already registered.');
$items=site_items($conn); $rows=[];
for ($i=1;$i<=20;$i++) {
    $qty=$_POST['qty'.$i] ?? ''; $ingredient=$_POST['ingredient'.$i] ?? '';
    if ($qty==='' && $ingredient==='') continue;
    $qty=site_number($qty,'Quantity on row '.$i,false,true,1000000);
    if ($qty<1) throw new InvalidArgumentException('Quantity on row '.$i.' must be at least 1, or leave the row empty.');
    $id=site_id($ingredient,'ingredient on row '.$i);
    if (!isset($items[$id])) throw new InvalidArgumentException('An ingredient no longer exists. Reload the form.');
    $rows[]=[$qty,$id];
}
if (!$rows) throw new InvalidArgumentException('Add at least one ingredient before creating a recipe.');
$created=false;
try {
    $conn->query('CREATE TABLE `'.$table.'` (id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,qty INT NOT NULL,used_servings DECIMAL(10,3) NULL,ingredient_name TEXT) ENGINE=InnoDB');
    $created=true;
    site_transaction($conn,function () use ($conn,$table,$url,$rows) {
        foreach ($rows as $row) { [$qty,$id]=$row; site_execute($conn,'INSERT INTO `'.$table.'` (qty,used_servings,ingredient_name) VALUES (?,NULL,?)','ii',$qty,$id); }
        site_execute($conn,'INSERT INTO recipe_lists (recipe_name,url) VALUES (?,?)','ss',$table,$url);
    });
} catch (Throwable $e) {
    // Only remove the new table created by this request, never an existing recipe.
    if ($created) $conn->query('DROP TABLE `'.$table.'`');
    throw $e;
}
site_success('Recipe created with '.count($rows).' ingredient rows.','show_shopping_list.php?recipe_name='.rawurlencode($table));
