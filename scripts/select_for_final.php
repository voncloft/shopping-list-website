<?php
require_once __DIR__ . '/../include/passwords.php';
require_once __DIR__ . '/../functions/recipe_summary.php';
$error = ''; $transaction = false;
try {
    if (($_SERVER['REQUEST_METHOD'] ?? '') !== 'POST') throw new InvalidArgumentException('Select recipes on the weekly recipe page.');
    $selected = $_POST['recipes'] ?? [];
    if (!is_array($selected) || !$selected) throw new InvalidArgumentException('Select at least one recipe.');
    $available = [];
    foreach ($conn->query('SHOW TABLES')->fetch_all(MYSQLI_NUM) as $table) if (substr($table[0],-13) === '_recipe_table') $available[$table[0]]=true;
    $batches = [];
    foreach ($selected as $name) {
        if (!is_string($name) || !isset($available[$name])) throw new InvalidArgumentException('An unavailable recipe was selected. Reload the recipe list.');
        $amount=$_POST[$name.'_portions'] ?? '';
        if (!is_scalar($amount) || !ctype_digit((string)$amount) || (int)$amount<1 || (int)$amount>10) throw new InvalidArgumentException('Recipe amounts must be from 1 to 10.');
        $batches[$name]=(int)$amount;
    }
    $conn->begin_transaction(); $transaction=true;
    $conn->query('SELECT weekly_total FROM variables FOR UPDATE');
    $already=[];
    foreach ($conn->query('SELECT recipes FROM current_week_recipes')->fetch_all(MYSQLI_ASSOC) as $row) $already[$row['recipes']]=true;
    $week=$conn->prepare('INSERT INTO current_week_recipes (recipes) VALUES (?)');
    $item=$conn->prepare('INSERT INTO final_list (QFRT,used_servings,IFRT,recipe_table_name) VALUES (?,?,?,?)');
    foreach ($batches as $name=>$amount) {
        if (isset($already[$name])) continue;
        $summary=recipe_summary($name);
        if ($summary['error']) throw new InvalidArgumentException(str_replace('_',' ',substr($name,0,-13)).': '.$summary['error']);
        $week->bind_param('s',$name); $week->execute();
        foreach ($summary['rows'] as $row) {
            $qty=(float)$row['qty']*$amount;
            // Keep auto as NULL so changes to an item's servings reach the imported list.
            $used=($row['used_servings'] === null || $row['used_servings'] === '') ? null : (float)$row['used_servings']*$amount;
            $id=(int)$row['ingredient_name'];
            $item->bind_param('ddis',$qty,$used,$id,$name); $item->execute();
        }
    }
    $week->close(); $item->close(); $conn->commit(); $transaction=false;
    header('Location: ../php/final_shopping_list.php',true,303); exit;
} catch (InvalidArgumentException $e) { if ($transaction) $conn->rollback(); $error=$e->getMessage(); http_response_code(400); }
catch (Throwable $e) { if ($transaction) $conn->rollback(); error_log('Recipe import failed.'); $error='The recipes could not be imported. No partial import was saved.'; http_response_code(500); }
if (site_json_request()) site_error($error, http_response_code());
?><!doctype html><html lang="en"><head><meta charset="utf-8"><?php require_once __DIR__ . '/../include/theme-head.php'; ?><title>Recipe import</title></head><body>
<?php include __DIR__.'/../include/toolbar.html'; ?></center><p role="alert"><?= recipe_html($error) ?></p><p><a href="../php/select_shopping_lists_for_week.php">Back to recipe selection</a></p></body></html>
