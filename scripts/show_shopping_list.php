<meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />

<form action='apply_changes_to_shopping_list.php' method=POST>
<?php
include '../include/passwords.php';
include '../include/toolbar.html';
include '../functions/loadFile.php';
session_start();

function load_recipe_macro_rows($conn,$recipe_name)
{
    $sql="select ".$recipe_name.".qty, ".$recipe_name.".used_servings, ".$recipe_name.".ingredient_name,
                 items.servings,items.calories,items.fat,items.protein,items.carbs,items.fiber,items.grocery_item
          from ".$recipe_name."
          inner join items on ".$recipe_name.".ingredient_name=items.id";
    $result=$conn->query($sql);
    return $result->fetch_all(MYSQLI_ASSOC);
}

function calculate_recipe_macros($rows)
{
    $totals=['fat'=>0,'protein'=>0,'carbs'=>0,'fiber'=>0,'calories'=>0];

    foreach($rows as $macros) {
        $qty=(float)$macros['qty'];
        $package_servings=(float)$macros['servings'];

        if($macros['used_servings']===null || $macros['used_servings']==='') {
            $nutrition_servings=$qty*$package_servings;
        } else {
            $nutrition_servings=(float)$macros['used_servings'];
        }

        $totals['fat'] += $nutrition_servings*$macros['fat'];
        $totals['protein'] += $nutrition_servings*$macros['protein'];
        $totals['carbs'] += $nutrition_servings*$macros['carbs'];
        $totals['fiber'] += $nutrition_servings*$macros['fiber'];
        $totals['calories'] += $nutrition_servings*$macros['calories'];
    }

    return $totals;
}

function show_recipe_details($conn,$recipe_name)
{
    global $fat,$protein,$carbs,$fiber,$calories,$counter;

    $rows=load_recipe_macro_rows($conn,$recipe_name);
    $totals=calculate_recipe_macros($rows);

    $fat=$totals['fat'];
    $protein=$totals['protein'];
    $carbs=$totals['carbs'];
    $fiber=$totals['fiber'];
    $calories=$totals['calories'];

    include '../chart/macros.php';

    echo "</td><td valign='top' align='center'>";

    $remove_rt=str_replace("_recipe_table","",$recipe_name);
    $remove_us=str_replace("_"," ",$remove_rt);
    echo "<center><h1>".$remove_us."</h1></center>";

    $url="select url from recipe_lists where recipe_name='".$recipe_name."'";
    $url_retrieve=$conn->query($url);
    $url_row=$url_retrieve->fetch_all(MYSQLI_ASSOC);
    foreach($url_row as $url_echo) {
        if(!is_null($url_echo['url']) && !empty($url_echo['url'])) {
            echo "URL: <a href='".$url_echo['url']."' target='_blank'>Recipe</a>";
        }
    }

    $table_sql="select qty,used_servings,ingredient_name from ".$recipe_name;
    $table_retrieve=$conn->query($table_sql);
    $table_row=$table_retrieve->fetch_all(MYSQLI_ASSOC);

    echo "<table border='2'><caption>Ingredients</caption><tr><th>Qty</th><th>Used Servings</th><th>Item</th><th>Price</th><th>Department</th></tr>";
    $overall_price=0;

    foreach($table_row as $ingredient_name_id) {
        $item_sql="select grocery_item,price,department,servings from items where id='".$ingredient_name_id['ingredient_name']."'";
        $item_retrieve=$conn->query($item_sql);
        $item_row=$item_retrieve->fetch_all(MYSQLI_ASSOC);

        foreach($item_row as $item) {
            $reconfigured_cost=$ingredient_name_id['qty']*$item['price'];
            $used=$ingredient_name_id['used_servings'];
            if($used===null || $used==='') {
                $used='auto ('.($ingredient_name_id['qty']*$item['servings']).')';
            }

            echo "<tr><td>".$ingredient_name_id['qty']."</td><td>".$used."</td><td><a target=_blank href='https://www.walmart.com/search?q=".$item['grocery_item']."&facet=fulfillment_method_in_store%3AIn-store'>".$item['grocery_item']."</a></td><td>".$reconfigured_cost."</td><td>".$item['department']."</td></tr>";
            $overall_price += $reconfigured_cost;
        }
    }

    echo "<tr><td></td><td></td><td>Total Cost</td><td>".$overall_price."</td><td></td></tr></table>";
    loadFile($recipe_name);
    echo "</td>";
}

$overall_price=0;
$count=0;
$fat=0;
$protein=0;
$carbs=0;
$fiber=0;
$counter=0;
$calories=0;

echo "<center><table><caption><h1>All Recipes Selected</h1></caption><tr><td>";
echo "<table border='2'><tr align='top'>";

if(empty($_POST['recipes'])) {
    echo "<td>";
    $recipe_name=$_GET['recipe_name'];
    show_recipe_details($conn,$recipe_name);
} else {
    foreach($_POST['recipes'] as $selected) {
        $counter++;
        $count++;
        echo "<td>";
        show_recipe_details($conn,$selected);

        if($count==2) {
            $count=0;
            echo "</tr><tr>";
        }
    }
}

echo "</tr></table>";
echo "<tr><td align='center'><a href='../php/show_recipe_no_editing.php'>Show Recipe List</a></td></tr>";
?>
