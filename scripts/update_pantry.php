<?php
require_once __DIR__.'/../functions/form_checks.php';site_post();
require_once __DIR__.'/../include/passwords.php';
$id=site_id($_POST['item_id'] ?? ''); $qty=site_number($_POST['pantryqty'] ?? '', 'Pantry quantity');
$items=site_items($conn);
if (!isset($items[$id])) throw new InvalidArgumentException('That item no longer exists. Reload the pantry page.');
site_execute($conn,'UPDATE items SET pantryqty=? WHERE ID=?','di',$qty,$id);
site_success('Pantry quantity saved for '.$items[$id]['grocery_item'].'.','../php/pantry.php');
