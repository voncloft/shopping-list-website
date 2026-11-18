<?php
function shopping_display_settings($conn) {
    $result = $conn->query('SELECT hide_covered_items FROM shopping_display_settings WHERE id=1');
    if (!$result || !($row = $result->fetch_assoc())) throw new RuntimeException('Display settings are unavailable.');
    return ['hideCovered' => (int)$row['hide_covered_items'] === 1];
}
