<head>
	<!-- Load plotly.js into the DOM -->
	<script src='https://cdn.plot.ly/plotly-2.18.0.min.js'></script>
</head>

<body>
	<table>
	<tr><td valign='top'>
	<div id='myDiv<?php echo $counter; ?>'><!-- Plotly chart will be drawn inside this DIV --></div>
	</td><td valign='top'>
		<?php
			include_once '../functions/get_servings.php';
			getServings();
			global $servings_from_db;
		?>
		Calories: <?php echo round($calories/$servings_from_db,2); ?><br>
		Fat: <?php echo round($fat/$servings_from_db,2); ?>g<br>
		Protein: <?php echo round($protein/$servings_from_db,2); ?>g<br>
		Carbs: <?php echo round($carbs/$servings_from_db,2); ?>g<br>
		Fiber: <?php echo round($fiber/$servings_from_db,2); ?>g<br>
		<?php
			$net=($carbs/$servings_from_db)-($fiber/$servings_from_db);
		?>
		Net Carbs:<?php echo round($net,2);?>g
	</td></tr></table>
</body>
<script>

var fat = <?php echo round($fat/$servings_from_db,2); ?>;
var protein = <?php echo round($protein/$servings_from_db,2); ?>;
var carbs = <?php echo round($carbs/$servings_from_db,2); ?>;
var fiber = <?php echo round($fiber/$servings_from_db,2); ?>;

var data = [{
  values: [fat, protein, carbs, fiber],
  labels: ['Fat', 'Protein', 'Carbs','Fiber'],
  type: 'pie'
}];

var layout = {
  height: 400,
  width: 400
};

Plotly.newPlot('myDiv<?php echo $counter; ?>', data, layout);
</script>
