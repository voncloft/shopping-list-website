<?php
echo "All Recipes";
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
      $i++;          
              $remove_table_name=str_replace("_recipe_table","",$table[0]);
              $replaceunderscores=str_replace("_"," ",$remove_table_name);
              echo '<input type="checkbox" name="recipes[]" value="'.$table[0]. '">';  
              echo '<label">'.$replaceunderscores.'</label><br>';
          
      }
    
 
     ?>
     <input type="submit">
     </form>
