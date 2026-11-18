<?php
// Compatibility for old cached pages; new pages include their palette directly.
require_once __DIR__ . '/../functions/themes.php';
header('Content-Type: text/css; charset=utf-8');
header('Cache-Control: no-store');
try {
    require_once __DIR__ . '/passwords.php';
    echo shopping_theme_palette_css($conn);
} catch (Throwable $e) {
    error_log('Shopping theme connection unavailable; using default appearance.');
    echo ':root{' . shopping_theme_css(shopping_theme_defaults()) . '}';
}
