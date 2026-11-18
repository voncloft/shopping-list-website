<?php
require_once __DIR__ . '/../include/passwords.php';
function getServings() {
    global $conn, $servings_from_db;
    static $cached;
    if ($cached === null) {
        $rows = $conn->query('SELECT servings FROM variables')->fetch_all(MYSQLI_ASSOC);
        $last = $rows ? end($rows) : ['servings'=>1];
        $cached = max(1, (float)$last['servings']);
    }
    $servings_from_db = $cached;
}
