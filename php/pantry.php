<meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />

<?php
include '../include/passwords.php';
include '../include/toolbar.html';

session_start();
$last_val=null;
echo "<form action='/scripts/update_pantry.php' method=POST>";
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
    echo '<Input type="submit">';
    echo "</form>";
$conn->close();
$_SESSION['counter']=$c;
//echo $string_to_write;
?>

