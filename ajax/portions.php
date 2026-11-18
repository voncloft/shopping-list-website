<?php
require_once __DIR__.'/../functions/form_checks.php';site_post();
require_once __DIR__.'/../include/passwords.php';
$count=site_number($_POST['id'] ?? '', 'Prep portions',false,true,10);
if ($count<1) throw new InvalidArgumentException('Prep portions must be from 1 to 10.');
site_execute($conn,'UPDATE variables SET servings=?','i',$count);
header('Content-Type: application/json; charset=utf-8'); echo json_encode(['ok'=>true]);
