<meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />

<?php
include '../include/passwords.php';
include '../include/toolbar.html';

session_start();
$counter=$_SESSION['counter'];
for($i=1;$i<=$counter;$i++)
{
  $idbox="idtb".$i;
  $itembox="itemtb".$i;
  $pricebox="pricetb".$i;
  $dbox="dtb".$i;
  $servings="servings".$i;
  if($_POST[$servings]>=0)
  {
  	$calories="calories".$i;
  	$fat="fat".$i;
  	$protein="protein".$i;
  	$carbs="carbs".$i;
  	$sql="update items set grocery_item='".$_POST[$itembox]."',price='".$_POST[$pricebox]."',department='".$_POST[$dbox]."',servings='".$_POST[$servings]."'".",calories='".$_POST[$calories]."'".",fat='".$_POST[$fat]."'".",protein='".$_POST[$protein]."'".",carbs='".$_POST[$carbs]."'"." where id ='".$_POST[$idbox]."'";
  }
  else
  {
        $sql="update items set grocery_item='".$_POST[$itembox]."',price='".$_POST[$pricebox]."',department='".$_POST[$dbox]."',servings=0,calories=0,fat=0,protein=0,carbs=0 where id ='".$_POST[$idbox]."'";;
  }
  	//echo "<br>".$sql."<br><br>";
  	echo "<br>".$sql."<br><br>";
   	$conn->query($sql);
}
//echo "<br>".$sql."<br><br>";
?>
<br>
<a href="../index.php">Main Page</a>
