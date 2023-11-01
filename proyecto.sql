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
  `estado` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idActividad`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `actividad`
--

LOCK TABLES `actividad` WRITE;
/*!40000 ALTER TABLE `actividad` DISABLE KEYS */;
INSERT INTO `actividad` VALUES (1,'VALORANT',NULL,'a'),(2,'LOL',NULL,'a'),(3,'DOTA 2',NULL,'a'),(4,'AJEDREZ',NULL,'a'),(5,'DANZA',NULL,'a');
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
  `Delegado_Actvidad_idDelegado_Actvidad` int NOT NULL,
  `Estado_Alumno_idEstado_Alumno` int NOT NULL,
  `Delegado_General_idDelegado_General` int NOT NULL,
  PRIMARY KEY (`idAlumno`),
  KEY `fk_Alumno_Delegado_Actvidad1_idx` (`Delegado_Actvidad_idDelegado_Actvidad`),
  KEY `fk_Alumno_Estado_Alumno1_idx` (`Estado_Alumno_idEstado_Alumno`),
  KEY `fk_Alumno_Delegado_General1_idx` (`Delegado_General_idDelegado_General`),
  CONSTRAINT `fk_Alumno_Delegado_Actvidad1` FOREIGN KEY (`Delegado_Actvidad_idDelegado_Actvidad`) REFERENCES `delegado_actvidad` (`idDelegado_Actvidad`),
  CONSTRAINT `fk_Alumno_Delegado_General1` FOREIGN KEY (`Delegado_General_idDelegado_General`) REFERENCES `delegado_general` (`idDelegado_General`),
  CONSTRAINT `fk_Alumno_Estado_Alumno1` FOREIGN KEY (`Estado_Alumno_idEstado_Alumno`) REFERENCES `estado_alumno` (`idEstado_Alumno`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alumno`
--

LOCK TABLES `alumno` WRITE;
/*!40000 ALTER TABLE `alumno` DISABLE KEYS */;
INSERT INTO `alumno` VALUES (1,'Juan','Perez','20201001','1@gmail.com','1','n',NULL,'motivo 1','2023-10-10',1,1,1);
/*!40000 ALTER TABLE `alumno` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `alumno_evento`
--

DROP TABLE IF EXISTS `alumno_evento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alumno_evento` (
  `Alumno_idAlumno` int NOT NULL,
  `Integrante_idIntegrante` int NOT NULL,
  `Evento_idEvento` int NOT NULL,
  KEY `fk_Alumno_evento_Alumno_idx` (`Alumno_idAlumno`),
  KEY `fk_Alumno_evento_Integrante1_idx` (`Integrante_idIntegrante`),
  KEY `fk_Alumno_evento_Evento1_idx` (`Evento_idEvento`),
  CONSTRAINT `fk_Alumno_evento_Alumno` FOREIGN KEY (`Alumno_idAlumno`) REFERENCES `alumno` (`idAlumno`),
  CONSTRAINT `fk_Alumno_evento_Evento1` FOREIGN KEY (`Evento_idEvento`) REFERENCES `evento` (`idEvento`),
  CONSTRAINT `fk_Alumno_evento_Integrante1` FOREIGN KEY (`Integrante_idIntegrante`) REFERENCES `integrante` (`idIntegrante`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alumno_evento`
--

LOCK TABLES `alumno_evento` WRITE;
/*!40000 ALTER TABLE `alumno_evento` DISABLE KEYS */;
/*!40000 ALTER TABLE `alumno_evento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `delegado_actvidad`
--

DROP TABLE IF EXISTS `delegado_actvidad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `delegado_actvidad` (
  `idDelegado_Actvidad` int NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(45) DEFAULT NULL,
  `fecha_aprob` date DEFAULT NULL,
  `Actividad_idActividad` int NOT NULL,
  `Delegado_General_idDelegado_General` int NOT NULL,
  PRIMARY KEY (`idDelegado_Actvidad`),
  KEY `fk_Delegado_Actvidad_Actividad1_idx` (`Actividad_idActividad`),
  KEY `fk_Delegado_Actvidad_Delegado_General1_idx` (`Delegado_General_idDelegado_General`),
  CONSTRAINT `fk_Delegado_Actvidad_Actividad1` FOREIGN KEY (`Actividad_idActividad`) REFERENCES `actividad` (`idActividad`),
  CONSTRAINT `fk_Delegado_Actvidad_Delegado_General1` FOREIGN KEY (`Delegado_General_idDelegado_General`) REFERENCES `delegado_general` (`idDelegado_General`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `delegado_actvidad`
--

LOCK TABLES `delegado_actvidad` WRITE;
/*!40000 ALTER TABLE `delegado_actvidad` DISABLE KEYS */;
INSERT INTO `delegado_actvidad` VALUES (1,'111','2023-10-10',1,1),(2,'222','2023-10-10',2,1);
/*!40000 ALTER TABLE `delegado_actvidad` ENABLE KEYS */;
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
  `descripcion` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idEstado_Alumno`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `estado_alumno`
--

LOCK TABLES `estado_alumno` WRITE;
/*!40000 ALTER TABLE `estado_alumno` DISABLE KEYS */;
INSERT INTO `estado_alumno` VALUES (1,'Activo'),(2,'Baneado');
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
  `participantes` int NOT NULL,
  `estado` varchar(45) NOT NULL,
  `foto` blob,
  `fechaFin` date NOT NULL,
  `Actividad_idActividad` int NOT NULL,
  `lugar` varchar(45) NOT NULL,
  `hora` time NOT NULL,
  PRIMARY KEY (`idEvento`),
  KEY `fk_Evento_Actividad1_idx` (`Actividad_idActividad`),
  CONSTRAINT `fk_Evento_Actividad1` FOREIGN KEY (`Actividad_idActividad`) REFERENCES `actividad` (`idActividad`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `evento`
--

LOCK TABLES `evento` WRITE;
/*!40000 ALTER TABLE `evento` DISABLE KEYS */;
INSERT INTO `evento` VALUES (1,'Fibra Tóxica vs Huascaminas','2023-10-15',1,'a',NULL,'2023-10-31',1,'Cancha de Minas','10:00:00'),(2,'Hormigón Armado vs Fibra Tóxica','2023-10-16',1,'a',NULL,'2023-10-31',1,'Lab V307','09:00:00'),(3,'Descontrol Automático vs PXO Industrial','2023-10-17',1,'a',NULL,'2023-10-31',1,'Lab V307','10:00:00'),(4,'Naranja Mecánica vs Fibra Tóxica','2023-10-18',1,'a',NULL,'2023-10-31',1,'Lab V307','11:00:00'),(5,'Descontrol Automático vs PXO Industrial','2023-10-19',1,'a',NULL,'2023-10-31',1,'Lab V307','12:00:00'),(6,'Hormigón Armado vs Fibra Tóxica','2023-10-21',1,'a',NULL,'2023-10-31',2,'Lab V305','08:00:00'),(7,'Descontrol Automático vs PXO Industrial','2023-10-22',1,'a',NULL,'2023-10-31',2,'Lab V306','15:00:00'),(8,'Fibra Tóxica vs Huascaminas','2023-10-23',1,'a',NULL,'2023-10-31',2,'Lab V306','17:00:00'),(9,'Hormigón Armado vs Fibra Tóxica','2023-10-23',1,'a',NULL,'2023-10-31',3,'Lab V306','08:00:00'),(10,'Descontrol Automático vs PXO Industrial','2023-10-17',1,'a',NULL,'2023-10-31',3,'Lab V306','12:00:00'),(11,'Naranja Mecánica vs Fibra Tóxica','2023-10-18',1,'a',NULL,'2023-10-31',3,'Lab V305','12:00:00');
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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `integrante`
--

LOCK TABLES `integrante` WRITE;
/*!40000 ALTER TABLE `integrante` DISABLE KEYS */;
INSERT INTO `integrante` VALUES (1,'Equipo'),(2,'Barra');
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
  `descripcion` varchar(45) DEFAULT NULL,
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

-- Dump completed on 2023-11-01 17:13:05
