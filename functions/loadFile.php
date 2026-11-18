<?php
function loadFile($recipe_name) {
    if (!preg_match('/^[A-Za-z0-9_]*_recipe_table$/D', $recipe_name)) return;
    $base = __DIR__ . '/../recipes/';
    foreach (['ingredients'=>'Ingredients','steps'=>'Steps'] as $folder=>$label) {
        $file = $base . $folder . '/' . $recipe_name . '_' . $folder . '.html';
        echo '<section class="recipe-instructions recipe-'.$folder.'">';
        if (is_file($file)) include $file;
        else echo '<p>No '.strtolower($label).' saved for this recipe yet.</p>';
        echo '</section>';
    }
}
