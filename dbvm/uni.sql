-- MySQL dump 10.17  Distrib 10.3.22-MariaDB, for Linux (x86_64)
--
-- Host: 127.0.0.1    Database: uni
-- ------------------------------------------------------
-- Server version	10.3.22-MariaDB

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
-- Table structure for table `Enrol`
--

DROP TABLE IF EXISTS `Enrol`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Enrol` (
  `student` int(11) NOT NULL,
  `unit` int(11) NOT NULL,
  `grade` int(11) DEFAULT NULL,
  PRIMARY KEY (`student`,`unit`),
  KEY `unit` (`unit`),
  CONSTRAINT `Enrol_ibfk_1` FOREIGN KEY (`student`) REFERENCES `Student` (`id`),
  CONSTRAINT `Enrol_ibfk_2` FOREIGN KEY (`unit`) REFERENCES `Unit` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Enrol`
--

LOCK TABLES `Enrol` WRITE;
/*!40000 ALTER TABLE `Enrol` DISABLE KEYS */;
INSERT INTO `Enrol` VALUES (1,11,58),(1,12,57),(1,15,56),(2,11,60),(2,12,52),(2,15,64),(3,11,54),(3,12,71),(3,15,68),(4,11,57),(4,12,65),(4,15,74),(5,11,63),(5,12,49),(5,15,63),(6,11,58),(6,12,69),(6,15,58),(7,11,62),(7,12,69),(7,15,48),(8,11,73),(8,12,69),(8,15,57),(9,11,61),(9,12,46),(9,15,74),(10,11,60),(10,12,67),(10,15,55),(11,13,NULL),(11,16,63),(12,13,NULL),(12,16,65),(13,13,NULL),(13,16,62),(14,13,NULL),(14,16,71),(15,13,NULL),(15,16,63);
/*!40000 ALTER TABLE `Enrol` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Lecturer`
--

DROP TABLE IF EXISTS `Lecturer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Lecturer` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `username` varchar(10) NOT NULL,
  `office` varchar(20) DEFAULT NULL,
  `rgroup` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  KEY `rgroup` (`rgroup`),
  CONSTRAINT `Lecturer_ibfk_1` FOREIGN KEY (`rgroup`) REFERENCES `RGroup` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Lecturer`
--

LOCK TABLES `Lecturer` WRITE;
/*!40000 ALTER TABLE `Lecturer` DISABLE KEYS */;
INSERT INTO `Lecturer` VALUES (31,'Sarah','csxss','1.5',82),(32,'Charles','cscw','0.3',81),(33,'Peter','csxpd','0.3',81),(34,'Dominic','csxde',NULL,81),(35,'Janet','csxjm','1.5',82),(36,'David','csxdb','3.22',NULL);
/*!40000 ALTER TABLE `Lecturer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `RGroup`
--

DROP TABLE IF EXISTS `RGroup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `RGroup` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=83 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `RGroup`
--

LOCK TABLES `RGroup` WRITE;
/*!40000 ALTER TABLE `RGroup` DISABLE KEYS */;
INSERT INTO `RGroup` VALUES (81,'Hardware'),(82,'Software');
/*!40000 ALTER TABLE `RGroup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Student`
--

DROP TABLE IF EXISTS `Student`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Student` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `username` varchar(10) NOT NULL,
  `cohort` varchar(10) NOT NULL,
  `grade` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Student`
--

LOCK TABLES `Student` WRITE;
/*!40000 ALTER TABLE `Student` DISABLE KEYS */;
INSERT INTO `Student` VALUES (1,'Sophia','cs15120','MS50',57),(2,'Jackson','cs15800','MS50',60),(3,'Emma','cs15301','MS50',65),(4,'Aiden','cs15846','MS50',68),(5,'Olivia','cs15255','MS50',60),(6,'Lucas','cs15910','MS50',61),(7,'Ava','cs15336','MS50',57),(8,'Liam','cs15656','MS50',64),(9,'Mia','cs15603','MS50',64),(10,'Noah','cs15241','MS50',59),(11,'Isabella','cs15997','G400',NULL),(12,'Ethan','cs15303','G400',NULL),(13,'Riley','cs15892','G400',NULL),(14,'Mason','cs15331','G400',NULL),(15,'Aria','cs15650','G400',NULL),(16,'Caden','cs15002','G410',NULL),(17,'Zoe','cs15240','G410',NULL),(18,'Oliver','cs15290','G410',NULL),(19,'Charlotte','cs15878','G410',NULL),(20,'Elijah','cs15315','G410',NULL);
/*!40000 ALTER TABLE `Student` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Unit`
--

DROP TABLE IF EXISTS `Unit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Unit` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(100) NOT NULL,
  `code` varchar(9) NOT NULL,
  `level` char(1) NOT NULL,
  `cp` int(11) NOT NULL,
  `director` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `title` (`title`),
  UNIQUE KEY `code` (`code`),
  KEY `director` (`director`),
  CONSTRAINT `Unit_ibfk_1` FOREIGN KEY (`director`) REFERENCES `Lecturer` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Unit`
--

LOCK TABLES `Unit` WRITE;
/*!40000 ALTER TABLE `Unit` DISABLE KEYS */;
INSERT INTO `Unit` VALUES (11,'Databases','COMSM0016','M',10,36),(12,'Web Technologies','COMSM0104','M',10,34),(13,'Programming and Algorithms','COMS10001','1',20,32),(14,'Computer Architecture','COMS20022','2',30,31),(15,'Overview of Computer Architecture','COMSM1302','M',20,31),(16,'Security 101','COMS10005','1',10,36);
/*!40000 ALTER TABLE `Unit` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-02-12 22:38:39
