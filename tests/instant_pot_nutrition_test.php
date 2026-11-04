<?php
// Run: php tests/instant_pot_nutrition_test.php
// The include-path fixture prevents loading any database credentials/connection.
set_include_path(__DIR__ . '/fixtures' . PATH_SEPARATOR . get_include_path());
require __DIR__ . '/../functions/get_prices_and_macros.php';
if (!defined('MYSQLI_ASSOC')) define('MYSQLI_ASSOC', 1);

function check($ok, $message) {
    if (!$ok) throw new RuntimeException($message);
}
class RecipeResult {
    public $rows;
    function __construct($rows) { $this->rows = $rows; }
    function fetch_all($mode) { return $this->rows; }
}
class RecipeConnection {
    public $rows;
    public $lastQuery;
    function query($query) {
        $this->lastQuery = $query;
        return new RecipeResult($this->rows);
    }
}
$conn = new RecipeConnection();
$base = ['qty'=>1, 'used_servings'=>2, 'servings'=>7, 'price'=>5,
    'calories'=>70, 'fat'=>7, 'protein'=>14, 'carbs'=>21, 'fiber'=>0];
function renderRecipe($rows) {
    global $conn;
    $conn->rows = $rows;
    ob_start(); get_prices_and_macros('Fixture_recipe_table'); return ob_get_clean();
}
$html = renderRecipe([$base]);
check(strpos($conn->lastQuery, '.used_servings') !== false, 'Select used_servings');
check(strpos($html, 'Price: $5') !== false, 'Purchase price stays based on qty');
check(strpos($html, '<center>20</td>') !== false, '2 consumed servings * 70 / 7 = 20 calories');
check(strpos($html, 'incomplete') === false, 'Complete data must not be flagged');
$old = array_replace($base, ['qty'=>2, 'used_servings'=>null]);
check(strpos(renderRecipe([$old]), '<center>140</td>') !== false, 'Old NULL serving fallback: 2 * 7 * 70 / 7');
check(recipe_nutrition_servings(array_replace($old,['used_servings'=>''])) === 14.0,'Blank serving fallback');
check(recipe_nutrition_servings(array_replace($base,['used_servings'=>'0'])) === 0.0,'Explicit zero must not fall back');
$missing=array_replace($base,['calories'=>null]);
check(strpos(renderRecipe([$missing]), 'Nutrition totals are incomplete.') !== false, 'NULL is unknown, not zero');
$missing=array_replace($base,['calories'=>0,'fiber'=>'']);
check(strpos(renderRecipe([$missing]), 'Nutrition totals are incomplete.') !== false, 'Blank nutrition is unknown');
check(strpos(renderRecipe([array_replace($base,['calories'=>0])]), 'incomplete') === false, 'Actual zero is complete');
check(strpos(renderRecipe([array_replace($base,['used_servings'=>0,'calories'=>null])]), 'incomplete') === false, 'Unused food does not affect totals');
ob_start(); show_incomplete_nutrition_notice([array_replace($base,['total_used_servings'=>3,'fat'=>null])]); $notice=ob_get_clean();
check(strpos($notice,'Nutrition totals are incomplete.')!==false, 'Final-list aggregate warning');
check(recipe_nutrition_servings(['total_used_servings'=>3])===3.0,'Final-list aggregate servings');
$detail = file_get_contents(__DIR__ . '/../scripts/show_shopping_list.php');
$start = strpos($detail, 'function calculate_recipe_macros(');
$end = strpos($detail, 'function show_recipe_details(', $start);
eval(substr($detail, $start, $end-$start));
$totals = calculate_recipe_macros([$base, $old]);
check($totals['calories'] === 1120.0, 'Detail view agrees on explicit and legacy batch totals');
check($totals['fiber'] === 0.0, 'Zero fiber remains valid');
echo "PASS: consumed servings, purchase prices, NULL/blank fallback, explicit zero, incomplete nutrition, detail totals, and final-list aggregates.\n";
