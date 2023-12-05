<?php
include_once '../include/passwords.php';
function getServings()
{
	global $conn;
	global $servings_from_db;	
	$sql = "select servings from variables";
	$result = $conn->query($sql);
	$rows = $result->fetch_all(MYSQLI_ASSOC);
	foreach ($rows as $row2){
		$servings_from_db=$row2['servings'];
	}
}
?>