<?php
include_once '../include/passwords.php';
include_once 'get_prices_and_macros.php';
function show_imported_recipes()
{
	global $conn;
	echo "<br>";
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
              get_prices_and_macros($table[0]); 
              echo "<br>";
          }
      }
    }
}