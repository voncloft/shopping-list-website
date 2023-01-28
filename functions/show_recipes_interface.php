<?php
//include folder is probably best as is....will investigate later
include_once '../include/passwords.php';
include_once '../functions/show_all_recipes.php';
include_once '../functions/show_imported_recipes_for_week.php';
include_once '../functions/modify_pantry.php';
include_once '../functions/pantry_inventory.php';
function get_interface($interface,$recipe_name,$function_of_use)
{
	switch($interface){
		case "select_recipes";//show all recipes
			show_all_recipes_to_select();
			break;
		case "show_imported";//show only recipes in the week imported
			show_imported_recipes();
			break;
		case "modify_pantry";//populate grocery items in db more in depth macros, cost, calories
			modify_pantry();
			break;
		case "pantry_inventory";//populate grocery items only showing qty
			pantry_inventory();
			break;
		case "create_shopping_list";//START OFF HERE
			create_shopping_list();
			break;
		case "create_cooking_instructions";//might not need to do this one
			create_cooking_instructions();
			break;
		case "view_final_list";//call a function to show the grocery list for the week
			view_final_list();
			break;
	}	
}

?>