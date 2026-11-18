<?php
require_once __DIR__.'/../include/passwords.php';
require_once __DIR__.'/item_form.php';
function modify_pantry() {
    global $conn;
    $items=site_items($conn);
    echo '<p>Changes save automatically after a short pause. Every field except URL is required; zero is valid. Blank values in older items must be completed before saving that item.</p><div class="item-edit-scroll"><table class="item-edit-table" border="1"><thead><tr>';
    foreach (item_form_fields() as $label) echo '<th>'.site_html($label).'</th>';
    echo '<th>Status</th></tr></thead><tbody>';
    foreach ($items as $id=>$item) {
        $data=$item; $data['item']=$item['grocery_item']; $data['dept']=$item['department']; $form='edit-item-'.$id;
        echo '<tr>';
        foreach (item_form_fields() as $key=>$label) { echo '<td>'; item_form_input($key,$data[$key] ?? '',$form,$form.'-'.$key); echo '</td>'; }
        echo '<td><button type="submit" form="'.$form.'">Save</button></td></tr>';
    }
    echo '</tbody></table></div>';
    foreach ($items as $id=>$item) echo '<form id="edit-item-'.$id.'" action="../scripts/modify_item.php" method="post"><input type="hidden" name="item_id" value="'.$id.'"></form>';
}
