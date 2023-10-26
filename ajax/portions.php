<?php
	include '../include/passwords.php';
	$query="update variables set servings =".$_POST['id']." where servings >0";
	mysqli_query($conn,$query);
?>