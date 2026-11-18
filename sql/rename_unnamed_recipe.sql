-- The latest repository dump has chicken thighs (item 185) and spicy BBQ sauce
-- (item 20) in _recipe_table. Rename it without recreating or replacing its data.
SET @old_recipe_exists = (SELECT COUNT(*) FROM information_schema.tables WHERE table_schema=DATABASE() AND table_name='_recipe_table');
SET @new_recipe_exists = (SELECT COUNT(*) FROM information_schema.tables WHERE table_schema=DATABASE() AND table_name='Spicy_BBQ_Chicken_Thighs_recipe_table');
SET @rename_recipe_sql = IF(@old_recipe_exists=1 AND @new_recipe_exists=0,
 'RENAME TABLE `_recipe_table` TO `Spicy_BBQ_Chicken_Thighs_recipe_table`', 'SELECT 1');
PREPARE rename_recipe_stmt FROM @rename_recipe_sql;
EXECUTE rename_recipe_stmt;
DEALLOCATE PREPARE rename_recipe_stmt;
SET @recipe_renamed = (SELECT COUNT(*) FROM information_schema.tables WHERE table_schema=DATABASE() AND table_name='Spicy_BBQ_Chicken_Thighs_recipe_table')=1
 AND (SELECT COUNT(*) FROM information_schema.tables WHERE table_schema=DATABASE() AND table_name='_recipe_table')=0;
START TRANSACTION;
UPDATE recipe_lists SET recipe_name='Spicy_BBQ_Chicken_Thighs_recipe_table' WHERE recipe_name='_recipe_table' AND @recipe_renamed;
UPDATE current_week_recipes SET recipes='Spicy_BBQ_Chicken_Thighs_recipe_table' WHERE recipes='_recipe_table' AND @recipe_renamed;
UPDATE final_list SET recipe_table_name='Spicy_BBQ_Chicken_Thighs_recipe_table' WHERE recipe_table_name='_recipe_table' AND @recipe_renamed;
COMMIT;
SELECT IF(@recipe_renamed,'Unnamed recipe is now Spicy BBQ Chicken Thighs.',
 'Recipe rename skipped: source missing or destination already exists alongside it. No recipe data was replaced.') AS recipe_rename_result;
