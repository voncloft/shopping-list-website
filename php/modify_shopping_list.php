<meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
<?php
include_once '../include/passwords.php';
include_once '../functions/show_recipes_interface.php';
include '../include/toolbar.html';
echo "<br>Recipes Imported Currently";
echo "<br>";
?>
<form action='../scripts/modify_shopping_list.php' method=POST>
<?php
	get_interface("show_imported","");
?>
<input type="submit">
</form>
