<meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />

<?php
include '../include/passwords.php';
include '../include/toolbar.html';

$recipes_for_week="";
$qty_for_final="";
if(!empty($_POST['recipes'])){
    foreach($_POST['recipes'] as $selected){
        //echo "<br>".$selected;
        $sql_week_recipes="insert into current_week_recipes(recipes)VALUES('".$selected."')";
        $conn->query($sql_week_recipes);
        $sql = "select qty, ingredient_name,id from ".$selected;
        $result = $conn->query($sql);
        $rows = $result->fetch_all(MYSQLI_ASSOC);
foreach ($rows as $row2){
            $sql2="select grocery_item,price,department,pantryqty from items where id ='".$row2['ingredient_name']."'";
            $results=$conn->query($sql2);
            $row_food=$results->fetch_all(MYSQLI_ASSOC);
            
           foreach ($row_food as $food_called){
              if($food_called['pantryqty']<$row2['qty'])
              {
                 $qty_for_final=$row2['qty'];
              }
              else
              {
                 $qty_for_final=0;              
              }
              echo $qty_for_final." ".$food_called['grocery_item']." added to list<br>";
                $sql_statement_to_input_to_final="Insert into final_list(QFRT,IFRT,recipe_table_name)VALUES('".$qty_for_final."','".$row2['ingredient_name']."','".$selected."')";                    
                    echo $sql_statement_to_input_to_final."<br>";
                    if ($conn->query($sql_statement_to_input_to_final)){
                        echo "Import Successful<br>";
                    }              
            }
        }
    }
}




    $result = $conn->query($sql);
    $rows = $result->fetch_all(MYSQLI_ASSOC);
    echo "<br><a href=../index.php>Main Menu</a>";
    
?>
