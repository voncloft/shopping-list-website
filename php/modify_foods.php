<?php
include '../include/passwords.php';

$sql = "select id,grocery_item, price, department from items order by grocery_item";
    $result = $conn->query($sql);
    $rows = $result->fetch_all(MYSQLI_ASSOC);

    echo "<center><table><caption>SHOPPING LIST</caption><tr><td>ID</td><td>Item</td><td>Price</td><td>Department</td></tr><tr>";

    foreach ($rows as $row2){
        echo "<td><input type='text' value=".$row2['id']."></td><td><input type='text' value='".$row2['grocery_item']."'></td><td><input type='text' value=".$row2['price']."></td><td><input type='text' value='".$row2['department']."'></td></tr>";  
    }
    echo "</table>";
$conn->close();
//echo $string_to_write;
?>

