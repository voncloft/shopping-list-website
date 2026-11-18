<?php
require_once __DIR__ . '/../functions/themes.php';
// Send the active MySQL palette with the HTML, before any stylesheet or script
// can delay it. The browser can paint the correct canvas immediately.
try {
    if (!isset($GLOBALS['conn'])) require_once __DIR__ . '/passwords.php';
    $themePalette = shopping_theme_palette_css($GLOBALS['conn'] ?? null);
} catch (Throwable $e) {
    error_log('Shopping theme connection unavailable; using default appearance.');
    $themePalette = ':root{' . shopping_theme_css(shopping_theme_defaults()) . '}';
}
$themePath = str_replace('\\', '/', $_SERVER['SCRIPT_NAME'] ?? '/index.php');
$themeFolder = basename(dirname($themePath));
$themeBase = in_array($themeFolder, ['php','scripts','include','chart'], true) ? '../' : '';
?>
<style id="shopping-theme-palette"><?= $themePalette ?>
html { background:var(--page-bg); color:var(--text); color-scheme:var(--color-scheme, light); }
body { background:var(--page-bg); color:var(--text); font-family:var(--font-family); font-size:var(--font-size); }
</style>
<link rel="stylesheet" href="<?= $themeBase ?>include/theme.css?v=20261118c">
<script src="<?= $themeBase ?>include/theme.js?v=20261118" defer></script>
