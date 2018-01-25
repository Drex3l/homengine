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
-- Dumping data for table `Facility`
--

LOCK TABLES `Facility` WRITE;
/*!40000 ALTER TABLE `Facility` DISABLE KEYS */;
INSERT INTO `Facility` VALUES ('IA00','Washing Machine',NULL,'ACCESSORY'),('IA01','Dishwasher',NULL,'ACCESSORY'),('IA02','Baking Oven',NULL,'ACCESSORY'),('IA03','Microwave Oven',NULL,'ACCESSORY'),('IA04','Television',NULL,'ACCESSORY'),('IA05','Satelite Dish','Allows for satelite TV subscription','ACCESSORY'),('IC00','Air Conditioner',NULL,'CONVENIENCE'),('IC01','Decks and Patios',NULL,'CONVENIENCE'),('IC02','Electric Gate','Controllable remotey from indoors','CONVENIENCE'),('IC03','Internet',NULL,'CONVENIENCE'),('IC04','Programmable Lights','Toggle on/off by clap, or adjust dim','CONVENIENCE'),('IC05','Swimming Pool',NULL,'CONVENIENCE'),('IF00','Book Shelf',NULL,'FURNITURE'),('IF01','Closet',NULL,'FURNITURE'),('IF02','Coffee Table',NULL,'FURNITURE'),('IF03','Couch and Sofa',NULL,'FURNITURE'),('IF04','Wall Unit',NULL,'FURNITURE'),('IF05','Wardrobe',NULL,'FURNITURE'),('IS00','Parking','Outdoor parking space','SUNDRY'),('IS01','Security',NULL,'SUNDRY'),('IS02','Gym','Indoor parking space','SUNDRY'),('IS03','Convenience Store','Mini-Market within property building','SUNDRY');
/*!40000 ALTER TABLE `Facility` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `MainstreamUser`
--

LOCK TABLES `MainstreamUser` WRITE;
/*!40000 ALTER TABLE `MainstreamUser` DISABLE KEYS */;
INSERT INTO `MainstreamUser` VALUES ('U217T0001','M',NULL),('U217T0002','M','STUDYING');
/*!40000 ALTER TABLE `MainstreamUser` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `Management`
--

LOCK TABLES `Management` WRITE;
/*!40000 ALTER TABLE `Management` DISABLE KEYS */;
INSERT INTO `Management` VALUES ('U217N0001','ngema','23 lucerne street',NULL,116,NULL,NULL),('U217S0001','Property House','27 Sixteen Road',NULL,146,'0416358524','www.phouse.co.za'),('U217T0001','The Home Team','24 Lucerne Aenue',NULL,24,NULL,'www.hometeam.co.za'),('U217T0002','Le Place Arena','12 Eden Street','120 Cliford Street',6,'0475542651','http://www.eden.co.za');
/*!40000 ALTER TABLE `Management` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `Notification`
--

LOCK TABLES `Notification` WRITE;
/*!40000 ALTER TABLE `Notification` DISABLE KEYS */;
INSERT INTO `Notification` VALUES ('171006104250','Welcome!',0,'U217N0001','2017-10-06 22:42:50'),('171007043317','Welcome!',1,'U217T0003','2017-10-07 16:33:17'),('171007043536','Welcome!',1,'U217T0002','2017-10-07 16:35:36'),('171007044605','Welcome!',0,'U217S0001','2017-10-07 16:46:05'),('171007050148','Welcome!',0,'U217T0001','2017-10-07 17:01:48'),('171010035530','Welcome!',0,'U217L0001','2017-10-10 15:55:30');
/*!40000 ALTER TABLE `Notification` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `PROPERTY_FACILITY`
--

LOCK TABLES `PROPERTY_FACILITY` WRITE;
/*!40000 ALTER TABLE `PROPERTY_FACILITY` DISABLE KEYS */;
INSERT INTO `PROPERTY_FACILITY` VALUES (6,'IA00'),(7,'IA00'),(96,'IA00'),(99,'IA00'),(101,'IA00'),(102,'IA00'),(97,'IA01'),(3,'IA02'),(4,'IA02'),(7,'IA02'),(96,'IA02'),(101,'IA02'),(103,'IA02'),(2,'IA03'),(4,'IA03'),(5,'IA03'),(7,'IA03'),(16,'IA03'),(96,'IA03'),(101,'IA03'),(103,'IA03'),(2,'IA04'),(3,'IA04'),(4,'IA04'),(6,'IA04'),(7,'IA04'),(9,'IA04'),(16,'IA04'),(97,'IA04'),(2,'IA05'),(5,'IA05'),(7,'IA05'),(9,'IA05'),(16,'IA05'),(96,'IA05'),(97,'IA05'),(101,'IA05'),(102,'IA05'),(103,'IA05'),(3,'IC00'),(99,'IC00'),(100,'IC00'),(101,'IC00'),(9,'IC01'),(16,'IC01'),(101,'IC01'),(102,'IC01'),(103,'IC01'),(2,'IC02'),(3,'IC02'),(4,'IC02'),(7,'IC02'),(9,'IC02'),(16,'IC02'),(97,'IC02'),(100,'IC02'),(103,'IC02'),(4,'IC03'),(5,'IC03'),(6,'IC03'),(96,'IC03'),(97,'IC03'),(101,'IC03'),(102,'IC03'),(103,'IC03'),(2,'IC04'),(7,'IC04'),(96,'IC04'),(4,'IC05'),(5,'IC05'),(16,'IC05'),(2,'IF00'),(5,'IF00'),(7,'IF00'),(96,'IF00'),(100,'IF00'),(102,'IF00'),(3,'IF01'),(9,'IF01'),(16,'IF01'),(96,'IF01'),(100,'IF01'),(102,'IF01'),(103,'IF01'),(4,'IF02'),(5,'IF02'),(6,'IF02'),(16,'IF02'),(97,'IF02'),(99,'IF02'),(101,'IF02'),(103,'IF02'),(2,'IF03'),(5,'IF03'),(6,'IF03'),(7,'IF03'),(9,'IF03'),(99,'IF03'),(6,'IF04'),(9,'IF04'),(16,'IF04'),(97,'IF04'),(99,'IF04'),(103,'IF04'),(2,'IF05'),(3,'IF05'),(4,'IF05'),(7,'IF05'),(96,'IF05'),(102,'IF05'),(2,'IS00'),(4,'IS00'),(5,'IS00'),(6,'IS00'),(9,'IS00'),(96,'IS00'),(99,'IS00'),(100,'IS00'),(101,'IS00'),(102,'IS00'),(5,'IS01'),(6,'IS01'),(7,'IS01'),(16,'IS01'),(96,'IS01'),(97,'IS01'),(2,'IS02'),(3,'IS02'),(9,'IS02'),(16,'IS02'),(96,'IS02'),(100,'IS02'),(101,'IS02'),(103,'IS02'),(3,'IS03'),(6,'IS03'),(7,'IS03'),(9,'IS03'),(97,'IS03'),(99,'IS03'),(101,'IS03');
/*!40000 ALTER TABLE `PROPERTY_FACILITY` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `PROPERTY_RENTAL`
--

LOCK TABLES `PROPERTY_RENTAL` WRITE;
/*!40000 ALTER TABLE `PROPERTY_RENTAL` DISABLE KEYS */;
INSERT INTO `PROPERTY_RENTAL` VALUES (2,1),(8,1),(16,1),(3,2),(9,2),(5,3),(5,4),(6,5),(27,5),(7,6),(48,6),(96,6),(48,7),(96,7),(7,8),(96,8),(6,9),(27,9),(6,10),(5,12),(5,13),(99,15),(4,16),(100,17),(103,18),(102,19),(2,20),(4,21);
/*!40000 ALTER TABLE `PROPERTY_RENTAL` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `PROPERTY_ROOM`
--

LOCK TABLES `PROPERTY_ROOM` WRITE;
/*!40000 ALTER TABLE `PROPERTY_ROOM` DISABLE KEYS */;
INSERT INTO `PROPERTY_ROOM` VALUES (4,'R02',1,1),(4,'R05',1,2),(4,'R06',1,3),(3,'R06',1,4),(3,'R05',1,5),(3,'R01',1,6),(3,'R01',1,7),(3,'R02',1,8),(3,'R03',1,9),(4,'R03',1,10),(16,'R07',1,13),(16,'R07',1,14),(2,'R02',1,15),(5,'R02',1,16),(5,'R02',1,17),(5,'R02',1,18),(5,'R01',1,19),(5,'R06',1,20),(5,'R08',1,21),(6,'R02',1,22),(6,'R02',1,23),(6,'R05',1,24),(6,'R07',1,25),(7,'R01',1,26),(7,'R01',1,27),(7,'R01',1,28),(7,'R01',1,29),(7,'R05',1,30),(7,'R06',1,31),(100,'R07',1,35),(100,'R09',1,36),(100,'R07',1,37),(100,'R07',1,38),(100,'R07',1,39),(101,'R01',1,40),(101,'R01',1,41),(101,'R01',1,42),(99,'R06',1,43),(99,'R05',1,44),(103,'R01',1,45),(103,'R02',1,46),(103,'R06',1,47),(103,'R05',1,48),(102,'R01',1,49),(102,'R01',1,50),(2,'R06',1,52),(16,'R08',1,55),(16,'R01',1,56),(16,'R01',1,57),(16,'R02',1,58),(16,'R04',1,59),(9,'R04',1,60),(9,'R04',1,62),(9,'R02',1,63),(9,'R02',1,64),(9,'R01',1,65),(9,'R01',1,66),(9,'R01',1,67),(97,'R01',1,68),(97,'R01',1,69),(97,'R01',1,70),(97,'R01',1,71),(97,'R02',1,72),(97,'R05',1,73),(97,'R08',1,74),(97,'R02',1,75),(96,'R02',1,76),(96,'R02',1,77),(96,'R01',1,78),(96,'R05',1,79),(96,'R06',1,80);
/*!40000 ALTER TABLE `PROPERTY_ROOM` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `PrivAcc`
--

LOCK TABLES `PrivAcc` WRITE;
/*!40000 ALTER TABLE `PrivAcc` DISABLE KEYS */;
INSERT INTO `PrivAcc` VALUES ('U217T0003');
/*!40000 ALTER TABLE `PrivAcc` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `Property`
--

LOCK TABLES `Property` WRITE;
/*!40000 ALTER TABLE `Property` DISABLE KEYS */;
INSERT INTO `Property` VALUES (2,'Student','','2017-09-07 20:01:43','P03',NULL,1,'43 Gomery Avenue',NULL,61,'U217T0002',NULL,0,2),(3,'Worker','','2017-09-09 00:00:00','P01',NULL,1,'125 Willern Court','159 Victoria Embankment',43,'U217T0002',NULL,5,1),(4,'Any','','2017-09-07 20:12:57','P01',NULL,1,'52 Pink Flats','01 Blackthorn Avenue',69,'U217T0002',NULL,0,1),(5,'Student','','2017-09-07 20:35:13','P01',NULL,1,'26 Vicent Street',NULL,71,'U217T0001',NULL,0,1),(6,'Any','','2017-07-18 00:00:00','P01',NULL,1,'18 Vicent Street',NULL,71,'U217T0001',NULL,0,1),(7,'Student','','2017-09-07 20:37:22','P01',NULL,1,'26 Jacobs PL',NULL,71,'U217T0001',NULL,0,1),(9,'Worker','','2000-01-01 00:00:00','P03',12,1,'12 Pink Flats',NULL,3,'U217T0001',NULL,1,1),(16,'Any','','2000-01-01 00:00:00','P03',4,1,'14 Black Threads','55 Ngubane Drive',17,'U217T0001','B4',4,1),(27,'Student','','2000-01-01 00:00:00','P03',10,1,'25 Russel Road',NULL,72,'U217M0001',NULL,1,1),(48,'Student','','2000-01-01 00:00:00','P01',11,1,'14 Lions Denn','28 Russel Road',19,'U217M0001',NULL,1,1),(96,'Other','','2000-01-01 00:00:00','P03',3,1,'1 Blackthorne Avenue',NULL,228,'U217T0001','B1',2,1),(97,'Nursing','Old Age Home','2017-10-12 10:00:18','P01',NULL,1,'45 Saire Home','89 Sig Street',26,'U217T0001','B1',6,1),(99,'Worker','Offices To Let','2017-04-04 00:00:00','P02',NULL,1,'192 Bigern Road',NULL,152,'U217T0002',NULL,NULL,1),(100,'Other','Storage Warehouse','2017-10-12 12:22:42','P02',NULL,1,'26 Justin Lane',NULL,4,'U217T0002',NULL,NULL,2),(101,'Nursing','Care Center','2017-10-12 12:26:36','P03',NULL,1,'35 Dinaly',NULL,109,'U217T0002',NULL,NULL,1),(102,'Any','','2017-10-12 12:36:02','P03',NULL,1,'36 Drekens Drive',NULL,112,'U217T0002',NULL,NULL,1),(103,'Worker','','2017-04-29 00:00:00','P03',NULL,1,'69 Foundry Lane',NULL,5,'U217T0002',NULL,NULL,2);
/*!40000 ALTER TABLE `Property` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `PropertyIMG`
--

LOCK TABLES `PropertyIMG` WRITE;
/*!40000 ALTER TABLE `PropertyIMG` DISABLE KEYS */;
/*!40000 ALTER TABLE `PropertyIMG` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `PropertyType`
--

LOCK TABLES `PropertyType` WRITE;
/*!40000 ALTER TABLE `PropertyType` DISABLE KEYS */;
INSERT INTO `PropertyType` VALUES ('P01','Apartment'),('P02','Commercial'),('P03','House'),('P04','Room');
/*!40000 ALTER TABLE `PropertyType` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `Rental`
--

LOCK TABLES `Rental` WRITE;
/*!40000 ALTER TABLE `Rental` DISABLE KEYS */;
/*!40000 ALTER TABLE `Rental` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `Review`
--

LOCK TABLES `Review` WRITE;
/*!40000 ALTER TABLE `Review` DISABLE KEYS */;
/*!40000 ALTER TABLE `Review` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `Room`
--

LOCK TABLES `Room` WRITE;
/*!40000 ALTER TABLE `Room` DISABLE KEYS */;
INSERT INTO `Room` VALUES ('R01','Bed Room','Single'),('R02','Bed Room','Sharing'),('R03','Bath Room','Shower'),('R04','Bath Room','Bathtub'),('R05','Kitchen',''),('R06','Lounge',''),('R07','Storage',''),('R08','Libary',''),('R09','Bar','');
/*!40000 ALTER TABLE `Room` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `Suburb`
--

LOCK TABLES `Suburb` WRITE;
/*!40000 ALTER TABLE `Suburb` DISABLE KEYS */;
INSERT INTO `Suburb` VALUES (0,'-- suburb --',NULL),(1,'Adcock Playing Fields','6001'),(2,'Adcock Vale','6001'),(3,'Algoa Park','6001'),(4,'Baakens Valley','6001'),(5,'Beachview','6001'),(6,'Blue Horizon Bay','6001'),(7,'Brakkefontein','6001'),(8,'Brakwater Flats','6001'),(9,'Brighton Beach','6001'),(10,'Brookes Hill','6001'),(11,'Chelsea','6001'),(12,'Cradock Place','6001'),(13,'Craigbain','6001'),(14,'Crockarts Hope','6001'),(15,'De Stades','6001'),(16,'Deal Party','6001'),(17,'Deer Park','6001'),(18,'Denholme','6001'),(19,'Dodds A H','6001'),(20,'Draaifontein','6001'),(21,'Eastbourne','6001'),(22,'Ferguson','6001'),(23,'Ferguson Township','6001'),(24,'Forest Hill','6001'),(25,'Gedults River','6001'),(26,'Glendinningvale','6001'),(27,'Hallack','6001'),(28,'Holland Park','6001'),(29,'Humerail','6001'),(30,'Humewood','6001'),(31,'Jutland','6001'),(32,'Kempston','6001'),(33,'Kensington','6001'),(34,'Kini Bay','6001'),(35,'Kwamagxaki','6001'),(36,'Linkside','6001'),(37,'Maitlands','6001'),(38,'Marais','6001'),(39,'Marais Township','6001'),(40,'Mill Park','6001'),(41,'Millard Grange','6001'),(42,'Mount Croix','6001'),(43,'Mount Rd','6001'),(44,'Newmarket','6001'),(45,'North End','6001'),(46,'North End Lake','6001'),(47,'Parkridge','6001'),(48,'Parsons Hill','6001'),(49,'Perridgevale','6001'),(50,'Pinelands','6001'),(51,'Port Elizabeth','6001'),(52,'Richmond Park','6001'),(53,'Rietkuil','6001'),(54,'Seaview','6001'),(55,'Sidwell','6001'),(56,'South End','6001'),(57,'St Georges Park','6001'),(58,'St Georges Strand','6001'),(59,'Steytler','6001'),(60,'Struandale','6001'),(61,'Summerstrand','6001'),(62,'Sundays River','6001'),(63,'Sydenham','6001'),(64,'Sydenham Hill','6001'),(65,'Van Stadens','6001'),(66,'Veeplaas','6001'),(67,'Victoria Park','6001'),(68,'Wells Estate','6001'),(69,'Willows','6001'),(70,'Young Park','6001'),(71,'Zwide','6001'),(72,'Port Elizabeth Central','6001'),(73,'Barris','6001'),(74,'Lady Slipper','6001'),(75,'Centrahil','6006'),(76,'Hunters Retreat','6017'),(77,'Colleen Glen','6018'),(78,'Gelvandale & Ext','6020'),(79,'Gelvan Park','6020'),(80,'Gelvandale','6020'),(81,'Helenvale','6020'),(82,'Korsten','6020'),(83,'Malabar','6020'),(84,'Missionvale','6020'),(85,'Neave','6020'),(86,'Parkside','6020'),(87,'Schauderville','6020'),(88,'Springdale','6020'),(89,'Westlands','6020'),(90,'Kwaford','6200'),(91,'New Brighton','6200'),(92,'Kwadwesi','6201'),(93,'Kwazakhele','6205'),(94,'Swartkops Valley','6210'),(95,'Bluewater Bay','6210'),(96,'Markman','6210'),(97,'Swartkops','6210'),(98,'Amsterdamhoek','6210'),(99,'Motherwell Nu 2','6211'),(100,'Motherwell','6211'),(101,'Motherwell Nu 3','6211'),(102,'Motherwell Nu 5','6211'),(103,'Motherwell Nu 6','6211'),(104,'Motherwell Nu 7','6211'),(105,'Redhouse','6215'),(106,'Kabega','6250'),(107,'St Albans','6385'),(108,'Greenbushes','6390'),(109,'Ben Kamma','6025'),(110,'Ben Kamma & Ext','6025'),(111,'Bramhope','6025'),(112,'Brentwood Park','6025'),(113,'Bridgemeade','6025'),(114,'Brymore','6025'),(115,'Francis Evatt Park','6025'),(116,'Glenroy Park','6025'),(117,'Kabega Park','6025'),(118,'Kamma Ridge','6025'),(119,'Kunene Park','6025'),(120,'Linton Grange','6025'),(121,'Morningside','6025'),(122,'Parsonsvlei','6025'),(123,'Rowallan Park','6025'),(124,'Sherwood','6025'),(125,'Taybank','6025'),(126,'Treehaven','6025'),(127,'Tulbagh','6025'),(128,'Van Der Stel','6025'),(129,'Vergelegen','6025'),(130,'Vikingvale','6025'),(131,'Westering','6025'),(132,'Western Hills','6025'),(133,'Willow Glen','6025'),(134,'Wonderview','6025'),(135,'Cotswold','6045'),(136,'Fernglen','6045'),(137,'Framesby','6045'),(138,'Glen Hurd','6045'),(139,'Greenacres','6045'),(140,'Newton Park','6045'),(141,'Sunridge Park','6045'),(142,'Westview','6045'),(143,'Adcock Vale & Ext','6045'),(144,'Cotswold & Ext','6045'),(145,'Bethelsdorp Ext 18','6059'),(146,'Bethelsdorp Ext 20','6059'),(147,'Booysens Park','6059'),(148,'Heath Park','6059'),(149,'Arcadia','6059'),(150,'Aspen Heights','6059'),(151,'Bethelsdorp','6059'),(152,'Bethelsdorp & Ext','6059'),(153,'Bethelsdorp Ext 27','6059'),(154,'Bethelsdorp Ext 30','6059'),(155,'Bloemendal','6059'),(156,'Boknes','6059'),(157,'Chatty','6059'),(158,'Cleary Estate','6059'),(159,'Hillside','6059'),(160,'Palm Ridge','6059'),(161,'Salsoneville','6059'),(162,'Salt Lake','6059'),(163,'Sanctor','6059'),(164,'West End','6059'),(165,'Windvogel','6059'),(166,'Bethelsdorp Ext 34','6059'),(167,'Bethelsdorp Ext 32','6059'),(168,'Beverley Grove','6070'),(169,'Broadwood','6070'),(170,'Charlo','6070'),(171,'Charlo & Ext','6070'),(172,'Essexvale','6070'),(173,'Fairview','6070'),(174,'Fairview Subdivided Estate','6070'),(175,'Goldwater','6070'),(176,'Greenshields Park','6070'),(177,'Kamma Park','6070'),(178,'Kraggakamma Park','6070'),(179,'Lorraine','6070'),(180,'Lorraine Manor','6070'),(181,'Lovemore Heights','6070'),(182,'Lovemore Park','6070'),(183,'Mangold Park','6070'),(184,'Miramar','6070'),(185,'Mount Pleasant','6070'),(186,'Pari Park','6070'),(187,'Providentia','6070'),(188,'Richmond Hill','6070'),(189,'Salisbury Park','6070'),(190,'Schoenmakerskop','6070'),(191,'Springfield','6070'),(192,'Theescombe','6070'),(193,'Walmer','6070'),(194,'Walmer Downs','6070'),(195,'Walmer Heights','6070'),(196,'Weybridge Park','6070'),(197,'Woodlands','6070'),(198,'Overbaakens','6070'),(199,'Kamma Heights','6070'),(200,'Adcockvale','6001'),(201,'Kama Park','6001'),(202,'Mount Road Township','6001'),(203,'Framesby Ext','6045'),(204,'Framesby Gardens','6045'),(205,'Framesby North','6045'),(206,'Sardinia Bay','6001'),(207,'Lovemore Heights Estate','6070'),(208,'Kamma Creek','6070'),(209,'Kragga Kamma','6001'),(210,'Nanaga','6001'),(211,'Murray Park','6000'),(212,'Parsons Ridge','6001'),(213,'Winchester Gardens','6001'),(214,'Witteklip','6001'),(215,'Coega','6100'),(216,'Little Chelsea','6001'),(217,'Wedgewood Golf Estate','6390'),(218,'Motherwell Nu 1','6211'),(219,'Motherwell Nu 4','6211'),(220,'Motherwell Nu 9','6211'),(221,'Motherwell Nu 10','6211'),(222,'Motherwell Nu 8','6211'),(223,'Perseverance Industrial','6220'),(224,'Westbrook','6025'),(225,'Crossways Farm Village','6375'),(226,'Motherwell NU 11','6211'),(227,'Motherwell NU 12','6211'),(228,'Humewood Extension','6001');
/*!40000 ALTER TABLE `Suburb` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `User`
--

LOCK TABLES `User` WRITE;
/*!40000 ALTER TABLE `User` DISABLE KEYS */;
INSERT INTO `User` VALUES ('U217L0001','likhaka','$2a$10$E2qYqps0i6gGO4tFoDDjPOy6QBNjQ6iPrCTXZ.wePiFheUySEmFBa','s215116747@nmmu.ac.za',NULL,NULL,-1,NULL,NULL),('U217N0001','ngematbb','$2a$10$wS2ubGAvtmLXqh04.jGJAuPpEsfmx8dx7/uMBA2HhDiTfP4b5nzue','ngematbb@gmail.com',NULL,NULL,-1,NULL,NULL),('U217S0001','sameones','$2a$10$S3aFLulTpyJ/qFrpFN/n6uraJdp.O5ebT5z6bZ5/ex7aS2FNOVpp.','s215013395@nmmu.ac.za','U217S0001.jpg',NULL,1,NULL,NULL),('U217T0001','teamhome','$2a$10$WjrKCs75u4uB7S4cTQqzAejn..XqpSi0OgQLMkNAafEhuh7UWtpZm','super@themail.co.za','U217T0001.jpg','0760326578',1,'Vito','Corleon'),('U217T0002','theguys','$2a$10$q2uNgGm1.mWwo4G8/n5rouoNEn/I7.dWXe.4HU9FTC55.k5py1DgS','peculiar@exclusivemail.co.za','U217T0002.svg','0737083731',1,'Jin',NULL),('U217T0003','theseones','$2a$10$FZotYl./eALc7smgmnmISOuEXWMhcz9jYmhq0Lcb0a9qjvQ5Hy6kq','business52@live.com','U217T0003.png',NULL,1,'Wezndla','Zwane'),('U217T0004','theseguys','$2a$10$SHZm9gMPL75eEfmtLyJ/auP7HFZFBul4wIpFDlLf4xOSuMT8q53na','s215177770@nmmu.ac.za',NULL,NULL,-1,NULL,NULL);
/*!40000 ALTER TABLE `User` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-01-25  0:20:15
