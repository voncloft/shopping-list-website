-- Shared display preference for the existing shopping_list database.
-- Safe to rerun: keeps the current choice and all shopping/recipe/theme data.
CREATE TABLE IF NOT EXISTS shopping_display_settings (
 id TINYINT UNSIGNED NOT NULL PRIMARY KEY,
 hide_covered_items TINYINT UNSIGNED NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
INSERT INTO shopping_display_settings (id,hide_covered_items)
SELECT 1,0 WHERE NOT EXISTS (SELECT 1 FROM shopping_display_settings WHERE id=1);
