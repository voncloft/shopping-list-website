<?php
require_once __DIR__ . '/recipe_summary.php';
function get_prices_and_macros($recipe_name, $summary = null) {
    $summary = $summary ?? recipe_summary($recipe_name);
    if ($summary['error']) { echo '<p class="theme-error" role="alert">'.recipe_html($summary['error']).'</p>'; return; }
    $values = $summary['portion'];
    echo '<table class="recipe-summary" border="1"><tbody><tr><td>Recipe price: '.($values['price'] === null ? 'Incomplete' : '$'.number_format($values['price'],2)).'</td><td><label>Amount: <select name="'.recipe_html($recipe_name).'_portions" id="'.recipe_html($recipe_name).'_portions">';
    for ($i=1; $i<=10; $i++) echo '<option value="'.$i.'">'.$i.'× recipe</option>';
    echo '</select></label></td></tr></tbody></table>';
    echo '<p class="recipe-portion-note">Nutrition per prep portion (1 of '.recipe_html(recipe_prep_portions()).') for 1× recipe.</p><dl class="recipe-nutrition">';
    foreach (['calories'=>'Calories','protein'=>'Protein','fat'=>'Fat','carbs'=>'Carbs','fiber'=>'Fiber','net_carbs'=>'Net carbs'] as $key=>$label) {
        echo '<div class="recipe-metric recipe-metric-'.str_replace('_','-',$key).'"><dt>'.$label.'</dt><dd>'.($values[$key] === null ? 'Not set' : number_format($values[$key],2).($key==='calories' ? ' kcal':' g')).'</dd></div>';
    }
    echo '</dl>';
}
