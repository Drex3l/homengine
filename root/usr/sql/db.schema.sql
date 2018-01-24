-- MySQL dump 10.13  Distrib 5.7.20, for Linux (x86_64)
--
-- Host: localhost    Database: homengine
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
-- Current Database: `homengine`
--

/*!40000 DROP DATABASE IF EXISTS `homengine`*/;

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `homengine` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `homengine`;

--
-- Table structure for table `Facility`
--

DROP TABLE IF EXISTS `Facility`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Facility` (
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
/*!50003 CREATE*/ /*!50017 DEFINER=`com01`@`%`*/ /*!50003 TRIGGER `homengine`.`trig_facilKeyGen`
BEFORE INSERT ON `homengine`.`Facility`
FOR EACH ROW
BEGIN
  DECLARE FOUND BOOLEAN DEFAULT TRUE;
  DECLARE INCR SMALLINT UNSIGNED DEFAULT 0;
  WHILE FOUND DO
     SET NEW.ITEM_CODE = CONCAT('I',SUBSTRING(NEW.CATEGORY,1,1),(LPAD((INCR),2,'0')));
     SET FOUND = ((SELECT COUNT(ITEM_CODE) FROM Facility WHERE ITEM_CODE = NEW.ITEM_CODE) > 0);
     SET INCR = INCR + 1;
  END WHILE;
 END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `MainstreamUser`
--

DROP TABLE IF EXISTS `MainstreamUser`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `MainstreamUser` (
  `USER_ID` char(9) NOT NULL,
  `GENDER` enum('F','M') NOT NULL,
  `OCCUPATION` enum('STUDYING','WORKING','BOTH') DEFAULT NULL,
  PRIMARY KEY (`USER_ID`),
  CONSTRAINT `MainstreamUser_ibfk_1` FOREIGN KEY (`USER_ID`) REFERENCES `User` (`USER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Management`
--

DROP TABLE IF EXISTS `Management`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Management` (
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
  CONSTRAINT `Management_ibfk_1` FOREIGN KEY (`SUBURB_ID`) REFERENCES `Suburb` (`SUBURB_ID`),
  CONSTRAINT `Management_ibfk_2` FOREIGN KEY (`USER_ID`) REFERENCES `User` (`USER_ID`) ON DELETE CASCADE ON UPDATE CASCADE
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
/*!50003 CREATE*/ /*!50017 DEFINER=`com01`@`%`*/ /*!50003 TRIGGER `homengine`.`trig_b4managerUpdate`
BEFORE UPDATE ON `homengine`.`Management`
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
-- Table structure for table `Notification`
--

DROP TABLE IF EXISTS `Notification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Notification` (
  `NOTE_ID` char(12) NOT NULL,
  `HEADING` varchar(64) NOT NULL,
  `HAVE_READ` tinyint(1) NOT NULL DEFAULT '0',
  `USER_ID` char(9) NOT NULL,
  `RECEIVED` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`NOTE_ID`),
  KEY `USER_ID` (`USER_ID`),
  CONSTRAINT `Notification_ibfk_1` FOREIGN KEY (`USER_ID`) REFERENCES `User` (`USER_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `PROPERTY_FACILITY`
--

DROP TABLE IF EXISTS `PROPERTY_FACILITY`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `PROPERTY_FACILITY` (
  `PROPERTY_ID` bigint(20) unsigned NOT NULL,
  `FACILITY_ID` char(4) NOT NULL,
  PRIMARY KEY (`PROPERTY_ID`,`FACILITY_ID`),
  KEY `FACILITY` (`FACILITY_ID`),
  CONSTRAINT `PROPERTY_FACILITY_ibfk_2` FOREIGN KEY (`PROPERTY_ID`) REFERENCES `Property` (`PROPERTY_ID`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `PROPERTY_RENTAL`
--

DROP TABLE IF EXISTS `PROPERTY_RENTAL`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `PROPERTY_RENTAL` (
  `PROPERTY_ID` bigint(20) unsigned NOT NULL,
  `RENTAL_ID` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`PROPERTY_ID`,`RENTAL_ID`),
  KEY `RENTAL_ID` (`RENTAL_ID`),
  CONSTRAINT `PROPERTY_RENTAL_ibfk_3` FOREIGN KEY (`PROPERTY_ID`) REFERENCES `Property` (`PROPERTY_ID`) ON UPDATE CASCADE,
  CONSTRAINT `PROPERTY_RENTAL_ibfk_4` FOREIGN KEY (`RENTAL_ID`) REFERENCES `Rental` (`RENTAL_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `PROPERTY_ROOM`
--

DROP TABLE IF EXISTS `PROPERTY_ROOM`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `PROPERTY_ROOM` (
  `PROPERTY_ID` bigint(20) unsigned NOT NULL,
  `ROOM_ID` char(3) CHARACTER SET utf8 NOT NULL,
  `AVAILABLE` tinyint(1) DEFAULT '1',
  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`ID`),
  KEY `TYPE_ID` (`ROOM_ID`),
  KEY `PROPERTY_ID` (`PROPERTY_ID`),
  CONSTRAINT `PROPERTY_ROOM_ibfk_2` FOREIGN KEY (`ROOM_ID`) REFERENCES `Room` (`ROOM_ID`),
  CONSTRAINT `PROPERTY_ROOM_ibfk_3` FOREIGN KEY (`PROPERTY_ID`) REFERENCES `Property` (`PROPERTY_ID`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `PrivAcc`
--

DROP TABLE IF EXISTS `PrivAcc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `PrivAcc` (
  `USER_ID` char(9) NOT NULL,
  PRIMARY KEY (`USER_ID`),
  CONSTRAINT `PrivAcc_ibfk_1` FOREIGN KEY (`USER_ID`) REFERENCES `User` (`USER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Property`
--

DROP TABLE IF EXISTS `Property`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Property` (
  `PROPERTY_ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `ACCOMMODATION` enum('Student','Worker','Nursing','Other','Any') NOT NULL DEFAULT 'Any',
  `DESCRIPTION` varchar(255) NOT NULL DEFAULT '',
  `DATE_ON_MARKET` datetime DEFAULT CURRENT_TIMESTAMP,
  `TYPE_ID` char(3) NOT NULL,
  `IMG_ID` bigint(20) unsigned DEFAULT NULL,
  `AVAILABLE` tinyint(1) NOT NULL DEFAULT '1',
  `ADDRESS_LINE1` varchar(45) NOT NULL,
  `ADDRESS_LINE2` varchar(45) DEFAULT NULL,
  `SUBURB_ID` int(10) unsigned NOT NULL DEFAULT '0',
  `MANAGER_ID` char(9) NOT NULL,
  `BLOCK` char(2) DEFAULT NULL,
  `FLOOR` smallint(5) unsigned DEFAULT NULL,
  `STORIES` smallint(5) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`PROPERTY_ID`),
  KEY `TYPE_ID` (`TYPE_ID`),
  KEY `MANAGER_ID` (`MANAGER_ID`),
  KEY `SUBURB_ID` (`SUBURB_ID`),
  KEY `IMG_ID` (`IMG_ID`),
  CONSTRAINT `Property_ibfk_2` FOREIGN KEY (`TYPE_ID`) REFERENCES `PropertyType` (`TYPE_ID`),
  CONSTRAINT `Property_ibfk_5` FOREIGN KEY (`MANAGER_ID`) REFERENCES `Management` (`USER_ID`),
  CONSTRAINT `Property_ibfk_6` FOREIGN KEY (`SUBURB_ID`) REFERENCES `Suburb` (`SUBURB_ID`),
  CONSTRAINT `Property_ibfk_7` FOREIGN KEY (`IMG_ID`) REFERENCES `PropertyIMG` (`PICTURE_ID`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=104 DEFAULT CHARSET=utf8;
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
/*!50003 CREATE*/ /*!50017 DEFINER=`com01`@`%`*/ /*!50003 TRIGGER `homengine`.`trig_b4PropertyInsert`
BEFORE INSERT ON `homengine`.`Property`
FOR EACH ROW
BEGIN
 
 IF NEW.ADDRESS_LINE1 IS NOT NULL && TRIM(NEW.ADDRESS_LINE1) <> ''THEN
 	IF NEW.SUBURB_ID = 0 THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Physical Address must have a Suburb!';	END IF;
 END IF;
 IF NEW.SUBURB_ID !=0 THEN
 	IF NEW.ADDRESS_LINE1 IS NULL OR TRIM(NEW.ADDRESS_LINE1) = '' THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Physical Address must have a Street name!';	END IF;
 END IF;
  IF NEW.ADDRESS_LINE2 IS NOT NULL && TRIM(NEW.ADDRESS_LINE2) <> ''THEN
  	IF NEW.ADDRESS_LINE1 IS NULL OR TRIM(NEW.ADDRESS_LINE1) = '' THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Physical Address must have a Street name!';	END IF;
  	IF NEW.SUBURB_ID = 0 THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Physical Address must have a Suburb!';	END IF;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`com01`@`%`*/ /*!50003 TRIGGER `homengine`.`trig_b4PropertyUpdate`
BEFORE UPDATE ON `homengine`.`Property`
FOR EACH ROW
BEGIN

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
  IF NEW.STORIES < 1 THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Numbers Stories impractical';	END IF;

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `PropertyIMG`
--

DROP TABLE IF EXISTS `PropertyIMG`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `PropertyIMG` (
  `PICTURE_ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `PROPERTY_ID` bigint(20) unsigned NOT NULL,
  `DESCRIPTION` text,
  `PICTURE` char(17) NOT NULL,
  `TITLE` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`PICTURE_ID`),
  KEY `PROPERTY_ID` (`PROPERTY_ID`),
  CONSTRAINT `PropertyIMG_ibfk_1` FOREIGN KEY (`PROPERTY_ID`) REFERENCES `Property` (`PROPERTY_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `PropertyType`
--

DROP TABLE IF EXISTS `PropertyType`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `PropertyType` (
  `TYPE_ID` char(3) NOT NULL,
  `TYPE_DESC` varchar(20) NOT NULL,
  PRIMARY KEY (`TYPE_ID`),
  UNIQUE KEY `TYPE_DESC` (`TYPE_DESC`)
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
/*!50003 CREATE*/ /*!50017 DEFINER=`com01`@`%`*/ /*!50003 TRIGGER `homengine`.`trig_propTypelKeyGen`
BEFORE INSERT ON `homengine`.`PropertyType`
FOR EACH ROW
BEGIN
  DECLARE FOUND BOOLEAN DEFAULT TRUE;
  DECLARE INCR SMALLINT UNSIGNED DEFAULT 1;
  WHILE FOUND DO
     SET NEW.TYPE_ID = CONCAT('P',(LPAD(((SELECT COUNT(*) FROM PropertyType) + INCR),2,'0')));
     SET FOUND = ((SELECT COUNT(TYPE_ID) FROM PropertyType WHERE TYPE_ID = NEW.TYPE_ID) > 0);
     SET INCR = INCR + 1;
  END WHILE;
 END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `Rental`
--

DROP TABLE IF EXISTS `Rental`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Rental` (
  `RENTAL_ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `AMOUNT` double(16,2) NOT NULL,
  `MONTHS` smallint(5) unsigned NOT NULL DEFAULT '1',
  `DEPOSIT` double(16,2) DEFAULT NULL,
  `LEASE` smallint(5) unsigned DEFAULT NULL COMMENT 'Lease length in units of one month',
  PRIMARY KEY (`RENTAL_ID`)
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
/*!50003 CREATE*/ /*!50017 DEFINER=`com01`@`%`*/ /*!50003 TRIGGER `homengine`.`trig_b4RentalInsert`
BEFORE INSERT ON `homengine`.`Rental`
FOR EACH ROW
BEGIN

	IF NEW.LEASE < NEW.MONTHS THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Rental Period exceeds Lease Contract!';	END IF;
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
-- Table structure for table `Review`
--

DROP TABLE IF EXISTS `Review`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Review` (
  `REVIEW_ID` char(19) NOT NULL,
  `USER_ID` char(9) NOT NULL,
  `PROPERTY_ID` bigint(20) unsigned NOT NULL,
  `APPOINTMENT` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `DURATION` smallint(5) unsigned DEFAULT '30' COMMENT 'MINUTES',
  PRIMARY KEY (`REVIEW_ID`),
  KEY `USER_ID` (`USER_ID`),
  KEY `PROPERTY_ID` (`PROPERTY_ID`),
  CONSTRAINT `Review_ibfk_1` FOREIGN KEY (`USER_ID`) REFERENCES `MainstreamUser` (`USER_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Review_ibfk_2` FOREIGN KEY (`PROPERTY_ID`) REFERENCES `Property` (`PROPERTY_ID`) ON DELETE CASCADE ON UPDATE CASCADE
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
/*!50003 CREATE*/ /*!50017 DEFINER=`com01`@`%`*/ /*!50003 TRIGGER `homengine`.`trig_b4ReviewInsert`BEFORE INSERT ON `homengine`.`Review`
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
-- Table structure for table `Room`
--

DROP TABLE IF EXISTS `Room`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Room` (
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
/*!50003 CREATE*/ /*!50017 DEFINER=`com01`@`%`*/ /*!50003 TRIGGER `homengine`.`room_before_insert`
BEFORE INSERT ON `homengine`.`Room`
FOR EACH ROW
BEGIN
  DECLARE FOUND BOOLEAN DEFAULT TRUE;
  DECLARE INCR SMALLINT UNSIGNED DEFAULT 1;
  WHILE FOUND DO
     SET NEW.ROOM_ID = CONCAT('R',(LPAD(((SELECT COUNT(*) FROM Room) + INCR),2,'0')));
     SET FOUND = ((SELECT COUNT(ROOM_ID) FROM Room WHERE ROOM_ID = NEW.ROOM_ID) > 0);
     SET INCR = INCR + 1;
  END WHILE;
 END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `Suburb`
--

DROP TABLE IF EXISTS `Suburb`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Suburb` (
  `SUBURB_ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `SUBURB_NAME` varchar(35) NOT NULL,
  `POSTAL_CODE` varchar(5) DEFAULT NULL,
  PRIMARY KEY (`SUBURB_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=229 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `User`
--

DROP TABLE IF EXISTS `User`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `User` (
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
/*!50003 CREATE*/ /*!50017 DEFINER=`com01`@`%`*/ /*!50003 TRIGGER `homengine`.`trig_b4UserInsert`
BEFORE INSERT ON `homengine`.`User`
FOR EACH ROW
BEGIN
 DECLARE FOUND BOOLEAN DEFAULT TRUE;
 DECLARE INCR MEDIUMINT UNSIGNED DEFAULT 1;
 
 WHILE FOUND DO
  SET NEW.USER_ID = UPPER(CONCAT('U',(SELECT (CONCAT(SUBSTRING(DATE_FORMAT(CURDATE(),'%Y'),1,1),DATE_FORMAT(CURDATE(),'%y')))),SUBSTRING(NEW.USERNAME,1,1),LPAD(INCR,4,'0'))); 
  SET FOUND = ((SELECT COUNT(USER_ID) FROM User WHERE USER_ID = NEW.USER_ID) > 0); 
  SET INCR = INCR + 1;
 END WHILE;
 
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Temporary table structure for view `appointment_list`
--

DROP TABLE IF EXISTS `appointment_list`;
/*!50001 DROP VIEW IF EXISTS `appointment_list`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `appointment_list` AS SELECT 
 1 AS `ADDRESS LINE 1`,
 1 AS `SUBURB`,
 1 AS `APPOINTMENT`,
 1 AS `FIRST NAME`,
 1 AS `LAST NAME`,
 1 AS `ID`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `general_public`
--

DROP TABLE IF EXISTS `general_public`;
/*!50001 DROP VIEW IF EXISTS `general_public`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `general_public` AS SELECT 
 1 AS `ID`,
 1 AS `FIRST NAME`,
 1 AS `LAST NAME`,
 1 AS `GENDER`,
 1 AS `OCCUPATION`,
 1 AS `EMAIL`,
 1 AS `PHONE`,
 1 AS `USERNAME`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `management_list`
--

DROP TABLE IF EXISTS `management_list`;
/*!50001 DROP VIEW IF EXISTS `management_list`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `management_list` AS SELECT 
 1 AS `ID`,
 1 AS `ORGANIZATION`,
 1 AS `EMAIL`,
 1 AS `WEBSITE`,
 1 AS `PHONE`,
 1 AS `FAX`,
 1 AS `ADDRESS LINE 1`,
 1 AS `ADDRESS LINE 2`,
 1 AS `SUBURB`,
 1 AS `USERNAME`,
 1 AS `LOGO`*/;
SET character_set_client = @saved_cs_client;

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
 1 AS `PROPERTY TYPE`,
 1 AS `ACCOMMODATION`,
 1 AS `ON MARKET`,
 1 AS `FLOOR`,
 1 AS `BLOCK`,
 1 AS `ADDRESS LINE 1`,
 1 AS `ADDRESS LINE 2`,
 1 AS `SUBURB`,
 1 AS `DESCRIPTION`,
 1 AS `STORIES`*/;
SET character_set_client = @saved_cs_client;

--
-- Dumping routines for database 'homengine'
--
/*!50003 DROP FUNCTION IF EXISTS `sf_accExists` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`com01`@`%` FUNCTION `sf_accExists`(id CHAR(9),account ENUM('MANAGE','GENERAL')) RETURNS tinyint(1)
BEGIN
	DECLARE FOUND BOOLEAN;
	CASE	account
		WHEN	'MANAGE'	THEN
			RETURN ((SELECT COUNT(USER_ID) FROM Management WHERE USER_ID = id) > 0);
		WHEN 'GENERAL'	THEN
			RETURN ((SELECT COUNT(USER_ID) FROM MainstreamUser WHERE USER_ID = id) > 0);
	END CASE;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `sf_addProperty` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`com01`@`%` FUNCTION `sf_addProperty`(stories SMALLINT UNSIGNED, blok CHAR(2), accom VARCHAR(7), propertyDesc TEXT, onmarket DATETIME, story SMALLINT UNSIGNED, pType CHAR(3), addr1 VARCHAR(45), addr2 VARCHAR(45), suburban BIGINT UNSIGNED,  managedBy CHAR(9)) RETURNS bigint(20) unsigned
BEGIN
	
	DECLARE propertyID BIGINT UNSIGNED;
	DECLARE CHECKPOINT  TINYINT UNSIGNED DEFAULT 0;

	
	SET accom = trim(accom);
	SET pType = UPPER(REPLACE(pType,' ',''));
	SET blok = UPPER(REPLACE(blok,' ',''));
	SET propertyDesc = trim(propertyDesc);
	SET addr1 = trim(addr1);
	SET addr2 = trim(addr2);
	
	INSERT INTO Property(ACCOMMODATION,TYPE_ID,ADDRESS_LINE1,SUBURB_ID,MANAGER_ID) VALUES(accom,pType,addr1,suburban,managedBy);										SET CHECKPOINT = 1;
	SET propertyID = LAST_INSERT_ID();
	
	IF blok <> '' && blok IS NOT NULL THEN UPDATE Property SET BLOCK = blok WHERE PROPERTY_ID = propertyID;	END IF;				SET CHECKPOINT = 2;
	IF stories IS NOT NULL THEN UPDATE Property SET STORIES = stories WHERE PROPERTY_ID = propertyID;	END IF;							SET CHECKPOINT = 3;
	IF propertyDesc  <> '' && propertyDesc IS NOT NULL THEN UPDATE Property SET DESCRIPTION = propertyDesc WHERE PROPERTY_ID = propertyID;	END IF;		SET CHECKPOINT = 4;
	IF onmarket IS NOT NULL THEN UPDATE Property SET DATE_ON_MARKET = onmarket WHERE PROPERTY_ID = propertyID;	END IF;		SET CHECKPOINT = 5;
	IF addr2 IS NOT NULL && addr2 <> '' THEN UPDATE Property SET ADDRESS_LINE2 = addr2 WHERE PROPERTY_ID = propertyID;	END IF;	SET CHECKPOINT = 6;
	IF story IS NOT NULL THEN UPDATE Property SET FLOOR = story WHERE PROPERTY_ID = propertyID;	END IF;							SET CHECKPOINT = 3;
	
 	RETURN propertyID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
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
CREATE DEFINER=`com01`@`%` FUNCTION `sf_arrayLength`(seperate CHAR(1), arrayString TEXT) RETURNS smallint(5) unsigned
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
/*!50003 DROP FUNCTION IF EXISTS `sf_checkFacility` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`com01`@`%` FUNCTION `sf_checkFacility`(  itemID CHAR(6), propID BIGINT UNSIGNED) RETURNS tinyint(1)
BEGIN
	RETURN  ((SELECT COUNT(*) FROM PROPERTY_FACILITY WHERE PROPERTY_ID = propID && FACILITY_ID = itemID) > 0); 
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `sf_countFacilities` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`com01`@`%` FUNCTION `sf_countFacilities`(propID BIGINT UNSIGNED) RETURNS int(10) unsigned
BEGIN
	DECLARE items INT UNSIGNED DEFAULT  (SELECT COUNT(PROPERTY_ID) FROM PROPERTY_FACILITY WHERE PROPERTY_ID = propID GROUP BY PROPERTY_ID); 
	
	IF items IS NOT \N THEN RETURN items; END IF;
	RETURN 0;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `sf_getAccountType` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`com01`@`%` FUNCTION `sf_getAccountType`(id CHAR(9)) RETURNS char(3) CHARSET utf8
BEGIN

 	IF ((SELECT COUNT(USER_ID) FROM Management WHERE USER_ID = id) > 0) THEN RETURN 'MNG';
 	ELSEIF ((SELECT COUNT(USER_ID) FROM MainstreamUser WHERE USER_ID = id) > 0) THEN RETURN 'MNS';	 END IF;
 	RETURN 'UND';
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `sf_isAliasAvailable` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`com01`@`%` FUNCTION `sf_isAliasAvailable`(alias TEXT) RETURNS tinyint(1)
BEGIN
	DECLARE FOUND BOOLEAN DEFAULT ((SELECT COUNT(USERNAME) FROM User WHERE USERNAME LIKE  TRIM(alias)) > 0);
	IF FOUND THEN	RETURN FALSE;	END IF;
 	RETURN TRUE;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `sf_itemCount` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`com01`@`%` FUNCTION `sf_itemCount`(id CHAR(9),account ENUM('PROPERTY','REVIEW','NOTE'),status ENUM('UNREAD','READ')) RETURNS bigint(20) unsigned
BEGIN
	DECLARE FOUND BOOLEAN;
	CASE	account
		WHEN 'PROPERTY'	THEN
			RETURN (SELECT COUNT(*)  FROM (SELECT L.* FROM property_list L, Property P WHERE L.ID = P.PROPERTY_ID && MANAGER_ID = id) T);
		WHEN 'REVIEW'	THEN
			RETURN (SELECT COUNT(*)  FROM Review WHERE USER_ID = id);
		WHEN 'NOTE'	THEN
			BEGIN
				CASE	status
					WHEN	'UNREAD' THEN
						RETURN (SELECT COUNT(HAVE_READ)  FROM Notification WHERE USER_ID = id && HAVE_READ = FALSE);
					WHEN	'READ'	THEN
						RETURN (SELECT COUNT(HAVE_READ)  FROM Notification WHERE USER_ID = id && HAVE_READ = TRUE);
					ELSE
						RETURN	(SELECT COUNT(HAVE_READ) FROM Notification WHERE USER_ID = id);
				END CASE;
			END;
	END CASE;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `sf_rentalID` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`com01`@`%` FUNCTION `sf_rentalID`(dwnPaymt DOUBLE(16,2),rent DOUBLE(16,2), period SMALLINT UNSIGNED, lease_length SMALLINT UNSIGNED) RETURNS bigint(20) unsigned
BEGIN
 	RETURN (SELECT RENTAL_ID FROM Rental WHERE AMOUNT = rent && MONTHS = period && DEPOSIT = dwnPaymt && LEASE = lease_length);
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
CREATE DEFINER=`com01`@`%` FUNCTION `SPLIT_STR`(x VARCHAR(255), delim CHAR(1),pos INT) RETURNS varchar(255) CHARSET utf8
    DETERMINISTIC
BEGIN
 RETURN REPLACE(SUBSTRING(SUBSTRING_INDEX(x, delim, pos),LENGTH(SUBSTRING_INDEX(x, delim, pos -1))+1),delim, '');
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_addFacility` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`com01`@`%` PROCEDURE `sp_addFacility`(IN title VARCHAR(20),IN facilityDesc TEXT,IN type enum('ACCESSORY','FURNITURE','CONVENIENCE','SUNDRY'))
BEGIN
	DECLARE roomID BIGINT UNSIGNED;
	DECLARE CHECKPOINT  TINYINT UNSIGNED DEFAULT 0;
	DECLARE EXIT HANDLER FOR SQLEXCEPTION,1265
	BEGIN 
		GET DIAGNOSTICS CONDITION 1 @p1 = RETURNED_SQLSTATE, @p2 = MESSAGE_TEXT;
		ROLLBACK;
        	SELECT CONCAT('Error encountered, operation rollbacked. : C',LPAD(CHECKPOINT,2,'0'))  AS 'SQL EXCEPTION',@p1 AS CODE, @p2 AS DESCRIPTION;
	END;
	START TRANSACTION;
	
	SET title = trim(title);
	SET facilityDesc = trim(facilityDesc);
	
	INSERT INTO Facility(NAME,CATEGORY) VALUES(title,type);													SET CHECKPOINT = 1;
	
	IF facilityDesc <> '' && facilityDesc IS NOT \N THEN	UPDATE Facility SET DESCRIPTION = facilityDesc	WHERE NAME = title;	END IF;
	
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
CREATE DEFINER=`com01`@`%` PROCEDURE `sp_addImage`(IN id BIGINT UNSIGNED, IN IMG CHAR(17),IN imgTitle VARCHAR(20),IN imgDesc TEXT)
BEGIN
	DECLARE CHECKPOINT  TINYINT UNSIGNED DEFAULT 0;
	DECLARE EXIT HANDLER FOR SQLEXCEPTION,1265
	BEGIN 
		GET DIAGNOSTICS CONDITION 1 @p1 = RETURNED_SQLSTATE, @p2 = MESSAGE_TEXT;
		ROLLBACK;
        	SELECT CONCAT('Error encountered, operation rollbacked. : C',LPAD(CHECKPOINT,2,'0'))  AS 'SQL EXCEPTION',@p1 AS CODE, @p2 AS DESCRIPTION;
	END;
	START TRANSACTION;
	
	SET IMG = REPLACE(IMG,' ','');
	SET imgTitle = trim(imgTitle);
	SET imgDesc = trim(imgDesc);
	
	IF IMG = '' THEN	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'image name not found';	END IF;										SET CHECKPOINT = 1;
	BEGIN
		INSERT INTO PropertyIMG(PROPERTY_ID,PICTURE) VALUES(id,IMG);
		IF imgTitle <> '' && imgTitle IS NOT NULL THEN	UPDATE PropertyIMG SET TITLE = imgTitle  WHERE PICTURE_ID = LAST_INSERT_ID(); END IF; 	SET CHECKPOINT = 2;
		IF imgDesc <> '' && imgDesc IS NOT NULL THEN	UPDATE PropertyIMG SET DESCRIPTION = imgDesc WHERE PICTURE_ID = LAST_INSERT_ID();	END IF; 	SET CHECKPOINT = 3;
	END;
	
 	COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_addMainstreamUser` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`com01`@`%` PROCEDURE `sp_addMainstreamUser`(IN id CHAR(9),IN fname VARCHAR(20),IN lname VARCHAR(20),IN sex CHAR(1),IN occ VARCHAR(20))
BEGIN
	DECLARE CHECKPOINT  TINYINT UNSIGNED DEFAULT 0;
	DECLARE EXIT HANDLER FOR SQLEXCEPTION,1265
	BEGIN 
		GET DIAGNOSTICS CONDITION 1 @p1 = RETURNED_SQLSTATE, @p2 = MESSAGE_TEXT;
		ROLLBACK;
        	SELECT CONCAT('Error encountered, operation rollbacked. : C',LPAD(CHECKPOINT,2,'0'))  AS 'SQL EXCEPTION',@p1 AS CODE, @p2 AS DESCRIPTION;
	END;
	START TRANSACTION;
	
	SET fname = LOWER(TRIM(fname));
	SET @fl = UPPER(SUBSTRING(fname,1,1));
	SET fname = CONCAT(@fl,SUBSTRING(fname,2,LENGTH(fname)));
	
	SET lname = LOWER(TRIM(lname));
	SET @fl = UPPER(SUBSTRING(lname,1,1));
	SET lname = CONCAT(@fl,SUBSTRING(lname,2,LENGTH(lname)));
	
	SET sex = UPPER(REPLACE(sex,' ',''));
	SET occ = UPPER(REPLACE(occ,' ',''));
	
	IF fname = '' OR fname IS \N THEN	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'first name required';	END IF;						SET CHECKPOINT = 1;
	IF lname = '' OR lname IS \N THEN	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'last name required';	END IF;							SET CHECKPOINT = 2;
	
	INSERT INTO MainstreamUser(USER_ID,GENDER) VALUES(id,sex);													SET CHECKPOINT = 3;
	UPDATE User SET FIRST_NAME = fname, LAST_NAME = lname WHERE USER_ID = id;												SET CHECKPOINT = 4;
	
	IF occ <> '' && occ IS NOT \N THEN UPDATE MainstreamUser SET OCCUPATION = occ WHERE USER_ID = id;	END IF;			SET CHECKPOINT = 2;		
 	COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_addManagement` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`com01`@`%` PROCEDURE `sp_addManagement`(IN id CHAR(9),IN org VARCHAR(45),IN web VARCHAR(45),IN faxno CHAR(10),IN addr1 VARCHAR(45),IN addr2 VARCHAR(45), IN suburban INT)
BEGIN
	DECLARE CHECKPOINT  TINYINT UNSIGNED DEFAULT 0;
	DECLARE EXIT HANDLER FOR SQLEXCEPTION,1265
	BEGIN 
		GET DIAGNOSTICS CONDITION 1 @p1 = RETURNED_SQLSTATE, @p2 = MESSAGE_TEXT;
		ROLLBACK;
        	SELECT CONCAT('Error encountered, operation rollbacked. : C',LPAD(CHECKPOINT,2,'0'))  AS 'SQL EXCEPTION',@p1 AS CODE, @p2 AS DESCRIPTION;
	END;
	START TRANSACTION;
	
	INSERT INTO Management(USER_ID) VALUES(id);																			SET CHECKPOINT = 1;
	
	SET faxno = REPLACE(faxno,' ','');
	SET web = LOWER(REPLACE(web,' ',''));
	SET addr1 = trim(addr1);
	SET addr2 = trim(addr2);
	SET org = trim(org);
	
	IF org <> '' && org IS NOT NULL THEN UPDATE Management SET ORGANIZATION = org WHERE USER_ID = id;	END IF;				SET CHECKPOINT = 2;
	IF web <> '' && web IS NOT NULL THEN UPDATE Management SET WEBSITE = web WHERE USER_ID = id;	END IF;					SET CHECKPOINT = 3;					
	IF faxno <> '' && faxno IS NOT NULL THEN UPDATE Management SET FAX =  faxno WHERE USER_ID = id;	END IF;					SET CHECKPOINT = 5;
	
	IF (addr1 <> '' && addr1 IS NOT NULL) OR  (addr2 <> '' && addr2 IS NOT NULL) OR (suburban != 0 && suburban IS NOT NULL)	THEN
		UPDATE Management SET ADDRESS_LINE1 = addr1, ADDRESS_LINE2 = addr2, SUBURB_ID = suburban WHERE USER_ID = id;
		IF addr2 = ''	THEN UPDATE Management SET ADDRESS_LINE2 = \N WHERE USER_ID = id;	END IF;
	END IF;
 	COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_addNotification` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`com01`@`%` PROCEDURE `sp_addNotification`(IN noteID CHAR(12),IN head VARCHAR(64), IN userID CHAR(9))
BEGIN
	DECLARE CHECKPOINT  TINYINT UNSIGNED DEFAULT 0;
	DECLARE EXIT HANDLER FOR SQLEXCEPTION,1265
	BEGIN 
		GET DIAGNOSTICS CONDITION 1 @p1 = RETURNED_SQLSTATE, @p2 = MESSAGE_TEXT;
		ROLLBACK;
        	SELECT CONCAT('Error encountered, operation rollbacked. : C',LPAD(CHECKPOINT,2,'0'))  AS 'SQL EXCEPTION',@p1 AS CODE, @p2 AS DESCRIPTION;
	END;
	START TRANSACTION;
	
	SET noteID = TRIM(noteID);
	SET head = TRIM(head);
	SET userID = TRIM(userID);
	
	IF noteID = '' THEN	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'notification ID cannot be left blank';	END IF;						SET CHECKPOINT = 1;
	IF head = '' THEN	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'notification HEAD cannot be left blank';	END IF;								SET CHECKPOINT = 2;
	IF userID = '' THEN	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'USER ID cannot be left blank';	END IF;									SET CHECKPOINT = 3;
	
 	INSERT INTO Notification(NOTE_ID,HEADING,USER_ID) VALUES(noteID,head,userID);													SET CHECKPOINT = 4;

 	COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_addPrevAccUser` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`com01`@`%` PROCEDURE `sp_addPrevAccUser`(IN id CHAR(9))
BEGIN
	DECLARE CHECKPOINT  TINYINT UNSIGNED DEFAULT 0;
	DECLARE EXIT HANDLER FOR SQLEXCEPTION,1265
	BEGIN 
		GET DIAGNOSTICS CONDITION 1 @p1 = RETURNED_SQLSTATE, @p2 = MESSAGE_TEXT;
		ROLLBACK;
        	SELECT CONCAT('Error encountered, operation rollbacked. : C',LPAD(CHECKPOINT,2,'0'))  AS 'SQL EXCEPTION',@p1 AS CODE, @p2 AS DESCRIPTION;
	END;
	START TRANSACTION;
	
	INSERT INTO PrivAcc(USER_ID) VALUES(id);													SET CHECKPOINT = 1;

 	COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_addReview` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`com01`@`%` PROCEDURE `sp_addReview`(IN tenantID CHAR(9),IN propID BIGINT UNSIGNED,IN meeting DATETIME)
BEGIN
	DECLARE CHECKPOINT  TINYINT UNSIGNED DEFAULT 0;
	DECLARE EXIT HANDLER FOR SQLEXCEPTION,1265
	BEGIN 
		GET DIAGNOSTICS CONDITION 1 @p1 = RETURNED_SQLSTATE, @p2 = MESSAGE_TEXT;
		ROLLBACK;
        	SELECT CONCAT('Error encountered, operation rollbacked. : C',LPAD(CHECKPOINT,2,'0'))  AS 'SQL EXCEPTION',@p1 AS CODE, @p2 AS DESCRIPTION;
	END;
	START TRANSACTION;
	
	SET tenantID = trim(tenantID);																									SET CHECKPOINT = 1;
	
	IF meeting  IS NOT \N THEN
		INSERT INTO Review(USER_ID,PROPERTY_ID,APPOINTMENT) VALUES(tenantID,propID,meeting);
	ELSE
		INSERT INTO Review(USER_ID,PROPERTY_ID) VALUES(tenantID,propID);
	END IF;
																																SET CHECKPOINT = 2;
 	COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_addRoom` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`com01`@`%` PROCEDURE `sp_addRoom`(IN roomType VARCHAR(20),IN typeDesc VARCHAR(20))
BEGIN
	DECLARE roomID BIGINT UNSIGNED;
	DECLARE CHECKPOINT  TINYINT UNSIGNED DEFAULT 0;
	DECLARE EXIT HANDLER FOR SQLEXCEPTION,1265
	BEGIN 
		GET DIAGNOSTICS CONDITION 1 @p1 = RETURNED_SQLSTATE, @p2 = MESSAGE_TEXT;
		ROLLBACK;
        	SELECT CONCAT('Error encountered, operation rollbacked. : C',LPAD(CHECKPOINT,2,'0'))  AS 'SQL EXCEPTION',@p1 AS CODE, @p2 AS DESCRIPTION;
	END;
	START TRANSACTION;
	
	SET roomType = trim(roomDesc);
	SET typeDesc = trim(typeDesc);
	
	INSERT INTO Room(ROOM_TYPE) VALUES(roomType);																				SET CHECKPOINT = 1;
	IF typeDesc <> '' && typeDesc IS NOT \N THEN UPDATE Room SET DESCRIPTION = typeDesc WHERE ROOM_TYPE = roomType;	END IF;	SET CHECKPOINT = 2;
 	COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_addUser` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`com01`@`%` PROCEDURE `sp_addUser`(IN alias VARCHAR(20),IN pass TEXT, IN mail VARCHAR(45))
BEGIN
	DECLARE CHECKPOINT  TINYINT UNSIGNED DEFAULT 0;
	DECLARE EXIT HANDLER FOR SQLEXCEPTION,1265
	BEGIN 
		GET DIAGNOSTICS CONDITION 1 @p1 = RETURNED_SQLSTATE, @p2 = MESSAGE_TEXT;
		ROLLBACK;
        	SELECT CONCAT('Error encountered, operation rollbacked. : C',LPAD(CHECKPOINT,2,'0'))  AS 'SQL EXCEPTION',@p1 AS CODE, @p2 AS DESCRIPTION;
	END;
	START TRANSACTION;
	
	SET alias = LOWER(REPLACE(alias,' ',''));
	
	IF alias = '' THEN	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'username cannot be left blank';	END IF;							SET CHECKPOINT = 1;
	IF pass = '' THEN	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'password cannot be left blank';	END IF;								SET CHECKPOINT = 2;
	IF mail = '' THEN	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'email cannot be left blank';	END IF;									SET CHECKPOINT = 3;
	
 	INSERT INTO User(USERNAME,HASH,EMAIL,ACTIVE) VALUES(alias,pass,mail,-1);													SET CHECKPOINT = 4;

 	COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_assignFacilities` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`com01`@`%` PROCEDURE `sp_assignFacilities`(IN items TEXT,IN propID BIGINT UNSIGNED)
BEGIN 
	DECLARE CHECKPOINT  TINYINT UNSIGNED DEFAULT 0;
	DECLARE EXIT HANDLER FOR SQLEXCEPTION,1265
	BEGIN 
		GET DIAGNOSTICS CONDITION 1 @p1 = RETURNED_SQLSTATE, @p2 = MESSAGE_TEXT;
		ROLLBACK;
        	SELECT CONCAT('Error encountered, operation rollbacked. : C',LPAD(CHECKPOINT,2,'0'))  AS 'SQL EXCEPTION',@p1 AS CODE, @p2 AS DESCRIPTION;
	END;
	START TRANSACTION;
	SET @itemList = items; 
	SET @delimiter = ',';
	SET @propID = propID;
	
	SET @q ='INSERT INTO PROPERTY_FACILITY(PROPERTY_ID,FACILITY_ID) VALUES ';														SET CHECKPOINT = 1;
	SET @length = sf_arrayLength(@delimiter,@itemList);																			SET CHECKPOINT = 2;
	IF @length > 0 THEN
		SET @selectedItems = '';
		SET @count = 0;
	
		WHILE(@count < @length)	DO
			SET @count = @count + 1;
			IF(@count < (@length))	THEN SET @selectedItems = CONCAT(@selectedItems,'(',@propID,', "', SPLIT_STR(@itemList,@delimiter,@count),'"), ');
			ELSE SET @selectedItems = CONCAT(@selectedItems,'(', @propID,',"', SPLIT_STR(@itemList,@delimiter,@count),'")');	END IF;
		END WHILE;																												SET CHECKPOINT = 3;
		SET @q = CONCAT(@q, @selectedItems);
	ELSE SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Nothing Selected';
	END IF;																														SET CHECKPOINT = 4;
	PREPARE stmt FROM @q; 																										SET CHECKPOINT = 5;
	 EXECUTE stmt; 																												SET CHECKPOINT = 6;
	DEALLOCATE PREPARE stmt; 																									SET CHECKPOINT = 7;
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
CREATE DEFINER=`com01`@`%` PROCEDURE `sp_assignRental`(IN propID BIGINT UNSIGNED,IN dwnPaymt DOUBLE(16,2),IN rent DOUBLE(16,2),IN period SMALLINT UNSIGNED,IN lease_length SMALLINT UNSIGNED)
BEGIN
	DECLARE CHECKPOINT  TINYINT UNSIGNED DEFAULT 0;
	DECLARE EXIT HANDLER FOR SQLEXCEPTION,1265
	BEGIN 
		GET DIAGNOSTICS CONDITION 1 @p1 = RETURNED_SQLSTATE, @p2 = MESSAGE_TEXT;
		ROLLBACK;
        	SELECT CONCAT('Error encountered, operation rollbacked. : C',LPAD(CHECKPOINT,2,'0'))  AS 'SQL EXCEPTION',@p1 AS CODE, @p2 AS DESCRIPTION;
	END;
	START TRANSACTION;
	
	IF rent IS NULL THEN 	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'please give rental';	END IF;										SET CHECKPOINT = 1;
	IF period IS NULL THEN SET period = 1; END IF;																					SET CHECKPOINT = 2;
	SET @Rental = sf_rentalID(dwnPaymt,rent,period,lease_length);																	SET CHECKPOINT = 3;	

			IF @Rental IS NULL THEN
 				INSERT INTO Rental VALUES(\N,rent,period,dwnPaymt,lease_length);													SET CHECKPOINT = 4;	
 				INSERT INTO PROPERTY_RENTAL VALUES(propID,LAST_INSERT_ID());
 			ELSE
 				INSERT INTO PROPERTY_RENTAL VALUES(propID,@Rental);
 			END IF;
 	COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_assignRooms` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`com01`@`%` PROCEDURE `sp_assignRooms`(IN roomID CHAR(3),IN propID BIGINT UNSIGNED, IN times INT)
BEGIN 
	DECLARE CHECKPOINT  TINYINT UNSIGNED DEFAULT 0;
	DECLARE EXIT HANDLER FOR SQLEXCEPTION,1265
	BEGIN 
		GET DIAGNOSTICS CONDITION 1 @p1 = RETURNED_SQLSTATE, @p2 = MESSAGE_TEXT;
		ROLLBACK;
        	SELECT CONCAT('Error encountered, operation rollbacked. : C',LPAD(CHECKPOINT,2,'0'))  AS 'SQL EXCEPTION',@p1 AS CODE, @p2 AS DESCRIPTION;
	END;
	START TRANSACTION;
	SET @propID = propID;
	SET @roomID = roomID;
	
	SET @q ='INSERT INTO PROPERTY_ROOM(ROOM_ID,PROPERTY_ID) VALUES ';														SET CHECKPOINT = 1;
	SET @length = times;																			SET CHECKPOINT = 2;
	IF @length > 0 THEN
		SET @selectedItems = '';
		SET @count = 0;
	
		WHILE(@count < @length)	DO
			SET @count = @count + 1;
			IF(@count < (@length))	THEN SET @selectedItems = CONCAT(@selectedItems,'("',@roomID,'", ', @propID,'), ');
			ELSE SET @selectedItems = CONCAT(@selectedItems,'("', @roomID,'",', @propID,')');	END IF;
		END WHILE;																												SET CHECKPOINT = 3;
		SET @q = CONCAT(@q, @selectedItems);
	ELSE SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Nothing Selected';
	END IF;																														SET CHECKPOINT = 4;
	PREPARE stmt FROM @q; 																										SET CHECKPOINT = 5;
	 EXECUTE stmt; 																												SET CHECKPOINT = 6;
	DEALLOCATE PREPARE stmt; 																									SET CHECKPOINT = 7;
	COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_deleteRental` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`com01`@`%` PROCEDURE `sp_deleteRental`(IN rentalID BIGINT UNSIGNED, IN propID BIGINT UNSIGNED)
BEGIN
	DECLARE CHECKPOINT  TINYINT UNSIGNED DEFAULT 0;
	DECLARE propCount BIGINT UNSIGNED;
	
	DECLARE EXIT HANDLER FOR SQLEXCEPTION,1265
	BEGIN 
		GET DIAGNOSTICS CONDITION 1 @p1 = RETURNED_SQLSTATE, @p2 = MESSAGE_TEXT;
		ROLLBACK;
        	SELECT CONCAT('Error encountered, operation rollbacked. : C',LPAD(CHECKPOINT,2,'0'))  AS 'SQL EXCEPTION',@p1 AS CODE, @p2 AS DESCRIPTION;
	END;
	START TRANSACTION;
		DELETE FROM PROPERTY_RENTAL WHERE RENTAL_ID = rentalID && PROPERTY_ID = propID;										SET CHECKPOINT = 1;
		SELECT  COUNT(PROPERTY_ID) FROM PROPERTY_RENTAL WHERE RENTAL_ID = rentalID GROUP BY RENTAL_ID INTO propCount;		SET CHECKPOINT = 2;
		
		IF propCount = 0  THEN	DELETE FROM Rental WHERE RENTAL_ID = rentalID;	END IF;											SET CHECKPOINT = 3;
	
 	COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_getFacilities` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`com01`@`%` PROCEDURE `sp_getFacilities`( IN propertyID BIGINT UNSIGNED, IN type ENUM('A','C','F','S'))
BEGIN
	DECLARE CHECKPOINT  TINYINT UNSIGNED DEFAULT 0;
	DECLARE EXIT HANDLER FOR SQLEXCEPTION,1265
	BEGIN 
		GET DIAGNOSTICS CONDITION 1 @p1 = RETURNED_SQLSTATE, @p2 = MESSAGE_TEXT;
		ROLLBACK;
        	SELECT CONCAT('Error encountered, operation rollbacked. : C',LPAD(CHECKPOINT,2,'0'))  AS 'SQL EXCEPTION',@p1 AS CODE, @p2 AS DESCRIPTION;
	END;
	CASE type
		WHEN 'A'	THEN
		BEGIN
			SELECT ITEM_CODE, NAME FROM Facility F, PROPERTY_FACILITY PF,  Property P
			WHERE P.PROPERTY_ID = PF.PROPERTY_ID && PF.FACILITY_ID = F.ITEM_CODE
			AND PF.PROPERTY_ID = propertyID && F.CATEGORY = 'ACCESSORY'
			ORDER BY NAME;
		END;
		WHEN 'C'	THEN
		BEGIN
			SELECT ITEM_CODE, NAME FROM Facility F, PROPERTY_FACILITY PF,  Property P
			WHERE P.PROPERTY_ID = PF.PROPERTY_ID && PF.FACILITY_ID = F.ITEM_CODE
			AND PF.PROPERTY_ID = propertyID && F.CATEGORY = 'CONVENIENCE'
			ORDER BY NAME;
		END;
		WHEN 'F'	THEN
		BEGIN
			SELECT ITEM_CODE, NAME FROM Facility F, PROPERTY_FACILITY PF,  Property P
			WHERE P.PROPERTY_ID = PF.PROPERTY_ID && PF.FACILITY_ID = F.ITEM_CODE
			AND PF.PROPERTY_ID = propertyID && F.CATEGORY = 'FURNITURE'
			ORDER BY NAME;
		END;
		WHEN 'S'	THEN
		BEGIN
			SELECT ITEM_CODE, NAME FROM Facility F, PROPERTY_FACILITY PF,  Property P
			WHERE P.PROPERTY_ID = PF.PROPERTY_ID && PF.FACILITY_ID = F.ITEM_CODE
			AND PF.PROPERTY_ID = propertyID && F.CATEGORY = 'SUNDRY'
			ORDER BY NAME;
		END;
		ELSE
		BEGIN
			SELECT ITEM_CODE, NAME FROM Facility F, PROPERTY_FACILITY PF,  Property P
			WHERE P.PROPERTY_ID = PF.PROPERTY_ID && PF.FACILITY_ID = F.ITEM_CODE
			AND PF.PROPERTY_ID = propertyID
			ORDER BY NAME;
		END;
	END CASE;
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
CREATE DEFINER=`com01`@`%` PROCEDURE `sp_getFeatureProperties`(IN seperate CHAR(1),IN items TEXT)
BEGIN  
	SET @itemList = items; 
	SET @delimiter = seperate;
	
	SET @q ='CREATE TEMPORARY TABLE IF NOT EXISTS shortlist SELECT  PL.*, COUNT(*) FACILITITIES FROM PROPERTY_FACILITY PF,  property_list PL WHERE PL.ID = PF.PROPERTY_ID AND (';
	SET @length = sf_arrayLength(@delimiter,@itemList);
	IF @length > 0 THEN
		SET @selectedItems = '';
		SET @count = 0;
	
		WHILE(@count < @length)	DO
			SET @count = @count + 1;
			IF(@count < (@length))	THEN SET @selectedItems = CONCAT(@selectedItems, 'PF.FACILITY_ID = "', SPLIT_STR(@itemList,@delimiter,@count),'"',' || ');
			ELSE SET @selectedItems = CONCAT(@selectedItems, 'PF.FACILITY_ID = "', SPLIT_STR(@itemList,@delimiter,@count),'"');	END IF;
		END WHILE;
		SET @q = CONCAT(@q, @selectedItems,' ) GROUP BY ID HAVING FACILITITIES = ',@length);
	ELSE SET @q = 'CREATE TEMPORARY TABLE IF NOT EXISTS shortlist SELECT * FROM property_list';	
	END IF;
	PREPARE stmt FROM @q; 
	 EXECUTE stmt; 
	DEALLOCATE PREPARE stmt; 
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_getListing` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`com01`@`%` PROCEDURE `sp_getListing`( IN item ENUM('P','A'),IN belongTo CHAR(9))
BEGIN
	DECLARE CHECKPOINT  TINYINT UNSIGNED DEFAULT 0;
	DECLARE EXIT HANDLER FOR SQLEXCEPTION,1265
	BEGIN 
		GET DIAGNOSTICS CONDITION 1 @p1 = RETURNED_SQLSTATE, @p2 = MESSAGE_TEXT;
		ROLLBACK;
        	SELECT CONCAT('Error encountered, operation rollbacked. : C',LPAD(CHECKPOINT,2,'0'))  AS 'SQL EXCEPTION',@p1 AS CODE, @p2 AS DESCRIPTION;
	END;
	CASE item
	WHEN	'P'	THEN
		BEGIN
			SELECT L.* FROM property_list L, Property P WHERE ID = PROPERTY_ID && MANAGER_ID = belongTo;
		END;
	WHEN	'A'	THEN
		BEGIN
			SELECT A.*, R.PROPERTY_ID FROM appointment_list A, Review R, MainstreamUser U  WHERE A.ID = R.REVIEW_ID && R.USER_ID = U.USER_ID AND U.USER_ID = belongTo;
		END;
	END CASE;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_getPropertyRooms` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`com01`@`%` PROCEDURE `sp_getPropertyRooms`( IN properyID BIGINT UNSIGNED)
BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION,1265
	BEGIN 
		GET DIAGNOSTICS CONDITION 1 @p1 = RETURNED_SQLSTATE, @p2 = MESSAGE_TEXT;
        	SELECT @p1 AS CODE, @p2 AS DESCRIPTION;
	END;
	SELECT PR.ID,R.*
	FROM Room R, PROPERTY_ROOM PR 
	WHERE PR.ROOM_ID = R.ROOM_ID && PR.PROPERTY_ID = properyID && PR.AVAILABLE = TRUE;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_getRental` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`com01`@`%` PROCEDURE `sp_getRental`(IN id BIGINT UNSIGNED)
BEGIN
	DECLARE CHECKPOINT  TINYINT UNSIGNED DEFAULT 0;
	DECLARE EXIT HANDLER FOR SQLEXCEPTION,1265
	BEGIN 
		GET DIAGNOSTICS CONDITION 1 @p1 = RETURNED_SQLSTATE, @p2 = MESSAGE_TEXT;
		
        	SELECT @p1 AS CODE, @p2 AS DESCRIPTION;
	END;
	
	SELECT R.DEPOSIT,R.AMOUNT, R.MONTHS, R.LEASE, R.RENTAL_ID ID FROM Rental R, PROPERTY_RENTAL PR WHERE PR.RENTAL_ID = R.RENTAL_ID && PR.PROPERTY_ID = id ORDER BY MONTHS;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_setPropertyStatus` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`com01`@`%` PROCEDURE `sp_setPropertyStatus`(IN state BOOLEAN,IN id BIGINT UNSIGNED,IN item CHAR(1))
BEGIN
	DECLARE CHECKPOINT  TINYINT UNSIGNED DEFAULT 0;
	DECLARE EXIT HANDLER FOR SQLEXCEPTION,1265
	BEGIN 
		GET DIAGNOSTICS CONDITION 1 @p1 = RETURNED_SQLSTATE, @p2 = MESSAGE_TEXT;
		ROLLBACK;
        	SELECT CONCAT('Error encountered, operation rollbacked. : C',LPAD(CHECKPOINT,2,'0'))  AS 'SQL EXCEPTION',@p1 AS CODE, @p2 AS DESCRIPTION;
	END;
	SET @@AUTOCOMMIT = 0;
	CASE UPPER(item)
		WHEN 'P' THEN
 			UPDATE Property SET AVAILABLE = state WHERE PROPERTY_ID = id;															SET CHECKPOINT = 1;
 		WHEN 'R' THEN
 			UPDATE Room SET AVAILABLE = state WHERE ROOM_ID = id;																	SET CHECKPOINT = 1;
 	END CASE;
 	COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_setStatus` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`com01`@`%` PROCEDURE `sp_setStatus`(IN state TINYINT(1),IN item ENUM('USER','NOTE','ROOM'),IN id TEXT)
BEGIN
	DECLARE CHECKPOINT  TINYINT UNSIGNED DEFAULT 0;
	DECLARE EXIT HANDLER FOR SQLEXCEPTION,1265
	BEGIN 
		GET DIAGNOSTICS CONDITION 1 @p1 = RETURNED_SQLSTATE, @p2 = MESSAGE_TEXT;
		ROLLBACK;
        	SELECT CONCAT('Error encountered, operation rollbacked. : C',LPAD(CHECKPOINT,2,'0'))  AS 'SQL EXCEPTION',@p1 AS CODE, @p2 AS DESCRIPTION;
	END;
	CASE item
		WHEN 'USER'	THEN
			UPDATE User SET ACTIVE = state WHERE USER_ID = id;																	SET CHECKPOINT = 1;
		WHEN 'NOTE'	THEN
			UPDATE Notification SET HAVE_READ = state WHERE NOTE_ID = id;														SET CHECKPOINT = 1;
		WHEN 'ROOM'	THEN
			UPDATE Room SET AVAILABLE = state WHERE ROOM_ID = id;															SET CHECKPOINT = 1;
 	END CASE;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_upateManagement` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`com01`@`%` PROCEDURE `sp_upateManagement`(IN id CHAR(9), IN org VARCHAR(45), IN web VARCHAR(45), IN faxno CHAR(10), IN addr1 VARCHAR(45), IN addr2 VARCHAR(45), IN suburban INT)
BEGIN
	DECLARE CHECKPOINT  TINYINT UNSIGNED DEFAULT 0;
	DECLARE EXIT HANDLER FOR SQLEXCEPTION,1265
	BEGIN 
		GET DIAGNOSTICS CONDITION 1 @p1 = RETURNED_SQLSTATE, @p2 = MESSAGE_TEXT;
		ROLLBACK;
        	SELECT CONCAT('Error encountered, operation rollbacked. : C',LPAD(CHECKPOINT,2,'0'))  AS 'SQL EXCEPTION',@p1 AS CODE, @p2 AS DESCRIPTION;
	END;
	START TRANSACTION;
	
	SET faxno = REPLACE(faxno,' ','');
	SET web = LOWER(REPLACE(web,' ',''));
	SET addr1 = trim(addr1);
	SET addr2 = trim(addr2);
	SET org = trim(org);
	
 	IF org <> '' && org  IS NOT NULL THEN	UPDATE Management SET ORGANIZATION = org WHERE USER_ID = id;	END IF;				SET CHECKPOINT = 1;
 	IF web <> '' && web IS NOT NULL THEN UPDATE Management SET WEBSITE = web WHERE USER_ID = id;	END IF;					SET CHECKPOINT = 2;	
 	IF faxno <> '' && faxno IS NOT NULL THEN UPDATE Management SET FAX = faxno WHERE USER_ID = id;	END IF;					SET CHECKPOINT = 3;
 	IF addr1 <> '' && addr1  IS NOT NULL THEN	UPDATE Management SET ADDRESS_LINE1 = addr1 WHERE USER_ID = id;	END IF;		SET CHECKPOINT = 4;
 	IF addr2 <> '' && addr2  IS NOT NULL THEN	UPDATE Management SET ADDRESS_LINE2 = addr2 WHERE USER_ID = id;	END IF;		SET CHECKPOINT = 5;
 	IF suburban  IS NOT NULL THEN	UPDATE Management SET SUBURB_ID = suburban WHERE USER_ID = id;	END IF;				SET CHECKPOINT = 6;
 	
 	COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_updateMainstreamUser` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`com01`@`%` PROCEDURE `sp_updateMainstreamUser`(IN id CHAR(9),IN fname VARCHAR(20),IN lname VARCHAR(20),IN sex CHAR(1),IN occ VARCHAR(20))
BEGIN
	DECLARE CHECKPOINT  TINYINT UNSIGNED DEFAULT 0;
	DECLARE EXIT HANDLER FOR SQLEXCEPTION,1265
	BEGIN 
		GET DIAGNOSTICS CONDITION 1 @p1 = RETURNED_SQLSTATE, @p2 = MESSAGE_TEXT;
		ROLLBACK;
        	SELECT CONCAT('Error encountered, operation rollbacked. : C',LPAD(CHECKPOINT,2,'0'))  AS 'SQL EXCEPTION',@p1 AS CODE, @p2 AS DESCRIPTION;
	END;
	START TRANSACTION;
	
	SET fname = LOWER(TRIM(fname));
	SET @fl = UPPER(SUBSTRING(fname,1,1));
	SET fname = CONCAT(@fl,SUBSTRING(fname,2,LENGTH(fname)));
	
	SET lname = LOWER(TRIM(lname));
	SET @fl = UPPER(SUBSTRING(lname,1,1));
	SET lname = CONCAT(@fl,SUBSTRING(lname,2,LENGTH(lname)));
	
	SET sex = UPPER(REPLACE(sex,' ',''));
	SET occ = UPPER(REPLACE(occ,' ',''));
	
 	IF fname <> '' && fname  IS NOT \N THEN	UPDATE User SET FIRST_NAME = fname WHERE USER_ID = id;	END IF;					SET CHECKPOINT = 1;
 	IF lname <> '' && lname  IS NOT \N THEN	UPDATE User SET LAST_NAME = lname WHERE USER_ID = id;	END IF;					SET CHECKPOINT = 2;
 	IF sex <> '' && sex  IS NOT \N THEN	UPDATE MainstreamUser SET GENDER = sex WHERE USER_ID = id;	END IF;						SET CHECKPOINT = 3;
 	IF occ <> '' && occ IS NOT \N THEN UPDATE MainstreamUser SET OCCUPATION = occ WHERE USER_ID = id;	
 	ELSE	UPDATE MainstreamUser SET OCCUPATION = \N WHERE USER_ID = id;
 	END IF;			SET CHECKPOINT = 4;
 	
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
CREATE DEFINER=`com01`@`%` PROCEDURE `sp_updateProperty`(stories SMALLINT UNSIGNED, blok CHAR(2), accom VARCHAR(7), propertyDesc TEXT, onmarket DATETIME, story SMALLINT UNSIGNED, pType CHAR(3), addr1 VARCHAR(45), addr2 VARCHAR(45), suburban BIGINT UNSIGNED,  propertyID BIGINT UNSIGNED)
BEGIN
	DECLARE CHECKPOINT  TINYINT UNSIGNED DEFAULT 0;
	DECLARE EXIT HANDLER FOR SQLEXCEPTION,1265
	BEGIN 
		GET DIAGNOSTICS CONDITION 1 @p1 = RETURNED_SQLSTATE, @p2 = MESSAGE_TEXT;
		ROLLBACK;
        	SELECT CONCAT('Error encountered, operation rollbacked. : C',LPAD(CHECKPOINT,2,'0'))  AS 'SQL EXCEPTION',@p1 AS CODE, @p2 AS DESCRIPTION;
	END;
	START TRANSACTION;
	
	SET accom = trim(accom);
	SET pType = UPPER(REPLACE(pType,' ',''));
	SET blok = UPPER(REPLACE(blok,' ',''));
	SET propertyDesc = trim(propertyDesc);
	SET addr1 = trim(addr1);
	SET addr2 = trim(addr2);
	
 	IF blok <> '' && blok IS NOT NULL THEN UPDATE Property SET BLOCK = blok WHERE PROPERTY_ID = propertyID;	END IF;				SET CHECKPOINT = 2;
	IF stories IS NOT NULL THEN UPDATE Property SET STORIES = stories WHERE PROPERTY_ID = propertyID;	END IF;							SET CHECKPOINT = 3;
	IF propertyDesc  <> '' && propertyDesc IS NOT NULL THEN UPDATE Property SET DESCRIPTION = propertyDesc WHERE PROPERTY_ID = propertyID;	END IF;		SET CHECKPOINT = 4;
	IF onmarket IS NOT NULL THEN UPDATE Property SET DATE_ON_MARKET = onmarket WHERE PROPERTY_ID = propertyID;	END IF;		SET CHECKPOINT = 5;
	IF story IS NOT NULL THEN UPDATE Property SET FLOOR = story WHERE PROPERTY_ID = propertyID;	END IF;							SET CHECKPOINT = 6;
	
	IF accom <> '' && accom  IS NOT NULL THEN	UPDATE Property SET ACCOMMODATION = accom WHERE PROPERTY_ID = propertyID;	END IF;		SET CHECKPOINT = 7;
	IF pType <> '' && pType  IS NOT NULL THEN	UPDATE Property SET TYPE_ID = pType WHERE PROPERTY_ID = propertyID;	END IF;		SET CHECKPOINT = 8;
	IF addr1 <> '' && addr1  IS NOT NULL THEN	UPDATE Property SET ADDRESS_LINE1 = addr1 WHERE PROPERTY_ID = propertyID;	END IF;		SET CHECKPOINT = 9;
 	IF addr2 <> '' && addr2  IS NOT NULL THEN	UPDATE Property SET ADDRESS_LINE2 = addr2 WHERE PROPERTY_ID = propertyID;	END IF;		SET CHECKPOINT = 10;
 	IF suburban  IS NOT NULL THEN	UPDATE Property SET SUBURB_ID = suburban WHERE PROPERTY_ID = propertyID;	END IF;				SET CHECKPOINT = 11;
 	
 	COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_updateRoom` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`com01`@`%` PROCEDURE `sp_updateRoom`(IN roomID CHAR(3),IN roomType VARCHAR(20),IN roomDesc VARCHAR(20))
BEGIN
	DECLARE CHECKPOINT  TINYINT UNSIGNED DEFAULT 0;
	DECLARE EXIT HANDLER FOR SQLEXCEPTION,1265
	BEGIN 
		GET DIAGNOSTICS CONDITION 1 @p1 = RETURNED_SQLSTATE, @p2 = MESSAGE_TEXT;
		ROLLBACK;
        	SELECT CONCAT('Error encountered, operation rollbacked. : C',LPAD(CHECKPOINT,2,'0'))  AS 'SQL EXCEPTION',@p1 AS CODE, @p2 AS DESCRIPTION;
	END;
	START TRANSACTION;
	
	SET roomID = trim(roomID);
	SET roomType = trim(roomType);
	SET roomDesc = trim(roomDesc);
	
	IF roomType <> '' && roomType IS NOT \N THEN UPDATE Room SET ROOM_TYPE = roomType WHERE ROOM_ID = roomID;	END IF;		SET CHECKPOINT = 1;
	IF roomDesc <> '' && roomDesc IS NOT \N THEN UPDATE Room SET DESCRIPTION = roomDesc WHERE ROOM_ID = roomID;	END IF;		SET CHECKPOINT = 2;

 	COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_updateUser` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`com01`@`%` PROCEDURE `sp_updateUser`(IN id CHAR(9),IN alias VARCHAR(20),IN email VARCHAR(45),IN phone CHAR(10),IN img CHAR(15),IN pass TEXT,IN fname VARCHAR(20),IN lname VARCHAR(20))
BEGIN
	DECLARE CHECKPOINT  TINYINT UNSIGNED DEFAULT 0;
	DECLARE EXIT HANDLER FOR SQLEXCEPTION,1265
	BEGIN 
		GET DIAGNOSTICS CONDITION 1 @p1 = RETURNED_SQLSTATE, @p2 = MESSAGE_TEXT;
		ROLLBACK;
        	SELECT CONCAT('Error encountered, operation rollbacked. : C',LPAD(CHECKPOINT,2,'0'))  AS 'SQL EXCEPTION',@p1 AS CODE, @p2 AS DESCRIPTION;
	END;
	START TRANSACTION;
	
	SET fname = LOWER(TRIM(fname));
	SET @fl = UPPER(SUBSTRING(fname,1,1));
	SET fname = CONCAT(@fl,SUBSTRING(fname,2,LENGTH(fname)));
	
	SET lname = LOWER(TRIM(lname));
	SET @fl = UPPER(SUBSTRING(lname,1,1));
	SET lname = CONCAT(@fl,SUBSTRING(lname,2,LENGTH(lname)));
	
	SET alias = LOWER(REPLACE(alias,' ',''));
	SET email = LOWER(REPLACE(email,' ',''));
	SET phone = LOWER(REPLACE(phone,' ',''));
	
	IF  alias IS NOT \N &&  alias <> ''	THEN UPDATE User SET USERNAME = alias WHERE USER_ID = id;	END IF;							SET CHECKPOINT = 1;
	IF  pass IS NOT \N &&  pass <> ''THEN UPDATE User SET HASH = pass WHERE USER_ID = id;	END IF;								SET CHECKPOINT = 2;
	IF  email IS NOT \N &&  email <> ''	THEN UPDATE User SET EMAIL = email WHERE USER_ID = id;	END IF;							SET CHECKPOINT = 3;
	IF  phone IS NOT \N &&  phone <> ''THEN UPDATE User SET PHONE = phone WHERE USER_ID = id;	END IF;							SET CHECKPOINT = 4;
	IF  img IS NOT \N &&  img <>  ''	THEN UPDATE User SET DISPLAY_IMG = img WHERE USER_ID = id;	END IF;						SET CHECKPOINT = 5;
	IF fname <> '' && fname  IS NOT \N THEN	UPDATE User SET FIRST_NAME = fname WHERE USER_ID = id;	END IF;					SET CHECKPOINT = 6;
 	IF lname <> '' && lname  IS NOT \N THEN	UPDATE User SET LAST_NAME = lname WHERE USER_ID = id;	END IF;					SET CHECKPOINT = 7;
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
CREATE DEFINER=`com01`@`%` PROCEDURE `uspFind`(IN accomType TEXT,IN propertyType  TEXT,IN SUBURBAN BIGINT unsigned,IN items TEXT)
BEGIN

	DECLARE CONTINUE HANDLER FOR 1146
	BEGIN END;
	
	SET @itemList = items; 
	CALL sp_getFeatureProperties(',', @itemList);
	IF SUBURBAN = 0 THEN
		SELECT * FROM shortlist  WHERE `ACCOMMODATION`   LIKE 	CONCAT('%',accomType,'%') AND  `PROPERTY TYPE`  LIKE 	CONCAT('%',propertyType,'%');
	ELSE
		SELECT PL.* FROM shortlist PL,  Property WHERE PL.`ACCOMMODATION`   LIKE 	CONCAT('%',accomType,'%') AND  `PROPERTY TYPE`  LIKE 	CONCAT('%',propertyType,'%')  and PROPERTY_ID = ID and SUBURB_ID = SUBURBAN;
	end if;
	
	DROP TABLE IF EXISTS shortlist;
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Current Database: `homengine`
--

USE `homengine`;

--
-- Final view structure for view `appointment_list`
--

/*!50001 DROP VIEW IF EXISTS `appointment_list`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`com01`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `appointment_list` AS select `P`.`ADDRESS_LINE1` AS `ADDRESS LINE 1`,`S`.`SUBURB_NAME` AS `SUBURB`,`R`.`APPOINTMENT` AS `APPOINTMENT`,`U`.`FIRST_NAME` AS `FIRST NAME`,`U`.`LAST_NAME` AS `LAST NAME`,`R`.`REVIEW_ID` AS `ID` from ((((`Property` `P` join `Suburb` `S`) join `Review` `R`) join `MainstreamUser` `MU`) join `User` `U`) where ((`P`.`SUBURB_ID` = `S`.`SUBURB_ID`) and (`R`.`PROPERTY_ID` = `P`.`PROPERTY_ID`) and (`R`.`USER_ID` = `MU`.`USER_ID`) and (`U`.`USER_ID` = `MU`.`USER_ID`)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `general_public`
--

/*!50001 DROP VIEW IF EXISTS `general_public`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`com01`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `general_public` AS select `M`.`USER_ID` AS `ID`,concat(upper(substr(`U`.`FIRST_NAME`,1,1)),substr(`U`.`FIRST_NAME`,2,(length(`U`.`FIRST_NAME`) - 1))) AS `FIRST NAME`,concat(upper(substr(`U`.`LAST_NAME`,1,1)),substr(`U`.`LAST_NAME`,2,(length(`U`.`LAST_NAME`) - 1))) AS `LAST NAME`,`M`.`GENDER` AS `GENDER`,`M`.`OCCUPATION` AS `OCCUPATION`,`U`.`EMAIL` AS `EMAIL`,`U`.`PHONE` AS `PHONE`,`U`.`USERNAME` AS `USERNAME` from (`MainstreamUser` `M` join `User` `U`) where ((`U`.`USER_ID` = `M`.`USER_ID`) and (`U`.`ACTIVE` = TRUE)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `management_list`
--

/*!50001 DROP VIEW IF EXISTS `management_list`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`com01`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `management_list` AS select `M`.`USER_ID` AS `ID`,`M`.`ORGANIZATION` AS `ORGANIZATION`,`U`.`EMAIL` AS `EMAIL`,`M`.`WEBSITE` AS `WEBSITE`,`U`.`PHONE` AS `PHONE`,`M`.`FAX` AS `FAX`,`M`.`ADDRESS_LINE1` AS `ADDRESS LINE 1`,`M`.`ADDRESS_LINE2` AS `ADDRESS LINE 2`,`S`.`SUBURB_NAME` AS `SUBURB`,`U`.`USERNAME` AS `USERNAME`,`U`.`DISPLAY_IMG` AS `LOGO` from ((`Management` `M` join `Suburb` `S`) join `User` `U`) where ((`M`.`USER_ID` = `U`.`USER_ID`) and (`M`.`SUBURB_ID` = `S`.`SUBURB_ID`) and (`U`.`ACTIVE` = TRUE)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

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
/*!50013 DEFINER=`com01`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `property_list` AS select `P`.`PROPERTY_ID` AS `ID`,concat((select count(`R`.`ROOM_ID`) from (`PROPERTY_ROOM` `PR` join `Room` `R`) where ((`PR`.`ROOM_ID` = `R`.`ROOM_ID`) and (`R`.`ROOM_TYPE` = 'Bed Room') and (`PR`.`PROPERTY_ID` = `P`.`PROPERTY_ID`))),' Bedroom') AS `SETTING`,`PT`.`TYPE_DESC` AS `PROPERTY TYPE`,`P`.`ACCOMMODATION` AS `ACCOMMODATION`,`P`.`DATE_ON_MARKET` AS `ON MARKET`,`P`.`FLOOR` AS `FLOOR`,`P`.`BLOCK` AS `BLOCK`,`P`.`ADDRESS_LINE1` AS `ADDRESS LINE 1`,`P`.`ADDRESS_LINE2` AS `ADDRESS LINE 2`,`S`.`SUBURB_NAME` AS `SUBURB`,`P`.`DESCRIPTION` AS `DESCRIPTION`,`P`.`STORIES` AS `STORIES` from ((`Property` `P` join `PropertyType` `PT`) join `Suburb` `S`) where ((`P`.`TYPE_ID` = `PT`.`TYPE_ID`) and (`P`.`SUBURB_ID` = `S`.`SUBURB_ID`) and (`P`.`AVAILABLE` = TRUE)) */;
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

-- Dump completed on 2018-01-24 22:34:09
