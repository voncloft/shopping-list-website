<?php
	include '../include/passwords.php';
	$ingredient_file='../recipes/ingredients/'.str_replace(" ","_",$_POST['recipe_name'])."_recipe_table_ingredients.html";
	$steps_file='../recipes/steps/'.str_replace(" ","_",$_POST['recipe_name'])."_recipe_table_steps.html";	
	$qty="";
	$contents="";
	//$c=0;
	$qty_contents="";
	$ingredients="<U>Ingredients:</u><br>";
	$count=$_POST["count"];
	for ($c=1;$c<=$count;$c++)
	{		
		$qty="qty".$c;
		if ($_POST[$qty]>0)
		{
			$measurement="measurement".$c;
			$ingredient="ingredient".$c;
			$ingredients=$ingredients.$_POST[$qty]." ".$_POST[$measurement]." ".$_POST[$ingredient]."<br>";
		}	
	}
	$instructions="<br><U>Steps:</u> <br>".$_POST['instructions'];
	//$contents=$contents;
	file_put_contents($ingredient_file, $ingredients);
	file_put_contents($steps_file,nl2br($instructions));
	echo "File Written<br>";
	echo "<a href=../index.php>Home</a>";
?>

