<?php
header('Content-Type: application/json; charset=utf-8');
header('Cache-Control: no-store');
function display_settings_reply($status, $body) {
    http_response_code($status);
    echo json_encode($body);
    exit;
}
$method = $_SERVER['REQUEST_METHOD'] ?? '';
if (!in_array($method, ['GET','POST'], true)) {
    header('Allow: GET, POST');
    display_settings_reply(405, ['ok'=>false,'error'=>'Use GET to read or POST to change this setting.']);
}
if ($method === 'POST' && ($_SERVER['HTTP_SEC_FETCH_SITE'] ?? '') === 'cross-site') {
    display_settings_reply(403, ['ok'=>false,'error'=>'Open the shopping list to make this change.']);
}
if ($method === 'POST' && !in_array($_POST['hide_covered'] ?? null, ['0','1'], true)) {
    display_settings_reply(400, ['ok'=>false,'error'=>'Choose whether to show or hide pantry-covered items.']);
}
try {
    require_once __DIR__ . '/../include/passwords.php';
    require_once __DIR__ . '/../functions/shopping_display_settings.php';
    $settings = shopping_display_settings($conn);
    if ($method === 'POST') {
        $value = (int)$_POST['hide_covered'];
        $stmt = $conn->prepare('UPDATE shopping_display_settings SET hide_covered_items=? WHERE id=1');
        $stmt->bind_param('i', $value);
        $stmt->execute();
        $stmt->close();
        $settings = shopping_display_settings($conn);
    }
    display_settings_reply(200, ['ok'=>true,'hideCovered'=>$settings['hideCovered']]);
} catch (Throwable $e) {
    error_log('Shopping display preference unavailable.');
    display_settings_reply(503, ['ok'=>false,'error'=>'Could not '.($method === 'POST' ? 'save' : 'load').' the display setting. Make sure sql/add_shopping_display_settings.sql has been imported, then try again.']);
}
