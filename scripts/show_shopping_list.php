<meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />

<form action='apply_changes_to_shopping_list.php' method=POST>
<?php
include '../include/passwords.php';
include '../include/toolbar.html';
include '../functions/loadFile.php';
session_start();
$overall_price=0;
$c=0;
$count=0;
$fat=0;
$qty=0;
$servings=0;
$protein=0;
$carbs=0;
$fiber=0;
$counter=0;
$calories=0;
echo "<center><table><caption><h1>All Recipes Selected</h1></caption><tr><td>";
echo "<table border = 2><tr align = 'top'>"; //2nd table within the first table
if(empty($_POST['recipes'])){
//$counter=1;
echo "<td>";
	$recipe_name=$_GET['recipe_name'];
    $sql = "select ".$recipe_name.".qty, ".$recipe_name.".ingredient_name,items.servings, items.calories, items.fat, items.protein, items.carbs, items.fiber, items.grocery_item from ".$recipe_name." inner join items on ".$recipe_name.".ingredient_name=items.id";
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
	$calories=$calories+($qty*$servings*$macros['calories']);
	//Debugging
	/* 
	echo "<tr>";
	echo "<td>".$macros['grocery_item']."</td>";
	echo"<td>".$qty."</td>";
	echo "<td>".$servings."</td>";
	echo "<td>".$macros['calories']."(".$calories.")</td>";
	echo "<td>".$macros['fat']."(".$fat.")</td>";
	echo "<td>".$macros['protein']."(".$protein.")</td>";
	echo "<td>".$macros['carbs']."(".$carbs.")</td>";
	echo "<td>".$macros['fiber']."(".$fiber.")</td>";
	echo "</tr>";*/
    }
	//DEBUGGING
    //echo "</table>";
        include '../chart/macros.php';
	echo "</td><td valign = 'top' align='center'>";
			$remove_rt=str_replace("_recipe_table","",$recipe_name);
		$remove_us=str_replace("_"," ",$remove_rt);
		echo "<center><h1>".$remove_us."</h1></center>";
		$url="select url from recipe_lists where recipe_name='".$recipe_name."'";
		$url_retrieve=$conn->query($url);
		$url_row=$url_retrieve->fetch_all(MYSQLI_ASSOC);

			foreach($url_row as $url_echo){
    				if(! is_null($url_echo['url']) && ! empty($url_echo['url'])){
        				echo "URL: <a href='".$url_echo['url']."' target='_blank'>Recipe</a>";
    				}
			}

		$table_sql = "Select qty, ingredient_name from ".$recipe_name;
		//echo $table_sql;
		$table_retrieve=$conn->query($table_sql);
		$table_row=$table_retrieve->fetch_all(MYSQLI_ASSOC);
		echo "<table border = '2'><caption>Ingredients</caption><tr><th>Qty</th><th>Item</th><th>Price</th><th>Department</th><tr>";
		foreach($table_row as $ingredient_name_id){
  		$item_sql="Select grocery_item,price,department from items where id='".$ingredient_name_id['ingredient_name']."'";
  		//echo $item_sql;
  		$item_retrieve=$conn->query($item_sql);
  		$item_row=$item_retrieve->fetch_all(MYSQLI_ASSOC);
  		foreach($item_row as $item){
      			$reconfigured_cost=$ingredient_name_id['qty'] * $item['price'];
    			echo "<tr><td>".$ingredient_name_id['qty']."</td><td><a target=_blank href='https://www.walmart.com/search?q=".$item['grocery_item']."&facet=fulfillment_method_in_store%3AIn-store'>".$item['grocery_item']."</a></td><td>".$reconfigured_cost."</td><td>".$item['department']."</td></tr>";  
    			$overall_price=$overall_price+$reconfigured_cost;
  			}
  		}
  		echo "<tr><td><td>Total Cost</td><td>";
  		include '../include/recipe_list_price.php';
  		echo"</td></tr></table>";
		loadFile($recipe_name);
}
else {
    foreach($_POST['recipes'] as $selected){
	$counter++;
	echo "<td>";
        $recipe_name=$selected;
	$sql = "select ".$recipe_name.".qty, ".$recipe_name.".ingredient_name,items.servings, items.calories, items.fat, items.protein, items.carbs, items.fiber, items.grocery_item from ".$recipe_name." inner join items on ".$recipe_name.".ingredient_name=items.id";
    	$result = $conn->query($sql);
    	$rows = $result->fetch_all(MYSQLI_ASSOC);
		//debugging    	
    	//echo "<table border = 2><tr><th>item</th><th>qty</td><th>Servings</th><th>Calories</th><th>fat</th><th>Protein</th><th>Carbs</th><th>Fiber</th></tr>";
    	foreach ($rows as $macros){
	        $servings=$macros['servings'];
        	$qty=$macros['qty'];
        	$fat=$fat+($qty*$servings*$macros['fat']);
        	$protein=$protein+($qty*$servings*$macros['protein']);
        	$carbs=$carbs+($qty*$servings*$macros['carbs']);
        	$fiber=$fiber+($qty*$servings*$macros['fiber']);
        	$calories=$calories+($qty*$servings*$macros['calories']);
			//debugging        
        /*echo "<tr>";
        echo "<td>".$macros['grocery_item']."</td>";
        echo"<td>".$qty."</td>";
        echo "<td>".$servings."</td>";
        echo "<td>".$macros['calories']."(".$calories.")</td>";
        echo "<td>".$macros['fat']."(".$fat.")</td>";
        echo "<td>".$macros['protein']."(".$protein.")</td>";
        echo "<td>".$macros['carbs']."(".$carbs.")</td>";
        echo "<td>".$macros['fiber']."(".$fiber.")</td>";
        echo "</tr>";*/
    	}
        include'../chart/macros.php';
        echo "</td>";
	echo "<td valign = 'top' align='center'>"; //table within table start
		$count=$count+1;
		$remove_rt=str_replace("_recipe_table","",$recipe_name);
		$remove_us=str_replace("_"," ",$remove_rt);
		echo "<center><h1>".$remove_us."</h1></center>";
		$url="select url from recipe_lists where recipe_name='".$recipe_name."'";
		$url_retrieve=$conn->query($url);
		$url_row=$url_retrieve->fetch_all(MYSQLI_ASSOC);

			foreach($url_row as $url_echo){
    				if(! is_null($url_echo['url']) && ! empty($url_echo['url'])){
        				echo "URL: <a href='".$url_echo['url']."' target='_blank'>Recipe</a>";
    				}
			}

		$table_sql = "Select qty, ingredient_name from ".$recipe_name;
		//echo $table_sql;
		$table_retrieve=$conn->query($table_sql);
		$table_row=$table_retrieve->fetch_all(MYSQLI_ASSOC);
		echo "<table border = '2'><caption>Ingredients</caption><tr><th>Qty</th><th>Item</th><th>Price</th><th>Department</th><tr>";
		foreach($table_row as $ingredient_name_id){
  		$item_sql="Select grocery_item,price,department from items where id='".$ingredient_name_id['ingredient_name']."'";
  		//echo $item_sql;
  		$item_retrieve=$conn->query($item_sql);
  		$item_row=$item_retrieve->fetch_all(MYSQLI_ASSOC);
  		foreach($item_row as $item){
      			$reconfigured_cost=$ingredient_name_id['qty'] * $item['price'];
    			echo "<tr><td>".$ingredient_name_id['qty']."</td><td><a target=_blank href='https://www.walmart.com/search?q=".$item['grocery_item']."&facet=fulfillment_method_in_store%3AIn-store'>".$item['grocery_item']."</a></td><td>".$reconfigured_cost."</td><td>".$item['department']."</td></tr>";  
    			$overall_price=$overall_price+$reconfigured_cost;
  			}
		}
  		echo "<tr><td><td>Total Cost</td><td>";
  		include '../include/recipe_list_price.php';
  		echo"</td></tr></table>";
 		
		loadFile($recipe_name);
		$overall_price=0;
		$carbs=0;
		$fiber=0;
		$servings=0;
		$qty=0;
		$fat=0;
		$protein=0;
		$calories=0;
		echo "</td></tr>";
		if ($count == 2){
			$count=0;
			echo "</tr><tr>";
		}
	}
	//echo"</td>";
}
echo "</tr></table>";
echo "<tr><td align='center'><a href='../php/show_recipe_no_editing.php'>Show Recipe List</a></td></tr>";

