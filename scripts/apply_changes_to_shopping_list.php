<?php
include '../include/passwords.php';
session_start();
    $i= $_SESSION['loop_counter'] ;
    $database=$_SESSION['recipe_edit_name'];
    for($c=1;$c<=$i;$c++)
    {
        $qty_key="recipe_list".$c;  
        $desc_key="select".$c;
        $hidden_key="hidden".$c;

        $sql_statement="update ".$database." set qty = '".$_POST[$qty_key]."',ingredient_name = '".$_POST[$desc_key]."' where id = '".$_POST[$hidden_key]."'";
        echo $sql_statement."<br>";
        $conn->query($sql_statement);
    }
?>
