<meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />

<?php
include '../include/passwords.php';
include '../include/toolbar.html';

$recipes_for_week = "";
$qty_for_final = "";

if (!empty($_POST['recipes'])) {
    foreach ($_POST['recipes'] as $selected) {
        $portion_name = $selected . "_portions";
        $number_of_portions = (float)$_POST[$portion_name];

        $sql_week_recipes = "insert into current_week_recipes(recipes) VALUES('" . $selected . "')";
        $conn->query($sql_week_recipes);

        $sql = "select qty, used_servings, ingredient_name, id from " . $selected;
        $result = $conn->query($sql);
        $rows = $result->fetch_all(MYSQLI_ASSOC);

        foreach ($rows as $row2) {
            $sql2 = "select grocery_item,price,department,pantryqty,servings from items where id ='" . $row2['ingredient_name'] . "'";
            $results = $conn->query($sql2);
            $row_food = $results->fetch_all(MYSQLI_ASSOC);

            foreach ($row_food as $food_called) {
                // How many purchasable packages/items go on the shopping list.
                $qty_for_final = $row2['qty'] * $number_of_portions;

                // How many nutrition-label servings are actually consumed.
                // NULL means preserve the old behavior: qty * servings-per-package.
                if ($row2['used_servings'] === null || $row2['used_servings'] === '') {
                    $base_used_servings = $row2['qty'] * $food_called['servings'];
                } else {
                    $base_used_servings = (float)$row2['used_servings'];
                }

                $used_servings_for_final = $base_used_servings * $number_of_portions;

                echo $qty_for_final . " " . $food_called['grocery_item'] . " added to list";
                echo " -- used servings: " . $used_servings_for_final . "<br>";

                $sql_statement_to_input_to_final =
                    "INSERT INTO final_list(QFRT,used_servings,IFRT,recipe_table_name) VALUES('" .
                    $qty_for_final . "','" . $used_servings_for_final . "','" .
                    $row2['ingredient_name'] . "','" . $selected . "')";

                echo $sql_statement_to_input_to_final . "<br>";

                if ($conn->query($sql_statement_to_input_to_final)) {
                    echo "Import Successful<br>";
                }
            }
        }
    }

    header("Location: ../php/final_shopping_list.php");
    exit;
}

$result = isset($sql) ? $conn->query($sql) : false;
if ($result) {
    $rows = $result->fetch_all(MYSQLI_ASSOC);
}

echo "<br><a href=../index.php>Main Menu</a>";
?>
