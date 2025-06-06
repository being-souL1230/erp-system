-- MySQL dump 10.13  Distrib 8.0.41, for Win64 (x86_64)
--
-- Host: localhost    Database: student_management
-- ------------------------------------------------------
-- Server version	8.0.41

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
-- Table structure for table `assignments`
--

DROP TABLE IF EXISTS `assignments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `assignments` (
  `id` int NOT NULL AUTO_INCREMENT,
  `student_id` int DEFAULT NULL,
  `subject` varchar(255) DEFAULT NULL,
  `assignment_details` text,
  PRIMARY KEY (`id`),
  KEY `student_id` (`student_id`),
  CONSTRAINT `assignments_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `students` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assignments`
--

LOCK TABLES `assignments` WRITE;
/*!40000 ALTER TABLE `assignments` DISABLE KEYS */;
INSERT INTO `assignments` VALUES (1,1,'Math','submitted'),(2,2,'Science','not submitted'),(3,3,'English','submitted'),(4,4,'History','not submitted'),(5,5,'Geography','submitted'),(6,6,'Math','not submitted'),(7,7,'Science','submitted'),(8,8,'English','not submitted'),(9,9,'History','submitted'),(10,10,'Geography','not submitted'),(11,11,'Math','submitted'),(12,12,'Science','not submitted'),(13,13,'English','submitted'),(14,14,'History','not submitted'),(15,15,'Geography','submitted'),(16,16,'Math','not submitted'),(17,17,'Science','submitted'),(18,18,'English','not submitted'),(19,19,'History','submitted'),(20,20,'Geography','not submitted'),(21,21,'Math','submitted'),(22,22,'Science','not submitted'),(23,23,'English','submitted'),(24,24,'History','not submitted'),(25,25,'Geography','submitted');
/*!40000 ALTER TABLE `assignments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `environmental_science`
--

DROP TABLE IF EXISTS `environmental_science`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `environmental_science` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `CT1_Marks` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `environmental_science`
--

LOCK TABLES `environmental_science` WRITE;
/*!40000 ALTER TABLE `environmental_science` DISABLE KEYS */;
INSERT INTO `environmental_science` VALUES (1,'Abdul Ghani',17),(9,'Durgesh',16),(19,'Kavya Pandey',15),(23,'Shagaf',8),(26,'Mohd Ali Zaidi',14),(33,'Prakhar Rathod',13),(35,'Pranshu Pandey',18),(36,'Pratishtha',14),(37,'Priya',20),(39,'Priyanshu Savita',14),(40,'Rishab',22),(43,'Sarabjeet Singh',16),(44,'Tazeem Mehdi',21),(48,'Shivansh',15),(51,'Tuba',22),(53,'Utkarsh Pal',16),(54,'Varsha Verma',13),(55,'Vasu Sonkar',4),(56,'Vishal Tiwari',13);
/*!40000 ALTER TABLE `environmental_science` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `faculty`
--

DROP TABLE IF EXISTS `faculty`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `faculty` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  `department` varchar(50) DEFAULT NULL,
  `contact` varchar(15) DEFAULT NULL,
  `qualification` varchar(50) DEFAULT NULL,
  `experience` int DEFAULT NULL,
  `profile_image` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `faculty`
--

LOCK TABLES `faculty` WRITE;
/*!40000 ALTER TABLE `faculty` DISABLE KEYS */;
INSERT INTO `faculty` VALUES (1,'Dr. Sharma','sharma@college.com','password123','Computer Science','9876543210','PhD',10,NULL),(2,'Prof. Verma','verma@college.com','pass456','Mathematics','9876501234','MSc',7,NULL),(3,'Dr. Mehta','mehta@college.com','secure789','Physics','9765432100','MTech',5,NULL),(4,'Dr. Kapoor','kapoor@college.com','kapoor@123','Biology','9456712345','PhD',12,NULL),(5,'Prof. Nair','nair@college.com','nair2025','Chemistry','9998765432','MSc',8,NULL),(6,'Dr. Reddy','reddy@college.com','reddy@pass','Electrical','9087654321','BTech',6,NULL),(7,'Prof. Das','das@college.com','daspass','Mechanical','9876543201','MTech',9,NULL),(8,'Dr. Gupta','gupta@college.com','gupta@321','Economics','9123456789','PhD',15,NULL),(9,'Prof. Saxena','saxena@college.com','saxena007','History','9451234567','MA',10,NULL),(10,'Dr. Malhotra','malhotra@college.com','mal@pass','English','9812345670','PhD',11,NULL);
/*!40000 ALTER TABLE `faculty` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `faculty_csv_data`
--

DROP TABLE IF EXISTS `faculty_csv_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `faculty_csv_data` (
  `id` int NOT NULL AUTO_INCREMENT,
  `faculty_id` int NOT NULL,
  `file_name` varchar(255) NOT NULL,
  `upload_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `content` longtext NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `faculty_csv_data`
--

LOCK TABLES `faculty_csv_data` WRITE;
/*!40000 ALTER TABLE `faculty_csv_data` DISABLE KEYS */;
/*!40000 ALTER TABLE `faculty_csv_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `period_schedule`
--

DROP TABLE IF EXISTS `period_schedule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `period_schedule` (
  `id` int NOT NULL AUTO_INCREMENT,
  `faculty_name` varchar(100) DEFAULT NULL,
  `day_of_week` varchar(20) DEFAULT NULL,
  `period_time` varchar(20) DEFAULT NULL,
  `subject` varchar(100) DEFAULT NULL,
  `class` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `period_schedule`
--

LOCK TABLES `period_schedule` WRITE;
/*!40000 ALTER TABLE `period_schedule` DISABLE KEYS */;
/*!40000 ALTER TABLE `period_schedule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `students`
--

DROP TABLE IF EXISTS `students`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `students` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `age` int DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `phone` varchar(15) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `attendance` float DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `students`
--

LOCK TABLES `students` WRITE;
/*!40000 ALTER TABLE `students` DISABLE KEYS */;
INSERT INTO `students` VALUES (1,'Rishab',18,'rishab@example.com','123-456-7890','pass123',85.5),(2,'Jane Smith',22,'jane.smith@example.com','234-567-8901','hashed_password2',90),(3,'Emily Johnson',19,'emily.johnson@example.com','345-678-9012','hashed_password3',49.5),(4,'Michael Brown',21,'michael.brown@example.com','456-789-0123','hashed_password4',95),(5,'Sarah Williams',23,'sarah.williams@example.com','567-890-1234','hashed_password5',92.5),(6,'Alice Johnson',21,'alice.johnson@gmail.com','555-1234','password123',45),(7,'Bob Smith',22,'bob.smith@yahoo.com','555-2345','securePass456',65),(8,'Charlie Davis',23,'charlie.davis@hotmail.com','555-3456','charlie789',90),(9,'David Lee',20,'david.lee@outlook.com','555-4567','davidPass2025',80),(10,'Emily White',19,'emily.white@gmail.com','555-5678','emily321',50),(11,'Frank Green',21,'frank.green@yahoo.com','555-6789','frankPass000',17),(12,'Grace Black',22,'grace.black@hotmail.com','555-7890','grace1234',10),(13,'Henry Wright',23,'henry.wright@outlook.com','555-8901','henry987',85),(14,'Ivy Brown',20,'ivy.brown@gmail.com','555-9012','ivysecret42',95),(15,'Jack Taylor',21,'jack.taylor@yahoo.com','555-0123','jack2021',37),(16,'Katie Moore',22,'katie.moore@hotmail.com','555-1235','katie1234',90),(17,'Liam Harris',19,'liam.harris@outlook.com','555-2346','liamsecure',55),(18,'Mia Martinez',24,'mia.martinez@gmail.com','555-3457','miaPass002',80),(19,'Nathan Scott',20,'nathan.scott@yahoo.com','555-4568','nathan444',22),(20,'Olivia Clark',21,'olivia.clark@hotmail.com','555-5679','olivia2025',85),(21,'Paul Harris',23,'paul.harris@outlook.com','555-6781','paulthepass1',60),(22,'Quincy King',22,'quincy.king@gmail.com','555-7892','quincy999',88),(23,'Rachel Hall',20,'rachel.hall@yahoo.com','555-8903','rachel!pass',50),(24,'Samuel Allen',21,'samuel.allen@hotmail.com','555-9014','samuel007',93),(25,'Tina Robinson',19,'tina.robinson@outlook.com','555-0125','tinaSecret1',19);
/*!40000 ALTER TABLE `students` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-03-20  9:03:35
