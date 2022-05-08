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
    
    
    echo '<table border=2 class="searchable sortable"><tr><th>Got it</th><th>Qty</th><th align=center>Description</th><th>Price</th><th align=center>Location</th></tr>';
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
                $price_for_items=$qty_needed_from_recipe * $item_info['price'];    
                echo "<td>".$item_info['grocery_item']."</td><td align=center>".$price_for_items."</td><td align=center>".$item_info['department']."</td></tr>";
                $total_price+=$price_for_items;
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
