<HEAD>
<script src="https://www.kryogenix.org/code/browser/sorttable/sorttable.js"></script>
<meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
</HEAD>
<body>
<?php
include_once '../include/passwords.php';
include_once '../include/toolbar.html';
require_once '../functions/saveFinalPriceToDB.php';
         $fat=0;
         $protein=0;
         $carbs=0;
         $fiber=0;
	$servings=0;
	$total_sum=0;
	$counter=0;
	$calories=0;
echo "<form action='../scripts/clear_final.php' method=POST>";
echo "<center><h1>Shopping List</h1>";
	 $total_price=0;
	 $url_link="";
	 $tax_added=0;
	//debugging
	 //echo "<table border = 2><tr><th>item</th><th>qty</td><th>Servings</th><th>Calories</th><th>fat</th><th>Protein</th><th>Carbs</th><th>Fiber</th></tr>";
	 //$sql = "select QFRT,count(DISTINCT(IFRT)) from final_list";
	 //$sql="select IFRT, checked, sum(QFRT) as totalsum from final_list group by IFRT";
	 $sql="select final_list.IFRT, final_list.checked, sum(final_list.QFRT) as totalsum, items.department,items.fiber,items.carbs,items.fat,items.protein,items.servings, items.calories, items.grocery_item from final_list inner join items on final_list.IFRT=items.ID group by IFRT order by items.department";
    $result = $conn->query($sql);
    $rows = $result->fetch_all(MYSQLI_ASSOC);
    foreach ($rows as $macros){
	//$fat=$fat+$macros['fat'];
	//$protein=$protein+$macros['protein'];
	//$carbs=$carbs+$macros['carbs'];
	//$fiber=$fiber+$macros['fiber'];
	$servings=$macros['servings'];
        $total_sum=$macros['totalsum'];
        $fat=$fat+($total_sum*$servings*$macros['fat']);
        $protein=$protein+($total_sum*$servings*$macros['protein']);
        $carbs=$carbs+($total_sum*$servings*$macros['carbs']);
	$fiber=$fiber+($total_sum*$servings*$macros['fiber']);
	$calories=$calories+($total_sum*$servings*$macros['calories']);
	//debugging
	/*
        echo "<tr>";
        echo "<td>".$macros['grocery_item']."</td>";
        echo"<td>".$total_sum."</td>";
        echo "<td>".$servings."</td>";
        echo "<td>".$macros['calories']."(".$calories.")</td>";
        echo "<td>".$macros['fat']."(".$fat.")</td>";
        echo "<td>".$macros['protein']."(".$protein.")</td>";
        echo "<td>".$macros['carbs']."(".$carbs.")</td>";
        echo "<td>".$macros['fiber']."(".$fiber.")</td>";
        echo "</tr>";*/
    }
	include '../chart/macros.php';
    echo "<table><tr><td>";
    echo '<table border=2 class="searchable sortable"><tr><th>Ignore?</th><th>Got it</th><th>Qty</th><th align=center>Pantry Qty</th><th align=center>Description</th><th>Price</th><th align=center>Location</th><th align=center>Recipe List(s)</th></tr>';
    foreach ($rows as $row2){
        $id_to_pull_from_items=$row2['IFRT'];
        $qty_needed_from_recipe=$row2['totalsum'];
        $pantrysql="select pantryqty from items where id='".$id_to_pull_from_items."'";
        $result= $conn->query($pantrysql);
        $pantry_results=$result -> fetch_assoc();
        if($row2['totalsum']>$pantry_results['pantryqty'])
        {
				echo "<tr><td align=center><input type='checkbox' id='ignore_cb' class='ignoreIt' value='".$id_to_pull_from_items."'</td>";
				if($row2['checked']=="1")
				{
           		echo "<td align=center><input type='checkbox' id='IFRT_CHECKBOX' class='checkIt' value=".$id_to_pull_from_items." checked ><td align=center>".$qty_needed_from_recipe."</td>";
				}
				else {            
            	echo "<td align=center><input type='checkbox' id='IFRT_CHECKBOX' class='checkIt' value=".$id_to_pull_from_items."><td align=center>".$qty_needed_from_recipe."</td>";
				}            
            echo '<td contenteditable="true" id="txt_pantry" onBlur="saveToDb(this,'.$id_to_pull_from_items.')" align=center>'.$pantry_results["pantryqty"].'</td>';
            $get_food_info="select pantryqty,grocery_item, price,department from items where id ='".$id_to_pull_from_items."' order by department";
            $item_results=$conn->query($get_food_info);
            $rows_from_items=$item_results->fetch_all(MYSQLI_ASSOC);
            foreach ($rows_from_items  as $item_info)
            {
            	$get_recipe_name="select recipe_table_name from final_list where IFRT='".$id_to_pull_from_items."'";
            	$recipes=$conn->query($get_recipe_name);
            	$show_recipe_name=$recipes->fetch_all(MYSQLI_ASSOC);
            	foreach($show_recipe_name as $recipe_td)
            	{
            		$recipe_entry[]=$recipe_td['recipe_table_name'];
           		}
 			   foreach ($recipe_entry as $word)
 			   {
					$finalized_recipe_entry=str_replace("_recipe_table","",$word);
            	$complete_recipe_entry=str_replace("_"," ",$finalized_recipe_entry);						
					$url_link.="<a target='_blank' href=http://voncloft.shopping.com/scripts/show_shopping_list.php?recipe_name=".$word.">".$complete_recipe_entry."</a>, ";	 			   			   
 			   }
            $price_for_items=($qty_needed_from_recipe - $pantry_results['pantryqty'])* $item_info['price'];    
				echo "<td>".$item_info['grocery_item']."</td><td align=center>".$price_for_items."</td><td align=center>".$item_info['department']."</td><td>".substr($url_link,0,-4)."</td></tr>";
  				unset($recipe_entry);
            $total_price+=$price_for_items;
            $url_link="";
            }
        }
    }
    echo "</table>";
    echo "<td valign=top>";
    echo "<table><tr><td>Bill:</td><td>".$total_price."</td></tr>";
    echo "<tr><td>Tax:</td><td>6%</td></tr>";
    $tax_added=$total_price * 1.06;
    saveFinalPriceToDB(number_format($tax_added,2));
    echo "<tr><td>Total:</td><td>".number_format($tax_added,2)."</td></tr></table>";
    echo "</td></tr><tr><td>Clear table <input type='submit'></table></center><form>";
?>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.0/jquery.min.js"></script>
<script>
	$('.checkIt').change(function () {
    var id = $(this).val();
    if (this.checked)
    {
    $.ajax({
        type: "POST",
        url: '../ajax/checkbox.php',
        data:"id="+id+"&checked=true"
    });
 	}
 	else {
    $.ajax({
        type: "POST",
        url: '../ajax/checkbox.php',
        data:"id="+id+"&checked=false"
    });
 	} 	
});
$('.ignoreIt').change(function() {
	var id = $(this).val();
	$.ajax({
		type: "POST",
		url: '../ajax/ignore.php',
		data:"id="+id,
		success: function(data)
		{
			window.location.href="final_shopping_list.php"
		}
	});
});
function saveToDb(editableObj,id)
{
	var id_from_items = $(editableObj).text();
	$.ajax({
		type: "POST",
		url: '../ajax/edit_pantry.php',
		data:"id="+id+"&updated_value="+id_from_items,
		success: function(data)
		{		
			window.location.href="final_shopping_list.php"
		}
	});
}
</script>
<a href="../index.php">Main Page</a>
</body>
