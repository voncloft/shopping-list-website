<?php
// Deploy as ajax/edit_price.php in the shopping website, next to ../include/.
header('Content-Type: application/json; charset=utf-8');

function price_update_response($status, $body) {
    http_response_code($status);
    echo json_encode($body);
    exit;
}

if (($_SERVER['REQUEST_METHOD'] ?? '') !== 'POST') {
    price_update_response(405, ['ok' => false, 'error' => 'POST required']);
}
if (!isset($_POST['id'], $_POST['updated_value'])) {
    price_update_response(400, ['ok' => false, 'error' => 'Missing id or updated_value']);
}

$rawId = is_string($_POST['id']) ? trim($_POST['id']) : '';
if (!preg_match('/^[0-9]+$/D', $rawId) || (float) $rawId > 2147483647 || (int) $rawId <= 0) {
    price_update_response(400, ['ok' => false, 'error' => 'Invalid id']);
}
$id = (int) $rawId;
$rawPrice = is_string($_POST['updated_value']) ? trim($_POST['updated_value']) : '';
// items.price is DECIMAL(14,2). Reject malformed prices instead of saving zero.
if (!preg_match('/^[0-9]{1,12}(?:\.[0-9]{1,2})?$/D', $rawPrice)) {
    price_update_response(400, ['ok' => false, 'error' => 'Invalid price']);
}
$updatedValue = number_format((float) $rawPrice, 2, '.', '');

// The food importer already maps the dept form field to items.department.
$department = '';
if (isset($_POST['dept'])) {
    if (!is_string($_POST['dept'])) {
        price_update_response(400, ['ok' => false, 'error' => 'Invalid aisle']);
    }
    $department = strtoupper(trim($_POST['dept']));
    if ($department !== '' && (strlen($department) > 32 || !preg_match('/^[A-Z]?[0-9]+[A-Z0-9-]*$/D', $department))) {
        price_update_response(400, ['ok' => false, 'error' => 'Invalid aisle']);
    }
}

try {
    mysqli_report(MYSQLI_REPORT_ERROR | MYSQLI_REPORT_STRICT);
    require __DIR__ . '/../include/passwords.php';

    if ($department !== '') {
        $stmt = $conn->prepare('UPDATE items SET price = ?, department = ? WHERE ID = ?');
        $stmt->bind_param('ssi', $updatedValue, $department, $id);
    } else {
        // Older clients and pages without an aisle must preserve the saved aisle.
        $stmt = $conn->prepare('UPDATE items SET price = ? WHERE ID = ?');
        $stmt->bind_param('si', $updatedValue, $id);
    }
    $stmt->execute();
    $affectedRows = $stmt->affected_rows;
    $stmt->close();

    if ($affectedRows === 0) {
        // An unchanged row is successful; a nonexistent product is not.
        $check = $conn->prepare('SELECT ID FROM items WHERE ID = ?');
        $check->bind_param('i', $id);
        $check->execute();
        $check->store_result();
        $exists = $check->num_rows > 0;
        $check->close();
        if (!$exists) {
            price_update_response(404, ['ok' => false, 'error' => 'Item not found']);
        }
    }

    price_update_response(200, [
        'ok' => true,
        'id' => $id,
        'updated_value' => $updatedValue,
        'department' => $department !== '' ? $department : null,
        'department_updated' => $department !== '',
        'affected_rows' => $affectedRows
    ]);
} catch (Throwable $error) {
    error_log('Price/aisle update failed: ' . $error->getMessage());
    price_update_response(500, ['ok' => false, 'error' => 'Database update failed']);
}
