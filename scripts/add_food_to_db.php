<?php
    include '../include/passwords.php';
    $item=$_POST["item"];
    $price=$_POST["price"];
    $department=$_POST["dept"];
//echo $items;
    $sql="Insert into items (grocery_item,price,department) Values ('".$item."','".$price."','".$department."')";
    echo "<br><br>";
    if ($conn->query($sql)){
            echo $sql."<br><br>";
                echo "Imported Ingredient to main food database";
    }
?>
<a href="../php/add_foods.php">Add Another Item</a>
<a href="../index.php">Main Page</a>
    
