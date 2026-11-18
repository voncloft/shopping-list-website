<?php
require_once __DIR__ . '/../functions/get_servings.php';
getServings();
global $servings_from_db;
$chartPortions = max(1, (float)$servings_from_db);
$chartValues = [round($fat/$chartPortions,2),round($protein/$chartPortions,2),round($carbs/$chartPortions,2),round($fiber/$chartPortions,2)];
$chartId = 'myDiv' . (int)$counter;
if (empty($GLOBALS['shopping_plotly_loaded'])) {
    echo '<script src="https://cdn.plot.ly/plotly-2.18.0.min.js"></script>';
    $GLOBALS['shopping_plotly_loaded'] = true;
}
?>
<table class="macro-chart"><tr><td valign="top"><div id="<?= $chartId ?>"></div></td><td valign="top">
Servings: <?= $chartPortions ?><br>
Calories: <?= round($calories/$chartPortions,2) ?><br>
Fat: <?= $chartValues[0] ?>g<br>Protein: <?= $chartValues[1] ?>g<br>Carbs: <?= $chartValues[2] ?>g<br>Fiber: <?= $chartValues[3] ?>g<br>
Net Carbs: <?= round(($carbs-$fiber)/$chartPortions,2) ?>g
</td></tr></table>
<script>
(function () {
    var id = <?= json_encode($chartId) ?>;
    var data = [{values:<?= json_encode($chartValues) ?>,labels:['Fat','Protein','Carbs','Fiber'],type:'pie'}];
    Plotly.newPlot(id, data, {height:400,width:400}, {responsive:true}).then(function () {
        document.dispatchEvent(new Event('shopping-chart-ready'));
    });
}());
</script>
