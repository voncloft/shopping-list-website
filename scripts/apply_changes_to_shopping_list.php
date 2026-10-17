<meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />

<?php
include '../include/passwords.php';
include '../include/toolbar.html';

session_start();
$current_week_recipe = 0;
$i = $_SESSION['loop_counter'];
$database = $_SESSION['recipe_edit_name'];
$url = $_POST['url'];
$selected_recipes = array();

$recipe_check = "select recipes from current_week_recipes";
$current_recipe_week = $conn->query($recipe_check);
$recipe_rows = $current_recipe_week->fetch_all(MYSQLI_ASSOC);

foreach ($recipe_rows as $recipes_selected) {
    $selected_recipes[] = $recipes_selected['recipes'];
    if ($database == $recipes_selected['recipes']) {
        $current_week_recipe = 1;
    }
}

$update_food = "delete from final_list where recipe_table_name='" . $database . "'";
if ($current_week_recipe == 1) {
    $conn->query($update_food);
}

for ($c = 1; $c <= $i; $c++) {
    $qty_key = "recipe_list" . $c;
    $used_key = "used_servings" . $c;
    $desc_key = "select" . $c;
    $hidden_key = "hidden" . $c;

    $used_value = isset($_POST[$used_key]) ? trim($_POST[$used_key]) : '';
    $used_sql = ($used_value === '') ? "NULL" : "'" . (float)$used_value . "'";

    $sql_statement = "update " . $database . " set qty='" . (int)$_POST[$qty_key] . "', used_servings=" . $used_sql . ", ingredient_name='" . $_POST[$desc_key] . "' where id='" . $_POST[$hidden_key] . "'";
    echo $sql_statement . "<br>";
    $conn->query($sql_statement);

    $id_items = "currentvalue" . $c;
    $id_from_items_list = isset($_SESSION[$id_items]) ? $_SESSION[$id_items] : null;

    if ($current_week_recipe == 1) {
        $item_id = $_POST[$desc_key];
        $item_q = $conn->query("select servings from items where id='" . $item_id . "'");
        $item_data = $item_q->fetch_assoc();
        $item_servings = (float)$item_data['servings'];

        $used_for_final = ($used_value === '')
            ? ((int)$_POST[$qty_key] * $item_servings)
            : (float)$used_value;

        $update_food = "insert into final_list(QFRT,used_servings,IFRT,recipe_table_name) VALUES ('" . (int)$_POST[$qty_key] . "','" . $used_for_final . "','" . $item_id . "','" . $database . "')";
        echo $update_food . "<br>";
        $conn->query($update_food);
    }
}

for ($n = 1; $n <= 20; $n++) {
    $txt_to_add = "qtext" . $n;
    $used_to_add = "used_add" . $n;
    $slct_to_add = "select_add" . $n;

    if (isset($_POST[$txt_to_add]) && $_POST[$txt_to_add] > 0) {
        $used_value = isset($_POST[$used_to_add]) ? trim($_POST[$used_to_add]) : '';
        $used_sql = ($used_value === '') ? "NULL" : "'" . (float)$used_value . "'";

        $sql_add = "insert into " . $database . "(qty,used_servings,ingredient_name) VALUES('" . (int)$_POST[$txt_to_add] . "'," . $used_sql . ",'" . $_POST[$slct_to_add] . "')";
        echo $sql_add . "<br>";
        $conn->query($sql_add);

        if (in_array($database, $selected_recipes)) {
            $item_id = $_POST[$slct_to_add];
            $item_q = $conn->query("select servings from items where id='" . $item_id . "'");
            $item_data = $item_q->fetch_assoc();
            $item_servings = (float)$item_data['servings'];

            $used_for_final = ($used_value === '')
                ? ((int)$_POST[$txt_to_add] * $item_servings)
                : (float)$used_value;

            $insert_into_final = "insert into final_list(QFRT,used_servings,IFRT,recipe_table_name) VALUES('" . (int)$_POST[$txt_to_add] . "','" . $used_for_final . "','" . $item_id . "','" . $database . "')";
            echo $insert_into_final . "<br>";
            $conn->query($insert_into_final);
        }
    }
}

$insert_url = "update recipe_lists set url='" . $url . "' where recipe_name='" . $database . "'";
echo $insert_url . "<br>";
$conn->query($insert_url);

echo "<br><a href=../index.php>Main Menu</a>";
?>
