# shopping-list-website
Ever since the "Out of milk" app for android went back to using ads, even tho I paid for it to opt out of them
I decided to roll my own shopping list app

You can have recipe lists that feed off an item list, and also use a pantry list

Recipe lists will be condensed into one shopping final list for the week

Twelve additional Instant Pot recipes, each making seven servings, are available
in `recipes/ingredients/` and `recipes/steps/`. Follow
[`upgrades/INSTANT-POT-12-INSTALL.txt`](upgrades/INSTANT-POT-12-INSTALL.txt) to import
[`upgrades/import_12_instant_pot_recipes.sql`](upgrades/import_12_instant_pot_recipes.sql).
The import creates the recipe tables and missing ingredients without replacing
existing food records. New prices and nutrition stay blank until entered from labels.
Do not re-import `database_setup` over an existing database.


