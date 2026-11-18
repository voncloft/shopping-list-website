<?php
function site_html($v) { return htmlspecialchars((string)$v, ENT_QUOTES, 'UTF-8'); }
function site_json_request() {
    return ($_POST['format'] ?? '') === 'json' || stripos($_SERVER['HTTP_ACCEPT'] ?? '', 'application/json') !== false || strpos($_SERVER['SCRIPT_NAME'] ?? '', '/ajax/') !== false;
}
function site_error($message, $status=400) {
    if (!headers_sent()) http_response_code($status);
    if (site_json_request()) {
        if (!headers_sent()) header('Content-Type: application/json; charset=utf-8');
        echo json_encode(['ok'=>false,'error'=>$message]);
    } else {
        echo '<!doctype html><meta name="viewport" content="width=device-width, initial-scale=1">';
        require_once __DIR__.'/../include/theme-head.php';
        echo '</table></form></center><section class="theme-panel" role="alert"><h1>Could not complete that change</h1><p>'.site_html($message).'</p><p><button type="button" onclick="history.back()">Back to your form</button> · <a href="../index.php">Home</a></p></section>';
    }
    exit;
}
function site_install_error_handler() {
    static $installed=false;
    if ($installed) return; $installed=true;
    ini_set('display_errors','0');
    set_exception_handler(function ($e) {
        if ($e instanceof InvalidArgumentException) site_error($e->getMessage(),400);
        error_log('Shopping website request failed: '.get_class($e).' code '.$e->getCode().' in '.basename($e->getFile()).':'.$e->getLine());
        site_error('The request could not be completed. Check the database connection and server log, then try again.',500);
    });
}
site_install_error_handler();
function site_post() { if (($_SERVER['REQUEST_METHOD'] ?? '') !== 'POST') site_error('Submit the form to make this change.',405); }
function site_text($value, $label, $required=true, $limit=255) {
    if (!is_string($value) && !is_numeric($value)) throw new InvalidArgumentException($label.' must be text.');
    $value=trim((string)$value);
    if ($required && $value==='') throw new InvalidArgumentException($label.' is required.');
    if (strlen($value)>$limit || preg_match('/[\x00-\x08\x0b\x0c\x0e-\x1f]/',$value)) throw new InvalidArgumentException($label.' is too long or contains invalid characters.');
    return $value;
}
function site_number($value, $label, $nullable=false, $integer=false, $max=1000000000) {
    $raw=site_text($value ?? '',$label,!$nullable,40);
    if ($raw==='' && $nullable) return null;
    if (!preg_match($integer ? '/^\d+$/D' : '/^\d+(?:\.\d+)?$/D',$raw) || !is_finite((float)$raw) || (float)$raw>$max) throw new InvalidArgumentException($label.' must be a non-negative '.($integer?'whole number':'number').'.');
    return $integer ? (int)$raw : (float)$raw;
}
function site_id($value,$label='Item') {
    $id=site_number($value,$label,false,true,2147483647);
    if ($id<1) throw new InvalidArgumentException('Choose a valid '.$label.'.');
    return $id;
}
function site_url($value) {
    $url=site_text($value ?? '', 'URL',false,8192);
    if ($url!=='' && (!filter_var($url,FILTER_VALIDATE_URL) || !in_array(strtolower(parse_url($url,PHP_URL_SCHEME) ?? ''),['http','https'],true))) throw new InvalidArgumentException('URL must start with http:// or https://, or be left empty.');
    return $url;
}
function site_name_key($name) {
    $name=preg_replace('/\s+/u',' ',trim($name));
    return function_exists('mb_strtolower') ? mb_strtolower($name,'UTF-8') : strtolower($name);
}
function site_items($conn) {
    $items=[];
    foreach ($conn->query('SELECT ID AS item_id,grocery_item,price,department,pantryqty,servings,calories,fat,protein,carbs,fiber,url FROM items ORDER BY grocery_item')->fetch_all(MYSQLI_ASSOC) as $row) $items[(int)$row['item_id']]=$row;
    return $items;
}
function site_item_input($post, $existing=null) {
    $item=['item'=>preg_replace('/\s+/u',' ',site_text($post['item'] ?? '', 'Item name')),'dept'=>site_text($post['dept'] ?? '', 'Department',true,80)];
    foreach (['price'=>'Price','servings'=>'Servings','calories'=>'Calories','fat'=>'Fat','protein'=>'Protein','carbs'=>'Carbohydrates','fiber'=>'Fiber'] as $key=>$label) $item[$key]=site_number($post[$key] ?? '',$label);
    if (abs(round($item['price'],2)-$item['price'])>0.000001) throw new InvalidArgumentException('Price can have at most two decimal places.');
    // Existing add-ons do not send pantryqty; new foods have always started at zero.
    $item['pantryqty']=site_number($post['pantryqty'] ?? ($existing['pantryqty'] ?? '0'),'Pantry quantity');
    $item['url']=site_url($post['url'] ?? '');
    return $item;
}
function site_duplicate_item($items,$name,$editingId=0) {
    $key=site_name_key($name);
    // Permit an unchanged historical name; do not force unrelated legacy duplicates to be renamed.
    if ($editingId && isset($items[$editingId]) && site_name_key($items[$editingId]['grocery_item'])===$key) return;
    foreach ($items as $id=>$item) if ($id!==$editingId && site_name_key($item['grocery_item'])===$key) throw new InvalidArgumentException('An item named “'.$item['grocery_item'].'” already exists (ID '.$id.'). Edit that item or use a different name.');
}
function site_recipe_tables($conn) {
    $tables=[];
    foreach ($conn->query('SHOW TABLES')->fetch_all(MYSQLI_NUM) as $row) if (substr($row[0],-13)==='_recipe_table') $tables[$row[0]]=true;
    return $tables;
}
function site_recipe_name($conn,$value) {
    $name=site_text($value,'Recipe',true,64);
    if (!preg_match('/^[A-Za-z0-9_]*_recipe_table$/D',$name) || !isset(site_recipe_tables($conn)[$name])) throw new InvalidArgumentException('Select an existing recipe.');
    return $name;
}
function site_execute($conn,$sql,$types,&...$params) {
    $stmt=$conn->prepare($sql); if (!$stmt) throw new RuntimeException('Statement unavailable.');
    $stmt->bind_param($types,...$params); if (!$stmt->execute()) throw new RuntimeException('Save failed.');
    $stmt->close();
}
function site_transaction($conn,$callback) {
    $conn->begin_transaction();
    try { $conn->query('SELECT weekly_total FROM variables FOR UPDATE'); $result=$callback(); $conn->commit(); return $result; }
    catch (Throwable $e) { $conn->rollback(); throw $e; }
}
function site_success($message,$link='../index.php') {
    if (site_json_request()) { header('Content-Type: application/json; charset=utf-8'); echo json_encode(['ok'=>true,'message'=>$message]); return; }
    require_once __DIR__.'/../include/theme-head.php';
    echo '<meta name="viewport" content="width=device-width, initial-scale=1"><section class="theme-panel"><p role="status">'.site_html($message).'</p><p><a href="'.site_html($link).'">Continue</a> · <a href="../index.php">Home</a></p></section>';
}
