<?php
include_once '../include/dbcontroller.php';
function saveFinalPriceToDB($price)
{
	//return $sql;	
	$db_handle = new DBController();	
	//$price="2.22";	
	$sql="Update weekly_total set price='".$price."' where id = 1";
	$db_handle->executeUpdate($sql);
	//return $sql;
}
//echo $price;
?>
