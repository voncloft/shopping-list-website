<meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
<?php
include_once '../include/passwords.php';
include '../include/toolbar.html';
include_once '../functions/show_recipes_interface.php';
echo "<form action='/scripts/update_pantry.php' method=POST>";
get_interface("pantry_inventory","","");
echo '<Input type="submit">';
echo "</form>";
?>

