<meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />

<?php
include '../include/toolbar.html';
echo "<br>All Recipes";
echo "<br>";

    include '../include/passwords.php';
    ?>
    <form action='../scripts/modify_shopping_list.php' method=POST>
    <?php
    $showtables= mysqli_query($conn, "SHOW TABLES FROM shopping_list");    
    $sql="select recipes from current_week_recipes";
    $result = $conn->query($sql);
    $rows = $result->fetch_all(MYSQLI_ASSOC);
     $i=0;      
     while($table = mysqli_fetch_array($showtables)) { 
		if($table[0]!="final_list" && $table[0]!="current_week_recipes" && $table[0]!="items" && $table[0]!="recipe_lists" && $table[0]!="measurements" ){
      $i++;          
              $remove_table_name=str_replace("_recipe_table","",$table[0]);
              $replaceunderscores=str_replace("_"," ",$remove_table_name);
              echo '<input type="checkbox" name="recipes[]" value="'.$table[0]. '">';  
              echo '<label">'.$replaceunderscores.'</label><br>';
          }
      }
    
 
     ?>
     <input type="submit">
     </form>
