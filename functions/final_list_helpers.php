<?php
// Shared by the page and the checkbox endpoint so saved and displayed totals agree.
function final_list_rows($conn)
{
    $sql = "SELECT final_list.IFRT, MAX(final_list.checked) AS checked,
        SUM(final_list.QFRT) AS totalsum,
        SUM(COALESCE(final_list.used_servings, final_list.QFRT * items.servings)) AS total_used_servings,
        items.department, items.fiber, items.carbs, items.fat, items.protein,
        items.servings, items.calories, items.url, items.grocery_item,
        items.price, items.pantryqty
        FROM final_list INNER JOIN items ON final_list.IFRT = items.ID
        GROUP BY final_list.IFRT, items.department, items.fiber, items.carbs,
        items.fat, items.protein, items.servings, items.calories, items.url,
        items.grocery_item, items.price, items.pantryqty
        ORDER BY items.department ASC, items.grocery_item ASC";
    return $conn->query($sql)->fetch_all(MYSQLI_ASSOC);
}

function final_list_needed($row)
{
    return max(0, (float)$row['totalsum'] - max(0, (float)$row['pantryqty']));
}

function final_list_row_cents($row)
{
    return (int)round(final_list_needed($row) * max(0, (float)$row['price']) * 100);
}

function final_list_summary($rows)
{
    $subtotal = 0;
    $full = 0;
    $missing = 0;
    $checked = [];
    foreach ($rows as $row) {
        $got_it = (int)$row['checked'] === 1;
        if ($got_it) {
            $checked[] = (string)$row['IFRT'];
        }
        if (final_list_needed($row) <= 0) {
            continue;
        }
        $cents = final_list_row_cents($row);
        $full += $cents;
        if ($row['price'] === null || $row['price'] === '') {
            $missing++;
        }
        if (!$got_it) {
            $subtotal += $cents;
        }
    }
    $tax = (int)round($subtotal * 0.06);
    return [
        'subtotalCents' => $subtotal, 'taxCents' => $tax,
        'totalCents' => $subtotal + $tax,
        'fullSubtotalCents' => $full, 'fullTaxCents' => (int)round($full * 0.06),
        'fullTotalCents' => $full + (int)round($full * 0.06),
        'checkedIds' => $checked, 'missingPrices' => $missing,
    ];
}

function final_list_store_total($conn, $summary)
{
    // No thousands separator: weekly_total is also used by other pages.
    // The weekly estimate includes items picked up during the trip.
    $amount = number_format($summary['fullTotalCents'] / 100, 2, '.', '');
    $stmt = $conn->prepare('UPDATE variables SET weekly_total = ?');
    $stmt->bind_param('s', $amount);
    $stmt->execute();
    $stmt->close();
}

function final_list_portion_macros($row, $portions)
{
    $used = $row['total_used_servings'];
    $factor = is_numeric($used) && $portions > 0 ? (float)$used / $portions : null;
    $values = [];
    foreach (['calories', 'fat', 'protein', 'carbs', 'fiber'] as $field) {
        $values[$field] = $factor === null ? null : ($factor == 0 ? 0 :
            (is_numeric($row[$field]) ? round((float)$row[$field] * $factor, 2) : null));
    }
    $values['net-carbs'] = $values['carbs'] !== null && $values['fiber'] !== null
        ? round($values['carbs'] - $values['fiber'], 2) : null;
    return $values;
}

function final_list_item_url($stored, $id)
{
    $url = trim((string)$stored);
    $parts = parse_url($url);
    if (!$parts || empty($parts['host']) ||
        !in_array(strtolower($parts['scheme'] ?? ''), ['http', 'https'], true)) {
        return '';
    }
    // Keep the query string; replace old fragments with the food ID used by the add-on.
    return explode('#', $url, 2)[0] . '#id=' . (int)$id;
}

function final_list_html($value)
{
    return htmlspecialchars((string)$value, ENT_QUOTES | ENT_SUBSTITUTE, 'UTF-8');
}
