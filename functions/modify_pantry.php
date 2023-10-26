<?php
include_once '../include/passwords.php';
function modify_pantry()
{
global $conn;
session_start();
$sql = "select id,grocery_item, price, department,servings,calories,fat,protein,carbs,fiber from items order by grocery_item";
$result = $conn->query($sql);
$rows = $result->fetch_all(MYSQLI_ASSOC);
$c=0;
echo "<center><table><caption>SHOPPING LIST</caption><tr><th>Item</th><th>Price</th><th>Department</th><th>Servings</th><th>Calories</th><th>Fat</th><th>Protein</th><th>Carbs</th><th>Fiber</th></tr><tr>";
	foreach ($rows as $row2){
        	$c++;
        	echo "<td><input type='hidden' name='idtb".$c."' value=".$row2['id'].">";
        	echo "<input type='text' name='itemtb".$c."' value='".$row2['grocery_item']."'></td>";
        	echo "<td><input type='text' size='3' name='pricetb".$c."' value='".$row2['price']."'></td>";
        	echo "<td><input type='text' name='dtb".$c."' value='".$row2['department']."'></td>";  
			echo "<td><input type='text' size='3' name='servings".$c."' value=".$row2['servings']."></td>";
			echo "<td><input type='text' size='3' name='calories".$c."' value=".$row2['calories']."></td>";
			echo "<td><input type='text' size='3' name='fat".$c."' value=".$row2['fat']."></td>";
			echo "<td><input type='text' size='3' name='protein".$c."' value=".$row2['protein']."></td>";
			echo "<td><input type='text' size='3' name='carbs".$c."' value=".$row2['carbs']."></td>";
			echo "<td><input type='text' size='3' name='fiber".$c."' value=".$row2['fiber']."></td>";
			echo "</tr>";
    }
echo "</table>";
$conn->close();
$_SESSION['counter']=$c;
}
?>