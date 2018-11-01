-- MySQL dump 10.16  Distrib 10.1.26-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: sqlexcdb
-- ------------------------------------------------------
-- Server version	10.1.26-MariaDB-0+deb9u1

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
-- Table structure for table `arelease`
--

DROP TABLE IF EXISTS `arelease`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `arelease` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `rdate_date` datetime DEFAULT NULL,
  `rdate_timezone_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `rdate_timezone_id` (`rdate_timezone_id`),
  CONSTRAINT `arelease_ibfk_1` FOREIGN KEY (`rdate_timezone_id`) REFERENCES `timezone` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `arelease`
--

LOCK TABLES `arelease` WRITE;
/*!40000 ALTER TABLE `arelease` DISABLE KEYS */;
INSERT INTO `arelease` VALUES (1,'Zwei Ei Käptn','','2018-11-01 16:30:06',7),(2,'Zum blauen Schwimmer','','2018-11-01 16:30:06',7);
/*!40000 ALTER TABLE `arelease` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `artist`
--

DROP TABLE IF EXISTS `artist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `artist` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identification` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `artist`
--

LOCK TABLES `artist` WRITE;
/*!40000 ALTER TABLE `artist` DISABLE KEYS */;
INSERT INTO `artist` VALUES (1,'Laars Jucken',''),(2,'Dick Hurts','');
/*!40000 ALTER TABLE `artist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `asset`
--

DROP TABLE IF EXISTS `asset`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `asset` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(128) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `path` varchar(255) DEFAULT NULL,
  `mimetype_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `mimetype_id` (`mimetype_id`),
  CONSTRAINT `asset_ibfk_1` FOREIGN KEY (`mimetype_id`) REFERENCES `mimetype` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `asset`
--

LOCK TABLES `asset` WRITE;
/*!40000 ALTER TABLE `asset` DISABLE KEYS */;
INSERT INTO `asset` VALUES (1,'Visage of an Artist','description','https://cdn.theatlantic.com/assets/media/img/photo/2018/10/halloween-tk/h02_RTX6GX9S/main_1200.jpg?1540839254',2),(2,'Visage of a given Artist','description','https://cdn.theatlantic.com/assets/media/img/photo/2018/10/images-of-the-season-fall-is-in-the/f02_RTX6EJJJ/main_1200.jpg?1539887088',2),(3,'1st cover imago','','https://cdn.theatlantic.com/assets/media/img/photo/2018/10/halloween-tk/h04_1054357306/main_1200.jpg?1540837377',2),(4,'2nd cover image','','https://cdn.theatlantic.com/assets/media/img/photo/2018/10/halloween-tk/h08_1052479722/main_1200.jpg?1540839254',2),(5,'Habe die Ehre, hebe die Haare','','https://cdn.theatlantic.com/assets/media/img/photo/2018/10/halloween-tk/h20_1054577334/main_1200.jpg?1540837378',2),(6,'Sambalagula','','https://cdn.theatlantic.com/assets/media/img/photo/2018/10/a-photo-appreciation-of-libraries/l06_RTS21D7W/main_1200.jpg?1540411310',2),(7,'Rhunghala Khatabhula Davila','','https://cdn.theatlantic.com/assets/media/img/photo/2018/10/a-photo-appreciation-of-libraries/l16_641582188/main_1200.jpg?1540411310',2),(8,'Visage of Dick','description','https://cdn.theatlantic.com/assets/media/img/photo/2018/10/photos-aftermath-hurricane-michael/m03_1051836988/main_1200.jpg?1539268123',2);
/*!40000 ALTER TABLE `asset` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `asset_to_artist`
--

DROP TABLE IF EXISTS `asset_to_artist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `asset_to_artist` (
  `asset_id` int(11) DEFAULT NULL,
  `artist_id` int(11) DEFAULT NULL,
  `meta` varchar(255) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  UNIQUE KEY `asset_id` (`asset_id`,`artist_id`),
  KEY `artist_id` (`artist_id`),
  CONSTRAINT `asset_to_artist_ibfk_1` FOREIGN KEY (`asset_id`) REFERENCES `asset` (`id`),
  CONSTRAINT `asset_to_artist_ibfk_2` FOREIGN KEY (`artist_id`) REFERENCES `artist` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `asset_to_artist`
--

LOCK TABLES `asset_to_artist` WRITE;
/*!40000 ALTER TABLE `asset_to_artist` DISABLE KEYS */;
INSERT INTO `asset_to_artist` VALUES (1,1,'meta','title','description'),(2,1,'meta','title','description'),(8,2,'meta','title','description');
/*!40000 ALTER TABLE `asset_to_artist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `asset_to_release`
--

DROP TABLE IF EXISTS `asset_to_release`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `asset_to_release` (
  `asset_id` int(11) DEFAULT NULL,
  `release_id` int(11) DEFAULT NULL,
  `meta` varchar(255) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  UNIQUE KEY `asset_id` (`asset_id`,`release_id`),
  KEY `release_id` (`release_id`),
  CONSTRAINT `asset_to_release_ibfk_1` FOREIGN KEY (`asset_id`) REFERENCES `asset` (`id`),
  CONSTRAINT `asset_to_release_ibfk_2` FOREIGN KEY (`release_id`) REFERENCES `arelease` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `asset_to_release`
--

LOCK TABLES `asset_to_release` WRITE;
/*!40000 ALTER TABLE `asset_to_release` DISABLE KEYS */;
INSERT INTO `asset_to_release` VALUES (3,1,'meta','title','description'),(4,1,'meta','title','description'),(5,2,'meta','title','description'),(6,2,'meta','title','description'),(7,2,'meta','title','description');
/*!40000 ALTER TABLE `asset_to_release` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mimetype`
--

DROP TABLE IF EXISTS `mimetype`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mimetype` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(128) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `title` (`title`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mimetype`
--

LOCK TABLES `mimetype` WRITE;
/*!40000 ALTER TABLE `mimetype` DISABLE KEYS */;
INSERT INTO `mimetype` VALUES (1,'image/jpg',''),(2,'image/png','');
/*!40000 ALTER TABLE `mimetype` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `release_to_artist`
--

DROP TABLE IF EXISTS `release_to_artist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `release_to_artist` (
  `release_id` int(11) DEFAULT NULL,
  `artist_id` int(11) DEFAULT NULL,
  UNIQUE KEY `release_id` (`release_id`,`artist_id`),
  KEY `artist_id` (`artist_id`),
  CONSTRAINT `release_to_artist_ibfk_1` FOREIGN KEY (`release_id`) REFERENCES `arelease` (`id`),
  CONSTRAINT `release_to_artist_ibfk_2` FOREIGN KEY (`artist_id`) REFERENCES `artist` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `release_to_artist`
--

LOCK TABLES `release_to_artist` WRITE;
/*!40000 ALTER TABLE `release_to_artist` DISABLE KEYS */;
INSERT INTO `release_to_artist` VALUES (1,1),(2,1);
/*!40000 ALTER TABLE `release_to_artist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `timezone`
--

DROP TABLE IF EXISTS `timezone`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `timezone` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `label` varchar(128) DEFAULT NULL,
  `abbr` varchar(255) DEFAULT NULL,
  `offset` decimal(4,1) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `label` (`label`)
) ENGINE=InnoDB AUTO_INCREMENT=107 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `timezone`
--

LOCK TABLES `timezone` WRITE;
/*!40000 ALTER TABLE `timezone` DISABLE KEYS */;
INSERT INTO `timezone` VALUES (1,'Dateline Standard Time','DST',-12.0,'(UTC-12:00) International Date Line West'),(2,'UTC-11','U',-11.0,'(UTC-11:00) Coordinated Universal Time-11'),(3,'Hawaiian Standard Time','HST',-10.0,'(UTC-10:00) Hawaii'),(4,'Alaskan Standard Time','AKDT',-8.0,'(UTC-09:00) Alaska'),(5,'Pacific Standard Time (Mexico)','PDT',-7.0,'(UTC-08:00) Baja California'),(6,'Pacific Daylight Time','PDT',-7.0,'(UTC-07:00) Pacific Time (US & Canada)'),(7,'Pacific Standard Time','PST',-8.0,'(UTC-08:00) Pacific Time (US & Canada)'),(8,'US Mountain Standard Time','UMST',-7.0,'(UTC-07:00) Arizona'),(9,'Mountain Standard Time (Mexico)','MDT',-6.0,'(UTC-07:00) Chihuahua, La Paz, Mazatlan'),(10,'Mountain Standard Time','MDT',-6.0,'(UTC-07:00) Mountain Time (US & Canada)'),(11,'Central America Standard Time','CAST',-6.0,'(UTC-06:00) Central America'),(12,'Central Standard Time','CDT',-5.0,'(UTC-06:00) Central Time (US & Canada)'),(13,'Central Standard Time (Mexico)','CDT',-5.0,'(UTC-06:00) Guadalajara, Mexico City, Monterrey'),(14,'Canada Central Standard Time','CCST',-6.0,'(UTC-06:00) Saskatchewan'),(15,'SA Pacific Standard Time','SPST',-5.0,'(UTC-05:00) Bogota, Lima, Quito'),(16,'Eastern Standard Time','EDT',-4.0,'(UTC-05:00) Eastern Time (US & Canada)'),(17,'US Eastern Standard Time','UEDT',-4.0,'(UTC-05:00) Indiana (East)'),(18,'Venezuela Standard Time','VST',-4.5,'(UTC-04:30) Caracas'),(19,'Paraguay Standard Time','PYT',-4.0,'(UTC-04:00) Asuncion'),(20,'Atlantic Standard Time','ADT',-3.0,'(UTC-04:00) Atlantic Time (Canada)'),(21,'Central Brazilian Standard Time','CBST',-4.0,'(UTC-04:00) Cuiaba'),(22,'SA Western Standard Time','SWST',-4.0,'(UTC-04:00) Georgetown, La Paz, Manaus, San Juan'),(23,'Pacific SA Standard Time','PSST',-4.0,'(UTC-04:00) Santiago'),(24,'Newfoundland Standard Time','NDT',-2.5,'(UTC-03:30) Newfoundland'),(25,'E. South America Standard Time','ESAST',-3.0,'(UTC-03:00) Brasilia'),(26,'Argentina Standard Time','AST',-3.0,'(UTC-03:00) Buenos Aires'),(27,'SA Eastern Standard Time','SEST',-3.0,'(UTC-03:00) Cayenne, Fortaleza'),(28,'Greenland Standard Time','GDT',-3.0,'(UTC-03:00) Greenland'),(29,'Montevideo Standard Time','MST',-3.0,'(UTC-03:00) Montevideo'),(30,'Bahia Standard Time','BST',-3.0,'(UTC-03:00) Salvador'),(31,'UTC-02','U',-2.0,'(UTC-02:00) Coordinated Universal Time-02'),(32,'Mid-Atlantic Standard Time','MDT',-1.0,'(UTC-02:00) Mid-Atlantic - Old'),(33,'Azores Standard Time','ADT',0.0,'(UTC-01:00) Azores'),(34,'Cape Verde Standard Time','CVST',-1.0,'(UTC-01:00) Cape Verde Is.'),(35,'Morocco Standard Time','MDT',1.0,'(UTC) Casablanca'),(36,'UTC','UTC',0.0,'(UTC) Coordinated Universal Time'),(37,'Greenwich Mean Time','GMT',0.0,'(UTC) Edinburgh, London'),(38,'British Summer Time','BST',1.0,'(UTC+01:00) Edinburgh, London'),(39,'GMT Standard Time','GDT',1.0,'(UTC) Dublin, Lisbon'),(40,'Greenwich Standard Time','GST',0.0,'(UTC) Monrovia, Reykjavik'),(41,'W. Europe Standard Time','WEDT',2.0,'(UTC+01:00) Amsterdam, Berlin, Bern, Rome, Stockholm, Vienna'),(42,'Central Europe Standard Time','CEDT',2.0,'(UTC+01:00) Belgrade, Bratislava, Budapest, Ljubljana, Prague'),(43,'Romance Standard Time','RDT',2.0,'(UTC+01:00) Brussels, Copenhagen, Madrid, Paris'),(44,'Central European Standard Time','CEDT',2.0,'(UTC+01:00) Sarajevo, Skopje, Warsaw, Zagreb'),(45,'W. Central Africa Standard Time','WCAST',1.0,'(UTC+01:00) West Central Africa'),(46,'Namibia Standard Time','NST',1.0,'(UTC+01:00) Windhoek'),(47,'GTB Standard Time','GDT',3.0,'(UTC+02:00) Athens, Bucharest'),(48,'Middle East Standard Time','MEDT',3.0,'(UTC+02:00) Beirut'),(49,'Egypt Standard Time','EST',2.0,'(UTC+02:00) Cairo'),(50,'Syria Standard Time','SDT',3.0,'(UTC+02:00) Damascus'),(51,'E. Europe Standard Time','EEDT',3.0,'(UTC+02:00) E. Europe'),(52,'South Africa Standard Time','SAST',2.0,'(UTC+02:00) Harare, Pretoria'),(53,'FLE Standard Time','FDT',3.0,'(UTC+02:00) Helsinki, Kyiv, Riga, Sofia, Tallinn, Vilnius'),(54,'Turkey Standard Time','TDT',3.0,'(UTC+03:00) Istanbul'),(55,'Israel Standard Time','JDT',3.0,'(UTC+02:00) Jerusalem'),(56,'Libya Standard Time','LST',2.0,'(UTC+02:00) Tripoli'),(57,'Jordan Standard Time','JST',3.0,'(UTC+03:00) Amman'),(58,'Arabic Standard Time','AST',3.0,'(UTC+03:00) Baghdad'),(59,'Kaliningrad Standard Time','KST',3.0,'(UTC+03:00) Kaliningrad, Minsk'),(60,'Arab Standard Time','AST',3.0,'(UTC+03:00) Kuwait, Riyadh'),(61,'E. Africa Standard Time','EAST',3.0,'(UTC+03:00) Nairobi'),(62,'Moscow Standard Time','MSK',3.0,'(UTC+03:00) Moscow, St. Petersburg, Volgograd'),(63,'Samara Time','SAMT',4.0,'(UTC+04:00) Samara, Ulyanovsk, Saratov'),(64,'Iran Standard Time','IDT',4.5,'(UTC+03:30) Tehran'),(65,'Arabian Standard Time','AST',4.0,'(UTC+04:00) Abu Dhabi, Muscat'),(66,'Azerbaijan Standard Time','ADT',5.0,'(UTC+04:00) Baku'),(67,'Mauritius Standard Time','MST',4.0,'(UTC+04:00) Port Louis'),(68,'Georgian Standard Time','GST',4.0,'(UTC+04:00) Tbilisi'),(69,'Caucasus Standard Time','CST',4.0,'(UTC+04:00) Yerevan'),(70,'Afghanistan Standard Time','AST',4.5,'(UTC+04:30) Kabul'),(71,'West Asia Standard Time','WAST',5.0,'(UTC+05:00) Ashgabat, Tashkent'),(72,'Yekaterinburg Time','YEKT',5.0,'(UTC+05:00) Yekaterinburg'),(73,'Pakistan Standard Time','PKT',5.0,'(UTC+05:00) Islamabad, Karachi'),(74,'India Standard Time','IST',5.5,'(UTC+05:30) Chennai, Kolkata, Mumbai, New Delhi'),(75,'Sri Lanka Standard Time','SLST',5.5,'(UTC+05:30) Sri Jayawardenepura'),(76,'Nepal Standard Time','NST',5.8,'(UTC+05:45) Kathmandu'),(77,'Central Asia Standard Time','CAST',6.0,'(UTC+06:00) Astana'),(78,'Bangladesh Standard Time','BST',6.0,'(UTC+06:00) Dhaka'),(79,'Myanmar Standard Time','MST',6.5,'(UTC+06:30) Yangon (Rangoon)'),(80,'SE Asia Standard Time','SAST',7.0,'(UTC+07:00) Bangkok, Hanoi, Jakarta'),(81,'N. Central Asia Standard Time','NCAST',7.0,'(UTC+07:00) Novosibirsk'),(82,'China Standard Time','CST',8.0,'(UTC+08:00) Beijing, Chongqing, Hong Kong, Urumqi'),(83,'North Asia Standard Time','NAST',8.0,'(UTC+08:00) Krasnoyarsk'),(84,'Singapore Standard Time','MPST',8.0,'(UTC+08:00) Kuala Lumpur, Singapore'),(85,'W. Australia Standard Time','WAST',8.0,'(UTC+08:00) Perth'),(86,'Taipei Standard Time','TST',8.0,'(UTC+08:00) Taipei'),(87,'Ulaanbaatar Standard Time','UST',8.0,'(UTC+08:00) Ulaanbaatar'),(88,'North Asia East Standard Time','NAEST',9.0,'(UTC+09:00) Irkutsk'),(89,'Japan Standard Time','JST',9.0,'(UTC+09:00) Osaka, Sapporo, Tokyo'),(90,'Korea Standard Time','KST',9.0,'(UTC+09:00) Seoul'),(91,'Cen. Australia Standard Time','CAST',9.5,'(UTC+09:30) Adelaide'),(92,'AUS Central Standard Time','ACST',9.5,'(UTC+09:30) Darwin'),(93,'E. Australia Standard Time','EAST',10.0,'(UTC+10:00) Brisbane'),(94,'AUS Eastern Standard Time','AEST',10.0,'(UTC+10:00) Canberra, Melbourne, Sydney'),(95,'West Pacific Standard Time','WPST',10.0,'(UTC+10:00) Guam, Port Moresby'),(96,'Tasmania Standard Time','TST',10.0,'(UTC+10:00) Hobart'),(97,'Yakutsk Standard Time','YST',10.0,'(UTC+10:00) Yakutsk'),(98,'Central Pacific Standard Time','CPST',11.0,'(UTC+11:00) Solomon Is., New Caledonia'),(99,'Vladivostok Standard Time','VST',11.0,'(UTC+11:00) Vladivostok'),(100,'New Zealand Standard Time','NZST',12.0,'(UTC+12:00) Auckland, Wellington'),(101,'UTC+12','U',12.0,'(UTC+12:00) Coordinated Universal Time+12'),(102,'Fiji Standard Time','FST',12.0,'(UTC+12:00) Fiji'),(103,'Magadan Standard Time','MST',12.0,'(UTC+12:00) Magadan'),(104,'Kamchatka Standard Time','KDT',13.0,'(UTC+12:00) Petropavlovsk-Kamchatsky - Old'),(105,'Tonga Standard Time','TST',13.0,'(UTC+13:00) Nuku\'alofa'),(106,'Samoa Standard Time','SST',13.0,'(UTC+13:00) Samoa');
/*!40000 ALTER TABLE `timezone` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-11-01 16:30:37
