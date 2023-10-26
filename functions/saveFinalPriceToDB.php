<?php
//session_start();
require_once '../include/passwords.php';
function saveFinalPriceToDB($price)
{
	global $conn;
	$sql="Update variables set weekly_total=".$price;
	$conn->query($sql);
}
?>
