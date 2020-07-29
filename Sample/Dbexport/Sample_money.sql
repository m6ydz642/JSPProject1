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
-- Table structure for table `money`
--

DROP TABLE IF EXISTS `money`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `money` (
  `num` int(11) NOT NULL AUTO_INCREMENT,
  `기수` varchar(50) DEFAULT NULL,
  `고유번호` int(30) DEFAULT NULL,
  `보고서종류` int(20) DEFAULT NULL,
  `회사이름` varchar(50) DEFAULT NULL,
  `대표자` varchar(50) DEFAULT NULL,
  `회사개요` varchar(2000) DEFAULT NULL,
  `범위` varchar(50) DEFAULT NULL,
  `구분` varchar(50) DEFAULT NULL,
  `매출액` bigint(20) DEFAULT NULL,
  `매출원가` bigint(20) DEFAULT NULL,
  `판매관리비` bigint(20) DEFAULT NULL,
  `유동자산` bigint(20) DEFAULT NULL,
  `유동부채` bigint(20) DEFAULT NULL,
  `비유동부채` bigint(20) DEFAULT NULL,
  `자본금` bigint(20) DEFAULT NULL,
  `자기자본` bigint(20) DEFAULT NULL,
  `자본총액` bigint(20) DEFAULT NULL,
  `주식발행수` bigint(20) DEFAULT NULL,
  `당기순이익` bigint(20) DEFAULT NULL,
  `시가총액` bigint(20) DEFAULT NULL,
  `부채총계` bigint(20) DEFAULT NULL,
  `자산총계` bigint(20) DEFAULT NULL,
  `자본총계` bigint(20) DEFAULT NULL,
  `re_ref` int(11) DEFAULT NULL,
  `re_seq` int(11) DEFAULT NULL,
  `종류` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`num`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `money`
--

LOCK TABLES `money` WRITE;
/*!40000 ALTER TABLE `money` DISABLE KEYS */;
INSERT INTO `money` VALUES (1,'제 18기',971090,11012,'샘코','정기환','동사는 2002년 1월 8월에 항공기용부품제조업 등을 영위할 목적으로 설립 되었음.\n\n동사는 항공기 도어시스템 분야에서 국내 유일의 제조회사로서, 세계적인 품질수준과 가격 경쟁력을 확보하고, 일관생산체제를 구축한 기술혁신 선도기업임.\n\n주요사업은 도어시스템, 점검도어, 항공기 부품으로 매출구성은 도어시스템 외 88.45%, 항공기부품 외 10.16%, 기타 1.39%로 이루어져 있음.','1분기 (2019년 1월1일 ~ 3월 31일)','1분기',4736453216,7088886143,1529375921,23302932688,27227322853,18303081474,4082472500,NULL,4329105026,8164945,-4676832283,2140000000,45530404327,49859509353,49859509353,1,1,'분기보고서'),(2,'제 22기',255433,11011,'라온시큐어','이순형','당사는 1998년 4월 16일 설립되었으며, 소프트웨어 개발, 판매 및 공급을 목적으로함.','1년 (2019년 1월1일 ~ 12월 31일)','사업보고서',30443293632,12289341541,16032659467,36735831833,11624372686,16374173580,15904806000,NULL,21456421100,500000000,2532706443,30000000000,27998546266,49454967366,21456421100,1,1,'사업보고서'),(3,'제 19기',688358,11011,'하이즈항공','하상헌','동사는 항공기 및 항공기 관련 부품의 조립 및 판매를 사업목적으로 2001년 11월 16일에 서울에서 설립되었으며, 2007년 6월 4일에 경남 사천으로 이전하였음.','1년 (2019년 1월1일 ~ 12월 31일)','사업보고서',53029222036,45372809289,4024955760,48692015234,12387657655,40800452845,8848083500,NULL,77120029251,17696167,3708297973,69300000000,53188110500,130308139751,77120029251,1,1,'사업보고서'),(4,'제 47 기',103592,11011,'광동제약','최성원','동사는 한방과학화를 창업이념으로 독창적인 의약품개발과 우수한 기술도입을 통해 국민보건과 삶의 질을 향상시킬 목적으로 1963년 설립됨.\n\n동사의 주요제품으로는 쌍화탕류, 우황청심원, 코포랑, 베니톨, 비타500, 광동 옥수수수염차 등이 있으며, 2012년에는 삼다수 판매권 획득하여 생수사업 시작함.\n\n연구개발비 비중이 매출액의 3~4%인 반면 제약산업은 10%이상을 담당하며, 신약개발부분에는 15~20% 정도의 연구개발비를 투자함.','1년 (2019년 1월1일 ~ 12월 31일)','사업보고서',748889470089,512168766013,195457907363,367790752055,202049289199,33014265389,52420851000,NULL,420976521739,52420851,22924353064,526800000000,235063554588,656040076327,420976521739,1,1,'사업보고서'),(5,'제 51기 말',NULL,11012,'두산중공업','\n박지원, 최형희, 정연인','동사는 1962년 현대양행으로 설립되었으며 1980년 중화학공업 구조조정의 일환으로 정부에 귀속, 한국중공업주식회사로 변경됨. 2001년 두산중공업주식회사로 상호 변경.  발전설비 및 담수설비, 주단조품, 건설(두산중공업), 건설중장비 및 엔진(두산인프라코어), 토목과 건축공사(두산건설) 등의 사업을 영위중임.  17,000톤 프레스 도입으로 발전과 산업 분야의 초대형 단조품 시장 공략을 더욱 가속화할 계획임.','1분기 (2020년 1월 1일 ~ 3월 31일','1분기',924873581853,769208368324,214856168097,3284104805347,7029091325357,1239579036061,1330224940000,NULL,3424000069291,255140778,-303374000000,2204900000000,8268670361418,11692670430709,3424000069291,1,1,'분기보고서'),(6,'제 33기 말',NULL,11012,'아시아나항공','\n한창수','동사는 1988년 2월 설립됨. 1999년 12월 주식을 KOSDAQ 증권시장에 등록하고, 2008년 3월 한국거래소 유가증권시장에 주식을 이전 상장함.\n\n항공운송사업을 주 목적으로 하며 주요종속회사는 에어부산㈜, 에어서울㈜, 아시아나IDT㈜, 아시아나에어포트㈜, 금호리조트㈜, 금호티앤아이(주) 등이 있음.\n\n정보통신부문에서 항공 3사 및 고속버스 등을 관계사로 보유해 경쟁력 있는 인프라와 전문 인력을 보유함.','1년 (2019년 1월 1일 ~ 3월 31일','1분기',1129459076255,1216497671941,121128488753,1400415771268,4469107871424,7501034124068,1116176470000,NULL,70945248262,223235294,-549033271765,749700000000,13204085377553,13414348807119,70945248262,1,1,'분기보고서');
/*!40000 ALTER TABLE `money` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-07-28  1:38:37
