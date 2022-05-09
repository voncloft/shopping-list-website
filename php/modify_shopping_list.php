<?php
echo "RECIPES";
echo "<br><br>";

    include '../include/passwords.php';
    ?>
    <form action='../scripts/modify_shopping_list.php' method=POST>
    <?php
    $showtables= mysqli_query($conn, "SHOW TABLES FROM shopping_list");
    
    $sql="select recipes from current_week_recipes";
    $result = $conn->query($sql);
    $rows = $result->fetch_all(MYSQLI_ASSOC);
     $i=0;

      
      while($table = mysqli_fetch_array($showtables)) { 
      $i++;
          foreach($rows as $recipe)
          {
            if($table[0]==$recipe['recipes'])
            {            
              echo '<input type="checkbox" name="recipes[]" value="'.$table[0]. '">';  
              echo '<label">'.$table[0].'</label><br>';
          }
      }
    }
 
     ?>
     <input type="submit">
     </form>
