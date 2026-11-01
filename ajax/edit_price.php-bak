<?php
header('Content-Type: application/json; charset=utf-8');

include '../include/passwords.php';

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    http_response_code(405);
    echo json_encode([
        'ok' => false,
        'error' => 'POST required'
    ]);
    exit;
}

if (!isset($_POST['id'], $_POST['updated_value'])) {
    http_response_code(400);
    echo json_encode([
        'ok' => false,
        'error' => 'Missing id or updated_value'
    ]);
    exit;
}

$id = (int) $_POST['id'];
$updatedValue = round((float) $_POST['updated_value'], 2);

if ($id <= 0) {
    http_response_code(400);
    echo json_encode([
        'ok' => false,
        'error' => 'Invalid id'
    ]);
    exit;
}

$query = "UPDATE items SET price = " . $updatedValue . " WHERE id = " . $id;
$result = mysqli_query($conn, $query);

if ($result === false) {
    http_response_code(500);
    echo json_encode([
        'ok' => false,
        'error' => mysqli_error($conn),
        'query' => $query
    ]);
    exit;
}

echo json_encode([
    'ok' => true,
    'id' => $id,
    'updated_value' => number_format($updatedValue, 2, '.', ''),
    'affected_rows' => mysqli_affected_rows($conn)
]);
?>
