<?php
require_once __DIR__.'/../functions/form_checks.php';site_post();
require_once __DIR__.'/../include/passwords.php';
$id=site_id($_POST['id'] ?? '');$qty=site_number($_POST['updated_value'] ?? '', 'Pantry quantity');
if (!isset(site_items($conn)[$id])) throw new InvalidArgumentException('Item not found. Reload the list.');
site_execute($conn,'UPDATE items SET pantryqty=? WHERE ID=?','di',$qty,$id);
header('Content-Type: application/json; charset=utf-8'); echo json_encode(['ok'=>true]);
