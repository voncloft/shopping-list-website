 <?php
 $q = isset($_GET['q']) && is_string($_GET['q']) ? trim($_GET['q']) : '';
 if ($q === '' || strlen($q) > 255) exit;
 header('Content-Type: text/plain; charset=utf-8');
include_once '../include/passwords.php';
 $my_data=mysqli_real_escape_string($conn,$q);
 $sql="SELECT distinct department FROM items WHERE department LIKE '%$my_data%'";
 $result = mysqli_query($conn,$sql);

 if($result)
 {
  while($row=mysqli_fetch_array($result))
  {
   echo $row['department']."\n";
  }
 }
?>
