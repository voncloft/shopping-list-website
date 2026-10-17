<HEAD>
<script src="../include/jquery/sorttable.js"></script>
<meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
</HEAD>
<body>
<?php
include_once '../include/passwords.php';
include_once '../include/toolbar.html';
require_once '../functions/saveFinalPriceToDB.php';
require_once '../functions/get_servings.php';
getServings();

$fat=0;
$protein=0;
$carbs=0;
$fiber=0;
$total_sum=0;
$counter=0;
$calories=0;

$portions="<select name=portions id=portions>";
for($portion_counter=1;$portion_counter<=10;$portion_counter++) {
    if($portion_counter==$servings_from_db) {
        $portions.="<option value='".$portion_counter."' selected>".$portion_counter."</option>";
    } else {
        $portions.="<option value='".$portion_counter."'>".$portion_counter."</option>";
    }
}
$portions.="</select>";

echo "<form action='../scripts/clear_final.php' method=POST>";
echo "<center><h1>Shopping List</h1>";
echo "Portions for Prep: ".$portions;

$total_price=0;
$url_link="";

$sql="SELECT
        final_list.IFRT,
        MAX(final_list.checked) AS checked,
        SUM(final_list.QFRT) AS totalsum,
        SUM(COALESCE(final_list.used_servings, final_list.QFRT * items.servings)) AS total_used_servings,
        items.department,
        items.fiber,
        items.carbs,
        items.fat,
        items.protein,
        items.servings,
        items.calories,
        items.url,
        items.grocery_item
      FROM final_list
      INNER JOIN items ON final_list.IFRT=items.ID
      GROUP BY final_list.IFRT,
               items.department,items.fiber,items.carbs,items.fat,items.protein,
               items.servings,items.calories,items.url,items.grocery_item
      ORDER BY items.department ASC, items.grocery_item ASC";

$result=$conn->query($sql);
$rows=$result->fetch_all(MYSQLI_ASSOC);

foreach($rows as $macros) {
    $nutrition_servings=(float)$macros['total_used_servings'];
    $fat += $nutrition_servings * $macros['fat'];
    $protein += $nutrition_servings * $macros['protein'];
    $carbs += $nutrition_servings * $macros['carbs'];
    $fiber += $nutrition_servings * $macros['fiber'];
    $calories += $nutrition_servings * $macros['calories'];
}

include '../chart/macros.php';

echo "<table><tr><td>";
echo '<table border=2 class="searchable sortable"><tr><th>Ignore?</th><th>Got it</th><th>Qty</th><th align=center>Pantry Qty</th><th align=center>Description</th><th>Price</th><th align=center>Location</th><th align=center>Recipe List(s)</th><th>Link</th></tr>';

foreach($rows as $row2) {
    $id_to_pull_from_items=$row2['IFRT'];
    $qty_needed_from_recipe=$row2['totalsum'];
    $url=$row2['url'];

    $pantrysql="select pantryqty from items where id='".$id_to_pull_from_items."'";
    $result=$conn->query($pantrysql);
    $pantry_results=$result->fetch_assoc();

    if($row2['totalsum']>$pantry_results['pantryqty']) {
        echo "<tr><td align=center><input type='checkbox' id='ignore_cb' class='ignoreIt' value='".$id_to_pull_from_items."'></td>";

        if($row2['checked']=="1") {
            echo "<td align=center><input type='checkbox' id='IFRT_CHECKBOX' class='checkIt' value='".$id_to_pull_from_items."' checked></td><td align=center>".$qty_needed_from_recipe."</td>";
        } else {
            echo "<td align=center><input type='checkbox' id='IFRT_CHECKBOX' class='checkIt' value='".$id_to_pull_from_items."'></td><td align=center>".$qty_needed_from_recipe."</td>";
        }

        echo '<td contenteditable="true" id="txt_pantry" onBlur="saveToDb(this,'.$id_to_pull_from_items.')" align=center>'.$pantry_results["pantryqty"].'</td>';

        $get_food_info="select pantryqty,grocery_item,price,department from items where id='".$id_to_pull_from_items."' order by department";
        $item_results=$conn->query($get_food_info);
        $rows_from_items=$item_results->fetch_all(MYSQLI_ASSOC);

        foreach($rows_from_items as $item_info) {
            $recipe_entry=[];
            $get_recipe_name="select recipe_table_name from final_list where IFRT='".$id_to_pull_from_items."'";
            $recipes=$conn->query($get_recipe_name);
            $show_recipe_name=$recipes->fetch_all(MYSQLI_ASSOC);

            foreach($show_recipe_name as $recipe_td) {
                $recipe_entry[]=$recipe_td['recipe_table_name'];
            }

            foreach(array_unique($recipe_entry) as $word) {
                $finalized_recipe_entry=str_replace("_recipe_table","",$word);
                $complete_recipe_entry=str_replace("_"," ",$finalized_recipe_entry);
                $url_link.="<a target='_blank' href=../scripts/show_shopping_list.php?recipe_name=".$word.">".$complete_recipe_entry."</a>, ";
            }

            $price_for_items=($qty_needed_from_recipe-$pantry_results['pantryqty'])*$item_info['price'];
            echo "<td><a target=_blank href='https://www.walmart.com/search?q=".$item_info['grocery_item']."&facet=fulfillment_method_in_store%3AIn-store'>".$item_info['grocery_item']."</a></td><td align=center>".$price_for_items."</td><td align=center>".$item_info['department']."</td><td>".substr($url_link,0,-2)."</td><td><a target=_blank href='".$url."#id=".$id_to_pull_from_items."'>link</a></td></tr>";
            $total_price += $price_for_items;
            $url_link="";
        }
    }
}

echo "</table>";
echo "<td valign=top>";
echo "<table><tr><td>Bill:</td><td>".$total_price."</td></tr>";
echo "<tr><td>Tax:</td><td>6%</td></tr>";
$tax_added=$total_price*1.06;
saveFinalPriceToDB(number_format($tax_added,2));
echo "<tr><td>Total:</td><td>".number_format($tax_added,2)."</td></tr></table>";
echo "</td></tr><tr><td>Clear table <input type='submit'></td></tr></table></center></form>";
?>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.0/jquery.min.js"></script>
<script>
$('.checkIt').change(function () {
    var id=$(this).val();
    $.ajax({type:'POST',url:'../ajax/checkbox.php',data:'id='+id+'&checked='+(this.checked?'true':'false')});
});
$('.ignoreIt').change(function() {
    var id=$(this).val();
    $.ajax({type:'POST',url:'../ajax/ignore.php',data:'id='+id,success:function(){window.location.href='final_shopping_list.php';}});
});
$('#portions').change(function() {
    var id=$(this).val();
    $.ajax({type:'POST',url:'../ajax/portions.php',data:'id='+id,success:function(){window.location.href='final_shopping_list.php';}});
});
function saveToDb(editableObj,id) {
    var id_from_items=$(editableObj).text();
    $.ajax({type:'POST',url:'../ajax/edit_pantry.php',data:'id='+id+'&updated_value='+id_from_items,success:function(){window.location.href='final_shopping_list.php';}});
}
</script>
<a href="../index.php">Main Page</a>
</body>
