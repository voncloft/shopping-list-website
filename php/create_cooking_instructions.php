<?php
include '../include/passwords.php';
include '../include/toolbar.html';
echo "<form action='../scripts/save_recipe_instructions.php' method=POST>";
 $showtables= mysqli_query($conn, "SHOW TABLES FROM shopping_list");
 $dropdown_menu="<select name='recipe_name' id='recipe_name'><option value='Pick_Recipe'>Pick Recipe</option>";
 //$selected_recipe=$_GET['selected_recipe'];

 
 while($table = mysqli_fetch_array($showtables)) { 
 	if($table[0]!="final_list" && $table[0]!="current_week_recipes" && $table[0]!="items" && $table[0]!="recipe_lists"  && $table[0]!="measurements" )
 	{	
	if(!empty($_GET['selected_recipe']))
	{
 		if($table[0]==$_GET['selected_recipe'])
 		{
			$dropdown_menu=$dropdown_menu.'<option selected="selected" value="'.str_replace("_"," ",str_replace("_recipe_table","",$table[0]).'">'.str_replace("_recipe_table","",$table[0])).'</option>';
 		}
 		else
 		{
			$dropdown_menu=$dropdown_menu.'<option value="'.str_replace("_"," ",str_replace("_recipe_table","",$table[0]).'">'.str_replace("_recipe_table","",$table[0])).'</option>';
 		}
 	}
 	else
 	{
		$dropdown_menu=$dropdown_menu.'<option value="'.str_replace("_"," ",str_replace("_recipe_table","",$table[0]).'">'.str_replace("_recipe_table","",$table[0])).'</option>';
 	}
 	}	
 }
    $drop_down_menu=$dropdown_menu."</select>";
if(!empty($_GET['selected_recipe']) && ($_GET['selected_recipe']!="Pick_Recipe_recipe_table"))
{
	$c=0;
	$sql="select ingredient_name from ".$_GET['selected_recipe'];
	$result = $conn->query($sql);
    	$rows = $result->fetch_all(MYSQLI_ASSOC);

	echo "<table><tr><td>";
	echo "<br>Creating recipe for: ".$drop_down_menu."</td></tr><tr><td>";
	echo "<table><tr><th>Qty</th><th>Measurement</th><th>Ingredient</th></tr><tr>";
	foreach($rows as $from_recipe_list)
	{
		$c++;
		echo "<td><input type='text' name='qty".$c."'></td><td>";


		$measurements_sql="select unit_of_measurement from measurements";
		$measurements_results=$conn->query($measurements_sql);
		$m_rows=$measurements_results->fetch_all(MYSQLI_ASSOC);
		echo "<select name='measurement".$c."'>";
		foreach($m_rows as $mrows){
                        echo '<option value="'.$mrows['unit_of_measurement'].'">'.$mrows['unit_of_measurement'].'</option>';
		}
		echo "</select></td><td>";
            	$items = "select grocery_item from items where id = '".$from_recipe_list['ingredient_name']."'";
        	$result = $conn->query($items);
        	$rows = $result->fetch_all(MYSQLI_ASSOC);
		echo "<select name='ingredient".$c."'>";
            	foreach ($rows as $row2){
            		if($from_recipe_list['ingredient_name']==$row2['id'])
            		{
                		echo '<option selected="selected" value="'.$row2['grocery_item'].'">'.$row2['grocery_item'].'</option>';
			}
			else
			{
				echo '<option value="'.$row2['grocery_item'].'">'.$row2['grocery_item'].'</option>';
			}
              	}
            echo '</select></td><tr>';		
		echo "</tr>";
	}
	echo '<input type="hidden" name="count" id="count" value="'.$c.'">';	
	echo "</table></td></tr><tr><td>";
	echo "INSTRUCTIONS: </td></tr><tr><td><textarea cols='130' rows='30' name='instructions'></textarea></td></tr>";
	echo "<tr><td><input type='submit'></td></tr><tr><td><center><a href='../index.php'>Home</a></center></td></tr><form>";
}
else
{
	echo "Recipe has not been selected<br>";
	echo $drop_down_menu;
}
echo "<center><a href='../index.php'>Home</a></center>";
?>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
<script>
$("#recipe_name").on('change', function() {
        var recipe = $(this).val();
	window.location.href="create_cooking_instructions.php?selected_recipe="+recipe.replace(/ /g,"_")+"_recipe_table";
});

</script>
