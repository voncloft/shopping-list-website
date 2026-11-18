<section class="theme-panel" id="recipe-filters" aria-label="Filter available recipes">
<label for="recipe-search">Recipe name</label><input type="search" id="recipe-search" placeholder="Try chicken or spicy pork" autocomplete="off">
<details><summary>Calories, macros and price</summary><p>Fill in any minimum or maximum. All filled-in limits must match. Calories and macros are per prep portion; price is for 1× the full recipe.</p>
<div class="recipe-ranges">
<?php foreach (['calories'=>'Calories (kcal)','protein'=>'Protein (g)','fat'=>'Fat (g)','carbs'=>'Carbs (g)','fiber'=>'Fiber (g)','net-carbs'=>'Net carbs (g)','price'=>'Recipe price ($)'] as $key=>$label): ?>
<fieldset><legend><?= recipe_html($label) ?></legend><label>Min <input type="number" step="any" data-metric="<?= $key ?>" data-bound="min" aria-label="Minimum <?= recipe_html($label) ?>"></label><label>Max <input type="number" step="any" data-metric="<?= $key ?>" data-bound="max" aria-label="Maximum <?= recipe_html($label) ?>"></label></fieldset>
<?php endforeach; ?></div>
<p class="theme-muted">Recipes with missing nutrition are excluded only when you filter that missing value. Estimates depend on the item information in your database.</p></details>
<div class="theme-actions"><button type="button" id="clear-recipe-filters">Clear filters</button><p id="recipe-filter-count" role="status" aria-live="polite"></p></div><p id="recipe-filter-error" class="theme-error" role="alert" hidden></p></section>
