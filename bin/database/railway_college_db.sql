-- MySQL dump 10.13  Distrib 9.6.0, for macos15 (arm64)
--
-- Host: localhost    Database: railway_college_db
-- ------------------------------------------------------
-- Server version	9.6.0

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
SET @MYSQLDUMP_TEMP_LOG_BIN = @@SESSION.SQL_LOG_BIN;
SET @@SESSION.SQL_LOG_BIN= 0;

--
-- GTID state at the beginning of the backup 
--

SET @@GLOBAL.GTID_PURGED=/*!80000 '+'*/ 'ac4af188-16c6-11f1-8fc4-0cf1930f8e9e:1-2538';

--
-- Table structure for table `bookings`
--

DROP TABLE IF EXISTS `bookings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bookings` (
  `booking_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `train_id` int NOT NULL,
  `journey_date` date NOT NULL,
  `passenger_name` varchar(100) NOT NULL,
  `passenger_age` int NOT NULL,
  `fare` decimal(10,2) NOT NULL,
  `status` enum('CONFIRMED','CANCELLED') DEFAULT 'CONFIRMED',
  `booking_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`booking_id`),
  KEY `user_id` (`user_id`),
  KEY `train_id` (`train_id`),
  CONSTRAINT `bookings_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`),
  CONSTRAINT `bookings_ibfk_2` FOREIGN KEY (`train_id`) REFERENCES `trains` (`train_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bookings`
--

LOCK TABLES `bookings` WRITE;
/*!40000 ALTER TABLE `bookings` DISABLE KEYS */;
INSERT INTO `bookings` VALUES (1,1,1,'2026-11-15','Agradip Chakravorty',20,1800.00,'CANCELLED','2026-11-10 13:47:07'),(2,2,1,'2026-11-11','abdul',23,1800.00,'CONFIRMED','2026-11-10 17:46:30'),(3,7,1,'2026-11-11','arsalan',23,1800.00,'CONFIRMED','2026-11-10 17:54:41'),(4,8,1,'2026-11-13','viraj',20,1800.00,'CANCELLED','2026-11-10 18:32:34'),(5,2,2,'2026-11-13','aak',20,1500.00,'CONFIRMED','2026-11-11 03:56:20');
/*!40000 ALTER TABLE `bookings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cancellations`
--

DROP TABLE IF EXISTS `cancellations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cancellations` (
  `cancellation_id` int NOT NULL AUTO_INCREMENT,
  `booking_id` int NOT NULL,
  `cancelled_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `reason` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`cancellation_id`),
  KEY `booking_id` (`booking_id`),
  CONSTRAINT `cancellations_ibfk_1` FOREIGN KEY (`booking_id`) REFERENCES `bookings` (`booking_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cancellations`
--

LOCK TABLES `cancellations` WRITE;
/*!40000 ALTER TABLE `cancellations` DISABLE KEYS */;
INSERT INTO `cancellations` VALUES (1,1,'2026-11-10 13:47:18','Cancelled by user'),(2,4,'2026-11-10 18:32:45','Cancelled by user');
/*!40000 ALTER TABLE `cancellations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stations`
--

DROP TABLE IF EXISTS `stations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stations` (
  `station_id` int NOT NULL AUTO_INCREMENT,
  `station_name` varchar(100) NOT NULL,
  `city` varchar(100) NOT NULL,
  PRIMARY KEY (`station_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stations`
--

LOCK TABLES `stations` WRITE;
/*!40000 ALTER TABLE `stations` DISABLE KEYS */;
INSERT INTO `stations` VALUES (1,'Howrah Junction','Kolkata'),(2,'Sealdah','Kolkata'),(3,'New Delhi','Delhi'),(4,'Mumbai Central','Mumbai'),(5,'Bhubaneswar','Bhubaneswar');
/*!40000 ALTER TABLE `stations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `trains`
--

DROP TABLE IF EXISTS `trains`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `trains` (
  `train_id` int NOT NULL AUTO_INCREMENT,
  `train_name` varchar(100) NOT NULL,
  `source` varchar(100) NOT NULL,
  `destination` varchar(100) NOT NULL,
  `departure_time` time NOT NULL,
  `arrival_time` time NOT NULL,
  `total_seats` int NOT NULL,
  `available_seats` int NOT NULL,
  `fare` decimal(10,2) NOT NULL,
  PRIMARY KEY (`train_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trains`
--

LOCK TABLES `trains` WRITE;
/*!40000 ALTER TABLE `trains` DISABLE KEYS */;
INSERT INTO `trains` VALUES (1,'Howrah Rajdhani','Kolkata','Delhi','16:50:00','10:00:00',100,98,1800.00),(2,'Duronto Express','Kolkata','Mumbai','08:20:00','21:30:00',80,79,1500.00),(3,'Shatabdi Express','Kolkata','Bhubaneswar','06:00:00','13:00:00',60,60,750.00);
/*!40000 ALTER TABLE `trains` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `email` varchar(120) NOT NULL,
  `password` varchar(64) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `role` enum('USER','ADMIN') DEFAULT 'USER',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Agradip Chakravorty','chakravortyagradip@gmail.com','bef57ec7f53a6d40beb640a780a639c83bc29ac8a9816f1fc6c5c6dcd93c4721','9073744673','ADMIN','2026-11-10 13:12:13'),(2,'Abdul Ahad Khan','aak@gmail.com','bef57ec7f53a6d40beb640a780a639c83bc29ac8a9816f1fc6c5c6dcd93c4721','9873647584','USER','2026-11-10 17:32:44'),(4,'Ayush Verma','averma@gmail.com','bef57ec7f53a6d40beb640a780a639c83bc29ac8a9816f1fc6c5c6dcd93c4721','9876374658','USER','2026-11-10 17:50:16'),(5,'Angshuman Tripathy','atripathy@gmail.com','bef57ec7f53a6d40beb640a780a639c83bc29ac8a9816f1fc6c5c6dcd93c4721','9874856473','USER','2026-11-10 17:51:05'),(6,'Aditya Aryan','aaryan@gmail.com','bef57ec7f53a6d40beb640a780a639c83bc29ac8a9816f1fc6c5c6dcd93c4721','9374859481','USER','2026-11-10 17:52:23'),(7,'arsalan azam','azamarsalan@gmail.com','bef57ec7f53a6d40beb640a780a639c83bc29ac8a9816f1fc6c5c6dcd93c4721','9837464538','USER','2026-11-10 17:54:01'),(8,'viraj mahajan','vmahajan@gmail.com','bef57ec7f53a6d40beb640a780a639c83bc29ac8a9816f1fc6c5c6dcd93c4721','9837467391','USER','2026-11-10 18:32:09');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
SET @@SESSION.SQL_LOG_BIN = @MYSQLDUMP_TEMP_LOG_BIN;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-11-11  9:41:34
