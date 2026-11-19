# shopping-list-website
Ever since the "Out of milk" app for android went back to using ads, even tho I paid for it to opt out of them
I decided to roll my own shopping list app

You can have recipe lists that feed off an item list, and also use a pantry list

Recipe lists will be condensed into one shopping final list for the week


---

**Plan your meals. Use what you have. Buy what you need.**

A self-hosted grocery and meal-prep website that connects your recipes, food database, pantry, nutrition, and shopping budget. Pick the week's meals and turn their ingredients into one shopping list, with your own prices, store locations, and appearance.

**PHP + MySQL/MariaDB · Weekly meal planning · Nutrition tracking · Pantry inventory · Custom themes**

[Features](#features) · [Weekly workflow](#weekly-workflow) · [Understanding quantities](#understanding-quantities) · [Project layout](#project-layout) · [Changelog](#changelog)

## Features

### 🗓️ Build the week from your recipes

- **One combined shopping list.** Ingredients shared by multiple recipes are grouped into one item with a combined quantity and links back to the recipes that need it.
- **Reusable recipes.** Create recipes from your food database, edit ingredients before importing, or update a recipe already included in the current week.
- **Make more than one batch.** Choose a recipe amount from 1× to 10× when importing. Purchase quantities and explicitly entered nutrition servings scale with it.
- **Keep the instructions with the meal.** Save ingredient quantities, measurements, and cooking steps in separate HTML files, then view them from the recipe pages.
- **A growing recipe library.** The repository includes 39 ingredient-and-instruction pairs, including Instant Pot meals, casseroles, sides, smoothies, and more.
- **Start the next week without losing your recipes.** Remove selected recipes from the current week or clear the final list while keeping the saved recipe library and pantry.

### 🔎 Find meals that fit your plan

- Search recipe names as you type: matching recipes stay visible and the others disappear until the filters change.
- Combine minimum and maximum limits for **calories, protein, fat, carbohydrates, fiber, net carbs, and recipe price**.
- Use the same filtering tools when choosing the week's meals, browsing recipes, editing before import, and editing currently imported recipes.
- See how many recipes match and how many are selected. A selection stays checked even if a new filter hides it.
- Clear the filters to bring everything back. Invalid ranges get an explanation, and missing nutrition only excludes a recipe when that particular value is being filtered.

Nutrition filters describe one prep portion of a 1× recipe. The price filter describes the cost of the whole 1× recipe.

### 🛒 A shopping list built for the store

- **Check it off and keep moving.** “Got it” saves to the database and reduces **Still to buy**, without a distracting success message after every tap.
- **Keep the budget in view.** The estimated Bill, Tax, and Total stay at the top right of the table. Checking off purchases reduces the remaining amount without erasing the full shopping estimate.
- **Sort your trip.** Sort by item, quantity, pantry quantity, price, location, and other table headings. Pantry edits and Ignore actions retain the chosen sort.
- **Open the products together.** “Open all Walmart links” opens valid saved product links from non-grey rows, skips pantry-covered items, and supports retrying tabs blocked by the browser. Allow pop-ups for the shopping-list site when prompted.
- **Look up an item quickly.** Item names link to Walmart search; saved product URLs provide direct links and keep the item identifier used by the companion add-ons.
- **Reset checkmarks in one click.** “Clear all Got it” clears the checks without clearing the meal plan.
- **Keep the table on your phone.** The final shopping table and price panel scale together to fit a phone screen, preserving all columns and the selected theme. The desktop layout stays separate, and pinch zoom remains available.

### 🏠 Make the pantry part of the plan

- Track how much of each food you already have and subtract that stock when estimating what still needs to be purchased.
- Edit Pantry Qty directly on the final shopping page and press **Enter** to save.
- Items fully covered by the pantry turn grey and move to the bottom. They remain editable; lowering their pantry quantity restores them to the active list and the selected sort order.
- **Hide grey items across devices.** The show/hide preference is stored in the database and is picked up by other devices when the page loads or returns to focus.
- Use the full-width pantry inventory page to edit stock without having to scroll sideways to reach the quantity field.
- Keep pantry-supplied ingredients in the nutrition totals. **Ignore** instead removes an item from the imported list and therefore removes its nutrition contribution.

### 📊 See what goes into each portion

- View calories, fat, protein, carbs, fiber, and net carbs alongside the macro pie chart at the top of the final shopping list.
- Tap the large **+ / −** beside an item to show or hide its nutrition **inside that same Description cell**.
- Each item's expanded values account for the amount consumed across the imported recipes and the selected number of prep portions.
- Nutrition cards use the same macro colors as the chart, including your custom theme colors.
- Separate the amount purchased from the amount actually eaten with **Used Servings**. Explicit amounts, including zero, are respected.
- Automatic servings stay automatic on new imports and imported-recipe saves, so later changes to an item's Servings reach the shopping list when it is reloaded.

Nutrition and cost estimates use the values in your food database. The current tax calculation is a fixed **6%**. “Portions for Prep” divides the plan's nutrition totals; it does not change how many packages are required.

### 🎨 Make the entire site yours

Open **Theme Options** from the homepage to choose a preset, edit it, or save your own. Themes and the active choice are stored in MySQL, so the same saved appearance is available across devices.

Start with **Light, Dark, or Warm**, or choose one of the ten additional presets:

| Dark and colorful | More choices |
| --- | --- |
| Purple & Black | Amber |
| Black & Red | Charcoal & Teal |
| Midnight Blue | Rose |
| Forest | Coffee |
| Deep Ocean | Cream & Indigo |

- **54 editable options** cover page backgrounds, text, headings, normal and visited links, table headers, alternating rows, hover states, and pantry-covered rows.
- Customize buttons, inputs, dropdowns, checkbox accents, navigation, messages, fonts, text size, padding, borders, and corners.
- Change chart backgrounds, labels, macro colors, and the center opening to switch between a **pie and donut chart**.
- Preview changes, save a new theme, update an existing one, apply it directly, or delete a custom theme.
- **Follow system** uses the saved Light or Dark preset according to each device's preference. A fixed theme uses the same selected palette across devices.
- The saved palette is included early in the page to avoid a white flash while a dark theme loads.

### ✏️ Less repetitive editing

- Maintain item names, prices, departments or aisles, pantry stock, servings, calories, macros, and optional product URLs in one food database.
- Item and department autocomplete help you reuse existing names while adding foods.
- Item and pantry rows save individually after a short pause, when leaving a field, or when pressing Enter. Each row reports whether the change saved.
- With JavaScript disabled, individual Save buttons remain available on those editing pages.
- Required fields, non-negative numbers, valid URLs, and duplicate names are checked before saving. Item URLs may be left blank, and explicit zero values are accepted.
- Empty recipes and recipes with missing ingredients are flagged before import, helping prevent blank or unusable shopping entries.
- Friendly error messages explain failed changes without printing SQL statements into the normal page flow.

### 🦊 Keep the browser add-ons connected

The website retains the endpoints used by the companion food-import and price/aisle-editing add-ons. Saved product links carry the food's `#id=` value, so a product page can be associated with the correct database item.

The site opens product links; the companion add-ons handle their own interaction with the store pages. The website does not automatically scrape Walmart or add products to a Walmart cart.

## Weekly workflow

1. **Update your foods and pantry.** Check prices, serving information, and stock already at home.
2. **Choose the week's recipes.** Search by name, narrow the nutrition or price ranges, and choose how many batches to import.
3. **Review the final list.** Check the nutrition chart, pantry deductions, locations, and estimated total.
4. **Shop.** Open product links, sort the list, expand nutrition when needed, and mark items “Got it.”
5. **Prepare for the next week.** Update pantry stock and clear or replace the current week's imported recipes. Saved recipes remain available.

## Understanding quantities

| Field | What it means |
| --- | --- |
| **Qty** in a recipe | Number of shopping units the recipe calls for: individual items, bags, bottles, packages, or another unit defined by your item entry. |
| **Servings** on a grocery item | Number of nutrition servings in one of those shopping units. The item's calorie and macro values describe one nutrition serving. |
| **Used Servings** in a recipe | Nutrition servings actually consumed by the entire recipe. Leave it blank for automatic `Qty × item Servings`. |
| **Amount** when importing | Number of batches of that recipe to add to the week's list. |
| **Portions for Prep** | Number of portions used to divide the combined nutrition totals for display. |
| **Pantry Qty** | Shopping units already at home, used to reduce the purchase estimate without removing the food from the meal's nutrition. |

For example, if one potato is one shopping unit and one nutrition serving, **Qty 7 × Servings 1 = 7 Used Servings**. Dividing that by seven prep portions gives one potato's recorded nutrition per portion.

If a recipe uses part of a package, enter the consumed amount in **Used Servings**. That keeps the nutrition calculation separate from the cost of buying the package.

## Project layout

| Location | Purpose |
| --- | --- |
| [index.php](index.php) | Homepage links to foods, pantry, recipes, shopping, and theme options. |
| [php/](php/) | User-facing pages and editors. |
| [scripts/](scripts/) and [ajax/](ajax/) | Form processing, imports, and updates. |
| [functions/](functions/) | Shared recipe calculations, validation, pantry, themes, and list helpers. |
| [include/](include/) | Styles, scripts, navigation, theme options, and database connection support. |
| [chart/](chart/) | Plotly nutrition chart. |
| [recipes/ingredients/](recipes/ingredients/) | Saved ingredient instructions. |
| [recipes/steps/](recipes/steps/) | Saved cooking steps with matching recipe filenames. |
| [sql/](sql/) | Database upgrades for themes, shared display settings, and recipe maintenance. |
| [text_files/](text_files/) | Installation and update notes. |

The application uses **PHP with mysqli, MySQL/MariaDB, JavaScript, CSS, and Plotly**. The chart currently loads Plotly from its CDN. Database credentials belong in the local `include/passwords.config.php`, which is ignored by Git; the repository provides [a configuration template](include/passwords.config.php.default). The recipe editor needs write access to the two recipe HTML directories.

## Changelog

Reviewed through [10d2129](https://github.com/voncloft/shopping-list-website/commit/10d2129ea538fbae3fb38eaf7ca73a40e502e9d0) on **November 19, 2026**, covering the repository's **287 commits** back to May 2022. Entries below describe the actual changes behind the commit messages. Related commits are grouped; database refreshes, repeated snapshots, and file-permission-only changes are not presented as separate features. Dates use America/Indianapolis local time.

[Browse the complete commit history](https://github.com/voncloft/shopping-list-website/commits/master/).

### 2026-11-19 — Automatic servings and a full-width pantry

- Fixed automatic nutrition servings being frozen as a number during import. New imports and imported-recipe saves preserve automatic values, so later item-serving edits are reflected on reload. Explicit servings, batch amounts, and saved checkmarks remain supported. [73869e6](https://github.com/voncloft/shopping-list-website/commit/73869e6776fdeb6d6b7cd649640d312da71c2705)
- Expanded pantry inventory to the browser width, kept all four columns visible, wrapped long item names, and retained row autosave and phone-friendly quantity inputs. [cbc4321](https://github.com/voncloft/shopping-list-website/commit/cbc4321185933acb0f1c87012816def33db21344)
- Moved installation, fix, and checksum notes into `text_files/`. [10d2129](https://github.com/voncloft/shopping-list-website/commit/10d2129ea538fbae3fb38eaf7ca73a40e502e9d0)

### 2026-11-18 — Themes, recipe search, and the shopping-page overhaul

- Added database-backed themes, three base presets, ten extra presets, a custom editor, live preview, and 54 appearance options, including pie/donut styling. Added direct Apply Theme behavior and early theme colors to reduce white flashing.
- Added live recipe-name search and combined calorie, macro, and price filters to weekly selection, recipe browsing, and both recipe editing lists.
- Added nutrition expansion inside each item's Description cell, with touch-friendly controls and colors matching the chart.
- Separated the full shopping estimate from the amount still to buy; kept the estimate beside the top of the table and updated the remaining amount as purchases are checked off.
- Added Clear all Got it, preserved sorting through Ignore and pantry edits, and kept pantry-covered rows editable, grey, and at the bottom.
- Added per-row item and pantry autosave, Enter-to-save, duplicate and required-field checks, friendlier errors, and checks for empty or broken recipes.
- Consolidated shared calculations and page helpers while retaining the existing browser add-on endpoints. Added an upgrade to give the unnamed BBQ chicken recipe a usable name, and stopped tracking the private database configuration. [1337857](https://github.com/voncloft/shopping-list-website/commit/133785719a2f597b3ea5b7e32669e3bcd19911c2)
- Corrected Open all links to skip grey rows and improved direct opening and retries when Firefox blocks pop-ups. [7cfe409](https://github.com/voncloft/shopping-list-website/commit/7cfe40994e13b3e231ce375d27c780354741197b)
- Removed routine shopping-page save messages and extra hints. [cac1f88](https://github.com/voncloft/shopping-list-website/commit/cac1f88f9f578aded2487c052624cb890a8c7c4a)
- Added phone scaling for the complete final table and price panel, plus a database-backed Hide grey items preference shared across devices. [7444245](https://github.com/voncloft/shopping-list-website/commit/74442458d0ba9bd44c6f75f19a55f1c2cb9cdb21)

### 2026-11-07 to 2026-11-15 — Korean spicy pulled pork updates

- Replaced fresh ginger with ground ginger and made the mixing step explicit. [9ecea6a](https://github.com/voncloft/shopping-list-website/commit/9ecea6a17696e26de4fcf42521eaf31bc2000d5b)
- Updated the listed pork amount and added rice instructions. [da8b09c](https://github.com/voncloft/shopping-list-website/commit/da8b09cca40cf07b44d48baf4ea786a044d1498a)
- Added bell peppers to both the ingredient list and cooking step. [0acc7e4](https://github.com/voncloft/shopping-list-website/commit/0acc7e49143c48db387d1dd4d5c0423d1abf957c)

### 2026-11-05 — Recipe-selection nutrition matches the recipe

- Changed selection-page calculations to honor `used_servings`, including explicit zero, instead of always counting the entire purchased quantity. Blank values still use the automatic calculation. [e5e12c4](https://github.com/voncloft/shopping-list-website/commit/e5e12c482d2f8703f46e35f6ab5d585f2b5a474c)

### 2026-11-04 — Twelve more Instant Pot recipes

- Added Beef Birria, Buffalo Chicken Mac and Cheese, Cajun Jambalaya, Chicken Tikka Masala, Creamy Cajun Chicken, Filipino Pork Adobo, Hungarian Beef Goulash, Korean Spicy Pulled Pork, Mississippi Pot Roast, Smoky BBQ Pulled Pork, Tuscan Chicken, and White Chicken Chili, with separate ingredient and step files. [79ae02f](https://github.com/voncloft/shopping-list-website/commit/79ae02fa10365b2619f4f6507ad2c8bfd4024189)
- Followed up with Creamy Cajun Chicken ingredient and instruction corrections. [27e6f76](https://github.com/voncloft/shopping-list-website/commit/27e6f76c90c91f54eaa625b03a6c64a3e2a45093), [18aa3e9](https://github.com/voncloft/shopping-list-website/commit/18aa3e9fa22cf8c3093ef83265a7de059878b589)

### 2026-10-31 — Price/aisle updates and ingredient clarifications

- Strengthened the price-update endpoint with input checks, prepared statements, optional aisle updates, and cleaner error responses. [ca3335f](https://github.com/voncloft/shopping-list-website/commit/ca3335f8c95df87fdc511cb14962ab4a45dc1aca)
- Clarified ingredient information for Beef Stroganoff and Creamy Garlic Parmesan Chicken. [03fb9ea](https://github.com/voncloft/shopping-list-website/commit/03fb9ea745d3c6c2f33a36743123863a0e325529)

### 2026-10-25 — Seven Instant Pot meals and clearer instructions

- Added Chipotle Beef Barbacoa, Creamy Garlic Parmesan Chicken, Pork Carnitas, Beef Stroganoff, Buffalo Shredded Chicken, Pork Chile Verde, and Italian Meatballs in Marinara. [def2a74](https://github.com/voncloft/shopping-list-website/commit/def2a74e9a4f0d8c33768391aa6b413e5941f52c)
- Reworked their steps into more explicit cooking directions and included item-link saving fixes in the accompanying upgrade files. [f78f227](https://github.com/voncloft/shopping-list-website/commit/f78f2274d0dcf7fd5d19341758567ff44c1aa022)

### 2026-10-17 — Separate purchase quantities from consumed servings

- Added `used_servings` handling to recipe editing, importing, recipe display, and final-list nutrition calculations.
- Consolidated duplicate recipe references in the final shopping list and revised its rendering. [fdd41e1](https://github.com/voncloft/shopping-list-website/commit/fdd41e1572286aa44d42b3b9a1537568e4a2ed4b)

### 2026-03-20 to 2026-03-28 — Product links and browser integration

- Added product URLs to food entry and editing, and refined default sorting by department and item name. [17a5fca](https://github.com/voncloft/shopping-list-website/commit/17a5fca1d020c1cc5f2fcb0798bcfe874ed142db)
- Added the price-update endpoint and direct product links on the final shopping list. [55db652](https://github.com/voncloft/shopping-list-website/commit/55db652872c554c72c7e8bf77e9fb3266a21a5df)
- Added a JSON response mode for the food-import workflow. [fcaedc3](https://github.com/voncloft/shopping-list-website/commit/fcaedc3a2b3e05c25e44220a4b194f37daa7d9e9)
- Added Homemade Sub Buns ingredient and step files. [6336f4b](https://github.com/voncloft/shopping-list-website/commit/6336f4bfb74bb98337ad8a19e1b40ea5296d8e16)

### 2025-06-27 — Local table sorting

- Replaced the externally loaded sorting script with a repository copy that handles numeric and text columns, ascending/descending order, and direction indicators. [0f46fc9](https://github.com/voncloft/shopping-list-website/commit/0f46fc9e6a79f9a0fa394ddb928471bc390ef827)

### 2024-12-05 — Portable navigation links

- Replaced hard-coded website addresses in the toolbar and final-list recipe links with relative paths. [ae0ae64](https://github.com/voncloft/shopping-list-website/commit/ae0ae64f8f3dfe8e00de689418fe953d9ada05e6)

### 2024-04-06 — Texas Chili

- Added Texas Chili ingredient and cooking-step files. [c727235](https://github.com/voncloft/shopping-list-website/commit/c727235fb503398a3da1cbf9a502f92d854c3f8b)

### 2023-03 to 2023-12 — More meal-planning controls and recipes

- Added a saved Portions for Prep control and made the charts divide nutrition by that selected value instead of a fixed seven. [827ad5b](https://github.com/voncloft/shopping-list-website/commit/827ad5be01bd6dfc70ba71abd42fd3ad7a6e6943)
- Added recipe price and nutrition summaries to the selection pages. [e048702](https://github.com/voncloft/shopping-list-website/commit/e048702dfcc48c27aab06b24fe85a31d31becf8f)
- Added recipe amount multipliers when importing the week's meals and summaries for currently imported recipes. [359c01d](https://github.com/voncloft/shopping-list-website/commit/359c01dee27b75883e747e45418b2df5d30a9477), [bd9156d](https://github.com/voncloft/shopping-list-website/commit/bd9156d637af22fae6e0e67ef27509a0a14dd90a)
- Expanded the instruction library with Keto Pretzel Bites, Stuffed Chicken Breast, Ham Casserole Sub, Lasagna, Spare Ribs, and Deepdish Pizza over the year. [25e96bd](https://github.com/voncloft/shopping-list-website/commit/25e96bd62739dbfc0107eb25b64dda2cb6c2a22f), [6ab50e8](https://github.com/voncloft/shopping-list-website/commit/6ab50e8f1d4f04e11cfdf17cfcce03d9fbb7c08d), [cacc915](https://github.com/voncloft/shopping-list-website/commit/cacc915e45ddbd062ec808963ca89243b5d254f5), [eaf9826](https://github.com/voncloft/shopping-list-website/commit/eaf98263d51ba6ef8d5bc5b6c38f17db9c5cc3b3), [f8a4515](https://github.com/voncloft/shopping-list-website/commit/f8a4515372a64ab7cbfb406f33d9a28de495d7c5)

### 2023-01 — Nutrition, saved checkmarks, and cooking instructions

- Linked shopping-list recipe names directly to their recipe details. [8446a91](https://github.com/voncloft/shopping-list-website/commit/8446a91c1b173f74676f28de333a5e917da6bd9f)
- Added database persistence for Got it, inline pantry updates, and Ignore actions. [a50a371](https://github.com/voncloft/shopping-list-website/commit/a50a3710938a5b5566009422203fa97653e2f1b0), [3a75ca8](https://github.com/voncloft/shopping-list-website/commit/3a75ca83237ce4b0028eb5ccd4b1d655bb9152e9), [2f9f062](https://github.com/voncloft/shopping-list-website/commit/2f9f0624c16c7a0f937f4f5a07a90f0f98c983ea)
- Added nutrition tracking and the macro pie chart. [b8bcdad](https://github.com/voncloft/shopping-list-website/commit/b8bcdad5b1d80b642bda3832546abed78dd98997)
- Implemented separate ingredient and step HTML files and instruction saving with automatic line breaks. [14b1277](https://github.com/voncloft/shopping-list-website/commit/14b1277800df243f28db232243e2692593106b12), [f364ed9](https://github.com/voncloft/shopping-list-website/commit/f364ed958583752dbe094643e5b52e35b52672eb)
- Introduced shared page helpers and the `get_interface()` switcher for reusing recipe, pantry, and editing views. [709b665](https://github.com/voncloft/shopping-list-website/commit/709b665750383525336d162fe12715a62ea92cb8)

### 2022-07 — Pantry awareness and shared navigation

- Added pantry inventory, quantities already at home, and purchase-cost deductions for pantry stock. [5c94544](https://github.com/voncloft/shopping-list-website/commit/5c94544a23a581de3883746c6178fd970d653b26)
- Added shared dropdown navigation across the website. [492cd27](https://github.com/voncloft/shopping-list-website/commit/492cd27b91489c4d680ca5c8a15cb4162fd0af92)

### 2022-05 — The original shopping-list website

- Started the PHP/MySQL application with a food database, recipe creation and editing, weekly recipe selection, combined shopping quantities, and a bill/tax/total estimate. [ef1718a](https://github.com/voncloft/shopping-list-website/commit/ef1718a976d53ec18fc3e2827e1317ddec88c0b6)
- Expanded recipe browsing and removal from the current week's list during the initial development period. [26f02b3](https://github.com/voncloft/shopping-list-website/commit/26f02b329a3b22b75b5812174d5b331a0c5e31da), [f78409c](https://github.com/voncloft/shopping-list-website/commit/f78409ca35f169e9c3c3c6905e747806581e77b4)
- Added item and department autocomplete. [ae013e9](https://github.com/voncloft/shopping-list-website/commit/ae013e90b789f962d00dcace296358273fca8122)
