<?php
header('Content-Type: application/json; charset=utf-8');
header('Cache-Control: no-store');

function checkbox_reply($status, $body)
{
    http_response_code($status);
    echo json_encode($body);
    exit;
}

if (($_SERVER['REQUEST_METHOD'] ?? '') !== 'POST') {
    header('Allow: POST');
    checkbox_reply(405, ['ok' => false, 'error' => 'Use POST to update checkmarks.']);
}
if (($_SERVER['HTTP_SEC_FETCH_SITE'] ?? '') === 'cross-site') {
    checkbox_reply(403, ['ok' => false, 'error' => 'Open the shopping list to make this change.']);
}

$action = $_POST['action'] ?? 'set';
if (!is_string($action) || !in_array($action, ['set', 'clear_all'], true)) {
    checkbox_reply(400, ['ok' => false, 'error' => 'Unknown checkbox action.']);
}
if ($action === 'set') {
    $id = filter_var($_POST['id'] ?? null, FILTER_VALIDATE_INT, ['options' => ['min_range' => 1]]);
    $state = $_POST['checked'] ?? null;
    if ($id === false || $id === null || !in_array($state, ['true', 'false'], true)) {
        checkbox_reply(400, ['ok' => false, 'error' => 'Invalid item or checkbox state.']);
    }
    $checked = $state === 'true' ? 1 : 0;
}

$in_transaction = false;
try {
    mysqli_report(MYSQLI_REPORT_ERROR | MYSQLI_REPORT_STRICT);
    require_once __DIR__ . '/../include/passwords.php';
    require_once __DIR__ . '/../functions/final_list_helpers.php';
    $conn->begin_transaction();
    $in_transaction = true;
    // Serialize checkbox requests from multiple tabs/devices before recalculating.
    $conn->query('SELECT weekly_total FROM variables FOR UPDATE');
    if ($action === 'clear_all') {
        $conn->query('UPDATE final_list SET checked = 0');
    } else {
        $stmt = $conn->prepare('SELECT IFRT FROM final_list WHERE IFRT = ? LIMIT 1');
        $stmt->bind_param('i', $id);
        $stmt->execute();
        $stmt->store_result();
        $exists = $stmt->num_rows > 0;
        $stmt->close();
        if (!$exists) {
            $conn->rollback();
            checkbox_reply(404, ['ok' => false, 'error' => 'This item is no longer on the list. Reload the page.']);
        }
        $stmt = $conn->prepare('UPDATE final_list SET checked = ? WHERE IFRT = ?');
        $stmt->bind_param('ii', $checked, $id);
        $stmt->execute();
        $stmt->close();
    }
    $summary = final_list_summary(final_list_rows($conn));
    final_list_store_total($conn, $summary);
    $conn->commit();
    $in_transaction = false;
    checkbox_reply(200, ['ok' => true, 'summary' => $summary]);
} catch (Throwable $error) {
    if ($in_transaction) {
        try { $conn->rollback(); } catch (Throwable $ignored) {}
    }
    error_log('Shopping-list checkbox update failed: ' . $error->getMessage());
    checkbox_reply(500, ['ok' => false, 'error' => 'Could not save the checkmarks. Please try again.']);
}
