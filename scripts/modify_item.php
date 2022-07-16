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
  $sql="update items set grocery_item='".$_POST[$itembox]."',price='".
  $_POST[$pricebox]."',department='".$_POST[$dbox]."' where id ='".$_POST[$idbox]."'";
  echo $sql."<br>";
   $conn->query($sql);
}
?>
<br>
<a href="../index.php">Main Page</a>
