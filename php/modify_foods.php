<meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
<head>
<style>
table th{
  background-color: green;
  color: white;
  position: sticky;
  z-index: 100;
  top: 0;
  left: 0;
}
</style>
</head>
<?php
include_once '../include/passwords.php';
include '../include/toolbar.html';
include_once '../functions/show_recipes_interface.php';
echo "<form action='/scripts/modify_item.php' method=POST>";
get_interface("modify_pantry","");
echo '<Input type="submit">';
echo "</form>";
?>

