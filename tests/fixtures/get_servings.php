<?php
// Isolated test stub: never opens the site's database configuration.
function getServings()
{
    $GLOBALS['servings_from_db'] = 7;
}
