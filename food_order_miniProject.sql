-- MySQL dump 10.13  Distrib 8.0.40, for Win64 (x86_64)
--
-- Host: localhost    Database: food_ordering_system
-- ------------------------------------------------------
-- Server version	8.0.40

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `customers`
--

DROP TABLE IF EXISTS `customers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customers` (
  `customer_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `phone` varchar(15) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `city` varchar(50) DEFAULT 'Pune',
  PRIMARY KEY (`customer_id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customers`
--

LOCK TABLES `customers` WRITE;
/*!40000 ALTER TABLE `customers` DISABLE KEYS */;
INSERT INTO `customers` VALUES (1,'Aditya Joshi','9876543210','aditya.j@gmail.com','Pune'),(2,'Sneha Patil','9823456789','sneha.patil@gmail.com','Pune'),(3,'Rohan Deshmukh','9765432101','rohan.d@gmail.com','Pune'),(4,'Pooja Kulkarni','9922334455','pooja.k@gmail.com','Pune'),(5,'Nikhil Khot','9845123456','nikhil.k@hotmail.com','Pune'),(6,'Sakshi Shinde','9001234567','sakshi.s@rediffmail.com','Pune'),(7,'Aman Pawar','9090909090','aman.pawar@gmail.com','Pune'),(8,'Mitali Chavan','9012345678','mitali.c@yahoo.com','Pune'),(9,'Aniket Gawade','9023456789','aniketg@outlook.com','Pune'),(10,'Tanvi Dixit','9034567890','tanvi.dixit@gmail.com','Pune'),(11,'Yash Naik','9045678901','yash.naik@gmail.com','Pune'),(12,'Rutuja Jadhav','9056789012','rutuja.j@ymail.com','Pune'),(13,'Tushar Bhosale','9067890123','tushar.bhosale@gmail.com','Pune'),(14,'Prachi Thorat','9078901234','prachi.t@hotmail.com','Pune'),(15,'Siddharth Phadke','9089012345','sid.phadke@gmail.com','Pune'),(16,'Meghna Kharat','9090123456','meghna.kharat@yahoo.com','Pune'),(17,'Omkar Dumbre','9111234567','omkar.dumbre@gmail.com','Pune'),(18,'Shruti Bhate','9122345678','shruti.bhate@rediff.com','Pune'),(19,'Jaydeep Salunkhe','9133456789','jaydeep.s@ymail.com','Pune'),(20,'Vaishnavi Karve','9144567890','vaishnavi.k@gmail.com','Pune'),(21,'Riya Sharma','9876543210','riya@example.com','Pune'),(22,'Amit Verma','8765432109','amit@example.com','Pune'),(23,'Priya Desai','7654321098','priya@example.com','Pune'),(24,'Kunal Joshi','6543210987','kunal@example.com','Pune'),(25,'Sneha Kapoor','5432109876','sneha@example.com','Pune');
/*!40000 ALTER TABLE `customers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dishes`
--

DROP TABLE IF EXISTS `dishes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dishes` (
  `dish_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `price` decimal(8,2) DEFAULT NULL,
  `restaurant_id` int DEFAULT NULL,
  PRIMARY KEY (`dish_id`),
  KEY `restaurant_id` (`restaurant_id`),
  CONSTRAINT `dishes_ibfk_1` FOREIGN KEY (`restaurant_id`) REFERENCES `restaurants` (`restaurant_id`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dishes`
--

LOCK TABLES `dishes` WRITE;
/*!40000 ALTER TABLE `dishes` DISABLE KEYS */;
INSERT INTO `dishes` VALUES (1,'Masala Dosa',90.00,1),(2,'Idli Sambar',60.00,1),(3,'Upma',50.00,1),(4,'Filter Coffee',40.00,1),(5,'Puran Poli',70.00,2),(6,'Thalipeeth',65.00,2),(7,'Sabudana Khichdi',60.00,2),(8,'Misal Pav',55.00,2),(9,'Chicken Biryani',180.00,3),(10,'Veg Biryani',150.00,3),(11,'Raita',30.00,3),(12,'Paneer Biryani',170.00,3),(13,'Paneer Butter Masala',160.00,4),(14,'Butter Naan',40.00,4),(15,'Gulab Jamun',35.00,4),(16,'Tandoori Roti',25.00,4),(17,'Bun Maska',25.00,5),(18,'Omelette Pav',40.00,5),(19,'Veg Puff',35.00,5),(20,'Cold Coffee',60.00,5),(21,'Butter Chicken Bao',120.00,6),(22,'Desi Tacos',130.00,6),(23,'Tandoori Momos',100.00,6),(24,'Spicy Paneer Wrap',90.00,6),(25,'Shrewsbury Biscuits',100.00,7),(26,'Mawa Cake',50.00,7),(27,'Rum Ball',60.00,7),(28,'Fruit Cake',80.00,7),(29,'Medu Vada',45.00,8),(30,'Set Dosa',70.00,8),(31,'Tomato Uttapam',75.00,8),(32,'Kesar Shira',50.00,8);
/*!40000 ALTER TABLE `dishes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orderitems`
--

DROP TABLE IF EXISTS `orderitems`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orderitems` (
  `order_item_id` int NOT NULL AUTO_INCREMENT,
  `order_id` int DEFAULT NULL,
  `dish_id` int DEFAULT NULL,
  `quantity` int DEFAULT NULL,
  PRIMARY KEY (`order_item_id`),
  KEY `order_id` (`order_id`),
  KEY `dish_id` (`dish_id`),
  CONSTRAINT `orderitems_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`),
  CONSTRAINT `orderitems_ibfk_2` FOREIGN KEY (`dish_id`) REFERENCES `dishes` (`dish_id`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orderitems`
--

LOCK TABLES `orderitems` WRITE;
/*!40000 ALTER TABLE `orderitems` DISABLE KEYS */;
INSERT INTO `orderitems` VALUES (1,1,1,2),(2,1,3,1),(3,2,5,2),(4,2,8,1),(5,3,9,1),(6,4,7,3),(7,5,12,1),(8,6,14,2),(9,7,17,1),(10,8,18,2),(11,9,6,3),(12,10,21,1),(13,11,22,1),(14,12,24,2),(15,13,25,1),(16,14,26,2),(17,15,30,1),(18,3,2,2),(19,6,15,1),(20,9,10,1),(21,5,11,2),(22,10,4,1),(23,12,16,1),(24,13,13,2),(25,14,19,1),(26,1,1,2),(27,2,2,1),(28,3,3,3),(29,4,1,1),(30,5,4,2),(31,6,2,2),(32,7,3,1),(33,8,5,2),(34,9,2,1),(35,10,1,2);
/*!40000 ALTER TABLE `orderitems` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `order_id` int NOT NULL AUTO_INCREMENT,
  `customer_id` int DEFAULT NULL,
  `restaurant_id` int DEFAULT NULL,
  `order_time` datetime DEFAULT NULL,
  `total_amount` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`order_id`),
  KEY `customer_id` (`customer_id`),
  KEY `restaurant_id` (`restaurant_id`),
  CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`),
  CONSTRAINT `orders_ibfk_2` FOREIGN KEY (`restaurant_id`) REFERENCES `restaurants` (`restaurant_id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (1,1,1,'2025-04-01 12:00:00',190.00),(2,2,2,'2025-04-02 13:15:00',130.00),(3,3,3,'2025-04-03 14:30:00',180.00),(4,4,4,'2025-04-03 18:45:00',200.00),(5,5,5,'2025-04-04 10:20:00',120.00),(6,6,6,'2025-04-05 19:00:00',250.00),(7,7,7,'2025-04-06 08:50:00',90.00),(8,8,8,'2025-04-06 21:10:00',165.00),(9,9,3,'2025-04-07 11:40:00',300.00),(10,10,4,'2025-04-08 16:25:00',220.00),(11,11,1,'2025-04-09 13:35:00',100.00),(12,12,2,'2025-04-10 09:05:00',110.00),(13,13,5,'2025-04-11 14:50:00',85.00),(14,14,6,'2025-04-11 20:00:00',140.00),(15,15,7,'2025-04-12 18:30:00',130.00),(16,1,1,'2025-04-15 15:32:11',450.00),(17,2,1,'2025-04-15 15:32:11',320.00),(18,3,2,'2025-04-14 15:32:11',210.00),(19,4,3,'2025-04-13 15:32:11',580.00),(20,1,1,'2025-04-15 15:32:11',290.00),(21,5,2,'2025-04-12 15:32:11',620.00),(22,2,1,'2025-04-15 15:32:11',500.00),(23,3,3,'2025-04-14 15:32:11',340.00),(24,4,2,'2025-04-15 15:32:11',470.00),(25,5,1,'2025-04-15 15:32:11',390.00);
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ratings`
--

DROP TABLE IF EXISTS `ratings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ratings` (
  `rating_id` int NOT NULL AUTO_INCREMENT,
  `customer_id` int DEFAULT NULL,
  `restaurant_id` int DEFAULT NULL,
  `rating` int DEFAULT NULL,
  `review_text` text,
  `rating_time` datetime DEFAULT NULL,
  PRIMARY KEY (`rating_id`),
  KEY `customer_id` (`customer_id`),
  KEY `restaurant_id` (`restaurant_id`),
  CONSTRAINT `ratings_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`),
  CONSTRAINT `ratings_ibfk_2` FOREIGN KEY (`restaurant_id`) REFERENCES `restaurants` (`restaurant_id`),
  CONSTRAINT `ratings_chk_1` CHECK ((`rating` between 1 and 5))
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ratings`
--

LOCK TABLES `ratings` WRITE;
/*!40000 ALTER TABLE `ratings` DISABLE KEYS */;
INSERT INTO `ratings` VALUES (1,1,1,5,'Delicious food and quick delivery!','2025-04-01 13:00:00'),(2,2,2,4,'Tasty, but delivery was a bit late.','2025-04-02 14:20:00'),(3,3,3,3,'Food was okay, could be better.','2025-04-03 15:45:00'),(4,4,4,5,'Amazing biryani! Highly recommended.','2025-04-03 18:30:00'),(5,5,5,2,'Not very fresh this time.','2025-04-04 11:15:00'),(6,6,6,4,'Paneer tikka was great!','2025-04-05 20:10:00'),(7,7,7,5,'Loved their thali, must try.','2025-04-06 09:45:00'),(8,8,8,3,'Momos were average, not spicy.','2025-04-06 22:00:00'),(9,9,3,5,'Consistent quality and tasty.','2025-04-07 12:20:00'),(10,10,4,4,'Nice packaging and hot food.','2025-04-08 17:30:00'),(11,11,1,5,'Butter chicken is to die for!','2025-04-09 14:00:00'),(12,12,2,4,'Quick and easy dinner.','2025-04-10 10:00:00'),(13,13,5,2,'Too oily.','2025-04-11 15:00:00'),(14,14,6,5,'Super fresh and yummy.','2025-04-11 20:30:00'),(15,15,7,4,'Loved the variety.','2025-04-12 19:10:00');
/*!40000 ALTER TABLE `ratings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `restaurants`
--

DROP TABLE IF EXISTS `restaurants`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `restaurants` (
  `restaurant_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `location` varchar(100) DEFAULT NULL,
  `cuisine_type` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`restaurant_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `restaurants`
--

LOCK TABLES `restaurants` WRITE;
/*!40000 ALTER TABLE `restaurants` DISABLE KEYS */;
INSERT INTO `restaurants` VALUES (1,'Vaishali Restaurant','FC Road, Pune','South Indian'),(2,'Durvankur','Sadashiv Peth, Pune','Maharashtrian'),(3,'Biryani Blues','Koregaon Park, Pune','Hyderabadi'),(4,'SP?s Biryani House','Deccan Gymkhana, Pune','North Indian'),(5,'Cafe Goodluck','Deccan, Pune','Fast Food'),(6,'The Urban Foundry','Baner, Pune','Modern Indian'),(7,'Kayani Bakery','Camp, Pune','Bakery'),(8,'Wadeshwar','JM Road, Pune','South Indian');
/*!40000 ALTER TABLE `restaurants` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reviews`
--

DROP TABLE IF EXISTS `reviews`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reviews` (
  `review_id` int NOT NULL AUTO_INCREMENT,
  `customer_id` int DEFAULT NULL,
  `dish_id` int DEFAULT NULL,
  `restaurant_id` int DEFAULT NULL,
  `rating` int DEFAULT NULL,
  `review_text` text,
  `review_date` datetime DEFAULT NULL,
  PRIMARY KEY (`review_id`),
  KEY `customer_id` (`customer_id`),
  KEY `dish_id` (`dish_id`),
  KEY `restaurant_id` (`restaurant_id`),
  CONSTRAINT `reviews_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`),
  CONSTRAINT `reviews_ibfk_2` FOREIGN KEY (`dish_id`) REFERENCES `dishes` (`dish_id`),
  CONSTRAINT `reviews_ibfk_3` FOREIGN KEY (`restaurant_id`) REFERENCES `restaurants` (`restaurant_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reviews`
--

LOCK TABLES `reviews` WRITE;
/*!40000 ALTER TABLE `reviews` DISABLE KEYS */;
INSERT INTO `reviews` VALUES (1,1,2,1,5,'Excellent dish! Loved the taste at this restaurant.','2025-04-15 12:30:00'),(2,2,3,2,4,'Good, but could use a bit more spice at this place.','2025-04-14 18:45:00'),(3,3,1,1,3,'It was okay, not what I expected from this restaurant.','2025-04-13 14:00:00');
/*!40000 ALTER TABLE `reviews` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-04-15 19:05:35
