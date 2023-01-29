<meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
<?php
include_once '../include/passwords.php';
include '../include/toolbar.html';
include_once '../functions/show_recipes_interface.php';
echo "<br>All Recipes";
echo "<br>";
?>
<form action='../scripts/show_shopping_list.php' method=POST>
<?php
    get_interface("select_recipes","dont_hid_import");
?>
<input type="submit">
</form>
