<?php
require_once __DIR__ . '/recipe_card.php';
function show_imported_recipes() {
    global $conn;
    $rows = $conn->query('SELECT DISTINCT recipes FROM current_week_recipes ORDER BY recipes')->fetch_all(MYSQLI_ASSOC);
    echo '<div class="recipe-cards" id="recipe-cards">';
    foreach ($rows as $row) {
        $name=$row['recipes'];
        if (!preg_match('/^[A-Za-z0-9_]*_recipe_table$/D',$name)) continue;
        show_recipe_card($name, true);
    }
    echo '</div>';
}
