<?php
foreach($_POST['recipes'] as $selected)
{
	echo "<i>".str_replace("_"," ",str_replace("_recipe_table","",$selected))."</i><br>";
	include '../recipes/ingredients/'.$selected."_ingredients.html";
	include '../recipes/steps/'.$selected."_steps.html";
	echo "<br><br>";
}
echo "<center><a href=../index.php>Home</a></center>";
?>