<?php
include '../include/passwords.php';
include '../functions/saveFinalPriceToDB.php';
$query="UPDATE items SET pantryqty =".$_POST['updated_value']." WHERE id=".$_POST['id'];
mysqli_query($conn,$query);
saveFinalPriceToDB($_POST['price']);
?>
