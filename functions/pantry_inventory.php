<?php
include_once '../include/passwords.php';
function pantry_inventory()
{
	global $conn;
session_start();
$last_val=null;
$sql = "select id,grocery_item, department,pantryqty from items order by department, grocery_item";
$result = $conn->query($sql);
$rows = $result->fetch_all(MYSQLI_ASSOC);
echo "<center><table><caption>SHOPPING LIST</caption><tr><th></th><th>Item</th><th>Qty at home</th></tr><tr>";
$c=0;
foreach ($rows as $row2){
	$c++;
   if($row2['department'] != $last_val)
   {
		echo "<td></td><td><br>".$row2['department']."</td></tr>";
	}
	echo "<td><input type='hidden' name='idtb".$c."' value=".$row2['id']."></td><td><input type='text' name='itemtb".$c."' value='".$row2['grocery_item']."'></td><td><input type='number' name='pantry".$c."' value=".$row2['pantryqty']."></td></tr>";  
	$last_val=$row2['department'];
    }
echo "</table>";
$conn->close();
$_SESSION['counter']=$c;
}
?>