<?php
require_once __DIR__.'/../functions/form_checks.php';
site_post();
$input=site_item_input($_POST);
require_once __DIR__.'/../include/passwords.php';
$id=site_transaction($conn,function () use ($conn,$input) {
    site_duplicate_item(site_items($conn),$input['item']);
    extract($input);
    site_execute($conn,'INSERT INTO items (grocery_item,price,department,pantryqty,servings,protein,fat,carbs,calories,fiber,url) VALUES (?,?,?,?,?,?,?,?,?,?,?)','sdsddddddds',$item,$price,$dept,$pantryqty,$servings,$protein,$fat,$carbs,$calories,$fiber,$url);
    return (int)$conn->insert_id;
});
if (site_json_request()) {
    header('Content-Type: application/json; charset=utf-8');
    echo json_encode(['ok'=>true,'insert_id'=>$id,'item'=>$input['item'],'price'=>number_format($input['price'],2,'.','')]);
} else site_success('Imported Ingredient to main food database. Inserted item ID: '.$id,'../php/add_foods.php');
