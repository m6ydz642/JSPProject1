-- MySQL dump 10.13  Distrib 5.7.17, for macos10.12 (x86_64)
--
-- Host: 59.20.215.149    Database: Sample
-- ------------------------------------------------------
-- Server version	5.7.30-0ubuntu0.16.04.1

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
-- Table structure for table `newscomment`
--

DROP TABLE IF EXISTS `newscomment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `newscomment` (
  `num` int(11) NOT NULL,
  `id` varchar(30) DEFAULT NULL,
  `content` varchar(500) DEFAULT NULL,
  `ref` int(11) DEFAULT NULL,
  `reg_date` datetime DEFAULT NULL,
  PRIMARY KEY (`num`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `newscomment`
--

LOCK TABLES `newscomment` WRITE;
/*!40000 ALTER TABLE `newscomment` DISABLE KEYS */;
INSERT INTO `newscomment` VALUES (1,'mattaw','아니 진짜 어이없네 기자양반아 이게 뉴스냐',1,'2020-07-23 00:36:40'),(2,'ngy','내 월급 빼고 다 오름 ㅅㄱ',3,'2020-07-23 00:53:54'),(3,'djdlrkdjqtsp','아니 저번엔 3잔이상 마시면 안좋다면서요? 어느장단에 맞추라는거여\r\n',4,'2020-07-23 10:42:58'),(4,'djdlrkdjqtsp','ㅇㅈ',3,'2020-07-23 11:01:39'),(5,'mattaw','??? : 되도않는 연구일수록 욕먹을 확률이 높다는 연구결과 밝혀져...',4,'2020-07-23 20:10:25'),(6,'kim','ㅡ.ㅡ',4,'2020-07-24 01:33:17'),(7,'mattaw','사진이니까 멈춰있지 멍청한 기자양반아',8,'2020-07-24 10:14:39'),(8,'jfakdivuud','멍청아 니땜에 웃다가 교수님한테 쫓겨날뻔했다',8,'2020-07-24 10:20:25'),(9,NULL,NULL,0,'2020-07-25 15:29:48'),(10,NULL,NULL,0,'2020-07-25 15:30:54'),(11,NULL,NULL,0,'2020-07-25 15:31:00'),(12,'kim','마스크좀 벗고 다니고 싶다',28,'2020-07-26 14:16:03');
/*!40000 ALTER TABLE `newscomment` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-07-28  1:38:38
