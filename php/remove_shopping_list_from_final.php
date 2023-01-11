<meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />

<?php

    include '../include/passwords.php';
    include '../include/toolbar.html';

echo "<br>Recipes Imported Currently";
echo "<br>";

    ?>
    <form action='../scripts/remove_shopping_list.php' method=POST>
    <?php
    $showtables= mysqli_query($conn, "SHOW TABLES FROM shopping_list");    
    $sql="select recipes from current_week_recipes";
    $result = $conn->query($sql);
    $rows = $result->fetch_all(MYSQLI_ASSOC);
     $i=0;      
     while($table = mysqli_fetch_array($showtables)) { 
      $i++;
          foreach($rows as $recipe)
          {
            if($table[0]==$recipe['recipes'])
            {            
              $remove_table_name=str_replace("_recipe_table","",$table[0]);
              $replaceunderscores=str_replace("_"," ",$remove_table_name);
              echo '<input type="checkbox" name="recipes[]" value="'.$table[0]. '">';  
              echo '<label">'.$replaceunderscores.'</label><br>';
          }
      }
    }
 
     ?>
     <input type="submit">
     </form>
