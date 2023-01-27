<?php
function loadFile($recipe_name)
{
 		if(file_exists('../recipes/ingredients/'.$recipe_name."_ingredients.html"))
 		{  			
			echo "<table><tr><td>";  	
			include '../recipes/ingredients/'.$recipe_name."_ingredients.html";
			echo "</td></tr><tr><td>";	
  			include '../recipes/steps/'.$recipe_name."_steps.html";
  			echo "</td></tr></table>";
  		}
  		else {
  				echo "<table><tr><td>";  	
  				echo "No recipe instructions exist";
  				echo "</td></tr></table>";
  		}
}
?>