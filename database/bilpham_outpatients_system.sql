-- MySQL dump 10.13  Distrib 8.0.38, for Win64 (x86_64)
--
-- Host: localhost    Database: bilpham_outpatients_system
-- ------------------------------------------------------
-- Server version	8.0.39

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `admins`
--

DROP TABLE IF EXISTS `admins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admins` (
  `admin_id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(100) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `full_name` varchar(100) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`admin_id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admins`
--

LOCK TABLES `admins` WRITE;
/*!40000 ALTER TABLE `admins` DISABLE KEYS */;
INSERT INTO `admins` VALUES (1,'admin','$2y$10$wGB4OnmVgSKYAAiWW4FZP.2JAB70SEN.Q5yopd28EN7NUuv1W.OaW','Super Admin','2025-05-09 11:39:47'),(2,'admin@bilpham.com','admin123','System Admin','2025-05-09 11:50:45');
/*!40000 ALTER TABLE `admins` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `appointments`
--

DROP TABLE IF EXISTS `appointments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `appointments` (
  `appointment_id` int NOT NULL AUTO_INCREMENT,
  `patient_id` int NOT NULL,
  `doctor_id` int NOT NULL,
  `appointment_date` date NOT NULL,
  `appointment_time` time NOT NULL,
  `status` enum('scheduled','completed','canceled') DEFAULT 'scheduled',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `reason` enum('Routine Check-up','Follow-up','New Symptoms','Chronic Condition','Other') NOT NULL,
  `additional_notes` text,
  PRIMARY KEY (`appointment_id`),
  KEY `patient_id` (`patient_id`),
  KEY `doctor_id` (`doctor_id`),
  CONSTRAINT `appointments_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`patient_id`) ON DELETE CASCADE,
  CONSTRAINT `appointments_ibfk_2` FOREIGN KEY (`doctor_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `appointments`
--

LOCK TABLES `appointments` WRITE;
/*!40000 ALTER TABLE `appointments` DISABLE KEYS */;
INSERT INTO `appointments` VALUES (2,3,5,'2025-03-13','09:00:00','scheduled','2025-02-06 21:33:59','Follow-up','Follow up on Leg Surgery'),(3,2,5,'2025-02-21','07:20:00','scheduled','2025-02-06 22:14:34','Chronic Condition','New medication'),(4,1,2,'2025-02-07','10:00:00','scheduled','2025-02-06 22:44:16','Routine Check-up',NULL),(5,3,5,'2025-02-08','06:00:00','completed','2025-02-06 22:53:11','Routine Check-up',''),(6,4,5,'2025-02-07','08:59:00','completed','2025-02-06 23:05:06','Routine Check-up',''),(7,3,7,'2025-05-02','15:00:00','scheduled','2025-04-04 11:33:52','New Symptoms','New'),(9,10,7,'2025-04-19','17:00:00','scheduled','2025-04-04 11:57:52','Routine Check-up',''),(10,10,5,'2025-06-25','20:00:00','scheduled','2025-04-04 11:58:22','Follow-up',''),(11,1,5,'2025-04-25','15:08:00','scheduled','2025-04-04 12:04:13','Routine Check-up',''),(12,1,5,'2025-06-26','20:00:00','completed','2025-04-04 12:04:40','Chronic Condition',''),(14,3,7,'2025-06-19','05:00:00','scheduled','2025-04-04 12:38:54','Routine Check-up',''),(15,11,7,'2025-05-21','15:00:00','scheduled','2025-05-07 12:16:01','New Symptoms',''),(16,11,5,'2025-05-30','20:00:00','scheduled','2025-05-07 12:23:07','Routine Check-up',''),(17,4,7,'2025-05-31','13:07:00','scheduled','2025-05-09 07:04:20','Routine Check-up',''),(18,3,5,'2025-05-16','10:00:00','scheduled','2025-05-16 17:05:04','Routine Check-up',NULL),(19,3,7,'2025-05-30','02:00:00','scheduled','2025-05-16 19:31:54','Routine Check-up','');
/*!40000 ALTER TABLE `appointments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `feedback`
--

DROP TABLE IF EXISTS `feedback`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `feedback` (
  `feedback_id` int NOT NULL AUTO_INCREMENT,
  `patient_id` int NOT NULL,
  `doctor_id` int NOT NULL,
  `rating` int DEFAULT NULL,
  `comments` text,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`feedback_id`),
  KEY `patient_id` (`patient_id`),
  KEY `doctor_id` (`doctor_id`),
  CONSTRAINT `feedback_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`patient_id`) ON DELETE CASCADE,
  CONSTRAINT `feedback_ibfk_2` FOREIGN KEY (`doctor_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE,
  CONSTRAINT `feedback_chk_1` CHECK ((`rating` between 1 and 5))
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `feedback`
--

LOCK TABLES `feedback` WRITE;
/*!40000 ALTER TABLE `feedback` DISABLE KEYS */;
INSERT INTO `feedback` VALUES (2,3,5,2,'Not good','2025-04-04 11:33:12'),(3,1,5,4,'V.good','2025-04-04 12:06:12'),(5,3,5,3,'Professional','2025-05-09 09:11:08');
/*!40000 ALTER TABLE `feedback` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `medical_records`
--

DROP TABLE IF EXISTS `medical_records`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `medical_records` (
  `record_id` int NOT NULL AUTO_INCREMENT,
  `appointment_id` int NOT NULL,
  `diagnosis` text,
  `prescription` text,
  `notes` text,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`record_id`),
  KEY `appointment_id` (`appointment_id`),
  CONSTRAINT `medical_records_ibfk_1` FOREIGN KEY (`appointment_id`) REFERENCES `appointments` (`appointment_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `medical_records`
--

LOCK TABLES `medical_records` WRITE;
/*!40000 ALTER TABLE `medical_records` DISABLE KEYS */;
INSERT INTO `medical_records` VALUES (2,3,'Primary Hypertension','Lifestyle modifications: Reduce salt intake, exercise regularly.','Monitor blood pressure weekly.','2025-02-06 22:33:44'),(3,2,'Type 2 Diabetes Mellitus','Metformin 500mg – Take 1 tablet twice daily with meals.','Return in 3 months for HbA1c test.','2025-02-06 22:50:07'),(4,3,'Peptic Ulcer Disease','Avoid spicy and acidic foods.','Return if pain persists.','2025-02-06 22:50:53'),(5,6,'Fever and cough','Three aspirin painkillers','Rest','2025-04-04 11:39:51'),(6,3,'chronic fatigue','Rest and less work','Dont carry heavy things','2025-04-04 12:05:39'),(8,6,'Coughs','SOme aloe vera pills','Keep warm','2025-05-08 13:51:50'),(9,12,'Blacking out','Dont drink','Stay away from alcohol','2025-05-08 14:29:15'),(10,5,'Diabetes','metformin, sulfonylureas, glitazones, glinides, gliptins, and gliflozins','No sugar intake','2025-05-09 06:44:33'),(11,6,'High blood pressure','ACE inhibitors, ARBs, calcium channel blockers, and beta-blockers','Don\'t get angry','2025-05-09 07:02:45');
/*!40000 ALTER TABLE `medical_records` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patients`
--

DROP TABLE IF EXISTS `patients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `patients` (
  `patient_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `date_of_birth` date DEFAULT NULL,
  `gender` enum('male','female','other') DEFAULT NULL,
  `address` text,
  PRIMARY KEY (`patient_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `patients_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patients`
--

LOCK TABLES `patients` WRITE;
/*!40000 ALTER TABLE `patients` DISABLE KEYS */;
INSERT INTO `patients` VALUES (1,2,'2003-02-06','male','100 Nairobi'),(2,3,'1992-07-15','male','10928 Rongai'),(3,4,'1991-06-12','female','1092 Thika'),(4,6,NULL,NULL,NULL),(5,6,'1972-05-09','female','27 Kambiti'),(6,4,'1991-06-12','female','1092 Thika'),(7,4,'1991-06-12','female','1092 Thika'),(8,3,'1992-07-15','male','10928 Rongai'),(9,3,'1992-07-15','male','10928 Rongai'),(10,8,'2025-04-18','male','100 Nairobi'),(11,9,'2025-05-14','male','4562 Ruiru'),(12,9,'2025-05-14','male','4562 Ruiru'),(13,9,'2025-05-14','male','4562 Ruiru'),(14,4,'1991-06-11','female','1092 Thika'),(15,6,'2009-02-10','female','1006 Nzioia');
/*!40000 ALTER TABLE `patients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `full_name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `phone_number` varchar(15) DEFAULT NULL,
  `role` enum('admin','doctor','patient') NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (2,'John Ngei','ngei@gmail.com','$2y$10$NmBO3Opg1Y4PZCuX7iE7BOUIuycUNrCqYXN.Rplm6Ka.bcDJ4lJFq','0706095624','patient','2025-02-06 18:58:50'),(3,'Ezekiel Kimeu','kimeu@gmail.com','$2y$10$cNs6EsTwr5QaUSiVF9JNkO0AUHwunjuk/eoulyihUqNSoLz8QAT.O','0700004095','patient','2025-02-06 20:00:46'),(4,'Anastacia Koira','koira@gmail.com','$2y$10$EMdz56zHL4h0dt0F86Ysh.u2QMTDt4H8j7LLiSIb5XLSqVNWFrzlC','0725262773','patient','2025-02-06 21:19:14'),(5,'Tony Mutunga','tmutunga@gmail.com','$2y$10$ysvGVXA3dmnZz7spU6SZtejNR/66cEZ7325mS7x2CmbjQmQxgPRd2','0706624111','doctor','2025-02-06 21:32:44'),(6,'Joyce Mwaniki','mwaniki@gmail.com','$2y$10$GTjB1Tie/JXLBHgHWJDtTuTsAaeqhquGou0L7/ItRqYDgioUm5KOO','25479087776','patient','2025-02-06 22:54:17'),(7,'John Ochieng','ochieng@gmail.com','$2y$10$D8uZs8QNprP4oLUTIDgrAO.opvQu/wh4ibT2gucvlgc8fB1tVte9a','0741641725','doctor','2025-02-18 06:25:29'),(8,'Albanus Mutati','mutati@gmail.com','$2y$10$Ycelj3o8p2EUTL0kKqY6cO4slDaFeXtj9OVeubq/AbtxPLvxM0SZ2','0706624444','patient','2025-04-04 11:57:03'),(9,'John Doe','jdoe@gmail.com','$2y$10$VOapEXIzzB8wbdOyMpm1s.EwscQOISeKqiP4.gp2jMS35KPGQ0NWe','0704526700','patient','2025-05-07 12:14:43'),(10,'System Admin','admin@bilpham.com','admin123','0703535454','admin','2025-05-09 11:47:32');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-05-17  2:45:11
