<HEAD>
<script src="https://www.kryogenix.org/code/browser/sorttable/sorttable.js"></script>

</HEAD>
<?php
include '../include/passwords.php';
echo "<form action='../scripts/clear_final.php' method=POST>";
echo "<center><h1>Shopping List</h1>";
$total_price=0;
//$sql = "select QFRT,count(DISTINCT(IFRT)) from final_list";
$sql="select IFRT, sum(QFRT) as totalsum from final_list group by IFRT";
    $result = $conn->query($sql);
    $rows = $result->fetch_all(MYSQLI_ASSOC);
    
    echo "<table><tr><td>";
	$recipe_entry="";    
    
    echo '<table border=2 class="searchable sortable"><tr><th>Got it</th><th>Qty</th><th align=center>Description</th><th>Price</th><th align=center>Location</th><th align=center>Recipe List(s)</th></tr>';
    foreach ($rows as $row2){
        $id_to_pull_from_items=$row2['IFRT'];
        $qty_needed_from_recipe=$row2['totalsum'];
        if(!$row2['totalsum']==0)
        {
            echo "<tr><td align=center><input type='checkbox'><td align=center>".$qty_needed_from_recipe."</td>";
            $get_food_info="select grocery_item, price,department from items where id ='".$id_to_pull_from_items."' order by department";
            $item_results=$conn->query($get_food_info);
            $rows_from_items=$item_results->fetch_all(MYSQLI_ASSOC);
        
            foreach ($rows_from_items  as $item_info)
            {
            	$get_recipe_name="select recipe_table_name from final_list where IFRT='".$id_to_pull_from_items."'";
            	$recipes=$conn->query($get_recipe_name);
            	$show_recipe_name=$recipes->fetch_all(MYSQLI_ASSOC);
            	foreach($show_recipe_name as $recipe_td)
            	{
				$recipe_entry.=$recipe_td['recipe_table_name'].", ";
				//$format_recipe_entry=str_replace(" ",",",$recipe_entry);
				$finalized_recipe_entry=str_replace("_recipe_table","",$recipe_entry);
                        	$complete_recipe_entry=str_replace("_"," ",$finalized_recipe_entry);
				$final_line=substr($complete_recipe_entry,0,-1);
            	}
                $price_for_items=$qty_needed_from_recipe * $item_info['price'];    
		//echo $recipe_entry;
                echo "<td>".$item_info['grocery_item']."</td><td align=center>".$price_for_items."</td><td align=center>".$item_info['department']."</td><td>".rtrim($final_line,',')."</td></tr>";
                $total_price+=$price_for_items;
                $recipe_entry="";
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
<a href="../index.php">Main Page</a>
