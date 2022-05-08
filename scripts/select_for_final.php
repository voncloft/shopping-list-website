<?php
include '../include/passwords.php';
$recipes_for_week="";
if(!empty($_POST['recipes'])){
    foreach($_POST['recipes'] as $selected){
        echo "<br>".$selected;
        $sql_week_recipes="insert into current_week_recipes(recipes)VALUES('".$selected."')";
        $conn->query($sql_week_recipes);
        $sql = "select qty, ingredient_name,id from ".$selected;
        $result = $conn->query($sql);
        $rows = $result->fetch_all(MYSQLI_ASSOC);
foreach ($rows as $row2){
            $sql2="select grocery_item,price,department from items where id ='".$row2['ingredient_name']."'";
            $results=$conn->query($sql2);
            $row_food=$results->fetch_all(MYSQLI_ASSOC);
            
           foreach ($row_food as $food_called){             
                $sql_statement_to_input_to_final="Insert into final_list(QFRT,IFRT,recipe_table_name)VALUES('".$row2['qty']."','".$row2['ingredient_name']."','".$selected."')";
                
                echo $sql_statement_to_input_to_final."<br>";
            if ($conn->query($sql_statement_to_input_to_final)){
                echo "Imported Ingredient";
            }
            }
        }
    }
}




    $result = $conn->query($sql);
    $rows = $result->fetch_all(MYSQLI_ASSOC);
    
    
?>
