<form action='apply_changes_to_shopping_list.php' method=POST>
<?php

include '../include/passwords.php';
include '../include/toolbar.html';

session_start();
$overall_price=0;
$c=0;
$count=0;
echo "<center><table><caption><h1>All Recipes Selected</h1></caption><tr><td>";
echo "<table border = 2><tr align = 'top'>"; //2nd table within the first table
if(!empty($_POST['recipes'])){
    foreach($_POST['recipes'] as $selected){
        $recipe_name=$selected;
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
    			echo "<tr><td>".$ingredient_name_id['qty']."</td><td>".$item['grocery_item']."</td><td>".$reconfigured_cost."</td><td>".$item['department']."</td></tr>";  
    			$overall_price=$overall_price+$reconfigured_cost;
  			}
		}
  		echo "<tr><td><td>Total Cost</td><td>";
  		include '../include/recipe_list_price.php';
  		echo"</td></tr></table>";
		$overall_price=0;
		echo "</td>";
		if ($count == 3){
			$count=0;
			echo "</tr><tr>";
		}
	}
	//echo"</td>";
}
echo "</tr></table>";
echo "<tr><td align='center'><a href='../php/show_recipe_no_editing.php'>Show Recipe List</a></td></tr>";

