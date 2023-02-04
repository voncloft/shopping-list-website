<meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />

<?php
include '../include/passwords.php';
include '../include/toolbar.html';

session_start();
$counter=$_SESSION['counter'];
for($i=1;$i<=$counter;$i++)
{
  $idbox="idtb".$i;
  $pantryqty="pantry".$i;
  $sql="update items set pantryqty='".$_POST[$pantryqty]."' where id ='".$_POST[$idbox]."'";
  echo $sql."<br>";
  $conn->query($sql);
}
?>
<br>
<a href="../index.php">Main Page</a>
