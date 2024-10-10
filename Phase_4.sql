-- MySQL dump 10.13  Distrib 8.0.20, for Win64 (x86_64)
--
-- Host: localhost    Database: society_management_system
-- ------------------------------------------------------
-- Server version	8.0.20

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
-- Table structure for table `age_from_dob`
--

DROP TABLE IF EXISTS `age_from_dob`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `age_from_dob` (
  `DOB` date NOT NULL,
  `Age` int DEFAULT NULL,
  PRIMARY KEY (`DOB`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `age_from_dob`
--

LOCK TABLES `age_from_dob` WRITE;
/*!40000 ALTER TABLE `age_from_dob` DISABLE KEYS */;
INSERT INTO `age_from_dob` VALUES ('1971-08-23',41),('1973-04-01',39),('1975-08-21',37),('1975-08-23',37),('1978-08-23',34),('2000-06-14',22),('2003-06-09',19),('2003-06-14',19);
/*!40000 ALTER TABLE `age_from_dob` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `building`
--

DROP TABLE IF EXISTS `building`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `building` (
  `Building_identifiers` varchar(1) NOT NULL,
  `Security_number` int DEFAULT NULL,
  `Number_of_Flats` int DEFAULT NULL,
  PRIMARY KEY (`Building_identifiers`),
  KEY `Security_number` (`Security_number`),
  CONSTRAINT `building_ibfk_1` FOREIGN KEY (`Security_number`) REFERENCES `security` (`Security_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `building`
--

LOCK TABLES `building` WRITE;
/*!40000 ALTER TABLE `building` DISABLE KEYS */;
INSERT INTO `building` VALUES ('A',NULL,1),('B',NULL,2),('C',NULL,2),('D',NULL,1);
/*!40000 ALTER TABLE `building` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `complaints`
--

DROP TABLE IF EXISTS `complaints`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `complaints` (
  `Complaint_ID` int NOT NULL,
  `Flat_number` varchar(5) NOT NULL,
  `Complaint_type` varchar(100) DEFAULT NULL,
  `Complaint_date` date DEFAULT NULL,
  `Resolve_Status` int DEFAULT NULL,
  PRIMARY KEY (`Complaint_ID`),
  KEY `Flat_number` (`Flat_number`),
  CONSTRAINT `complaints_ibfk_1` FOREIGN KEY (`Flat_number`) REFERENCES `flats` (`Flat_number`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `complaints`
--

LOCK TABLES `complaints` WRITE;
/*!40000 ALTER TABLE `complaints` DISABLE KEYS */;
INSERT INTO `complaints` VALUES (1267,'A-101','Electrical','2022-11-05',0),(1269,'A-101','Tap Issue','2022-11-11',1),(1500,'B-203','Tubelight Issue','2022-11-03',0),(1504,'D-001','Furniture','2022-10-29',1),(1779,'B-303','Water Leakage','2022-11-01',0);
/*!40000 ALTER TABLE `complaints` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flats`
--

DROP TABLE IF EXISTS `flats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `flats` (
  `Flat_number` varchar(5) NOT NULL,
  `Owner_PhoneNo` int DEFAULT NULL,
  `Building_identifiers` varchar(1) DEFAULT NULL,
  `Number_of_Residents` int DEFAULT NULL,
  PRIMARY KEY (`Flat_number`),
  KEY `Owner_PhoneNo` (`Owner_PhoneNo`),
  KEY `Building_identifiers` (`Building_identifiers`),
  CONSTRAINT `flats_ibfk_1` FOREIGN KEY (`Owner_PhoneNo`) REFERENCES `residents` (`Phone_number`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `flats_ibfk_2` FOREIGN KEY (`Building_identifiers`) REFERENCES `building` (`Building_identifiers`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flats`
--

LOCK TABLES `flats` WRITE;
/*!40000 ALTER TABLE `flats` DISABLE KEYS */;
INSERT INTO `flats` VALUES ('A-101',982123646,'A',3),('B-203',956781172,'B',2),('B-303',765481175,'B',2),('C-101',972417652,'C',3),('C-103',972481652,'C',2),('D-001',944417882,'D',3);
/*!40000 ALTER TABLE `flats` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `handles`
--

DROP TABLE IF EXISTS `handles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `handles` (
  `RWA_Phone_no` int DEFAULT NULL,
  `Complaint_ID` int DEFAULT NULL,
  `Security_ID` int DEFAULT NULL,
  `Worker_ID` int DEFAULT NULL,
  KEY `RWA_Phone_no` (`RWA_Phone_no`),
  KEY `Complaint_ID` (`Complaint_ID`),
  KEY `Security_ID` (`Security_ID`),
  KEY `Worker_ID` (`Worker_ID`),
  CONSTRAINT `handles_ibfk_1` FOREIGN KEY (`RWA_Phone_no`) REFERENCES `rwa` (`Phone_number`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `handles_ibfk_2` FOREIGN KEY (`Complaint_ID`) REFERENCES `complaints` (`Complaint_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `handles_ibfk_3` FOREIGN KEY (`Security_ID`) REFERENCES `security` (`Security_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `handles_ibfk_4` FOREIGN KEY (`Worker_ID`) REFERENCES `maintainence_workers` (`Worker_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `handles`
--

LOCK TABLES `handles` WRITE;
/*!40000 ALTER TABLE `handles` DISABLE KEYS */;
INSERT INTO `handles` VALUES (921112432,1267,20210106,112302),(923232432,1269,20210106,112300),(921112432,1500,20210146,112302),(923232432,1779,20210146,112300),(765481175,1504,20219186,102334);
/*!40000 ALTER TABLE `handles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `maintainence_workers`
--

DROP TABLE IF EXISTS `maintainence_workers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `maintainence_workers` (
  `Worker_ID` int NOT NULL,
  `Phone_Number` int DEFAULT NULL,
  `First_Name` varchar(50) DEFAULT NULL,
  `Last_Name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`Worker_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `maintainence_workers`
--

LOCK TABLES `maintainence_workers` WRITE;
/*!40000 ALTER TABLE `maintainence_workers` DISABLE KEYS */;
INSERT INTO `maintainence_workers` VALUES (92334,347722889,'Suneeta','Subzi'),(102334,999722889,'Chunky','Shera'),(112300,999724559,'Sudeep','Ghosh'),(112302,911724559,'Ram','Lakhan'),(132302,999388382,'Abdul','Nadeem');
/*!40000 ALTER TABLE `maintainence_workers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `requests`
--

DROP TABLE IF EXISTS `requests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `requests` (
  `Request_ID` int NOT NULL,
  `Flat_number` varchar(5) NOT NULL,
  `Request_type` varchar(100) DEFAULT NULL,
  `Request_date` date DEFAULT NULL,
  `Resolve_Status` int DEFAULT NULL,
  PRIMARY KEY (`Request_ID`),
  KEY `Flat_number` (`Flat_number`),
  CONSTRAINT `requests_ibfk_1` FOREIGN KEY (`Flat_number`) REFERENCES `flats` (`Flat_number`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `requests`
--

LOCK TABLES `requests` WRITE;
/*!40000 ALTER TABLE `requests` DISABLE KEYS */;
INSERT INTO `requests` VALUES (1010,'B-203','Room Cleaning','2022-11-02',0),(1056,'C-101','Ladder Demand','2022-11-07',1),(1070,'C-101','White Wash','2022-11-05',0),(1090,'A-101','LIFT System','2022-11-09',0),(1096,'D-001','Wheelchair','2022-11-11',1);
/*!40000 ALTER TABLE `requests` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `resident_email_id`
--

DROP TABLE IF EXISTS `resident_email_id`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `resident_email_id` (
  `Aadhar_number` int NOT NULL,
  `User` varchar(50) DEFAULT NULL,
  `Connecting_Symbol` varchar(1) DEFAULT NULL,
  `Mail_Server` varchar(30) DEFAULT NULL,
  `Domain` varchar(10) DEFAULT NULL,
  KEY `Aadhar_number` (`Aadhar_number`),
  CONSTRAINT `resident_email_id_ibfk_1` FOREIGN KEY (`Aadhar_number`) REFERENCES `residents` (`Aadhar_number`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `resident_email_id`
--

LOCK TABLES `resident_email_id` WRITE;
/*!40000 ALTER TABLE `resident_email_id` DISABLE KEYS */;
INSERT INTO `resident_email_id` VALUES (123478678,'Popatlal.Pandey','@','gokul.soc','.in'),(123555101,'Tipendra.Gada','@','gokul.soc','.in'),(122225678,'Sonalika.Bhide','@','gokul.soc','.in'),(111665678,'Goli.Beta','@','gokul.soc','.in'),(123899101,'Babita.Ji','@','gokul.soc','.in'),(123666698,'Hathi.Hansraj','@','gokul.soc','.in'),(123665678,'Komal.Hansraj','@','gokul.soc','.in'),(123478978,'Iyer.Subramaniam','@','gokul.soc','.in'),(123929347,'Atmaram.Bhide','@','gokul.soc','.in'),(123666647,'Madhavi.Bhide','@','gokul.soc','.in'),(123221347,'Roshan.Sodhi','@','gokul.soc','.in'),(1234789101,'Jethalal.Gada','@','gokul.soc','.in'),(123678101,'Daya.Gada','@','gokul.soc','.in'),(123333678,'KabAyengi.Pandey','@','gokul.soc','.in'),(123221679,'Roshan.Sodhi','@','gokul.soc','.in');
/*!40000 ALTER TABLE `resident_email_id` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `residents`
--

DROP TABLE IF EXISTS `residents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `residents` (
  `Phone_number` int NOT NULL,
  `Aadhar_number` int NOT NULL,
  `First_Name` varchar(50) DEFAULT NULL,
  `Last_Name` varchar(50) DEFAULT NULL,
  `DOB` date DEFAULT NULL,
  `Gender` varchar(10) DEFAULT NULL,
  `Flat_Number` varchar(5) DEFAULT NULL,
  `Manager_Aadhar_No` int DEFAULT NULL,
  PRIMARY KEY (`Phone_number`,`Aadhar_number`),
  UNIQUE KEY `Phone_number` (`Phone_number`),
  UNIQUE KEY `Aadhar_number` (`Aadhar_number`),
  KEY `Manager_Aadhar_No` (`Manager_Aadhar_No`),
  KEY `DOB` (`DOB`),
  CONSTRAINT `residents_ibfk_1` FOREIGN KEY (`Manager_Aadhar_No`) REFERENCES `residents` (`Aadhar_number`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `residents_ibfk_2` FOREIGN KEY (`DOB`) REFERENCES `age_from_dob` (`DOB`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `residents`
--

LOCK TABLES `residents` WRITE;
/*!40000 ALTER TABLE `residents` DISABLE KEYS */;
INSERT INTO `residents` VALUES (765481175,123478678,'Popatlal','Pandey','1975-08-21','Male','B-303',123478678),(782123649,123555101,'Tipendra','Gada','2003-06-14','Male','A-101',1234789101),(921112432,122225678,'Sonalika','Bhide','2003-06-09','Female','C-101',123929347),(923232432,111665678,'Goli','Beta','2000-06-14','Male','D-001',123666698),(937021172,123899101,'Babita','Ji','1978-08-23','Female','B-203',123478978),(944417882,123666698,'Hathi','Hansraj','1971-08-23','Male','D-001',123666698),(944432432,123665678,'Komal','Hansraj','1973-04-01','Female','D-001',123666698),(956781172,123478978,'Iyer','Subramaniam','1975-08-23','Male','B-203',123478978),(972417652,123929347,'Atmaram','Bhide','1971-08-23','Male','C-101',123929347),(972417882,123666647,'Madhavi','Bhide','1975-08-23','Female','C-101',123929347),(972481652,123221347,'Roshan','Sodhi','1975-08-21','Male','C-103',123221679),(982123646,1234789101,'Jethalal','Gada','1971-08-23','Male','A-101',1234789101),(982123649,123678101,'Daya','Gada','1971-08-23','Female','A-101',1234789101),(999481172,123333678,'KabAyengi','Pandey','1978-08-23','Female','B-303',123478678),(999481652,123221679,'Roshan','Sodhi','1975-08-21','Female','C-103',123221679);
/*!40000 ALTER TABLE `residents` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rwa`
--

DROP TABLE IF EXISTS `rwa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rwa` (
  `Phone_number` int NOT NULL,
  `First_Name` varchar(50) DEFAULT NULL,
  `Last_Name` varchar(50) DEFAULT NULL,
  `DOB` date DEFAULT NULL,
  `GENDER` varchar(10) DEFAULT NULL,
  `Responsibility` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`Phone_number`),
  KEY `DOB` (`DOB`),
  CONSTRAINT `rwa_ibfk_1` FOREIGN KEY (`DOB`) REFERENCES `age_from_dob` (`DOB`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `rwa_ibfk_2` FOREIGN KEY (`Phone_number`) REFERENCES `residents` (`Phone_number`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rwa`
--

LOCK TABLES `rwa` WRITE;
/*!40000 ALTER TABLE `rwa` DISABLE KEYS */;
INSERT INTO `rwa` VALUES (765481175,'Popatlal','Pandey','1975-08-21','Male','Maintenence'),(782123649,'Tipendra','Gada','2003-06-14','Male','Maintenence'),(921112432,'Sonalika','Bhide','2003-06-09','Female','Complaints'),(923232432,'Goli','Beta','2000-06-14','Male','Supply'),(937021172,'Babita','Ji','1978-08-23','Female','Requests');
/*!40000 ALTER TABLE `rwa` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `security`
--

DROP TABLE IF EXISTS `security`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `security` (
  `Phone_number` int NOT NULL,
  `Security_ID` int NOT NULL,
  `Building_id` varchar(1) DEFAULT NULL,
  `Age` int DEFAULT NULL,
  `First_Name` varchar(50) DEFAULT NULL,
  `Last_Name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`Security_ID`),
  UNIQUE KEY `Building_id` (`Building_id`),
  CONSTRAINT `security_ibfk_1` FOREIGN KEY (`Building_id`) REFERENCES `building` (`Building_identifiers`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `security`
--

LOCK TABLES `security` WRITE;
/*!40000 ALTER TABLE `security` DISABLE KEYS */;
INSERT INTO `security` VALUES (983344556,20210106,'A',34,'MAGAN','RAJ'),(971344556,20210146,'B',38,'CHUNNI','LAL'),(971344556,20219146,'C',38,'CHAALU','PANDEY'),(971344556,20219186,'D',31,'DESI','KUMAR');
/*!40000 ALTER TABLE `security` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `visitor`
--

DROP TABLE IF EXISTS `visitor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `visitor` (
  `Phone_number` int NOT NULL,
  `Flat_number` varchar(5) NOT NULL,
  `Entry_time` time DEFAULT NULL,
  `Exit_time` time DEFAULT NULL,
  `First_Name` varchar(50) DEFAULT NULL,
  `Last_Name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`Phone_number`),
  KEY `Flat_number` (`Flat_number`),
  CONSTRAINT `visitor_ibfk_1` FOREIGN KEY (`Flat_number`) REFERENCES `flats` (`Flat_number`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `visitor`
--

LOCK TABLES `visitor` WRITE;
/*!40000 ALTER TABLE `visitor` DISABLE KEYS */;
INSERT INTO `visitor` VALUES (723883333,'A-101','10:03:45','11:41:39','BAGHA','BHAI'),(734445555,'B-203','13:03:45','13:05:39','SURESH','ZOMATO'),(776573333,'C-103','06:03:45','06:05:39','DOODH','WAALA'),(899541234,'A-101','16:03:45','17:45:12','NATTU','KAKA'),(946573333,'C-101','07:03:45','07:10:39','ABDUL','BHAI'),(999883333,'B-303','00:03:45','01:41:39','ACP','PRADYUMAN');
/*!40000 ALTER TABLE `visitor` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-11-16  1:12:40
