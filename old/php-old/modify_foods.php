<?php
include '../include/passwords.php';
session_start();
echo "<form action='/scripts/modify_item.php' method=POST>";
$sql = "select id,grocery_item, price, department from items order by grocery_item";
    $result = $conn->query($sql);
    $rows = $result->fetch_all(MYSQLI_ASSOC);

    echo "<center><table><caption>SHOPPING LIST</caption><tr><th></th><th>Item</th><th>Price</th><th>Department</th></tr><tr>";
    $c=0;
    foreach ($rows as $row2){
        $c++;
        echo "<td><input type='hidden' name='idtb".$c."' value=".$row2['id']."></td><td><input type='text' name='itemtb".$c."' value='".$row2['grocery_item']."'></td><td><input type='text' name='pricetb".$c."' value=".$row2['price']."></td><td><input type='text' name='dtb".$c."' value='".$row2['department']."'></td></tr>";  
    }
    
    echo "</table>";
    echo '<Input type="submit">';
    echo "</form>";
$conn->close();
$_SESSION['counter']=$c;
//echo $string_to_write;
?>

