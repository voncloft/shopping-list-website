<?php
require_once __DIR__.'/../functions/form_checks.php';site_post();
require_once __DIR__.'/../include/passwords.php';
$name=site_recipe_name($conn,$_POST['recipe_name'] ?? '');$url=site_url($_POST['url'] ?? '');
$items=site_items($conn);$old=$conn->query('SELECT id,qty,used_servings,ingredient_name FROM `'.$name.'`')->fetch_all(MYSQLI_ASSOC);
$count=site_number($_POST['row_count'] ?? '', 'Ingredient count',false,true,10000);
if ($count!==count($old))throw new InvalidArgumentException('The recipe changed while you were editing. Reload it before saving.');
$known=[];foreach($old as $r)$known[(int)$r['id']]=true;
$seen=[];$next=[];
$readRow=function($qty,$used,$ingredient,$label)use($items){
    $qty=site_number($qty,'Quantity '.$label,false,true,1000000);$used=site_number($used,'Used servings '.$label,true,false,9999999.999);$id=site_id($ingredient,'ingredient '.$label);
    if(!isset($items[$id]))throw new InvalidArgumentException('An ingredient no longer exists. Choose a replacement.');
    if($used!==null && abs($used-round($used,3))>0.0000001)throw new InvalidArgumentException('Used servings can have at most three decimal places.');
    return [$qty,$used,$id];
};
for($i=1;$i<=$count;$i++){
    $rowId=site_id($_POST['hidden'.$i] ?? '','recipe row');
    if(!isset($known[$rowId]) || isset($seen[$rowId]))throw new InvalidArgumentException('Ingredient rows are missing or repeated. Reload the recipe.');
    $seen[$rowId]=true;if(($_POST['remove'.$i] ?? '')==='1')continue;
    $next[]=$readRow($_POST['recipe_list'.$i] ?? '',$_POST['used_servings'.$i] ?? '',$_POST['select'.$i] ?? '','on row '.$i);
}
for($i=1;$i<=20;$i++){
    $qty=$_POST['qtext'.$i] ?? '';$used=$_POST['used_add'.$i] ?? '';$ingredient=$_POST['select_add'.$i] ?? '';
    if($qty==='' && $used==='' && $ingredient==='')continue;
    $next[]=$readRow($qty,$used,$ingredient,'on new row '.$i);
}
$usable=false;foreach($next as $r)if($r[0]>0 || $r[1]>0)$usable=true;
if(!$next || !$usable)throw new InvalidArgumentException('Keep at least one ingredient with a positive quantity. The existing recipe was not changed.');
site_transaction($conn,function()use($conn,$name,$url,$next,$old){
    $imported=false;foreach($conn->query('SELECT recipes FROM current_week_recipes')->fetch_all(MYSQLI_ASSOC)as$r)if($r['recipes']===$name)$imported=true;
    $factor=1;$checks=[];
    if($imported){
        $base=[];foreach($old as$r)$base[$r['ingredient_name']]=($base[$r['ingredient_name']]??0)+(float)$r['qty'];
        $current=$conn->query("SELECT IFRT,SUM(QFRT) AS qty,MAX(checked) AS checked FROM final_list WHERE recipe_table_name='".$name."' GROUP BY IFRT")->fetch_all(MYSQLI_ASSOC);
        foreach($current as$r){$checks[$r['IFRT']]=(int)$r['checked'];if(($base[$r['IFRT']]??0)>0)$factor=max(1,(float)$r['qty']/$base[$r['IFRT']]);}
    }
    $conn->query('DELETE FROM `'.$name.'`');
    foreach($next as$r){[$qty,$used,$id]=$r;site_execute($conn,'INSERT INTO `'.$name.'` (qty,used_servings,ingredient_name) VALUES (?,?,?)','idi',$qty,$used,$id);}
    site_execute($conn,'UPDATE recipe_lists SET url=? WHERE recipe_name=?','ss',$url,$name);
    if($imported){
        site_execute($conn,'DELETE FROM final_list WHERE recipe_table_name=?','s',$name);
        // Auto remains NULL; only explicitly entered servings are multiplied and stored.
        foreach($next as$r){[$qty,$used,$id]=$r;$consumed=$used===null?null:$used*$factor;$qty*=$factor;$checked=$checks[$id]??0;
            site_execute($conn,'INSERT INTO final_list (QFRT,used_servings,IFRT,recipe_table_name,checked) VALUES (?,?,?,?,?)','ddisi',$qty,$consumed,$id,$name,$checked);
        }
    }
});
site_success('Recipe updated.','show_shopping_list.php?recipe_name='.rawurlencode($name));
