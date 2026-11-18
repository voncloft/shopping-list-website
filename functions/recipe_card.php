<?php
require_once __DIR__ . '/get_prices_and_macros.php';
function show_recipe_card($name, $allowRepair = false) {
    $label = trim(str_replace('_', ' ', substr($name, 0, -13))) ?: 'Unnamed recipe';
    $summary = recipe_summary($name);
    echo '<section class="recipe-card" data-recipe-name="'.recipe_html($label).'"';
    foreach ($summary['portion'] as $key=>$value) echo ' data-'.str_replace('_','-',$key).'="'.($value === null ? '' : recipe_html($value)).'"';
    echo '><h2><label><input type="checkbox" name="recipes[]" value="'.recipe_html($name).'"'.($summary['error'] && !$allowRepair?' disabled':'').'> '.recipe_html($label).'</label></h2>';
    get_prices_and_macros($name, $summary);
    echo '<p><a href="../scripts/show_shopping_list.php?recipe_name='.rawurlencode($name).'" target="_blank" rel="noopener">View recipe and instructions</a></p>';
    echo '</section>';
}
