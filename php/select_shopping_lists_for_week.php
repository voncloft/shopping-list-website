<meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />

<?php
include_once '../include/passwords.php';
include '../include/toolbar.html';
include '../functions/show_recipes_interface.php';
echo "<br>Recipes not currently imported";
echo "<br>";
?>
<form action='../scripts/select_for_final.php' method=POST>
<?php
	get_interface("select_recipes","","");
?>
 <input type="submit">
</form>


