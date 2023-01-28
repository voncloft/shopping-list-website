<?php
include_once '../include/dbcontroller.php';
	
function get_interface($interface,$recipe_name,$function_of_use)
{
	/*interfaces:
		checkbox: select recipes to edit, final_list, show recipe list (before and imported),
					 show instructions, remove recipe for week
		textbox:  modify items
	*/
	switch($interface){
		case "select_recipes";
			show_all_recipes_to_select();
			break;
	}	
}
function show_all_recipes_to_select()
{
	 $db_handle = new DBController();    
    $showtables= mysqli_query($db_handle, "SHOW TABLES FROM shopping_list");
    $sql="select recipes from current_week_recipes";
    $result = $db_handle->query($sql);
    $rows = $result->fetch_all(MYSQLI_ASSOC);
    $i=0;
    $array = array();
    
    foreach($rows as $recipe)
    { 
      $array[]=$recipe['recipes'];
    }
    while($table = mysqli_fetch_array($showtables)) { 
              if($table[0]!="final_list" && $table[0]!="current_week_recipes" && $table[0]!="items" && $table[0]!="recipe_lists"  && $table[0]!="measurements" )
              {
                  $i++;
                  $remove_rt=str_replace("_recipe_table","",$table[0]);
                  $remove_us=str_replace("_"," ",$remove_rt);
                  if (! in_array($table[0], $array)){
                  echo '<input type="checkbox" name="recipes[]" value="'.$table[0]. '">';  
                  echo '<label">'.$remove_us.'</label><br>';
                }
              }
            }
}
?>