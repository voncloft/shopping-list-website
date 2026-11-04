<?php
// Used servings describe food eaten; qty describes packages purchased.
function recipe_nutrition_servings($row)
{
    if (isset($row['total_used_servings'])) {
        return (float)$row['total_used_servings'];
    }
    if (isset($row['used_servings']) && $row['used_servings'] !== '') {
        return (float)$row['used_servings'];
    }
    return (float)$row['qty'] * (float)$row['servings'];
}

function show_incomplete_nutrition_notice($rows)
{
    foreach ($rows as $row) {
        if (recipe_nutrition_servings($row) <= 0) {
            continue;
        }
        foreach (['calories', 'fat', 'protein', 'carbs', 'fiber'] as $field) {
            if (!isset($row[$field]) || $row[$field] === '') {
                echo '<p><strong>Nutrition totals are incomplete.</strong> '
                    . 'Enter the missing ingredient nutrition from your product labels.</p>';
                return;
            }
        }
    }
}
