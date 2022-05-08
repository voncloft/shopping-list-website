<?php
session_start();
    $i= $_SESSION['loop_counter'] ;
    for($c=1;$c<=$i;$c++)
    {
        $qty_key="recipe_list".$c;  
        $desc_key="select".$c;
        //todo get the db name from previous form
        //create sql statements in this loop
        
        //need to update the recipe list find the ID of the recipe list and apply $qty_key and $desc_key
        
        echo $_POST[$qty_key]."<br>";
    }
?>
