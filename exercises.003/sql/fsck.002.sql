# ************************************************************
# Sequel Pro SQL dump
# Version 4096
#
# http://www.sequelpro.com/
# http://code.google.com/p/sequel-pro/
#
# Host: localhost (MySQL 5.5.33)
# Datenbank: sql_demo
# Erstellungsdauer: 2013-10-03 13:12:21 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Export von Tabelle department
# ------------------------------------------------------------

DROP TABLE IF EXISTS `department`;

CREATE TABLE `department` (
  `dept_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL DEFAULT '',
  `location` varchar(64) NOT NULL DEFAULT '',
  PRIMARY KEY (`dept_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `department` WRITE;
/*!40000 ALTER TABLE `department` DISABLE KEYS */;

INSERT INTO `department` (`dept_id`, `name`, `location`)
VALUES
	(1,'Buchhaltung','Langenau'),
	(2,'Entwicklung','Dornstadt'),
	(3,'Vertrieb','Ulm'),
	(4,'Marketing','Günzburg');

/*!40000 ALTER TABLE `department` ENABLE KEYS */;
UNLOCK TABLES;


# Export von Tabelle employee
# ------------------------------------------------------------

DROP TABLE IF EXISTS `employee`;

CREATE TABLE `employee` (
  `emp_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `emp_no` char(4) NOT NULL,
  `name` varchar(64) NOT NULL DEFAULT '',
  `job` varchar(64) NOT NULL DEFAULT '',
  `manager_id` int(11) unsigned DEFAULT NULL,
  `hired_date` date NOT NULL,
  `salary` int(11) NOT NULL,
  `commission` int(11) DEFAULT NULL,
  `dept_id` int(11) unsigned NOT NULL,
  PRIMARY KEY (`emp_id`),
  UNIQUE KEY `emp_no` (`emp_no`),
  KEY `dept_id` (`dept_id`),
  KEY `manager_id` (`manager_id`),
  CONSTRAINT `employee_ibfk_1` FOREIGN KEY (`dept_id`) REFERENCES `department` (`dept_id`),
  CONSTRAINT `employee_ibfk_2` FOREIGN KEY (`manager_id`) REFERENCES `employee` (`emp_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `employee` WRITE;
/*!40000 ALTER TABLE `employee` DISABLE KEYS */;

INSERT INTO `employee` (`emp_id`, `emp_no`, `name`, `job`, `manager_id`, `hired_date`, `salary`, `commission`, `dept_id`)
VALUES
	(1,'S001','Schmidt','Entwickler',13,'2000-12-17',800,NULL,2),
	(2,'A001','Albrecht','Verkäufer',6,'2002-02-20',1600,300,3),
	(3,'W001','Werner','Verkäufer',6,'2002-02-22',1250,500,3),
	(4,'J002','Jones','Teamleiter',9,'2002-04-02',2975,NULL,2),
	(5,'M001','Marbach','Verkäufer',6,'2002-09-28',1250,1400,3),
	(6,'B001','Bürger','Teamleiter',9,'2001-05-01',2850,NULL,3),
	(7,'C001','Carl','Teamleiter',9,'2002-06-09',2450,NULL,1),
	(8,'S002','Seeberger','QA',4,'2003-12-09',3000,NULL,2),
	(9,'K001','Karle','Geschäftsführer',NULL,'2002-11-17',5000,NULL,1),
	(10,'T001','Thürmann','Verkäufer',6,'2002-09-08',1500,0,3),
	(11,'A002','Alessi','Entwickler',8,'2004-01-12',1100,NULL,2),
	(12,'J001','Jakulov','Entwickler',6,'2002-12-03',950,NULL,3),
	(13,'F001','Färber','QA',4,'2002-12-03',3000,NULL,2),
	(14,'M002','Müller','Entwickler',7,'2003-01-23',1300,NULL,1);

/*!40000 ALTER TABLE `employee` ENABLE KEYS */;
UNLOCK TABLES;


# Export von Tabelle project
# ------------------------------------------------------------

DROP TABLE IF EXISTS `project`;

CREATE TABLE `project` (
  `proj_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `proj_start` date NOT NULL,
  `proj_end` date DEFAULT NULL,
  PRIMARY KEY (`proj_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `project` WRITE;
/*!40000 ALTER TABLE `project` DISABLE KEYS */;

INSERT INTO `project` (`proj_id`, `proj_start`, `proj_end`)
VALUES
	(1,'2010-01-01','2010-01-02'),
	(2,'2010-01-02','2010-01-06'),
	(3,'2010-01-06','2010-01-10'),
	(4,'2010-01-10','2010-01-15'),
	(5,'2010-01-18','2010-01-20'),
	(6,'2010-01-20','2010-01-23'),
	(7,'2010-01-23','2010-01-24'),
	(8,'2010-01-24','2010-01-27'),
	(9,'2010-01-27','2010-02-02'),
	(10,'2010-02-03','2010-02-07'),
	(11,'2010-02-07','2010-02-08'),
	(12,'2010-02-12','2010-02-14'),
	(13,'2010-02-14','2010-02-15'),
	(14,'2010-02-15','2010-02-22');

/*!40000 ALTER TABLE `project` ENABLE KEYS */;
UNLOCK TABLES;



/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
