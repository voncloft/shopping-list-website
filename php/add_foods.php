<?php require_once __DIR__.'/../functions/item_form.php'; ?>
<!doctype html><html lang="en"><head><meta charset="utf-8"><meta name="viewport" content="width=device-width, initial-scale=1"><?php require_once __DIR__ . '/../include/theme-head.php'; ?><title>Add grocery item</title>
<link rel="stylesheet" href="../include/colors.css"><script src="../include/jquery/jquery.js"></script><script src="../include/jquery/jquery.autocomplete.js"></script>
<script>$(document).ready(function(){ $('#item').autocomplete('../include/item_complete.php',{selectFirst:true}); $('#dept').autocomplete('../include/dept_complete.php',{selectFirst:true}); });</script>
</head><body><?php include __DIR__.'/../include/toolbar.html'; ?></center>
<main class="theme-page"><h1>Add grocery item</h1><p>Every field except URL is required. Enter 0 where the actual value is zero. Names must be unique.</p>
<form action="../scripts/add_food_to_db.php" method="post"><div class="item-form-grid">
<?php foreach (item_form_fields() as $key=>$label): ?><label><?= site_html($label) ?><?php item_form_input($key,$key==='pantryqty'?'0':''); ?></label><?php endforeach; ?>
</div><p><button type="submit">Add item</button></p></form></main></body></html>
