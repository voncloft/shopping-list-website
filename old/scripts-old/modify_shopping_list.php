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
//echo $recipe_name;
    //get default values
    $update_script="";
    $default_list_string="<select>";
    $default_items_sql="select id, grocery_item from items";
    $items=$conn->query($default_items_sql);
    $rows_of_default=$items->fetch_all(MYSQLI_ASSOC);
    foreach($rows_of_default as $original_list)
    {
        $default_list_string.="<option value='".$original_list['id']."'>".$original_list['grocery_item']."</option>";
    }
    $default_list_string.="</select>";
    $sql = "select qty,id,ingredient_name from ".$recipe_name;
    //echo $sql;
    $result = $conn->query($sql);
    $rows = $result->fetch_all(MYSQLI_ASSOC);
    echo "<table border = 2><tr><th>Qty</th><th>Description</th></tr>";
    $x=0;
    foreach ($rows as $from_recipe_list)
    {
            $c++;
            echo "<input type='hidden' name=hidden".$c." value='".$from_recipe_list['id']."'>";
            echo "<td><input type='text' value='".$from_recipe_list['qty']."' name='recipe_list".$c."'></td>";
            $items_list="select id, grocery_item, price, department from items where id='".$from_recipe_list['ingredient_name']."'";
            
            //echo $items_list;
            $items=$conn->query($items_list);
            $row_editing = $items->fetch_all(MYSQLI_ASSOC);
            foreach($row_editing as $current_item)
            {
                $x++;
                $current_value="currentvalue".$x;
                //echo $current_value;
                $_SESSION[$current_value]=$current_item['id'];
                $replaced_string="'".' option selected="selected" >'.$current_item['grocery_item'];
                $look_for_string="'>".$current_item['grocery_item']."</option>";
                $select_current_item=str_replace($look_for_string,$replaced_string,$default_list_string);
               
                $string_in_select="<select>";
                $replace_in_select="<select name='select".$c."'>";
                $final_select_option=str_replace($string_in_select,$replace_in_select,$select_current_item);
                echo "<td>".$final_select_option."</td></tr>";
            }
    }
    $_SESSION['loop_counter'] = $c;
    $_SESSION['recipe_edit_name']=$recipe_name;
    
    for($c=1;$c<=20;$c++)
    {
                $string_in_select="<select>";
                $replace_in_select="<select name='select_add".$c."'>";
                $final_select_option=str_replace($string_in_select,$replace_in_select,$default_list_string);
        echo "<tr><td><input type='text' name='qtext".$c."'></td><td>".$final_select_option."</td>";  
    }
$conn->close();
?>
<tr><td></td><td><INPUT TYPE="SUBMIT"></td></tr>
</FORM>
