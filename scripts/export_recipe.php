<?php
    include '../include/passwords.php';
    $recipe_name=$_POST["recipe_name"]."_recipe_table";
    echo $recipe_name."<br><br>";
         $table_string="create table ".$recipe_name." (id INT AUTO_INCREMENT PRIMARY KEY, qty INT NOT NULL, ingredient_name text);";
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
            $insert_command="insert into ".$recipe_name."(qty,ingredient_name)VALUES('".$_POST[$qty]."','".$_POST[$key]."');";
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
    echo "<br>"; 
    ?>
