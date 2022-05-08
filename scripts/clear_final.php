<?php
include '../include/passwords.php';
sql="truncate table final_list";
echo $sql."<br>";
if($conn->query($sql){
    echo "Main Shopping List Cleared";
}
?>
