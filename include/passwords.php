<?php
require_once __DIR__ . '/../functions/form_checks.php';
require_once __DIR__ . '/passwords.config.php';
mysqli_report(MYSQLI_REPORT_ERROR | MYSQLI_REPORT_STRICT);
$GLOBALS['conn'] = new mysqli(DBHOST, DBUSER, DBPASS, DBNAME);
$conn->set_charset('utf8mb4');
