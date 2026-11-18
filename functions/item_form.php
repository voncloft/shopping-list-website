<?php
require_once __DIR__.'/form_checks.php';
function item_form_fields() { return ['item'=>'Item name','price'=>'Price','dept'=>'Department','pantryqty'=>'Pantry quantity','servings'=>'Servings','calories'=>'Calories','fat'=>'Fat','protein'=>'Protein','carbs'=>'Carbohydrates','fiber'=>'Fiber','url'=>'URL (optional)']; }
function item_form_input($key,$value='',$form='',$id='') {
    $label=item_form_fields()[$key];
    $type=in_array($key,['item','dept'],true)?'text':($key==='url'?'url':'number');
    echo '<input type="'.$type.'" name="'.$key.'" id="'.site_html($id ?: $key).'" value="'.site_html($value).'" aria-label="'.site_html($label).'"';
    if ($form!=='') echo ' form="'.site_html($form).'"';
    if ($key!=='url') echo ' required';
    if ($type==='number') echo ' min="0" max="1000000000" step="'.($key==='price'?'0.01':'any').'"';
    else echo ' maxlength="'.($key==='url'?'8192':($key==='dept'?'80':'255')).'"';
    echo '>';
}
