<?php
include '../include/passwords.php';
//$test="";
//$id=$_POST['id'];
//if($_POST['IFRT_CHECKBOX']==1) {
	if($_POST['checked']=="true")
	{
		$query="UPDATE final_list SET checked=1 WHERE IFRT=".$_POST['id'];
	}else {
		$query="UPDATE final_list SET checked=0 WHERE IFRT=".$_POST['id'];
	}
mysqli_query($conn,$query);
?>