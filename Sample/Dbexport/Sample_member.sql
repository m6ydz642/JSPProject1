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
-- Table structure for table `member`
--

DROP TABLE IF EXISTS `member`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `member` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userid` varchar(12) NOT NULL,
  `userpasswd` varchar(12) NOT NULL,
  `name` varchar(20) NOT NULL,
  `gender` varchar(5) NOT NULL,
  `phone` int(11) DEFAULT NULL,
  `email` varchar(20) DEFAULT NULL,
  `address` varchar(30) DEFAULT NULL,
  `address2` varchar(30) DEFAULT NULL,
  `reg_date` datetime NOT NULL,
  `session` int(5) DEFAULT NULL,
  `exfire` varchar(1) DEFAULT NULL,
  PRIMARY KEY (`id`,`userid`),
  UNIQUE KEY `userid_UNIQUE` (`userid`),
  UNIQUE KEY `phone_UNIQUE` (`phone`),
  UNIQUE KEY `email_UNIQUE` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `member`
--

LOCK TABLES `member` WRITE;
/*!40000 ALTER TABLE `member` DISABLE KEYS */;
INSERT INTO `member` VALUES (1,'123','123','123','남',10123123,'1234@baver.com','부산남구 기장로 20','이진캐스빌 2동 103호','2020-07-14 22:40:23',0,'N'),(2,'kim','1234','미스터킴','남',1039283928,'010@naver.com','부산 기장군 기장읍 31','쌍용아파트 7동','2020-07-14 23:52:20',0,'N'),(3,'1234','562792','1234','남',111111111,'1234@naver.com','부산 남구 동명로92번길 58','태광아파트','2020-07-15 21:54:46',0,'N'),(4,'12345','582662','12345','남',12345,'12345@naver.com','경기 성남시 분당구 대왕판교로606번길 45','번영로','2020-07-16 22:32:59',0,'N'),(5,'test','1234','테스트맨','남',10123456,'test@naver.com','경기 성남시 분당구 판교로 20','흠','2020-07-18 22:35:06',0,'N'),(6,'기자양반','469032','sbs','남',1020830293,'a@naver.com','경기 성남시 분당구 판교역로 4','골스타워','2020-07-19 22:29:02',0,'N'),(7,'testuser','비밀번호 잠금처리','나는야테스트','남',11,'admin@naver.com','부산 남구 동명로 66','전력공사','2020-07-22 12:35:04',3,'Y'),(8,'testuser2','1234','test','남',111,'admin3@naver.com','부산 남구 용호로 16','나머지주소 ','2020-07-22 12:36:45',0,'N'),(9,'mattaw','1234','mattaw','남',1111,'mattaw@naver.com','서울 마포구 가양대로 1','3번지','2020-07-23 00:36:07',0,'N'),(10,'ngy','1234','ngy','남',123,'','','','2020-07-23 00:47:31',0,'N'),(11,'djdlrkdjqtsp','1234','어이','남',1012341234,'2@Naver.com','부산 강서구 가달1로 7','주식회사','2020-07-23 10:41:39',0,'N'),(12,'jfakdivuud','1234','앙기모띠','남',12341234,'jfakdivuud@naver.com','','','2020-07-23 11:06:58',0,'N'),(13,'1111','864922','1111','남',1097221234,'1111@naver.com','','','2020-07-23 11:16:43',0,'N'),(14,'suho','586279','suho','남',1234,'suho@naver.com','','','2020-07-27 16:44:20',0,'N'),(20,'ᇂᆻᆸㅛ','1234','53543','남',1053420384,'53543@naver.com','','','2020-07-27 19:40:32',3,'Y'),(32,'1235','비밀번호 잠금처리','김','남',1028011234,'0101234@na','','','2020-07-27 19:58:19',3,'Y'),(36,'master','1234','1234','남',12930902,'1239190@naver.com','','','2020-07-27 20:06:44',0,'N'),(37,'nayanahohoho','1234','1234','남',1293918982,'nayanaho@naver.com','','','2020-07-27 20:07:59',0,'N'),(38,'bonobono','1234','bonobono','남',103938293,'bonobono@naver.com','','','2020-07-27 20:13:43',0,'N'),(39,'bonobono1','1234','bonobono1','남',1039382932,'bonobono1@naver.com','','','2020-07-27 20:13:57',0,'N'),(40,'bonobono2','1234','bonobono1','남',1039382933,'bonobono2@naver.com','','','2020-07-27 20:20:17',0,'N'),(41,'bonobono4','1234','bonobono1','남',1039382939,'bonobono3@naver.com','','','2020-07-27 20:21:13',0,'N'),(44,'miss','1234','miss','여',1029348283,'234@naver.com','','','2020-07-27 20:54:33',0,'N'),(46,'123456','123456','123456','남',101234,'0101234@naver.com','','','2020-07-27 23:07:30',0,'N'),(48,'1234567','1234','1234','남',123476334,'12345@1naver.com','','','2020-07-28 01:37:51',0,'N');
/*!40000 ALTER TABLE `member` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-07-28  1:38:36
