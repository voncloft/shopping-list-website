<?php
require_once __DIR__.'/../include/passwords.php';
require_once __DIR__.'/form_checks.php';
function pantry_inventory() {
    global $conn;
    $items=site_items($conn);
    echo '<p>Edit a quantity. That row saves automatically after a short pause.</p><div class="item-edit-scroll pantry-inventory-scroll"><table class="item-edit-table pantry-inventory-table" border="1"><colgroup><col class="pantry-item-column"><col class="pantry-department-column"><col class="pantry-quantity-column"><col class="pantry-status-column"></colgroup><thead><tr><th scope="col">Item</th><th scope="col">Department</th><th scope="col">Quantity at home</th><th scope="col">Status</th></tr></thead><tbody>';
    foreach ($items as $id=>$row) echo '<tr><td>'.site_html($row['grocery_item']).'</td><td>'.site_html($row['department']).'</td><td><input type="number" min="0" step="any" required form="pantry-'.$id.'" name="pantryqty" value="'.site_html($row['pantryqty']).'" aria-label="Pantry quantity for '.site_html($row['grocery_item']).'"></td><td><button type="submit" form="pantry-'.$id.'">Save</button></td></tr>';
    echo '</tbody></table></div>';
    foreach ($items as $id=>$row) echo '<form id="pantry-'.$id.'" action="../scripts/update_pantry.php" method="post"><input type="hidden" name="item_id" value="'.$id.'"></form>';
}
