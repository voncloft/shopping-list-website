<?php
require_once __DIR__ . '/../include/passwords.php';
require_once __DIR__ . '/recipe_card.php';
function show_all_recipes_to_select($function_of_use) {
    global $conn;
    $imported = [];
    if ($function_of_use === 'hide_imported') foreach ($conn->query('SELECT recipes FROM current_week_recipes')->fetch_all(MYSQLI_ASSOC) as $row) $imported[$row['recipes']] = true;
    $tables = $conn->query('SHOW TABLES')->fetch_all(MYSQLI_NUM);
    echo '<div class="recipe-cards" id="recipe-cards">';
    foreach ($tables as $table) {
        $name = $table[0];
        if (substr($name, -13) !== '_recipe_table' || isset($imported[$name])) continue;
        show_recipe_card($name, $function_of_use === 'edit_recipes');
    }
    echo '</div>';
}
