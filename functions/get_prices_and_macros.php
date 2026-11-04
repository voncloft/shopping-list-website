<?php
include 'get_servings.php';
require_once __DIR__ . '/recipe_nutrition.php';
function get_prices_and_macros($recipe_name)
{
	getServings();
	global $servings_from_db;		
	global $conn;
	 $price=0;
	 $fat=0;
	 $protein=0;
	 $carbs=0;
	 $fiber=0;
	 $cals=0;
    $sql = "select ".$recipe_name.".qty, ".$recipe_name.".used_servings, ".$recipe_name.".ingredient_name,items.price,items.servings, items.calories, items.fat, items.protein, items.carbs, items.fiber, items.grocery_item from ".$recipe_name." inner join items on ".$recipe_name.".ingredient_name=items.id";
    $result = $conn->query($sql);
    $rows = $result->fetch_all(MYSQLI_ASSOC);
foreach ($rows as $macros){
        $qty=$macros['qty'];
        $nutrition_servings=recipe_nutrition_servings($macros);
        $fat=$fat+($nutrition_servings*(float)$macros['fat']);
        $protein=$protein+($nutrition_servings*(float)$macros['protein']);
        $carbs=$carbs+($nutrition_servings*(float)$macros['carbs']);
        $fiber=$fiber+($nutrition_servings*(float)$macros['fiber']);
		  $cals=$cals+($nutrition_servings*(float)$macros['calories']);
		  $price=$price+($macros['qty'] * $macros['price']);
}
show_incomplete_nutrition_notice($rows);
$portions="<select name=".$recipe_name."_portions id=".$recipe_name."_portions>";
for ($i=1;$i<=10;$i++)
{
	$portions=$portions."<option value=".$i.">".$i."</option>";
}		
$portions=$portions."</select>";
		if($cals>0)
		{
			echo "<table border=2 width=350><tr><td>";
		}
		else {
			echo "<table width=350><tr><td>";		
		}
			echo "<table border=2 width=100%><tr><td>";    	
    		echo "<center>Price: $".$price."</center>";
    		echo "</td><td>Portions: ".$portions;
			echo"</td></tr></table>";  
		if($cals>0)
		{			
			echo "</td></tr><tr><td>";
			echo "<table border=2 width=100%><th>Calories</th><th>Fat</th><th>Protein</th><th>Carbs</th><th>Fiber</th>";  	
    		echo "<tr><td><center>".round($cals/$servings_from_db,2)."</td><td><center>".round($fat/$servings_from_db,2)."</td><td><center>".round($protein/$servings_from_db,2)."</td><td><center>".round($carbs/$servings_from_db,2)."</td><td><center>".round($fiber/$servings_from_db,2);
    		echo "</td></tr></table>";
    		echo "</td></tr></table>";
    	}
    	else {
			echo "</td></tr></table>";    	
    	}
		$price=0;
		$fat=0;
		$protein=0;
		$carbs=0;
		$cals=0;
		$fiber=0;
}
?>
