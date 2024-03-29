-- MariaDB dump 10.17  Distrib 10.5.4-MariaDB, for Linux (x86_64)
--
-- Host: localhost    Database: shopping_list
-- ------------------------------------------------------
-- Server version	10.5.4-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `Apple_Cinnamon_Smoothie_recipe_table`
--

DROP TABLE IF EXISTS `Apple_Cinnamon_Smoothie_recipe_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Apple_Cinnamon_Smoothie_recipe_table` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `qty` int(11) NOT NULL,
  `ingredient_name` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Apple_Cinnamon_Smoothie_recipe_table`
--

LOCK TABLES `Apple_Cinnamon_Smoothie_recipe_table` WRITE;
/*!40000 ALTER TABLE `Apple_Cinnamon_Smoothie_recipe_table` DISABLE KEYS */;
INSERT INTO `Apple_Cinnamon_Smoothie_recipe_table` VALUES (1,1,'35'),(2,2,'243'),(3,1,'244'),(4,1,'245'),(5,1,'238'),(6,1,'57');
/*!40000 ALTER TABLE `Apple_Cinnamon_Smoothie_recipe_table` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `BLT_burger_recipe_table`
--

DROP TABLE IF EXISTS `BLT_burger_recipe_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `BLT_burger_recipe_table` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `qty` int(11) NOT NULL,
  `ingredient_name` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `BLT_burger_recipe_table`
--

LOCK TABLES `BLT_burger_recipe_table` WRITE;
/*!40000 ALTER TABLE `BLT_burger_recipe_table` DISABLE KEYS */;
INSERT INTO `BLT_burger_recipe_table` VALUES (1,2,'154'),(2,2,'15'),(3,1,'167'),(4,1,'92'),(5,1,'144'),(6,2,'147'),(7,2,'182'),(8,1,'184');
/*!40000 ALTER TABLE `BLT_burger_recipe_table` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Bacon_Wrapped_Cheese_Stuffed_Burgers_recipe_table`
--

DROP TABLE IF EXISTS `Bacon_Wrapped_Cheese_Stuffed_Burgers_recipe_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Bacon_Wrapped_Cheese_Stuffed_Burgers_recipe_table` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `qty` int(11) NOT NULL,
  `ingredient_name` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Bacon_Wrapped_Cheese_Stuffed_Burgers_recipe_table`
--

LOCK TABLES `Bacon_Wrapped_Cheese_Stuffed_Burgers_recipe_table` WRITE;
/*!40000 ALTER TABLE `Bacon_Wrapped_Cheese_Stuffed_Burgers_recipe_table` DISABLE KEYS */;
INSERT INTO `Bacon_Wrapped_Cheese_Stuffed_Burgers_recipe_table` VALUES (1,1,'67'),(2,1,'255'),(3,0,'64'),(4,1,'31'),(5,1,'221'),(6,1,'42'),(7,1,'92'),(8,1,'7'),(9,1,'249'),(10,1,'141'),(11,1,'10'),(12,10,'8'),(13,0,'38'),(14,1,'15');
/*!40000 ALTER TABLE `Bacon_Wrapped_Cheese_Stuffed_Burgers_recipe_table` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Bacon_Wrapped_Meatloaf_recipe_table`
--

DROP TABLE IF EXISTS `Bacon_Wrapped_Meatloaf_recipe_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Bacon_Wrapped_Meatloaf_recipe_table` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `qty` int(11) NOT NULL,
  `ingredient_name` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Bacon_Wrapped_Meatloaf_recipe_table`
--

LOCK TABLES `Bacon_Wrapped_Meatloaf_recipe_table` WRITE;
/*!40000 ALTER TABLE `Bacon_Wrapped_Meatloaf_recipe_table` DISABLE KEYS */;
INSERT INTO `Bacon_Wrapped_Meatloaf_recipe_table` VALUES (1,1,'54'),(2,1,'29'),(3,1,'175'),(4,1,'150'),(5,1,'66'),(6,1,'176'),(7,2,'15'),(8,1,'12'),(9,1,'164'),(10,1,'39'),(11,1,'40'),(12,1,'177'),(13,1,'167'),(14,1,'92'),(15,1,'154');
/*!40000 ALTER TABLE `Bacon_Wrapped_Meatloaf_recipe_table` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Beverages_recipe_table`
--

DROP TABLE IF EXISTS `Beverages_recipe_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Beverages_recipe_table` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `qty` int(11) NOT NULL,
  `ingredient_name` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Beverages_recipe_table`
--

LOCK TABLES `Beverages_recipe_table` WRITE;
/*!40000 ALTER TABLE `Beverages_recipe_table` DISABLE KEYS */;
INSERT INTO `Beverages_recipe_table` VALUES (1,1,'62'),(2,2,'1'),(3,0,'57'),(4,1,'95'),(5,1,'202'),(6,0,'224'),(7,0,'226'),(8,0,'227'),(9,0,'232'),(10,1,'48'),(11,0,'254');
/*!40000 ALTER TABLE `Beverages_recipe_table` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Body_recipe_table`
--

DROP TABLE IF EXISTS `Body_recipe_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Body_recipe_table` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `qty` int(11) NOT NULL,
  `ingredient_name` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Body_recipe_table`
--

LOCK TABLES `Body_recipe_table` WRITE;
/*!40000 ALTER TABLE `Body_recipe_table` DISABLE KEYS */;
INSERT INTO `Body_recipe_table` VALUES (1,1,'90'),(2,1,'88'),(3,1,'86'),(4,1,'87'),(5,1,'84'),(6,0,'153'),(7,1,'85'),(8,1,'196'),(9,1,'198'),(10,0,'199'),(11,1,'204');
/*!40000 ALTER TABLE `Body_recipe_table` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Bratwurst_recipe_table`
--

DROP TABLE IF EXISTS `Bratwurst_recipe_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Bratwurst_recipe_table` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `qty` int(11) NOT NULL,
  `ingredient_name` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Bratwurst_recipe_table`
--

LOCK TABLES `Bratwurst_recipe_table` WRITE;
/*!40000 ALTER TABLE `Bratwurst_recipe_table` DISABLE KEYS */;
INSERT INTO `Bratwurst_recipe_table` VALUES (1,3,'9'),(2,0,'10'),(3,0,'91'),(4,0,'147');
/*!40000 ALTER TABLE `Bratwurst_recipe_table` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Buffalo_Chicken_Casserole_recipe_table`
--

DROP TABLE IF EXISTS `Buffalo_Chicken_Casserole_recipe_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Buffalo_Chicken_Casserole_recipe_table` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `qty` int(11) NOT NULL,
  `ingredient_name` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Buffalo_Chicken_Casserole_recipe_table`
--

LOCK TABLES `Buffalo_Chicken_Casserole_recipe_table` WRITE;
/*!40000 ALTER TABLE `Buffalo_Chicken_Casserole_recipe_table` DISABLE KEYS */;
INSERT INTO `Buffalo_Chicken_Casserole_recipe_table` VALUES (1,1,'14'),(2,3,'142'),(3,1,'143'),(4,1,'12'),(5,1,'144'),(6,2,'29'),(7,1,'145'),(8,1,'146'),(9,3,'64'),(10,1,'137'),(11,1,'54'),(12,1,'67'),(13,1,'23'),(14,1,'42'),(15,1,'92'),(16,1,'147'),(17,1,'152'),(18,1,'148'),(19,3,'8');
/*!40000 ALTER TABLE `Buffalo_Chicken_Casserole_recipe_table` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Burritos_recipe_table`
--

DROP TABLE IF EXISTS `Burritos_recipe_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Burritos_recipe_table` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `qty` int(11) NOT NULL,
  `ingredient_name` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Burritos_recipe_table`
--

LOCK TABLES `Burritos_recipe_table` WRITE;
/*!40000 ALTER TABLE `Burritos_recipe_table` DISABLE KEYS */;
INSERT INTO `Burritos_recipe_table` VALUES (1,1,'11'),(2,5,'8'),(3,2,'205'),(4,1,'13'),(5,1,'14'),(6,0,'221'),(7,0,'193'),(8,0,'64'),(9,0,'29'),(10,0,'147'),(11,0,'148'),(12,0,'182');
/*!40000 ALTER TABLE `Burritos_recipe_table` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Cauliflower_Potato_Salad_recipe_table`
--

DROP TABLE IF EXISTS `Cauliflower_Potato_Salad_recipe_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Cauliflower_Potato_Salad_recipe_table` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `qty` int(11) NOT NULL,
  `ingredient_name` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Cauliflower_Potato_Salad_recipe_table`
--

LOCK TABLES `Cauliflower_Potato_Salad_recipe_table` WRITE;
/*!40000 ALTER TABLE `Cauliflower_Potato_Salad_recipe_table` DISABLE KEYS */;
INSERT INTO `Cauliflower_Potato_Salad_recipe_table` VALUES (1,2,'256'),(2,1,'144'),(3,1,'35'),(4,1,'10'),(5,1,'137'),(6,1,'174'),(7,1,'42'),(8,1,'92'),(9,0,'29'),(10,0,'175'),(11,0,'40');
/*!40000 ALTER TABLE `Cauliflower_Potato_Salad_recipe_table` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Cauliflower_Tots_recipe_table`
--

DROP TABLE IF EXISTS `Cauliflower_Tots_recipe_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Cauliflower_Tots_recipe_table` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `qty` int(11) NOT NULL,
  `ingredient_name` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Cauliflower_Tots_recipe_table`
--

LOCK TABLES `Cauliflower_Tots_recipe_table` WRITE;
/*!40000 ALTER TABLE `Cauliflower_Tots_recipe_table` DISABLE KEYS */;
INSERT INTO `Cauliflower_Tots_recipe_table` VALUES (1,1,'172'),(2,1,'54'),(3,1,'40'),(4,1,'26'),(5,1,'146'),(6,1,'42');
/*!40000 ALTER TABLE `Cauliflower_Tots_recipe_table` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Cauliflower_pizza_recipe_table`
--

DROP TABLE IF EXISTS `Cauliflower_pizza_recipe_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Cauliflower_pizza_recipe_table` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `qty` int(11) NOT NULL,
  `ingredient_name` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Cauliflower_pizza_recipe_table`
--

LOCK TABLES `Cauliflower_pizza_recipe_table` WRITE;
/*!40000 ALTER TABLE `Cauliflower_pizza_recipe_table` DISABLE KEYS */;
INSERT INTO `Cauliflower_pizza_recipe_table` VALUES (1,1,'172'),(2,1,'40'),(3,1,'39'),(4,1,'66'),(5,1,'42'),(6,1,'33'),(7,1,'206'),(8,1,'29'),(9,1,'64'),(10,3,'8'),(11,1,'37'),(12,1,'31');
/*!40000 ALTER TABLE `Cauliflower_pizza_recipe_table` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Cheese_steak_stuffed_peppers_recipe_table`
--

DROP TABLE IF EXISTS `Cheese_steak_stuffed_peppers_recipe_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Cheese_steak_stuffed_peppers_recipe_table` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `qty` int(11) NOT NULL,
  `ingredient_name` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Cheese_steak_stuffed_peppers_recipe_table`
--

LOCK TABLES `Cheese_steak_stuffed_peppers_recipe_table` WRITE;
/*!40000 ALTER TABLE `Cheese_steak_stuffed_peppers_recipe_table` DISABLE KEYS */;
INSERT INTO `Cheese_steak_stuffed_peppers_recipe_table` VALUES (1,4,'64'),(2,1,'181'),(3,1,'29'),(4,1,'31'),(5,1,'167'),(6,1,'92'),(7,1,'13'),(8,1,'134'),(9,1,'25');
/*!40000 ALTER TABLE `Cheese_steak_stuffed_peppers_recipe_table` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Cheesy_bacon_ranch_chicken_breast_recipe_table`
--

DROP TABLE IF EXISTS `Cheesy_bacon_ranch_chicken_breast_recipe_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Cheesy_bacon_ranch_chicken_breast_recipe_table` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `qty` int(11) NOT NULL,
  `ingredient_name` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Cheesy_bacon_ranch_chicken_breast_recipe_table`
--

LOCK TABLES `Cheesy_bacon_ranch_chicken_breast_recipe_table` WRITE;
/*!40000 ALTER TABLE `Cheesy_bacon_ranch_chicken_breast_recipe_table` DISABLE KEYS */;
INSERT INTO `Cheesy_bacon_ranch_chicken_breast_recipe_table` VALUES (1,1,'154'),(2,2,'14'),(3,1,'167'),(4,1,'92'),(5,1,'149'),(6,1,'26');
/*!40000 ALTER TABLE `Cheesy_bacon_ranch_chicken_breast_recipe_table` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Chicken_Bacon_Ranch_Casserole_Recipe_recipe_table`
--

DROP TABLE IF EXISTS `Chicken_Bacon_Ranch_Casserole_Recipe_recipe_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Chicken_Bacon_Ranch_Casserole_Recipe_recipe_table` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `qty` int(11) NOT NULL,
  `ingredient_name` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Chicken_Bacon_Ranch_Casserole_Recipe_recipe_table`
--

LOCK TABLES `Chicken_Bacon_Ranch_Casserole_Recipe_recipe_table` WRITE;
/*!40000 ALTER TABLE `Chicken_Bacon_Ranch_Casserole_Recipe_recipe_table` DISABLE KEYS */;
INSERT INTO `Chicken_Bacon_Ranch_Casserole_Recipe_recipe_table` VALUES (1,1,'14'),(2,1,'154'),(3,1,'150'),(4,1,'149'),(5,1,'26'),(6,1,'12'),(7,1,'151');
/*!40000 ALTER TABLE `Chicken_Bacon_Ranch_Casserole_Recipe_recipe_table` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Chicken_Drumbsticks_recipe_table`
--

DROP TABLE IF EXISTS `Chicken_Drumbsticks_recipe_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Chicken_Drumbsticks_recipe_table` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `qty` int(11) NOT NULL,
  `ingredient_name` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Chicken_Drumbsticks_recipe_table`
--

LOCK TABLES `Chicken_Drumbsticks_recipe_table` WRITE;
/*!40000 ALTER TABLE `Chicken_Drumbsticks_recipe_table` DISABLE KEYS */;
INSERT INTO `Chicken_Drumbsticks_recipe_table` VALUES (1,1,'19'),(2,1,'20'),(3,1,'92'),(4,0,'67'),(5,1,'54');
/*!40000 ALTER TABLE `Chicken_Drumbsticks_recipe_table` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Chicken_Leg_Quarters_recipe_table`
--

DROP TABLE IF EXISTS `Chicken_Leg_Quarters_recipe_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Chicken_Leg_Quarters_recipe_table` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `qty` int(11) NOT NULL,
  `ingredient_name` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Chicken_Leg_Quarters_recipe_table`
--

LOCK TABLES `Chicken_Leg_Quarters_recipe_table` WRITE;
/*!40000 ALTER TABLE `Chicken_Leg_Quarters_recipe_table` DISABLE KEYS */;
INSERT INTO `Chicken_Leg_Quarters_recipe_table` VALUES (1,1,'21'),(2,1,'20'),(3,1,'92'),(4,1,'68');
/*!40000 ALTER TABLE `Chicken_Leg_Quarters_recipe_table` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Chicken_wings_recipe_table`
--

DROP TABLE IF EXISTS `Chicken_wings_recipe_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Chicken_wings_recipe_table` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `qty` int(11) NOT NULL,
  `ingredient_name` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Chicken_wings_recipe_table`
--

LOCK TABLES `Chicken_wings_recipe_table` WRITE;
/*!40000 ALTER TABLE `Chicken_wings_recipe_table` DISABLE KEYS */;
INSERT INTO `Chicken_wings_recipe_table` VALUES (1,1,'23'),(2,1,'22'),(3,1,'67'),(4,1,'68');
/*!40000 ALTER TABLE `Chicken_wings_recipe_table` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Cleaning_Supplies_recipe_table`
--

DROP TABLE IF EXISTS `Cleaning_Supplies_recipe_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Cleaning_Supplies_recipe_table` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `qty` int(11) NOT NULL,
  `ingredient_name` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Cleaning_Supplies_recipe_table`
--

LOCK TABLES `Cleaning_Supplies_recipe_table` WRITE;
/*!40000 ALTER TABLE `Cleaning_Supplies_recipe_table` DISABLE KEYS */;
INSERT INTO `Cleaning_Supplies_recipe_table` VALUES (1,1,'3'),(2,1,'50'),(3,0,'101'),(4,0,'52'),(5,0,'102'),(6,0,'105'),(7,1,'51'),(8,0,'170'),(9,0,'230'),(10,0,'203'),(11,0,'228'),(12,0,'231'),(13,0,'229');
/*!40000 ALTER TABLE `Cleaning_Supplies_recipe_table` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Deviled_Eggs_recipe_table`
--

DROP TABLE IF EXISTS `Deviled_Eggs_recipe_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Deviled_Eggs_recipe_table` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `qty` int(11) NOT NULL,
  `ingredient_name` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Deviled_Eggs_recipe_table`
--

LOCK TABLES `Deviled_Eggs_recipe_table` WRITE;
/*!40000 ALTER TABLE `Deviled_Eggs_recipe_table` DISABLE KEYS */;
INSERT INTO `Deviled_Eggs_recipe_table` VALUES (1,0,'40'),(2,0,'144'),(3,0,'10'),(4,0,'35'),(5,0,'137'),(6,0,'42'),(7,0,'30'),(8,0,'179'),(9,1,'191');
/*!40000 ALTER TABLE `Deviled_Eggs_recipe_table` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Electronic_Bartender_recipe_table`
--

DROP TABLE IF EXISTS `Electronic_Bartender_recipe_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Electronic_Bartender_recipe_table` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `qty` int(11) NOT NULL,
  `ingredient_name` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Electronic_Bartender_recipe_table`
--

LOCK TABLES `Electronic_Bartender_recipe_table` WRITE;
/*!40000 ALTER TABLE `Electronic_Bartender_recipe_table` DISABLE KEYS */;
INSERT INTO `Electronic_Bartender_recipe_table` VALUES (1,2,'114'),(2,2,'115'),(3,1,'116'),(4,1,'117'),(5,1,'118'),(6,1,'119'),(7,1,'120'),(8,1,'121'),(9,6,'122'),(10,3,'123'),(11,1,'124'),(12,1,'127'),(13,1,'128'),(14,1,'129'),(15,1,'130'),(16,1,'131'),(17,1,'125'),(18,1,'126');
/*!40000 ALTER TABLE `Electronic_Bartender_recipe_table` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Electronic_needs_recipe_table`
--

DROP TABLE IF EXISTS `Electronic_needs_recipe_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Electronic_needs_recipe_table` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `qty` int(11) NOT NULL,
  `ingredient_name` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Electronic_needs_recipe_table`
--

LOCK TABLES `Electronic_needs_recipe_table` WRITE;
/*!40000 ALTER TABLE `Electronic_needs_recipe_table` DISABLE KEYS */;
INSERT INTO `Electronic_needs_recipe_table` VALUES (1,0,'69'),(2,1,'104'),(3,1,'103'),(4,1,'106'),(5,1,'107'),(6,1,'112'),(7,0,'110'),(8,2,'187');
/*!40000 ALTER TABLE `Electronic_needs_recipe_table` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `French_fries_recipe_table`
--

DROP TABLE IF EXISTS `French_fries_recipe_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `French_fries_recipe_table` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `qty` int(11) NOT NULL,
  `ingredient_name` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `French_fries_recipe_table`
--

LOCK TABLES `French_fries_recipe_table` WRITE;
/*!40000 ALTER TABLE `French_fries_recipe_table` DISABLE KEYS */;
INSERT INTO `French_fries_recipe_table` VALUES (1,1,'164'),(2,1,'166'),(3,1,'54'),(4,1,'45'),(5,1,'42'),(6,1,'92');
/*!40000 ALTER TABLE `French_fries_recipe_table` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Jalapeno_Poppers_recipe_table`
--

DROP TABLE IF EXISTS `Jalapeno_Poppers_recipe_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Jalapeno_Poppers_recipe_table` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `qty` int(11) NOT NULL,
  `ingredient_name` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Jalapeno_Poppers_recipe_table`
--

LOCK TABLES `Jalapeno_Poppers_recipe_table` WRITE;
/*!40000 ALTER TABLE `Jalapeno_Poppers_recipe_table` DISABLE KEYS */;
INSERT INTO `Jalapeno_Poppers_recipe_table` VALUES (1,11,'8'),(2,1,'5'),(3,1,'12'),(4,1,'7'),(12,1,'160');
/*!40000 ALTER TABLE `Jalapeno_Poppers_recipe_table` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Kale_Smoothie_recipe_table`
--

DROP TABLE IF EXISTS `Kale_Smoothie_recipe_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Kale_Smoothie_recipe_table` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `qty` int(11) NOT NULL,
  `ingredient_name` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Kale_Smoothie_recipe_table`
--

LOCK TABLES `Kale_Smoothie_recipe_table` WRITE;
/*!40000 ALTER TABLE `Kale_Smoothie_recipe_table` DISABLE KEYS */;
INSERT INTO `Kale_Smoothie_recipe_table` VALUES (1,1,'158'),(2,1,'237'),(3,1,'57'),(4,1,'238'),(5,1,'210');
/*!40000 ALTER TABLE `Kale_Smoothie_recipe_table` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Keto_Chili_recipe_table`
--

DROP TABLE IF EXISTS `Keto_Chili_recipe_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Keto_Chili_recipe_table` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `qty` int(11) NOT NULL,
  `ingredient_name` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Keto_Chili_recipe_table`
--

LOCK TABLES `Keto_Chili_recipe_table` WRITE;
/*!40000 ALTER TABLE `Keto_Chili_recipe_table` DISABLE KEYS */;
INSERT INTO `Keto_Chili_recipe_table` VALUES (1,1,'154'),(2,2,'29'),(3,1,'175'),(4,1,'64'),(5,1,'31'),(6,1,'44'),(7,2,'15'),(8,1,'176'),(9,1,'178'),(10,1,'66'),(11,1,'179'),(12,1,'167'),(13,1,'92'),(14,1,'180'),(15,1,'148'),(16,1,'12');
/*!40000 ALTER TABLE `Keto_Chili_recipe_table` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Keto_Fried_Chicken_recipe_table`
--

DROP TABLE IF EXISTS `Keto_Fried_Chicken_recipe_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Keto_Fried_Chicken_recipe_table` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `qty` int(11) NOT NULL,
  `ingredient_name` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Keto_Fried_Chicken_recipe_table`
--

LOCK TABLES `Keto_Fried_Chicken_recipe_table` WRITE;
/*!40000 ALTER TABLE `Keto_Fried_Chicken_recipe_table` DISABLE KEYS */;
INSERT INTO `Keto_Fried_Chicken_recipe_table` VALUES (1,1,'185'),(2,1,'167'),(3,1,'92'),(4,1,'40'),(5,1,'57'),(6,1,'164'),(7,2,'171'),(8,1,'39'),(9,1,'137'),(10,1,'174'),(11,0,'144'),(12,0,'23');
/*!40000 ALTER TABLE `Keto_Fried_Chicken_recipe_table` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Keto_Mac_and_Cheese_recipe_table`
--

DROP TABLE IF EXISTS `Keto_Mac_and_Cheese_recipe_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Keto_Mac_and_Cheese_recipe_table` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `qty` int(11) NOT NULL,
  `ingredient_name` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Keto_Mac_and_Cheese_recipe_table`
--

LOCK TABLES `Keto_Mac_and_Cheese_recipe_table` WRITE;
/*!40000 ALTER TABLE `Keto_Mac_and_Cheese_recipe_table` DISABLE KEYS */;
INSERT INTO `Keto_Mac_and_Cheese_recipe_table` VALUES (1,3,'172'),(2,1,'67'),(3,1,'54'),(4,1,'167'),(5,1,'57'),(6,1,'192'),(7,2,'205'),(8,1,'206'),(9,1,'23'),(10,1,'92'),(11,2,'171'),(12,1,'39');
/*!40000 ALTER TABLE `Keto_Mac_and_Cheese_recipe_table` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Lasagna_recipe_table`
--

DROP TABLE IF EXISTS `Lasagna_recipe_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Lasagna_recipe_table` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `qty` int(11) NOT NULL,
  `ingredient_name` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Lasagna_recipe_table`
--

LOCK TABLES `Lasagna_recipe_table` WRITE;
/*!40000 ALTER TABLE `Lasagna_recipe_table` DISABLE KEYS */;
INSERT INTO `Lasagna_recipe_table` VALUES (1,1,'40'),(2,1,'5'),(3,1,'39'),(4,2,'26'),(5,0,'134'),(6,0,'137'),(7,0,'135'),(8,2,'15'),(9,1,'33'),(10,1,'136'),(11,0,'66'),(12,0,'41'),(13,0,'43');
/*!40000 ALTER TABLE `Lasagna_recipe_table` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Meat_Pizza_recipe_table`
--

DROP TABLE IF EXISTS `Meat_Pizza_recipe_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Meat_Pizza_recipe_table` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `qty` int(11) NOT NULL,
  `ingredient_name` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Meat_Pizza_recipe_table`
--

LOCK TABLES `Meat_Pizza_recipe_table` WRITE;
/*!40000 ALTER TABLE `Meat_Pizza_recipe_table` DISABLE KEYS */;
INSERT INTO `Meat_Pizza_recipe_table` VALUES (1,4,'24'),(2,2,'25'),(3,1,'26'),(4,1,'27'),(5,1,'28'),(6,1,'29'),(7,1,'30'),(8,1,'31'),(9,2,'8'),(10,1,'32'),(11,1,'33');
/*!40000 ALTER TABLE `Meat_Pizza_recipe_table` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Meatballs_recipe_table`
--

DROP TABLE IF EXISTS `Meatballs_recipe_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Meatballs_recipe_table` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `qty` int(11) NOT NULL,
  `ingredient_name` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Meatballs_recipe_table`
--

LOCK TABLES `Meatballs_recipe_table` WRITE;
/*!40000 ALTER TABLE `Meatballs_recipe_table` DISABLE KEYS */;
INSERT INTO `Meatballs_recipe_table` VALUES (1,1,'26'),(2,1,'37'),(3,1,'38'),(4,1,'12'),(5,1,'39'),(6,1,'40'),(7,1,'33'),(8,1,'41'),(9,1,'42'),(10,1,'43'),(11,1,'44');
/*!40000 ALTER TABLE `Meatballs_recipe_table` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Misc_recipe_table`
--

DROP TABLE IF EXISTS `Misc_recipe_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Misc_recipe_table` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `qty` int(11) NOT NULL,
  `ingredient_name` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Misc_recipe_table`
--

LOCK TABLES `Misc_recipe_table` WRITE;
/*!40000 ALTER TABLE `Misc_recipe_table` DISABLE KEYS */;
INSERT INTO `Misc_recipe_table` VALUES (1,1,'250'),(2,0,'97'),(3,0,'99'),(4,0,'100'),(5,0,'98'),(6,0,'155'),(7,0,'133'),(8,0,'48'),(9,0,'161'),(10,0,'194'),(11,0,'69'),(12,0,'195'),(13,0,'207'),(14,0,'233'),(15,0,'19'),(16,0,'234');
/*!40000 ALTER TABLE `Misc_recipe_table` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Peanut_butter_fat_bombs_recipe_table`
--

DROP TABLE IF EXISTS `Peanut_butter_fat_bombs_recipe_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Peanut_butter_fat_bombs_recipe_table` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `qty` int(11) NOT NULL,
  `ingredient_name` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Peanut_butter_fat_bombs_recipe_table`
--

LOCK TABLES `Peanut_butter_fat_bombs_recipe_table` WRITE;
/*!40000 ALTER TABLE `Peanut_butter_fat_bombs_recipe_table` DISABLE KEYS */;
INSERT INTO `Peanut_butter_fat_bombs_recipe_table` VALUES (1,1,'210'),(2,1,'211'),(3,1,'212'),(4,1,'213'),(5,1,'42');
/*!40000 ALTER TABLE `Peanut_butter_fat_bombs_recipe_table` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Produce_recipe_table`
--

DROP TABLE IF EXISTS `Produce_recipe_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Produce_recipe_table` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `qty` int(11) NOT NULL,
  `ingredient_name` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Produce_recipe_table`
--

LOCK TABLES `Produce_recipe_table` WRITE;
/*!40000 ALTER TABLE `Produce_recipe_table` DISABLE KEYS */;
INSERT INTO `Produce_recipe_table` VALUES (1,1,'17'),(2,1,'158'),(3,1,'16'),(4,0,'236'),(5,0,'239'),(6,0,'238'),(7,0,'210'),(8,0,'248'),(9,0,'243');
/*!40000 ALTER TABLE `Produce_recipe_table` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Pulled_pork_recipe_table`
--

DROP TABLE IF EXISTS `Pulled_pork_recipe_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Pulled_pork_recipe_table` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `qty` int(11) NOT NULL,
  `ingredient_name` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Pulled_pork_recipe_table`
--

LOCK TABLES `Pulled_pork_recipe_table` WRITE;
/*!40000 ALTER TABLE `Pulled_pork_recipe_table` DISABLE KEYS */;
INSERT INTO `Pulled_pork_recipe_table` VALUES (1,1,'197'),(2,1,'42'),(3,1,'92'),(4,1,'135'),(5,1,'137'),(6,1,'152'),(7,1,'176'),(8,1,'174'),(9,1,'20');
/*!40000 ALTER TABLE `Pulled_pork_recipe_table` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Quick_List_recipe_table`
--

DROP TABLE IF EXISTS `Quick_List_recipe_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Quick_List_recipe_table` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `qty` int(11) NOT NULL,
  `ingredient_name` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Quick_List_recipe_table`
--

LOCK TABLES `Quick_List_recipe_table` WRITE;
/*!40000 ALTER TABLE `Quick_List_recipe_table` DISABLE KEYS */;
INSERT INTO `Quick_List_recipe_table` VALUES (1,0,'253'),(2,0,'195'),(3,0,'251'),(4,0,'216'),(5,0,'217'),(6,0,'218'),(7,0,'222'),(8,0,'223'),(9,0,'52'),(10,0,'137'),(11,0,'252'),(12,1,'42');
/*!40000 ALTER TABLE `Quick_List_recipe_table` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Raviolli_recipe_table`
--

DROP TABLE IF EXISTS `Raviolli_recipe_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Raviolli_recipe_table` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `qty` int(11) NOT NULL,
  `ingredient_name` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Raviolli_recipe_table`
--

LOCK TABLES `Raviolli_recipe_table` WRITE;
/*!40000 ALTER TABLE `Raviolli_recipe_table` DISABLE KEYS */;
INSERT INTO `Raviolli_recipe_table` VALUES (1,1,'164'),(2,1,'165'),(3,1,'166'),(4,1,'137'),(5,1,'40'),(6,1,'54'),(7,1,'150'),(8,1,'151'),(9,1,'136'),(10,1,'39'),(11,1,'167'),(12,1,'92'),(13,1,'168'),(14,1,'169');
/*!40000 ALTER TABLE `Raviolli_recipe_table` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Ribs_recipe_table`
--

DROP TABLE IF EXISTS `Ribs_recipe_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Ribs_recipe_table` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `qty` int(11) NOT NULL,
  `ingredient_name` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Ribs_recipe_table`
--

LOCK TABLES `Ribs_recipe_table` WRITE;
/*!40000 ALTER TABLE `Ribs_recipe_table` DISABLE KEYS */;
INSERT INTO `Ribs_recipe_table` VALUES (1,2,'34'),(2,1,'20'),(3,1,'35'),(4,1,'36');
/*!40000 ALTER TABLE `Ribs_recipe_table` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Salsa_recipe_table`
--

DROP TABLE IF EXISTS `Salsa_recipe_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Salsa_recipe_table` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `qty` int(11) NOT NULL,
  `ingredient_name` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Salsa_recipe_table`
--

LOCK TABLES `Salsa_recipe_table` WRITE;
/*!40000 ALTER TABLE `Salsa_recipe_table` DISABLE KEYS */;
INSERT INTO `Salsa_recipe_table` VALUES (1,1,'147'),(2,1,'240'),(3,1,'150'),(4,1,'8'),(5,1,'29'),(6,1,'242');
/*!40000 ALTER TABLE `Salsa_recipe_table` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Shaving_List_recipe_table`
--

DROP TABLE IF EXISTS `Shaving_List_recipe_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Shaving_List_recipe_table` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `qty` int(11) NOT NULL,
  `ingredient_name` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Shaving_List_recipe_table`
--

LOCK TABLES `Shaving_List_recipe_table` WRITE;
/*!40000 ALTER TABLE `Shaving_List_recipe_table` DISABLE KEYS */;
INSERT INTO `Shaving_List_recipe_table` VALUES (1,1,'87'),(2,1,'86');
/*!40000 ALTER TABLE `Shaving_List_recipe_table` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Snacks_recipe_table`
--

DROP TABLE IF EXISTS `Snacks_recipe_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Snacks_recipe_table` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `qty` int(11) NOT NULL,
  `ingredient_name` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Snacks_recipe_table`
--

LOCK TABLES `Snacks_recipe_table` WRITE;
/*!40000 ALTER TABLE `Snacks_recipe_table` DISABLE KEYS */;
INSERT INTO `Snacks_recipe_table` VALUES (1,0,'94');
/*!40000 ALTER TABLE `Snacks_recipe_table` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Spices_recipe_table`
--

DROP TABLE IF EXISTS `Spices_recipe_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Spices_recipe_table` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `qty` int(11) NOT NULL,
  `ingredient_name` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Spices_recipe_table`
--

LOCK TABLES `Spices_recipe_table` WRITE;
/*!40000 ALTER TABLE `Spices_recipe_table` DISABLE KEYS */;
INSERT INTO `Spices_recipe_table` VALUES (1,1,'157'),(2,1,'156');
/*!40000 ALTER TABLE `Spices_recipe_table` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Steak_and_eggs_recipe_table`
--

DROP TABLE IF EXISTS `Steak_and_eggs_recipe_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Steak_and_eggs_recipe_table` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `qty` int(11) NOT NULL,
  `ingredient_name` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Steak_and_eggs_recipe_table`
--

LOCK TABLES `Steak_and_eggs_recipe_table` WRITE;
/*!40000 ALTER TABLE `Steak_and_eggs_recipe_table` DISABLE KEYS */;
INSERT INTO `Steak_and_eggs_recipe_table` VALUES (1,6,'13'),(2,1,'40'),(3,3,'9');
/*!40000 ALTER TABLE `Steak_and_eggs_recipe_table` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Stuffed_Pizza_Bell_Peppers_recipe_table`
--

DROP TABLE IF EXISTS `Stuffed_Pizza_Bell_Peppers_recipe_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Stuffed_Pizza_Bell_Peppers_recipe_table` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `qty` int(11) NOT NULL,
  `ingredient_name` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Stuffed_Pizza_Bell_Peppers_recipe_table`
--

LOCK TABLES `Stuffed_Pizza_Bell_Peppers_recipe_table` WRITE;
/*!40000 ALTER TABLE `Stuffed_Pizza_Bell_Peppers_recipe_table` DISABLE KEYS */;
INSERT INTO `Stuffed_Pizza_Bell_Peppers_recipe_table` VALUES (1,4,'64'),(2,1,'37'),(3,1,'255'),(4,1,'53'),(5,1,'27'),(6,1,'32'),(7,2,'206'),(8,1,'54'),(9,1,'44'),(10,1,'66'),(11,1,'55'),(12,4,'8'),(13,1,'30'),(14,1,'31');
/*!40000 ALTER TABLE `Stuffed_Pizza_Bell_Peppers_recipe_table` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Vacation_recipe_table`
--

DROP TABLE IF EXISTS `Vacation_recipe_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Vacation_recipe_table` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `qty` int(11) NOT NULL,
  `ingredient_name` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Vacation_recipe_table`
--

LOCK TABLES `Vacation_recipe_table` WRITE;
/*!40000 ALTER TABLE `Vacation_recipe_table` DISABLE KEYS */;
INSERT INTO `Vacation_recipe_table` VALUES (1,1,'73'),(2,1,'72'),(3,0,'74'),(4,1,'188'),(5,1,'70'),(6,1,'71'),(7,0,'76'),(8,0,'80'),(9,0,'81'),(10,0,'82'),(11,0,'83'),(12,0,'162'),(13,0,'163'),(14,0,'59'),(15,0,'190'),(16,3,'189');
/*!40000 ALTER TABLE `Vacation_recipe_table` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Vaping_Equipment_recipe_table`
--

DROP TABLE IF EXISTS `Vaping_Equipment_recipe_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Vaping_Equipment_recipe_table` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `qty` int(11) NOT NULL,
  `ingredient_name` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Vaping_Equipment_recipe_table`
--

LOCK TABLES `Vaping_Equipment_recipe_table` WRITE;
/*!40000 ALTER TABLE `Vaping_Equipment_recipe_table` DISABLE KEYS */;
INSERT INTO `Vaping_Equipment_recipe_table` VALUES (1,3,'108'),(2,0,'109'),(4,0,'159');
/*!40000 ALTER TABLE `Vaping_Equipment_recipe_table` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `current_week_recipes`
--

DROP TABLE IF EXISTS `current_week_recipes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `current_week_recipes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `recipes` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `recipes` (`recipes`) USING HASH
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `current_week_recipes`
--

LOCK TABLES `current_week_recipes` WRITE;
/*!40000 ALTER TABLE `current_week_recipes` DISABLE KEYS */;
INSERT INTO `current_week_recipes` VALUES (1,'Chicken_wings_recipe_table'),(2,'Meat_Pizza_recipe_table'),(3,'Meatballs_recipe_table'),(4,'Beverages_recipe_table'),(5,'Produce_recipe_table');
/*!40000 ALTER TABLE `current_week_recipes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `final_list`
--

DROP TABLE IF EXISTS `final_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `final_list` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `QFRT` int(11) NOT NULL,
  `IFRT` int(11) NOT NULL,
  `recipe_table_name` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `final_list`
--

LOCK TABLES `final_list` WRITE;
/*!40000 ALTER TABLE `final_list` DISABLE KEYS */;
INSERT INTO `final_list` VALUES (1,1,23,'Chicken_wings_recipe_table'),(2,1,22,'Chicken_wings_recipe_table'),(3,0,67,'Chicken_wings_recipe_table'),(4,0,68,'Chicken_wings_recipe_table'),(5,4,24,'Meat_Pizza_recipe_table'),(6,2,25,'Meat_Pizza_recipe_table'),(7,1,26,'Meat_Pizza_recipe_table'),(8,1,27,'Meat_Pizza_recipe_table'),(9,1,28,'Meat_Pizza_recipe_table'),(10,1,29,'Meat_Pizza_recipe_table'),(11,0,30,'Meat_Pizza_recipe_table'),(12,1,31,'Meat_Pizza_recipe_table'),(13,2,8,'Meat_Pizza_recipe_table'),(14,1,32,'Meat_Pizza_recipe_table'),(15,1,33,'Meat_Pizza_recipe_table'),(16,1,26,'Meatballs_recipe_table'),(17,1,37,'Meatballs_recipe_table'),(18,1,38,'Meatballs_recipe_table'),(19,1,12,'Meatballs_recipe_table'),(20,1,39,'Meatballs_recipe_table'),(21,0,40,'Meatballs_recipe_table'),(22,1,33,'Meatballs_recipe_table'),(23,0,41,'Meatballs_recipe_table'),(24,0,42,'Meatballs_recipe_table'),(25,1,43,'Meatballs_recipe_table'),(26,0,44,'Meatballs_recipe_table'),(27,1,62,'Beverages_recipe_table'),(28,2,1,'Beverages_recipe_table'),(29,0,57,'Beverages_recipe_table'),(30,1,95,'Beverages_recipe_table'),(31,1,202,'Beverages_recipe_table'),(32,0,224,'Beverages_recipe_table'),(33,0,226,'Beverages_recipe_table'),(34,0,227,'Beverages_recipe_table'),(35,0,232,'Beverages_recipe_table'),(36,1,48,'Beverages_recipe_table'),(37,0,254,'Beverages_recipe_table'),(38,1,17,'Produce_recipe_table'),(39,1,158,'Produce_recipe_table'),(40,1,16,'Produce_recipe_table'),(41,0,236,'Produce_recipe_table'),(42,0,239,'Produce_recipe_table'),(43,0,238,'Produce_recipe_table'),(44,0,210,'Produce_recipe_table'),(45,0,248,'Produce_recipe_table'),(46,0,243,'Produce_recipe_table');
/*!40000 ALTER TABLE `final_list` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `items`
--

DROP TABLE IF EXISTS `items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `items` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `grocery_item` varchar(255) NOT NULL,
  `price` decimal(14,2) DEFAULT NULL,
  `department` text DEFAULT NULL,
  `pantryqty` text DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `grocery_item` (`grocery_item`)
) ENGINE=InnoDB AUTO_INCREMENT=257 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `items`
--

LOCK TABLES `items` WRITE;
/*!40000 ALTER TABLE `items` DISABLE KEYS */;
INSERT INTO `items` VALUES (1,'Pop',3.98,'Beverage','0'),(2,'Shredded Cheese - Generic',2.77,'Dairy','0'),(3,'Detergent',4.00,'Home','1'),(5,'Cream cheese 2 Pack',4.48,'Dairy','0'),(7,'Bacon 20 Pack or so',6.84,'Meat','0'),(8,'Jalapenos',0.20,'Produce','0'),(9,'Bratwurst 5 Pack',5.48,'Meat','0'),(10,'Guldens Spicy Brown Mustard',1.46,'Condiments','1'),(11,'Tortilla 8 Pack',4.48,'Bread','0'),(12,'Shredded Cheddar 2 cups',2.22,'Dairy','0'),(13,'Beef Choice Angus Ribeye Steak Thin',15.17,'Meat','0'),(14,'Chicken Breasts 5 Pack',9.05,'Meat','0'),(15,'1 lb hamburger',4.34,'Meat','0'),(16,'Strawberries',3.86,'Produce','0'),(17,'Lemon Pack',4.12,'Produce','0'),(18,'Blueberries 24 oz',6.38,'Produce','0'),(19,'Chicken Drumbsticks 14 Pack',9.18,'Meat','0'),(20,'BBQ sauce',3.58,'Condiments','0'),(21,'Chicken Leg Quarters 14 Pack',7.88,'Meat','0'),(22,'Chicken Wings 14 Pack',16.23,'Meat','0'),(23,'Franks Hot Sauce',3.26,'Condiments','0'),(24,'Italian Sausage Brick',3.57,'Meat','0'),(25,'Provolone Cheese Slices',6.28,'Dairy','0'),(26,'Shredded Mozerrela 2 cups',2.22,'Dairy','0'),(27,'Spicy Pepperoni',2.43,'Meat','0'),(28,'Diced Bell Pepper',0.77,'Produce','0'),(29,'Onion',0.64,'Produce','0'),(30,'Bacon Bits',3.90,'Meat','1'),(31,'Mushrooms',2.34,'Produce','0'),(32,'Black Olives',1.47,'Canned Goods','0'),(33,'Raos Marinara Sauce 24 oz',7.98,'Pasta','0'),(34,'Ribs',16.00,'Meat','0'),(35,'Apple Cider Vinegar',1.88,'Cooking','1'),(36,'Weber Rib Rub',6.58,'Spices','1'),(37,'1 lb italian sausage',3.94,'Meat','0'),(38,'1 lb ground turkey',3.16,'Meat','0'),(39,'Parmesan',3.82,'Dairy','0'),(40,'Eggs-6 pack',1.23,'Dairy','1'),(41,'Dried Basil',0.98,'Spices','1'),(42,'Salt',1.12,'Spices','3'),(43,'Minced Onion',2.97,'Spices','0'),(44,'Minced garlic',4.24,'Spices','1'),(45,'Cajun Spice',4.24,'Spices','1'),(46,'Lemon pepper seasoning',2.86,'Spices','1'),(47,'Aluminum Foil',1.98,'Paper','1'),(48,'Coffee Filter Pack',2.17,'Coffee','1'),(50,'Dish Detergent',5.74,'Home','1'),(51,'Paper Towels',4.87,'Paper','0'),(52,'Mr clean pads',4.77,'Home','1'),(53,'Raos Pizza Sauce',4.78,'Pasta','0'),(54,'Olive Oil',4.00,'Cooking','1'),(55,'Crushed Red Pepper',2.72,'Spices','1'),(56,'White Rum',10.00,'Drink','1'),(57,'Heavy Cream',3.92,'Dairy','0'),(58,'Cinnamon Sticks',3.97,'Spices','1'),(59,'Vanilla Vodka',9.00,'Alcohol','1'),(60,'Low Carb Splenda',6.30,'Spices','1'),(61,'Vanilla Extract',5.84,'Spices','1'),(62,'Dunkin Donuts Coffee',8.58,'Beverage','1'),(64,'Bell Pepper',0.77,'Produce','0'),(65,'Grated Mozerrella Cheese',3.98,'Dairy','0'),(66,'Oregeno',0.98,'Spices','1'),(67,'Butter 4 pack',3.58,'Dairy','1'),(68,'Cayenne Pepper',2.92,'Spices','1'),(69,'Wireless Charger',9.98,'Electronics','2'),(70,'Mancinos',20.00,'Fast Food','0'),(71,'Pizza Hut',50.00,'Fast Food','0'),(72,'Wings etc',62.00,'Fast Food','0'),(73,'Burger king',20.00,'Fast Food','0'),(74,'Kfc',40.00,'Fast Food','0'),(75,'Alcohol Vacation ',80.00,'Fun','0'),(76,'McDonalds ',20.00,'Fast food','0'),(77,'Rallys',20.00,'Fast food','0'),(78,'Dupont bar and grill',20.00,'Fast food','0'),(80,'Firehouse subs',20.00,'Fast food','0'),(81,'Arbys',20.00,'Fast food','0'),(82,'Hardys',20.00,'Fast food','0'),(83,'Taco bell',20.00,'Fast food','0'),(84,'Old Spice Body Soap',5.97,'Health and Body','1'),(85,'Old Spice Deoderant',5.47,'Health and Body','1'),(86,'Shaving Cream',1.84,'Health and Body','1'),(87,'Razors',15.00,'<a href=\"https://www.walmart.com/ip/Gillette-Fusion5-Men-s-Razor-Blade-Refills-4-Count/14071268?athbdg=L1600\">Health and Body</a>','0'),(88,'Toothpaste',3.44,'Health and Body','0'),(90,'Toothbrush',2.97,'Health and Body','2'),(91,'Sauerkraut ',1.98,'Canned Goods','1'),(92,'Black pepper',5.98,'Spices','2'),(93,'Fat bombs',8.98,'Health','0'),(94,'Jack links prime rib tender cuts',9.78,'Snacks J10','0'),(95,'Braggs Apple Cider',6.34,'Cooking','1'),(96,'Knife work sleeve ',1.00,'Home','0'),(97,'Plastic utensils ',6.42,'Home','1'),(98,'Five Star Notebook',6.98,'Office','1'),(99,'Pens',5.14,'Office','1'),(100,'Push pins',2.86,'Office','1'),(101,'Pine-Sol',6.74,'Cleaning','1'),(102,'Windex',2.97,'Cleaning','1'),(103,'MX Ergo Plus Wireless Mouse',99.99,'Electronics - Best Buy','1'),(104,'Logitech Wireless Keyboard - Lit',119.99,'Electronics - Best Buy','1'),(105,'Pledge',4.48,'Cleaning','1'),(106,'Samsung - Galaxy S22 Ultra 128GB (Unlocked)',899.00,'Electronics - Best Buy','0'),(107,'Samsung - Galaxy Watch4 Aluminum Smartwatch 44mm',279.00,'Electronics - Best Buy','0'),(108,'Vape Juice',11.99,'Cravin Vapes','0'),(109,'Coils 3 Pack',20.99,'Cravin Vapes','0'),(110,'Wall charger',4.88,'Electronics','0'),(111,'6 ft usb c cable',5.88,'Electronics','1'),(112,'3d printer to build mini titanic',279.00,'<a href=\"https://www.amazon.com/Integrated-Structure-Motherboard-Carborundum-8-66x8-66x9-84in/dp/B07FFTHMMN/ref=pd_aw_ic_dpcp_m_1_m_4?pd_rd_w=rxDZB&pf_rd_p=76ca361a-bf6a-4646-9a1c-ec5c5eafbb6b&pf_rd_r=TVGH1W9CYP4FR1BW83W9&pd_rd_r=dcb0fd71-b0f2-4e10-8c6b-63a6a46386c0&pd_rd_wg=Kz3s8&pd_rd_i=B07FFTHMMN\">Printer</a>','0'),(113,'Stapler',5.36,'Office','0'),(114,'Momentary Push Button Switch x 2',7.98,'<a href=\"https://www.amazon.com/gp/product/B01G821G6A/ref=as_li_tl?ie=UTF8&camp=1789&creative=9325&creativeASIN=B01G821G92&linkCode=as2&tag=hackerhouse-20&linkId=5d259c525266b38ce5546147100d3e0f&th=1\">LINK</a>','0'),(115,'PVC Project Board Ã— 2',7.27,'<a href=\"https://www.homedepot.com/p/Palight-ProjectPVC-12-in-x-12-in-x-0-236-in-Foam-PVC-Black-Sheet-159842/206402741\">LINK</a>','0'),(116,'8 Channel Relay Ã— 1',9.59,'<a href=\" https://goo.gl/CSpVdT\">LINK</a>','0'),(117,'Raspberry Pi 3 Model B Ã— 1',169.99,'<a href=\"https://www.amazon.com/PepperTech-Digital-Raspberry-Model-Installed/dp/B07JLQ9GYF/ref=sr_1_1_sspa?keywords=Raspberry+Pi+3+Model+B&qid=1652229760&sr=8-1-spons&psc=1&spLa=ZW5jcnlwdGVkUXVhbGlmaWVyPUExWlNFNjBaTTNUNFdBJmVuY3J5cHRlZElkPUEwNTM2OTU5T0lTSVNMWURDRDZPJmVuY3J5cHRlZEFkSWQ9QTA0NzUzNzkzVTZJRUpZTlhWUTRNJndpZGdldE5hbWU9c3BfYXRmJmFjdGlvbj1jbGlja1JlZGlyZWN0JmRvTm90TG9nQ2xpY2s9dHJ1ZQ==\">LINK</a>','0'),(118,'12V Switching Power Supply Ã— 1',9.79,'<a href=\"https://www.droking.com/100W-AC-Power-Supply-Switching-AC110-220V-to-DC-12V-8.5A-Buck-Converter-Voltage-Regulator-DC-12V-Adapter-Power-Supply-Module-Driver-Module\">LINK</a>','0'),(119,'Power Cable Ã— 1',7.99,'<a href=\"https://www.amazon.com/gp/product/B00005113L/ref=as_li_tl?ie=UTF8&camp=1789&creative=9325&creativeASIN=B00005113L&linkCode=as2&tag=hackerhouse-20&linkId=91841b4da2520e0b5f437a1835a12dff\">LINK</a>','0'),(120,'5V Regulator Ã— 1',7.99,'<a href=\"https://goo.gl/xVk14K\">LINK</a>','0'),(121,'Power Distribution Board Ã— 1',17.00,'<a href=\"https://www.amazon.com/gp/product/B01CU66VM2/ref=as_li_tl?ie=UTF8&camp=1789&creative=9325&creativeASIN=B01CU66VM2&linkCode=as2&tag=hackerhouse-20&linkId=f8c7b18cbe6a59305668e4a4cc8ca9c3\">LINK</a>','0'),(122,'Peristaltic Pump Ã— 6',12.78,'<a href=\"https://www.amazon.com/gp/product/B01IUVHB8E/ref=as_li_tl?ie=UTF8&camp=1789&creative=9325&creativeASIN=B01IUVHB8E&linkCode=as2&tag=hackerhouse-20&linkId=042cb752e964390bfb72864185928b64\">LINK</a>','0'),(123,'Food Grade Silicone Tubing 2mm Inner Diameter Ã— 3',1.00,'<a href=\"https://www.amazon.com/gp/product/B01C3GCZTM/ref=as_li_tl?ie=UTF8&camp=1789&creative=9325&creativeASIN=B01C3GCZTM&linkCode=as2&tag=hackerhouse-20&linkId=4e64cc85725fae991fb31f77c8c91cf8\">LINK</a>','0'),(124,'LED Strip Ã— 1',27.05,'<a href=\"https://www.amazon.com/Adafruit-DotStar-Digital-LED-Strip/dp/B01BMRUPKE\">LINK</a>','0'),(125,'Kitchen Funnel Ã— 1',8.65,'<a href=\"https://www.amazon.com/Lakatay-Stainless-Transferring-Ingredients-Funnel-Silver/dp/B0722V49LC/ref=sr_1_5?crid=1AIQ6BF1HB38Y&keywords=stainless%2Bkitchen%2Bfunnel&qid=1652230322&s=home-garden&sprefix=stainless%2Bkitchen%2Bfunnel%2Cgarden%2C97&sr=1-5&th=1\">LINK</a>','0'),(126,'OLED Display Ã— 1',19.99,'<a href=\"https://www.amazon.com/gp/product/B00HPLGW4A/ref=as_li_tl?ie=UTF8&camp=1789&creative=9325&creativeASIN=B00HPLGW4A&linkCode=as2&tag=hackerhouse-20&linkId=93b650badc6c9e034d2392a415887cf8\">LINK</a>','0'),(127,'1N4007 Diode Ã— 6',5.40,'<a href=\"https://idealblasting.com/1n4007-do-41-axial-silastic-guard-junction-standard-rectifier-diode-pack-of-20/\">LINK</a>','0'),(128,'Jumper wires Ã— 1 ',6.89,'<a href=\"https://www.amazon.com/Lakatay-Stainless-Transferring-Ingredients-Funnel-Silver/dp/B0722V49LC/ref=sr_1_5?crid=1AIQ6BF1HB38Y&keywords=stainless%2Bkitchen%2Bfunnel&qid=1652230322&s=home-garden&sprefix=stainless%2Bkitchen%2Bfunnel%2Cgarden%2C97&sr=1-5&th=1\">LINK</a>','0'),(129,'3mm Outdoor Mounting Tape Ã— 1 ',14.53,'<a href=\"https://www.amazon.com/Double-HitLights-Mounting-Waterproof-Length/dp/B07TC16SZ7/ref=sr_1_1_sspa?keywords=3m+outdoor+double+sided+tape&qid=1652230672&sr=8-1-spons&psc=1&spLa=ZW5jcnlwdGVkUXVhbGlmaWVyPUExWFVEV0RBU1dDNkI2JmVuY3J5cHRlZElkPUEwNzM4MTU2MUtOVzFJWFg3M0MwWSZlbmNyeXB0ZWRBZElkPUEwMDQwODk1MU8zWDFWTFdFSzQ5TSZ3aWRnZXROYW1lPXNwX2F0ZiZhY3Rpb249Y2xpY2tSZWRpcmVjdCZkb05vdExvZ0NsaWNrPXRydWU=\">LINK</a>','0'),(130,'Wood Screws Ã— 1 ',25.99,'<a href=\"https://www.amazon.com/Double-HitLights-Mounting-Waterproof-Length/dp/B07TC16SZ7/ref=sr_1_1_sspa?keywords=3m+outdoor+double+sided+tape&qid=1652230672&sr=8-1-spons&psc=1&spLa=ZW5jcnlwdGVkUXVhbGlmaWVyPUExWFVEV0RBU1dDNkI2JmVuY3J5cHRlZElkPUEwNzM4MTU2MUtOVzFJWFg3M0MwWSZlbmNyeXB0ZWRBZElkPUEwMDQwODk1MU8zWDFWTFdFSzQ5TSZ3aWRnZXROYW1lPXNwX2F0ZiZhY3Rpb249Y2xpY2tSZWRpcmVjdCZkb05vdExvZ0NsaWNrPXRydWU=\">LINK</a>','0'),(131,'M2.5 Screws Ã— 4 ',5.01,'<a href=\"https://www.amazon.com/Machine-Plated-Phillips-M2-5-0-45-Threads/dp/B000NHYR1S/ref=sr_1_3?c=ts&keywords=Machine+Screws&qid=1652230780&refinements=p_n_feature_fourteen_browse-bin%3A11434050011&s=industrial&sr=1-3&ts_id=16403531\">LINK</a>','0'),(132,'Gorilla Glue',7.59,'CVS','1'),(133,'Velcro',3.69,'Hardware','1'),(134,'Italan Seasoning',2.69,'Spices','1'),(135,'Onion Powder',3.50,'Spices','1'),(136,'Whole Milk Ricotta Cheese',2.12,'Dairy','0'),(137,'Garlic Powder',3.59,'Spices','1'),(140,'Ghee',6.98,'Dairy','1'),(141,'Sriracha',1.98,'Condiments','1'),(142,'Riced Cauliflower, Frozen, 12 oz',1.00,'Frozen','0'),(143,'Shredded Monterey Jack Shredded Cheeese 1 lb',2.22,'Dairy','0'),(144,'Mayo',3.98,'Condiments','0'),(145,'Broccoli Slaw',2.58,'Produce','0'),(146,'Frozen Kale 1 lb',1.42,'Frozen','0'),(147,'2 Tomatoes',2.74,'Produce','0'),(148,'Sour Cream',1.48,'Dairy','0'),(149,'Ranch Dressing Bacon 16 oz',3.00,'Condiments','0'),(150,'Garlic Cloves 3 pack',1.76,'Produce','0'),(151,'Spinach 16 oz',2.88,'Produce','0'),(152,'Chicken broth',2.70,'Cooking','0'),(153,'Cleared Item',0.00,'Cleared Item','0'),(154,'Bacon 10 piece',3.72,'Meat','0'),(155,'Hangers 10 pack',1.78,'Home','1'),(156,'Tony Chacheras seasoning',1.98,'Spices','0'),(157,'Treager spice rub',9.95,'Spices','0'),(158,'Blueberries 18 oz',4.78,'Produce','0'),(159,'DISCOUNT',-15.00,'Coupon','0'),(160,'Hot jalapeno and habenero shredded cheese 1 lb',2.22,'Dairy','0'),(161,'glass bowl',4.00,'Home','1'),(162,'Rib Fest',100.00,'FUN','0'),(163,'German Fest',40.00,'FUN','0'),(164,'Almond Flour',10.98,'Cooking','1'),(165,'Coconut flour',6.49,'Cooking','0'),(166,'Xanthum Gum',4.62,'Cooking','0'),(167,'Kosher Salt',1.88,'Spices','1'),(168,'Nutmeg',2.85,'Spices','1'),(169,'Pine Nuts',6.92,'Cooking','0'),(170,'Shower Spray',4.57,'Cleaning','1'),(171,'Pork Rinds',3.98,'Snacks','0'),(172,'Cauliflour Head',3.74,'Produce','0'),(173,'Bone in chicken breast',6.48,'Meat','0'),(174,'Paprika',3.12,'Spices','1'),(175,'Celery',2.98,'Produce','0'),(176,'Chili powder',3.78,'Spices','1'),(177,'Soy sauce',2.98,'Cooking','1'),(178,'Ground Cumin',3.27,'Spices','1'),(179,'Smoked Paprika',3.78,'Spices','0'),(180,'Beef Broth',2.78,'Cooking','0'),(181,'Vegetable Oil',4.78,'Cooking','1'),(182,'Lettuce',1.98,'Produce','0'),(184,'Lemon Juice',2.78,'Juice','0'),(185,'Chicken thigh bone in 10 pack',9.89,'Meat','0'),(186,'Small Franks hot sauce',1.66,'Condiments','0'),(187,'Amazon Alexa',50.00,'<a href = \"https://www.amazon.com/dp/B07XJ8C8F5/ref=mh_s9_acsd_al_c2_x_1_t?pf_rd_m=ATVPDKIKX0DER&pf_rd_s=mobile-hybrid-7&pf_rd_r=24SCM9YCBT05VV54G8TZ&pf_rd_t=30901&pf_rd_p=edfad812-5ab7-4ce3-b1d0-b9b5accb7282&pf_rd_i=9818047011\">link</a>','0'),(188,'beer',20.00,'s and v','0'),(189,'jello',1.80,'Cooking','0'),(190,'juice',3.80,'Juice','0'),(191,'Egg salad',5.00,'Deli','0'),(192,'Cream cheese 1 pack',2.48,'Dairy','0'),(193,'Salsa',2.79,'Mexican','0'),(194,'Panino hard salami cheese',5.47,'Deli','0'),(195,'Trash bags',7.49,'Paper','0'),(196,'Boxers 6 pack',21.00,'Clothes','0'),(197,'9 lb pork shoulder ',20.00,'Meat','0'),(198,'Bandaids',6.00,'Health and Body','1'),(199,'Shirt',15.00,'Clothes','2'),(201,'Kitchen pot 4qt',17.00,'Home','1'),(202,'Starbucks Mocha Coffee',8.98,'Coffee','1'),(203,'White Vinegar',3.00,'Cooking','1'),(204,'got2be spray glue',5.00,'body','1'),(205,'Cheddar Cheese block',2.98,'Dairy','1'),(206,'Mozerella Block',2.98,'Dairy','0'),(207,'Wireless Headphone',50.00,'Electronics','1'),(208,'Mixing bowl',7.00,'Home','3'),(209,'Heinz Ketchup Sugar Free',3.18,'Condiments','1'),(210,'Sugar Free peanut butter',4.94,'Cereal','0'),(211,'Coconut oil',4.94,'Cooking','0'),(212,'Cocoa powder',3.64,'Cooking','1'),(213,'Swerve ',7.58,'Cooking','1'),(214,'Pillow',10.00,'Bedding','6'),(215,'Aleve',10.00,'Health','1'),(216,'Pillow covers',10.00,'Bedding ','6'),(217,'3 hole binder',9.00,'Office','1'),(218,'3 hole puncher',4.44,'Office','1'),(219,'Binder Dividers',5.00,'<a href=\"https://www.walmart.com/ip/Pen-Gear-Vibrant-Color-8-Tab-Dividers-with-Pockets-Regular/622324481\">Office</a>','24'),(220,'Printer Paper',10.00,'Office','1'),(221,'3 lb hamburger',13.00,'Meat','0'),(222,'Ladel with hole',4.00,'Kitchen','1'),(223,'Toner majenta',9.00,'Electronics','0'),(224,'Starbucks vanilla ',5.72,'Coffee','1'),(225,'Sugar Free Ketchup',3.89,'Condiments','1'),(226,'Mio',3.28,'Drink','2'),(227,'Crystal light',2.68,'Drink','0'),(228,'Pumice',3.00,'Cleaning','0'),(229,'Gloves',2.99,'Cleaning','0'),(230,'Baking soda',1.79,'Cooking','1'),(231,'Bleach',5.00,'Cleaning','0'),(232,'Starbucks Cinnamon Coffee',8.98,'Coffee','1'),(233,'Coffee Carafe',12.00,'Home','2'),(234,'Ice trays',1.99,'Home','8'),(235,'spray olive oil',2.77,'Cooking','1'),(236,'Cherry tomatoes',3.32,'Produce','0'),(237,'Kale',2.78,'Produce','0'),(238,'Bananas',1.62,'Produce','0'),(239,'Oranges',5.98,'Produce','0'),(240,'Cilantro',0.98,'Produce','0'),(241,'Lime',2.78,'Produce','0'),(242,'Lime Juice',1.99,'Juice','0'),(243,'Apples',3.25,'Produce','0'),(244,'Pumpkin Spice',3.00,'Spices','1'),(245,'Vanilla Yogurt',2.36,'Dairy','1'),(247,'Apple Slicer',5.98,'Housewares','1'),(248,'Milk',1.76,'Dairy','0'),(249,'pepperjack block',2.79,'Dairy','0'),(250,'toilet paper',4.77,'Paper','0'),(251,'Sponge with a stick for handwashing dishes',8.00,'Home','0'),(252,'Facewash',5.79,'<a href=https://www.walmart.com/ip/NIVEA-MEN-Maximum-Hydration-Moisturizing-Face-Wash-5-Fl-Oz-Tube/10810948?fulfillmentIntent=In-store&athbdg=L1200>Home</a>','0'),(253,'Roku',25.00,'<a href=https://www.walmart.com/ip/Roku-Streaming-Stick-4K-Streaming-Device-4K-HDR-Dolby-Vision-with-Voice-Remote-and-TV-Controls/199415215?fulfillmentIntent=In-store&athbdg=L1800>Electronics</a>','0'),(254,'Bottled water',5.92,'Water','0'),(255,'Frozen Pepper and Onions',2.40,'<a href=https://www.walmart.com/ip/Great-Value-Pepper-Onion-Blend-20-oz-Frozen/539250805>Frozen</a>','0'),(256,'Frozen Cauliflower 48 oz',6.92,'<a href=https://www.walmart.com/ip/Birds-Eye-Cauliflower-Florets-Frozen-48-oz/206190896>Frozen</a>','0');
/*!40000 ALTER TABLE `items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `measurements`
--

DROP TABLE IF EXISTS `measurements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `measurements` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `unit_of_measurement` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `measurements`
--

LOCK TABLES `measurements` WRITE;
/*!40000 ALTER TABLE `measurements` DISABLE KEYS */;
INSERT INTO `measurements` VALUES (1,'tsp'),(2,'tbsp'),(3,'cup');
/*!40000 ALTER TABLE `measurements` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `recipe_lists`
--

DROP TABLE IF EXISTS `recipe_lists`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `recipe_lists` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `recipe_name` text DEFAULT NULL,
  `url` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `recipe_name` (`recipe_name`) USING HASH
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `recipe_lists`
--

LOCK TABLES `recipe_lists` WRITE;
/*!40000 ALTER TABLE `recipe_lists` DISABLE KEYS */;
INSERT INTO `recipe_lists` VALUES (1,'Beverages_recipe_table',''),(2,'Body_recipe_table',''),(3,'Bratwurst_recipe_table',''),(4,'Burritos_recipe_table',''),(5,'Chicken_Drumbsticks_recipe_table',''),(6,'Chicken_wings_recipe_table',NULL),(7,'Cleaning_Supplies_recipe_table',''),(8,'Electronic_needs_recipe_table',''),(9,'Jalapeno_Poppers_recipe_table',''),(10,'Meat_Pizza_recipe_table','https://ketoinpearls.com/sausage-crust-pizza/'),(11,'Meatballs_recipe_table','https://joyfilledeats.com/meatball-parm-casserole/#recipe'),(12,'Misc_recipe_table',''),(13,'Produce_recipe_table',''),(14,'Ribs_recipe_table',''),(15,'Snacks_recipe_table',NULL),(16,'Stuffed_Pizza_Bell_Peppers_recipe_table','https://kalynskitchen.com/low-carb-sausage-pepperoni-pizza-stuffed-peppers/#mv-creation-50-jtr'),(17,'Vacation_recipe_table',''),(18,'Vaping_Equipment_recipe_table',''),(33,'Electronic_Bartender_recipe_table','https://www.youtube.com/watch?v=2DopvpNF7J4'),(34,'Quick_List_recipe_table',''),(35,'Lasagna_recipe_table','https://peaceloveandlowcarb.com/just-like-the-real-thing-lasagna/#tasty-recipes-12196-jump-target'),(36,'Bacon_Wrapped_Cheese_Stuffed_Burgers_recipe_table','https://ketodietapp.com/Blog/lchf/bacon-wrapped-and-cheese-stuffed-burgers#preptime'),(37,'Buffalo_Chicken_Casserole_recipe_table','https://www.mincerepublic.com/buffalo-chicken-casserole/'),(38,'Chicken_Bacon_Ranch_Casserole_Recipe_recipe_table','https://www.wholesomeyum.com/recipes/chicken-bacon-ranch-casserole-recipe-easy-low-carb/'),(39,'Spices_recipe_table',''),(40,'Raviolli_recipe_table','https://www.gnom-gnom.com/spinach-ricotta-grain-free-keto-ravioli/'),(41,'Steak_and_eggs_recipe_table',''),(42,'Keto_Mac_and_Cheese_recipe_table','https://www.delish.com/cooking/nutrition/a29024668/keto-mac-and-cheese-recipe/'),(43,'Keto_Fried_Chicken_recipe_table','https://www.delish.com/cooking/nutrition/a29537911/keto-fried-chicken-recipe/'),(44,'Cheesy_bacon_ranch_chicken_breast_recipe_table','https://www.delish.com/cooking/recipe-ideas/a27156187/cheesy-bacon-ranch-chicken-reipe/'),(45,'Bacon_Wrapped_Meatloaf_recipe_table','https://www.delish.com/cooking/recipe-ideas/a23480870/keto-meatloaf-recipe/'),(46,'Keto_Chili_recipe_table','https://www.delish.com/cooking/recipe-ideas/a23103912/keto-chili-recipe/'),(47,'Cheese_steak_stuffed_peppers_recipe_table','https://www.delish.com/cooking/recipe-ideas/recipes/a51551/cheesesteak-stuffed-peppers-recipe/'),(48,'BLT_burger_recipe_table','https://www.delish.com/cooking/recipe-ideas/recipes/a54644/blt-burgers-recipe/'),(49,'deviled_eggs_recipe_table','https://www.wholesomeyum.com/keto-deviled-eggs-recipe/#jumptorecipe'),(50,'Chicken_Leg_Quarters_recipe_table',''),(51,'Cauliflower_Potato_Salad_recipe_table','https://www.wholesomeyum.com/recipes/cauliflower-potato-salad-low-carb-paleo-potato-salad/#jumptorecipe'),(52,'Cauliflower_Tots_recipe_table','https://www.wholesomeyum.com/cheesy-low-carb-cauliflower-tots-recipe/#jumptorecipe'),(53,'Pulled_pork_recipe_table','https://realsimplegood.com/crock-pot-pulled-pork/'),(54,'French_fries_recipe_table','https://imhungryforthat.com/keto-french-fries/#tasty-recipes-1440-jump-target'),(55,'Peanut_butter_fat_bombs_recipe_table','https://www.fittoservegroup.com/low-carb-chocolate-peanut-butter-fat-bombs/#mv-creation-52-jtr'),(56,'Cauliflower_pizza_recipe_table','https://detoxinista.com/wprm_print/recipe/23235'),(57,'Shaving_List_recipe_table',''),(58,'Kale_Smoothie_recipe_table',''),(59,'Salsa_recipe_table','https://www.foodnetwork.com/recipes/food-network-kitchen/nutribullet-salsa-6562395'),(60,'Apple_Cinnamon_Smoothie_recipe_table','https://loseweightbyeating.com/wprm_print/recipe/177796');
/*!40000 ALTER TABLE `recipe_lists` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-12-21  4:58:52
