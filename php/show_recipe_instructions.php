<meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />

<?php
include '../include/toolbar.html';
echo "<br>ALL RECIPES";
echo "<br>";
    include '../include/passwords.php';

    ?>
    <form action='../scripts/show_recipe_instructions.php' method=POST>
    <?php
    
    $showtables= mysqli_query($conn, "SHOW TABLES FROM shopping_list");
    while($table = mysqli_fetch_array($showtables)) { 
              if($table[0]!="final_list" && $table[0]!="current_week_recipes" && $table[0]!="items" && $table[0]!="recipe_lists"  && $table[0]!="measurements" )
              {
                  $remove_rt=str_replace("_recipe_table","",$table[0]);
                  $remove_us=str_replace("_"," ",$remove_rt);
                  
                  echo '<input type="checkbox" name="recipes[]" value="'.$table[0]. '">';  
                  echo '<label">'.$remove_us.'</label><br>';
                
              }
            }
     ?>
     <input type="submit">
     </form>