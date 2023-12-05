<meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />

<?php
    include '../include/passwords.php';
include '../include/toolbar.html';

    $item=$_POST["item"];
    $price=$_POST["price"];
    $department=$_POST["dept"];
    $servings=$_POST["servings"];
    $protein=$_POST["protein"];
    $fat=$_POST["fat"];
    $carbs=$_POST["carbs"];
    $calories=$_POST["calories"];
    $fiber=$_POST["fiber"];
//echo $items;
    $sql="Insert into items (grocery_item,price,department,pantryqty,servings,protein,fat,carbs,calories,fiber) Values ('".$item."','".$price."','".$department."','0','".$servings."','".$protein."','".$fat."','".$carbs."','".$calories."','".$fiber."')";
    echo "<br><br>";
    if ($conn->query($sql)){
            echo $sql."<br><br>";
                echo "Imported Ingredient to main food database";
    }
?>
<br>
<a href="../php/add_foods.php">Add Another Item</a><br>
<a href="../index.php">Main Page</a><br>
    
