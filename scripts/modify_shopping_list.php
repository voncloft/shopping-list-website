<form action='apply_changes_to_shopping_list.php' method=POST>
<?php
include '../include/passwords.php';
session_start();
$c=0;
if(!empty($_POST['recipes'])){
    foreach($_POST['recipes'] as $selected){
        $recipe_name=$selected;
    }
}
    //get default values
    $update_script="";
    $default_list_string="<select>";
    $default_items_sql="select grocery_item from items";
    $items=$conn->query($default_items_sql);
    $rows_of_default=$items->fetch_all(MYSQLI_ASSOC);
    foreach($rows_of_default as $original_list)
    {
        $default_list_string.="<option>".$original_list['grocery_item']."</option>";
    }
    $default_list_string.="</select>";
    $sql = "select qty,id,ingredient_name from ".$recipe_name;
    echo $sql;
    $result = $conn->query($sql);
    $rows = $result->fetch_all(MYSQLI_ASSOC);
    echo "<table border = 2><tr><th>Qty</th><th>Description</th></tr>";
    foreach ($rows as $from_recipe_list)
    {
            $c++;
            echo "<td><input type='text' value='".$from_recipe_list['qty']."' name='recipe_list".$c."'></td>";
            $items_list="select grocery_item, price, department from items where id=".$from_recipe_list['ingredient_name'];
            $items=$conn->query($items_list);
            $row_editing = $items->fetch_all(MYSQLI_ASSOC);
            foreach($row_editing as $current_item)
            {
                $replaced_string=' <option selected="selected" name=select'.$c.'>'.$current_item['grocery_item'].'</option>';
                $look_for_string="<option>".$current_item['grocery_item']."</option>";
                $select_current_item=str_replace($look_for_string,$replaced_string,$default_list_string);
                echo "<td>".$select_current_item."</td></tr>";
            }
    }
    $_SESSION['loop_counter'] = $c;
$conn->close();
?>
<tr><td></td><td><INPUT TYPE="SUBMIT"></td></tr>
</FORM>

