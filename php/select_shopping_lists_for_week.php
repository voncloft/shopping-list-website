<!doctype html><html lang="en"><head><meta charset="utf-8"><meta name="viewport" content="width=device-width, initial-scale=1"><?php require_once __DIR__ . '/../include/theme-head.php'; ?><title>Select this week's recipes</title>
<script src="../include/recipe-filter.js?v=20261118" defer></script></head><body>
<?php
require_once __DIR__ . '/../include/passwords.php';
include __DIR__ . '/../include/toolbar.html';
require_once __DIR__ . '/../functions/show_recipes_interface.php';
?></center>
<main class="recipe-selector"><h1>Choose this week's recipes</h1><p>Recipes already imported are left out. Start with everything available, then narrow it down as much as you like.</p>
<?php include __DIR__ . '/../include/recipe-filter-controls.php'; ?>
<form action="../scripts/select_for_final.php" method="post" id="recipe-selection-form">
<p id="recipe-selection-count" role="status" aria-live="polite">0 selected</p>
<?php get_interface('select_recipes','hide_imported'); ?>
<p id="recipe-no-matches" hidden>No recipes match. Loosen a limit or clear the filters to show them again.</p>
<div class="theme-save-bar"><button type="submit">Add selected recipes to this week</button></div>
</form></main></body></html>
