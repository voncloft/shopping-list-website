<?php
include '../include/toolbar.html';
echo "</center><br>";
foreach($_POST['recipes'] as $selected)
{
	echo "<i>".str_replace("_"," ",str_replace("_recipe_table","",$selected))."</i><br>";
	if (file_exists('../recipes/ingredients/'.$selected."_ingredients.html"))
	{
		include '../recipes/ingredients/'.$selected."_ingredients.html";
		include '../recipes/steps/'.$selected."_steps.html";
	}
	else {
		echo "No instructions exist for recipe";	
	}	
		echo "<br><br>";
	
}
echo "<center><a href=../index.php>Home</a></center>";
?>
