<?php
    include '../include/passwords.php';
include '../include/toolbar.html';

    $recipe_name=$_POST["recipe_name"]."_recipe_table";
    $final_table_name=str_replace(" ","_",$recipe_name);
    echo $final_table_name."<br>";
    echo $recipe_name."<br><br>";
         $table_string="create table ".$final_table_name." (id INT AUTO_INCREMENT PRIMARY KEY, qty INT NOT NULL, ingredient_name text);";
         echo $table_string."<br>";
     echo "<br>";
    if ($conn->query($table_string)){
         echo "Created table";
     }
     else
     {
         echo "Failed to make table";
     }
     echo "<br><br>";
    for($c=1;$c<=20;$c++)
    {
        $qty="qty".$c;
        $key="ingredient".$c;       
        if (!empty($_POST[$qty]))
        {
            $insert_command="insert into ".$final_table_name."(qty,ingredient_name)VALUES('".$_POST[$qty]."','".$_POST[$key]."');";
            echo $insert_command."<br>";
            if ($conn->query($insert_command)){
                echo "Imported Ingredient";
            }
            else
            {
                echo "Failed to import ingredient";
            }           
        }
    }
    $insert_into_url_table="insert into recipe_lists(recipe_name)VALUES('".$final_table_name."')";
    $conn->query($insert_into_url_table);
        $insert_into_url_table="update recipe_lists set url = '".$_POST['url']."' where recipe_name='".$final_table_name."'";
        echo $insert_into_url_table;
    $conn->query($insert_into_url_table);
    echo "<br>"; 
    ?>
<br><a href="../index.php">Main Page</a>
