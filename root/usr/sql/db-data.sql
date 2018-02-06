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
-- Dumping data for table `admin`
--

LOCK TABLES `admin` WRITE;
/*!40000 ALTER TABLE `admin` DISABLE KEYS */;
INSERT INTO `admin` VALUES ('U217N0001','ngema','23 lucerne street',NULL,116,NULL,NULL),('U217S0001','Property House','27 Sixteen Road',NULL,146,'0416358524','www.phouse.co.za'),('U217T0001','The Home Team','24 Lucerne Aenue',NULL,24,NULL,'www.hometeam.co.za'),('U217T0002','Le Place Arena','12 Eden Street','120 Cliford Street',6,'0475542651','http://www.eden.co.za');
/*!40000 ALTER TABLE `admin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `bedroom`
--

LOCK TABLES `bedroom` WRITE;
/*!40000 ALTER TABLE `bedroom` DISABLE KEYS */;
INSERT INTO `bedroom` VALUES (2,'M',NULL,NULL,NULL,'Bedroom','Single'),(4,NULL,NULL,NULL,NULL,'Bedroom','Sharing'),(5,'F',NULL,NULL,NULL,'Bedroom','Sharing'),(7,'M',NULL,NULL,NULL,'Bedroom','Sharing'),(16,NULL,NULL,NULL,NULL,'Bedroom','Single'),(96,NULL,NULL,NULL,NULL,'Bedroom','Sharing'),(97,NULL,NULL,NULL,NULL,'Bedroom','Sharing'),(100,NULL,NULL,NULL,NULL,'Bedroom','Single'),(101,NULL,NULL,NULL,NULL,'Bedroom','Sharing'),(102,NULL,NULL,NULL,NULL,'Bedroom','Single');
/*!40000 ALTER TABLE `bedroom` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `bedroom_type`
--

LOCK TABLES `bedroom_type` WRITE;
/*!40000 ALTER TABLE `bedroom_type` DISABLE KEYS */;
INSERT INTO `bedroom_type` VALUES ('Sharing'),('Single');
/*!40000 ALTER TABLE `bedroom_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `building`
--

LOCK TABLES `building` WRITE;
/*!40000 ALTER TABLE `building` DISABLE KEYS */;
INSERT INTO `building` VALUES (3,1,'Apartment','Building',1,1),(6,1,'Apartment','Building',0,1),(9,1,'Apartment','Building',1,1),(99,1,'House','Building',5,2),(103,2,'House','Building',6,3);
/*!40000 ALTER TABLE `building` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `building_type`
--

LOCK TABLES `building_type` WRITE;
/*!40000 ALTER TABLE `building_type` DISABLE KEYS */;
INSERT INTO `building_type` VALUES ('Apartment'),('House');
/*!40000 ALTER TABLE `building_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `client`
--

LOCK TABLES `client` WRITE;
/*!40000 ALTER TABLE `client` DISABLE KEYS */;
INSERT INTO `client` VALUES ('U217T0001','M',NULL),('U217T0002','M','STUDYING');
/*!40000 ALTER TABLE `client` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `feature`
--

LOCK TABLES `feature` WRITE;
/*!40000 ALTER TABLE `feature` DISABLE KEYS */;
INSERT INTO `feature` VALUES ('IA00','Washing Machine',NULL,'ACCESSORY'),('IA01','Dishwasher',NULL,'ACCESSORY'),('IA02','Baking Oven',NULL,'ACCESSORY'),('IA03','Microwave Oven',NULL,'ACCESSORY'),('IA04','Television',NULL,'ACCESSORY'),('IA05','Satelite Dish','Allows for satelite TV subscription','ACCESSORY'),('IC00','Air Conditioner',NULL,'CONVENIENCE'),('IC01','Decks and Patios',NULL,'CONVENIENCE'),('IC02','Electric Gate','Controllable remotey from indoors','CONVENIENCE'),('IC03','Internet',NULL,'CONVENIENCE'),('IC04','Programmable Lights','Toggle on/off by clap, or adjust dim','CONVENIENCE'),('IC05','Swimming Pool',NULL,'CONVENIENCE'),('IF00','Book Shelf',NULL,'FURNITURE'),('IF01','Closet',NULL,'FURNITURE'),('IF02','Coffee Table',NULL,'FURNITURE'),('IF03','Couch and Sofa',NULL,'FURNITURE'),('IF04','Wall Unit',NULL,'FURNITURE'),('IF05','Wardrobe',NULL,'FURNITURE'),('IS00','Parking','Outdoor parking space','SUNDRY'),('IS01','Security',NULL,'SUNDRY'),('IS02','Gym','Indoor parking space','SUNDRY'),('IS03','Convenience Store','Mini-Market within property building','SUNDRY'),('IS04','Bathtub','Might not necessarily be in the bathroom','SUNDRY'),('IS05','Shower','Might not necessarily be in the bathroom','SUNDRY');
/*!40000 ALTER TABLE `feature` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `property`
--

LOCK TABLES `property` WRITE;
/*!40000 ALTER TABLE `property` DISABLE KEYS */;
INSERT INTO `property` VALUES (2,'43 Gomery Avenue',NULL,61,'U217T0002',1,NULL,'Student','2018-01-01 00:00:00','Bedroom',NULL),(3,'125 Willern Court','159 Victoria Embankment',43,'U217T0002',1,NULL,'Worker','2017-09-09 00:00:00','Building',NULL),(4,'52 Pink Flats','01 Blackthorn Avenue',69,'U217T0002',1,NULL,'Any','2017-09-07 20:12:57','Bedroom',NULL),(5,'26 Vicent Street',NULL,71,'U217T0001',1,NULL,'Student','2017-09-07 20:35:13','Bedroom',NULL),(6,'18 Vicent Street',NULL,71,'U217T0001',1,NULL,'Any','2017-07-18 00:00:00','Building',NULL),(7,'26 Jacobs PL',NULL,71,'U217T0001',1,NULL,'Student','2017-09-07 20:37:22','Bedroom',NULL),(9,'12 Pink Flats',NULL,3,'U217T0001',1,NULL,'Worker','2000-01-01 00:00:00','Building',NULL),(16,'14 Black Threads','55 Ngubane Drive',17,'U217T0001',1,NULL,'Any','2000-01-01 00:00:00','Bedroom',NULL),(96,'1 Blackthorne Avenue',NULL,228,'U217T0001',1,NULL,'Other','2000-01-01 00:00:00','Bedroom',NULL),(97,'45 Saire Home','89 Sig Street',26,'U217T0001',1,NULL,'Nursing','2017-10-12 10:00:18','Bedroom',NULL),(99,'192 Bigern Road',NULL,152,'U217T0002',1,NULL,'Worker','2017-04-04 00:00:00','Building',NULL),(100,'26 Justin Lane',NULL,4,'U217T0002',1,NULL,'Other','2017-10-12 12:22:42','Bedroom',NULL),(101,'35 Dinaly',NULL,109,'U217T0002',1,NULL,'Nursing','2017-10-12 12:26:36','Bedroom',NULL),(102,'36 Drekens Drive',NULL,112,'U217T0002',1,NULL,'Any','2017-10-12 12:36:02','Bedroom',NULL),(103,'69 Foundry Lane',NULL,5,'U217T0002',1,NULL,'Worker','2017-04-29 00:00:00','Building',NULL);
/*!40000 ALTER TABLE `property` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `property_feature`
--

LOCK TABLES `property_feature` WRITE;
/*!40000 ALTER TABLE `property_feature` DISABLE KEYS */;
INSERT INTO `property_feature` VALUES (6,'IA00'),(7,'IA00'),(96,'IA00'),(99,'IA00'),(101,'IA00'),(102,'IA00'),(97,'IA01'),(3,'IA02'),(4,'IA02'),(7,'IA02'),(96,'IA02'),(101,'IA02'),(103,'IA02'),(2,'IA03'),(4,'IA03'),(5,'IA03'),(7,'IA03'),(16,'IA03'),(96,'IA03'),(101,'IA03'),(103,'IA03'),(2,'IA04'),(3,'IA04'),(4,'IA04'),(6,'IA04'),(7,'IA04'),(9,'IA04'),(16,'IA04'),(97,'IA04'),(2,'IA05'),(5,'IA05'),(7,'IA05'),(9,'IA05'),(16,'IA05'),(96,'IA05'),(97,'IA05'),(101,'IA05'),(102,'IA05'),(103,'IA05'),(3,'IC00'),(99,'IC00'),(100,'IC00'),(101,'IC00'),(9,'IC01'),(16,'IC01'),(101,'IC01'),(102,'IC01'),(103,'IC01'),(2,'IC02'),(3,'IC02'),(4,'IC02'),(7,'IC02'),(9,'IC02'),(16,'IC02'),(97,'IC02'),(100,'IC02'),(103,'IC02'),(4,'IC03'),(5,'IC03'),(6,'IC03'),(96,'IC03'),(97,'IC03'),(101,'IC03'),(102,'IC03'),(103,'IC03'),(2,'IC04'),(7,'IC04'),(96,'IC04'),(4,'IC05'),(5,'IC05'),(16,'IC05'),(2,'IF00'),(5,'IF00'),(7,'IF00'),(96,'IF00'),(100,'IF00'),(102,'IF00'),(3,'IF01'),(9,'IF01'),(16,'IF01'),(96,'IF01'),(100,'IF01'),(102,'IF01'),(103,'IF01'),(4,'IF02'),(5,'IF02'),(6,'IF02'),(16,'IF02'),(97,'IF02'),(99,'IF02'),(101,'IF02'),(103,'IF02'),(2,'IF03'),(5,'IF03'),(6,'IF03'),(7,'IF03'),(9,'IF03'),(99,'IF03'),(6,'IF04'),(9,'IF04'),(16,'IF04'),(97,'IF04'),(99,'IF04'),(103,'IF04'),(2,'IF05'),(3,'IF05'),(4,'IF05'),(7,'IF05'),(96,'IF05'),(102,'IF05'),(2,'IS00'),(4,'IS00'),(5,'IS00'),(6,'IS00'),(9,'IS00'),(96,'IS00'),(99,'IS00'),(100,'IS00'),(101,'IS00'),(102,'IS00'),(5,'IS01'),(6,'IS01'),(7,'IS01'),(16,'IS01'),(96,'IS01'),(97,'IS01'),(2,'IS02'),(3,'IS02'),(9,'IS02'),(16,'IS02'),(96,'IS02'),(100,'IS02'),(101,'IS02'),(103,'IS02'),(3,'IS03'),(6,'IS03'),(7,'IS03'),(9,'IS03'),(97,'IS03'),(99,'IS03'),(101,'IS03');
/*!40000 ALTER TABLE `property_feature` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `property_img`
--

LOCK TABLES `property_img` WRITE;
/*!40000 ALTER TABLE `property_img` DISABLE KEYS */;
INSERT INTO `property_img` VALUES (1,2,'Open view','239338.jpg','Lounge','A'),(2,2,NULL,'904191.jpg','Outdoor','B'),(6,3,NULL,'728040.jpg','House View','A'),(7,3,NULL,'337083.jpg','Bedroom','B'),(8,4,NULL,'539297.jpg','Chillplace','A'),(9,99,NULL,'948824.jpg','Dinning Room','A'),(10,100,NULL,'640264.jpg','Lounge','A'),(11,101,NULL,'156108.jpg','Bedroom','A'),(12,103,NULL,'674254.jpg','Swimming Pool','A'),(13,102,'Open View','272285.jpg','Bedroom','A'),(14,5,'With garden','655311.jpg','Swimming Pool','A'),(15,6,'View to the lounge','60894.jpg','Kitchen','A'),(16,7,'On the Roof','211611.jpg','Lounge','A'),(17,9,'On the roof','844646.jpg','Bedroom','A'),(18,16,NULL,'58551.jpg','Laundry','A'),(19,96,NULL,'263318.jpg','Lounge','A'),(20,97,'Entrance/Exit','202300.jpg','Lounge','A'),(21,97,NULL,'276444.jpg','Kitchen','B'),(22,97,'With garden','703489.jpg','Chillplace','C'),(23,96,NULL,'392790.jpg','Outdoor','B'),(24,2,NULL,'784490.jpg','House View','C');
/*!40000 ALTER TABLE `property_img` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `property_room`
--

LOCK TABLES `property_room` WRITE;
/*!40000 ALTER TABLE `property_room` DISABLE KEYS */;
INSERT INTO `property_room` VALUES (2,'R05',1),(2,'R06',1),(3,'R05',1),(3,'R06',1),(4,'R05',1),(4,'R06',1),(5,'R06',1),(5,'R08',1),(6,'R05',1),(6,'R07',1),(7,'R05',1),(7,'R06',1),(16,'R07',1),(16,'R08',1),(96,'R05',1),(96,'R06',1),(97,'R05',1),(97,'R08',1),(99,'R05',1),(99,'R06',1),(100,'R07',1),(100,'R09',1),(103,'R05',1),(103,'R06',1);
/*!40000 ALTER TABLE `property_room` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `property_type`
--

LOCK TABLES `property_type` WRITE;
/*!40000 ALTER TABLE `property_type` DISABLE KEYS */;
INSERT INTO `property_type` VALUES ('Bedroom','Bedroom Unit'),('Building','Housing Unit'),('Yard','Whole Yard');
/*!40000 ALTER TABLE `property_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `rental`
--

LOCK TABLES `rental` WRITE;
/*!40000 ALTER TABLE `rental` DISABLE KEYS */;
INSERT INTO `rental` VALUES (3,2800.00,1,2800.00,10,2),(4,6000.00,1,6000.00,2,3),(5,1500.00,1,1500.00,6,4),(6,1500.00,1,1500.00,10,5),(7,3500.00,1,3500.00,6,6),(8,1200.00,1,1200.00,10,7),(9,4500.00,1,4500.00,12,9),(10,2400.00,1,2400.00,10,16),(11,800.00,1,800.00,1,96),(12,3800.00,1,6200.00,12,97),(13,5000.00,1,5500.00,12,99),(14,600.00,1,650.00,3,100),(15,3000.00,1,3600.00,12,101),(16,2400.00,1,2400.00,3,102),(17,3200.00,1,3200.00,3,103);
/*!40000 ALTER TABLE `rental` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `review`
--

LOCK TABLES `review` WRITE;
/*!40000 ALTER TABLE `review` DISABLE KEYS */;
/*!40000 ALTER TABLE `review` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `room`
--

LOCK TABLES `room` WRITE;
/*!40000 ALTER TABLE `room` DISABLE KEYS */;
INSERT INTO `room` VALUES ('R05','Kitchen',''),('R06','Lounge',''),('R07','Storage',''),('R08','Libary',''),('R09','Bar','');
/*!40000 ALTER TABLE `room` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `suburb`
--

LOCK TABLES `suburb` WRITE;
/*!40000 ALTER TABLE `suburb` DISABLE KEYS */;
INSERT INTO `suburb` VALUES (0,'-- suburb --',NULL),(1,'Adcock Playing Fields','6001'),(2,'Adcock Vale','6001'),(3,'Algoa Park','6001'),(4,'Baakens Valley','6001'),(5,'Beachview','6001'),(6,'Blue Horizon Bay','6001'),(7,'Brakkefontein','6001'),(8,'Brakwater Flats','6001'),(9,'Brighton Beach','6001'),(10,'Brookes Hill','6001'),(11,'Chelsea','6001'),(12,'Cradock Place','6001'),(13,'Craigbain','6001'),(14,'Crockarts Hope','6001'),(15,'De Stades','6001'),(16,'Deal Party','6001'),(17,'Deer Park','6001'),(18,'Denholme','6001'),(19,'Dodds A H','6001'),(20,'Draaifontein','6001'),(21,'Eastbourne','6001'),(22,'Ferguson','6001'),(23,'Ferguson Township','6001'),(24,'Forest Hill','6001'),(25,'Gedults River','6001'),(26,'Glendinningvale','6001'),(27,'Hallack','6001'),(28,'Holland Park','6001'),(29,'Humerail','6001'),(30,'Humewood','6001'),(31,'Jutland','6001'),(32,'Kempston','6001'),(33,'Kensington','6001'),(34,'Kini Bay','6001'),(35,'Kwamagxaki','6001'),(36,'Linkside','6001'),(37,'Maitlands','6001'),(38,'Marais','6001'),(39,'Marais Township','6001'),(40,'Mill Park','6001'),(41,'Millard Grange','6001'),(42,'Mount Croix','6001'),(43,'Mount Rd','6001'),(44,'Newmarket','6001'),(45,'North End','6001'),(46,'North End Lake','6001'),(47,'Parkridge','6001'),(48,'Parsons Hill','6001'),(49,'Perridgevale','6001'),(50,'Pinelands','6001'),(51,'Port Elizabeth','6001'),(52,'Richmond Park','6001'),(53,'Rietkuil','6001'),(54,'Seaview','6001'),(55,'Sidwell','6001'),(56,'South End','6001'),(57,'St Georges Park','6001'),(58,'St Georges Strand','6001'),(59,'Steytler','6001'),(60,'Struandale','6001'),(61,'Summerstrand','6001'),(62,'Sundays River','6001'),(63,'Sydenham','6001'),(64,'Sydenham Hill','6001'),(65,'Van Stadens','6001'),(66,'Veeplaas','6001'),(67,'Victoria Park','6001'),(68,'Wells Estate','6001'),(69,'Willows','6001'),(70,'Young Park','6001'),(71,'Zwide','6001'),(72,'Port Elizabeth Central','6001'),(73,'Barris','6001'),(74,'Lady Slipper','6001'),(75,'Centrahil','6006'),(76,'Hunters Retreat','6017'),(77,'Colleen Glen','6018'),(78,'Gelvandale & Ext','6020'),(79,'Gelvan Park','6020'),(80,'Gelvandale','6020'),(81,'Helenvale','6020'),(82,'Korsten','6020'),(83,'Malabar','6020'),(84,'Missionvale','6020'),(85,'Neave','6020'),(86,'Parkside','6020'),(87,'Schauderville','6020'),(88,'Springdale','6020'),(89,'Westlands','6020'),(90,'Kwaford','6200'),(91,'New Brighton','6200'),(92,'Kwadwesi','6201'),(93,'Kwazakhele','6205'),(94,'Swartkops Valley','6210'),(95,'Bluewater Bay','6210'),(96,'Markman','6210'),(97,'Swartkops','6210'),(98,'Amsterdamhoek','6210'),(99,'Motherwell Nu 2','6211'),(100,'Motherwell','6211'),(101,'Motherwell Nu 3','6211'),(102,'Motherwell Nu 5','6211'),(103,'Motherwell Nu 6','6211'),(104,'Motherwell Nu 7','6211'),(105,'Redhouse','6215'),(106,'Kabega','6250'),(107,'St Albans','6385'),(108,'Greenbushes','6390'),(109,'Ben Kamma','6025'),(110,'Ben Kamma & Ext','6025'),(111,'Bramhope','6025'),(112,'Brentwood Park','6025'),(113,'Bridgemeade','6025'),(114,'Brymore','6025'),(115,'Francis Evatt Park','6025'),(116,'Glenroy Park','6025'),(117,'Kabega Park','6025'),(118,'Kamma Ridge','6025'),(119,'Kunene Park','6025'),(120,'Linton Grange','6025'),(121,'Morningside','6025'),(122,'Parsonsvlei','6025'),(123,'Rowallan Park','6025'),(124,'Sherwood','6025'),(125,'Taybank','6025'),(126,'Treehaven','6025'),(127,'Tulbagh','6025'),(128,'Van Der Stel','6025'),(129,'Vergelegen','6025'),(130,'Vikingvale','6025'),(131,'Westering','6025'),(132,'Western Hills','6025'),(133,'Willow Glen','6025'),(134,'Wonderview','6025'),(135,'Cotswold','6045'),(136,'Fernglen','6045'),(137,'Framesby','6045'),(138,'Glen Hurd','6045'),(139,'Greenacres','6045'),(140,'Newton Park','6045'),(141,'Sunridge Park','6045'),(142,'Westview','6045'),(143,'Adcock Vale & Ext','6045'),(144,'Cotswold & Ext','6045'),(145,'Bethelsdorp Ext 18','6059'),(146,'Bethelsdorp Ext 20','6059'),(147,'Booysens Park','6059'),(148,'Heath Park','6059'),(149,'Arcadia','6059'),(150,'Aspen Heights','6059'),(151,'Bethelsdorp','6059'),(152,'Bethelsdorp & Ext','6059'),(153,'Bethelsdorp Ext 27','6059'),(154,'Bethelsdorp Ext 30','6059'),(155,'Bloemendal','6059'),(156,'Boknes','6059'),(157,'Chatty','6059'),(158,'Cleary Estate','6059'),(159,'Hillside','6059'),(160,'Palm Ridge','6059'),(161,'Salsoneville','6059'),(162,'Salt Lake','6059'),(163,'Sanctor','6059'),(164,'West End','6059'),(165,'Windvogel','6059'),(166,'Bethelsdorp Ext 34','6059'),(167,'Bethelsdorp Ext 32','6059'),(168,'Beverley Grove','6070'),(169,'Broadwood','6070'),(170,'Charlo','6070'),(171,'Charlo & Ext','6070'),(172,'Essexvale','6070'),(173,'Fairview','6070'),(174,'Fairview Subdivided Estate','6070'),(175,'Goldwater','6070'),(176,'Greenshields Park','6070'),(177,'Kamma Park','6070'),(178,'Kraggakamma Park','6070'),(179,'Lorraine','6070'),(180,'Lorraine Manor','6070'),(181,'Lovemore Heights','6070'),(182,'Lovemore Park','6070'),(183,'Mangold Park','6070'),(184,'Miramar','6070'),(185,'Mount Pleasant','6070'),(186,'Pari Park','6070'),(187,'Providentia','6070'),(188,'Richmond Hill','6070'),(189,'Salisbury Park','6070'),(190,'Schoenmakerskop','6070'),(191,'Springfield','6070'),(192,'Theescombe','6070'),(193,'Walmer','6070'),(194,'Walmer Downs','6070'),(195,'Walmer Heights','6070'),(196,'Weybridge Park','6070'),(197,'Woodlands','6070'),(198,'Overbaakens','6070'),(199,'Kamma Heights','6070'),(200,'Adcockvale','6001'),(201,'Kama Park','6001'),(202,'Mount Road Township','6001'),(203,'Framesby Ext','6045'),(204,'Framesby Gardens','6045'),(205,'Framesby North','6045'),(206,'Sardinia Bay','6001'),(207,'Lovemore Heights Estate','6070'),(208,'Kamma Creek','6070'),(209,'Kragga Kamma','6001'),(210,'Nanaga','6001'),(211,'Murray Park','6000'),(212,'Parsons Ridge','6001'),(213,'Winchester Gardens','6001'),(214,'Witteklip','6001'),(215,'Coega','6100'),(216,'Little Chelsea','6001'),(217,'Wedgewood Golf Estate','6390'),(218,'Motherwell Nu 1','6211'),(219,'Motherwell Nu 4','6211'),(220,'Motherwell Nu 9','6211'),(221,'Motherwell Nu 10','6211'),(222,'Motherwell Nu 8','6211'),(223,'Perseverance Industrial','6220'),(224,'Westbrook','6025'),(225,'Crossways Farm Village','6375'),(226,'Motherwell NU 11','6211'),(227,'Motherwell NU 12','6211'),(228,'Humewood Extension','6001');
/*!40000 ALTER TABLE `suburb` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES ('U217L0001','likhaka','$2a$10$E2qYqps0i6gGO4tFoDDjPOy6QBNjQ6iPrCTXZ.wePiFheUySEmFBa','s215116747@nmmu.ac.za',NULL,NULL,-1,NULL,NULL),('U217N0001','ngematbb','$2a$10$wS2ubGAvtmLXqh04.jGJAuPpEsfmx8dx7/uMBA2HhDiTfP4b5nzue','ngematbb@gmail.com',NULL,NULL,-1,NULL,NULL),('U217S0001','sameones','$2a$10$S3aFLulTpyJ/qFrpFN/n6uraJdp.O5ebT5z6bZ5/ex7aS2FNOVpp.','s215013395@nmmu.ac.za','U217S0001.jpg',NULL,1,NULL,NULL),('U217T0001','teamhome','$2a$10$WjrKCs75u4uB7S4cTQqzAejn..XqpSi0OgQLMkNAafEhuh7UWtpZm','super@themail.co.za','U217T0001.jpg','0760326578',1,'Vito','Corleon'),('U217T0002','theguys','$2a$10$q2uNgGm1.mWwo4G8/n5rouoNEn/I7.dWXe.4HU9FTC55.k5py1DgS','peculiar@exclusivemail.co.za','U217T0002.svg','0737083731',1,'Jin',NULL),('U217T0003','theseones','$2a$10$FZotYl./eALc7smgmnmISOuEXWMhcz9jYmhq0Lcb0a9qjvQ5Hy6kq','business52@live.com','U217T0003.png',NULL,1,'Wezndla','Zwane'),('U217T0004','theseguys','$2a$10$SHZm9gMPL75eEfmtLyJ/auP7HFZFBul4wIpFDlLf4xOSuMT8q53na','s215177770@nmmu.ac.za',NULL,NULL,-1,NULL,NULL);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `yard`
--

LOCK TABLES `yard` WRITE;
/*!40000 ALTER TABLE `yard` DISABLE KEYS */;
/*!40000 ALTER TABLE `yard` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-02-06 19:33:26
