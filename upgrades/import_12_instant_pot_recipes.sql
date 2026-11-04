-- Twelve seven-serving Instant Pot recipes for voncloft/shopping-list-website.
-- Prepared against commit 03fb9ea745d3c6c2f33a36743123863a0e325529.
-- Creates recipe tables, adds missing foods and recipe_lists entries, then ingredients.
-- Existing food labels, prices, URLs, recipe rows and weekly selections are preserved.
-- Run once at a time, in one connection, without --force. Safe to rerun serially.
-- DDL auto-commits in MariaDB/MySQL; the data transaction starts after table creation.
-- New ingredient prices and nutrition are NULL (unknown), not estimated zeros.
-- See INSTANT-POT-12-INSTALL.txt for serving units and installation instructions.
USE `shopping_list`;
SET NAMES utf8mb4;


CREATE TABLE IF NOT EXISTS `Creamy_Cajun_Chicken_recipe_table` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `qty` int(11) NOT NULL,
  `used_servings` decimal(10,3) DEFAULT NULL,
  `ingredient_name` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `Tuscan_Chicken_recipe_table` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `qty` int(11) NOT NULL,
  `used_servings` decimal(10,3) DEFAULT NULL,
  `ingredient_name` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `Buffalo_Chicken_Mac_and_Cheese_recipe_table` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `qty` int(11) NOT NULL,
  `used_servings` decimal(10,3) DEFAULT NULL,
  `ingredient_name` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `Mississippi_Pot_Roast_recipe_table` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `qty` int(11) NOT NULL,
  `used_servings` decimal(10,3) DEFAULT NULL,
  `ingredient_name` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `Beef_Birria_recipe_table` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `qty` int(11) NOT NULL,
  `used_servings` decimal(10,3) DEFAULT NULL,
  `ingredient_name` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `Hungarian_Beef_Goulash_recipe_table` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `qty` int(11) NOT NULL,
  `used_servings` decimal(10,3) DEFAULT NULL,
  `ingredient_name` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `Korean_Spicy_Pulled_Pork_recipe_table` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `qty` int(11) NOT NULL,
  `used_servings` decimal(10,3) DEFAULT NULL,
  `ingredient_name` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `Filipino_Pork_Adobo_recipe_table` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `qty` int(11) NOT NULL,
  `used_servings` decimal(10,3) DEFAULT NULL,
  `ingredient_name` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `Smoky_BBQ_Pulled_Pork_recipe_table` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `qty` int(11) NOT NULL,
  `used_servings` decimal(10,3) DEFAULT NULL,
  `ingredient_name` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `Chicken_Tikka_Masala_recipe_table` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `qty` int(11) NOT NULL,
  `used_servings` decimal(10,3) DEFAULT NULL,
  `ingredient_name` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `White_Chicken_Chili_recipe_table` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `qty` int(11) NOT NULL,
  `used_servings` decimal(10,3) DEFAULT NULL,
  `ingredient_name` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `Cajun_Jambalaya_recipe_table` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `qty` int(11) NOT NULL,
  `used_servings` decimal(10,3) DEFAULT NULL,
  `ingredient_name` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

START TRANSACTION;

-- ancho: one nutrition serving = 1 dried pepper.
-- Buy: 1 bag containing at least 2 dried ancho peppers.
INSERT INTO `items` (`grocery_item`, `price`, `department`, `pantryqty`, `servings`, `protein`, `fat`, `carbs`, `calories`, `fiber`, `url`)
SELECT 'Dried Ancho Peppers', NULL, 'Spices', '0', 1, NULL, NULL, NULL, NULL, NULL, ''
WHERE NOT EXISTS (SELECT 1 FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Dried Ancho Peppers'));

-- andouille: one nutrition serving = 2 oz.
-- Buy: Qty counts 12 oz packages; two packages supply the required 16 oz.
INSERT INTO `items` (`grocery_item`, `price`, `department`, `pantryqty`, `servings`, `protein`, `fat`, `carbs`, `calories`, `fiber`, `url`)
SELECT 'Fully Cooked Andouille Sausage 12 oz', NULL, 'Meat', '0', 1, NULL, NULL, NULL, NULL, NULL, ''
WHERE NOT EXISTS (SELECT 1 FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Fully Cooked Andouille Sausage 12 oz'));

-- au_jus: one nutrition serving = 1 whole 1 oz packet.
-- Buy: 1 packet.
INSERT INTO `items` (`grocery_item`, `price`, `department`, `pantryqty`, `servings`, `protein`, `fat`, `carbs`, `calories`, `fiber`, `url`)
SELECT 'Au Jus Gravy Mix 1 oz', NULL, 'Cooking', '0', 1, NULL, NULL, NULL, NULL, NULL, ''
WHERE NOT EXISTS (SELECT 1 FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Au Jus Gravy Mix 1 oz'));

-- bay: one nutrition serving = 1 leaf.
-- Buy: 1 jar.
INSERT INTO `items` (`grocery_item`, `price`, `department`, `pantryqty`, `servings`, `protein`, `fat`, `carbs`, `calories`, `fiber`, `url`)
SELECT 'Bay Leaves', NULL, 'Cooking', '0', 1, NULL, NULL, NULL, NULL, NULL, ''
WHERE NOT EXISTS (SELECT 1 FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Bay Leaves'));

-- bbq: one nutrition serving = 2 tablespoons.
-- Buy: 1 bottle containing at least 1 1/2 cups.
INSERT INTO `items` (`grocery_item`, `price`, `department`, `pantryqty`, `servings`, `protein`, `fat`, `carbs`, `calories`, `fiber`, `url`)
SELECT 'Smoky Barbecue Sauce', NULL, 'Condiments', '0', 1, NULL, NULL, NULL, NULL, NULL, ''
WHERE NOT EXISTS (SELECT 1 FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Smoky Barbecue Sauce'));

-- beans: one nutrition serving = 1/2 cup drained; 3 servings per drained can.
-- Buy: Qty counts 15 oz cans.
INSERT INTO `items` (`grocery_item`, `price`, `department`, `pantryqty`, `servings`, `protein`, `fat`, `carbs`, `calories`, `fiber`, `url`)
SELECT 'Cannellini Beans 15 oz', NULL, 'Canned Goods', '0', 1, NULL, NULL, NULL, NULL, NULL, ''
WHERE NOT EXISTS (SELECT 1 FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Cannellini Beans 15 oz'));

-- beef: one nutrition serving = 4 oz raw boneless meat.
-- Buy: Enough roast for the listed trimmed raw weight.
INSERT INTO `items` (`grocery_item`, `price`, `department`, `pantryqty`, `servings`, `protein`, `fat`, `carbs`, `calories`, `fiber`, `url`)
SELECT 'Boneless Beef Chuck Roast', NULL, 'Cooking', '0', 1, NULL, NULL, NULL, NULL, NULL, ''
WHERE NOT EXISTS (SELECT 1 FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Boneless Beef Chuck Roast'));

-- beef_broth: one nutrition serving = 1 cup.
-- Buy: 1 carton containing 32 fl oz; choose low sodium.
INSERT INTO `items` (`grocery_item`, `price`, `department`, `pantryqty`, `servings`, `protein`, `fat`, `carbs`, `calories`, `fiber`, `url`)
SELECT 'Beef Broth', NULL, 'Cooking', '0', 1, NULL, NULL, NULL, NULL, NULL, ''
WHERE NOT EXISTS (SELECT 1 FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Beef Broth'));

-- bell: one nutrition serving = 1 medium pepper.
-- Buy: Qty counts whole medium bell peppers.
INSERT INTO `items` (`grocery_item`, `price`, `department`, `pantryqty`, `servings`, `protein`, `fat`, `carbs`, `calories`, `fiber`, `url`)
SELECT 'Bell Pepper', NULL, 'Cooking', '0', 1, NULL, NULL, NULL, NULL, NULL, ''
WHERE NOT EXISTS (SELECT 1 FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Bell Pepper'));

-- brown_sugar: one nutrition serving = 2 teaspoons packed.
-- Buy: 1 bag regular brown sugar.
INSERT INTO `items` (`grocery_item`, `price`, `department`, `pantryqty`, `servings`, `protein`, `fat`, `carbs`, `calories`, `fiber`, `url`)
SELECT 'Brown Sugar', NULL, 'Cooking', '0', 1, NULL, NULL, NULL, NULL, NULL, ''
WHERE NOT EXISTS (SELECT 1 FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Brown Sugar'));

-- butter: one nutrition serving = 1 tablespoon.
-- Buy: 1 four-stick package; use unsalted.
INSERT INTO `items` (`grocery_item`, `price`, `department`, `pantryqty`, `servings`, `protein`, `fat`, `carbs`, `calories`, `fiber`, `url`)
SELECT 'Butter 4 pack', NULL, 'Cooking', '0', 1, NULL, NULL, NULL, NULL, NULL, ''
WHERE NOT EXISTS (SELECT 1 FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Butter 4 pack'));

-- cajun: one nutrition serving = 1 teaspoon; verify your seasoning label.
-- Buy: 1 jar; use a low-salt Cajun blend.
INSERT INTO `items` (`grocery_item`, `price`, `department`, `pantryqty`, `servings`, `protein`, `fat`, `carbs`, `calories`, `fiber`, `url`)
SELECT 'Cajun Spice', NULL, 'Cooking', '0', 1, NULL, NULL, NULL, NULL, NULL, ''
WHERE NOT EXISTS (SELECT 1 FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Cajun Spice'));

-- caraway: one nutrition serving = 1 teaspoon.
-- Buy: 1 jar.
INSERT INTO `items` (`grocery_item`, `price`, `department`, `pantryqty`, `servings`, `protein`, `fat`, `carbs`, `calories`, `fiber`, `url`)
SELECT 'Caraway Seeds', NULL, 'Spices', '0', 1, NULL, NULL, NULL, NULL, NULL, ''
WHERE NOT EXISTS (SELECT 1 FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Caraway Seeds'));

-- celery: one nutrition serving = 2 medium stalks; verify label.
-- Buy: 1 bunch containing at least 3 stalks.
INSERT INTO `items` (`grocery_item`, `price`, `department`, `pantryqty`, `servings`, `protein`, `fat`, `carbs`, `calories`, `fiber`, `url`)
SELECT 'Celery', NULL, 'Cooking', '0', 1, NULL, NULL, NULL, NULL, NULL, ''
WHERE NOT EXISTS (SELECT 1 FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Celery'));

-- cheddar: one nutrition serving = 1 oz.
-- Buy: Qty counts 8 oz blocks; two blocks for 16 oz.
INSERT INTO `items` (`grocery_item`, `price`, `department`, `pantryqty`, `servings`, `protein`, `fat`, `carbs`, `calories`, `fiber`, `url`)
SELECT 'Cheddar Cheese block', NULL, 'Cooking', '0', 1, NULL, NULL, NULL, NULL, NULL, ''
WHERE NOT EXISTS (SELECT 1 FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Cheddar Cheese block'));

-- chicken: one nutrition serving = 4 oz raw boneless skinless meat.
-- Buy: Enough packages for the listed raw weight.
INSERT INTO `items` (`grocery_item`, `price`, `department`, `pantryqty`, `servings`, `protein`, `fat`, `carbs`, `calories`, `fiber`, `url`)
SELECT 'Boneless Skinless Chicken Thighs', NULL, 'Cooking', '0', 1, NULL, NULL, NULL, NULL, NULL, ''
WHERE NOT EXISTS (SELECT 1 FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Boneless Skinless Chicken Thighs'));

-- chicken_broth: one nutrition serving = 1 cup.
-- Buy: 1 carton containing 32 fl oz; choose low sodium.
INSERT INTO `items` (`grocery_item`, `price`, `department`, `pantryqty`, `servings`, `protein`, `fat`, `carbs`, `calories`, `fiber`, `url`)
SELECT 'Chicken broth', NULL, 'Cooking', '0', 1, NULL, NULL, NULL, NULL, NULL, ''
WHERE NOT EXISTS (SELECT 1 FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Chicken broth'));

-- chiles: one nutrition serving = 2 tablespoons, about 1 oz.
-- Buy: Qty counts 4 oz cans.
INSERT INTO `items` (`grocery_item`, `price`, `department`, `pantryqty`, `servings`, `protein`, `fat`, `carbs`, `calories`, `fiber`, `url`)
SELECT 'Diced Roasted Green Chiles 4 oz', NULL, 'Cooking', '0', 1, NULL, NULL, NULL, NULL, NULL, ''
WHERE NOT EXISTS (SELECT 1 FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Diced Roasted Green Chiles 4 oz'));

-- cilantro: one nutrition serving = 1 tablespoon chopped.
-- Buy: 1 bunch.
INSERT INTO `items` (`grocery_item`, `price`, `department`, `pantryqty`, `servings`, `protein`, `fat`, `carbs`, `calories`, `fiber`, `url`)
SELECT 'Cilantro', NULL, 'Cooking', '0', 1, NULL, NULL, NULL, NULL, NULL, ''
WHERE NOT EXISTS (SELECT 1 FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Cilantro'));

-- cinnamon: one nutrition serving = 1 stick.
-- Buy: 1 jar.
INSERT INTO `items` (`grocery_item`, `price`, `department`, `pantryqty`, `servings`, `protein`, `fat`, `carbs`, `calories`, `fiber`, `url`)
SELECT 'Cinnamon Sticks', NULL, 'Cooking', '0', 1, NULL, NULL, NULL, NULL, NULL, ''
WHERE NOT EXISTS (SELECT 1 FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Cinnamon Sticks'));

-- cloves: one nutrition serving = 1/4 teaspoon ground.
-- Buy: 1 jar.
INSERT INTO `items` (`grocery_item`, `price`, `department`, `pantryqty`, `servings`, `protein`, `fat`, `carbs`, `calories`, `fiber`, `url`)
SELECT 'Ground Cloves', NULL, 'Spices', '0', 1, NULL, NULL, NULL, NULL, NULL, ''
WHERE NOT EXISTS (SELECT 1 FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Ground Cloves'));

-- corn: one nutrition serving = 1/2 cup.
-- Buy: 1 frozen bag containing at least 2 cups.
INSERT INTO `items` (`grocery_item`, `price`, `department`, `pantryqty`, `servings`, `protein`, `fat`, `carbs`, `calories`, `fiber`, `url`)
SELECT 'frozen corn', NULL, 'Cooking', '0', 1, NULL, NULL, NULL, NULL, NULL, ''
WHERE NOT EXISTS (SELECT 1 FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('frozen corn'));

-- cornstarch: one nutrition serving = 1 tablespoon.
-- Buy: 1 container.
INSERT INTO `items` (`grocery_item`, `price`, `department`, `pantryqty`, `servings`, `protein`, `fat`, `carbs`, `calories`, `fiber`, `url`)
SELECT 'Cornstarch 16 oz', NULL, 'Cooking', '0', 1, NULL, NULL, NULL, NULL, NULL, ''
WHERE NOT EXISTS (SELECT 1 FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Cornstarch 16 oz'));

-- cream: one nutrition serving = 1 tablespoon.
-- Buy: 1 pint heavy cream.
INSERT INTO `items` (`grocery_item`, `price`, `department`, `pantryqty`, `servings`, `protein`, `fat`, `carbs`, `calories`, `fiber`, `url`)
SELECT 'Heavy Cream', NULL, 'Cooking', '0', 1, NULL, NULL, NULL, NULL, NULL, ''
WHERE NOT EXISTS (SELECT 1 FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Heavy Cream'));

-- cream_cheese: one nutrition serving = 1 oz.
-- Buy: 1 full-fat 8 oz block.
INSERT INTO `items` (`grocery_item`, `price`, `department`, `pantryqty`, `servings`, `protein`, `fat`, `carbs`, `calories`, `fiber`, `url`)
SELECT 'Cream cheese 1 pack', NULL, 'Cooking', '0', 1, NULL, NULL, NULL, NULL, NULL, ''
WHERE NOT EXISTS (SELECT 1 FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Cream cheese 1 pack'));

-- cumin: one nutrition serving = 1 teaspoon.
-- Buy: 1 jar.
INSERT INTO `items` (`grocery_item`, `price`, `department`, `pantryqty`, `servings`, `protein`, `fat`, `carbs`, `calories`, `fiber`, `url`)
SELECT 'Ground Cumin', NULL, 'Cooking', '0', 1, NULL, NULL, NULL, NULL, NULL, ''
WHERE NOT EXISTS (SELECT 1 FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Ground Cumin'));

-- garam: one nutrition serving = 1 teaspoon.
-- Buy: 1 jar.
INSERT INTO `items` (`grocery_item`, `price`, `department`, `pantryqty`, `servings`, `protein`, `fat`, `carbs`, `calories`, `fiber`, `url`)
SELECT 'Garam Masala', NULL, 'Spices', '0', 1, NULL, NULL, NULL, NULL, NULL, ''
WHERE NOT EXISTS (SELECT 1 FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Garam Masala'));

-- garlic: one nutrition serving = 1 clove.
-- Buy: Qty counts individual cloves; buy enough bulbs or frozen cloves.
INSERT INTO `items` (`grocery_item`, `price`, `department`, `pantryqty`, `servings`, `protein`, `fat`, `carbs`, `calories`, `fiber`, `url`)
SELECT 'Garlic Clove', NULL, 'Cooking', '0', 1, NULL, NULL, NULL, NULL, NULL, ''
WHERE NOT EXISTS (SELECT 1 FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Garlic Clove'));

-- garlic_powder: one nutrition serving = 1 teaspoon.
-- Buy: 1 jar.
INSERT INTO `items` (`grocery_item`, `price`, `department`, `pantryqty`, `servings`, `protein`, `fat`, `carbs`, `calories`, `fiber`, `url`)
SELECT 'Garlic Powder', NULL, 'Cooking', '0', 1, NULL, NULL, NULL, NULL, NULL, ''
WHERE NOT EXISTS (SELECT 1 FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Garlic Powder'));

-- ginger: one nutrition serving = 1 tablespoon finely chopped.
-- Buy: 1 piece of fresh ginger yielding at least 2 tablespoons peeled and chopped.
INSERT INTO `items` (`grocery_item`, `price`, `department`, `pantryqty`, `servings`, `protein`, `fat`, `carbs`, `calories`, `fiber`, `url`)
SELECT 'Fresh Ginger Root', NULL, 'Produce', '0', 1, NULL, NULL, NULL, NULL, NULL, ''
WHERE NOT EXISTS (SELECT 1 FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Fresh Ginger Root'));

-- gochujang: one nutrition serving = 1 tablespoon.
-- Buy: 1 tub containing at least 1/3 cup.
INSERT INTO `items` (`grocery_item`, `price`, `department`, `pantryqty`, `servings`, `protein`, `fat`, `carbs`, `calories`, `fiber`, `url`)
SELECT 'Gochujang Korean Chili Paste', NULL, 'Condiments', '0', 1, NULL, NULL, NULL, NULL, NULL, ''
WHERE NOT EXISTS (SELECT 1 FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Gochujang Korean Chili Paste'));

-- guajillo: one nutrition serving = 1 dried pepper.
-- Buy: 1 bag containing at least 6 dried guajillo peppers.
INSERT INTO `items` (`grocery_item`, `price`, `department`, `pantryqty`, `servings`, `protein`, `fat`, `carbs`, `calories`, `fiber`, `url`)
SELECT 'Dried Guajillo Peppers', NULL, 'Spices', '0', 1, NULL, NULL, NULL, NULL, NULL, ''
WHERE NOT EXISTS (SELECT 1 FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Dried Guajillo Peppers'));

-- hot: one nutrition serving = 1 teaspoon.
-- Buy: 1 bottle containing at least 4 fl oz plain cayenne hot sauce.
INSERT INTO `items` (`grocery_item`, `price`, `department`, `pantryqty`, `servings`, `protein`, `fat`, `carbs`, `calories`, `fiber`, `url`)
SELECT 'Franks Hot Sauce', NULL, 'Cooking', '0', 1, NULL, NULL, NULL, NULL, NULL, ''
WHERE NOT EXISTS (SELECT 1 FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Franks Hot Sauce'));

-- italian: one nutrition serving = 1 teaspoon.
-- Buy: 1 jar.
INSERT INTO `items` (`grocery_item`, `price`, `department`, `pantryqty`, `servings`, `protein`, `fat`, `carbs`, `calories`, `fiber`, `url`)
SELECT 'Italan Seasoning', NULL, 'Cooking', '0', 1, NULL, NULL, NULL, NULL, NULL, ''
WHERE NOT EXISTS (SELECT 1 FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Italan Seasoning'));

-- lemon: one nutrition serving = 1 tablespoon.
-- Buy: 1 bottle lemon juice.
INSERT INTO `items` (`grocery_item`, `price`, `department`, `pantryqty`, `servings`, `protein`, `fat`, `carbs`, `calories`, `fiber`, `url`)
SELECT 'Lemon Juice', NULL, 'Cooking', '0', 1, NULL, NULL, NULL, NULL, NULL, ''
WHERE NOT EXISTS (SELECT 1 FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Lemon Juice'));

-- lime: one nutrition serving = 1 tablespoon.
-- Buy: 1 bottle lime juice.
INSERT INTO `items` (`grocery_item`, `price`, `department`, `pantryqty`, `servings`, `protein`, `fat`, `carbs`, `calories`, `fiber`, `url`)
SELECT 'Lime Juice', NULL, 'Cooking', '0', 1, NULL, NULL, NULL, NULL, NULL, ''
WHERE NOT EXISTS (SELECT 1 FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Lime Juice'));

-- macaroni: one nutrition serving = 2 oz dry.
-- Buy: 1 box containing 16 oz dry elbow macaroni.
INSERT INTO `items` (`grocery_item`, `price`, `department`, `pantryqty`, `servings`, `protein`, `fat`, `carbs`, `calories`, `fiber`, `url`)
SELECT 'Elbow Macaroni 16 oz', NULL, 'Pasta', '0', 1, NULL, NULL, NULL, NULL, NULL, ''
WHERE NOT EXISTS (SELECT 1 FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Elbow Macaroni 16 oz'));

-- milk: one nutrition serving = 1 cup.
-- Buy: 1 container of whole milk.
INSERT INTO `items` (`grocery_item`, `price`, `department`, `pantryqty`, `servings`, `protein`, `fat`, `carbs`, `calories`, `fiber`, `url`)
SELECT 'Milk', NULL, 'Cooking', '0', 1, NULL, NULL, NULL, NULL, NULL, ''
WHERE NOT EXISTS (SELECT 1 FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Milk'));

-- oil: one nutrition serving = 1 tablespoon.
-- Buy: 1 bottle.
INSERT INTO `items` (`grocery_item`, `price`, `department`, `pantryqty`, `servings`, `protein`, `fat`, `carbs`, `calories`, `fiber`, `url`)
SELECT 'Olive Oil', NULL, 'Cooking', '0', 1, NULL, NULL, NULL, NULL, NULL, ''
WHERE NOT EXISTS (SELECT 1 FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Olive Oil'));

-- onion: one nutrition serving = 2/3 cup frozen chopped onion.
-- Buy: 1 bag containing at least 1 cup; 2 bags for 2 cups.
INSERT INTO `items` (`grocery_item`, `price`, `department`, `pantryqty`, `servings`, `protein`, `fat`, `carbs`, `calories`, `fiber`, `url`)
SELECT 'Frozen Onion', NULL, 'Cooking', '0', 1, NULL, NULL, NULL, NULL, NULL, ''
WHERE NOT EXISTS (SELECT 1 FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Frozen Onion'));

-- onion_powder: one nutrition serving = 1 teaspoon.
-- Buy: 1 jar.
INSERT INTO `items` (`grocery_item`, `price`, `department`, `pantryqty`, `servings`, `protein`, `fat`, `carbs`, `calories`, `fiber`, `url`)
SELECT 'Onion Powder', NULL, 'Cooking', '0', 1, NULL, NULL, NULL, NULL, NULL, ''
WHERE NOT EXISTS (SELECT 1 FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Onion Powder'));

-- oregano: one nutrition serving = 1 teaspoon.
-- Buy: 1 jar dried oregano.
INSERT INTO `items` (`grocery_item`, `price`, `department`, `pantryqty`, `servings`, `protein`, `fat`, `carbs`, `calories`, `fiber`, `url`)
SELECT 'Oregeno', NULL, 'Cooking', '0', 1, NULL, NULL, NULL, NULL, NULL, ''
WHERE NOT EXISTS (SELECT 1 FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Oregeno'));

-- paprika: one nutrition serving = 1 teaspoon.
-- Buy: 1 jar sweet Hungarian paprika, not hot paprika.
INSERT INTO `items` (`grocery_item`, `price`, `department`, `pantryqty`, `servings`, `protein`, `fat`, `carbs`, `calories`, `fiber`, `url`)
SELECT 'Paprika', NULL, 'Cooking', '0', 1, NULL, NULL, NULL, NULL, NULL, ''
WHERE NOT EXISTS (SELECT 1 FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Paprika'));

-- parmesan: one nutrition serving = 5 grams.
-- Buy: 1 container of at least 4 oz.
INSERT INTO `items` (`grocery_item`, `price`, `department`, `pantryqty`, `servings`, `protein`, `fat`, `carbs`, `calories`, `fiber`, `url`)
SELECT 'Parmesan', NULL, 'Cooking', '0', 1, NULL, NULL, NULL, NULL, NULL, ''
WHERE NOT EXISTS (SELECT 1 FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Parmesan'));

-- pepper: one nutrition serving = 1/4 teaspoon.
-- Buy: 1 container.
INSERT INTO `items` (`grocery_item`, `price`, `department`, `pantryqty`, `servings`, `protein`, `fat`, `carbs`, `calories`, `fiber`, `url`)
SELECT 'Black pepper', NULL, 'Cooking', '0', 1, NULL, NULL, NULL, NULL, NULL, ''
WHERE NOT EXISTS (SELECT 1 FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Black pepper'));

-- pepperoncini: one nutrition serving = 1 oz drained peppers; verify jar label.
-- Buy: 1 jar with at least 4 oz drained pepperoncini plus 1/4 cup brine.
INSERT INTO `items` (`grocery_item`, `price`, `department`, `pantryqty`, `servings`, `protein`, `fat`, `carbs`, `calories`, `fiber`, `url`)
SELECT 'Pepperchini', NULL, 'Cooking', '0', 1, NULL, NULL, NULL, NULL, NULL, ''
WHERE NOT EXISTS (SELECT 1 FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Pepperchini'));

-- pork: one nutrition serving = 4 oz raw boneless meat; verify the older item label uses this basis.
-- Buy: Enough shoulder for the listed boneless trimmed raw weight.
INSERT INTO `items` (`grocery_item`, `price`, `department`, `pantryqty`, `servings`, `protein`, `fat`, `carbs`, `calories`, `fiber`, `url`)
SELECT 'Pork shoulder', NULL, 'Cooking', '0', 1, NULL, NULL, NULL, NULL, NULL, ''
WHERE NOT EXISTS (SELECT 1 FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Pork shoulder'));

-- ranch: one nutrition serving = 1/4 teaspoon dry mix; verify packet label.
-- Buy: 1 oz packet.
INSERT INTO `items` (`grocery_item`, `price`, `department`, `pantryqty`, `servings`, `protein`, `fat`, `carbs`, `calories`, `fiber`, `url`)
SELECT 'Ranch seasoning mix', NULL, 'Cooking', '0', 1, NULL, NULL, NULL, NULL, NULL, ''
WHERE NOT EXISTS (SELECT 1 FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Ranch seasoning mix'));

-- rice: one nutrition serving = 1/4 cup dry.
-- Buy: 1 bag containing at least 2 cups dry long-grain white rice.
INSERT INTO `items` (`grocery_item`, `price`, `department`, `pantryqty`, `servings`, `protein`, `fat`, `carbs`, `calories`, `fiber`, `url`)
SELECT 'Long Grain Rice', NULL, 'Cooking', '0', 1, NULL, NULL, NULL, NULL, NULL, ''
WHERE NOT EXISTS (SELECT 1 FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Long Grain Rice'));

-- salt: one nutrition serving = 1 teaspoon.
-- Buy: 1 container.
INSERT INTO `items` (`grocery_item`, `price`, `department`, `pantryqty`, `servings`, `protein`, `fat`, `carbs`, `calories`, `fiber`, `url`)
SELECT 'Salt', NULL, 'Cooking', '0', 1, NULL, NULL, NULL, NULL, NULL, ''
WHERE NOT EXISTS (SELECT 1 FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Salt'));

-- sesame: one nutrition serving = 1 tablespoon.
-- Buy: 1 bottle.
INSERT INTO `items` (`grocery_item`, `price`, `department`, `pantryqty`, `servings`, `protein`, `fat`, `carbs`, `calories`, `fiber`, `url`)
SELECT 'Toasted Sesame Oil', NULL, 'Cooking', '0', 1, NULL, NULL, NULL, NULL, NULL, ''
WHERE NOT EXISTS (SELECT 1 FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Toasted Sesame Oil'));

-- smoked: one nutrition serving = 1 teaspoon.
-- Buy: 1 jar smoked paprika.
INSERT INTO `items` (`grocery_item`, `price`, `department`, `pantryqty`, `servings`, `protein`, `fat`, `carbs`, `calories`, `fiber`, `url`)
SELECT 'Smoked Paprika', NULL, 'Cooking', '0', 1, NULL, NULL, NULL, NULL, NULL, ''
WHERE NOT EXISTS (SELECT 1 FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Smoked Paprika'));

-- sour_cream: one nutrition serving = 2 tablespoons.
-- Buy: 1 tub containing at least 8 oz.
INSERT INTO `items` (`grocery_item`, `price`, `department`, `pantryqty`, `servings`, `protein`, `fat`, `carbs`, `calories`, `fiber`, `url`)
SELECT 'Sour Cream', NULL, 'Cooking', '0', 1, NULL, NULL, NULL, NULL, NULL, ''
WHERE NOT EXISTS (SELECT 1 FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Sour Cream'));

-- soy: one nutrition serving = 1 tablespoon.
-- Buy: 1 bottle low-sodium soy sauce.
INSERT INTO `items` (`grocery_item`, `price`, `department`, `pantryqty`, `servings`, `protein`, `fat`, `carbs`, `calories`, `fiber`, `url`)
SELECT 'Soy sauce', NULL, 'Cooking', '0', 1, NULL, NULL, NULL, NULL, NULL, ''
WHERE NOT EXISTS (SELECT 1 FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Soy sauce'));

-- spinach: one nutrition serving = 100 grams.
-- Buy: 1 bag containing 5 oz.
INSERT INTO `items` (`grocery_item`, `price`, `department`, `pantryqty`, `servings`, `protein`, `fat`, `carbs`, `calories`, `fiber`, `url`)
SELECT 'Fresh Baby Spinach 5 oz', NULL, 'Cooking', '0', 1, NULL, NULL, NULL, NULL, NULL, ''
WHERE NOT EXISTS (SELECT 1 FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Fresh Baby Spinach 5 oz'));

-- sun_dried: one nutrition serving = 1 oz drained.
-- Buy: 1 jar with at least 4 oz drained tomatoes.
INSERT INTO `items` (`grocery_item`, `price`, `department`, `pantryqty`, `servings`, `protein`, `fat`, `carbs`, `calories`, `fiber`, `url`)
SELECT 'Sun-dried Tomatoes in Oil', NULL, 'Canned Goods', '0', 1, NULL, NULL, NULL, NULL, NULL, ''
WHERE NOT EXISTS (SELECT 1 FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Sun-dried Tomatoes in Oil'));

-- tomato_paste: one nutrition serving = 2 tablespoons.
-- Buy: 1 can containing 6 oz.
INSERT INTO `items` (`grocery_item`, `price`, `department`, `pantryqty`, `servings`, `protein`, `fat`, `carbs`, `calories`, `fiber`, `url`)
SELECT 'Tomato Paste 6 oz', NULL, 'Canned Goods', '0', 1, NULL, NULL, NULL, NULL, NULL, ''
WHERE NOT EXISTS (SELECT 1 FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Tomato Paste 6 oz'));

-- tomatoes: one nutrition serving = 1/2 cup including juice; use 3.5 label servings per 14.5 oz can.
-- Buy: Qty counts 14.5 oz cans.
INSERT INTO `items` (`grocery_item`, `price`, `department`, `pantryqty`, `servings`, `protein`, `fat`, `carbs`, `calories`, `fiber`, `url`)
SELECT 'No Salt Added Diced Tomatoes 14.5 oz', NULL, 'Canned Goods', '0', 1, NULL, NULL, NULL, NULL, NULL, ''
WHERE NOT EXISTS (SELECT 1 FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('No Salt Added Diced Tomatoes 14.5 oz'));

-- turmeric: one nutrition serving = 1 teaspoon.
-- Buy: 1 jar.
INSERT INTO `items` (`grocery_item`, `price`, `department`, `pantryqty`, `servings`, `protein`, `fat`, `carbs`, `calories`, `fiber`, `url`)
SELECT 'Ground Turmeric', NULL, 'Spices', '0', 1, NULL, NULL, NULL, NULL, NULL, ''
WHERE NOT EXISTS (SELECT 1 FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Ground Turmeric'));

-- vinegar: one nutrition serving = 1 tablespoon.
-- Buy: 1 bottle apple cider vinegar.
INSERT INTO `items` (`grocery_item`, `price`, `department`, `pantryqty`, `servings`, `protein`, `fat`, `carbs`, `calories`, `fiber`, `url`)
SELECT 'Apple Cider Vinegar', NULL, 'Cooking', '0', 1, NULL, NULL, NULL, NULL, NULL, ''
WHERE NOT EXISTS (SELECT 1 FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Apple Cider Vinegar'));

-- water: one nutrition serving = 1 cup; nutrition remains zero.
-- Buy: Tap water; Qty 0, no purchase.
INSERT INTO `items` (`grocery_item`, `price`, `department`, `pantryqty`, `servings`, `protein`, `fat`, `carbs`, `calories`, `fiber`, `url`)
SELECT 'Water From Sink', NULL, 'Cooking', '0', 1, NULL, NULL, NULL, NULL, NULL, ''
WHERE NOT EXISTS (SELECT 1 FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Water From Sink'));

-- white_vinegar: one nutrition serving = 1 tablespoon.
-- Buy: 1 bottle white vinegar.
INSERT INTO `items` (`grocery_item`, `price`, `department`, `pantryqty`, `servings`, `protein`, `fat`, `carbs`, `calories`, `fiber`, `url`)
SELECT 'White Vinegar', NULL, 'Cooking', '0', 1, NULL, NULL, NULL, NULL, NULL, ''
WHERE NOT EXISTS (SELECT 1 FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('White Vinegar'));

-- yogurt: one nutrition serving = 1/2 cup.
-- Buy: 1 tub plain whole-milk yogurt; at least 1/2 cup.
INSERT INTO `items` (`grocery_item`, `price`, `department`, `pantryqty`, `servings`, `protein`, `fat`, `carbs`, `calories`, `fiber`, `url`)
SELECT 'Plain Whole Milk Yogurt', NULL, 'Dairy', '0', 1, NULL, NULL, NULL, NULL, NULL, ''
WHERE NOT EXISTS (SELECT 1 FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Plain Whole Milk Yogurt'));

-- Creamy Cajun Chicken: one batch makes 7 servings.
INSERT INTO `recipe_lists` (`recipe_name`, `url`)
SELECT 'Creamy_Cajun_Chicken_recipe_table', ''
WHERE NOT EXISTS (SELECT 1 FROM `recipe_lists` WHERE `recipe_name` = 'Creamy_Cajun_Chicken_recipe_table');

-- 3 lb boneless skinless chicken thighs, thawed; Qty = purchases, Used Servings = whole batch.
INSERT INTO `Creamy_Cajun_Chicken_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 12.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Boneless Skinless Chicken Thighs'))
  AND NOT EXISTS (SELECT 1 FROM `Creamy_Cajun_Chicken_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

-- 1 tablespoon olive oil; Qty = purchases, Used Servings = whole batch.
INSERT INTO `Creamy_Cajun_Chicken_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 1.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Olive Oil'))
  AND NOT EXISTS (SELECT 1 FROM `Creamy_Cajun_Chicken_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

-- 1 cup frozen chopped onion; Qty = purchases, Used Servings = whole batch.
INSERT INTO `Creamy_Cajun_Chicken_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 1.500, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Frozen Onion'))
  AND NOT EXISTS (SELECT 1 FROM `Creamy_Cajun_Chicken_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

-- 2 medium bell peppers, seeds removed and cut into strips; Qty = purchases, Used Servings = whole batch.
INSERT INTO `Creamy_Cajun_Chicken_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 2, 2.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Bell Pepper'))
  AND NOT EXISTS (SELECT 1 FROM `Creamy_Cajun_Chicken_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

-- 6 garlic cloves, finely chopped; Qty = purchases, Used Servings = whole batch.
INSERT INTO `Creamy_Cajun_Chicken_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 6, 6.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Garlic Clove'))
  AND NOT EXISTS (SELECT 1 FROM `Creamy_Cajun_Chicken_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

-- 2 tablespoons low-salt Cajun seasoning; Qty = purchases, Used Servings = whole batch.
INSERT INTO `Creamy_Cajun_Chicken_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 6.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Cajun Spice'))
  AND NOT EXISTS (SELECT 1 FROM `Creamy_Cajun_Chicken_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

-- 2 1/4 cups low-sodium chicken broth; Qty = purchases, Used Servings = whole batch.
INSERT INTO `Creamy_Cajun_Chicken_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 2.250, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Chicken broth'))
  AND NOT EXISTS (SELECT 1 FROM `Creamy_Cajun_Chicken_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

-- 1 cup heavy cream; Qty = purchases, Used Servings = whole batch.
INSERT INTO `Creamy_Cajun_Chicken_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 16.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Heavy Cream'))
  AND NOT EXISTS (SELECT 1 FROM `Creamy_Cajun_Chicken_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

-- 4 oz cream cheese, cut into small cubes; Qty = purchases, Used Servings = whole batch.
INSERT INTO `Creamy_Cajun_Chicken_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 4.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Cream cheese 1 pack'))
  AND NOT EXISTS (SELECT 1 FROM `Creamy_Cajun_Chicken_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

-- 2 oz finely grated Parmesan; Qty = purchases, Used Servings = whole batch.
INSERT INTO `Creamy_Cajun_Chicken_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 11.340, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Parmesan'))
  AND NOT EXISTS (SELECT 1 FROM `Creamy_Cajun_Chicken_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

-- Tuscan Chicken: one batch makes 7 servings.
INSERT INTO `recipe_lists` (`recipe_name`, `url`)
SELECT 'Tuscan_Chicken_recipe_table', ''
WHERE NOT EXISTS (SELECT 1 FROM `recipe_lists` WHERE `recipe_name` = 'Tuscan_Chicken_recipe_table');

-- 3 lb boneless skinless chicken thighs, thawed; Qty = purchases, Used Servings = whole batch.
INSERT INTO `Tuscan_Chicken_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 12.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Boneless Skinless Chicken Thighs'))
  AND NOT EXISTS (SELECT 1 FROM `Tuscan_Chicken_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

-- 1 tablespoon olive oil; Qty = purchases, Used Servings = whole batch.
INSERT INTO `Tuscan_Chicken_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 1.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Olive Oil'))
  AND NOT EXISTS (SELECT 1 FROM `Tuscan_Chicken_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

-- 1 cup frozen chopped onion; Qty = purchases, Used Servings = whole batch.
INSERT INTO `Tuscan_Chicken_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 1.500, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Frozen Onion'))
  AND NOT EXISTS (SELECT 1 FROM `Tuscan_Chicken_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

-- 8 garlic cloves, finely chopped; Qty = purchases, Used Servings = whole batch.
INSERT INTO `Tuscan_Chicken_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 8, 8.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Garlic Clove'))
  AND NOT EXISTS (SELECT 1 FROM `Tuscan_Chicken_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

-- 2 1/4 cups low-sodium chicken broth; Qty = purchases, Used Servings = whole batch.
INSERT INTO `Tuscan_Chicken_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 2.250, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Chicken broth'))
  AND NOT EXISTS (SELECT 1 FROM `Tuscan_Chicken_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

-- 2 teaspoons Italian seasoning; Qty = purchases, Used Servings = whole batch.
INSERT INTO `Tuscan_Chicken_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 2.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Italan Seasoning'))
  AND NOT EXISTS (SELECT 1 FROM `Tuscan_Chicken_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

-- 4 oz sun-dried tomatoes, drained and chopped; Qty = purchases, Used Servings = whole batch.
INSERT INTO `Tuscan_Chicken_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 4.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Sun-dried Tomatoes in Oil'))
  AND NOT EXISTS (SELECT 1 FROM `Tuscan_Chicken_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

-- 1 cup heavy cream; Qty = purchases, Used Servings = whole batch.
INSERT INTO `Tuscan_Chicken_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 16.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Heavy Cream'))
  AND NOT EXISTS (SELECT 1 FROM `Tuscan_Chicken_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

-- 4 oz finely grated Parmesan; Qty = purchases, Used Servings = whole batch.
INSERT INTO `Tuscan_Chicken_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 22.680, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Parmesan'))
  AND NOT EXISTS (SELECT 1 FROM `Tuscan_Chicken_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

-- 5 oz fresh baby spinach; Qty = purchases, Used Servings = whole batch.
INSERT INTO `Tuscan_Chicken_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 1.417, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Fresh Baby Spinach 5 oz'))
  AND NOT EXISTS (SELECT 1 FROM `Tuscan_Chicken_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

-- 1 tablespoon lemon juice; Qty = purchases, Used Servings = whole batch.
INSERT INTO `Tuscan_Chicken_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 1.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Lemon Juice'))
  AND NOT EXISTS (SELECT 1 FROM `Tuscan_Chicken_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

-- 1/2 teaspoon ground black pepper; Qty = purchases, Used Servings = whole batch.
INSERT INTO `Tuscan_Chicken_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 2.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Black pepper'))
  AND NOT EXISTS (SELECT 1 FROM `Tuscan_Chicken_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

-- Buffalo Chicken Mac and Cheese: one batch makes 7 servings.
INSERT INTO `recipe_lists` (`recipe_name`, `url`)
SELECT 'Buffalo_Chicken_Mac_and_Cheese_recipe_table', ''
WHERE NOT EXISTS (SELECT 1 FROM `recipe_lists` WHERE `recipe_name` = 'Buffalo_Chicken_Mac_and_Cheese_recipe_table');

-- 3 lb boneless skinless chicken thighs, thawed; Qty = purchases, Used Servings = whole batch.
INSERT INTO `Buffalo_Chicken_Mac_and_Cheese_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 12.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Boneless Skinless Chicken Thighs'))
  AND NOT EXISTS (SELECT 1 FROM `Buffalo_Chicken_Mac_and_Cheese_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

-- 2 1/4 cups low-sodium chicken broth; Qty = purchases, Used Servings = whole batch.
INSERT INTO `Buffalo_Chicken_Mac_and_Cheese_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 2.250, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Chicken broth'))
  AND NOT EXISTS (SELECT 1 FROM `Buffalo_Chicken_Mac_and_Cheese_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

-- 2 teaspoons garlic powder; Qty = purchases, Used Servings = whole batch.
INSERT INTO `Buffalo_Chicken_Mac_and_Cheese_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 2.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Garlic Powder'))
  AND NOT EXISTS (SELECT 1 FROM `Buffalo_Chicken_Mac_and_Cheese_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

-- 1 teaspoon onion powder; Qty = purchases, Used Servings = whole batch.
INSERT INTO `Buffalo_Chicken_Mac_and_Cheese_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 1.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Onion Powder'))
  AND NOT EXISTS (SELECT 1 FROM `Buffalo_Chicken_Mac_and_Cheese_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

-- 16 oz dry elbow macaroni; Qty = purchases, Used Servings = whole batch.
INSERT INTO `Buffalo_Chicken_Mac_and_Cheese_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 8.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Elbow Macaroni 16 oz'))
  AND NOT EXISTS (SELECT 1 FROM `Buffalo_Chicken_Mac_and_Cheese_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

-- 4 quarts tap water for boiling the macaroni; Qty = purchases, Used Servings = whole batch.
INSERT INTO `Buffalo_Chicken_Mac_and_Cheese_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 0, 16.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Water From Sink'))
  AND NOT EXISTS (SELECT 1 FROM `Buffalo_Chicken_Mac_and_Cheese_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

-- 1/2 cup plain cayenne hot sauce; Qty = purchases, Used Servings = whole batch.
INSERT INTO `Buffalo_Chicken_Mac_and_Cheese_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 24.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Franks Hot Sauce'))
  AND NOT EXISTS (SELECT 1 FROM `Buffalo_Chicken_Mac_and_Cheese_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

-- 2 tablespoons unsalted butter; Qty = purchases, Used Servings = whole batch.
INSERT INTO `Buffalo_Chicken_Mac_and_Cheese_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 2.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Butter 4 pack'))
  AND NOT EXISTS (SELECT 1 FROM `Buffalo_Chicken_Mac_and_Cheese_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

-- 4 oz cream cheese, cubed; Qty = purchases, Used Servings = whole batch.
INSERT INTO `Buffalo_Chicken_Mac_and_Cheese_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 4.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Cream cheese 1 pack'))
  AND NOT EXISTS (SELECT 1 FROM `Buffalo_Chicken_Mac_and_Cheese_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

-- 1 cup whole milk; Qty = purchases, Used Servings = whole batch.
INSERT INTO `Buffalo_Chicken_Mac_and_Cheese_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 1.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Milk'))
  AND NOT EXISTS (SELECT 1 FROM `Buffalo_Chicken_Mac_and_Cheese_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

-- 16 oz cheddar cheese, freshly grated; Qty = purchases, Used Servings = whole batch.
INSERT INTO `Buffalo_Chicken_Mac_and_Cheese_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 2, 16.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Cheddar Cheese block'))
  AND NOT EXISTS (SELECT 1 FROM `Buffalo_Chicken_Mac_and_Cheese_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

-- Mississippi Pot Roast: one batch makes 7 servings.
INSERT INTO `recipe_lists` (`recipe_name`, `url`)
SELECT 'Mississippi_Pot_Roast_recipe_table', ''
WHERE NOT EXISTS (SELECT 1 FROM `recipe_lists` WHERE `recipe_name` = 'Mississippi_Pot_Roast_recipe_table');

-- 3 1/2 lb boneless beef chuck roast, cut into 3-inch pieces; Qty = purchases, Used Servings = whole batch.
INSERT INTO `Mississippi_Pot_Roast_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 14.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Boneless Beef Chuck Roast'))
  AND NOT EXISTS (SELECT 1 FROM `Mississippi_Pot_Roast_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

-- 2 1/4 cups low-sodium beef broth; Qty = purchases, Used Servings = whole batch.
INSERT INTO `Mississippi_Pot_Roast_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 2.250, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Beef Broth'))
  AND NOT EXISTS (SELECT 1 FROM `Mississippi_Pot_Roast_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

-- 1 oz packet dry ranch seasoning (about 3 tablespoons); Qty = purchases, Used Servings = whole batch.
INSERT INTO `Mississippi_Pot_Roast_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 36.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Ranch seasoning mix'))
  AND NOT EXISTS (SELECT 1 FROM `Mississippi_Pot_Roast_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

-- 4 oz drained pepperoncini peppers, stems removed, plus 1/4 cup brine from the jar; Qty = purchases, Used Servings = whole batch.
INSERT INTO `Mississippi_Pot_Roast_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 4.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Pepperchini'))
  AND NOT EXISTS (SELECT 1 FROM `Mississippi_Pot_Roast_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

-- 1 oz packet au jus gravy mix; Qty = purchases, Used Servings = whole batch.
INSERT INTO `Mississippi_Pot_Roast_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 1.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Au Jus Gravy Mix 1 oz'))
  AND NOT EXISTS (SELECT 1 FROM `Mississippi_Pot_Roast_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

-- 4 tablespoons unsalted butter; Qty = purchases, Used Servings = whole batch.
INSERT INTO `Mississippi_Pot_Roast_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 4.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Butter 4 pack'))
  AND NOT EXISTS (SELECT 1 FROM `Mississippi_Pot_Roast_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

-- 1/4 cup cold tap water for the gravy mix, plus up to 1/2 cup if the meat needs longer simmering; Qty = purchases, Used Servings = whole batch.
INSERT INTO `Mississippi_Pot_Roast_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 0, 0.750, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Water From Sink'))
  AND NOT EXISTS (SELECT 1 FROM `Mississippi_Pot_Roast_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

-- Beef Birria: one batch makes 7 servings.
INSERT INTO `recipe_lists` (`recipe_name`, `url`)
SELECT 'Beef_Birria_recipe_table', ''
WHERE NOT EXISTS (SELECT 1 FROM `recipe_lists` WHERE `recipe_name` = 'Beef_Birria_recipe_table');

-- 3 1/2 lb boneless beef chuck, cut into 3-inch pieces; Qty = purchases, Used Servings = whole batch.
INSERT INTO `Beef_Birria_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 14.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Boneless Beef Chuck Roast'))
  AND NOT EXISTS (SELECT 1 FROM `Beef_Birria_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

-- 6 dried guajillo peppers, stems and seeds removed; Qty = purchases, Used Servings = whole batch.
INSERT INTO `Beef_Birria_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 6.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Dried Guajillo Peppers'))
  AND NOT EXISTS (SELECT 1 FROM `Beef_Birria_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

-- 2 dried ancho peppers, stems and seeds removed; Qty = purchases, Used Servings = whole batch.
INSERT INTO `Beef_Birria_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 2.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Dried Ancho Peppers'))
  AND NOT EXISTS (SELECT 1 FROM `Beef_Birria_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

-- 2 cups cold tap water brought to a boil for soaking peppers, plus up to 1/2 cup if the beef needs more simmering; Qty = purchases, Used Servings = whole batch.
INSERT INTO `Beef_Birria_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 0, 2.500, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Water From Sink'))
  AND NOT EXISTS (SELECT 1 FROM `Beef_Birria_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

-- 3 1/4 cups low-sodium beef broth, divided; Qty = purchases, Used Servings = whole batch.
INSERT INTO `Beef_Birria_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 3.250, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Beef Broth'))
  AND NOT EXISTS (SELECT 1 FROM `Beef_Birria_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

-- 1 cup frozen chopped onion; Qty = purchases, Used Servings = whole batch.
INSERT INTO `Beef_Birria_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 1.500, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Frozen Onion'))
  AND NOT EXISTS (SELECT 1 FROM `Beef_Birria_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

-- 8 garlic cloves, peeled; Qty = purchases, Used Servings = whole batch.
INSERT INTO `Beef_Birria_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 8, 8.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Garlic Clove'))
  AND NOT EXISTS (SELECT 1 FROM `Beef_Birria_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

-- 1 can (14.5 oz) no-salt-added diced tomatoes, with the juice; Qty = purchases, Used Servings = whole batch.
INSERT INTO `Beef_Birria_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 3.500, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('No Salt Added Diced Tomatoes 14.5 oz'))
  AND NOT EXISTS (SELECT 1 FROM `Beef_Birria_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

-- 2 tablespoons apple cider vinegar; Qty = purchases, Used Servings = whole batch.
INSERT INTO `Beef_Birria_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 2.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Apple Cider Vinegar'))
  AND NOT EXISTS (SELECT 1 FROM `Beef_Birria_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

-- 2 teaspoons ground cumin; Qty = purchases, Used Servings = whole batch.
INSERT INTO `Beef_Birria_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 2.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Ground Cumin'))
  AND NOT EXISTS (SELECT 1 FROM `Beef_Birria_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

-- 2 teaspoons dried oregano; Qty = purchases, Used Servings = whole batch.
INSERT INTO `Beef_Birria_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 2.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Oregeno'))
  AND NOT EXISTS (SELECT 1 FROM `Beef_Birria_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

-- 1/4 teaspoon ground cloves; Qty = purchases, Used Servings = whole batch.
INSERT INTO `Beef_Birria_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 1.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Ground Cloves'))
  AND NOT EXISTS (SELECT 1 FROM `Beef_Birria_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

-- 1 cinnamon stick; Qty = purchases, Used Servings = whole batch.
INSERT INTO `Beef_Birria_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 1.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Cinnamon Sticks'))
  AND NOT EXISTS (SELECT 1 FROM `Beef_Birria_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

-- 2 bay leaves; Qty = purchases, Used Servings = whole batch.
INSERT INTO `Beef_Birria_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 2.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Bay Leaves'))
  AND NOT EXISTS (SELECT 1 FROM `Beef_Birria_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

-- 1/2 teaspoon salt; Qty = purchases, Used Servings = whole batch.
INSERT INTO `Beef_Birria_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 0.500, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Salt'))
  AND NOT EXISTS (SELECT 1 FROM `Beef_Birria_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

-- 2 tablespoons lime juice; Qty = purchases, Used Servings = whole batch.
INSERT INTO `Beef_Birria_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 2.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Lime Juice'))
  AND NOT EXISTS (SELECT 1 FROM `Beef_Birria_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

-- 1/4 cup chopped cilantro; Qty = purchases, Used Servings = whole batch.
INSERT INTO `Beef_Birria_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 4.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Cilantro'))
  AND NOT EXISTS (SELECT 1 FROM `Beef_Birria_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

-- Hungarian Beef Goulash: one batch makes 7 servings.
INSERT INTO `recipe_lists` (`recipe_name`, `url`)
SELECT 'Hungarian_Beef_Goulash_recipe_table', ''
WHERE NOT EXISTS (SELECT 1 FROM `recipe_lists` WHERE `recipe_name` = 'Hungarian_Beef_Goulash_recipe_table');

-- 3 1/2 lb boneless beef chuck, cut into 1 1/2-inch cubes; Qty = purchases, Used Servings = whole batch.
INSERT INTO `Hungarian_Beef_Goulash_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 14.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Boneless Beef Chuck Roast'))
  AND NOT EXISTS (SELECT 1 FROM `Hungarian_Beef_Goulash_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

-- 1 tablespoon olive oil; Qty = purchases, Used Servings = whole batch.
INSERT INTO `Hungarian_Beef_Goulash_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 1.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Olive Oil'))
  AND NOT EXISTS (SELECT 1 FROM `Hungarian_Beef_Goulash_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

-- 2 cups frozen chopped onion; Qty = purchases, Used Servings = whole batch.
INSERT INTO `Hungarian_Beef_Goulash_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 2, 3.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Frozen Onion'))
  AND NOT EXISTS (SELECT 1 FROM `Hungarian_Beef_Goulash_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

-- 2 medium bell peppers, seeded and chopped; Qty = purchases, Used Servings = whole batch.
INSERT INTO `Hungarian_Beef_Goulash_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 2, 2.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Bell Pepper'))
  AND NOT EXISTS (SELECT 1 FROM `Hungarian_Beef_Goulash_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

-- 6 garlic cloves, finely chopped; Qty = purchases, Used Servings = whole batch.
INSERT INTO `Hungarian_Beef_Goulash_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 6, 6.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Garlic Clove'))
  AND NOT EXISTS (SELECT 1 FROM `Hungarian_Beef_Goulash_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

-- 2 1/4 cups low-sodium beef broth; Qty = purchases, Used Servings = whole batch.
INSERT INTO `Hungarian_Beef_Goulash_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 2.250, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Beef Broth'))
  AND NOT EXISTS (SELECT 1 FROM `Hungarian_Beef_Goulash_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

-- 3 tablespoons sweet Hungarian paprika; Qty = purchases, Used Servings = whole batch.
INSERT INTO `Hungarian_Beef_Goulash_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 9.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Paprika'))
  AND NOT EXISTS (SELECT 1 FROM `Hungarian_Beef_Goulash_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

-- 1 teaspoon caraway seeds; Qty = purchases, Used Servings = whole batch.
INSERT INTO `Hungarian_Beef_Goulash_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 1.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Caraway Seeds'))
  AND NOT EXISTS (SELECT 1 FROM `Hungarian_Beef_Goulash_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

-- 2 tablespoons tomato paste; Qty = purchases, Used Servings = whole batch.
INSERT INTO `Hungarian_Beef_Goulash_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 1.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Tomato Paste 6 oz'))
  AND NOT EXISTS (SELECT 1 FROM `Hungarian_Beef_Goulash_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

-- 1 can (14.5 oz) no-salt-added diced tomatoes, with the juice; Qty = purchases, Used Servings = whole batch.
INSERT INTO `Hungarian_Beef_Goulash_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 3.500, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('No Salt Added Diced Tomatoes 14.5 oz'))
  AND NOT EXISTS (SELECT 1 FROM `Hungarian_Beef_Goulash_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

-- 1 teaspoon salt; Qty = purchases, Used Servings = whole batch.
INSERT INTO `Hungarian_Beef_Goulash_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 1.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Salt'))
  AND NOT EXISTS (SELECT 1 FROM `Hungarian_Beef_Goulash_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

-- 1/2 teaspoon ground black pepper; Qty = purchases, Used Servings = whole batch.
INSERT INTO `Hungarian_Beef_Goulash_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 2.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Black pepper'))
  AND NOT EXISTS (SELECT 1 FROM `Hungarian_Beef_Goulash_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

-- 2 tablespoons cornstarch; Qty = purchases, Used Servings = whole batch.
INSERT INTO `Hungarian_Beef_Goulash_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 2.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Cornstarch 16 oz'))
  AND NOT EXISTS (SELECT 1 FROM `Hungarian_Beef_Goulash_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

-- 2 tablespoons cold tap water for thickening, plus up to 1/2 cup if beef needs more simmering; Qty = purchases, Used Servings = whole batch.
INSERT INTO `Hungarian_Beef_Goulash_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 0, 0.625, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Water From Sink'))
  AND NOT EXISTS (SELECT 1 FROM `Hungarian_Beef_Goulash_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

-- 1/2 cup sour cream, for serving; Qty = purchases, Used Servings = whole batch.
INSERT INTO `Hungarian_Beef_Goulash_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 4.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Sour Cream'))
  AND NOT EXISTS (SELECT 1 FROM `Hungarian_Beef_Goulash_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

-- Korean Spicy Pulled Pork: one batch makes 7 servings.
INSERT INTO `recipe_lists` (`recipe_name`, `url`)
SELECT 'Korean_Spicy_Pulled_Pork_recipe_table', ''
WHERE NOT EXISTS (SELECT 1 FROM `recipe_lists` WHERE `recipe_name` = 'Korean_Spicy_Pulled_Pork_recipe_table');

-- 3 1/2 lb boneless pork shoulder, large outside fat trimmed, cut into 3-inch pieces; Qty = purchases, Used Servings = whole batch.
INSERT INTO `Korean_Spicy_Pulled_Pork_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 14.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Pork shoulder'))
  AND NOT EXISTS (SELECT 1 FROM `Korean_Spicy_Pulled_Pork_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

-- 2 1/4 cups low-sodium chicken broth; Qty = purchases, Used Servings = whole batch.
INSERT INTO `Korean_Spicy_Pulled_Pork_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 2.250, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Chicken broth'))
  AND NOT EXISTS (SELECT 1 FROM `Korean_Spicy_Pulled_Pork_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

-- 1 cup frozen chopped onion; Qty = purchases, Used Servings = whole batch.
INSERT INTO `Korean_Spicy_Pulled_Pork_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 1.500, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Frozen Onion'))
  AND NOT EXISTS (SELECT 1 FROM `Korean_Spicy_Pulled_Pork_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

-- 8 garlic cloves, finely chopped; Qty = purchases, Used Servings = whole batch.
INSERT INTO `Korean_Spicy_Pulled_Pork_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 8, 8.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Garlic Clove'))
  AND NOT EXISTS (SELECT 1 FROM `Korean_Spicy_Pulled_Pork_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

-- 2 tablespoons peeled, finely chopped fresh ginger; Qty = purchases, Used Servings = whole batch.
INSERT INTO `Korean_Spicy_Pulled_Pork_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 2.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Fresh Ginger Root'))
  AND NOT EXISTS (SELECT 1 FROM `Korean_Spicy_Pulled_Pork_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

-- 1/4 cup low-sodium soy sauce; Qty = purchases, Used Servings = whole batch.
INSERT INTO `Korean_Spicy_Pulled_Pork_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 4.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Soy sauce'))
  AND NOT EXISTS (SELECT 1 FROM `Korean_Spicy_Pulled_Pork_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

-- 1/3 cup gochujang Korean chili paste; Qty = purchases, Used Servings = whole batch.
INSERT INTO `Korean_Spicy_Pulled_Pork_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 5.333, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Gochujang Korean Chili Paste'))
  AND NOT EXISTS (SELECT 1 FROM `Korean_Spicy_Pulled_Pork_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

-- 3 tablespoons packed brown sugar; Qty = purchases, Used Servings = whole batch.
INSERT INTO `Korean_Spicy_Pulled_Pork_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 4.500, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Brown Sugar'))
  AND NOT EXISTS (SELECT 1 FROM `Korean_Spicy_Pulled_Pork_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

-- 2 tablespoons apple cider vinegar; Qty = purchases, Used Servings = whole batch.
INSERT INTO `Korean_Spicy_Pulled_Pork_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 2.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Apple Cider Vinegar'))
  AND NOT EXISTS (SELECT 1 FROM `Korean_Spicy_Pulled_Pork_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

-- 1 tablespoon toasted sesame oil; Qty = purchases, Used Servings = whole batch.
INSERT INTO `Korean_Spicy_Pulled_Pork_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 1.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Toasted Sesame Oil'))
  AND NOT EXISTS (SELECT 1 FROM `Korean_Spicy_Pulled_Pork_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

-- 1 tablespoon cornstarch; Qty = purchases, Used Servings = whole batch.
INSERT INTO `Korean_Spicy_Pulled_Pork_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 1.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Cornstarch 16 oz'))
  AND NOT EXISTS (SELECT 1 FROM `Korean_Spicy_Pulled_Pork_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

-- 1 tablespoon cold tap water, plus up to 1/2 cup if pork needs more simmering; Qty = purchases, Used Servings = whole batch.
INSERT INTO `Korean_Spicy_Pulled_Pork_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 0, 0.562, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Water From Sink'))
  AND NOT EXISTS (SELECT 1 FROM `Korean_Spicy_Pulled_Pork_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

-- Filipino Pork Adobo: one batch makes 7 servings.
INSERT INTO `recipe_lists` (`recipe_name`, `url`)
SELECT 'Filipino_Pork_Adobo_recipe_table', ''
WHERE NOT EXISTS (SELECT 1 FROM `recipe_lists` WHERE `recipe_name` = 'Filipino_Pork_Adobo_recipe_table');

-- 3 1/2 lb boneless pork shoulder, large outside fat trimmed, cut into 1 1/2-inch cubes; Qty = purchases, Used Servings = whole batch.
INSERT INTO `Filipino_Pork_Adobo_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 14.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Pork shoulder'))
  AND NOT EXISTS (SELECT 1 FROM `Filipino_Pork_Adobo_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

-- 2 1/4 cups tap water, plus up to 1/2 cup if pork needs more simmering; Qty = purchases, Used Servings = whole batch.
INSERT INTO `Filipino_Pork_Adobo_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 0, 2.750, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Water From Sink'))
  AND NOT EXISTS (SELECT 1 FROM `Filipino_Pork_Adobo_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

-- 1/2 cup low-sodium soy sauce; Qty = purchases, Used Servings = whole batch.
INSERT INTO `Filipino_Pork_Adobo_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 8.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Soy sauce'))
  AND NOT EXISTS (SELECT 1 FROM `Filipino_Pork_Adobo_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

-- 1/2 cup white vinegar; Qty = purchases, Used Servings = whole batch.
INSERT INTO `Filipino_Pork_Adobo_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 8.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('White Vinegar'))
  AND NOT EXISTS (SELECT 1 FROM `Filipino_Pork_Adobo_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

-- 12 garlic cloves, peeled and lightly crushed; Qty = purchases, Used Servings = whole batch.
INSERT INTO `Filipino_Pork_Adobo_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 12, 12.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Garlic Clove'))
  AND NOT EXISTS (SELECT 1 FROM `Filipino_Pork_Adobo_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

-- 3 bay leaves; Qty = purchases, Used Servings = whole batch.
INSERT INTO `Filipino_Pork_Adobo_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 3.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Bay Leaves'))
  AND NOT EXISTS (SELECT 1 FROM `Filipino_Pork_Adobo_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

-- 1 teaspoon ground black pepper; Qty = purchases, Used Servings = whole batch.
INSERT INTO `Filipino_Pork_Adobo_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 4.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Black pepper'))
  AND NOT EXISTS (SELECT 1 FROM `Filipino_Pork_Adobo_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

-- 1 tablespoon packed brown sugar; Qty = purchases, Used Servings = whole batch.
INSERT INTO `Filipino_Pork_Adobo_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 1.500, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Brown Sugar'))
  AND NOT EXISTS (SELECT 1 FROM `Filipino_Pork_Adobo_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

-- Smoky BBQ Pulled Pork: one batch makes 7 servings.
INSERT INTO `recipe_lists` (`recipe_name`, `url`)
SELECT 'Smoky_BBQ_Pulled_Pork_recipe_table', ''
WHERE NOT EXISTS (SELECT 1 FROM `recipe_lists` WHERE `recipe_name` = 'Smoky_BBQ_Pulled_Pork_recipe_table');

-- 3 1/2 lb boneless pork shoulder, large outside fat trimmed, cut into 3-inch pieces; Qty = purchases, Used Servings = whole batch.
INSERT INTO `Smoky_BBQ_Pulled_Pork_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 14.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Pork shoulder'))
  AND NOT EXISTS (SELECT 1 FROM `Smoky_BBQ_Pulled_Pork_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

-- 2 1/4 cups low-sodium chicken broth; Qty = purchases, Used Servings = whole batch.
INSERT INTO `Smoky_BBQ_Pulled_Pork_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 2.250, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Chicken broth'))
  AND NOT EXISTS (SELECT 1 FROM `Smoky_BBQ_Pulled_Pork_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

-- 1 cup frozen chopped onion; Qty = purchases, Used Servings = whole batch.
INSERT INTO `Smoky_BBQ_Pulled_Pork_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 1.500, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Frozen Onion'))
  AND NOT EXISTS (SELECT 1 FROM `Smoky_BBQ_Pulled_Pork_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

-- 1 tablespoon smoked paprika; Qty = purchases, Used Servings = whole batch.
INSERT INTO `Smoky_BBQ_Pulled_Pork_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 3.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Smoked Paprika'))
  AND NOT EXISTS (SELECT 1 FROM `Smoky_BBQ_Pulled_Pork_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

-- 2 teaspoons garlic powder; Qty = purchases, Used Servings = whole batch.
INSERT INTO `Smoky_BBQ_Pulled_Pork_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 2.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Garlic Powder'))
  AND NOT EXISTS (SELECT 1 FROM `Smoky_BBQ_Pulled_Pork_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

-- 1 teaspoon onion powder; Qty = purchases, Used Servings = whole batch.
INSERT INTO `Smoky_BBQ_Pulled_Pork_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 1.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Onion Powder'))
  AND NOT EXISTS (SELECT 1 FROM `Smoky_BBQ_Pulled_Pork_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

-- 1/2 teaspoon ground black pepper; Qty = purchases, Used Servings = whole batch.
INSERT INTO `Smoky_BBQ_Pulled_Pork_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 2.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Black pepper'))
  AND NOT EXISTS (SELECT 1 FROM `Smoky_BBQ_Pulled_Pork_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

-- 2 tablespoons packed brown sugar; Qty = purchases, Used Servings = whole batch.
INSERT INTO `Smoky_BBQ_Pulled_Pork_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 3.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Brown Sugar'))
  AND NOT EXISTS (SELECT 1 FROM `Smoky_BBQ_Pulled_Pork_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

-- 2 tablespoons apple cider vinegar; Qty = purchases, Used Servings = whole batch.
INSERT INTO `Smoky_BBQ_Pulled_Pork_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 2.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Apple Cider Vinegar'))
  AND NOT EXISTS (SELECT 1 FROM `Smoky_BBQ_Pulled_Pork_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

-- 1 1/2 cups smoky barbecue sauce; Qty = purchases, Used Servings = whole batch.
INSERT INTO `Smoky_BBQ_Pulled_Pork_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 12.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Smoky Barbecue Sauce'))
  AND NOT EXISTS (SELECT 1 FROM `Smoky_BBQ_Pulled_Pork_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

-- Up to 1/2 cup tap water only if pork needs more simmering; Qty = purchases, Used Servings = whole batch.
INSERT INTO `Smoky_BBQ_Pulled_Pork_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 0, 0.500, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Water From Sink'))
  AND NOT EXISTS (SELECT 1 FROM `Smoky_BBQ_Pulled_Pork_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

-- Chicken Tikka Masala: one batch makes 7 servings.
INSERT INTO `recipe_lists` (`recipe_name`, `url`)
SELECT 'Chicken_Tikka_Masala_recipe_table', ''
WHERE NOT EXISTS (SELECT 1 FROM `recipe_lists` WHERE `recipe_name` = 'Chicken_Tikka_Masala_recipe_table');

-- 3 lb boneless skinless chicken thighs, cut into 1 1/2-inch pieces; Qty = purchases, Used Servings = whole batch.
INSERT INTO `Chicken_Tikka_Masala_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 12.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Boneless Skinless Chicken Thighs'))
  AND NOT EXISTS (SELECT 1 FROM `Chicken_Tikka_Masala_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

-- 1 tablespoon olive oil; Qty = purchases, Used Servings = whole batch.
INSERT INTO `Chicken_Tikka_Masala_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 1.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Olive Oil'))
  AND NOT EXISTS (SELECT 1 FROM `Chicken_Tikka_Masala_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

-- 1 cup frozen chopped onion; Qty = purchases, Used Servings = whole batch.
INSERT INTO `Chicken_Tikka_Masala_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 1.500, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Frozen Onion'))
  AND NOT EXISTS (SELECT 1 FROM `Chicken_Tikka_Masala_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

-- 8 garlic cloves, finely chopped; Qty = purchases, Used Servings = whole batch.
INSERT INTO `Chicken_Tikka_Masala_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 8, 8.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Garlic Clove'))
  AND NOT EXISTS (SELECT 1 FROM `Chicken_Tikka_Masala_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

-- 2 tablespoons peeled, finely chopped fresh ginger; Qty = purchases, Used Servings = whole batch.
INSERT INTO `Chicken_Tikka_Masala_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 2.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Fresh Ginger Root'))
  AND NOT EXISTS (SELECT 1 FROM `Chicken_Tikka_Masala_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

-- 2 1/4 cups low-sodium chicken broth; Qty = purchases, Used Servings = whole batch.
INSERT INTO `Chicken_Tikka_Masala_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 2.250, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Chicken broth'))
  AND NOT EXISTS (SELECT 1 FROM `Chicken_Tikka_Masala_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

-- 2 cans (14.5 oz each) no-salt-added diced tomatoes, with their juice; Qty = purchases, Used Servings = whole batch.
INSERT INTO `Chicken_Tikka_Masala_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 2, 7.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('No Salt Added Diced Tomatoes 14.5 oz'))
  AND NOT EXISTS (SELECT 1 FROM `Chicken_Tikka_Masala_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

-- 2 tablespoons tomato paste; Qty = purchases, Used Servings = whole batch.
INSERT INTO `Chicken_Tikka_Masala_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 1.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Tomato Paste 6 oz'))
  AND NOT EXISTS (SELECT 1 FROM `Chicken_Tikka_Masala_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

-- 2 tablespoons garam masala, divided; Qty = purchases, Used Servings = whole batch.
INSERT INTO `Chicken_Tikka_Masala_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 6.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Garam Masala'))
  AND NOT EXISTS (SELECT 1 FROM `Chicken_Tikka_Masala_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

-- 2 teaspoons sweet paprika; Qty = purchases, Used Servings = whole batch.
INSERT INTO `Chicken_Tikka_Masala_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 2.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Paprika'))
  AND NOT EXISTS (SELECT 1 FROM `Chicken_Tikka_Masala_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

-- 1 teaspoon ground turmeric; Qty = purchases, Used Servings = whole batch.
INSERT INTO `Chicken_Tikka_Masala_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 1.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Ground Turmeric'))
  AND NOT EXISTS (SELECT 1 FROM `Chicken_Tikka_Masala_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

-- 2 teaspoons ground cumin; Qty = purchases, Used Servings = whole batch.
INSERT INTO `Chicken_Tikka_Masala_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 2.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Ground Cumin'))
  AND NOT EXISTS (SELECT 1 FROM `Chicken_Tikka_Masala_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

-- 1 teaspoon salt; Qty = purchases, Used Servings = whole batch.
INSERT INTO `Chicken_Tikka_Masala_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 1.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Salt'))
  AND NOT EXISTS (SELECT 1 FROM `Chicken_Tikka_Masala_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

-- 1/2 cup heavy cream; Qty = purchases, Used Servings = whole batch.
INSERT INTO `Chicken_Tikka_Masala_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 8.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Heavy Cream'))
  AND NOT EXISTS (SELECT 1 FROM `Chicken_Tikka_Masala_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

-- 1/2 cup plain whole-milk yogurt; Qty = purchases, Used Servings = whole batch.
INSERT INTO `Chicken_Tikka_Masala_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 1.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Plain Whole Milk Yogurt'))
  AND NOT EXISTS (SELECT 1 FROM `Chicken_Tikka_Masala_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

-- 1 tablespoon lemon juice; Qty = purchases, Used Servings = whole batch.
INSERT INTO `Chicken_Tikka_Masala_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 1.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Lemon Juice'))
  AND NOT EXISTS (SELECT 1 FROM `Chicken_Tikka_Masala_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

-- 1/4 cup chopped cilantro; Qty = purchases, Used Servings = whole batch.
INSERT INTO `Chicken_Tikka_Masala_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 4.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Cilantro'))
  AND NOT EXISTS (SELECT 1 FROM `Chicken_Tikka_Masala_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

-- White Chicken Chili: one batch makes 7 servings.
INSERT INTO `recipe_lists` (`recipe_name`, `url`)
SELECT 'White_Chicken_Chili_recipe_table', ''
WHERE NOT EXISTS (SELECT 1 FROM `recipe_lists` WHERE `recipe_name` = 'White_Chicken_Chili_recipe_table');

-- 3 lb boneless skinless chicken thighs, thawed; Qty = purchases, Used Servings = whole batch.
INSERT INTO `White_Chicken_Chili_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 12.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Boneless Skinless Chicken Thighs'))
  AND NOT EXISTS (SELECT 1 FROM `White_Chicken_Chili_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

-- 1 tablespoon olive oil; Qty = purchases, Used Servings = whole batch.
INSERT INTO `White_Chicken_Chili_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 1.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Olive Oil'))
  AND NOT EXISTS (SELECT 1 FROM `White_Chicken_Chili_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

-- 1 cup frozen chopped onion; Qty = purchases, Used Servings = whole batch.
INSERT INTO `White_Chicken_Chili_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 1.500, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Frozen Onion'))
  AND NOT EXISTS (SELECT 1 FROM `White_Chicken_Chili_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

-- 6 garlic cloves, finely chopped; Qty = purchases, Used Servings = whole batch.
INSERT INTO `White_Chicken_Chili_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 6, 6.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Garlic Clove'))
  AND NOT EXISTS (SELECT 1 FROM `White_Chicken_Chili_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

-- 4 cups low-sodium chicken broth; Qty = purchases, Used Servings = whole batch.
INSERT INTO `White_Chicken_Chili_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 4.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Chicken broth'))
  AND NOT EXISTS (SELECT 1 FROM `White_Chicken_Chili_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

-- 2 cans (4 oz each) mild diced roasted green chiles, with their liquid; Qty = purchases, Used Servings = whole batch.
INSERT INTO `White_Chicken_Chili_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 2, 8.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Diced Roasted Green Chiles 4 oz'))
  AND NOT EXISTS (SELECT 1 FROM `White_Chicken_Chili_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

-- 2 teaspoons ground cumin; Qty = purchases, Used Servings = whole batch.
INSERT INTO `White_Chicken_Chili_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 2.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Ground Cumin'))
  AND NOT EXISTS (SELECT 1 FROM `White_Chicken_Chili_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

-- 1 teaspoon dried oregano; Qty = purchases, Used Servings = whole batch.
INSERT INTO `White_Chicken_Chili_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 1.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Oregeno'))
  AND NOT EXISTS (SELECT 1 FROM `White_Chicken_Chili_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

-- 1/2 teaspoon ground black pepper; Qty = purchases, Used Servings = whole batch.
INSERT INTO `White_Chicken_Chili_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 2.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Black pepper'))
  AND NOT EXISTS (SELECT 1 FROM `White_Chicken_Chili_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

-- 3 cans (15 oz each) cannellini beans, drained and rinsed; Qty = purchases, Used Servings = whole batch.
INSERT INTO `White_Chicken_Chili_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 3, 9.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Cannellini Beans 15 oz'))
  AND NOT EXISTS (SELECT 1 FROM `White_Chicken_Chili_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

-- 2 cups frozen corn; Qty = purchases, Used Servings = whole batch.
INSERT INTO `White_Chicken_Chili_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 4.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('frozen corn'))
  AND NOT EXISTS (SELECT 1 FROM `White_Chicken_Chili_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

-- 8 oz cream cheese, cut into small cubes; Qty = purchases, Used Servings = whole batch.
INSERT INTO `White_Chicken_Chili_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 8.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Cream cheese 1 pack'))
  AND NOT EXISTS (SELECT 1 FROM `White_Chicken_Chili_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

-- 2 tablespoons lime juice; Qty = purchases, Used Servings = whole batch.
INSERT INTO `White_Chicken_Chili_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 2.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Lime Juice'))
  AND NOT EXISTS (SELECT 1 FROM `White_Chicken_Chili_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

-- 1/4 cup chopped cilantro; Qty = purchases, Used Servings = whole batch.
INSERT INTO `White_Chicken_Chili_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 4.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Cilantro'))
  AND NOT EXISTS (SELECT 1 FROM `White_Chicken_Chili_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

-- Cajun Jambalaya: one batch makes 7 servings.
INSERT INTO `recipe_lists` (`recipe_name`, `url`)
SELECT 'Cajun_Jambalaya_recipe_table', ''
WHERE NOT EXISTS (SELECT 1 FROM `recipe_lists` WHERE `recipe_name` = 'Cajun_Jambalaya_recipe_table');

-- 2 lb boneless skinless chicken thighs, cut into 1 1/2-inch pieces; Qty = purchases, Used Servings = whole batch.
INSERT INTO `Cajun_Jambalaya_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 8.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Boneless Skinless Chicken Thighs'))
  AND NOT EXISTS (SELECT 1 FROM `Cajun_Jambalaya_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

-- 1 lb fully cooked andouille sausage, cut into 1/4-inch slices; Qty = purchases, Used Servings = whole batch.
INSERT INTO `Cajun_Jambalaya_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 2, 8.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Fully Cooked Andouille Sausage 12 oz'))
  AND NOT EXISTS (SELECT 1 FROM `Cajun_Jambalaya_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

-- 1 tablespoon olive oil; Qty = purchases, Used Servings = whole batch.
INSERT INTO `Cajun_Jambalaya_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 1.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Olive Oil'))
  AND NOT EXISTS (SELECT 1 FROM `Cajun_Jambalaya_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

-- 1 cup frozen chopped onion; Qty = purchases, Used Servings = whole batch.
INSERT INTO `Cajun_Jambalaya_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 1.500, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Frozen Onion'))
  AND NOT EXISTS (SELECT 1 FROM `Cajun_Jambalaya_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

-- 2 medium bell peppers, seeded and chopped; Qty = purchases, Used Servings = whole batch.
INSERT INTO `Cajun_Jambalaya_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 2, 2.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Bell Pepper'))
  AND NOT EXISTS (SELECT 1 FROM `Cajun_Jambalaya_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

-- 3 medium celery stalks, chopped; Qty = purchases, Used Servings = whole batch.
INSERT INTO `Cajun_Jambalaya_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 1.500, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Celery'))
  AND NOT EXISTS (SELECT 1 FROM `Cajun_Jambalaya_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

-- 6 garlic cloves, finely chopped; Qty = purchases, Used Servings = whole batch.
INSERT INTO `Cajun_Jambalaya_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 6, 6.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Garlic Clove'))
  AND NOT EXISTS (SELECT 1 FROM `Cajun_Jambalaya_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

-- 2 tablespoons low-salt Cajun seasoning; Qty = purchases, Used Servings = whole batch.
INSERT INTO `Cajun_Jambalaya_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 6.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Cajun Spice'))
  AND NOT EXISTS (SELECT 1 FROM `Cajun_Jambalaya_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

-- 1 teaspoon smoked paprika; Qty = purchases, Used Servings = whole batch.
INSERT INTO `Cajun_Jambalaya_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 1.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Smoked Paprika'))
  AND NOT EXISTS (SELECT 1 FROM `Cajun_Jambalaya_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

-- 2 1/4 cups low-sodium chicken broth; Qty = purchases, Used Servings = whole batch.
INSERT INTO `Cajun_Jambalaya_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 2.250, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Chicken broth'))
  AND NOT EXISTS (SELECT 1 FROM `Cajun_Jambalaya_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

-- 1 can (14.5 oz) no-salt-added diced tomatoes, with the juice; Qty = purchases, Used Servings = whole batch.
INSERT INTO `Cajun_Jambalaya_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 3.500, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('No Salt Added Diced Tomatoes 14.5 oz'))
  AND NOT EXISTS (SELECT 1 FROM `Cajun_Jambalaya_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

-- 2 bay leaves; Qty = purchases, Used Servings = whole batch.
INSERT INTO `Cajun_Jambalaya_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 2.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Bay Leaves'))
  AND NOT EXISTS (SELECT 1 FROM `Cajun_Jambalaya_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

-- 2 cups dry long-grain white rice, not instant or brown rice; Qty = purchases, Used Servings = whole batch.
INSERT INTO `Cajun_Jambalaya_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 8.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Long Grain Rice'))
  AND NOT EXISTS (SELECT 1 FROM `Cajun_Jambalaya_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

-- 4 cups tap water for the rice, or the amount its package specifies for 2 cups dry rice; Qty = purchases, Used Servings = whole batch.
INSERT INTO `Cajun_Jambalaya_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 0, 4.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(`grocery_item`)) = LOWER('Water From Sink'))
  AND NOT EXISTS (SELECT 1 FROM `Cajun_Jambalaya_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

COMMIT;

-- Report: expect 12 recipes with the ingredient counts listed below.

SELECT 'Creamy Cajun Chicken' AS recipe, COUNT(*) AS ingredient_rows, 10 AS expected_rows, 7 AS meal_servings FROM `Creamy_Cajun_Chicken_recipe_table`
UNION ALL
SELECT 'Tuscan Chicken' AS recipe, COUNT(*) AS ingredient_rows, 12 AS expected_rows, 7 AS meal_servings FROM `Tuscan_Chicken_recipe_table`
UNION ALL
SELECT 'Buffalo Chicken Mac and Cheese' AS recipe, COUNT(*) AS ingredient_rows, 11 AS expected_rows, 7 AS meal_servings FROM `Buffalo_Chicken_Mac_and_Cheese_recipe_table`
UNION ALL
SELECT 'Mississippi Pot Roast' AS recipe, COUNT(*) AS ingredient_rows, 7 AS expected_rows, 7 AS meal_servings FROM `Mississippi_Pot_Roast_recipe_table`
UNION ALL
SELECT 'Beef Birria' AS recipe, COUNT(*) AS ingredient_rows, 17 AS expected_rows, 7 AS meal_servings FROM `Beef_Birria_recipe_table`
UNION ALL
SELECT 'Hungarian Beef Goulash' AS recipe, COUNT(*) AS ingredient_rows, 15 AS expected_rows, 7 AS meal_servings FROM `Hungarian_Beef_Goulash_recipe_table`
UNION ALL
SELECT 'Korean Spicy Pulled Pork' AS recipe, COUNT(*) AS ingredient_rows, 12 AS expected_rows, 7 AS meal_servings FROM `Korean_Spicy_Pulled_Pork_recipe_table`
UNION ALL
SELECT 'Filipino Pork Adobo' AS recipe, COUNT(*) AS ingredient_rows, 8 AS expected_rows, 7 AS meal_servings FROM `Filipino_Pork_Adobo_recipe_table`
UNION ALL
SELECT 'Smoky BBQ Pulled Pork' AS recipe, COUNT(*) AS ingredient_rows, 11 AS expected_rows, 7 AS meal_servings FROM `Smoky_BBQ_Pulled_Pork_recipe_table`
UNION ALL
SELECT 'Chicken Tikka Masala' AS recipe, COUNT(*) AS ingredient_rows, 17 AS expected_rows, 7 AS meal_servings FROM `Chicken_Tikka_Masala_recipe_table`
UNION ALL
SELECT 'White Chicken Chili' AS recipe, COUNT(*) AS ingredient_rows, 14 AS expected_rows, 7 AS meal_servings FROM `White_Chicken_Chili_recipe_table`
UNION ALL
SELECT 'Cajun Jambalaya' AS recipe, COUNT(*) AS ingredient_rows, 14 AS expected_rows, 7 AS meal_servings FROM `Cajun_Jambalaya_recipe_table`;


-- Foods still needing product-label nutrition or a price (includes preexisting blanks).
SELECT `ID`, `grocery_item`, `price`, `servings`, `protein`, `fat`, `carbs`, `calories`, `fiber`
FROM `items`
WHERE LOWER(TRIM(`grocery_item`)) IN ('dried ancho peppers', 'fully cooked andouille sausage 12 oz', 'au jus gravy mix 1 oz', 'bay leaves', 'smoky barbecue sauce', 'cannellini beans 15 oz', 'boneless beef chuck roast', 'beef broth', 'bell pepper', 'brown sugar', 'butter 4 pack', 'cajun spice', 'caraway seeds', 'celery', 'cheddar cheese block', 'boneless skinless chicken thighs', 'chicken broth', 'diced roasted green chiles 4 oz', 'cilantro', 'cinnamon sticks', 'ground cloves', 'frozen corn', 'cornstarch 16 oz', 'heavy cream', 'cream cheese 1 pack', 'ground cumin', 'garam masala', 'garlic clove', 'garlic powder', 'fresh ginger root', 'gochujang korean chili paste', 'dried guajillo peppers', 'franks hot sauce', 'italan seasoning', 'lemon juice', 'lime juice', 'elbow macaroni 16 oz', 'milk', 'olive oil', 'frozen onion', 'onion powder', 'oregeno', 'paprika', 'parmesan', 'black pepper', 'pepperchini', 'pork shoulder', 'ranch seasoning mix', 'long grain rice', 'salt', 'toasted sesame oil', 'smoked paprika', 'sour cream', 'soy sauce', 'fresh baby spinach 5 oz', 'sun-dried tomatoes in oil', 'tomato paste 6 oz', 'no salt added diced tomatoes 14.5 oz', 'ground turmeric', 'apple cider vinegar', 'water from sink', 'white vinegar', 'plain whole milk yogurt')
  AND (`price` IS NULL OR `protein` IS NULL OR `fat` IS NULL OR `carbs` IS NULL OR `calories` IS NULL OR `fiber` IS NULL)
ORDER BY `grocery_item`;
