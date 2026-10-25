-- Instant Pot recipe import for voncloft/shopping-list-website
-- Source snapshot: 3b36b5d48fc4f2932e9c1179a87726cf5e0356c1
-- Only new food records, seven recipe tables and their recipe_lists rows.
-- Existing food IDs, names, URLs, prices and nutrition are preserved.
-- Per-serving item nutrition is multiplied by used_servings, then divided by 7.
-- See IMPORT-NOTES.txt for explicit serving-size assumptions and generic estimates.
-- Run in one connection, without --force. DDL auto-commits in MySQL/MariaDB.
-- Do NOT import database_setup over your live database.
USE `shopping_list`;
SET NAMES utf8mb4;


CREATE TABLE IF NOT EXISTS `Chipotle_Beef_Barbacoa_recipe_table` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `qty` int(11) NOT NULL,
  `used_servings` decimal(10,3) DEFAULT NULL,
  `ingredient_name` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `Creamy_Garlic_Parmesan_Chicken_recipe_table` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `qty` int(11) NOT NULL,
  `used_servings` decimal(10,3) DEFAULT NULL,
  `ingredient_name` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `Pork_Carnitas_recipe_table` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `qty` int(11) NOT NULL,
  `used_servings` decimal(10,3) DEFAULT NULL,
  `ingredient_name` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `Beef_Stroganoff_recipe_table` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `qty` int(11) NOT NULL,
  `used_servings` decimal(10,3) DEFAULT NULL,
  `ingredient_name` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `Buffalo_Shredded_Chicken_recipe_table` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `qty` int(11) NOT NULL,
  `used_servings` decimal(10,3) DEFAULT NULL,
  `ingredient_name` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `Pork_Chile_Verde_recipe_table` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `qty` int(11) NOT NULL,
  `used_servings` decimal(10,3) DEFAULT NULL,
  `ingredient_name` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `Italian_Meatballs_in_Marinara_recipe_table` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `qty` int(11) NOT NULL,
  `used_servings` decimal(10,3) DEFAULT NULL,
  `ingredient_name` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

START TRANSACTION;

-- oil: 1 tbsp (14 g)
INSERT INTO `items` (`grocery_item`, `price`, `department`, `pantryqty`, `servings`, `protein`, `fat`, `carbs`, `calories`, `fiber`, `url`)
SELECT 'Olive Oil', NULL, 'A15', '0', 7, 0, 14, 0, 120, 0, 'https://www.walmart.com/ip/Great-Value-Extra-Virgin-Olive-Oil-17-fl-oz/10315102?fulfillmentIntent=In-store&filters=%5B%7B%22intent%22%3A%22fulfillmentIntent%22%2C%22values%22%3A%5B%22In-store%22%5D%7D%5D&classType=VARIANT&athbdg=L1200&from=/search'
WHERE NOT EXISTS (SELECT 1 FROM `items` WHERE LOWER(TRIM(grocery_item)) = LOWER('Olive Oil'));

-- onion: 1 large onion (200 g)
INSERT INTO `items` (`grocery_item`, `price`, `department`, `pantryqty`, `servings`, `protein`, `fat`, `carbs`, `calories`, `fiber`, `url`)
SELECT 'Onion', NULL, 'A01', '0', 7, 0, 0, 0, 0, 0, 'https://www.walmart.com/ip/Fresh-Whole-Red-Onion-Each/51259215?fulfillmentIntent=In-store&filters=%5B%7B%22intent%22%3A%22fulfillmentIntent%22%2C%22values%22%3A%5B%22In-store%22%5D%7D%5D&classType=REGULAR&athbdg=L1100&from=/search'
WHERE NOT EXISTS (SELECT 1 FROM `items` WHERE LOWER(TRIM(grocery_item)) = LOWER('Onion'));

-- garlic: 1 clove (3 g)
INSERT INTO `items` (`grocery_item`, `price`, `department`, `pantryqty`, `servings`, `protein`, `fat`, `carbs`, `calories`, `fiber`, `url`)
SELECT 'Garlic Clove', NULL, 'A01', '0', 7, 0.18, 0.01, 0.93, 4, 0.06, ''
WHERE NOT EXISTS (SELECT 1 FROM `items` WHERE LOWER(TRIM(grocery_item)) = LOWER('Garlic Clove'));

-- beef_broth: 1 cup (240 ml)
INSERT INTO `items` (`grocery_item`, `price`, `department`, `pantryqty`, `servings`, `protein`, `fat`, `carbs`, `calories`, `fiber`, `url`)
SELECT 'Beef Broth', NULL, 'Cooking', '0', 7, 2, 0, 1, 10, 0, 'https://www.walmart.com/ip/Swanson-100-Natural-Beef-Broth-32-oz-Carton/20850616?fulfillmentIntent=In-store&filters=%5B%7B%22intent%22%3A%22fulfillmentIntent%22%2C%22values%22%3A%5B%22In-store%22%5D%7D%5D&classType=VARIANT&athbdg=L1300&from=/search'
WHERE NOT EXISTS (SELECT 1 FROM `items` WHERE LOWER(TRIM(grocery_item)) = LOWER('Beef Broth'));

-- chicken_broth: 1 cup (240 ml)
INSERT INTO `items` (`grocery_item`, `price`, `department`, `pantryqty`, `servings`, `protein`, `fat`, `carbs`, `calories`, `fiber`, `url`)
SELECT 'Chicken broth', NULL, 'Cooking', '0', 7, 1, 0, 1, 10, 0, ''
WHERE NOT EXISTS (SELECT 1 FROM `items` WHERE LOWER(TRIM(grocery_item)) = LOWER('Chicken broth'));

-- vinegar: 1 tbsp (15 ml)
INSERT INTO `items` (`grocery_item`, `price`, `department`, `pantryqty`, `servings`, `protein`, `fat`, `carbs`, `calories`, `fiber`, `url`)
SELECT 'Apple Cider Vinegar', NULL, 'A15', '0', 7, 0, 0, 0, 0, 0, 'https://www.walmart.com/ip/Vinegar-Apple-Cider-Unf-Org-32-OZ-Pack-Of-3/32590745?fulfillmentIntent=In-store&filters=%5B%7B%22intent%22%3A%22fulfillmentIntent%22%2C%22values%22%3A%5B%22In-store%22%5D%7D%5D&classType=REGULAR&athbdg=L1100&from=/search'
WHERE NOT EXISTS (SELECT 1 FROM `items` WHERE LOWER(TRIM(grocery_item)) = LOWER('Apple Cider Vinegar'));

-- chipotle: 2 tbsp (30 g)
INSERT INTO `items` (`grocery_item`, `price`, `department`, `pantryqty`, `servings`, `protein`, `fat`, `carbs`, `calories`, `fiber`, `url`)
SELECT 'Chopped Chipotles in adobo sauce', NULL, 'A13', '0', 7, 1, 0, 4, 20, 1, 'https://www.walmart.com/ip/La-Coste-a-Chipotle-Peppers-in-Adobo-Sauce-7-oz/13424766?fulfillmentIntent=In-store&filters=%5B%7B%22intent%22%3A%22fulfillmentIntent%22%2C%22values%22%3A%5B%22In-store%22%5D%7D%5D&classType=VARIANT&athbdg=L1600&from=/search'
WHERE NOT EXISTS (SELECT 1 FROM `items` WHERE LOWER(TRIM(grocery_item)) = LOWER('Chopped Chipotles in adobo sauce'));

-- cumin: 1 tsp (2 g)
INSERT INTO `items` (`grocery_item`, `price`, `department`, `pantryqty`, `servings`, `protein`, `fat`, `carbs`, `calories`, `fiber`, `url`)
SELECT 'Ground Cumin', NULL, 'A14', '0', 7, 0, 0, 0, 0, 0, 'https://www.walmart.com/ip/Great-Value-Ground-Cumin-2-5-oz/985501095?fulfillmentIntent=In-store&filters=%5B%7B%22intent%22%3A%22fulfillmentIntent%22%2C%22values%22%3A%5B%22In-store%22%5D%7D%5D&classType=VARIANT&athbdg=L1200&from=/search'
WHERE NOT EXISTS (SELECT 1 FROM `items` WHERE LOWER(TRIM(grocery_item)) = LOWER('Ground Cumin'));

-- oregano: 1 tsp (1 g)
INSERT INTO `items` (`grocery_item`, `price`, `department`, `pantryqty`, `servings`, `protein`, `fat`, `carbs`, `calories`, `fiber`, `url`)
SELECT 'Oregeno', NULL, 'A14', '0', 7, 0, 0, 0, 0, 0, 'https://www.walmart.com/ip/Great-Value-Oregano-Leaves-0-87-oz/631368530?fulfillmentIntent=In-store&filters=%5B%7B%22intent%22%3A%22fulfillmentIntent%22%2C%22values%22%3A%5B%22In-store%22%5D%7D%5D&classType=REGULAR&athbdg=L1200&from=/search'
WHERE NOT EXISTS (SELECT 1 FROM `items` WHERE LOWER(TRIM(grocery_item)) = LOWER('Oregeno'));

-- salt: 1 tsp (6 g)
INSERT INTO `items` (`grocery_item`, `price`, `department`, `pantryqty`, `servings`, `protein`, `fat`, `carbs`, `calories`, `fiber`, `url`)
SELECT 'Salt', NULL, 'A14', '0', 7, 0, 0, 0, 0, 0, 'https://www.walmart.com/ip/Morton-Iodized-Salt-26-oz/10448936?fulfillmentIntent=In-store&filters=%5B%7B%22intent%22%3A%22fulfillmentIntent%22%2C%22values%22%3A%5B%22In-store%22%5D%7D%5D&classType=VARIANT&athbdg=L1600&from=/search'
WHERE NOT EXISTS (SELECT 1 FROM `items` WHERE LOWER(TRIM(grocery_item)) = LOWER('Salt'));

-- pepper: 1/4 tsp (0.5 g)
INSERT INTO `items` (`grocery_item`, `price`, `department`, `pantryqty`, `servings`, `protein`, `fat`, `carbs`, `calories`, `fiber`, `url`)
SELECT 'Black pepper', NULL, 'A14', '0', 7, 0, 0, 0, 0, 0, 'https://www.walmart.com/ip/McCormick-Non-GMO-Kosher-Pure-Ground-Black-Pepper-1-5-oz-Can/44981957?fulfillmentIntent=In-store&filters=%5B%7B%22intent%22%3A%22fulfillmentIntent%22%2C%22values%22%3A%5B%22In-store%22%5D%7D%5D&classType=REGULAR&athbdg=L1102&from=/search'
WHERE NOT EXISTS (SELECT 1 FROM `items` WHERE LOWER(TRIM(grocery_item)) = LOWER('Black pepper'));

-- lime: 1 tbsp (15 ml)
INSERT INTO `items` (`grocery_item`, `price`, `department`, `pantryqty`, `servings`, `protein`, `fat`, `carbs`, `calories`, `fiber`, `url`)
SELECT 'Lime Juice', NULL, 'Juice', '0', 7, 0, 0, 0, 0, 0, ''
WHERE NOT EXISTS (SELECT 1 FROM `items` WHERE LOWER(TRIM(grocery_item)) = LOWER('Lime Juice'));

-- italian: 1 tsp (1 g)
INSERT INTO `items` (`grocery_item`, `price`, `department`, `pantryqty`, `servings`, `protein`, `fat`, `carbs`, `calories`, `fiber`, `url`)
SELECT 'Italan Seasoning', NULL, 'Spices', '0', 7, 0, 0, 0, 0, 0, ''
WHERE NOT EXISTS (SELECT 1 FROM `items` WHERE LOWER(TRIM(grocery_item)) = LOWER('Italan Seasoning'));

-- cream: 1 tbsp (15 ml)
INSERT INTO `items` (`grocery_item`, `price`, `department`, `pantryqty`, `servings`, `protein`, `fat`, `carbs`, `calories`, `fiber`, `url`)
SELECT 'Heavy Cream', NULL, 'A35', '0', 7, 0, 5, 0, 50, 0, 'https://www.walmart.com/ip/Great-Value-Heavy-Whipping-Cream-16-oz-Carton-Refrigerated/10450339?fulfillmentIntent=In-store&filters=%5B%7B%22intent%22%3A%22fulfillmentIntent%22%2C%22values%22%3A%5B%22In-store%22%5D%7D%5D&classType=REGULAR&athbdg=L1102&from=/search'
WHERE NOT EXISTS (SELECT 1 FROM `items` WHERE LOWER(TRIM(grocery_item)) = LOWER('Heavy Cream'));

-- cream_cheese: 1 oz (28.35 g)
INSERT INTO `items` (`grocery_item`, `price`, `department`, `pantryqty`, `servings`, `protein`, `fat`, `carbs`, `calories`, `fiber`, `url`)
SELECT 'Cream cheese 1 pack', NULL, 'Dairy', '0', 7, 2, 10, 0.1, 100, 0, ''
WHERE NOT EXISTS (SELECT 1 FROM `items` WHERE LOWER(TRIM(grocery_item)) = LOWER('Cream cheese 1 pack'));

-- parmesan: 5 g
INSERT INTO `items` (`grocery_item`, `price`, `department`, `pantryqty`, `servings`, `protein`, `fat`, `carbs`, `calories`, `fiber`, `url`)
SELECT 'Parmesan', NULL, 'A09', '0', 7, 2, 1.5, 0, 20, 0, 'https://www.walmart.com/ip/Kraft-Grated-Parmesan-Cheese-Shaker-8-oz-Bottle/5212438666?fulfillmentIntent=In-store&filters=%5B%7B%22intent%22%3A%22fulfillmentIntent%22%2C%22values%22%3A%5B%22In-store%22%5D%7D%5D&classType=REGULAR&athbdg=L1100&from=/search'
WHERE NOT EXISTS (SELECT 1 FROM `items` WHERE LOWER(TRIM(grocery_item)) = LOWER('Parmesan'));

-- lemon: 1 tbsp (15 ml)
INSERT INTO `items` (`grocery_item`, `price`, `department`, `pantryqty`, `servings`, `protein`, `fat`, `carbs`, `calories`, `fiber`, `url`)
SELECT 'Lemon Juice', NULL, 'Juice', '0', 7, 0, 0, 0, 0, 0, ''
WHERE NOT EXISTS (SELECT 1 FROM `items` WHERE LOWER(TRIM(grocery_item)) = LOWER('Lemon Juice'));

-- shoulder: 4 oz (113.4 g), RAW
INSERT INTO `items` (`grocery_item`, `price`, `department`, `pantryqty`, `servings`, `protein`, `fat`, `carbs`, `calories`, `fiber`, `url`)
SELECT 'Pork shoulder ', NULL, 'Meat', '0', 7, 31, 29, 0, 394, 0, ''
WHERE NOT EXISTS (SELECT 1 FROM `items` WHERE LOWER(TRIM(grocery_item)) = LOWER('Pork shoulder'));

-- butter: 1 tbsp (14 g)
INSERT INTO `items` (`grocery_item`, `price`, `department`, `pantryqty`, `servings`, `protein`, `fat`, `carbs`, `calories`, `fiber`, `url`)
SELECT 'Butter 4 pack', NULL, 'Dairy', '0', 7, 0, 11, 0, 100, 0, 'https://www.walmart.com/ip/Land-O-Lakes-Salted-Stick-Butter-16-oz-4-Sticks/10291058?fulfillmentIntent=In-store&filters=%5B%7B%22intent%22%3A%22fulfillmentIntent%22%2C%22values%22%3A%5B%22In-store%22%5D%7D%5D&classType=REGULAR&athbdg=L1300&from=/search'
WHERE NOT EXISTS (SELECT 1 FROM `items` WHERE LOWER(TRIM(grocery_item)) = LOWER('Butter 4 pack'));

-- mushrooms: 3 oz (85 g)
INSERT INTO `items` (`grocery_item`, `price`, `department`, `pantryqty`, `servings`, `protein`, `fat`, `carbs`, `calories`, `fiber`, `url`)
SELECT 'Mushrooms', NULL, 'A01', '0', 7, 3, 0, 3, 20, 1, 'https://www.walmart.com/ip/Freshness-Guaranteed-Sliced-White-Mushrooms-8-oz/10449184?fulfillmentIntent=In-store&filters=%5B%7B%22intent%22%3A%22fulfillmentIntent%22%2C%22values%22%3A%5B%22In-store%22%5D%7D%5D&classType=REGULAR&athbdg=L1102&from=/search'
WHERE NOT EXISTS (SELECT 1 FROM `items` WHERE LOWER(TRIM(grocery_item)) = LOWER('Mushrooms'));

-- worcestershire: 1 tsp (5 ml)
INSERT INTO `items` (`grocery_item`, `price`, `department`, `pantryqty`, `servings`, `protein`, `fat`, `carbs`, `calories`, `fiber`, `url`)
SELECT 'Worcestershire sauce', NULL, 'A08', '0', 7, 0, 0, 0, 0, 0, ''
WHERE NOT EXISTS (SELECT 1 FROM `items` WHERE LOWER(TRIM(grocery_item)) = LOWER('Worcestershire sauce'));

-- sour_cream: 2 tbsp (30 g)
INSERT INTO `items` (`grocery_item`, `price`, `department`, `pantryqty`, `servings`, `protein`, `fat`, `carbs`, `calories`, `fiber`, `url`)
SELECT 'Sour Cream', NULL, 'Dairy', '0', 7, 1, 5, 1, 60, 0, ''
WHERE NOT EXISTS (SELECT 1 FROM `items` WHERE LOWER(TRIM(grocery_item)) = LOWER('Sour Cream'));

-- garlic_powder: 1 tsp (3 g)
INSERT INTO `items` (`grocery_item`, `price`, `department`, `pantryqty`, `servings`, `protein`, `fat`, `carbs`, `calories`, `fiber`, `url`)
SELECT 'Garlic Powder', NULL, 'A14', '0', 7, 0, 0, 0, 0, 0, 'https://www.walmart.com/ip/McCormick-Kosher-Garlic-Powder-3-12-oz-Bottle/10535033?fulfillmentIntent=In-store&filters=%5B%7B%22intent%22%3A%22fulfillmentIntent%22%2C%22values%22%3A%5B%22In-store%22%5D%7D%5D&classType=VARIANT&athbdg=L1102&from=/search'
WHERE NOT EXISTS (SELECT 1 FROM `items` WHERE LOWER(TRIM(grocery_item)) = LOWER('Garlic Powder'));

-- onion_powder: 1 tsp (2.5 g)
INSERT INTO `items` (`grocery_item`, `price`, `department`, `pantryqty`, `servings`, `protein`, `fat`, `carbs`, `calories`, `fiber`, `url`)
SELECT 'Onion Powder', NULL, 'Spices', '0', 7, 0, 0, 0, 0, 0, ''
WHERE NOT EXISTS (SELECT 1 FROM `items` WHERE LOWER(TRIM(grocery_item)) = LOWER('Onion Powder'));

-- hot_sauce: 1 tsp (5 ml)
INSERT INTO `items` (`grocery_item`, `price`, `department`, `pantryqty`, `servings`, `protein`, `fat`, `carbs`, `calories`, `fiber`, `url`)
SELECT 'Franks Hot Sauce', NULL, 'A09', '0', 7, 0, 0, 0, 0, 0, 'https://www.walmart.com/ip/Frank-s-RedHot-Kosher-Xtra-Hot-Sauce-12-fl-oz-Bottle/17247772?fulfillmentIntent=In-store&filters=%5B%7B%22intent%22%3A%22fulfillmentIntent%22%2C%22values%22%3A%5B%22In-store%22%5D%7D%5D&classType=REGULAR&athbdg=L1100&from=/search'
WHERE NOT EXISTS (SELECT 1 FROM `items` WHERE LOWER(TRIM(grocery_item)) = LOWER('Franks Hot Sauce'));

-- cilantro: 1 tbsp chopped (1 g)
INSERT INTO `items` (`grocery_item`, `price`, `department`, `pantryqty`, `servings`, `protein`, `fat`, `carbs`, `calories`, `fiber`, `url`)
SELECT 'Cilantro', NULL, 'A01', '0', 7, 0, 0, 0, 0, 0, ''
WHERE NOT EXISTS (SELECT 1 FROM `items` WHERE LOWER(TRIM(grocery_item)) = LOWER('Cilantro'));

-- milk: 1 cup (240 ml)
INSERT INTO `items` (`grocery_item`, `price`, `department`, `pantryqty`, `servings`, `protein`, `fat`, `carbs`, `calories`, `fiber`, `url`)
SELECT 'Milk', NULL, 'Dairy', '0', 7, 0, 0, 0, 0, 0, 'https://www.walmart.com/ip/Prairie-Farms-Whole-Vitamin-D-Milk-Half-Gallon-64-fl-oz/43269801?fulfillmentIntent=In-store&filters=%5B%7B%22intent%22%3A%22fulfillmentIntent%22%2C%22values%22%3A%5B%22In-store%22%5D%7D%5D&classType=REGULAR&from=/search'
WHERE NOT EXISTS (SELECT 1 FROM `items` WHERE LOWER(TRIM(grocery_item)) = LOWER('Milk'));

-- eggs: 1 large egg
INSERT INTO `items` (`grocery_item`, `price`, `department`, `pantryqty`, `servings`, `protein`, `fat`, `carbs`, `calories`, `fiber`, `url`)
SELECT 'Eggs-6 pack', NULL, 'A26', '0', 7, 6, 5, 0, 70, 0, 'https://www.walmart.com/ip/Great-Value-Large-White-Eggs-6-Count/172144435?fulfillmentIntent=In-store&filters=%5B%7B%22intent%22%3A%22fulfillmentIntent%22%2C%22values%22%3A%5B%22In-store%22%5D%7D%5D&classType=REGULAR&athbdg=L1100&from=/search'
WHERE NOT EXISTS (SELECT 1 FROM `items` WHERE LOWER(TRIM(grocery_item)) = LOWER('Eggs-6 pack'));

-- water: water; no nutrition
INSERT INTO `items` (`grocery_item`, `price`, `department`, `pantryqty`, `servings`, `protein`, `fat`, `carbs`, `calories`, `fiber`, `url`)
SELECT 'Water From Sink', NULL, '0', '0', 0, 0, 0, 0, 0, 0, 'None'
WHERE NOT EXISTS (SELECT 1 FROM `items` WHERE LOWER(TRIM(grocery_item)) = LOWER('Water From Sink'));

-- chuck: 4 oz (113.4 g), raw
INSERT INTO `items` (`grocery_item`, `price`, `department`, `pantryqty`, `servings`, `protein`, `fat`, `carbs`, `calories`, `fiber`, `url`)
SELECT 'Boneless Beef Chuck Roast', NULL, 'Meat', '0', 1, 21.55, 18.14, 0, 249.5, 0, ''
WHERE NOT EXISTS (SELECT 1 FROM `items` WHERE LOWER(TRIM(grocery_item)) = LOWER('Boneless Beef Chuck Roast'));

-- thigh: 4 oz (113.4 g), raw
INSERT INTO `items` (`grocery_item`, `price`, `department`, `pantryqty`, `servings`, `protein`, `fat`, `carbs`, `calories`, `fiber`, `url`)
SELECT 'Boneless Skinless Chicken Thighs', NULL, 'Meat', '0', 1, 21.55, 8.73, 0, 164.4, 0, ''
WHERE NOT EXISTS (SELECT 1 FROM `items` WHERE LOWER(TRIM(grocery_item)) = LOWER('Boneless Skinless Chicken Thighs'));

-- bay: 1 leaf, removed after cooking
INSERT INTO `items` (`grocery_item`, `price`, `department`, `pantryqty`, `servings`, `protein`, `fat`, `carbs`, `calories`, `fiber`, `url`)
SELECT 'Bay Leaves', NULL, 'Spices', '0', 1, 0, 0, 0, 0, 0, 'https://www.walmart.com/ip/10315300'
WHERE NOT EXISTS (SELECT 1 FROM `items` WHERE LOWER(TRIM(grocery_item)) = LOWER('Bay Leaves'));

-- orange: 1 cup (240 ml)
INSERT INTO `items` (`grocery_item`, `price`, `department`, `pantryqty`, `servings`, `protein`, `fat`, `carbs`, `calories`, `fiber`, `url`)
SELECT 'Orange Juice', NULL, 'Juice', '0', 1, 1.68, 0.48, 24.96, 108, 0.48, ''
WHERE NOT EXISTS (SELECT 1 FROM `items` WHERE LOWER(TRIM(grocery_item)) = LOWER('Orange Juice'));

-- spinach: 100 g
INSERT INTO `items` (`grocery_item`, `price`, `department`, `pantryqty`, `servings`, `protein`, `fat`, `carbs`, `calories`, `fiber`, `url`)
SELECT 'Fresh Baby Spinach 5 oz', NULL, 'Produce', '0', 1, 2.9, 0.4, 3.6, 23, 2.2, ''
WHERE NOT EXISTS (SELECT 1 FROM `items` WHERE LOWER(TRIM(grocery_item)) = LOWER('Fresh Baby Spinach 5 oz'));

-- dijon: 1 tsp (5 g)
INSERT INTO `items` (`grocery_item`, `price`, `department`, `pantryqty`, `servings`, `protein`, `fat`, `carbs`, `calories`, `fiber`, `url`)
SELECT 'Dijon Mustard', NULL, 'Condiments', '0', 1, 0.22, 0.225, 0.29, 3.3, 0.165, ''
WHERE NOT EXISTS (SELECT 1 FROM `items` WHERE LOWER(TRIM(grocery_item)) = LOWER('Dijon Mustard'));

-- cornstarch: 1 tbsp (8 g)
INSERT INTO `items` (`grocery_item`, `price`, `department`, `pantryqty`, `servings`, `protein`, `fat`, `carbs`, `calories`, `fiber`, `url`)
SELECT 'Cornstarch 16 oz', NULL, 'Baking', '0', 1, 0.008, 0.008, 7.304, 30.48, 0.072, 'https://www.walmart.com/ip/54802256'
WHERE NOT EXISTS (SELECT 1 FROM `items` WHERE LOWER(TRIM(grocery_item)) = LOWER('Cornstarch 16 oz'));

-- salsa: 2 tbsp (30 g)
INSERT INTO `items` (`grocery_item`, `price`, `department`, `pantryqty`, `servings`, `protein`, `fat`, `carbs`, `calories`, `fiber`, `url`)
SELECT 'Tomatillo Salsa Verde 16 oz', NULL, 'Cooking', '0', 1, 0.3, 0.3, 1.8, 10.5, 0.45, 'https://www.walmart.com/ip/10292961'
WHERE NOT EXISTS (SELECT 1 FROM `items` WHERE LOWER(TRIM(grocery_item)) = LOWER('Tomatillo Salsa Verde 16 oz'));

-- chiles: 2 tbsp (about 28 g)
INSERT INTO `items` (`grocery_item`, `price`, `department`, `pantryqty`, `servings`, `protein`, `fat`, `carbs`, `calories`, `fiber`, `url`)
SELECT 'Diced Roasted Green Chiles 4 oz', NULL, 'Cooking', '0', 1, 0.28, 0.028, 1.428, 7, 0.448, 'https://www.walmart.com/ip/10415222'
WHERE NOT EXISTS (SELECT 1 FROM `items` WHERE LOWER(TRIM(grocery_item)) = LOWER('Diced Roasted Green Chiles 4 oz'));

-- ground_pork: 4 oz (113.4 g), raw
INSERT INTO `items` (`grocery_item`, `price`, `department`, `pantryqty`, `servings`, `protein`, `fat`, `carbs`, `calories`, `fiber`, `url`)
SELECT 'Ground Pork 1 lb', NULL, 'Meat', '0', 1, 19.16, 24.04, 0, 298.2, 0, ''
WHERE NOT EXISTS (SELECT 1 FROM `items` WHERE LOWER(TRIM(grocery_item)) = LOWER('Ground Pork 1 lb'));

-- ground_beef: 4 oz (113.4 g), raw
INSERT INTO `items` (`grocery_item`, `price`, `department`, `pantryqty`, `servings`, `protein`, `fat`, `carbs`, `calories`, `fiber`, `url`)
SELECT 'Ground Beef 85 Percent Lean 1 lb', NULL, 'Meat', '0', 1, 21.09, 17.01, 0, 243.8, 0, ''
WHERE NOT EXISTS (SELECT 1 FROM `items` WHERE LOWER(TRIM(grocery_item)) = LOWER('Ground Beef 85 Percent Lean 1 lb'));

-- breadcrumbs: 1/4 cup (20 g)
INSERT INTO `items` (`grocery_item`, `price`, `department`, `pantryqty`, `servings`, `protein`, `fat`, `carbs`, `calories`, `fiber`, `url`)
SELECT 'Plain Dry Bread Crumbs', NULL, 'Cooking', '0', 1, 2.6, 1, 14.4, 79, 0.9, ''
WHERE NOT EXISTS (SELECT 1 FROM `items` WHERE LOWER(TRIM(grocery_item)) = LOWER('Plain Dry Bread Crumbs'));

-- parsley: 1 tbsp chopped (3.75 g)
INSERT INTO `items` (`grocery_item`, `price`, `department`, `pantryqty`, `servings`, `protein`, `fat`, `carbs`, `calories`, `fiber`, `url`)
SELECT 'Fresh Parsley', NULL, 'Produce', '0', 1, 0.1125, 0.03, 0.236, 1.35, 0.124, 'https://www.walmart.com/ip/44391168'
WHERE NOT EXISTS (SELECT 1 FROM `items` WHERE LOWER(TRIM(grocery_item)) = LOWER('Fresh Parsley'));

-- marinara: 1/2 cup (125 g)
INSERT INTO `items` (`grocery_item`, `price`, `department`, `pantryqty`, `servings`, `protein`, `fat`, `carbs`, `calories`, `fiber`, `url`)
SELECT 'Raos Marinara Sauce 24 oz', NULL, 'Pasta', '0', 7, 0, 0, 0, 0, 0, ''
WHERE NOT EXISTS (SELECT 1 FROM `items` WHERE LOWER(TRIM(grocery_item)) = LOWER('Raos Marinara Sauce 24 oz'));


-- Chipotle Beef Barbacoa: ONE batch = SEVEN meals.

INSERT INTO `Chipotle_Beef_Barbacoa_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 16.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(grocery_item)) = LOWER('Boneless Beef Chuck Roast'))
  AND NOT EXISTS (SELECT 1 FROM `Chipotle_Beef_Barbacoa_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

INSERT INTO `Chipotle_Beef_Barbacoa_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 1.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(grocery_item)) = LOWER('Olive Oil'))
  AND NOT EXISTS (SELECT 1 FROM `Chipotle_Beef_Barbacoa_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

INSERT INTO `Chipotle_Beef_Barbacoa_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 1.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(grocery_item)) = LOWER('Onion'))
  AND NOT EXISTS (SELECT 1 FROM `Chipotle_Beef_Barbacoa_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

INSERT INTO `Chipotle_Beef_Barbacoa_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 6, 6.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(grocery_item)) = LOWER('Garlic Clove'))
  AND NOT EXISTS (SELECT 1 FROM `Chipotle_Beef_Barbacoa_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

INSERT INTO `Chipotle_Beef_Barbacoa_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 2.250, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(grocery_item)) = LOWER('Beef Broth'))
  AND NOT EXISTS (SELECT 1 FROM `Chipotle_Beef_Barbacoa_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

INSERT INTO `Chipotle_Beef_Barbacoa_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 4.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(grocery_item)) = LOWER('Apple Cider Vinegar'))
  AND NOT EXISTS (SELECT 1 FROM `Chipotle_Beef_Barbacoa_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

INSERT INTO `Chipotle_Beef_Barbacoa_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 2.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(grocery_item)) = LOWER('Chopped Chipotles in adobo sauce'))
  AND NOT EXISTS (SELECT 1 FROM `Chipotle_Beef_Barbacoa_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

INSERT INTO `Chipotle_Beef_Barbacoa_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 3.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(grocery_item)) = LOWER('Ground Cumin'))
  AND NOT EXISTS (SELECT 1 FROM `Chipotle_Beef_Barbacoa_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

INSERT INTO `Chipotle_Beef_Barbacoa_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 2.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(grocery_item)) = LOWER('Oregeno'))
  AND NOT EXISTS (SELECT 1 FROM `Chipotle_Beef_Barbacoa_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

INSERT INTO `Chipotle_Beef_Barbacoa_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 1.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(grocery_item)) = LOWER('Salt'))
  AND NOT EXISTS (SELECT 1 FROM `Chipotle_Beef_Barbacoa_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

INSERT INTO `Chipotle_Beef_Barbacoa_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 4.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(grocery_item)) = LOWER('Black pepper'))
  AND NOT EXISTS (SELECT 1 FROM `Chipotle_Beef_Barbacoa_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

INSERT INTO `Chipotle_Beef_Barbacoa_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 2.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(grocery_item)) = LOWER('Bay Leaves'))
  AND NOT EXISTS (SELECT 1 FROM `Chipotle_Beef_Barbacoa_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

INSERT INTO `Chipotle_Beef_Barbacoa_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 4.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(grocery_item)) = LOWER('Lime Juice'))
  AND NOT EXISTS (SELECT 1 FROM `Chipotle_Beef_Barbacoa_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

INSERT INTO `recipe_lists` (`recipe_name`, `url`)
SELECT 'Chipotle_Beef_Barbacoa_recipe_table', ''
WHERE NOT EXISTS (SELECT 1 FROM `recipe_lists` WHERE `recipe_name` = 'Chipotle_Beef_Barbacoa_recipe_table');


-- Creamy Garlic Parmesan Chicken: ONE batch = SEVEN meals.

INSERT INTO `Creamy_Garlic_Parmesan_Chicken_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 16.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(grocery_item)) = LOWER('Boneless Skinless Chicken Thighs'))
  AND NOT EXISTS (SELECT 1 FROM `Creamy_Garlic_Parmesan_Chicken_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

INSERT INTO `Creamy_Garlic_Parmesan_Chicken_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 1.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(grocery_item)) = LOWER('Olive Oil'))
  AND NOT EXISTS (SELECT 1 FROM `Creamy_Garlic_Parmesan_Chicken_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

INSERT INTO `Creamy_Garlic_Parmesan_Chicken_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 1.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(grocery_item)) = LOWER('Onion'))
  AND NOT EXISTS (SELECT 1 FROM `Creamy_Garlic_Parmesan_Chicken_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

INSERT INTO `Creamy_Garlic_Parmesan_Chicken_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 10, 10.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(grocery_item)) = LOWER('Garlic Clove'))
  AND NOT EXISTS (SELECT 1 FROM `Creamy_Garlic_Parmesan_Chicken_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

INSERT INTO `Creamy_Garlic_Parmesan_Chicken_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 2.250, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(grocery_item)) = LOWER('Chicken broth'))
  AND NOT EXISTS (SELECT 1 FROM `Creamy_Garlic_Parmesan_Chicken_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

INSERT INTO `Creamy_Garlic_Parmesan_Chicken_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 2.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(grocery_item)) = LOWER('Italan Seasoning'))
  AND NOT EXISTS (SELECT 1 FROM `Creamy_Garlic_Parmesan_Chicken_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

INSERT INTO `Creamy_Garlic_Parmesan_Chicken_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 0.500, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(grocery_item)) = LOWER('Salt'))
  AND NOT EXISTS (SELECT 1 FROM `Creamy_Garlic_Parmesan_Chicken_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

INSERT INTO `Creamy_Garlic_Parmesan_Chicken_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 4.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(grocery_item)) = LOWER('Black pepper'))
  AND NOT EXISTS (SELECT 1 FROM `Creamy_Garlic_Parmesan_Chicken_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

INSERT INTO `Creamy_Garlic_Parmesan_Chicken_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 16.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(grocery_item)) = LOWER('Heavy Cream'))
  AND NOT EXISTS (SELECT 1 FROM `Creamy_Garlic_Parmesan_Chicken_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

INSERT INTO `Creamy_Garlic_Parmesan_Chicken_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 8.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(grocery_item)) = LOWER('Cream cheese 1 pack'))
  AND NOT EXISTS (SELECT 1 FROM `Creamy_Garlic_Parmesan_Chicken_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

INSERT INTO `Creamy_Garlic_Parmesan_Chicken_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 22.600, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(grocery_item)) = LOWER('Parmesan'))
  AND NOT EXISTS (SELECT 1 FROM `Creamy_Garlic_Parmesan_Chicken_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

INSERT INTO `Creamy_Garlic_Parmesan_Chicken_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 1.420, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(grocery_item)) = LOWER('Fresh Baby Spinach 5 oz'))
  AND NOT EXISTS (SELECT 1 FROM `Creamy_Garlic_Parmesan_Chicken_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

INSERT INTO `Creamy_Garlic_Parmesan_Chicken_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 1.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(grocery_item)) = LOWER('Lemon Juice'))
  AND NOT EXISTS (SELECT 1 FROM `Creamy_Garlic_Parmesan_Chicken_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

INSERT INTO `recipe_lists` (`recipe_name`, `url`)
SELECT 'Creamy_Garlic_Parmesan_Chicken_recipe_table', ''
WHERE NOT EXISTS (SELECT 1 FROM `recipe_lists` WHERE `recipe_name` = 'Creamy_Garlic_Parmesan_Chicken_recipe_table');


-- Pork Carnitas: ONE batch = SEVEN meals.

INSERT INTO `Pork_Carnitas_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 16.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(grocery_item)) = LOWER('Pork shoulder'))
  AND NOT EXISTS (SELECT 1 FROM `Pork_Carnitas_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

INSERT INTO `Pork_Carnitas_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 1.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(grocery_item)) = LOWER('Onion'))
  AND NOT EXISTS (SELECT 1 FROM `Pork_Carnitas_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

INSERT INTO `Pork_Carnitas_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 6, 6.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(grocery_item)) = LOWER('Garlic Clove'))
  AND NOT EXISTS (SELECT 1 FROM `Pork_Carnitas_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

INSERT INTO `Pork_Carnitas_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 2.250, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(grocery_item)) = LOWER('Chicken broth'))
  AND NOT EXISTS (SELECT 1 FROM `Pork_Carnitas_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

INSERT INTO `Pork_Carnitas_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 0.500, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(grocery_item)) = LOWER('Orange Juice'))
  AND NOT EXISTS (SELECT 1 FROM `Pork_Carnitas_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

INSERT INTO `Pork_Carnitas_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 4.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(grocery_item)) = LOWER('Lime Juice'))
  AND NOT EXISTS (SELECT 1 FROM `Pork_Carnitas_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

INSERT INTO `Pork_Carnitas_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 3.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(grocery_item)) = LOWER('Ground Cumin'))
  AND NOT EXISTS (SELECT 1 FROM `Pork_Carnitas_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

INSERT INTO `Pork_Carnitas_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 2.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(grocery_item)) = LOWER('Oregeno'))
  AND NOT EXISTS (SELECT 1 FROM `Pork_Carnitas_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

INSERT INTO `Pork_Carnitas_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 1.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(grocery_item)) = LOWER('Salt'))
  AND NOT EXISTS (SELECT 1 FROM `Pork_Carnitas_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

INSERT INTO `Pork_Carnitas_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 4.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(grocery_item)) = LOWER('Black pepper'))
  AND NOT EXISTS (SELECT 1 FROM `Pork_Carnitas_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

INSERT INTO `Pork_Carnitas_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 2.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(grocery_item)) = LOWER('Bay Leaves'))
  AND NOT EXISTS (SELECT 1 FROM `Pork_Carnitas_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

INSERT INTO `Pork_Carnitas_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 1.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(grocery_item)) = LOWER('Olive Oil'))
  AND NOT EXISTS (SELECT 1 FROM `Pork_Carnitas_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

INSERT INTO `recipe_lists` (`recipe_name`, `url`)
SELECT 'Pork_Carnitas_recipe_table', ''
WHERE NOT EXISTS (SELECT 1 FROM `recipe_lists` WHERE `recipe_name` = 'Pork_Carnitas_recipe_table');


-- Beef Stroganoff: ONE batch = SEVEN meals.

INSERT INTO `Beef_Stroganoff_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 16.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(grocery_item)) = LOWER('Boneless Beef Chuck Roast'))
  AND NOT EXISTS (SELECT 1 FROM `Beef_Stroganoff_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

INSERT INTO `Beef_Stroganoff_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 1.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(grocery_item)) = LOWER('Olive Oil'))
  AND NOT EXISTS (SELECT 1 FROM `Beef_Stroganoff_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

INSERT INTO `Beef_Stroganoff_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 2.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(grocery_item)) = LOWER('Butter 4 pack'))
  AND NOT EXISTS (SELECT 1 FROM `Beef_Stroganoff_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

INSERT INTO `Beef_Stroganoff_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 3, 8.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(grocery_item)) = LOWER('Mushrooms'))
  AND NOT EXISTS (SELECT 1 FROM `Beef_Stroganoff_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

INSERT INTO `Beef_Stroganoff_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 1.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(grocery_item)) = LOWER('Onion'))
  AND NOT EXISTS (SELECT 1 FROM `Beef_Stroganoff_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

INSERT INTO `Beef_Stroganoff_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 4, 4.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(grocery_item)) = LOWER('Garlic Clove'))
  AND NOT EXISTS (SELECT 1 FROM `Beef_Stroganoff_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

INSERT INTO `Beef_Stroganoff_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 2.250, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(grocery_item)) = LOWER('Beef Broth'))
  AND NOT EXISTS (SELECT 1 FROM `Beef_Stroganoff_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

INSERT INTO `Beef_Stroganoff_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 6.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(grocery_item)) = LOWER('Worcestershire sauce'))
  AND NOT EXISTS (SELECT 1 FROM `Beef_Stroganoff_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

INSERT INTO `Beef_Stroganoff_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 6.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(grocery_item)) = LOWER('Dijon Mustard'))
  AND NOT EXISTS (SELECT 1 FROM `Beef_Stroganoff_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

INSERT INTO `Beef_Stroganoff_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 1.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(grocery_item)) = LOWER('Salt'))
  AND NOT EXISTS (SELECT 1 FROM `Beef_Stroganoff_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

INSERT INTO `Beef_Stroganoff_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 4.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(grocery_item)) = LOWER('Black pepper'))
  AND NOT EXISTS (SELECT 1 FROM `Beef_Stroganoff_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

INSERT INTO `Beef_Stroganoff_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 3.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(grocery_item)) = LOWER('Cornstarch 16 oz'))
  AND NOT EXISTS (SELECT 1 FROM `Beef_Stroganoff_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

INSERT INTO `Beef_Stroganoff_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 0, 0.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(grocery_item)) = LOWER('Water From Sink'))
  AND NOT EXISTS (SELECT 1 FROM `Beef_Stroganoff_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

INSERT INTO `Beef_Stroganoff_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 12.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(grocery_item)) = LOWER('Sour Cream'))
  AND NOT EXISTS (SELECT 1 FROM `Beef_Stroganoff_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

INSERT INTO `recipe_lists` (`recipe_name`, `url`)
SELECT 'Beef_Stroganoff_recipe_table', ''
WHERE NOT EXISTS (SELECT 1 FROM `recipe_lists` WHERE `recipe_name` = 'Beef_Stroganoff_recipe_table');


-- Buffalo Shredded Chicken: ONE batch = SEVEN meals.

INSERT INTO `Buffalo_Shredded_Chicken_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 16.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(grocery_item)) = LOWER('Boneless Skinless Chicken Thighs'))
  AND NOT EXISTS (SELECT 1 FROM `Buffalo_Shredded_Chicken_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

INSERT INTO `Buffalo_Shredded_Chicken_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 2.250, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(grocery_item)) = LOWER('Chicken broth'))
  AND NOT EXISTS (SELECT 1 FROM `Buffalo_Shredded_Chicken_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

INSERT INTO `Buffalo_Shredded_Chicken_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 2.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(grocery_item)) = LOWER('Garlic Powder'))
  AND NOT EXISTS (SELECT 1 FROM `Buffalo_Shredded_Chicken_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

INSERT INTO `Buffalo_Shredded_Chicken_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 2.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(grocery_item)) = LOWER('Onion Powder'))
  AND NOT EXISTS (SELECT 1 FROM `Buffalo_Shredded_Chicken_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

INSERT INTO `Buffalo_Shredded_Chicken_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 2.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(grocery_item)) = LOWER('Black pepper'))
  AND NOT EXISTS (SELECT 1 FROM `Buffalo_Shredded_Chicken_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

INSERT INTO `Buffalo_Shredded_Chicken_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 48.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(grocery_item)) = LOWER('Franks Hot Sauce'))
  AND NOT EXISTS (SELECT 1 FROM `Buffalo_Shredded_Chicken_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

INSERT INTO `Buffalo_Shredded_Chicken_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 4.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(grocery_item)) = LOWER('Butter 4 pack'))
  AND NOT EXISTS (SELECT 1 FROM `Buffalo_Shredded_Chicken_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

INSERT INTO `Buffalo_Shredded_Chicken_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 8.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(grocery_item)) = LOWER('Cream cheese 1 pack'))
  AND NOT EXISTS (SELECT 1 FROM `Buffalo_Shredded_Chicken_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

INSERT INTO `recipe_lists` (`recipe_name`, `url`)
SELECT 'Buffalo_Shredded_Chicken_recipe_table', ''
WHERE NOT EXISTS (SELECT 1 FROM `recipe_lists` WHERE `recipe_name` = 'Buffalo_Shredded_Chicken_recipe_table');


-- Pork Chile Verde: ONE batch = SEVEN meals.

INSERT INTO `Pork_Chile_Verde_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 16.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(grocery_item)) = LOWER('Pork shoulder'))
  AND NOT EXISTS (SELECT 1 FROM `Pork_Chile_Verde_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

INSERT INTO `Pork_Chile_Verde_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 1.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(grocery_item)) = LOWER('Olive Oil'))
  AND NOT EXISTS (SELECT 1 FROM `Pork_Chile_Verde_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

INSERT INTO `Pork_Chile_Verde_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 1.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(grocery_item)) = LOWER('Onion'))
  AND NOT EXISTS (SELECT 1 FROM `Pork_Chile_Verde_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

INSERT INTO `Pork_Chile_Verde_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 6, 6.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(grocery_item)) = LOWER('Garlic Clove'))
  AND NOT EXISTS (SELECT 1 FROM `Pork_Chile_Verde_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

INSERT INTO `Pork_Chile_Verde_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 2.250, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(grocery_item)) = LOWER('Chicken broth'))
  AND NOT EXISTS (SELECT 1 FROM `Pork_Chile_Verde_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

INSERT INTO `Pork_Chile_Verde_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 2.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(grocery_item)) = LOWER('Ground Cumin'))
  AND NOT EXISTS (SELECT 1 FROM `Pork_Chile_Verde_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

INSERT INTO `Pork_Chile_Verde_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 1.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(grocery_item)) = LOWER('Oregeno'))
  AND NOT EXISTS (SELECT 1 FROM `Pork_Chile_Verde_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

INSERT INTO `Pork_Chile_Verde_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 0.500, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(grocery_item)) = LOWER('Salt'))
  AND NOT EXISTS (SELECT 1 FROM `Pork_Chile_Verde_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

INSERT INTO `Pork_Chile_Verde_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 2.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(grocery_item)) = LOWER('Black pepper'))
  AND NOT EXISTS (SELECT 1 FROM `Pork_Chile_Verde_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

INSERT INTO `Pork_Chile_Verde_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 2, 22.667, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(grocery_item)) = LOWER('Tomatillo Salsa Verde 16 oz'))
  AND NOT EXISTS (SELECT 1 FROM `Pork_Chile_Verde_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

INSERT INTO `Pork_Chile_Verde_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 2, 8.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(grocery_item)) = LOWER('Diced Roasted Green Chiles 4 oz'))
  AND NOT EXISTS (SELECT 1 FROM `Pork_Chile_Verde_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

INSERT INTO `Pork_Chile_Verde_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 4.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(grocery_item)) = LOWER('Lime Juice'))
  AND NOT EXISTS (SELECT 1 FROM `Pork_Chile_Verde_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

INSERT INTO `Pork_Chile_Verde_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 15.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(grocery_item)) = LOWER('Cilantro'))
  AND NOT EXISTS (SELECT 1 FROM `Pork_Chile_Verde_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

INSERT INTO `recipe_lists` (`recipe_name`, `url`)
SELECT 'Pork_Chile_Verde_recipe_table', ''
WHERE NOT EXISTS (SELECT 1 FROM `recipe_lists` WHERE `recipe_name` = 'Pork_Chile_Verde_recipe_table');


-- Italian Meatballs in Marinara: ONE batch = SEVEN meals.

INSERT INTO `Italian_Meatballs_in_Marinara_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 3, 12.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(grocery_item)) = LOWER('Ground Beef 85 Percent Lean 1 lb'))
  AND NOT EXISTS (SELECT 1 FROM `Italian_Meatballs_in_Marinara_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

INSERT INTO `Italian_Meatballs_in_Marinara_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 4.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(grocery_item)) = LOWER('Ground Pork 1 lb'))
  AND NOT EXISTS (SELECT 1 FROM `Italian_Meatballs_in_Marinara_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

INSERT INTO `Italian_Meatballs_in_Marinara_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 4.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(grocery_item)) = LOWER('Plain Dry Bread Crumbs'))
  AND NOT EXISTS (SELECT 1 FROM `Italian_Meatballs_in_Marinara_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

INSERT INTO `Italian_Meatballs_in_Marinara_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 0.500, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(grocery_item)) = LOWER('Milk'))
  AND NOT EXISTS (SELECT 1 FROM `Italian_Meatballs_in_Marinara_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

INSERT INTO `Italian_Meatballs_in_Marinara_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 2.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(grocery_item)) = LOWER('Eggs-6 pack'))
  AND NOT EXISTS (SELECT 1 FROM `Italian_Meatballs_in_Marinara_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

INSERT INTO `Italian_Meatballs_in_Marinara_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 20.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(grocery_item)) = LOWER('Parmesan'))
  AND NOT EXISTS (SELECT 1 FROM `Italian_Meatballs_in_Marinara_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

INSERT INTO `Italian_Meatballs_in_Marinara_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 6, 6.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(grocery_item)) = LOWER('Garlic Clove'))
  AND NOT EXISTS (SELECT 1 FROM `Italian_Meatballs_in_Marinara_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

INSERT INTO `Italian_Meatballs_in_Marinara_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 4.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(grocery_item)) = LOWER('Fresh Parsley'))
  AND NOT EXISTS (SELECT 1 FROM `Italian_Meatballs_in_Marinara_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

INSERT INTO `Italian_Meatballs_in_Marinara_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 2.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(grocery_item)) = LOWER('Italan Seasoning'))
  AND NOT EXISTS (SELECT 1 FROM `Italian_Meatballs_in_Marinara_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

INSERT INTO `Italian_Meatballs_in_Marinara_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 1.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(grocery_item)) = LOWER('Salt'))
  AND NOT EXISTS (SELECT 1 FROM `Italian_Meatballs_in_Marinara_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

INSERT INTO `Italian_Meatballs_in_Marinara_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 1, 4.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(grocery_item)) = LOWER('Black pepper'))
  AND NOT EXISTS (SELECT 1 FROM `Italian_Meatballs_in_Marinara_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

INSERT INTO `Italian_Meatballs_in_Marinara_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 0, 0.000, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(grocery_item)) = LOWER('Water From Sink'))
  AND NOT EXISTS (SELECT 1 FROM `Italian_Meatballs_in_Marinara_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

INSERT INTO `Italian_Meatballs_in_Marinara_recipe_table` (`qty`, `used_servings`, `ingredient_name`)
SELECT 2, 10.880, CAST(i.`ID` AS CHAR)
FROM `items` AS i
WHERE i.`ID` = (SELECT MIN(`ID`) FROM `items` WHERE LOWER(TRIM(grocery_item)) = LOWER('Raos Marinara Sauce 24 oz'))
  AND NOT EXISTS (SELECT 1 FROM `Italian_Meatballs_in_Marinara_recipe_table` AS r WHERE r.`ingredient_name` = CAST(i.`ID` AS CHAR));

INSERT INTO `recipe_lists` (`recipe_name`, `url`)
SELECT 'Italian_Meatballs_in_Marinara_recipe_table', ''
WHERE NOT EXISTS (SELECT 1 FROM `recipe_lists` WHERE `recipe_name` = 'Italian_Meatballs_in_Marinara_recipe_table');

COMMIT;

-- Existing site code adds #id=<actual ID> to items.url at display time.
-- Do not store a guessed or hard-coded #id fragment in items.url.
-- Show import results and the resulting Walmart links:
SELECT `ID`, `grocery_item`, `url`,
       CASE WHEN COALESCE(`url`, '') = '' THEN ''
            ELSE CONCAT(`url`, '#id=', `ID`) END AS `site_walmart_link`
FROM `items`
WHERE LOWER(TRIM(`grocery_item`)) IN ('olive oil', 'onion', 'garlic clove', 'beef broth', 'chicken broth', 'apple cider vinegar', 'chopped chipotles in adobo sauce', 'ground cumin', 'oregeno', 'salt', 'black pepper', 'lime juice', 'italan seasoning', 'heavy cream', 'cream cheese 1 pack', 'parmesan', 'lemon juice', 'pork shoulder', 'butter 4 pack', 'mushrooms', 'worcestershire sauce', 'sour cream', 'garlic powder', 'onion powder', 'franks hot sauce', 'cilantro', 'milk', 'eggs-6 pack', 'water from sink', 'boneless beef chuck roast', 'boneless skinless chicken thighs', 'bay leaves', 'orange juice', 'fresh baby spinach 5 oz', 'dijon mustard', 'cornstarch 16 oz', 'tomatillo salsa verde 16 oz', 'diced roasted green chiles 4 oz', 'ground pork 1 lb', 'ground beef 85 percent lean 1 lb', 'plain dry bread crumbs', 'fresh parsley', 'raos marinara sauce 24 oz')
ORDER BY `grocery_item`;

SELECT 'Chipotle_Beef_Barbacoa_recipe_table' AS recipe_table, COUNT(*) AS ingredient_rows FROM `Chipotle_Beef_Barbacoa_recipe_table`;

SELECT 'Creamy_Garlic_Parmesan_Chicken_recipe_table' AS recipe_table, COUNT(*) AS ingredient_rows FROM `Creamy_Garlic_Parmesan_Chicken_recipe_table`;

SELECT 'Pork_Carnitas_recipe_table' AS recipe_table, COUNT(*) AS ingredient_rows FROM `Pork_Carnitas_recipe_table`;

SELECT 'Beef_Stroganoff_recipe_table' AS recipe_table, COUNT(*) AS ingredient_rows FROM `Beef_Stroganoff_recipe_table`;

SELECT 'Buffalo_Shredded_Chicken_recipe_table' AS recipe_table, COUNT(*) AS ingredient_rows FROM `Buffalo_Shredded_Chicken_recipe_table`;

SELECT 'Pork_Chile_Verde_recipe_table' AS recipe_table, COUNT(*) AS ingredient_rows FROM `Pork_Chile_Verde_recipe_table`;

SELECT 'Italian_Meatballs_in_Marinara_recipe_table' AS recipe_table, COUNT(*) AS ingredient_rows FROM `Italian_Meatballs_in_Marinara_recipe_table`;
