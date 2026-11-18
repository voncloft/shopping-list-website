<?php
require_once __DIR__.'/../functions/form_checks.php'; site_post();
require_once __DIR__.'/../include/passwords.php';
$id=site_id($_POST['item_id'] ?? '');
site_transaction($conn,function () use ($conn,$id) {
    $items=site_items($conn);
    if (!isset($items[$id])) throw new InvalidArgumentException('That item no longer exists. Reload the item list.');
    $input=site_item_input($_POST,$items[$id]);
    site_duplicate_item($items,$input['item'],$id);
    extract($input);
    site_execute($conn,'UPDATE items SET grocery_item=?,price=?,department=?,pantryqty=?,servings=?,protein=?,fat=?,carbs=?,calories=?,fiber=?,url=? WHERE ID=?','sdsdddddddsi',$item,$price,$dept,$pantryqty,$servings,$protein,$fat,$carbs,$calories,$fiber,$url,$id);
});
site_success('Item saved.','../php/modify_foods.php');
