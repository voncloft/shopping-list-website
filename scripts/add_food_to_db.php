<?php
    include '../include/passwords.php';
include '../include/toolbar.html';

    $item=$_POST["item"];
    $price=$_POST["price"];
    $department=$_POST["dept"];
//echo $items;
    $sql="Insert into items (grocery_item,price,department,pantryqty) Values ('".$item."','".$price."','".$department."','0')";
    echo "<br><br>";
    if ($conn->query($sql)){
            echo $sql."<br><br>";
                echo "Imported Ingredient to main food database";
    }
?>
<br>
<a href="../php/add_foods.php">Add Another Item</a><br>
<a href="../index.php">Main Page</a><br>
    
