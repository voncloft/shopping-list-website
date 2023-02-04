<?php
//session_start();
require_once '../include/passwords.php';
function saveFinalPriceToDB($price)
{
	global $conn;
	$sql="Update weekly_total set price='".$price."' where id = 1";
	$conn->query($sql);
}
?>
