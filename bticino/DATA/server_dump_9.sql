-- MySQL dump 10.13  Distrib 5.5.37, for debian-linux-gnu (armv7l)
--
-- Host: localhost    Database: bticino_db
-- ------------------------------------------------------
-- Server version	5.5.37-0+wheezy1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `db_version`
--

DROP TABLE IF EXISTS `db_version`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `db_version` (
  `db` varchar(10) NOT NULL,
  `version` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `db_version`
--

LOCK TABLES `db_version` WRITE;
/*!40000 ALTER TABLE `db_version` DISABLE KEYS */;
INSERT INTO `db_version` VALUES ('data',5);
/*!40000 ALTER TABLE `db_version` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `device`
--

DROP TABLE IF EXISTS `device`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `device` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `serial` varchar(40) NOT NULL,
  `name` varchar(50) NOT NULL,
  `when` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `device`
--

LOCK TABLES `device` WRITE;
/*!40000 ALTER TABLE `device` DISABLE KEYS */;
INSERT INTO `device` VALUES (1,'702442500','Dimmer','2014-06-27 18:50:31'),(2,'702495401','Switch A','2014-06-27 18:50:33'),(3,'702495402','Switch B','2014-06-27 18:50:34');
/*!40000 ALTER TABLE `device` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `device_scene`
--

DROP TABLE IF EXISTS `device_scene`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `device_scene` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `device` int(11) NOT NULL,
  `scene` int(11) NOT NULL,
  `when` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `start` varchar(20) NOT NULL,
  `end` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `device_scene`
--

LOCK TABLES `device_scene` WRITE;
/*!40000 ALTER TABLE `device_scene` DISABLE KEYS */;
INSERT INTO `device_scene` VALUES (1,1,52,'2014-06-25 16:07:41','*1*7*702442500#9##','*1*0*702442500#9##'),(2,2,52,'2014-06-25 16:18:21','*1*3*702442500#9##','*1*0*702442500#9##');
/*!40000 ALTER TABLE `device_scene` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `floor`
--

DROP TABLE IF EXISTS `floor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `floor` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(40) NOT NULL,
  `when` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `floor`
--

LOCK TABLES `floor` WRITE;
/*!40000 ALTER TABLE `floor` DISABLE KEYS */;
INSERT INTO `floor` VALUES (1,'Planta baja','2014-06-05 15:22:11'),(2,'Segundo Piso','2014-06-05 15:22:11');
/*!40000 ALTER TABLE `floor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `scene`
--

DROP TABLE IF EXISTS `scene`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `scene` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `floor` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `when` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `schedule` int(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `floorKey` (`floor`),
  KEY `scene_schedule` (`schedule`),
  CONSTRAINT `floorKey` FOREIGN KEY (`floor`) REFERENCES `floor` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `scene_schedule` FOREIGN KEY (`schedule`) REFERENCES `schedule` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `scene`
--

LOCK TABLES `scene` WRITE;
/*!40000 ALTER TABLE `scene` DISABLE KEYS */;
INSERT INTO `scene` VALUES (31,2,'Hora de Dormir','2014-06-12 17:10:55',7),(32,1,'Estamos de Vacaciones','2014-06-12 17:11:13',3),(33,1,'En la noche','2014-06-12 17:39:47',9),(34,1,'De día','2014-06-12 23:00:36',3),(35,1,'aoe','2014-06-23 17:44:49',0),(36,1,'Comedor','2014-06-23 17:46:01',0),(37,1,'Comedor','2014-06-23 18:00:13',0),(38,1,'aoe','2014-06-23 18:17:18',0),(39,1,'AOE','2014-06-23 18:24:45',0),(40,1,'aoe','2014-06-23 18:25:02',0),(41,1,'Yoyo','2014-06-24 19:39:53',0),(42,1,'aoeoe','2014-06-24 19:41:04',0),(43,1,'Aaoetna','2014-06-24 19:42:22',0),(44,1,'aoeae','2014-06-24 19:43:54',0),(45,1,'AOE','2014-06-24 19:45:53',0),(46,1,'Hola','2014-06-24 20:33:29',0),(48,1,'EscenaNueva','2014-06-24 20:56:58',0),(49,1,'YoYa','2014-06-25 15:41:45',0),(50,1,'ComedorMonitor','2014-06-25 15:57:15',0),(51,1,'Atntadoe thdaoe','2014-06-25 15:58:50',0),(52,1,'EscConDimmers','2014-06-25 16:07:34',0);
/*!40000 ALTER TABLE `scene` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `schedule`
--

DROP TABLE IF EXISTS `schedule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `schedule` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `description` varchar(80) NOT NULL,
  `start` varchar(20) NOT NULL,
  `end` varchar(20) NOT NULL,
  `mo` int(1) NOT NULL DEFAULT '0',
  `tu` int(1) NOT NULL DEFAULT '0',
  `th` int(1) NOT NULL DEFAULT '0',
  `we` int(1) NOT NULL DEFAULT '0',
  `fr` int(1) NOT NULL DEFAULT '0',
  `sa` int(1) NOT NULL DEFAULT '0',
  `su` int(1) NOT NULL DEFAULT '0',
  `enabled` int(1) NOT NULL DEFAULT '1',
  `when` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `schedule`
--

LOCK TABLES `schedule` WRITE;
/*!40000 ALTER TABLE `schedule` DISABLE KEYS */;
INSERT INTO `schedule` VALUES (0,'Default','00:00 XX','00:00 XX',0,0,0,0,0,0,0,0,'2014-06-12 17:06:13'),(3,'Vacaciones','05:58 PM','00:58 PM',0,0,0,0,0,0,0,1,'2014-06-11 22:58:12'),(7,'Trabajar','07:47 PM','07:47 PM',0,0,0,0,0,0,0,1,'2014-06-12 00:47:47'),(9,'Luces de Noche','07:00 PM','08:00 AM',0,0,0,0,0,0,0,1,'2014-06-12 17:39:33');
/*!40000 ALTER TABLE `schedule` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2014-07-01 22:09:20
