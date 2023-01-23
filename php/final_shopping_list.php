<HEAD>
<script src="https://www.kryogenix.org/code/browser/sorttable/sorttable.js"></script>
<meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />


</HEAD>
<body>

    </script>
<?php
include '../include/passwords.php';
include '../include/toolbar.html';
echo "<form action='../scripts/clear_final.php' method=POST>";
echo "<center><h1>Shopping List</h1>";
$total_price=0;
$url_link="";
//$sql = "select QFRT,count(DISTINCT(IFRT)) from final_list";
$sql="select IFRT, checked, sum(QFRT) as totalsum from final_list group by IFRT";
    $result = $conn->query($sql);
    $rows = $result->fetch_all(MYSQLI_ASSOC);
    
    echo "<table><tr><td>";
	//$recipe_entry="";    
    
    echo '<table border=2 class="searchable sortable"><tr><th>Got it</th><th>Qty</th><th align=center>Pantry Qty</th><th align=center>Description</th><th>Price</th><th align=center>Location</th><th align=center>Recipe List(s)</th></tr>';
    foreach ($rows as $row2){
        $id_to_pull_from_items=$row2['IFRT'];
        $qty_needed_from_recipe=$row2['totalsum'];
        
        $pantrysql="select pantryqty from items where id='".$id_to_pull_from_items."'";
        $result= $conn->query($pantrysql);
        $pantry_results=$result -> fetch_assoc();
        //if(!$row2['totalsum']==0)
        if($row2['totalsum']>$pantry_results['pantryqty'])
        {
				if($row2['checked']=="1")
				{
           		echo "<tr><td align=center><input type='checkbox' id='IFRT_CHECKBOX' class='checkIt' value=".$id_to_pull_from_items." checked ><td align=center>".$qty_needed_from_recipe."</td>";
				}
				else {            
            	echo "<tr><td align=center><input type='checkbox' id='IFRT_CHECKBOX' class='checkIt' value=".$id_to_pull_from_items."><td align=center>".$qty_needed_from_recipe."</td>";
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
 			   //$url_loop=explode("-",$recipe_entry);
 			   
 			   foreach ($recipe_entry as $word)
 			   {


				$finalized_recipe_entry=str_replace("_recipe_table","",$word);
            $complete_recipe_entry=str_replace("_"," ",$finalized_recipe_entry);
				//$final_line=substr($complete_recipe_entry,0,-1);							
					$url_link.="<a target='_blank' href=http://voncloft.shopping.com/scripts/show_shopping_list.php?recipe_name=".$word.">".$complete_recipe_entry."</a>, ";	 			   
					//$url_link=$word."<br><br>"; 			   
 			   }
 			   //$url_link=implode(",",$url);
                $price_for_items=($qty_needed_from_recipe - $pantry_results['pantryqty'])* $item_info['price'];    
		//echo $recipe_entry;
                
                //echo "<td>".$item_info['grocery_item']."</td><td align=center>".$price_for_items."</td><td align=center>".$item_info['department']."</td><td>".rtrim($final_line,',')."</td></tr>";
               echo "<td>".$item_info['grocery_item']."</td><td align=center>".$price_for_items."</td><td align=center>".$item_info['department']."</td><td>".substr($url_link,0,-4)."</td></tr>";
  					//$recipe_entry="";
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
    echo "<tr><td>Total:</td><td>".number_format($tax_added,2)."</td></tr></table>";
    echo "</td></tr><tr><td>Clear table <input type='submit'></table></center><form>";
?>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.0/jquery.min.js"></script>

	<script>
	
 $('.checkIt').change(function () {
    var id = $(this).val();
    
    //alert(id);
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
function saveToDb(editableObj,id)
{
	var id_from_items = $(editableObj).text();
	//alert(id_from_items);
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
