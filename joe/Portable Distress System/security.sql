-- MySQL dump 10.13  Distrib 8.0.30, for Win64 (x86_64)
--
-- Host: localhost    Database: security
-- ------------------------------------------------------
-- Server version	8.0.30

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',2,'add_permission'),(6,'Can change permission',2,'change_permission'),(7,'Can delete permission',2,'delete_permission'),(8,'Can view permission',2,'view_permission'),(9,'Can add group',3,'add_group'),(10,'Can change group',3,'change_group'),(11,'Can delete group',3,'delete_group'),(12,'Can view group',3,'view_group'),(13,'Can add user',4,'add_user'),(14,'Can change user',4,'change_user'),(15,'Can delete user',4,'delete_user'),(16,'Can view user',4,'view_user'),(17,'Can add content type',5,'add_contenttype'),(18,'Can change content type',5,'change_contenttype'),(19,'Can delete content type',5,'delete_contenttype'),(20,'Can view content type',5,'view_contenttype'),(21,'Can add session',6,'add_session'),(22,'Can change session',6,'change_session'),(23,'Can delete session',6,'delete_session'),(24,'Can view session',6,'view_session'),(25,'Can add contact_info',7,'add_contact_info'),(26,'Can change contact_info',7,'change_contact_info'),(27,'Can delete contact_info',7,'delete_contact_info'),(28,'Can view contact_info',7,'view_contact_info'),(29,'Can add incoming_info',8,'add_incoming_info'),(30,'Can change incoming_info',8,'change_incoming_info'),(31,'Can delete incoming_info',8,'delete_incoming_info'),(32,'Can view incoming_info',8,'view_incoming_info'),(33,'Can add relation_users',9,'add_relation_users'),(34,'Can change relation_users',9,'change_relation_users'),(35,'Can delete relation_users',9,'delete_relation_users'),(36,'Can view relation_users',9,'view_relation_users'),(37,'Can add site',10,'add_site'),(38,'Can change site',10,'change_site'),(39,'Can delete site',10,'delete_site'),(40,'Can view site',10,'view_site');
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
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (3,'pbkdf2_sha256$390000$bKynd0xztjdSZhjIVX1bpn$lvG0+r5DXQIlUKoP2Fnd2hvsRGhY8+mQT70SNROR77U=','2023-02-13 00:36:41.636046',1,'admin','','','',1,1,'2023-02-02 17:23:36.363745'),(9,'pbkdf2_sha256$390000$3iO5gax5US1KzxSSMzEShr$YJH/83Yyr7sc8GeBarpgK3E1WGKrFc2yk4i6FOe6lMY=','2023-03-11 03:29:07.737813',0,'nikhil931','Nikhil','Tomar','nikhiltomar931@gmail.com',0,1,'2023-02-06 07:02:51.548059'),(10,'pbkdf2_sha256$390000$JDoHvIfgVfCloB3Ua2hXSJ$9YwL2nUKEX4PbtSSkAQn/r31oHXNyRoa9ITINI6vt6M=','2023-02-16 17:34:24.777495',0,'crimsonglare','Anirudh','Boddu','glennradar069@gmail.com',0,1,'2023-02-16 02:03:55.256852'),(11,'pbkdf2_sha256$390000$1deH8YCYaeRBRWyc4UZGAh$Gu8ZlT96M0OMroBVIWlkJR7ldxg084HfB0fVpe0sqpM=','2023-02-16 15:00:14.132403',0,'sahil9','Sahil','Merothia','sahil.merothia.22cse@bmu.edu.in',0,1,'2023-02-16 02:31:17.982158'),(12,'pbkdf2_sha256$390000$CxsSrG8t8juxFREBFhQeh6$iepwE4kIjh/o9ikGv/Fo5AvgUpxEjirZUMds4TQnD+s=','2023-02-28 12:20:42.079565',0,'vishwajeet123','Vishwajeet','Tripathi','vishwajeet.tripathi.22cse@bmu.edu.in',0,1,'2023-02-16 15:22:17.210582'),(13,'pbkdf2_sha256$390000$JRduj9fl7hl0LBYJLOb3eq$BPxD5UIa2twP2wx8k7MnCUbDadO9wx84769fMGSm2v0=','2023-02-16 17:21:28.374106',0,'divas1','Divas','Sharma','divas.sharma.22cse@bmu.edu.in',0,1,'2023-02-16 17:20:52.477903'),(14,'pbkdf2_sha256$390000$5UemL4JHROuY92HUA1Y4Pc$wQ088Aa+uFOlnjg34w4BzP7tv7QjrrsV+2y6YRIHhKs=','2023-03-11 03:30:46.928280',0,'nick931','Nikhil','Tomar','nikhiltomar123@dsgm.com',0,1,'2023-03-11 03:30:38.205465');
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'2023-02-02 17:24:11.929341','2','asdf',3,'',4,3),(2,'2023-02-02 17:24:11.990269','1','nikhil',3,'',4,3),(3,'2023-02-02 17:26:12.775667','4','nikhil931',3,'',4,3),(4,'2023-02-02 18:15:04.618732','6','nikhil',3,'',4,3),(5,'2023-02-02 18:15:04.760901','7','nikhil02',3,'',4,3),(6,'2023-02-02 18:15:04.785354','5','nikhil931',3,'',4,3);
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
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(3,'auth','group'),(2,'auth','permission'),(4,'auth','user'),(5,'contenttypes','contenttype'),(7,'security','contact_info'),(8,'security','incoming_info'),(9,'security','relation_users'),(6,'sessions','session'),(10,'sites','site');
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
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2023-01-31 12:32:33.911375'),(2,'auth','0001_initial','2023-01-31 12:32:36.813023'),(3,'admin','0001_initial','2023-01-31 12:32:37.379549'),(4,'admin','0002_logentry_remove_auto_add','2023-01-31 12:32:37.418991'),(5,'admin','0003_logentry_add_action_flag_choices','2023-01-31 12:32:37.455674'),(6,'contenttypes','0002_remove_content_type_name','2023-01-31 12:32:37.777804'),(7,'auth','0002_alter_permission_name_max_length','2023-01-31 12:32:38.079793'),(8,'auth','0003_alter_user_email_max_length','2023-01-31 12:32:38.167842'),(9,'auth','0004_alter_user_username_opts','2023-01-31 12:32:38.210419'),(10,'auth','0005_alter_user_last_login_null','2023-01-31 12:32:38.442747'),(11,'auth','0006_require_contenttypes_0002','2023-01-31 12:32:38.475624'),(12,'auth','0007_alter_validators_add_error_messages','2023-01-31 12:32:38.514738'),(13,'auth','0008_alter_user_username_max_length','2023-01-31 12:32:38.747432'),(14,'auth','0009_alter_user_last_name_max_length','2023-01-31 12:32:38.960376'),(15,'auth','0010_alter_group_name_max_length','2023-01-31 12:32:39.026385'),(16,'auth','0011_update_proxy_permissions','2023-01-31 12:32:39.068022'),(17,'auth','0012_alter_user_first_name_max_length','2023-01-31 12:32:39.278547'),(18,'sessions','0001_initial','2023-01-31 12:32:39.549130'),(19,'security','0001_initial','2023-02-02 17:48:04.697145'),(20,'security','0002_incoming_info','2023-02-07 17:13:53.372919'),(21,'security','0003_alter_incoming_info_roll','2023-02-07 17:15:21.953912'),(22,'security','0004_alter_contact_info_email_alter_contact_info_phone','2023-02-08 11:51:36.495328'),(23,'security','0005_contact_info_date_time','2023-02-08 11:56:56.763376'),(24,'security','0006_remove_contact_info_date_time','2023-02-08 11:57:48.712908'),(25,'security','0007_incoming_info_date_time','2023-02-08 11:58:15.896810'),(26,'security','0008_relation_users','2023-02-10 10:02:07.526875'),(27,'security','0009_alter_relation_users_relation','2023-02-10 10:02:56.722007'),(28,'security','0010_alter_relation_users_relation','2023-02-16 02:40:49.146095'),(29,'sites','0001_initial','2023-03-05 18:55:37.828348'),(30,'sites','0002_alter_domain_unique','2023-03-05 18:55:38.097010');
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('01hp926u80p8q8dbi4pwqllbktmmf7er','.eJxVjMsOwiAQRf-FtSEdqDxcuu83kGEYpGogKe3K-O_apAvd3nPOfYmA21rC1nkJcxIXAYM4_Y4R6cF1J-mO9dYktbouc5S7Ig_a5dQSP6-H-3dQsJdvPRCDBhXZGjCUgSgpJozZ2RhxTE4Z9grAQGbvyKA-j94TaCYLWTvx_gAk9jiP:1pSOTc:Nn_Uk9iE_D6qXesnS9cVMs70Xm7O-ShZLaFJIW2FKeA','2023-03-02 02:04:04.946637'),('2ithxby2wkhyel4jrespivyuhaxf9sdr','.eJxVjMsOwiAQRf-FtSHyBpfu-w0EZgapGkhKuzL-uzbpQrf3nHNfLKZtrXEbtMQZ2YUFdvrdcoIHtR3gPbVb59DbusyZ7wo_6OBTR3peD_fvoKZRvzWhQLLSO2OdTd6B9ArJZzw7zLooIYMr2mkTTNFK-QBoMxEE1AIUafb-AOczOAE:1pV8aZ:phEiAFg25awdPjYFEG00p917yC6ukNGQepz9H8xrY7Q','2023-03-09 15:42:35.876918'),('jehcgk0jhz0m0j4xe8h8hmpswnnohew7','.eJxVjMsOwiAQRf-FtSHQ4enSvd9ABgakaiAp7cr479qkC93ec859sYDbWsM28hJmYmcm2el3i5geue2A7thunafe1mWOfFf4QQe_dsrPy-H-HVQc9Vt7TdGhUCh9Es4aihMVS0UhaFlc9s4Iyj6Tg0IgNExK64RgPaA02rP3B-4EN7c:1pMq9Q:aPvTf0LCoPJrUIAZaGOJIU22je8NsoPhpUs41ElwDUg','2023-02-14 12:54:16.918752'),('k8dteydk5e7zskfz5yjnkxq8ej34pgzh','.eJxVjMsOwiAQRf-FtSHQ4enSvd9ABgakaiAp7cr479qkC93ec859sYDbWsM28hJmYmcm2el3i5geue2A7thunafe1mWOfFf4QQe_dsrPy-H-HVQc9Vt7TdGhUCh9Es4aihMVS0UhaFlc9s4Iyj6Tg0IgNExK64RgPaA02rP3B-4EN7c:1pMuj8:YxP-GKaQ-1JXQZndA7y0DjESDHp8-WqtaIswE4W3wO0','2023-02-14 17:47:26.113663'),('mk1502ur9cfew1j5c5y10lwg1m65ltok','.eJxVjDsOwjAQRO_iGlm2lyU2JT1niPYHCSBHyqdC3J1ESgHlzHszb9fSMnftMtnY9urODtzht2OSp9UN6IPqffAy1Hns2W-K3-nkr4Pa67K7fwcdTd26jtlAODNTlgYjhphPUKCBsmZIYoSI2TAcS2JSFk3SEISIhjctwX2-1Io3ow:1pNdJR:UpwSyY79xuT92Ymwq6VD9b8ksWeSfPuv3m7Vx2qGJWY','2023-02-16 17:23:53.851672');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_site`
--

DROP TABLE IF EXISTS `django_site`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_site` (
  `id` int NOT NULL AUTO_INCREMENT,
  `domain` varchar(100) NOT NULL,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_site_domain_a2e37b91_uniq` (`domain`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_site`
--

LOCK TABLES `django_site` WRITE;
/*!40000 ALTER TABLE `django_site` DISABLE KEYS */;
INSERT INTO `django_site` VALUES (1,'example.com','example.com');
/*!40000 ALTER TABLE `django_site` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `security_contact_info`
--

DROP TABLE IF EXISTS `security_contact_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `security_contact_info` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `phone` varchar(10) NOT NULL,
  `email` varchar(254) NOT NULL,
  `roll_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `roll_id` (`roll_id`),
  UNIQUE KEY `security_contact_info_email_d7f702f0_uniq` (`email`),
  UNIQUE KEY `security_contact_info_phone_d0a02572_uniq` (`phone`),
  CONSTRAINT `security_contact_info_roll_id_23e8087d_fk_auth_user_id` FOREIGN KEY (`roll_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `security_contact_info`
--

LOCK TABLES `security_contact_info` WRITE;
/*!40000 ALTER TABLE `security_contact_info` DISABLE KEYS */;
INSERT INTO `security_contact_info` VALUES (4,'9711289867','nikhiltomar931@gmail.com',9),(5,'7838067309','nikhiltomar631@gmail.com',3),(6,'9830562622','glennradar069@gmail.com',10),(7,'7037977533','sahil.merothia.22cse@bmu.edu.in',11),(8,'7027723221','vishwajeet.tripathi.22cse@bmu.edu.in',12),(9,'7417828850','divas.sharma.22cse@bmu.edu.in',13),(10,'9311289867','nikhiltomar123@dsgm.com',14);
/*!40000 ALTER TABLE `security_contact_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `security_incoming_info`
--

DROP TABLE IF EXISTS `security_incoming_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `security_incoming_info` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `coordinate_x` varchar(354) NOT NULL,
  `coordinate_y` varchar(354) NOT NULL,
  `emergency` tinyint(1) NOT NULL,
  `roll_id` int NOT NULL,
  `date_time` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `security_incoming_info_roll_id_e97936f6` (`roll_id`),
  CONSTRAINT `security_incoming_in_roll_id_e97936f6_fk_security_` FOREIGN KEY (`roll_id`) REFERENCES `security_contact_info` (`roll_id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `security_incoming_info`
--

LOCK TABLES `security_incoming_info` WRITE;
/*!40000 ALTER TABLE `security_incoming_info` DISABLE KEYS */;
INSERT INTO `security_incoming_info` VALUES (1,'1','1',1,9,'2023-02-16 15:06:33.365577'),(2,'99','99',1,9,'2023-02-16 15:52:15.332461'),(3,'23','24',1,13,'2023-02-16 17:23:41.954842'),(4,'23','14',0,13,'2023-02-16 17:31:34.763676'),(5,'23','14',0,13,'2023-02-16 17:35:18.761065'),(6,'23','14',0,10,'2023-02-16 17:44:05.489970'),(7,'23','14',0,10,'2023-02-16 17:47:34.665467'),(8,'23','14',0,10,'2023-02-16 17:48:45.041956'),(9,'11.11','23,21',0,9,'2023-02-16 23:13:54.251970'),(10,'23','14',0,9,'2023-02-17 11:30:30.232632'),(11,'1','1',1,9,'2023-02-28 12:18:26.145503'),(12,'1','1',1,9,'2023-02-28 12:18:38.234366'),(13,'1','1',1,9,'2023-02-28 12:21:10.171265'),(14,'1','1',1,12,'2023-02-28 12:21:12.442340'),(15,'1','1',1,9,'2023-02-28 12:21:31.278049'),(16,'1','1',1,12,'2023-02-28 16:07:44.322130'),(17,'1','1',1,9,'2023-02-28 16:07:45.327208'),(18,'1','1',1,12,'2023-02-28 16:07:49.007025'),(19,'1','1',1,9,'2023-02-28 16:08:18.382919');
/*!40000 ALTER TABLE `security_incoming_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `security_relation_users`
--

DROP TABLE IF EXISTS `security_relation_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `security_relation_users` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `relation_id` int NOT NULL,
  `roll_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `security_relation_us_roll_id_35993b7e_fk_security_` (`roll_id`),
  KEY `security_relation_users_relation_id_389d2960` (`relation_id`),
  CONSTRAINT `security_relation_us_relation_id_389d2960_fk_security_` FOREIGN KEY (`relation_id`) REFERENCES `security_contact_info` (`roll_id`),
  CONSTRAINT `security_relation_us_roll_id_35993b7e_fk_security_` FOREIGN KEY (`roll_id`) REFERENCES `security_contact_info` (`roll_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `security_relation_users`
--

LOCK TABLES `security_relation_users` WRITE;
/*!40000 ALTER TABLE `security_relation_users` DISABLE KEYS */;
/*!40000 ALTER TABLE `security_relation_users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-03-11  3:44:49
