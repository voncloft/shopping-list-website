<?php
include '../include/passwords.php';
include '../include/toolbar.html';
echo "<form action='../scripts/save_recipe_instructions.php' method=POST>";
 $showtables= mysqli_query($conn, "SHOW TABLES FROM shopping_list");
 $dropdown_menu="<select name='recipe_name'>";
 while($table = mysqli_fetch_array($showtables)) { 
 	if($table[0]!="final_list" && $table[0]!="current_week_recipes" && $table[0]!="items" && $table[0]!="recipe_lists"  && $table[0]!="measurements" )
 	{	
		$dropdown_menu=$dropdown_menu.'<option value="'.str_replace("_"," ",str_replace("_recipe_table","",$table[0]).'">'.str_replace("_recipe_table","",$table[0])).'</option>';
 	}				
 }
    $drop_down_menu=$dropdown_menu."</select>";
echo "<table><tr><td>";
echo "<br>Creating recipe for: ".$drop_down_menu."</td></tr><tr><td>";
echo "<table><tr><th>Qty</th><th>Measurement</th><th>Ingredient</th></tr><tr>";
	for ($c=1;$c<=20;$c++)
	{
		echo "<td><input type='text' name='qty".$c."'></td><td>";


		$measurements_sql="select unit_of_measurement from measurements";
		$measurements_results=$conn->query($measurements_sql);
		$m_rows=$measurements_results->fetch_all(MYSQLI_ASSOC);
		echo "<select name='measurement".$c."'>";
		foreach($m_rows as $mrows){
                        echo '<option value="'.$mrows['unit_of_measurement'].'">'.$mrows['unit_of_measurement'].'</option>';
		}
		echo "</select></td><td>";
            	$sql = "select id,grocery_item, price, department from items order by grocery_item";
        	$result = $conn->query($sql);
        	$rows = $result->fetch_all(MYSQLI_ASSOC);
		echo "<select name='ingredient".$c."'>";
            	foreach ($rows as $row2){
                	echo '<option value="'.$row2['grocery_item'].'">'.$row2['grocery_item'].'</option>';
              	}
            echo '</select></td><tr>';		
		echo "</tr>";
	}
	
	echo "</table></td></tr><tr><td>";
	echo "INSTRUCTIONS: </td></tr><tr><td><textarea cols='130' rows='30' name='instructions'></textarea></td></tr>";
	echo "<tr><td><input type='submit'></td></tr><tr><td><center><a href='../index.php'>Home</a></center></td></tr><form>";
?>
