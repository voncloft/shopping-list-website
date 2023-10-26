<?php
include '../include/passwords.php';
$query="Delete from final_list WHERE IFRT=".$_POST['id'];
mysqli_query($conn,$query);
?>
