<?php
// Prepare before homepage markup so the shared settings form can use a session token.
if (session_status() !== PHP_SESSION_ACTIVE) session_start();
require_once __DIR__ . '/../functions/themes.php';
if (empty($_SESSION['theme_token'])) $_SESSION['theme_token'] = bin2hex(random_bytes(32));
$homeThemes = []; $homeThemeSettings = null;
try {
    require_once __DIR__ . '/passwords.php';
    $homeThemes = shopping_theme_rows($conn);
    $homeThemeSettings = shopping_theme_settings($conn);
} catch (Throwable $e) { /* The Themes link explains how to install the migration. */ }
function home_theme_picker($base = '', $returnTo = 'home') {
    global $homeThemes, $homeThemeSettings;
    echo '<section class="home-theme-picker theme-panel"><h2>Appearance</h2>';
    if (!empty($_SESSION['theme_saved'])) { echo '<p class="theme-success" role="status">'.shopping_theme_h($_SESSION['theme_saved']).'</p>'; unset($_SESSION['theme_saved']); }
    if ($homeThemeSettings) {
        echo '<form action="'.$base.'php/themes.php" method="post" class="theme-actions">';
        echo '<input type="hidden" name="token" value="'.shopping_theme_h($_SESSION['theme_token']).'"><input type="hidden" name="return_to" value="'.$returnTo.'">';
        echo '<label for="home-theme">Theme</label><select name="theme_id" id="home-theme">';
        foreach ($homeThemes as $theme) {
            $selected = $homeThemeSettings['mode'] !== 'system' && (int)$theme['id'] === (int)$homeThemeSettings['active_theme_id'];
            echo '<option value="'.(int)$theme['id'].'"'.($selected?' selected':'').'>'.shopping_theme_h($theme['name']).'</option>';
        }
        echo '<option value="system"'.($homeThemeSettings['mode']==='system'?' selected':'').'>Follow system</option></select><button name="action" value="choose">Apply</button></form>';
    }
    echo '<p><a href="'.$base.'php/themes.php">Edit or create themes</a></p></section>';
}
