<?php
function wants_json_response()
{
    $accept = isset($_SERVER['HTTP_ACCEPT']) ? $_SERVER['HTTP_ACCEPT'] : '';
    return (isset($_POST['format']) && $_POST['format'] === 'json') || stripos($accept, 'application/json') !== false;
}

function json_exit($payload, $statusCode = 200)
{
    http_response_code($statusCode);
    header('Content-Type: application/json; charset=utf-8');
    echo json_encode($payload);
    exit;
}

function read_post_string($key)
{
    return isset($_POST[$key]) ? trim((string) $_POST[$key]) : '';
}

function read_post_float($key)
{
    $raw = isset($_POST[$key]) ? trim((string) $_POST[$key]) : '';
    $raw = str_replace(',', '', $raw);

    return $raw === '' ? 0.0 : (float) $raw;
}

$wantsJson = wants_json_response();

include '../include/passwords.php';

$ok = false;
$error = '';
$insertId = 0;
$item = '';

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    $error = 'POST required';

    if ($wantsJson) {
        json_exit([
            'ok' => false,
            'error' => $error
        ], 405);
    }
} else {
    $item = read_post_string('item');
    $price = read_post_float('price');
    $department = read_post_string('dept');
    $servings = read_post_float('servings');
    $protein = read_post_float('protein');
    $fat = read_post_float('fat');
    $carbs = read_post_float('carbs');
    $calories = read_post_float('calories');
    $fiber = read_post_float('fiber');
    $url = read_post_string('url');

    if ($item === '') {
        $error = 'Missing item';

        if ($wantsJson) {
            json_exit([
                'ok' => false,
                'error' => $error
            ], 400);
        }
    } else {
        $stmt = mysqli_prepare(
            $conn,
            "INSERT INTO items (grocery_item, price, department, pantryqty, servings, protein, fat, carbs, calories, fiber, url)
             VALUES (?, ?, ?, '0', ?, ?, ?, ?, ?, ?, ?)"
        );

        if ($stmt === false) {
            $error = mysqli_error($conn);

            if ($wantsJson) {
                json_exit([
                    'ok' => false,
                    'error' => $error
                ], 500);
            }
        } else {
            mysqli_stmt_bind_param(
                $stmt,
                'sdsdddddds',
                $item,
                $price,
                $department,
                $servings,
                $protein,
                $fat,
                $carbs,
                $calories,
                $fiber,
                $url
            );

            $ok = mysqli_stmt_execute($stmt);

            if ($ok) {
                $insertId = mysqli_insert_id($conn);
            } else {
                $error = mysqli_stmt_error($stmt);
            }

            mysqli_stmt_close($stmt);

            if ($wantsJson) {
                if (!$ok) {
                    json_exit([
                        'ok' => false,
                        'error' => $error
                    ], 500);
                }

                json_exit([
                    'ok' => true,
                    'insert_id' => $insertId,
                    'item' => $item,
                    'price' => number_format($price, 2, '.', '')
                ]);
            }
        }
    }
}
?>
<meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
<?php include '../include/toolbar.html'; ?>
<br><br>
<?php if ($ok) { ?>
Imported Ingredient to main food database<br>
Inserted item ID: <?php echo (int) $insertId; ?>
<?php } else { ?>
Failed to import ingredient to main food database.<br>
<?php if ($error !== '') { ?>
<?php echo htmlspecialchars($error, ENT_QUOTES, 'UTF-8'); ?>
<?php } ?>
<?php } ?>
<br>
<a href="../php/add_foods.php">Add Another Item</a><br>
<a href="../index.php">Main Page</a><br>
    
