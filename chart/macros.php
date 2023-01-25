<head>
	<!-- Load plotly.js into the DOM -->
	<script src='https://cdn.plot.ly/plotly-2.18.0.min.js'></script>
</head>

<body>
	<table>
	<tr><td valign='top'>
	<div id='myDiv<?php echo $counter; ?>'><!-- Plotly chart will be drawn inside this DIV --></div>
	</td><td valign='top'>
		Fat: <?php echo $fat; ?><br>
		Protein: <?php echo $protein; ?><br>
		Carbs: <?php echo $carbs; ?><br>
		Fiber: <?php echo $fiber; ?>
	</td></tr></table>
</body>
<script>
var fat = <?php echo $fat; ?>;
var protein = <?php echo $protein; ?>;
var carbs = <?php echo $carbs; ?>;
var fiber = <?php echo $fiber; ?>;

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
