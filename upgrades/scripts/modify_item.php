<?php
// Process the form before producing output. Unknown numeric values stay NULL.
function item_edit_text($key)
{
    if (!isset($_POST[$key]) || !is_string($_POST[$key])) {
        throw new InvalidArgumentException('Incomplete item form. Reload Edit Items and try again.');
    }
    return $_POST[$key];
}

function item_edit_number($key, $label)
{
    $value = trim(item_edit_text($key));
    if ($value === '') {
        return null;
    }
    if (!is_numeric($value) || !is_finite((float) $value)) {
        throw new InvalidArgumentException($label . ' must be a number or blank.');
    }
    return $value;
}

$error = '';
$saved = 0;
$transactionStarted = false;
$conn = null;
$stmt = null;

try {
    if (($_SERVER['REQUEST_METHOD'] ?? '') !== 'POST') {
        throw new InvalidArgumentException('Open Edit Items and submit the form to save changes.');
    }

    // This marker is last in the form, so truncated submissions cannot erase rows.
    $count = filter_var(item_edit_text('item_edit_count'), FILTER_VALIDATE_INT,
        ['options' => ['min_range' => 1]]);
    if ($count === false) {
        throw new InvalidArgumentException('Invalid item count. Reload Edit Items and try again.');
    }

    $rows = [];
    for ($i = 1; $i <= $count; $i++) {
        $id = filter_var(item_edit_text('idtb' . $i), FILTER_VALIDATE_INT,
            ['options' => ['min_range' => 1]]);
        $item = item_edit_text('itemtb' . $i);
        if ($id === false || trim($item) === '') {
            throw new InvalidArgumentException('Each item needs a valid ID and a name.');
        }
        $row = [
            'id' => $id,
            'item' => $item,
            'url' => trim(item_edit_text('url' . $i)),
            'price' => item_edit_number('pricetb' . $i, $item . ': price'),
            'department' => item_edit_text('dtb' . $i)
        ];
        foreach (['servings', 'calories', 'fat', 'protein', 'carbs', 'fiber'] as $field) {
            $row[$field] = item_edit_number($field . $i, $item . ': ' . $field);
        }
        // Retain the existing editor's negative-servings convention.
        if ($row['servings'] !== null && (float) $row['servings'] < 0) {
            foreach (['servings', 'calories', 'fat', 'protein', 'carbs', 'fiber'] as $field) {
                $row[$field] = 0;
            }
        }
        $rows[] = $row;
    }

    mysqli_report(MYSQLI_REPORT_ERROR | MYSQLI_REPORT_STRICT);
    include '../include/passwords.php';
    $conn->begin_transaction();
    $transactionStarted = true;
    $stmt = $conn->prepare('UPDATE items SET url=?, grocery_item=?, price=?, department=?,
        servings=?, calories=?, fat=?, protein=?, carbs=?, fiber=? WHERE ID=?');
    foreach ($rows as $row) {
        $url = $row['url'];
        $item = $row['item'];
        $price = $row['price'];
        $department = $row['department'];
        $servings = $row['servings'];
        $calories = $row['calories'];
        $fat = $row['fat'];
        $protein = $row['protein'];
        $carbs = $row['carbs'];
        $fiber = $row['fiber'];
        $id = $row['id'];
        // Bind price as text to preserve decimal precision; null still binds SQL NULL.
        $stmt->bind_param('ssssddddddi', $url, $item, $price, $department,
            $servings, $calories, $fat, $protein, $carbs, $fiber, $id);
        $stmt->execute();
    }
    $conn->commit();
    $transactionStarted = false;
    $saved = count($rows);
} catch (Throwable $e) {
    if ($transactionStarted && $conn !== null) {
        try {
            $conn->rollback();
        } catch (Throwable $ignored) {
            // Preserve the original save error if the database disconnected.
        }
    }
    http_response_code($e instanceof InvalidArgumentException ? 400 : 500);
    $error = $e->getMessage();
} finally {
    if ($stmt !== null) {
        $stmt->close();
    }
}
?>
<meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
<?php include '../include/toolbar.html'; ?>
<br><br>
<?php if ($error !== '') { ?>
<strong>Items were not saved.</strong><br>
<?php echo htmlspecialchars($error, ENT_QUOTES | ENT_SUBSTITUTE, 'UTF-8'); ?><br>
If the form is incomplete, install both fix files and reopen Edit Items.
If it persists, check the server's max_input_vars and post_max_size settings.<br>
<?php } else { ?>
Saved the submitted fields for <?php echo $saved; ?> items.<br>
<?php } ?>
<a href="../php/modify_foods.php">Back to Edit Items</a><br>
<a href="../index.php">Main Page</a><br>
