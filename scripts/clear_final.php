<meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />

<?php
include '../include/passwords.php';
include '../include/toolbar.html';

$sql="truncate table final_list";
$sql2="truncate table current_week_recipes";
echo $sql."<br>";
if($conn->query($sql)){
    echo "Main Shopping List Cleared";
}
if($conn->query($sql2)){
    echo "Main Shopping List Cleared";
}
echo "<br><a href=../index.php>Main Menu</a>";
?>
