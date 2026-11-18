<?php
require_once __DIR__.'/../functions/loadFile.php';
include __DIR__.'/../include/toolbar.html';
echo '</center><main class="recipe-detail-page">';
$selected = $_POST['recipes'] ?? [];
if (is_array($selected)) foreach ($selected as $recipe) {
    if (!is_string($recipe) || !preg_match('/^[A-Za-z0-9_]*_recipe_table$/D',$recipe)) continue;
    echo '<h1>'.htmlspecialchars(str_replace('_',' ',substr($recipe,0,-13)),ENT_QUOTES,'UTF-8').'</h1>';
    loadFile($recipe);
}
echo '<p><a href="../index.php">Home</a></p></main>';
