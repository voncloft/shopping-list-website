<?php
require_once __DIR__.'/../functions/form_checks.php';site_post();
require_once __DIR__.'/../include/passwords.php';
$selected=$_POST['recipes'] ?? [];
if (!is_array($selected) || !$selected) throw new InvalidArgumentException('Select at least one recipe to remove from this week.');
$available=[];foreach($conn->query('SELECT recipes FROM current_week_recipes')->fetch_all(MYSQLI_ASSOC) as $row)$available[$row['recipes']]=true;
$names=[];foreach ($selected as $value) { $value=site_text($value,'Recipe',true,64);if(!isset($available[$value]))throw new InvalidArgumentException('A selected recipe is no longer imported. Reload the list.');$names[]=$value; }
site_transaction($conn,function () use ($conn,$names) { foreach ($names as $name) { site_execute($conn,'DELETE FROM current_week_recipes WHERE recipes=?','s',$name);site_execute($conn,'DELETE FROM final_list WHERE recipe_table_name=?','s',$name); } });
site_success('Selected recipes removed from this week. Their saved ingredients and instructions are unchanged.','../php/final_shopping_list.php');
