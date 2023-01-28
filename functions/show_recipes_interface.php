<?php
include_once '../include/passwords.php';
include_once '../functions/show_all_recipes.php';
include_once '../functions/show_imported_recipes_for_week.php';
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
		case "show_imported";
			show_imported_recipes();
			break;
	}	
}

?>