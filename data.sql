-- MySQL dump 10.13  Distrib 8.0.21, for Win64 (x86_64)
--
-- Host: localhost    Database: django_web
-- ------------------------------------------------------
-- Server version	8.0.21

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `django_web`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `django_web` /*!40100 DEFAULT CHARACTER SET utf8 */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `django_web`;

--
-- Table structure for table `app01_department`
--

DROP TABLE IF EXISTS `app01_department`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `app01_department` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `title` varchar(32) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app01_department`
--

LOCK TABLES `app01_department` WRITE;
/*!40000 ALTER TABLE `app01_department` DISABLE KEYS */;
INSERT INTO `app01_department` VALUES (1,'教学部'),(2,'销售部');
/*!40000 ALTER TABLE `app01_department` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app01_financeaccount`
--

DROP TABLE IF EXISTS `app01_financeaccount`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `app01_financeaccount` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `filename` varchar(32) NOT NULL,
  `filepath` varchar(32) NOT NULL,
  `is_alid` tinyint(1) NOT NULL,
  `upload_datetime` datetime(6) NOT NULL,
  `upload_person` varchar(32) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app01_financeaccount`
--

LOCK TABLES `app01_financeaccount` WRITE;
/*!40000 ALTER TABLE `app01_financeaccount` DISABLE KEYS */;
INSERT INTO `app01_financeaccount` VALUES (44,'20220224095542_2022年1月营销费用预提表格式-','media\\data\\20220224095542_2022年1',0,'2022-02-24 01:55:42.542296','bft'),(45,'20220224102512_2022年1月营销费用预提表格式-','media\\data\\20220224102512_2022年1',0,'2022-02-24 02:25:12.746929','lyq'),(46,'20220224103533_2022年1月营销费用预提表格式-','media\\data\\20220224103533_2022年1',1,'2022-02-24 02:35:33.877976','lyq'),(48,'20220224141240_tt.xlsx','media\\data\\20220224141240_tt.xls',0,'2022-02-24 06:12:40.841003','bft'),(51,'20220303091924_2022年1月营销费用预提表格式-','media\\data\\20220303091924_2022年1',0,'2022-03-03 01:19:24.581570','bft'),(52,'20220303104755_2022年1月营销费用预提表格式-','media\\data\\20220303104755_2022年1',0,'2022-03-03 02:47:55.295803','test03');
/*!40000 ALTER TABLE `app01_financeaccount` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app01_host`
--

DROP TABLE IF EXISTS `app01_host`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `app01_host` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `hostname` varchar(32) NOT NULL,
  `ip` char(39) NOT NULL,
  `depart_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `app01_host_depart_id_ba5981e9_fk` (`depart_id`),
  CONSTRAINT `app01_host_depart_id_ba5981e9_fk` FOREIGN KEY (`depart_id`) REFERENCES `app01_department` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app01_host`
--

LOCK TABLES `app01_host` WRITE;
/*!40000 ALTER TABLE `app01_host` DISABLE KEYS */;
INSERT INTO `app01_host` VALUES (1,'c1.1com','1.1.1.1',1),(2,'c2.1com','2.2.2.2',1);
/*!40000 ALTER TABLE `app01_host` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app01_salesmanagementact`
--

DROP TABLE IF EXISTS `app01_salesmanagementact`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `app01_salesmanagementact` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `filename` varchar(255) NOT NULL,
  `filepath` varchar(255) NOT NULL,
  `yearmonth` varchar(32) NOT NULL,
  `upload_datetime` datetime(6) NOT NULL,
  `upload_person` varchar(32) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app01_salesmanagementact`
--

LOCK TABLES `app01_salesmanagementact` WRITE;
/*!40000 ALTER TABLE `app01_salesmanagementact` DISABLE KEYS */;
INSERT INTO `app01_salesmanagementact` VALUES (38,'202207_bft_玄讯导入表.xlsx','media/sm_act/data/202207_bft_玄讯导入表.xlsx','202207','2022-07-01 17:39:04.809324','bft'),(39,'202206_bft_玄讯导入表.xlsx','media/sm_act/data/202206_bft_玄讯导入表.xlsx','202206','2022-07-01 17:39:19.441513','bft');
/*!40000 ALTER TABLE `app01_salesmanagementact` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app01_salesmanagementcrc`
--

DROP TABLE IF EXISTS `app01_salesmanagementcrc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `app01_salesmanagementcrc` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `filename` varchar(255) NOT NULL,
  `filepath` varchar(255) NOT NULL,
  `upload_datetime` datetime(6) NOT NULL,
  `upload_person` varchar(32) NOT NULL,
  `yearmonth` varchar(32) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=89 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app01_salesmanagementcrc`
--

LOCK TABLES `app01_salesmanagementcrc` WRITE;
/*!40000 ALTER TABLE `app01_salesmanagementcrc` DISABLE KEYS */;
INSERT INTO `app01_salesmanagementcrc` VALUES (87,'xxxxx_正确2.xlsx','media\\sm/data\\xxxxx_正确2.xlsx','2022-07-01 17:37:13.661913','bft','202207'),(88,'yyyy_正确2 - 副本.xlsx','media\\sm/data\\yyyy_正确2 - 副本.xlsx','2022-07-01 17:37:30.122615','bft','202206');
/*!40000 ALTER TABLE `app01_salesmanagementcrc` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app01_userinfo`
--

DROP TABLE IF EXISTS `app01_userinfo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `app01_userinfo` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL,
  `password` varchar(64) NOT NULL,
  `email` varchar(32) NOT NULL,
  `phone` varchar(32) NOT NULL,
  `level` int NOT NULL,
  `depart_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `app01_userinfo_depart_id_e22e0907_fk` (`depart_id`),
  CONSTRAINT `app01_userinfo_depart_id_e22e0907_fk` FOREIGN KEY (`depart_id`) REFERENCES `app01_department` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app01_userinfo`
--

LOCK TABLES `app01_userinfo` WRITE;
/*!40000 ALTER TABLE `app01_userinfo` DISABLE KEYS */;
INSERT INTO `app01_userinfo` VALUES (1,'lyq','123','wupeiqi@xxx.com','15131255089',1,1),(3,'bft','123','bft@163.com','13472536437',1,1),(7,'yvonney@hwccl','yvonney@hwccl','yvonney@hwccl.com','18321408535',1,1),(8,'smTest','smTest','smTest@123','18321401234',1,1),(9,'jhzheng@hwccl','jhzheng@hwccl','jhzheng@hwccl.com','233',1,2),(10,'actTest','actTest','actTest@123','233',1,2),(11,'安徽','anhui','anhui@hwccl','anhui@hwccl',1,2);
/*!40000 ALTER TABLE `app01_userinfo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app01_userinfo_roles`
--

DROP TABLE IF EXISTS `app01_userinfo_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `app01_userinfo_roles` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `userinfo_id` bigint NOT NULL,
  `role_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `app01_userinfo_roles_userinfo_id_role_id_c1a899a5_uniq` (`userinfo_id`,`role_id`),
  KEY `app01_userinfo_roles_role_id_7144c267_fk_rbac_role_id` (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app01_userinfo_roles`
--

LOCK TABLES `app01_userinfo_roles` WRITE;
/*!40000 ALTER TABLE `app01_userinfo_roles` DISABLE KEYS */;
INSERT INTO `app01_userinfo_roles` VALUES (5,1,1),(4,3,1),(8,7,6),(9,8,5),(10,9,8),(11,10,7),(12,11,7);
/*!40000 ALTER TABLE `app01_userinfo_roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',2,'add_permission'),(6,'Can change permission',2,'change_permission'),(7,'Can delete permission',2,'delete_permission'),(8,'Can view permission',2,'view_permission'),(9,'Can add group',3,'add_group'),(10,'Can change group',3,'change_group'),(11,'Can delete group',3,'delete_group'),(12,'Can view group',3,'view_group'),(13,'Can add user',4,'add_user'),(14,'Can change user',4,'change_user'),(15,'Can delete user',4,'delete_user'),(16,'Can view user',4,'view_user'),(17,'Can add content type',5,'add_contenttype'),(18,'Can change content type',5,'change_contenttype'),(19,'Can delete content type',5,'delete_contenttype'),(20,'Can view content type',5,'view_contenttype'),(21,'Can add session',6,'add_session'),(22,'Can change session',6,'change_session'),(23,'Can delete session',6,'delete_session'),(24,'Can view session',6,'view_session'),(25,'Can add department',7,'add_department'),(26,'Can change department',7,'change_department'),(27,'Can delete department',7,'delete_department'),(28,'Can view department',7,'view_department'),(29,'Can add host',8,'add_host'),(30,'Can change host',8,'change_host'),(31,'Can delete host',8,'delete_host'),(32,'Can view host',8,'view_host'),(33,'Can add user info',9,'add_userinfo'),(34,'Can change user info',9,'change_userinfo'),(35,'Can delete user info',9,'delete_userinfo'),(36,'Can view user info',9,'view_userinfo'),(37,'Can add finance account',10,'add_financeaccount'),(38,'Can change finance account',10,'change_financeaccount'),(39,'Can delete finance account',10,'delete_financeaccount'),(40,'Can view finance account',10,'view_financeaccount'),(41,'Can add sales management crc',11,'add_salesmanagementcrc'),(42,'Can change sales management crc',11,'change_salesmanagementcrc'),(43,'Can delete sales management crc',11,'delete_salesmanagementcrc'),(44,'Can view sales management crc',11,'view_salesmanagementcrc'),(45,'Can add sales management act',12,'add_salesmanagementact'),(46,'Can change sales management act',12,'change_salesmanagementact'),(47,'Can delete sales management act',12,'delete_salesmanagementact'),(48,'Can view sales management act',12,'view_salesmanagementact'),(49,'Can add menu',13,'add_menu'),(50,'Can change menu',13,'change_menu'),(51,'Can delete menu',13,'delete_menu'),(52,'Can view menu',13,'view_menu'),(53,'Can add permission',14,'add_permission'),(54,'Can change permission',14,'change_permission'),(55,'Can delete permission',14,'delete_permission'),(56,'Can view permission',14,'view_permission'),(57,'Can add role',15,'add_role'),(58,'Can change role',15,'change_role'),(59,'Can delete role',15,'delete_role'),(60,'Can view role',15,'view_role');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_groups` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_admin_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `django_admin_log_chk_1` CHECK ((`action_flag` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(7,'app01','department'),(10,'app01','financeaccount'),(8,'app01','host'),(12,'app01','salesmanagementact'),(11,'app01','salesmanagementcrc'),(9,'app01','userinfo'),(3,'auth','group'),(2,'auth','permission'),(4,'auth','user'),(5,'contenttypes','contenttype'),(13,'rbac','menu'),(14,'rbac','permission'),(15,'rbac','role'),(6,'sessions','session');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_migrations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2022-06-30 09:20:56.386633'),(2,'auth','0001_initial','2022-06-30 09:20:56.899592'),(3,'admin','0001_initial','2022-06-30 09:20:57.020753'),(4,'admin','0002_logentry_remove_auto_add','2022-06-30 09:20:57.027429'),(5,'admin','0003_logentry_add_action_flag_choices','2022-06-30 09:20:57.033430'),(6,'rbac','0001_initial','2022-06-30 09:20:57.376354'),(7,'app01','0001_initial','2022-06-30 09:20:57.727787'),(8,'app01','0002_auto_20220221_1008','2022-06-30 09:20:58.231711'),(9,'app01','0003_remove_financeaccount_file','2022-06-30 09:20:58.262099'),(10,'app01','0004_salesmanagementcrc','2022-06-30 09:20:58.298246'),(11,'app01','0005_auto_20220624_1646','2022-06-30 09:20:58.339692'),(12,'app01','0006_salesmanagementact','2022-06-30 09:20:58.363812'),(13,'contenttypes','0002_remove_content_type_name','2022-06-30 09:20:58.472963'),(14,'auth','0002_alter_permission_name_max_length','2022-06-30 09:20:58.524637'),(15,'auth','0003_alter_user_email_max_length','2022-06-30 09:20:58.620565'),(16,'auth','0004_alter_user_username_opts','2022-06-30 09:20:58.627556'),(17,'auth','0005_alter_user_last_login_null','2022-06-30 09:20:58.670677'),(18,'auth','0006_require_contenttypes_0002','2022-06-30 09:20:58.673676'),(19,'auth','0007_alter_validators_add_error_messages','2022-06-30 09:20:58.679733'),(20,'auth','0008_alter_user_username_max_length','2022-06-30 09:20:58.732685'),(21,'auth','0009_alter_user_last_name_max_length','2022-06-30 09:20:58.789743'),(22,'auth','0010_alter_group_name_max_length','2022-06-30 09:20:58.840528'),(23,'auth','0011_update_proxy_permissions','2022-06-30 09:20:58.850232'),(24,'auth','0012_alter_user_first_name_max_length','2022-06-30 09:20:58.901774'),(25,'rbac','0002_auto_20220221_1008','2022-06-30 09:20:59.488085'),(26,'sessions','0001_initial','2022-06-30 09:20:59.520119');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('3ipzfuhus23q9l04dqxmq5ahqz0mv76b','.eJy9mNuOmzAQht-Fqx6SBsw5qrav0PumQgabBi2BiENXq1XevbYTyJhlUrIhuUEJiWe-f_z7-GZkRVoa6zcjY8baXhhtzauC7rixNuK0MQ4LI2_T9DXa82qX1XVWFlFb5VGe1U30zF9lS9lEvejCOAujyZpcxti0vkuCTesR29-0LrHEMwi8wBCZqlz8YSVbr2TrlXi3l82LNs_Fx-gUo_uq_i-_HI6UEWdZn9LTUqaWJ9KkoQXTD1LK1qtPP35-3z8_bTbs6-c-vwOSXxJwQtIkdGyM5x2aD9FcQsxNG3qecwFNNL4fWcVr3kT7F9bxBZAvtBImC-hxETJORBn9wLQGfCrEak_r-qWs2F1Qt6XwF_RUCCkdbscimm_TcU_J1ld7SqWkrK-LZcKUHktjmYyaMP0gpWjdZwz1AqDIfQEAdEcDHW5ZmMVRHNzic8ABi1sE8zjKhnr8RrQqpsm6KnOuuceyIWAQMiKexCfj9pExVjLG1R46Z4dGcjAjnUHGkkM3SQGwLKiEvixDERqdZiwXM9ZlPNxdM8NCo3mY0S6zom6bD3XHi1b3nDbxBzZLREjbdS94Tsb4mOdUdui5AJ-8TPH0OfUh1BiI5j9_UCdMjl4nIEgj1fwX4hPbVNQLXpwXHHiRmPikN5Ub9-Vs2DVPyoJFQ4MQCzdIkPyX_hj17BMpQqXI2FHJfYVA_xCC--dKJY-wEZQB3WTjbrpSxQNMBU4D0FPoQuf5ji31uOaA-xyotxEsUOem-0rQ3ISuhlM0PMJAABz6B10Zp3A_wDK7Nm8ycIyse3JtnfSIH6pjSCo-O_Iw4qRuckGFigu01I9g1yofYPyTeuE9_wM6g4lvVRa3DR_tEW1FPpPLLKYn1TlsoOIccLQrph7pwWRiowsUem6GG5Ybz587MZJpjwLmNfWDiOdxeUJO4USsfjr2HG22T9--fJ4JJs0KWiTiTJEkZVvo52JbG_cBI54qk7z5CJnVg47sOE9RV6eoV-87h1TtPi_pufv8KVxip0TlCCcmznWM25NJwdogmCK5L-y46BE1YIDbAXqD0-fD8dHR_CAhf2menXtFG9khlTuLIE4slZ28z47LUmEfKGzsIlJtEU6XkEQ-xoeYH6vMjumJPJnYXIh_pHSZsWVCK7Ysxdtkm-Ws4uKXX7ddYR5-C1BbZ4FXGAjLlhZsWSdCV1nV40QfvQBTRJZOBKd0jKhsqz85reulPUZz24XKYTHHEbmLMuNypYrl6MXSRsZ4sV5EaZLtWJ3mnp4F4OHwD5EmYjA:1nN37z:Sv8SWac09ztUBcfCImsC25Rbjeu1LxAwYLGnlkur7lg','2022-03-10 01:41:07.180930'),('3n1fx2p9d7z7s8m06wwpdv4semdmfv01','.eJy9ldGO2yAQRf-Fp1ZNZOzY2ImqttL-QNXXurIw4A0KwRaYRtEq_94hu47tNHa12mxfUCDMnTMXMzwhqasabZ6Q5GiTLpCzwmi6F2iDjr9rrcXx2_bAmEKnBVKuqo5FI8xeWitrXTijCiVtW-zE0Wv44PNCJxgvUCtb5dVylyZRljsSrdLcJVEIY5aRDEFOo2BD4KMDHx3AWuPDtVMKfhYvGt30vN9PTs-8heDykpKMUlYhgTTVOhymv0rpo4MPX79_bnZf8px_-njJHw-SzxXwgjQqoWPjQg3s7cWSKMK5WxMSz6BB8PuRGWFFWzQH3vFlQ751yLg3kAiQLBnYmGY4vOI7SwQNtfZQG_4uqKakbMNhZmTpWjH4_GzHHa2H4CSNV97YBPsEmPhSYt6De8GgFwwGgq_-8Ci_mLcKRxC8Kn16imdOF6Lv5ZKlStg91fRR7IVuC2bY-CLinu7hx4M_0orBGJKkh7oSCUDk1ffxFohrVE0vRsUjo9YJ9haVNDxjxQJTGKsIz2M9S_bu4aF9fxd4cW26xAl2Xh_0iD6apy99u0n5PH0n-j_4-_YTr2bQ-3b0D_TJjnSHEm69MbDHde9L5Ifbl8QXAmOMCeSSrNawo6JLyZeMGr6sYZVtpeJGwD8_3_Y6nX4BaDhmGXadCZZt7cyjgl65XN2iuWMXOwMmY8D-vKcBqeZ2S3diwq639RCAOp3-ALCRsfA:1o65YW:OG6Bipwr-lQCP2AjAXF58eGYCp-KblLXq331ZV2ZVV4','2022-07-12 07:22:40.188139'),('3y14svfni9g43akroad5aajn7yrxpjfo','.eJy9mNuOmzAQht-Fqx6SBsw5qrav0PumQgabBi2BiENXq1XevbYTyJhlUrIhuUEJiWe-f_z7-GZkRVoa6zcjY8baXhhtzauC7rixNuK0MQ4LI2_T9DXa82qX1XVWFlFb5VGe1U30zF9lS9lEvejCOAujyZpcxti0vkuCTesR29-0LrHEMwi8wBCZqlz8YSVbr2TrlXi3l82LNs_Fx-gUo_uq_i-_HI6UEWdZn9LTUqaWJ9KkoQXTD1LK1qtPP35-3z8_bTbs6-c-vwOSXxJwQtIkdGyM5x2aD9FcQsxNG3qecwFNNL4fWcVr3kT7F9bxBZAvtBImC-hxETJORBn9wLQGfCrEak_r-qWs2F1Qt6XwF_RUCCkdbscimm_TcU_J1ld7SqWkrK-LZcKUHktjmYyaMP0gpWjdZwz1AqDIfQEAdEcDHW5ZmMVRHNzic8ABi1sE8zjKhnr8RrQqpsm6KnOuuceyIWAQMiKexCfj9pExVjLG1R46Z4dGcjAjnUHGkkM3SQGwLKiEvixDERqdZiwXM9ZlPNxdM8NCo3mY0S6zom6bD3XHi1b3nDbxBzZLREjbdS94Tsb4mOdUdui5AJ-8TPH0OfUh1BiI5j9_UCdMjl4nIEgj1fwX4hPbVNQLXpwXHHiRmPikN5Ub9-Vs2DVPyoJFQ4MQCzdIkPyX_hj17BMpQqXI2FHJfYVA_xCC--dKJY-wEZQB3WTjbrpSxQNMBU4D0FPoQuf5ji31uOaA-xyotxEsUOem-0rQ3ISuhlM0PMJAABz6B10Zp3A_wDK7Nm8ycIyse3JtnfSIH6pjSCo-O_Iw4qRuckGFigu01I9g1yofYPyTeuE9_wM6g4lvVRa3DR_tEW1FPpPLLKYn1TlsoOIccLQrph7pwWRiowsUem6GG5Ybz587MZJpjwLmNfWDiOdxeUJO4USsfjr2HG22T9--fJ4JJs0KWiTiTJEkZVvo52JbG_cBI54qk7z5CJnVg47sOE9RV6eoV-87h1TtPi_pufv8KVxip0TlCCcmznWM25NJwdogmCK5L-y46BE1YIDbAXqD0-fD8dHR_CAhf2menXtFG9khlTuLIE4slZ28z47LUmEfKGzsIlJtEU6XkEQ-xoeYH6vMjumJPJnYXIh_pHSZsWVCK7Ysxdtkm-Ws4uKXX7ddYR5-C1BbZ4FXGAjLlhZsWSdCV1nV40QfvQBTRJZOBKd0jKhsqz85reulPUZz24XKYTHHEbmLMuNypYrl6MXSRsZ4sV5EaZLtWJ3mnp4F4OHwD5EmYjA:1nMgBJ:RInHFCMOKLYiugVb6pegA-L7JiHP3tnDiUjBiA6u-bU','2022-03-09 01:11:01.347231'),('3zuwvp7l6mvdwhfa3izly96m3hx6b33j','.eJy9mNuOozgQht-Fqzl0JmDOrdXsxbzAam83K2SwmaAmEHHY1miUd1_bCVCmXUwyoXODEhJXfX_59_GnVVR5bT3_tApmPbtPVt_ypqIHbj1bad5Zpyer7PP8R3LkzaFo26Kukr4pk7Jou-SF_5AtZRP1YgjjPVld0ZUyxq4PfRLt-oC44a73iSOeURRElsjUlOIPW9l6K1tvxbujbF71ZSk-JpcYw1f1f_nldKZMOCvGlIGWMncCkSaPHZh-llK23n74868_ji9fdzv2-eOY3wPJlwRckDQJAxvj5YAWQjSfEHvXx0HgLaCJxu9H1vCWd8nxlQ18EeSLnYzJAgZchEwzUcYwsp0ZnwqxPdK2fa0b9i6o-1r4C3oqhpQed1MRLXSp2VOy9c2eUikpG-vi2DBlwPJUJqM2TD9LKVqPGWO9ACjyWAAAPdBAhzsOZnEUB7f4GnDA4g7BPI6yoR6_E61Jafbc1CXX3OO4EDCKGRFPEhKzfWSMrYxxs4em7NBIHmakCcSUHLpJCoBlQSWMZZmL0Og0Y_mYsZbxcHetDAuNFmBGW2ZF3bYe6oFXve45beKPXJaJkK7vL3hOxvg9z6ns0HMRPnnZ4hlyGkIoE4jmv3BWJ0yOXicgSCPV_BfjE9u1qAteXBcceJHY-KR3LTfuy9WwW57VFUvmBiEObpAo-yX9OerkEylCpSjYWcn7CoH-IQT3z41KHmEjKAO6ycXddKOKB5gKnAagp9CFLgg9V-rx7Rn3FGi0ESzQ4Kb3laC5CV0Nr9HwCAMBcOgfdGW8hvsBljn0ZVeAY2Q7kmvrZEDCWB1DcvHZk4cRL_ezBRUqLtDSPoJdq3yE8V_VC2_5H9AZTHxrirTvuLFHtBV5IpdZ7ECq89hMxRTQ2BXXHunBZOKiCxR6boYbljvPnwcxkumIAuY19YOIF3B5Qs7hRKx-Ovcc7fZfv3z6uBJMXlS0ysSZIsvqvtLPxa427iNGAlUmefMRM2cENew4L1G3l6g37zvnVP2xrOnUfeE1XGKnROUIJzbOdY47kknB2iC4RvJYWLNogxowwN0IvcEZ8-H46Gh-kJD_aFlMvaKN7JjKnUWUZo7KTt5mx2WpsA8V1tKStwda0e9czGhdkjWZfusI9uPf_v4m769yOT06ARijsyBbEeRm45tAdPN72twV--o4kFJHYZk8b8Ka-V7Km6r6VuBYQFwiws7q10qjJ8v0qdwRhWyZfgi6Kr_pNlrtEy830UQ-zPOsFCCenh2IXIXYYYp_5HRTsE1GG7apxdtsX5Ss4eKXf-67xz79K0BdnQXeYyEse1qxTZsJXXXTmol-9xZUETk6EVzXMaK6b76XtG03ronmvlu109Ma9yRDlBX3LKpYnl4sbXo0F-tVlCbbm-q09hqtAH0dcBqmi_5q9_SFI26_b_4UUKfT__d_Pb0:1o4c1K:8sw4SncGvwN4qrOddFt8dKPUpb-domiMZ4QdKrF7M3c','2022-07-08 05:38:18.016195'),('413g43ws3r4h758bsz87xamtialvtw7w','NDVhMzIxOGIxMmYzMDk3NzFiOTIzYjZhMjc4OTVhMTE0NWIyNDhjZjp7Imx1ZmZ5X3Blcm1pc3Npb25fdXJsX2xpc3Rfa2V5Ijp7InJiYWM6bXVsdGlfcGVybWlzc2lvbnNfZGVsIjp7InVybCI6Ii9yYmFjL211bHRpL3Blcm1pc3Npb25zL2RlbC8oP1A8cGs+XFxkKykvIiwidGl0bGUiOiJcdTYyNzlcdTkxY2ZcdTUyMjBcdTk2NjRcdTY3NDNcdTk2NTAiLCJpZCI6MjgsInBfdXJsIjoiL3JiYWMvbWVudS9saXN0LyIsInBfdGl0bGUiOiJcdTgzZGNcdTUzNTVcdTUyMTdcdTg4NjgiLCJwaWQiOjE3fSwicmJhYzpwZXJtaXNzaW9uX2VkaXQiOnsidXJsIjoiL3JiYWMvcGVybWlzc2lvbi9lZGl0Lyg/UDxwaz5cXGQrKS8iLCJ0aXRsZSI6Ilx1N2YxNlx1OGY5MVx1Njc0M1x1OTY1MCIsImlkIjoyNSwicF91cmwiOiIvcmJhYy9tZW51L2xpc3QvIiwicF90aXRsZSI6Ilx1ODNkY1x1NTM1NVx1NTIxN1x1ODg2OCIsInBpZCI6MTd9LCJ1c2VyX2xpc3QiOnsidXJsIjoiL3VzZXIvbGlzdC8iLCJ0aXRsZSI6Ilx1NzUyOFx1NjIzN1x1NTIxN1x1ODg2OCIsImlkIjo0LCJwX3VybCI6bnVsbCwicF90aXRsZSI6bnVsbCwicGlkIjpudWxsfSwicmJhYzptZW51X2RlbCI6eyJ1cmwiOiIvcmJhYy9tZW51L2RlbC8oP1A8cGs+XFxkKykvIiwidGl0bGUiOiJcdTUyMjBcdTk2NjRcdTRlMDBcdTdlYTdcdTgzZGNcdTUzNTUiLCJpZCI6MjAsInBfdXJsIjoiL3JiYWMvbWVudS9saXN0LyIsInBfdGl0bGUiOiJcdTgzZGNcdTUzNTVcdTUyMTdcdTg4NjgiLCJwaWQiOjE3fSwicmJhYzpwZXJtaXNzaW9uX2RlbCI6eyJ1cmwiOiIvcmJhYy9wZXJtaXNzaW9uL2RlbC8oP1A8cGs+XFxkKykvIiwidGl0bGUiOiJcdTUyMjBcdTk2NjRcdTY3NDNcdTk2NTAiLCJpZCI6MjYsInBfdXJsIjoiL3JiYWMvbWVudS9saXN0LyIsInBfdGl0bGUiOiJcdTgzZGNcdTUzNTVcdTUyMTdcdTg4NjgiLCJwaWQiOjE3fSwicmJhYzpkaXN0cmlidXRlX3Blcm1pc3Npb25zIjp7InVybCI6Ii9yYmFjL2Rpc3RyaWJ1dGUvcGVybWlzc2lvbnMvIiwidGl0bGUiOiJcdTY3NDNcdTk2NTBcdTUyMDZcdTkxNGQiLCJpZCI6MjksInBfdXJsIjpudWxsLCJwX3RpdGxlIjpudWxsLCJwaWQiOm51bGx9LCJyYmFjOnJvbGVfZGVsIjp7InVybCI6Ii9yYmFjL3JvbGUvZGVsLyg/UDxwaz5cXGQrKS8iLCJ0aXRsZSI6Ilx1NTIyMFx1OTY2NFx1ODlkMlx1ODI3MiIsImlkIjoxNiwicF91cmwiOiIvcmJhYy9yb2xlL2xpc3QvIiwicF90aXRsZSI6Ilx1ODlkMlx1ODI3Mlx1NTIxN1x1ODg2OCIsInBpZCI6MTN9LCJyYmFjOnJvbGVfZWRpdCI6eyJ1cmwiOiIvcmJhYy9yb2xlL2VkaXQvKD9QPHBrPlxcZCspLyIsInRpdGxlIjoiXHU3ZjE2XHU4ZjkxXHU4OWQyXHU4MjcyIiwiaWQiOjE1LCJwX3VybCI6Ii9yYmFjL3JvbGUvbGlzdC8iLCJwX3RpdGxlIjoiXHU4OWQyXHU4MjcyXHU1MjE3XHU4ODY4IiwicGlkIjoxM30sInJiYWM6cGVybWlzc2lvbl9hZGQiOnsidXJsIjoiL3JiYWMvcGVybWlzc2lvbi9hZGQvKD9QPHNlY29uZF9tZW51X2lkPlxcZCspLyIsInRpdGxlIjoiXHU2ZGZiXHU1MmEwXHU2NzQzXHU5NjUwIiwiaWQiOjI0LCJwX3VybCI6Ii9yYmFjL21lbnUvbGlzdC8iLCJwX3RpdGxlIjoiXHU4M2RjXHU1MzU1XHU1MjE3XHU4ODY4IiwicGlkIjoxN30sImhvc3RfZWRpdCI6eyJ1cmwiOiIvaG9zdC9lZGl0Lyg/UDxwaz5cXGQrKS8iLCJ0aXRsZSI6Ilx1N2YxNlx1OGY5MVx1NGUzYlx1NjczYSIsImlkIjoxMSwicF91cmwiOiIvaG9zdC9saXN0LyIsInBfdGl0bGUiOiJcdTRlM2JcdTY3M2FcdTUyMTdcdTg4NjgiLCJwaWQiOjl9LCJyYmFjOm1lbnVfZWRpdCI6eyJ1cmwiOiIvcmJhYy9tZW51L2VkaXQvKD9QPHBrPlxcZCspLyIsInRpdGxlIjoiXHU3ZjE2XHU4ZjkxXHU0ZTAwXHU3ZWE3XHU4M2RjXHU1MzU1IiwiaWQiOjE5LCJwX3VybCI6Ii9yYmFjL21lbnUvbGlzdC8iLCJwX3RpdGxlIjoiXHU4M2RjXHU1MzU1XHU1MjE3XHU4ODY4IiwicGlkIjoxN30sInJiYWM6bWVudV9hZGQiOnsidXJsIjoiL3JiYWMvbWVudS9hZGQvIiwidGl0bGUiOiJcdTZkZmJcdTUyYTBcdTRlMDBcdTdlYTdcdTgzZGNcdTUzNTUiLCJpZCI6MTgsInBfdXJsIjoiL3JiYWMvbWVudS9saXN0LyIsInBfdGl0bGUiOiJcdTgzZGNcdTUzNTVcdTUyMTdcdTg4NjgiLCJwaWQiOjE3fSwicmJhYzpyb2xlX2xpc3QiOnsidXJsIjoiL3JiYWMvcm9sZS9saXN0LyIsInRpdGxlIjoiXHU4OWQyXHU4MjcyXHU1MjE3XHU4ODY4IiwiaWQiOjEzLCJwX3VybCI6bnVsbCwicF90aXRsZSI6bnVsbCwicGlkIjpudWxsfSwiaG9zdF9hZGQiOnsidXJsIjoiL2hvc3QvYWRkLyIsInRpdGxlIjoiXHU2ZGZiXHU1MmEwXHU0ZTNiXHU2NzNhIiwiaWQiOjEwLCJwX3VybCI6Ii9ob3N0L2xpc3QvIiwicF90aXRsZSI6Ilx1NGUzYlx1NjczYVx1NTIxN1x1ODg2OCIsInBpZCI6OX0sInJiYWM6cm9sZV9hZGQiOnsidXJsIjoiL3JiYWMvcm9sZS9hZGQvIiwidGl0bGUiOiJcdTZkZmJcdTUyYTBcdTg5ZDJcdTgyNzIiLCJpZCI6MTQsInBfdXJsIjoiL3JiYWMvcm9sZS9saXN0LyIsInBfdGl0bGUiOiJcdTg5ZDJcdTgyNzJcdTUyMTdcdTg4NjgiLCJwaWQiOjEzfSwidXNlcl9kZWwiOnsidXJsIjoiL3VzZXIvZGVsLyg/UDxwaz5cXGQrKS8iLCJ0aXRsZSI6Ilx1NTIyMFx1OTY2NFx1NzUyOFx1NjIzNyIsImlkIjo3LCJwX3VybCI6Ii91c2VyL2xpc3QvIiwicF90aXRsZSI6Ilx1NzUyOFx1NjIzN1x1NTIxN1x1ODg2OCIsInBpZCI6NH0sInJiYWM6bXVsdGlfcGVybWlzc2lvbnMiOnsidXJsIjoiL3JiYWMvbXVsdGkvcGVybWlzc2lvbnMvIiwidGl0bGUiOiJcdTYyNzlcdTkxY2ZcdTY0Y2RcdTRmNWNcdTY3NDNcdTk2NTAiLCJpZCI6MjcsInBfdXJsIjoiL3JiYWMvbWVudS9saXN0LyIsInBfdGl0bGUiOiJcdTgzZGNcdTUzNTVcdTUyMTdcdTg4NjgiLCJwaWQiOjE3fSwiaG9zdF9saXN0Ijp7InVybCI6Ii9ob3N0L2xpc3QvIiwidGl0bGUiOiJcdTRlM2JcdTY3M2FcdTUyMTdcdTg4NjgiLCJpZCI6OSwicF91cmwiOm51bGwsInBfdGl0bGUiOm51bGwsInBpZCI6bnVsbH0sInVzZXJfYWRkIjp7InVybCI6Ii91c2VyL2FkZC8iLCJ0aXRsZSI6Ilx1NmRmYlx1NTJhMFx1NzUyOFx1NjIzNyIsImlkIjo1LCJwX3VybCI6Ii91c2VyL2xpc3QvIiwicF90aXRsZSI6Ilx1NzUyOFx1NjIzN1x1NTIxN1x1ODg2OCIsInBpZCI6NH0sInJiYWM6c2Vjb25kX21lbnVfZWRpdCI6eyJ1cmwiOiIvcmJhYy9zZWNvbmQvbWVudS9lZGl0Lyg/UDxwaz5cXGQrKS8iLCJ0aXRsZSI6Ilx1N2YxNlx1OGY5MVx1NGU4Y1x1N2VhN1x1ODNkY1x1NTM1NSIsImlkIjoyMiwicF91cmwiOiIvcmJhYy9tZW51L2xpc3QvIiwicF90aXRsZSI6Ilx1ODNkY1x1NTM1NVx1NTIxN1x1ODg2OCIsInBpZCI6MTd9LCJyYmFjOnNlY29uZF9tZW51X2FkZCI6eyJ1cmwiOiIvcmJhYy9zZWNvbmQvbWVudS9hZGQvKD9QPG1lbnVfaWQ+XFxkKykiLCJ0aXRsZSI6Ilx1NmRmYlx1NTJhMFx1NGU4Y1x1N2VhN1x1ODNkY1x1NTM1NSIsImlkIjoyMSwicF91cmwiOiIvcmJhYy9tZW51L2xpc3QvIiwicF90aXRsZSI6Ilx1ODNkY1x1NTM1NVx1NTIxN1x1ODg2OCIsInBpZCI6MTd9LCJyYmFjOm1lbnVfbGlzdCI6eyJ1cmwiOiIvcmJhYy9tZW51L2xpc3QvIiwidGl0bGUiOiJcdTgzZGNcdTUzNTVcdTUyMTdcdTg4NjgiLCJpZCI6MTcsInBfdXJsIjpudWxsLCJwX3RpdGxlIjpudWxsLCJwaWQiOm51bGx9LCJyYmFjOnNlY29uZF9tZW51X2RlbCI6eyJ1cmwiOiIvcmJhYy9zZWNvbmQvbWVudS9kZWwvKD9QPHBrPlxcZCspLyIsInRpdGxlIjoiXHU1MjIwXHU5NjY0XHU0ZThjXHU3ZWE3XHU4M2RjXHU1MzU1IiwiaWQiOjIzLCJwX3VybCI6Ii9yYmFjL21lbnUvbGlzdC8iLCJwX3RpdGxlIjoiXHU4M2RjXHU1MzU1XHU1MjE3XHU4ODY4IiwicGlkIjoxN319LCJsdWZmeV9wZXJtaXNzaW9uX21lbnVfa2V5Ijp7IjEiOnsiY2hpbGRyZW4iOlt7InVybCI6Ii9yYmFjL3JvbGUvbGlzdC8iLCJ0aXRsZSI6Ilx1ODlkMlx1ODI3Mlx1NTIxN1x1ODg2OCIsImlkIjoxM30seyJ1cmwiOiIvcmJhYy9tZW51L2xpc3QvIiwidGl0bGUiOiJcdTgzZGNcdTUzNTVcdTUyMTdcdTg4NjgiLCJpZCI6MTd9LHsidXJsIjoiL3JiYWMvZGlzdHJpYnV0ZS9wZXJtaXNzaW9ucy8iLCJ0aXRsZSI6Ilx1Njc0M1x1OTY1MFx1NTIwNlx1OTE0ZCIsImlkIjoyOX1dLCJ0aXRsZSI6Ilx1Njc0M1x1OTY1MFx1N2JhMVx1NzQwNiIsImljb24iOiJmYS1ob3VyZ2xhc3MtMyJ9LCIyIjp7ImNoaWxkcmVuIjpbeyJ1cmwiOiIvdXNlci9saXN0LyIsInRpdGxlIjoiXHU3NTI4XHU2MjM3XHU1MjE3XHU4ODY4IiwiaWQiOjR9XSwidGl0bGUiOiJcdTc1MjhcdTYyMzdcdTdiYTFcdTc0MDYiLCJpY29uIjoiZmEtaWQtY2FyZC1vIn0sIjMiOnsiY2hpbGRyZW4iOlt7InVybCI6Ii9ob3N0L2xpc3QvIiwidGl0bGUiOiJcdTRlM2JcdTY3M2FcdTUyMTdcdTg4NjgiLCJpZCI6OX1dLCJ0aXRsZSI6Ilx1NGUzYlx1NjczYVx1N2JhMVx1NzQwNiIsImljb24iOiJmYS1oYW5kLXNjaXNzb3JzLW8ifX19','2018-12-02 07:27:24.984295'),('4bohvr4ryb6jlzc0t8sj108f29vvbfk2','.eJy9ld2OmzAQhd_FV62aCEzAkKjqj_oCvehdqZDBdnDjALKxou0q795xdgkQBaqoyd5YwfGc-c7YHj8jWYkabZ6RZGizXiBruK7onqMN-l3-KXm1_VIeikKh4wIpK8RT1nC9l8bIusqsVpmSps12_MlpuODTRCcYLlArW-XUUhtHQZJaEqzi1EYBhjFJSIIgp1awwHPRnov2YK5x4ZVVCn5mrxrd52m9-zi-8GacyXNKMkopMIE0Yo2H6S9Sumjv3efvH5vdpzRlH96f84eD5HMGXpFGFjo2xlWHFg_RoiDwU7smJJxBg-DHkWlueJs1B9bxJUO-NS6YKyDhIJkXUMY48fEF30nCa6gxh1qzh6DqnBYbBl9a5rblg-NnOu5gPQQncbhyhY18l8AnzkrIenAn6PWC3kDw5oNH2bl4KzyCYCJ36ak_s7sQfa8qGaq42dOKbvmeV21Gi3Z8EUc3kSRk5QqFhdtbUcCISdTTXah5oHbzxbxGZBtV03PFwmh03iLf1Sqn-Ou3H6kNuU9hFIE_j_Ui2Zfxoo6TTs91nPY6YYLVh2pkg8zbyF0Ditm8jU70TY30nSmMZzz0neofHiab1dttSrav-41JZkwRGmDHEIvbN8klAa8PsXftmYU1tntiAzdc7xPOG4yhTyCXLOoKVgi6lGxZUM2WNcwWpVRMc_jn5_890MdfAIrHLMPGO8FS1lZvFTwXy9U1mjs28hNgNAbsj8A0IK2YKemOT5TrTm0U6I7Hv5VpCX8:1o6Quz:PEqe50DOE9e9hxeJxpcearO4s9GQiNrQh8-8ScouuKE','2022-07-13 06:11:17.811575'),('7dgn2bvhcut67gyz5vmulzchavlfg8gz','.eJy9ld2OmzAQhd_FV62aCEzAkKjqj_oCvehdqZDBdnDjALKxou0q795xdgkQBaqoyd5YwfGc-c7YHj8jWYkabZ6RZGizXiBruK7onqMN-l3-KXm1_VIeikKh4wIpK8RT1nC9l8bIusqsVpmSps12_MlpuODTRCcYLlArW-XUUhtHQZJaEqzi1EYBhjFJSIIgp1awwHPRnov2YK5x4ZVVCn5mrxrd52m9-zi-8GacyXNKMkopMIE0Yo2H6S9Sumjv3efvH5vdpzRlH96f84eD5HMGXpFGFjo2xlWHFg_RoiDwU7smJJxBg-DHkWlueJs1B9bxJUO-NS6YKyDhIJkXUMY48fEF30nCa6gxh1qzh6DqnBYbBl9a5rblg-NnOu5gPQQncbhyhY18l8AnzkrIenAn6PWC3kDw5oNH2bl4KzyCYCJ36ak_s7sQfa8qGaq42dOKbvmeV21Gi3Z8EUc3kSRk5QqFhdtbUcCISdTTXah5oHbzxbxGZBtV03PFwmh03iLf1Sqn-Ou3H6kNuU9hFIE_j_Ui2Zfxoo6TTs91nPY6YYLVh2pkg8zbyF0Ditm8jU70TY30nSmMZzz0neofHiab1dttSrav-41JZkwRGmDHEIvbN8klAa8PsXftmYU1tntiAzdc7xPOG4yhTyCXLOoKVgi6lGxZUM2WNcwWpVRMc_jn5_890MdfAIrHLMPGO8FS1lZvFTwXy9U1mjs28hNgNAbsj8A0IK2YKemOT5TrTm0U6I7Hv5VpCX8:1o6NWS:9paZiiYRoKALNSZu8Nkj6N0nF6VVxOwMuMuQPVvQj_I','2022-07-13 02:33:44.764087'),('7otjkl4v4lg62wntmajeij7beciojnsr','.eJy9ld2OmzAQhd_FV602EZiAIdGqP-oL9KJ3pUIOthc3xiCMFW1XvHvH2SVAFKhW3ezNKDieM98Zw_gJSS0qtHtCkqHddoWs4Y2mJUc79Lv4U3D98KU45rlC3QopK8RjVvOmlMbISme2UZmSps0O_NFpuOTTQi8YrlArW-XUUhtHQZJaEmzi1EYBhpgkJEFQs1GwwXPZnsv2YK126doqBT-zF43-8bTfPXTPvBln8lySTEoKTKCM2OJx-YuSLtv78Pn7fX34lKbs7uO5fjgqvmTgBWlioWdjXPVo8RgtCgI_tVtCwgU0SL4dWcMNb7P6yHq-ZMy3xTlzDSQcJPc5tDFOfHzBd5LwamrMsWrY7VApO0Nu8JiSMLF3OtRf6CJkvxWNoYqbkmr6wEuu24zm7fSFn7zxJCEbiDEWrocih4hJNNBdqHmg9uoP4BqRrVVFzx0Lo8m5Rr7r1Z7ir99-pDbkPoUoAn8Z61lyaONFH2ednvs473XGBKuOemKDLNvYuw89Zss2etF3NTJMgDBe8DBMhH94mB0K73coWVkNB5MsmCI0wI4hFq8_JFcEvN7E3rXrDPbY_ioLXLg-J5w3iKFPoJbMKw07BF1Lts5pw9YVrOaFVKzh8M_P_7sIu18AGk1Zhg7PshRUM1PQA5-heaMpBXRd9xdSMaP8:1o6UUq:ynEpyMwk9CrjrGaob2IP6bEJveyjBseXawlNN5uaZOI','2022-07-13 10:00:32.043576'),('7qh3en8b26tw4rda8oo9py3nzor5714n','.eJytkc1ugzAMx9_FZyrCBN3GtW8w7TamKA3OiBoCysehqvLuc1hh0oR62sWKv_7-2bmBtmqC9ga6h_algOjRWTEitODHd_QBUgEmKnXlM7pRe68ny6Mz3Ggf-AWvudkLg34UVnzhiDZw6eSSX4VrVkDQwWTZ09upi81ZSbLVsQGa6QzFyz8iJYmUWaSkkjmr2GgMPfldaXWX9uwQ6R5InM0k-g2l-kXp4mvDWBefz6JasGpkgqx6Yo-xfiQ3sLzehrWz4J3x0Ypp78xUE9cTN9nsgW-2ZkeapeVkqUKJwyBs7wdxwcNEcTlo0zuk3Me__En6TCl9A9YNwbg:1o4fin:EfHnd-aEfXtJzRWBlu5KJi-izcenvnCI18csAdh1zbk','2022-07-08 09:35:25.429732'),('8aeq4izpsft24umnmzzvaxiuxcs0v7h3','.eJy9mduOm0gQht-Fq83ueA3NeRQlWs0LRFHu1ivUppsYDQYLzI6iyO-e7raBakwxOMbcIJ-66vur_z76p5HmSWE8_zRSZjzbT0Zd8TKne248G9vkaJyejKxOkh_RgZf7tKrSIo_qMouytDpGr_yHbCmbqA-aMM6TcUyPmYyxqX2XBJvaI7a_qV1iiWcQeIEhMpWZ-MFatl7L1mvx2UE2z-ssEy-jS4zmrfq9fHM6U0acpW1KT0uZWJ5Ik4QWTN9LKVuv__j85ePh9dNmw_760OZ3QPIxARckTULDxnjWoPkQzSXE3NSh5zkjaKLx48hKXvFjdHhjDV8A-UIrZrKAHhcht7Eoox-YVo9PhVgfaFW9FSV7COquEP6CngohpcPtrYjm23TYU7L1zZ5SKSlr62KZMKXHkq1MRk2YvpdStG4zhnoBUOS2AAC6oYEOtyzM4igObvE54IDFLYJ5HGVDPX4nWrml8XNZZFxzj2VDwCBkRDyJT4btI2OsZYybPdRlh0ZyMCN1IEPJoZukAFgWVEJblr4IjU4zlosZaxwPd9fMsNBoHma0cVbUbfOh7nle657TJv7AZrEIabvuiOdkjN_znMoOPRfgk5cpnj6nPoQaAtH85_fqhMnR6wQEaaSa_0J8YpuKOuLFecGBF4mJT3pTuXFfzoZd8bjIWdQ3CLFwgwTxu_TnqJ1PpAiVImVnJY8VAv1DCO6fG5UsYSMoA7rJxt10o4oFTAVOA9BT6ELn-Y4t9bhmj7sL1NoIFqhx02MlaG5CV8MpGpYwEACH_kFXxincC1hmX2fHFBwjq5ZcWyc94ofqGJKI1448jDiJG4-oUHGBlmoJdq3yAcY_qReu-RfoDCbelem2PvLBHtFW5I5cZjE9qc5hPRVdwMGumHqkB5OJjS5Q6LkZbljuPH_uxUimLQqY19QXIp7H5Qk5gROx-urcc_S4-_T3nx9mgknSnOaxOFPEcVHn-rnY1sZ9wIinyiRvPkJmtaADO85L1PUl6s37zj5VfcgK2nWfP4VL7JSoHOHExLnOcVsyKVgbBFMkt4UdFj2gBgxwO0BvcNp8OD46mhcS8j_N0q5XtJEdUrmzCLaxpbKT6-y4LBV2UWEVzXi1pzn9zsWMdoziMtZvHcF-_OXri7y_SuT0aHlgjPaCrEWQm40_BKKb39HmrtBVx4EttRTWkOeHsHq-l_K6ql4LbAuIS0TYWfGWa_RknH4rd0Q-G6dvgi7B3w1Vxx5B70buO-jo9etDJNBYn9EdfRcdeLZcg61kmqFFtLsNLYl6hnaH6_rPy7dphpZYfUP3VkVUKVrWTisi4srZ3riMd50tM147ewEhwOL-iIYpFlcaUIsv1ynRvug6JhgR5VGijl9-cnsnySRC60PkDf03pk6tl__FiHwM7_qkNvF0TE_kSsV5V_wioauUrWJaslUhPo13acZKLr75975_1U7_CVBbZ4G36gjLjuZsVcVCV1FWw0S_-5-MIrJ0InjKwIiKuvye0apa2UM0993xn57muLVtosx4glLFcvRiaZu14WK9idLEu6E6zX1iUICuDtiN4FF_VTv6yhG337ebazpirsVUiDydfgElZdXP:1o65QA:pJvAdmQjHulnjXXTAqwBlbgblQ-9WkeBGXBEvP9SfLE','2022-07-12 07:14:02.750671'),('b7aauip04rzco2v9abdaychtxdoxzmvx','.eJy9mNuOmzAQht-Fqx6SBsw5qrav0PumQgabBi2BiENXq1XevbYTyJhlUrIhuUEJiWe-f_z7-GZkRVoa6zcjY8baXhhtzauC7rixNuK0MQ4LI2_T9DXa82qX1XVWFlFb5VGe1U30zF9lS9lEvejCOAujyZpcxti0vkuCTesR29-0LrHEMwi8wBCZqlz8YSVbr2TrlXi3l82LNs_Fx-gUo_uq_i-_HI6UEWdZn9LTUqaWJ9KkoQXTD1LK1qtPP35-3z8_bTbs6-c-vwOSXxJwQtIkdGyM5x2aD9FcQsxNG3qecwFNNL4fWcVr3kT7F9bxBZAvtBImC-hxETJORBn9wLQGfCrEak_r-qWs2F1Qt6XwF_RUCCkdbscimm_TcU_J1ld7SqWkrK-LZcKUHktjmYyaMP0gpWjdZwz1AqDIfQEAdEcDHW5ZmMVRHNzic8ABi1sE8zjKhnr8RrQqpsm6KnOuuceyIWAQMiKexCfj9pExVjLG1R46Z4dGcjAjnUHGkkM3SQGwLKiEvixDERqdZiwXM9ZlPNxdM8NCo3mY0S6zom6bD3XHi1b3nDbxBzZLREjbdS94Tsb4mOdUdui5AJ-8TPH0OfUh1BiI5j9_UCdMjl4nIEgj1fwX4hPbVNQLXpwXHHiRmPikN5Ub9-Vs2DVPyoJFQ4MQCzdIkPyX_hj17BMpQqXI2FHJfYVA_xCC--dKJY-wEZQB3WTjbrpSxQNMBU4D0FPoQuf5ji31uOaA-xyotxEsUOem-0rQ3ISuhlM0PMJAABz6B10Zp3A_wDK7Nm8ycIyse3JtnfSIH6pjSCo-O_Iw4qRuckGFigu01I9g1yofYPyTeuE9_wM6g4lvVRa3DR_tEW1FPpPLLKYn1TlsoOIccLQrph7pwWRiowsUem6GG5Ybz587MZJpjwLmNfWDiOdxeUJO4USsfjr2HG22T9--fJ4JJs0KWiTiTJEkZVvo52JbG_cBI54qk7z5CJnVg47sOE9RV6eoV-87h1TtPi_pufv8KVxip0TlCCcmznWM25NJwdogmCK5L-y46BE1YIDbAXqD0-fD8dHR_CAhf2menXtFG9khlTuLIE4slZ28z47LUmEfKGzsIlJtEU6XkEQ-xoeYH6vMjumJPJnYXIh_pHSZsWVCK7Ysxdtkm-Ws4uKXX7ddYR5-C1BbZ4FXGAjLlhZsWSdCV1nV40QfvQBTRJZOBKd0jKhsqz85reulPUZz24XKYTHHEbmLMuNypYrl6MXSRsZ4sV5EaZLtWJ3mnp4F4OHwD5EmYjA:1nN89u:PdJya2p4WMvGxY-pkY81EYKSO0O_HjKkPc-dEdMZbZw','2022-03-10 07:03:26.697975'),('bdy8esp475jt0a6kbenukvd3t76984qx','.eJy9mNuOmzAQht-Fqx6SBsw5qrav0PumQgabBi2BiENXq1XevbYTyJhlUrIhuUEJiWe-f_z7-GZkRVoa6zcjY8baXhhtzauC7rixNuK0MQ4LI2_T9DXa82qX1XVWFlFb5VGe1U30zF9lS9lEvejCOAujyZpcxti0vkuCTesR29-0LrHEMwi8wBCZqlz8YSVbr2TrlXi3l82LNs_Fx-gUo_uq_i-_HI6UEWdZn9LTUqaWJ9KkoQXTD1LK1qtPP35-3z8_bTbs6-c-vwOSXxJwQtIkdGyM5x2aD9FcQsxNG3qecwFNNL4fWcVr3kT7F9bxBZAvtBImC-hxETJORBn9wLQGfCrEak_r-qWs2F1Qt6XwF_RUCCkdbscimm_TcU_J1ld7SqWkrK-LZcKUHktjmYyaMP0gpWjdZwz1AqDIfQEAdEcDHW5ZmMVRHNzic8ABi1sE8zjKhnr8RrQqpsm6KnOuuceyIWAQMiKexCfj9pExVjLG1R46Z4dGcjAjnUHGkkM3SQGwLKiEvixDERqdZiwXM9ZlPNxdM8NCo3mY0S6zom6bD3XHi1b3nDbxBzZLREjbdS94Tsb4mOdUdui5AJ-8TPH0OfUh1BiI5j9_UCdMjl4nIEgj1fwX4hPbVNQLXpwXHHiRmPikN5Ub9-Vs2DVPyoJFQ4MQCzdIkPyX_hj17BMpQqXI2FHJfYVA_xCC--dKJY-wEZQB3WTjbrpSxQNMBU4D0FPoQuf5ji31uOaA-xyotxEsUOem-0rQ3ISuhlM0PMJAABz6B10Zp3A_wDK7Nm8ycIyse3JtnfSIH6pjSCo-O_Iw4qRuckGFigu01I9g1yofYPyTeuE9_wM6g4lvVRa3DR_tEW1FPpPLLKYn1TlsoOIccLQrph7pwWRiowsUem6GG5Ybz587MZJpjwLmNfWDiOdxeUJO4USsfjr2HG22T9--fJ4JJs0KWiTiTJEkZVvo52JbG_cBI54qk7z5CJnVg47sOE9RV6eoV-87h1TtPi_pufv8KVxip0TlCCcmznWM25NJwdogmCK5L-y46BE1YIDbAXqD0-fD8dHR_CAhf2menXtFG9khlTuLIE4slZ28z47LUmEfKGzsIlJtEU6XkEQ-xoeYH6vMjumJPJnYXIh_pHSZsWVCK7Ysxdtkm-Ws4uKXX7ddYR5-C1BbZ4FXGAjLlhZsWSdCV1nV40QfvQBTRJZOBKd0jKhsqz85reulPUZz24XKYTHHEbmLMuNypYrl6MXSRsZ4sV5EaZLtWJ3mnp4F4OHwD5EmYjA:1nPa7g:AhNZbAvc2Q26F-3iopzOUxFIWjDWx2C5nOwzD-iyGfM','2022-03-17 01:19:16.339863'),('k8dk86zbntmga6kf04oanm45hze75820','.eJy9mNuOozgQht-Fqzl0JmDOrdXsxbzAam83K2SwmaAmEHHY1miUd1_bCVCmXUwyoXODEhJXfX_59_GnVVR5bT3_tApmPbtPVt_ypqIHbj1bad5Zpyer7PP8R3LkzaFo26Kukr4pk7Jou-SF_5AtZRP1YgjjPVld0ZUyxq4PfRLt-oC44a73iSOeURRElsjUlOIPW9l6K1tvxbujbF71ZSk-JpcYw1f1f_nldKZMOCvGlIGWMncCkSaPHZh-llK23n74868_ji9fdzv2-eOY3wPJlwRckDQJAxvj5YAWQjSfEHvXx0HgLaCJxu9H1vCWd8nxlQ18EeSLnYzJAgZchEwzUcYwsp0ZnwqxPdK2fa0b9i6o-1r4C3oqhpQed1MRLXSp2VOy9c2eUikpG-vi2DBlwPJUJqM2TD9LKVqPGWO9ACjyWAAAPdBAhzsOZnEUB7f4GnDA4g7BPI6yoR6_E61Jafbc1CXX3OO4EDCKGRFPEhKzfWSMrYxxs4em7NBIHmakCcSUHLpJCoBlQSWMZZmL0Og0Y_mYsZbxcHetDAuNFmBGW2ZF3bYe6oFXve45beKPXJaJkK7vL3hOxvg9z6ns0HMRPnnZ4hlyGkIoE4jmv3BWJ0yOXicgSCPV_BfjE9u1qAteXBcceJHY-KR3LTfuy9WwW57VFUvmBiEObpAo-yX9OerkEylCpSjYWcn7CoH-IQT3z41KHmEjKAO6ycXddKOKB5gKnAagp9CFLgg9V-rx7Rn3FGi0ESzQ4Kb3laC5CV0Nr9HwCAMBcOgfdGW8hvsBljn0ZVeAY2Q7kmvrZEDCWB1DcvHZk4cRL_ezBRUqLtDSPoJdq3yE8V_VC2_5H9AZTHxrirTvuLFHtBV5IpdZ7ECq89hMxRTQ2BXXHunBZOKiCxR6boYbljvPnwcxkumIAuY19YOIF3B5Qs7hRKx-Ovcc7fZfv3z6uBJMXlS0ysSZIsvqvtLPxa427iNGAlUmefMRM2cENew4L1G3l6g37zvnVP2xrOnUfeE1XGKnROUIJzbOdY47kknB2iC4RvJYWLNogxowwN0IvcEZ8-H46Gh-kJD_aFlMvaKN7JjKnUWUZo7KTt5mx2WpsA8V1tKStwda0e9czGhdkjWZfusI9uPf_v4m769yOT06ARijsyBbEeRm45tAdPN72twV--o4kFJHYZk8b8Ka-V7Km6r6VuBYQFwiws7q10qjJ8v0qdwRhWyZfgi6Kr_pNlrtEy830UQ-zPOsFCCenh2IXIXYYYp_5HRTsE1GG7apxdtsX5Ss4eKXf-67xz79K0BdnQXeYyEse1qxTZsJXXXTmol-9xZUETk6EVzXMaK6b76XtG03ronmvlu109Ma9yRDlBX3LKpYnl4sbXo0F-tVlCbbm-q09hqtAH0dcBqmi_5q9_SFI26_b_4UUKfT__d_Pb0:1o4f9t:PN6Zpb1Fu0HJe9MZVokVfq1WCIkoM_0Fcmv-y6HZyWw','2022-07-08 08:59:21.987140'),('mixtpefxlgwc57aor5ttghh88bi4a6kd','.eJy9mNuOmzAQht-Fqx6SBsw5qrav0PumQgabBi2BiENXq1XevbYTyJhlUrIhuUEJiWe-f_z7-GZkRVoa6zcjY8baXhhtzauC7rixNuK0MQ4LI2_T9DXa82qX1XVWFlFb5VGe1U30zF9lS9lEvejCOAujyZpcxti0vkuCTesR29-0LrHEMwi8wBCZqlz8YSVbr2TrlXi3l82LNs_Fx-gUo_uq_i-_HI6UEWdZn9LTUqaWJ9KkoQXTD1LK1qtPP35-3z8_bTbs6-c-vwOSXxJwQtIkdGyM5x2aD9FcQsxNG3qecwFNNL4fWcVr3kT7F9bxBZAvtBImC-hxETJORBn9wLQGfCrEak_r-qWs2F1Qt6XwF_RUCCkdbscimm_TcU_J1ld7SqWkrK-LZcKUHktjmYyaMP0gpWjdZwz1AqDIfQEAdEcDHW5ZmMVRHNzic8ABi1sE8zjKhnr8RrQqpsm6KnOuuceyIWAQMiKexCfj9pExVjLG1R46Z4dGcjAjnUHGkkM3SQGwLKiEvixDERqdZiwXM9ZlPNxdM8NCo3mY0S6zom6bD3XHi1b3nDbxBzZLREjbdS94Tsb4mOdUdui5AJ-8TPH0OfUh1BiI5j9_UCdMjl4nIEgj1fwX4hPbVNQLXpwXHHiRmPikN5Ub9-Vs2DVPyoJFQ4MQCzdIkPyX_hj17BMpQqXI2FHJfYVA_xCC--dKJY-wEZQB3WTjbrpSxQNMBU4D0FPoQuf5ji31uOaA-xyotxEsUOem-0rQ3ISuhlM0PMJAABz6B10Zp3A_wDK7Nm8ycIyse3JtnfSIH6pjSCo-O_Iw4qRuckGFigu01I9g1yofYPyTeuE9_wM6g4lvVRa3DR_tEW1FPpPLLKYn1TlsoOIccLQrph7pwWRiowsUem6GG5Ybz587MZJpjwLmNfWDiOdxeUJO4USsfjr2HG22T9--fJ4JJs0KWiTiTJEkZVvo52JbG_cBI54qk7z5CJnVg47sOE9RV6eoV-87h1TtPi_pufv8KVxip0TlCCcmznWM25NJwdogmCK5L-y46BE1YIDbAXqD0-fD8dHR_CAhf2menXtFG9khlTuLIE4slZ28z47LUmEfKGzsIlJtEU6XkEQ-xoeYH6vMjumJPJnYXIh_pHSZsWVCK7Ysxdtkm-Ws4uKXX7ddYR5-C1BbZ4FXGAjLlhZsWSdCV1nV40QfvQBTRJZOBKd0jKhsqz85reulPUZz24XKYTHHEbmLMuNypYrl6MXSRsZ4sV5EaZLtWJ3mnp4F4OHwD5EmYjA:1nN7JZ:J5g7mrCVqU2_LE-MVWFHRkvoz1jqEKdyq-wIw3--8hE','2022-03-10 06:09:21.963632'),('o3vbd9le6j6ugs6819e8jpduh1gkznuc','.eJy9mduOm0gQht-Fq83ueA3NeRQlWs0LRFHu1ivUppsYDQYLzI6iyO-e7raBakwxOMbcIJ-66vur_z76p5HmSWE8_zRSZjzbT0Zd8TKne248G9vkaJyejKxOkh_RgZf7tKrSIo_qMouytDpGr_yHbCmbqA-aMM6TcUyPmYyxqX2XBJvaI7a_qV1iiWcQeIEhMpWZ-MFatl7L1mvx2UE2z-ssEy-jS4zmrfq9fHM6U0acpW1KT0uZWJ5Ik4QWTN9LKVuv__j85ePh9dNmw_760OZ3QPIxARckTULDxnjWoPkQzSXE3NSh5zkjaKLx48hKXvFjdHhjDV8A-UIrZrKAHhcht7Eoox-YVo9PhVgfaFW9FSV7COquEP6CngohpcPtrYjm23TYU7L1zZ5SKSlr62KZMKXHkq1MRk2YvpdStG4zhnoBUOS2AAC6oYEOtyzM4igObvE54IDFLYJ5HGVDPX4nWrml8XNZZFxzj2VDwCBkRDyJT4btI2OsZYybPdRlh0ZyMCN1IEPJoZukAFgWVEJblr4IjU4zlosZaxwPd9fMsNBoHma0cVbUbfOh7nle657TJv7AZrEIabvuiOdkjN_znMoOPRfgk5cpnj6nPoQaAtH85_fqhMnR6wQEaaSa_0J8YpuKOuLFecGBF4mJT3pTuXFfzoZd8bjIWdQ3CLFwgwTxu_TnqJ1PpAiVImVnJY8VAv1DCO6fG5UsYSMoA7rJxt10o4oFTAVOA9BT6ELn-Y4t9bhmj7sL1NoIFqhx02MlaG5CV8MpGpYwEACH_kFXxincC1hmX2fHFBwjq5ZcWyc94ofqGJKI1448jDiJG4-oUHGBlmoJdq3yAcY_qReu-RfoDCbelem2PvLBHtFW5I5cZjE9qc5hPRVdwMGumHqkB5OJjS5Q6LkZbljuPH_uxUimLQqY19QXIp7H5Qk5gROx-urcc_S4-_T3nx9mgknSnOaxOFPEcVHn-rnY1sZ9wIinyiRvPkJmtaADO85L1PUl6s37zj5VfcgK2nWfP4VL7JSoHOHExLnOcVsyKVgbBFMkt4UdFj2gBgxwO0BvcNp8OD46mhcS8j_N0q5XtJEdUrmzCLaxpbKT6-y4LBV2UWEVzXi1pzn9zsWMdoziMtZvHcF-_OXri7y_SuT0aHlgjPaCrEWQm40_BKKb39HmrtBVx4EttRTWkOeHsHq-l_K6ql4LbAuIS0TYWfGWa_RknH4rd0Q-G6dvgi7B3w1Vxx5B70buO-jo9etDJNBYn9EdfRcdeLZcg61kmqFFtLsNLYl6hnaH6_rPy7dphpZYfUP3VkVUKVrWTisi4srZ3riMd50tM147ewEhwOL-iIYpFlcaUIsv1ynRvug6JhgR5VGijl9-cnsnySRC60PkDf03pk6tl__FiHwM7_qkNvF0TE_kSsV5V_wioauUrWJaslUhPo13acZKLr75975_1U7_CVBbZ4G36gjLjuZsVcVCV1FWw0S_-5-MIrJ0InjKwIiKuvye0apa2UM0993xn57muLVtosx4glLFcvRiaZu14WK9idLEu6E6zX1iUICuDtiN4FF_VTv6yhG337ebazpirsVUiDydfgElZdXP:1o6UH7:8YiwMvdx0vZnp_g0y7wYxu221DfNgEjTdU5xN8-KBkI','2022-07-13 09:46:21.001352'),('s2ot47uhhms5y7lnj24nd0y97kwzyn6s','.eJy9ld2OmzAQhd_FV62aCEzAkKjqj_oCvehdqZDBdnDjALKxou0q795xdgkQBaqoyd5YwfGc-c7YHj8jWYkabZ6RZGizXiBruK7onqMN-l3-KXm1_VIeikKh4wIpK8RT1nC9l8bIusqsVpmSps12_MlpuODTRCcYLlArW-XUUhtHQZJaEqzi1EYBhjFJSIIgp1awwHPRnov2YK5x4ZVVCn5mrxrd52m9-zi-8GacyXNKMkopMIE0Yo2H6S9Sumjv3efvH5vdpzRlH96f84eD5HMGXpFGFjo2xlWHFg_RoiDwU7smJJxBg-DHkWlueJs1B9bxJUO-NS6YKyDhIJkXUMY48fEF30nCa6gxh1qzh6DqnBYbBl9a5rblg-NnOu5gPQQncbhyhY18l8AnzkrIenAn6PWC3kDw5oNH2bl4KzyCYCJ36ak_s7sQfa8qGaq42dOKbvmeV21Gi3Z8EUc3kSRk5QqFhdtbUcCISdTTXah5oHbzxbxGZBtV03PFwmh03iLf1Sqn-Ou3H6kNuU9hFIE_j_Ui2Zfxoo6TTs91nPY6YYLVh2pkg8zbyF0Ditm8jU70TY30nSmMZzz0neofHiab1dttSrav-41JZkwRGmDHEIvbN8klAa8PsXftmYU1tntiAzdc7xPOG4yhTyCXLOoKVgi6lGxZUM2WNcwWpVRMc_jn5_890MdfAIrHLMPGO8FS1lZvFTwXy9U1mjs28hNgNAbsj8A0IK2YKemOT5TrTm0U6I7Hv5VpCX8:1o6SDm:cao7PNeannE7lRVnUK1O7NWupmGjuxe0OYHct-S7GOc','2022-07-13 07:34:46.698608'),('to14zc4e4h0uucmpuewfqd7jrh5657dc','.eJy9mF2TmjAUhv8LV912rRC-nc72L_S-dphIQmUWwYJ0Z2fH_94kCpywHIsrcsMomnOe9-TN55uR5klhrN6MlBkr69GoK17mdMeNlZG9_jGOj0ZWJ8lrtOflLq2qtMijusyiLK0O0TN_lS1lE_WiCeM8Gof0kMkY69p3SbCuPWL769ollngGgRcYIlOZiT8sZeulbL0U7_ayeV5nmfgYnWM0X9X_5ZfjiTLiLG1TelrKxPJEmiS0YPpeStl6-en7j2_756f1mn15aPM7IPklAWckTULDxnjWoPkQzSXEXNeh5zkX0ETj-5GVvOKHaP_CGr4A8oVWzGQBPS5CbmJRRj8wrR6fCrHc06p6KUp2F9RtIfwFPRVCSofbGxHNt-mwp2Trqz2lUlLW1sUyYUqPJRuZjJowfS-laN1mDPUCoMhtAQB0QwMdblmYxVEc3OJTwAGLWwTzOMqGevxGtHJD41VZZFxzj2VDwCBkRDyJT4btI2MsZYyrPdRlh0ZyMCN1IEPJoZukAFgWVEJblr4IjU4zlosZ6zIe7q6JYaHRPMxol1lRt02HuuN5rXtOm_gDm8UipO26FzwnY3zMcyo79FyAT16mePqc-hBqCETzn9-rEyZHrxMQpJFq_gvxiW0s6gUvTgsOvEhMfNIby437cjLsisdFzqK-QYiFGySI_0t_itr5RIpQKVJ2UnJfIdA_hOD-uVLJHDaCMqCbbNxNV6qYwVTgNAA9hS50nu_YUo9r9ri7QK2NYIEaN91XguYmdDUco2EOAwFw6B90ZRzDPYNldnV2SMExsmrJtXXSI36ojiGJ-OzIw4iTuPEFFSou0FLNwa5VPsD4R_XCe_4ZOoOJb2W6qQ98sEe0Fbkjl1lMT6pzWE9FF3CwK8Ye6cFkYqMLFHpuhhuWG8-fOzGSaYsC5jX1g4jncXlCTuBErH469Rw9bJ--fn6YCCZJc5rH4kwRx0Wd6-diWxv3ASOeKpO8-QiZ1YIO7DjPUZfnqFfvO_tU9T4raNd9_hgusVOicoQTE-c6xW3JpGBtEIyR3BZ2WPSAGjDA7QC9wWnz4fjoaJ5JyF-apV2vaCM7pHJnEWxiS2Un77PjslTYGYUNXUSqLcL5EpLIx_AQ8zcqs2N6Ik8qNhfiHwldpGwR05ItCvE23qYZK7n45edtV5jHXwLU1lngFQbCsqU5W1Sx0FWU1TDRRy_AFJGlE8EpHSMq6vJ3RqtqYQ_R3Hahcnyc4ojcRJlwuVLFcvRiaSNjuFgvojTxdqhOU0_PAvB4_AfHc2JI:1nPbYS:7rMRgwHJui0XLEcDhSbvTTkTUcBi8EenPcfkgf6dr8M','2022-03-17 02:51:00.859607'),('unwwchuer90aomkqfkht10n79uqcr7s8','.eJy9mNuOmzAQht-Fqx6SBsw5qrav0PumQgabBi2BiENXq1XevbYTyJhlUrIhuUEJiWe-f_z7-GZkRVoa6zcjY8baXhhtzauC7rixNuK0MQ4LI2_T9DXa82qX1XVWFlFb5VGe1U30zF9lS9lEvejCOAujyZpcxti0vkuCTesR29-0LrHEMwi8wBCZqlz8YSVbr2TrlXi3l82LNs_Fx-gUo_uq_i-_HI6UEWdZn9LTUqaWJ9KkoQXTD1LK1qtPP35-3z8_bTbs6-c-vwOSXxJwQtIkdGyM5x2aD9FcQsxNG3qecwFNNL4fWcVr3kT7F9bxBZAvtBImC-hxETJORBn9wLQGfCrEak_r-qWs2F1Qt6XwF_RUCCkdbscimm_TcU_J1ld7SqWkrK-LZcKUHktjmYyaMP0gpWjdZwz1AqDIfQEAdEcDHW5ZmMVRHNzic8ABi1sE8zjKhnr8RrQqpsm6KnOuuceyIWAQMiKexCfj9pExVjLG1R46Z4dGcjAjnUHGkkM3SQGwLKiEvixDERqdZiwXM9ZlPNxdM8NCo3mY0S6zom6bD3XHi1b3nDbxBzZLREjbdS94Tsb4mOdUdui5AJ-8TPH0OfUh1BiI5j9_UCdMjl4nIEgj1fwX4hPbVNQLXpwXHHiRmPikN5Ub9-Vs2DVPyoJFQ4MQCzdIkPyX_hj17BMpQqXI2FHJfYVA_xCC--dKJY-wEZQB3WTjbrpSxQNMBU4D0FPoQuf5ji31uOaA-xyotxEsUOem-0rQ3ISuhlM0PMJAABz6B10Zp3A_wDK7Nm8ycIyse3JtnfSIH6pjSCo-O_Iw4qRuckGFigu01I9g1yofYPyTeuE9_wM6g4lvVRa3DR_tEW1FPpPLLKYn1TlsoOIccLQrph7pwWRiowsUem6GG5Ybz587MZJpjwLmNfWDiOdxeUJO4USsfjr2HG22T9--fJ4JJs0KWiTiTJEkZVvo52JbG_cBI54qk7z5CJnVg47sOE9RV6eoV-87h1TtPi_pufv8KVxip0TlCCcmznWM25NJwdogmCK5L-y46BE1YIDbAXqD0-fD8dHR_CAhf2menXtFG9khlTuLIE4slZ28z47LUmEfKGzsIlJtEU6XkEQ-xoeYH6vMjumJPJnYXIh_pHSZsWVCK7Ysxdtkm-Ws4uKXX7ddYR5-C1BbZ4FXGAjLlhZsWSdCV1nV40QfvQBTRJZOBKd0jKhsqz85reulPUZz24XKYTHHEbmLMuNypYrl6MXSRsZ4sV5EaZLtWJ3mnp4F4OHwD5EmYjA:1nMgA4:fEkU0wXRNJxc9EOKaAVjOSB405QqfFdB1UT0-dChy0k','2022-03-09 01:09:44.516360'),('uy7kdz4jnjnn1jrfr0g70ziwztt45v5w','.eJy9mV2PmzgUhv8LV9vdyQbM96hqtZo_UFW926yQg02DhkAEYUdVlf9e2wlwTDgMaQg3Ub58zvMevzY-8NNI86Qwnn8aKTOe7SejrniZ0z03no1tcjROT0ZWJ8mP6MDLfVpVaZFHdZlFWVodo1f-Q46UQ9QXTRjnyTimx0zG2NS-S4JN7RHb39QuscRrEHiBITKVmfjDWo5ey9Fr8d1BDs_rLBNvo0uM5qP6v_xwOlNGnKVtSk9LmVieSJOEFkzfSylHr__4_OXj4fXTZsP--tDmd0DyMQEXJE1Cw8Z41qD5EM0lxNzUoec5I2hi8OPISl7xY3R4Yw1fAPlCK2aygB4XIbexKKMfmFaPT4VYH2hVvRUlewjqrhD-gp4KIaXD7a2I5tt02FNy9M2eUikpa-timTClx5KtTEZNmL6XUoxuM4Z6AVDktgAAuqGBDrcszOIoDm7xOeCAxS2CeRxlQz1-J1q5pfFzWWRcc49lQ8AgZES8Ep8M20fGWMsYN3uoyw6N5GBG6kCGkkM3SQGwLKiEtix9ERqdZiwXM9Y4Hu6umWGh0TzMaOOsqNvmQ93zvNY9p238gc1iEdJ23RHPyRi_5zmVHXouwDcvU7z6nPoQaghE85_fqxMmR68TEKSRav4L8Y1tKuqIF-cFB14kJr7pTeXGfTkbdsXjImdR3yDEwg0SxO_Sn6N2PpEiVIqUnZU8Vgj0DyG4f25UsoSNoAzoJht3040qFjAV6Aagp9ALnec7ttTjmj3uLlBrI1igxk2PlaC5Cb0aTtGwhIEAOPQPemWcwr2AZfZ1dkxBG1m15Np10iN-qNqQRLx3ZDPiJG48okLFBVqqJdi1ygcY_6RZuOZfYDKY-FSm2_rIB2dEuyJ35DKL6Ul1Duup6AIOTsXUlh5sJjZ6gUL7ZnhgubP_3IuVTFsUsK-pH0Q8j8sOOYEbsfrpPHP0uPv0958fZoJJ0pzmsegp4rioc70vtrV1HzDiqTLJOx8hs1rQgRPnJer6EvXmc2efqj5kBe2mz5_CJU5KVK5wYuJc57gtmRSsLYIpktvCDoseUAMWuB2gd3DafDg-upoXEvI_zdJuVrSVHVJ5sgi2saWyk-vsuCwVdlFhFc14tac5_c7FjnaM4jLW7zqC8_jL1xd5_yqR26PlgTXaC7IWQW42_hCIbn5H27tCV7UDW2oprCHPD2H1fC_ldVW9FtgWEJeIsLPiLdfoyTj9Vp6IfDZO3wRdgr9bqo49gt6t3HfQ0duvD5FAY31Hd_RTdODZ8hpsJdMMLaLdbWhJ1DO0O1zXf16-TTO0xOobundVRJWiZe20IiKunO2Ny3jX2TLjtbMXEAIs7o9omGJxpQG1-HKTEu2LbmKCEVEeJar98pPbJ0kmEVoXkgd3U01eOLIt3SoP7q59eTNsUENP_FQvfnnaR-TL8FlWShKvjumJXKno4sU_ErpK2SqmJVsV4tt4l2as5OKXf-97Vnj6T4DaOgt8VoCw7GjOVlUsdBVlNUz0u0-aFJGlE8HeCSMq6vJ7RqtqZQ_R3Pfk4vQ0x73oJsqMfaEqlqMXSzuCDhfrTZQm3g3Vae4-SAG6OmC3cEf9Ve3oK0fcft8ZtZmIuY4IQuTp9Au7dx2F:1o8Coi:tmp65VJgvS8OWqsn8zQLsErvEza_rs857EELdG7z-gQ','2022-07-18 11:32:08.005274'),('ve9qwtetsriwoy38dv3fe47hcrkl4zk6','.eJy9mNuOmzAQht-Fqx6SBsw5qrav0PumQgabBi2BiENXq1XevbYTyJhlUrIhuUEJiWe-f_z7-GZkRVoa6zcjY8baXhhtzauC7rixNuK0MQ4LI2_T9DXa82qX1XVWFlFb5VGe1U30zF9lS9lEvejCOAujyZpcxti0vkuCTesR29-0LrHEMwi8wBCZqlz8YSVbr2TrlXi3l82LNs_Fx-gUo_uq_i-_HI6UEWdZn9LTUqaWJ9KkoQXTD1LK1qtPP35-3z8_bTbs6-c-vwOSXxJwQtIkdGyM5x2aD9FcQsxNG3qecwFNNL4fWcVr3kT7F9bxBZAvtBImC-hxETJORBn9wLQGfCrEak_r-qWs2F1Qt6XwF_RUCCkdbscimm_TcU_J1ld7SqWkrK-LZcKUHktjmYyaMP0gpWjdZwz1AqDIfQEAdEcDHW5ZmMVRHNzic8ABi1sE8zjKhnr8RrQqpsm6KnOuuceyIWAQMiKexCfj9pExVjLG1R46Z4dGcjAjnUHGkkM3SQGwLKiEvixDERqdZiwXM9ZlPNxdM8NCo3mY0S6zom6bD3XHi1b3nDbxBzZLREjbdS94Tsb4mOdUdui5AJ-8TPH0OfUh1BiI5j9_UCdMjl4nIEgj1fwX4hPbVNQLXpwXHHiRmPikN5Ub9-Vs2DVPyoJFQ4MQCzdIkPyX_hj17BMpQqXI2FHJfYVA_xCC--dKJY-wEZQB3WTjbrpSxQNMBU4D0FPoQuf5ji31uOaA-xyotxEsUOem-0rQ3ISuhlM0PMJAABz6B10Zp3A_wDK7Nm8ycIyse3JtnfSIH6pjSCo-O_Iw4qRuckGFigu01I9g1yofYPyTeuE9_wM6g4lvVRa3DR_tEW1FPpPLLKYn1TlsoOIccLQrph7pwWRiowsUem6GG5Ybz587MZJpjwLmNfWDiOdxeUJO4USsfjr2HG22T9--fJ4JJs0KWiTiTJEkZVvo52JbG_cBI54qk7z5CJnVg47sOE9RV6eoV-87h1TtPi_pufv8KVxip0TlCCcmznWM25NJwdogmCK5L-y46BE1YIDbAXqD0-fD8dHR_CAhf2menXtFG9khlTuLIE4slZ28z47LUmEfKGzsIlJtEU6XkEQ-xoeYH6vMjumJPJnYXIh_pHSZsWVCK7Ysxdtkm-Ws4uKXX7ddYR5-C1BbZ4FXGAjLlhZsWSdCV1nV40QfvQBTRJZOBKd0jKhsqz85reulPUZz24XKYTHHEbmLMuNypYrl6MXSRsZ4sV5EaZLtWJ3mnp4F4OHwD5EmYjA:1nNArK:PuVp_pMqskzcxqrmbID0eHVyZ8fbgoD_WB97Jz0cJEk','2022-03-10 09:56:26.751088'),('x59dh53pz7dklgkkgrxb7bw776fpk4rp','.eJy9mNuOmzAQht-Fqx6SBsw5qrav0PumQgabBi2BiENXq1XevbYTyJhlUrIhuUEJiWe-f_z7-GZkRVoa6zcjY8baXhhtzauC7rixNuK0MQ4LI2_T9DXa82qX1XVWFlFb5VGe1U30zF9lS9lEvejCOAujyZpcxti0vkuCTesR29-0LrHEMwi8wBCZqlz8YSVbr2TrlXi3l82LNs_Fx-gUo_uq_i-_HI6UEWdZn9LTUqaWJ9KkoQXTD1LK1qtPP35-3z8_bTbs6-c-vwOSXxJwQtIkdGyM5x2aD9FcQsxNG3qecwFNNL4fWcVr3kT7F9bxBZAvtBImC-hxETJORBn9wLQGfCrEak_r-qWs2F1Qt6XwF_RUCCkdbscimm_TcU_J1ld7SqWkrK-LZcKUHktjmYyaMP0gpWjdZwz1AqDIfQEAdEcDHW5ZmMVRHNzic8ABi1sE8zjKhnr8RrQqpsm6KnOuuceyIWAQMiKexCfj9pExVjLG1R46Z4dGcjAjnUHGkkM3SQGwLKiEvixDERqdZiwXM9ZlPNxdM8NCo3mY0S6zom6bD3XHi1b3nDbxBzZLREjbdS94Tsb4mOdUdui5AJ-8TPH0OfUh1BiI5j9_UCdMjl4nIEgj1fwX4hPbVNQLXpwXHHiRmPikN5Ub9-Vs2DVPyoJFQ4MQCzdIkPyX_hj17BMpQqXI2FHJfYVA_xCC--dKJY-wEZQB3WTjbrpSxQNMBU4D0FPoQuf5ji31uOaA-xyotxEsUOem-0rQ3ISuhlM0PMJAABz6B10Zp3A_wDK7Nm8ycIyse3JtnfSIH6pjSCo-O_Iw4qRuckGFigu01I9g1yofYPyTeuE9_wM6g4lvVRa3DR_tEW1FPpPLLKYn1TlsoOIccLQrph7pwWRiowsUem6GG5Ybz587MZJpjwLmNfWDiOdxeUJO4USsfjr2HG22T9--fJ4JJs0KWiTiTJEkZVvo52JbG_cBI54qk7z5CJnVg47sOE9RV6eoV-87h1TtPi_pufv8KVxip0TlCCcmznWM25NJwdogmCK5L-y46BE1YIDbAXqD0-fD8dHR_CAhf2menXtFG9khlTuLIE4slZ28z47LUmEfKGzsIlJtEU6XkEQ-xoeYH6vMjumJPJnYXIh_pHSZsWVCK7Ysxdtkm-Ws4uKXX7ddYR5-C1BbZ4FXGAjLlhZsWSdCV1nV40QfvQBTRJZOBKd0jKhsqz85reulPUZz24XKYTHHEbmLMuNypYrl6MXSRsZ4sV5EaZLtWJ3mnp4F4OHwD5EmYjA:1nN7Ju:EAtMAxGXyXugRCnDuKWxrkOVYXXZHKb057vof_uhH4g','2022-03-10 06:09:42.959919'),('z8sdfao7z065ub4gb1ehnkrqxpiq4aic','.eJy9mNuSmzgQht-Fq2QzXoM4T21lL_ICW3sbpyiBREwNBheHnUql_O4ryTa0GDWxY4YbysZW9_e3fh1_WkWV19bzT6tg1rP7ZPUtbyp64NazleaddXqyyj7PfyRH3hyKti3qKumbMimLtkte-A_ZUjZRL65hvCerK7pSxtj1oU-iXR8QN9z1PnHEM4qCyBKZmlL8YStbb2XrrXh3lM2rvizFx-QS4_pV_V9-OZ0pE86KIWWgpcydQKTJYwemn6SUrbcf_v7nr-PL592Offo45PdA8jkBFyRNwpWN8fKKFkI0nxB718dB4M2gicbvR9bwlnfJ8ZVd-SLIFzsZkwUMuAiZZqKMYWQ7Ez4VYnukbftaN-xdUPe18Bf0VAwpPe6mIlroUrOnZOu7PaVSUjbUxbFhyoDlqUxGbZh-klK0HjLGegFQ5KEAAPpKAx3uOJjFURzc4kvAAYs7BPM4yoZ6_EG0JqXZc1OXXHOP40LAKGZEPElIzPaRMbYyxt0eGrNDI3mYkUYQU3LoJikAlgWVMJRlKkKj04zlY8aax8PdtTAsNFqAGW2eFXXbcqgHXvW657SJP3JZJkK6vj_jORnj9zynskPPRfjkZYtnyGkIoUwgmv_CSZ0wOXqdgCCNVPNfjE9st6LOeHFZcOBFYuOT3q3cuC8Xw255VlcsmRqEOLhBouyX9Oeoo0-kCJWiYGcl7ysE-ocQ3D93KlnDRlAGdJOLu-lOFSuYCpwGoKfQhS4IPVfq8e0J9xhosBEs0NVN7ytBcxO6Gt6iYQ0DAXDoH3RlvIV7Bcsc-rIrwDGyHci1dTIgYayOIbn47MnDiJf72YwKFRdoaddg1yofYfw39cJb_hU6g4lvTZH2HTf2iLYij-Qyix1IdR6bqBgDGrvi1iM9mExcdIFCz81ww_Lg-fMgRjIdUMC8pn4Q8QIuT8g5nIjVT-eeo93-859_fFwIJi8qWmXiTJFldV_p52JXG_cRI4Eqk7z5iJkzgBp2nJeo20vUu_edU6r-WNZ07L7wFi6xU6JyhBMb5zrHHcikYG0Q3CJ5KKxZtEENGOBuhN7gDPlwfHQ0ryTkP1oWY69oIzumcmcRpZmjspO32XFZKuyqwlpa8vZAK_qdixmtS7Im028dwX78y79f5P1VLqdHJwBjdBJkK4LcbXwTiG5-T5u7Yl8dB1LqKCyT501YE99LeWNV3wocCohLRNhZ_Vpp9GSePpU7opDN01-DrsE_DlXPnUEfR-4v0NHr1wUkmC7U1Vb3cplO5MO8VEgh4unZgchViE2y-EdONwXbZLRhm1q8zfZFyRoufvn62FX86ZsAdXUWeBWHsOxpxTZtJnTVTWsm-t2LXEXk6ERwa4IR1X3zvaRtu3FNNI9dDJ6elrjquUZZcNuliuXpxdJmeHOxXkVpsr2pTktvMxSgrwOOw3XWX-2evnDE7Y8tAQLqdPofnsZ8TA:1o5HW5:tBOYD_6ckVp5I7YmTDCXaqAITSBf3axrNzKMDqpWGaY','2022-07-10 01:56:49.720708');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rbac_menu`
--

DROP TABLE IF EXISTS `rbac_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rbac_menu` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `title` varchar(32) NOT NULL,
  `icon` varchar(32) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rbac_menu`
--

LOCK TABLES `rbac_menu` WRITE;
/*!40000 ALTER TABLE `rbac_menu` DISABLE KEYS */;
INSERT INTO `rbac_menu` VALUES (1,'权限管理','fa-hourglass-3'),(2,'用户管理','fa-id-card-o'),(3,'主机管理','fa-hand-scissors-o'),(4,'财务管理','fa-wrench'),(5,'销管管理','fa-handshake-o');
/*!40000 ALTER TABLE `rbac_menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rbac_permission`
--

DROP TABLE IF EXISTS `rbac_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rbac_permission` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `title` varchar(32) NOT NULL,
  `url` varchar(128) NOT NULL,
  `name` varchar(32) NOT NULL,
  `menu_id` bigint DEFAULT NULL,
  `pid_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `rbac_permission_menu_id_3dcc68be_fk` (`menu_id`),
  KEY `rbac_permission_pid_id_6939354d_fk` (`pid_id`),
  CONSTRAINT `rbac_permission_menu_id_3dcc68be_fk` FOREIGN KEY (`menu_id`) REFERENCES `rbac_menu` (`id`),
  CONSTRAINT `rbac_permission_pid_id_6939354d_fk` FOREIGN KEY (`pid_id`) REFERENCES `rbac_permission` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rbac_permission`
--

LOCK TABLES `rbac_permission` WRITE;
/*!40000 ALTER TABLE `rbac_permission` DISABLE KEYS */;
INSERT INTO `rbac_permission` VALUES (4,'用户列表','/user/list/','user_list',2,NULL),(6,'编辑用户','/user/edit/(?P<pk>\\d+)/','user_edit',NULL,4),(7,'删除用户','/user/del/(?P<pk>\\d+)/','user_del',NULL,4),(8,'重置密码','/user/reset/password/(?P<pk>\\d+)/','user_reset_pwd',NULL,4),(9,'主机列表','/host/list/','host_list',3,NULL),(10,'添加主机','/host/add/','host_add',NULL,9),(11,'编辑主机','/host/edit/(?P<pk>\\d+)/','host_edit',NULL,9),(12,'删除主机','/host/del/(?P<pk>\\d+)/','host_del',NULL,9),(13,'角色列表','/rbac/role/list/','rbac:role_list',1,NULL),(14,'添加角色','/rbac/role/add/','rbac:role_add',NULL,13),(15,'编辑角色','/rbac/role/edit/(?P<pk>\\d+)/','rbac:role_edit',NULL,13),(16,'删除角色','/rbac/role/del/(?P<pk>\\d+)/','rbac:role_del',NULL,13),(17,'菜单列表','/rbac/menu/list/','rbac:menu_list',1,NULL),(18,'添加一级菜单','/rbac/menu/add/','rbac:menu_add',NULL,17),(19,'编辑一级菜单','/rbac/menu/edit/(?P<pk>\\d+)/','rbac:menu_edit',NULL,17),(20,'删除一级菜单','/rbac/menu/del/(?P<pk>\\d+)/','rbac:menu_del',NULL,17),(21,'添加二级菜单','/rbac/second/menu/add/(?P<menu_id>\\d+)','rbac:second_menu_add',NULL,17),(22,'编辑二级菜单','/rbac/second/menu/edit/(?P<pk>\\d+)/','rbac:second_menu_edit',NULL,17),(23,'删除二级菜单','/rbac/second/menu/del/(?P<pk>\\d+)/','rbac:second_menu_del',NULL,17),(24,'添加权限','/rbac/permission/add/(?P<second_menu_id>\\d+)/','rbac:permission_add',NULL,17),(25,'编辑权限','/rbac/permission/edit/(?P<pk>\\d+)/','rbac:permission_edit',NULL,17),(26,'删除权限','/rbac/permission/del/(?P<pk>\\d+)/','rbac:permission_del',NULL,17),(27,'批量操作权限','/rbac/multi/permissions/','rbac:multi_permissions',NULL,17),(28,'批量删除权限','/rbac/multi/permissions/del/(?P<pk>\\d+)/','rbac:multi_permissions_del',NULL,17),(29,'权限分配','/rbac/distribute/permissions/','rbac:distribute_permissions',1,NULL),(31,'添加用户','/user/add/','user_add',NULL,4),(34,'media目录','/media/(?P<path>.*)','media',NULL,4),(36,'账务科目列表','/finance/account/list/','finance_account_list',4,NULL),(37,'账务科目上传','/finance/account/upload/','finance_account_upload',NULL,36),(38,'删除科目','/finance/account/del/(?P<pk>\\d+)/','finance_account_del',NULL,36),(39,'验证财务科目','/finance/account/valid/(?P<pk>\\d+)/','finance_account_valid',NULL,36),(40,'CRC导入','/salesmanagement/crc/list/','salesmanagement_crc_list',5,NULL),(41,'销管CRC上传','/salesmanagement/crc/upload/','salesmanagement_crc_upload',NULL,40),(42,'销管CRC下载','/salesmanagement/crc/download/','salesmanagement_crc_download',NULL,40),(43,'销管CRC删除','/salesmanagement/crc/del/(?P<pk>\\d+)/','salesmanagement_crc_del',NULL,40),(44,'档期导入','/salesmanagement/act/list/','salesmanagement_act_list',5,NULL),(45,'销管ACT上传','/salesmanagement/act/upload/','salesmanagement_act_upload',NULL,44),(46,'销管ACT下载','/salesmanagement/act/download/','salesmanagement_act_download',NULL,44),(47,'销管ACT删除','/salesmanagement/act/del/(?P<pk>\\d+)/','salesmanagement_act_del',NULL,44),(48,'销管ACT模板下载','/salesmanagement/act/download_model/','salesmanagement_act_download_mod',NULL,44),(49,'销管CRC模板下载','/salesmanagement/crc/download_model/','salesmanagement_crc_download_mod',NULL,40);
/*!40000 ALTER TABLE `rbac_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rbac_role`
--

DROP TABLE IF EXISTS `rbac_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rbac_role` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `title` varchar(32) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rbac_role`
--

LOCK TABLES `rbac_role` WRITE;
/*!40000 ALTER TABLE `rbac_role` DISABLE KEYS */;
INSERT INTO `rbac_role` VALUES (1,'管理员'),(2,'CTO'),(4,'文件上传检验'),(5,'销管CRC上传'),(6,'销管CRC管理员'),(7,'销管ACT上传'),(8,'销管ACT管理员');
/*!40000 ALTER TABLE `rbac_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rbac_role_permissions`
--

DROP TABLE IF EXISTS `rbac_role_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rbac_role_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `role_id` bigint NOT NULL,
  `permission_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `rbac_role_permissions_role_id_permission_id_d01303da_uniq` (`role_id`,`permission_id`),
  KEY `rbac_role_permission_permission_id_f5e1e866_fk_rbac_perm` (`permission_id`)
) ENGINE=InnoDB AUTO_INCREMENT=188 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rbac_role_permissions`
--

LOCK TABLES `rbac_role_permissions` WRITE;
/*!40000 ALTER TABLE `rbac_role_permissions` DISABLE KEYS */;
INSERT INTO `rbac_role_permissions` VALUES (116,1,4),(117,1,6),(118,1,7),(119,1,8),(120,1,9),(121,1,10),(122,1,11),(123,1,12),(124,1,13),(125,1,14),(126,1,15),(127,1,16),(128,1,17),(129,1,18),(130,1,19),(131,1,20),(132,1,21),(133,1,22),(134,1,23),(135,1,24),(136,1,25),(137,1,26),(138,1,27),(139,1,28),(140,1,29),(141,1,31),(142,1,34),(143,1,36),(144,1,37),(145,1,38),(146,1,39),(150,1,40),(151,1,41),(152,1,42),(156,1,43),(166,1,44),(167,1,45),(168,1,46),(169,1,47),(170,1,48),(187,1,49),(40,2,4),(82,2,6),(29,2,7),(80,2,8),(34,2,9),(32,2,10),(42,2,11),(81,2,12),(48,2,13),(47,2,14),(30,2,15),(36,2,16),(45,2,17),(31,2,18),(27,2,19),(39,2,20),(41,2,21),(46,2,22),(38,2,23),(43,2,24),(44,2,25),(28,2,26),(35,2,27),(33,2,28),(49,2,29),(83,2,31),(112,4,36),(113,4,37),(114,4,38),(115,4,39),(147,5,40),(148,5,41),(157,5,43),(186,5,49),(180,6,4),(181,6,6),(182,6,7),(183,6,8),(184,6,31),(153,6,40),(154,6,41),(155,6,42),(158,6,43),(185,6,49),(173,7,44),(164,7,45),(165,7,47),(171,7,48),(175,8,4),(176,8,6),(177,8,7),(178,8,8),(179,8,31),(160,8,44),(161,8,45),(162,8,46),(163,8,47),(172,8,48);
/*!40000 ALTER TABLE `rbac_role_permissions` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-08-02 10:55:25
