<meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
<head>
<style>
table th{
  background-color: green;
  color: white;
  position: sticky;
  z-index: 100;
  top: 0;
  left: 0;
}
</style>
</head>
<?php
include '../include/passwords.php';
include '../include/toolbar.html';
session_start();
//fix the selection menu at the top from being stopped when scrolling down to keep header on top
echo "<form action='/scripts/modify_item.php' method=POST>";
$sql = "select id,grocery_item, price, department,servings,calories,fat,protein,carbs,fiber from items order by grocery_item";
    $result = $conn->query($sql);
    $rows = $result->fetch_all(MYSQLI_ASSOC);

    echo "<center><table><caption>SHOPPING LIST</caption><tr><th>Item</th><th>Price</th><th>Department</th><th>Servings</th><th>Calories</th><th>Fat</th><th>Protein</th><th>Carbs</th><th>Fiber</th></tr><tr>";
    $c=0;
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
    echo '<Input type="submit">';
    echo "</form>";
$conn->close();
$_SESSION['counter']=$c;
//echo $string_to_write;
?>

