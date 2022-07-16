<?php
include '../include/passwords.php';
include '../include/toolbar.html';

session_start();
    $i= $_SESSION['loop_counter'] ;
    $database=$_SESSION['recipe_edit_name'];
//check if this recipe is even set up for selection of week to not interfere with main list later
   $url=$_POST['url'];
   $selected_recipes=array();
   $recipe_check="select recipes from current_week_recipes";
   $current_recipe_week=$conn->query($recipe_check);
   $recipe_rows=$current_recipe_week->fetch_all(MYSQLI_ASSOC);

   foreach($recipe_rows as $recipes_selected)
   {
        $selected_recipes[]=$recipes_selected['recipes'];
   }


   for($c=1;$c<=$i;$c++)
    {
       $qty_key="recipe_list".$c;  
        $desc_key="select".$c;
        $hidden_key="hidden".$c;
        $sql_statement="update ".$database." set qty = '".$_POST[$qty_key]."',ingredient_name = '".$_POST[$desc_key]."' where id = '".$_POST[$hidden_key]."'";
        echo $sql_statement."<br>";
        $conn->query($sql_statement);

        //DONT THINK I need these lines anymore keep just in case tho they both seperately update qty and description of the final list - however it needs to be ran twice
        //$update_final="update final_list set qfrt = '".$_POST[$qty_key]."' where IFRT = '".$_POST[$desc_key]."' and recipe_table_name ='".$database."'";
        
        //echo $update_final."<br>";
        //$conn->query($update_final);
        $id_items="currentvalue".$c;
        $id_from_items_list=$_SESSION[$id_items];
        
        //$update_food="update final_list set IFRT = '".$_POST[$desc_key]."' where IFRT='".$id_from_items_list."' and recipe_table_name='".$database."'";
	$update_food="update final_list set IFRT = '".$_POST[$desc_key]."', QFRT = '".$_POST[$qty_key] ."' where IFRT = '".$id_from_items_list."' and recipe_table_name='".$database."'";
        echo $update_food;
        $conn->query($update_food);
    }
    
    for($i=1;$i<=20;$i++)
    {
        $txt_to_add="qtext".$i;
        $slct_to_add="select_add".$i;
        //echo $_POST[$txt_to_add];
	
        if($_POST[$txt_to_add] >0)
        {
            $sql_add="insert into ".$database."(qty,ingredient_name)Values('".$_POST[$txt_to_add]."','".$_POST[$slct_to_add]."')";
            echo $sql_add."<br>";
            $conn->query($sql_add);
             if (in_array($database, $selected_recipes))
             {
            	$insert_into_final="insert into final_list(qfrt,ifrt,recipe_table_name)VALUES('".$_POST[$txt_to_add]."','".$_POST[$slct_to_add]."','".$database."')";
            
            	echo $insert_into_final."<br>";
            	$conn->query($insert_into_final);
	     }
        }
    }
    echo "<br>";
	$insert_url="update recipe_lists set url='".$url."' where recipe_name='".$database."'";
	echo $insert_url."<br>";
	$conn->query($insert_url);
    echo "<br><a href=../index.php>Main Menu</a>";

?>
