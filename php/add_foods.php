<html>
<meta name="viewport" content="initial-scale=.75, maximum-scale=1.0, user-scalable=no" />

<head>
<link rel="stylesheet" type="text/css" href="../include/colors.css" />
<script type="text/javascript" src="../include/jquery/jquery.js"></script>
<script type="text/javascript" src="../include/jquery/jquery.autocomplete.js"></script>
<script>
 $(document).ready(function(){
  $("#item").autocomplete("../include/item_complete.php", {
        selectFirst: true
  });
 });
</script>
<script>
 $(document).ready(function(){
  $("#dept").autocomplete("../include/dept_complete.php", {
        selectFirst: true
  });
 });
</script>
</head>
<?php
include '../include/toolbar.html'

?>
<input type="hidden" name="update" value="<?php echo $stat;?>">
<form action='../scripts/add_food_to_db.php' method=POST>
<table border = 2 ><caption>Add item</caption>
<tr><td>Item Name</td><td>Price</td><td>Department</td></tr>
<tr><td><input type="text" name="item" id="item"></td>
<td><input type="text" name="price" id="price"></td>
<td><input type="text" name="dept" id="dept"></td></tr>
<tr><td>Servings</td><td>Calories</td><td>Fat</td></tr>
<tr><td><input type="text" name="servings" id="servings"></td>
<td><input type="text" name="calories" id="calories"></td>
<td><input type="text" name="fat" id="fat"></td></tr>
<tr><td>Protein</td><td>Carbohydrates</td></tr>
<tr><td><input type="text" name="protein" id="protein"></td>
<td><input type="text" name="carbs" id="carbs"></td></tr>


</table><input type="submit">
</form>
