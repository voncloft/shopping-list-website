<?php
include '../include/passwords.php';
$query="UPDATE items SET pantryqty =".$_POST['updated_value']." WHERE id=".$_POST['id'];
mysqli_query($conn,$query);
?>
