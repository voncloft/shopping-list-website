<?php
echo "RECIPES";
echo "<br><br>";
    include '../include/passwords.php';
    ?>
    <form action='../scripts/modify_shopping_list.php' method=POST>
    <?php
    $showtables= mysqli_query($conn, "SHOW TABLES FROM shopping_list");
    while($table = mysqli_fetch_array($showtables)) { 
         $i=0;
        if($table[0]!="items" && $table[0]!="final_list" )
         {
            $i++;
            echo '<input type="checkbox" name="recipes[]" value="'.$table[0]. '">';  
            echo '<label">'.$table[0].'</label><br>';
      }
    }
     ?>
     <input type="submit">
     </form>
