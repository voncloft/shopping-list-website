<?php
include 'get_servings.php';
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
	 /*$sql="select qty,ingredient_name from ".$recipe_name;
    $result = $conn->query($sql);
    $rows = $result->fetch_all(MYSQLI_ASSOC);
    foreach ($rows as $recipe){
		$items="select price, servings,protein,fat,carbs,calories,fiber from items where ID = ".$recipe['ingredient_name'];
		$items_info=$conn->query($items);
		$item_rows=$items_info->fetch_all(MYSQLI_ASSOC);
		foreach($item_rows as $item_information)
		{
			$servings=$item_information['servings'];	
	
				$price=$price+($recipe['qty'] * $item_information['price']);
				$fat=$fat+($recipe['qty'] * $servings * $item_information['fat']);	
				$protein=$protein+($recipe['qty'] * $servings * $item_information['protein']);
				$carbs=$carbs+($recipe['qty'] * $servings * $item_information['carbs']);	
				$fiber=$fiber+($recipe['qty'] * $servings * $item_information['fiber']);
				$cals=$cals+($recipe['qty'] * $servings * $item_information['calories']);	
				
		}
			$fat_per_serving=$fat/$servings_from_db;
			
		}*/
    $sql = "select ".$recipe_name.".qty, ".$recipe_name.".ingredient_name,items.price,items.servings, items.calories, items.fat, items.protein, items.carbs, items.fiber, items.grocery_item from ".$recipe_name." inner join items on ".$recipe_name.".ingredient_name=items.id";
    $result = $conn->query($sql);
    $rows = $result->fetch_all(MYSQLI_ASSOC);
	//Debugging
    //echo "<table border = 2><tr><th>item</th><th>qty</td><th>Servings</th><th>Calories</th><th>fat</th><th>Protein</th><th>Carbs</th><th>Fiber</th></tr>";
    foreach ($rows as $macros){
        //$fat=$fat+$macros['fat'];
        //$protein=$protein+$macros['protein'];
        //$carbs=$carbs+$macros['carbs'];
        //$fiber=$fiber+$macros['fiber'];
        $servings=$macros['servings'];
        $qty=$macros['qty'];
        $fat=$fat+($qty*$servings*$macros['fat']);
        $protein=$protein+($qty*$servings*$macros['protein']);
        $carbs=$carbs+($qty*$servings*$macros['carbs']);
        $fiber=$fiber+($qty*$servings*$macros['fiber']);
			$cals=$cals+($qty*$servings*$macros['calories']);
			$price=$price+($macros['qty'] * $macros['price']);
}    	
		if($cals>0)
		{
			echo "<table border=2 width=350><tr><td>";
		}
		else {
			echo "<table width=350><tr><td>";		
		}
			echo "<table border=2 width=100%><tr><td>";    	
    			echo "<center>Price: $".$price."</center>";
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