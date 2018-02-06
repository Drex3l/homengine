-- MySQL dump 10.13  Distrib 5.7.20, for Linux (x86_64)
--
-- Host: localhost    Database: HE
-- ------------------------------------------------------
-- Server version	5.7.20-0ubuntu0.17.10.1

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
-- Current Database: `HE`
--

/*!40000 DROP DATABASE IF EXISTS `HE`*/;

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `HE` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `HE`;

--
-- Table structure for table `admin`
--

DROP TABLE IF EXISTS `admin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `admin` (
  `USER_ID` char(9) NOT NULL,
  `ORGANIZATION` varchar(45) DEFAULT NULL,
  `ADDRESS_LINE1` varchar(45) DEFAULT NULL,
  `ADDRESS_LINE2` varchar(45) DEFAULT NULL,
  `SUBURB_ID` int(10) unsigned NOT NULL DEFAULT '0',
  `FAX` char(10) DEFAULT NULL,
  `WEBSITE` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`USER_ID`),
  UNIQUE KEY `FAX` (`FAX`),
  UNIQUE KEY `FAX_2` (`FAX`),
  UNIQUE KEY `WEBSITE` (`WEBSITE`),
  KEY `SUBURB_ID` (`SUBURB_ID`),
  CONSTRAINT `admin_ibfk_1` FOREIGN KEY (`SUBURB_ID`) REFERENCES `Suburb` (`SUBURB_ID`),
  CONSTRAINT `admin_ibfk_2` FOREIGN KEY (`USER_ID`) REFERENCES `User` (`USER_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`s215013395`@`localhost`*/ /*!50003 TRIGGER `HE`.`before_admin_update`
BEFORE UPDATE ON `HE`.`admin`
FOR EACH ROW
BEGIN
 DECLARE FOUND BOOLEAN DEFAULT TRUE;
 DECLARE INCR MEDIUMINT UNSIGNED DEFAULT 1;

 IF NEW.ADDRESS_LINE1 IS NOT NULL && TRIM(NEW.ADDRESS_LINE1) <> ''THEN
 	IF OLD.SUBURB_ID = 0 && NEW.SUBURB_ID = 0 THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Physical Address must have a Suburb!';	END IF;
 END IF;
 IF NEW.SUBURB_ID != 0  THEN
 	IF (NEW.ADDRESS_LINE1 IS NULL && OLD.ADDRESS_LINE1 IS NULL) OR (TRIM(OLD.ADDRESS_LINE1) = '' && TRIM(NEW.ADDRESS_LINE1) = '') THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Physical Address must have a Street name!';	END IF;
 END IF;
  IF NEW.ADDRESS_LINE2 IS NOT NULL && TRIM(NEW.ADDRESS_LINE2) <> ''THEN
  	IF (NEW.ADDRESS_LINE1 IS NULL && OLD.ADDRESS_LINE1 IS NULL) OR (TRIM(OLD.ADDRESS_LINE1) = '' && TRIM(NEW.ADDRESS_LINE1) = '') THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Physical Address must have a Street name!';	END IF;
  	IF OLD.SUBURB_ID = 0 && NEW.SUBURB_ID = 0 THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Physical Address must have a Suburb!';	END IF;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `bedroom`
--

DROP TABLE IF EXISTS `bedroom`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bedroom` (
  `PROPERTY_ID` bigint(20) unsigned NOT NULL,
  `GENDER_REQ` enum('F','M') DEFAULT NULL,
  `FLOOR` smallint(6) DEFAULT NULL,
  `BRENGTH` double(16,2) DEFAULT NULL,
  `LENGTH` double(16,2) DEFAULT NULL,
  `PROP_TYPE_ID` varchar(8) NOT NULL DEFAULT 'Bedroom',
  `BEDROOM_TYPE` varchar(10) NOT NULL,
  PRIMARY KEY (`PROPERTY_ID`),
  UNIQUE KEY `PROPERTY_ID` (`PROPERTY_ID`,`PROP_TYPE_ID`),
  KEY `BEDROOM_TYPE` (`BEDROOM_TYPE`),
  CONSTRAINT `bedroom_ibfk_1` FOREIGN KEY (`PROPERTY_ID`, `PROP_TYPE_ID`) REFERENCES `property` (`PROPERTY_ID`, `PROP_TYPE_ID`),
  CONSTRAINT `bedroom_ibfk_2` FOREIGN KEY (`BEDROOM_TYPE`) REFERENCES `bedroom_type` (`BEDROOM_TYPE`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bedroom_type`
--

DROP TABLE IF EXISTS `bedroom_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bedroom_type` (
  `BEDROOM_TYPE` varchar(10) NOT NULL,
  PRIMARY KEY (`BEDROOM_TYPE`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `building`
--

DROP TABLE IF EXISTS `building`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `building` (
  `PROPERTY_ID` bigint(20) unsigned NOT NULL,
  `STORIES` smallint(5) unsigned DEFAULT NULL,
  `BUILDING_TYPE` varchar(10) NOT NULL,
  `PROP_TYPE_ID` varchar(8) NOT NULL DEFAULT 'Building',
  `BEDROOMS` tinyint(3) unsigned NOT NULL DEFAULT '1',
  `BATHROOMS` tinyint(3) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`PROPERTY_ID`),
  UNIQUE KEY `PROPERTY_ID` (`PROPERTY_ID`,`PROP_TYPE_ID`),
  KEY `BUILDING_TYPE` (`BUILDING_TYPE`),
  CONSTRAINT `building_ibfk_1` FOREIGN KEY (`PROPERTY_ID`, `PROP_TYPE_ID`) REFERENCES `property` (`PROPERTY_ID`, `PROP_TYPE_ID`),
  CONSTRAINT `building_ibfk_2` FOREIGN KEY (`BUILDING_TYPE`) REFERENCES `building_type` (`BUILDING_TYPE`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `building_type`
--

DROP TABLE IF EXISTS `building_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `building_type` (
  `BUILDING_TYPE` varchar(10) NOT NULL,
  PRIMARY KEY (`BUILDING_TYPE`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `client`
--

DROP TABLE IF EXISTS `client`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `client` (
  `USER_ID` char(9) NOT NULL,
  `GENDER` enum('F','M') NOT NULL,
  `OCCUPATION` enum('STUDYING','WORKING','BOTH') DEFAULT NULL,
  PRIMARY KEY (`USER_ID`),
  CONSTRAINT `client_ibfk_1` FOREIGN KEY (`USER_ID`) REFERENCES `User` (`USER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `feature`
--

DROP TABLE IF EXISTS `feature`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `feature` (
  `ITEM_CODE` char(4) CHARACTER SET utf8 NOT NULL,
  `NAME` varchar(20) NOT NULL,
  `DESCRIPTION` text,
  `CATEGORY` enum('ACCESSORY','FURNITURE','CONVENIENCE','SUNDRY') NOT NULL DEFAULT 'SUNDRY',
  PRIMARY KEY (`ITEM_CODE`),
  UNIQUE KEY `NAME` (`NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`s215013395`@`localhost`*/ /*!50003 TRIGGER `HE`.`before_feature_insert`
BEFORE INSERT ON `HE`.`feature`
FOR EACH ROW
BEGIN
  DECLARE FOUND BOOLEAN DEFAULT TRUE;
  DECLARE INCR SMALLINT UNSIGNED DEFAULT 0;
  WHILE FOUND DO
     SET NEW.ITEM_CODE = CONCAT('I',SUBSTRING(NEW.CATEGORY,1,1),(LPAD((INCR),2,'0')));
     SET FOUND = ((SELECT COUNT(ITEM_CODE) FROM feature WHERE ITEM_CODE = NEW.ITEM_CODE) > 0);
     SET INCR = INCR + 1;
  END WHILE;
 END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `property`
--

DROP TABLE IF EXISTS `property`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `property` (
  `PROPERTY_ID` bigint(20) unsigned NOT NULL,
  `ADDRESS_LINE1` varchar(45) NOT NULL,
  `ADDRESS_LINE2` varchar(45) DEFAULT NULL,
  `SUBURB_ID` int(10) unsigned NOT NULL,
  `USER_ID` char(9) CHARACTER SET utf8 NOT NULL,
  `AVAILABLE` tinyint(1) NOT NULL DEFAULT '1',
  `IMG_ID` bigint(20) unsigned DEFAULT NULL,
  `TARGET` enum('Student','Worker','Nursing','Other','Any') NOT NULL DEFAULT 'Any',
  `LISTING` datetime DEFAULT CURRENT_TIMESTAMP,
  `PROP_TYPE_ID` varchar(8) NOT NULL,
  `DESCRIPTION` text,
  PRIMARY KEY (`PROPERTY_ID`),
  UNIQUE KEY `PROPERTY_ID` (`PROPERTY_ID`,`PROP_TYPE_ID`),
  KEY `PROP_TYPE_ID` (`PROP_TYPE_ID`),
  KEY `SUBURB_ID` (`SUBURB_ID`),
  KEY `USER_ID` (`USER_ID`),
  KEY `IMG_ID` (`IMG_ID`),
  CONSTRAINT `property_ibfk_1` FOREIGN KEY (`PROP_TYPE_ID`) REFERENCES `property_type` (`PROP_TYPE_ID`) ON UPDATE CASCADE,
  CONSTRAINT `property_ibfk_2` FOREIGN KEY (`SUBURB_ID`) REFERENCES `suburb` (`SUBURB_ID`) ON UPDATE CASCADE,
  CONSTRAINT `property_ibfk_3` FOREIGN KEY (`USER_ID`) REFERENCES `admin` (`USER_ID`) ON UPDATE CASCADE,
  CONSTRAINT `property_ibfk_4` FOREIGN KEY (`IMG_ID`) REFERENCES `property_img` (`PICTURE_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `property_feature`
--

DROP TABLE IF EXISTS `property_feature`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `property_feature` (
  `PROPERTY_ID` bigint(20) unsigned NOT NULL,
  `FEATURE_ID` char(4) CHARACTER SET utf8 NOT NULL,
  PRIMARY KEY (`PROPERTY_ID`,`FEATURE_ID`),
  KEY `FACILITY` (`FEATURE_ID`),
  CONSTRAINT `property_feature_ibfk_2` FOREIGN KEY (`PROPERTY_ID`) REFERENCES `property` (`PROPERTY_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `property_feature_ibfk_3` FOREIGN KEY (`FEATURE_ID`) REFERENCES `feature` (`ITEM_CODE`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `property_img`
--

DROP TABLE IF EXISTS `property_img`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `property_img` (
  `PICTURE_ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `PROPERTY_ID` bigint(20) unsigned NOT NULL,
  `DESCRIPTION` text,
  `PICTURE` char(17) NOT NULL,
  `TITLE` varchar(20) DEFAULT NULL,
  `PREVIEW` enum('A','B','C') DEFAULT NULL,
  PRIMARY KEY (`PICTURE_ID`),
  UNIQUE KEY `PROPERTY_ID_2` (`PROPERTY_ID`,`PREVIEW`),
  KEY `PROPERTY_ID` (`PROPERTY_ID`),
  CONSTRAINT `property_img_ibfk_1` FOREIGN KEY (`PROPERTY_ID`) REFERENCES `property` (`PROPERTY_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary table structure for view `property_list`
--

DROP TABLE IF EXISTS `property_list`;
/*!50001 DROP VIEW IF EXISTS `property_list`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `property_list` AS SELECT 
 1 AS `ID`,
 1 AS `SETTING`,
 1 AS `TARGET`,
 1 AS `PROPERTY TYPE`,
 1 AS `ADDRESS LINE 1`,
 1 AS `SUBURB`,
 1 AS `LISTING`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `property_room`
--

DROP TABLE IF EXISTS `property_room`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `property_room` (
  `PROPERTY_ID` bigint(20) unsigned NOT NULL,
  `ROOM_ID` char(3) CHARACTER SET utf8 NOT NULL,
  `AVAILABLE` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`PROPERTY_ID`,`ROOM_ID`),
  KEY `ROOM_ID` (`ROOM_ID`),
  KEY `PROPERTY_ID` (`PROPERTY_ID`),
  CONSTRAINT `property_room_ibfk_3` FOREIGN KEY (`PROPERTY_ID`) REFERENCES `property` (`PROPERTY_ID`) ON UPDATE CASCADE,
  CONSTRAINT `property_room_ibfk_4` FOREIGN KEY (`ROOM_ID`) REFERENCES `room` (`ROOM_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `property_type`
--

DROP TABLE IF EXISTS `property_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `property_type` (
  `PROP_TYPE_ID` varchar(8) NOT NULL,
  `DESCRIPTION` varchar(20) NOT NULL,
  PRIMARY KEY (`PROP_TYPE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `rental`
--

DROP TABLE IF EXISTS `rental`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rental` (
  `RENTAL_ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `AMOUNT` double(16,2) NOT NULL,
  `MONTHS` smallint(5) unsigned NOT NULL DEFAULT '1',
  `DEPOSIT` double(16,2) DEFAULT NULL,
  `LEASE` smallint(5) unsigned DEFAULT NULL COMMENT 'Lease length in units of one month',
  `PROPERTY_ID` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`RENTAL_ID`),
  UNIQUE KEY `RENTAL_ID` (`RENTAL_ID`,`MONTHS`),
  KEY `PROPERTY_ID` (`PROPERTY_ID`),
  CONSTRAINT `rental_ibfk_1` FOREIGN KEY (`PROPERTY_ID`) REFERENCES `property` (`PROPERTY_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`s215013395`@`localhost`*/ /*!50003 TRIGGER `HE`.`before_rental_insert`
BEFORE INSERT ON `HE`.`rental`
FOR EACH ROW
BEGIN

	IF NEW.LEASE < NEW.MONTHS THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'rental Period exceeds Lease Contract!';	END IF;
	IF MOD(NEW.LEASE, NEW.MONTHS) != 0 THEN
		SET @remain	= MOD(NEW.LEASE, NEW.MONTHS);
		IF @remain > 1 THEN SET @remain = CONCAT(@remain, ' months');	ELSE	SET @remain = CONCAT(@remain, ' month');	END IF;
		SET @message = CONCAT('A period of ',@remain,'  remains uncatered for on the current contract!');	
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = @message;	
	END IF;

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `review`
--

DROP TABLE IF EXISTS `review`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `review` (
  `REVIEW_ID` char(19) NOT NULL,
  `USER_ID` char(9) NOT NULL,
  `PROPERTY_ID` bigint(20) unsigned NOT NULL,
  `APPOINTMENT` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `DURATION` smallint(5) unsigned DEFAULT '30' COMMENT 'MINUTES',
  PRIMARY KEY (`REVIEW_ID`),
  KEY `USER_ID` (`USER_ID`),
  KEY `PROPERTY_ID` (`PROPERTY_ID`),
  CONSTRAINT `review_ibfk_1` FOREIGN KEY (`USER_ID`) REFERENCES `client` (`USER_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `review_ibfk_2` FOREIGN KEY (`PROPERTY_ID`) REFERENCES `property` (`PROPERTY_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`s215013395`@`localhost`*/ /*!50003 TRIGGER `HE`.`before_review_insert`BEFORE INSERT ON `HE`.`review`
FOR EACH ROW
BEGIN
 
 IF SUBSTRING(NEW.APPOINTMENT,1,4) = '0000' THEN SET NEW.APPOINTMENT = DATE_ADD(NOW(),INTERVAL 1 DAY); 
 ELSE
 
  SET @GAP = TIMESTAMPDIFF(MINUTE,NOW(),NEW.APPOINTMENT);
  IF @GAP < 1 THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Appointments are possible only in the future';	END IF;
 END IF;
 
 SET NEW.REVIEW_ID = CONCAT('R',DATE_FORMAT(NEW.APPOINTMENT,'%y%m%d%H%i'),SUBSTRING(NEW.USER_ID,2,LENGTH(NEW.USER_ID)));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `room`
--

DROP TABLE IF EXISTS `room`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `room` (
  `ROOM_ID` char(3) NOT NULL,
  `ROOM_TYPE` varchar(20) NOT NULL,
  `DESCRIPTION` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`ROOM_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`s215013395`@`localhost`*/ /*!50003 TRIGGER `HE`.`before_room_insert`
BEFORE INSERT ON `HE`.`room`
FOR EACH ROW
BEGIN
  DECLARE FOUND BOOLEAN DEFAULT TRUE;
  DECLARE INCR SMALLINT UNSIGNED DEFAULT 1;
  WHILE FOUND DO
     SET NEW.ROOM_ID = CONCAT('R',(LPAD(((SELECT COUNT(*) FROM room) + INCR),2,'0')));
     SET FOUND = ((SELECT COUNT(ROOM_ID) FROM room WHERE ROOM_ID = NEW.ROOM_ID) > 0);
     SET INCR = INCR + 1;
  END WHILE;
 END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `suburb`
--

DROP TABLE IF EXISTS `suburb`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `suburb` (
  `SUBURB_ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `SUBURB_NAME` varchar(35) NOT NULL,
  `POSTAL_CODE` varchar(5) DEFAULT NULL,
  PRIMARY KEY (`SUBURB_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=229 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `USER_ID` char(9) NOT NULL,
  `USERNAME` varchar(20) NOT NULL,
  `HASH` text NOT NULL,
  `EMAIL` varchar(45) NOT NULL,
  `DISPLAY_IMG` char(15) DEFAULT NULL,
  `PHONE` char(10) DEFAULT NULL,
  `ACTIVE` tinyint(1) NOT NULL DEFAULT '1',
  `FIRST_NAME` varchar(20) DEFAULT NULL,
  `LAST_NAME` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`USER_ID`),
  UNIQUE KEY `USERNAME` (`USERNAME`),
  UNIQUE KEY `EMAIL` (`EMAIL`),
  UNIQUE KEY `PHONE` (`PHONE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`s215013395`@`localhost`*/ /*!50003 TRIGGER `HE`.`before_user_insert`
BEFORE INSERT ON `HE`.`user`
FOR EACH ROW
BEGIN
 DECLARE FOUND BOOLEAN DEFAULT TRUE;
 DECLARE INCR MEDIUMINT UNSIGNED DEFAULT 1;
 
 WHILE FOUND DO
  SET NEW.USER_ID = UPPER(CONCAT('U',(SELECT (CONCAT(SUBSTRING(DATE_FORMAT(CURDATE(),'%Y'),1,1),DATE_FORMAT(CURDATE(),'%y')))),SUBSTRING(NEW.USERNAME,1,1),LPAD(INCR,4,'0'))); 
  SET FOUND = ((SELECT COUNT(USER_ID) FROM user WHERE USER_ID = NEW.USER_ID) > 0); 
  SET INCR = INCR + 1;
 END WHILE;
 
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `yard`
--

DROP TABLE IF EXISTS `yard`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `yard` (
  `PROPERTY_ID` bigint(20) unsigned NOT NULL,
  `SIZE` double(16,2) DEFAULT NULL,
  `SPACE` enum('Enclosed','Open') DEFAULT NULL,
  `PROP_TYPE_ID` varchar(8) NOT NULL DEFAULT 'Yard',
  PRIMARY KEY (`PROPERTY_ID`),
  UNIQUE KEY `PROPERTY_ID` (`PROPERTY_ID`,`PROP_TYPE_ID`),
  CONSTRAINT `yard_ibfk_1` FOREIGN KEY (`PROPERTY_ID`, `PROP_TYPE_ID`) REFERENCES `property` (`PROPERTY_ID`, `PROP_TYPE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping routines for database 'HE'
--
/*!50003 DROP FUNCTION IF EXISTS `sf_arrayLength` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`s215013395`@`localhost` FUNCTION `sf_arrayLength`(seperate CHAR(1), arrayString TEXT) RETURNS smallint(5) unsigned
BEGIN
	DECLARE count SMALLINT UNSIGNED DEFAULT 0;
	SET @string = arrayString;
	SET @delimiter = seperate;
	
	WHILE (LOCATE(@delimiter,@string)>0)  DO 
		SET @string = SUBSTRING(@string,LOCATE(@delimiter,@string)+1);
		SET count = count + 1;
	END WHILE;
 	RETURN count;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `sf_banner` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`s215013395`@`localhost` FUNCTION `sf_banner`(prop_id BIGINT UNSIGNED) RETURNS varchar(35) CHARSET utf8
BEGIN
	DECLARE type VARCHAR(8);
	SELECT PROP_TYPE_ID FROM property WHERE PROPERTY_ID = prop_id INTO type;
	CASE type
		WHEN 'Bedroom' THEN
		BEGIN
			RETURN (select concat(`BEDROOM_TYPE`,' ',`PROP_TYPE_ID`) from `bedroom` WHERE PROPERTY_ID = prop_id);
		END;
		WHEN 'Building' THEN
		BEGIN
			SELECT BEDROOMS FROM building WHERE PROPERTY_ID = prop_id INTO @rooms;
			IF @rooms = 0 THEN RETURN (select concat('Bachelor ',`BUILDING_TYPE`) from `building` WHERE PROPERTY_ID = prop_id); END IF;
			RETURN (select concat(`BEDROOMS`,' Bedroom ',`BUILDING_TYPE`) from `building` WHERE PROPERTY_ID = prop_id);
		END;
		WHEN 'Yard' THEN
		BEGIN
			RETURN (select concat(`SPACE`,' Space Yard') from `yard` WHERE ID = prop_id);
		END;
	END CASE;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `sf_engine_page_count` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`s215013395`@`localhost` FUNCTION `sf_engine_page_count`(block TINYINT UNSIGNED) RETURNS smallint(5) unsigned
BEGIN


 
 DECLARE pages SMALLINT UNSIGNED;
 DECLARE list BIGINT UNSIGNED;
    SELECT COUNT(*) FROM RECORDS INTO list;
    
    SELECT (list / block) INTO pages;
    
    IF list = 0 THEN RETURN 0;	END IF;
    IF pages = 0 THEN RETURN 1;	END IF;
    IF list > block && list % block > 0 THEN	SET pages = pages + 1; END IF;
    RETURN pages;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `SPLIT_STR` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`s215013395`@`localhost` FUNCTION `SPLIT_STR`(x VARCHAR(255), delim CHAR(1),pos INT) RETURNS varchar(255) CHARSET utf8
    DETERMINISTIC
BEGIN
 RETURN REPLACE(SUBSTRING(SUBSTRING_INDEX(x, delim, pos),LENGTH(SUBSTRING_INDEX(x, delim, pos -1))+1),delim, '');
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getPriceProperties` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`s215013395`@`localhost` PROCEDURE `getPriceProperties`(IN minimum DOUBLE(16,2),IN maximum DOUBLE(16,2))
BEGIN
	IF minimum != 0 THEN
		CREATE TEMPORARY TABLE IF NOT EXISTS `templist` SELECT pl.* from `shortlist` pl, rental WHERE PROPERTY_ID = ID && MONTHS = 1 AND AMOUNT >= minimum;
		
		DROP TABLE IF EXISTS `shortlist`;				
		CREATE TEMPORARY TABLE IF NOT EXISTS `shortlist` SELECT * FROM `templist`;	
		DROP TABLE IF EXISTS `templist`;
	END IF;
	
	IF maximum != 0 THEN
		CREATE TEMPORARY TABLE IF NOT EXISTS `templist` SELECT pl.* from `shortlist` pl, rental WHERE PROPERTY_ID = ID && MONTHS = 1 AND AMOUNT <= maximum;
		
		DROP TABLE IF EXISTS `shortlist`;				
		CREATE TEMPORARY TABLE IF NOT EXISTS `shortlist` SELECT * FROM `templist`;	
		DROP TABLE IF EXISTS `templist`;
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getRoomGendList` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`s215013395`@`localhost` PROCEDURE `getRoomGendList`(
IN pType  TEXT,
IN gender VARCHAR(1)
)
BEGIN
	IF pType = 'bedroom' && gender <> '' THEN
		CREATE TEMPORARY TABLE IF NOT EXISTS `templist` SELECT Pl.* from `shortlist` Pl,bedroom B WHERE ID = PROPERTY_ID AND B.GENDER_REQ = gender;
		
		DROP TABLE IF EXISTS `shortlist`;				
		CREATE TEMPORARY TABLE IF NOT EXISTS `shortlist` SELECT * FROM `templist`;	
		DROP TABLE IF EXISTS `templist`;
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_addFeature` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`s215013395`@`localhost` PROCEDURE `sp_addFeature`(IN title VARCHAR(20),IN featureDesc TEXT,IN type enum('ACCESSORY','FURNITURE','CONVENIENCE','SUNDRY'))
BEGIN
	DECLARE roomID BIGINT UNSIGNED;
	DECLARE CHECKPOINT  TINYINT UNSIGNED DEFAULT 0;
	DECLARE EXIT HANDLER FOR SQLEXCEPTION,1265
	BEGIN 
		GET DIAGNOSTICS CONDITION 1 @p1 = RETURNED_SQLSTATE, @p2 = MESSAGE_TEXT;
		ROLLBACK;
        	SELECT CONCAT('C',LPAD(CHECKPOINT,2,'0'))  AS 'POINT',@p1 AS CODE, @p2 AS DESCRIPTION;
	END;
	START TRANSACTION;
	
	SET title = trim(title);
	SET featureDesc = trim(featureDesc);
	
	INSERT INTO feature(NAME,CATEGORY) VALUES(title,type);			SET CHECKPOINT = 1;
	
	IF featureDesc <> '' THEN	UPDATE feature SET DESCRIPTION = featureDesc	WHERE NAME = title;	END IF;
	
 	COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_addImage` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`s215013395`@`localhost` PROCEDURE `sp_addImage`(IN id BIGINT UNSIGNED, IN IMG CHAR(17),IN imgTitle VARCHAR(20),IN imgDesc TEXT)
BEGIN
	DECLARE CHECKPOINT  TINYINT UNSIGNED DEFAULT 0;
	DECLARE dp BIGINT UNSIGNED;
	DECLARE EXIT HANDLER FOR SQLEXCEPTION,1265
	BEGIN 
		GET DIAGNOSTICS CONDITION 1 @p1 = RETURNED_SQLSTATE, @p2 = MESSAGE_TEXT;
		ROLLBACK;
        	SELECT CONCAT('C',LPAD(CHECKPOINT,2,'0'))  AS 'POINT',@p1 AS CODE, @p2 AS DESCRIPTION;
	END;
	START TRANSACTION;
	
	SET IMG = REPLACE(IMG,' ','');
	SET imgTitle = trim(imgTitle);
	SET imgDesc = trim(imgDesc);
	
	IF IMG = '' THEN	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'image name not found';	END IF;										SET CHECKPOINT = 1;
		INSERT INTO property_img(PROPERTY_ID,PICTURE,TITLE,DESCRIPTION) VALUES(id,IMG,imgTitle,imgDesc);
		IF imgTitle = '' THEN	UPDATE property_img SET TITLE = \N  WHERE PICTURE_ID = LAST_INSERT_ID(); END IF; 	SET CHECKPOINT = 2;
		IF imgDesc = '' THEN	UPDATE property_img SET DESCRIPTION = \N WHERE PICTURE_ID = LAST_INSERT_ID();	END IF; 	SET CHECKPOINT = 3;
		
		SELECT IMG_ID FROM property WHERE PROPERTY_ID = id INTO dp;	SET CHECKPOINT = 4;
		IF dp IS \N THEN UPDATE property SET IMG_ID = LAST_INSERT_ID() WHERE PROPERTY_ID = id;	END IF;
	
 	COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_assignRental` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`s215013395`@`localhost` PROCEDURE `sp_assignRental`(IN propID BIGINT UNSIGNED,IN dwnPaymt DOUBLE(16,2),IN rent DOUBLE(16,2),IN period SMALLINT UNSIGNED,IN lease_length SMALLINT UNSIGNED)
BEGIN
	DECLARE CHECKPOINT  TINYINT UNSIGNED DEFAULT 0;
	DECLARE EXIT HANDLER FOR SQLEXCEPTION,1265
	BEGIN 
		GET DIAGNOSTICS CONDITION 1 @p1 = RETURNED_SQLSTATE, @p2 = MESSAGE_TEXT;
		ROLLBACK;
        	SELECT CONCAT('C',LPAD(CHECKPOINT,2,'0'))  AS 'POINT',@p1 AS CODE, @p2 AS DESCRIPTION;
	END;
	START TRANSACTION;
	
	IF rent IS NULL THEN 	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'please give rental';	END IF;										SET CHECKPOINT = 1;
	IF period IS NULL THEN SET period = 1; END IF;																					SET CHECKPOINT = 2;
	INSERT INTO rental VALUES(\N,rent,period,dwnPaymt,lease_length,propID);	
 	COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_getFeatureProperties` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`s215013395`@`localhost` PROCEDURE `sp_getFeatureProperties`(IN seperate CHAR(1),IN items TEXT)
BEGIN  
	SET @itemList = items; 
	SET @delimiter = seperate;
	
	SET @q ='CREATE TEMPORARY TABLE IF NOT EXISTS templist SELECT  PL.*, COUNT(*) FEATURES FROM property_feature PF,  shortlist PL WHERE PL.ID = PF.PROPERTY_ID AND (';
	SET @length = sf_arrayLength(@delimiter,@itemList);
	IF @length > 0 THEN
		SET @selectedItems = '';
		SET @count = 0;
	
		WHILE(@count < @length)	DO
			SET @count = @count + 1;
			IF(@count < (@length))	THEN SET @selectedItems = CONCAT(@selectedItems, 'PF.FEATURE_ID = "', SPLIT_STR(@itemList,@delimiter,@count),'"',' || ');
			ELSE SET @selectedItems = CONCAT(@selectedItems, 'PF.FEATURE_ID = "', SPLIT_STR(@itemList,@delimiter,@count),'"');	END IF;
		END WHILE;
		SET @q = CONCAT(@q, @selectedItems,' ) GROUP BY ID,SETTING,PL.`PROPERTY TYPE`,PL.TARGET,PL.`ADDRESS LINE 1`,PL.SUBURB,PL.LISTING HAVING FEATURES = ',@length);
		PREPARE stmt FROM @q; 
	 	EXECUTE stmt; 
		DEALLOCATE PREPARE stmt;
		
		DROP TABLE IF EXISTS `shortlist`;				
		CREATE TEMPORARY TABLE IF NOT EXISTS `shortlist` SELECT ID,SETTING,TARGET,`PROPERTY TYPE`,`ADDRESS LINE 1`,SUBURB,LISTING FROM `templist`;						
		DROP TABLE IF EXISTS `templist`;
	END IF;
	
	
	
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_getRoomBuildings` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`s215013395`@`localhost` PROCEDURE `sp_getRoomBuildings`(IN pType  TEXT,IN beds TINYINT(3),IN baths TINYINT(3),IN type VARCHAR(10))
BEGIN

	IF pType = 'building' THEN

		IF beds >= 0 THEN
			CREATE TEMPORARY TABLE IF NOT EXISTS `templist` SELECT pl.* from `shortlist` pl, building WHERE PROPERTY_ID = ID && `PROPERTY TYPE` = 'building' AND BEDROOMS = beds;							
			
			DROP TABLE IF EXISTS `shortlist`;
			CREATE TEMPORARY TABLE IF NOT EXISTS `shortlist` SELECT * FROM `templist`;	
			DROP TABLE IF EXISTS `templist`;
		END IF;
		

		IF baths > 0 THEN
			CREATE TEMPORARY TABLE IF NOT EXISTS `templist` SELECT pl.* from `shortlist` pl, building WHERE PROPERTY_ID = ID && `PROPERTY TYPE` = 'building' AND BATHROOMS = baths;						
			
			DROP TABLE IF EXISTS `shortlist`;
			CREATE TEMPORARY TABLE IF NOT EXISTS `shortlist` SELECT * FROM `templist`;	
			DROP TABLE IF EXISTS `templist`;
		END IF;
		

		IF type != '' THEN
			CREATE TEMPORARY TABLE IF NOT EXISTS `templist` SELECT Pl.* FROM `shortlist` Pl, building B WHERE ID = PROPERTY_ID &&`PROPERTY TYPE` = 'building' AND BUILDING_TYPE = type;						
			
			DROP TABLE IF EXISTS `shortlist`;
			CREATE TEMPORARY TABLE IF NOT EXISTS `shortlist` SELECT * FROM `templist`;	
			DROP TABLE IF EXISTS `templist`;
		END IF;
	END IF;
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_getRoomProperties` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`s215013395`@`localhost` PROCEDURE `sp_getRoomProperties`(IN seperate CHAR(1),IN items TEXT)
BEGIN  
	SET @itemList = items; 
	SET @delimiter = seperate;
	
	SET @q ='CREATE TEMPORARY TABLE IF NOT EXISTS templist SELECT  PL.*, COUNT(*) ROOMS FROM property_room PR,  shortlist PL WHERE PL.ID = PR.PROPERTY_ID AND (';
	SET @length = sf_arrayLength(@delimiter,@itemList);
	IF @length > 0 THEN
		SET @selectedItems = '';
		SET @count = 0;
	
		WHILE(@count < @length)	DO
			SET @count = @count + 1;
			IF(@count < (@length))	THEN SET @selectedItems = CONCAT(@selectedItems, 'PR.ROOM_ID = "', SPLIT_STR(@itemList,@delimiter,@count),'"',' || ');
			ELSE SET @selectedItems = CONCAT(@selectedItems, 'PR.ROOM_ID = "', SPLIT_STR(@itemList,@delimiter,@count),'"');	END IF;
		END WHILE;
		SET @q = CONCAT(@q, @selectedItems,' ) GROUP BY PL.ID,PL.SETTING,PL.`PROPERTY TYPE`,PL.TARGET,PL.`ADDRESS LINE 1`,PL.SUBURB,PL.LISTING HAVING ROOMS = ',@length);
		PREPARE stmt FROM @q; 
	 	EXECUTE stmt; 
		DEALLOCATE PREPARE stmt;
		
		DROP TABLE IF EXISTS `shortlist`;				
		CREATE TEMPORARY TABLE IF NOT EXISTS `shortlist` SELECT ID,SETTING,TARGET,`PROPERTY TYPE`,`ADDRESS LINE 1`,SUBURB,LISTING FROM `templist`;						
		DROP TABLE IF EXISTS `templist`;
	END IF;
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_getRoomTypeList` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`s215013395`@`localhost` PROCEDURE `sp_getRoomTypeList`(
IN pType  TEXT,
IN bType VARCHAR(10)
)
BEGIN
	IF pType = 'bedroom' && bType <> '' THEN
		CREATE TEMPORARY TABLE IF NOT EXISTS `templist` SELECT Pl.* from `shortlist` Pl,bedroom B,bedroom_type Bt WHERE ID = PROPERTY_ID && Bt.BEDROOM_TYPE = B.BEDROOM_TYPE AND B.BEDROOM_TYPE = bType;
		
		DROP TABLE IF EXISTS `shortlist`;				
		CREATE TEMPORARY TABLE IF NOT EXISTS `shortlist` SELECT * FROM `templist`;	
		DROP TABLE IF EXISTS `templist`;
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_updateBedroom` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`s215013395`@`localhost` PROCEDURE `sp_updateBedroom`(
	IN gend enum('F','M'),
	IN bType VARCHAR(10),
	IN story SMALLINT(6) UNSIGNED,
	IN x DOUBLE(16,2),
	IN y DOUBLE(16,2),
	IN id BIGINT(20) UNSIGNED
)
BEGIN
	DECLARE CHECKPOINT  TINYINT UNSIGNED DEFAULT 0;
	DECLARE EXIT HANDLER FOR SQLEXCEPTION,1265
	BEGIN 
		GET DIAGNOSTICS CONDITION 1 @p1 = RETURNED_SQLSTATE, @p2 = MESSAGE_TEXT;
		ROLLBACK;
        	SELECT CONCAT('C',LPAD(CHECKPOINT,2,'0'))  AS 'POINT',@p1 AS CODE, @p2 AS DESCRIPTION;
	END;
	START TRANSACTION;
	

	UPDATE bedroom SET GENDER_REQ = gend, FLOOR = story, BRENGTH = x, LENGTH = y, BEDROOM_TYPE = bType  WHERE  PROPERTY_ID = id;
 	COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_updateBuilding` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`s215013395`@`localhost` PROCEDURE `sp_updateBuilding`(
	IN floors SMALLINT(5) UNSIGNED,
	IN bType VARCHAR(10),
	IN beds TINYINT(3) UNSIGNED,
	IN baths TINYINT(3) UNSIGNED,
	IN id BIGINT(20) UNSIGNED
)
BEGIN
	DECLARE CHECKPOINT  TINYINT UNSIGNED DEFAULT 0;
	DECLARE EXIT HANDLER FOR SQLEXCEPTION,1265
	BEGIN 
		GET DIAGNOSTICS CONDITION 1 @p1 = RETURNED_SQLSTATE, @p2 = MESSAGE_TEXT;
		ROLLBACK;
        	SELECT CONCAT('C',LPAD(CHECKPOINT,2,'0'))  AS 'POINT',@p1 AS CODE, @p2 AS DESCRIPTION;
	END;
	START TRANSACTION;

	UPDATE building SET STORIES = floors, BUILDING_TYPE = bType, BEDROOMS = beds, BATHROOMS = baths WHERE PROPERTY_ID = id;
 	COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_updateProperty` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`s215013395`@`localhost` PROCEDURE `sp_updateProperty`(
	IN addr1 VARCHAR(45), 
	IN addr2 VARCHAR(45), 
	IN suburban BIGINT UNSIGNED,
	IN accom enum('Student','Worker','Nursing','Other','Any'),
	IN img BIGINT(20) UNSIGNED,
	IN propertyDesc TEXT,
	IN id BIGINT(20) UNSIGNED
)
BEGIN
	DECLARE CHECKPOINT  TINYINT UNSIGNED DEFAULT 0;
	DECLARE EXIT HANDLER FOR SQLEXCEPTION,1265
	BEGIN 
		GET DIAGNOSTICS CONDITION 1 @p1 = RETURNED_SQLSTATE, @p2 = MESSAGE_TEXT;
		ROLLBACK;
        	SELECT CONCAT('C',LPAD(CHECKPOINT,2,'0'))  AS 'POINT',@p1 AS CODE, @p2 AS DESCRIPTION;
	END;
	START TRANSACTION;

	UPDATE property SET ADDRESS_LINE1 = trim(addr1), ADDRESS_LINE2 = trim(addr2), SUBURB_ID = suburban, IMG_ID = img, TARGET = accom, DESCRIPTION = trim(propertyDesc) WHERE  PROPERTY_ID = id;
 	COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `uspFind` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`s215013395`@`localhost` PROCEDURE `uspFind`(
IN n MEDIUMINT UNSIGNED, IN block TINYINT UNSIGNED,IN del CHAR(1),
IN accomType TEXT,
IN propertyType  TEXT,
IN SUBURBAN BIGINT unsigned,
IN rooms TEXT,
IN items TEXT,
IN minp DOUBLE(16,2),
IN maxp DOUBLE(16,2),
IN bedType TEXT,
IN gender VARCHAR(1),
IN beds TINYINT(3),
IN baths TINYINT(3),
IN buildType VARCHAR(10)
)
BEGIN




	DECLARE k BIGINT UNSIGNED DEFAULT (n * block);
	DECLARE CONTINUE HANDLER FOR 1146
	BEGIN END;
	
	SET @itemList = items;							
	SET @roomList = rooms;							
	SET @delimiter = del;							
	
	DROP TABLE IF EXISTS `shortlist`;
	CREATE TEMPORARY TABLE IF NOT EXISTS `shortlist` SELECT * FROM property_list;
	
	CALL sp_getFeatureProperties(@delimiter, @itemList);			
	CALL sp_getRoomProperties(@delimiter, @roomList);			
	CALL getPriceProperties(minp,maxp);					
	CALL sp_getRoomTypeList(TRIM(propertyType),TRIM(bedType));		
	CALL getRoomGendList(TRIM(propertyType),TRIM(gender));			
	CALL sp_getRoomBuildings(TRIM(propertyType),beds,baths,TRIM(buildType));
	
	IF SUBURBAN = 0 THEN
		CREATE TABLE RECORDS SELECT * FROM shortlist  WHERE `TARGET`   LIKE 	CONCAT('%',accomType,'%') AND  `PROPERTY TYPE`  LIKE 	CONCAT('%',propertyType,'%');
		SELECT * FROM shortlist  WHERE `TARGET`   LIKE 	CONCAT('%',accomType,'%') AND  `PROPERTY TYPE`  LIKE 	CONCAT('%',propertyType,'%')  LIMIT block OFFSET k;
	ELSE
		CREATE TABLE RECORDS SELECT PL.* FROM shortlist PL,  property WHERE PL.`TARGET`   LIKE 	CONCAT('%',accomType,'%') AND  `PROPERTY TYPE` LIKE CONCAT('%',propertyType,'%')  and PROPERTY_ID = ID and SUBURB_ID = SUBURBAN;
		SELECT PL.* FROM shortlist PL,  property WHERE PL.`TARGET`   LIKE 	CONCAT('%',accomType,'%') AND  `PROPERTY TYPE` LIKE CONCAT('%',propertyType,'%')  and PROPERTY_ID = ID and SUBURB_ID = SUBURBAN LIMIT block OFFSET k;
	END IF;
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Current Database: `HE`
--

USE `HE`;

--
-- Final view structure for view `property_list`
--

/*!50001 DROP VIEW IF EXISTS `property_list`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`s215013395`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `property_list` AS select `P`.`PROPERTY_ID` AS `ID`,`sf_banner`(`P`.`PROPERTY_ID`) AS `SETTING`,`P`.`TARGET` AS `TARGET`,`P`.`PROP_TYPE_ID` AS `PROPERTY TYPE`,`P`.`ADDRESS_LINE1` AS `ADDRESS LINE 1`,(select `suburb`.`SUBURB_NAME` from `suburb` where (`suburb`.`SUBURB_ID` = `P`.`SUBURB_ID`)) AS `SUBURB`,`P`.`LISTING` AS `LISTING` from `property` `P` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-02-06 19:33:41
