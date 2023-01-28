<meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />

<?php
include '../include/passwords.php';
include '../include/toolbar.html';

session_start();
if(!empty($_POST['recipes'])){
    foreach($_POST['recipes'] as $selected){
        $recipe_name=$selected;
	echo $recipe_name;
	$sql="delete from current_week_recipes where recipes='".$recipe_name."'";
	$conn->query($sql);
	$sql2="delete from final_list where recipe_table_name='".$recipe_name."'";
	$conn->query($sql2);
	echo $sql."<br>".$sql2."<br>";
	echo "Removed ".$recipe_name." from the week<br>";
	}
}
?>
<br>
<a href="../index.php">Main Page</a>
