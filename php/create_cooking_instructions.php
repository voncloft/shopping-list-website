<?php
include '../include/passwords.php';
echo "<table><tr><td>";
echo "<table><tr><th>Qty</th><th>Measurement</th><th>Ingredient</th></tr><tr>";
	for ($c=1;$c<=20;$c++)
	{
		echo "<td><input type='text' name='qty".$c."'></td><td>";


		$measurements_sql="select unit_of_measurement from measurements";
		$measurements_results=$conn->query($measurements_sql);
		$m_rows=$measurements_results->fetch_all(MYSQLI_ASSOC);
		echo "<select name='qty".$c."'>";
		foreach($m_rows as $mrows){
                        echo '<option value="'.$mrows['unit_of_measurement'].'">'.$mrows['unit_of_measurement'].'</option>';
		}
		echo "</select></td><td>";
            	$sql = "select id,grocery_item, price, department from items order by grocery_item";
        	$result = $conn->query($sql);
        	$rows = $result->fetch_all(MYSQLI_ASSOC);
		echo "<select name='ingredient".$c."'>";
            	foreach ($rows as $row2){
                	echo '<option value="'.$row2['id'].'">'.$row2['grocery_item'].'</option>';
              	}
            echo '</select></td><tr>';		
		echo "</tr>";
	}
	
	echo "</table></td></tr><tr><td>";
	echo "<br>INSTRUCTIONS: <textarea cols='130' rows='30' name='instructions'></textarea></td></tr>";
?>
