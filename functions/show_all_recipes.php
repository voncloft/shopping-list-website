<?php
include_once '../include/passwords.php';
include_once 'get_prices_and_macros.php';
function show_all_recipes_to_select($function_of_use)
{
	 global $conn;
	 echo "<br>";
    $showtables= mysqli_query($conn, "SHOW TABLES FROM shopping_list");
    $sql="select recipes from current_week_recipes";
    $result = $conn->query($sql);
    $rows = $result->fetch_all(MYSQLI_ASSOC);
    $i=0;
    $array = array();
    foreach($rows as $recipe)
    { 
      $array[]=$recipe['recipes'];
    }

    	while($table = mysqli_fetch_array($showtables)) { 
              if($table[0]!="final_list" && $table[0]!="current_week_recipes" && $table[0]!="items" && $table[0]!="recipe_lists"  && $table[0]!="measurements" && $table[0]!="weekly_total" && $table[0]!="variables" )
              {
                  $i++;

                  $remove_rt=str_replace("_recipe_table","",$table[0]);
                  $remove_us=str_replace("_"," ",$remove_rt);
                  switch($function_of_use)
                  {
                  	case "hide_imported";
                  		if (! in_array($table[0], $array)){
                  		echo '<input type="checkbox" name="recipes[]" value="'.$table[0]. '">';  
                  		echo '<label">'.$remove_us.'</label><br>';
                		}
                		break;
                		default:
                  		echo '<input type="checkbox" name="recipes[]" value="'.$table[0]. '">';  
                  		echo '<label">'.$remove_us.'</label><br>';                				
             	}
             	                  get_prices_and_macros($table[0]);
             	                  echo "<br>";
              }
            }
         }



?>