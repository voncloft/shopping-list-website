<?php
require_once __DIR__.'/../functions/form_checks.php';site_post();
require_once __DIR__.'/../include/passwords.php';
$id=site_id($_POST['id'] ?? '');
site_execute($conn,'DELETE FROM final_list WHERE IFRT=?','i',$id);
header('Content-Type: application/json; charset=utf-8');echo json_encode(['ok'=>true]);
