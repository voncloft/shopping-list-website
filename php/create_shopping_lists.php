<?php
include '../include/passwords.php';
?>
<form action='../scripts/export_recipe.php' method=POST>
    <table><caption>New Recipe</caption>
        <tr><td>Recipe Name</td><td><input type="text" name="recipe_name" id="recipe_name"></td></tr>
        <tr><td>URL: </td><td><input type="text" name="url"></td></tr>
    </table>
    <table>
        <tr><td>QTY</td><td>Ingredient</td></tr>
        <?php
            $sql = "select id,grocery_item, price, department from items order by grocery_item";
        $result = $conn->query($sql);
        $rows = $result->fetch_all(MYSQLI_ASSOC);
        for($i=1;$i<=20;$i++)
        {
            echo '<tr><td><input type="number" name="qty'.$i.'" id="qty'.$i.'"></td>
        <td><select id="ingredient'.$i.'" name="ingredient'.$i.'">';
            foreach ($rows as $row2){
                echo '<option value="'.$row2['id'].'">'.$row2['grocery_item'].'</option>';
            }
            echo '</select>';
        }
        ?>
    </td></tr><tr><td><input type="submit"></td></tr></table>
    </form>
