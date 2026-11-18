<?php
require_once __DIR__.'/../functions/form_checks.php';site_post();
require_once __DIR__.'/../include/passwords.php';
$name=site_recipe_name($conn,$_POST['recipe_table'] ?? '');
$instructions=site_text($_POST['instructions'] ?? '', 'Steps',true,100000);
$rows=$conn->query('SELECT i.grocery_item FROM `'.$name.'` r INNER JOIN items i ON r.ingredient_name=i.ID')->fetch_all(MYSQLI_ASSOC);
$count=site_number($_POST['count'] ?? '', 'Ingredient count',false,true,10000);
if(!$rows || $count!==count($rows))throw new InvalidArgumentException('The ingredient list changed. Reload the instructions form.');
$allowed=[];foreach($conn->query('SELECT unit_of_measurement FROM measurements')->fetch_all(MYSQLI_ASSOC)as$r)$allowed[$r['unit_of_measurement']]=true;
$ingredients='<h2>Ingredients</h2><ul>';$used=0;
for($i=1;$i<=$count;$i++){
    $qty=site_number($_POST['qty'.$i] ?? '', 'Quantity on row '.$i);
    $unit=site_text($_POST['measurement'.$i] ?? '', 'Measurement');
    $ingredient=site_text($_POST['ingredient'.$i] ?? '', 'Ingredient');
    if(!isset($allowed[$unit]) || $ingredient!==$rows[$i-1]['grocery_item'])throw new InvalidArgumentException('An ingredient or measurement changed. Reload the form.');
    if($qty>0){$ingredients.='<li>'.site_html($qty.' '.($unit==='N/A'?'':$unit).' '.$ingredient).'</li>';$used++;}
}
if(!$used)throw new InvalidArgumentException('Enter a positive quantity for at least one ingredient.');
$ingredients.='</ul>';$steps='<h2>Steps</h2><p>'.nl2br(site_html($instructions)).'</p>';
$files=[__DIR__.'/../recipes/ingredients/'.$name.'_ingredients.html'=>$ingredients,__DIR__.'/../recipes/steps/'.$name.'_steps.html'=>$steps];
$temp=[];$original=[];$replaced=[];
try {
    foreach($files as$file=>$content){
        if(!is_writable(dirname($file)) || (is_file($file)&&!is_writable($file)))throw new InvalidArgumentException('The web server cannot write the recipe files. Restore the recipes folder permissions; nothing was saved.');
        $original[$file]=is_file($file)?file_get_contents($file):null;
        $tmp=tempnam(dirname($file),'.recipe-');if($tmp===false)throw new RuntimeException('Temporary file unavailable.');$temp[$file]=$tmp;
        if(file_put_contents($tmp,$content,LOCK_EX)!==strlen($content))throw new RuntimeException('Recipe write failed.');
        chmod($tmp,is_file($file)?(fileperms($file)&0777):0644);
    }
    foreach($temp as$file=>$tmp){if(!rename($tmp,$file))throw new RuntimeException('Recipe replace failed.');$replaced[]=$file;}
}catch(Throwable$e){foreach($replaced as$file){if($original[$file]===null)unlink($file);else file_put_contents($file,$original[$file],LOCK_EX);}foreach($temp as$tmp)if(is_file($tmp))unlink($tmp);throw $e;}
site_success('Recipe ingredients and steps saved.','show_shopping_list.php?recipe_name='.rawurlencode($name));
