<?php
include_once '../include/passwords.php';
function modify_pantry()
{
    global $conn;
    $result = $conn->query('SELECT ID AS id, grocery_item, price, department, servings,
        calories, fat, protein, carbs, fiber, url FROM items ORDER BY grocery_item');
    $rows = $result->fetch_all(MYSQLI_ASSOC);
    $escape = function ($value) {
        return htmlspecialchars((string) $value, ENT_QUOTES | ENT_SUBSTITUTE, 'UTF-8');
    };
    $fields = [
        ['grocery_item', 'itemtb', null],
        ['price', 'pricetb', 3],
        ['department', 'dtb', null],
        ['servings', 'servings', 3],
        ['calories', 'calories', 3],
        ['fat', 'fat', 3],
        ['protein', 'protein', 3],
        ['carbs', 'carbs', 3],
        ['fiber', 'fiber', 3],
        ['url', 'url', null]
    ];
    echo '<center><table><caption>SHOPPING LIST</caption><tr><th>Item</th><th>Price</th>'
        . '<th>Department</th><th>Servings</th><th>Calories</th><th>Fat</th>'
        . '<th>Protein</th><th>Carbs</th><th>Fiber</th><th>URL</th></tr>';
    $c = 0;
    foreach ($rows as $row) {
        $c++;
        echo '<tr>';
        foreach ($fields as $field) {
            list($column, $prefix, $size) = $field;
            echo '<td>';
            if ($column === 'grocery_item') {
                echo '<input type="hidden" name="idtb' . $c . '" value="' . (int) $row['id'] . '">';
            }
            echo '<input type="text" name="' . $prefix . $c . '" value="' . $escape($row[$column]) . '"';
            if ($size !== null) {
                echo ' size="' . $size . '"';
            }
            echo '></td>';
        }
        echo '</tr>';
    }
    echo '</table></center>';
    // Last field lets the save handler detect PHP input-limit truncation.
    echo '<input type="hidden" name="item_edit_count" value="' . $c . '">';
    $conn->close();
}
?>
