 <?php
//error_reporting(0);
 $q=$_GET['q'];
 //echo $q;
include_once '../include/passwords.php';
 $my_data=mysqli_real_escape_string($conn,$q);
 //echo $my_data;
 //$sql="SELECT distinct Search_query FROM Search_History WHERE Search_query LIKE '%$my_data%' ORDER BY Search_query";
 $sql="SELECT distinct grocery_item FROM items WHERE grocery_item LIKE '%$my_data%'";
//echo $sql; 
 $result = mysqli_query($conn,$sql) or die(mysqli_error());

 if($result)
 {
  while($row=mysqli_fetch_array($result))
  {
   echo $row['grocery_item']."\n";
  }
 }
?>
