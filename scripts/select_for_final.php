<?php
include '../include/passwords.php';
if(!empty($_POST['recipes'])){
// Loop to store and display values of individual checked checkbox.
    foreach($_POST['recipes'] as $selected){
        echo "<br>".$selected;
        $sql = "select qty, ingredient_name from ".$selected;
        $result = $conn->query($sql);
        $rows = $result->fetch_all(MYSQLI_ASSOC);

        foreach ($rows as $row2){
            //echo "<br>";
            $sql2="select grocery_item,price,department from items where id ='".$row2['ingredient_name']."'";
            //echo "<br>".$sql2;
            $results=$conn->query($sql2);
            $row_food=$results->fetch_all(MYSQLI_ASSOC);
            
           foreach ($row_food as $food_called){
               // echo "<tr><td><input type='text' value='".$row2['qty']."'></td>
                //<tr><td><input type='text' value='".$food_called['grocery_item']."'".$food_called['grocery_item']."'></td></tr><br>";     
                
                $sql_statement_to_input_to_final="Insert into final_list(QFRT,IFRT)VALUES('".$row2['qty']."','".$row2['ingredient_name']."')";
                
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
