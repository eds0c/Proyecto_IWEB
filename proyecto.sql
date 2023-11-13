CREATE DATABASE  IF NOT EXISTS `proyecto` /*!40100 DEFAULT CHARACTER SET utf8mb3 */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `proyecto`;
-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: localhost    Database: proyecto
-- ------------------------------------------------------
-- Server version	8.0.34

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `actividad`
--

DROP TABLE IF EXISTS `actividad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `actividad` (
  `idActividad` int NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(45) NOT NULL,
  `foto` blob,
  `estado` varchar(45) DEFAULT 'activa',
  `titulo` varchar(45) NOT NULL,
  PRIMARY KEY (`idActividad`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `actividad`
--

LOCK TABLES `actividad` WRITE;
/*!40000 ALTER TABLE `actividad` DISABLE KEYS */;
INSERT INTO `actividad` VALUES (1,'VALORANT des',NULL,'activa','VALORANT'),(2,'LOL des',NULL,'activa','LOL'),(3,'DOTA 2 des',NULL,'activa','DOTA 2'),(4,'AJEDREZ des',NULL,'activa','AJEDREZ'),(5,'DANZA des',NULL,'activa','DANZA');
/*!40000 ALTER TABLE `actividad` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `alumno`
--

DROP TABLE IF EXISTS `alumno`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alumno` (
  `idAlumno` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) NOT NULL,
  `apellido` varchar(45) NOT NULL,
  `codigo` varchar(45) NOT NULL,
  `correo` varchar(45) NOT NULL,
  `contrasena` varchar(45) NOT NULL,
  `egresado` varchar(45) NOT NULL,
  `foto` blob,
  `motivo` varchar(45) NOT NULL,
  `fecha_aprob` date NOT NULL,
  `Delegado_Actividad_idDelegado_Actividad` int DEFAULT NULL,
  `Estado_Alumno_idEstado_Alumno` int NOT NULL,
  `Delegado_General_idDelegado_General` int DEFAULT NULL,
  PRIMARY KEY (`idAlumno`),
  UNIQUE KEY `Delegado_Actividad_idDelegado_Actividad_UNIQUE` (`Delegado_Actividad_idDelegado_Actividad`),
  KEY `fk_Alumno_Delegado_Actvidad1_idx` (`Delegado_Actividad_idDelegado_Actividad`),
  KEY `fk_Alumno_Estado_Alumno1_idx` (`Estado_Alumno_idEstado_Alumno`),
  KEY `fk_Alumno_Delegado_General1_idx` (`Delegado_General_idDelegado_General`),
  CONSTRAINT `fk_Alumno_Delegado_Actvidad1` FOREIGN KEY (`Delegado_Actividad_idDelegado_Actividad`) REFERENCES `delegado_actividad` (`idDelegado_Actividad`),
  CONSTRAINT `fk_Alumno_Delegado_General1` FOREIGN KEY (`Delegado_General_idDelegado_General`) REFERENCES `delegado_general` (`idDelegado_General`),
  CONSTRAINT `fk_Alumno_Estado_Alumno1` FOREIGN KEY (`Estado_Alumno_idEstado_Alumno`) REFERENCES `estado_alumno` (`idEstado_Alumno`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alumno`
--

LOCK TABLES `alumno` WRITE;
/*!40000 ALTER TABLE `alumno` DISABLE KEYS */;
INSERT INTO `alumno` VALUES (1,'Juan','Perez','20201001','1@gmail.com','1','n',NULL,'motivo 1','2023-10-10',1,1,1),(2,'Pedro','Flores','20201002','2@gmail.com','2','n',NULL,'motivo 2','2023-10-12',2,1,1),(3,'Hugo','Cespedes','20201003','3@gmail.com','3','n',NULL,'motivo 2','2023-10-12',3,1,2),(4,'Pancho','Gonzales','20000000','4@gmail.com','4','n',NULL,'dd','2023-10-12',4,1,NULL),(5,'Antony','Benito','20212020','5@gmail.com','5','n',NULL,'ttttt','2023-10-12',5,1,NULL);
/*!40000 ALTER TABLE `alumno` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `alumno_evento`
--

DROP TABLE IF EXISTS `alumno_evento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alumno_evento` (
  `idAlumno_Evento` int NOT NULL AUTO_INCREMENT,
  `Alumno_idAlumno` int NOT NULL,
  `Integrante_idIntegrante` int NOT NULL,
  `Evento_idEvento` int NOT NULL,
  PRIMARY KEY (`Alumno_idAlumno`,`Integrante_idIntegrante`,`Evento_idEvento`),
  UNIQUE KEY `idAlumno_Evento_UNIQUE` (`idAlumno_Evento`),
  KEY `fk_Alumno_evento_Alumno_idx` (`Alumno_idAlumno`),
  KEY `fk_Alumno_evento_Integrante1_idx` (`Integrante_idIntegrante`),
  KEY `fk_Alumno_evento_Evento1_idx` (`Evento_idEvento`),
  CONSTRAINT `fk_Alumno_evento_Alumno` FOREIGN KEY (`Alumno_idAlumno`) REFERENCES `alumno` (`idAlumno`),
  CONSTRAINT `fk_Alumno_evento_Evento1` FOREIGN KEY (`Evento_idEvento`) REFERENCES `evento` (`idEvento`),
  CONSTRAINT `fk_Alumno_evento_Integrante1` FOREIGN KEY (`Integrante_idIntegrante`) REFERENCES `integrante` (`idIntegrante`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alumno_evento`
--

LOCK TABLES `alumno_evento` WRITE;
/*!40000 ALTER TABLE `alumno_evento` DISABLE KEYS */;
INSERT INTO `alumno_evento` VALUES (1,1,2,1),(3,3,2,1),(6,1,2,4),(7,2,3,7),(19,2,1,1),(22,2,3,2),(23,2,3,5),(24,2,3,4),(25,2,3,3),(27,2,3,9);
/*!40000 ALTER TABLE `alumno_evento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `delegado_actividad`
--

DROP TABLE IF EXISTS `delegado_actividad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `delegado_actividad` (
  `idDelegado_Actividad` int NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(45) DEFAULT NULL,
  `fecha_aprob` date DEFAULT NULL,
  `Actividad_idActividad` int NOT NULL,
  `Delegado_General_idDelegado_General` int NOT NULL,
  PRIMARY KEY (`idDelegado_Actividad`),
  KEY `fk_Delegado_Actvidad_Actividad1_idx` (`Actividad_idActividad`),
  KEY `fk_Delegado_Actvidad_Delegado_General1_idx` (`Delegado_General_idDelegado_General`),
  CONSTRAINT `fk_Delegado_Actvidad_Actividad1` FOREIGN KEY (`Actividad_idActividad`) REFERENCES `actividad` (`idActividad`),
  CONSTRAINT `fk_Delegado_Actvidad_Delegado_General1` FOREIGN KEY (`Delegado_General_idDelegado_General`) REFERENCES `delegado_general` (`idDelegado_General`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `delegado_actividad`
--

LOCK TABLES `delegado_actividad` WRITE;
/*!40000 ALTER TABLE `delegado_actividad` DISABLE KEYS */;
INSERT INTO `delegado_actividad` VALUES (1,'111','2023-10-10',1,1),(2,'222','2023-10-10',2,1),(3,'333','2023-10-10',3,1),(4,'444','2023-10-10',4,1),(5,'555','2023-10-10',5,1);
/*!40000 ALTER TABLE `delegado_actividad` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `delegado_general`
--

DROP TABLE IF EXISTS `delegado_general`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `delegado_general` (
  `idDelegado_General` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) NOT NULL,
  `apellido` varchar(45) NOT NULL,
  `codigo` varchar(45) NOT NULL,
  `correo` varchar(45) NOT NULL,
  `contrasena` varchar(45) NOT NULL,
  `foto` blob,
  PRIMARY KEY (`idDelegado_General`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `delegado_general`
--

LOCK TABLES `delegado_general` WRITE;
/*!40000 ALTER TABLE `delegado_general` DISABLE KEYS */;
INSERT INTO `delegado_general` VALUES (1,'Pedro','Picapiedra','1111','gen1@gmail.com','1',NULL),(2,'Pablo','Marmol','2222','gen2@gmail.com','2',NULL),(3,'Homero','Simpson','3333','gen3@gmail.com','3',NULL),(4,'Peter','Griffin','4444','gen4@gmail.com','4',NULL);
/*!40000 ALTER TABLE `delegado_general` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `delegado_general_has_actividad`
--

DROP TABLE IF EXISTS `delegado_general_has_actividad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `delegado_general_has_actividad` (
  `Delegado_General_idDelegado_General` int NOT NULL,
  `Actividad_idActividad` int NOT NULL,
  PRIMARY KEY (`Delegado_General_idDelegado_General`,`Actividad_idActividad`),
  KEY `fk_Delegado_General_has_Actividad_Actividad1_idx` (`Actividad_idActividad`),
  KEY `fk_Delegado_General_has_Actividad_Delegado_General1_idx` (`Delegado_General_idDelegado_General`),
  CONSTRAINT `fk_Delegado_General_has_Actividad_Actividad1` FOREIGN KEY (`Actividad_idActividad`) REFERENCES `actividad` (`idActividad`),
  CONSTRAINT `fk_Delegado_General_has_Actividad_Delegado_General1` FOREIGN KEY (`Delegado_General_idDelegado_General`) REFERENCES `delegado_general` (`idDelegado_General`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `delegado_general_has_actividad`
--

LOCK TABLES `delegado_general_has_actividad` WRITE;
/*!40000 ALTER TABLE `delegado_general_has_actividad` DISABLE KEYS */;
/*!40000 ALTER TABLE `delegado_general_has_actividad` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `donacion`
--

DROP TABLE IF EXISTS `donacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `donacion` (
  `idDonacion` int NOT NULL AUTO_INCREMENT,
  `monto` varchar(45) NOT NULL,
  `captura` blob NOT NULL,
  `estado` varchar(45) NOT NULL,
  `fecha` varchar(45) NOT NULL,
  `motivo` varchar(45) NOT NULL,
  `Alumno_idAlumno` int NOT NULL,
  `Tipo_Donacion_idTipo_Donacion` int NOT NULL,
  `Delegado_General_idDelegado_General` int NOT NULL,
  PRIMARY KEY (`idDonacion`),
  KEY `fk_Donacion_Alumno1_idx` (`Alumno_idAlumno`),
  KEY `fk_Donacion_Tipo_Donacion1_idx` (`Tipo_Donacion_idTipo_Donacion`),
  KEY `fk_Donacion_Delegado_General1_idx` (`Delegado_General_idDelegado_General`),
  CONSTRAINT `fk_Donacion_Alumno1` FOREIGN KEY (`Alumno_idAlumno`) REFERENCES `alumno` (`idAlumno`),
  CONSTRAINT `fk_Donacion_Delegado_General1` FOREIGN KEY (`Delegado_General_idDelegado_General`) REFERENCES `delegado_general` (`idDelegado_General`),
  CONSTRAINT `fk_Donacion_Tipo_Donacion1` FOREIGN KEY (`Tipo_Donacion_idTipo_Donacion`) REFERENCES `tipo_donacion` (`idTipo_Donacion`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `donacion`
--

LOCK TABLES `donacion` WRITE;
/*!40000 ALTER TABLE `donacion` DISABLE KEYS */;
/*!40000 ALTER TABLE `donacion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `estado_alumno`
--

DROP TABLE IF EXISTS `estado_alumno`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `estado_alumno` (
  `idEstado_Alumno` int NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(45) NOT NULL,
  PRIMARY KEY (`idEstado_Alumno`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `estado_alumno`
--

LOCK TABLES `estado_alumno` WRITE;
/*!40000 ALTER TABLE `estado_alumno` DISABLE KEYS */;
INSERT INTO `estado_alumno` VALUES (1,'Activo'),(2,'Baneado'),(3,'Pendiente'),(4,'Rechazado');
/*!40000 ALTER TABLE `estado_alumno` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `evento`
--

DROP TABLE IF EXISTS `evento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `evento` (
  `idEvento` int NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(45) NOT NULL,
  `fechaIn` date NOT NULL,
  `participantes` int DEFAULT NULL,
  `estado` varchar(45) NOT NULL DEFAULT 'a',
  `foto` blob,
  `fechaFin` date DEFAULT NULL,
  `Actividad_idActividad` int NOT NULL,
  `lugar` varchar(45) NOT NULL,
  `hora` time NOT NULL,
  `titulo` varchar(45) NOT NULL,
  PRIMARY KEY (`idEvento`),
  KEY `fk_Evento_Actividad1_idx` (`Actividad_idActividad`),
  CONSTRAINT `fk_Evento_Actividad1` FOREIGN KEY (`Actividad_idActividad`) REFERENCES `actividad` (`idActividad`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `evento`
--

LOCK TABLES `evento` WRITE;
/*!40000 ALTER TABLE `evento` DISABLE KEYS */;
INSERT INTO `evento` VALUES (1,'descripcion','2023-11-04',1,'a','','2023-10-31',1,'v307','07:37:00','Fibra Toxica vs Hormigon Armado'),(2,'descripcion','2023-11-04',1,'f','','2023-10-31',1,'v307','04:37:00','Fibra Toxica vs Hormigon Armado'),(3,'descripcion','2023-11-04',1,'a','','2023-10-31',1,'v307','04:37:00','Fibra Toxica vs Hormigon Armado'),(4,'descripcion','2023-11-04',1,'a','','2023-10-31',1,'v307','04:37:00','Fibra Toxica vs Hormigon Armado'),(5,'descripcion','2023-11-04',1,'f','','2023-10-31',1,'lugar 2','04:37:00','Fibra Toxica vs Hormigon Armado'),(7,'descripcion','2023-11-04',1,'a','','2023-10-31',1,'lugar 2','04:37:00','Fibra Toxica vs Hormigon Armado'),(9,'descripcion','2023-11-04',1,'a','','2023-10-31',2,'lugar 2','04:37:00','Fibra Toxica vs Hormigon Armado'),(12,'descripcion','2023-11-04',1,'f','','2023-10-31',1,'lugar 2','04:37:00','Huascaminas vs '),(13,'descripcion','2023-11-04',NULL,'a','','2023-10-31',2,'lugar 2','04:37:00','Descontrol Automático vs Memoria Caché'),(14,'descripcion','2023-11-04',NULL,'f','','2023-10-31',1,'lugar 2','04:37:00','Fibra Toxica vs Hormigon Armado'),(15,'descripcion','2023-11-04',NULL,'f','','2023-10-31',1,'lugar 2','04:37:00','Descontrol Automático vs Memoria Caché'),(16,'descripcion','2023-11-04',NULL,'f','','2023-10-31',1,'lugar 2','04:37:00','Descontrol Automático vs Hormigón Armado'),(18,'descripcion','2023-11-04',NULL,'a','','2023-10-31',2,'lugar 3','04:37:00','Descontrol Automático vs Memoria Caché'),(19,'descripcion','2023-11-04',NULL,'f','','2023-10-31',2,'lugar 4','04:37:00','Armado'),(20,'descripcion','2023-11-04',NULL,'a','','2023-10-31',2,'lugar 2','04:37:00','Armado'),(23,'adsadas','2023-11-04',NULL,'a',NULL,'2023-10-31',2,'aqui','04:37:00','yo vs yo'),(24,'WW3','2023-11-23',NULL,'a','',NULL,1,'CIA','23:32:00','America vs Europa'),(25,'ddedede','2023-11-17',NULL,'a',_binary 'league-of-legends-01.jpg',NULL,1,'aaaa','23:33:00','aaaaaaaa'),(26,'ffff','2023-11-24',NULL,'a','',NULL,1,'Marte','06:24:00','USA vs Haytii');
/*!40000 ALTER TABLE `evento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `integrante`
--

DROP TABLE IF EXISTS `integrante`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `integrante` (
  `idIntegrante` int NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(45) NOT NULL,
  PRIMARY KEY (`idIntegrante`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `integrante`
--

LOCK TABLES `integrante` WRITE;
/*!40000 ALTER TABLE `integrante` DISABLE KEYS */;
INSERT INTO `integrante` VALUES (1,'Equipo'),(2,'Barra'),(3,'Pendiente');
/*!40000 ALTER TABLE `integrante` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipo_donacion`
--

DROP TABLE IF EXISTS `tipo_donacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tipo_donacion` (
  `idTipo_Donacion` int NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(45) NOT NULL,
  PRIMARY KEY (`idTipo_Donacion`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipo_donacion`
--

LOCK TABLES `tipo_donacion` WRITE;
/*!40000 ALTER TABLE `tipo_donacion` DISABLE KEYS */;
/*!40000 ALTER TABLE `tipo_donacion` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-11-13  1:34:31
