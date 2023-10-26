<meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
<?php
include '../include/toolbar.html';
include '../functions/show_recipes_interface.php';
echo "<br>ALL RECIPES";
echo "<br>";
?>
<form action='../scripts/show_recipe_instructions.php' method=POST>
<?php
	get_interface("select_recipes","dont_hide_import");
?>
<input type="submit">
</form>