-- MySQL dump 10.13  Distrib 8.1.0, for Win64 (x86_64)
--
-- Host: localhost    Database: pp0alm
-- ------------------------------------------------------
-- Server version	8.1.0

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
-- Table structure for table `admin`
--

DROP TABLE IF EXISTS `admin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admin` (
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `passwrd` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`email`) USING BTREE,
  CONSTRAINT `admin_ibfk_1` FOREIGN KEY (`email`) REFERENCES `person` (`email`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin`
--

LOCK TABLES `admin` WRITE;
/*!40000 ALTER TABLE `admin` DISABLE KEYS */;
INSERT INTO `admin` VALUES ('admin02@libman.com','d4e01a749610b02ce7d27366a4008bfa'),('jasonliu88@libman.com','d4e01a749610b02ce7d27366a4008bfa'),('mlas028@libman.com','d4e01a749610b02ce7d27366a4008bfa');
/*!40000 ALTER TABLE `admin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `book`
--

DROP TABLE IF EXISTS `book`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `book` (
  `isbn` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `category` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `description` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `publish_date` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `author` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `publisher` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `cDate` datetime DEFAULT CURRENT_TIMESTAMP,
  `uDate` datetime DEFAULT NULL,
  `cover` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `credit` int DEFAULT NULL,
  `number` int DEFAULT '0',
  PRIMARY KEY (`isbn`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `book`
--

LOCK TABLES `book` WRITE;
/*!40000 ALTER TABLE `book` DISABLE KEYS */;
INSERT INTO `book` VALUES ('0128203315','Computer Organization and Design RISC-V Edition: The Hardware Software Interface','Science > Computer Science','Computer Organization and Design RISC-V Edition: The Hardware Software Interface, Second Edition, the award-winning textbook from Patterson and Hennessy that is used by more than 40,000 students per year, continues to present the most comprehensive and readable introduction to this core computer science topic. ','2020-12-31','David A. Patterson','Morgan Kaufmann','2023-01-03 23:54:53','2023-01-05 21:41:25','https://m.media-amazon.com/images/W/WEBP_402378-T2/images/I/51tRhoFUQ2L._SX405_BO1,204,203,200_.jpg',10,3),('0131103628','C Programming Langeage','Science > Computer Science','Written by the developers of C, this new version helps readers keep up with the finalized ANSI standard for C while showing how to take advantage of C\'s rich set of operators, economy of expression, improved control flow, and data structures.','1988-03-22','Brian W. Kernighan','Pearson','2023-01-03 16:18:14','2023-01-05 21:41:22','https://m.media-amazon.com/images/I/411ejyE8obL._SX377_BO1,204,203,200_.jpg',10,9),('0133970779','Fundamentals of Database Systems','Science > Computer Science','This book introduces the fundamental concepts necessary for designing, using, and implementing database systems and database applications. Our presentation stresses the fundamentals of database modeling and design, the languages and models provided by the database management systems, and database system implementation techniques.','2015-06-08','Ramez Elmasri','Pearson','2023-01-03 16:06:46','2023-01-04 18:02:18','https://m.media-amazon.com/images/I/51IBmkQUFuL._SX400_BO1,204,203,200_.jpg',15,3),('1234567890','TestBook','Science > Compuiter Science','description','2022-01-01','Wangshibo','Acme','2023-12-30 03:22:41','2023-12-30 03:23:37','http://example.com/bookcover.jpg',5,0),('1721801286','Roman History: A Captivating Guide to Ancient Rome, Including the Roman Republic, the Roman Empire and the Byzantium','History > European History','A Captivating Guide to Ancient Rome, Including the Roman Republic, the Roman Empire and the Byzantium','2018-06-22','Captivating History','CreateSpace Independent Publishing Platform','2023-01-06 15:57:45','2023-01-06 15:59:16','https://m.media-amazon.com/images/I/51f2iRPAUKL._SX398_BO1,204,203,200_.jpg',20,3),('1791929729','Ottoman Empire: A Captivating Guide to the Rise and Fall of the Ottoman Empire, The Fall of Constantinople, and the Life of Suleiman the Magnificent','History > European History','A Captivating Guide to the Rise and Fall of the Ottoman Empire, The Fall of Constantinople, and the Life of Suleiman the Magnificent','2018-12-18','Captivating History','Independently published','2023-01-06 16:03:26',NULL,'https://m.media-amazon.com/images/I/514CSKI-PKL._SX398_BO1,204,203,200_.jpg',15,3);
/*!40000 ALTER TABLE `book` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `book_unity`
--

DROP TABLE IF EXISTS `book_unity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `book_unity` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'book independent id',
  `position` varchar(255) NOT NULL COMMENT 'position of book',
  `handler` varchar(255) NOT NULL COMMENT 'number of admin',
  `isbn` varchar(255) NOT NULL COMMENT 'isbn of book',
  `status` varchar(255) NOT NULL COMMENT 'status of book(0:cantborrow,1:unborrow,2:borrowed,3:reserved)',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='individual book';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `book_unity`
--

LOCK TABLES `book_unity` WRITE;
/*!40000 ALTER TABLE `book_unity` DISABLE KEYS */;
INSERT INTO `book_unity` VALUES (16,'Circulation room','admin02@libman.com','1234567890','Borrowed'),(17,'Circulation room','admin02@libman.com','1234567890','Borrowed'),(18,'Circulation room','admin02@libman.com','1234567890','Borrowed'),(19,'Circulation room','admin02@libman.com','1234567890','Borrowed'),(20,'Circulation room','admin02@libman.com','1234567890','Borrowed'),(21,'Circulation room','admin02@libman.com','1234567890','Borrowed');
/*!40000 ALTER TABLE `book_unity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `borrow`
--

DROP TABLE IF EXISTS `borrow`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `borrow` (
  `isbn` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `id` int NOT NULL DEFAULT '1',
  `cDate` datetime DEFAULT CURRENT_TIMESTAMP,
  `bstatus` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `duration` int DEFAULT '1',
  `rDate` datetime DEFAULT NULL,
  `notification` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `book_unity_id` int DEFAULT NULL,
  PRIMARY KEY (`isbn`,`email`,`id`) USING BTREE,
  KEY `borrow_ibfk_2` (`email`) USING BTREE,
  CONSTRAINT `borrow_ibfk_1` FOREIGN KEY (`isbn`) REFERENCES `book` (`isbn`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `borrow_ibfk_2` FOREIGN KEY (`email`) REFERENCES `user` (`email`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `borrow`
--

LOCK TABLES `borrow` WRITE;
/*!40000 ALTER TABLE `borrow` DISABLE KEYS */;
INSERT INTO `borrow` VALUES ('0128203315','azelaya@yahoo.com',1,'2023-01-05 23:12:22','Returned',1,'2023-01-06 23:12:22','before due',NULL),('0128203315','azelaya@yahoo.com',2,'2023-01-06 00:02:04','Returned',5,'2023-01-11 00:02:04','before due',NULL),('0128203315','azelaya@yahoo.com',3,'2023-01-06 00:03:20','Returned',5,'2023-01-11 00:03:20','before due',NULL),('0128203315','fblorg@outlook.com',1,'2023-01-05 23:07:41','Returned',1,'2023-01-06 23:07:41','before due',NULL),('0128203315','jbs123@gmail.com',1,'2023-01-06 00:09:35','Borrowed',1,'2023-01-07 00:09:35','past due',NULL),('0128203315','spacestarfish@outlook.com',1,'2023-01-06 00:45:22','Returned',5,'2023-01-11 00:45:22','before due',NULL),('0128203315','yoshida124@yahoo.com',1,'2023-01-07 11:02:17','Borrowed',5,'2023-01-12 11:02:17','past due',NULL),('0131103628','fblorg@outlook.com',1,'2023-01-05 23:56:17','Returned',3,'2023-01-08 23:56:17','before due',NULL),('0131103628','jande8654@outlook.com',1,'2023-01-06 00:39:41','Returned',1,'2023-01-07 00:39:41','before due',NULL),('0131103628','jen2687@gmail.com',1,'2023-01-05 23:56:28','Returned',5,'2023-01-10 23:56:28','before due',NULL),('0131103628','jen2687@gmail.com',2,'2023-01-06 00:09:03','Borrowed',5,'2023-01-11 00:09:03','past due',NULL),('0131103628','jen2687@gmail.com',3,'2023-01-06 15:33:17','Borrowed',1,'2023-01-07 15:33:17','past due',NULL),('0131103628','linsmith@gmail.com',1,'2023-01-05 23:57:22','Returned',1,'2023-01-06 23:57:22','unexpired',NULL),('0131103628','linsmith@gmail.com',2,'2023-01-07 11:01:54','Borrowed',5,'2023-01-12 11:01:54','past due',NULL),('0131103628','spacestarfish@outlook.com',1,'2023-01-06 00:43:53','Returned',1,'2023-01-07 00:43:53','before due',NULL),('0131103628','wf2887@outlook.com',1,'2023-01-06 00:49:21','Borrowed',6,'2023-01-12 00:49:21','past due',NULL),('0133970779','azelaya@yahoo.com',1,'2023-01-06 11:26:30','Returned',1,'2023-01-07 11:26:30','before due',NULL),('0133970779','fblorg@outlook.com',1,'2023-01-06 00:49:35','Returned',3,'2023-01-09 00:49:35','almost due',NULL),('0133970779','jamesborg@gmail.com',1,'2023-01-06 00:09:13','Borrowed',3,'2023-01-09 00:09:13','past due',NULL),('0133970779','jbs123@gmail.com',1,'2023-01-05 23:56:38','Returned',1,'2023-01-06 23:56:38','before due',NULL),('0133970779','jwallace2598@outlook.com',1,'2023-01-06 00:40:00','Borrowed',1,'2023-01-07 00:40:00','past due',NULL),('1234567890','wccurate7a7@gmail.com',1,'2023-12-30 16:26:28','Borrowed',2,'2024-01-01 16:26:28',NULL,16),('1234567890','wccurate7a7@gmail.com',2,'2023-12-30 16:27:52','Borrowed',2,'2024-01-01 16:27:52',NULL,17),('1234567890','wccurate7a7@gmail.com',3,'2023-12-30 16:28:34','Returned',2,'2024-01-01 16:28:34',NULL,18),('1234567890','wccurate7a7@gmail.com',4,'2023-12-30 16:28:35','Borrowed',2,'2024-01-01 16:28:35',NULL,19),('1234567890','wccurate7a7@gmail.com',5,'2023-12-30 16:28:35','Returned',2,'2024-01-01 16:28:35',NULL,20),('1234567890','wccurate7a7@gmail.com',6,'2023-12-30 16:28:36','Borrowed',2,'2024-01-01 16:28:36',NULL,21),('1234567890','wccurate7a7@gmail.com',7,'2023-12-30 17:06:58','Borrowed',10,'2024-01-09 17:06:58',NULL,20),('1234567890','wccurate7a7@gmail.com',8,'2023-12-30 17:11:04','Borrowed',10,'2024-01-09 17:11:04',NULL,18);
/*!40000 ALTER TABLE `borrow` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `category` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `cDate` datetime DEFAULT CURRENT_TIMESTAMP,
  `uDate` datetime DEFAULT NULL,
  `pid` int DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES (1,'History','history','2023-01-02 16:12:23',NULL,NULL),(2,'Science','science','2023-01-02 16:12:45',NULL,NULL),(3,'Book Arts','book arts','2023-01-02 16:12:57','2023-01-02 18:35:33',NULL),(4,'European History','european history','2023-01-02 16:19:44',NULL,1),(5,'Asian History','asian history','2023-01-02 16:20:09',NULL,1),(7,'Education','education','2023-01-02 17:47:34',NULL,NULL),(8,'Technology','technology','2023-01-02 17:54:07',NULL,NULL),(9,'Social Science','social science','2023-01-02 18:13:36',NULL,2),(10,'Natural Science','natural science','2023-01-02 18:14:41',NULL,2),(11,'Information Technology','information Technology','2023-01-02 18:42:46',NULL,8),(12,'Computer Science','computer science','2023-01-03 18:11:35',NULL,2),(15,'Biotechnology','biotechnology','2023-01-04 17:28:22',NULL,8);
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `person`
--

DROP TABLE IF EXISTS `person`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `person` (
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `fname` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `minit` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `lname` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `username` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `province` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `city` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `street` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `phone` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `status` tinyint DEFAULT '1',
  PRIMARY KEY (`email`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `person`
--

LOCK TABLES `person` WRITE;
/*!40000 ALTER TABLE `person` DISABLE KEYS */;
INSERT INTO `person` VALUES ('admin02@libman.com','Jennifer','L','Smith','admin02','QC','Quebec','987 Sheild','4269571397',1),('azelaya@yahoo.com','Alicia','J','Zelaya','azelaya','TX','Spring','3221 Castle','4623587412',1),('fblorg@outlook.com','Friend','C','Blorg','blorggg','ON','North York','867 Skywood','4236587412',1),('jamesborg@gmail.com','James','E','Borg','jamborg','TX','Houston','450 Stone','4325874156',1),('jande8654@outlook.com','Jane','C','Doe','jande865','ON','North York','187 Sayview','4358974156',1),('jasonliu88@libman.com','Jason','M','Liu','jsonliu088','ON','Toronto','166 Kings','4563218974',1),('jbs123@gmail.com','John','B','Smith','jbs123','TX','Houston','731 Fondren','4395210124',1),('jen2687@gmail.com','Joyce','A','English','jen26687','TX','Houston','5631 Dallas','4598741256',1),('jwallace2598@outlook.com','Jennifer','S','Wallace','jwallace85','TX','Ballaire','291 Berry','4632157894',1),('kojitadokoro@gmail.com','Koji','M','Tadokoro','kojitada114514','ON','Mississauga','123 Upwood','4563281597',1),('linsmith@gmail.com','Linda','Z','Smith','linsmith028','ON','Toronto','876 Prince','4856321598',1),('mlas028@libman.com','Mike','J','Laski','mlas028','NS','Halifax','195 Centrewood','4125637852',0),('spacestarfish@outlook.com','Evil','S','Starfish','spacestarfish','NS','Halifax','2333 Void','4856321475',1),('wccurate7a7@gmail.com','Wang','V','Shibo','wccurate','QC','NY',NULL,'1111111111',0),('wf2887@outlook.com','Franklin','T','Wong','wf288c','TX','Houston','638 Voss','4381254789',1),('yoshida124@yahoo.com','Hiroshi','V','Yoshida','hyoshida','ON','North York','3001 Dinch','6321478569',1);
/*!40000 ALTER TABLE `person` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reserve`
--

DROP TABLE IF EXISTS `reserve`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reserve` (
  `id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL,
  `duration` int NOT NULL,
  `isbn` varchar(255) DEFAULT NULL,
  `reservetime` date NOT NULL,
  `book_unity_id` int DEFAULT '-1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reserve`
--

LOCK TABLES `reserve` WRITE;
/*!40000 ALTER TABLE `reserve` DISABLE KEYS */;
/*!40000 ALTER TABLE `reserve` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reterns`
--

DROP TABLE IF EXISTS `reterns`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reterns` (
  `isbn` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `id` int NOT NULL,
  `cDate` datetime DEFAULT CURRENT_TIMESTAMP,
  `bstatus` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `duration` int DEFAULT '1',
  `rDate` datetime DEFAULT NULL,
  `aDate` datetime DEFAULT NULL COMMENT 'actual return date',
  PRIMARY KEY (`isbn`,`email`,`id`) USING BTREE,
  KEY `email` (`email`) USING BTREE,
  CONSTRAINT `reterns_ibfk_1` FOREIGN KEY (`isbn`) REFERENCES `book` (`isbn`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `reterns_ibfk_2` FOREIGN KEY (`email`) REFERENCES `user` (`email`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reterns`
--

LOCK TABLES `reterns` WRITE;
/*!40000 ALTER TABLE `reterns` DISABLE KEYS */;
INSERT INTO `reterns` VALUES ('0128203315','azelaya@yahoo.com',1,'2023-01-05 23:12:22','Returned',1,'2023-01-06 23:12:22','2023-01-05 23:35:53'),('0128203315','azelaya@yahoo.com',2,'2023-01-06 00:02:04','Returned',5,'2023-01-11 00:02:04','2023-01-06 00:02:13'),('0128203315','azelaya@yahoo.com',3,'2023-01-06 00:03:20','Returned',5,'2023-01-11 00:03:20','2023-01-06 00:03:24'),('0128203315','fblorg@outlook.com',1,'2023-01-05 23:07:41','Returned',1,'2023-01-06 23:07:41','2023-01-05 23:33:48'),('0128203315','spacestarfish@outlook.com',1,'2023-01-06 00:45:22','Returned',5,'2023-01-11 00:45:22','2023-01-06 00:46:42'),('0131103628','fblorg@outlook.com',1,'2023-01-05 23:56:17','Returned',3,'2023-01-08 23:56:17','2023-01-06 00:00:50'),('0131103628','jande8654@outlook.com',1,'2023-01-06 00:39:41','Returned',1,'2023-01-07 00:39:41','2023-01-06 00:40:06'),('0131103628','jen2687@gmail.com',1,'2023-01-05 23:56:28','Returned',5,'2023-01-10 23:56:28','2023-01-06 00:00:48'),('0131103628','linsmith@gmail.com',1,'2023-01-05 23:57:22','Returned',1,'2023-01-06 23:57:22','2023-01-05 23:57:29'),('0131103628','spacestarfish@outlook.com',1,'2023-01-06 00:43:53','Returned',1,'2023-01-07 00:43:53','2023-01-06 00:44:05'),('0133970779','azelaya@yahoo.com',1,'2023-01-06 11:26:30','Returned',1,'2023-01-07 11:26:30','2023-01-06 11:26:39'),('0133970779','fblorg@outlook.com',1,'2023-01-06 00:49:35','Returned',3,'2023-01-09 00:49:35','2023-01-07 10:59:55'),('0133970779','jbs123@gmail.com',1,'2023-01-05 23:56:38','Returned',1,'2023-01-06 23:56:38','2023-01-06 00:00:47'),('1234567890','wccurate7a7@gmail.com',1,'2023-12-30 16:28:35','Returned',2,'2024-01-01 16:28:35','2023-12-30 16:37:33'),('1234567890','wccurate7a7@gmail.com',2,'2023-12-30 16:28:35','Returned',2,'2024-01-01 16:28:35','2023-12-30 17:06:33'),('1234567890','wccurate7a7@gmail.com',3,'2023-12-30 16:28:34','Returned',2,'2024-01-01 16:28:34','2023-12-30 17:10:45');
/*!40000 ALTER TABLE `reterns` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `gender` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `age` int NOT NULL,
  `uid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `cTime` datetime DEFAULT CURRENT_TIMESTAMP,
  `uTime` datetime DEFAULT NULL,
  `aCredit` int DEFAULT '0',
  PRIMARY KEY (`email`) USING BTREE,
  CONSTRAINT `user_ibfk_1` FOREIGN KEY (`email`) REFERENCES `person` (`email`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES ('azelaya@yahoo.com','Female',27,'20221224597193486','2022-12-24 17:33:04','2023-01-06 00:06:50',500),('fblorg@outlook.com','Other',4,'20221224346174758','2022-12-24 17:38:39','2023-01-06 00:06:48',450),('jamesborg@gmail.com','Male',45,'202212242055571912','2022-12-24 17:36:58','2023-01-06 00:06:48',455),('jande8654@outlook.com','Female',23,'20221224564425856','2022-12-24 17:39:53','2023-01-06 00:06:48',500),('jbs123@gmail.com','Male',33,'202212241946340529','2022-12-24 17:30:11','2023-01-06 00:06:53',350),('jen2687@gmail.com','Female',25,'20221224723207108','2022-12-24 17:36:14','2023-01-06 00:06:49',430),('jwallace2598@outlook.com','Female',36,'20221224679361579','2022-12-24 17:34:57','2023-01-06 00:06:50',485),('kojitadokoro@gmail.com','Male',18,'20221224828600467','2022-12-24 17:43:47','2023-01-06 00:06:47',485),('linsmith@gmail.com','Unknown',37,'202301041937374814','2023-01-04 17:08:08','2023-01-06 00:06:46',450),('spacestarfish@outlook.com','Other',17,'20221225752851968','2022-12-25 16:35:37','2023-01-06 00:06:46',500),('wccurate7a7@gmail.com','Male',20,'200000000000000000','2022-12-24 17:41:54','2023-01-06 00:06:47',999955),('wf2887@outlook.com','Male',25,'202212241314368891','2022-12-24 17:31:42','2023-01-06 00:06:52',440),('yoshida124@yahoo.com','Male',33,'202212241065002931','2022-12-24 17:41:54','2023-01-06 00:06:47',450);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-12-30 20:15:18
