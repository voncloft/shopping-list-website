<head>
	<!-- Load plotly.js into the DOM -->
	<script src='https://cdn.plot.ly/plotly-2.18.0.min.js'></script>
</head>

<body>
	<table>
	<tr><td valign='top'>
	<div id='myDiv<?php echo $counter; ?>'><!-- Plotly chart will be drawn inside this DIV --></div>
	</td><td valign='top'>
		Calories: <?php echo $calories/7; ?><br>
		Fat: <?php echo $fat/7; ?><br>
		Protein: <?php echo $protein/7; ?><br>
		Carbs: <?php echo $carbs/7; ?><br>
		Fiber: <?php echo $fiber/7; ?>
	</td></tr></table>
</body>
<script>

var fat = <?php echo $fat/7; ?>;
var protein = <?php echo $protein/7; ?>;
var carbs = <?php echo $carbs/7; ?>;
var fiber = <?php echo $fiber/7; ?>;

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
