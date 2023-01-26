<head>
	<!-- Load plotly.js into the DOM -->
	<script src='https://cdn.plot.ly/plotly-2.18.0.min.js'></script>
</head>

<body>
	<table>
	<tr><td valign='top'>
	<div id='myDiv<?php echo $counter; ?>'><!-- Plotly chart will be drawn inside this DIV --></div>
	</td><td valign='top'>
		Calories: <?php echo round($calories/7,2); ?><br>
		Fat: <?php echo round($fat/7,2); ?>g<br>
		Protein: <?php echo round($protein/7,2); ?>g<br>
		Carbs: <?php echo round($carbs/7,2); ?>g<br>
		Fiber: <?php echo round($fiber/7,2); ?>g<br>
		<?php
			$net=($carbs/7)-($fiber/7);
		?>
		Net Carbs:<?php echo round($net,2);?>g
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
