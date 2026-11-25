CREATE DATABASE  IF NOT EXISTS `dbsistemaembutidos` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `dbsistemaembutidos`;
-- MySQL dump 10.13  Distrib 8.0.43, for Win64 (x86_64)
--
-- Host: localhost    Database: dbsistemaembutidos
-- ------------------------------------------------------
-- Server version	8.0.43

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
-- Table structure for table `tbl_paciente`
--

DROP TABLE IF EXISTS `tbl_paciente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_paciente` (
  `idPaciente` int NOT NULL AUTO_INCREMENT,
  `nombrePaciente` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `apellidoPaciente` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fechaNacimientoPaciente` date DEFAULT NULL,
  `sexoPaciente` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `direccionPaciente` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `telefonoPaciente` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `estadoPaciente` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`idPaciente`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_paciente`
--

LOCK TABLES `tbl_paciente` WRITE;
/*!40000 ALTER TABLE `tbl_paciente` DISABLE KEYS */;
INSERT INTO `tbl_paciente` VALUES (1,'manolo','manolin','2004-08-13','M','zona 16','45782136',1),(2,'Examen','Examen Final','2000-06-13','M','Zona 4','24685785',1),(3,'otro examen','Final','2004-06-15','F','zona 7','26487596',1);
/*!40000 ALTER TABLE `tbl_paciente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblactivofijo`
--

DROP TABLE IF EXISTS `tblactivofijo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblactivofijo` (
  `idActivoFijo` int NOT NULL AUTO_INCREMENT,
  `idModuloContable` int NOT NULL,
  `idMaestroVidaUtil` int NOT NULL,
  `codigoActivoFijo` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcionActivoFijo` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `valorCompraActivoFijo` decimal(12,4) NOT NULL,
  `valorResidualActivoFijo` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `valorDepreciableActivoFijo` decimal(12,4) GENERATED ALWAYS AS ((`valorCompraActivoFijo` - `valorResidualActivoFijo`)) STORED,
  `valorEnLibrosActivoFijo` decimal(12,4) NOT NULL,
  `mesesVidaUtilActivoFijo` int NOT NULL,
  `fechaAdquisicionActivoFijo` date NOT NULL,
  `fechaInicioUsoActivoFijo` date NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idActivoFijo`),
  UNIQUE KEY `uqActivoFijoCodigo` (`codigoActivoFijo`),
  KEY `idxActivoFijoModulo` (`idModuloContable`),
  KEY `idxActivoFijoMaestroVida` (`idMaestroVidaUtil`),
  CONSTRAINT `Fk_ActivoFijo_MaestroVidaUtil` FOREIGN KEY (`idMaestroVidaUtil`) REFERENCES `tblmaestrovidautil` (`idMaestroVidaUtil`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `Fk_ActivoFijo_Modulo` FOREIGN KEY (`idModuloContable`) REFERENCES `tblmodulocontable` (`idModuloContable`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `ckActivoFijoFechas` CHECK ((`fechaInicioUsoActivoFijo` >= `fechaAdquisicionActivoFijo`)),
  CONSTRAINT `ckActivoFijoMeses` CHECK ((`mesesVidaUtilActivoFijo` > 0)),
  CONSTRAINT `ckActivoFijoResidual` CHECK (((`valorResidualActivoFijo` >= 0) and (`valorResidualActivoFijo` <= `valorCompraActivoFijo`)))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblactivofijo`
--

LOCK TABLES `tblactivofijo` WRITE;
/*!40000 ALTER TABLE `tblactivofijo` DISABLE KEYS */;
/*!40000 ALTER TABLE `tblactivofijo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblactualizacionsaldos`
--

DROP TABLE IF EXISTS `tblactualizacionsaldos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblactualizacionsaldos` (
  `idActualizacionSaldos` int NOT NULL AUTO_INCREMENT,
  `modoActualizacionSaldos` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tipoPeriodoActualizacionSaldos` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fechaDesdeActualizacionSaldos` date NOT NULL,
  `fechaHastaActualizacionSaldos` date NOT NULL,
  `polizasProcesadasActualizacionSaldos` int NOT NULL DEFAULT '0',
  `usuarioActualizacionSaldos` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idActualizacionSaldos`),
  KEY `idxActualizacionFechas` (`fechaDesdeActualizacionSaldos`,`fechaHastaActualizacionSaldos`),
  CONSTRAINT `ckActualizacionFechas` CHECK ((`fechaHastaActualizacionSaldos` >= `fechaDesdeActualizacionSaldos`)),
  CONSTRAINT `ckActualizacionModo` CHECK ((`modoActualizacionSaldos` in (_utf8mb4'LINEA',_utf8mb4'BATCH'))),
  CONSTRAINT `ckActualizacionPolizas` CHECK ((`polizasProcesadasActualizacionSaldos` >= 0)),
  CONSTRAINT `ckActualizacionTipo` CHECK ((`tipoPeriodoActualizacionSaldos` in (_utf8mb4'ANUAL',_utf8mb4'MENSUAL',_utf8mb4'SEMANAL',_utf8mb4'RANGO')))
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblactualizacionsaldos`
--

LOCK TABLES `tblactualizacionsaldos` WRITE;
/*!40000 ALTER TABLE `tblactualizacionsaldos` DISABLE KEYS */;
INSERT INTO `tblactualizacionsaldos` VALUES (1,'BATCH','MENSUAL','2026-10-01','2026-10-31',5,'Administrador',1,'2026-11-14 18:34:36','2026-11-14 18:34:36');
/*!40000 ALTER TABLE `tblactualizacionsaldos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblalertacadenafrio`
--

DROP TABLE IF EXISTS `tblalertacadenafrio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblalertacadenafrio` (
  `idAlertaCadenaFrio` bigint NOT NULL AUTO_INCREMENT,
  `Fk_Telemetria_Temperatura_Codigo` bigint NOT NULL,
  `tipoAlertaCadenaFrio` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `atendidaAlertaCadenaFrio` tinyint(1) NOT NULL DEFAULT '0',
  `observacionCalidadAlertaCadenaFrio` varchar(500) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idAlertaCadenaFrio`),
  KEY `idxIdTelemetriaTemperaturaAlertaCadenaFrio` (`Fk_Telemetria_Temperatura_Codigo`),
  KEY `idxAtendidaAlertaCadenaFrio` (`atendidaAlertaCadenaFrio`),
  CONSTRAINT `Fk_Alerta_Cadena_Frio_Telemetria_Temperatura` FOREIGN KEY (`Fk_Telemetria_Temperatura_Codigo`) REFERENCES `tbltelemetriatemperatura` (`idTelemetriaTemperatura`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblalertacadenafrio`
--

LOCK TABLES `tblalertacadenafrio` WRITE;
/*!40000 ALTER TABLE `tblalertacadenafrio` DISABLE KEYS */;
INSERT INTO `tblalertacadenafrio` VALUES (1,1,'REVISION_PREVENTIVA',1,'Se verificó el termómetro de la cámara y se confirmó refrigeración estable.','2026-11-14 18:34:39','2026-11-14 18:34:39'),(2,2,'TEMPERATURA_ALTA',1,'Temperatura superior al rango; se ajustó la unidad de frío.','2026-11-14 18:34:39','2026-11-14 18:34:39'),(3,3,'HUMEDAD_ALTA',1,'Se revisaron empaques y sellos de la cámara durante la parada técnica.','2026-11-14 18:34:39','2026-11-14 18:34:39'),(4,4,'PUERTA_ABIERTA',1,'Se confirmó apertura durante descarga y cierre inmediato de la puerta.','2026-11-14 18:34:39','2026-11-14 18:34:39'),(5,5,'TEMPERATURA_BAJA',0,'Se solicitó verificar el termostato antes de completar la entrega.','2026-11-14 18:34:39','2026-11-14 18:34:39');
/*!40000 ALTER TABLE `tblalertacadenafrio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblantiguedadsaldo`
--

DROP TABLE IF EXISTS `tblantiguedadsaldo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblantiguedadsaldo` (
  `idAntiguedadSaldo` int NOT NULL AUTO_INCREMENT,
  `idPeriodoCompras` int NOT NULL,
  `idProveedor` int NOT NULL,
  `idMoneda` bigint NOT NULL,
  `idRangoAntiguedad` int NOT NULL,
  `montoAntiguedadSaldo` decimal(12,4) NOT NULL,
  `montoLocalAntiguedadSaldo` decimal(12,4) NOT NULL,
  `cantidadDocumentosAntiguedadSaldo` int NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idAntiguedadSaldo`),
  UNIQUE KEY `uqPeriodoProveedorMonedaRango` (`idPeriodoCompras`,`idProveedor`,`idMoneda`,`idRangoAntiguedad`),
  KEY `idxAntiguedadSaldoProveedor` (`idProveedor`),
  KEY `idxAntiguedadSaldoMoneda` (`idMoneda`),
  KEY `idxAntiguedadSaldoRango` (`idRangoAntiguedad`),
  CONSTRAINT `Fk_AntiguedadSaldo_Moneda` FOREIGN KEY (`idMoneda`) REFERENCES `tblmoneda` (`idMoneda`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `Fk_AntiguedadSaldo_Periodo` FOREIGN KEY (`idPeriodoCompras`) REFERENCES `tblperiodocompras` (`idPeriodoCompras`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `Fk_AntiguedadSaldo_Proveedor` FOREIGN KEY (`idProveedor`) REFERENCES `tblproveedor` (`idProveedor`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `Fk_AntiguedadSaldo_Rango` FOREIGN KEY (`idRangoAntiguedad`) REFERENCES `tblrangoantiguedad` (`idRangoAntiguedad`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `ckCantidadAntiguedadSaldo` CHECK ((`cantidadDocumentosAntiguedadSaldo` > 0)),
  CONSTRAINT `ckMontoAntiguedadSaldo` CHECK (((`montoAntiguedadSaldo` > 0) and (`montoLocalAntiguedadSaldo` > 0)))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblantiguedadsaldo`
--

LOCK TABLES `tblantiguedadsaldo` WRITE;
/*!40000 ALTER TABLE `tblantiguedadsaldo` DISABLE KEYS */;
/*!40000 ALTER TABLE `tblantiguedadsaldo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblaplicacion`
--

DROP TABLE IF EXISTS `tblaplicacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblaplicacion` (
  `idAplicacion` int NOT NULL AUTO_INCREMENT,
  `idModulo` int NOT NULL,
  `nombreAplicacion` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcionAplicacion` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idAplicacion`),
  KEY `idxAplicacionIdModulo` (`idModulo`),
  CONSTRAINT `Fk_Aplicacion_Modulo` FOREIGN KEY (`idModulo`) REFERENCES `tblmodulo` (`idModulo`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10016 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblaplicacion`
--

LOCK TABLES `tblaplicacion` WRITE;
/*!40000 ALTER TABLE `tblaplicacion` DISABLE KEYS */;
INSERT INTO `tblaplicacion` VALUES (3,7000,'Gestión de Pedidos','Registro y seguimiento de pedidos de clientes',1,'2026-09-17 20:07:07','2026-09-17 20:07:07'),(4,4,'Empleados','Gestión de empleados del sistema',1,'2026-09-17 20:07:07','2026-09-17 20:07:07'),(5,4,'Usuarios','Gestión de usuarios del sistema',1,'2026-09-17 20:07:07','2026-09-17 20:07:07'),(6,4,'Módulos','Administración de módulos del sistema',1,'2026-09-17 20:07:07','2026-09-17 20:07:07'),(7,4,'Aplicaciones','Administración de aplicaciones del sistema',1,'2026-09-17 20:07:07','2026-09-17 20:07:07'),(8,4,'Perfiles','Administración de roles/perfiles',1,'2026-09-17 20:07:07','2026-09-17 20:07:07'),(9,4,'Asignación de Perfiles','Asignación de roles a usuarios',1,'2026-09-17 20:07:07','2026-09-17 20:07:07'),(10,4,'Asignación Aplicación Perfiles','Asignación de permisos por rol/módulo/aplicación',1,'2026-09-17 20:07:07','2026-09-17 20:07:07'),(11,4,'Asignación Aplicación Usuario','Asignación de permisos por usuario/módulo/aplicación',1,'2026-09-17 20:07:07','2026-09-17 20:07:07'),(12,4,'Bitácora','Consulta de bitácora del sistema',1,'2026-09-17 20:07:07','2026-09-20 08:48:38'),(15,4,'Prueba','Esto es una prueba controlada por parte de Seguridad.',1,'2026-09-24 05:46:12','2026-09-24 05:46:12'),(5001,5000,'Sucursales','Mantenimiento de sucursales y ubicaciones de Embutidos de Calidad S.A.',1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(5002,5000,'Bodegas','Mantenimiento de bodegas de almacenamiento y refrigeración de embutidos.',1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(5003,5000,'Categorías','Mantenimiento de categorías de productos cárnicos y embutidos.',1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(5004,5000,'Línea','Mantenimiento de líneas de productos del catálogo de embutidos.',1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(5005,5000,'Marca','Mantenimiento de marcas asociadas a productos de embutidos.',1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(5007,5000,'Detalle de movimiento','Mantenimiento de detalles de movimientos de inventario.',1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(5008,5000,'Tipo de movimiento','Mantenimiento de tipos de movimientos de inventario.',1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(5013,5000,'Transporte','Mantenimiento de unidades de transporte de productos refrigerados.',1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(5015,5000,'Tipo de transporte','Mantenimiento de tipos de transporte de Logística.',1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(5016,5000,'Conductores','Mantenimiento de conductores del área de Logística.',1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(5028,5000,'Cámara de Refrigeración','Mantenimiento de cámaras de refrigeración y cadena de frío.',1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(6000,6000,'MDI Compras','Pantalla principal de Compras',1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(6001,6000,'Movimientos de proveedores','Registro de documentos de proveedores',1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(6002,6000,'Pólizas','Pólizas de compras',1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(6003,6000,'Órdenes de compra','Registro y consulta de órdenes de compra',1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(6004,6000,'Pagos a proveedores','Registro de pagos a proveedores',1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(6005,6000,'Aprobación financiera','Aprobación financiera de órdenes',1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(6006,6000,'Cierre de movimientos','Cierre de períodos de Compras',1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(6007,6000,'Aprobar orden','Aprobación de órdenes',1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(6008,6000,'Rechazar orden','Rechazo de órdenes',1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(6009,6000,'Evaluar orden','Evaluación de órdenes',1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(6010,6000,'Proveedor','Mantenimiento de proveedores',1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(6011,6000,'Método de pago','Mantenimiento de métodos de pago',1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(6012,6000,'Encabezados compras por pagar','Consulta de encabezados de compras por pagar',1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(6013,6000,'Plazo','Mantenimiento de plazos',1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(6014,6000,'Concepto de proveedor','Mantenimiento de conceptos de proveedor',1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(7000,7000,'Ventas','Configuración general del módulo: correlativos de venta y cuentas contables de cuentas por cobrar',1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(7002,7000,'Listas de Precio','Gestiona los tipos de cliente, las listas de precio, los precios por tipo de cliente y su historial de modificaciones',1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(7003,7000,'Movimientos de CxC','Registro y consulta de los movimientos de cuentas por cobrar de los clientes',1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(7004,7000,'Pedidos','Registra y da seguimiento a los pedidos de los clientes',1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(7005,7000,'Recibos de Pago','Registra los recibos de pago de los clientes y su aplicación a las facturas',1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(7007,7000,'Facturación','Emisión y control de facturas de venta y versiones de facturación por cliente',1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(7009,7000,'Catálogos de Ventas','Administra clientes, vendedores, productos de venta y formas de pago',1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(7010,7000,'Cierres de CxC','Cierre de períodos de cuentas por cobrar, saldos por cliente y traslados',1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(7011,7000,'Cotizaciones','Registra y da seguimiento a las cotizaciones enviadas a los clientes',1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(7013,7000,'Comisiones','Define reglas de comisión y calcula las comisiones de los vendedores sobre facturas y abonos',1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(7014,7000,'Notas de CxC','Gestiona las notas de crédito y débito de cuentas por cobrar',1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(7015,7000,'Depósitos de Venta','Registra los depósitos de las ventas con su detalle',1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(8001,8000,'Moneda','Mantenimiento de la moneda a utilizar.',1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(8002,8000,'Bancos','Mantenimiento del banco a utilizar.',1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(8003,8000,'Tipo de Cuenta Bancaria','Mantenimiento del tipo de cuenta a utilizar.',1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(8004,8000,'Tipo de Transacción','Mantenimiento del tipo de transacción a utilizar.',1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(8005,8000,'Cuenta Bancaria','Mantenimiento de las cuentas a utilizar.',1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(8006,8000,'Movimiento Bancario','Proceso para el registro de movimientos bancarios.',1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(8007,8000,'Conciliacion Bancaria','Proceso para conciliar los movimientos con el estado de cuentas.',1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(8008,8000,'Enlace a Otros Modulos','Proceso que permite la comunicacion con los demas modulos.',1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(8009,8000,'Disponibilidad Diaria','Proceso que permite visualizar la disponibilidad del cliente.',1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(8010,8000,'Tipo de Cambio','Proceso que permite visualizar el cambio de la moneda.',1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(8011,8000,'Proceso autorizacion de Orden de Compra','Proceso que autoriza las ordenes de las compras.',1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(8012,8000,'Proceso Generacion de Pago','Proceso que permite generar los pagos requeridos.',1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(8013,8000,'Cierre Bancario','Proceso que culmina con los movimientos mensuales y anuales.',1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(9001,9000,'Empleados','Gestión de empleados, departamentos, jornadas y puestos',1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(9002,9000,'Departamentos','Administra los departamentos de la empresa para la asignación',1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(9003,9000,'Jornadas','Gestiona las jornadas laborales disponibles en la empresa',1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(9004,9000,'Puestos','Administra los puestos de trabajo disponibles para los empleados',1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(9005,9000,'Tipo de Puestos','Gestiona los tipos de puesto (operativo, administrativo, etc.)',1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(9006,9000,'Asignación de Puestos','Relaciona los empleados con sus puestos y controla su historial',1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(9101,9000,'Asistencia','Registro y control de asistencia de los empleados',1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(9102,9000,'Horas Extra','Cálculo y aprobación del pago de horas extra generadas desde Asistencia',1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(9150,9000,'Paciente','9150 - Mantenimiento de tbl_paciente',1,'2026-11-24 05:19:41','2026-11-24 05:19:41'),(9201,9000,'Permisos y Vacaciones','Gestión de permisos, períodos de vacaciones y su aprobación',1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(9202,9000,'Permisos','Registra y da seguimiento a las solicitudes de permisos del personal: tipos, fechas, motivos y estados de aprobación',1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(9203,9000,'Vacaciones','Gestiona las solicitudes de vacaciones del personal: días disponibles, períodos vacacionales y estado de cada solicitud',1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(9301,9000,'Capacitación','Gestión de capacitaciones, instructores, evaluaciones y asignaciones',1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(9302,9000,'Capacitaciones','Define el nombre, las fechas, el costo y el cupo de cada capacitación por departamento',1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(9303,9000,'Instructores','Mantiene el listado de instructores con su especialidad y correo de contacto',1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(9304,9000,'Evaluaciones','Registra puntualidad, calidad, responsabilidad y desarrollo; el resultado final se calcula',1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(9305,9000,'Asignación de Capacitación','Asigna empleados a cada capacitación; un empleado no puede repetirse en la misma',1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(9401,9000,'Evaluación de Desempeño','Evaluación del desempeño de los empleados por ciclo y criterio',1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(9402,9000,'Realizar Evaluación de Desempeño','Registra y evalúa el desempeño del personal según los criterios establecidos para cada ciclo',1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(9403,9000,'Plan de Mejora','Define acciones y da seguimiento a los planes de mejora de los colaboradores',1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(9404,9000,'Ver Evaluaciones','Consulta resultados, puntajes y retroalimentación de desempeño',1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(9501,9000,'Nómina','Cálculo y gestión de la nómina de los empleados',1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(9601,9000,'Cierres de Nómina','Cierre de períodos de nómina',1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(9701,9000,'Liquidación del Empleado','Bajas, liquidaciones y finiquitos de empleados',1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(9702,9000,'Motivo de Baja','Catálogo de motivos de baja de los empleados',1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(9703,9000,'Parámetros de Ley','Parámetros legales para el cálculo de indemnizaciones y liquidaciones',1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(9704,9000,'Baja de Empleado','Registro de la baja de un empleado',1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(10000,10000,'Contabilidad','10000 - Menú principal del módulo de Contabilidad',1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(10001,10000,'Pólizas locales','10001 - Registro de pólizas locales de Contabilidad',1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(10002,10000,'Presupuestos','10002 - Planificación de presupuestos por módulo',1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(10003,10000,'Activos fijos','10003 - Ficha y depreciación de activos fijos',1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(10004,10000,'Cierre contable','10004 - Revisión y cierre del período contable',1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(10005,10000,'Estados financieros','10005 - Consulta del estado de resultados',1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(10006,10000,'Detalle de póliza','10006 - Encabezado y detalle de la póliza con el navegador',1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(10011,10000,'Mantenimiento de países','10011 - Mantenimiento de tblPais con el control Navegador',1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(10012,10000,'Mantenimiento de módulos contables','10012 - Mantenimiento de tblModuloContable',1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(10013,10000,'Mantenimiento de vida útil','10013 - Mantenimiento de tblMaestroVidaUtil',1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(10014,10000,'Mantenimiento de cuentas','10014 - Mantenimiento del catálogo de cuentas tblCuenta',1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(10015,10000,'Asignación de cuentas por módulo','10015 - Mantenimiento de tblModuloCuentaPais',1,'2026-11-14 18:34:40','2026-11-14 18:34:40');
/*!40000 ALTER TABLE `tblaplicacion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblaplicacionpago`
--

DROP TABLE IF EXISTS `tblaplicacionpago`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblaplicacionpago` (
  `idAplicacionPago` int NOT NULL AUTO_INCREMENT,
  `idReciboPago` int NOT NULL,
  `idFacturaEncabezado` int NOT NULL,
  `fechaAplicacionPago` date NOT NULL,
  `montoAplicadoAplicacionPago` decimal(12,4) NOT NULL,
  `estadoAplicacionPago` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `idUsuarioRegistro` int NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idAplicacionPago`),
  KEY `idxAplicacionPagoFacturaEncabezadoCodigofecha` (`idFacturaEncabezado`,`fechaAplicacionPago`),
  KEY `idxAplicacionPagoReciboPagoCodigo` (`idReciboPago`),
  KEY `idxAplicacionPagoUsuarioRegistro` (`idUsuarioRegistro`),
  CONSTRAINT `Fk_AplicacionPago_FacturaEncabezado` FOREIGN KEY (`idFacturaEncabezado`) REFERENCES `tblfacturaencabezado` (`idFacturaEncabezado`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `Fk_AplicacionPago_ReciboPago` FOREIGN KEY (`idReciboPago`) REFERENCES `tblrecibopago` (`idReciboPago`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `Fk_AplicacionPago_Usuario_Registro` FOREIGN KEY (`idUsuarioRegistro`) REFERENCES `tblusuario` (`idUsuario`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `ckAplicacionPagoMontoPositivo` CHECK ((`montoAplicadoAplicacionPago` > 0)),
  CONSTRAINT `ckAplicacionPagoValoresEstadoAplicacion` CHECK ((`estadoAplicacionPago` in (_utf8mb4'APLICADA',_utf8mb4'REVERTIDA')))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblaplicacionpago`
--

LOCK TABLES `tblaplicacionpago` WRITE;
/*!40000 ALTER TABLE `tblaplicacionpago` DISABLE KEYS */;
/*!40000 ALTER TABLE `tblaplicacionpago` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblaplicacionreporte`
--

DROP TABLE IF EXISTS `tblaplicacionreporte`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblaplicacionreporte` (
  `idAplicacion` int NOT NULL,
  `numeroReporte` int NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idAplicacion`,`numeroReporte`),
  KEY `Fk_Reporte_NumeroReporte` (`numeroReporte`),
  CONSTRAINT `Fk_Aplicacion_IdAplicacion` FOREIGN KEY (`idAplicacion`) REFERENCES `tblaplicacion` (`idAplicacion`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `Fk_Reporte_NumeroReporte` FOREIGN KEY (`numeroReporte`) REFERENCES `tblreporte` (`numeroReporte`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblaplicacionreporte`
--

LOCK TABLES `tblaplicacionreporte` WRITE;
/*!40000 ALTER TABLE `tblaplicacionreporte` DISABLE KEYS */;
/*!40000 ALTER TABLE `tblaplicacionreporte` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblaprobacion`
--

DROP TABLE IF EXISTS `tblaprobacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblaprobacion` (
  `idAprobacion` bigint NOT NULL AUTO_INCREMENT,
  `decisionAprobacion` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `comentarioAprobacion` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `identificadorAprobadorAprobacion` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `referenciaEvidencia2FAAprobacion` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fechaValidacion2FAAprobacion` datetime NOT NULL,
  `Fk_OrdenCompraRecibida_Codigo` bigint DEFAULT NULL,
  `Fk_OrdenPago_Codigo` bigint DEFAULT NULL,
  `Fk_PoliticaAprobacion_Codigo` bigint DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idAprobacion`),
  KEY `idxAprobacionOrdenCompra` (`Fk_OrdenCompraRecibida_Codigo`),
  KEY `idxAprobacionOrdenPago` (`Fk_OrdenPago_Codigo`),
  KEY `idxAprobacionPolitica` (`Fk_PoliticaAprobacion_Codigo`),
  CONSTRAINT `Fk_Aprobacion_OrdenCompra` FOREIGN KEY (`Fk_OrdenCompraRecibida_Codigo`) REFERENCES `tblordencomprarecibida` (`Pk_OrdenCompraRecibida`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `Fk_Aprobacion_OrdenPago` FOREIGN KEY (`Fk_OrdenPago_Codigo`) REFERENCES `tblordenpago` (`idOrdenPago`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `Fk_Aprobacion_Politica` FOREIGN KEY (`Fk_PoliticaAprobacion_Codigo`) REFERENCES `tblpoliticaaprobacion` (`Pk_PoliticaAprobacion`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `ckAprobacion1` CHECK ((`decisionAprobacion` in (_utf8mb4'APROBADA',_utf8mb4'RECHAZADA'))),
  CONSTRAINT `ckAprobacion2` CHECK ((((`Fk_OrdenCompraRecibida_Codigo` is not null) + (`Fk_OrdenPago_Codigo` is not null)) = 1))
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblaprobacion`
--

LOCK TABLES `tblaprobacion` WRITE;
/*!40000 ALTER TABLE `tblaprobacion` DISABLE KEYS */;
INSERT INTO `tblaprobacion` VALUES (1,'APROBADA','Factura verificada contra la orden de compra','gerencia.carlos','2FA-20261103-0001','2026-11-03 09:12:00',NULL,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(2,'APROBADA','Pago dentro del presupuesto de empaques','gerencia.carlos','2FA-20261104-0001','2026-11-04 10:05:00',NULL,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(3,'APROBADA','Planilla revisada por Recursos Humanos','gerencia.sofia','2FA-20261105-0001','2026-11-05 08:40:00',NULL,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(4,'APROBADA','Importacion de maquinaria autorizada por gerencia','gerencia.sofia','2FA-20261106-0001','2026-11-06 08:20:00',NULL,4,3,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(5,'APROBADA','Compra de especias para la produccion de noviembre','gerencia.carlos','2FA-20261106-0002','2026-11-06 08:55:00',NULL,5,1,'2026-11-14 18:34:36','2026-11-14 18:34:36');
/*!40000 ALTER TABLE `tblaprobacion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblasignacioncapacitacion`
--

DROP TABLE IF EXISTS `tblasignacioncapacitacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblasignacioncapacitacion` (
  `idAsignacionCapacitacion` int NOT NULL AUTO_INCREMENT,
  `idEmpleado` int NOT NULL,
  `idCapacitacion` int NOT NULL,
  `fechaAsignacionCapacitacion` date NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idAsignacionCapacitacion`),
  UNIQUE KEY `uqAsignacionCapacitacion` (`idEmpleado`,`idCapacitacion`),
  KEY `Fk_AsignacionCapacitacion_Capacitacion` (`idCapacitacion`),
  CONSTRAINT `Fk_AsignacionCapacitacion_Capacitacion` FOREIGN KEY (`idCapacitacion`) REFERENCES `tblcapacitacion` (`idCapacitacion`),
  CONSTRAINT `Fk_AsignacionCapacitacion_Empleado` FOREIGN KEY (`idEmpleado`) REFERENCES `tblempleado` (`idEmpleado`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblasignacioncapacitacion`
--

LOCK TABLES `tblasignacioncapacitacion` WRITE;
/*!40000 ALTER TABLE `tblasignacioncapacitacion` DISABLE KEYS */;
INSERT INTO `tblasignacioncapacitacion` VALUES (1,20,4,'2026-10-01','2026-11-14 18:34:37','2026-11-14 18:34:37'),(2,21,2,'2026-09-10','2026-11-14 18:34:37','2026-11-14 18:34:37'),(3,22,1,'2026-09-05','2026-11-14 18:34:37','2026-11-14 18:34:37'),(4,23,3,'2026-09-28','2026-11-14 18:34:37','2026-11-14 18:34:37'),(5,24,4,'2026-10-01','2026-11-14 18:34:37','2026-11-14 18:34:37'),(7,2,1,'2026-11-22','2026-11-23 01:25:36','2026-11-23 01:25:36');
/*!40000 ALTER TABLE `tblasignacioncapacitacion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblasistenciaempleado`
--

DROP TABLE IF EXISTS `tblasistenciaempleado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblasistenciaempleado` (
  `idAsistenciaEmpleado` int NOT NULL AUTO_INCREMENT,
  `idEmpleado` int NOT NULL,
  `fechaAsistenciaEmpleado` date NOT NULL,
  `horaEntradaAsistenciaEmpleado` time DEFAULT NULL,
  `horaSalidaAsistenciaEmpleado` time DEFAULT NULL,
  `estadoAsistenciaEmpleado` enum('PRESENTE','TARDANZA','AUSENTE','PERMISO') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'PRESENTE',
  `observacionAsistenciaEmpleado` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idAsistenciaEmpleado`),
  UNIQUE KEY `uqAsistenciaEmpleadoFecha` (`idEmpleado`,`fechaAsistenciaEmpleado`),
  CONSTRAINT `Fk_AsistenciaEmpleado_Empleado` FOREIGN KEY (`idEmpleado`) REFERENCES `tblempleado` (`idEmpleado`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `ckAsistenciaEmpleadoHoras` CHECK (((`horaEntradaAsistenciaEmpleado` is null) or (`horaSalidaAsistenciaEmpleado` is null) or (`horaSalidaAsistenciaEmpleado` > `horaEntradaAsistenciaEmpleado`)))
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblasistenciaempleado`
--

LOCK TABLES `tblasistenciaempleado` WRITE;
/*!40000 ALTER TABLE `tblasistenciaempleado` DISABLE KEYS */;
INSERT INTO `tblasistenciaempleado` VALUES (1,20,'2026-06-15','08:00:00','19:00:00','PRESENTE','Cierre de proyecto','2026-11-14 18:34:37','2026-11-14 18:34:37'),(2,20,'2026-07-15','07:58:00','18:00:00','PRESENTE',NULL,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(3,20,'2026-08-14','08:12:00','18:30:00','TARDANZA','Llegó 12 minutos tarde','2026-11-14 18:34:37','2026-11-14 18:34:37'),(4,20,'2026-09-15','08:00:00','19:30:00','PRESENTE','Cierre de planilla','2026-11-14 18:34:37','2026-11-14 18:34:37'),(5,20,'2026-10-15','08:00:00','19:00:00','PRESENTE',NULL,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(6,1,'2026-11-02','08:00:00','17:00:00','PRESENTE',NULL,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(7,1,'2026-11-03','08:09:00','17:00:00','TARDANZA','Llegó 9 minutos tarde','2026-11-14 18:34:38','2026-11-14 18:34:38'),(8,1,'2026-11-04','07:55:00','18:00:00','PRESENTE','Apoyo en cierre mensual','2026-11-14 18:34:38','2026-11-14 18:34:38'),(9,1,'2026-11-05','08:00:00','19:00:00','PRESENTE','Revisión de planilla','2026-11-14 18:34:38','2026-11-14 18:34:38'),(10,1,'2026-11-06',NULL,NULL,'AUSENTE','Ausencia sin aviso','2026-11-14 18:34:38','2026-11-14 18:34:38'),(11,3,'2026-11-02','08:00:00','17:00:00','PRESENTE',NULL,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(12,3,'2026-11-03','08:00:00','18:30:00','PRESENTE','Atención de auditoría','2026-11-14 18:34:38','2026-11-14 18:34:38'),(13,3,'2026-11-04','08:15:00','17:00:00','TARDANZA','Llegó 15 minutos tarde','2026-11-14 18:34:38','2026-11-14 18:34:38'),(14,3,'2026-11-05','08:00:00','17:00:00','PRESENTE',NULL,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(15,3,'2026-11-06','08:00:00','17:00:00','PRESENTE',NULL,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(16,13,'2026-11-02','08:00:00','17:00:00','PRESENTE',NULL,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(17,13,'2026-11-03','08:00:00','17:00:00','PRESENTE',NULL,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(18,13,'2026-11-04','08:00:00','20:00:00','PRESENTE','Reunión con proveedores','2026-11-14 18:34:38','2026-11-14 18:34:38'),(19,13,'2026-11-05',NULL,NULL,'PERMISO','Cita médica (permiso aprobado)','2026-11-14 18:34:38','2026-11-14 18:34:38'),(20,13,'2026-11-06','08:00:00','17:00:00','PRESENTE',NULL,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(21,21,'2026-11-05','08:00:00','18:00:00','PRESENTE','Cierre contable','2026-11-14 18:34:38','2026-11-14 18:34:38'),(22,22,'2026-11-04','08:00:00','19:00:00','PRESENTE','Pedido urgente de producción','2026-11-14 18:34:38','2026-11-14 18:34:38'),(23,24,'2026-11-05','06:00:00','16:00:00','PRESENTE','Despacho extraordinario','2026-11-14 18:34:38','2026-11-14 18:34:38');
/*!40000 ALTER TABLE `tblasistenciaempleado` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblauditoriainventario`
--

DROP TABLE IF EXISTS `tblauditoriainventario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblauditoriainventario` (
  `idAuditoriaInventario` int NOT NULL AUTO_INCREMENT,
  `Fk_Movimiento_Inventario_Codigo` int DEFAULT NULL COMMENT 'La auditoría puede realizarse sin movimiento previo',
  `Fk_Bodega_Codigo` int NOT NULL,
  `tipoAuditoriaInventario` enum('INDIVIDUAL','MULTIPLE') COLLATE utf8mb4_unicode_ci NOT NULL,
  `estadoAuditoriaInventario` enum('EN_PROCESO','FINALIZADA') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'EN_PROCESO',
  `fechaAuditoriaInventario` datetime NOT NULL,
  `encargadoBodegaAuditoriaInventario` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `responsableAuditoriaInventario` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `resultadoAuditoriaInventario` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `observacionesCalidadAuditoriaInventario` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idAuditoriaInventario`),
  KEY `Fk_Auditoria_Inventario_Movimiento_Inventario` (`Fk_Movimiento_Inventario_Codigo`),
  KEY `Fk_Auditoria_Inventario_Bodega` (`Fk_Bodega_Codigo`),
  CONSTRAINT `Fk_Auditoria_Inventario_Bodega` FOREIGN KEY (`Fk_Bodega_Codigo`) REFERENCES `tblbodega` (`idBodega`) ON DELETE RESTRICT,
  CONSTRAINT `Fk_Auditoria_Inventario_Movimiento_Inventario` FOREIGN KEY (`Fk_Movimiento_Inventario_Codigo`) REFERENCES `tblmovimientoinventario` (`idMovimientoInventario`) ON DELETE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblauditoriainventario`
--

LOCK TABLES `tblauditoriainventario` WRITE;
/*!40000 ALTER TABLE `tblauditoriainventario` DISABLE KEYS */;
INSERT INTO `tblauditoriainventario` VALUES (1,1,1,'INDIVIDUAL','FINALIZADA','2026-11-03 08:30:00','Verónica Isabel Cruz','Carlos Eduardo Méndez','Sin diferencias','Conteo físico de salchichas coincide con el saldo registrado.','2026-11-14 18:34:39','2026-11-14 18:34:39'),(2,2,2,'INDIVIDUAL','FINALIZADA','2026-11-04 09:15:00','Óscar David Ramos','Gabriela Fernanda López','Sin diferencias','Existencias de chorizo verificadas y documentadas.','2026-11-14 18:34:39','2026-11-14 18:34:39'),(3,3,3,'INDIVIDUAL','EN_PROCESO','2026-11-05 10:00:00','Ana Lucía Castillo','Roberto Emilio Pérez','Diferencia pendiente','Se identificaron dos unidades faltantes para investigar.','2026-11-14 18:34:39','2026-11-14 18:34:39'),(4,4,4,'INDIVIDUAL','EN_PROCESO','2026-11-06 11:45:00','Mario Estuardo Reyes','Daniela Sofía Vásquez','Diferencia pendiente','Una unidad adicional pendiente de conciliación documental.','2026-11-14 18:34:39','2026-11-14 18:34:39'),(5,5,5,'MULTIPLE','EN_PROCESO','2026-11-10 14:00:00','Elena Patricia Herrera','Jorge Alejandro Castro','Conteo en proceso','Auditoría múltiple iniciada; quedan productos por agregar.','2026-11-14 18:34:39','2026-11-14 18:34:39');
/*!40000 ALTER TABLE `tblauditoriainventario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblautdisponibilidadfondos`
--

DROP TABLE IF EXISTS `tblautdisponibilidadfondos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblautdisponibilidadfondos` (
  `idAutDisponibilidadFondos` bigint NOT NULL AUTO_INCREMENT,
  `Fk_AutOrdenCompra_Codigo` bigint NOT NULL,
  `Fk_CuentaBancaria_Codigo` bigint NOT NULL,
  `fechaCorteAutDisponibilidadFondos` date NOT NULL,
  `fechaEvaluacionAutDisponibilidadFondos` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `saldoDisponibleAutDisponibilidadFondos` decimal(12,4) NOT NULL,
  `Fk_Moneda_Origen_Codigo` bigint NOT NULL,
  `Fk_Moneda_Destino_Codigo` bigint NOT NULL,
  `tipoCambioAutDisponibilidadFondos` decimal(12,4) NOT NULL,
  `Fk_TipoCambio_Codigo` bigint DEFAULT NULL,
  `fuenteAutDisponibilidadFondos` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idAutDisponibilidadFondos`),
  KEY `idxAutDisponibilidadFondosEvaluacion` (`Fk_AutOrdenCompra_Codigo`,`Fk_CuentaBancaria_Codigo`,`fechaEvaluacionAutDisponibilidadFondos`),
  KEY `idxAutDisponibilidadFondosCuenta` (`Fk_CuentaBancaria_Codigo`),
  KEY `idxAutDisponibilidadFondosMonedaOrigen` (`Fk_Moneda_Origen_Codigo`),
  KEY `idxAutDisponibilidadFondosMonedaDestino` (`Fk_Moneda_Destino_Codigo`),
  KEY `idxAutDisponibilidadFondosTipoCambio` (`Fk_TipoCambio_Codigo`),
  CONSTRAINT `Fk_AutDisponibilidadFondos_Autorizacion` FOREIGN KEY (`Fk_AutOrdenCompra_Codigo`) REFERENCES `tblautordencompra` (`Pk_AutOrdenCompra`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `Fk_AutDisponibilidadFondos_Cuenta` FOREIGN KEY (`Fk_CuentaBancaria_Codigo`) REFERENCES `tblcuentabancaria` (`idCuentaBancaria`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `Fk_AutDisponibilidadFondos_MonedaDestino` FOREIGN KEY (`Fk_Moneda_Destino_Codigo`) REFERENCES `tblmoneda` (`idMoneda`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `Fk_AutDisponibilidadFondos_MonedaOrigen` FOREIGN KEY (`Fk_Moneda_Origen_Codigo`) REFERENCES `tblmoneda` (`idMoneda`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `Fk_AutDisponibilidadFondos_TipoCambio` FOREIGN KEY (`Fk_TipoCambio_Codigo`) REFERENCES `tbltipocambio` (`idTipoCambio`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `ckAutDisponibilidadFondos1` CHECK ((`tipoCambioAutDisponibilidadFondos` > 0)),
  CONSTRAINT `ckAutDisponibilidadFondos2` CHECK ((((`Fk_Moneda_Origen_Codigo` = `Fk_Moneda_Destino_Codigo`) and (`tipoCambioAutDisponibilidadFondos` = 1.0000) and (`Fk_TipoCambio_Codigo` is null)) or ((`Fk_Moneda_Origen_Codigo` <> `Fk_Moneda_Destino_Codigo`) and (`Fk_TipoCambio_Codigo` is not null))))
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblautdisponibilidadfondos`
--

LOCK TABLES `tblautdisponibilidadfondos` WRITE;
/*!40000 ALTER TABLE `tblautdisponibilidadfondos` DISABLE KEYS */;
INSERT INTO `tblautdisponibilidadfondos` VALUES (1,1,1,'2026-10-16','2026-11-14 12:34:37',150000.0000,1,1,1.0000,NULL,'Disponibilidad diaria','2026-11-14 18:34:37','2026-11-14 18:34:37'),(2,2,2,'2026-10-21','2026-11-14 12:34:37',60000.0000,1,1,1.0000,NULL,'Disponibilidad diaria','2026-11-14 18:34:37','2026-11-14 18:34:37'),(3,3,3,'2026-10-29','2026-11-14 12:34:37',18000.0000,2,2,1.0000,NULL,'Disponibilidad diaria','2026-11-14 18:34:37','2026-11-14 18:34:37'),(4,4,1,'2026-10-31','2026-11-14 12:34:37',120000.0000,1,1,1.0000,NULL,'Disponibilidad diaria','2026-11-14 18:34:37','2026-11-14 18:34:37'),(5,5,1,'2026-11-06','2026-11-14 12:34:37',85250.0000,1,1,1.0000,NULL,'Disponibilidad diaria','2026-11-14 18:34:37','2026-11-14 18:34:37');
/*!40000 ALTER TABLE `tblautdisponibilidadfondos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblautordencompra`
--

DROP TABLE IF EXISTS `tblautordencompra`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblautordencompra` (
  `Pk_AutOrdenCompra` bigint NOT NULL AUTO_INCREMENT,
  `Fk_OrdenCompraRecibida_Codigo` bigint NOT NULL,
  `identificadorEmpresaAutOrdenCompra` int NOT NULL,
  `estadoAutOrdenCompra` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'PENDIENTE',
  `identificadorUsuarioAutorizaAutOrdenCompra` int DEFAULT NULL,
  `fechaDecisionAutOrdenCompra` datetime DEFAULT NULL,
  `comentarioAutOrdenCompra` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `motivoRechazoAutOrdenCompra` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`Pk_AutOrdenCompra`),
  UNIQUE KEY `uqAutOrdenCompra1` (`Fk_OrdenCompraRecibida_Codigo`),
  CONSTRAINT `Fk_AutOrdenCompra_Compra` FOREIGN KEY (`Fk_OrdenCompraRecibida_Codigo`) REFERENCES `tblordencomprarecibida` (`Pk_OrdenCompraRecibida`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `ckAutOrdenCompra1` CHECK ((`identificadorEmpresaAutOrdenCompra` > 0)),
  CONSTRAINT `ckAutOrdenCompra2` CHECK ((`estadoAutOrdenCompra` in (_utf8mb4'PENDIENTE',_utf8mb4'AUTORIZADA',_utf8mb4'RECHAZADA'))),
  CONSTRAINT `ckAutOrdenCompra3` CHECK ((((`estadoAutOrdenCompra` = _utf8mb4'PENDIENTE') and (`identificadorUsuarioAutorizaAutOrdenCompra` is null) and (`fechaDecisionAutOrdenCompra` is null)) or ((`estadoAutOrdenCompra` in (_utf8mb4'AUTORIZADA',_utf8mb4'RECHAZADA')) and (`identificadorUsuarioAutorizaAutOrdenCompra` is not null) and (`fechaDecisionAutOrdenCompra` is not null)))),
  CONSTRAINT `ckAutOrdenCompra4` CHECK (((`identificadorUsuarioAutorizaAutOrdenCompra` is null) or (`identificadorUsuarioAutorizaAutOrdenCompra` > 0))),
  CONSTRAINT `ckAutOrdenCompra5` CHECK (((`estadoAutOrdenCompra` <> _utf8mb4'RECHAZADA') or ((`motivoRechazoAutOrdenCompra` is not null) and (char_length(trim(`motivoRechazoAutOrdenCompra`)) > 0))))
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblautordencompra`
--

LOCK TABLES `tblautordencompra` WRITE;
/*!40000 ALTER TABLE `tblautordencompra` DISABLE KEYS */;
INSERT INTO `tblautordencompra` VALUES (1,1,1,'AUTORIZADA',3,'2026-10-16 10:20:00','Autorizada segun presupuesto de materia prima',NULL,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(2,2,1,'AUTORIZADA',3,'2026-10-21 09:45:00','Autorizada segun presupuesto de empaques',NULL,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(3,3,1,'AUTORIZADA',2,'2026-10-29 14:10:00','Compra de maquinaria autorizada por gerencia',NULL,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(4,4,1,'AUTORIZADA',2,'2026-10-31 11:00:00','Especias para la produccion de noviembre',NULL,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(5,5,1,'PENDIENTE',NULL,NULL,NULL,NULL,'2026-11-14 18:34:37','2026-11-14 18:34:37');
/*!40000 ALTER TABLE `tblautordencompra` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblautpagoorden`
--

DROP TABLE IF EXISTS `tblautpagoorden`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblautpagoorden` (
  `idAutPagoOrden` bigint NOT NULL AUTO_INCREMENT,
  `Fk_AutDisponibilidadFondos_Codigo` bigint NOT NULL,
  `montoAsignadoAutPagoOrden` decimal(12,4) NOT NULL,
  `estadoAutPagoOrden` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'PROPUESTA',
  `fechaReservaAutPagoOrden` datetime DEFAULT NULL,
  `Fk_OrdenPago_Codigo` bigint DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idAutPagoOrden`),
  UNIQUE KEY `uqAutPagoOrden1` (`Fk_OrdenPago_Codigo`),
  KEY `idxAutPagoOrdenEvidencia` (`Fk_AutDisponibilidadFondos_Codigo`),
  CONSTRAINT `Fk_AutPagoOrden_Evidencia` FOREIGN KEY (`Fk_AutDisponibilidadFondos_Codigo`) REFERENCES `tblautdisponibilidadfondos` (`idAutDisponibilidadFondos`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `Fk_AutPagoOrden_OrdenPago` FOREIGN KEY (`Fk_OrdenPago_Codigo`) REFERENCES `tblordenpago` (`idOrdenPago`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `ckAutPagoOrden1` CHECK ((`montoAsignadoAutPagoOrden` > 0)),
  CONSTRAINT `ckAutPagoOrden2` CHECK ((`estadoAutPagoOrden` in (_utf8mb4'PROPUESTA',_utf8mb4'RESERVADA',_utf8mb4'LIBERADA',_utf8mb4'APLICADA'))),
  CONSTRAINT `ckAutPagoOrden3` CHECK (((`estadoAutPagoOrden` not in (_utf8mb4'RESERVADA',_utf8mb4'APLICADA')) or (`fechaReservaAutPagoOrden` is not null))),
  CONSTRAINT `ckAutPagoOrden4` CHECK (((`estadoAutPagoOrden` <> _utf8mb4'APLICADA') or (`Fk_OrdenPago_Codigo` is not null)))
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblautpagoorden`
--

LOCK TABLES `tblautpagoorden` WRITE;
/*!40000 ALTER TABLE `tblautpagoorden` DISABLE KEYS */;
INSERT INTO `tblautpagoorden` VALUES (1,1,18450.0000,'APLICADA','2026-10-16 10:30:00',1,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(2,2,7920.5000,'APLICADA','2026-10-21 09:55:00',2,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(3,3,3200.0000,'RESERVADA','2026-11-06 09:10:00',4,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(4,4,41300.0000,'RESERVADA','2026-11-06 09:25:00',5,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(5,5,12875.0000,'PROPUESTA',NULL,NULL,'2026-11-14 18:34:37','2026-11-14 18:34:37');
/*!40000 ALTER TABLE `tblautpagoorden` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblbajaempleado`
--

DROP TABLE IF EXISTS `tblbajaempleado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblbajaempleado` (
  `idBajaEmpleado` int NOT NULL AUTO_INCREMENT,
  `idEmpleado` int NOT NULL,
  `idMotivoBaja` int NOT NULL,
  `fechaBajaEmpleado` date NOT NULL,
  `observacionBajaEmpleado` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idUsuarioRegistra` int NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idBajaEmpleado`),
  KEY `Fk_BajaEmpleado_Empleado` (`idEmpleado`),
  KEY `Fk_BajaEmpleado_Usuario` (`idUsuarioRegistra`),
  KEY `Fk_BajaEmpleado_MotivoBaja` (`idMotivoBaja`),
  CONSTRAINT `Fk_BajaEmpleado_Empleado` FOREIGN KEY (`idEmpleado`) REFERENCES `tblempleado` (`idEmpleado`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `Fk_BajaEmpleado_MotivoBaja` FOREIGN KEY (`idMotivoBaja`) REFERENCES `tblmotivobaja` (`idMotivoBaja`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `Fk_BajaEmpleado_Usuario` FOREIGN KEY (`idUsuarioRegistra`) REFERENCES `tblusuario` (`idUsuario`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblbajaempleado`
--

LOCK TABLES `tblbajaempleado` WRITE;
/*!40000 ALTER TABLE `tblbajaempleado` DISABLE KEYS */;
INSERT INTO `tblbajaempleado` VALUES (1,20,1,'2026-12-15','Renuncia presentada por escrito',1,1,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(2,21,3,'2026-12-18','Terminación sin causa justificada',1,1,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(3,22,4,'2026-12-22','Acuerdo firmado entre ambas partes',1,1,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(4,23,5,'2026-12-28','Vencimiento del contrato',1,1,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(5,24,2,'2026-12-31','Falta grave comprobada',1,1,'2026-11-14 18:34:38','2026-11-14 18:34:38');
/*!40000 ALTER TABLE `tblbajaempleado` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblbanco`
--

DROP TABLE IF EXISTS `tblbanco`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblbanco` (
  `idBanco` bigint NOT NULL AUTO_INCREMENT,
  `codigoBanco` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nombreBanco` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idBanco`),
  UNIQUE KEY `uqBanco1` (`codigoBanco`),
  CONSTRAINT `ckBanco1` CHECK ((`is_active` in (0,1)))
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblbanco`
--

LOCK TABLES `tblbanco` WRITE;
/*!40000 ALTER TABLE `tblbanco` DISABLE KEYS */;
INSERT INTO `tblbanco` VALUES (1,'BIND','Banco Industrial',1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(2,'BRUR','Banrural',1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(3,'BAC','BAC Credomatic',1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(4,'GYT','Banco G&T Continental',1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(5,'BAM','Banco Agromercantil',1,'2026-11-14 18:34:36','2026-11-14 18:34:36');
/*!40000 ALTER TABLE `tblbanco` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblbitacora`
--

DROP TABLE IF EXISTS `tblbitacora`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblbitacora` (
  `idBitacora` int NOT NULL AUTO_INCREMENT,
  `idUsuario` int DEFAULT NULL,
  `accionBitacora` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `tablaBitacora` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `idRegistroBitacora` int NOT NULL,
  `detallesBitacora` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `ipBitacora` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `fechaHoraBitacora` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idBitacora`),
  KEY `idxBitacoraIdUsuario` (`idUsuario`),
  KEY `idxBitacoraFechaHora` (`fechaHoraBitacora`),
  KEY `idxBitacoraTabla` (`tablaBitacora`),
  CONSTRAINT `Fk_Bitacora_Usuario` FOREIGN KEY (`idUsuario`) REFERENCES `tblusuario` (`idUsuario`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=320 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblbitacora`
--

LOCK TABLES `tblbitacora` WRITE;
/*!40000 ALTER TABLE `tblbitacora` DISABLE KEYS */;
INSERT INTO `tblbitacora` VALUES (1,1,'INSERT','tblEmpleado',1,'Alta de empleado de prueba','192.168.1.10','2026-09-17 08:07:07','2026-09-17 20:07:07'),(2,2,'UPDATE','tblAplicacion',2,'Actualización de datos de aplicación','192.168.1.11','2026-09-17 08:07:07','2026-09-17 20:07:07'),(3,3,'DELETE','tblUsuarioRol',3,'Eliminación de asignación de rol','192.168.1.12','2026-09-17 08:07:07','2026-09-17 20:07:07'),(4,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.167.48','2026-09-17 08:07:53','2026-09-17 20:07:53'),(5,1,'INSERT','tblUsuarioRol',3,'Se asignó el perfil 2 al usuario 3','192.168.167.48','2026-09-17 08:09:00','2026-09-17 20:09:00'),(6,1,'INSERT','tblEmpleado',0,'Se agregó el empleado: Oscar Moralesl','192.168.167.48','2026-09-17 08:13:37','2026-09-17 20:13:37'),(7,1,'INSERT','tblUsuario',0,'Se agregó el usuario: SofiGoty','192.168.167.48','2026-09-17 08:14:24','2026-09-17 20:14:24'),(8,1,'INSERT','tblUsuarioRol',4,'Se asignó el perfil 1 al usuario 4','192.168.167.48','2026-09-17 08:14:33','2026-09-17 20:14:33'),(9,1,'LOGIN','tblUsuario',4,'Inicio de sesión exitoso del usuario: SofiGoty','192.168.167.48','2026-09-17 08:14:55','2026-09-17 20:14:55'),(10,1,'UPDATE','tblAsigAppPerf',1,'Se actualizaron permisos de aplicación 4 al rol 1','192.168.167.48','2026-09-17 08:16:33','2026-09-17 20:16:33'),(11,1,'LOGIN','tblUsuario',4,'Inicio de sesión exitoso del usuario: SofiGoty','192.168.167.48','2026-09-17 08:17:20','2026-09-17 20:17:20'),(12,1,'UPDATE','tblAsigAppPerf',1,'Se actualizaron permisos de aplicación 4 al rol 1','192.168.167.48','2026-09-17 08:19:43','2026-09-17 20:19:43'),(13,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.167.48','2026-09-17 08:22:18','2026-09-17 20:22:18'),(14,1,'DELETE','tblEmpleado',4,'Se eliminó el empleado ID: 4','192.168.167.48','2026-09-17 08:23:26','2026-09-17 20:23:26'),(15,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.167.48','2026-09-17 08:27:14','2026-09-17 20:27:14'),(16,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.167.48','2026-09-17 13:53:54','2026-09-18 01:53:54'),(17,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.167.48','2026-09-17 14:04:42','2026-09-18 02:04:42'),(18,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.1.11','2026-09-17 19:21:21','2026-09-18 07:21:21'),(19,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.1.11','2026-09-17 19:51:48','2026-09-18 07:51:48'),(20,1,'LOGIN','tblUsuario',2,'Inicio de sesión exitoso del usuario: cramirez','192.168.1.11','2026-09-17 19:53:15','2026-09-18 07:53:16'),(21,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.1.11','2026-09-17 19:53:42','2026-09-18 07:53:42'),(22,1,'LOGIN','tblUsuario',2,'Inicio de sesión exitoso del usuario: cramirez','192.168.1.11','2026-09-18 08:24:51','2026-09-18 20:24:51'),(23,NULL,'LOGIN','tblUsuario',2,'Inicio de sesión exitoso del usuario: cramirez','192.168.1.11','2026-09-18 08:44:12','2026-09-18 20:44:12'),(24,NULL,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.1.11','2026-09-18 08:44:48','2026-09-18 20:44:48'),(25,NULL,'LOGIN','tblUsuario',2,'Inicio de sesión exitoso del usuario: cramirez','192.168.1.11','2026-09-18 08:58:45','2026-09-18 20:58:45'),(26,NULL,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.1.11','2026-09-18 08:58:59','2026-09-18 20:58:59'),(27,NULL,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.1.11','2026-09-18 09:04:20','2026-09-18 21:04:20'),(28,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.1.11','2026-09-18 09:07:48','2026-09-18 21:07:48'),(29,2,'LOGIN','tblUsuario',2,'Inicio de sesión exitoso del usuario: cramirez','192.168.1.11','2026-09-18 09:08:15','2026-09-18 21:08:15'),(30,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.1.11','2026-09-18 09:08:38','2026-09-18 21:08:38'),(31,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.1.11','2026-09-18 09:17:02','2026-09-18 21:17:02'),(32,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.1.11','2026-09-18 11:41:10','2026-09-18 23:41:10'),(33,1,'INSERT','tblEmpleado',0,'Se agregó el empleado: Oscar Emilio Morales Lemus','192.168.1.11','2026-09-18 11:48:58','2026-09-18 23:48:58'),(34,1,'UPDATE','tblEmpleado',5,'Se actualizó el empleado: Oscar Emilio Morales Lemus','192.168.1.11','2026-09-18 11:49:13','2026-09-18 23:49:13'),(35,1,'UPDATE','tblEmpleado',5,'Se actualizó el empleado: Oscar Emilio Morales Lemus','192.168.1.11','2026-09-18 11:49:54','2026-09-18 23:49:55'),(36,1,'INSERT','tblEmpleado',0,'Se agregó el empleado: dfdsf dsfdsf','192.168.1.11','2026-09-18 11:58:46','2026-09-18 23:58:46'),(37,1,'UPDATE','tblEmpleado',8,'Se actualizó el empleado: dfdsf dsfdsf','192.168.1.11','2026-09-18 11:59:21','2026-09-18 23:59:21'),(38,1,'DELETE','tblEmpleado',8,'Se eliminó el empleado ID: 8','192.168.1.11','2026-09-18 11:59:25','2026-09-18 23:59:25'),(39,1,'INSERT','tblUsuario',0,'Se agregó el usuario: Omorales','192.168.1.11','2026-09-18 12:02:42','2026-09-19 00:02:42'),(40,1,'INSERT','tblModulo',0,'Se agregó el módulo: Compras','192.168.1.11','2026-09-18 12:10:26','2026-09-19 00:10:26'),(41,1,'UPDATE','tblModulo',5,'Se actualizó el módulo: Compras','192.168.1.11','2026-09-18 12:10:33','2026-09-19 00:10:33'),(42,1,'DELETE','tblModulo',5,'Se eliminó el módulo ID: 5','192.168.1.11','2026-09-18 12:10:38','2026-09-19 00:10:38'),(43,1,'INSERT','tblModulo',5,'Se agregó el módulo: Comprasdfd','192.168.1.11','2026-09-18 12:10:52','2026-09-19 00:10:53'),(44,1,'UPDATE','tblModulo',6,'Se actualizó el módulo: Comprasdfd','192.168.1.11','2026-09-18 12:10:56','2026-09-19 00:10:56'),(45,1,'UPDATE','tblModulo',4,'Se actualizó el módulo: Seguridad','192.168.1.11','2026-09-18 12:11:19','2026-09-19 00:11:19'),(46,1,'DELETE','tblModulo',6,'Se eliminó el módulo ID: 6','192.168.1.11','2026-09-18 12:13:28','2026-09-19 00:13:28'),(47,1,'INSERT','tblAplicacion',0,'Se agregó la aplicación: fdsfsdfdsf','192.168.1.11','2026-09-18 12:24:05','2026-09-19 00:24:05'),(48,1,'UPDATE','tblAplicacion',13,'Se actualizó la aplicación: fdsfsdfds','192.168.1.11','2026-09-18 12:24:20','2026-09-19 00:24:20'),(49,1,'DELETE','tblAplicacion',13,'Se eliminó la aplicación ID: 13','192.168.1.11','2026-09-18 12:24:25','2026-09-19 00:24:25'),(50,1,'INSERT','tblAplicacion',13,'Se agregó la aplicación: Perfiles','192.168.1.11','2026-09-18 12:24:41','2026-09-19 00:24:41'),(51,1,'INSERT','tblModulo',0,'Se agregó el módulo: dsolpkojdfkdsf','192.168.1.11','2026-09-18 12:26:47','2026-09-19 00:26:47'),(52,1,'DELETE','tblModulo',8,'Se eliminó el módulo ID: 8','192.168.1.11','2026-09-18 12:26:51','2026-09-19 00:26:51'),(53,1,'DELETE','tblAplicacion',14,'Se eliminó la aplicación ID: 14','192.168.1.11','2026-09-18 12:27:35','2026-09-19 00:27:35'),(54,1,'INSERT','tblRol',0,'Se agregó el perfil: Probador','192.168.1.11','2026-09-18 12:30:24','2026-09-19 00:30:24'),(55,1,'UPDATE','tblRol',5,'Se actualizó el perfil: Probador','192.168.1.11','2026-09-18 12:33:51','2026-09-19 00:33:51'),(56,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.1.11','2026-09-18 12:42:44','2026-09-19 00:42:44'),(57,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.1.11','2026-09-18 12:43:19','2026-09-19 00:43:19'),(58,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.1.11','2026-09-18 12:43:56','2026-09-19 00:43:56'),(59,1,'DELETE','tblAsigAppPerf',3,'Se eliminó asignación de aplicación 3 al rol 3','192.168.1.11','2026-09-18 12:44:12','2026-09-19 00:44:12'),(60,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.1.11','2026-09-18 12:45:34','2026-09-19 00:45:34'),(61,1,'UPDATE','tblAsigAppPerf',2,'Se actualizaron permisos de aplicación 2 al rol 2','192.168.1.11','2026-09-18 12:46:57','2026-09-19 00:46:57'),(62,1,'DELETE','tblAsigAppPerf',2,'Se eliminó asignación de aplicación 5 al rol 2','192.168.1.11','2026-09-18 12:47:07','2026-09-19 00:47:07'),(63,1,'INSERT','tblAsigAppUsuario',1,'Se asignó aplicación 1 al módulo 1','192.168.1.11','2026-09-18 12:48:09','2026-09-19 00:48:09'),(64,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.1.11','2026-09-18 15:40:45','2026-09-19 03:40:45'),(65,1,'UPDATE','tblAsigAppPerf',1,'Se actualizaron permisos de aplicación 1 al rol 1','192.168.1.11','2026-09-18 15:41:54','2026-09-19 03:41:54'),(66,1,'LOGIN','tblUsuario',5,'Inicio de sesión exitoso del usuario: Omorales','192.168.1.11','2026-09-18 15:44:36','2026-09-19 03:44:36'),(67,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.1.11','2026-09-18 15:44:58','2026-09-19 03:44:59'),(68,1,'INSERT','tblRol',0,'Se agregó el perfil: Pruebas','192.168.1.11','2026-09-18 15:45:38','2026-09-19 03:45:38'),(69,1,'DELETE','tblRol',5,'Se eliminó el rol perfil: 5','192.168.1.11','2026-09-18 15:45:45','2026-09-19 03:45:45'),(70,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.1.11','2026-09-18 15:46:11','2026-09-19 03:46:11'),(71,1,'INSERT','tblUsuarioRol',5,'Se asignó el perfil 3 al usuario 5','192.168.1.11','2026-09-18 15:56:26','2026-09-19 03:56:27'),(72,1,'INSERT','tblAsigAppPerf',3,'Se asignó aplicación 11 al rol 3','192.168.1.11','2026-09-18 15:57:29','2026-09-19 03:57:29'),(73,1,'INSERT','tblAsigAppPerf',3,'Se asignó aplicación 10 al rol 3','192.168.1.11','2026-09-18 15:57:37','2026-09-19 03:57:37'),(74,1,'INSERT','tblAsigAppPerf',3,'Se asignó aplicación 8 al rol 3','192.168.1.11','2026-09-18 15:57:43','2026-09-19 03:57:43'),(75,1,'INSERT','tblAsigAppPerf',3,'Se asignó aplicación 7 al rol 3','192.168.1.11','2026-09-18 15:57:51','2026-09-19 03:57:51'),(76,1,'LOGIN','tblUsuario',5,'Inicio de sesión exitoso del usuario: Omorales','192.168.1.11','2026-09-18 15:58:13','2026-09-19 03:58:13'),(77,1,'INSERT','tblAsigAppPerf',1,'Se asignó aplicación 1 al rol 1','192.168.1.11','2026-09-18 15:58:39','2026-09-19 03:58:39'),(78,1,'LOGIN','tblUsuario',5,'Inicio de sesión exitoso del usuario: Omorales','192.168.1.11','2026-09-18 16:13:17','2026-09-19 04:13:17'),(79,1,'LOGIN','tblUsuario',5,'Inicio de sesión exitoso del usuario: Omorales','192.168.1.11','2026-09-18 17:43:22','2026-09-19 05:43:22'),(80,1,'INSERT','tblAsigAppPerf',3,'Se asignó aplicación 5 al rol 3','192.168.1.11','2026-09-18 17:44:16','2026-09-19 05:44:16'),(81,1,'INSERT','tblAsigAppPerf',3,'Se asignó aplicación 6 al rol 3','192.168.1.11','2026-09-18 17:44:33','2026-09-19 05:44:33'),(82,1,'INSERT','tblAsigAppPerf',3,'Se asignó aplicación 4 al rol 3','192.168.1.11','2026-09-18 17:44:53','2026-09-19 05:44:53'),(83,NULL,'LOGIN','tblUsuario',5,'Inicio de sesión exitoso del usuario: Omorales','192.168.1.11','2026-09-18 18:19:05','2026-09-19 06:19:05'),(84,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.1.11','2026-09-18 18:19:24','2026-09-19 06:19:24'),(85,NULL,'LOGIN','tblUsuario',5,'Inicio de sesión exitoso del usuario: Omorales','192.168.1.11','2026-09-18 18:20:11','2026-09-19 06:20:11'),(86,NULL,'UPDATE','tblEmpleado',5,'Se actualizó el empleado: Oscar Emilio Morales Lemus','192.168.1.11','2026-09-18 18:20:32','2026-09-19 06:20:32'),(87,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.1.11','2026-09-18 18:20:48','2026-09-19 06:20:48'),(88,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.1.11','2026-09-18 19:58:29','2026-09-19 07:58:29'),(89,NULL,'LOGIN','tblUsuario',5,'Inicio de sesión exitoso del usuario: Omorales','192.168.1.11','2026-09-18 20:25:30','2026-09-19 08:25:30'),(90,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.1.11','2026-09-18 20:38:01','2026-09-19 08:38:01'),(91,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.1.11','2026-09-18 22:15:35','2026-09-19 10:15:35'),(92,1,'INSERT','tblAsigAppPerf',3,'Se asignó aplicación 12 al rol 3','192.168.1.11','2026-09-18 22:16:49','2026-09-19 10:16:49'),(93,NULL,'LOGIN','tblUsuario',5,'Inicio de sesión exitoso del usuario: Omorales','192.168.1.11','2026-09-18 22:17:09','2026-09-19 10:17:09'),(94,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.1.11','2026-09-19 09:19:13','2026-09-19 21:19:13'),(95,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.1.11','2026-09-19 16:24:37','2026-09-20 04:24:37'),(96,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.1.11','2026-09-19 16:26:02','2026-09-20 04:26:02'),(97,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.1.11','2026-09-19 16:45:59','2026-09-20 04:45:59'),(98,1,'UPDATE','tblEmpleado',5,'Se actualizó el empleado: Oscar Emilio Morales Lemus','192.168.1.11','2026-09-19 16:46:27','2026-09-20 04:46:27'),(99,1,'UPDATE','tblEmpleado',5,'Se actualizó el empleado: Oscar Emilio Morales Lemus','192.168.1.11','2026-09-19 16:46:42','2026-09-20 04:46:42'),(100,1,'UPDATE','tblEmpleado',5,'Se actualizó el empleado: Oscar Emilio Morales Lemus','192.168.1.11','2026-09-19 16:47:25','2026-09-20 04:47:25'),(101,1,'INSERT','tblEmpleado',5,'Se agregó el empleado: Pepito Muralles','192.168.1.11','2026-09-19 16:49:06','2026-09-20 04:49:06'),(102,1,'UPDATE','tblEmpleado',12,'Se actualizó el empleado: Pepito Muralles','192.168.1.11','2026-09-19 16:49:29','2026-09-20 04:49:29'),(103,1,'UPDATE','tblEmpleado',5,'Se actualizó el empleado: Oscar Emilio Morales Lemus','192.168.1.11','2026-09-19 16:50:24','2026-09-20 04:50:24'),(104,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.1.11','2026-09-19 20:46:49','2026-09-20 08:46:49'),(105,1,'UPDATE','tblEmpleado',12,'Se actualizó el empleado: Pepito Muralles','192.168.1.11','2026-09-19 20:47:08','2026-09-20 08:47:08'),(106,1,'UPDATE','tblAplicacion',12,'Se actualizó la aplicación: Bitácora','192.168.1.11','2026-09-19 20:48:28','2026-09-20 08:48:28'),(107,1,'UPDATE','tblAplicacion',12,'Se actualizó la aplicación: Bitácora','192.168.1.11','2026-09-19 20:48:38','2026-09-20 08:48:38'),(108,1,'DELETE','tblAplicacion',1,'Se eliminó la aplicación ID: 1','192.168.1.11','2026-09-19 20:48:52','2026-09-20 08:48:52'),(109,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.1.11','2026-09-19 20:49:17','2026-09-20 08:49:17'),(110,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.1.11','2026-09-19 22:01:50','2026-09-20 10:01:50'),(111,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.1.11','2026-09-19 22:33:27','2026-09-20 10:33:27'),(112,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.1.11','2026-09-19 22:35:23','2026-09-20 10:35:23'),(113,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.1.11','2026-09-19 22:36:26','2026-09-20 10:36:26'),(114,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.1.11','2026-09-19 22:55:23','2026-09-20 10:55:23'),(115,1,'DELETE','tblRol',3,'Se eliminó el rol perfil: 3','192.168.1.11','2026-09-19 22:56:55','2026-09-20 10:56:55'),(116,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.1.11','2026-09-19 23:25:33','2026-09-20 11:25:33'),(117,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.1.11','2026-09-19 23:27:56','2026-09-20 11:27:56'),(118,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.1.11','2026-09-19 23:28:33','2026-09-20 11:28:33'),(119,1,'UPDATE','tblModulo',2,'Se actualizó el módulo: Inventario','192.168.1.11','2026-09-19 23:28:56','2026-09-20 11:28:56'),(120,1,'UPDATE','tblModulo',2,'Se actualizó el módulo: Inventario','192.168.1.11','2026-09-19 23:29:01','2026-09-20 11:29:01'),(121,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.1.11','2026-09-19 23:30:10','2026-09-20 11:30:10'),(122,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.1.11','2026-09-19 23:43:23','2026-09-20 11:43:23'),(123,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.1.11','2026-09-19 23:48:49','2026-09-20 11:48:49'),(124,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.1.11','2026-09-19 23:50:17','2026-09-20 11:50:17'),(125,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.1.11','2026-09-19 23:52:57','2026-09-20 11:52:58'),(126,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.1.11','2026-09-19 23:54:44','2026-09-20 11:54:44'),(127,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.1.11','2026-09-20 00:05:44','2026-09-20 12:05:44'),(128,1,'DELETE','tblAplicacion',2,'Se eliminó la aplicación ID: 2','192.168.1.11','2026-09-20 00:06:15','2026-09-20 12:06:15'),(129,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.1.11','2026-09-20 00:11:20','2026-09-20 12:11:20'),(130,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.1.11','2026-09-20 00:14:04','2026-09-20 12:14:04'),(131,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.1.11','2026-09-20 00:17:19','2026-09-20 12:17:19'),(132,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.1.11','2026-09-20 00:22:42','2026-09-20 12:22:42'),(133,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.1.11','2026-09-20 00:26:44','2026-09-20 12:26:44'),(134,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','172.20.10.4','2026-09-20 00:37:21','2026-09-20 12:37:21'),(135,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','172.20.10.4','2026-09-20 00:39:27','2026-09-20 12:39:27'),(136,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.1.2','2026-09-20 08:40:49','2026-09-20 20:40:49'),(137,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.1.2','2026-09-20 08:43:23','2026-09-20 20:43:23'),(138,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.1.2','2026-09-20 08:44:51','2026-09-20 20:44:51'),(139,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.1.2','2026-09-20 08:46:20','2026-09-20 20:46:20'),(140,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.1.2','2026-09-20 08:47:12','2026-09-20 20:47:12'),(141,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.1.2','2026-09-20 08:55:47','2026-09-20 20:55:48'),(142,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.1.2','2026-09-20 08:57:12','2026-09-20 20:57:12'),(143,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.1.2','2026-09-20 08:58:00','2026-09-20 20:58:00'),(144,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.1.2','2026-09-20 08:58:46','2026-09-20 20:58:46'),(145,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.1.2','2026-09-20 08:59:38','2026-09-20 20:59:38'),(146,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.1.2','2026-09-20 09:14:45','2026-09-20 21:14:45'),(147,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.1.2','2026-09-20 09:16:11','2026-09-20 21:16:11'),(148,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.1.2','2026-09-20 09:26:36','2026-09-20 21:26:36'),(149,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.1.2','2026-09-20 09:29:58','2026-09-20 21:29:58'),(150,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.1.2','2026-09-20 09:31:54','2026-09-20 21:31:54'),(151,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.1.2','2026-09-20 09:34:18','2026-09-20 21:34:18'),(152,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.1.2','2026-09-20 09:35:27','2026-09-20 21:35:27'),(153,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.1.2','2026-09-20 09:39:39','2026-09-20 21:39:39'),(154,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.1.2','2026-09-20 09:42:23','2026-09-20 21:42:23'),(155,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.1.2','2026-09-20 09:54:49','2026-09-20 21:54:49'),(156,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.1.2','2026-09-20 09:57:32','2026-09-20 21:57:32'),(157,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.1.2','2026-09-20 09:59:16','2026-09-20 21:59:16'),(158,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.1.2','2026-09-20 10:04:06','2026-09-20 22:04:06'),(159,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.1.2','2026-09-20 11:47:28','2026-09-20 23:47:28'),(160,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.1.2','2026-09-20 12:23:34','2026-09-21 00:23:34'),(161,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.1.2','2026-09-20 15:35:11','2026-09-21 03:35:11'),(162,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.1.2','2026-09-20 15:41:55','2026-09-21 03:41:55'),(163,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.1.2','2026-09-20 18:11:00','2026-09-21 06:11:00'),(164,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.1.2','2026-09-20 18:14:17','2026-09-21 06:14:17'),(165,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.1.2','2026-09-20 19:52:31','2026-09-21 07:52:31'),(166,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.1.2','2026-09-20 20:24:57','2026-09-21 08:24:58'),(167,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.1.2','2026-09-20 21:39:02','2026-09-21 09:39:02'),(168,1,'INSERT','tblUsuario',0,'Se agregó el usuario: Ppito','192.168.1.2','2026-09-20 21:39:53','2026-09-21 09:39:53'),(169,1,'UPDATE','tblUsuario',9,'Se actualizó el usuario: Ppito','192.168.1.2','2026-09-20 21:40:30','2026-09-21 09:40:30'),(170,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.1.2','2026-09-21 15:21:33','2026-09-22 03:21:33'),(171,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.1.2','2026-09-21 22:04:15','2026-09-22 10:04:15'),(172,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.1.2','2026-09-21 22:09:15','2026-09-22 10:09:15'),(173,1,'UPDATE','tblUsuario',9,'Se actualizó el usuario: Ppitote','192.168.1.2','2026-09-21 22:09:53','2026-09-22 10:09:53'),(174,1,'DELETE','tblUsuario',9,'Se eliminó el usuario ID: 9','192.168.1.2','2026-09-21 22:09:59','2026-09-22 10:10:00'),(175,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.1.2','2026-09-21 22:11:32','2026-09-22 10:11:32'),(176,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.1.2','2026-09-21 22:24:51','2026-09-22 10:24:51'),(177,1,'DELETE','tblUsuario',5,'Se eliminó el usuario ID: 5','192.168.1.2','2026-09-21 22:25:15','2026-09-22 10:25:15'),(178,1,'DELETE','tblEmpleado',5,'Se eliminó el empleado ID: 5','192.168.1.2','2026-09-21 22:25:25','2026-09-22 10:25:25'),(179,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.1.2','2026-09-21 22:29:12','2026-09-22 10:29:12'),(180,1,'INSERT','tblEmpleado',0,'Se agregó el empleado: Oscar Emilio Morales Lemus','192.168.1.2','2026-09-21 22:30:17','2026-09-22 10:30:17'),(181,1,'INSERT','tblUsuario',0,'Se agregó el usuario: Omorales','192.168.1.2','2026-09-21 22:30:38','2026-09-22 10:30:38'),(182,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.167.48','2026-09-22 06:47:05','2026-09-22 18:47:05'),(183,1,'DELETE','tblUsuario',11,'Se eliminó el usuario ID: 11','192.168.167.48','2026-09-22 06:48:42','2026-09-22 18:48:42'),(184,1,'DELETE','tblEmpleado',12,'Se eliminó el empleado ID: 12','192.168.167.48','2026-09-22 06:50:50','2026-09-22 18:50:51'),(185,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.167.48','2026-09-22 07:08:29','2026-09-22 19:08:29'),(186,1,'INSERT','tblEmpleado',0,'Se agregó el empleado: Empleado Examen','192.168.167.48','2026-09-22 07:11:30','2026-09-22 19:11:31'),(187,1,'INSERT','tblUsuario',0,'Se agregó el usuario: UsuarioExamen','192.168.167.48','2026-09-22 07:12:30','2026-09-22 19:12:30'),(188,1,'INSERT','tblRol',0,'Se agregó el perfil: PerfilExamen','192.168.167.48','2026-09-22 07:16:29','2026-09-22 19:16:29'),(189,12,'LOGIN','tblUsuario',12,'Inicio de sesión exitoso del usuario: UsuarioExamen','192.168.167.48','2026-09-22 07:17:23','2026-09-22 19:17:23'),(190,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.167.48','2026-09-22 07:19:39','2026-09-22 19:19:39'),(191,1,'INSERT','tblAsigAppPerf',12,'Se asignó aplicación 8 al rol 12','192.168.167.48','2026-09-22 07:20:38','2026-09-22 19:20:39'),(192,12,'LOGIN','tblUsuario',12,'Inicio de sesión exitoso del usuario: UsuarioExamen','192.168.167.48','2026-09-22 07:21:11','2026-09-22 19:21:11'),(193,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.167.48','2026-09-22 07:21:45','2026-09-22 19:21:45'),(194,1,'INSERT','tblUsuarioRol',12,'Se asignó el perfil 12 al usuario 12','192.168.167.48','2026-09-22 07:22:32','2026-09-22 19:22:32'),(195,12,'LOGIN','tblUsuario',12,'Inicio de sesión exitoso del usuario: UsuarioExamen','192.168.167.48','2026-09-22 07:22:48','2026-09-22 19:22:48'),(196,12,'INSERT','tblRol',0,'Se agregó el perfil: Prueba','192.168.167.48','2026-09-22 07:25:13','2026-09-22 19:25:13'),(197,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.167.48','2026-09-22 07:26:54','2026-09-22 19:26:54'),(198,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.1.2','2026-09-22 16:22:37','2026-09-23 04:22:37'),(199,1,'INSERT','tblModulo',0,'Se agregó el módulo: Contabilidad','192.168.1.2','2026-09-22 16:24:31','2026-09-23 04:24:31'),(200,1,'UPDATE','tblModulo',12,'Se actualizó el módulo: Contabilidad','192.168.1.2','2026-09-22 16:26:01','2026-09-23 04:26:01'),(201,1,'DELETE','tblModulo',12,'Se eliminó el módulo ID: 12','192.168.1.2','2026-09-22 16:28:47','2026-09-23 04:28:47'),(202,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.1.2','2026-09-22 16:57:01','2026-09-23 04:57:01'),(203,12,'LOGIN','tblUsuario',12,'Inicio de sesión exitoso del usuario: UsuarioExamen','192.168.1.2','2026-09-22 16:57:27','2026-09-23 04:57:27'),(204,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.1.2','2026-09-22 17:48:41','2026-09-23 05:48:41'),(205,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.1.2','2026-09-22 17:49:18','2026-09-23 05:49:18'),(206,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.1.2','2026-09-22 17:52:57','2026-09-23 05:52:57'),(207,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.1.2','2026-09-22 18:07:57','2026-09-23 06:07:57'),(208,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.1.2','2026-09-22 18:09:35','2026-09-23 06:09:35'),(209,12,'LOGIN','tblUsuario',12,'Inicio de sesión exitoso del usuario: UsuarioExamen','192.168.1.2','2026-09-22 18:10:11','2026-09-23 06:10:11'),(210,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.1.2','2026-09-22 19:16:51','2026-09-23 07:16:51'),(211,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.1.2','2026-09-22 20:21:32','2026-09-23 08:21:32'),(212,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.1.2','2026-09-22 20:28:21','2026-09-23 08:28:21'),(213,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.1.2','2026-09-22 20:39:51','2026-09-23 08:39:51'),(214,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.1.2','2026-09-22 21:38:32','2026-09-23 09:38:32'),(215,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.1.2','2026-09-22 23:32:12','2026-09-23 11:32:12'),(216,12,'LOGIN','tblUsuario',12,'Inicio de sesión exitoso del usuario: UsuarioExamen','192.168.1.2','2026-09-22 23:33:18','2026-09-23 11:33:18'),(217,2,'LOGIN','tblUsuario',2,'Inicio de sesión exitoso del usuario: cramirez','192.168.1.2','2026-09-22 23:33:42','2026-09-23 11:33:42'),(218,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.1.2','2026-09-22 23:34:17','2026-09-23 11:34:17'),(219,12,'LOGIN','tblUsuario',12,'Inicio de sesión exitoso del usuario: UsuarioExamen','192.168.1.2','2026-09-22 23:38:03','2026-09-23 11:38:03'),(220,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.1.2','2026-09-22 23:42:18','2026-09-23 11:42:18'),(221,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.1.2','2026-09-22 23:43:12','2026-09-23 11:43:12'),(222,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.1.2','2026-09-22 23:44:58','2026-09-23 11:44:58'),(223,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.1.2','2026-09-22 23:47:01','2026-09-23 11:47:01'),(224,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.1.2','2026-09-22 23:48:54','2026-09-23 11:48:54'),(225,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.1.2','2026-09-22 23:51:43','2026-09-23 11:51:43'),(226,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.1.2','2026-09-22 23:52:55','2026-09-23 11:52:55'),(227,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.1.2','2026-09-22 23:53:56','2026-09-23 11:53:56'),(228,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.1.2','2026-09-22 23:56:37','2026-09-23 11:56:37'),(229,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.1.2','2026-09-22 23:57:34','2026-09-23 11:57:34'),(230,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.1.2','2026-09-22 23:58:23','2026-09-23 11:58:23'),(231,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.1.2','2026-09-23 00:00:00','2026-09-23 12:00:00'),(232,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.1.2','2026-09-23 00:01:45','2026-09-23 12:01:45'),(233,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.1.2','2026-09-23 00:03:49','2026-09-23 12:03:49'),(234,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.1.2','2026-09-23 00:15:17','2026-09-23 12:15:17'),(235,12,'LOGIN','tblUsuario',12,'Inicio de sesión exitoso del usuario: UsuarioExamen','192.168.1.2','2026-09-23 00:15:49','2026-09-23 12:15:49'),(236,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.1.2','2026-09-23 17:32:40','2026-09-24 05:32:40'),(237,1,'UPDATE','tblEmpleado',1,'Se actualizó el empleado: Isabel Meléndez','192.168.1.2','2026-09-23 17:40:07','2026-09-24 05:40:07'),(238,1,'INSERT','tblEmpleado',1,'Se agregó el empleado: Pruebas Capacitacion','192.168.1.2','2026-09-23 17:42:57','2026-09-24 05:42:57'),(239,1,'INSERT','tblUsuario',0,'Se agregó el usuario: Pcapacitacion','192.168.1.2','2026-09-23 17:43:51','2026-09-24 05:43:51'),(240,1,'INSERT','tblModulo',0,'Se agregó el módulo: Pruebas','192.168.1.2','2026-09-23 17:44:26','2026-09-24 05:44:26'),(241,1,'INSERT','tblAplicacion',0,'Se agregó la aplicación: Prueba','192.168.1.2','2026-09-23 17:46:12','2026-09-24 05:46:12'),(242,1,'DELETE','tblRol',13,'Se eliminó el rol perfil: 13','192.168.1.2','2026-09-23 17:46:19','2026-09-24 05:46:19'),(243,1,'UPDATE','tblRol',1,'Se actualizó el perfil: Administrador','192.168.1.2','2026-09-23 17:46:22','2026-09-24 05:46:22'),(244,1,'INSERT','tblRol',1,'Se agregó el perfil: Prueba','192.168.1.2','2026-09-23 17:47:34','2026-09-24 05:47:34'),(245,1,'INSERT','tblUsuarioRol',13,'Se asignó el perfil 14 al usuario 13','192.168.1.2','2026-09-23 17:47:47','2026-09-24 05:47:47'),(246,1,'INSERT','tblAsigAppPerf',14,'Se asignó aplicación 15 al rol 14','192.168.1.2','2026-09-23 17:48:40','2026-09-24 05:48:40'),(247,1,'INSERT','tblAsigAppUsuario',13,'Se asignó aplicación 15 al módulo 13','192.168.1.2','2026-09-23 17:49:15','2026-09-24 05:49:15'),(248,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.1.2','2026-09-23 19:44:06','2026-09-24 07:44:07'),(249,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.1.71','2026-11-14 13:09:00','2026-11-14 19:09:00'),(250,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.1.71','2026-11-14 13:28:39','2026-11-14 19:28:39'),(251,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.1.71','2026-11-14 13:29:42','2026-11-14 19:29:42'),(252,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.1.71','2026-11-14 13:31:03','2026-11-14 19:31:03'),(253,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.1.71','2026-11-14 13:32:27','2026-11-14 19:32:27'),(254,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.1.71','2026-11-14 13:33:30','2026-11-14 19:33:30'),(255,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.1.71','2026-11-14 13:33:52','2026-11-14 19:33:52'),(256,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.1.71','2026-11-14 13:34:06','2026-11-14 19:34:06'),(257,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.1.71','2026-11-14 13:34:43','2026-11-14 19:34:43'),(258,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.1.71','2026-11-14 13:35:13','2026-11-14 19:35:13'),(259,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.1.71','2026-11-14 13:36:56','2026-11-14 19:36:56'),(260,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.1.71','2026-11-14 14:02:19','2026-11-14 20:02:19'),(261,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.1.71','2026-11-14 14:03:02','2026-11-14 20:03:02'),(262,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.1.71','2026-11-14 14:05:33','2026-11-14 20:05:33'),(263,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.1.71','2026-11-14 14:05:51','2026-11-14 20:05:51'),(264,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.1.71','2026-11-14 14:06:03','2026-11-14 20:06:03'),(265,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.1.71','2026-11-14 14:06:19','2026-11-14 20:06:19'),(266,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.1.71','2026-11-14 14:06:37','2026-11-14 20:06:37'),(267,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.1.71','2026-11-14 14:07:18','2026-11-14 20:07:18'),(268,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.1.71','2026-11-14 14:07:40','2026-11-14 20:07:40'),(269,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.1.71','2026-11-14 14:07:58','2026-11-14 20:07:58'),(270,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.1.71','2026-11-14 14:08:13','2026-11-14 20:08:13'),(271,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.1.71','2026-11-14 14:08:26','2026-11-14 20:08:26'),(272,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.1.71','2026-11-14 14:08:39','2026-11-14 20:08:39'),(273,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.1.71','2026-11-14 14:10:17','2026-11-14 20:10:17'),(274,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.1.71','2026-11-14 14:12:24','2026-11-14 20:12:25'),(275,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.1.71','2026-11-14 14:43:44','2026-11-14 20:43:44'),(276,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.1.71','2026-11-14 14:43:58','2026-11-14 20:43:58'),(277,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.1.71','2026-11-14 14:46:33','2026-11-14 20:46:33'),(278,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.1.71','2026-11-14 14:48:18','2026-11-14 20:48:18'),(279,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.1.71','2026-11-14 14:49:27','2026-11-14 20:49:27'),(280,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.1.71','2026-11-14 14:49:49','2026-11-14 20:49:49'),(281,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.1.71','2026-11-14 14:50:18','2026-11-14 20:50:18'),(282,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.1.71','2026-11-14 17:57:27','2026-11-14 23:57:27'),(283,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.1.71','2026-11-14 18:45:16','2026-11-15 00:45:16'),(284,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.1.71','2026-11-14 18:51:51','2026-11-15 00:51:51'),(285,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.1.71','2026-11-14 19:22:04','2026-11-15 01:22:04'),(286,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.1.71','2026-11-14 19:24:17','2026-11-15 01:24:17'),(287,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.1.71','2026-11-14 19:25:50','2026-11-15 01:25:50'),(288,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.1.71','2026-11-14 19:47:39','2026-11-15 01:47:39'),(289,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.1.71','2026-11-14 20:48:11','2026-11-15 02:48:11'),(290,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.1.71','2026-11-14 20:52:17','2026-11-15 02:52:17'),(291,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.1.71','2026-11-14 21:46:36','2026-11-15 03:46:36'),(292,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.1.71','2026-11-14 21:49:02','2026-11-15 03:49:03'),(293,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.1.71','2026-11-14 22:00:10','2026-11-15 04:00:10'),(294,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.1.32','2026-11-22 19:24:32','2026-11-23 01:24:33'),(295,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.1.32','2026-11-23 23:02:19','2026-11-24 05:02:19'),(296,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.1.32','2026-11-23 23:07:37','2026-11-24 05:07:37'),(297,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.1.32','2026-11-23 23:09:25','2026-11-24 05:09:25'),(298,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.1.32','2026-11-23 23:10:52','2026-11-24 05:10:52'),(299,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.1.32','2026-11-23 23:22:55','2026-11-24 05:22:55'),(300,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.1.32','2026-11-23 23:24:27','2026-11-24 05:24:27'),(301,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.1.32','2026-11-23 23:25:24','2026-11-24 05:25:25'),(302,1,'INSERT','tblAsigAppPerf',1,'Se asignó aplicación 9150 al rol 1','192.168.1.32','2026-11-23 23:26:42','2026-11-24 05:26:42'),(303,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.1.32','2026-11-23 23:26:52','2026-11-24 05:26:52'),(304,1,'INSERT','tbl_paciente',1,'Se insertó un registro en tbl_paciente: idPaciente: 1\nnombrePaciente: manolo\napellidoPaciente: manolin\nfechaNacimientoPaciente: 2004-08-13\nsexoPaciente: M\ndireccionPaciente: zona 16\ntelefonoPaciente: 45782136\nestadoPaciente: 1\n','192.168.1.32','2026-11-23 23:28:04','2026-11-24 05:28:04'),(305,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.56.1','2026-11-24 08:56:34','2026-11-24 14:56:34'),(306,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.56.1','2026-11-24 08:56:59','2026-11-24 14:56:59'),(307,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.56.1','2026-11-24 09:17:34','2026-11-24 15:17:34'),(308,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.56.1','2026-11-24 09:26:05','2026-11-24 15:26:05'),(309,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.56.1','2026-11-24 09:29:04','2026-11-24 15:29:04'),(310,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.56.1','2026-11-24 09:32:58','2026-11-24 15:32:58'),(311,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.56.1','2026-11-24 09:41:56','2026-11-24 15:41:56'),(312,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.56.1','2026-11-24 09:50:23','2026-11-24 15:50:23'),(313,1,'LOGIN','tblUsuario',1,'Inicio de sesión exitoso del usuario: imelendez','192.168.56.1','2026-11-24 09:54:49','2026-11-24 15:54:49'),(314,1,'INSERT','tblempleado',32,'Se insertó un registro en tblempleado: idEmpleado: 32\ncodigoEmpleado: EMP-023\ndpiEmpleado: 1236547895215\nnitEmpleado: 2659872-5\nnombresEmpleado: UsuarioFinal\napellidosEmpleado: Final\nidDepartamento: 3\nidJornada: 3\nsalarioEmpleado: 3000\ngeneroEmpleado: M\nfechaNacimientoEmpleado: 2005-07-18\nfechaContratacionEmpleado: 2026-11-24\ntelefonoEmpleado: 15487526\ncorreoEmpleado: UsuF@miumg.edu.gt\nis_active: 1\ncreated_at: 2026-11-24\nupdated_at: 2026-11-24\n','192.168.56.1','2026-11-24 09:57:05','2026-11-24 15:57:05'),(315,1,'INSERT','tblUsuario',0,'Se agregó el usuario: UsuarioFinal','192.168.56.1','2026-11-24 09:57:45','2026-11-24 15:57:45'),(316,1,'INSERT','tblUsuarioRol',22,'Se asignó el perfil 1 al usuario 22','192.168.56.1','2026-11-24 09:58:07','2026-11-24 15:58:07'),(317,22,'LOGIN','tblUsuario',22,'Inicio de sesión exitoso del usuario: UsuarioFinal','192.168.56.1','2026-11-24 09:58:32','2026-11-24 15:58:32'),(318,22,'INSERT','tbl_paciente',2,'Se insertó un registro en tbl_paciente: idPaciente: 2\nnombrePaciente: Examen\napellidoPaciente: Examen Final\nfechaNacimientoPaciente: 2000-06-13\nsexoPaciente: M\ndireccionPaciente: Zona 4\ntelefonoPaciente: 24685785\nestadoPaciente: 1\n','192.168.56.1','2026-11-24 09:59:26','2026-11-24 15:59:27'),(319,22,'INSERT','tbl_paciente',3,'Se insertó un registro en tbl_paciente: idPaciente: 3\nnombrePaciente: otro examen\napellidoPaciente: Final\nfechaNacimientoPaciente: 2004-06-15\nsexoPaciente: F\ndireccionPaciente: zona 7\ntelefonoPaciente: 26487596\nestadoPaciente: 1\n','192.168.56.1','2026-11-24 09:59:59','2026-11-24 15:59:59');
/*!40000 ALTER TABLE `tblbitacora` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblbodega`
--

DROP TABLE IF EXISTS `tblbodega`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblbodega` (
  `idBodega` int NOT NULL AUTO_INCREMENT,
  `nombreBodega` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Fk_Sucursal_Codigo` int NOT NULL,
  `paisBodega` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idBodega`),
  UNIQUE KEY `uqBodegaSucursal` (`idBodega`,`Fk_Sucursal_Codigo`),
  KEY `Fk_Bodega_Sucursal` (`Fk_Sucursal_Codigo`),
  CONSTRAINT `Fk_Bodega_Sucursal` FOREIGN KEY (`Fk_Sucursal_Codigo`) REFERENCES `tblsucursal` (`idSucursal`) ON DELETE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblbodega`
--

LOCK TABLES `tblbodega` WRITE;
/*!40000 ALTER TABLE `tblbodega` DISABLE KEYS */;
INSERT INTO `tblbodega` VALUES (1,'Bodega Central de Refrigerados',1,'Guatemala','2026-11-14 18:34:39','2026-11-14 18:34:39'),(2,'Bodega Mixco',2,'Guatemala','2026-11-14 18:34:39','2026-11-14 18:34:39'),(3,'Bodega Villa Nueva',3,'Guatemala','2026-11-14 18:34:39','2026-11-14 18:34:39'),(4,'Bodega Occidente',4,'Guatemala','2026-11-14 18:34:39','2026-11-14 18:34:39'),(5,'Bodega Costa Sur',5,'Guatemala','2026-11-14 18:34:39','2026-11-14 18:34:39'),(6,'FAC-QA Zona 9',6,'Guatemala','2026-11-14 18:34:40','2026-11-14 18:34:40'),(7,'FAC-QA Zona 11',6,'Guatemala','2026-11-14 18:34:40','2026-11-14 18:34:40');
/*!40000 ALTER TABLE `tblbodega` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblcamararefrigeracion`
--

DROP TABLE IF EXISTS `tblcamararefrigeracion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblcamararefrigeracion` (
  `idCamaraRefrigeracion` int NOT NULL AUTO_INCREMENT,
  `Fk_Transporte_Codigo` int NOT NULL,
  `marcaEquipoCamaraRefrigeracion` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tempMinimaCelsiusCamaraRefrigeracion` decimal(5,2) NOT NULL,
  `tempMaximaCelsiusCamaraRefrigeracion` decimal(5,2) NOT NULL,
  `estadoOperativoCamaraRefrigeracion` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'OPERATIVO',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idCamaraRefrigeracion`),
  UNIQUE KEY `uqIdTransporteCamaraRefrigeracion` (`Fk_Transporte_Codigo`),
  CONSTRAINT `Fk_Camara_Refrigeracion_Transporte` FOREIGN KEY (`Fk_Transporte_Codigo`) REFERENCES `tbltransporte` (`idTransporte`) ON DELETE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblcamararefrigeracion`
--

LOCK TABLES `tblcamararefrigeracion` WRITE;
/*!40000 ALTER TABLE `tblcamararefrigeracion` DISABLE KEYS */;
INSERT INTO `tblcamararefrigeracion` VALUES (1,1,'Thermo King T-800',0.00,5.00,'OPERATIVO','2026-11-14 18:34:39','2026-11-14 18:34:39'),(2,2,'Carrier Xarios 350',0.00,6.00,'OPERATIVO','2026-11-14 18:34:39','2026-11-14 18:34:39'),(3,3,'Thermo King V-500',1.00,5.00,'OPERATIVO','2026-11-14 18:34:39','2026-11-14 18:34:39'),(4,4,'Carrier Neos 100',0.00,5.00,'OPERATIVO','2026-11-14 18:34:39','2026-11-14 18:34:39'),(5,5,'Thermo King SLXi 400',-2.00,5.00,'OPERATIVO','2026-11-14 18:34:39','2026-11-14 18:34:39');
/*!40000 ALTER TABLE `tblcamararefrigeracion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblcapacitacion`
--

DROP TABLE IF EXISTS `tblcapacitacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblcapacitacion` (
  `idCapacitacion` int NOT NULL AUTO_INCREMENT,
  `idInstructor` int DEFAULT NULL,
  `idDepartamento` int DEFAULT NULL,
  `nombreCapacitacion` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcionCapacitacion` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fechaInicioCapacitacion` date NOT NULL,
  `fechaFinCapacitacion` date NOT NULL,
  `costoCapacitacion` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `cupoCapacitacion` int NOT NULL,
  `estadoCapacitacion` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idCapacitacion`),
  KEY `Fk_Capacitacion_Departamento` (`idDepartamento`),
  KEY `Fk_Capacitacion_Instructor` (`idInstructor`),
  CONSTRAINT `Fk_Capacitacion_Departamento` FOREIGN KEY (`idDepartamento`) REFERENCES `tbldepartamento` (`idDepartamento`),
  CONSTRAINT `Fk_Capacitacion_Instructor` FOREIGN KEY (`idInstructor`) REFERENCES `tblinstructor` (`idInstructor`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblcapacitacion`
--

LOCK TABLES `tblcapacitacion` WRITE;
/*!40000 ALTER TABLE `tblcapacitacion` DISABLE KEYS */;
INSERT INTO `tblcapacitacion` VALUES (1,1,5,'Seguridad e Higiene Industrial','Manejo seguro de maquinaria y normas de higiene en planta','2026-09-14','2026-09-18',1200.0000,20,1,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(2,2,4,'Excel Avanzado','Fórmulas, tablas dinámicas y reportes','2026-09-21','2026-09-25',850.0000,15,1,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(3,3,6,'Atención al Cliente','Técnicas de servicio y manejo de quejas','2026-10-05','2026-10-09',600.0000,25,1,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(4,4,NULL,'Liderazgo y Trabajo en Equipo','Habilidades de liderazgo para todas las áreas','2026-10-12','2026-10-16',1500.0000,30,1,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(5,5,1,'Inducción a Sistemas ERP','Uso básico del ERP y flujos de información','2026-10-19','2026-10-23',900.0000,12,1,'2026-11-14 18:34:37','2026-11-14 18:34:37');
/*!40000 ALTER TABLE `tblcapacitacion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblcategoria`
--

DROP TABLE IF EXISTS `tblcategoria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblcategoria` (
  `idCategoria` int NOT NULL AUTO_INCREMENT,
  `nombreCategoria` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `porcentajeComisionCategoria` decimal(3,2) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idCategoria`),
  UNIQUE KEY `uqCategoriaNombre` (`nombreCategoria`),
  CONSTRAINT `ckPorcentajeComisionCategoriaRango` CHECK (((`porcentajeComisionCategoria` >= 0.00) and (`porcentajeComisionCategoria` <= 0.99)))
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblcategoria`
--

LOCK TABLES `tblcategoria` WRITE;
/*!40000 ALTER TABLE `tblcategoria` DISABLE KEYS */;
INSERT INTO `tblcategoria` VALUES (1,'Salchichas',0.10,'2026-11-14 18:34:39','2026-11-14 18:34:39'),(2,'Chorizos',0.12,'2026-11-14 18:34:39','2026-11-14 18:34:39'),(3,'Jamones',0.15,'2026-11-14 18:34:39','2026-11-14 18:34:39'),(4,'Mortadelas',0.08,'2026-11-14 18:34:39','2026-11-14 18:34:39'),(5,'Tocinos',0.11,'2026-11-14 18:34:39','2026-11-14 18:34:39'),(6,'FAC-QA Embutidos',0.00,'2026-11-14 18:34:40','2026-11-14 18:34:40');
/*!40000 ALTER TABLE `tblcategoria` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblcheque`
--

DROP TABLE IF EXISTS `tblcheque`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblcheque` (
  `idCheque` bigint NOT NULL AUTO_INCREMENT,
  `numeroCheque` bigint NOT NULL,
  `beneficiarioCheque` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `estadoCheque` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'GENERADO',
  `referenciaEvidencia2FACheque` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fechaValidacion2FACheque` datetime NOT NULL,
  `identificadorGeneradorCheque` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Fk_Chequera_Codigo` bigint NOT NULL,
  `Fk_OrdenPago_Codigo` bigint NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idCheque`),
  UNIQUE KEY `uqCheque1` (`Fk_Chequera_Codigo`,`numeroCheque`),
  UNIQUE KEY `uqCheque2` (`Fk_OrdenPago_Codigo`),
  CONSTRAINT `Fk_Cheque_Chequera` FOREIGN KEY (`Fk_Chequera_Codigo`) REFERENCES `tblchequera` (`idChequera`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `Fk_Cheque_OrdenPago` FOREIGN KEY (`Fk_OrdenPago_Codigo`) REFERENCES `tblordenpago` (`idOrdenPago`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `ckCheque1` CHECK ((`estadoCheque` in (_utf8mb4'GENERADO',_utf8mb4'ENTREGADO',_utf8mb4'COBRADO',_utf8mb4'ANULADO')))
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblcheque`
--

LOCK TABLES `tblcheque` WRITE;
/*!40000 ALTER TABLE `tblcheque` DISABLE KEYS */;
INSERT INTO `tblcheque` VALUES (1,1001,'Distribuidora de Carnes La Esperanza, S.A.','COBRADO','2FA-20261103-0002','2026-11-03 11:30:00','tesoreria.ana',1,1,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(2,5001,'Empaques y Etiquetas de Guatemala, S.A.','COBRADO','2FA-20261104-0002','2026-11-04 11:15:00','tesoreria.ana',2,2,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(3,8001,'Carlos Mendez Ruiz','ENTREGADO','2FA-20261105-0002','2026-11-05 09:50:00','tesoreria.ana',4,3,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(4,3001,'Importadora de Maquinaria Alimenticia, S.A.','GENERADO','2FA-20261106-0003','2026-11-06 09:10:00','tesoreria.luis',3,4,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(5,1002,'Especias y Condimentos del Pacifico, S.A.','GENERADO','2FA-20261106-0004','2026-11-06 09:25:00','tesoreria.luis',1,5,'2026-11-14 18:34:37','2026-11-14 18:34:37');
/*!40000 ALTER TABLE `tblcheque` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblchequera`
--

DROP TABLE IF EXISTS `tblchequera`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblchequera` (
  `idChequera` bigint NOT NULL AUTO_INCREMENT,
  `serieChequera` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `numeroInicialChequera` bigint NOT NULL,
  `numeroFinalChequera` bigint NOT NULL,
  `siguienteNumeroChequera` bigint NOT NULL,
  `Fk_CuentaBancaria_Codigo` bigint NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idChequera`),
  UNIQUE KEY `uqChequera1` (`Fk_CuentaBancaria_Codigo`,`serieChequera`),
  CONSTRAINT `Fk_Chequera_Cuenta` FOREIGN KEY (`Fk_CuentaBancaria_Codigo`) REFERENCES `tblcuentabancaria` (`idCuentaBancaria`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `ckChequera1` CHECK ((`numeroInicialChequera` > 0)),
  CONSTRAINT `ckChequera2` CHECK ((`numeroFinalChequera` >= `numeroInicialChequera`)),
  CONSTRAINT `ckChequera3` CHECK ((`siguienteNumeroChequera` between `numeroInicialChequera` and (`numeroFinalChequera` + 1))),
  CONSTRAINT `ckChequera4` CHECK ((`is_active` in (0,1)))
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblchequera`
--

LOCK TABLES `tblchequera` WRITE;
/*!40000 ALTER TABLE `tblchequera` DISABLE KEYS */;
INSERT INTO `tblchequera` VALUES (1,'BIND-A',1001,1100,1003,1,1,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(2,'BRUR-A',5001,5050,5002,2,1,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(3,'BAC-A',3001,3025,3002,3,1,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(4,'GYT-A',8001,8050,8002,4,1,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(5,'BAM-A',9001,9025,9001,5,1,'2026-11-14 18:34:37','2026-11-14 18:34:37');
/*!40000 ALTER TABLE `tblchequera` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblcierreinventario`
--

DROP TABLE IF EXISTS `tblcierreinventario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblcierreinventario` (
  `idCierreInventario` int NOT NULL AUTO_INCREMENT,
  `nombreCierreInventario` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Fk_Sucursal_Codigo` int NOT NULL,
  `fechaInicioCierreInventario` date NOT NULL,
  `fechaFinCierreInventario` date NOT NULL,
  `esCierreAnualCierreInventario` tinyint(1) NOT NULL DEFAULT '0',
  `diferenciaUnidadesCierreInventario` int NOT NULL DEFAULT '0',
  `diferenciaMontoCierreInventario` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `motivoAceptacionCierreInventario` varchar(500) COLLATE utf8mb4_unicode_ci NOT NULL,
  `observacionesCierreInventario` varchar(500) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fechaEjecucionCierreInventario` datetime DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idCierreInventario`),
  UNIQUE KEY `uqCierreInventarioSucursalFin` (`Fk_Sucursal_Codigo`,`fechaFinCierreInventario`,`esCierreAnualCierreInventario`),
  CONSTRAINT `Fk_Cierre_Inventario_Sucursal` FOREIGN KEY (`Fk_Sucursal_Codigo`) REFERENCES `tblsucursal` (`idSucursal`) ON DELETE RESTRICT,
  CONSTRAINT `ckCierreInventarioFechas` CHECK ((`fechaInicioCierreInventario` <= `fechaFinCierreInventario`))
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblcierreinventario`
--

LOCK TABLES `tblcierreinventario` WRITE;
/*!40000 ALTER TABLE `tblcierreinventario` DISABLE KEYS */;
INSERT INTO `tblcierreinventario` VALUES (1,'Cierre octubre 2026 - Central',1,'2026-10-01','2026-10-31',0,0,0.0000,'Conteo y saldos conciliados, sin diferencias.','Cierre mensual validado por el responsable de inventario.','2026-11-01 08:00:00','2026-11-14 18:34:39','2026-11-14 18:34:39'),(2,'Cierre octubre 2026 - Mixco',2,'2026-10-01','2026-10-31',0,0,0.0000,'Conteo y saldos conciliados, sin diferencias.','Cierre mensual conforme al kardex de la bodega.','2026-11-01 08:20:00','2026-11-14 18:34:39','2026-11-14 18:34:39'),(3,'Cierre octubre 2026 - Villa Nueva',3,'2026-10-01','2026-10-31',0,0,0.0000,'Movimientos de entrada y salida verificados.','Cierre aprobado sin ajustes pendientes.','2026-11-01 08:40:00','2026-11-14 18:34:39','2026-11-14 18:34:39'),(4,'Cierre octubre 2026 - Quetzaltenango',4,'2026-10-01','2026-10-31',0,0,0.0000,'Existencias y reportes coincidentes.','Cierre del centro regional de occidente.','2026-11-01 09:00:00','2026-11-14 18:34:39','2026-11-14 18:34:39'),(5,'Cierre octubre 2026 - Escuintla',5,'2026-10-01','2026-10-31',0,0,0.0000,'Saldos y conteos confirmados por encargado.','Cierre del centro regional de la costa sur.','2026-11-01 09:20:00','2026-11-14 18:34:39','2026-11-14 18:34:39');
/*!40000 ALTER TABLE `tblcierreinventario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblcierremovimientocxcdetalle`
--

DROP TABLE IF EXISTS `tblcierremovimientocxcdetalle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblcierremovimientocxcdetalle` (
  `idCierreMovimientoCxCDetalle` int NOT NULL AUTO_INCREMENT,
  `idCierreMovimientoCxCEncabezado` int NOT NULL,
  `idFacturaEncabezado` int NOT NULL,
  `saldoInicialCierreMovimientoCxCDetalle` decimal(12,4) NOT NULL,
  `cargosPeriodoCierreMovimientoCxCDetalle` decimal(12,4) NOT NULL,
  `abonosPeriodoCierreMovimientoCxCDetalle` decimal(12,4) NOT NULL,
  `saldoFinalCierreMovimientoCxCDetalle` decimal(12,4) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idCierreMovimientoCxCEncabezado`,`idCierreMovimientoCxCDetalle`),
  UNIQUE KEY `uqCierreMovimientoCxCDetalleCierreMovimientoCxCEncabeza4f1c6502` (`idCierreMovimientoCxCEncabezado`,`idFacturaEncabezado`),
  UNIQUE KEY `uqCierreMovimientoCxCDetalleId` (`idCierreMovimientoCxCDetalle`),
  KEY `idxCierreMovimientoCxCDetalleFacturaEncabezadoCodigo` (`idFacturaEncabezado`),
  CONSTRAINT `Fk_CierreMovimientoCxCDetalle_CierreMovimientoCxCEncabezado` FOREIGN KEY (`idCierreMovimientoCxCEncabezado`) REFERENCES `tblcierremovimientocxcencabezado` (`idCierreMovimientoCxCEncabezado`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `Fk_CierreMovimientoCxCDetalle_FacturaEncabezado` FOREIGN KEY (`idFacturaEncabezado`) REFERENCES `tblfacturaencabezado` (`idFacturaEncabezado`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblcierremovimientocxcdetalle`
--

LOCK TABLES `tblcierremovimientocxcdetalle` WRITE;
/*!40000 ALTER TABLE `tblcierremovimientocxcdetalle` DISABLE KEYS */;
/*!40000 ALTER TABLE `tblcierremovimientocxcdetalle` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblcierremovimientocxcencabezado`
--

DROP TABLE IF EXISTS `tblcierremovimientocxcencabezado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblcierremovimientocxcencabezado` (
  `idCierreMovimientoCxCEncabezado` int NOT NULL AUTO_INCREMENT,
  `numeroCierreMovimientoCxCEncabezado` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fechaDesdeCierreMovimientoCxCEncabezado` date NOT NULL,
  `fechaHastaCierreMovimientoCxCEncabezado` date NOT NULL,
  `fechaCorteCierreMovimientoCxCEncabezado` date NOT NULL,
  `idMoneda` bigint NOT NULL,
  `tipoCierreMovimientoCxCEncabezado` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `estadoCierreMovimientoCxCEncabezado` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `documentosRevisadosCierreMovimientoCxCEncabezado` tinyint(1) NOT NULL DEFAULT '0',
  `pagosConciliadosCierreMovimientoCxCEncabezado` tinyint(1) NOT NULL DEFAULT '0',
  `observacionesCierreMovimientoCxCEncabezado` text COLLATE utf8mb4_unicode_ci,
  `idUsuarioResponsable` int NOT NULL,
  `fechaConfirmacionCierreMovimientoCxCEncabezado` datetime DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idCierreMovimientoCxCEncabezado`),
  UNIQUE KEY `uqCierreMovimientoCxCEncabezadonumero` (`numeroCierreMovimientoCxCEncabezado`),
  KEY `idxCierreMovimientoCxCEncabezadoMonedaCodigofechaDesdefechaHasta` (`idMoneda`,`fechaDesdeCierreMovimientoCxCEncabezado`,`fechaHastaCierreMovimientoCxCEncabezado`),
  KEY `idxCierreMovimientoCxCEncabezadoUsuarioResponsable` (`idUsuarioResponsable`),
  CONSTRAINT `Fk_CierreMovimientoCxCEncabezado_Moneda` FOREIGN KEY (`idMoneda`) REFERENCES `tblmoneda` (`idMoneda`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `Fk_CierreMovimientoCxCEncabezado_Usuario_Responsable` FOREIGN KEY (`idUsuarioResponsable`) REFERENCES `tblusuario` (`idUsuario`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `ckCierreMovimientoCxCEncabezadodocumentosRevisadosCierra3aaae2a` CHECK ((`documentosRevisadosCierreMovimientoCxCEncabezado` in (0,1))),
  CONSTRAINT `ckCierreMovimientoCxCEncabezadoFechasCoherentes` CHECK ((`fechaHastaCierreMovimientoCxCEncabezado` >= `fechaDesdeCierreMovimientoCxCEncabezado`)),
  CONSTRAINT `ckCierreMovimientoCxCEncabezadopagosConciliadosCierreMob8223bf3` CHECK ((`pagosConciliadosCierreMovimientoCxCEncabezado` in (0,1))),
  CONSTRAINT `ckCierreMovimientoCxCEncabezadoValoresEstadoCierre` CHECK ((`estadoCierreMovimientoCxCEncabezado` in (_utf8mb4'BORRADOR',_utf8mb4'CONFIRMADO',_utf8mb4'ANULADO'))),
  CONSTRAINT `ckCierreMovimientoCxCEncabezadoValoresTipoCierre` CHECK ((`tipoCierreMovimientoCxCEncabezado` in (_utf8mb4'MENSUAL',_utf8mb4'ANUAL')))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblcierremovimientocxcencabezado`
--

LOCK TABLES `tblcierremovimientocxcencabezado` WRITE;
/*!40000 ALTER TABLE `tblcierremovimientocxcencabezado` DISABLE KEYS */;
/*!40000 ALTER TABLE `tblcierremovimientocxcencabezado` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblcierrenomina`
--

DROP TABLE IF EXISTS `tblcierrenomina`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblcierrenomina` (
  `idCierreNomina` int NOT NULL AUTO_INCREMENT,
  `periodoCierreNomina` char(7) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'AAAA-MM, mismo formato del período contable',
  `fechaInicioCierreNomina` date NOT NULL COMMENT 'Primer día del mes cerrado',
  `fechaFinalCierreNomina` date NOT NULL COMMENT 'Último día del mes cerrado',
  `cantidadEmpleadoCierreNomina` int NOT NULL DEFAULT '0',
  `totalPercepcionCierreNomina` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `totalDeduccionCierreNomina` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `totalNetoCierreNomina` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `totalPatronalCierreNomina` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `totalDebeCierreNomina` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `totalHaberCierreNomina` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `documentoOrigenCierreNomina` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Documento origen enviado a Contabilidad (máx. 30, igual que tblPolizaEncabezado; ej. NOM-2026-10 o NOM-2026-10-Q2)',
  `codigoPolizaCierreNomina` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'CodigoPoliza devuelto por Contabilidad',
  `fechaPolizaCierreNomina` date NOT NULL,
  `estadoPolizaCierreNomina` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Estado devuelto por Contabilidad (BORRADOR, VALIDADA, APLICADA o ANULADA)',
  `idUsuarioCierra` int NOT NULL,
  `fechaEjecucionCierreNomina` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idCierreNomina`),
  UNIQUE KEY `uqCierreNominaPeriodo` (`periodoCierreNomina`),
  UNIQUE KEY `uqCierreNominaDocumentoOrigen` (`documentoOrigenCierreNomina`),
  UNIQUE KEY `uqCierreNominaCodigoPoliza` (`codigoPolizaCierreNomina`),
  KEY `Fk_CierreNomina_Usuario` (`idUsuarioCierra`),
  CONSTRAINT `Fk_CierreNomina_Usuario` FOREIGN KEY (`idUsuarioCierra`) REFERENCES `tblusuario` (`idUsuario`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `ckCierreNominaCuadre` CHECK ((`totalDebeCierreNomina` = `totalHaberCierreNomina`)),
  CONSTRAINT `ckCierreNominaFechas` CHECK ((`fechaFinalCierreNomina` >= `fechaInicioCierreNomina`))
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblcierrenomina`
--

LOCK TABLES `tblcierrenomina` WRITE;
/*!40000 ALTER TABLE `tblcierrenomina` DISABLE KEYS */;
INSERT INTO `tblcierrenomina` VALUES (1,'2026-06','2026-06-01','2026-06-30',1,6581.2499,317.8744,6263.3755,833.8444,7415.0943,7415.0943,'NOM-2026-06','POL-NOM-2026-06','2026-06-30','APLICADA',1,'2026-07-01 08:30:00','2026-11-14 18:34:37','2026-11-14 18:34:37'),(2,'2026-07','2026-07-01','2026-07-31',1,6540.6250,315.9122,6224.7128,828.6972,7369.3222,7369.3222,'NOM-2026-07','POL-NOM-2026-07','2026-07-31','APLICADA',1,'2026-08-03 08:30:00','2026-11-14 18:34:37','2026-11-14 18:34:37'),(3,'2026-08','2026-08-01','2026-08-31',1,6560.9374,316.8933,6244.0441,831.2708,7392.2082,7392.2082,'NOM-2026-08','POL-NOM-2026-08','2026-08-31','APLICADA',1,'2026-09-01 08:30:00','2026-11-14 18:34:37','2026-11-14 18:34:37'),(4,'2026-09','2026-09-01','2026-09-30',1,6601.5624,318.8555,6282.7069,836.4180,7437.9804,7437.9804,'NOM-2026-09','POL-NOM-2026-09','2026-09-30','APLICADA',1,'2026-10-01 08:30:00','2026-11-14 18:34:37','2026-11-14 18:34:37'),(5,'2026-10','2026-10-01','2026-10-31',1,6581.2499,317.8744,6263.3755,833.8444,7415.0943,7415.0943,'NOM-2026-10','POL-NOM-2026-10','2026-10-31','VALIDADA',1,'2026-11-02 08:30:00','2026-11-14 18:34:37','2026-11-14 18:34:37'),(6,'2025-12','2025-12-01','2025-12-31',5,33250.0000,1845.6000,31404.4000,4212.7750,37462.7750,37462.7750,'NOM-2025-12','POL-NOM-2025-12','2025-12-31','VALIDADA',1,'2026-01-02 08:30:00','2026-11-14 18:34:38','2026-11-14 18:34:38'),(7,'2026-01','2026-01-01','2026-01-31',5,33250.0000,1845.6000,31404.4000,4212.7750,37462.7750,37462.7750,'NOM-2026-01','POL-NOM-2026-01','2026-01-31','VALIDADA',1,'2026-02-02 08:30:00','2026-11-14 18:34:38','2026-11-14 18:34:38'),(8,'2026-02','2026-02-01','2026-02-28',6,41000.0000,2357.8500,38642.1500,5194.7000,46194.7000,46194.7000,'NOM-2026-02','POL-NOM-2026-02','2026-02-28','VALIDADA',1,'2026-03-02 08:30:00','2026-11-14 18:34:38','2026-11-14 18:34:38');
/*!40000 ALTER TABLE `tblcierrenomina` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblcierrenominaempleado`
--

DROP TABLE IF EXISTS `tblcierrenominaempleado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblcierrenominaempleado` (
  `idCierreNominaEmpleado` int NOT NULL AUTO_INCREMENT,
  `idCierreNomina` int NOT NULL,
  `idNominaEncabezado` int NOT NULL,
  `idEmpleado` int NOT NULL,
  `salarioBaseCierreNominaEmpleado` decimal(12,4) NOT NULL,
  `totalPercepcionCierreNominaEmpleado` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `totalDeduccionCierreNominaEmpleado` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `totalNetoCierreNominaEmpleado` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `acumuladoPercepcionAnioCierreNominaEmpleado` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `acumuladoDeduccionAnioCierreNominaEmpleado` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idCierreNominaEmpleado`),
  UNIQUE KEY `uqCierreNominaEmpleadoEncabezado` (`idNominaEncabezado`),
  KEY `Fk_CierreNominaEmpleado_Empleado` (`idEmpleado`),
  KEY `idxCierreNominaEmpleadoCierre` (`idCierreNomina`),
  CONSTRAINT `Fk_CierreNominaEmpleado_CierreNomina` FOREIGN KEY (`idCierreNomina`) REFERENCES `tblcierrenomina` (`idCierreNomina`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `Fk_CierreNominaEmpleado_Empleado` FOREIGN KEY (`idEmpleado`) REFERENCES `tblempleado` (`idEmpleado`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `Fk_CierreNominaEmpleado_NominaEncabezado` FOREIGN KEY (`idNominaEncabezado`) REFERENCES `tblnominaencabezado` (`idNominaEncabezado`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `ckCierreNominaEmpleadoNeto` CHECK ((`totalNetoCierreNominaEmpleado` = (`totalPercepcionCierreNominaEmpleado` - `totalDeduccionCierreNominaEmpleado`)))
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblcierrenominaempleado`
--

LOCK TABLES `tblcierrenominaempleado` WRITE;
/*!40000 ALTER TABLE `tblcierrenominaempleado` DISABLE KEYS */;
INSERT INTO `tblcierrenominaempleado` VALUES (1,1,1,20,6500.0000,6581.2499,317.8744,6263.3755,6581.2499,317.8744,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(2,2,2,20,6500.0000,6540.6250,315.9122,6224.7128,13121.8749,633.7866,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(3,3,3,20,6500.0000,6560.9374,316.8933,6244.0441,19682.8123,950.6799,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(4,4,4,20,6500.0000,6601.5624,318.8555,6282.7069,26284.3747,1269.5354,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(5,5,5,20,6500.0000,6581.2499,317.8744,6263.3755,32865.6246,1587.4098,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(6,6,24,3,7500.0000,7750.0000,512.2500,7237.7500,7750.0000,512.2500,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(7,6,25,21,7200.0000,7450.0000,497.7600,6952.2400,7450.0000,497.7600,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(8,6,26,22,5800.0000,6050.0000,280.1400,5769.8600,6050.0000,280.1400,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(9,6,27,23,6000.0000,6250.0000,289.8000,5960.2000,6250.0000,289.8000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(10,6,28,24,5500.0000,5750.0000,265.6500,5484.3500,5750.0000,265.6500,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(11,7,29,3,7500.0000,7750.0000,512.2500,7237.7500,7750.0000,512.2500,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(12,7,30,21,7200.0000,7450.0000,497.7600,6952.2400,7450.0000,497.7600,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(13,7,31,22,5800.0000,6050.0000,280.1400,5769.8600,6050.0000,280.1400,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(14,7,32,23,6000.0000,6250.0000,289.8000,5960.2000,6250.0000,289.8000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(15,7,33,24,5500.0000,5750.0000,265.6500,5484.3500,5750.0000,265.6500,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(16,8,34,1,7500.0000,7750.0000,512.2500,7237.7500,7750.0000,512.2500,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(17,8,35,3,7500.0000,7750.0000,512.2500,7237.7500,15500.0000,1024.5000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(18,8,36,21,7200.0000,7450.0000,497.7600,6952.2400,14900.0000,995.5200,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(19,8,37,22,5800.0000,6050.0000,280.1400,5769.8600,12100.0000,560.2800,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(20,8,38,23,6000.0000,6250.0000,289.8000,5960.2000,12500.0000,579.6000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(21,8,39,24,5500.0000,5750.0000,265.6500,5484.3500,11500.0000,531.3000,'2026-11-14 18:34:38','2026-11-14 18:34:38');
/*!40000 ALTER TABLE `tblcierrenominaempleado` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblcierresaldocliente`
--

DROP TABLE IF EXISTS `tblcierresaldocliente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblcierresaldocliente` (
  `idCierreSaldoCliente` int NOT NULL AUTO_INCREMENT,
  `idCierreMovimientoCxCEncabezado` int NOT NULL,
  `idCliente` int NOT NULL,
  `codigoClienteCierreSaldoCliente` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nombreClienteCierreSaldoCliente` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `saldoAnteriorCierreSaldoCliente` decimal(12,4) NOT NULL,
  `cargosPeriodoCierreSaldoCliente` decimal(12,4) NOT NULL,
  `abonosPeriodoCierreSaldoCliente` decimal(12,4) NOT NULL,
  `cargosAcumuladosCierreSaldoCliente` decimal(12,4) NOT NULL,
  `abonosAcumuladosCierreSaldoCliente` decimal(12,4) NOT NULL,
  `saldoActualCierreSaldoCliente` decimal(12,4) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idCierreMovimientoCxCEncabezado`,`idCierreSaldoCliente`),
  UNIQUE KEY `uqCierreSaldoClienteClaveNegocio` (`idCierreMovimientoCxCEncabezado`,`idCliente`),
  UNIQUE KEY `uqCierreSaldoClienteId` (`idCierreSaldoCliente`),
  KEY `idxCierreSaldoClienteClienteCodigo` (`idCliente`),
  CONSTRAINT `Fk_CierreSaldoCliente_CierreMovimientoCxCEncabezado` FOREIGN KEY (`idCierreMovimientoCxCEncabezado`) REFERENCES `tblcierremovimientocxcencabezado` (`idCierreMovimientoCxCEncabezado`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `Fk_CierreSaldoCliente_Cliente` FOREIGN KEY (`idCliente`) REFERENCES `tblcliente` (`idCliente`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblcierresaldocliente`
--

LOCK TABLES `tblcierresaldocliente` WRITE;
/*!40000 ALTER TABLE `tblcierresaldocliente` DISABLE KEYS */;
/*!40000 ALTER TABLE `tblcierresaldocliente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblcliente`
--

DROP TABLE IF EXISTS `tblcliente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblcliente` (
  `idCliente` int NOT NULL AUTO_INCREMENT,
  `codigoCliente` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tipoIdentificacionCliente` enum('NIT','CUI','CF') COLLATE utf8mb4_unicode_ci NOT NULL,
  `nombreCliente` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `direccionCliente` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nombreContactoCliente` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `telefonoCliente` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `correoCliente` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `diasCreditoCliente` int NOT NULL DEFAULT '0',
  `limiteCreditoCliente` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `idMonedaCredito` bigint NOT NULL,
  `activoCliente` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `nitCliente` char(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `dpiCliente` char(13) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`idCliente`),
  UNIQUE KEY `uqClientecodigo` (`codigoCliente`),
  UNIQUE KEY `uqClientenit` (`nitCliente`),
  UNIQUE KEY `uqClientedpi` (`dpiCliente`),
  KEY `idxClienteMonedaCredito` (`idMonedaCredito`),
  CONSTRAINT `Fk_Cliente_Moneda_Credito` FOREIGN KEY (`idMonedaCredito`) REFERENCES `tblmoneda` (`idMoneda`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `ckClienteactivoClienteBooleano` CHECK ((`activoCliente` in (0,1))),
  CONSTRAINT `ckClienteCreditoNoNegativo` CHECK (((`diasCreditoCliente` >= 0) and (`limiteCreditoCliente` >= 0))),
  CONSTRAINT `ckClienteIdentificacionCoherente` CHECK ((((`tipoIdentificacionCliente` = _utf8mb4'CF') and (`nitCliente` is null) and (`dpiCliente` is null)) or ((`tipoIdentificacionCliente` = _utf8mb4'NIT') and (`nitCliente` is not null) and (`dpiCliente` is null)) or ((`tipoIdentificacionCliente` = _utf8mb4'CUI') and (`dpiCliente` is not null) and (`nitCliente` is null))))
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblcliente`
--

LOCK TABLES `tblcliente` WRITE;
/*!40000 ALTER TABLE `tblcliente` DISABLE KEYS */;
INSERT INTO `tblcliente` VALUES (1,'CLI-BNK-001','NIT','Supermercados El Ahorro, S.A.',NULL,NULL,NULL,NULL,0,0.0000,1,1,'2026-11-14 18:34:37','2026-11-14 18:34:37','7345612-1',NULL),(2,'CLI-BNK-002','NIT','Restaurantes Gran Sabor, S.A.',NULL,NULL,NULL,NULL,0,0.0000,1,1,'2026-11-14 18:34:37','2026-11-14 18:34:37','8123456-7',NULL),(3,'FAC-QA-CF','CF','Consumidor Final','Ciudad',NULL,NULL,NULL,0,0.0000,1,1,'2026-11-14 18:34:40','2026-11-14 18:34:40',NULL,NULL),(4,'FAC-QA-C01','NIT','Tienda El Roble','Ciudad',NULL,NULL,NULL,0,0.0000,1,1,'2026-11-14 18:34:40','2026-11-14 18:34:40','99100401-1',NULL),(5,'FAC-QA-C02','NIT','Distribuidora La Cumbre','Ciudad',NULL,NULL,NULL,30,10000.0000,1,1,'2026-11-14 18:34:40','2026-11-14 18:34:40','99100402-1',NULL),(6,'FAC-QA-C03','NIT','Restaurante El Pinar','Ciudad',NULL,NULL,NULL,60,20000.0000,1,1,'2026-11-14 18:34:40','2026-11-14 18:34:40','99100403-1',NULL),(7,'FAC-QA-C04','NIT','Mercado Regional','Ciudad',NULL,NULL,NULL,15,500.0000,1,1,'2026-11-14 18:34:40','2026-11-14 18:34:40','99100404-1',NULL),(8,'FAC-QA-C05','NIT','Exportadora Sierra','Ciudad',NULL,NULL,NULL,30,5000.0000,2,1,'2026-11-14 18:34:40','2026-11-14 18:34:40','99100405-1',NULL),(9,'FAC-QA-C06','NIT','Comercial del Valle','Ciudad',NULL,NULL,NULL,0,0.0000,2,1,'2026-11-14 18:34:40','2026-11-14 18:34:40','99100406-1',NULL),(10,'FAC-QA-C07','NIT','Tienda Las Flores','Ciudad',NULL,NULL,NULL,45,8000.0000,1,1,'2026-11-14 18:34:40','2026-11-14 18:34:40','99100407-1',NULL);
/*!40000 ALTER TABLE `tblcliente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblclientefacturaversion`
--

DROP TABLE IF EXISTS `tblclientefacturaversion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblclientefacturaversion` (
  `idClienteFacturaVersion` int NOT NULL AUTO_INCREMENT,
  `idCliente` int NOT NULL,
  `numeroVersionClienteFacturaVersion` int NOT NULL,
  `tipoIdentificacionClienteFacturaVersion` enum('NIT','CUI','CF') COLLATE utf8mb4_unicode_ci NOT NULL,
  `nitClienteFacturaVersion` char(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `dpiClienteFacturaVersion` char(13) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nombreClienteFacturaVersion` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `direccionClienteFacturaVersion` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idClienteFacturaVersion`),
  UNIQUE KEY `uqClienteFacturaVersionClienteCodigonumeroVersion` (`idCliente`,`numeroVersionClienteFacturaVersion`),
  CONSTRAINT `Fk_ClienteFacturaVersion_Cliente` FOREIGN KEY (`idCliente`) REFERENCES `tblcliente` (`idCliente`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `ckClienteFacturaVersionIdentificacionCoherente` CHECK ((((`tipoIdentificacionClienteFacturaVersion` = _utf8mb4'CF') and (`nitClienteFacturaVersion` is null) and (`dpiClienteFacturaVersion` is null)) or ((`tipoIdentificacionClienteFacturaVersion` = _utf8mb4'NIT') and (`nitClienteFacturaVersion` is not null) and (`dpiClienteFacturaVersion` is null)) or ((`tipoIdentificacionClienteFacturaVersion` = _utf8mb4'CUI') and (`dpiClienteFacturaVersion` is not null) and (`nitClienteFacturaVersion` is null)))),
  CONSTRAINT `ckClienteFacturaVersionVersionPositiva` CHECK ((`numeroVersionClienteFacturaVersion` > 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblclientefacturaversion`
--

LOCK TABLES `tblclientefacturaversion` WRITE;
/*!40000 ALTER TABLE `tblclientefacturaversion` DISABLE KEYS */;
/*!40000 ALTER TABLE `tblclientefacturaversion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblclientelistaprecio`
--

DROP TABLE IF EXISTS `tblclientelistaprecio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblclientelistaprecio` (
  `idClienteListaPrecio` int NOT NULL AUTO_INCREMENT,
  `idCliente` int NOT NULL,
  `idListaPrecioEncabezado` int NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idClienteListaPrecio`),
  UNIQUE KEY `uqClienteListaPrecioClaveNegocio` (`idCliente`),
  KEY `idxClienteListaPrecioListaPrecioEncabezadoCodigo` (`idListaPrecioEncabezado`),
  CONSTRAINT `Fk_ClienteListaPrecio_Cliente` FOREIGN KEY (`idCliente`) REFERENCES `tblcliente` (`idCliente`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `Fk_ClienteListaPrecio_ListaPrecioEncabezado` FOREIGN KEY (`idListaPrecioEncabezado`) REFERENCES `tbllistaprecioencabezado` (`idListaPrecioEncabezado`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblclientelistaprecio`
--

LOCK TABLES `tblclientelistaprecio` WRITE;
/*!40000 ALTER TABLE `tblclientelistaprecio` DISABLE KEYS */;
INSERT INTO `tblclientelistaprecio` VALUES (1,3,1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(2,4,1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(3,5,2,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(4,6,1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(5,7,2,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(6,8,3,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(7,9,3,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(8,10,2,'2026-11-14 18:34:40','2026-11-14 18:34:40');
/*!40000 ALTER TABLE `tblclientelistaprecio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblcomisionabono`
--

DROP TABLE IF EXISTS `tblcomisionabono`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblcomisionabono` (
  `idComisionAbono` int NOT NULL AUTO_INCREMENT,
  `idComisionFacturaEncabezado` int NOT NULL,
  `idAplicacionPago` int NOT NULL,
  `tasaFacturaPagadaAcumuladaComisionAbono` decimal(5,4) NOT NULL,
  `montoComisionDevengadoComisionAbono` decimal(12,4) NOT NULL,
  `estadoPagoVendedorComisionAbono` enum('PENDIENTE','PAGADO','REVERSADO') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'PENDIENTE',
  `fechaPagoVendedorComisionAbono` date DEFAULT NULL,
  `referenciaNominaComisionAbono` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `observacionesComisionAbono` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idComisionAbono`),
  UNIQUE KEY `uqComisionAbonoAplicacionPagoCodigo` (`idAplicacionPago`),
  KEY `idxComisionAbonoComisionFacturaEncabezadoCodigoestadoPa19c1f12f` (`idComisionFacturaEncabezado`,`estadoPagoVendedorComisionAbono`),
  CONSTRAINT `Fk_ComisionAbono_AplicacionPago` FOREIGN KEY (`idAplicacionPago`) REFERENCES `tblaplicacionpago` (`idAplicacionPago`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `Fk_ComisionAbono_ComisionFacturaEncabezado` FOREIGN KEY (`idComisionFacturaEncabezado`) REFERENCES `tblcomisionfacturaencabezado` (`idComisionFacturaEncabezado`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `ckComisionAbonoDevengoNoNegativo` CHECK ((`montoComisionDevengadoComisionAbono` >= 0)),
  CONSTRAINT `ckComisionAbonoFechaPagoVendedor` CHECK (((`estadoPagoVendedorComisionAbono` <> _utf8mb4'PAGADO') or (`fechaPagoVendedorComisionAbono` is not null))),
  CONSTRAINT `ckComisionAbonotasaFacturaPagadaAcumuladaComisionAbonoRango` CHECK ((`tasaFacturaPagadaAcumuladaComisionAbono` between 0 and 1))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblcomisionabono`
--

LOCK TABLES `tblcomisionabono` WRITE;
/*!40000 ALTER TABLE `tblcomisionabono` DISABLE KEYS */;
/*!40000 ALTER TABLE `tblcomisionabono` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblcomisiondetalle`
--

DROP TABLE IF EXISTS `tblcomisiondetalle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblcomisiondetalle` (
  `idComisionDetalle` int NOT NULL AUTO_INCREMENT,
  `idComisionEncabezado` int NOT NULL,
  `idFacturaEncabezado` int NOT NULL,
  `idAplicacionPago` int DEFAULT NULL,
  `baseComisionDetalle` decimal(12,4) NOT NULL,
  `tasaAplicadaComisionDetalle` decimal(3,2) NOT NULL,
  `montoComisionDetalle` decimal(12,4) GENERATED ALWAYS AS (round((`baseComisionDetalle` * `tasaAplicadaComisionDetalle`),4)) STORED,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idComisionEncabezado`,`idComisionDetalle`),
  UNIQUE KEY `uqComisionDetalleId` (`idComisionDetalle`),
  KEY `idxComisionDetalleComisionEncabezadoCodigo` (`idComisionEncabezado`),
  KEY `idxComisionDetalleFacturaEncabezadoCodigo` (`idFacturaEncabezado`),
  KEY `idxComisionDetalleAplicacionPagoCodigo` (`idAplicacionPago`),
  CONSTRAINT `Fk_ComisionDetalle_AplicacionPago` FOREIGN KEY (`idAplicacionPago`) REFERENCES `tblaplicacionpago` (`idAplicacionPago`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `Fk_ComisionDetalle_ComisionEncabezado` FOREIGN KEY (`idComisionEncabezado`) REFERENCES `tblcomisionencabezado` (`idComisionEncabezado`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `Fk_ComisionDetalle_FacturaEncabezado` FOREIGN KEY (`idFacturaEncabezado`) REFERENCES `tblfacturaencabezado` (`idFacturaEncabezado`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `ckComisionDetalleBaseNoNegativa` CHECK ((`baseComisionDetalle` >= 0)),
  CONSTRAINT `ckComisionDetalletasaAplicadaComisionDetalleRango` CHECK ((`tasaAplicadaComisionDetalle` between 0 and 0.99))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblcomisiondetalle`
--

LOCK TABLES `tblcomisiondetalle` WRITE;
/*!40000 ALTER TABLE `tblcomisiondetalle` DISABLE KEYS */;
/*!40000 ALTER TABLE `tblcomisiondetalle` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblcomisionencabezado`
--

DROP TABLE IF EXISTS `tblcomisionencabezado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblcomisionencabezado` (
  `idComisionEncabezado` int NOT NULL AUTO_INCREMENT,
  `numeroComisionEncabezado` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `idVendedor` int NOT NULL,
  `idReglaComision` int NOT NULL,
  `idMoneda` bigint NOT NULL,
  `fechaDesdeComisionEncabezado` date NOT NULL,
  `fechaHastaComisionEncabezado` date NOT NULL,
  `estadoComisionEncabezado` varchar(25) COLLATE utf8mb4_unicode_ci NOT NULL,
  `idUsuarioSolicita` int DEFAULT NULL,
  `fechaSolicitudComisionEncabezado` datetime DEFAULT NULL,
  `idUsuarioAutoriza` int DEFAULT NULL,
  `fechaAutorizacionComisionEncabezado` datetime DEFAULT NULL,
  `comentarioAutorizacionComisionEncabezado` text COLLATE utf8mb4_unicode_ci,
  `referenciaContableComisionEncabezado` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fechaEnvioComisionEncabezado` datetime DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idComisionEncabezado`),
  UNIQUE KEY `uqComisionEncabezadonumero` (`numeroComisionEncabezado`),
  KEY `idxComisionEncabezadoVendedorCodigofechaDesdefechaHasta` (`idVendedor`,`fechaDesdeComisionEncabezado`,`fechaHastaComisionEncabezado`),
  KEY `idxComisionEncabezadoReglaComisionCodigo` (`idReglaComision`),
  KEY `idxComisionEncabezadoMonedaCodigo` (`idMoneda`),
  KEY `idxComisionEncabezadoUsuarioSolicita` (`idUsuarioSolicita`),
  KEY `idxComisionEncabezadoUsuarioAutoriza` (`idUsuarioAutoriza`),
  CONSTRAINT `Fk_ComisionEncabezado_Moneda` FOREIGN KEY (`idMoneda`) REFERENCES `tblmoneda` (`idMoneda`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `Fk_ComisionEncabezado_ReglaComision` FOREIGN KEY (`idReglaComision`) REFERENCES `tblreglacomision` (`idReglaComision`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `Fk_ComisionEncabezado_Usuario_Autoriza` FOREIGN KEY (`idUsuarioAutoriza`) REFERENCES `tblusuario` (`idUsuario`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `Fk_ComisionEncabezado_Usuario_Solicita` FOREIGN KEY (`idUsuarioSolicita`) REFERENCES `tblusuario` (`idUsuario`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `Fk_ComisionEncabezado_Vendedor` FOREIGN KEY (`idVendedor`) REFERENCES `tblvendedor` (`idVendedor`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `ckComisionEncabezadoFechasCoherentes` CHECK ((`fechaHastaComisionEncabezado` >= `fechaDesdeComisionEncabezado`)),
  CONSTRAINT `ckComisionEncabezadoValoresEstadoComision` CHECK ((`estadoComisionEncabezado` in (_utf8mb4'BORRADOR',_utf8mb4'SOLICITADA',_utf8mb4'APROBADA',_utf8mb4'RECHAZADA',_utf8mb4'ENVIADA')))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblcomisionencabezado`
--

LOCK TABLES `tblcomisionencabezado` WRITE;
/*!40000 ALTER TABLE `tblcomisionencabezado` DISABLE KEYS */;
/*!40000 ALTER TABLE `tblcomisionencabezado` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblcomisionfacturadetalle`
--

DROP TABLE IF EXISTS `tblcomisionfacturadetalle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblcomisionfacturadetalle` (
  `idComisionFacturaDetalle` int NOT NULL AUTO_INCREMENT,
  `idComisionFacturaEncabezado` int NOT NULL,
  `idFacturaDetalle` int NOT NULL,
  `metodoComisionFacturaDetalle` enum('LINEA','PRODUCTO','CATEGORIA','MARCA') COLLATE utf8mb4_unicode_ci NOT NULL,
  `nombreClasificacionHistoricaComisionFacturaDetalle` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tasaAplicadaComisionFacturaDetalle` decimal(3,2) NOT NULL,
  `baseComisionFacturaDetalle` decimal(12,4) NOT NULL,
  `montoComisionLineaComisionFacturaDetalle` decimal(12,4) GENERATED ALWAYS AS (round((`baseComisionFacturaDetalle` * `tasaAplicadaComisionFacturaDetalle`),4)) STORED,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `idLinea` int DEFAULT NULL,
  `idCategoria` int DEFAULT NULL,
  `idMarca` int DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idComisionFacturaEncabezado`,`idComisionFacturaDetalle`),
  UNIQUE KEY `uqComisionFacturaDetalleFacturaDetalleCodigo` (`idFacturaDetalle`),
  UNIQUE KEY `uqComisionFacturaDetalleId` (`idComisionFacturaDetalle`),
  KEY `idxComisionFacturaDetalleComisionFacturaEncabezadoCodigo` (`idComisionFacturaEncabezado`),
  KEY `idxComisionFacturaDetalleLineaCodigo` (`idLinea`),
  KEY `idxComisionFacturaDetalleCategoriaCodigo` (`idCategoria`),
  KEY `idxComisionFacturaDetalleMarcaCodigo` (`idMarca`),
  CONSTRAINT `Fk_ComisionFacturaDetalle_Categoria` FOREIGN KEY (`idCategoria`) REFERENCES `tblcategoria` (`idCategoria`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `Fk_ComisionFacturaDetalle_ComisionFacturaEncabezado` FOREIGN KEY (`idComisionFacturaEncabezado`) REFERENCES `tblcomisionfacturaencabezado` (`idComisionFacturaEncabezado`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `Fk_ComisionFacturaDetalle_FacturaDetalle` FOREIGN KEY (`idFacturaDetalle`) REFERENCES `tblfacturadetalle` (`idFacturaDetalle`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `Fk_ComisionFacturaDetalle_Linea` FOREIGN KEY (`idLinea`) REFERENCES `tbllinea` (`idLinea`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `Fk_ComisionFacturaDetalle_Marca` FOREIGN KEY (`idMarca`) REFERENCES `tblmarca` (`idMarca`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `ckComisionFacturaDetalleBaseNoNegativa` CHECK ((`baseComisionFacturaDetalle` >= 0)),
  CONSTRAINT `ckComisionFacturaDetalleClasificacionTipada` CHECK ((((`metodoComisionFacturaDetalle` = _utf8mb4'PRODUCTO') and (`idLinea` is null) and (`idCategoria` is null) and (`idMarca` is null)) or ((`metodoComisionFacturaDetalle` = _utf8mb4'LINEA') and (`idLinea` is not null) and (`idCategoria` is null) and (`idMarca` is null)) or ((`metodoComisionFacturaDetalle` = _utf8mb4'CATEGORIA') and (`idCategoria` is not null) and (`idLinea` is null) and (`idMarca` is null)) or ((`metodoComisionFacturaDetalle` = _utf8mb4'MARCA') and (`idMarca` is not null) and (`idLinea` is null) and (`idCategoria` is null)))),
  CONSTRAINT `ckComisionFacturaDetalletasaAplicadaComisionFacturaDetalleRango` CHECK ((`tasaAplicadaComisionFacturaDetalle` between 0 and 0.99))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblcomisionfacturadetalle`
--

LOCK TABLES `tblcomisionfacturadetalle` WRITE;
/*!40000 ALTER TABLE `tblcomisionfacturadetalle` DISABLE KEYS */;
/*!40000 ALTER TABLE `tblcomisionfacturadetalle` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblcomisionfacturaencabezado`
--

DROP TABLE IF EXISTS `tblcomisionfacturaencabezado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblcomisionfacturaencabezado` (
  `idComisionFacturaEncabezado` int NOT NULL AUTO_INCREMENT,
  `idFacturaEncabezado` int NOT NULL,
  `metodoComisionFacturaEncabezado` enum('LINEA','PRODUCTO','CATEGORIA','MARCA','MIXTA') COLLATE utf8mb4_unicode_ci NOT NULL,
  `estadoComisionFacturaEncabezado` enum('CALCULADA','ANULADA') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'CALCULADA',
  `observacionesComisionFacturaEncabezado` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idComisionFacturaEncabezado`),
  UNIQUE KEY `uqComisionFacturaEncabezadoFacturaEncabezadoCodigo` (`idFacturaEncabezado`),
  CONSTRAINT `Fk_ComisionFacturaEncabezado_FacturaEncabezado` FOREIGN KEY (`idFacturaEncabezado`) REFERENCES `tblfacturaencabezado` (`idFacturaEncabezado`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblcomisionfacturaencabezado`
--

LOCK TABLES `tblcomisionfacturaencabezado` WRITE;
/*!40000 ALTER TABLE `tblcomisionfacturaencabezado` DISABLE KEYS */;
/*!40000 ALTER TABLE `tblcomisionfacturaencabezado` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblconceptobancario`
--

DROP TABLE IF EXISTS `tblconceptobancario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblconceptobancario` (
  `idConceptoBancario` bigint NOT NULL AUTO_INCREMENT,
  `codigoConceptoBancario` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nombreConceptoBancario` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcionConceptoBancario` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `naturalezaConceptoBancario` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `claseOperacionConceptoBancario` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'NORMAL',
  `tipoTerceroConceptoBancario` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'NINGUNO',
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idConceptoBancario`),
  UNIQUE KEY `uqConceptoBancarioCodigo` (`codigoConceptoBancario`),
  CONSTRAINT `ckConceptoBancarioActivo` CHECK ((`is_active` in (0,1))),
  CONSTRAINT `ckConceptoBancarioClase` CHECK ((`claseOperacionConceptoBancario` in (_utf8mb4'NORMAL',_utf8mb4'TRANSFERENCIA_INTERNA'))),
  CONSTRAINT `ckConceptoBancarioNaturaleza` CHECK ((`naturalezaConceptoBancario` in (_utf8mb4'INGRESO',_utf8mb4'EGRESO',_utf8mb4'AMBOS'))),
  CONSTRAINT `ckConceptoBancarioTercero` CHECK ((`tipoTerceroConceptoBancario` in (_utf8mb4'EMPLEADO',_utf8mb4'PROVEEDOR',_utf8mb4'CLIENTE',_utf8mb4'NINGUNO'))),
  CONSTRAINT `ckConceptoBancarioTransferencia` CHECK (((`claseOperacionConceptoBancario` <> _utf8mb4'TRANSFERENCIA_INTERNA') or ((`naturalezaConceptoBancario` = _utf8mb4'AMBOS') and (`tipoTerceroConceptoBancario` = _utf8mb4'NINGUNO'))))
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblconceptobancario`
--

LOCK TABLES `tblconceptobancario` WRITE;
/*!40000 ALTER TABLE `tblconceptobancario` DISABLE KEYS */;
INSERT INTO `tblconceptobancario` VALUES (1,'CB-001','Pago a proveedores','Egreso por pago de facturas u ordenes de compra de proveedores','EGRESO','NORMAL','PROVEEDOR',1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(2,'CB-002','Pago de planilla','Egreso por pago de sueldos a empleados','EGRESO','NORMAL','EMPLEADO',1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(3,'CB-003','Cobro a clientes','Ingreso por deposito o transferencia de un cliente','INGRESO','NORMAL','CLIENTE',1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(4,'CB-004','Transferencia entre cuentas propias','Movimiento entre dos cuentas de la empresa','AMBOS','TRANSFERENCIA_INTERNA','NINGUNO',1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(5,'CB-005','Comision bancaria','Cargo del banco por manejo de cuenta o servicios','EGRESO','NORMAL','NINGUNO',1,'2026-11-14 18:34:36','2026-11-14 18:34:36');
/*!40000 ALTER TABLE `tblconceptobancario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblconceptoproveedor`
--

DROP TABLE IF EXISTS `tblconceptoproveedor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblconceptoproveedor` (
  `idConceptoProveedor` int NOT NULL AUTO_INCREMENT,
  `nombreConceptoProveedor` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `naturalezaConceptoProveedor` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idConceptoProveedor`),
  UNIQUE KEY `uqConceptoProveedorNombre` (`nombreConceptoProveedor`),
  CONSTRAINT `ckNaturalezaConceptoProveedor` CHECK ((`naturalezaConceptoProveedor` in (_utf8mb4'Cargo',_utf8mb4'Abono')))
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblconceptoproveedor`
--

LOCK TABLES `tblconceptoproveedor` WRITE;
/*!40000 ALTER TABLE `tblconceptoproveedor` DISABLE KEYS */;
INSERT INTO `tblconceptoproveedor` VALUES (1,'Compra de mercadería','Cargo','2026-11-14 18:34:38','2026-11-14 18:34:38'),(2,'Compra de materia prima','Cargo','2026-11-14 18:34:38','2026-11-14 18:34:38'),(3,'Compra de suministros','Cargo','2026-11-14 18:34:38','2026-11-14 18:34:38'),(4,'Servicios de transporte','Cargo','2026-11-14 18:34:38','2026-11-14 18:34:38'),(5,'Servicios de mantenimiento','Cargo','2026-11-14 18:34:38','2026-11-14 18:34:38'),(6,'Pago a proveedor','Abono','2026-11-14 18:34:38','2026-11-14 18:34:38'),(7,'Nota de crédito','Abono','2026-11-14 18:34:38','2026-11-14 18:34:38'),(8,'Devolución de mercadería','Abono','2026-11-14 18:34:38','2026-11-14 18:34:38'),(9,'Descuento por pronto pago','Abono','2026-11-14 18:34:38','2026-11-14 18:34:38'),(10,'Ajuste a favor del proveedor','Abono','2026-11-14 18:34:38','2026-11-14 18:34:38'),(11,'Factura prueba 0d2d5068e05a','Cargo','2026-11-14 18:34:39','2026-11-14 18:34:39'),(12,'Debito prueba 0d2d5068e05a','Cargo','2026-11-14 18:34:39','2026-11-14 18:34:39'),(13,'Pago prueba 0d2d5068e05a','Abono','2026-11-14 18:34:39','2026-11-14 18:34:39'),(14,'Credito prueba 0d2d5068e05a','Abono','2026-11-14 18:34:39','2026-11-14 18:34:39'),(15,'Transporte prueba 0d2d5068e05a','Cargo','2026-11-14 18:34:39','2026-11-14 18:34:39');
/*!40000 ALTER TABLE `tblconceptoproveedor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblconciliacion`
--

DROP TABLE IF EXISTS `tblconciliacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblconciliacion` (
  `idConciliacion` bigint NOT NULL AUTO_INCREMENT,
  `fechaCorteConciliacion` date NOT NULL,
  `estadoConciliacion` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'ABIERTA',
  `metodoConciliacion` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'AUTOMATICA',
  `saldoLibroConciliacion` decimal(12,4) DEFAULT NULL,
  `saldoBancoConciliacion` decimal(12,4) DEFAULT NULL,
  `diferenciaConciliacion` decimal(12,4) DEFAULT NULL,
  `identificadorResponsableConciliacion` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fechaCierreConciliacion` datetime DEFAULT NULL,
  `Fk_CuentaBancaria_Codigo` bigint NOT NULL,
  `Fk_ExtractoBancario_Codigo` bigint NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idConciliacion`),
  UNIQUE KEY `uqConciliacion1` (`Fk_CuentaBancaria_Codigo`,`fechaCorteConciliacion`),
  CONSTRAINT `ckConciliacion1` CHECK ((`estadoConciliacion` in (_utf8mb4'ABIERTA',_utf8mb4'PROCESANDO',_utf8mb4'CONCILIADA',_utf8mb4'CON_DIFERENCIAS',_utf8mb4'CERRADA'))),
  CONSTRAINT `ckConciliacion2` CHECK ((`metodoConciliacion` in (_utf8mb4'AUTOMATICA',_utf8mb4'MANUAL',_utf8mb4'MIXTA')))
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblconciliacion`
--

LOCK TABLES `tblconciliacion` WRITE;
/*!40000 ALTER TABLE `tblconciliacion` DISABLE KEYS */;
INSERT INTO `tblconciliacion` VALUES (1,'2026-11-06','CON_DIFERENCIAS','MIXTA',126550.0000,126515.0000,35.0000,'tesoreria.ana',NULL,1,1,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(2,'2026-11-06','CERRADA','AUTOMATICA',64379.5000,64379.5000,0.0000,'tesoreria.ana','2026-11-06 17:30:00',2,2,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(3,'2026-11-06','CONCILIADA','AUTOMATICA',18000.0000,18000.0000,0.0000,'tesoreria.luis',NULL,3,3,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(4,'2026-11-06','CON_DIFERENCIAS','MANUAL',80750.0000,85000.0000,-4250.0000,'tesoreria.luis',NULL,4,4,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(5,'2026-11-06','ABIERTA','AUTOMATICA',NULL,NULL,NULL,NULL,NULL,5,5,'2026-11-14 18:34:37','2026-11-14 18:34:37');
/*!40000 ALTER TABLE `tblconciliacion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblconductor`
--

DROP TABLE IF EXISTS `tblconductor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblconductor` (
  `idConductor` int NOT NULL AUTO_INCREMENT,
  `codigoConductor` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nombreCompletoConductor` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `numeroLicenciaConductor` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fechaVencimientoDocConductor` date NOT NULL,
  `Fk_Estado_Codigo` int NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idConductor`),
  UNIQUE KEY `uqCodigoConductor` (`codigoConductor`),
  UNIQUE KEY `uqNumeroLicenciaConductor` (`numeroLicenciaConductor`),
  KEY `idxIdEstadoConductor` (`Fk_Estado_Codigo`),
  CONSTRAINT `Fk_Conductor_Estado` FOREIGN KEY (`Fk_Estado_Codigo`) REFERENCES `tblestado` (`idEstado`) ON DELETE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblconductor`
--

LOCK TABLES `tblconductor` WRITE;
/*!40000 ALTER TABLE `tblconductor` DISABLE KEYS */;
INSERT INTO `tblconductor` VALUES (1,'COND-001','Luis Fernando García','LIC-A-471832','2028-06-18',1,'2026-11-14 18:34:39','2026-11-14 18:34:39'),(2,'COND-002','José Manuel Pérez','LIC-A-628105','2027-11-03',3,'2026-11-14 18:34:39','2026-11-14 18:34:39'),(3,'COND-003','Ricardo Antonio López','LIC-B-530972','2029-02-27',1,'2026-11-14 18:34:39','2026-11-14 18:34:39'),(4,'COND-004','Marco Tulio Hernández','LIC-B-741260','2027-08-14',3,'2026-11-14 18:34:39','2026-11-14 18:34:39'),(5,'COND-005','Edwin Alexander Castillo','LIC-A-893641','2028-12-09',1,'2026-11-14 18:34:39','2026-11-14 18:34:39');
/*!40000 ALTER TABLE `tblconductor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblconductortransporte`
--

DROP TABLE IF EXISTS `tblconductortransporte`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblconductortransporte` (
  `idConductorTransporte` int NOT NULL AUTO_INCREMENT,
  `Fk_Servicio_Transporte_Externo_Codigo` int NOT NULL,
  `nombreConductorTransporte` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `telefonoConductorTransporte` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idConductorTransporte`),
  UNIQUE KEY `uqConductorServicio` (`Fk_Servicio_Transporte_Externo_Codigo`),
  CONSTRAINT `Fk_Conductor_Transporte_Servicio_Transporte_Externo` FOREIGN KEY (`Fk_Servicio_Transporte_Externo_Codigo`) REFERENCES `tblserviciotransporteexterno` (`idServicioTransporteExterno`) ON DELETE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblconductortransporte`
--

LOCK TABLES `tblconductortransporte` WRITE;
/*!40000 ALTER TABLE `tblconductortransporte` DISABLE KEYS */;
INSERT INTO `tblconductortransporte` VALUES (1,1,'Héctor Orlando Gómez','+502 5432-7810','2026-11-14 18:34:39','2026-11-14 18:34:39'),(2,2,'Rafael Enrique Juárez','+502 5278-0631','2026-11-14 18:34:39','2026-11-14 18:34:39'),(3,3,'Saúl Ernesto Ramírez','+502 5590-1427','2026-11-14 18:34:39','2026-11-14 18:34:39'),(4,4,'Juan Pablo Escobar','+502 5781-2369','2026-11-14 18:34:39','2026-11-14 18:34:39'),(5,5,'Miguel Ángel Méndez','+502 5356-8042','2026-11-14 18:34:39','2026-11-14 18:34:39');
/*!40000 ALTER TABLE `tblconductortransporte` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblconfiguracionpoliza`
--

DROP TABLE IF EXISTS `tblconfiguracionpoliza`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblconfiguracionpoliza` (
  `idConfiguracionPoliza` bigint NOT NULL AUTO_INCREMENT,
  `codigoCuentaContableBancoConfiguracionPoliza` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `codigoCuentaContableContrapartidaConfiguracionPoliza` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Fk_CuentaBancaria_Codigo` bigint NOT NULL,
  `Fk_TipoTransaccion_Codigo` bigint NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idConfiguracionPoliza`),
  UNIQUE KEY `uqConfiguracionPoliza1` (`Fk_CuentaBancaria_Codigo`,`Fk_TipoTransaccion_Codigo`),
  KEY `idxConfiguracionPolizaTipo` (`Fk_TipoTransaccion_Codigo`),
  CONSTRAINT `Fk_ConfiguracionPoliza_Cuenta` FOREIGN KEY (`Fk_CuentaBancaria_Codigo`) REFERENCES `tblcuentabancaria` (`idCuentaBancaria`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `Fk_ConfiguracionPoliza_Tipo` FOREIGN KEY (`Fk_TipoTransaccion_Codigo`) REFERENCES `tbltipotransaccion` (`idTipoTransaccion`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `ckConfiguracionPoliza1` CHECK ((`is_active` in (0,1)))
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblconfiguracionpoliza`
--

LOCK TABLES `tblconfiguracionpoliza` WRITE;
/*!40000 ALTER TABLE `tblconfiguracionpoliza` DISABLE KEYS */;
INSERT INTO `tblconfiguracionpoliza` VALUES (1,'1.01.02.001','2.01.01.001',1,1,1,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(2,'1.01.02.002','2.01.01.001',2,1,1,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(3,'1.01.02.004','2.01.02.001',4,2,1,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(4,'1.01.02.001','1.01.04.001',1,3,1,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(5,'1.01.02.002','1.01.04.001',2,3,1,'2026-11-14 18:34:37','2026-11-14 18:34:37');
/*!40000 ALTER TABLE `tblconfiguracionpoliza` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblconsulta`
--

DROP TABLE IF EXISTS `tblconsulta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblconsulta` (
  `Pk_Consulta` int NOT NULL AUTO_INCREMENT,
  `nombreConsulta` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tablaConsulta` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `queryConsulta` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`Pk_Consulta`),
  UNIQUE KEY `Uq_NombreConsulta` (`nombreConsulta`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblconsulta`
--

LOCK TABLES `tblconsulta` WRITE;
/*!40000 ALTER TABLE `tblconsulta` DISABLE KEYS */;
/*!40000 ALTER TABLE `tblconsulta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblcontrolperiodocxc`
--

DROP TABLE IF EXISTS `tblcontrolperiodocxc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblcontrolperiodocxc` (
  `idControlPeriodoCxC` int NOT NULL AUTO_INCREMENT,
  `idMoneda` bigint NOT NULL,
  `fechaUltimoCierreControlPeriodoCxC` date DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idControlPeriodoCxC`),
  UNIQUE KEY `uqControlPeriodoCxCClaveNegocio` (`idMoneda`),
  CONSTRAINT `Fk_ControlPeriodoCxC_Moneda` FOREIGN KEY (`idMoneda`) REFERENCES `tblmoneda` (`idMoneda`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblcontrolperiodocxc`
--

LOCK TABLES `tblcontrolperiodocxc` WRITE;
/*!40000 ALTER TABLE `tblcontrolperiodocxc` DISABLE KEYS */;
/*!40000 ALTER TABLE `tblcontrolperiodocxc` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblcorrelativoventa`
--

DROP TABLE IF EXISTS `tblcorrelativoventa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblcorrelativoventa` (
  `idCorrelativoVenta` int NOT NULL AUTO_INCREMENT,
  `prefijoCorrelativoVenta` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ultimoNumeroCorrelativoVenta` bigint NOT NULL DEFAULT '0',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idCorrelativoVenta`),
  UNIQUE KEY `uqCorrelativoVentaClaveNegocio` (`prefijoCorrelativoVenta`),
  CONSTRAINT `ckCorrelativoVentaNumeroNoNegativo` CHECK ((`ultimoNumeroCorrelativoVenta` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblcorrelativoventa`
--

LOCK TABLES `tblcorrelativoventa` WRITE;
/*!40000 ALTER TABLE `tblcorrelativoventa` DISABLE KEYS */;
/*!40000 ALTER TABLE `tblcorrelativoventa` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblcostotransporte`
--

DROP TABLE IF EXISTS `tblcostotransporte`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblcostotransporte` (
  `idCostoTransporte` int NOT NULL AUTO_INCREMENT,
  `Fk_Servicio_Transporte_Externo_Codigo` int NOT NULL,
  `Fk_Tarifa_Transporte_Codigo` int NOT NULL,
  `cantidadCostoTransporte` decimal(12,4) NOT NULL,
  `costoUnitarioCostoTransporte` decimal(12,4) NOT NULL,
  `costoTotalCostoTransporte` decimal(12,4) NOT NULL COMMENT 'Calculado por el programa, no en la base de datos',
  `monedaCostoTransporte` char(3) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tipoPagoCostoTransporte` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idCostoTransporte`),
  UNIQUE KEY `uqCostoServicio` (`Fk_Servicio_Transporte_Externo_Codigo`),
  KEY `Fk_Costo_Transporte_Tarifa_Transporte` (`Fk_Tarifa_Transporte_Codigo`),
  CONSTRAINT `Fk_Costo_Transporte_Servicio_Transporte_Externo` FOREIGN KEY (`Fk_Servicio_Transporte_Externo_Codigo`) REFERENCES `tblserviciotransporteexterno` (`idServicioTransporteExterno`) ON DELETE RESTRICT,
  CONSTRAINT `Fk_Costo_Transporte_Tarifa_Transporte` FOREIGN KEY (`Fk_Tarifa_Transporte_Codigo`) REFERENCES `tbltarifatransporte` (`idTarifaTransporte`) ON DELETE RESTRICT,
  CONSTRAINT `ckCostoCantidad` CHECK ((`cantidadCostoTransporte` > 0)),
  CONSTRAINT `ckCostoMoneda` CHECK ((`monedaCostoTransporte` in (_utf8mb4'GTQ',_utf8mb4'USD'))),
  CONSTRAINT `ckCostoTipoPago` CHECK ((`tipoPagoCostoTransporte` in (_utf8mb4'Transferencia',_utf8mb4'Efectivo'))),
  CONSTRAINT `ckCostoUnitario` CHECK ((`costoUnitarioCostoTransporte` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblcostotransporte`
--

LOCK TABLES `tblcostotransporte` WRITE;
/*!40000 ALTER TABLE `tblcostotransporte` DISABLE KEYS */;
INSERT INTO `tblcostotransporte` VALUES (1,1,1,120.0000,8.7500,1050.0000,'GTQ','Transferencia','2026-11-14 18:34:39','2026-11-14 18:34:39'),(2,2,2,850.0000,1.2500,1062.5000,'GTQ','Transferencia','2026-11-14 18:34:39','2026-11-14 18:34:39'),(3,3,3,1.0000,1250.0000,1250.0000,'GTQ','Transferencia','2026-11-14 18:34:39','2026-11-14 18:34:39'),(4,4,4,3.0000,150.0000,450.0000,'GTQ','Efectivo','2026-11-14 18:34:39','2026-11-14 18:34:39'),(5,5,5,12.0000,45.0000,540.0000,'GTQ','Transferencia','2026-11-14 18:34:39','2026-11-14 18:34:39');
/*!40000 ALTER TABLE `tblcostotransporte` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblcotizaciondetalle`
--

DROP TABLE IF EXISTS `tblcotizaciondetalle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblcotizaciondetalle` (
  `idCotizacionDetalle` int NOT NULL AUTO_INCREMENT,
  `idCotizacionEncabezado` int NOT NULL,
  `numeroLineaCotizacionDetalle` int NOT NULL,
  `idProducto` int NOT NULL,
  `descripcionItemCotizacionDetalle` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `cantidadCotizacionDetalle` decimal(12,4) NOT NULL,
  `precioUnitarioCotizacionDetalle` decimal(12,4) NOT NULL,
  `descuentoMontoCotizacionDetalle` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `tasaImpuestoCotizacionDetalle` decimal(3,2) NOT NULL DEFAULT '0.00',
  `impuestoMontoCotizacionDetalle` decimal(12,4) GENERATED ALWAYS AS (round((((`cantidadCotizacionDetalle` * `precioUnitarioCotizacionDetalle`) - `descuentoMontoCotizacionDetalle`) * `tasaImpuestoCotizacionDetalle`),4)) STORED,
  `totalLineaCotizacionDetalle` decimal(12,4) GENERATED ALWAYS AS (round((((`cantidadCotizacionDetalle` * `precioUnitarioCotizacionDetalle`) - `descuentoMontoCotizacionDetalle`) + `impuestoMontoCotizacionDetalle`),4)) STORED,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idCotizacionEncabezado`,`idCotizacionDetalle`),
  UNIQUE KEY `uqCotizacionDetalleCotizacionEncabezadoCodigonumeroLinea` (`idCotizacionEncabezado`,`numeroLineaCotizacionDetalle`),
  UNIQUE KEY `uqCotizacionDetalleId` (`idCotizacionDetalle`),
  KEY `idxCotizacionDetalleProductoCodigo` (`idProducto`),
  CONSTRAINT `Fk_CotizacionDetalle_CotizacionEncabezado` FOREIGN KEY (`idCotizacionEncabezado`) REFERENCES `tblcotizacionencabezado` (`idCotizacionEncabezado`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `Fk_CotizacionDetalle_Producto` FOREIGN KEY (`idProducto`) REFERENCES `tblproducto` (`idProducto`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `ckCotizacionDetalleCantidadPrecioDescuentoValidos` CHECK (((`cantidadCotizacionDetalle` > 0) and (`precioUnitarioCotizacionDetalle` >= 0) and (`descuentoMontoCotizacionDetalle` >= 0) and (`descuentoMontoCotizacionDetalle` <= (`cantidadCotizacionDetalle` * `precioUnitarioCotizacionDetalle`)))),
  CONSTRAINT `ckCotizacionDetalleNumeroLineaPositivo` CHECK ((`numeroLineaCotizacionDetalle` > 0)),
  CONSTRAINT `ckCotizacionDetalletasaImpuestoCotizacionDetalleRango` CHECK ((`tasaImpuestoCotizacionDetalle` between 0 and 0.99))
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblcotizaciondetalle`
--

LOCK TABLES `tblcotizaciondetalle` WRITE;
/*!40000 ALTER TABLE `tblcotizaciondetalle` DISABLE KEYS */;
INSERT INTO `tblcotizaciondetalle` (`idCotizacionDetalle`, `idCotizacionEncabezado`, `numeroLineaCotizacionDetalle`, `idProducto`, `descripcionItemCotizacionDetalle`, `cantidadCotizacionDetalle`, `precioUnitarioCotizacionDetalle`, `descuentoMontoCotizacionDetalle`, `tasaImpuestoCotizacionDetalle`, `created_at`, `updated_at`) VALUES (1,1,1,13,'Salchicha 1 lb',2.0000,34.0000,0.0000,0.12,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(9,1,2,15,'Longaniza 1 lb',3.0000,38.0000,1.0000,0.12,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(17,1,3,18,'Salami 250 g',1.0000,44.0000,0.0000,0.12,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(3,2,1,13,'Salchicha 1 lb',2.0000,16.0000,0.0000,0.12,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(11,2,2,15,'Longaniza 1 lb',3.0000,20.0000,1.0000,0.12,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(19,2,3,18,'Salami 250 g',1.0000,26.0000,0.0000,0.12,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(7,3,1,13,'Salchicha 1 lb',2.0000,4.5000,0.0000,0.12,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(15,3,2,15,'Longaniza 1 lb',3.0000,5.0000,1.0000,0.12,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(23,3,3,18,'Salami 250 g',1.0000,5.7500,0.0000,0.12,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(2,4,1,13,'Salchicha 1 lb',2.0000,34.0000,0.0000,0.12,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(10,4,2,15,'Longaniza 1 lb',3.0000,38.0000,1.0000,0.12,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(18,4,3,18,'Salami 250 g',1.0000,44.0000,0.0000,0.12,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(4,5,1,13,'Salchicha 1 lb',2.0000,16.0000,0.0000,0.12,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(12,5,2,15,'Longaniza 1 lb',3.0000,20.0000,1.0000,0.12,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(20,5,3,18,'Salami 250 g',1.0000,26.0000,0.0000,0.12,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(5,6,1,13,'Salchicha 1 lb',2.0000,16.0000,0.0000,0.12,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(13,6,2,15,'Longaniza 1 lb',3.0000,20.0000,1.0000,0.12,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(21,6,3,18,'Salami 250 g',1.0000,26.0000,0.0000,0.12,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(8,7,1,13,'Salchicha 1 lb',2.0000,4.5000,0.0000,0.12,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(16,7,2,15,'Longaniza 1 lb',3.0000,5.0000,1.0000,0.12,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(24,7,3,18,'Salami 250 g',1.0000,5.7500,0.0000,0.12,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(6,8,1,13,'Salchicha 1 lb',2.0000,16.0000,0.0000,0.12,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(14,8,2,15,'Longaniza 1 lb',3.0000,20.0000,1.0000,0.12,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(22,8,3,18,'Salami 250 g',1.0000,26.0000,0.0000,0.12,'2026-11-14 18:34:40','2026-11-14 18:34:40');
/*!40000 ALTER TABLE `tblcotizaciondetalle` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblcotizacionencabezado`
--

DROP TABLE IF EXISTS `tblcotizacionencabezado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblcotizacionencabezado` (
  `idCotizacionEncabezado` int NOT NULL AUTO_INCREMENT,
  `numeroCotizacionEncabezado` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `idCliente` int NOT NULL,
  `idVendedor` int NOT NULL,
  `idMoneda` bigint NOT NULL,
  `fechaEmisionCotizacionEncabezado` date NOT NULL,
  `vigenteHastaCotizacionEncabezado` date NOT NULL,
  `estadoCotizacionEncabezado` varchar(25) COLLATE utf8mb4_unicode_ci NOT NULL,
  `observacionesCotizacionEncabezado` text COLLATE utf8mb4_unicode_ci,
  `idUsuarioRegistro` int NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `idListaPrecioEncabezado` int NOT NULL,
  PRIMARY KEY (`idCotizacionEncabezado`),
  UNIQUE KEY `uqCotizacionEncabezadonumero` (`numeroCotizacionEncabezado`),
  KEY `idxCotizacionEncabezadoClienteCodigo` (`idCliente`),
  KEY `idxCotizacionEncabezadoVendedorCodigo` (`idVendedor`),
  KEY `idxCotizacionEncabezadoMonedaCodigo` (`idMoneda`),
  KEY `idxCotizacionEncabezadoUsuarioRegistro` (`idUsuarioRegistro`),
  KEY `idxCotizacionEncabezadoListaPrecioEncabezadoCodigo` (`idListaPrecioEncabezado`),
  CONSTRAINT `Fk_CotizacionEncabezado_Cliente` FOREIGN KEY (`idCliente`) REFERENCES `tblcliente` (`idCliente`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `Fk_CotizacionEncabezado_ListaPrecioEncabezado` FOREIGN KEY (`idListaPrecioEncabezado`) REFERENCES `tbllistaprecioencabezado` (`idListaPrecioEncabezado`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `Fk_CotizacionEncabezado_Moneda` FOREIGN KEY (`idMoneda`) REFERENCES `tblmoneda` (`idMoneda`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `Fk_CotizacionEncabezado_Usuario_Registro` FOREIGN KEY (`idUsuarioRegistro`) REFERENCES `tblusuario` (`idUsuario`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `Fk_CotizacionEncabezado_Vendedor` FOREIGN KEY (`idVendedor`) REFERENCES `tblvendedor` (`idVendedor`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `ckCotizacionEncabezadoFechasCoherentes` CHECK ((`vigenteHastaCotizacionEncabezado` >= `fechaEmisionCotizacionEncabezado`)),
  CONSTRAINT `ckCotizacionEncabezadoValoresEstadoCotizacion` CHECK ((`estadoCotizacionEncabezado` in (_utf8mb4'BORRADOR',_utf8mb4'EMITIDA',_utf8mb4'ACEPTADA',_utf8mb4'RECHAZADA',_utf8mb4'VENCIDA',_utf8mb4'ANULADA')))
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblcotizacionencabezado`
--

LOCK TABLES `tblcotizacionencabezado` WRITE;
/*!40000 ALTER TABLE `tblcotizacionencabezado` DISABLE KEYS */;
INSERT INTO `tblcotizacionencabezado` VALUES (1,'FAC-QA-COT01',4,1,1,'2026-11-14','2027-11-14','EMITIDA',NULL,1,'2026-11-14 18:34:40','2026-11-14 18:34:40',1),(2,'FAC-QA-COT02',5,1,1,'2026-11-14','2027-11-14','EMITIDA',NULL,1,'2026-11-14 18:34:40','2026-11-14 18:34:40',2),(3,'FAC-QA-COT03',8,1,2,'2026-11-14','2027-11-14','EMITIDA',NULL,1,'2026-11-14 18:34:40','2026-11-14 18:34:40',3),(4,'FAC-QA-COT04',6,1,1,'2026-11-14','2027-11-14','EMITIDA',NULL,1,'2026-11-14 18:34:40','2026-11-14 18:34:40',1),(5,'FAC-QA-COT05',10,1,1,'2026-11-14','2027-11-14','ACEPTADA',NULL,1,'2026-11-14 18:34:40','2026-11-14 18:34:40',2),(6,'FAC-QA-COT06',7,1,1,'2026-11-14','2027-11-14','ACEPTADA',NULL,1,'2026-11-14 18:34:40','2026-11-14 18:34:40',2),(7,'FAC-QA-COT07',9,1,2,'2026-11-14','2027-11-14','ACEPTADA',NULL,1,'2026-11-14 18:34:40','2026-11-14 18:34:40',3),(8,'FAC-QA-COT08',5,1,1,'2026-11-14','2027-11-14','ACEPTADA',NULL,1,'2026-11-14 18:34:40','2026-11-14 18:34:40',2);
/*!40000 ALTER TABLE `tblcotizacionencabezado` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblcuenta`
--

DROP TABLE IF EXISTS `tblcuenta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblcuenta` (
  `idCuenta` int NOT NULL AUTO_INCREMENT,
  `codigoCuenta` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nombreCuenta` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tipoCuenta` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `clasificacionCuenta` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'DETALLE',
  `idCuentaPadre` int DEFAULT NULL,
  `saldoInicialCuenta` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `cargoPeriodoCuenta` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `abonoPeriodoCuenta` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `saldoActualCuenta` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `cargoAcumuladoCuenta` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `abonoAcumuladoCuenta` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `periodoSaldoCuenta` char(7) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idCuenta`),
  UNIQUE KEY `uqCuentaCodigo` (`codigoCuenta`),
  KEY `idxCuentaPadre` (`idCuentaPadre`),
  KEY `idxCuentaTipo` (`tipoCuenta`),
  KEY `idxCuentaClasificacion` (`clasificacionCuenta`),
  KEY `idxCuentaNombre` (`nombreCuenta`),
  CONSTRAINT `Fk_Cuenta_Cuenta` FOREIGN KEY (`idCuentaPadre`) REFERENCES `tblcuenta` (`idCuenta`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `ckCuentaClasificacion` CHECK ((`clasificacionCuenta` in (_utf8mb4'MAYOR',_utf8mb4'DETALLE'))),
  CONSTRAINT `ckCuentaTipo` CHECK ((`tipoCuenta` in (_utf8mb4'DEUDORA',_utf8mb4'ACREEDORA')))
) ENGINE=InnoDB AUTO_INCREMENT=255 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblcuenta`
--

LOCK TABLES `tblcuenta` WRITE;
/*!40000 ALTER TABLE `tblcuenta` DISABLE KEYS */;
INSERT INTO `tblcuenta` VALUES (1,'0','Padre','DEUDORA','MAYOR',NULL,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(2,'1','Activo','DEUDORA','MAYOR',1,0.0000,125800.0000,99800.0000,26000.0000,125800.0000,99800.0000,'2026-10',1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(3,'1.01','Activo Corriente','DEUDORA','MAYOR',2,0.0000,125800.0000,99800.0000,26000.0000,125800.0000,99800.0000,'2026-10',1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(4,'1.01.01','Caja','DEUDORA','MAYOR',3,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(5,'1.01.01.001','Caja General','DEUDORA','DETALLE',4,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(6,'1.01.01.002','Caja Chica','DEUDORA','DETALLE',4,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(7,'1.01.02','Bancos','DEUDORA','MAYOR',3,0.0000,25000.0000,44800.0000,-19800.0000,25000.0000,44800.0000,'2026-10',1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(8,'1.01.02.001','Banco Industrial (Moneda Nacional)','DEUDORA','DETALLE',7,0.0000,25000.0000,44800.0000,-19800.0000,25000.0000,44800.0000,'2026-10',1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(9,'1.01.02.002','Banrural (Moneda Nacional)','DEUDORA','DETALLE',7,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(10,'1.01.02.003','Banco G&T Continental (Moneda Nacional)','DEUDORA','DETALLE',7,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(11,'1.01.02.004','Banco Industrial (Moneda Extranjera)','DEUDORA','DETALLE',7,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(12,'1.01.03','Inversiones Temporales','DEUDORA','MAYOR',3,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(13,'1.01.03.001','Inversiones en Moneda Nacional','DEUDORA','DETALLE',12,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(14,'1.01.03.002','Inversiones en Moneda Extranjera','DEUDORA','DETALLE',12,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(15,'1.01.04','Cuentas por Cobrar Comerciales','DEUDORA','MAYOR',3,0.0000,56000.0000,25000.0000,31000.0000,56000.0000,25000.0000,'2026-10',1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(16,'1.01.04.001','Clientes Nacionales','DEUDORA','DETALLE',15,0.0000,56000.0000,25000.0000,31000.0000,56000.0000,25000.0000,'2026-10',1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(17,'1.01.04.002','Clientes del Extranjero (Exportación)','DEUDORA','DETALLE',15,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(18,'1.01.04.003','Estimación para Cuentas Incobrables','ACREEDORA','DETALLE',15,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(19,'1.01.05','Otras Cuentas por Cobrar','DEUDORA','MAYOR',3,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(20,'1.01.05.001','Deudores Diversos','DEUDORA','DETALLE',19,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(21,'1.01.05.002','Gastos por Comprobar','DEUDORA','DETALLE',19,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(22,'1.01.05.003','Anticipos a Proveedores','DEUDORA','DETALLE',19,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(23,'1.01.06','Inventarios','DEUDORA','MAYOR',3,0.0000,40000.0000,30000.0000,10000.0000,40000.0000,30000.0000,'2026-10',1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(24,'1.01.06.001','Inventario de Materias Primas','DEUDORA','DETALLE',23,0.0000,40000.0000,0.0000,40000.0000,40000.0000,0.0000,'2026-10',1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(25,'1.01.06.002','Inventario de Producción en Proceso','DEUDORA','DETALLE',23,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(26,'1.01.06.003','Inventario de Productos Terminados','DEUDORA','DETALLE',23,0.0000,0.0000,30000.0000,-30000.0000,0.0000,30000.0000,'2026-10',1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(27,'1.01.06.004','Mercancías en Tránsito','DEUDORA','DETALLE',23,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(28,'1.01.07','Impuestos por Cobrar','DEUDORA','MAYOR',3,0.0000,4800.0000,0.0000,4800.0000,4800.0000,0.0000,'2026-10',1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(29,'1.01.07.001','IVA Acreditable','DEUDORA','DETALLE',28,0.0000,4800.0000,0.0000,4800.0000,4800.0000,0.0000,'2026-10',1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(30,'1.02','Propiedad, Planta y Equipo','DEUDORA','MAYOR',2,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(31,'1.02.01','Terrenos','DEUDORA','MAYOR',30,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(32,'1.02.01.001','Terrenos de Planta de Producción','DEUDORA','DETALLE',31,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(33,'1.02.01.002','Terrenos de Oficinas Administrativas','DEUDORA','DETALLE',31,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(34,'1.02.02','Edificios','DEUDORA','MAYOR',30,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(35,'1.02.02.001','Edificios de Planta','DEUDORA','DETALLE',34,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(36,'1.02.02.002','Edificios de Oficinas','DEUDORA','DETALLE',34,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(37,'1.02.03','Maquinaria y Equipo','DEUDORA','MAYOR',30,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(38,'1.02.03.001','Maquinaria de Producción de Embutidos','DEUDORA','DETALLE',37,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(39,'1.02.03.002','Equipo Auxiliar de Planta','DEUDORA','DETALLE',37,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(40,'1.02.04','Equipo de Transporte','DEUDORA','MAYOR',30,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(41,'1.02.04.001','Camiones de Reparto Refrigerados','DEUDORA','DETALLE',40,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(42,'1.02.04.002','Camionetas de Transporte de Personal','DEUDORA','DETALLE',40,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(43,'1.02.05','Mobiliario y Equipo de Oficina','DEUDORA','MAYOR',30,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(44,'1.02.05.001','Mobiliario de Oficinas','DEUDORA','DETALLE',43,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(45,'1.02.05.002','Equipo de Oficina','DEUDORA','DETALLE',43,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(46,'1.02.06','Equipo Electrónico de Cómputo','DEUDORA','MAYOR',30,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(47,'1.02.06.001','Computadoras y Servidores','DEUDORA','DETALLE',46,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(48,'1.02.06.002','Equipo Periférico','DEUDORA','DETALLE',46,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(49,'1.02.07','Depreciaciones y Amortizaciones','ACREEDORA','MAYOR',30,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(50,'1.02.07.001','Depreciación Acumulada de Edificios','ACREEDORA','DETALLE',49,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(51,'1.02.07.002','Depreciación Acumulada de Maquinaria y Equipo','ACREEDORA','DETALLE',49,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(52,'1.02.07.003','Depreciación Acumulada de Equipo de Transporte','ACREEDORA','DETALLE',49,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(53,'1.02.07.004','Depreciación Acumulada de Mobiliario y Equipo de Oficina','ACREEDORA','DETALLE',49,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(54,'1.02.07.005','Depreciación Acumulada de Equipo Electrónico de Cómputo','ACREEDORA','DETALLE',49,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(55,'1.02.07.006','Amortización Acumulada de Gastos de Instalación','ACREEDORA','DETALLE',49,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(56,'1.02.07.007','Amortización Acumulada de Gastos de Organización','ACREEDORA','DETALLE',49,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(57,'1.03','Activo Diferido','DEUDORA','MAYOR',2,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(58,'1.03.01','Gastos de Instalación','DEUDORA','MAYOR',57,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(59,'1.03.01.001','Gastos de Instalación de Planta','DEUDORA','DETALLE',58,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(60,'1.03.02','Gastos de Organización','DEUDORA','MAYOR',57,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(61,'1.03.02.001','Gastos de Organización','DEUDORA','DETALLE',60,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(62,'1.03.03','Pagos Anticipados','DEUDORA','MAYOR',57,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(63,'1.03.03.001','Rentas Pagadas por Anticipado','DEUDORA','DETALLE',62,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(64,'1.03.03.002','Primas de Seguros Pagadas por Anticipado','DEUDORA','DETALLE',62,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(65,'1.03.03.003','Papelería y Útiles de Escritorio','DEUDORA','DETALLE',62,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(66,'1.03.03.004','Propaganda y Publicidad','DEUDORA','DETALLE',62,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(67,'1.04','Activos Intangibles','DEUDORA','MAYOR',2,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(68,'1.04.01','Derecho de Llave','DEUDORA','MAYOR',67,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(69,'1.04.01.001','Derecho de Llave','DEUDORA','DETALLE',68,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(70,'1.04.02','Marcas y Patentes','DEUDORA','MAYOR',67,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(71,'1.04.02.001','Marcas','DEUDORA','DETALLE',70,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(72,'1.04.02.002','Patentes','DEUDORA','DETALLE',70,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(73,'1.04.03','Licencias y Software','DEUDORA','MAYOR',67,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(74,'1.04.03.001','Licencias','DEUDORA','DETALLE',73,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(75,'1.04.03.002','Software','DEUDORA','DETALLE',73,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(76,'1.04.04','Amortización Acumulada de Activos Intangibles','ACREEDORA','MAYOR',67,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(77,'1.04.04.001','Amortización Acumulada de Derecho de Llave','ACREEDORA','DETALLE',76,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(78,'1.04.04.002','Amortización Acumulada de Marcas y Patentes','ACREEDORA','DETALLE',76,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(79,'1.04.04.003','Amortización Acumulada de Licencias y Software','ACREEDORA','DETALLE',76,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(80,'2','Pasivo','ACREEDORA','MAYOR',1,0.0000,44800.0000,50800.0000,6000.0000,44800.0000,50800.0000,'2026-10',1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(81,'2.01','Pasivo Corriente','ACREEDORA','MAYOR',80,0.0000,44800.0000,50800.0000,6000.0000,44800.0000,50800.0000,'2026-10',1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(82,'2.01.01','Proveedores','ACREEDORA','MAYOR',81,0.0000,44800.0000,44800.0000,0.0000,44800.0000,44800.0000,'2026-10',1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(83,'2.01.01.001','Proveedores Nacionales','ACREEDORA','DETALLE',82,0.0000,44800.0000,44800.0000,0.0000,44800.0000,44800.0000,'2026-10',1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(84,'2.01.01.002','Proveedores Extranjeros','ACREEDORA','DETALLE',82,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(85,'2.01.02','Sueldos y Salarios por Pagar','ACREEDORA','MAYOR',81,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(86,'2.01.02.001','Sueldos por Pagar (Personal Administrativo)','ACREEDORA','DETALLE',85,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(87,'2.01.02.002','Salarios por Pagar (Personal de Planta)','ACREEDORA','DETALLE',85,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(88,'2.01.02.003','Comisiones por Pagar (Ventas)','ACREEDORA','DETALLE',85,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(89,'2.01.03','Impuestos por Pagar','ACREEDORA','MAYOR',81,0.0000,0.0000,6000.0000,6000.0000,0.0000,6000.0000,'2026-10',1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(90,'2.01.03.001','ISR por Pagar','ACREEDORA','DETALLE',89,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(91,'2.01.03.002','IVA Trasladado (por pagar)','ACREEDORA','DETALLE',89,0.0000,0.0000,6000.0000,6000.0000,0.0000,6000.0000,'2026-10',1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(92,'2.01.03.003','Cuotas Obrero-Patronales IGSS','ACREEDORA','DETALLE',89,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(93,'2.01.03.004','Cuotas Obrero-Patronales IRTRA','ACREEDORA','DETALLE',89,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(94,'2.01.03.005','2% Sobre Nóminas','ACREEDORA','DETALLE',89,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(95,'2.01.04','Créditos Bancarios por Pagar (Corto Plazo)','ACREEDORA','MAYOR',81,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(96,'2.01.04.001','Banco Industrial (MN)','ACREEDORA','DETALLE',95,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(97,'2.01.04.002','Banrural (MN)','ACREEDORA','DETALLE',95,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(98,'2.01.04.003','Banco G&T Continental (MN)','ACREEDORA','DETALLE',95,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(99,'2.01.05','Documentos por Pagar (Corto Plazo)','ACREEDORA','MAYOR',81,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(100,'2.01.05.001','Documentos por Pagar a Proveedores Nacionales','ACREEDORA','DETALLE',99,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(101,'2.01.05.002','Documentos por Pagar a Proveedores Extranjeros','ACREEDORA','DETALLE',99,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(102,'2.01.06','Acreedores Diversos','ACREEDORA','MAYOR',81,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(103,'2.01.06.001','Acreedores Diversos por Conceptos Varios','ACREEDORA','DETALLE',102,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(104,'2.02','Pasivo Fijo','ACREEDORA','MAYOR',80,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(105,'2.02.01','Créditos Bancarios (Largo Plazo)','ACREEDORA','MAYOR',104,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(106,'2.02.01.001','Banco Industrial (Largo Plazo)','ACREEDORA','DETALLE',105,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(107,'2.02.01.002','Banco G&T Continental (Largo Plazo)','ACREEDORA','DETALLE',105,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(108,'2.02.02','Acreedores Hipotecarios','ACREEDORA','MAYOR',104,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(109,'2.02.02.001','Acreedores Hipotecarios','ACREEDORA','DETALLE',108,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(110,'2.02.03','Documentos por Pagar (Largo Plazo)','ACREEDORA','MAYOR',104,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(111,'2.02.03.001','Documentos por Pagar a Proveedores Nacionales (LP)','ACREEDORA','DETALLE',110,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(112,'2.02.03.002','Documentos por Pagar a Proveedores Extranjeros (LP)','ACREEDORA','DETALLE',110,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(113,'2.03','Pasivo Diferido','ACREEDORA','MAYOR',80,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(114,'2.03.01','Rentas Cobradas por Anticipado','ACREEDORA','MAYOR',113,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(115,'2.03.01.001','Rentas Cobradas por Anticipado','ACREEDORA','DETALLE',114,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(116,'2.03.02','Intereses Cobrados por Anticipado','ACREEDORA','MAYOR',113,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(117,'2.03.02.001','Intereses Cobrados por Anticipado','ACREEDORA','DETALLE',116,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(118,'3','Capital','ACREEDORA','MAYOR',1,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(119,'3.01','Capital Social','ACREEDORA','MAYOR',118,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(120,'3.01.01','Capital Social Fijo','ACREEDORA','MAYOR',119,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(121,'3.01.01.001','Inversionistas Nacionales','ACREEDORA','DETALLE',120,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(122,'3.01.01.002','Inversionistas Extranjeros','ACREEDORA','DETALLE',120,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(123,'3.01.02','Capital Social Variable','ACREEDORA','MAYOR',119,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(124,'3.01.02.001','Inversionistas Nacionales','ACREEDORA','DETALLE',123,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(125,'3.01.02.002','Inversionistas Extranjeros','ACREEDORA','DETALLE',123,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(126,'3.02','Resultados','ACREEDORA','MAYOR',118,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(127,'3.02.01','Resultado del Ejercicio','ACREEDORA','MAYOR',126,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(128,'3.02.01.001','Resultado del Ejercicio en Curso','ACREEDORA','DETALLE',127,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(129,'3.02.02','Resultados de Ejercicios Anteriores','ACREEDORA','MAYOR',126,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(130,'3.02.02.001','Resultados de Ejercicios Anteriores','ACREEDORA','DETALLE',129,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(131,'4','Resultados Acreedoras','ACREEDORA','MAYOR',1,0.0000,0.0000,50000.0000,50000.0000,0.0000,50000.0000,'2026-10',1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(132,'4.01','Ventas','ACREEDORA','MAYOR',131,0.0000,0.0000,50000.0000,50000.0000,0.0000,50000.0000,'2026-10',1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(133,'4.01.01','Ventas en Territorio Nacional','ACREEDORA','MAYOR',132,0.0000,0.0000,50000.0000,50000.0000,0.0000,50000.0000,'2026-10',1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(134,'4.01.01.001','Ventas de Embutidos – Línea Res','ACREEDORA','DETALLE',133,0.0000,0.0000,30000.0000,30000.0000,0.0000,30000.0000,'2026-10',1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(135,'4.01.01.002','Ventas de Embutidos – Línea Cerdo','ACREEDORA','DETALLE',133,0.0000,0.0000,20000.0000,20000.0000,0.0000,20000.0000,'2026-10',1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(136,'4.01.01.003','Ventas de Embutidos – Línea Pollo','ACREEDORA','DETALLE',133,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(137,'4.01.02','Ventas en Territorio Extranjero (Exportación)','ACREEDORA','MAYOR',132,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(138,'4.01.02.001','Ventas de Exportación','ACREEDORA','DETALLE',137,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(139,'4.02','Productos Financieros','ACREEDORA','MAYOR',131,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(140,'4.02.01','Descuentos Aprovechados por Pronto Pago','ACREEDORA','MAYOR',139,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(141,'4.02.01.001','Descuentos Aprovechados por Pronto Pago','ACREEDORA','DETALLE',140,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(142,'4.03','Otros Ingresos','ACREEDORA','MAYOR',131,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(143,'4.03.01','Ventas de Subproductos','ACREEDORA','MAYOR',142,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(144,'4.03.01.001','Venta de Subproductos (No considerados mercancía)','ACREEDORA','DETALLE',143,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(145,'4.03.02','Otros Ingresos Diversos','ACREEDORA','MAYOR',142,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(146,'4.03.02.001','Otros Ingresos Diversos','ACREEDORA','DETALLE',145,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(147,'4.04','Devoluciones, Rebajas y Bonificaciones sobre Compras','ACREEDORA','MAYOR',131,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(148,'4.04.01','Devoluciones sobre Compras','ACREEDORA','MAYOR',147,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(149,'4.04.01.001','Devoluciones sobre Compras Nacionales','ACREEDORA','DETALLE',148,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(150,'4.04.01.002','Devoluciones sobre Compras de Importación','ACREEDORA','DETALLE',148,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(151,'4.04.02','Rebajas sobre Compras','ACREEDORA','MAYOR',147,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(152,'4.04.02.001','Rebajas sobre Compras Nacionales','ACREEDORA','DETALLE',151,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(153,'4.04.02.002','Rebajas sobre Compras de Importación','ACREEDORA','DETALLE',151,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(154,'4.04.03','Bonificaciones sobre Compras','ACREEDORA','MAYOR',147,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(155,'4.04.03.001','Bonificaciones sobre Compras Nacionales','ACREEDORA','DETALLE',154,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(156,'4.04.03.002','Bonificaciones sobre Compras de Importación','ACREEDORA','DETALLE',154,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(157,'4.04.04','Descuentos sobre Compras','ACREEDORA','MAYOR',147,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(158,'4.04.04.001','Descuentos sobre Compras Nacionales','ACREEDORA','DETALLE',157,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(159,'4.04.04.002','Descuentos sobre Compras de Importación','ACREEDORA','DETALLE',157,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(160,'5','Resultados Deudoras','DEUDORA','MAYOR',1,0.0000,30000.0000,0.0000,30000.0000,30000.0000,0.0000,'2026-10',1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(161,'5.01','Compras','DEUDORA','MAYOR',160,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(162,'5.01.01','Compras de Materias Primas','DEUDORA','MAYOR',161,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(163,'5.01.01.001','Compras a Proveedores Nacionales','DEUDORA','DETALLE',162,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(164,'5.01.01.002','Compras a Proveedores Extranjeros (Importación)','DEUDORA','DETALLE',162,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(165,'5.01.02','Gastos sobre Compras','DEUDORA','MAYOR',161,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(166,'5.01.02.001','Gastos sobre Compras Nacionales','DEUDORA','DETALLE',165,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(167,'5.01.02.002','Gastos sobre Compras de Importación','DEUDORA','DETALLE',165,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(168,'5.02','Costo de Ventas','DEUDORA','MAYOR',160,0.0000,30000.0000,0.0000,30000.0000,30000.0000,0.0000,'2026-10',1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(169,'5.02.01','Costo de Ventas de Productos Terminados','DEUDORA','MAYOR',168,0.0000,30000.0000,0.0000,30000.0000,30000.0000,0.0000,'2026-10',1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(170,'5.02.01.001','Costo de Ventas – Línea Res','DEUDORA','DETALLE',169,0.0000,18000.0000,0.0000,18000.0000,18000.0000,0.0000,'2026-10',1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(171,'5.02.01.002','Costo de Ventas – Línea Cerdo','DEUDORA','DETALLE',169,0.0000,12000.0000,0.0000,12000.0000,12000.0000,0.0000,'2026-10',1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(172,'5.02.01.003','Costo de Ventas – Línea Pollo','DEUDORA','DETALLE',169,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(173,'5.02.02','Costo de Ventas de Mercancías','DEUDORA','MAYOR',168,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(174,'5.02.02.001','Costo de Ventas de Mercancías','DEUDORA','DETALLE',173,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(175,'5.02.03','Depreciaciones y Amortizaciones (Costo)','DEUDORA','MAYOR',168,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(176,'5.02.03.001','Depreciación de Maquinaria y Equipo (Producción)','DEUDORA','DETALLE',175,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(177,'5.02.03.002','Depreciación de Edificios de Planta','DEUDORA','DETALLE',175,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(178,'5.02.03.003','Amortización de Gastos de Instalación (Producción)','DEUDORA','DETALLE',175,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(179,'5.03','Gastos de Venta','DEUDORA','MAYOR',160,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(180,'5.03.01','Sueldos y Prestaciones (Personal de Ventas)','DEUDORA','MAYOR',179,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(181,'5.03.01.001','Sueldos Normales','DEUDORA','DETALLE',180,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(182,'5.03.01.002','Prestaciones Normales','DEUDORA','DETALLE',180,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(183,'5.03.01.003','Comisiones','DEUDORA','DETALLE',180,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(184,'5.03.01.004','Impuestos y Aportaciones Patronales','DEUDORA','DETALLE',180,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(185,'5.03.02','Gastos de Viaje','DEUDORA','MAYOR',179,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(186,'5.03.02.001','Gastos de Viaje','DEUDORA','DETALLE',185,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(187,'5.03.03','Servicios Básicos','DEUDORA','MAYOR',179,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(188,'5.03.03.001','Energía Eléctrica','DEUDORA','DETALLE',187,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(189,'5.03.03.002','Servicio Telefónico','DEUDORA','DETALLE',187,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(190,'5.03.03.003','Arrendamientos de Oficinas y Locales','DEUDORA','DETALLE',187,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(191,'5.03.04','Depreciaciones y Amortizaciones','DEUDORA','MAYOR',179,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(192,'5.03.04.001','Depreciación de Edificios','DEUDORA','DETALLE',191,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(193,'5.03.04.002','Depreciación de Maquinaria y Equipo','DEUDORA','DETALLE',191,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(194,'5.03.04.003','Depreciación de Equipo de Transporte','DEUDORA','DETALLE',191,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(195,'5.03.04.004','Depreciación de Mobiliario y Equipo de Oficina','DEUDORA','DETALLE',191,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(196,'5.03.04.005','Depreciación de Equipo Electrónico de Cómputo','DEUDORA','DETALLE',191,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(197,'5.03.04.006','Amortización de Gastos de Instalación','DEUDORA','DETALLE',191,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(198,'5.03.04.007','Amortización de Gastos de Organización','DEUDORA','DETALLE',191,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(199,'5.03.04.008','Amortización de Activos Intangibles','DEUDORA','DETALLE',191,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(200,'5.03.05','Propaganda y Publicidad','DEUDORA','MAYOR',179,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(201,'5.03.05.001','Propaganda Impresa','DEUDORA','DETALLE',200,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(202,'5.03.05.002','Propaganda en Televisión','DEUDORA','DETALLE',200,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(203,'5.03.05.003','Propaganda en Radio','DEUDORA','DETALLE',200,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(204,'5.03.05.004','Propaganda en Medios Impresos','DEUDORA','DETALLE',200,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(205,'5.04','Gastos de Administración','DEUDORA','MAYOR',160,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(206,'5.04.01','Sueldos y Prestaciones (Personal Administrativo)','DEUDORA','MAYOR',205,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(207,'5.04.01.001','Sueldos Normales','DEUDORA','DETALLE',206,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(208,'5.04.01.002','Sueldos Extraordinarios','DEUDORA','DETALLE',206,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(209,'5.04.01.003','Prestaciones Normales','DEUDORA','DETALLE',206,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(210,'5.04.01.004','Impuestos y Aportaciones Patronales','DEUDORA','DETALLE',206,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(211,'5.04.02','Gastos de Viaje','DEUDORA','MAYOR',205,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(212,'5.04.02.001','Gastos de Viaje','DEUDORA','DETALLE',211,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(213,'5.04.03','Servicios Básicos','DEUDORA','MAYOR',205,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(214,'5.04.03.001','Energía Eléctrica','DEUDORA','DETALLE',213,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(215,'5.04.03.002','Servicio Telefónico','DEUDORA','DETALLE',213,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(216,'5.04.03.003','Arrendamientos de Oficinas y Locales','DEUDORA','DETALLE',213,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(217,'5.04.04','Depreciaciones y Amortizaciones','DEUDORA','MAYOR',205,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(218,'5.04.04.001','Depreciación de Edificios','DEUDORA','DETALLE',217,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(219,'5.04.04.002','Depreciación de Maquinaria y Equipo','DEUDORA','DETALLE',217,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(220,'5.04.04.003','Depreciación de Equipo de Transporte','DEUDORA','DETALLE',217,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(221,'5.04.04.004','Depreciación de Mobiliario y Equipo de Oficina','DEUDORA','DETALLE',217,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(222,'5.04.04.005','Depreciación de Equipo Electrónico de Cómputo','DEUDORA','DETALLE',217,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(223,'5.04.04.006','Amortización de Gastos de Instalación','DEUDORA','DETALLE',217,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(224,'5.04.04.007','Amortización de Gastos de Organización','DEUDORA','DETALLE',217,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(225,'5.04.04.008','Amortización de Activos Intangibles','DEUDORA','DETALLE',217,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(226,'5.05','Gastos Financieros','DEUDORA','MAYOR',160,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(227,'5.05.01','Comisiones Bancarias','DEUDORA','MAYOR',226,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(228,'5.05.01.001','Comisiones Diversas','DEUDORA','DETALLE',227,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(229,'5.05.02','Intereses Pagados','DEUDORA','MAYOR',226,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(230,'5.05.02.001','Intereses Pagados a Instituciones Bancarias','DEUDORA','DETALLE',229,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(231,'5.05.02.002','Intereses Pagados a Compañías del Grupo','DEUDORA','DETALLE',229,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(232,'5.05.02.003','Intereses Pagados a Terceros','DEUDORA','DETALLE',229,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(233,'5.05.03','Pérdida en Cambios','DEUDORA','MAYOR',226,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(234,'5.05.03.001','Pérdida en Cambios por Compras en Moneda Extranjera','DEUDORA','DETALLE',233,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(235,'5.05.03.002','Pérdida en Cambios por Importaciones','DEUDORA','DETALLE',233,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(236,'5.05.03.003','Pérdida en Cambios por Operaciones Diversas','DEUDORA','DETALLE',233,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(237,'5.05.04','Descuentos por Pronto Pago','DEUDORA','MAYOR',226,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(238,'5.05.04.001','Descuentos por Pronto Pago','DEUDORA','DETALLE',237,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(239,'5.06','Otros Gastos','DEUDORA','MAYOR',160,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(240,'5.06.01','Otros Gastos Diversos','DEUDORA','MAYOR',239,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(241,'5.06.01.001','Otros Gastos Extraordinarios','DEUDORA','DETALLE',240,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(242,'5.06.01.002','Otros Gastos Diversos','DEUDORA','DETALLE',240,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(243,'6','Contingencia','ACREEDORA','MAYOR',1,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(244,'6.01','Cuentas de Contingencia','ACREEDORA','MAYOR',243,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(245,'6.01.01','Contingencias Laborales','ACREEDORA','DETALLE',244,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(246,'6.01.02','Contingencias Fiscales','ACREEDORA','DETALLE',244,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(247,'6.01.03','Contingencias Legales','ACREEDORA','DETALLE',244,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(248,'7','Cuentas de Orden','DEUDORA','MAYOR',1,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(249,'7.01','Cuentas de Orden Deudoras','DEUDORA','MAYOR',248,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(250,'7.01.01','Documentos en Custodia','DEUDORA','DETALLE',249,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(251,'7.01.02','Valores en Garantía','DEUDORA','DETALLE',249,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(252,'7.02','Cuentas de Orden Acreedoras','ACREEDORA','MAYOR',248,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(253,'7.02.01','Contrapartida de Documentos en Custodia','ACREEDORA','DETALLE',252,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(254,'7.02.02','Contrapartida de Valores en Garantía','ACREEDORA','DETALLE',252,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,1,'2026-11-14 18:34:36','2026-11-14 18:34:36');
/*!40000 ALTER TABLE `tblcuenta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblcuentabancaria`
--

DROP TABLE IF EXISTS `tblcuentabancaria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblcuentabancaria` (
  `idCuentaBancaria` bigint NOT NULL AUTO_INCREMENT,
  `numeroCuentaBancaria` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nombreCuentaBancaria` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `codigoCuentaContableCuentaBancaria` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `limiteSobregiroCuentaBancaria` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `saldoInicialCuentaBancaria` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `Fk_Banco_Codigo` bigint NOT NULL,
  `Fk_Moneda_Codigo` bigint NOT NULL,
  `Fk_TipoCuentaBancaria_Codigo` bigint NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idCuentaBancaria`),
  UNIQUE KEY `uqCuentaBancaria1` (`Fk_Banco_Codigo`,`numeroCuentaBancaria`),
  KEY `idxCuentaBancariaMoneda` (`Fk_Moneda_Codigo`),
  KEY `idxCuentaBancariaTipo` (`Fk_TipoCuentaBancaria_Codigo`),
  CONSTRAINT `Fk_CuentaBancaria_Banco` FOREIGN KEY (`Fk_Banco_Codigo`) REFERENCES `tblbanco` (`idBanco`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `Fk_CuentaBancaria_Moneda` FOREIGN KEY (`Fk_Moneda_Codigo`) REFERENCES `tblmoneda` (`idMoneda`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `Fk_CuentaBancaria_Tipo` FOREIGN KEY (`Fk_TipoCuentaBancaria_Codigo`) REFERENCES `tbltipocuentabancaria` (`idTipoCuentaBancaria`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `ckCuentaBancaria1` CHECK ((`limiteSobregiroCuentaBancaria` >= 0)),
  CONSTRAINT `ckCuentaBancaria2` CHECK ((`is_active` in (0,1)))
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblcuentabancaria`
--

LOCK TABLES `tblcuentabancaria` WRITE;
/*!40000 ALTER TABLE `tblcuentabancaria` DISABLE KEYS */;
INSERT INTO `tblcuentabancaria` VALUES (1,'000-215487-9','Cuenta operativa Industrial GTQ','1.01.02.001',50000.0000,0.0000,1,1,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(2,'3011-045678-2','Cuenta de proveedores Banrural GTQ','1.01.02.002',25000.0000,0.0000,2,1,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(3,'90-4421-3','Cuenta operativa BAC USD','1.01.02.003',0.0000,0.0000,3,2,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(4,'450-0123456-1','Cuenta de nomina G&T GTQ','1.01.02.004',0.0000,0.0000,4,1,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(5,'7701-889012-6','Cuenta de ahorro reserva Agromercantil GTQ','1.01.03.001',0.0000,0.0000,5,1,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36');
/*!40000 ALTER TABLE `tblcuentabancaria` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblcuentabancariatercero`
--

DROP TABLE IF EXISTS `tblcuentabancariatercero`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblcuentabancariatercero` (
  `idCuentaBancariaTercero` bigint NOT NULL AUTO_INCREMENT,
  `numeroCuentaBancariaTercero` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nombreTitularCuentaBancariaTercero` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `idBanco` bigint NOT NULL,
  `idMoneda` bigint NOT NULL,
  `idEmpleado` int DEFAULT NULL,
  `idProveedor` int DEFAULT NULL,
  `idCliente` int DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idCuentaBancariaTercero`),
  UNIQUE KEY `uqCuentaBancariaTercero` (`idBanco`,`numeroCuentaBancariaTercero`),
  KEY `Fk_CuentaBancariaTercero_Moneda` (`idMoneda`),
  KEY `idxCuentaTerceroEmpleado` (`idEmpleado`),
  KEY `idxCuentaTerceroProveedor` (`idProveedor`),
  KEY `idxCuentaTerceroCliente` (`idCliente`),
  CONSTRAINT `Fk_CuentaBancariaTercero_Banco` FOREIGN KEY (`idBanco`) REFERENCES `tblbanco` (`idBanco`),
  CONSTRAINT `Fk_CuentaBancariaTercero_Cliente` FOREIGN KEY (`idCliente`) REFERENCES `tblcliente` (`idCliente`),
  CONSTRAINT `Fk_CuentaBancariaTercero_Empleado` FOREIGN KEY (`idEmpleado`) REFERENCES `tblempleado` (`idEmpleado`),
  CONSTRAINT `Fk_CuentaBancariaTercero_Moneda` FOREIGN KEY (`idMoneda`) REFERENCES `tblmoneda` (`idMoneda`),
  CONSTRAINT `Fk_CuentaBancariaTercero_Proveedor` FOREIGN KEY (`idProveedor`) REFERENCES `tblproveedor` (`idProveedor`),
  CONSTRAINT `ckCuentaBancariaTerceroPropietario` CHECK (((((`idEmpleado` is not null) + (`idProveedor` is not null)) + (`idCliente` is not null)) = 1)),
  CONSTRAINT `ckCuentaTerceroActivo` CHECK ((`is_active` in (0,1)))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblcuentabancariatercero`
--

LOCK TABLES `tblcuentabancariatercero` WRITE;
/*!40000 ALTER TABLE `tblcuentabancariatercero` DISABLE KEYS */;
/*!40000 ALTER TABLE `tblcuentabancariatercero` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblcuentabancariatransportista`
--

DROP TABLE IF EXISTS `tblcuentabancariatransportista`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblcuentabancariatransportista` (
  `idCuentaBancariaTransportista` int NOT NULL AUTO_INCREMENT,
  `Fk_Empresa_Transportista_Codigo` int NOT NULL,
  `Fk_Banco_Codigo` bigint NOT NULL,
  `Fk_TipoCuentaBancaria_Codigo` bigint NOT NULL,
  `Fk_Moneda_Codigo` bigint NOT NULL,
  `numeroCuentaBancariaTransportista` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `titularCuentaBancariaTransportista` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `activaCuentaBancariaTransportista` tinyint(1) NOT NULL DEFAULT '1',
  `predeterminadaCuentaBancariaTransportista` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idCuentaBancariaTransportista`),
  UNIQUE KEY `uqCuentaBancariaTransportista` (`Fk_Banco_Codigo`,`numeroCuentaBancariaTransportista`),
  KEY `Fk_Cuenta_Bancaria_Transportista_Empresa_Transportista` (`Fk_Empresa_Transportista_Codigo`),
  KEY `Fk_Cuenta_Bancaria_Transportista_Tipo_Cuenta_Bancaria` (`Fk_TipoCuentaBancaria_Codigo`),
  KEY `Fk_Cuenta_Bancaria_Transportista_Moneda` (`Fk_Moneda_Codigo`),
  CONSTRAINT `Fk_Cuenta_Bancaria_Transportista_Banco` FOREIGN KEY (`Fk_Banco_Codigo`) REFERENCES `tblbanco` (`idBanco`) ON DELETE RESTRICT,
  CONSTRAINT `Fk_Cuenta_Bancaria_Transportista_Empresa_Transportista` FOREIGN KEY (`Fk_Empresa_Transportista_Codigo`) REFERENCES `tblempresatransportista` (`idEmpresaTransportista`) ON DELETE RESTRICT,
  CONSTRAINT `Fk_Cuenta_Bancaria_Transportista_Moneda` FOREIGN KEY (`Fk_Moneda_Codigo`) REFERENCES `tblmoneda` (`idMoneda`) ON DELETE RESTRICT,
  CONSTRAINT `Fk_Cuenta_Bancaria_Transportista_Tipo_Cuenta_Bancaria` FOREIGN KEY (`Fk_TipoCuentaBancaria_Codigo`) REFERENCES `tbltipocuentabancaria` (`idTipoCuentaBancaria`) ON DELETE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblcuentabancariatransportista`
--

LOCK TABLES `tblcuentabancariatransportista` WRITE;
/*!40000 ALTER TABLE `tblcuentabancariatransportista` DISABLE KEYS */;
INSERT INTO `tblcuentabancariatransportista` VALUES (1,1,1,1,1,'0102-0045-00876321','Transporte Refrigerado del Altiplano, S.A.',1,1,'2026-11-14 18:34:39','2026-11-14 18:34:39'),(2,2,1,1,1,'0102-0045-00876322','Logística del Pacífico, S.A.',1,1,'2026-11-14 18:34:39','2026-11-14 18:34:39'),(3,3,1,1,1,'0102-0045-00876323','Distribuciones La Ceiba, S.A.',1,1,'2026-11-14 18:34:39','2026-11-14 18:34:39'),(4,4,1,1,1,'0102-0045-00876324','Carga Fría del Sur, S.A.',1,1,'2026-11-14 18:34:39','2026-11-14 18:34:39'),(5,5,1,1,1,'0102-0045-00876325','Transportes Valle Verde, S.A.',1,1,'2026-11-14 18:34:39','2026-11-14 18:34:39');
/*!40000 ALTER TABLE `tblcuentabancariatransportista` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblcuentacontablecxc`
--

DROP TABLE IF EXISTS `tblcuentacontablecxc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblcuentacontablecxc` (
  `idCuentaContableCxC` int NOT NULL AUTO_INCREMENT,
  `idMoneda` bigint NOT NULL,
  `tipoCuentaContableCxC` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `cuentaClientesCuentaContableCxC` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `cuentaContrapartidaCuentaContableCxC` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idCuentaContableCxC`),
  UNIQUE KEY `uqCuentaContableCxCClaveNegocio` (`idMoneda`,`tipoCuentaContableCxC`),
  CONSTRAINT `Fk_CuentaContableCxC_Moneda` FOREIGN KEY (`idMoneda`) REFERENCES `tblmoneda` (`idMoneda`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblcuentacontablecxc`
--

LOCK TABLES `tblcuentacontablecxc` WRITE;
/*!40000 ALTER TABLE `tblcuentacontablecxc` DISABLE KEYS */;
/*!40000 ALTER TABLE `tblcuentacontablecxc` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblcuentaporpagar`
--

DROP TABLE IF EXISTS `tblcuentaporpagar`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblcuentaporpagar` (
  `idProveedor` int NOT NULL,
  `idConceptoProveedor` int NOT NULL,
  `serieDocumentoCuentaPorPagar` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `numeroDocumentoCuentaPorPagar` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fechaEmisionCuentaPorPagar` date NOT NULL,
  `fechaVencimientoCuentaPorPagar` date NOT NULL,
  `idMoneda` bigint NOT NULL,
  `idTipoCambio` bigint DEFAULT NULL,
  `tipoCambioCuentaPorPagar` decimal(12,6) NOT NULL DEFAULT '1.000000',
  `montoTotalCuentaPorPagar` decimal(12,4) NOT NULL,
  `saldoActualCuentaPorPagar` decimal(12,4) NOT NULL,
  `estadoCuentaPorPagar` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Pendiente',
  `bloqueadoCuentaPorPagar` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`serieDocumentoCuentaPorPagar`,`numeroDocumentoCuentaPorPagar`,`idConceptoProveedor`),
  KEY `Fk_Proveedor_idProveedor` (`idProveedor`),
  KEY `Fk_CuentaPorPagar_Concepto` (`idConceptoProveedor`),
  KEY `idxCuentaPorPagarVencimiento` (`fechaVencimientoCuentaPorPagar`),
  KEY `idxCuentaPorPagarMoneda` (`idMoneda`),
  KEY `idxCuentaPorPagarTipoCambio` (`idTipoCambio`),
  CONSTRAINT `Fk_CuentaPorPagar_Concepto` FOREIGN KEY (`idConceptoProveedor`) REFERENCES `tblconceptoproveedor` (`idConceptoProveedor`),
  CONSTRAINT `Fk_CuentaPorPagar_Moneda` FOREIGN KEY (`idMoneda`) REFERENCES `tblmoneda` (`idMoneda`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `Fk_CuentaPorPagar_TipoCambio` FOREIGN KEY (`idTipoCambio`) REFERENCES `tbltipocambio` (`idTipoCambio`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `Fk_Proveedor_idProveedor` FOREIGN KEY (`idProveedor`) REFERENCES `tblproveedor` (`idProveedor`),
  CONSTRAINT `ckEstadoCuentaPorPagar` CHECK ((`estadoCuentaPorPagar` in (_utf8mb4'Pendiente',_utf8mb4'Parcial',_utf8mb4'Pagada',_utf8mb4'Anulada'))),
  CONSTRAINT `ckFechasCuentaPorPagar` CHECK ((`fechaVencimientoCuentaPorPagar` >= `fechaEmisionCuentaPorPagar`)),
  CONSTRAINT `ckMontoTotalCuentaPorPagar` CHECK ((`montoTotalCuentaPorPagar` <> 0)),
  CONSTRAINT `ckReferenciaTipoCambioCuentaPorPagar` CHECK (((`idTipoCambio` is not null) or (`tipoCambioCuentaPorPagar` = 1))),
  CONSTRAINT `ckTipoCambioCuentaPorPagar` CHECK ((`tipoCambioCuentaPorPagar` > 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblcuentaporpagar`
--

LOCK TABLES `tblcuentaporpagar` WRITE;
/*!40000 ALTER TABLE `tblcuentaporpagar` DISABLE KEYS */;
INSERT INTO `tblcuentaporpagar` VALUES (13,11,'PR-0d2d5068e05a','1','2026-11-14','2026-11-29',1,NULL,1.000000,100.0000,100.0000,'Pendiente',0,'2026-11-14 18:34:39','2026-11-14 18:34:39'),(14,11,'PR-0d2d5068e05a','2','2026-11-14','2026-12-14',1,NULL,1.000000,100.0000,100.0000,'Pendiente',0,'2026-11-14 18:34:39','2026-11-14 18:34:39'),(15,11,'PR-0d2d5068e05a','3','2026-11-14','2026-12-29',1,NULL,1.000000,100.0000,100.0000,'Pendiente',0,'2026-11-14 18:34:39','2026-11-14 18:34:39'),(16,11,'PR-0d2d5068e05a','4','2026-11-14','2027-01-13',1,NULL,1.000000,100.0000,100.0000,'Pendiente',0,'2026-11-14 18:34:39','2026-11-14 18:34:39'),(17,11,'PR-0d2d5068e05a','5','2026-11-14','2027-01-28',1,NULL,1.000000,100.0000,100.0000,'Pendiente',0,'2026-11-14 18:34:39','2026-11-14 18:34:39');
/*!40000 ALTER TABLE `tblcuentaporpagar` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbldepartamento`
--

DROP TABLE IF EXISTS `tbldepartamento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbldepartamento` (
  `idDepartamento` int NOT NULL AUTO_INCREMENT,
  `nombreDepartamento` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idDepartamento`),
  UNIQUE KEY `uqNombreDepartamento` (`nombreDepartamento`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbldepartamento`
--

LOCK TABLES `tbldepartamento` WRITE;
/*!40000 ALTER TABLE `tbldepartamento` DISABLE KEYS */;
INSERT INTO `tbldepartamento` VALUES (1,'Sistemas',1,'2026-11-14 18:33:55','2026-11-14 18:33:55'),(2,'Gerencia',1,'2026-11-14 18:33:55','2026-11-14 18:33:55'),(3,'Recursos Humanos',1,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(4,'Contabilidad',1,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(5,'Producción',1,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(6,'Ventas',1,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(7,'Logística',1,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(8,'bancos',1,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(9,'compras',1,'2026-11-14 18:34:37','2026-11-14 18:34:37');
/*!40000 ALTER TABLE `tbldepartamento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbldepositoventadetalle`
--

DROP TABLE IF EXISTS `tbldepositoventadetalle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbldepositoventadetalle` (
  `idDepositoVentaDetalle` int NOT NULL AUTO_INCREMENT,
  `idDepositoVentaEncabezado` int NOT NULL,
  `idReciboPago` int NOT NULL,
  `importeDepositoVentaDetalle` decimal(12,4) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idDepositoVentaEncabezado`,`idDepositoVentaDetalle`),
  UNIQUE KEY `uqDepositoVentaDetalleClaveNegocio` (`idDepositoVentaEncabezado`,`idReciboPago`),
  UNIQUE KEY `uqDepositoVentaDetalleId` (`idDepositoVentaDetalle`),
  KEY `idxDepositoVentaDetalleReciboPagoCodigo` (`idReciboPago`),
  CONSTRAINT `Fk_DepositoVentaDetalle_DepositoVentaEncabezado` FOREIGN KEY (`idDepositoVentaEncabezado`) REFERENCES `tbldepositoventaencabezado` (`idDepositoVentaEncabezado`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `Fk_DepositoVentaDetalle_ReciboPago` FOREIGN KEY (`idReciboPago`) REFERENCES `tblrecibopago` (`idReciboPago`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `ckDepositoVentaDetalleImportePositivo` CHECK ((`importeDepositoVentaDetalle` > 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbldepositoventadetalle`
--

LOCK TABLES `tbldepositoventadetalle` WRITE;
/*!40000 ALTER TABLE `tbldepositoventadetalle` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbldepositoventadetalle` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbldepositoventaencabezado`
--

DROP TABLE IF EXISTS `tbldepositoventaencabezado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbldepositoventaencabezado` (
  `idDepositoVentaEncabezado` int NOT NULL AUTO_INCREMENT,
  `codigoDepositoVentaEncabezado` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fechaDepositoVentaEncabezado` date NOT NULL,
  `referenciaDepositoVentaEncabezado` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idMoneda` bigint NOT NULL,
  `totalDepositoVentaEncabezado` decimal(12,4) NOT NULL,
  `estadoDepositoVentaEncabezado` varchar(25) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'PREPARADO',
  `idUsuarioRegistro` int NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `idCuentaBancaria` bigint NOT NULL,
  `idTipoTransaccion` bigint NOT NULL,
  `idMovimientoBancario` bigint DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idDepositoVentaEncabezado`),
  UNIQUE KEY `uqDepositoVentaEncabezadocodigo` (`codigoDepositoVentaEncabezado`),
  UNIQUE KEY `uqDepositoVentaEncabezadoMovimientoBancarioCodigo` (`idMovimientoBancario`),
  KEY `idxDepositoVentaEncabezadoUsuarioRegistro` (`idUsuarioRegistro`),
  KEY `idxDepositoVentaEncabezadoMonedaCodigo` (`idMoneda`),
  KEY `idxDepositoVentaEncabezadoCuentaBancariaCodigo` (`idCuentaBancaria`),
  KEY `idxDepositoVentaEncabezadoTipoTransaccionCodigo` (`idTipoTransaccion`),
  CONSTRAINT `Fk_DepositoVentaEncabezado_CuentaBancaria` FOREIGN KEY (`idCuentaBancaria`) REFERENCES `tblcuentabancaria` (`idCuentaBancaria`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `Fk_DepositoVentaEncabezado_Moneda` FOREIGN KEY (`idMoneda`) REFERENCES `tblmoneda` (`idMoneda`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `Fk_DepositoVentaEncabezado_MovimientoBancario` FOREIGN KEY (`idMovimientoBancario`) REFERENCES `tblmovimientobancario` (`idMovimientoBancario`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `Fk_DepositoVentaEncabezado_TipoTransaccion` FOREIGN KEY (`idTipoTransaccion`) REFERENCES `tbltipotransaccion` (`idTipoTransaccion`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `Fk_DepositoVentaEncabezado_Usuario_Registro` FOREIGN KEY (`idUsuarioRegistro`) REFERENCES `tblusuario` (`idUsuario`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `ckDepositoVentaEncabezadoTotalPositivo` CHECK ((`totalDepositoVentaEncabezado` > 0)),
  CONSTRAINT `ckDepositoVentaEncabezadoValoresEstadoDeposito` CHECK ((`estadoDepositoVentaEncabezado` in (_utf8mb4'PREPARADO',_utf8mb4'ENVIADO',_utf8mb4'CONFIRMADO',_utf8mb4'ANULADO')))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbldepositoventaencabezado`
--

LOCK TABLES `tbldepositoventaencabezado` WRITE;
/*!40000 ALTER TABLE `tbldepositoventaencabezado` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbldepositoventaencabezado` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbldetalleauditoria`
--

DROP TABLE IF EXISTS `tbldetalleauditoria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbldetalleauditoria` (
  `idDetalleAuditoria` int NOT NULL AUTO_INCREMENT,
  `Fk_Auditoria_Inventario_Codigo` int NOT NULL,
  `Fk_Stock_Codigo` int NOT NULL,
  `stockTeoricoDetalleAuditoria` int NOT NULL,
  `stockFisicoDetalleAuditoria` int NOT NULL,
  `diferenciaDetalleAuditoria` int NOT NULL COMMENT 'Calculado en C# como stock físico - stock teórico',
  `observacionesDetalleAuditoria` varchar(500) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idDetalleAuditoria`),
  UNIQUE KEY `uqDetalleAuditoriaStock` (`Fk_Auditoria_Inventario_Codigo`,`Fk_Stock_Codigo`),
  KEY `Fk_Detalle_Auditoria_Stock` (`Fk_Stock_Codigo`),
  CONSTRAINT `Fk_Detalle_Auditoria_Auditoria_Inventario` FOREIGN KEY (`Fk_Auditoria_Inventario_Codigo`) REFERENCES `tblauditoriainventario` (`idAuditoriaInventario`) ON DELETE RESTRICT,
  CONSTRAINT `Fk_Detalle_Auditoria_Stock` FOREIGN KEY (`Fk_Stock_Codigo`) REFERENCES `tblstock` (`idStock`) ON DELETE RESTRICT,
  CONSTRAINT `ckDetalleAuditoriaStockFisico` CHECK ((`stockFisicoDetalleAuditoria` >= 0)),
  CONSTRAINT `ckDetalleAuditoriaStockTeorico` CHECK ((`stockTeoricoDetalleAuditoria` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbldetalleauditoria`
--

LOCK TABLES `tbldetalleauditoria` WRITE;
/*!40000 ALTER TABLE `tbldetalleauditoria` DISABLE KEYS */;
INSERT INTO `tbldetalleauditoria` VALUES (1,1,1,135,135,0,'Concordancia completa con el saldo teórico.','2026-11-14 18:34:39','2026-11-14 18:34:39'),(2,2,2,82,82,0,'Cantidad física confirmada con la ubicación de bodega.','2026-11-14 18:34:39','2026-11-14 18:34:39'),(3,3,3,50,48,-2,'Dos unidades no localizadas; investigar despachos.','2026-11-14 18:34:39','2026-11-14 18:34:39'),(4,4,4,160,161,1,'Una unidad adicional; revisar ingreso pendiente.','2026-11-14 18:34:39','2026-11-14 18:34:39'),(5,5,5,100,100,0,'Primer artículo validado de la auditoría múltiple.','2026-11-14 18:34:39','2026-11-14 18:34:39');
/*!40000 ALTER TABLE `tbldetalleauditoria` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbldetallecierre`
--

DROP TABLE IF EXISTS `tbldetallecierre`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbldetallecierre` (
  `idDetalleCierre` int NOT NULL AUTO_INCREMENT,
  `Fk_Cierre_Inventario_Codigo` int NOT NULL,
  `Fk_Stock_Codigo` int NOT NULL,
  `stockAnteriorDetalleCierre` int NOT NULL DEFAULT '0',
  `stockActualDetalleCierre` int NOT NULL DEFAULT '0',
  `cargosMesDetalleCierre` int NOT NULL DEFAULT '0',
  `abonosMesDetalleCierre` int NOT NULL DEFAULT '0',
  `cargosAcumuladosDetalleCierre` bigint NOT NULL DEFAULT '0',
  `abonosAcumuladosDetalleCierre` bigint NOT NULL DEFAULT '0',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idDetalleCierre`),
  UNIQUE KEY `uqDetalleCierreStock` (`Fk_Cierre_Inventario_Codigo`,`Fk_Stock_Codigo`),
  KEY `Fk_Detalle_Cierre_Stock` (`Fk_Stock_Codigo`),
  CONSTRAINT `Fk_Detalle_Cierre_Cierre_Inventario` FOREIGN KEY (`Fk_Cierre_Inventario_Codigo`) REFERENCES `tblcierreinventario` (`idCierreInventario`) ON DELETE RESTRICT,
  CONSTRAINT `Fk_Detalle_Cierre_Stock` FOREIGN KEY (`Fk_Stock_Codigo`) REFERENCES `tblstock` (`idStock`) ON DELETE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbldetallecierre`
--

LOCK TABLES `tbldetallecierre` WRITE;
/*!40000 ALTER TABLE `tbldetallecierre` DISABLE KEYS */;
INSERT INTO `tbldetallecierre` VALUES (1,1,1,120,135,35,20,400,265,'2026-11-14 18:34:39','2026-11-14 18:34:39'),(2,2,2,80,82,20,18,250,168,'2026-11-14 18:34:39','2026-11-14 18:34:39'),(3,3,3,60,50,15,25,220,170,'2026-11-14 18:34:39','2026-11-14 18:34:39'),(4,4,4,150,160,50,40,580,420,'2026-11-14 18:34:39','2026-11-14 18:34:39'),(5,5,5,95,100,20,15,330,230,'2026-11-14 18:34:39','2026-11-14 18:34:39');
/*!40000 ALTER TABLE `tbldetallecierre` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbldetallecompra`
--

DROP TABLE IF EXISTS `tbldetallecompra`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbldetallecompra` (
  `idCompra` int NOT NULL,
  `ordenDetalleCompra` int NOT NULL,
  `idProducto` int NOT NULL,
  `idBodega` int NOT NULL,
  `cantidadDetalleCompra` decimal(12,4) NOT NULL,
  `costoUnitarioDetalleCompra` decimal(12,4) NOT NULL,
  `descuentoPorcentualDetalleCompra` decimal(3,2) NOT NULL DEFAULT '0.00',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idCompra`,`ordenDetalleCompra`,`idProducto`),
  UNIQUE KEY `uqOrdenDetalleCompra` (`idCompra`,`ordenDetalleCompra`),
  KEY `idxDetalleCompraProducto` (`idProducto`),
  KEY `idxDetalleCompraBodega` (`idBodega`),
  CONSTRAINT `Fk_DetalleCompra_Bodega` FOREIGN KEY (`idBodega`) REFERENCES `tblbodega` (`idBodega`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `Fk_DetalleCompra_Encabezado` FOREIGN KEY (`idCompra`) REFERENCES `tblencabezadocompra` (`idCompra`),
  CONSTRAINT `Fk_DetalleCompra_Producto` FOREIGN KEY (`idProducto`) REFERENCES `tblproducto` (`idProducto`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `ckCantidadDetalleCompra` CHECK ((`cantidadDetalleCompra` > 0)),
  CONSTRAINT `ckCostoDetalleCompra` CHECK ((`costoUnitarioDetalleCompra` >= 0)),
  CONSTRAINT `ckDescuentoDetalleCompra` CHECK ((`descuentoPorcentualDetalleCompra` between 0 and 0.99)),
  CONSTRAINT `ckOrdenDetalleCompra` CHECK ((`ordenDetalleCompra` > 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbldetallecompra`
--

LOCK TABLES `tbldetallecompra` WRITE;
/*!40000 ALTER TABLE `tbldetallecompra` DISABLE KEYS */;
INSERT INTO `tbldetallecompra` VALUES (1,1,6,1,10.0000,10.0000,0.00,'2026-11-14 18:34:39','2026-11-14 18:34:39'),(2,1,7,1,10.0000,10.0000,0.00,'2026-11-14 18:34:39','2026-11-14 18:34:39'),(3,1,8,1,10.0000,10.0000,0.00,'2026-11-14 18:34:39','2026-11-14 18:34:39');
/*!40000 ALTER TABLE `tbldetallecompra` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbldetalleconciliacion`
--

DROP TABLE IF EXISTS `tbldetalleconciliacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbldetalleconciliacion` (
  `idDetalleConciliacion` bigint NOT NULL AUTO_INCREMENT,
  `resultadoDetalleConciliacion` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `metodoDetalleConciliacion` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `diferenciaDetalleConciliacion` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `motivoDetalleConciliacion` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Fk_Conciliacion_Codigo` bigint NOT NULL,
  `Fk_MovimientoBancario_Codigo` bigint DEFAULT NULL,
  `Fk_DetalleExtracto_Codigo` bigint DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idDetalleConciliacion`),
  UNIQUE KEY `uqDetalleConciliacion1` (`Fk_Conciliacion_Codigo`,`Fk_MovimientoBancario_Codigo`),
  UNIQUE KEY `uqDetalleConciliacion2` (`Fk_Conciliacion_Codigo`,`Fk_DetalleExtracto_Codigo`),
  KEY `idxDetalleConciliacionMovimiento` (`Fk_MovimientoBancario_Codigo`),
  KEY `idxDetalleConciliacionExtracto` (`Fk_DetalleExtracto_Codigo`),
  CONSTRAINT `Fk_DetalleConciliacion_Conciliacion` FOREIGN KEY (`Fk_Conciliacion_Codigo`) REFERENCES `tblconciliacion` (`idConciliacion`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `Fk_DetalleConciliacion_Extracto` FOREIGN KEY (`Fk_DetalleExtracto_Codigo`) REFERENCES `tbldetalleextracto` (`idDetalleExtracto`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `Fk_DetalleConciliacion_Movimiento` FOREIGN KEY (`Fk_MovimientoBancario_Codigo`) REFERENCES `tblmovimientobancario` (`idMovimientoBancario`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `ckDetalleConciliacion1` CHECK ((`resultadoDetalleConciliacion` in (_utf8mb4'COINCIDE',_utf8mb4'PENDIENTE',_utf8mb4'DIFERENCIA'))),
  CONSTRAINT `ckDetalleConciliacion2` CHECK ((`metodoDetalleConciliacion` in (_utf8mb4'AUTOMATICA',_utf8mb4'MANUAL'))),
  CONSTRAINT `ckDetalleConciliacion3` CHECK (((`Fk_MovimientoBancario_Codigo` is not null) or (`Fk_DetalleExtracto_Codigo` is not null)))
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbldetalleconciliacion`
--

LOCK TABLES `tbldetalleconciliacion` WRITE;
/*!40000 ALTER TABLE `tbldetalleconciliacion` DISABLE KEYS */;
INSERT INTO `tbldetalleconciliacion` VALUES (1,'COINCIDE','AUTOMATICA',0.0000,NULL,1,1,2,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(2,'COINCIDE','AUTOMATICA',0.0000,NULL,1,4,1,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(3,'DIFERENCIA','MANUAL',35.0000,'Comision bancaria que aun no esta registrada en libros',1,NULL,3,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(4,'COINCIDE','AUTOMATICA',0.0000,NULL,2,2,5,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(5,'COINCIDE','AUTOMATICA',0.0000,NULL,2,5,4,'2026-11-14 18:34:37','2026-11-14 18:34:37');
/*!40000 ALTER TABLE `tbldetalleconciliacion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbldetalledevolucioncompra`
--

DROP TABLE IF EXISTS `tbldetalledevolucioncompra`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbldetalledevolucioncompra` (
  `idDevolucionCompra` int NOT NULL,
  `ordenDetalleDevolucionCompra` int NOT NULL,
  `idProducto` int NOT NULL,
  `idBodega` int NOT NULL,
  `cantidadDetalleDevolucionCompra` decimal(12,4) NOT NULL,
  `costoUnitarioDetalleDevolucionCompra` decimal(12,4) NOT NULL,
  `descuentoPorcentajeDetalleDevolucionCompra` decimal(3,2) NOT NULL DEFAULT '0.00',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idDevolucionCompra`,`ordenDetalleDevolucionCompra`,`idProducto`),
  UNIQUE KEY `uqOrdenDetalleDevolucionCompra` (`idDevolucionCompra`,`ordenDetalleDevolucionCompra`),
  KEY `idxDetalleDevolucionCompraProducto` (`idProducto`),
  KEY `idxDetalleDevolucionCompraBodega` (`idBodega`),
  CONSTRAINT `Fk_DetalleDevolucionCompra_Bodega` FOREIGN KEY (`idBodega`) REFERENCES `tblbodega` (`idBodega`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `Fk_DetalleDevolucionCompra_Devolucion` FOREIGN KEY (`idDevolucionCompra`) REFERENCES `tbldevolucioncompra` (`idDevolucionCompra`),
  CONSTRAINT `Fk_DetalleDevolucionCompra_Producto` FOREIGN KEY (`idProducto`) REFERENCES `tblproducto` (`idProducto`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `ckCantidadDetalleDevolucionCompra` CHECK ((`cantidadDetalleDevolucionCompra` > 0)),
  CONSTRAINT `ckCostoDetalleDevolucionCompra` CHECK ((`costoUnitarioDetalleDevolucionCompra` >= 0)),
  CONSTRAINT `ckDescuentoDetalleDevolucionCompra` CHECK ((`descuentoPorcentajeDetalleDevolucionCompra` between 0 and 0.99)),
  CONSTRAINT `ckOrdenDetalleDevolucionCompra` CHECK ((`ordenDetalleDevolucionCompra` > 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbldetalledevolucioncompra`
--

LOCK TABLES `tbldetalledevolucioncompra` WRITE;
/*!40000 ALTER TABLE `tbldetalledevolucioncompra` DISABLE KEYS */;
INSERT INTO `tbldetalledevolucioncompra` VALUES (1,1,6,1,1.0000,10.0000,0.00,'2026-11-14 18:34:39','2026-11-14 18:34:39'),(2,1,7,1,1.0000,10.0000,0.00,'2026-11-14 18:34:39','2026-11-14 18:34:39'),(3,1,8,1,1.0000,10.0000,0.00,'2026-11-14 18:34:39','2026-11-14 18:34:39');
/*!40000 ALTER TABLE `tbldetalledevolucioncompra` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbldetalleextracto`
--

DROP TABLE IF EXISTS `tbldetalleextracto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbldetalleextracto` (
  `idDetalleExtracto` bigint NOT NULL AUTO_INCREMENT,
  `identificadorDetalleExtracto` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `referenciaDetalleExtracto` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `conceptoDetalleExtracto` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fechaOperacionDetalleExtracto` date NOT NULL,
  `fechaValorDetalleExtracto` date NOT NULL,
  `importeDetalleExtracto` decimal(12,4) NOT NULL,
  `sentidoDetalleExtracto` int NOT NULL,
  `Fk_ExtractoBancario_Codigo` bigint NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idDetalleExtracto`),
  UNIQUE KEY `uqDetalleExtracto1` (`Fk_ExtractoBancario_Codigo`,`identificadorDetalleExtracto`),
  CONSTRAINT `Fk_DetalleExtracto_Extracto` FOREIGN KEY (`Fk_ExtractoBancario_Codigo`) REFERENCES `tblextractobancario` (`Pk_ExtractoBancario`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `ckDetalleExtracto1` CHECK ((`importeDetalleExtracto` > 0)),
  CONSTRAINT `ckDetalleExtracto2` CHECK ((`sentidoDetalleExtracto` in (-(1),1)))
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbldetalleextracto`
--

LOCK TABLES `tbldetalleextracto` WRITE;
/*!40000 ALTER TABLE `tbldetalleextracto` DISABLE KEYS */;
INSERT INTO `tbldetalleextracto` VALUES (1,'BIND-20261102-001','DEP-88341','Deposito en efectivo','2026-11-02','2026-11-02',25000.0000,1,1,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(2,'BIND-20261105-002','CHQ-1001','Cheque pagado numero 1001','2026-11-05','2026-11-05',18450.0000,-1,1,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(3,'BIND-20261106-003','COM-1106','Comision por manejo de cuenta','2026-11-06','2026-11-06',35.0000,-1,1,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(4,'BRUR-20261104-001','DEP-20417','Credito por transferencia ACH','2026-11-04','2026-11-04',12300.0000,1,2,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(5,'BRUR-20261105-002','CHQ-5001','Cheque pagado numero 5001','2026-11-05','2026-11-05',7920.5000,-1,2,'2026-11-14 18:34:37','2026-11-14 18:34:37');
/*!40000 ALTER TABLE `tbldetalleextracto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbldetalleliquidacion`
--

DROP TABLE IF EXISTS `tbldetalleliquidacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbldetalleliquidacion` (
  `idDetalleLiquidacion` int NOT NULL AUTO_INCREMENT,
  `idLiquidacion` int NOT NULL,
  `idPercepcionDeduccion` int NOT NULL,
  `diasDetalleLiquidacion` decimal(8,2) NOT NULL DEFAULT '0.00',
  `baseDetalleLiquidacion` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `montoDetalleLiquidacion` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idDetalleLiquidacion`),
  UNIQUE KEY `uqDetalleLiquidacionConcepto` (`idLiquidacion`,`idPercepcionDeduccion`),
  KEY `Fk_DetalleLiquidacion_PercepcionDeduccion` (`idPercepcionDeduccion`),
  CONSTRAINT `Fk_DetalleLiquidacion_Liquidacion` FOREIGN KEY (`idLiquidacion`) REFERENCES `tblliquidacion` (`idLiquidacion`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Fk_DetalleLiquidacion_PercepcionDeduccion` FOREIGN KEY (`idPercepcionDeduccion`) REFERENCES `tblpercepciondeduccion` (`idPercepcionDeduccion`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `ckDetalleLiquidacionMonto` CHECK ((`montoDetalleLiquidacion` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbldetalleliquidacion`
--

LOCK TABLES `tbldetalleliquidacion` WRITE;
/*!40000 ALTER TABLE `tbldetalleliquidacion` DISABLE KEYS */;
INSERT INTO `tbldetalleliquidacion` VALUES (1,1,5,15.00,6500.0000,267.1233,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(2,2,4,1250.00,7200.0000,24657.5342,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(3,3,5,22.00,5800.0000,349.5890,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(4,4,5,28.00,6000.0000,460.2740,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(5,5,5,31.00,5500.0000,467.1233,'2026-11-14 18:34:38','2026-11-14 18:34:38');
/*!40000 ALTER TABLE `tbldetalleliquidacion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbldetallemovimiento`
--

DROP TABLE IF EXISTS `tbldetallemovimiento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbldetallemovimiento` (
  `idDetalleMovimiento` int NOT NULL AUTO_INCREMENT,
  `Fk_Movimiento_Inventario_Codigo` int NOT NULL,
  `Fk_Lote_Producto_Codigo` bigint DEFAULT NULL COMMENT 'Opcional cuando un producto aun no tiene lote',
  `Fk_Producto_Codigo` int NOT NULL,
  `cantidadDetalleMovimiento` int NOT NULL,
  `precioCostoDetalleMovimiento` decimal(12,4) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idDetalleMovimiento`),
  KEY `Fk_Detalle_Movimiento_Movimiento_Inventario` (`Fk_Movimiento_Inventario_Codigo`),
  KEY `Fk_Detalle_Movimiento_Producto` (`Fk_Producto_Codigo`),
  KEY `Fk_Detalle_Movimiento_Lote_Producto` (`Fk_Lote_Producto_Codigo`,`Fk_Producto_Codigo`),
  CONSTRAINT `Fk_Detalle_Movimiento_Lote_Producto` FOREIGN KEY (`Fk_Lote_Producto_Codigo`, `Fk_Producto_Codigo`) REFERENCES `tblloteproducto` (`idLoteProducto`, `Fk_Producto_Codigo`) ON DELETE RESTRICT,
  CONSTRAINT `Fk_Detalle_Movimiento_Movimiento_Inventario` FOREIGN KEY (`Fk_Movimiento_Inventario_Codigo`) REFERENCES `tblmovimientoinventario` (`idMovimientoInventario`) ON DELETE CASCADE,
  CONSTRAINT `Fk_Detalle_Movimiento_Producto` FOREIGN KEY (`Fk_Producto_Codigo`) REFERENCES `tblproducto` (`idProducto`) ON DELETE RESTRICT,
  CONSTRAINT `ckDetalleMovimientoCantidad` CHECK ((`cantidadDetalleMovimiento` > 0))
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbldetallemovimiento`
--

LOCK TABLES `tbldetallemovimiento` WRITE;
/*!40000 ALTER TABLE `tbldetallemovimiento` DISABLE KEYS */;
INSERT INTO `tbldetallemovimiento` VALUES (1,1,1,1,25,18.5000,'2026-11-14 18:34:39','2026-11-14 18:34:39'),(2,2,2,2,18,22.7500,'2026-11-14 18:34:39','2026-11-14 18:34:39'),(3,3,3,3,12,24.2000,'2026-11-14 18:34:39','2026-11-14 18:34:39'),(4,4,4,4,50,36.0000,'2026-11-14 18:34:39','2026-11-14 18:34:39'),(5,5,5,5,15,20.8000,'2026-11-14 18:34:39','2026-11-14 18:34:39');
/*!40000 ALTER TABLE `tbldetallemovimiento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbldetalleordencompra`
--

DROP TABLE IF EXISTS `tbldetalleordencompra`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbldetalleordencompra` (
  `idOrdenCompra` int NOT NULL,
  `ordenDetalleOrdenCompra` int NOT NULL,
  `idProducto` int NOT NULL,
  `idBodega` int NOT NULL,
  `cantidadDetalleOrdenCompra` decimal(12,4) NOT NULL,
  `costoUnitarioDetalleOrdenCompra` decimal(12,4) NOT NULL,
  `descuentoPorcentajeDetalleOrdenCompra` decimal(5,2) NOT NULL DEFAULT '0.00',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idOrdenCompra`,`ordenDetalleOrdenCompra`,`idProducto`),
  UNIQUE KEY `uqOrdenDetalleOrdenCompra` (`idOrdenCompra`,`ordenDetalleOrdenCompra`),
  KEY `idxDetalleOrdenCompraProducto` (`idProducto`),
  KEY `idxDetalleOrdenCompraBodega` (`idBodega`),
  CONSTRAINT `Fk_DetalleOrdenCompra_Bodega` FOREIGN KEY (`idBodega`) REFERENCES `tblbodega` (`idBodega`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `Fk_DetalleOrdenCompra_Encabezado` FOREIGN KEY (`idOrdenCompra`) REFERENCES `tblencabezadoordencompra` (`idOrdenCompra`),
  CONSTRAINT `Fk_DetalleOrdenCompra_Producto` FOREIGN KEY (`idProducto`) REFERENCES `tblproducto` (`idProducto`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `ckCantidadDetalleOrdenCompra` CHECK ((`cantidadDetalleOrdenCompra` > 0)),
  CONSTRAINT `ckCostoDetalleOrdenCompra` CHECK ((`costoUnitarioDetalleOrdenCompra` >= 0)),
  CONSTRAINT `ckDescPorcDetalleOrdenCompra` CHECK ((`descuentoPorcentajeDetalleOrdenCompra` between 0 and 100)),
  CONSTRAINT `ckOrdenDetalleOrdenCompra` CHECK ((`ordenDetalleOrdenCompra` > 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbldetalleordencompra`
--

LOCK TABLES `tbldetalleordencompra` WRITE;
/*!40000 ALTER TABLE `tbldetalleordencompra` DISABLE KEYS */;
INSERT INTO `tbldetalleordencompra` VALUES (1,1,6,1,10.0000,10.0000,0.00,'2026-11-14 18:34:39','2026-11-14 18:34:39'),(2,1,7,1,10.0000,10.0000,0.00,'2026-11-14 18:34:39','2026-11-14 18:34:39'),(3,1,8,1,10.0000,10.0000,0.00,'2026-11-14 18:34:39','2026-11-14 18:34:39');
/*!40000 ALTER TABLE `tbldetalleordencompra` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbldetallepagoproveedor`
--

DROP TABLE IF EXISTS `tbldetallepagoproveedor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbldetallepagoproveedor` (
  `idPagoProveedor` int NOT NULL,
  `serieDocumentoCuentaPorPagar` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `numeroDocumentoCuentaPorPagar` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `idConceptoProveedor` int NOT NULL,
  `montoAplicadoDetallePago` decimal(12,4) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idPagoProveedor`,`serieDocumentoCuentaPorPagar`,`numeroDocumentoCuentaPorPagar`,`idConceptoProveedor`),
  KEY `idxDetallePagoCuenta` (`serieDocumentoCuentaPorPagar`,`numeroDocumentoCuentaPorPagar`,`idConceptoProveedor`),
  CONSTRAINT `Fk_DetallePago_CuentaPorPagar` FOREIGN KEY (`serieDocumentoCuentaPorPagar`, `numeroDocumentoCuentaPorPagar`, `idConceptoProveedor`) REFERENCES `tblcuentaporpagar` (`serieDocumentoCuentaPorPagar`, `numeroDocumentoCuentaPorPagar`, `idConceptoProveedor`),
  CONSTRAINT `Fk_DetallePago_Encabezado` FOREIGN KEY (`idPagoProveedor`) REFERENCES `tblencabezadopagoproveedor` (`idPagoProveedor`),
  CONSTRAINT `ckMontoAplicadoDetallePago` CHECK ((`montoAplicadoDetallePago` > 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbldetallepagoproveedor`
--

LOCK TABLES `tbldetallepagoproveedor` WRITE;
/*!40000 ALTER TABLE `tbldetallepagoproveedor` DISABLE KEYS */;
INSERT INTO `tbldetallepagoproveedor` VALUES (1,'PR-0d2d5068e05a','1',11,20.0000,'2026-11-14 18:34:39','2026-11-14 18:34:39'),(2,'PR-0d2d5068e05a','2',11,20.0000,'2026-11-14 18:34:39','2026-11-14 18:34:39'),(3,'PR-0d2d5068e05a','3',11,20.0000,'2026-11-14 18:34:39','2026-11-14 18:34:39');
/*!40000 ALTER TABLE `tbldetallepagoproveedor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbldetallepartidaconsolidada`
--

DROP TABLE IF EXISTS `tbldetallepartidaconsolidada`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbldetallepartidaconsolidada` (
  `idDetallePartidaConsolidada` bigint NOT NULL AUTO_INCREMENT,
  `Fk_PartidaConsolidada_Codigo` bigint NOT NULL,
  `codigoCuentaContableDetallePartidaConsolidada` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nombreCuentaContableDetallePartidaConsolidada` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `debeDetallePartidaConsolidada` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `haberDetallePartidaConsolidada` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idDetallePartidaConsolidada`),
  UNIQUE KEY `uqDetallePartidaCuenta` (`Fk_PartidaConsolidada_Codigo`,`codigoCuentaContableDetallePartidaConsolidada`),
  CONSTRAINT `Fk_DetallePartidaConsolidada_Partida` FOREIGN KEY (`Fk_PartidaConsolidada_Codigo`) REFERENCES `tblpartidaconsolidada` (`Pk_PartidaConsolidada`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `ckDetallePartidaCuenta` CHECK (((char_length(trim(`codigoCuentaContableDetallePartidaConsolidada`)) > 0) and (char_length(trim(`nombreCuentaContableDetallePartidaConsolidada`)) > 0))),
  CONSTRAINT `ckDetallePartidaImportes` CHECK (((`debeDetallePartidaConsolidada` >= 0) and (`haberDetallePartidaConsolidada` >= 0) and ((`debeDetallePartidaConsolidada` > 0) or (`haberDetallePartidaConsolidada` > 0))))
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbldetallepartidaconsolidada`
--

LOCK TABLES `tbldetallepartidaconsolidada` WRITE;
/*!40000 ALTER TABLE `tbldetallepartidaconsolidada` DISABLE KEYS */;
INSERT INTO `tbldetallepartidaconsolidada` VALUES (1,1,'2.01.01.001','Proveedores locales',185400.0000,0.0000,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(2,1,'1.01.02.001','Bancos moneda nacional',0.0000,185400.0000,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(3,2,'2.01.01.001','Proveedores locales',232750.5000,0.0000,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(4,2,'1.01.02.001','Bancos moneda nacional',0.0000,232750.5000,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(5,3,'2.01.01.001','Proveedores locales',264300.0000,0.0000,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(6,3,'1.01.02.001','Bancos moneda nacional',0.0000,264300.0000,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(7,4,'2.01.01.001','Proveedores locales',9600.0000,0.0000,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(8,4,'1.01.02.003','Bancos moneda extranjera',0.0000,9600.0000,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(9,5,'1.01.02.001','Bancos moneda nacional (Industrial)',6550.0000,0.0000,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(10,5,'1.01.02.002','Bancos moneda nacional (Banrural)',4379.5000,0.0000,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(11,5,'2.01.01.001','Proveedores locales',26370.5000,0.0000,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(12,5,'2.01.02.001','Sueldos por pagar',4250.0000,0.0000,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(13,5,'1.01.02.004','Bancos moneda nacional (G&T nomina)',0.0000,4250.0000,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(14,5,'1.01.04.001','Clientes locales',0.0000,37300.0000,'2026-11-14 18:34:37','2026-11-14 18:34:37');
/*!40000 ALTER TABLE `tbldetallepartidaconsolidada` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbldetalleplanillarecibida`
--

DROP TABLE IF EXISTS `tbldetalleplanillarecibida`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbldetalleplanillarecibida` (
  `idDetallePlanillaRecibida` bigint NOT NULL AUTO_INCREMENT,
  `referenciaEmpleadoDetallePlanillaRecibida` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `beneficiarioDetallePlanillaRecibida` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `importeNetoDetallePlanillaRecibida` decimal(12,4) NOT NULL,
  `Fk_PlanillaRecibida_Codigo` bigint NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idDetallePlanillaRecibida`),
  UNIQUE KEY `uqDetallePlanillaRecibida1` (`Fk_PlanillaRecibida_Codigo`,`referenciaEmpleadoDetallePlanillaRecibida`),
  CONSTRAINT `Fk_DetallePlanillaRecibida_Planilla` FOREIGN KEY (`Fk_PlanillaRecibida_Codigo`) REFERENCES `tblplanillarecibida` (`Pk_PlanillaRecibida`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `ckDetallePlanillaRecibida1` CHECK ((`importeNetoDetallePlanillaRecibida` > 0))
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbldetalleplanillarecibida`
--

LOCK TABLES `tbldetalleplanillarecibida` WRITE;
/*!40000 ALTER TABLE `tbldetalleplanillarecibida` DISABLE KEYS */;
INSERT INTO `tbldetalleplanillarecibida` VALUES (1,'EMP-0101','Carlos Mendez Ruiz',4250.0000,5,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(2,'EMP-0102','Maria Fernanda Lopez Barrios',5120.0000,5,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(3,'EMP-0103','Jose Luis Ajanel Tzoc',3980.5000,5,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(4,'EMP-0104','Ana Lucia Castillo Perez',4675.0000,5,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(5,'EMP-0105','Roberto Giron Pineda',6010.0000,5,'2026-11-14 18:34:36','2026-11-14 18:34:36');
/*!40000 ALTER TABLE `tbldetalleplanillarecibida` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbldetallepolizabancaria`
--

DROP TABLE IF EXISTS `tbldetallepolizabancaria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbldetallepolizabancaria` (
  `idDetallePolizaBancaria` bigint NOT NULL AUTO_INCREMENT,
  `codigoCuentaContableDetallePolizaBancaria` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `debeDetallePolizaBancaria` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `haberDetallePolizaBancaria` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `Fk_PolizaBancaria_Codigo` bigint NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idDetallePolizaBancaria`),
  KEY `idxDetallePolizaBancariaPoliza` (`Fk_PolizaBancaria_Codigo`),
  CONSTRAINT `Fk_DetallePolizaBancaria_Poliza` FOREIGN KEY (`Fk_PolizaBancaria_Codigo`) REFERENCES `tblpolizabancaria` (`idPolizaBancaria`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `ckDetallePolizaBancaria1` CHECK ((((`debeDetallePolizaBancaria` > 0) and (`haberDetallePolizaBancaria` = 0)) or ((`haberDetallePolizaBancaria` > 0) and (`debeDetallePolizaBancaria` = 0))))
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbldetallepolizabancaria`
--

LOCK TABLES `tbldetallepolizabancaria` WRITE;
/*!40000 ALTER TABLE `tbldetallepolizabancaria` DISABLE KEYS */;
INSERT INTO `tbldetallepolizabancaria` VALUES (1,'2.01.01.001',18450.0000,0.0000,1,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(2,'1.01.02.001',0.0000,18450.0000,1,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(3,'2.01.01.001',7920.5000,0.0000,2,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(4,'1.01.02.002',0.0000,7920.5000,2,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(5,'2.01.02.001',4250.0000,0.0000,3,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(6,'1.01.02.004',0.0000,4250.0000,3,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(7,'1.01.02.001',25000.0000,0.0000,4,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(8,'1.01.04.001',0.0000,25000.0000,4,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(9,'1.01.02.002',12300.0000,0.0000,5,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(10,'1.01.04.001',0.0000,12300.0000,5,'2026-11-14 18:34:37','2026-11-14 18:34:37');
/*!40000 ALTER TABLE `tbldetallepolizabancaria` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbldetalletraslado`
--

DROP TABLE IF EXISTS `tbldetalletraslado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbldetalletraslado` (
  `idDetalleTraslado` int NOT NULL AUTO_INCREMENT,
  `Fk_Traslado_Codigo` int NOT NULL,
  `Fk_Producto_Codigo` int NOT NULL,
  `cantidadDetalleTraslado` int NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idDetalleTraslado`),
  UNIQUE KEY `uqDetalleTrasladoProducto` (`Fk_Traslado_Codigo`,`Fk_Producto_Codigo`),
  KEY `Fk_Detalle_Traslado_Producto` (`Fk_Producto_Codigo`),
  CONSTRAINT `Fk_Detalle_Traslado_Producto` FOREIGN KEY (`Fk_Producto_Codigo`) REFERENCES `tblproducto` (`idProducto`) ON DELETE RESTRICT,
  CONSTRAINT `Fk_Detalle_Traslado_Traslado` FOREIGN KEY (`Fk_Traslado_Codigo`) REFERENCES `tbltraslado` (`idTraslado`) ON DELETE CASCADE,
  CONSTRAINT `ckDetalleTrasladoCantidad` CHECK ((`cantidadDetalleTraslado` > 0))
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbldetalletraslado`
--

LOCK TABLES `tbldetalletraslado` WRITE;
/*!40000 ALTER TABLE `tbldetalletraslado` DISABLE KEYS */;
INSERT INTO `tbldetalletraslado` VALUES (1,1,1,25,'2026-11-14 18:34:39','2026-11-14 18:34:39'),(2,2,2,18,'2026-11-14 18:34:39','2026-11-14 18:34:39'),(3,3,3,12,'2026-11-14 18:34:39','2026-11-14 18:34:39'),(4,4,4,30,'2026-11-14 18:34:39','2026-11-14 18:34:39'),(5,5,5,15,'2026-11-14 18:34:39','2026-11-14 18:34:39');
/*!40000 ALTER TABLE `tbldetalletraslado` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbldetalleviaje`
--

DROP TABLE IF EXISTS `tbldetalleviaje`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbldetalleviaje` (
  `idDetalleViaje` bigint NOT NULL AUTO_INCREMENT,
  `Fk_Encabezado_Viaje_Codigo` bigint NOT NULL,
  `ordenDetalleViaje` int NOT NULL,
  `descripcionDetalleViaje` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `cantidadDetalleViaje` decimal(18,3) NOT NULL,
  `pesoDetalleViaje` decimal(18,3) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idDetalleViaje`),
  UNIQUE KEY `uqOrdenDetalleViaje` (`Fk_Encabezado_Viaje_Codigo`,`ordenDetalleViaje`),
  CONSTRAINT `Fk_Detalle_Viaje_Encabezado_Viaje` FOREIGN KEY (`Fk_Encabezado_Viaje_Codigo`) REFERENCES `tblencabezadoviaje` (`idEncabezadoViaje`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbldetalleviaje`
--

LOCK TABLES `tbldetalleviaje` WRITE;
/*!40000 ALTER TABLE `tbldetalleviaje` DISABLE KEYS */;
INSERT INTO `tbldetalleviaje` VALUES (1,1,1,'Despacho de salchichas refrigeradas a sucursal de Mixco',1700.000,850.000,'2026-11-14 18:34:39','2026-11-14 18:34:39'),(2,2,1,'Entrega de chorizo parrillero a sucursal de Villa Nueva',2044.000,920.000,'2026-11-14 18:34:39','2026-11-14 18:34:39'),(3,3,1,'Envío de jamón de pierna a sucursal de Quetzaltenango',2100.000,735.000,'2026-11-14 18:34:39','2026-11-14 18:34:39'),(4,4,1,'Distribución de mortadela familiar hacia Escuintla',480.000,480.000,'2026-11-14 18:34:39','2026-11-14 18:34:39'),(5,5,1,'Traslado de tocino ahumado a centro de distribución',4800.000,1200.000,'2026-11-14 18:34:39','2026-11-14 18:34:39');
/*!40000 ALTER TABLE `tbldetalleviaje` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbldetalleviajeloteproducto`
--

DROP TABLE IF EXISTS `tbldetalleviajeloteproducto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbldetalleviajeloteproducto` (
  `idDetalleViajeLoteProducto` bigint NOT NULL AUTO_INCREMENT,
  `Fk_Detalle_Viaje_Codigo` bigint NOT NULL,
  `Fk_Lote_Producto_Codigo` bigint NOT NULL,
  `cantidadCajasDetalleViajeLoteProducto` int NOT NULL,
  `pesoKgDetalleViajeLoteProducto` decimal(18,3) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idDetalleViajeLoteProducto`),
  UNIQUE KEY `uqDetalleViajeLoteProducto` (`Fk_Detalle_Viaje_Codigo`,`Fk_Lote_Producto_Codigo`),
  KEY `idxIdLoteProductoDetalleViajeLoteProducto` (`Fk_Lote_Producto_Codigo`),
  CONSTRAINT `Fk_Detalle_Viaje_Lote_Producto_Detalle_Viaje` FOREIGN KEY (`Fk_Detalle_Viaje_Codigo`) REFERENCES `tbldetalleviaje` (`idDetalleViaje`) ON DELETE CASCADE,
  CONSTRAINT `Fk_Detalle_Viaje_Lote_Producto_Lote_Producto` FOREIGN KEY (`Fk_Lote_Producto_Codigo`) REFERENCES `tblloteproducto` (`idLoteProducto`) ON DELETE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbldetalleviajeloteproducto`
--

LOCK TABLES `tbldetalleviajeloteproducto` WRITE;
/*!40000 ALTER TABLE `tbldetalleviajeloteproducto` DISABLE KEYS */;
INSERT INTO `tbldetalleviajeloteproducto` VALUES (1,1,1,85,850.000,'2026-11-14 18:34:39','2026-11-14 18:34:39'),(2,2,2,92,920.000,'2026-11-14 18:34:39','2026-11-14 18:34:39'),(3,3,3,70,735.000,'2026-11-14 18:34:39','2026-11-14 18:34:39'),(4,4,4,48,480.000,'2026-11-14 18:34:39','2026-11-14 18:34:39'),(5,5,5,120,1200.000,'2026-11-14 18:34:39','2026-11-14 18:34:39');
/*!40000 ALTER TABLE `tbldetalleviajeloteproducto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbldevolucioncompra`
--

DROP TABLE IF EXISTS `tbldevolucioncompra`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbldevolucioncompra` (
  `idDevolucionCompra` int NOT NULL AUTO_INCREMENT,
  `idCompra` int NOT NULL,
  `fechaDevolucionCompra` date NOT NULL,
  `motivoDevolucionCompra` varchar(500) COLLATE utf8mb4_unicode_ci NOT NULL,
  `serieNotaCreditoDevolucionCompra` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `numeroNotaCreditoDevolucionCompra` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `totalDevolucionCompra` decimal(12,4) NOT NULL,
  `estadoDevolucionCompra` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Registrada',
  `bloqueadoDevolucionCompra` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idDevolucionCompra`),
  UNIQUE KEY `uqNotaCreditoDevolucionCompra` (`idCompra`,`serieNotaCreditoDevolucionCompra`,`numeroNotaCreditoDevolucionCompra`),
  KEY `idxDevolucionCompraCompra` (`idCompra`),
  CONSTRAINT `Fk_DevolucionCompra_Compra` FOREIGN KEY (`idCompra`) REFERENCES `tblencabezadocompra` (`idCompra`),
  CONSTRAINT `ckEstadoDevolucionCompra` CHECK ((`estadoDevolucionCompra` in (_utf8mb4'Registrada',_utf8mb4'Anulada'))),
  CONSTRAINT `ckTotalDevolucionCompra` CHECK ((`totalDevolucionCompra` > 0))
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbldevolucioncompra`
--

LOCK TABLES `tbldevolucioncompra` WRITE;
/*!40000 ALTER TABLE `tbldevolucioncompra` DISABLE KEYS */;
INSERT INTO `tbldevolucioncompra` VALUES (1,1,'2026-11-14','Ejemplo anulado sin efecto en saldo ni inventario',NULL,NULL,10.0000,'Anulada',0,'2026-11-14 18:34:39','2026-11-14 18:34:39'),(2,2,'2026-11-14','Ejemplo anulado sin efecto en saldo ni inventario',NULL,NULL,10.0000,'Anulada',0,'2026-11-14 18:34:39','2026-11-14 18:34:39'),(3,3,'2026-11-14','Ejemplo anulado sin efecto en saldo ni inventario',NULL,NULL,10.0000,'Anulada',0,'2026-11-14 18:34:39','2026-11-14 18:34:39'),(4,3,'2026-11-14','Ejemplo anulado sin efecto en saldo ni inventario',NULL,NULL,10.0000,'Anulada',0,'2026-11-14 18:34:39','2026-11-14 18:34:39'),(5,3,'2026-11-14','Ejemplo anulado sin efecto en saldo ni inventario',NULL,NULL,10.0000,'Anulada',0,'2026-11-14 18:34:39','2026-11-14 18:34:39');
/*!40000 ALTER TABLE `tbldevolucioncompra` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbldisponibilidaddiaria`
--

DROP TABLE IF EXISTS `tbldisponibilidaddiaria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbldisponibilidaddiaria` (
  `idDisponibilidadDiaria` bigint NOT NULL AUTO_INCREMENT,
  `fechaDisponibilidadDiaria` date NOT NULL,
  `saldoInicialDisponibilidadDiaria` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `ingresosDisponibilidadDiaria` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `egresosDisponibilidadDiaria` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `comprometidoDisponibilidadDiaria` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `restringidoDisponibilidadDiaria` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `saldoDisponibleDisponibilidadDiaria` decimal(12,4) NOT NULL,
  `saldoDisponibleGTQDisponibilidadDiaria` decimal(12,4) NOT NULL,
  `tipoCambioAplicadoDisponibilidadDiaria` decimal(12,4) NOT NULL DEFAULT '1.0000',
  `fuenteDisponibilidadDiaria` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fechaGeneracionDisponibilidadDiaria` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Fk_CuentaBancaria_Codigo` bigint NOT NULL,
  `Fk_TipoCambio_Codigo` bigint DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `versionDisponibilidadDiaria` bigint NOT NULL DEFAULT '1',
  PRIMARY KEY (`idDisponibilidadDiaria`),
  UNIQUE KEY `uqDisponibilidadDiaria1` (`Fk_CuentaBancaria_Codigo`,`fechaDisponibilidadDiaria`),
  KEY `idxDisponibilidadDiariaTipoCambio` (`Fk_TipoCambio_Codigo`),
  CONSTRAINT `Fk_DisponibilidadDiaria_Cuenta` FOREIGN KEY (`Fk_CuentaBancaria_Codigo`) REFERENCES `tblcuentabancaria` (`idCuentaBancaria`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `Fk_DisponibilidadDiaria_TipoCambio` FOREIGN KEY (`Fk_TipoCambio_Codigo`) REFERENCES `tbltipocambio` (`idTipoCambio`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `ckDisponibilidadDiaria1` CHECK ((`saldoInicialDisponibilidadDiaria` >= 0)),
  CONSTRAINT `ckDisponibilidadDiaria2` CHECK (((`ingresosDisponibilidadDiaria` >= 0) and (`egresosDisponibilidadDiaria` >= 0) and (`comprometidoDisponibilidadDiaria` >= 0))),
  CONSTRAINT `ckDisponibilidadDiaria3` CHECK ((`tipoCambioAplicadoDisponibilidadDiaria` > 0)),
  CONSTRAINT `ckDisponibilidadDiaria4` CHECK ((`restringidoDisponibilidadDiaria` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbldisponibilidaddiaria`
--

LOCK TABLES `tbldisponibilidaddiaria` WRITE;
/*!40000 ALTER TABLE `tbldisponibilidaddiaria` DISABLE KEYS */;
INSERT INTO `tbldisponibilidaddiaria` VALUES (1,'2026-11-06',126550.0000,0.0000,0.0000,41300.0000,0.0000,85250.0000,85250.0000,1.0000,'Cierre bancario diario','2026-11-14 12:34:36',1,NULL,'2026-11-14 18:34:36','2026-11-14 18:34:36',1),(2,'2026-11-06',64379.5000,0.0000,0.0000,0.0000,0.0000,64379.5000,64379.5000,1.0000,'Cierre bancario diario','2026-11-14 12:34:36',2,NULL,'2026-11-14 18:34:36','2026-11-14 18:34:36',1),(3,'2026-11-06',18000.0000,0.0000,0.0000,3200.0000,0.0000,14800.0000,114747.3600,7.7532,'Cierre bancario diario','2026-11-14 12:34:36',3,3,'2026-11-14 18:34:36','2026-11-14 18:34:36',1),(4,'2026-11-06',80750.0000,0.0000,0.0000,0.0000,0.0000,80750.0000,80750.0000,1.0000,'Cierre bancario diario','2026-11-14 12:34:36',4,NULL,'2026-11-14 18:34:36','2026-11-14 18:34:36',1),(5,'2026-11-06',250000.0000,0.0000,0.0000,0.0000,0.0000,250000.0000,250000.0000,1.0000,'Cierre bancario diario','2026-11-14 12:34:36',5,NULL,'2026-11-14 18:34:36','2026-11-14 18:34:36',1);
/*!40000 ALTER TABLE `tbldisponibilidaddiaria` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbldisponibilidaddiariahistorial`
--

DROP TABLE IF EXISTS `tbldisponibilidaddiariahistorial`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbldisponibilidaddiariahistorial` (
  `idDisponibilidadDiariaHistorial` bigint NOT NULL AUTO_INCREMENT,
  `Fk_DisponibilidadDiaria` bigint NOT NULL,
  `Fk_CuentaBancaria` bigint NOT NULL,
  `fechaCorte` date NOT NULL,
  `accion` varchar(12) COLLATE utf8mb4_unicode_ci NOT NULL,
  `versionAnterior` bigint DEFAULT NULL,
  `versionNueva` bigint NOT NULL,
  `usuarioId` int DEFAULT NULL,
  `usuarioNombre` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fechaOperacion` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `monedaAnterior` char(3) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `monedaNueva` char(3) COLLATE utf8mb4_unicode_ci NOT NULL,
  `saldoInicialAnterior` decimal(12,4) DEFAULT NULL,
  `ingresosAnterior` decimal(12,4) DEFAULT NULL,
  `egresosAnterior` decimal(12,4) DEFAULT NULL,
  `comprometidoAnterior` decimal(12,4) DEFAULT NULL,
  `restringidoAnterior` decimal(12,4) DEFAULT NULL,
  `tasaAnterior` decimal(12,4) DEFAULT NULL,
  `fuenteAnterior` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `saldoInicialNuevo` decimal(12,4) NOT NULL,
  `ingresosNuevo` decimal(12,4) NOT NULL,
  `egresosNuevo` decimal(12,4) NOT NULL,
  `comprometidoNuevo` decimal(12,4) NOT NULL,
  `restringidoNuevo` decimal(12,4) NOT NULL,
  `tasaNueva` decimal(12,4) NOT NULL,
  `fuenteNueva` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`idDisponibilidadDiariaHistorial`),
  UNIQUE KEY `uqDisponibilidadHistorialVersion` (`Fk_DisponibilidadDiaria`,`versionNueva`),
  KEY `ixDisponibilidadHistorialCuentaFecha` (`Fk_CuentaBancaria`,`fechaCorte`,`fechaOperacion`),
  CONSTRAINT `fkDisponibilidadHistorialCorte` FOREIGN KEY (`Fk_DisponibilidadDiaria`) REFERENCES `tbldisponibilidaddiaria` (`idDisponibilidadDiaria`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbldisponibilidaddiariahistorial`
--

LOCK TABLES `tbldisponibilidaddiariahistorial` WRITE;
/*!40000 ALTER TABLE `tbldisponibilidaddiariahistorial` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbldisponibilidaddiariahistorial` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblempleado`
--

DROP TABLE IF EXISTS `tblempleado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblempleado` (
  `idEmpleado` int NOT NULL AUTO_INCREMENT,
  `codigoEmpleado` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `dpiEmpleado` char(13) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `nitEmpleado` char(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `nombresEmpleado` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `apellidosEmpleado` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `idDepartamento` int NOT NULL,
  `idJornada` int NOT NULL,
  `salarioEmpleado` decimal(12,4) NOT NULL,
  `generoEmpleado` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'M = Masculino, F = Femenino',
  `fechaNacimientoEmpleado` date NOT NULL,
  `fechaContratacionEmpleado` date NOT NULL,
  `telefonoEmpleado` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `correoEmpleado` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idEmpleado`),
  UNIQUE KEY `uqCodigoEmpleado` (`codigoEmpleado`),
  UNIQUE KEY `uqDpiEmpleado` (`dpiEmpleado`),
  UNIQUE KEY `uqNitEmpleado` (`nitEmpleado`),
  UNIQUE KEY `uqCorreoEmpleado` (`correoEmpleado`),
  KEY `Fk_Empleado_Departamento` (`idDepartamento`),
  KEY `Fk_Empleado_Jornada` (`idJornada`),
  CONSTRAINT `Fk_Empleado_Departamento` FOREIGN KEY (`idDepartamento`) REFERENCES `tbldepartamento` (`idDepartamento`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `Fk_Empleado_Jornada` FOREIGN KEY (`idJornada`) REFERENCES `tbljornada` (`idJornada`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblempleado`
--

LOCK TABLES `tblempleado` WRITE;
/*!40000 ALTER TABLE `tblempleado` DISABLE KEYS */;
INSERT INTO `tblempleado` VALUES (1,'EMP-001','1234567890123','1234567-K','Isabel','Meléndez',1,1,7500.0000,'F','2000-05-14','2026-01-10','55512345','isabel@gmail.com',1,'2026-09-17 20:07:07','2026-11-14 18:34:38'),(2,'EMP-002','2345678901234','2345678K','Carlos','Ramírez',1,1,0.0000,'M','1998-03-22','2025-11-05','55523456','carlos.ramirez@terminus.com',1,'2026-09-17 20:07:07','2026-11-14 18:33:55'),(3,'EMP-003','3456789012345','3456789K','María','López',1,1,7500.0000,'F','1995-09-30','2025-08-19','55534567','maria.lopez@terminus.com',1,'2026-09-17 20:07:07','2026-11-14 18:34:38'),(13,'EMP-006','8463778648763','3727836-7','Oscar Emilio','Morales Lemus',2,1,7500.0000,'M','2005-05-28','2026-09-21','32323232','oscaremilio@gmail.com',1,'2026-09-22 10:30:17','2026-11-14 18:34:38'),(14,'EMP-007','5463212315453','5454542-1','Empleado','Examen',1,1,0.0000,'F','1990-09-22','2026-09-22','87897654','prueba@gmail.com',1,'2026-09-22 19:11:30','2026-11-14 18:33:55'),(19,'EMP-010','9876543219876','9876543-2','Pruebas','Capacitacion',1,1,0.0000,'M','1990-01-01','2026-01-10','12345678','terminus.seguridad22026@gmail.com',1,'2026-09-24 05:42:57','2026-11-14 18:33:55'),(20,'EMP-011','2456123400101','4455667-1','Ana Lucía','Pérez Gómez',3,1,6500.0000,'F','1996-04-12','2024-03-01','55501111','ana.perez@terminus.com',1,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(21,'EMP-012','2987456120101','5566778-2','Luis Fernando','Castillo Ruiz',4,1,7200.0000,'M','1992-08-25','2023-07-17','55502222','luis.castillo@terminus.com',1,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(22,'EMP-013','3012456780101','6677889-3','Sofía Alejandra','Morales Díaz',5,1,5800.0000,'F','1999-01-30','2025-02-03','55503333','sofia.morales@terminus.com',1,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(23,'EMP-014','1987456320101','7788990-4','Jorge Mario','Hernández Soto',6,1,6000.0000,'M','1994-11-09','2022-11-14','55504444','jorge.hernandez@terminus.com',1,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(24,'EMP-015','2234567890101','8899001-5','Karla Beatriz','Ortiz Méndez',7,5,5500.0000,'F','2000-06-18','2025-06-02','55505555','karla.ortiz@terminus.com',1,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(25,'EMP-016','0000000000001','1234567-8','Modulo ','RRHH',3,5,0.0000,'M','1996-04-12','2024-03-01','55500001','recursoshumanos.terminus@gmail.com',1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(26,'EMP-017','0000000000002','4589216-3','Modulo ','Bancos',8,5,0.0000,'M','1992-08-25','2023-07-17','55500002','terminus.bancoserp22026@gmail.com',1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(27,'EMP-018','0000000000003','7823451-9','Modulo ','Ventas',6,5,0.0000,'M','1999-01-30','2025-02-03','55500003','terminus.ventas22026@gmail.com',1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(28,'EMP-019','0000000000004','6158392-4','Modulo',' Compras',9,5,0.0000,'M','1994-11-09','2022-11-14','55500004',' terminus.compras2206@gmail.com',1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(29,'EMP-020','0000000000005','2947618-2','Modulo ','Logistica',7,5,0.0000,'M','2000-06-18','2025-06-02','55500005','terminus.logistica@gmail.com',1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(30,'EMP-021','0000000000006','9361527-5','Modulo ','Contabilidad',4,5,0.0000,'M','2000-06-18','2025-06-02','55500006','terminus.conta22026@gmail.com',1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(31,'EMP-022','0000000000007','9361034-6','risko ','Auditoria',5,5,0.0000,'M','2000-06-18','2025-06-02','55500007','risko22026@gmail.com',1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(32,'EMP-023','1236547895215','2659872-5','UsuarioFinal','Final',3,3,3000.0000,'M','2005-07-18','2026-11-24','15487526','UsuF@miumg.edu.gt',1,'2026-11-24 06:00:00','2026-11-24 06:00:00');
/*!40000 ALTER TABLE `tblempleado` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblempleadometodopago`
--

DROP TABLE IF EXISTS `tblempleadometodopago`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblempleadometodopago` (
  `idEmpleado` int NOT NULL,
  `idMetodoPago` int NOT NULL,
  `fechaAsignacionEmpleadoMetodoPago` date NOT NULL,
  `montoEmpleadoMetodoPago` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idEmpleado`,`idMetodoPago`),
  KEY `Fk_EmpleadoMetodoPago_MetodoPago` (`idMetodoPago`),
  CONSTRAINT `Fk_EmpleadoMetodoPago_Empleado` FOREIGN KEY (`idEmpleado`) REFERENCES `tblempleado` (`idEmpleado`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Fk_EmpleadoMetodoPago_MetodoPago` FOREIGN KEY (`idMetodoPago`) REFERENCES `tblmetodopago` (`idMetodoPago`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblempleadometodopago`
--

LOCK TABLES `tblempleadometodopago` WRITE;
/*!40000 ALTER TABLE `tblempleadometodopago` DISABLE KEYS */;
INSERT INTO `tblempleadometodopago` VALUES (20,2,'2024-03-01',6500.0000,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(21,4,'2023-07-17',7200.0000,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(22,5,'2025-02-03',5800.0000,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(23,2,'2022-11-14',6000.0000,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(24,1,'2025-06-02',5500.0000,'2026-11-14 18:34:37','2026-11-14 18:34:37');
/*!40000 ALTER TABLE `tblempleadometodopago` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblempresa`
--

DROP TABLE IF EXISTS `tblempresa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblempresa` (
  `idEmpresa` int NOT NULL AUTO_INCREMENT,
  `nitEmpresa` char(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `razonSocialEmpresa` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nombreComercialEmpresa` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `direccionEmpresa` varchar(500) COLLATE utf8mb4_unicode_ci NOT NULL,
  `representanteLegalEmpresa` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idEmpresa`),
  UNIQUE KEY `uqNitEmpresa` (`nitEmpresa`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblempresa`
--

LOCK TABLES `tblempresa` WRITE;
/*!40000 ALTER TABLE `tblempresa` DISABLE KEYS */;
INSERT INTO `tblempresa` VALUES (1,'1234567-8','Embutidos Terminus, S.A.','Terminus Embutidos','5a. Avenida 10-20 Zona 12, Ciudad de Guatemala','Roberto Alejandro Estrada Paz',1,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(2,'2345678-9','Distribuidora Don Carlos, S.A.','Don Carlos','12 Calle 3-45 Zona 1, Quetzaltenango','Carlos Enrique Díaz Ruiz',1,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(3,'3456789-0','Carnes y Embutidos del Norte, S.A.',NULL,'Avenida Las Américas 7-88 Zona 14, Guatemala','Marta Lucía Ordóñez Vela',1,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(4,'4567890-1','Industrias Cárnicas La Antigua, S.A.','La Antigua','3a. Calle Poniente 15, Antigua Guatemala','Hugo René Chávez Lara',1,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(5,'5678901-2','Comercial Embutidos del Sur, S.A.',NULL,'Km 28 Ruta al Pacífico, Palín, Escuintla','Silvia Marina Cabrera Gómez',1,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(6,'25103','Embutidos de Calidad, S.A.','Embutidos de Calidad','3a. Avenida 9-00 zona 2 Interior Finca El Zapote','Representante ficticio de auditoría',1,'2026-11-14 18:34:40','2026-11-14 18:34:40');
/*!40000 ALTER TABLE `tblempresa` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblempresatransportista`
--

DROP TABLE IF EXISTS `tblempresatransportista`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblempresatransportista` (
  `idEmpresaTransportista` int NOT NULL AUTO_INCREMENT,
  `nombreEmpresaTransportista` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `contactoEmpresaTransportista` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `telefonoEmpresaTransportista` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `nitEmpresaTransportista` char(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `direccionEmpresaTransportista` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `estadoEmpresaTransportista` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idEmpresaTransportista`),
  UNIQUE KEY `uqEmpresaTransportistaNombre` (`nombreEmpresaTransportista`),
  UNIQUE KEY `uqNitEmpresaTransportista` (`nitEmpresaTransportista`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblempresatransportista`
--

LOCK TABLES `tblempresatransportista` WRITE;
/*!40000 ALTER TABLE `tblempresatransportista` DISABLE KEYS */;
INSERT INTO `tblempresatransportista` VALUES (1,'Transporte Refrigerado del Altiplano, S.A.','María Fernanda Solís','+502 2234-7812','7246815-3','Calzada Roosevelt 15-42, zona 11, Ciudad de Guatemala',1,'2026-11-14 18:34:39','2026-11-14 18:34:39'),(2,'Logística del Pacífico, S.A.','Carlos Alberto Rivera','+502 2478-3605','6382504-1','Km 32.5, carretera al Pacífico, Amatitlán, Guatemala',1,'2026-11-14 18:34:39','2026-11-14 18:34:39'),(3,'Distribuciones La Ceiba, S.A.','Andrea Lucía Méndez','+502 7765-2098','5827431-9','4a avenida 6-18, zona 3, Quetzaltenango',1,'2026-11-14 18:34:39','2026-11-14 18:34:39'),(4,'Carga Fría del Sur, S.A.','José Roberto Aguilar','+502 7889-1436','4109637-2','3a calle 2-60, zona 1, Escuintla',1,'2026-11-14 18:34:39','2026-11-14 18:34:39'),(5,'Transportes Valle Verde, S.A.','Paola Gabriela Morales','+502 2431-8706','9671240-5','10a avenida 17-25, zona 10, Ciudad de Guatemala',1,'2026-11-14 18:34:39','2026-11-14 18:34:39');
/*!40000 ALTER TABLE `tblempresatransportista` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblencabezadocompra`
--

DROP TABLE IF EXISTS `tblencabezadocompra`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblencabezadocompra` (
  `idCompra` int NOT NULL AUTO_INCREMENT,
  `idOrdenCompra` int DEFAULT NULL,
  `idProveedor` int NOT NULL,
  `serieFacturaCompra` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `numeroFacturaCompra` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fechaCompra` date NOT NULL,
  `idMetodoPago` int NOT NULL,
  `idMoneda` bigint NOT NULL,
  `idTipoCambio` bigint DEFAULT NULL,
  `tipoCambioCompra` decimal(12,6) NOT NULL DEFAULT '1.000000',
  `subtotalCompra` decimal(12,4) NOT NULL,
  `descuentoCompra` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `impuestoCompra` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `totalCompra` decimal(12,4) NOT NULL,
  `estadoCompra` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Registrada',
  `bloqueadoCompra` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idCompra`),
  UNIQUE KEY `uqFacturaProveedorCompra` (`idProveedor`,`serieFacturaCompra`,`numeroFacturaCompra`),
  KEY `idxCompraOrden` (`idOrdenCompra`),
  KEY `idxCompraProveedor` (`idProveedor`),
  KEY `Fk_EncabezadoCompra_MetodoPago` (`idMetodoPago`),
  KEY `idxCompraMoneda` (`idMoneda`),
  KEY `idxCompraTipoCambio` (`idTipoCambio`),
  CONSTRAINT `Fk_EncabezadoCompra_EncabezadoOrdenCompra` FOREIGN KEY (`idOrdenCompra`) REFERENCES `tblencabezadoordencompra` (`idOrdenCompra`),
  CONSTRAINT `Fk_EncabezadoCompra_MetodoPago` FOREIGN KEY (`idMetodoPago`) REFERENCES `tblmetodopago` (`idMetodoPago`),
  CONSTRAINT `Fk_EncabezadoCompra_Moneda` FOREIGN KEY (`idMoneda`) REFERENCES `tblmoneda` (`idMoneda`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `Fk_EncabezadoCompra_Proveedor` FOREIGN KEY (`idProveedor`) REFERENCES `tblproveedor` (`idProveedor`),
  CONSTRAINT `Fk_EncabezadoCompra_TipoCambio` FOREIGN KEY (`idTipoCambio`) REFERENCES `tbltipocambio` (`idTipoCambio`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `ckDescuentoCompra` CHECK ((`descuentoCompra` >= 0)),
  CONSTRAINT `ckEstadoCompra` CHECK ((`estadoCompra` in (_utf8mb4'Registrada',_utf8mb4'Anulada'))),
  CONSTRAINT `ckImportesCompra` CHECK (((`descuentoCompra` <= `subtotalCompra`) and (`totalCompra` = ((`subtotalCompra` - `descuentoCompra`) + `impuestoCompra`)))),
  CONSTRAINT `ckImpuestoCompra` CHECK ((`impuestoCompra` >= 0)),
  CONSTRAINT `ckReferenciaTipoCambioCompra` CHECK (((`idTipoCambio` is not null) or (`tipoCambioCompra` = 1))),
  CONSTRAINT `ckSubtotalCompra` CHECK ((`subtotalCompra` >= 0)),
  CONSTRAINT `ckTipoCambioCompra` CHECK ((`tipoCambioCompra` > 0)),
  CONSTRAINT `ckTotalCompra` CHECK ((`totalCompra` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblencabezadocompra`
--

LOCK TABLES `tblencabezadocompra` WRITE;
/*!40000 ALTER TABLE `tblencabezadocompra` DISABLE KEYS */;
INSERT INTO `tblencabezadocompra` VALUES (1,1,13,'PR-0d2d5068e05a','1','2026-11-14',1,1,NULL,1.000000,100.0000,0.0000,0.0000,100.0000,'Registrada',0,'2026-11-14 18:34:39','2026-11-14 18:34:39'),(2,2,14,'PR-0d2d5068e05a','2','2026-11-14',1,1,NULL,1.000000,100.0000,0.0000,0.0000,100.0000,'Registrada',0,'2026-11-14 18:34:39','2026-11-14 18:34:39'),(3,3,15,'PR-0d2d5068e05a','3','2026-11-14',1,1,NULL,1.000000,100.0000,0.0000,0.0000,100.0000,'Registrada',0,'2026-11-14 18:34:39','2026-11-14 18:34:39'),(4,4,16,'PR-0d2d5068e05a','4','2026-11-14',1,1,NULL,1.000000,0.0000,0.0000,0.0000,0.0000,'Anulada',0,'2026-11-14 18:34:39','2026-11-14 18:34:39'),(5,5,17,'PR-0d2d5068e05a','5','2026-11-14',1,1,NULL,1.000000,0.0000,0.0000,0.0000,0.0000,'Anulada',0,'2026-11-14 18:34:39','2026-11-14 18:34:39');
/*!40000 ALTER TABLE `tblencabezadocompra` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblencabezadoordencompra`
--

DROP TABLE IF EXISTS `tblencabezadoordencompra`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblencabezadoordencompra` (
  `idOrdenCompra` int NOT NULL AUTO_INCREMENT,
  `idProveedor` int NOT NULL,
  `idPlazo` int NOT NULL,
  `fechaEmisionOrdenCompra` date NOT NULL,
  `fechaVencimientoOrdenCompra` date NOT NULL,
  `idMoneda` bigint NOT NULL,
  `idTipoCambio` bigint DEFAULT NULL,
  `tipoCambioOrdenCompra` decimal(12,6) NOT NULL DEFAULT '1.000000',
  `subtotalOrdenCompra` decimal(12,4) NOT NULL,
  `descuentoOrdenCompra` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `impuestoOrdenCompra` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `totalOrdenCompra` decimal(12,4) NOT NULL,
  `comentarioOrdenCompra` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `estadoOrdenCompra` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Pendiente',
  `bloqueadoOrdenCompra` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idOrdenCompra`),
  KEY `Fk_EncabezadoOrdenCompra_Plazo` (`idPlazo`),
  KEY `idxOrdenCompraProveedor` (`idProveedor`),
  KEY `idxOrdenCompraFecha` (`fechaEmisionOrdenCompra`),
  KEY `idxOrdenCompraMoneda` (`idMoneda`),
  KEY `idxOrdenCompraTipoCambio` (`idTipoCambio`),
  CONSTRAINT `Fk_EncabezadoOrdenCompra_Moneda` FOREIGN KEY (`idMoneda`) REFERENCES `tblmoneda` (`idMoneda`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `Fk_EncabezadoOrdenCompra_Plazo` FOREIGN KEY (`idPlazo`) REFERENCES `tblplazo` (`idPlazo`),
  CONSTRAINT `Fk_EncabezadoOrdenCompra_Proveedor` FOREIGN KEY (`idProveedor`) REFERENCES `tblproveedor` (`idProveedor`),
  CONSTRAINT `Fk_EncabezadoOrdenCompra_TipoCambio` FOREIGN KEY (`idTipoCambio`) REFERENCES `tbltipocambio` (`idTipoCambio`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `ckDescuentoOrdenCompra` CHECK ((`descuentoOrdenCompra` >= 0)),
  CONSTRAINT `ckEstadoOrdenCompra` CHECK ((`estadoOrdenCompra` in (_utf8mb4'Pendiente',_utf8mb4'Autorizada',_utf8mb4'Rechazada',_utf8mb4'Anulada',_utf8mb4'Recibida'))),
  CONSTRAINT `ckFechasOrdenCompra` CHECK ((`fechaVencimientoOrdenCompra` >= `fechaEmisionOrdenCompra`)),
  CONSTRAINT `ckImportesOrdenCompra` CHECK (((`descuentoOrdenCompra` <= `subtotalOrdenCompra`) and (`totalOrdenCompra` = ((`subtotalOrdenCompra` - `descuentoOrdenCompra`) + `impuestoOrdenCompra`)))),
  CONSTRAINT `ckImpuestoOrdenCompra` CHECK ((`impuestoOrdenCompra` >= 0)),
  CONSTRAINT `ckReferenciaTipoCambioOrdenCompra` CHECK (((`idTipoCambio` is not null) or (`tipoCambioOrdenCompra` = 1))),
  CONSTRAINT `ckSubtotalOrdenCompra` CHECK ((`subtotalOrdenCompra` >= 0)),
  CONSTRAINT `ckTipoCambioOrdenCompra` CHECK ((`tipoCambioOrdenCompra` > 0)),
  CONSTRAINT `ckTotalOrdenCompra` CHECK ((`totalOrdenCompra` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblencabezadoordencompra`
--

LOCK TABLES `tblencabezadoordencompra` WRITE;
/*!40000 ALTER TABLE `tblencabezadoordencompra` DISABLE KEYS */;
INSERT INTO `tblencabezadoordencompra` VALUES (1,13,11,'2026-11-14','2026-11-29',1,NULL,1.000000,100.0000,0.0000,0.0000,100.0000,NULL,'Pendiente',0,'2026-11-14 18:34:39','2026-11-14 18:34:39'),(2,14,12,'2026-11-14','2026-12-14',1,NULL,1.000000,100.0000,0.0000,0.0000,100.0000,NULL,'Pendiente',0,'2026-11-14 18:34:39','2026-11-14 18:34:39'),(3,15,13,'2026-11-14','2026-12-29',1,NULL,1.000000,100.0000,0.0000,0.0000,100.0000,NULL,'Pendiente',0,'2026-11-14 18:34:39','2026-11-14 18:34:39'),(4,16,14,'2026-11-14','2027-01-13',1,NULL,1.000000,0.0000,0.0000,0.0000,0.0000,NULL,'Pendiente',0,'2026-11-14 18:34:39','2026-11-14 18:34:39'),(5,17,15,'2026-11-14','2027-01-28',1,NULL,1.000000,0.0000,0.0000,0.0000,0.0000,NULL,'Pendiente',0,'2026-11-14 18:34:39','2026-11-14 18:34:39');
/*!40000 ALTER TABLE `tblencabezadoordencompra` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblencabezadopagoproveedor`
--

DROP TABLE IF EXISTS `tblencabezadopagoproveedor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblencabezadopagoproveedor` (
  `idPagoProveedor` int NOT NULL AUTO_INCREMENT,
  `idProveedor` int NOT NULL,
  `fechaPagoProveedor` date NOT NULL,
  `montoPagoProveedor` decimal(12,4) NOT NULL,
  `idMetodoPago` int NOT NULL,
  `idMoneda` bigint NOT NULL,
  `idTipoCambio` bigint DEFAULT NULL,
  `tipoCambioPagoProveedor` decimal(12,6) NOT NULL DEFAULT '1.000000',
  `referenciaPagoProveedor` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `estadoPagoProveedor` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Programado',
  `bloqueadoPagoProveedor` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idPagoProveedor`),
  KEY `idxPagoProveedorProveedor` (`idProveedor`),
  KEY `idxPagoProveedorFecha` (`fechaPagoProveedor`),
  KEY `Fk_EncabezadoPagoProveedor_MetodoPago` (`idMetodoPago`),
  KEY `idxPagoProveedorMoneda` (`idMoneda`),
  KEY `idxPagoProveedorTipoCambio` (`idTipoCambio`),
  CONSTRAINT `Fk_EncabezadoPagoProveedor_MetodoPago` FOREIGN KEY (`idMetodoPago`) REFERENCES `tblmetodopago` (`idMetodoPago`),
  CONSTRAINT `Fk_EncabezadoPagoProveedor_Moneda` FOREIGN KEY (`idMoneda`) REFERENCES `tblmoneda` (`idMoneda`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `Fk_EncabezadoPagoProveedor_Proveedor` FOREIGN KEY (`idProveedor`) REFERENCES `tblproveedor` (`idProveedor`),
  CONSTRAINT `Fk_EncabezadoPagoProveedor_TipoCambio` FOREIGN KEY (`idTipoCambio`) REFERENCES `tbltipocambio` (`idTipoCambio`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `ckEstadoPagoProveedor` CHECK ((`estadoPagoProveedor` in (_utf8mb4'Pagado',_utf8mb4'Programado',_utf8mb4'Rechazado',_utf8mb4'Anulado'))),
  CONSTRAINT `ckMontoPagoProveedor` CHECK ((`montoPagoProveedor` > 0)),
  CONSTRAINT `ckReferenciaTipoCambioPagoProveedor` CHECK (((`idTipoCambio` is not null) or (`tipoCambioPagoProveedor` = 1))),
  CONSTRAINT `ckTipoCambioPagoProveedor` CHECK ((`tipoCambioPagoProveedor` > 0))
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblencabezadopagoproveedor`
--

LOCK TABLES `tblencabezadopagoproveedor` WRITE;
/*!40000 ALTER TABLE `tblencabezadopagoproveedor` DISABLE KEYS */;
INSERT INTO `tblencabezadopagoproveedor` VALUES (1,13,'2026-11-14',20.0000,1,1,NULL,1.000000,'PR-0d2d5068e05a-1','Programado',0,'2026-11-14 18:34:39','2026-11-14 18:34:39'),(2,14,'2026-11-14',20.0000,1,1,NULL,1.000000,'PR-0d2d5068e05a-2','Programado',0,'2026-11-14 18:34:39','2026-11-14 18:34:39'),(3,15,'2026-11-14',20.0000,1,1,NULL,1.000000,'PR-0d2d5068e05a-3','Programado',0,'2026-11-14 18:34:39','2026-11-14 18:34:39'),(4,16,'2026-11-14',20.0000,1,1,NULL,1.000000,'PR-0d2d5068e05a-4','Rechazado',0,'2026-11-14 18:34:39','2026-11-14 18:34:39'),(5,17,'2026-11-14',20.0000,1,1,NULL,1.000000,'PR-0d2d5068e05a-5','Rechazado',0,'2026-11-14 18:34:39','2026-11-14 18:34:39');
/*!40000 ALTER TABLE `tblencabezadopagoproveedor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblencabezadoviaje`
--

DROP TABLE IF EXISTS `tblencabezadoviaje`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblencabezadoviaje` (
  `idEncabezadoViaje` bigint NOT NULL AUTO_INCREMENT,
  `fechaDocumentoEncabezadoViaje` datetime NOT NULL,
  `horaSalidaEncabezadoViaje` datetime NOT NULL,
  `horaLlegadaEncabezadoViaje` datetime DEFAULT NULL,
  `requiereCadenaFrioEncabezadoViaje` tinyint(1) NOT NULL DEFAULT '1',
  `estadoViajeEncabezadoViaje` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'EN_CURSO',
  `pesoTotalEncabezadoViaje` decimal(18,3) NOT NULL,
  `Fk_Transporte_Codigo` int NOT NULL,
  `Fk_Conductor_Codigo` int NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idEncabezadoViaje`),
  KEY `idxIdTransporteEncabezadoViaje` (`Fk_Transporte_Codigo`),
  KEY `idxIdConductorEncabezadoViaje` (`Fk_Conductor_Codigo`),
  KEY `idxEstadoViajeEncabezadoViaje` (`estadoViajeEncabezadoViaje`),
  CONSTRAINT `Fk_Encabezado_Viaje_Conductor` FOREIGN KEY (`Fk_Conductor_Codigo`) REFERENCES `tblconductor` (`idConductor`) ON DELETE RESTRICT,
  CONSTRAINT `Fk_Encabezado_Viaje_Transporte` FOREIGN KEY (`Fk_Transporte_Codigo`) REFERENCES `tbltransporte` (`idTransporte`) ON DELETE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblencabezadoviaje`
--

LOCK TABLES `tblencabezadoviaje` WRITE;
/*!40000 ALTER TABLE `tblencabezadoviaje` DISABLE KEYS */;
INSERT INTO `tblencabezadoviaje` VALUES (1,'2026-10-20 05:30:00','2026-10-20 06:00:00','2026-10-20 10:45:00',1,'FINALIZADO',850.000,1,1,'2026-11-14 18:34:39','2026-11-14 18:34:39'),(2,'2026-10-21 07:15:00','2026-10-21 07:45:00','2026-10-21 13:20:00',1,'FINALIZADO',920.000,2,2,'2026-11-14 18:34:39','2026-11-14 18:34:39'),(3,'2026-10-22 04:45:00','2026-10-22 05:30:00','2026-10-22 11:15:00',1,'FINALIZADO',735.000,3,3,'2026-11-14 18:34:39','2026-11-14 18:34:39'),(4,'2026-11-08 08:10:00','2026-11-08 09:00:00',NULL,1,'EN_CURSO',480.000,4,4,'2026-11-14 18:34:39','2026-11-14 18:34:39'),(5,'2026-10-24 06:10:00','2026-10-24 06:30:00','2026-10-24 16:40:00',1,'FINALIZADO',1200.000,5,5,'2026-11-14 18:34:39','2026-11-14 18:34:39');
/*!40000 ALTER TABLE `tblencabezadoviaje` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblestado`
--

DROP TABLE IF EXISTS `tblestado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblestado` (
  `idEstado` int NOT NULL AUTO_INCREMENT,
  `tipoEstado` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idEstado`),
  UNIQUE KEY `uqTipoEstado` (`tipoEstado`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblestado`
--

LOCK TABLES `tblestado` WRITE;
/*!40000 ALTER TABLE `tblestado` DISABLE KEYS */;
INSERT INTO `tblestado` VALUES (1,'Disponible','2026-11-14 18:34:39','2026-11-14 18:34:39'),(2,'En mantenimiento','2026-11-14 18:34:39','2026-11-14 18:34:39'),(3,'En ruta','2026-11-14 18:34:39','2026-11-14 18:34:39'),(4,'Fuera de servicio','2026-11-14 18:34:39','2026-11-14 18:34:39'),(5,'Reservado','2026-11-14 18:34:39','2026-11-14 18:34:39');
/*!40000 ALTER TABLE `tblestado` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblestadosolicitudpago`
--

DROP TABLE IF EXISTS `tblestadosolicitudpago`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblestadosolicitudpago` (
  `idEstadoSolicitudPago` int NOT NULL AUTO_INCREMENT,
  `codigoEstadoSolicitudPago` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nombreEstadoSolicitudPago` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcionEstadoSolicitudPago` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idEstadoSolicitudPago`),
  UNIQUE KEY `uqCodigoEstadoSolicitudPago` (`codigoEstadoSolicitudPago`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblestadosolicitudpago`
--

LOCK TABLES `tblestadosolicitudpago` WRITE;
/*!40000 ALTER TABLE `tblestadosolicitudpago` DISABLE KEYS */;
INSERT INTO `tblestadosolicitudpago` VALUES (1,'SOLICITADO','Solicitado','Solicitud de pago registrada','2026-11-14 18:34:17','2026-11-14 18:34:17'),(2,'EN_REVISION','En revisión','Documentación de soporte en revisión.','2026-11-14 18:34:39','2026-11-14 18:34:39'),(3,'APROBADO','Aprobado','Solicitud autorizada para realizar el pago.','2026-11-14 18:34:39','2026-11-14 18:34:39'),(4,'PAGADO','Pagado','Pago realizado y confirmado.','2026-11-14 18:34:35','2026-11-14 18:34:35'),(5,'RECHAZADO','Rechazado','Solicitud devuelta por inconsistencia documental.','2026-11-14 18:34:39','2026-11-14 18:34:39');
/*!40000 ALTER TABLE `tblestadosolicitudpago` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblevaluacioncapacitacion`
--

DROP TABLE IF EXISTS `tblevaluacioncapacitacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblevaluacioncapacitacion` (
  `idEvaluacionCapacitacion` int NOT NULL AUTO_INCREMENT,
  `idAsignacionCapacitacion` int NOT NULL,
  `puntualidadEvaluacionCapacitacion` decimal(5,2) NOT NULL,
  `calidadEvaluacionCapacitacion` decimal(5,2) NOT NULL,
  `responsabilidadEvaluacionCapacitacion` decimal(5,2) NOT NULL,
  `desarrolloEvaluacionCapacitacion` decimal(5,2) NOT NULL,
  `resultadoFinalEvaluacionCapacitacion` decimal(5,2) NOT NULL DEFAULT '0.00',
  `observacionEvaluacionCapacitacion` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idEvaluacionCapacitacion`),
  UNIQUE KEY `uqEvaluacionCapacitacion` (`idAsignacionCapacitacion`),
  CONSTRAINT `Fk_EvaluacionCapacitacion_AsignacionCapacitacion` FOREIGN KEY (`idAsignacionCapacitacion`) REFERENCES `tblasignacioncapacitacion` (`idAsignacionCapacitacion`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblevaluacioncapacitacion`
--

LOCK TABLES `tblevaluacioncapacitacion` WRITE;
/*!40000 ALTER TABLE `tblevaluacioncapacitacion` DISABLE KEYS */;
INSERT INTO `tblevaluacioncapacitacion` VALUES (1,1,90.00,85.00,88.00,92.00,88.75,'Excelente participación','2026-11-14 18:34:38','2026-11-14 18:34:38'),(2,2,95.00,90.00,92.00,94.00,92.75,'Aplica lo aprendido en su trabajo','2026-11-14 18:34:38','2026-11-14 18:34:38'),(3,3,80.00,85.00,78.00,82.00,81.25,NULL,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(4,4,70.00,75.00,80.00,72.00,74.25,'Debe reforzar puntualidad','2026-11-14 18:34:38','2026-11-14 18:34:38'),(5,5,88.00,90.00,85.00,87.00,87.50,NULL,'2026-11-14 18:34:38','2026-11-14 18:34:38');
/*!40000 ALTER TABLE `tblevaluacioncapacitacion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblevaluaciondesempeno`
--

DROP TABLE IF EXISTS `tblevaluaciondesempeno`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblevaluaciondesempeno` (
  `idEvaluacionDesempeno` int NOT NULL AUTO_INCREMENT,
  `idEmpleado` int NOT NULL,
  `idEvaluador` int NOT NULL,
  `fechaEvaluacionDesempeno` date NOT NULL,
  `calidadEvaluacionDesempeno` int NOT NULL,
  `productividadEvaluacionDesempeno` int NOT NULL,
  `trabajoEquipoEvaluacionDesempeno` int NOT NULL,
  `puntualidadEvaluacionDesempeno` int NOT NULL,
  `iniciativaEvaluacionDesempeno` int NOT NULL,
  `puntajeEvaluacionDesempeno` decimal(4,2) DEFAULT '0.00',
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idEvaluacionDesempeno`),
  KEY `Fk_EvaluacionDesempeno_Evaluador` (`idEvaluador`),
  KEY `idxEvaluacionDesempenoEmpleado` (`idEmpleado`),
  CONSTRAINT `Fk_EvaluacionDesempeno_Empleado` FOREIGN KEY (`idEmpleado`) REFERENCES `tblempleado` (`idEmpleado`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `Fk_EvaluacionDesempeno_Evaluador` FOREIGN KEY (`idEvaluador`) REFERENCES `tblempleado` (`idEmpleado`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `ckEvaluacionDesempenoNotas` CHECK (((`calidadEvaluacionDesempeno` between 1 and 5) and (`productividadEvaluacionDesempeno` between 1 and 5) and (`trabajoEquipoEvaluacionDesempeno` between 1 and 5) and (`puntualidadEvaluacionDesempeno` between 1 and 5) and (`iniciativaEvaluacionDesempeno` between 1 and 5))),
  CONSTRAINT `ckEvaluacionDesempenoPuntaje` CHECK ((`puntajeEvaluacionDesempeno` between 0 and 5))
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblevaluaciondesempeno`
--

LOCK TABLES `tblevaluaciondesempeno` WRITE;
/*!40000 ALTER TABLE `tblevaluaciondesempeno` DISABLE KEYS */;
INSERT INTO `tblevaluaciondesempeno` VALUES (1,20,1,'2026-10-15',5,4,5,5,4,4.60,1,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(2,21,1,'2026-10-15',4,4,3,5,4,4.00,1,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(3,22,3,'2026-10-16',3,3,4,2,3,3.00,1,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(4,23,3,'2026-10-16',5,5,5,4,5,4.80,1,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(5,24,13,'2026-10-16',2,3,3,4,2,2.80,1,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(6,1,3,'2026-04-15',3,3,4,4,3,3.35,1,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(7,1,3,'2026-07-15',4,3,4,5,4,3.90,1,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(8,1,3,'2026-10-20',4,4,5,5,4,4.35,1,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(9,3,1,'2026-04-16',4,4,3,5,3,3.80,1,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(10,3,1,'2026-07-16',4,5,4,4,4,4.25,1,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(11,3,1,'2026-10-21',5,4,4,5,5,4.55,1,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(12,13,1,'2026-04-17',2,3,3,3,2,2.60,1,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(13,13,1,'2026-07-17',3,3,4,3,3,3.20,1,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(14,13,1,'2026-10-22',4,4,4,5,4,4.15,1,'2026-11-14 18:34:38','2026-11-14 18:34:38');
/*!40000 ALTER TABLE `tblevaluaciondesempeno` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblextractobancario`
--

DROP TABLE IF EXISTS `tblextractobancario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblextractobancario` (
  `Pk_ExtractoBancario` bigint NOT NULL AUTO_INCREMENT,
  `referenciaExtractoBancario` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fechaInicioExtractoBancario` date NOT NULL,
  `fechaFinExtractoBancario` date NOT NULL,
  `saldoInicialExtractoBancario` decimal(12,4) NOT NULL,
  `saldoFinalExtractoBancario` decimal(12,4) NOT NULL,
  `huellaExtractoBancario` char(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fechaImportacionExtractoBancario` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Fk_CuentaBancaria_Codigo` bigint NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`Pk_ExtractoBancario`),
  UNIQUE KEY `uqExtractoBancario1` (`Fk_CuentaBancaria_Codigo`,`referenciaExtractoBancario`),
  UNIQUE KEY `uqExtractoBancario2` (`Fk_CuentaBancaria_Codigo`,`huellaExtractoBancario`),
  CONSTRAINT `Fk_ExtractoBancario_Cuenta` FOREIGN KEY (`Fk_CuentaBancaria_Codigo`) REFERENCES `tblcuentabancaria` (`idCuentaBancaria`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `ckExtractoBancario1` CHECK ((`fechaFinExtractoBancario` >= `fechaInicioExtractoBancario`))
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblextractobancario`
--

LOCK TABLES `tblextractobancario` WRITE;
/*!40000 ALTER TABLE `tblextractobancario` DISABLE KEYS */;
INSERT INTO `tblextractobancario` VALUES (1,'EXT-BIND-2026-11','2026-11-01','2026-11-06',120000.0000,126515.0000,'ae0633787708e2c63026eaa8a3ba83c8a17bf335101a4cff84721ea554a62e43','2026-11-14 12:34:37',1,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(2,'EXT-BRUR-2026-11','2026-11-01','2026-11-06',60000.0000,64379.5000,'a30af9998041bd432786855ba32c84cbf2d89deeb3cb897cb9a2c80f962a9a0e','2026-11-14 12:34:37',2,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(3,'EXT-BAC-2026-11','2026-11-01','2026-11-06',18000.0000,18000.0000,'e37f9d5792f34fa11419d616dccb18aff56c280f1fbafca1919ed3fb3e622275','2026-11-14 12:34:37',3,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(4,'EXT-GYT-2026-11','2026-11-01','2026-11-06',85000.0000,85000.0000,'9a5a07d4de899c75f09acb257f7643c40dc80ca7cc6661ffcbcb0a7475917f0c','2026-11-14 12:34:37',4,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(5,'EXT-BAM-2026-11','2026-11-01','2026-11-06',250000.0000,250000.0000,'ecb2d933e99c4db9569a0df45afb62c4eeaa04d4f0ccd917c263fea828107d53','2026-11-14 12:34:37',5,'2026-11-14 18:34:37','2026-11-14 18:34:37');
/*!40000 ALTER TABLE `tblextractobancario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblfacturadetalle`
--

DROP TABLE IF EXISTS `tblfacturadetalle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblfacturadetalle` (
  `idFacturaEncabezadoUuidDte` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `numeroLineaFacturaDetalle` int NOT NULL,
  `idFacturaDetalle` int NOT NULL AUTO_INCREMENT,
  `idProducto` int NOT NULL,
  `cantidadFacturaDetalle` decimal(12,4) NOT NULL,
  `precioUnitarioFacturaDetalle` decimal(12,4) NOT NULL,
  `descuentoMontoFacturaDetalle` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `tasaImpuestoFacturaDetalle` decimal(3,2) NOT NULL DEFAULT '0.12',
  `impuestoMontoFacturaDetalle` decimal(12,4) GENERATED ALWAYS AS (round((((`cantidadFacturaDetalle` * `precioUnitarioFacturaDetalle`) - `descuentoMontoFacturaDetalle`) * `tasaImpuestoFacturaDetalle`),4)) STORED,
  `subtotalLineaFacturaDetalle` decimal(12,4) GENERATED ALWAYS AS (round(((`cantidadFacturaDetalle` * `precioUnitarioFacturaDetalle`) - `descuentoMontoFacturaDetalle`),4)) STORED,
  `totalLineaFacturaDetalle` decimal(12,4) GENERATED ALWAYS AS (round((((`cantidadFacturaDetalle` * `precioUnitarioFacturaDetalle`) - `descuentoMontoFacturaDetalle`) + `impuestoMontoFacturaDetalle`),4)) STORED,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idFacturaEncabezadoUuidDte`,`idFacturaDetalle`),
  UNIQUE KEY `uqFacturaDetalleClaveNegocio` (`idFacturaEncabezadoUuidDte`,`numeroLineaFacturaDetalle`),
  UNIQUE KEY `uqFacturaDetalleId` (`idFacturaDetalle`),
  KEY `idxFacturaDetalleProductoCodigo` (`idProducto`),
  CONSTRAINT `Fk_FacturaDetalle_FacturaEncabezado` FOREIGN KEY (`idFacturaEncabezadoUuidDte`) REFERENCES `tblfacturaencabezado` (`uuidDteFacturaEncabezado`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `Fk_FacturaDetalle_Producto` FOREIGN KEY (`idProducto`) REFERENCES `tblproducto` (`idProducto`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `ckFacturaDetalleCantidadPrecioDescuentoValidos` CHECK (((`cantidadFacturaDetalle` > 0) and (`precioUnitarioFacturaDetalle` >= 0) and (`descuentoMontoFacturaDetalle` >= 0) and (`descuentoMontoFacturaDetalle` <= (`cantidadFacturaDetalle` * `precioUnitarioFacturaDetalle`)))),
  CONSTRAINT `ckFacturaDetalleNumeroLineaPositivo` CHECK ((`numeroLineaFacturaDetalle` > 0)),
  CONSTRAINT `ckFacturaDetalletasaImpuestoFacturaDetalleRango` CHECK ((`tasaImpuestoFacturaDetalle` between 0 and 0.99))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblfacturadetalle`
--

LOCK TABLES `tblfacturadetalle` WRITE;
/*!40000 ALTER TABLE `tblfacturadetalle` DISABLE KEYS */;
/*!40000 ALTER TABLE `tblfacturadetalle` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblfacturaencabezado`
--

DROP TABLE IF EXISTS `tblfacturaencabezado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblfacturaencabezado` (
  `idFacturaEncabezado` int NOT NULL AUTO_INCREMENT,
  `uuidDteFacturaEncabezado` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `serieFacturaEncabezado` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `numeroFacturaEncabezado` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `idSucursal` int NOT NULL,
  `idClienteFacturaVersion` int NOT NULL,
  `idVendedor` int DEFAULT NULL,
  `idMoneda` bigint NOT NULL,
  `idCotizacionEncabezado` int DEFAULT NULL,
  `idPedidoEncabezado` int DEFAULT NULL,
  `fechaEmisionFacturaEncabezado` datetime NOT NULL,
  `fechaVencimientoFacturaEncabezado` date NOT NULL,
  `tipoDteFacturaEncabezado` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Factura',
  `condicionPagoFacturaEncabezado` varchar(15) COLLATE utf8mb4_unicode_ci NOT NULL,
  `estadoFacturaEncabezado` varchar(25) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'EMITIDA',
  `fechaCertificacionFacturaEncabezado` datetime DEFAULT NULL,
  `subtotalFacturaEncabezado` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `impuestoIvaFacturaEncabezado` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `totalFacturaEncabezado` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `observacionesFacturaEncabezado` text COLLATE utf8mb4_unicode_ci,
  `idUsuarioRegistro` int NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idFacturaEncabezado`),
  UNIQUE KEY `uqFacturaEncabezadoSucursalCodigoserienumero` (`idSucursal`,`serieFacturaEncabezado`,`numeroFacturaEncabezado`),
  UNIQUE KEY `uqFacturaEncabezadoClaveNegocio` (`uuidDteFacturaEncabezado`),
  UNIQUE KEY `uqFacturaEncabezadoCotizacionEncabezadoCodigo` (`idCotizacionEncabezado`),
  KEY `idxFacturaEncabezadoPedidoEncabezadoCodigo` (`idPedidoEncabezado`),
  KEY `idxFacturaEncabezadoVendedorCodigo` (`idVendedor`),
  KEY `idxFacturaEncabezadoMonedaCodigo` (`idMoneda`),
  KEY `idxFacturaEncabezadoUsuarioRegistro` (`idUsuarioRegistro`),
  KEY `idxFacturaEncabezadoClienteFacturaVersionCodigo` (`idClienteFacturaVersion`),
  CONSTRAINT `Fk_FacturaEncabezado_ClienteFacturaVersion` FOREIGN KEY (`idClienteFacturaVersion`) REFERENCES `tblclientefacturaversion` (`idClienteFacturaVersion`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `Fk_FacturaEncabezado_CotizacionEncabezado` FOREIGN KEY (`idCotizacionEncabezado`) REFERENCES `tblcotizacionencabezado` (`idCotizacionEncabezado`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `Fk_FacturaEncabezado_Moneda` FOREIGN KEY (`idMoneda`) REFERENCES `tblmoneda` (`idMoneda`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `Fk_FacturaEncabezado_PedidoEncabezado` FOREIGN KEY (`idPedidoEncabezado`) REFERENCES `tblpedidoencabezado` (`idPedidoEncabezado`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `Fk_FacturaEncabezado_Sucursal` FOREIGN KEY (`idSucursal`) REFERENCES `tblsucursal` (`idSucursal`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `Fk_FacturaEncabezado_Usuario_Registro` FOREIGN KEY (`idUsuarioRegistro`) REFERENCES `tblusuario` (`idUsuario`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `Fk_FacturaEncabezado_Vendedor` FOREIGN KEY (`idVendedor`) REFERENCES `tblvendedor` (`idVendedor`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `ckFacturaEncabezadoCondicionPagoValida` CHECK ((`condicionPagoFacturaEncabezado` in (_utf8mb4'CONTADO',_utf8mb4'CREDITO'))),
  CONSTRAINT `ckFacturaEncabezadoFechasCoherentes` CHECK ((`fechaVencimientoFacturaEncabezado` >= cast(`fechaEmisionFacturaEncabezado` as date))),
  CONSTRAINT `ckFacturaEncabezadoValoresEstadoFactura` CHECK ((`estadoFacturaEncabezado` in (_utf8mb4'BORRADOR',_utf8mb4'EMITIDA',_utf8mb4'ANULADA')))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblfacturaencabezado`
--

LOCK TABLES `tblfacturaencabezado` WRITE;
/*!40000 ALTER TABLE `tblfacturaencabezado` DISABLE KEYS */;
/*!40000 ALTER TABLE `tblfacturaencabezado` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblfacturatransporte`
--

DROP TABLE IF EXISTS `tblfacturatransporte`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblfacturatransporte` (
  `idFacturaTransporte` int NOT NULL AUTO_INCREMENT,
  `Fk_Servicio_Transporte_Externo_Codigo` int NOT NULL,
  `Fk_Plazo_Codigo` int NOT NULL,
  `Fk_SerieDocumentoCuentaPorPagar` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Fk_NumeroDocumentoCuentaPorPagar` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Fk_IdConceptoProveedor` int DEFAULT NULL,
  `serieFacturaTransporte` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `numeroFacturaTransporte` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fechaEmisionFacturaTransporte` date NOT NULL,
  `montoFacturaTransporte` decimal(12,4) NOT NULL,
  `activaFacturaTransporte` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idFacturaTransporte`),
  UNIQUE KEY `uqFacturaServicio` (`Fk_Servicio_Transporte_Externo_Codigo`),
  UNIQUE KEY `uqFacturaDocumento` (`serieFacturaTransporte`,`numeroFacturaTransporte`),
  UNIQUE KEY `uqFacturaCuentaPorPagar` (`Fk_SerieDocumentoCuentaPorPagar`,`Fk_NumeroDocumentoCuentaPorPagar`,`Fk_IdConceptoProveedor`),
  KEY `Fk_Factura_Transporte_Plazo` (`Fk_Plazo_Codigo`),
  CONSTRAINT `Fk_Factura_Transporte_Cuenta_Por_Pagar` FOREIGN KEY (`Fk_SerieDocumentoCuentaPorPagar`, `Fk_NumeroDocumentoCuentaPorPagar`, `Fk_IdConceptoProveedor`) REFERENCES `tblcuentaporpagar` (`serieDocumentoCuentaPorPagar`, `numeroDocumentoCuentaPorPagar`, `idConceptoProveedor`) ON DELETE RESTRICT,
  CONSTRAINT `Fk_Factura_Transporte_Plazo` FOREIGN KEY (`Fk_Plazo_Codigo`) REFERENCES `tblplazo` (`idPlazo`) ON DELETE RESTRICT,
  CONSTRAINT `Fk_Factura_Transporte_Servicio_Transporte_Externo` FOREIGN KEY (`Fk_Servicio_Transporte_Externo_Codigo`) REFERENCES `tblserviciotransporteexterno` (`idServicioTransporteExterno`) ON DELETE RESTRICT,
  CONSTRAINT `ckFacturaCuentaPorPagarCompleta` CHECK ((((`Fk_SerieDocumentoCuentaPorPagar` is null) and (`Fk_NumeroDocumentoCuentaPorPagar` is null) and (`Fk_IdConceptoProveedor` is null)) or ((`Fk_SerieDocumentoCuentaPorPagar` is not null) and (`Fk_NumeroDocumentoCuentaPorPagar` is not null) and (`Fk_IdConceptoProveedor` is not null)))),
  CONSTRAINT `ckFacturaMonto` CHECK ((`montoFacturaTransporte` > 0))
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblfacturatransporte`
--

LOCK TABLES `tblfacturatransporte` WRITE;
/*!40000 ALTER TABLE `tblfacturatransporte` DISABLE KEYS */;
INSERT INTO `tblfacturatransporte` VALUES (1,1,1,NULL,NULL,NULL,'A-2026','000184','2026-10-25',1050.0000,1,'2026-11-14 18:34:39','2026-11-14 18:34:39'),(2,2,1,NULL,NULL,NULL,'A-2026','000192','2026-10-26',1062.5000,1,'2026-11-14 18:34:39','2026-11-14 18:34:39'),(3,3,1,NULL,NULL,NULL,'FEL-26','000847','2026-10-27',1250.0000,1,'2026-11-14 18:34:39','2026-11-14 18:34:39'),(4,4,1,NULL,NULL,NULL,'FEL-26','000861','2026-11-08',450.0000,1,'2026-11-14 18:34:39','2026-11-14 18:34:39'),(5,5,1,NULL,NULL,NULL,'B-2026','000319','2026-11-10',540.0000,1,'2026-11-14 18:34:39','2026-11-14 18:34:39');
/*!40000 ALTER TABLE `tblfacturatransporte` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblformapagoventa`
--

DROP TABLE IF EXISTS `tblformapagoventa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblformapagoventa` (
  `idFormaPagoVenta` int NOT NULL AUTO_INCREMENT,
  `codigoFormaPagoVenta` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nombreFormaPagoVenta` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `requiereReferenciaFormaPagoVenta` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idFormaPagoVenta`),
  UNIQUE KEY `uqFormaPagoVentacodigo` (`codigoFormaPagoVenta`),
  CONSTRAINT `ckFormaPagoVentarequiereReferenciaFormaPagoVentaBooleano` CHECK ((`requiereReferenciaFormaPagoVenta` in (0,1)))
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblformapagoventa`
--

LOCK TABLES `tblformapagoventa` WRITE;
/*!40000 ALTER TABLE `tblformapagoventa` DISABLE KEYS */;
INSERT INTO `tblformapagoventa` VALUES (1,'FAC-QA-EF','Efectivo (Facturas QA)',0,'2026-11-14 18:34:40','2026-11-14 18:34:40');
/*!40000 ALTER TABLE `tblformapagoventa` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblhistorialmodificacionprecio`
--

DROP TABLE IF EXISTS `tblhistorialmodificacionprecio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblhistorialmodificacionprecio` (
  `idHistorialModificacionPrecio` int NOT NULL AUTO_INCREMENT,
  `idTipoCliente` int NOT NULL,
  `tipoModificacion` enum('DESCUENTO_PORCENTAJE','AUMENTO_PORCENTAJE','AUMENTO_BASE') COLLATE utf8mb4_unicode_ci NOT NULL,
  `valorModificacion` decimal(12,4) NOT NULL,
  `alcanceModificacion` enum('INDIVIDUAL','SELECCIONADOS','TODOS_FILTROS') COLLATE utf8mb4_unicode_ci NOT NULL,
  `idMarca` int DEFAULT NULL,
  `idLinea` int DEFAULT NULL,
  `idCategoria` int DEFAULT NULL,
  `idProveedor` int DEFAULT NULL,
  `idProducto` int DEFAULT NULL,
  `idUsuarioRegistro` int NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idHistorialModificacionPrecio`),
  KEY `Fk_HistorialModificacionPrecio_TipoCliente` (`idTipoCliente`),
  KEY `Fk_HistorialModificacionPrecio_Usuario` (`idUsuarioRegistro`),
  KEY `Fk_HistorialModificacionPrecio_Marca` (`idMarca`),
  KEY `Fk_HistorialModificacionPrecio_Linea` (`idLinea`),
  KEY `Fk_HistorialModificacionPrecio_Categoria` (`idCategoria`),
  KEY `Fk_HistorialModificacionPrecio_Proveedor` (`idProveedor`),
  KEY `Fk_HistorialModificacionPrecio_Producto` (`idProducto`),
  CONSTRAINT `Fk_HistorialModificacionPrecio_Categoria` FOREIGN KEY (`idCategoria`) REFERENCES `tblcategoria` (`idCategoria`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `Fk_HistorialModificacionPrecio_Linea` FOREIGN KEY (`idLinea`) REFERENCES `tbllinea` (`idLinea`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `Fk_HistorialModificacionPrecio_Marca` FOREIGN KEY (`idMarca`) REFERENCES `tblmarca` (`idMarca`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `Fk_HistorialModificacionPrecio_Producto` FOREIGN KEY (`idProducto`) REFERENCES `tblproducto` (`idProducto`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `Fk_HistorialModificacionPrecio_Proveedor` FOREIGN KEY (`idProveedor`) REFERENCES `tblproveedor` (`idProveedor`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `Fk_HistorialModificacionPrecio_TipoCliente` FOREIGN KEY (`idTipoCliente`) REFERENCES `tbltipocliente` (`idTipoCliente`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `Fk_HistorialModificacionPrecio_Usuario` FOREIGN KEY (`idUsuarioRegistro`) REFERENCES `tblusuario` (`idUsuario`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblhistorialmodificacionprecio`
--

LOCK TABLES `tblhistorialmodificacionprecio` WRITE;
/*!40000 ALTER TABLE `tblhistorialmodificacionprecio` DISABLE KEYS */;
/*!40000 ALTER TABLE `tblhistorialmodificacionprecio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblhistorialmodificacionpreciodetalle`
--

DROP TABLE IF EXISTS `tblhistorialmodificacionpreciodetalle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblhistorialmodificacionpreciodetalle` (
  `idHistorialModificacionPrecioDetalle` int NOT NULL AUTO_INCREMENT,
  `idHistorialModificacionPrecio` int NOT NULL,
  `idProducto` int NOT NULL,
  `porcentajeDescuentoAnterior` decimal(5,2) NOT NULL,
  `precioBaseAnterior` decimal(12,4) NOT NULL,
  `precioFinalAnterior` decimal(12,4) NOT NULL,
  `porcentajeDescuentoNuevo` decimal(5,2) NOT NULL,
  `precioBaseNuevo` decimal(12,4) NOT NULL,
  `precioFinalNuevo` decimal(12,4) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idHistorialModificacionPrecio`,`idHistorialModificacionPrecioDetalle`),
  UNIQUE KEY `uqHistorialModificacionPrecioDetalleId` (`idHistorialModificacionPrecioDetalle`),
  KEY `Fk_HistorialDetalle_Producto` (`idProducto`),
  CONSTRAINT `Fk_HistorialDetalle_HistorialEncabezado` FOREIGN KEY (`idHistorialModificacionPrecio`) REFERENCES `tblhistorialmodificacionprecio` (`idHistorialModificacionPrecio`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `Fk_HistorialDetalle_Producto` FOREIGN KEY (`idProducto`) REFERENCES `tblproducto` (`idProducto`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblhistorialmodificacionpreciodetalle`
--

LOCK TABLES `tblhistorialmodificacionpreciodetalle` WRITE;
/*!40000 ALTER TABLE `tblhistorialmodificacionpreciodetalle` DISABLE KEYS */;
/*!40000 ALTER TABLE `tblhistorialmodificacionpreciodetalle` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblhistorialtransporte`
--

DROP TABLE IF EXISTS `tblhistorialtransporte`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblhistorialtransporte` (
  `idHistorialTransporte` int NOT NULL AUTO_INCREMENT,
  `Fk_Servicio_Transporte_Externo_Codigo` int NOT NULL,
  `fechaMovimientoHistorialTransporte` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `tipoMovimientoHistorialTransporte` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcionMovimientoHistorialTransporte` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `estadoTransporteHistorialTransporte` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idHistorialTransporte`),
  KEY `Fk_Historial_Transporte_Servicio_Transporte_Externo` (`Fk_Servicio_Transporte_Externo_Codigo`),
  CONSTRAINT `Fk_Historial_Transporte_Servicio_Transporte_Externo` FOREIGN KEY (`Fk_Servicio_Transporte_Externo_Codigo`) REFERENCES `tblserviciotransporteexterno` (`idServicioTransporteExterno`) ON DELETE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblhistorialtransporte`
--

LOCK TABLES `tblhistorialtransporte` WRITE;
/*!40000 ALTER TABLE `tblhistorialtransporte` DISABLE KEYS */;
INSERT INTO `tblhistorialtransporte` VALUES (1,1,'2026-10-25 11:15:00','Confirmación de entrega','Entrega recibida y documentación firmada en Mixco.','Entregado','2026-11-14 18:34:39','2026-11-14 18:34:39'),(2,2,'2026-10-26 10:45:00','Confirmación de entrega','Recepción completa en Villa Nueva.','Entregado','2026-11-14 18:34:39','2026-11-14 18:34:39'),(3,3,'2026-10-27 14:20:00','Confirmación de entrega','Mercadería refrigerada recibida en Quetzaltenango.','Entregado','2026-11-14 18:34:39','2026-11-14 18:34:39'),(4,4,'2026-11-11 10:15:00','Actualización de ruta','Vehículo reporta avance por carretera al Pacífico.','En tránsito','2026-11-14 18:34:39','2026-11-14 18:34:39'),(5,5,'2026-11-10 16:00:00','Programación de despacho','Se programó unidad para recolección y entrega.','Programado','2026-11-14 18:34:39','2026-11-14 18:34:39');
/*!40000 ALTER TABLE `tblhistorialtransporte` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblhistoricoinventario`
--

DROP TABLE IF EXISTS `tblhistoricoinventario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblhistoricoinventario` (
  `idHistoricoInventario` bigint NOT NULL AUTO_INCREMENT,
  `Fk_Cierre_Inventario_Codigo` int NOT NULL,
  `Fk_Stock_Codigo` int NOT NULL,
  `Fk_Sucursal_Codigo` int NOT NULL,
  `Fk_Bodega_Codigo` int NOT NULL,
  `Fk_Producto_Codigo` int NOT NULL,
  `stockFisicoStock` int NOT NULL DEFAULT '0',
  `stockVirtualStock` int NOT NULL DEFAULT '0',
  `stockAnteriorStock` int NOT NULL DEFAULT '0',
  `stockActualStock` int NOT NULL DEFAULT '0',
  `cargosMesStock` int NOT NULL DEFAULT '0',
  `abonosMesStock` int NOT NULL DEFAULT '0',
  `cargosAcumuladosStock` bigint NOT NULL DEFAULT '0',
  `abonosAcumuladosStock` bigint NOT NULL DEFAULT '0',
  `apartadosStock` int NOT NULL DEFAULT '0',
  `estadoVentaStock` tinyint(1) NOT NULL,
  `estadoCompraStock` tinyint(1) NOT NULL,
  `fechaCorteHistoricoInventario` date NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idHistoricoInventario`),
  UNIQUE KEY `uqHistoricoInventarioCierreStock` (`Fk_Cierre_Inventario_Codigo`,`Fk_Stock_Codigo`),
  KEY `Fk_Historico_Inventario_Stock` (`Fk_Stock_Codigo`),
  KEY `Fk_Historico_Inventario_Producto` (`Fk_Producto_Codigo`),
  KEY `Fk_Historico_Inventario_Bodega` (`Fk_Bodega_Codigo`,`Fk_Sucursal_Codigo`),
  CONSTRAINT `Fk_Historico_Inventario_Bodega` FOREIGN KEY (`Fk_Bodega_Codigo`, `Fk_Sucursal_Codigo`) REFERENCES `tblbodega` (`idBodega`, `Fk_Sucursal_Codigo`) ON DELETE RESTRICT,
  CONSTRAINT `Fk_Historico_Inventario_Cierre_Inventario` FOREIGN KEY (`Fk_Cierre_Inventario_Codigo`) REFERENCES `tblcierreinventario` (`idCierreInventario`) ON DELETE RESTRICT,
  CONSTRAINT `Fk_Historico_Inventario_Producto` FOREIGN KEY (`Fk_Producto_Codigo`) REFERENCES `tblproducto` (`idProducto`) ON DELETE RESTRICT,
  CONSTRAINT `Fk_Historico_Inventario_Stock` FOREIGN KEY (`Fk_Stock_Codigo`) REFERENCES `tblstock` (`idStock`) ON DELETE RESTRICT,
  CONSTRAINT `ckHistoricoEstadoCompra` CHECK ((`estadoCompraStock` in (0,1))),
  CONSTRAINT `ckHistoricoEstadoVenta` CHECK ((`estadoVentaStock` in (0,1))),
  CONSTRAINT `ckHistoricoStockActualNoNegativo` CHECK ((`stockActualStock` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblhistoricoinventario`
--

LOCK TABLES `tblhistoricoinventario` WRITE;
/*!40000 ALTER TABLE `tblhistoricoinventario` DISABLE KEYS */;
INSERT INTO `tblhistoricoinventario` VALUES (1,1,1,1,1,1,135,135,120,135,35,20,400,265,12,1,1,'2026-10-31','2026-11-14 18:34:39','2026-11-14 18:34:39'),(2,2,2,2,2,2,82,82,80,82,20,18,250,168,5,1,1,'2026-10-31','2026-11-14 18:34:39','2026-11-14 18:34:39'),(3,3,3,3,3,3,50,50,60,50,15,25,220,170,3,1,1,'2026-10-31','2026-11-14 18:34:39','2026-11-14 18:34:39'),(4,4,4,4,4,4,160,160,150,160,50,40,580,420,20,1,0,'2026-10-31','2026-11-14 18:34:39','2026-11-14 18:34:39'),(5,5,5,5,5,5,100,100,95,100,20,15,330,230,8,0,1,'2026-10-31','2026-11-14 18:34:39','2026-11-14 18:34:39');
/*!40000 ALTER TABLE `tblhistoricoinventario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblhoraextra`
--

DROP TABLE IF EXISTS `tblhoraextra`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblhoraextra` (
  `idHoraExtra` int NOT NULL AUTO_INCREMENT,
  `idPercepcionDeduccion` int NOT NULL,
  `idEmpleado` int NOT NULL,
  `idAsistenciaEmpleado` int NOT NULL,
  `duracionHoraExtra` int NOT NULL,
  `valorHoraOrdinariaHoraExtra` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `porcentajeRecargoHoraExtra` decimal(3,2) NOT NULL DEFAULT '0.50',
  `totalPagoHoraExtra` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `estadoHoraExtra` enum('PENDIENTE','APROBADA','RECHAZADA','PAGADA') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'PENDIENTE',
  `idUsuarioAprueba` int DEFAULT NULL,
  `fechaAprobacionHoraExtra` datetime DEFAULT NULL,
  `idNominaEncabezado` int DEFAULT NULL,
  `observacionHoraExtra` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idHoraExtra`),
  UNIQUE KEY `uqHoraExtraAsistencia` (`idAsistenciaEmpleado`),
  KEY `Fk_HoraExtra_PercepcionDeduccion` (`idPercepcionDeduccion`),
  KEY `Fk_HoraExtra_Empleado` (`idEmpleado`),
  KEY `Fk_HoraExtra_UsuarioAprueba` (`idUsuarioAprueba`),
  KEY `Fk_HoraExtra_NominaEncabezado` (`idNominaEncabezado`),
  CONSTRAINT `Fk_HoraExtra_AsistenciaEmpleado` FOREIGN KEY (`idAsistenciaEmpleado`) REFERENCES `tblasistenciaempleado` (`idAsistenciaEmpleado`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `Fk_HoraExtra_Empleado` FOREIGN KEY (`idEmpleado`) REFERENCES `tblempleado` (`idEmpleado`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `Fk_HoraExtra_NominaEncabezado` FOREIGN KEY (`idNominaEncabezado`) REFERENCES `tblnominaencabezado` (`idNominaEncabezado`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `Fk_HoraExtra_PercepcionDeduccion` FOREIGN KEY (`idPercepcionDeduccion`) REFERENCES `tblpercepciondeduccion` (`idPercepcionDeduccion`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `Fk_HoraExtra_UsuarioAprueba` FOREIGN KEY (`idUsuarioAprueba`) REFERENCES `tblusuario` (`idUsuario`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `ckHoraExtraDuracion` CHECK (((`duracionHoraExtra` > 0) and (`duracionHoraExtra` <= 360))),
  CONSTRAINT `ckHoraExtraRecargo` CHECK ((`porcentajeRecargoHoraExtra` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblhoraextra`
--

LOCK TABLES `tblhoraextra` WRITE;
/*!40000 ALTER TABLE `tblhoraextra` DISABLE KEYS */;
INSERT INTO `tblhoraextra` VALUES (1,1,20,1,120,27.0833,0.50,81.2499,'PAGADA',1,'2026-06-16 09:00:00',1,'Cierre de proyecto',1,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(2,1,20,2,60,27.0833,0.50,40.6250,'PAGADA',1,'2026-07-16 09:00:00',2,NULL,1,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(3,1,20,3,90,27.0833,0.50,60.9374,'PAGADA',1,'2026-08-17 09:00:00',3,NULL,1,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(4,1,20,4,150,27.0833,0.50,101.5624,'PAGADA',2,'2026-09-16 09:00:00',4,'Cierre de planilla',1,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(5,1,20,5,120,27.0833,0.50,81.2499,'APROBADA',1,'2026-10-16 09:00:00',5,NULL,1,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(6,1,1,8,60,31.2500,0.50,46.8750,'APROBADA',1,'2026-11-05 09:00:00',NULL,'Apoyo en cierre mensual',1,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(7,1,1,9,120,31.2500,0.50,93.7500,'PENDIENTE',NULL,NULL,NULL,'Revisión de planilla',1,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(8,1,3,12,90,31.2500,0.50,70.3125,'APROBADA',1,'2026-11-04 09:00:00',NULL,'Atención de auditoría',1,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(9,1,13,18,180,31.2500,0.50,140.6250,'PENDIENTE',NULL,NULL,NULL,'Reunión con proveedores',1,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(10,1,21,21,60,30.0000,0.50,45.0000,'APROBADA',1,'2026-11-06 09:00:00',NULL,'Cierre contable',1,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(11,1,22,22,120,24.1667,0.50,72.5001,'RECHAZADA',3,'2026-11-05 09:00:00',NULL,'No fue autorizada previamente',1,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(12,1,24,23,120,22.9167,0.50,68.7501,'PENDIENTE',NULL,NULL,NULL,'Despacho extraordinario',1,'2026-11-14 18:34:38','2026-11-14 18:34:38');
/*!40000 ALTER TABLE `tblhoraextra` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblimpuesto`
--

DROP TABLE IF EXISTS `tblimpuesto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblimpuesto` (
  `idImpuesto` int NOT NULL AUTO_INCREMENT,
  `nombreImpuesto` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcionImpuesto` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tipoImpuesto` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `operacionImpuesto` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'AMBAS',
  `valorImpuesto` decimal(7,4) NOT NULL,
  `periodicidadImpuesto` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `idCuentaAcreditableImpuesto` int DEFAULT NULL,
  `idCuentaPorPagarImpuesto` int DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idImpuesto`),
  KEY `Fk_Impuesto_CuentaAcreditable` (`idCuentaAcreditableImpuesto`),
  KEY `Fk_Impuesto_CuentaPorPagar` (`idCuentaPorPagarImpuesto`),
  KEY `idxImpuestoTipo` (`tipoImpuesto`),
  KEY `idxImpuestoOperacion` (`operacionImpuesto`),
  CONSTRAINT `Fk_Impuesto_CuentaAcreditable` FOREIGN KEY (`idCuentaAcreditableImpuesto`) REFERENCES `tblcuenta` (`idCuenta`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `Fk_Impuesto_CuentaPorPagar` FOREIGN KEY (`idCuentaPorPagarImpuesto`) REFERENCES `tblcuenta` (`idCuenta`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `ckImpuestoOperacion` CHECK ((`operacionImpuesto` in (_utf8mb4'COMPRA',_utf8mb4'VENTA',_utf8mb4'AMBAS',_utf8mb4'PLANILLA',_utf8mb4'PERIODO'))),
  CONSTRAINT `ckImpuestoPeriodicidad` CHECK ((`periodicidadImpuesto` in (_utf8mb4'MENSUAL',_utf8mb4'TRIMESTRAL',_utf8mb4'ANUAL',_utf8mb4'POR_EVENTO'))),
  CONSTRAINT `ckImpuestoTipo` CHECK ((`tipoImpuesto` in (_utf8mb4'CONSUMO',_utf8mb4'RENTA',_utf8mb4'PATRIMONIO',_utf8mb4'CONTRIBUCION',_utf8mb4'OTRO')))
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblimpuesto`
--

LOCK TABLES `tblimpuesto` WRITE;
/*!40000 ALTER TABLE `tblimpuesto` DISABLE KEYS */;
INSERT INTO `tblimpuesto` VALUES (1,'IVA','Impuesto al Valor Agregado (Decreto 27-92)','CONSUMO','AMBAS',0.1200,'MENSUAL',29,91,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(2,'IVA Pequeño Contribuyente','IVA Régimen Pequeño Contribuyente (Decreto 27-92)','CONSUMO','VENTA',0.0500,'MENSUAL',NULL,91,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(3,'ISR Utilidades','ISR Régimen sobre las Utilidades (Decreto 10-2012)','RENTA','PERIODO',0.2500,'ANUAL',NULL,90,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(4,'ISR Simplificado','ISR Régimen Opcional Simplificado (Decreto 10-2012)','RENTA','PERIODO',0.0000,'ANUAL',NULL,90,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(5,'ISR Rentas del Trabajo','ISR Rentas del Trabajo en relación de dependencia','RENTA','PLANILLA',0.0000,'MENSUAL',NULL,90,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(6,'ISO','Impuesto de Solidaridad (Decreto 73-2008)','OTRO','PERIODO',0.0100,'TRIMESTRAL',NULL,NULL,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(7,'IUSI','Impuesto Único Sobre Inmuebles (Decreto 15-98)','PATRIMONIO','PERIODO',0.0000,'TRIMESTRAL',NULL,NULL,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(8,'Timbres Fiscales','Impuesto de Timbres Fiscales (Decreto 37-92)','OTRO','AMBAS',0.0300,'POR_EVENTO',NULL,NULL,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(9,'IGSS Patronal','Cuota patronal IGSS','CONTRIBUCION','PLANILLA',0.1067,'MENSUAL',NULL,92,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(10,'IGSS Laboral','Cuota laboral IGSS','CONTRIBUCION','PLANILLA',0.0483,'MENSUAL',NULL,92,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(11,'IRTRA','Cuota patronal IRTRA','CONTRIBUCION','PLANILLA',0.0100,'MENSUAL',NULL,93,'2026-11-14 18:34:36','2026-11-14 18:34:36');
/*!40000 ALTER TABLE `tblimpuesto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblimpuestotramo`
--

DROP TABLE IF EXISTS `tblimpuestotramo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblimpuestotramo` (
  `idImpuestoTramo` int NOT NULL AUTO_INCREMENT,
  `idImpuesto` int NOT NULL,
  `montoDesdeImpuestoTramo` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `montoHastaImpuestoTramo` decimal(12,4) DEFAULT NULL,
  `tasaImpuestoTramo` decimal(5,4) NOT NULL,
  `importeFijoImpuestoTramo` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idImpuestoTramo`),
  UNIQUE KEY `uqImpuestoTramo` (`idImpuesto`,`montoDesdeImpuestoTramo`),
  KEY `idxImpuestoTramoImpuesto` (`idImpuesto`),
  CONSTRAINT `Fk_ImpuestoTramo_Impuesto` FOREIGN KEY (`idImpuesto`) REFERENCES `tblimpuesto` (`idImpuesto`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ckImpuestoTramoRango` CHECK (((`montoHastaImpuestoTramo` is null) or (`montoHastaImpuestoTramo` > `montoDesdeImpuestoTramo`)))
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblimpuestotramo`
--

LOCK TABLES `tblimpuestotramo` WRITE;
/*!40000 ALTER TABLE `tblimpuestotramo` DISABLE KEYS */;
INSERT INTO `tblimpuestotramo` VALUES (1,4,0.0000,30000.0000,0.0500,0.0000,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(2,4,30000.0000,NULL,0.0700,1500.0000,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(3,5,0.0000,300000.0000,0.0500,0.0000,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(4,5,300000.0000,NULL,0.0700,15000.0000,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(5,7,0.0000,2000.0000,0.0000,0.0000,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(6,7,2000.0000,20000.0000,0.0020,0.0000,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(7,7,20000.0000,70000.0000,0.0060,36.0000,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(8,7,70000.0000,NULL,0.0090,336.0000,'2026-11-14 18:34:36','2026-11-14 18:34:36');
/*!40000 ALTER TABLE `tblimpuestotramo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblincidenciatransporte`
--

DROP TABLE IF EXISTS `tblincidenciatransporte`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblincidenciatransporte` (
  `idIncidenciaTransporte` int NOT NULL AUTO_INCREMENT,
  `Fk_Servicio_Transporte_Externo_Codigo` int NOT NULL,
  `codigoIncidenciaTransporte` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fechaIncidenciaTransporte` datetime NOT NULL,
  `tipoIncidenciaTransporte` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcionIncidenciaTransporte` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `responsableIncidenciaTransporte` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `estadoIncidenciaTransporte` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Pendiente',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idIncidenciaTransporte`),
  UNIQUE KEY `uqIncidenciaCodigo` (`codigoIncidenciaTransporte`),
  KEY `Fk_Incidencia_Transporte_Servicio_Transporte_Externo` (`Fk_Servicio_Transporte_Externo_Codigo`),
  CONSTRAINT `Fk_Incidencia_Transporte_Servicio_Transporte_Externo` FOREIGN KEY (`Fk_Servicio_Transporte_Externo_Codigo`) REFERENCES `tblserviciotransporteexterno` (`idServicioTransporteExterno`) ON DELETE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblincidenciatransporte`
--

LOCK TABLES `tblincidenciatransporte` WRITE;
/*!40000 ALTER TABLE `tblincidenciatransporte` DISABLE KEYS */;
INSERT INTO `tblincidenciatransporte` VALUES (1,1,'INC-2601','2026-10-25 09:20:00','Demora por tráfico','Se registraron 25 minutos de atraso en Calzada Roosevelt.','María Fernanda Solís','Resuelta','2026-11-14 18:34:39','2026-11-14 18:34:39'),(2,2,'INC-2602','2026-10-26 09:00:00','Revisión documental','Se verificó la guía de remisión antes de ingresar al destino.','Carlos Alberto Rivera','Resuelta','2026-11-14 18:34:39','2026-11-14 18:34:39'),(3,3,'INC-2603','2026-10-27 11:05:00','Variación de temperatura','La unidad registró 6 grados y se ajustó el sistema de refrigeración.','Andrea Lucía Méndez','Resuelta','2026-11-14 18:34:39','2026-11-14 18:34:39'),(4,4,'INC-2604','2026-11-11 08:45:00','Tránsito lento','Congestión vehicular en carretera; entrega todavía pendiente.','José Roberto Aguilar','En seguimiento','2026-11-14 18:34:39','2026-11-14 18:34:39'),(5,5,'INC-2605','2026-11-10 14:35:00','Reprogramación de carga','El área de despacho solicitó mover el horario de recolección.','Paola Gabriela Morales','Pendiente','2026-11-14 18:34:39','2026-11-14 18:34:39');
/*!40000 ALTER TABLE `tblincidenciatransporte` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblinstructor`
--

DROP TABLE IF EXISTS `tblinstructor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblinstructor` (
  `idInstructor` int NOT NULL AUTO_INCREMENT,
  `nombreInstructor` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `especialidadInstructor` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `correoInstructor` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idInstructor`),
  UNIQUE KEY `uqCorreoInstructor` (`correoInstructor`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblinstructor`
--

LOCK TABLES `tblinstructor` WRITE;
/*!40000 ALTER TABLE `tblinstructor` DISABLE KEYS */;
INSERT INTO `tblinstructor` VALUES (1,'Mario Estuardo Barrios','Seguridad industrial','mbarrios@capacitaciones.gt',1,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(2,'Lucía Fernanda Aguilar','Ofimática y análisis de datos','laguilar@capacitaciones.gt',1,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(3,'Pedro Antonio Sandoval','Servicio al cliente','psandoval@capacitaciones.gt',1,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(4,'Gabriela Noemí Cifuentes','Liderazgo y recursos humanos','gcifuentes@capacitaciones.gt',1,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(5,'Rodrigo Javier Montenegro','Sistemas ERP','rmontenegro@capacitaciones.gt',1,'2026-11-14 18:34:37','2026-11-14 18:34:37');
/*!40000 ALTER TABLE `tblinstructor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbljornada`
--

DROP TABLE IF EXISTS `tbljornada`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbljornada` (
  `idJornada` int NOT NULL AUTO_INCREMENT,
  `nombreJornada` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `horaInicioJornada` time NOT NULL,
  `horaFinJornada` time NOT NULL,
  `minutosToleranciaJornada` int NOT NULL DEFAULT '5',
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idJornada`),
  UNIQUE KEY `uqNombreJornada` (`nombreJornada`),
  CONSTRAINT `ckJornadaHoras` CHECK ((`horaFinJornada` <> `horaInicioJornada`)),
  CONSTRAINT `ckJornadaTolerancia` CHECK ((`minutosToleranciaJornada` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbljornada`
--

LOCK TABLES `tbljornada` WRITE;
/*!40000 ALTER TABLE `tbljornada` DISABLE KEYS */;
INSERT INTO `tbljornada` VALUES (1,'Diurna','08:00:00','17:00:00',5,1,'2026-11-14 18:33:55','2026-11-14 18:33:55'),(2,'Nocturna','19:00:00','05:00:00',5,1,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(3,'Mixta','13:00:00','21:00:00',10,1,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(4,'Medio Tiempo','08:00:00','12:00:00',5,1,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(5,'Matutina','06:00:00','14:00:00',5,1,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(6,'Vespertina','14:00:00','22:00:00',10,1,'2026-11-14 18:34:37','2026-11-14 18:34:37');
/*!40000 ALTER TABLE `tbljornada` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbllinea`
--

DROP TABLE IF EXISTS `tbllinea`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbllinea` (
  `idLinea` int NOT NULL AUTO_INCREMENT,
  `nombreLinea` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `porcentajeComisionLinea` decimal(3,2) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idLinea`),
  UNIQUE KEY `uqLineaNombre` (`nombreLinea`),
  CONSTRAINT `ckPorcentajeComisionLineaRango` CHECK (((`porcentajeComisionLinea` >= 0.00) and (`porcentajeComisionLinea` <= 0.99)))
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbllinea`
--

LOCK TABLES `tbllinea` WRITE;
/*!40000 ALTER TABLE `tbllinea` DISABLE KEYS */;
INSERT INTO `tbllinea` VALUES (1,'Tradicional',0.05,'2026-11-14 18:34:39','2026-11-14 18:34:39'),(2,'Parrillera',0.07,'2026-11-14 18:34:39','2026-11-14 18:34:39'),(3,'Premium',0.09,'2026-11-14 18:34:39','2026-11-14 18:34:39'),(4,'Familiar',0.06,'2026-11-14 18:34:39','2026-11-14 18:34:39'),(5,'Ahumados',0.08,'2026-11-14 18:34:39','2026-11-14 18:34:39'),(6,'FAC-QA Refrigerados',0.00,'2026-11-14 18:34:40','2026-11-14 18:34:40');
/*!40000 ALTER TABLE `tbllinea` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblliquidacion`
--

DROP TABLE IF EXISTS `tblliquidacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblliquidacion` (
  `idLiquidacion` int NOT NULL AUTO_INCREMENT,
  `idEmpresa` int NOT NULL,
  `idEmpleado` int NOT NULL,
  `idBajaEmpleado` int NOT NULL,
  `fechaIngresoLiquidacion` date NOT NULL,
  `fechaBajaLiquidacion` date NOT NULL,
  `diasLaboradosLiquidacion` int NOT NULL,
  `salarioMensualLiquidacion` decimal(12,4) NOT NULL,
  `salarioPromedioLiquidacion` decimal(12,4) NOT NULL,
  `baseIndemnizacionLiquidacion` decimal(12,4) NOT NULL,
  `salarioDiaLiquidacion` decimal(12,4) NOT NULL,
  `totalPercepcionLiquidacion` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `totalDeduccionLiquidacion` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `totalNetoLiquidacion` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `parametrosUsadosLiquidacion` text COLLATE utf8mb4_unicode_ci,
  `numeroFiniquitoLiquidacion` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fechaEmisionFiniquitoLiquidacion` date DEFAULT NULL,
  `montoLetrasFiniquitoLiquidacion` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `estadoLiquidacion` enum('BORRADOR','APROBADA','PAGADA','ANULADA') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'BORRADOR',
  `idUsuarioCrea` int NOT NULL,
  `idUsuarioAprueba` int NOT NULL,
  `fechaAprobacionLiquidacion` datetime DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idLiquidacion`),
  UNIQUE KEY `uqNumeroFiniquitoLiquidacion` (`numeroFiniquitoLiquidacion`),
  KEY `Fk_Liquidacion_Empleado` (`idEmpleado`),
  KEY `Fk_Liquidacion_BajaEmpleado` (`idBajaEmpleado`),
  KEY `Fk_Liquidacion_UsuarioCrea` (`idUsuarioCrea`),
  KEY `Fk_Liquidacion_UsuarioAprueba` (`idUsuarioAprueba`),
  KEY `idxLiquidacionEmpresaEstado` (`idEmpresa`,`estadoLiquidacion`),
  CONSTRAINT `Fk_Liquidacion_BajaEmpleado` FOREIGN KEY (`idBajaEmpleado`) REFERENCES `tblbajaempleado` (`idBajaEmpleado`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `Fk_Liquidacion_Empleado` FOREIGN KEY (`idEmpleado`) REFERENCES `tblempleado` (`idEmpleado`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `Fk_Liquidacion_Empresa` FOREIGN KEY (`idEmpresa`) REFERENCES `tblempresa` (`idEmpresa`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `Fk_Liquidacion_UsuarioAprueba` FOREIGN KEY (`idUsuarioAprueba`) REFERENCES `tblusuario` (`idUsuario`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `Fk_Liquidacion_UsuarioCrea` FOREIGN KEY (`idUsuarioCrea`) REFERENCES `tblusuario` (`idUsuario`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `ckLiquidacionDias` CHECK ((`diasLaboradosLiquidacion` >= 0)),
  CONSTRAINT `ckLiquidacionFechas` CHECK ((`fechaBajaLiquidacion` >= `fechaIngresoLiquidacion`))
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblliquidacion`
--

LOCK TABLES `tblliquidacion` WRITE;
/*!40000 ALTER TABLE `tblliquidacion` DISABLE KEYS */;
INSERT INTO `tblliquidacion` VALUES (1,1,20,1,'2024-03-01','2026-12-15',1019,6500.0000,6500.0000,6500.0000,216.6667,267.1233,0.0000,267.1233,'{\"DIAS_BASE_INDEMNIZACION\":{\"valor\":365,\"origen\":\"LEY\"},\"MESES_PROMEDIO_INDEMNIZACION\":{\"valor\":6,\"origen\":\"LEY\"}}',NULL,NULL,NULL,'BORRADOR',1,2,NULL,1,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(2,1,21,2,'2023-07-17','2026-12-18',1250,7200.0000,7200.0000,7200.0000,240.0000,24657.5342,0.0000,24657.5342,'{\"DIAS_BASE_INDEMNIZACION\":{\"valor\":365,\"origen\":\"LEY\"},\"MESES_PROMEDIO_INDEMNIZACION\":{\"valor\":6,\"origen\":\"LEY\"}}','FIN-2026-0001','2026-12-18','Veinticuatro mil seiscientos cincuenta y siete quetzales con 53/100','PAGADA',1,2,'2026-12-18 10:00:00',1,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(3,1,22,3,'2025-02-03','2026-12-22',687,5800.0000,5800.0000,5800.0000,193.3333,349.5890,0.0000,349.5890,'{\"DIAS_BASE_INDEMNIZACION\":{\"valor\":365,\"origen\":\"LEY\"},\"MESES_PROMEDIO_INDEMNIZACION\":{\"valor\":6,\"origen\":\"LEY\"}}','FIN-2026-0002','2026-12-22','Trescientos cuarenta y nueve quetzales con 59/100','APROBADA',1,2,'2026-12-22 09:30:00',1,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(4,1,23,4,'2022-11-14','2026-12-28',1505,6000.0000,6000.0000,6000.0000,200.0000,460.2740,0.0000,460.2740,'{\"DIAS_BASE_INDEMNIZACION\":{\"valor\":365,\"origen\":\"LEY\"},\"MESES_PROMEDIO_INDEMNIZACION\":{\"valor\":6,\"origen\":\"LEY\"}}','FIN-2026-0003','2026-12-28','Cuatrocientos sesenta quetzales con 27/100','APROBADA',1,2,'2026-12-28 09:00:00',1,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(5,1,24,5,'2025-06-02','2026-12-31',577,5500.0000,5500.0000,5500.0000,183.3333,467.1233,0.0000,467.1233,'{\"DIAS_BASE_INDEMNIZACION\":{\"valor\":365,\"origen\":\"LEY\"},\"MESES_PROMEDIO_INDEMNIZACION\":{\"valor\":6,\"origen\":\"LEY\"}}','FIN-2026-0004','2026-12-31','Cuatrocientos sesenta y siete quetzales con 12/100','ANULADA',1,2,'2026-12-31 09:00:00',1,'2026-11-14 18:34:38','2026-11-14 18:34:38');
/*!40000 ALTER TABLE `tblliquidacion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbllistapreciodetalle`
--

DROP TABLE IF EXISTS `tbllistapreciodetalle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbllistapreciodetalle` (
  `idListaPrecioDetalle` int NOT NULL AUTO_INCREMENT,
  `idListaPrecioEncabezado` int NOT NULL,
  `idProducto` int NOT NULL,
  `precioUnitarioListaPrecioDetalle` decimal(12,4) NOT NULL,
  `activoListaPrecioDetalle` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idListaPrecioEncabezado`,`idListaPrecioDetalle`),
  UNIQUE KEY `uqListaPrecioDetalleListaPrecioEncabezadoCodigoProductoCodigo` (`idListaPrecioEncabezado`,`idProducto`),
  UNIQUE KEY `uqListaPrecioDetalleId` (`idListaPrecioDetalle`),
  KEY `idxListaPrecioDetalleProductoCodigo` (`idProducto`),
  CONSTRAINT `Fk_ListaPrecioDetalle_ListaPrecioEncabezado` FOREIGN KEY (`idListaPrecioEncabezado`) REFERENCES `tbllistaprecioencabezado` (`idListaPrecioEncabezado`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `Fk_ListaPrecioDetalle_Producto` FOREIGN KEY (`idProducto`) REFERENCES `tblproducto` (`idProducto`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `ckListaPrecioDetalleactivoListaPrecioDetalleBooleano` CHECK ((`activoListaPrecioDetalle` in (0,1))),
  CONSTRAINT `ckListaPrecioDetallePrecioNoNegativo` CHECK ((`precioUnitarioListaPrecioDetalle` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbllistapreciodetalle`
--

LOCK TABLES `tbllistapreciodetalle` WRITE;
/*!40000 ALTER TABLE `tbllistapreciodetalle` DISABLE KEYS */;
INSERT INTO `tbllistapreciodetalle` VALUES (2,1,11,30.0000,1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(5,1,12,32.0000,1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(8,1,13,34.0000,1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(11,1,14,36.0000,1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(14,1,15,38.0000,1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(17,1,16,40.0000,1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(20,1,17,42.0000,1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(23,1,18,44.0000,1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(3,2,11,12.0000,1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(6,2,12,14.0000,1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(9,2,13,16.0000,1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(12,2,14,18.0000,1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(15,2,15,20.0000,1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(18,2,16,22.0000,1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(21,2,17,24.0000,1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(24,2,18,26.0000,1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(1,3,11,4.0000,1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(4,3,12,4.2500,1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(7,3,13,4.5000,1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(10,3,14,4.7500,1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(13,3,15,5.0000,1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(16,3,16,5.2500,1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(19,3,17,5.5000,1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(22,3,18,5.7500,1,'2026-11-14 18:34:40','2026-11-14 18:34:40');
/*!40000 ALTER TABLE `tbllistapreciodetalle` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbllistaprecioencabezado`
--

DROP TABLE IF EXISTS `tbllistaprecioencabezado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbllistaprecioencabezado` (
  `idListaPrecioEncabezado` int NOT NULL AUTO_INCREMENT,
  `idTipoCliente` int NOT NULL,
  `codigoListaPrecioEncabezado` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nombreListaPrecioEncabezado` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `idMoneda` bigint NOT NULL,
  `vigenteDesdeListaPrecioEncabezado` date NOT NULL,
  `vigenteHastaListaPrecioEncabezado` date DEFAULT NULL,
  `activoListaPrecioEncabezado` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idListaPrecioEncabezado`),
  UNIQUE KEY `uqListaPrecioEncabezadocodigo` (`codigoListaPrecioEncabezado`),
  KEY `idxListaPrecioEncabezadoTipoCliente` (`idTipoCliente`),
  KEY `idxListaPrecioEncabezadoMonedaCodigo` (`idMoneda`),
  CONSTRAINT `Fk_ListaPrecioEncabezado_Moneda` FOREIGN KEY (`idMoneda`) REFERENCES `tblmoneda` (`idMoneda`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `Fk_ListaPrecioEncabezado_TipoCliente` FOREIGN KEY (`idTipoCliente`) REFERENCES `tbltipocliente` (`idTipoCliente`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `ckListaPrecioEncabezadoactivoListaPrecioEncabezadoBooleano` CHECK ((`activoListaPrecioEncabezado` in (0,1))),
  CONSTRAINT `ckListaPrecioEncabezadoFechasCoherentes` CHECK ((`vigenteHastaListaPrecioEncabezado` >= `vigenteDesdeListaPrecioEncabezado`))
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbllistaprecioencabezado`
--

LOCK TABLES `tbllistaprecioencabezado` WRITE;
/*!40000 ALTER TABLE `tbllistaprecioencabezado` DISABLE KEYS */;
INSERT INTO `tbllistaprecioencabezado` VALUES (1,1,'FAC-QA-MIN','Auditoría minorista GTQ',1,'2026-11-14',NULL,1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(2,1,'FAC-QA-MAY','Auditoría mayorista GTQ',1,'2026-11-14',NULL,1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(3,1,'FAC-QA-USD','Auditoría USD',2,'2026-11-14',NULL,1,'2026-11-14 18:34:40','2026-11-14 18:34:40');
/*!40000 ALTER TABLE `tbllistaprecioencabezado` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblloteproducto`
--

DROP TABLE IF EXISTS `tblloteproducto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblloteproducto` (
  `idLoteProducto` bigint NOT NULL AUTO_INCREMENT,
  `codigoLoteProducto` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Fk_Producto_Codigo` int NOT NULL,
  `descripcionLoteProducto` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `requiereFrioLoteProducto` tinyint(1) NOT NULL DEFAULT '1',
  `fechaFabricacionLoteProducto` date NOT NULL,
  `fechaVencimientoLoteProducto` date NOT NULL,
  `tempRequeridaMinLoteProducto` decimal(5,2) NOT NULL,
  `tempRequeridaMaxLoteProducto` decimal(5,2) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idLoteProducto`),
  UNIQUE KEY `uqCodigoLoteProducto` (`codigoLoteProducto`),
  UNIQUE KEY `uqLoteProductoRelacion` (`idLoteProducto`,`Fk_Producto_Codigo`),
  KEY `idxLoteProducto` (`Fk_Producto_Codigo`),
  CONSTRAINT `Fk_Lote_Producto_Producto` FOREIGN KEY (`Fk_Producto_Codigo`) REFERENCES `tblproducto` (`idProducto`) ON DELETE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblloteproducto`
--

LOCK TABLES `tblloteproducto` WRITE;
/*!40000 ALTER TABLE `tblloteproducto` DISABLE KEYS */;
INSERT INTO `tblloteproducto` VALUES (1,'L-SAL-261001',1,'Producción de salchicha vienesa, turno matutino',1,'2026-10-01','2026-12-15',0.00,5.00,'2026-11-14 18:34:39','2026-11-14 18:34:39'),(2,'L-CHO-261004',2,'Producción de chorizo parrillero de octubre',1,'2026-10-04','2026-12-08',0.00,5.00,'2026-11-14 18:34:39','2026-11-14 18:34:39'),(3,'L-JAM-261006',3,'Jamón de pierna rebanado y empacado al vacío',1,'2026-10-06','2026-12-20',0.00,5.00,'2026-11-14 18:34:39','2026-11-14 18:34:39'),(4,'L-MOR-261008',4,'Mortadela familiar, lote de distribución nacional',1,'2026-10-08','2026-12-18',0.00,5.00,'2026-11-14 18:34:39','2026-11-14 18:34:39'),(5,'L-TOC-261010',5,'Tocino ahumado, producción de octubre',1,'2026-10-10','2027-01-15',-1.00,5.00,'2026-11-14 18:34:39','2026-11-14 18:34:39');
/*!40000 ALTER TABLE `tblloteproducto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblmaestrovidautil`
--

DROP TABLE IF EXISTS `tblmaestrovidautil`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblmaestrovidautil` (
  `idMaestroVidaUtil` int NOT NULL AUTO_INCREMENT,
  `codigoMaestroVidaUtil` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nombreMaestroVidaUtil` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `cantidadMesesMaestroVidaUtil` int NOT NULL,
  `tasaDepreciacionMaestroVidaUtil` decimal(3,2) NOT NULL DEFAULT '0.20',
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idMaestroVidaUtil`),
  UNIQUE KEY `uqMaestroVidaUtilCodigo` (`codigoMaestroVidaUtil`),
  CONSTRAINT `ckMaestroVidaUtilMeses` CHECK ((`cantidadMesesMaestroVidaUtil` > 0))
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblmaestrovidautil`
--

LOCK TABLES `tblmaestrovidautil` WRITE;
/*!40000 ALTER TABLE `tblmaestrovidautil` DISABLE KEYS */;
INSERT INTO `tblmaestrovidautil` VALUES (1,'EDIFICIO','Edificios e instalaciones',240,0.05,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(2,'MAQUINARIA','Maquinaria y equipo de planta',120,0.20,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(3,'VEHICULO','Equipo de transporte',60,0.20,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(4,'MOBILIARIO','Mobiliario y equipo de oficina',60,0.20,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(5,'EQ_COMPUTO','Equipo electronico de computo',36,0.33,1,'2026-11-14 18:34:36','2026-11-14 18:34:36');
/*!40000 ALTER TABLE `tblmaestrovidautil` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblmarca`
--

DROP TABLE IF EXISTS `tblmarca`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblmarca` (
  `idMarca` int NOT NULL AUTO_INCREMENT,
  `nombreMarca` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `porcentajeComisionMarca` decimal(3,2) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idMarca`),
  UNIQUE KEY `uqMarcaNombre` (`nombreMarca`),
  CONSTRAINT `ckPorcentajeComisionMarcaRango` CHECK (((`porcentajeComisionMarca` >= 0.00) and (`porcentajeComisionMarca` <= 0.99)))
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblmarca`
--

LOCK TABLES `tblmarca` WRITE;
/*!40000 ALTER TABLE `tblmarca` DISABLE KEYS */;
INSERT INTO `tblmarca` VALUES (1,'Montesol',0.06,'2026-11-14 18:34:39','2026-11-14 18:34:39'),(2,'Del Prado',0.07,'2026-11-14 18:34:39','2026-11-14 18:34:39'),(3,'La Hacienda',0.08,'2026-11-14 18:34:39','2026-11-14 18:34:39'),(4,'Buen Sabor',0.05,'2026-11-14 18:34:39','2026-11-14 18:34:39'),(5,'Sierra Fresca',0.09,'2026-11-14 18:34:39','2026-11-14 18:34:39'),(6,'FAC-QA Marca',0.00,'2026-11-14 18:34:40','2026-11-14 18:34:40');
/*!40000 ALTER TABLE `tblmarca` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblmetodopago`
--

DROP TABLE IF EXISTS `tblmetodopago`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblmetodopago` (
  `idMetodoPago` int NOT NULL AUTO_INCREMENT,
  `nombreMetodoPago` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcionMetodoPago` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idMetodoPago`),
  UNIQUE KEY `uqNombreMetodoPago` (`nombreMetodoPago`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblmetodopago`
--

LOCK TABLES `tblmetodopago` WRITE;
/*!40000 ALTER TABLE `tblmetodopago` DISABLE KEYS */;
INSERT INTO `tblmetodopago` VALUES (1,'Efectivo','Pago en efectivo en caja de la empresa',1,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(2,'Transferencia bancaria','Acreditación directa a la cuenta del empleado',1,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(3,'Cheque','Pago mediante cheque a nombre del empleado',1,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(4,'Depósito monetario','Depósito en cuenta bancaria del empleado',1,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(5,'Tarjeta de nómina','Acreditación en tarjeta de débito de nómina',1,'2026-11-14 18:34:37','2026-11-14 18:34:37');
/*!40000 ALTER TABLE `tblmetodopago` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblmodulo`
--

DROP TABLE IF EXISTS `tblmodulo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblmodulo` (
  `idModulo` int NOT NULL AUTO_INCREMENT,
  `nombreModulo` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcionModulo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idModulo`),
  UNIQUE KEY `uqNombreModulo` (`nombreModulo`)
) ENGINE=InnoDB AUTO_INCREMENT=10001 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblmodulo`
--

LOCK TABLES `tblmodulo` WRITE;
/*!40000 ALTER TABLE `tblmodulo` DISABLE KEYS */;
INSERT INTO `tblmodulo` VALUES (1,'Producción','Módulo de control de producción de embutidos',1,'2026-09-17 20:07:07','2026-09-17 20:07:07'),(2,'Inventario','Módulo de control de materia prima y producto terminado',1,'2026-09-17 20:07:07','2026-09-20 11:29:01'),(4,'Seguridad','Módulo de administración y seguridad del sistema',1,'2026-09-17 20:07:07','2026-09-17 20:07:07'),(13,'Pruebas','Esto es una prueba controlada por parte de Seguridad.',1,'2026-09-24 05:44:26','2026-09-24 05:44:26'),(5000,'Logística','Gestión de inventarios, bodegas, sucursales y transporte de embutidos.',1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(6000,'Compras y Cuentas por Pagar','Gestión de compras y cuentas por pagar',1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(7000,'Ventas','Módulo de ventas: clientes, vendedores, listas de precio, cotizaciones, pedidos, facturación, cuentas por cobrar, recibos, depósitos, comisiones y cierres',1,'2026-09-17 20:07:07','2026-11-14 18:34:40'),(8000,'Bancos','Modulo bancario del sistema de Enbutidos S.A.',1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(9000,'Recursos Humanos','Módulo de administración del personal: empleados, asistencia, permisos, capacitaciones, desempeño, nómina y liquidaciones',1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(10000,'Contabilidad','Módulo de Contabilidad',1,'2026-11-14 18:34:40','2026-11-14 18:34:40');
/*!40000 ALTER TABLE `tblmodulo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblmodulocontable`
--

DROP TABLE IF EXISTS `tblmodulocontable`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblmodulocontable` (
  `idModuloContable` int NOT NULL AUTO_INCREMENT,
  `nombreModuloContable` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `codigoModuloContable` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `metodoActualizacionModuloContable` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'BATCH',
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idModuloContable`),
  UNIQUE KEY `uqModuloNombre` (`nombreModuloContable`),
  UNIQUE KEY `uqModuloCodigo` (`codigoModuloContable`),
  CONSTRAINT `ckModuloMetodoActualizacion` CHECK ((`metodoActualizacionModuloContable` in (_utf8mb4'LINEA',_utf8mb4'BATCH')))
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblmodulocontable`
--

LOCK TABLES `tblmodulocontable` WRITE;
/*!40000 ALTER TABLE `tblmodulocontable` DISABLE KEYS */;
INSERT INTO `tblmodulocontable` VALUES (1,'Contabilidad','MOD-CONTA','BATCH',1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(2,'Logística','MOD-LOGIS','BATCH',1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(3,'Compras','MOD-COMPR','BATCH',1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(4,'Recursos Humanos','MOD-RRHH','BATCH',1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(5,'Ventas','MOD-VENTA','BATCH',1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(6,'Bancos','MOD-BANCO','BATCH',1,'2026-11-14 18:34:36','2026-11-14 18:34:36');
/*!40000 ALTER TABLE `tblmodulocontable` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblmodulocuentapais`
--

DROP TABLE IF EXISTS `tblmodulocuentapais`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblmodulocuentapais` (
  `idModuloContable` int NOT NULL,
  `idCuenta` int NOT NULL,
  `idPais` int NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idModuloContable`,`idCuenta`,`idPais`),
  KEY `idxModuloCuentaPaisCuenta` (`idCuenta`),
  KEY `idxModuloCuentaPaisPais` (`idPais`),
  CONSTRAINT `Fk_ModuloCuentaPais_Cuenta` FOREIGN KEY (`idCuenta`) REFERENCES `tblcuenta` (`idCuenta`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `Fk_ModuloCuentaPais_Modulo` FOREIGN KEY (`idModuloContable`) REFERENCES `tblmodulocontable` (`idModuloContable`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `Fk_ModuloCuentaPais_Pais` FOREIGN KEY (`idPais`) REFERENCES `tblpais` (`idPais`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblmodulocuentapais`
--

LOCK TABLES `tblmodulocuentapais` WRITE;
/*!40000 ALTER TABLE `tblmodulocuentapais` DISABLE KEYS */;
INSERT INTO `tblmodulocuentapais` VALUES (1,5,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,5,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,5,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,6,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,6,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,6,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,8,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,8,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,8,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,9,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,9,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,9,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,10,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,10,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,10,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,11,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,11,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,11,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,13,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,13,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,13,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,14,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,14,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,14,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,16,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,16,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,16,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,17,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,17,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,17,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,18,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,18,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,18,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,20,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,20,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,20,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,21,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,21,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,21,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,22,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,22,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,22,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,24,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,24,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,24,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,25,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,25,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,25,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,26,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,26,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,26,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,27,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,27,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,27,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,29,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,29,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,29,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,32,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,32,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,32,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,33,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,33,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,33,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,35,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,35,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,35,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,36,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,36,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,36,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,38,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,38,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,38,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,39,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,39,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,39,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,41,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,41,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,41,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,42,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,42,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,42,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,44,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,44,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,44,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,45,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,45,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,45,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,47,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,47,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,47,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,48,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,48,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,48,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,50,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,50,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,50,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,51,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,51,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,51,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,52,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,52,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,52,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,53,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,53,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,53,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,54,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,54,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,54,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,55,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,55,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,55,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,56,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,56,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,56,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,59,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,59,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,59,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,61,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,61,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,61,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,63,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,63,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,63,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,64,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,64,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,64,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,65,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,65,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,65,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,66,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,66,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,66,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,69,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,69,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,69,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,71,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,71,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,71,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,72,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,72,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,72,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,74,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,74,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,74,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,75,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,75,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,75,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,77,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,77,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,77,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,78,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,78,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,78,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,79,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,79,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,79,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,83,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,83,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,83,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,84,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,84,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,84,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,86,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,86,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,86,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,87,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,87,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,87,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,88,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,88,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,88,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,90,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,90,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,90,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,91,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,91,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,91,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,92,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,92,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,92,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,93,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,93,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,93,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,94,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,94,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,94,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,96,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,96,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,96,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,97,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,97,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,97,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,98,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,98,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,98,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,100,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,100,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,100,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,101,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,101,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,101,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,103,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,103,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,103,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,106,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,106,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,106,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,107,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,107,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,107,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,109,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,109,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,109,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,111,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,111,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,111,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,112,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,112,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,112,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,115,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,115,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,115,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,117,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,117,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,117,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,121,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,121,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,121,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,122,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,122,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,122,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,124,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,124,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,124,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,125,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,125,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,125,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,128,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,128,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,128,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,130,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,130,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,130,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,134,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,134,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,134,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,135,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,135,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,135,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,136,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,136,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,136,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,138,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,138,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,138,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,141,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,141,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,141,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,144,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,144,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,144,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,146,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,146,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,146,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,149,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,149,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,149,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,150,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,150,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,150,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,152,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,152,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,152,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,153,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,153,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,153,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,155,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,155,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,155,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,156,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,156,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,156,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,158,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,158,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,158,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,159,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,159,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,159,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,163,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,163,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,163,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,164,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,164,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,164,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,166,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,166,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,166,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,167,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,167,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,167,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,170,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,170,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,170,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,171,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,171,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,171,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,172,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,172,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,172,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,174,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,174,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,174,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,176,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,176,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,176,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,177,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,177,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,177,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,178,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,178,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,178,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,181,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,181,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,181,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,182,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,182,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,182,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,183,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,183,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,183,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,184,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,184,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,184,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,186,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,186,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,186,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,188,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,188,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,188,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,189,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,189,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,189,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,190,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,190,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,190,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,192,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,192,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,192,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,193,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,193,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,193,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,194,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,194,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,194,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,195,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,195,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,195,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,196,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,196,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,196,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,197,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,197,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,197,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,198,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,198,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,198,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,199,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,199,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,199,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,201,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,201,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,201,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,202,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,202,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,202,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,203,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,203,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,203,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,204,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,204,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,204,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,207,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,207,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,207,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,208,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,208,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,208,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,209,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,209,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,209,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,210,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,210,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,210,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,212,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,212,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,212,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,214,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,214,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,214,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,215,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,215,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,215,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,216,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,216,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,216,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,218,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,218,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,218,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,219,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,219,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,219,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,220,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,220,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,220,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,221,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,221,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,221,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,222,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,222,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,222,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,223,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,223,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,223,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,224,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,224,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,224,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,225,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,225,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,225,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,228,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,228,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,228,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,230,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,230,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,230,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,231,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,231,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,231,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,232,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,232,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,232,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,234,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,234,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,234,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,235,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,235,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,235,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,236,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,236,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,236,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,238,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,238,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,238,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,241,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,241,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,241,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,242,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,242,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,242,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,245,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,245,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,245,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,246,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,246,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,246,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,247,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,247,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,247,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,250,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,250,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,250,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,251,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,251,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,251,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,253,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,253,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,253,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,254,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,254,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(1,254,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(2,24,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(2,24,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(2,24,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(2,25,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(2,25,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(2,25,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(2,26,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(2,26,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(2,26,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(2,27,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(2,27,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(2,27,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(2,41,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(2,41,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(2,41,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(2,42,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(2,42,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(2,42,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(2,52,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(2,52,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(2,52,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(2,166,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(2,166,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(2,166,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(2,167,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(2,167,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(2,167,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(3,22,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(3,22,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(3,22,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(3,24,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(3,24,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(3,24,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(3,25,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(3,25,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(3,25,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(3,26,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(3,26,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(3,26,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(3,27,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(3,27,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(3,27,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(3,29,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(3,29,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(3,29,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(3,83,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(3,83,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(3,83,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(3,84,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(3,84,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(3,84,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(3,100,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(3,100,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(3,100,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(3,101,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(3,101,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(3,101,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(3,149,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(3,149,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(3,149,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(3,150,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(3,150,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(3,150,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(3,152,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(3,152,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(3,152,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(3,153,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(3,153,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(3,153,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(3,155,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(3,155,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(3,155,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(3,156,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(3,156,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(3,156,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(3,158,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(3,158,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(3,158,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(3,159,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(3,159,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(3,159,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(3,163,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(3,163,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(3,163,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(3,164,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(3,164,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(3,164,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(3,166,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(3,166,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(3,166,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(3,167,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(3,167,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(3,167,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(4,86,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(4,86,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(4,86,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(4,87,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(4,87,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(4,87,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(4,88,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(4,88,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(4,88,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(4,90,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(4,90,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(4,90,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(4,91,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(4,91,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(4,91,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(4,92,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(4,92,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(4,92,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(4,93,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(4,93,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(4,93,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(4,94,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(4,94,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(4,94,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(4,181,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(4,181,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(4,181,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(4,182,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(4,182,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(4,182,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(4,183,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(4,183,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(4,183,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(4,184,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(4,184,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(4,184,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(4,207,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(4,207,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(4,207,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(4,208,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(4,208,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(4,208,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(4,209,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(4,209,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(4,209,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(4,210,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(4,210,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(4,210,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(5,5,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(5,5,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(5,5,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(5,6,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(5,6,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(5,6,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(5,8,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(5,8,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(5,8,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(5,9,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(5,9,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(5,9,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(5,10,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(5,10,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(5,10,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(5,11,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(5,11,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(5,11,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(5,16,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(5,16,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(5,16,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(5,17,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(5,17,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(5,17,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(5,18,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(5,18,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(5,18,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(5,26,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(5,26,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(5,26,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(5,91,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(5,91,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(5,91,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(5,134,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(5,134,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(5,134,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(5,135,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(5,135,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(5,135,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(5,136,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(5,136,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(5,136,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(5,138,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(5,138,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(5,138,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(5,170,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(5,170,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(5,170,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(5,171,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(5,171,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(5,171,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(5,172,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(5,172,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(5,172,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(6,5,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(6,5,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(6,5,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(6,6,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(6,6,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(6,6,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(6,8,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(6,8,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(6,8,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(6,9,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(6,9,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(6,9,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(6,10,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(6,10,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(6,10,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(6,11,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(6,11,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(6,11,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(6,13,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(6,13,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(6,13,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(6,14,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(6,14,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(6,14,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(6,16,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(6,16,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(6,16,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(6,17,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(6,17,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(6,17,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(6,18,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(6,18,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(6,18,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(6,83,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(6,83,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(6,83,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(6,84,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(6,84,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(6,84,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(6,96,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(6,96,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(6,96,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(6,97,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(6,97,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(6,97,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(6,98,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(6,98,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(6,98,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(6,106,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(6,106,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(6,106,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(6,107,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(6,107,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(6,107,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(6,141,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(6,141,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(6,141,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(6,228,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(6,228,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(6,228,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(6,230,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(6,230,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(6,230,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(6,231,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(6,231,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(6,231,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(6,232,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(6,232,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(6,232,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(6,234,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(6,234,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(6,234,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(6,235,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(6,235,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(6,235,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(6,236,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(6,236,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(6,236,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(6,238,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(6,238,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(6,238,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36');
/*!40000 ALTER TABLE `tblmodulocuentapais` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblmoneda`
--

DROP TABLE IF EXISTS `tblmoneda`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblmoneda` (
  `idMoneda` bigint NOT NULL AUTO_INCREMENT,
  `codigoMoneda` char(3) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nombreMoneda` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `simboloMoneda` varchar(8) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idMoneda`),
  UNIQUE KEY `uqMoneda1` (`codigoMoneda`),
  CONSTRAINT `ckMoneda1` CHECK ((`is_active` in (0,1)))
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblmoneda`
--

LOCK TABLES `tblmoneda` WRITE;
/*!40000 ALTER TABLE `tblmoneda` DISABLE KEYS */;
INSERT INTO `tblmoneda` VALUES (1,'GTQ','Quetzal','Q',1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(2,'USD','Dolar estadounidense','US$',1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(3,'EUR','Euro','EUR',1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(4,'MXN','Peso mexicano','MX$',1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(5,'HNL','Lempira hondureno','L',1,'2026-11-14 18:34:36','2026-11-14 18:34:36');
/*!40000 ALTER TABLE `tblmoneda` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblmotivobaja`
--

DROP TABLE IF EXISTS `tblmotivobaja`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblmotivobaja` (
  `idMotivoBaja` int NOT NULL AUTO_INCREMENT,
  `nombreMotivoBaja` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `aplicaIndemnizacionMotivoBaja` tinyint(1) NOT NULL DEFAULT '0',
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idMotivoBaja`),
  UNIQUE KEY `uqNombreMotivoBaja` (`nombreMotivoBaja`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblmotivobaja`
--

LOCK TABLES `tblmotivobaja` WRITE;
/*!40000 ALTER TABLE `tblmotivobaja` DISABLE KEYS */;
INSERT INTO `tblmotivobaja` VALUES (1,'Renuncia voluntaria',0,1,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(2,'Despido justificado',0,1,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(3,'Despido injustificado',1,1,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(4,'Mutuo acuerdo',0,1,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(5,'Finalización de contrato',0,1,'2026-11-14 18:34:37','2026-11-14 18:34:37');
/*!40000 ALTER TABLE `tblmotivobaja` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblmovimientobancario`
--

DROP TABLE IF EXISTS `tblmovimientobancario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblmovimientobancario` (
  `idMovimientoBancario` bigint NOT NULL AUTO_INCREMENT,
  `referenciaMovimientoBancario` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `conceptoMovimientoBancario` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `importeMovimientoBancario` decimal(12,4) NOT NULL,
  `importeGTQMovimientoBancario` decimal(12,4) NOT NULL,
  `tipoCambioAplicadoMovimientoBancario` decimal(12,4) NOT NULL DEFAULT '1.0000',
  `sentidoMovimientoBancario` int NOT NULL,
  `fechaOperacionMovimientoBancario` date NOT NULL,
  `fechaValorMovimientoBancario` date NOT NULL,
  `origenMovimientoBancario` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'MANUAL',
  `Fk_CuentaBancaria_Codigo` bigint NOT NULL,
  `Fk_TipoTransaccion_Codigo` bigint NOT NULL,
  `Fk_TipoCambio_Codigo` bigint DEFAULT NULL,
  `Fk_OrdenPago_Codigo` bigint DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `idConceptoBancario` bigint DEFAULT NULL,
  `idMetodoPago` int DEFAULT NULL,
  `idTransferenciaInterna` bigint DEFAULT NULL,
  `idMovimientoRevertido` bigint DEFAULT NULL,
  PRIMARY KEY (`idMovimientoBancario`),
  UNIQUE KEY `uqMovimientoBancario1` (`Fk_OrdenPago_Codigo`),
  UNIQUE KEY `uqMovimientoReversion` (`idMovimientoRevertido`),
  UNIQUE KEY `uqMovimientoReferencia` (`referenciaMovimientoBancario`),
  KEY `idxMovimientoBancarioCuentaFecha` (`Fk_CuentaBancaria_Codigo`,`fechaOperacionMovimientoBancario`),
  KEY `idxMovimientoBancarioTipo` (`Fk_TipoTransaccion_Codigo`),
  KEY `idxMovimientoBancarioTipoCambio` (`Fk_TipoCambio_Codigo`),
  KEY `idxMovimientoConcepto` (`idConceptoBancario`),
  KEY `idxMovimientoMetodoPago` (`idMetodoPago`),
  KEY `idxMovimientoTransferencia` (`idTransferenciaInterna`),
  CONSTRAINT `Fk_MovimientoBancario_ConceptoBancario` FOREIGN KEY (`idConceptoBancario`) REFERENCES `tblconceptobancario` (`idConceptoBancario`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `Fk_MovimientoBancario_Cuenta` FOREIGN KEY (`Fk_CuentaBancaria_Codigo`) REFERENCES `tblcuentabancaria` (`idCuentaBancaria`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `Fk_MovimientoBancario_MetodoPago` FOREIGN KEY (`idMetodoPago`) REFERENCES `tblmetodopago` (`idMetodoPago`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `Fk_MovimientoBancario_MovimientoRevertido` FOREIGN KEY (`idMovimientoRevertido`) REFERENCES `tblmovimientobancario` (`idMovimientoBancario`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `Fk_MovimientoBancario_OrdenPago` FOREIGN KEY (`Fk_OrdenPago_Codigo`) REFERENCES `tblordenpago` (`idOrdenPago`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `Fk_MovimientoBancario_Tipo` FOREIGN KEY (`Fk_TipoTransaccion_Codigo`) REFERENCES `tbltipotransaccion` (`idTipoTransaccion`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `Fk_MovimientoBancario_TipoCambio` FOREIGN KEY (`Fk_TipoCambio_Codigo`) REFERENCES `tbltipocambio` (`idTipoCambio`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `Fk_MovimientoBancario_TransferenciaInterna` FOREIGN KEY (`idTransferenciaInterna`) REFERENCES `tbltransferenciainterna` (`idTransferenciaInterna`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `ckMovimientoBancario1` CHECK (((`importeMovimientoBancario` > 0) and (`importeGTQMovimientoBancario` > 0))),
  CONSTRAINT `ckMovimientoBancario2` CHECK ((`tipoCambioAplicadoMovimientoBancario` > 0)),
  CONSTRAINT `ckMovimientoBancario3` CHECK ((`sentidoMovimientoBancario` in (-(1),1))),
  CONSTRAINT `ckMovimientoBancario4` CHECK ((`origenMovimientoBancario` in (_utf8mb4'MANUAL',_utf8mb4'ESTADO_CUENTA',_utf8mb4'ORDEN_PAGO')))
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblmovimientobancario`
--

LOCK TABLES `tblmovimientobancario` WRITE;
/*!40000 ALTER TABLE `tblmovimientobancario` DISABLE KEYS */;
INSERT INTO `tblmovimientobancario` VALUES (1,'MB-2026-0001','Pago OP-2026-0201 a Distribuidora de Carnes La Esperanza',18450.0000,18450.0000,1.0000,-1,'2026-11-03','2026-11-03','ORDEN_PAGO',1,1,NULL,1,'2026-11-14 18:34:37','2026-11-14 18:34:37',1,NULL,NULL,NULL),(2,'MB-2026-0002','Pago OP-2026-0202 a Empaques y Etiquetas de Guatemala',7920.5000,7920.5000,1.0000,-1,'2026-11-04','2026-11-04','ORDEN_PAGO',2,1,NULL,2,'2026-11-14 18:34:37','2026-11-14 18:34:37',1,NULL,NULL,NULL),(3,'MB-2026-0003','Pago OP-2026-0203 de planilla a Carlos Mendez Ruiz',4250.0000,4250.0000,1.0000,-1,'2026-11-05','2026-11-05','ORDEN_PAGO',4,2,NULL,3,'2026-11-14 18:34:37','2026-11-14 18:34:37',2,NULL,NULL,NULL),(4,'MB-2026-0004','Deposito en efectivo de cliente Supermercados El Ahorro',25000.0000,25000.0000,1.0000,1,'2026-11-02','2026-11-02','MANUAL',1,3,NULL,NULL,'2026-11-14 18:34:37','2026-11-14 18:34:37',3,NULL,NULL,NULL),(5,'MB-2026-0005','Credito por transferencia ACH de cliente Restaurantes Gran Sabor',12300.0000,12300.0000,1.0000,1,'2026-11-04','2026-11-04','ESTADO_CUENTA',2,3,NULL,NULL,'2026-11-14 18:34:37','2026-11-14 18:34:37',3,NULL,NULL,NULL);
/*!40000 ALTER TABLE `tblmovimientobancario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblmovimientobancariotercero`
--

DROP TABLE IF EXISTS `tblmovimientobancariotercero`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblmovimientobancariotercero` (
  `idMovimientoBancarioTercero` bigint NOT NULL AUTO_INCREMENT,
  `idMovimientoBancario` bigint NOT NULL,
  `idEmpleado` int DEFAULT NULL,
  `idProveedor` int DEFAULT NULL,
  `idCliente` int DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `idCuentaBancariaTercero` bigint DEFAULT NULL,
  PRIMARY KEY (`idMovimientoBancarioTercero`),
  UNIQUE KEY `uqMovimientoBancarioTercero` (`idMovimientoBancario`),
  KEY `idxAsociativaEmpleado` (`idEmpleado`),
  KEY `idxAsociativaProveedor` (`idProveedor`),
  KEY `idxAsociativaCliente` (`idCliente`),
  KEY `idxMovimientoTerceroCuenta` (`idCuentaBancariaTercero`),
  CONSTRAINT `Fk_MovimientoBancarioTercero_Cliente` FOREIGN KEY (`idCliente`) REFERENCES `tblcliente` (`idCliente`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `Fk_MovimientoBancarioTercero_Empleado` FOREIGN KEY (`idEmpleado`) REFERENCES `tblempleado` (`idEmpleado`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `Fk_MovimientoBancarioTercero_MovimientoBancario` FOREIGN KEY (`idMovimientoBancario`) REFERENCES `tblmovimientobancario` (`idMovimientoBancario`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `Fk_MovimientoBancarioTercero_Proveedor` FOREIGN KEY (`idProveedor`) REFERENCES `tblproveedor` (`idProveedor`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `Fk_MovimientoTercero_CuentaBancariaTercero` FOREIGN KEY (`idCuentaBancariaTercero`) REFERENCES `tblcuentabancariatercero` (`idCuentaBancariaTercero`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `ckAsociativaEstado` CHECK ((`is_active` in (0,1))),
  CONSTRAINT `ckAsociativaUnTercero` CHECK (((((`idEmpleado` is not null) + (`idProveedor` is not null)) + (`idCliente` is not null)) = 1))
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblmovimientobancariotercero`
--

LOCK TABLES `tblmovimientobancariotercero` WRITE;
/*!40000 ALTER TABLE `tblmovimientobancariotercero` DISABLE KEYS */;
INSERT INTO `tblmovimientobancariotercero` VALUES (1,1,NULL,1,NULL,1,'2026-11-14 18:34:37','2026-11-14 18:34:37',NULL),(2,2,NULL,2,NULL,1,'2026-11-14 18:34:37','2026-11-14 18:34:37',NULL),(3,3,1,NULL,NULL,1,'2026-11-14 18:34:37','2026-11-14 18:34:37',NULL),(4,4,NULL,NULL,1,1,'2026-11-14 18:34:37','2026-11-14 18:34:37',NULL),(5,5,NULL,NULL,2,1,'2026-11-14 18:34:37','2026-11-14 18:34:37',NULL);
/*!40000 ALTER TABLE `tblmovimientobancariotercero` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblmovimientocxc`
--

DROP TABLE IF EXISTS `tblmovimientocxc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblmovimientocxc` (
  `idMovimientoCxC` int NOT NULL AUTO_INCREMENT,
  `idFacturaEncabezado` int NOT NULL,
  `idAplicacionPago` int DEFAULT NULL,
  `idNotaCxC` int DEFAULT NULL,
  `idMovimientoCxCRevertido` int DEFAULT NULL,
  `fechaMovimientoCxC` date NOT NULL,
  `tipoMovimientoCxC` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcionMovimientoCxC` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `cargoMovimientoCxC` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `abonoMovimientoCxC` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `idUsuarioRegistro` int NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idMovimientoCxC`),
  UNIQUE KEY `uqMovimientoCxCAplicacionPagoCodigo` (`idAplicacionPago`),
  UNIQUE KEY `uqMovimientoCxCNotaCxCCodigo` (`idNotaCxC`),
  UNIQUE KEY `uqMovimientoCxCRevertido` (`idMovimientoCxCRevertido`),
  KEY `idxMovimientoCxCFacturaEncabezadoCodigofecha` (`idFacturaEncabezado`,`fechaMovimientoCxC`),
  KEY `idxMovimientoCxCfecha` (`fechaMovimientoCxC`),
  KEY `idxMovimientoCxCUsuarioRegistro` (`idUsuarioRegistro`),
  CONSTRAINT `Fk_MovimientoCxC_AplicacionPago` FOREIGN KEY (`idAplicacionPago`) REFERENCES `tblaplicacionpago` (`idAplicacionPago`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `Fk_MovimientoCxC_FacturaEncabezado` FOREIGN KEY (`idFacturaEncabezado`) REFERENCES `tblfacturaencabezado` (`idFacturaEncabezado`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `Fk_MovimientoCxC_MovimientoCxC_Revertido` FOREIGN KEY (`idMovimientoCxCRevertido`) REFERENCES `tblmovimientocxc` (`idMovimientoCxC`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `Fk_MovimientoCxC_NotaCxC` FOREIGN KEY (`idNotaCxC`) REFERENCES `tblnotacxc` (`idNotaCxC`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `Fk_MovimientoCxC_Usuario_Registro` FOREIGN KEY (`idUsuarioRegistro`) REFERENCES `tblusuario` (`idUsuario`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `ckMovimientoCxCCargoAbonoExcluyentes` CHECK (((`cargoMovimientoCxC` >= 0) and (`abonoMovimientoCxC` >= 0) and (((`cargoMovimientoCxC` > 0) and (`abonoMovimientoCxC` = 0)) or ((`abonoMovimientoCxC` > 0) and (`cargoMovimientoCxC` = 0))))),
  CONSTRAINT `ckMovimientoCxCReversionIdentificada` CHECK ((((`tipoMovimientoCxC` = _utf8mb4'REVERSO') and (`idMovimientoCxCRevertido` is not null)) or ((`tipoMovimientoCxC` <> _utf8mb4'REVERSO') and (`idMovimientoCxCRevertido` is null)))),
  CONSTRAINT `ckMovimientoCxCValoresTipoMovimiento` CHECK ((`tipoMovimientoCxC` in (_utf8mb4'FACTURA',_utf8mb4'PAGO',_utf8mb4'NOTA_CREDITO',_utf8mb4'NOTA_DEBITO',_utf8mb4'AJUSTE_POSITIVO',_utf8mb4'AJUSTE_NEGATIVO',_utf8mb4'REVERSO')))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblmovimientocxc`
--

LOCK TABLES `tblmovimientocxc` WRITE;
/*!40000 ALTER TABLE `tblmovimientocxc` DISABLE KEYS */;
/*!40000 ALTER TABLE `tblmovimientocxc` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblmovimientoinventario`
--

DROP TABLE IF EXISTS `tblmovimientoinventario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblmovimientoinventario` (
  `idMovimientoInventario` int NOT NULL AUTO_INCREMENT,
  `Fk_Tipo_Movimiento_Codigo` int NOT NULL,
  `Fk_Sucursal_Origen_Codigo` int DEFAULT NULL,
  `Fk_Bodega_Origen_Codigo` int DEFAULT NULL,
  `Fk_Sucursal_Destino_Codigo` int DEFAULT NULL,
  `Fk_Bodega_Destino_Codigo` int DEFAULT NULL,
  `Fk_Transporte_Codigo` int DEFAULT NULL,
  `Fk_Traslado_Codigo` int DEFAULT NULL COMMENT 'Relaciona movimientos con su traslado',
  `fechaMovimientoInventario` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `observacionesMovimientoInventario` varchar(500) COLLATE utf8mb4_unicode_ci NOT NULL,
  `estadoMovimientoInventario` enum('PENDIENTE','CUADRADO','CERRADO','ANULADO') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'PENDIENTE',
  `Fk_Cierre_Inventario_Codigo` int DEFAULT NULL COMMENT 'NULL mientras el movimiento no pertenezca a un cierre',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idMovimientoInventario`),
  KEY `Fk_Movimiento_Inventario_Tipo_Movimiento` (`Fk_Tipo_Movimiento_Codigo`),
  KEY `Fk_Movimiento_Inventario_Sucursal_Origen` (`Fk_Sucursal_Origen_Codigo`),
  KEY `Fk_Movimiento_Inventario_Sucursal_Destino` (`Fk_Sucursal_Destino_Codigo`),
  KEY `Fk_Movimiento_Inventario_Bodega_Origen` (`Fk_Bodega_Origen_Codigo`,`Fk_Sucursal_Origen_Codigo`),
  KEY `Fk_Movimiento_Inventario_Bodega_Destino` (`Fk_Bodega_Destino_Codigo`,`Fk_Sucursal_Destino_Codigo`),
  KEY `Fk_Movimiento_Inventario_Transporte` (`Fk_Transporte_Codigo`),
  KEY `Fk_Movimiento_Inventario_Traslado` (`Fk_Traslado_Codigo`),
  KEY `Fk_Movimiento_Inventario_Cierre_Inventario` (`Fk_Cierre_Inventario_Codigo`),
  CONSTRAINT `Fk_Movimiento_Inventario_Bodega_Destino` FOREIGN KEY (`Fk_Bodega_Destino_Codigo`, `Fk_Sucursal_Destino_Codigo`) REFERENCES `tblbodega` (`idBodega`, `Fk_Sucursal_Codigo`) ON DELETE RESTRICT,
  CONSTRAINT `Fk_Movimiento_Inventario_Bodega_Origen` FOREIGN KEY (`Fk_Bodega_Origen_Codigo`, `Fk_Sucursal_Origen_Codigo`) REFERENCES `tblbodega` (`idBodega`, `Fk_Sucursal_Codigo`) ON DELETE RESTRICT,
  CONSTRAINT `Fk_Movimiento_Inventario_Cierre_Inventario` FOREIGN KEY (`Fk_Cierre_Inventario_Codigo`) REFERENCES `tblcierreinventario` (`idCierreInventario`) ON DELETE RESTRICT,
  CONSTRAINT `Fk_Movimiento_Inventario_Sucursal_Destino` FOREIGN KEY (`Fk_Sucursal_Destino_Codigo`) REFERENCES `tblsucursal` (`idSucursal`) ON DELETE RESTRICT,
  CONSTRAINT `Fk_Movimiento_Inventario_Sucursal_Origen` FOREIGN KEY (`Fk_Sucursal_Origen_Codigo`) REFERENCES `tblsucursal` (`idSucursal`) ON DELETE RESTRICT,
  CONSTRAINT `Fk_Movimiento_Inventario_Tipo_Movimiento` FOREIGN KEY (`Fk_Tipo_Movimiento_Codigo`) REFERENCES `tbltipomovimiento` (`idTipoMovimiento`) ON DELETE RESTRICT,
  CONSTRAINT `Fk_Movimiento_Inventario_Transporte` FOREIGN KEY (`Fk_Transporte_Codigo`) REFERENCES `tbltransporte` (`idTransporte`) ON DELETE RESTRICT,
  CONSTRAINT `Fk_Movimiento_Inventario_Traslado` FOREIGN KEY (`Fk_Traslado_Codigo`) REFERENCES `tbltraslado` (`idTraslado`) ON DELETE RESTRICT,
  CONSTRAINT `ckMovimientoSucursalBodegaDestino` CHECK ((((`Fk_Sucursal_Destino_Codigo` is null) and (`Fk_Bodega_Destino_Codigo` is null)) or ((`Fk_Sucursal_Destino_Codigo` is not null) and (`Fk_Bodega_Destino_Codigo` is not null)))),
  CONSTRAINT `ckMovimientoSucursalBodegaOrigen` CHECK ((((`Fk_Sucursal_Origen_Codigo` is null) and (`Fk_Bodega_Origen_Codigo` is null)) or ((`Fk_Sucursal_Origen_Codigo` is not null) and (`Fk_Bodega_Origen_Codigo` is not null))))
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblmovimientoinventario`
--

LOCK TABLES `tblmovimientoinventario` WRITE;
/*!40000 ALTER TABLE `tblmovimientoinventario` DISABLE KEYS */;
INSERT INTO `tblmovimientoinventario` VALUES (1,4,1,1,2,2,1,1,'2026-10-25 09:00:00','Salida por traslado de salchichas hacia Mixco.','CERRADO',1,'2026-11-14 18:34:39','2026-11-14 18:34:39'),(2,3,2,2,3,3,2,2,'2026-10-26 10:45:00','Entrada por traslado recibido de chorizos.','CERRADO',2,'2026-11-14 18:34:39','2026-11-14 18:34:39'),(3,4,3,3,4,4,3,3,'2026-10-27 06:30:00','Salida por traslado de jamones hacia occidente.','CERRADO',3,'2026-11-14 18:34:39','2026-11-14 18:34:39'),(4,1,NULL,NULL,4,4,NULL,NULL,'2026-10-28 11:30:00','Ingreso de mortadela procedente del área de producción.','CERRADO',4,'2026-11-14 18:34:39','2026-11-14 18:34:39'),(5,2,5,5,NULL,NULL,NULL,NULL,'2026-10-29 15:10:00','Despacho de tocino ahumado para venta mayorista.','CERRADO',5,'2026-11-14 18:34:39','2026-11-14 18:34:39');
/*!40000 ALTER TABLE `tblmovimientoinventario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblnominadetalle`
--

DROP TABLE IF EXISTS `tblnominadetalle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblnominadetalle` (
  `idNominaDetalle` int NOT NULL AUTO_INCREMENT,
  `idNominaEncabezado` int NOT NULL,
  `idPercepcionDeduccion` int NOT NULL,
  `montoNominaDetalle` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idNominaDetalle`),
  UNIQUE KEY `uqNominaDetalleConcepto` (`idNominaEncabezado`,`idPercepcionDeduccion`),
  KEY `Fk_NominaDetalle_PercepcionDeduccion` (`idPercepcionDeduccion`),
  CONSTRAINT `Fk_NominaDetalle_NominaEncabezado` FOREIGN KEY (`idNominaEncabezado`) REFERENCES `tblnominaencabezado` (`idNominaEncabezado`),
  CONSTRAINT `Fk_NominaDetalle_PercepcionDeduccion` FOREIGN KEY (`idPercepcionDeduccion`) REFERENCES `tblpercepciondeduccion` (`idPercepcionDeduccion`)
) ENGINE=InnoDB AUTO_INCREMENT=330 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblnominadetalle`
--

LOCK TABLES `tblnominadetalle` WRITE;
/*!40000 ALTER TABLE `tblnominadetalle` DISABLE KEYS */;
INSERT INTO `tblnominadetalle` VALUES (1,1,1,81.2499,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(2,1,2,317.8744,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(3,2,1,40.6250,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(4,2,2,315.9122,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(5,3,1,60.9374,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(6,3,2,316.8933,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(7,4,1,101.5624,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(8,4,2,318.8555,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(9,5,1,81.2499,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(10,5,2,317.8744,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(11,6,6,7500.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(12,6,7,250.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(13,6,8,362.2500,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(14,6,9,150.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(15,7,6,6500.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(16,7,7,250.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(17,7,8,313.9500,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(18,8,6,7200.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(19,8,7,250.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(20,8,8,347.7600,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(21,8,9,150.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(22,9,6,5800.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(23,9,7,250.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(24,9,8,280.1400,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(25,10,6,6000.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(26,10,7,250.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(27,10,8,289.8000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(28,11,6,5500.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(29,11,7,250.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(30,11,8,265.6500,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(31,12,6,7500.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(32,12,7,250.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(33,12,8,362.2500,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(34,12,9,150.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(35,13,6,6500.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(36,13,7,250.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(37,13,8,313.9500,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(38,14,6,7200.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(39,14,7,250.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(40,14,8,347.7600,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(41,14,9,150.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(42,15,6,5800.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(43,15,7,250.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(44,15,8,280.1400,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(45,16,6,6000.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(46,16,7,250.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(47,16,8,289.8000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(48,17,6,5500.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(49,17,7,250.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(50,17,8,265.6500,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(51,18,6,7500.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(52,18,7,250.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(53,18,8,362.2500,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(54,18,9,150.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(55,19,6,6500.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(56,19,7,250.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(57,19,8,313.9500,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(58,20,6,7200.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(59,20,7,250.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(60,20,8,347.7600,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(61,20,9,150.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(62,21,6,5800.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(63,21,7,250.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(64,21,8,280.1400,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(65,22,6,6000.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(66,22,7,250.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(67,22,8,289.8000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(68,23,6,5500.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(69,23,7,250.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(70,23,8,265.6500,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(71,24,6,7500.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(72,24,7,250.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(73,24,8,362.2500,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(74,24,9,150.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(75,25,6,7200.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(76,25,7,250.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(77,25,8,347.7600,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(78,25,9,150.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(79,26,6,5800.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(80,26,7,250.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(81,26,8,280.1400,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(82,27,6,6000.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(83,27,7,250.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(84,27,8,289.8000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(85,28,6,5500.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(86,28,7,250.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(87,28,8,265.6500,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(88,29,6,7500.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(89,29,7,250.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(90,29,8,362.2500,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(91,29,9,150.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(92,30,6,7200.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(93,30,7,250.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(94,30,8,347.7600,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(95,30,9,150.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(96,31,6,5800.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(97,31,7,250.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(98,31,8,280.1400,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(99,32,6,6000.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(100,32,7,250.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(101,32,8,289.8000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(102,33,6,5500.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(103,33,7,250.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(104,33,8,265.6500,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(105,34,6,7500.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(106,34,7,250.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(107,34,8,362.2500,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(108,34,9,150.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(109,35,6,7500.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(110,35,7,250.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(111,35,8,362.2500,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(112,35,9,150.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(113,36,6,7200.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(114,36,7,250.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(115,36,8,347.7600,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(116,36,9,150.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(117,37,6,5800.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(118,37,7,250.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(119,37,8,280.1400,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(120,38,6,6000.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(121,38,7,250.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(122,38,8,289.8000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(123,39,6,5500.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(124,39,7,250.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(125,39,8,265.6500,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(126,40,6,7500.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(127,40,7,250.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(128,40,8,362.2500,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(129,40,9,150.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(130,41,6,7500.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(131,41,7,250.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(132,41,8,362.2500,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(133,41,9,150.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(134,42,6,7500.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(135,42,7,250.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(136,42,8,362.2500,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(137,42,9,150.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(138,43,6,6500.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(139,43,7,250.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(140,43,8,313.9500,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(141,44,6,7200.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(142,44,7,250.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(143,44,8,347.7600,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(144,44,9,150.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(145,45,6,5800.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(146,45,7,250.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(147,45,8,280.1400,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(148,46,6,6000.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(149,46,7,250.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(150,46,8,289.8000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(151,47,6,5500.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(152,47,7,250.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(153,47,8,265.6500,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(154,48,6,7500.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(155,48,7,250.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(156,48,8,362.2500,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(157,48,9,150.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(158,49,6,7500.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(159,49,7,250.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(160,49,8,362.2500,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(161,49,9,150.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(162,50,6,7500.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(163,50,7,250.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(164,50,8,362.2500,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(165,50,9,150.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(166,51,6,6500.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(167,51,7,250.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(168,51,8,313.9500,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(169,52,6,7200.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(170,52,7,250.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(171,52,8,347.7600,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(172,52,9,150.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(173,53,6,5800.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(174,53,7,250.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(175,53,8,280.1400,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(176,54,6,6000.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(177,54,7,250.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(178,54,8,289.8000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(179,55,6,5500.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(180,55,7,250.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(181,55,8,265.6500,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(266,56,6,7500.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(267,56,7,250.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(268,56,8,362.2500,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(269,56,9,150.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(270,57,6,7500.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(271,57,7,250.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(272,57,8,362.2500,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(273,57,9,150.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(274,58,6,7200.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(275,58,7,250.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(276,58,8,347.7600,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(277,58,9,150.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(278,59,6,5800.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(279,59,7,250.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(280,59,8,280.1400,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(281,60,6,6000.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(282,60,7,250.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(283,60,8,289.8000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(284,61,6,5500.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(285,61,7,250.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(286,61,8,265.6500,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(287,62,6,7500.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(288,62,7,250.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(289,62,8,362.2500,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(290,62,9,150.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(291,63,6,7500.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(292,63,7,250.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(293,63,8,362.2500,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(294,63,9,150.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(295,64,6,7200.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(296,64,7,250.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(297,64,8,347.7600,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(298,64,9,150.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(299,65,6,5300.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(300,65,7,250.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(301,65,8,280.1400,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(302,66,6,6000.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(303,66,7,250.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(304,66,8,289.8000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(305,67,6,5500.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(306,67,7,250.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(307,67,8,265.6500,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(308,68,6,7500.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(309,68,7,250.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(310,68,8,362.2500,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(311,68,9,150.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(312,69,6,7500.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(313,69,7,250.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(314,69,8,362.2500,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(315,69,9,150.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(316,70,6,7200.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(317,70,7,250.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(318,70,8,347.7600,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(319,70,9,150.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(320,71,6,5800.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(321,71,7,250.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(322,71,8,280.1400,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(323,71,10,1000.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(324,72,6,6000.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(325,72,7,250.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(326,72,8,289.8000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(327,73,6,5500.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(328,73,7,250.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(329,73,8,265.6500,'2026-11-14 18:34:38','2026-11-14 18:34:38');
/*!40000 ALTER TABLE `tblnominadetalle` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblnominaencabezado`
--

DROP TABLE IF EXISTS `tblnominaencabezado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblnominaencabezado` (
  `idNominaEncabezado` int NOT NULL AUTO_INCREMENT,
  `idEmpleado` int NOT NULL,
  `fechaInicioNominaEncabezado` date NOT NULL,
  `fechaFinalNominaEncabezado` date NOT NULL,
  `salarioBaseNominaEncabezado` decimal(12,4) NOT NULL,
  `duracionHoraExtraNominaEncabezado` int NOT NULL DEFAULT '0',
  `totalHorasExtraNominaEncabezado` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `totalPercepcionNominaEncabezado` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `totalDeduccionNominaEncabezado` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `totalNetoNominaEncabezado` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `estadoNminaEncabezado` enum('Aprobada','Rechazada','Pagada') COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idNominaEncabezado`),
  KEY `Fk_NominaEncabezado_Empleado` (`idEmpleado`),
  CONSTRAINT `Fk_NominaEncabezado_Empleado` FOREIGN KEY (`idEmpleado`) REFERENCES `tblempleado` (`idEmpleado`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `ckNominaEncabezadoFechas` CHECK ((`fechaFinalNominaEncabezado` >= `fechaInicioNominaEncabezado`))
) ENGINE=InnoDB AUTO_INCREMENT=74 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblnominaencabezado`
--

LOCK TABLES `tblnominaencabezado` WRITE;
/*!40000 ALTER TABLE `tblnominaencabezado` DISABLE KEYS */;
INSERT INTO `tblnominaencabezado` VALUES (1,20,'2026-06-01','2026-06-30',6500.0000,120,81.2499,6581.2499,317.8744,6263.3755,'Pagada','2026-11-14 18:34:37','2026-11-14 18:34:37'),(2,20,'2026-07-01','2026-07-31',6500.0000,60,40.6250,6540.6250,315.9122,6224.7128,'Pagada','2026-11-14 18:34:37','2026-11-14 18:34:37'),(3,20,'2026-08-01','2026-08-31',6500.0000,90,60.9374,6560.9374,316.8933,6244.0441,'Pagada','2026-11-14 18:34:37','2026-11-14 18:34:37'),(4,20,'2026-09-01','2026-09-30',6500.0000,150,101.5624,6601.5624,318.8555,6282.7069,'Pagada','2026-11-14 18:34:37','2026-11-14 18:34:37'),(5,20,'2026-10-01','2026-10-31',6500.0000,120,81.2499,6581.2499,317.8744,6263.3755,'Aprobada','2026-11-14 18:34:37','2026-11-14 18:34:37'),(6,3,'2025-09-01','2025-09-30',7500.0000,0,0.0000,7750.0000,512.2500,7237.7500,'Aprobada','2026-11-14 18:34:38','2026-11-14 18:34:38'),(7,20,'2025-09-01','2025-09-30',6500.0000,0,0.0000,6750.0000,313.9500,6436.0500,'Aprobada','2026-11-14 18:34:38','2026-11-14 18:34:38'),(8,21,'2025-09-01','2025-09-30',7200.0000,0,0.0000,7450.0000,497.7600,6952.2400,'Aprobada','2026-11-14 18:34:38','2026-11-14 18:34:38'),(9,22,'2025-09-01','2025-09-30',5800.0000,0,0.0000,6050.0000,280.1400,5769.8600,'Aprobada','2026-11-14 18:34:38','2026-11-14 18:34:38'),(10,23,'2025-09-01','2025-09-30',6000.0000,0,0.0000,6250.0000,289.8000,5960.2000,'Aprobada','2026-11-14 18:34:38','2026-11-14 18:34:38'),(11,24,'2025-09-01','2025-09-30',5500.0000,0,0.0000,5750.0000,265.6500,5484.3500,'Aprobada','2026-11-14 18:34:38','2026-11-14 18:34:38'),(12,3,'2025-10-01','2025-10-31',7500.0000,0,0.0000,7750.0000,512.2500,7237.7500,'Aprobada','2026-11-14 18:34:38','2026-11-14 18:34:38'),(13,20,'2025-10-01','2025-10-31',6500.0000,0,0.0000,6750.0000,313.9500,6436.0500,'Aprobada','2026-11-14 18:34:38','2026-11-14 18:34:38'),(14,21,'2025-10-01','2025-10-31',7200.0000,0,0.0000,7450.0000,497.7600,6952.2400,'Aprobada','2026-11-14 18:34:38','2026-11-14 18:34:38'),(15,22,'2025-10-01','2025-10-31',5800.0000,0,0.0000,6050.0000,280.1400,5769.8600,'Aprobada','2026-11-14 18:34:38','2026-11-14 18:34:38'),(16,23,'2025-10-01','2025-10-31',6000.0000,0,0.0000,6250.0000,289.8000,5960.2000,'Aprobada','2026-11-14 18:34:38','2026-11-14 18:34:38'),(17,24,'2025-10-01','2025-10-31',5500.0000,0,0.0000,5750.0000,265.6500,5484.3500,'Aprobada','2026-11-14 18:34:38','2026-11-14 18:34:38'),(18,3,'2025-11-01','2025-11-30',7500.0000,0,0.0000,7750.0000,512.2500,7237.7500,'Aprobada','2026-11-14 18:34:38','2026-11-14 18:34:38'),(19,20,'2025-11-01','2025-11-30',6500.0000,0,0.0000,6750.0000,313.9500,6436.0500,'Aprobada','2026-11-14 18:34:38','2026-11-14 18:34:38'),(20,21,'2025-11-01','2025-11-30',7200.0000,0,0.0000,7450.0000,497.7600,6952.2400,'Aprobada','2026-11-14 18:34:38','2026-11-14 18:34:38'),(21,22,'2025-11-01','2025-11-30',5800.0000,0,0.0000,6050.0000,280.1400,5769.8600,'Aprobada','2026-11-14 18:34:38','2026-11-14 18:34:38'),(22,23,'2025-11-01','2025-11-30',6000.0000,0,0.0000,6250.0000,289.8000,5960.2000,'Aprobada','2026-11-14 18:34:38','2026-11-14 18:34:38'),(23,24,'2025-11-01','2025-11-30',5500.0000,0,0.0000,5750.0000,265.6500,5484.3500,'Aprobada','2026-11-14 18:34:38','2026-11-14 18:34:38'),(24,3,'2025-12-01','2025-12-31',7500.0000,0,0.0000,7750.0000,512.2500,7237.7500,'Pagada','2026-11-14 18:34:38','2026-11-14 18:34:38'),(25,21,'2025-12-01','2025-12-31',7200.0000,0,0.0000,7450.0000,497.7600,6952.2400,'Pagada','2026-11-14 18:34:38','2026-11-14 18:34:38'),(26,22,'2025-12-01','2025-12-31',5800.0000,0,0.0000,6050.0000,280.1400,5769.8600,'Pagada','2026-11-14 18:34:38','2026-11-14 18:34:38'),(27,23,'2025-12-01','2025-12-31',6000.0000,0,0.0000,6250.0000,289.8000,5960.2000,'Pagada','2026-11-14 18:34:38','2026-11-14 18:34:38'),(28,24,'2025-12-01','2025-12-31',5500.0000,0,0.0000,5750.0000,265.6500,5484.3500,'Pagada','2026-11-14 18:34:38','2026-11-14 18:34:38'),(29,3,'2026-01-01','2026-01-31',7500.0000,0,0.0000,7750.0000,512.2500,7237.7500,'Pagada','2026-11-14 18:34:38','2026-11-14 18:34:38'),(30,21,'2026-01-01','2026-01-31',7200.0000,0,0.0000,7450.0000,497.7600,6952.2400,'Pagada','2026-11-14 18:34:38','2026-11-14 18:34:38'),(31,22,'2026-01-01','2026-01-31',5800.0000,0,0.0000,6050.0000,280.1400,5769.8600,'Pagada','2026-11-14 18:34:38','2026-11-14 18:34:38'),(32,23,'2026-01-01','2026-01-31',6000.0000,0,0.0000,6250.0000,289.8000,5960.2000,'Pagada','2026-11-14 18:34:38','2026-11-14 18:34:38'),(33,24,'2026-01-01','2026-01-31',5500.0000,0,0.0000,5750.0000,265.6500,5484.3500,'Pagada','2026-11-14 18:34:38','2026-11-14 18:34:38'),(34,1,'2026-02-01','2026-02-28',7500.0000,0,0.0000,7750.0000,512.2500,7237.7500,'Pagada','2026-11-14 18:34:38','2026-11-14 18:34:38'),(35,3,'2026-02-01','2026-02-28',7500.0000,0,0.0000,7750.0000,512.2500,7237.7500,'Pagada','2026-11-14 18:34:38','2026-11-14 18:34:38'),(36,21,'2026-02-01','2026-02-28',7200.0000,0,0.0000,7450.0000,497.7600,6952.2400,'Pagada','2026-11-14 18:34:38','2026-11-14 18:34:38'),(37,22,'2026-02-01','2026-02-28',5800.0000,0,0.0000,6050.0000,280.1400,5769.8600,'Pagada','2026-11-14 18:34:38','2026-11-14 18:34:38'),(38,23,'2026-02-01','2026-02-28',6000.0000,0,0.0000,6250.0000,289.8000,5960.2000,'Pagada','2026-11-14 18:34:38','2026-11-14 18:34:38'),(39,24,'2026-02-01','2026-02-28',5500.0000,0,0.0000,5750.0000,265.6500,5484.3500,'Pagada','2026-11-14 18:34:38','2026-11-14 18:34:38'),(40,1,'2026-11-01','2026-11-30',7500.0000,0,0.0000,7750.0000,512.2500,7237.7500,'Aprobada','2026-11-14 18:34:38','2026-11-14 18:34:38'),(41,3,'2026-11-01','2026-11-30',7500.0000,0,0.0000,7750.0000,512.2500,7237.7500,'Aprobada','2026-11-14 18:34:38','2026-11-14 18:34:38'),(42,13,'2026-11-01','2026-11-30',7500.0000,0,0.0000,7750.0000,512.2500,7237.7500,'Aprobada','2026-11-14 18:34:38','2026-11-14 18:34:38'),(43,20,'2026-11-01','2026-11-30',6500.0000,0,0.0000,6750.0000,313.9500,6436.0500,'Aprobada','2026-11-14 18:34:38','2026-11-14 18:34:38'),(44,21,'2026-11-01','2026-11-30',7200.0000,0,0.0000,7450.0000,497.7600,6952.2400,'Aprobada','2026-11-14 18:34:38','2026-11-14 18:34:38'),(45,22,'2026-11-01','2026-11-30',5800.0000,0,0.0000,6050.0000,280.1400,5769.8600,'Aprobada','2026-11-14 18:34:38','2026-11-14 18:34:38'),(46,23,'2026-11-01','2026-11-30',6000.0000,0,0.0000,6250.0000,289.8000,5960.2000,'Aprobada','2026-11-14 18:34:38','2026-11-14 18:34:38'),(47,24,'2026-11-01','2026-11-30',5500.0000,0,0.0000,5750.0000,265.6500,5484.3500,'Aprobada','2026-11-14 18:34:38','2026-11-14 18:34:38'),(48,1,'2026-12-01','2026-12-31',7500.0000,0,0.0000,7750.0000,512.2500,7237.7500,'Aprobada','2026-11-14 18:34:38','2026-11-14 18:34:38'),(49,3,'2026-12-01','2026-12-31',7500.0000,0,0.0000,7750.0000,512.2500,7237.7500,'Aprobada','2026-11-14 18:34:38','2026-11-14 18:34:38'),(50,13,'2026-12-01','2026-12-31',7500.0000,0,0.0000,7750.0000,512.2500,7237.7500,'Aprobada','2026-11-14 18:34:38','2026-11-14 18:34:38'),(51,20,'2026-12-01','2026-12-31',6500.0000,0,0.0000,6750.0000,313.9500,6436.0500,'Aprobada','2026-11-14 18:34:38','2026-11-14 18:34:38'),(52,21,'2026-12-01','2026-12-31',7200.0000,0,0.0000,7450.0000,497.7600,6952.2400,'Aprobada','2026-11-14 18:34:38','2026-11-14 18:34:38'),(53,22,'2026-12-01','2026-12-31',5800.0000,0,0.0000,6050.0000,280.1400,5769.8600,'Aprobada','2026-11-14 18:34:38','2026-11-14 18:34:38'),(54,23,'2026-12-01','2026-12-31',6000.0000,0,0.0000,6250.0000,289.8000,5960.2000,'Aprobada','2026-11-14 18:34:38','2026-11-14 18:34:38'),(55,24,'2026-12-01','2026-12-31',5500.0000,0,0.0000,5750.0000,265.6500,5484.3500,'Aprobada','2026-11-14 18:34:38','2026-11-14 18:34:38'),(56,1,'2026-03-01','2026-03-31',7500.0000,0,0.0000,7750.0000,512.2500,7237.7500,'Aprobada','2026-11-14 18:34:38','2026-11-14 18:34:38'),(57,3,'2026-03-01','2026-03-31',7500.0000,0,0.0000,7750.0000,512.2500,7237.7500,'Aprobada','2026-11-14 18:34:38','2026-11-14 18:34:38'),(58,21,'2026-03-01','2026-03-31',7200.0000,0,0.0000,7450.0000,497.7600,6952.2400,'Aprobada','2026-11-14 18:34:38','2026-11-14 18:34:38'),(59,22,'2026-03-01','2026-03-31',5800.0000,0,0.0000,6050.0000,280.1400,5669.8600,'Aprobada','2026-11-14 18:34:38','2026-11-14 18:34:38'),(60,23,'2026-03-01','2026-03-31',6000.0000,0,0.0000,6250.0000,289.8000,5960.2000,'Aprobada','2026-11-14 18:34:38','2026-11-14 18:34:38'),(61,24,'2026-03-01','2026-03-31',5500.0000,0,0.0000,5750.0000,265.6500,5484.3500,'Aprobada','2026-11-14 18:34:38','2026-11-14 18:34:38'),(62,1,'2026-04-01','2026-04-30',7500.0000,0,0.0000,7750.0000,512.2500,7237.7500,'Aprobada','2026-11-14 18:34:38','2026-11-14 18:34:38'),(63,3,'2026-04-01','2026-04-30',7500.0000,0,0.0000,7750.0000,512.2500,7237.7500,'Aprobada','2026-11-14 18:34:38','2026-11-14 18:34:38'),(64,21,'2026-04-01','2026-04-30',7200.0000,0,0.0000,7450.0000,497.7600,6952.2400,'Aprobada','2026-11-14 18:34:38','2026-11-14 18:34:38'),(65,22,'2026-04-01','2026-04-30',5800.0000,0,0.0000,6050.0000,280.1400,5769.8600,'Aprobada','2026-11-14 18:34:38','2026-11-14 18:34:38'),(66,23,'2026-04-01','2026-04-30',6000.0000,0,0.0000,6250.0000,289.8000,5960.2000,'Aprobada','2026-11-14 18:34:38','2026-11-14 18:34:38'),(67,24,'2026-04-01','2026-04-30',5500.0000,0,0.0000,5750.0000,265.6500,5484.3500,'Aprobada','2026-11-14 18:34:38','2026-11-14 18:34:38'),(68,1,'2026-05-01','2026-05-31',7500.0000,0,0.0000,7750.0000,512.2500,7237.7500,'Aprobada','2026-11-14 18:34:38','2026-11-14 18:34:38'),(69,3,'2026-05-01','2026-05-31',7500.0000,0,0.0000,7750.0000,512.2500,7237.7500,'Aprobada','2026-11-14 18:34:38','2026-11-14 18:34:38'),(70,21,'2026-05-01','2026-05-31',7200.0000,0,0.0000,7450.0000,497.7600,6952.2400,'Aprobada','2026-11-14 18:34:38','2026-11-14 18:34:38'),(71,22,'2026-05-01','2026-05-31',5800.0000,0,0.0000,7050.0000,280.1400,6769.8600,'Aprobada','2026-11-14 18:34:38','2026-11-14 18:34:38'),(72,23,'2026-05-01','2026-05-31',6000.0000,0,0.0000,6250.0000,289.8000,5960.2000,'Aprobada','2026-11-14 18:34:38','2026-11-14 18:34:38'),(73,24,'2026-05-01','2026-05-31',5500.0000,0,0.0000,5750.0000,265.6500,5484.3500,'Aprobada','2026-11-14 18:34:38','2026-11-14 18:34:38');
/*!40000 ALTER TABLE `tblnominaencabezado` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblnotacxc`
--

DROP TABLE IF EXISTS `tblnotacxc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblnotacxc` (
  `idNotaCxC` int NOT NULL AUTO_INCREMENT,
  `numeroNotaCxC` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `idFacturaEncabezado` int NOT NULL,
  `tipoNotaCxC` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fechaNotaCxC` date NOT NULL,
  `montoNotaCxC` decimal(12,4) NOT NULL,
  `motivoNotaCxC` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `estadoNotaCxC` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `idUsuarioRegistro` int NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idNotaCxC`),
  UNIQUE KEY `uqNotaCxCnumero` (`numeroNotaCxC`),
  KEY `idxNotaCxCFacturaEncabezadoCodigo` (`idFacturaEncabezado`),
  KEY `idxNotaCxCUsuarioRegistro` (`idUsuarioRegistro`),
  CONSTRAINT `Fk_NotaCxC_FacturaEncabezado` FOREIGN KEY (`idFacturaEncabezado`) REFERENCES `tblfacturaencabezado` (`idFacturaEncabezado`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `Fk_NotaCxC_Usuario_Registro` FOREIGN KEY (`idUsuarioRegistro`) REFERENCES `tblusuario` (`idUsuario`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `ckNotaCxCMontoPositivo` CHECK ((`montoNotaCxC` > 0)),
  CONSTRAINT `ckNotaCxCValoresEstadoNota` CHECK ((`estadoNotaCxC` in (_utf8mb4'BORRADOR',_utf8mb4'APLICADA',_utf8mb4'ANULADA'))),
  CONSTRAINT `ckNotaCxCValoresTipoNota` CHECK ((`tipoNotaCxC` in (_utf8mb4'CREDITO',_utf8mb4'DEBITO')))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblnotacxc`
--

LOCK TABLES `tblnotacxc` WRITE;
/*!40000 ALTER TABLE `tblnotacxc` DISABLE KEYS */;
/*!40000 ALTER TABLE `tblnotacxc` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblordencomprarecibida`
--

DROP TABLE IF EXISTS `tblordencomprarecibida`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblordencomprarecibida` (
  `Pk_OrdenCompraRecibida` bigint NOT NULL AUTO_INCREMENT,
  `referenciaExternaOrdenCompraRecibida` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `proveedorOrdenCompraRecibida` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fechaOrdenCompraRecibida` date NOT NULL,
  `fechaVencimientoOrdenCompraRecibida` date NOT NULL,
  `importeOrdenCompraRecibida` decimal(12,4) NOT NULL,
  `estadoOrdenCompraRecibida` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'PENDIENTE',
  `referenciaDocumentoOrdenCompraRecibida` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `identificadorSolicitanteOrdenCompraRecibida` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Fk_Moneda_Codigo` bigint NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`Pk_OrdenCompraRecibida`),
  UNIQUE KEY `uqOrdenCompraRecibida1` (`referenciaExternaOrdenCompraRecibida`),
  KEY `idxOrdenCompraRecibidaMoneda` (`Fk_Moneda_Codigo`),
  CONSTRAINT `Fk_OrdenCompraRecibida_Moneda` FOREIGN KEY (`Fk_Moneda_Codigo`) REFERENCES `tblmoneda` (`idMoneda`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `ckOrdenCompraRecibida1` CHECK ((`importeOrdenCompraRecibida` > 0)),
  CONSTRAINT `ckOrdenCompraRecibida2` CHECK ((`fechaVencimientoOrdenCompraRecibida` >= `fechaOrdenCompraRecibida`)),
  CONSTRAINT `ckOrdenCompraRecibida3` CHECK ((`estadoOrdenCompraRecibida` in (_utf8mb4'PENDIENTE',_utf8mb4'APROBADA',_utf8mb4'RECHAZADA',_utf8mb4'PAGADA')))
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblordencomprarecibida`
--

LOCK TABLES `tblordencomprarecibida` WRITE;
/*!40000 ALTER TABLE `tblordencomprarecibida` DISABLE KEYS */;
INSERT INTO `tblordencomprarecibida` VALUES (1,'OC-2026-0201','Distribuidora de Carnes La Esperanza, S.A.','2026-10-15','2026-11-03',18450.0000,'PAGADA','compras/oc/OC-2026-0201.pdf','compras.jlopez',1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(2,'OC-2026-0202','Empaques y Etiquetas de Guatemala, S.A.','2026-10-20','2026-11-04',7920.5000,'PAGADA','compras/oc/OC-2026-0202.pdf','compras.jlopez',1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(3,'OC-2026-0203','Importadora de Maquinaria Alimenticia, S.A.','2026-10-28','2026-11-10',3200.0000,'APROBADA','compras/oc/OC-2026-0203.pdf','compras.mrivera',2,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(4,'OC-2026-0204','Especias y Condimentos del Pacifico, S.A.','2026-10-30','2026-11-09',41300.0000,'APROBADA','compras/oc/OC-2026-0204.pdf','compras.mrivera',1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(5,'OC-2026-0205','Transportes y Fletes Rapidos, S.A.','2026-11-03','2026-11-20',12875.0000,'PENDIENTE','compras/oc/OC-2026-0205.pdf','compras.jlopez',1,'2026-11-14 18:34:36','2026-11-14 18:34:36');
/*!40000 ALTER TABLE `tblordencomprarecibida` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblordenpago`
--

DROP TABLE IF EXISTS `tblordenpago`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblordenpago` (
  `idOrdenPago` bigint NOT NULL AUTO_INCREMENT,
  `referenciaOrdenPago` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `beneficiarioOrdenPago` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `importeOrdenPago` decimal(12,4) NOT NULL,
  `medioOrdenPago` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `estadoOrdenPago` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'PENDIENTE',
  `fechaProgramadaOrdenPago` date NOT NULL,
  `identificadorSolicitanteOrdenPago` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Fk_CuentaBancaria_Codigo` bigint NOT NULL,
  `Fk_Moneda_Codigo` bigint NOT NULL,
  `Fk_OrdenCompraRecibida_Codigo` bigint DEFAULT NULL,
  `Fk_DetallePlanillaRecibida_Codigo` bigint DEFAULT NULL,
  `Fk_SolicitudPagoTransporte_Codigo` int DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idOrdenPago`),
  UNIQUE KEY `uqOrdenPago1` (`referenciaOrdenPago`),
  KEY `idxOrdenPagoCuenta` (`Fk_CuentaBancaria_Codigo`),
  KEY `idxOrdenPagoMoneda` (`Fk_Moneda_Codigo`),
  KEY `idxOrdenPagoCompra` (`Fk_OrdenCompraRecibida_Codigo`),
  KEY `idxOrdenPagoPlanilla` (`Fk_DetallePlanillaRecibida_Codigo`),
  KEY `idxOrdenPagoTransporte` (`Fk_SolicitudPagoTransporte_Codigo`),
  CONSTRAINT `Fk_OrdenPago_Compra` FOREIGN KEY (`Fk_OrdenCompraRecibida_Codigo`) REFERENCES `tblordencomprarecibida` (`Pk_OrdenCompraRecibida`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `Fk_OrdenPago_Cuenta` FOREIGN KEY (`Fk_CuentaBancaria_Codigo`) REFERENCES `tblcuentabancaria` (`idCuentaBancaria`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `Fk_OrdenPago_Moneda` FOREIGN KEY (`Fk_Moneda_Codigo`) REFERENCES `tblmoneda` (`idMoneda`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `Fk_OrdenPago_Planilla` FOREIGN KEY (`Fk_DetallePlanillaRecibida_Codigo`) REFERENCES `tbldetalleplanillarecibida` (`idDetallePlanillaRecibida`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `Fk_OrdenPago_SolicitudTransporte` FOREIGN KEY (`Fk_SolicitudPagoTransporte_Codigo`) REFERENCES `tblsolicitudpagotransporte` (`idSolicitudPagoTransporte`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `ckOrdenPago1` CHECK ((`importeOrdenPago` > 0)),
  CONSTRAINT `ckOrdenPago3` CHECK ((`estadoOrdenPago` in (_utf8mb4'PENDIENTE',_utf8mb4'AUTORIZADA',_utf8mb4'RECHAZADA',_utf8mb4'EMITIDA',_utf8mb4'PAGADA',_utf8mb4'ANULADA'))),
  CONSTRAINT `ckOrdenPago4` CHECK (((((`Fk_OrdenCompraRecibida_Codigo` is not null) + (`Fk_DetallePlanillaRecibida_Codigo` is not null)) + (`Fk_SolicitudPagoTransporte_Codigo` is not null)) = 1))
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblordenpago`
--

LOCK TABLES `tblordenpago` WRITE;
/*!40000 ALTER TABLE `tblordenpago` DISABLE KEYS */;
INSERT INTO `tblordenpago` VALUES (1,'OP-2026-0201','Distribuidora de Carnes La Esperanza, S.A.',18450.0000,'CHEQUE','PAGADA','2026-11-03','tesoreria.ana',1,1,1,NULL,NULL,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(2,'OP-2026-0202','Empaques y Etiquetas de Guatemala, S.A.',7920.5000,'CHEQUE','PAGADA','2026-11-04','tesoreria.ana',2,1,2,NULL,NULL,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(3,'OP-2026-0203','Carlos Mendez Ruiz',4250.0000,'CHEQUE','PAGADA','2026-11-05','tesoreria.ana',4,1,NULL,1,NULL,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(4,'OP-2026-0204','Importadora de Maquinaria Alimenticia, S.A.',3200.0000,'CHEQUE','EMITIDA','2026-11-06','tesoreria.luis',3,2,3,NULL,NULL,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(5,'OP-2026-0205','Especias y Condimentos del Pacifico, S.A.',41300.0000,'CHEQUE','EMITIDA','2026-11-06','tesoreria.luis',1,1,4,NULL,NULL,'2026-11-14 18:34:36','2026-11-14 18:34:36');
/*!40000 ALTER TABLE `tblordenpago` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblpaciente`
--

DROP TABLE IF EXISTS `tblpaciente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblpaciente` (
  `idPaciente` int NOT NULL AUTO_INCREMENT,
  `nombrePaciente` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `apellidoPaciente` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fechaNacimientoPaciente` date DEFAULT NULL,
  `sexoPaciente` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `direccionPaciente` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `telefonoPaciente` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `estadoPaciente` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`idPaciente`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblpaciente`
--

LOCK TABLES `tblpaciente` WRITE;
/*!40000 ALTER TABLE `tblpaciente` DISABLE KEYS */;
/*!40000 ALTER TABLE `tblpaciente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblpais`
--

DROP TABLE IF EXISTS `tblpais`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblpais` (
  `idPais` int NOT NULL AUTO_INCREMENT,
  `nombrePais` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `codigoMonedaPais` char(3) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'GTQ',
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idPais`),
  UNIQUE KEY `uqPaisNombre` (`nombrePais`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblpais`
--

LOCK TABLES `tblpais` WRITE;
/*!40000 ALTER TABLE `tblpais` DISABLE KEYS */;
INSERT INTO `tblpais` VALUES (1,'Guatemala','GTQ',1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(2,'El Salvador','USD',1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(3,'Honduras','HNL',1,'2026-11-14 18:34:36','2026-11-14 18:34:36');
/*!40000 ALTER TABLE `tblpais` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblparametroley`
--

DROP TABLE IF EXISTS `tblparametroley`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblparametroley` (
  `idParametroLey` int NOT NULL AUTO_INCREMENT,
  `idEmpresa` int DEFAULT NULL,
  `codigoParametroLey` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcionParametroLey` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `valorParametroLey` decimal(12,4) NOT NULL,
  `vigenteDesdeParametroLey` date NOT NULL,
  `vigenteHastaParametroLey` date DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idParametroLey`),
  KEY `Fk_ParametroLey_Empresa` (`idEmpresa`),
  KEY `idxParametroLeyBusqueda` (`codigoParametroLey`,`idEmpresa`,`vigenteDesdeParametroLey`),
  CONSTRAINT `Fk_ParametroLey_Empresa` FOREIGN KEY (`idEmpresa`) REFERENCES `tblempresa` (`idEmpresa`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `ckParametroLeyVigencia` CHECK (((`vigenteHastaParametroLey` is null) or (`vigenteHastaParametroLey` >= `vigenteDesdeParametroLey`)))
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblparametroley`
--

LOCK TABLES `tblparametroley` WRITE;
/*!40000 ALTER TABLE `tblparametroley` DISABLE KEYS */;
INSERT INTO `tblparametroley` VALUES (1,NULL,'IGSS_LABORAL','Porcentaje de cuota laboral IGSS',4.8300,'2026-01-01',NULL,1,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(2,NULL,'DIAS_BASE_INDEMNIZACION','Días base del año para calcular la indemnización',365.0000,'2026-01-01',NULL,1,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(3,NULL,'DIAS_VACACIONES_ANIO','Días de vacaciones por año laborado',15.0000,'2026-01-01',NULL,1,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(4,NULL,'MESES_PROMEDIO_INDEMNIZACION','Meses usados para el salario promedio de indemnización',6.0000,'2026-01-01',NULL,1,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(5,1,'DIAS_VACACIONES_ANIO','Días de vacaciones por año (beneficio propio de la empresa)',20.0000,'2026-01-01',NULL,1,'2026-11-14 18:34:37','2026-11-14 18:34:37');
/*!40000 ALTER TABLE `tblparametroley` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblpartidaconsolidada`
--

DROP TABLE IF EXISTS `tblpartidaconsolidada`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblpartidaconsolidada` (
  `Pk_PartidaConsolidada` bigint NOT NULL AUTO_INCREMENT,
  `identificadorEmpresaPartidaConsolidada` int NOT NULL,
  `fechaInicioPartidaConsolidada` date NOT NULL,
  `conceptoPartidaConsolidada` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Fk_Moneda_Codigo` bigint NOT NULL,
  `totalDebePartidaConsolidada` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `totalHaberPartidaConsolidada` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `estadoPartidaConsolidada` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'GENERADA',
  `identificadorUsuarioGeneraPartidaConsolidada` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fechaGeneracionPartidaConsolidada` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `identificadorUsuarioTrasladaPartidaConsolidada` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fechaTrasladoPartidaConsolidada` datetime DEFAULT NULL,
  `claveTrasladoPartidaConsolidada` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `referenciaContabilidadPartidaConsolidada` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mensajeResultadoTrasladoPartidaConsolidada` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`Pk_PartidaConsolidada`),
  UNIQUE KEY `uqPartidaConsolidadaClave` (`claveTrasladoPartidaConsolidada`),
  UNIQUE KEY `uqPartidaConsolidadaPeriodo` (`identificadorEmpresaPartidaConsolidada`,`fechaInicioPartidaConsolidada`,`Fk_Moneda_Codigo`),
  KEY `idxPartidaConsolidadaEmpresaEstado` (`identificadorEmpresaPartidaConsolidada`,`estadoPartidaConsolidada`),
  KEY `idxPartidaConsolidadaMoneda` (`Fk_Moneda_Codigo`),
  CONSTRAINT `Fk_PartidaConsolidada_Moneda` FOREIGN KEY (`Fk_Moneda_Codigo`) REFERENCES `tblmoneda` (`idMoneda`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `ckPartidaConsolidadaCuadre` CHECK (((`estadoPartidaConsolidada` not in (_utf8mb4'VALIDADA',_utf8mb4'EN_PROCESO',_utf8mb4'TRASLADADA')) or ((`totalDebePartidaConsolidada` = `totalHaberPartidaConsolidada`) and (`totalDebePartidaConsolidada` > 0)))),
  CONSTRAINT `ckPartidaConsolidadaDatos` CHECK (((char_length(trim(`conceptoPartidaConsolidada`)) > 0) and (char_length(trim(`claveTrasladoPartidaConsolidada`)) > 0) and (char_length(trim(`identificadorUsuarioGeneraPartidaConsolidada`)) > 0))),
  CONSTRAINT `ckPartidaConsolidadaEmpresa` CHECK ((`identificadorEmpresaPartidaConsolidada` > 0)),
  CONSTRAINT `ckPartidaConsolidadaEstado` CHECK ((`estadoPartidaConsolidada` in (_utf8mb4'GENERADA',_utf8mb4'VALIDADA',_utf8mb4'EN_PROCESO',_utf8mb4'TRASLADADA',_utf8mb4'ERROR'))),
  CONSTRAINT `ckPartidaConsolidadaFechaTraslado` CHECK (((`estadoPartidaConsolidada` <> _utf8mb4'TRASLADADA') or (`fechaTrasladoPartidaConsolidada` is not null))),
  CONSTRAINT `ckPartidaConsolidadaOrdenFechas` CHECK (((`fechaTrasladoPartidaConsolidada` is null) or (`fechaTrasladoPartidaConsolidada` >= `fechaGeneracionPartidaConsolidada`))),
  CONSTRAINT `ckPartidaConsolidadaPeriodo` CHECK ((dayofmonth(`fechaInicioPartidaConsolidada`) = 1)),
  CONSTRAINT `ckPartidaConsolidadaReferenciaTraslado` CHECK (((`estadoPartidaConsolidada` <> _utf8mb4'TRASLADADA') or ((`referenciaContabilidadPartidaConsolidada` is not null) and (char_length(trim(`referenciaContabilidadPartidaConsolidada`)) > 0)))),
  CONSTRAINT `ckPartidaConsolidadaTotales` CHECK (((`totalDebePartidaConsolidada` >= 0) and (`totalHaberPartidaConsolidada` >= 0))),
  CONSTRAINT `ckPartidaConsolidadaUsuarioTraslado` CHECK (((`estadoPartidaConsolidada` not in (_utf8mb4'EN_PROCESO',_utf8mb4'TRASLADADA')) or ((`identificadorUsuarioTrasladaPartidaConsolidada` is not null) and (char_length(trim(`identificadorUsuarioTrasladaPartidaConsolidada`)) > 0))))
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblpartidaconsolidada`
--

LOCK TABLES `tblpartidaconsolidada` WRITE;
/*!40000 ALTER TABLE `tblpartidaconsolidada` DISABLE KEYS */;
INSERT INTO `tblpartidaconsolidada` VALUES (1,1,'2026-08-01','Consolidado bancario de agosto 2026',1,185400.0000,185400.0000,'TRASLADADA','tesoreria.ana','2026-09-01 08:00:00','contabilidad.jgomez','2026-09-01 09:30:00','PCB-1-202608-GTQ','PART-CONT-2026-0831','Partida trasladada correctamente a Contabilidad','2026-11-14 18:34:37','2026-11-14 18:34:37'),(2,1,'2026-09-01','Consolidado bancario de septiembre 2026',1,232750.5000,232750.5000,'TRASLADADA','tesoreria.ana','2026-10-01 08:00:00','contabilidad.jgomez','2026-10-01 10:15:00','PCB-1-202609-GTQ','PART-CONT-2026-0930','Partida trasladada correctamente a Contabilidad','2026-11-14 18:34:37','2026-11-14 18:34:37'),(3,1,'2026-10-01','Consolidado bancario de octubre 2026',1,264300.0000,264300.0000,'VALIDADA','tesoreria.ana','2026-11-02 08:00:00',NULL,NULL,'PCB-1-202610-GTQ',NULL,NULL,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(4,1,'2026-10-01','Consolidado bancario de octubre 2026 en dolares',2,9600.0000,9600.0000,'GENERADA','tesoreria.luis','2026-11-02 08:05:00',NULL,NULL,'PCB-1-202610-USD',NULL,NULL,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(5,1,'2026-11-01','Consolidado bancario de noviembre 2026 (parcial)',1,41550.0000,41550.0000,'GENERADA','tesoreria.ana','2026-11-06 18:00:00',NULL,NULL,'PCB-1-202611-GTQ',NULL,NULL,'2026-11-14 18:34:37','2026-11-14 18:34:37');
/*!40000 ALTER TABLE `tblpartidaconsolidada` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblpartidaconsolidadapolizabancaria`
--

DROP TABLE IF EXISTS `tblpartidaconsolidadapolizabancaria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblpartidaconsolidadapolizabancaria` (
  `Fk_PartidaConsolidada_Codigo` bigint NOT NULL,
  `Fk_PolizaBancaria_Codigo` bigint NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`Fk_PartidaConsolidada_Codigo`,`Fk_PolizaBancaria_Codigo`),
  UNIQUE KEY `uqPartidaConsolidadaPolizaBancariaPoliza` (`Fk_PolizaBancaria_Codigo`),
  CONSTRAINT `Fk_PartidaConsolidadaPolizaBancaria_Partida` FOREIGN KEY (`Fk_PartidaConsolidada_Codigo`) REFERENCES `tblpartidaconsolidada` (`Pk_PartidaConsolidada`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `Fk_PartidaConsolidadaPolizaBancaria_Poliza` FOREIGN KEY (`Fk_PolizaBancaria_Codigo`) REFERENCES `tblpolizabancaria` (`idPolizaBancaria`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblpartidaconsolidadapolizabancaria`
--

LOCK TABLES `tblpartidaconsolidadapolizabancaria` WRITE;
/*!40000 ALTER TABLE `tblpartidaconsolidadapolizabancaria` DISABLE KEYS */;
INSERT INTO `tblpartidaconsolidadapolizabancaria` VALUES (5,1,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(5,2,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(5,3,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(5,4,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(5,5,'2026-11-14 18:34:37','2026-11-14 18:34:37');
/*!40000 ALTER TABLE `tblpartidaconsolidadapolizabancaria` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblpedidodetalle`
--

DROP TABLE IF EXISTS `tblpedidodetalle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblpedidodetalle` (
  `idPedidoDetalle` int NOT NULL AUTO_INCREMENT,
  `idPedidoEncabezado` int NOT NULL,
  `OrdenPedido` int NOT NULL,
  `idProducto` int NOT NULL,
  `cantidadPedidoDetalle` decimal(12,4) NOT NULL,
  `precioUnitarioPedidoDetalle` decimal(12,4) NOT NULL,
  `descuentoMontoPedidoDetalle` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idPedidoEncabezado`,`idPedidoDetalle`),
  UNIQUE KEY `uqPedidoDetalleClaveNegocio` (`idPedidoEncabezado`,`OrdenPedido`,`idProducto`),
  UNIQUE KEY `uqPedidoDetalleId` (`idPedidoDetalle`),
  KEY `idxPedidoDetalleProducto` (`idProducto`),
  CONSTRAINT `Fk_PedidoDetalle_PedidoEncabezado` FOREIGN KEY (`idPedidoEncabezado`) REFERENCES `tblpedidoencabezado` (`idPedidoEncabezado`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `Fk_PedidoDetalle_Producto` FOREIGN KEY (`idProducto`) REFERENCES `tblproducto` (`idProducto`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `ckPedidoDetalleCantidadPrecioDescuento` CHECK (((`cantidadPedidoDetalle` > 0) and (`precioUnitarioPedidoDetalle` >= 0) and (`descuentoMontoPedidoDetalle` >= 0) and (`descuentoMontoPedidoDetalle` <= (`cantidadPedidoDetalle` * `precioUnitarioPedidoDetalle`)))),
  CONSTRAINT `ckPedidoDetalleOrdenPositivo` CHECK ((`OrdenPedido` > 0))
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblpedidodetalle`
--

LOCK TABLES `tblpedidodetalle` WRITE;
/*!40000 ALTER TABLE `tblpedidodetalle` DISABLE KEYS */;
INSERT INTO `tblpedidodetalle` VALUES (1,1,1,13,2.0000,16.0000,0.0000,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(2,1,2,15,3.0000,20.0000,1.0000,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(3,1,3,18,1.0000,26.0000,0.0000,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(4,2,1,13,2.0000,16.0000,0.0000,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(5,2,2,15,3.0000,20.0000,1.0000,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(6,2,3,18,1.0000,26.0000,0.0000,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(7,3,1,13,2.0000,4.5000,0.0000,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(8,3,2,15,3.0000,5.0000,1.0000,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(9,3,3,18,1.0000,5.7500,0.0000,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(10,4,1,13,2.0000,16.0000,0.0000,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(11,4,2,15,3.0000,20.0000,1.0000,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(12,4,3,18,1.0000,26.0000,0.0000,'2026-11-14 18:34:40','2026-11-14 18:34:40');
/*!40000 ALTER TABLE `tblpedidodetalle` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblpedidoencabezado`
--

DROP TABLE IF EXISTS `tblpedidoencabezado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblpedidoencabezado` (
  `idPedidoEncabezado` int NOT NULL AUTO_INCREMENT,
  `referenciaPedidoEncabezado` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `idCotizacionEncabezado` int DEFAULT NULL,
  `idCliente` int NOT NULL,
  `idVendedor` int NOT NULL,
  `idMoneda` bigint NOT NULL,
  `fechaPedidoEncabezado` date NOT NULL,
  `fechaEntregaPedidoEncabezado` date DEFAULT NULL,
  `fechaVencimientoPedidoEncabezado` date DEFAULT NULL,
  `estadoPedidoEncabezado` varchar(25) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'PENDIENTE',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idPedidoEncabezado`),
  UNIQUE KEY `uqPedidoEncabezadoReferencia` (`referenciaPedidoEncabezado`),
  UNIQUE KEY `uqPedidoEncabezadoCotizacion` (`idCotizacionEncabezado`),
  KEY `idxPedidoEncabezadoCliente` (`idCliente`),
  KEY `idxPedidoEncabezadoVendedor` (`idVendedor`),
  KEY `idxPedidoEncabezadoMoneda` (`idMoneda`),
  CONSTRAINT `Fk_PedidoEncabezado_Cliente` FOREIGN KEY (`idCliente`) REFERENCES `tblcliente` (`idCliente`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `Fk_PedidoEncabezado_Cotizacion` FOREIGN KEY (`idCotizacionEncabezado`) REFERENCES `tblcotizacionencabezado` (`idCotizacionEncabezado`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `Fk_PedidoEncabezado_Moneda` FOREIGN KEY (`idMoneda`) REFERENCES `tblmoneda` (`idMoneda`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `Fk_PedidoEncabezado_Vendedor` FOREIGN KEY (`idVendedor`) REFERENCES `tblvendedor` (`idVendedor`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `ckPedidoEncabezadoEstado` CHECK ((`estadoPedidoEncabezado` in (_utf8mb4'PENDIENTE',_utf8mb4'CONFIRMADO',_utf8mb4'COMPLETADO',_utf8mb4'ANULADO'))),
  CONSTRAINT `ckPedidoEncabezadoFechas` CHECK ((((`fechaEntregaPedidoEncabezado` is null) or (`fechaEntregaPedidoEncabezado` >= `fechaPedidoEncabezado`)) and ((`fechaVencimientoPedidoEncabezado` is null) or (`fechaVencimientoPedidoEncabezado` >= `fechaPedidoEncabezado`))))
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblpedidoencabezado`
--

LOCK TABLES `tblpedidoencabezado` WRITE;
/*!40000 ALTER TABLE `tblpedidoencabezado` DISABLE KEYS */;
INSERT INTO `tblpedidoencabezado` VALUES (1,'FAC-QA-PED05',5,10,1,1,'2026-11-14',NULL,NULL,'CONFIRMADO','2026-11-14 18:34:40','2026-11-14 18:34:40'),(2,'FAC-QA-PED06',6,7,1,1,'2026-11-14',NULL,NULL,'CONFIRMADO','2026-11-14 18:34:40','2026-11-14 18:34:40'),(3,'FAC-QA-PED07',7,9,1,2,'2026-11-14',NULL,NULL,'CONFIRMADO','2026-11-14 18:34:40','2026-11-14 18:34:40'),(4,'FAC-QA-PED08',8,5,1,1,'2026-11-14',NULL,NULL,'CONFIRMADO','2026-11-14 18:34:40','2026-11-14 18:34:40');
/*!40000 ALTER TABLE `tblpedidoencabezado` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblpercepciondeduccion`
--

DROP TABLE IF EXISTS `tblpercepciondeduccion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblpercepciondeduccion` (
  `idPercepcionDeduccion` int NOT NULL AUTO_INCREMENT,
  `nombrePercepcionDeduccion` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `periodoPercepcionDeduccion` enum('MENSUAL','ANUAL') COLLATE utf8mb4_unicode_ci NOT NULL,
  `efectoPercepcionDeduccion` tinyint(1) NOT NULL DEFAULT '0',
  `tipoPercepcionDeduccion` enum('Tabla','%','Monto') COLLATE utf8mb4_unicode_ci NOT NULL,
  `valorTipoPercepcionDeduccion` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `aplicacionPercepcionDeduccion` enum('Todos','Algunos') COLLATE utf8mb4_unicode_ci NOT NULL,
  `idCuenta` int DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idPercepcionDeduccion`),
  UNIQUE KEY `uqNombrePercepcionDeduccion` (`nombrePercepcionDeduccion`),
  KEY `Fk_PercepcionDeduccion_Cuenta` (`idCuenta`),
  CONSTRAINT `Fk_PercepcionDeduccion_Cuenta` FOREIGN KEY (`idCuenta`) REFERENCES `tblcuenta` (`idCuenta`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblpercepciondeduccion`
--

LOCK TABLES `tblpercepciondeduccion` WRITE;
/*!40000 ALTER TABLE `tblpercepciondeduccion` DISABLE KEYS */;
INSERT INTO `tblpercepciondeduccion` VALUES (1,'Horas Extra','MENSUAL',1,'Monto',0.0000,'Todos',NULL,1,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(2,'Cuota IGSS Laboral','MENSUAL',0,'%',4.8300,'Todos',NULL,1,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(3,'ISR Retención','ANUAL',0,'Tabla',0.0000,'Algunos',NULL,1,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(4,'Indemnización','ANUAL',1,'Monto',0.0000,'Algunos',NULL,1,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(5,'Aguinaldo Proporcional','ANUAL',1,'Monto',0.0000,'Todos',NULL,1,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(6,'PRUEBA CIERRE - Sueldo ordinario','MENSUAL',1,'Monto',0.0000,'Todos',207,1,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(7,'PRUEBA CIERRE - Bonificación incentivo','MENSUAL',1,'Monto',250.0000,'Todos',209,1,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(8,'PRUEBA CIERRE - IGSS laboral','MENSUAL',0,'%',4.8300,'Todos',92,1,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(9,'PRUEBA CIERRE - ISR','MENSUAL',0,'Monto',0.0000,'Algunos',90,1,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(10,'PRUEBA CIERRE - Bono SIN cuenta','MENSUAL',1,'Monto',0.0000,'Algunos',NULL,1,'2026-11-14 18:34:38','2026-11-14 18:34:38');
/*!40000 ALTER TABLE `tblpercepciondeduccion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblpercepciondeduccionempleado`
--

DROP TABLE IF EXISTS `tblpercepciondeduccionempleado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblpercepciondeduccionempleado` (
  `idPercepcionDeduccionEmpleado` int NOT NULL AUTO_INCREMENT,
  `idPercepcionDeduccion` int NOT NULL,
  `idEmpleado` int DEFAULT NULL,
  `idDepartamento` int DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idPercepcionDeduccionEmpleado`),
  UNIQUE KEY `uqPercepcionDeduccionEmpleadoEmpleado` (`idPercepcionDeduccion`,`idEmpleado`),
  UNIQUE KEY `uqPercepcionDeduccionEmpleadoDepartamento` (`idPercepcionDeduccion`,`idDepartamento`),
  KEY `Fk_PercepcionDeduccionEmpleado_Empleado` (`idEmpleado`),
  KEY `Fk_PercepcionDeduccionEmpleado_Departamento` (`idDepartamento`),
  CONSTRAINT `Fk_PercepcionDeduccionEmpleado_Departamento` FOREIGN KEY (`idDepartamento`) REFERENCES `tbldepartamento` (`idDepartamento`),
  CONSTRAINT `Fk_PercepcionDeduccionEmpleado_Empleado` FOREIGN KEY (`idEmpleado`) REFERENCES `tblempleado` (`idEmpleado`),
  CONSTRAINT `Fk_PercepcionDeduccionEmpleado_PercepcionDeduccion` FOREIGN KEY (`idPercepcionDeduccion`) REFERENCES `tblpercepciondeduccion` (`idPercepcionDeduccion`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblpercepciondeduccionempleado`
--

LOCK TABLES `tblpercepciondeduccionempleado` WRITE;
/*!40000 ALTER TABLE `tblpercepciondeduccionempleado` DISABLE KEYS */;
INSERT INTO `tblpercepciondeduccionempleado` VALUES (1,3,20,NULL,1,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(2,3,21,NULL,1,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(3,3,22,NULL,1,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(4,4,22,NULL,1,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(5,4,NULL,3,1,'2026-11-14 18:34:37','2026-11-14 18:34:37');
/*!40000 ALTER TABLE `tblpercepciondeduccionempleado` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblpercepciondeduccionrango`
--

DROP TABLE IF EXISTS `tblpercepciondeduccionrango`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblpercepciondeduccionrango` (
  `idPercepcionDeduccionRango` int NOT NULL AUTO_INCREMENT,
  `idPercepcionDeduccion` int NOT NULL,
  `salarioDesdePercepcionDeduccionRango` decimal(12,4) NOT NULL,
  `salarioHastaPercepcionDeduccionRango` decimal(12,4) DEFAULT NULL,
  `modoValorPercepcionDeduccionRango` enum('%','Monto') COLLATE utf8mb4_unicode_ci NOT NULL,
  `valorPercepcionDeduccionRango` decimal(12,4) NOT NULL,
  `montoFijoBasePercepcionDeduccionRango` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idPercepcionDeduccionRango`),
  UNIQUE KEY `uqPercepcionDeduccionRangoDesde` (`idPercepcionDeduccion`,`salarioDesdePercepcionDeduccionRango`),
  CONSTRAINT `Fk_PercepcionDeduccionRango_PercepcionDeduccion` FOREIGN KEY (`idPercepcionDeduccion`) REFERENCES `tblpercepciondeduccion` (`idPercepcionDeduccion`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblpercepciondeduccionrango`
--

LOCK TABLES `tblpercepciondeduccionrango` WRITE;
/*!40000 ALTER TABLE `tblpercepciondeduccionrango` DISABLE KEYS */;
INSERT INTO `tblpercepciondeduccionrango` VALUES (1,3,0.0000,50000.0000,'%',0.0000,0.0000,1,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(2,3,50000.0100,100000.0000,'%',3.0000,0.0000,1,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(3,3,100000.0100,200000.0000,'%',5.0000,1500.0000,1,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(4,3,200000.0100,300000.0000,'%',6.0000,6500.0000,1,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(5,3,300000.0100,NULL,'%',7.0000,12500.0000,1,'2026-11-14 18:34:37','2026-11-14 18:34:37');
/*!40000 ALTER TABLE `tblpercepciondeduccionrango` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblperiodocompras`
--

DROP TABLE IF EXISTS `tblperiodocompras`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblperiodocompras` (
  `idPeriodoCompras` int NOT NULL AUTO_INCREMENT,
  `anioPeriodoCompras` smallint NOT NULL,
  `mesPeriodoCompras` tinyint NOT NULL,
  `fechaInicioPeriodoCompras` date NOT NULL,
  `fechaFinPeriodoCompras` date NOT NULL,
  `estadoPeriodoCompras` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Abierto',
  `totalCargosPeriodoCompras` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `totalAbonosPeriodoCompras` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `fechaCierrePeriodoCompras` datetime DEFAULT NULL,
  `idUsuarioCierrePeriodoCompras` int DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idPeriodoCompras`),
  UNIQUE KEY `uqAnioMesPeriodoCompras` (`anioPeriodoCompras`,`mesPeriodoCompras`),
  KEY `idxFechasPeriodoCompras` (`fechaInicioPeriodoCompras`,`fechaFinPeriodoCompras`),
  KEY `idxPeriodoComprasUsuario` (`idUsuarioCierrePeriodoCompras`),
  CONSTRAINT `Fk_PeriodoCompras_Usuario` FOREIGN KEY (`idUsuarioCierrePeriodoCompras`) REFERENCES `tblusuario` (`idUsuario`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `ckEstadoPeriodoCompras` CHECK ((`estadoPeriodoCompras` in (_utf8mb4'Abierto',_utf8mb4'Cerrado'))),
  CONSTRAINT `ckFechasPeriodoCompras` CHECK ((`fechaFinPeriodoCompras` >= `fechaInicioPeriodoCompras`)),
  CONSTRAINT `ckMesPeriodoCompras` CHECK ((`mesPeriodoCompras` between 1 and 12)),
  CONSTRAINT `ckTotalesPeriodoCompras` CHECK (((`totalCargosPeriodoCompras` >= 0) and (`totalAbonosPeriodoCompras` >= 0)))
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblperiodocompras`
--

LOCK TABLES `tblperiodocompras` WRITE;
/*!40000 ALTER TABLE `tblperiodocompras` DISABLE KEYS */;
INSERT INTO `tblperiodocompras` VALUES (1,2026,10,'2026-10-01','2026-10-31','Abierto',0.0000,0.0000,NULL,NULL,'2026-11-14 18:34:40','2026-11-14 18:34:40');
/*!40000 ALTER TABLE `tblperiodocompras` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblperiodovacacion`
--

DROP TABLE IF EXISTS `tblperiodovacacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblperiodovacacion` (
  `idPeriodoVacacion` int NOT NULL AUTO_INCREMENT,
  `idEmpleado` int NOT NULL,
  `fechaInicioPeriodoVacacion` date NOT NULL,
  `fechaFinPeriodoVacacion` date NOT NULL,
  `diasCorrespondientesPeriodoVacacion` decimal(5,2) NOT NULL DEFAULT '15.00',
  `diasTomadosPeriodoVacacion` decimal(5,2) NOT NULL DEFAULT '0.00',
  `diasDisponiblesPeriodoVacacion` decimal(5,2) GENERATED ALWAYS AS ((`diasCorrespondientesPeriodoVacacion` - `diasTomadosPeriodoVacacion`)) STORED,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idPeriodoVacacion`),
  UNIQUE KEY `uqPeriodoVacacionEmpleadoInicio` (`idEmpleado`,`fechaInicioPeriodoVacacion`),
  CONSTRAINT `Fk_PeriodoVacacion_Empleado` FOREIGN KEY (`idEmpleado`) REFERENCES `tblempleado` (`idEmpleado`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `ckPeriodoVacacionDias` CHECK (((`diasTomadosPeriodoVacacion` >= 0) and (`diasTomadosPeriodoVacacion` <= `diasCorrespondientesPeriodoVacacion`))),
  CONSTRAINT `ckPeriodoVacacionFechas` CHECK ((`fechaFinPeriodoVacacion` > `fechaInicioPeriodoVacacion`))
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblperiodovacacion`
--

LOCK TABLES `tblperiodovacacion` WRITE;
/*!40000 ALTER TABLE `tblperiodovacacion` DISABLE KEYS */;
INSERT INTO `tblperiodovacacion` (`idPeriodoVacacion`, `idEmpleado`, `fechaInicioPeriodoVacacion`, `fechaFinPeriodoVacacion`, `diasCorrespondientesPeriodoVacacion`, `diasTomadosPeriodoVacacion`, `is_active`, `created_at`, `updated_at`) VALUES (1,20,'2026-01-01','2026-12-31',15.00,0.00,1,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(2,21,'2026-01-01','2026-12-31',15.00,0.00,1,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(3,22,'2026-01-01','2026-12-31',15.00,0.00,1,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(4,23,'2026-01-01','2026-12-31',15.00,0.00,1,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(5,24,'2026-01-01','2026-12-31',15.00,0.00,1,'2026-11-14 18:34:37','2026-11-14 18:34:37');
/*!40000 ALTER TABLE `tblperiodovacacion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblpermisoempleado`
--

DROP TABLE IF EXISTS `tblpermisoempleado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblpermisoempleado` (
  `idPermisoEmpleado` int NOT NULL AUTO_INCREMENT,
  `idEmpleado` int NOT NULL,
  `idTipoPermiso` int NOT NULL,
  `fechaInicioPermisoEmpleado` date NOT NULL,
  `fechaFinPermisoEmpleado` date NOT NULL,
  `horaInicioPermisoEmpleado` time DEFAULT NULL,
  `horaFinPermisoEmpleado` time DEFAULT NULL,
  `unidadPermisoEmpleado` enum('DIAS','HORAS') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'DIAS',
  `totalPermisoEmpleado` decimal(6,2) DEFAULT '0.00',
  `motivoPermisoEmpleado` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `conGoceSueldoPermisoEmpleado` tinyint(1) NOT NULL DEFAULT '1',
  `estadoPermisoEmpleado` enum('PENDIENTE','APROBADO','RECHAZADO','ANULADO') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'PENDIENTE',
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idPermisoEmpleado`),
  KEY `Fk_PermisoEmpleado_Empleado` (`idEmpleado`),
  KEY `Fk_PermisoEmpleado_TipoPermiso` (`idTipoPermiso`),
  CONSTRAINT `Fk_PermisoEmpleado_Empleado` FOREIGN KEY (`idEmpleado`) REFERENCES `tblempleado` (`idEmpleado`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `Fk_PermisoEmpleado_TipoPermiso` FOREIGN KEY (`idTipoPermiso`) REFERENCES `tbltipopermiso` (`idTipoPermiso`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `ckPermisoEmpleadoFechas` CHECK ((`fechaFinPermisoEmpleado` >= `fechaInicioPermisoEmpleado`)),
  CONSTRAINT `ckPermisoEmpleadoTotal` CHECK ((`totalPermisoEmpleado` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblpermisoempleado`
--

LOCK TABLES `tblpermisoempleado` WRITE;
/*!40000 ALTER TABLE `tblpermisoempleado` DISABLE KEYS */;
INSERT INTO `tblpermisoempleado` VALUES (1,20,4,'2026-11-09','2026-11-09',NULL,NULL,'DIAS',1.00,'Trámite personal en el Registro Civil',1,'PENDIENTE',1,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(2,21,5,'2026-11-10','2026-11-11',NULL,NULL,'DIAS',2.00,'Asuntos familiares',1,'APROBADO',1,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(3,22,2,'2026-11-12','2026-11-12','08:00:00','12:00:00','HORAS',4.00,'Trámite bancario',0,'PENDIENTE',1,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(4,23,2,'2026-11-18','2026-11-20',NULL,NULL,'DIAS',3.00,'Curso externo de carácter personal',0,'RECHAZADO',1,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(5,24,4,'2026-11-25','2026-11-25',NULL,NULL,'DIAS',1.00,'Gestión de documentos personales',1,'PENDIENTE',1,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(6,1,1,'2026-11-09','2026-11-09',NULL,NULL,'DIAS',1.00,'Cita médica',1,'APROBADO',1,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(7,13,3,'2026-11-18','2026-11-19',NULL,NULL,'DIAS',2.00,'Duelo familiar',1,'APROBADO',1,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(8,13,1,'2026-11-05','2026-11-05',NULL,NULL,'DIAS',1.00,'Cita médica',1,'APROBADO',1,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(9,3,4,'2026-11-16','2026-11-16','14:00:00','17:00:00','HORAS',3.00,'Trámite en la SAT',1,'PENDIENTE',1,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(10,1,2,'2026-11-23','2026-11-23',NULL,NULL,'DIAS',1.00,'Asunto personal',0,'PENDIENTE',1,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(11,3,5,'2026-11-12','2026-11-13',NULL,NULL,'DIAS',2.00,'Atención a un familiar',1,'APROBADO',1,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(12,13,4,'2026-11-26','2026-11-26','08:00:00','10:00:00','HORAS',2.00,'Gestión en el banco',1,'RECHAZADO',1,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(13,21,1,'2026-11-17','2026-11-17','09:00:00','11:00:00','HORAS',2.00,'Control médico',1,'APROBADO',1,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(14,23,3,'2026-11-30','2026-12-01',NULL,NULL,'DIAS',2.00,'Duelo familiar',1,'PENDIENTE',1,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(15,20,5,'2026-11-20','2026-11-20',NULL,NULL,'DIAS',1.00,'Asunto familiar (solicitud cancelada)',1,'ANULADO',1,'2026-11-14 18:34:38','2026-11-14 18:34:38');
/*!40000 ALTER TABLE `tblpermisoempleado` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblplanillarecibida`
--

DROP TABLE IF EXISTS `tblplanillarecibida`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblplanillarecibida` (
  `Pk_PlanillaRecibida` bigint NOT NULL AUTO_INCREMENT,
  `referenciaExternaPlanillaRecibida` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `inicioPeriodoPlanillaRecibida` date NOT NULL,
  `finPeriodoPlanillaRecibida` date NOT NULL,
  `estadoPlanillaRecibida` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'RECIBIDA',
  `referenciaDocumentoPlanillaRecibida` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Fk_Moneda_Codigo` bigint NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`Pk_PlanillaRecibida`),
  UNIQUE KEY `uqPlanillaRecibida1` (`referenciaExternaPlanillaRecibida`),
  KEY `idxPlanillaRecibidaMoneda` (`Fk_Moneda_Codigo`),
  CONSTRAINT `Fk_PlanillaRecibida_Moneda` FOREIGN KEY (`Fk_Moneda_Codigo`) REFERENCES `tblmoneda` (`idMoneda`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `ckPlanillaRecibida1` CHECK ((`finPeriodoPlanillaRecibida` >= `inicioPeriodoPlanillaRecibida`)),
  CONSTRAINT `ckPlanillaRecibida2` CHECK ((`estadoPlanillaRecibida` in (_utf8mb4'RECIBIDA',_utf8mb4'PROCESADA',_utf8mb4'ANULADA')))
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblplanillarecibida`
--

LOCK TABLES `tblplanillarecibida` WRITE;
/*!40000 ALTER TABLE `tblplanillarecibida` DISABLE KEYS */;
INSERT INTO `tblplanillarecibida` VALUES (1,'PL-2026-08-Q2','2026-08-16','2026-08-31','PROCESADA','rrhh/planillas/PL-2026-08-Q2.pdf',1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(2,'PL-2026-09-Q1','2026-09-01','2026-09-15','PROCESADA','rrhh/planillas/PL-2026-09-Q1.pdf',1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(3,'PL-2026-09-Q2','2026-09-16','2026-09-30','PROCESADA','rrhh/planillas/PL-2026-09-Q2.pdf',1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(4,'PL-2026-10-Q1','2026-10-01','2026-10-15','PROCESADA','rrhh/planillas/PL-2026-10-Q1.pdf',1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(5,'PL-2026-10-Q2','2026-10-16','2026-10-31','RECIBIDA','rrhh/planillas/PL-2026-10-Q2.pdf',1,'2026-11-14 18:34:36','2026-11-14 18:34:36');
/*!40000 ALTER TABLE `tblplanillarecibida` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblplanmejora`
--

DROP TABLE IF EXISTS `tblplanmejora`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblplanmejora` (
  `idPlanMejora` int NOT NULL AUTO_INCREMENT,
  `idEvaluacionDesempeno` int DEFAULT NULL,
  `nombrePlanMejora` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcionPlanMejora` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idPlanMejora`),
  UNIQUE KEY `uqNombrePlanMejora` (`nombrePlanMejora`),
  UNIQUE KEY `uqPlanMejoraEvaluacion` (`idEvaluacionDesempeno`),
  CONSTRAINT `Fk_PlanMejora_EvaluacionDesempeno` FOREIGN KEY (`idEvaluacionDesempeno`) REFERENCES `tblevaluaciondesempeno` (`idEvaluacionDesempeno`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblplanmejora`
--

LOCK TABLES `tblplanmejora` WRITE;
/*!40000 ALTER TABLE `tblplanmejora` DISABLE KEYS */;
INSERT INTO `tblplanmejora` VALUES (1,5,'Plan de Refuerzo en Calidad e Iniciativa','Acompañamiento semanal y metas de calidad para el siguiente trimestre',1,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(2,3,'Plan de Puntualidad y Productividad','Seguimiento diario de horarios y metas de producción',1,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(3,2,'Plan de Trabajo en Equipo','Talleres de comunicación y proyectos colaborativos',1,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(4,1,'Plan de Desarrollo de Iniciativa','Asignación de proyectos de mejora continua',1,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(5,4,'Plan de Liderazgo','Preparación para coordinar equipos de trabajo',1,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(6,6,'Plan de Productividad y Calidad','Metas semanales de productividad y revisión de calidad con el jefe inmediato',1,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(7,9,'Plan de Trabajo en Equipo e Iniciativa','Participación en proyectos colaborativos y propuesta de al menos una mejora por mes',1,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(8,12,'Plan de Nivelación General','Capacitación en calidad e iniciativa con seguimiento quincenal',1,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(9,13,'Plan de Seguimiento Trimestral','Reunión mensual de seguimiento para sostener la mejora en calidad y productividad',1,'2026-11-14 18:34:38','2026-11-14 18:34:38');
/*!40000 ALTER TABLE `tblplanmejora` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblplazo`
--

DROP TABLE IF EXISTS `tblplazo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblplazo` (
  `idPlazo` int NOT NULL AUTO_INCREMENT,
  `nombrePlazo` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `diasPlazo` int NOT NULL DEFAULT '0',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idPlazo`),
  UNIQUE KEY `uqnombrePlazo` (`nombrePlazo`),
  CONSTRAINT `ckDiasPlazo` CHECK ((`diasPlazo` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblplazo`
--

LOCK TABLES `tblplazo` WRITE;
/*!40000 ALTER TABLE `tblplazo` DISABLE KEYS */;
INSERT INTO `tblplazo` VALUES (1,'Contado',0,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(2,'8 días',8,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(3,'15 días',15,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(4,'30 días',30,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(5,'45 días',45,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(6,'60 días',60,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(7,'90 días',90,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(8,'120 días',120,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(9,'150 días',150,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(10,'180 días',180,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(11,'Prueba 0d2d5068e05a - 15 dias',15,'2026-11-14 18:34:39','2026-11-14 18:34:39'),(12,'Prueba 0d2d5068e05a - 30 dias',30,'2026-11-14 18:34:39','2026-11-14 18:34:39'),(13,'Prueba 0d2d5068e05a - 45 dias',45,'2026-11-14 18:34:39','2026-11-14 18:34:39'),(14,'Prueba 0d2d5068e05a - 60 dias',60,'2026-11-14 18:34:39','2026-11-14 18:34:39'),(15,'Prueba 0d2d5068e05a - 75 dias',75,'2026-11-14 18:34:39','2026-11-14 18:34:39');
/*!40000 ALTER TABLE `tblplazo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblpoliticaaprobacion`
--

DROP TABLE IF EXISTS `tblpoliticaaprobacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblpoliticaaprobacion` (
  `Pk_PoliticaAprobacion` bigint NOT NULL AUTO_INCREMENT,
  `nombrePoliticaAprobacion` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tipoOperacionPoliticaAprobacion` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `montoMinimoPoliticaAprobacion` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `montoMaximoPoliticaAprobacion` decimal(12,4) NOT NULL,
  `cantidadAprobacionesPoliticaAprobacion` int NOT NULL DEFAULT '1',
  `fechaInicioPoliticaAprobacion` date NOT NULL,
  `fechaFinPoliticaAprobacion` date DEFAULT NULL,
  `Fk_Moneda_Codigo` bigint NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`Pk_PoliticaAprobacion`),
  KEY `idxPoliticaAprobacionMoneda` (`Fk_Moneda_Codigo`),
  CONSTRAINT `Fk_PoliticaAprobacion_Moneda` FOREIGN KEY (`Fk_Moneda_Codigo`) REFERENCES `tblmoneda` (`idMoneda`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `ckPoliticaAprobacion1` CHECK ((`tipoOperacionPoliticaAprobacion` in (_utf8mb4'ORDEN_COMPRA',_utf8mb4'ORDEN_PAGO'))),
  CONSTRAINT `ckPoliticaAprobacion2` CHECK (((`montoMinimoPoliticaAprobacion` >= 0) and (`montoMaximoPoliticaAprobacion` >= `montoMinimoPoliticaAprobacion`))),
  CONSTRAINT `ckPoliticaAprobacion3` CHECK ((`cantidadAprobacionesPoliticaAprobacion` > 0)),
  CONSTRAINT `ckPoliticaAprobacion4` CHECK (((`fechaFinPoliticaAprobacion` is null) or (`fechaFinPoliticaAprobacion` >= `fechaInicioPoliticaAprobacion`))),
  CONSTRAINT `ckPoliticaAprobacion5` CHECK ((`is_active` in (0,1)))
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblpoliticaaprobacion`
--

LOCK TABLES `tblpoliticaaprobacion` WRITE;
/*!40000 ALTER TABLE `tblpoliticaaprobacion` DISABLE KEYS */;
INSERT INTO `tblpoliticaaprobacion` VALUES (1,'Orden de pago en quetzales hasta Q50,000','ORDEN_PAGO',0.0000,50000.0000,1,'2026-01-01',NULL,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(2,'Orden de pago en quetzales mayor a Q50,000','ORDEN_PAGO',50000.0100,1000000.0000,2,'2026-01-01',NULL,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(3,'Orden de pago en dolares hasta US$6,500','ORDEN_PAGO',0.0000,6500.0000,1,'2026-01-01',NULL,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(4,'Orden de pago en dolares mayor a US$6,500','ORDEN_PAGO',6500.0100,200000.0000,2,'2026-01-01',NULL,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(5,'Orden de compra en quetzales hasta Q25,000','ORDEN_COMPRA',0.0000,25000.0000,1,'2026-01-01',NULL,1,1,'2026-11-14 18:34:36','2026-11-14 18:34:36');
/*!40000 ALTER TABLE `tblpoliticaaprobacion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblpolizabancaria`
--

DROP TABLE IF EXISTS `tblpolizabancaria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblpolizabancaria` (
  `idPolizaBancaria` bigint NOT NULL AUTO_INCREMENT,
  `fechaPolizaBancaria` date NOT NULL,
  `estadoPolizaBancaria` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'BORRADOR',
  `referenciaContabilidadPolizaBancaria` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fechaEnvioContabilidadPolizaBancaria` datetime DEFAULT NULL,
  `Fk_MovimientoBancario_Codigo` bigint NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idPolizaBancaria`),
  UNIQUE KEY `uqPolizaBancaria1` (`Fk_MovimientoBancario_Codigo`),
  CONSTRAINT `Fk_PolizaBancaria_Movimiento` FOREIGN KEY (`Fk_MovimientoBancario_Codigo`) REFERENCES `tblmovimientobancario` (`idMovimientoBancario`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `ckPolizaBancaria1` CHECK ((`estadoPolizaBancaria` in (_utf8mb4'BORRADOR',_utf8mb4'VALIDADA',_utf8mb4'PENDIENTE_ENVIO',_utf8mb4'ENVIADA',_utf8mb4'ACEPTADA',_utf8mb4'RECHAZADA',_utf8mb4'ANULADA')))
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblpolizabancaria`
--

LOCK TABLES `tblpolizabancaria` WRITE;
/*!40000 ALTER TABLE `tblpolizabancaria` DISABLE KEYS */;
INSERT INTO `tblpolizabancaria` VALUES (1,'2026-11-03','ENVIADA','POL-CONT-2026-1103-01','2026-11-03 16:45:00',1,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(2,'2026-11-04','ENVIADA','POL-CONT-2026-1104-01','2026-11-04 16:30:00',2,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(3,'2026-11-05','VALIDADA',NULL,NULL,3,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(4,'2026-11-02','ENVIADA','POL-CONT-2026-1102-01','2026-11-02 16:10:00',4,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(5,'2026-11-04','BORRADOR',NULL,NULL,5,'2026-11-14 18:34:37','2026-11-14 18:34:37');
/*!40000 ALTER TABLE `tblpolizabancaria` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblpolizadetalle`
--

DROP TABLE IF EXISTS `tblpolizadetalle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblpolizadetalle` (
  `idPolizaDetalle` int NOT NULL AUTO_INCREMENT,
  `idPolizaEncabezado` int NOT NULL,
  `idCuenta` int NOT NULL,
  `lineaPolizaDetalle` int NOT NULL,
  `debePolizaDetalle` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `haberPolizaDetalle` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `descripcionPolizaDetalle` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idPolizaDetalle`),
  UNIQUE KEY `uqPolizaDetalleLinea` (`idPolizaEncabezado`,`lineaPolizaDetalle`),
  KEY `idxPolizaDetalleEncabezado` (`idPolizaEncabezado`),
  KEY `idxPolizaDetalleCuenta` (`idCuenta`),
  CONSTRAINT `Fk_PolizaDetalle_Cuenta` FOREIGN KEY (`idCuenta`) REFERENCES `tblcuenta` (`idCuenta`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `Fk_PolizaDetalle_PolizaEncabezado` FOREIGN KEY (`idPolizaEncabezado`) REFERENCES `tblpolizaencabezado` (`idPolizaEncabezado`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `ckDetalleMontoPositivo` CHECK (((`debePolizaDetalle` >= 0) and (`haberPolizaDetalle` >= 0))),
  CONSTRAINT `ckDetallePartidaDoble` CHECK (((`debePolizaDetalle` = 0) or (`haberPolizaDetalle` = 0)))
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblpolizadetalle`
--

LOCK TABLES `tblpolizadetalle` WRITE;
/*!40000 ALTER TABLE `tblpolizadetalle` DISABLE KEYS */;
INSERT INTO `tblpolizadetalle` VALUES (1,1,16,1,56000.0000,0.0000,'Clientes Nacionales - factura A-1045',1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(2,1,134,2,0.0000,30000.0000,'Ventas de Embutidos - Línea Res',1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(3,1,135,3,0.0000,20000.0000,'Ventas de Embutidos - Línea Cerdo',1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(4,1,91,4,0.0000,6000.0000,'IVA Trasladado 12% sobre la venta',1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(5,2,170,1,18000.0000,0.0000,'Costo de Ventas - Línea Res',1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(6,2,171,2,12000.0000,0.0000,'Costo de Ventas - Línea Cerdo',1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(7,2,26,3,0.0000,30000.0000,'Salida de Inventario de Productos Terminados',1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(8,3,24,1,40000.0000,0.0000,'Inventario de Materias Primas - carne y especias',1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(9,3,29,2,4800.0000,0.0000,'IVA Acreditable 12% sobre la compra',1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(10,3,83,3,0.0000,44800.0000,'Proveedores Nacionales - factura B-7781',1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(11,4,207,1,25000.0000,0.0000,'Sueldos Normales - personal administrativo',1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(12,4,210,2,3167.5000,0.0000,'Cuota patronal IGSS 12.67%',1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(13,4,92,3,0.0000,4375.0000,'Cuotas Obrero-Patronales IGSS por pagar',1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(14,4,86,4,0.0000,23792.5000,'Sueldos por Pagar (Personal Administrativo)',1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(15,5,83,1,44800.0000,0.0000,'Cancelación de factura B-7781',1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(16,5,8,2,0.0000,44800.0000,'Banco Industrial (MN) - cheque 004521',1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(17,6,176,1,4166.6667,0.0000,'Depreciación de Maquinaria de Producción',1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(18,6,222,2,833.3333,0.0000,'Depreciación de Equipo Electrónico de Cómputo',1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(19,6,51,3,0.0000,4166.6667,'Depreciación Acumulada de Maquinaria y Equipo',1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(20,6,54,4,0.0000,833.3333,'Depreciación Acumulada de Equipo de Cómputo',1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(21,7,201,1,7500.0000,0.0000,'Propaganda Impresa - campaña noviembre',1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(22,7,29,2,900.0000,0.0000,'IVA Acreditable 12%',1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(23,7,103,3,0.0000,8400.0000,'Acreedores Diversos - agencia publicitaria',1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(24,8,5,1,1120.0000,0.0000,'Caja General - recibo 0098 (anulado)',1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(25,8,136,2,0.0000,1000.0000,'Ventas de Embutidos - Línea Pollo (anulado)',1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(26,8,91,3,0.0000,120.0000,'IVA Trasladado (anulado)',1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(27,9,8,1,25000.0000,0.0000,'Ingreso bancario doc. BOL-2026-9912',1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(28,9,16,2,0.0000,25000.0000,'Contrapartida doc. BOL-2026-9912',1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(29,10,228,1,350.0000,0.0000,'Contrapartida doc. NDB-2026-0451',1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(30,10,8,2,0.0000,350.0000,'Egreso bancario doc. NDB-2026-0451',1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(31,11,207,1,32000.0000,0.0000,'Sueldos Normales 2025-12',1,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(32,11,209,2,1250.0000,0.0000,'Prestaciones Normales (bonificación incentivo) 2025-12',1,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(33,11,210,3,4212.7750,0.0000,'Impuestos y Aportaciones Patronales (12.67 %) 2025-12',1,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(34,11,92,4,0.0000,5758.3750,'IGSS laboral + patronal por pagar 2025-12',1,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(35,11,90,5,0.0000,300.0000,'ISR por pagar 2025-12',1,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(36,11,86,6,0.0000,31404.4000,'Sueldos por pagar (neto) 2025-12',1,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(37,12,207,1,32000.0000,0.0000,'Sueldos Normales 2026-01',1,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(38,12,209,2,1250.0000,0.0000,'Prestaciones Normales (bonificación incentivo) 2026-01',1,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(39,12,210,3,4212.7750,0.0000,'Impuestos y Aportaciones Patronales (12.67 %) 2026-01',1,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(40,12,92,4,0.0000,5758.3750,'IGSS laboral + patronal por pagar 2026-01',1,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(41,12,90,5,0.0000,300.0000,'ISR por pagar 2026-01',1,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(42,12,86,6,0.0000,31404.4000,'Sueldos por pagar (neto) 2026-01',1,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(43,13,207,1,39500.0000,0.0000,'Sueldos Normales 2026-02',1,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(44,13,209,2,1500.0000,0.0000,'Prestaciones Normales (bonificación incentivo) 2026-02',1,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(45,13,210,3,5194.7000,0.0000,'Impuestos y Aportaciones Patronales (12.67 %) 2026-02',1,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(46,13,92,4,0.0000,7102.5500,'IGSS laboral + patronal por pagar 2026-02',1,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(47,13,90,5,0.0000,450.0000,'ISR por pagar 2026-02',1,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(48,13,86,6,0.0000,38642.1500,'Sueldos por pagar (neto) 2026-02',1,'2026-11-14 18:34:38','2026-11-14 18:34:38');
/*!40000 ALTER TABLE `tblpolizadetalle` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblpolizaencabezado`
--

DROP TABLE IF EXISTS `tblpolizaencabezado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblpolizaencabezado` (
  `idPolizaEncabezado` int NOT NULL AUTO_INCREMENT,
  `idModuloContable` int NOT NULL DEFAULT '1',
  `idPais` int NOT NULL DEFAULT '1',
  `idActualizacionSaldos` int DEFAULT NULL,
  `codigoPolizaEncabezado` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fechaPolizaEncabezado` date NOT NULL,
  `periodoContablePolizaEncabezado` char(7) COLLATE utf8mb4_unicode_ci NOT NULL,
  `estadoPolizaEncabezado` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'BORRADOR',
  `documentoOrigenPolizaEncabezado` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `descripcionPolizaEncabezado` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idPolizaEncabezado`),
  UNIQUE KEY `uqPolizaCodigo` (`codigoPolizaEncabezado`),
  UNIQUE KEY `uqPolizaDocumentoOrigen` (`idModuloContable`,`documentoOrigenPolizaEncabezado`),
  KEY `idxPolizaModulo` (`idModuloContable`),
  KEY `idxPolizaPeriodo` (`periodoContablePolizaEncabezado`),
  KEY `idxPolizaFecha` (`fechaPolizaEncabezado`),
  KEY `idxPolizaEstado` (`estadoPolizaEncabezado`),
  KEY `idxPolizaActualizacion` (`idActualizacionSaldos`),
  KEY `Fk_PolizaEncabezado_Pais` (`idPais`),
  CONSTRAINT `Fk_PolizaEncabezado_Actualizacion` FOREIGN KEY (`idActualizacionSaldos`) REFERENCES `tblactualizacionsaldos` (`idActualizacionSaldos`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `Fk_PolizaEncabezado_Modulo` FOREIGN KEY (`idModuloContable`) REFERENCES `tblmodulocontable` (`idModuloContable`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `Fk_PolizaEncabezado_Pais` FOREIGN KEY (`idPais`) REFERENCES `tblpais` (`idPais`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `ckPolizaEstado` CHECK ((`estadoPolizaEncabezado` in (_utf8mb4'BORRADOR',_utf8mb4'VALIDADA',_utf8mb4'APLICADA',_utf8mb4'ANULADA')))
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblpolizaencabezado`
--

LOCK TABLES `tblpolizaencabezado` WRITE;
/*!40000 ALTER TABLE `tblpolizaencabezado` DISABLE KEYS */;
INSERT INTO `tblpolizaencabezado` VALUES (1,5,1,1,'POL-2026-10-0001','2026-10-02','2026-10','APLICADA','FAC-A-1045','Venta de embutidos al crédito, líneas Res y Cerdo, factura serie A-1045',1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(2,5,1,1,'POL-2026-10-0002','2026-10-02','2026-10','APLICADA','FAC-A-1045-CV','Registro del costo de ventas de la factura serie A-1045',1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(3,3,1,1,'POL-2026-10-0003','2026-10-05','2026-10','APLICADA','FAC-B-7781','Compra de materia prima al crédito a proveedor nacional, factura B-7781',1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(4,4,1,NULL,'POL-2026-10-0004','2026-10-15','2026-10','VALIDADA','PLA-2026-10-Q2','Planilla quincenal del personal administrativo, segunda quincena',1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(5,1,1,1,'POL-2026-10-0005','2026-10-20','2026-10','APLICADA','CHQ-004521','Pago a proveedor nacional mediante cheque de Banco Industrial',1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(6,1,1,NULL,'POL-2026-10-0006','2026-10-31','2026-10','VALIDADA','DEP-2026-10','Depreciación mensual de maquinaria de planta y equipo de cómputo',1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(7,1,1,NULL,'POL-2026-10-0007','2026-10-31','2026-10','BORRADOR',NULL,'Provisión de campaña publicitaria impresa, pendiente de aprobación',1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(8,5,1,NULL,'POL-2026-10-0008','2026-10-28','2026-10','ANULADA','REC-0098','Venta de contado anulada por error de digitación en el monto',0,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(9,6,1,1,'POL-2026-10-0009','2026-10-22','2026-10','APLICADA','BOL-2026-9912','Deposito por cobro de factura A-1045',1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(10,6,1,NULL,'POL-2026-10-0010','2026-10-30','2026-10','VALIDADA','NDB-2026-0451','Nota de debito por comisiones bancarias del mes',1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(11,4,1,NULL,'POL-NOM-2025-12','2025-12-31','2025-12','VALIDADA','NOM-2025-12','Cierre de nómina 2025-12',1,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(12,4,1,NULL,'POL-NOM-2026-01','2026-01-31','2026-01','VALIDADA','NOM-2026-01','Cierre de nómina 2026-01',1,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(13,4,1,NULL,'POL-NOM-2026-02','2026-02-28','2026-02','VALIDADA','NOM-2026-02','Cierre de nómina 2026-02',1,'2026-11-14 18:34:38','2026-11-14 18:34:38');
/*!40000 ALTER TABLE `tblpolizaencabezado` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblpreciotipocliente`
--

DROP TABLE IF EXISTS `tblpreciotipocliente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblpreciotipocliente` (
  `idPrecioTipoCliente` int NOT NULL AUTO_INCREMENT,
  `idTipoCliente` int NOT NULL,
  `idProducto` int NOT NULL,
  `porcentajeDescuento` decimal(5,2) NOT NULL DEFAULT '0.00',
  `precioBase` decimal(12,4) NOT NULL,
  `precioFinal` decimal(12,4) GENERATED ALWAYS AS (round((`precioBase` * (1 - (`porcentajeDescuento` / 100))),4)) STORED,
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idPrecioTipoCliente`),
  UNIQUE KEY `uqPrecioTipoCliente_TipoClienteProducto` (`idTipoCliente`,`idProducto`),
  KEY `Fk_PrecioTipoCliente_Producto` (`idProducto`),
  CONSTRAINT `Fk_PrecioTipoCliente_Producto` FOREIGN KEY (`idProducto`) REFERENCES `tblproducto` (`idProducto`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `Fk_PrecioTipoCliente_TipoCliente` FOREIGN KEY (`idTipoCliente`) REFERENCES `tbltipocliente` (`idTipoCliente`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `ckPrecioTipoClienteDescuentoRango` CHECK ((`porcentajeDescuento` between 0 and 100))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblpreciotipocliente`
--

LOCK TABLES `tblpreciotipocliente` WRITE;
/*!40000 ALTER TABLE `tblpreciotipocliente` DISABLE KEYS */;
/*!40000 ALTER TABLE `tblpreciotipocliente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblpresupuestodetalle`
--

DROP TABLE IF EXISTS `tblpresupuestodetalle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblpresupuestodetalle` (
  `idPresupuestoDetalle` int NOT NULL AUTO_INCREMENT,
  `idPresupuestoEncabezado` int NOT NULL,
  `idModuloContable` int NOT NULL,
  `idPolizaDetalle` int DEFAULT NULL,
  `nombrePresupuestoDetalle` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `cantidadPresupuestoDetalle` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idPresupuestoDetalle`),
  KEY `idxPresupuestoDetalleEncabezado` (`idPresupuestoEncabezado`),
  KEY `idxPresupuestoDetalleModulo` (`idModuloContable`),
  KEY `idxPresupuestoDetallePolizaDet` (`idPolizaDetalle`),
  CONSTRAINT `Fk_PresupuestoDetalle_Modulo` FOREIGN KEY (`idModuloContable`) REFERENCES `tblmodulocontable` (`idModuloContable`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `Fk_PresupuestoDetalle_PolizaDetalle` FOREIGN KEY (`idPolizaDetalle`) REFERENCES `tblpolizadetalle` (`idPolizaDetalle`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `Fk_PresupuestoDetalle_PresupuestoEncabezado` FOREIGN KEY (`idPresupuestoEncabezado`) REFERENCES `tblpresupuestoencabezado` (`idPresupuestoEncabezado`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `ckPresupuestoDetalleCantidad` CHECK ((`cantidadPresupuestoDetalle` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblpresupuestodetalle`
--

LOCK TABLES `tblpresupuestodetalle` WRITE;
/*!40000 ALTER TABLE `tblpresupuestodetalle` DISABLE KEYS */;
/*!40000 ALTER TABLE `tblpresupuestodetalle` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblpresupuestoencabezado`
--

DROP TABLE IF EXISTS `tblpresupuestoencabezado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblpresupuestoencabezado` (
  `idPresupuestoEncabezado` int NOT NULL AUTO_INCREMENT,
  `nombrePresupuestoEncabezado` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `totalPresupuestoEncabezado` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `gastadoPresupuestoEncabezado` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `restantePresupuestoEncabezado` decimal(12,4) GENERATED ALWAYS AS ((`totalPresupuestoEncabezado` - `gastadoPresupuestoEncabezado`)) STORED,
  `fechaInicioPresupuestoEncabezado` date NOT NULL,
  `fechaCierrePresupuestoEncabezado` date DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idPresupuestoEncabezado`),
  CONSTRAINT `ckPresupuestoFechas` CHECK (((`fechaCierrePresupuestoEncabezado` is null) or (`fechaCierrePresupuestoEncabezado` >= `fechaInicioPresupuestoEncabezado`))),
  CONSTRAINT `ckPresupuestoMontos` CHECK (((`totalPresupuestoEncabezado` >= 0) and (`gastadoPresupuestoEncabezado` >= 0)))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblpresupuestoencabezado`
--

LOCK TABLES `tblpresupuestoencabezado` WRITE;
/*!40000 ALTER TABLE `tblpresupuestoencabezado` DISABLE KEYS */;
/*!40000 ALTER TABLE `tblpresupuestoencabezado` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblproducto`
--

DROP TABLE IF EXISTS `tblproducto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblproducto` (
  `idProducto` int NOT NULL AUTO_INCREMENT,
  `skuProducto` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `clasificacionProducto` char(5) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '?????',
  `nombreProducto` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `idProveedorProductos` int NOT NULL,
  `Fk_Marca_Codigo` int NOT NULL,
  `Fk_Categoria_Codigo` int NOT NULL,
  `Fk_Linea_Codigo` int NOT NULL,
  `descripcionProducto` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `imagenProducto` longblob NOT NULL,
  `paisProducto` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `precioCostoProducto` decimal(12,4) NOT NULL,
  `precioVentaProducto` decimal(12,4) NOT NULL,
  `porcentajeComisionProducto` decimal(3,2) NOT NULL,
  `stockMinimoProducto` int NOT NULL,
  `stockMaximoProducto` int NOT NULL,
  `pesoProducto` decimal(4,2) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idProducto`),
  UNIQUE KEY `uqProductoSku` (`skuProducto`),
  KEY `idxProductoProveedorProductos` (`idProveedorProductos`),
  KEY `Fk_Producto_Marca` (`Fk_Marca_Codigo`),
  KEY `Fk_Producto_Categoria` (`Fk_Categoria_Codigo`),
  KEY `Fk_Producto_Linea` (`Fk_Linea_Codigo`),
  CONSTRAINT `Fk_Producto_Categoria` FOREIGN KEY (`Fk_Categoria_Codigo`) REFERENCES `tblcategoria` (`idCategoria`) ON DELETE RESTRICT,
  CONSTRAINT `Fk_Producto_Linea` FOREIGN KEY (`Fk_Linea_Codigo`) REFERENCES `tbllinea` (`idLinea`) ON DELETE RESTRICT,
  CONSTRAINT `Fk_Producto_Marca` FOREIGN KEY (`Fk_Marca_Codigo`) REFERENCES `tblmarca` (`idMarca`) ON DELETE RESTRICT,
  CONSTRAINT `Fk_Producto_Proveedor` FOREIGN KEY (`idProveedorProductos`) REFERENCES `tblproveedor` (`idProveedor`) ON DELETE RESTRICT,
  CONSTRAINT `ckPorcentajeComisionProductoRango` CHECK (((`porcentajeComisionProducto` >= 0.00) and (`porcentajeComisionProducto` <= 0.99))),
  CONSTRAINT `ckProductoMinMax` CHECK (((`stockMinimoProducto` >= 0) and (`stockMaximoProducto` >= `stockMinimoProducto`)))
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblproducto`
--

LOCK TABLES `tblproducto` WRITE;
/*!40000 ALTER TABLE `tblproducto` DISABLE KEYS */;
INSERT INTO `tblproducto` VALUES (1,'SAL-VIE-500','REFRI','Salchicha vienesa 500 g',1,1,1,1,'Paquete refrigerado de salchicha vienesa de 500 gramos',_binary '�PNG\r\n\Z\n\0\0\0\rIHDR\0\0\0\0\0\0\0\0\0ĉ\0\0\0\rIDATx�cx�\�\�\0	\Z�p:�(\0\0\0\0IEND�B`�','Guatemala',18.5000,26.9000,0.10,25,350,0.50,'2026-11-14 18:34:39','2026-11-14 18:34:39'),(2,'CHO-PAR-450','REFRI','Chorizo parrillero 450 g',1,2,2,2,'Chorizo para parrilla empacado al vacío, 450 gramos',_binary '�PNG\r\n\Z\n\0\0\0\rIHDR\0\0\0\0\0\0\0\0\0ĉ\0\0\0\rIDATx�cx�\�\�\0	\Z�p:�(\0\0\0\0IEND�B`�','Guatemala',22.7500,33.5000,0.12,20,250,0.45,'2026-11-14 18:34:39','2026-11-14 18:34:39'),(3,'JAM-PIE-350','REFRI','Jamón de pierna 350 g',1,3,3,3,'Jamón de pierna rebanado, presentación de 350 gramos',_binary '�PNG\r\n\Z\n\0\0\0\rIHDR\0\0\0\0\0\0\0\0\0ĉ\0\0\0\rIDATx�cx�\�\�\0	\Z�p:�(\0\0\0\0IEND�B`�','Guatemala',24.2000,38.0000,0.15,15,200,0.35,'2026-11-14 18:34:39','2026-11-14 18:34:39'),(4,'MOR-FAM-1KG','REFRI','Mortadela familiar 1 kg',1,4,4,4,'Mortadela cocida en presentación familiar de un kilogramo',_binary '�PNG\r\n\Z\n\0\0\0\rIHDR\0\0\0\0\0\0\0\0\0ĉ\0\0\0\rIDATx�cx�\�\�\0	\Z�p:�(\0\0\0\0IEND�B`�','Guatemala',36.0000,49.5000,0.08,30,400,1.00,'2026-11-14 18:34:39','2026-11-14 18:34:39'),(5,'TOC-AHU-250','AHUMA','Tocino ahumado 250 g',1,5,5,5,'Tocino ahumado y rebanado en presentación de 250 gramos',_binary '�PNG\r\n\Z\n\0\0\0\rIHDR\0\0\0\0\0\0\0\0\0ĉ\0\0\0\rIDATx�cx�\�\�\0	\Z�p:�(\0\0\0\0IEND�B`�','Guatemala',20.8000,31.2500,0.11,20,220,0.25,'2026-11-14 18:34:39','2026-11-14 18:34:39'),(6,'PR-0d2d5068e05a-1','?????','Producto prueba 1',13,1,1,1,'Producto de ejemplo','','Guatemala',10.0000,15.0000,0.00,5,100,1.00,'2026-11-14 18:34:39','2026-11-14 18:34:39'),(7,'PR-0d2d5068e05a-2','?????','Producto prueba 2',14,1,1,1,'Producto de ejemplo','','Guatemala',10.0000,15.0000,0.00,5,100,1.00,'2026-11-14 18:34:39','2026-11-14 18:34:39'),(8,'PR-0d2d5068e05a-3','?????','Producto prueba 3',15,1,1,1,'Producto de ejemplo','','Guatemala',10.0000,15.0000,0.00,5,100,1.00,'2026-11-14 18:34:39','2026-11-14 18:34:39'),(9,'PR-0d2d5068e05a-4','?????','Producto prueba 4',16,1,1,1,'Producto de ejemplo','','Guatemala',10.0000,15.0000,0.00,5,100,1.00,'2026-11-14 18:34:39','2026-11-14 18:34:39'),(10,'PR-0d2d5068e05a-5','?????','Producto prueba 5',17,1,1,1,'Producto de ejemplo','','Guatemala',10.0000,15.0000,0.00,5,100,1.00,'2026-11-14 18:34:39','2026-11-14 18:34:39'),(11,'FAC-QA-P01','?????','Jamón de pavo 250 g',18,6,6,6,'Producto ficticio de auditoría',_binary '�PNG\r\n\Z\n\0\0\0\rIHDR\0\0\0\0\0\0\0\0\0�\0\0\0IDATx\�c��\0\0\�_W\0\0\0\0IEND�B`�','Guatemala',15.0000,30.0000,0.00,1,1000,0.50,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(12,'FAC-QA-P02','?????','Jamón tradicional 500 g',18,6,6,6,'Producto ficticio de auditoría',_binary '�PNG\r\n\Z\n\0\0\0\rIHDR\0\0\0\0\0\0\0\0\0�\0\0\0IDATx\�c��\0\0\�_W\0\0\0\0IEND�B`�','Guatemala',16.0000,32.0000,0.00,1,1000,0.50,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(13,'FAC-QA-P03','?????','Salchicha 1 lb',18,6,6,6,'Producto ficticio de auditoría',_binary '�PNG\r\n\Z\n\0\0\0\rIHDR\0\0\0\0\0\0\0\0\0�\0\0\0IDATx\�c��\0\0\�_W\0\0\0\0IEND�B`�','Guatemala',17.0000,34.0000,0.00,1,1000,0.50,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(14,'FAC-QA-P04','?????','Chorizo tradicional 1 lb',18,6,6,6,'Producto ficticio de auditoría',_binary '�PNG\r\n\Z\n\0\0\0\rIHDR\0\0\0\0\0\0\0\0\0�\0\0\0IDATx\�c��\0\0\�_W\0\0\0\0IEND�B`�','Guatemala',18.0000,36.0000,0.00,1,1000,0.50,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(15,'FAC-QA-P05','?????','Longaniza 1 lb',18,6,6,6,'Producto ficticio de auditoría',_binary '�PNG\r\n\Z\n\0\0\0\rIHDR\0\0\0\0\0\0\0\0\0�\0\0\0IDATx\�c��\0\0\�_W\0\0\0\0IEND�B`�','Guatemala',19.0000,38.0000,0.00,1,1000,0.50,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(16,'FAC-QA-P06','?????','Tocino 250 g',18,6,6,6,'Producto ficticio de auditoría',_binary '�PNG\r\n\Z\n\0\0\0\rIHDR\0\0\0\0\0\0\0\0\0�\0\0\0IDATx\�c��\0\0\�_W\0\0\0\0IEND�B`�','Guatemala',20.0000,40.0000,0.00,1,1000,0.50,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(17,'FAC-QA-P07','?????','Mortadela 500 g',18,6,6,6,'Producto ficticio de auditoría',_binary '�PNG\r\n\Z\n\0\0\0\rIHDR\0\0\0\0\0\0\0\0\0�\0\0\0IDATx\�c��\0\0\�_W\0\0\0\0IEND�B`�','Guatemala',21.0000,42.0000,0.00,1,1000,0.50,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(18,'FAC-QA-P08','?????','Salami 250 g',18,6,6,6,'Producto ficticio de auditoría',_binary '�PNG\r\n\Z\n\0\0\0\rIHDR\0\0\0\0\0\0\0\0\0�\0\0\0IDATx\�c��\0\0\�_W\0\0\0\0IEND�B`�','Guatemala',22.0000,44.0000,0.00,1,1000,0.50,'2026-11-14 18:34:40','2026-11-14 18:34:40');
/*!40000 ALTER TABLE `tblproducto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblproductotransporte`
--

DROP TABLE IF EXISTS `tblproductotransporte`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblproductotransporte` (
  `idProductoTransporte` int NOT NULL AUTO_INCREMENT,
  `Fk_Servicio_Transporte_Externo_Codigo` int NOT NULL,
  `Fk_Producto_Codigo` int NOT NULL,
  `cantidadProductoTransporte` decimal(12,4) NOT NULL,
  `unidadMedidaProductoTransporte` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idProductoTransporte`),
  KEY `Fk_Producto_Transporte_Servicio_Transporte_Externo` (`Fk_Servicio_Transporte_Externo_Codigo`),
  KEY `Fk_Producto_Transporte_Producto` (`Fk_Producto_Codigo`),
  CONSTRAINT `Fk_Producto_Transporte_Producto` FOREIGN KEY (`Fk_Producto_Codigo`) REFERENCES `tblproducto` (`idProducto`) ON DELETE RESTRICT,
  CONSTRAINT `Fk_Producto_Transporte_Servicio_Transporte_Externo` FOREIGN KEY (`Fk_Servicio_Transporte_Externo_Codigo`) REFERENCES `tblserviciotransporteexterno` (`idServicioTransporteExterno`) ON DELETE RESTRICT,
  CONSTRAINT `ckProductoCantidad` CHECK ((`cantidadProductoTransporte` > 0))
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblproductotransporte`
--

LOCK TABLES `tblproductotransporte` WRITE;
/*!40000 ALTER TABLE `tblproductotransporte` DISABLE KEYS */;
INSERT INTO `tblproductotransporte` VALUES (1,1,1,25.0000,'paquetes','2026-11-14 18:34:39','2026-11-14 18:34:39'),(2,2,2,18.0000,'paquetes','2026-11-14 18:34:39','2026-11-14 18:34:39'),(3,3,3,12.0000,'paquetes','2026-11-14 18:34:39','2026-11-14 18:34:39'),(4,4,4,30.0000,'kilogramos','2026-11-14 18:34:39','2026-11-14 18:34:39'),(5,5,5,15.0000,'paquetes','2026-11-14 18:34:39','2026-11-14 18:34:39');
/*!40000 ALTER TABLE `tblproductotransporte` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblproductoventa`
--

DROP TABLE IF EXISTS `tblproductoventa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblproductoventa` (
  `idProductoVenta` int NOT NULL,
  `tipoItemProductoVenta` char(1) COLLATE utf8mb4_unicode_ci NOT NULL,
  `unidadMedidaProductoVenta` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tasaImpuestoProductoVenta` decimal(3,2) NOT NULL DEFAULT '0.00',
  `activoProductoVenta` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idProductoVenta`),
  CONSTRAINT `Fk_ProductoVenta_Producto` FOREIGN KEY (`idProductoVenta`) REFERENCES `tblproducto` (`idProducto`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `ckProductoVentaactivoProductoVentaBooleano` CHECK ((`activoProductoVenta` in (0,1))),
  CONSTRAINT `ckProductoVentatasaImpuestoProductoVentaRango` CHECK ((`tasaImpuestoProductoVenta` between 0 and 0.99)),
  CONSTRAINT `ckProductoVentaTipoItemValido` CHECK ((`tipoItemProductoVenta` in (_utf8mb4'B',_utf8mb4'S')))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblproductoventa`
--

LOCK TABLES `tblproductoventa` WRITE;
/*!40000 ALTER TABLE `tblproductoventa` DISABLE KEYS */;
INSERT INTO `tblproductoventa` VALUES (11,'B','Paquete',0.12,1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(12,'B','Paquete',0.12,1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(13,'B','Paquete',0.12,1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(14,'B','Paquete',0.12,1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(15,'B','Paquete',0.12,1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(16,'B','Paquete',0.12,1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(17,'B','Paquete',0.12,1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(18,'B','Paquete',0.12,1,'2026-11-14 18:34:40','2026-11-14 18:34:40');
/*!40000 ALTER TABLE `tblproductoventa` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblproveedor`
--

DROP TABLE IF EXISTS `tblproveedor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblproveedor` (
  `idProveedor` int NOT NULL AUTO_INCREMENT,
  `nombreProveedor` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nitProveedor` char(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `correoProveedor` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `telefonoProveedor` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `direccionProveedor` varchar(500) COLLATE utf8mb4_unicode_ci NOT NULL,
  `estadoProveedor` tinyint(1) NOT NULL DEFAULT '1',
  `idPlazo` int DEFAULT NULL,
  `saldoActualProveedor` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `saldoAnteriorProveedor` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `cargosMesProveedor` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `abonosMesProveedor` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `cargosAsignadosProveedor` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `cargosAcumuladosProveedor` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `abonosAcumuladosProveedor` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idProveedor`),
  UNIQUE KEY `uqProveedorNit` (`nitProveedor`),
  KEY `idxProveedorPlazo` (`idPlazo`),
  CONSTRAINT `Fk_Proveedor_Plazo` FOREIGN KEY (`idPlazo`) REFERENCES `tblplazo` (`idPlazo`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `ckMovimientosProveedor` CHECK (((`cargosMesProveedor` >= 0) and (`abonosMesProveedor` >= 0) and (`cargosAsignadosProveedor` >= 0) and (`cargosAcumuladosProveedor` >= 0) and (`abonosAcumuladosProveedor` >= 0)))
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblproveedor`
--

LOCK TABLES `tblproveedor` WRITE;
/*!40000 ALTER TABLE `tblproveedor` DISABLE KEYS */;
INSERT INTO `tblproveedor` VALUES (1,'Distribuidora de Carnes La Esperanza, S.A.','4521879-3','ventas@carnesesperanza.com.gt','22345678','Zona 12, Ciudad de Guatemala',1,NULL,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(2,'Empaques y Etiquetas de Guatemala, S.A.','6098123-5','pedidos@empaquesgt.com.gt','23456789','Zona 4 de Mixco, Guatemala',1,NULL,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(3,'Distribuidora del Norte','1234567890','ventas@distribuidoranorte.com','5551-1001','Zona 1, Ciudad de Guatemala',1,NULL,15000.0000,12000.0000,5000.0000,2000.0000,3000.0000,25000.0000,10000.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(4,'Comercializadora Central','1234567891','contacto@comercialcentral.com','5551-1002','Zona 4, Ciudad de Guatemala',1,NULL,8500.0000,7000.0000,3000.0000,1500.0000,1500.0000,18000.0000,9500.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(5,'Materias Primas del Sur','1234567892','ventas@materiasprimas.com','5551-1003','Escuintla, Guatemala',1,NULL,22000.0000,18000.0000,7000.0000,3000.0000,4000.0000,35000.0000,13000.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(6,'Empaques Industriales','1234567893','info@empaquesindustriales.com','5551-1004','Zona 12, Ciudad de Guatemala',1,NULL,6500.0000,5000.0000,2500.0000,1000.0000,1500.0000,12000.0000,5500.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(7,'Transportes Express','1234567894','servicios@transportesexpress.com','5551-1005','Villa Nueva, Guatemala',1,NULL,4500.0000,4000.0000,1800.0000,1300.0000,500.0000,9000.0000,4500.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(8,'Tecnología Empresarial','1234567895','ventas@tecnologiaempresarial.com','5551-1006','Zona 10, Ciudad de Guatemala',1,NULL,12000.0000,10000.0000,4000.0000,2000.0000,2000.0000,20000.0000,8000.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(9,'Suministros Industriales','1234567896','contacto@suministrosindustriales.com','5551-1007','Mixco, Guatemala',1,NULL,7800.0000,6000.0000,2800.0000,1000.0000,1800.0000,15000.0000,7200.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(10,'Repuestos y Servicios','1234567897','ventas@repuestosyservicios.com','5551-1008','Zona 7, Ciudad de Guatemala',1,NULL,3200.0000,2500.0000,1200.0000,500.0000,700.0000,8000.0000,4800.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(11,'Productos Alimenticios','1234567898','pedidos@productosalimenticios.com','5551-1009','Chimaltenango, Guatemala',1,NULL,18500.0000,15000.0000,6000.0000,2500.0000,3500.0000,28000.0000,9500.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(12,'Servicios Generales GT','1234567899','info@serviciosgeneralesgt.com','5551-1010','Zona 3, Ciudad de Guatemala',0,NULL,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,'2026-11-14 18:34:38','2026-11-14 18:34:38'),(13,'Proveedor prueba 1 0d2d5068e05a','0d2d5068e1','proveedor1@example.com','55550001','Guatemala',1,11,100.0000,0.0000,100.0000,0.0000,0.0000,100.0000,0.0000,'2026-11-14 18:34:39','2026-11-14 18:34:39'),(14,'Proveedor prueba 2 0d2d5068e05a','0d2d5068e2','proveedor2@example.com','55550002','Guatemala',1,12,100.0000,0.0000,100.0000,0.0000,0.0000,100.0000,0.0000,'2026-11-14 18:34:39','2026-11-14 18:34:39'),(15,'Proveedor prueba 3 0d2d5068e05a','0d2d5068e3','proveedor3@example.com','55550003','Guatemala',1,13,100.0000,0.0000,100.0000,0.0000,0.0000,100.0000,0.0000,'2026-11-14 18:34:39','2026-11-14 18:34:39'),(16,'Proveedor prueba 4 0d2d5068e05a','0d2d5068e4','proveedor4@example.com','55550004','Guatemala',1,14,100.0000,0.0000,100.0000,0.0000,0.0000,100.0000,0.0000,'2026-11-14 18:34:39','2026-11-14 18:34:39'),(17,'Proveedor prueba 5 0d2d5068e05a','0d2d5068e5','proveedor5@example.com','55550005','Guatemala',1,15,100.0000,0.0000,100.0000,0.0000,0.0000,100.0000,0.0000,'2026-11-14 18:34:39','2026-11-14 18:34:39'),(18,'FAC-QA Proveedor','99100499-1','facturas@example.invalid','00000000','Ciudad',1,NULL,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,'2026-11-14 18:34:40','2026-11-14 18:34:40');
/*!40000 ALTER TABLE `tblproveedor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblpuesto`
--

DROP TABLE IF EXISTS `tblpuesto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblpuesto` (
  `idPuesto` int NOT NULL AUTO_INCREMENT,
  `idTipoPuesto` int NOT NULL,
  `nombrePuesto` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcionPuesto` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idPuesto`),
  UNIQUE KEY `uqNombrePuesto` (`nombrePuesto`),
  KEY `Fk_Puesto_TipoPuesto` (`idTipoPuesto`),
  CONSTRAINT `Fk_Puesto_TipoPuesto` FOREIGN KEY (`idTipoPuesto`) REFERENCES `tbltipopuesto` (`idTipoPuesto`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblpuesto`
--

LOCK TABLES `tblpuesto` WRITE;
/*!40000 ALTER TABLE `tblpuesto` DISABLE KEYS */;
INSERT INTO `tblpuesto` VALUES (1,1,'Coordinadora de Implementación','Coordina la implementación del sistema',1,'2026-11-14 18:33:55','2026-11-14 18:33:55'),(2,1,'Analista de Sistemas','Análisis de sistemas',1,'2026-11-14 18:33:55','2026-11-14 18:33:55'),(3,1,'Administradora de Base de Datos','Administración de BD',1,'2026-11-14 18:33:55','2026-11-14 18:33:55'),(4,1,'Gerente','Gerencia general',1,'2026-11-14 18:33:55','2026-11-14 18:33:55'),(5,1,'Pruebas','Puesto de pruebas',1,'2026-11-14 18:33:55','2026-11-14 18:33:55'),(6,1,'Probador','Puesto de capacitación y pruebas',1,'2026-11-14 18:33:55','2026-11-14 18:33:55'),(7,1,'Analista de Recursos Humanos','Gestión de personal, asistencia y nómina',1,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(8,1,'Contador General','Control contable y financiero de la empresa',1,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(9,2,'Operario de Producción','Elaboración y empaque de embutidos',1,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(10,5,'Vendedor de Campo','Atención y visita de clientes y rutas de venta',1,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(11,6,'Supervisora de Logística','Supervisa bodega, despacho y distribución',1,'2026-11-14 18:34:37','2026-11-14 18:34:37');
/*!40000 ALTER TABLE `tblpuesto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblpuestoempleado`
--

DROP TABLE IF EXISTS `tblpuestoempleado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblpuestoempleado` (
  `idPuestoEmpleado` int NOT NULL AUTO_INCREMENT,
  `idEmpleado` int NOT NULL,
  `idPuesto` int NOT NULL,
  `fechaAsignacionPuestoEmpleado` date NOT NULL,
  `fechaFinPuestoEmpleado` date DEFAULT NULL,
  `vigentePuestoEmpleado` int GENERATED ALWAYS AS (if(((`fechaFinPuestoEmpleado` is null) and (`is_active` = 1)),`idEmpleado`,NULL)) STORED,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idPuestoEmpleado`),
  UNIQUE KEY `uqPuestoEmpleadoVigente` (`vigentePuestoEmpleado`),
  KEY `Fk_PuestoEmpleado_Puesto` (`idPuesto`),
  KEY `idxPuestoEmpleadoEmpleadoFecha` (`idEmpleado`,`fechaAsignacionPuestoEmpleado`),
  CONSTRAINT `Fk_PuestoEmpleado_Empleado` FOREIGN KEY (`idEmpleado`) REFERENCES `tblempleado` (`idEmpleado`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `Fk_PuestoEmpleado_Puesto` FOREIGN KEY (`idPuesto`) REFERENCES `tblpuesto` (`idPuesto`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `ckPuestoEmpleadoFechas` CHECK (((`fechaFinPuestoEmpleado` is null) or (`fechaFinPuestoEmpleado` >= `fechaAsignacionPuestoEmpleado`)))
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblpuestoempleado`
--

LOCK TABLES `tblpuestoempleado` WRITE;
/*!40000 ALTER TABLE `tblpuestoempleado` DISABLE KEYS */;
INSERT INTO `tblpuestoempleado` (`idPuestoEmpleado`, `idEmpleado`, `idPuesto`, `fechaAsignacionPuestoEmpleado`, `fechaFinPuestoEmpleado`, `is_active`, `created_at`, `updated_at`) VALUES (1,1,1,'2026-01-10',NULL,1,'2026-11-14 18:33:55','2026-11-14 18:33:55'),(2,2,2,'2025-11-05',NULL,1,'2026-11-14 18:33:55','2026-11-14 18:33:55'),(3,3,3,'2025-08-19',NULL,1,'2026-11-14 18:33:55','2026-11-14 18:33:55'),(4,13,4,'2026-09-21',NULL,1,'2026-11-14 18:33:55','2026-11-14 18:33:55'),(5,14,5,'2026-09-22',NULL,1,'2026-11-14 18:33:55','2026-11-14 18:33:55'),(6,19,6,'2026-01-10',NULL,1,'2026-11-14 18:33:55','2026-11-14 18:33:55'),(8,20,7,'2024-03-01',NULL,1,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(9,21,8,'2023-07-17',NULL,1,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(10,22,9,'2025-02-03',NULL,1,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(11,23,10,'2022-11-14',NULL,1,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(12,24,11,'2025-06-02',NULL,1,'2026-11-14 18:34:37','2026-11-14 18:34:37');
/*!40000 ALTER TABLE `tblpuestoempleado` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblrangoantiguedad`
--

DROP TABLE IF EXISTS `tblrangoantiguedad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblrangoantiguedad` (
  `idRangoAntiguedad` int NOT NULL AUTO_INCREMENT,
  `nombreRangoAntiguedad` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `diasDesdeRangoAntiguedad` int DEFAULT NULL,
  `diasHastaRangoAntiguedad` int DEFAULT NULL,
  `ordenRangoAntiguedad` tinyint NOT NULL,
  `activoRangoAntiguedad` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idRangoAntiguedad`),
  UNIQUE KEY `uqNombreRangoAntiguedad` (`nombreRangoAntiguedad`),
  UNIQUE KEY `uqOrdenRangoAntiguedad` (`ordenRangoAntiguedad`),
  CONSTRAINT `ckLimitesRangoAntiguedad` CHECK (((`diasDesdeRangoAntiguedad` is null) or (`diasHastaRangoAntiguedad` is null) or (`diasHastaRangoAntiguedad` >= `diasDesdeRangoAntiguedad`)))
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblrangoantiguedad`
--

LOCK TABLES `tblrangoantiguedad` WRITE;
/*!40000 ALTER TABLE `tblrangoantiguedad` DISABLE KEYS */;
INSERT INTO `tblrangoantiguedad` VALUES (1,'Por vencer',NULL,0,1,1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(2,'1 a 30 días',1,30,2,1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(3,'31 a 60 días',31,60,3,1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(4,'61 a 90 días',61,90,4,1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(5,'Más de 90 días',91,NULL,5,1,'2026-11-14 18:34:40','2026-11-14 18:34:40');
/*!40000 ALTER TABLE `tblrangoantiguedad` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblrecibopago`
--

DROP TABLE IF EXISTS `tblrecibopago`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblrecibopago` (
  `idReciboPago` int NOT NULL AUTO_INCREMENT,
  `numeroReciboPago` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `idCliente` int NOT NULL,
  `idMoneda` bigint NOT NULL,
  `fechaReciboPago` date NOT NULL,
  `montoReciboPago` decimal(12,4) NOT NULL,
  `referenciaReciboPago` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `estadoReciboPago` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `observacionesReciboPago` text COLLATE utf8mb4_unicode_ci,
  `idUsuarioRegistro` int NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `idFormaPagoVenta` int NOT NULL,
  PRIMARY KEY (`idReciboPago`),
  UNIQUE KEY `uqReciboPagonumero` (`numeroReciboPago`),
  KEY `idxReciboPagoClienteCodigofecha` (`idCliente`,`fechaReciboPago`),
  KEY `idxReciboPagoMonedaCodigo` (`idMoneda`),
  KEY `idxReciboPagoUsuarioRegistro` (`idUsuarioRegistro`),
  KEY `idxReciboPagoFormaPagoVentaCodigo` (`idFormaPagoVenta`),
  CONSTRAINT `Fk_ReciboPago_Cliente` FOREIGN KEY (`idCliente`) REFERENCES `tblcliente` (`idCliente`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `Fk_ReciboPago_FormaPagoVenta` FOREIGN KEY (`idFormaPagoVenta`) REFERENCES `tblformapagoventa` (`idFormaPagoVenta`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `Fk_ReciboPago_Moneda` FOREIGN KEY (`idMoneda`) REFERENCES `tblmoneda` (`idMoneda`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `Fk_ReciboPago_Usuario_Registro` FOREIGN KEY (`idUsuarioRegistro`) REFERENCES `tblusuario` (`idUsuario`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `ckReciboPagoMontoPositivo` CHECK ((`montoReciboPago` > 0)),
  CONSTRAINT `ckReciboPagoValoresEstadoPago` CHECK ((`estadoReciboPago` in (_utf8mb4'BORRADOR',_utf8mb4'CONFIRMADO',_utf8mb4'ANULADO')))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblrecibopago`
--

LOCK TABLES `tblrecibopago` WRITE;
/*!40000 ALTER TABLE `tblrecibopago` DISABLE KEYS */;
/*!40000 ALTER TABLE `tblrecibopago` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblrecuperacioncontrasena`
--

DROP TABLE IF EXISTS `tblrecuperacioncontrasena`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblrecuperacioncontrasena` (
  `idRecuperacionContrasena` int NOT NULL AUTO_INCREMENT,
  `idUsuario` int NOT NULL,
  `tokenRecuperacionContrasena` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `fechaExpiracionRecuperacionContrasena` datetime NOT NULL,
  `usadoRecuperacionContrasena` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idRecuperacionContrasena`),
  UNIQUE KEY `uqTokenRecuperacionContrasena` (`tokenRecuperacionContrasena`),
  KEY `idxRecuperacionContrasenaIdUsuario` (`idUsuario`),
  CONSTRAINT `Fk_RecuperacionContrasena_Usuario` FOREIGN KEY (`idUsuario`) REFERENCES `tblusuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblrecuperacioncontrasena`
--

LOCK TABLES `tblrecuperacioncontrasena` WRITE;
/*!40000 ALTER TABLE `tblrecuperacioncontrasena` DISABLE KEYS */;
INSERT INTO `tblrecuperacioncontrasena` VALUES (1,1,'TOKEN-A1B2C3D4','2026-09-18 08:07:07',0,'2026-09-17 20:07:07','2026-09-17 20:07:07'),(2,2,'TOKEN-E5F6G7H8','2026-09-18 08:07:07',0,'2026-09-17 20:07:07','2026-09-17 20:07:07'),(3,3,'TOKEN-I9J0K1L2','2026-09-18 08:07:07',1,'2026-09-17 20:07:07','2026-09-17 20:07:07');
/*!40000 ALTER TABLE `tblrecuperacioncontrasena` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblreglacomision`
--

DROP TABLE IF EXISTS `tblreglacomision`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblreglacomision` (
  `idReglaComision` int NOT NULL AUTO_INCREMENT,
  `codigoReglaComision` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nombreReglaComision` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `baseCalculoReglaComision` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tasaComisionReglaComision` decimal(3,2) NOT NULL,
  `vigenteDesdeReglaComision` date NOT NULL,
  `vigenteHastaReglaComision` date DEFAULT NULL,
  `requiereAutorizacionReglaComision` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idReglaComision`),
  UNIQUE KEY `uqReglaComisioncodigo` (`codigoReglaComision`),
  CONSTRAINT `ckReglaComisionFechasCoherentes` CHECK ((`vigenteHastaReglaComision` >= `vigenteDesdeReglaComision`)),
  CONSTRAINT `ckReglaComisionrequiereAutorizacionReglaComisionBooleano` CHECK ((`requiereAutorizacionReglaComision` in (0,1))),
  CONSTRAINT `ckReglaComisiontasaComisionReglaComisionRango` CHECK ((`tasaComisionReglaComision` between 0 and 0.99)),
  CONSTRAINT `ckReglaComisionValoresBaseCalculo` CHECK ((`baseCalculoReglaComision` in (_utf8mb4'VENTA_NETA',_utf8mb4'COBRO_NETO')))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblreglacomision`
--

LOCK TABLES `tblreglacomision` WRITE;
/*!40000 ALTER TABLE `tblreglacomision` DISABLE KEYS */;
/*!40000 ALTER TABLE `tblreglacomision` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblreporte`
--

DROP TABLE IF EXISTS `tblreporte`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblreporte` (
  `numeroReporte` int NOT NULL,
  `nombreReporte` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `rutaReporte` varchar(500) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fechaReporte` date NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`numeroReporte`),
  UNIQUE KEY `uqNombreReporte` (`nombreReporte`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblreporte`
--

LOCK TABLES `tblreporte` WRITE;
/*!40000 ALTER TABLE `tblreporte` DISABLE KEYS */;
/*!40000 ALTER TABLE `tblreporte` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblrol`
--

DROP TABLE IF EXISTS `tblrol`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblrol` (
  `idRol` int NOT NULL AUTO_INCREMENT,
  `nombreRol` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcionRol` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idRol`),
  UNIQUE KEY `uqNombreRol` (`nombreRol`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblrol`
--

LOCK TABLES `tblrol` WRITE;
/*!40000 ALTER TABLE `tblrol` DISABLE KEYS */;
INSERT INTO `tblrol` VALUES (1,'Administrador','Rol con acceso total al sistema',1,'2026-09-17 20:07:07','2026-09-17 20:07:07'),(2,'Supervisor','Rol con acceso a reportes y aprobaciones',1,'2026-09-17 20:07:07','2026-09-17 20:07:07'),(11,'Pruebas','pruebas del sistema',0,'2026-09-19 03:45:38','2026-09-19 03:45:38'),(12,'PerfilExamen','Permisos personalizados para el examen',1,'2026-09-22 19:16:29','2026-09-22 19:16:29'),(14,'Prueba','Esta es una prueba controlada por parte de Seguridad',1,'2026-09-24 05:47:34','2026-09-24 05:47:34'),(15,'Recursos Humanos','Rol con acceso a recursos humanos',1,'2026-09-17 20:07:07','2026-09-17 20:07:07'),(16,'Bancos','Rol con acceso a bancos',1,'2026-09-17 20:07:07','2026-09-17 20:07:07'),(17,'Ventas','Rol con acceso a ventas',1,'2026-09-17 20:07:07','2026-09-17 20:07:07'),(18,'compras','Rol con acceso compras',1,'2026-09-17 20:07:07','2026-09-17 20:07:07'),(19,'Contabilidad','Rol con acceso a contabilidad',1,'2026-09-17 20:07:07','2026-09-17 20:07:07'),(20,'Logistica','Rol con acceso a logistica',1,'2026-09-17 20:07:07','2026-09-17 20:07:07');
/*!40000 ALTER TABLE `tblrol` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblrolmoduloaplicacion`
--

DROP TABLE IF EXISTS `tblrolmoduloaplicacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblrolmoduloaplicacion` (
  `idRol` int NOT NULL,
  `idModulo` int NOT NULL,
  `idAplicacion` int NOT NULL,
  `derInsertarRolModuloAplicacion` tinyint(1) NOT NULL DEFAULT '0',
  `derEditarRolModuloAplicacion` tinyint(1) NOT NULL DEFAULT '0',
  `derEliminarRolModuloAplicacion` tinyint(1) NOT NULL DEFAULT '0',
  `derImprimirRolModuloAplicacion` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idRol`,`idModulo`,`idAplicacion`),
  KEY `idxRolModAplIdModulo` (`idModulo`),
  KEY `idxRolModAplIdAplicacion` (`idAplicacion`),
  CONSTRAINT `Fk_RolModuloAplicacion_Aplicacion` FOREIGN KEY (`idAplicacion`) REFERENCES `tblaplicacion` (`idAplicacion`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Fk_RolModuloAplicacion_Modulo` FOREIGN KEY (`idModulo`) REFERENCES `tblmodulo` (`idModulo`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Fk_RolModuloAplicacion_Rol` FOREIGN KEY (`idRol`) REFERENCES `tblrol` (`idRol`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblrolmoduloaplicacion`
--

LOCK TABLES `tblrolmoduloaplicacion` WRITE;
/*!40000 ALTER TABLE `tblrolmoduloaplicacion` DISABLE KEYS */;
INSERT INTO `tblrolmoduloaplicacion` VALUES (1,4,4,1,1,1,1,'2026-09-17 20:07:07','2026-09-17 20:19:43'),(1,4,5,1,1,1,1,'2026-09-17 20:07:07','2026-09-17 20:07:07'),(1,4,6,1,1,1,1,'2026-09-17 20:07:07','2026-09-17 20:07:07'),(1,4,7,1,1,1,1,'2026-09-17 20:07:07','2026-09-17 20:07:07'),(1,4,8,1,1,1,1,'2026-09-17 20:07:07','2026-09-17 20:07:07'),(1,4,9,1,1,1,1,'2026-09-17 20:07:07','2026-09-17 20:07:07'),(1,4,10,1,1,1,1,'2026-09-17 20:07:07','2026-09-17 20:07:07'),(1,4,11,1,1,1,1,'2026-09-17 20:07:07','2026-09-17 20:07:07'),(1,4,12,1,1,1,1,'2026-09-17 20:07:07','2026-09-17 20:07:07'),(1,5000,5001,1,1,1,1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(1,5000,5002,1,1,1,1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(1,5000,5003,1,1,1,1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(1,5000,5004,1,1,1,1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(1,5000,5005,1,1,1,1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(1,5000,5007,1,1,1,1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(1,5000,5008,1,1,1,1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(1,5000,5013,1,1,1,1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(1,5000,5015,1,1,1,1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(1,5000,5016,1,1,1,1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(1,5000,5028,1,1,1,1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(1,6000,6000,1,1,1,1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(1,6000,6001,1,1,1,1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(1,6000,6002,1,1,1,1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(1,6000,6003,1,1,1,1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(1,6000,6004,1,1,1,1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(1,6000,6005,1,1,1,1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(1,6000,6006,1,1,1,1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(1,6000,6007,1,1,1,1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(1,6000,6008,1,1,1,1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(1,6000,6009,1,1,1,1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(1,6000,6010,1,1,1,1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(1,6000,6011,1,1,1,1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(1,6000,6012,1,1,1,1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(1,6000,6013,1,1,1,1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(1,6000,6014,1,1,1,1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(1,7000,3,1,1,1,1,'2026-11-14 18:34:41','2026-11-14 18:34:41'),(1,7000,7000,1,1,1,1,'2026-11-14 18:34:41','2026-11-14 18:34:41'),(1,7000,7002,1,1,1,1,'2026-11-14 18:34:41','2026-11-14 18:34:41'),(1,7000,7003,1,1,1,1,'2026-11-14 18:34:41','2026-11-14 18:34:41'),(1,7000,7004,1,1,1,1,'2026-11-14 18:34:41','2026-11-14 18:34:41'),(1,7000,7005,1,1,1,1,'2026-11-14 18:34:41','2026-11-14 18:34:41'),(1,7000,7007,1,1,1,1,'2026-11-14 18:34:41','2026-11-14 18:34:41'),(1,7000,7009,1,1,1,1,'2026-11-14 18:34:41','2026-11-14 18:34:41'),(1,7000,7010,1,1,1,1,'2026-11-14 18:34:41','2026-11-14 18:34:41'),(1,7000,7011,1,1,1,1,'2026-11-14 18:34:41','2026-11-14 18:34:41'),(1,7000,7013,1,1,1,1,'2026-11-14 18:34:41','2026-11-14 18:34:41'),(1,7000,7014,1,1,1,1,'2026-11-14 18:34:41','2026-11-14 18:34:41'),(1,7000,7015,1,1,1,1,'2026-11-14 18:34:41','2026-11-14 18:34:41'),(1,8000,8001,1,1,1,1,'2026-11-14 18:34:41','2026-11-14 18:34:41'),(1,8000,8002,1,1,1,1,'2026-11-14 18:34:41','2026-11-14 18:34:41'),(1,8000,8003,1,1,1,1,'2026-11-14 18:34:41','2026-11-14 18:34:41'),(1,8000,8004,1,1,1,1,'2026-11-14 18:34:41','2026-11-14 18:34:41'),(1,8000,8005,1,1,1,1,'2026-11-14 18:34:41','2026-11-14 18:34:41'),(1,8000,8006,1,1,1,1,'2026-11-14 18:34:41','2026-11-14 18:34:41'),(1,8000,8007,1,1,1,1,'2026-11-14 18:34:41','2026-11-14 18:34:41'),(1,8000,8008,1,1,1,1,'2026-11-14 18:34:41','2026-11-14 18:34:41'),(1,8000,8009,1,1,1,1,'2026-11-14 18:34:41','2026-11-14 18:34:41'),(1,8000,8010,1,1,1,1,'2026-11-14 18:34:41','2026-11-14 18:34:41'),(1,8000,8011,1,1,1,1,'2026-11-14 18:34:41','2026-11-14 18:34:41'),(1,8000,8012,1,1,1,1,'2026-11-14 18:34:41','2026-11-14 18:34:41'),(1,8000,8013,1,1,1,1,'2026-11-14 18:34:41','2026-11-14 18:34:41'),(1,9000,9001,1,1,1,1,'2026-11-14 18:34:41','2026-11-14 18:34:41'),(1,9000,9002,1,1,1,1,'2026-11-14 18:34:41','2026-11-14 18:34:41'),(1,9000,9003,1,1,1,1,'2026-11-14 18:34:41','2026-11-14 18:34:41'),(1,9000,9004,1,1,1,1,'2026-11-14 18:34:41','2026-11-14 18:34:41'),(1,9000,9005,1,1,1,1,'2026-11-14 18:34:41','2026-11-14 18:34:41'),(1,9000,9006,1,1,1,1,'2026-11-14 18:34:41','2026-11-14 18:34:41'),(1,9000,9101,1,1,1,1,'2026-11-14 18:34:41','2026-11-14 18:34:41'),(1,9000,9102,1,1,1,1,'2026-11-14 18:34:41','2026-11-14 18:34:41'),(1,9000,9150,1,1,1,1,'2026-11-24 05:26:42','2026-11-24 05:26:42'),(1,9000,9201,1,1,1,1,'2026-11-14 18:34:41','2026-11-14 18:34:41'),(1,9000,9202,1,1,1,1,'2026-11-14 18:34:41','2026-11-14 18:34:41'),(1,9000,9203,1,1,1,1,'2026-11-14 18:34:41','2026-11-14 18:34:41'),(1,9000,9301,1,1,1,1,'2026-11-14 18:34:41','2026-11-14 18:34:41'),(1,9000,9302,1,1,1,1,'2026-11-14 18:34:41','2026-11-14 18:34:41'),(1,9000,9303,1,1,1,1,'2026-11-14 18:34:41','2026-11-14 18:34:41'),(1,9000,9304,1,1,1,1,'2026-11-14 18:34:41','2026-11-14 18:34:41'),(1,9000,9305,1,1,1,1,'2026-11-14 18:34:41','2026-11-14 18:34:41'),(1,9000,9401,1,1,1,1,'2026-11-14 18:34:41','2026-11-14 18:34:41'),(1,9000,9402,1,1,1,1,'2026-11-14 18:34:41','2026-11-14 18:34:41'),(1,9000,9403,1,1,1,1,'2026-11-14 18:34:41','2026-11-14 18:34:41'),(1,9000,9404,1,1,1,1,'2026-11-14 18:34:41','2026-11-14 18:34:41'),(1,9000,9501,1,1,1,1,'2026-11-14 18:34:41','2026-11-14 18:34:41'),(1,9000,9601,1,1,1,1,'2026-11-14 18:34:41','2026-11-14 18:34:41'),(1,9000,9701,1,1,1,1,'2026-11-14 18:34:41','2026-11-14 18:34:41'),(1,9000,9702,1,1,1,1,'2026-11-14 18:34:41','2026-11-14 18:34:41'),(1,9000,9703,1,1,1,1,'2026-11-14 18:34:41','2026-11-14 18:34:41'),(1,9000,9704,1,1,1,1,'2026-11-14 18:34:41','2026-11-14 18:34:41'),(1,10000,10000,1,1,1,1,'2026-11-14 18:34:41','2026-11-14 18:34:41'),(1,10000,10001,1,1,1,1,'2026-11-14 18:34:41','2026-11-14 18:34:41'),(1,10000,10002,1,1,1,1,'2026-11-14 18:34:41','2026-11-14 18:34:41'),(1,10000,10003,1,1,1,1,'2026-11-14 18:34:41','2026-11-14 18:34:41'),(1,10000,10004,1,1,1,1,'2026-11-14 18:34:41','2026-11-14 18:34:41'),(1,10000,10005,1,1,1,1,'2026-11-14 18:34:41','2026-11-14 18:34:41'),(1,10000,10006,1,1,1,1,'2026-11-14 18:34:41','2026-11-14 18:34:41'),(1,10000,10011,1,1,1,1,'2026-11-14 18:34:41','2026-11-14 18:34:41'),(1,10000,10012,1,1,1,1,'2026-11-14 18:34:41','2026-11-14 18:34:41'),(1,10000,10013,1,1,1,1,'2026-11-14 18:34:41','2026-11-14 18:34:41'),(1,10000,10014,1,1,1,1,'2026-11-14 18:34:41','2026-11-14 18:34:41'),(1,10000,10015,1,1,1,1,'2026-11-14 18:34:41','2026-11-14 18:34:41'),(2,4,4,1,1,0,0,'2026-09-17 20:07:07','2026-09-17 20:07:07'),(12,4,8,1,1,0,0,'2026-09-22 19:20:38','2026-09-22 19:20:38'),(14,4,15,1,1,1,1,'2026-09-24 05:48:40','2026-09-24 05:48:40'),(15,9000,9001,1,1,1,1,'2026-11-14 18:34:41','2026-11-14 18:34:41'),(15,9000,9002,1,1,1,1,'2026-11-14 18:34:41','2026-11-14 18:34:41'),(15,9000,9003,1,1,1,1,'2026-11-14 18:34:41','2026-11-14 18:34:41'),(15,9000,9004,1,1,1,1,'2026-11-14 18:34:41','2026-11-14 18:34:41'),(15,9000,9005,1,1,1,1,'2026-11-14 18:34:41','2026-11-14 18:34:41'),(15,9000,9006,1,1,1,1,'2026-11-14 18:34:41','2026-11-14 18:34:41'),(15,9000,9101,1,1,1,1,'2026-11-14 18:34:41','2026-11-14 18:34:41'),(15,9000,9102,1,1,1,1,'2026-11-14 18:34:41','2026-11-14 18:34:41'),(15,9000,9201,1,1,1,1,'2026-11-14 18:34:41','2026-11-14 18:34:41'),(15,9000,9202,1,1,1,1,'2026-11-14 18:34:41','2026-11-14 18:34:41'),(15,9000,9203,1,1,1,1,'2026-11-14 18:34:41','2026-11-14 18:34:41'),(15,9000,9301,1,1,1,1,'2026-11-14 18:34:41','2026-11-14 18:34:41'),(15,9000,9302,1,1,1,1,'2026-11-14 18:34:41','2026-11-14 18:34:41'),(15,9000,9303,1,1,1,1,'2026-11-14 18:34:41','2026-11-14 18:34:41'),(15,9000,9304,1,1,1,1,'2026-11-14 18:34:41','2026-11-14 18:34:41'),(15,9000,9305,1,1,1,1,'2026-11-14 18:34:41','2026-11-14 18:34:41'),(15,9000,9401,1,1,1,1,'2026-11-14 18:34:41','2026-11-14 18:34:41'),(15,9000,9402,1,1,1,1,'2026-11-14 18:34:41','2026-11-14 18:34:41'),(15,9000,9403,1,1,1,1,'2026-11-14 18:34:41','2026-11-14 18:34:41'),(15,9000,9404,1,1,1,1,'2026-11-14 18:34:41','2026-11-14 18:34:41'),(15,9000,9501,1,1,1,1,'2026-11-14 18:34:41','2026-11-14 18:34:41'),(15,9000,9601,1,1,1,1,'2026-11-14 18:34:41','2026-11-14 18:34:41'),(15,9000,9701,1,1,1,1,'2026-11-14 18:34:41','2026-11-14 18:34:41'),(15,9000,9702,1,1,1,1,'2026-11-14 18:34:41','2026-11-14 18:34:41'),(15,9000,9703,1,1,1,1,'2026-11-14 18:34:41','2026-11-14 18:34:41'),(15,9000,9704,1,1,1,1,'2026-11-14 18:34:41','2026-11-14 18:34:41'),(16,8000,8001,1,1,1,1,'2026-11-14 18:34:41','2026-11-14 18:34:41'),(16,8000,8002,1,1,1,1,'2026-11-14 18:34:41','2026-11-14 18:34:41'),(16,8000,8003,1,1,1,1,'2026-11-14 18:34:41','2026-11-14 18:34:41'),(16,8000,8004,1,1,1,1,'2026-11-14 18:34:41','2026-11-14 18:34:41'),(16,8000,8005,1,1,1,1,'2026-11-14 18:34:41','2026-11-14 18:34:41'),(16,8000,8006,1,1,1,1,'2026-11-14 18:34:41','2026-11-14 18:34:41'),(16,8000,8007,1,1,1,1,'2026-11-14 18:34:41','2026-11-14 18:34:41'),(16,8000,8008,1,1,1,1,'2026-11-14 18:34:41','2026-11-14 18:34:41'),(16,8000,8009,1,1,1,1,'2026-11-14 18:34:41','2026-11-14 18:34:41'),(16,8000,8010,1,1,1,1,'2026-11-14 18:34:41','2026-11-14 18:34:41'),(16,8000,8011,1,1,1,1,'2026-11-14 18:34:41','2026-11-14 18:34:41'),(16,8000,8012,1,1,1,1,'2026-11-14 18:34:41','2026-11-14 18:34:41'),(16,8000,8013,1,1,1,1,'2026-11-14 18:34:41','2026-11-14 18:34:41'),(17,7000,3,1,1,1,1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(17,7000,7000,1,1,1,1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(17,7000,7002,1,1,1,1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(17,7000,7003,1,1,1,1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(17,7000,7004,1,1,1,1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(17,7000,7005,1,1,1,1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(17,7000,7007,1,1,1,1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(17,7000,7009,1,1,1,1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(17,7000,7010,1,1,1,1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(17,7000,7011,1,1,1,1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(17,7000,7013,1,1,1,1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(17,7000,7014,1,1,1,1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(17,7000,7015,1,1,1,1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(19,10000,10000,1,1,1,1,'2026-11-14 18:34:41','2026-11-14 18:34:41'),(19,10000,10001,1,1,1,1,'2026-11-14 18:34:41','2026-11-14 18:34:41'),(19,10000,10002,1,1,1,1,'2026-11-14 18:34:41','2026-11-14 18:34:41'),(19,10000,10003,1,1,1,1,'2026-11-14 18:34:41','2026-11-14 18:34:41'),(19,10000,10004,1,1,1,1,'2026-11-14 18:34:41','2026-11-14 18:34:41'),(19,10000,10005,1,1,1,1,'2026-11-14 18:34:41','2026-11-14 18:34:41'),(19,10000,10006,1,1,1,1,'2026-11-14 18:34:41','2026-11-14 18:34:41'),(19,10000,10011,1,1,1,1,'2026-11-14 18:34:41','2026-11-14 18:34:41'),(19,10000,10012,1,1,1,1,'2026-11-14 18:34:41','2026-11-14 18:34:41'),(19,10000,10013,1,1,1,1,'2026-11-14 18:34:41','2026-11-14 18:34:41'),(19,10000,10014,1,1,1,1,'2026-11-14 18:34:41','2026-11-14 18:34:41'),(19,10000,10015,1,1,1,1,'2026-11-14 18:34:41','2026-11-14 18:34:41'),(20,9000,9150,1,1,1,1,'2026-11-24 05:20:35','2026-11-24 05:20:35');
/*!40000 ALTER TABLE `tblrolmoduloaplicacion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblsaldocuentaperiodo`
--

DROP TABLE IF EXISTS `tblsaldocuentaperiodo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblsaldocuentaperiodo` (
  `idSaldoCuentaPeriodo` int NOT NULL AUTO_INCREMENT,
  `idCuenta` int NOT NULL,
  `idActualizacionSaldos` int DEFAULT NULL,
  `periodoContableSaldoCuentaPeriodo` char(7) COLLATE utf8mb4_unicode_ci NOT NULL,
  `saldoInicialSaldoCuentaPeriodo` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `cargoSaldoCuentaPeriodo` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `abonoSaldoCuentaPeriodo` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `saldoFinalSaldoCuentaPeriodo` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `estadoSaldoCuentaPeriodo` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'ABIERTO',
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idSaldoCuentaPeriodo`),
  UNIQUE KEY `uqSaldoCuentaPeriodo` (`idCuenta`,`periodoContableSaldoCuentaPeriodo`),
  KEY `idxSaldoCuentaPeriodoPeriodo` (`periodoContableSaldoCuentaPeriodo`),
  KEY `idxSaldoCuentaPeriodoActualizacion` (`idActualizacionSaldos`),
  CONSTRAINT `Fk_SaldoCuentaPeriodo_Actualizacion` FOREIGN KEY (`idActualizacionSaldos`) REFERENCES `tblactualizacionsaldos` (`idActualizacionSaldos`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `Fk_SaldoCuentaPeriodo_Cuenta` FOREIGN KEY (`idCuenta`) REFERENCES `tblcuenta` (`idCuenta`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `ckSaldoEstado` CHECK ((`estadoSaldoCuentaPeriodo` in (_utf8mb4'ABIERTO',_utf8mb4'CERRADO'))),
  CONSTRAINT `ckSaldoMovimientos` CHECK (((`cargoSaldoCuentaPeriodo` >= 0) and (`abonoSaldoCuentaPeriodo` >= 0)))
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblsaldocuentaperiodo`
--

LOCK TABLES `tblsaldocuentaperiodo` WRITE;
/*!40000 ALTER TABLE `tblsaldocuentaperiodo` DISABLE KEYS */;
INSERT INTO `tblsaldocuentaperiodo` VALUES (1,16,1,'2026-10',0.0000,56000.0000,25000.0000,31000.0000,'ABIERTO',1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(2,134,1,'2026-10',0.0000,0.0000,30000.0000,30000.0000,'ABIERTO',1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(3,135,1,'2026-10',0.0000,0.0000,20000.0000,20000.0000,'ABIERTO',1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(4,91,1,'2026-10',0.0000,0.0000,6000.0000,6000.0000,'ABIERTO',1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(5,170,1,'2026-10',0.0000,18000.0000,0.0000,18000.0000,'ABIERTO',1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(6,171,1,'2026-10',0.0000,12000.0000,0.0000,12000.0000,'ABIERTO',1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(7,26,1,'2026-10',0.0000,0.0000,30000.0000,-30000.0000,'ABIERTO',1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(8,24,1,'2026-10',0.0000,40000.0000,0.0000,40000.0000,'ABIERTO',1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(9,29,1,'2026-10',0.0000,4800.0000,0.0000,4800.0000,'ABIERTO',1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(10,83,1,'2026-10',0.0000,44800.0000,44800.0000,0.0000,'ABIERTO',1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(11,8,1,'2026-10',0.0000,25000.0000,44800.0000,-19800.0000,'ABIERTO',1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(12,15,1,'2026-10',0.0000,56000.0000,25000.0000,31000.0000,'ABIERTO',1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(13,133,1,'2026-10',0.0000,0.0000,50000.0000,50000.0000,'ABIERTO',1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(14,89,1,'2026-10',0.0000,0.0000,6000.0000,6000.0000,'ABIERTO',1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(15,169,1,'2026-10',0.0000,30000.0000,0.0000,30000.0000,'ABIERTO',1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(16,23,1,'2026-10',0.0000,40000.0000,30000.0000,10000.0000,'ABIERTO',1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(17,28,1,'2026-10',0.0000,4800.0000,0.0000,4800.0000,'ABIERTO',1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(18,82,1,'2026-10',0.0000,44800.0000,44800.0000,0.0000,'ABIERTO',1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(19,7,1,'2026-10',0.0000,25000.0000,44800.0000,-19800.0000,'ABIERTO',1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(20,3,1,'2026-10',0.0000,125800.0000,99800.0000,26000.0000,'ABIERTO',1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(21,132,1,'2026-10',0.0000,0.0000,50000.0000,50000.0000,'ABIERTO',1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(22,81,1,'2026-10',0.0000,44800.0000,50800.0000,6000.0000,'ABIERTO',1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(23,168,1,'2026-10',0.0000,30000.0000,0.0000,30000.0000,'ABIERTO',1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(24,2,1,'2026-10',0.0000,125800.0000,99800.0000,26000.0000,'ABIERTO',1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(25,131,1,'2026-10',0.0000,0.0000,50000.0000,50000.0000,'ABIERTO',1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(26,80,1,'2026-10',0.0000,44800.0000,50800.0000,6000.0000,'ABIERTO',1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(27,160,1,'2026-10',0.0000,30000.0000,0.0000,30000.0000,'ABIERTO',1,'2026-11-14 18:34:36','2026-11-14 18:34:36');
/*!40000 ALTER TABLE `tblsaldocuentaperiodo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblsaldoproveedorperiodo`
--

DROP TABLE IF EXISTS `tblsaldoproveedorperiodo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblsaldoproveedorperiodo` (
  `idSaldoProveedorPeriodo` int NOT NULL AUTO_INCREMENT,
  `idPeriodoCompras` int NOT NULL,
  `idProveedor` int NOT NULL,
  `idMoneda` bigint NOT NULL,
  `saldoInicialSaldoProveedorPeriodo` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `cargosSaldoProveedorPeriodo` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `abonosSaldoProveedorPeriodo` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `saldoFinalSaldoProveedorPeriodo` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `tipoCambioSaldoProveedorPeriodo` decimal(12,6) NOT NULL DEFAULT '1.000000',
  `saldoFinalLocalSaldoProveedorPeriodo` decimal(12,4) NOT NULL DEFAULT '0.0000',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idSaldoProveedorPeriodo`),
  UNIQUE KEY `uqPeriodoProveedorMonedaSaldo` (`idPeriodoCompras`,`idProveedor`,`idMoneda`),
  KEY `idxSaldoProveedorPeriodoProveedor` (`idProveedor`),
  KEY `idxSaldoProveedorPeriodoMoneda` (`idMoneda`),
  CONSTRAINT `Fk_SaldoProveedorPeriodo_Moneda` FOREIGN KEY (`idMoneda`) REFERENCES `tblmoneda` (`idMoneda`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `Fk_SaldoProveedorPeriodo_Periodo` FOREIGN KEY (`idPeriodoCompras`) REFERENCES `tblperiodocompras` (`idPeriodoCompras`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `Fk_SaldoProveedorPeriodo_Proveedor` FOREIGN KEY (`idProveedor`) REFERENCES `tblproveedor` (`idProveedor`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `ckCuadreSaldoProveedorPeriodo` CHECK ((`saldoFinalSaldoProveedorPeriodo` = ((`saldoInicialSaldoProveedorPeriodo` + `cargosSaldoProveedorPeriodo`) - `abonosSaldoProveedorPeriodo`))),
  CONSTRAINT `ckMovimientosSaldoProveedorPeriodo` CHECK (((`cargosSaldoProveedorPeriodo` >= 0) and (`abonosSaldoProveedorPeriodo` >= 0))),
  CONSTRAINT `ckTipoCambioSaldoProveedorPeriodo` CHECK ((`tipoCambioSaldoProveedorPeriodo` > 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblsaldoproveedorperiodo`
--

LOCK TABLES `tblsaldoproveedorperiodo` WRITE;
/*!40000 ALTER TABLE `tblsaldoproveedorperiodo` DISABLE KEYS */;
/*!40000 ALTER TABLE `tblsaldoproveedorperiodo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblsaldos`
--

DROP TABLE IF EXISTS `tblsaldos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblsaldos` (
  `idSaldo` int NOT NULL AUTO_INCREMENT,
  `Fk_Producto_Codigo` int NOT NULL,
  `Fk_Bodega_Codigo` int NOT NULL,
  `saldoActualSaldo` int NOT NULL DEFAULT '0',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idSaldo`),
  UNIQUE KEY `uqSaldoProductoBodega` (`Fk_Producto_Codigo`,`Fk_Bodega_Codigo`),
  KEY `Fk_Saldos_Bodega` (`Fk_Bodega_Codigo`),
  CONSTRAINT `Fk_Saldos_Bodega` FOREIGN KEY (`Fk_Bodega_Codigo`) REFERENCES `tblbodega` (`idBodega`) ON DELETE RESTRICT,
  CONSTRAINT `Fk_Saldos_Producto` FOREIGN KEY (`Fk_Producto_Codigo`) REFERENCES `tblproducto` (`idProducto`) ON DELETE RESTRICT,
  CONSTRAINT `ckSaldoActualNoNegativo` CHECK ((`saldoActualSaldo` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblsaldos`
--

LOCK TABLES `tblsaldos` WRITE;
/*!40000 ALTER TABLE `tblsaldos` DISABLE KEYS */;
INSERT INTO `tblsaldos` VALUES (1,1,1,135,'2026-11-14 18:34:39','2026-11-14 18:34:39'),(2,2,2,82,'2026-11-14 18:34:39','2026-11-14 18:34:39'),(3,3,3,50,'2026-11-14 18:34:39','2026-11-14 18:34:39'),(4,4,4,160,'2026-11-14 18:34:39','2026-11-14 18:34:39'),(5,5,5,100,'2026-11-14 18:34:39','2026-11-14 18:34:39');
/*!40000 ALTER TABLE `tblsaldos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblserviciotransporteexterno`
--

DROP TABLE IF EXISTS `tblserviciotransporteexterno`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblserviciotransporteexterno` (
  `idServicioTransporteExterno` int NOT NULL AUTO_INCREMENT,
  `Fk_Empresa_Transportista_Codigo` int NOT NULL,
  `Fk_Tipo_Servicio_Codigo` int NOT NULL,
  `Fk_Traslado_Codigo` int DEFAULT NULL,
  `numeroGuiaServicioTransporteExterno` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `estadoServicioTransporteExterno` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Programado',
  `origenServicioTransporteExterno` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `direccionOrigenServicioTransporteExterno` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `destinoServicioTransporteExterno` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `direccionDestinoServicioTransporteExterno` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fechaContratacionServicioTransporteExterno` date NOT NULL,
  `fechaEstimadaEntregaServicioTransporteExterno` date NOT NULL,
  `fechaEntregaRealServicioTransporteExterno` date DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idServicioTransporteExterno`),
  UNIQUE KEY `uqServicioNumeroGuia` (`numeroGuiaServicioTransporteExterno`),
  KEY `Fk_Servicio_Transporte_Externo_Empresa_Transportista` (`Fk_Empresa_Transportista_Codigo`),
  KEY `Fk_Servicio_Transporte_Externo_Tipo_Servicio` (`Fk_Tipo_Servicio_Codigo`),
  KEY `Fk_Servicio_Transporte_Externo_Traslado` (`Fk_Traslado_Codigo`),
  CONSTRAINT `Fk_Servicio_Transporte_Externo_Empresa_Transportista` FOREIGN KEY (`Fk_Empresa_Transportista_Codigo`) REFERENCES `tblempresatransportista` (`idEmpresaTransportista`) ON DELETE RESTRICT,
  CONSTRAINT `Fk_Servicio_Transporte_Externo_Tipo_Servicio` FOREIGN KEY (`Fk_Tipo_Servicio_Codigo`) REFERENCES `tbltiposervicio` (`idTipoServicio`) ON DELETE RESTRICT,
  CONSTRAINT `Fk_Servicio_Transporte_Externo_Traslado` FOREIGN KEY (`Fk_Traslado_Codigo`) REFERENCES `tbltraslado` (`idTraslado`) ON DELETE RESTRICT,
  CONSTRAINT `ckServicioEstado` CHECK ((`estadoServicioTransporteExterno` in (_utf8mb4'Programado',_utf8mb4'En tránsito',_utf8mb4'Entregado',_utf8mb4'Cancelado'))),
  CONSTRAINT `ckServicioFechas` CHECK ((`fechaEstimadaEntregaServicioTransporteExterno` >= `fechaContratacionServicioTransporteExterno`))
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblserviciotransporteexterno`
--

LOCK TABLES `tblserviciotransporteexterno` WRITE;
/*!40000 ALTER TABLE `tblserviciotransporteexterno` DISABLE KEYS */;
INSERT INTO `tblserviciotransporteexterno` VALUES (1,1,1,1,'GUIA-EXT-2601','Entregado','Ciudad de Guatemala','Avenida Petapa 32-36, zona 12','Mixco','Calzada San Juan 10-80, zona 4','2026-10-23','2026-10-25','2026-10-25','2026-11-14 18:34:39','2026-11-14 18:34:39'),(2,2,2,2,'GUIA-EXT-2602','Entregado','Mixco','Calzada San Juan 10-80, zona 4','Villa Nueva','5a avenida 4-55, zona 1','2026-10-24','2026-10-26','2026-10-26','2026-11-14 18:34:39','2026-11-14 18:34:39'),(3,3,3,3,'GUIA-EXT-2603','Entregado','Villa Nueva','5a avenida 4-55, zona 1','Quetzaltenango','7a calle 14-26, zona 3','2026-10-25','2026-10-27','2026-10-27','2026-11-14 18:34:39','2026-11-14 18:34:39'),(4,4,4,4,'GUIA-EXT-2604','En tránsito','Quetzaltenango','7a calle 14-26, zona 3','Escuintla','2a avenida 5-14, zona 1','2026-11-07','2026-11-11',NULL,'2026-11-14 18:34:39','2026-11-14 18:34:39'),(5,5,5,5,'GUIA-EXT-2605','Programado','Escuintla','2a avenida 5-14, zona 1','Ciudad de Guatemala','Avenida Petapa 32-36, zona 12','2026-11-10','2026-11-13',NULL,'2026-11-14 18:34:39','2026-11-14 18:34:39');
/*!40000 ALTER TABLE `tblserviciotransporteexterno` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblsolicitudpago`
--

DROP TABLE IF EXISTS `tblsolicitudpago`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblsolicitudpago` (
  `idSolicitudPago` int NOT NULL AUTO_INCREMENT,
  `moduloOrigenSolicitudPago` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `idOrigenSolicitudPago` int NOT NULL,
  `beneficiarioSolicitudPago` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `montoSolicitudPago` decimal(12,4) NOT NULL,
  `metodoSolicitudPago` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `estadoSolicitudPago` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Pendiente',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idSolicitudPago`),
  KEY `idxSolicitudPagoOrigen` (`moduloOrigenSolicitudPago`,`idOrigenSolicitudPago`),
  CONSTRAINT `ckEstadoSolicitudPago` CHECK ((`estadoSolicitudPago` in (_utf8mb4'Pendiente',_utf8mb4'Procesada',_utf8mb4'Rechazada'))),
  CONSTRAINT `ckMontoSolicitudPago` CHECK ((`montoSolicitudPago` > 0))
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblsolicitudpago`
--

LOCK TABLES `tblsolicitudpago` WRITE;
/*!40000 ALTER TABLE `tblsolicitudpago` DISABLE KEYS */;
INSERT INTO `tblsolicitudpago` VALUES (1,'Compras',1,'Proveedor prueba 1 0d2d5068e05a',20.0000,'Efectivo','Pendiente','2026-11-14 18:34:39','2026-11-14 18:34:39'),(2,'Compras',2,'Proveedor prueba 2 0d2d5068e05a',20.0000,'Efectivo','Pendiente','2026-11-14 18:34:39','2026-11-14 18:34:39'),(3,'Compras',3,'Proveedor prueba 3 0d2d5068e05a',20.0000,'Efectivo','Pendiente','2026-11-14 18:34:39','2026-11-14 18:34:39'),(4,'Compras',4,'Proveedor prueba 4 0d2d5068e05a',20.0000,'Efectivo','Rechazada','2026-11-14 18:34:39','2026-11-14 18:34:39'),(5,'Compras',5,'Proveedor prueba 5 0d2d5068e05a',20.0000,'Efectivo','Rechazada','2026-11-14 18:34:39','2026-11-14 18:34:39');
/*!40000 ALTER TABLE `tblsolicitudpago` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblsolicitudpagotransporte`
--

DROP TABLE IF EXISTS `tblsolicitudpagotransporte`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblsolicitudpagotransporte` (
  `idSolicitudPagoTransporte` int NOT NULL AUTO_INCREMENT,
  `Fk_Servicio_Transporte_Externo_Codigo` int NOT NULL,
  `codigoSolicitudPagoTransporte` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Fk_Estado_Solicitud_Pago_Codigo` int NOT NULL DEFAULT '1',
  `referenciaBancariaSolicitudPagoTransporte` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fechaPagoSolicitudPagoTransporte` date DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idSolicitudPagoTransporte`),
  UNIQUE KEY `uqSolicitudServicio` (`Fk_Servicio_Transporte_Externo_Codigo`),
  UNIQUE KEY `uqSolicitudCodigo` (`codigoSolicitudPagoTransporte`),
  KEY `idxSolicitudPagoEstado` (`Fk_Estado_Solicitud_Pago_Codigo`),
  CONSTRAINT `Fk_Solicitud_Pago_Transporte_Estado_Solicitud_Pago` FOREIGN KEY (`Fk_Estado_Solicitud_Pago_Codigo`) REFERENCES `tblestadosolicitudpago` (`idEstadoSolicitudPago`) ON DELETE RESTRICT,
  CONSTRAINT `Fk_Solicitud_Pago_Transporte_Servicio_Transporte_Externo` FOREIGN KEY (`Fk_Servicio_Transporte_Externo_Codigo`) REFERENCES `tblserviciotransporteexterno` (`idServicioTransporteExterno`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblsolicitudpagotransporte`
--

LOCK TABLES `tblsolicitudpagotransporte` WRITE;
/*!40000 ALTER TABLE `tblsolicitudpagotransporte` DISABLE KEYS */;
INSERT INTO `tblsolicitudpagotransporte` VALUES (1,1,'SOL-PAG-2601',4,'TRF-20261028-001','2026-10-28','2026-11-14 18:34:39','2026-11-14 18:34:39'),(2,2,'SOL-PAG-2602',3,NULL,NULL,'2026-11-14 18:34:39','2026-11-14 18:34:39'),(3,3,'SOL-PAG-2603',2,NULL,NULL,'2026-11-14 18:34:39','2026-11-14 18:34:39'),(4,4,'SOL-PAG-2604',1,NULL,NULL,'2026-11-14 18:34:39','2026-11-14 18:34:39'),(5,5,'SOL-PAG-2605',5,NULL,NULL,'2026-11-14 18:34:39','2026-11-14 18:34:39');
/*!40000 ALTER TABLE `tblsolicitudpagotransporte` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblstock`
--

DROP TABLE IF EXISTS `tblstock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblstock` (
  `idStock` int NOT NULL AUTO_INCREMENT,
  `Fk_Sucursal_Codigo` int NOT NULL,
  `Fk_Bodega_Codigo` int NOT NULL,
  `Fk_Producto_Codigo` int NOT NULL,
  `stockFisicoStock` int NOT NULL DEFAULT '0',
  `stockVirtualStock` int NOT NULL DEFAULT '0',
  `stockAnteriorStock` int NOT NULL DEFAULT '0',
  `stockActualStock` int NOT NULL DEFAULT '0',
  `cargosMesStock` int NOT NULL DEFAULT '0',
  `abonosMesStock` int NOT NULL DEFAULT '0',
  `cargosAcumuladosStock` bigint NOT NULL DEFAULT '0',
  `abonosAcumuladosStock` bigint NOT NULL DEFAULT '0',
  `apartadosStock` int NOT NULL DEFAULT '0',
  `estadoVentaStock` tinyint(1) NOT NULL,
  `estadoCompraStock` tinyint(1) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idStock`),
  UNIQUE KEY `uqStockSucursalBodegaProducto` (`Fk_Sucursal_Codigo`,`Fk_Bodega_Codigo`,`Fk_Producto_Codigo`),
  KEY `Fk_Stock_Bodega` (`Fk_Bodega_Codigo`,`Fk_Sucursal_Codigo`),
  KEY `Fk_Stock_Producto` (`Fk_Producto_Codigo`),
  CONSTRAINT `Fk_Stock_Bodega` FOREIGN KEY (`Fk_Bodega_Codigo`, `Fk_Sucursal_Codigo`) REFERENCES `tblbodega` (`idBodega`, `Fk_Sucursal_Codigo`) ON DELETE RESTRICT,
  CONSTRAINT `Fk_Stock_Producto` FOREIGN KEY (`Fk_Producto_Codigo`) REFERENCES `tblproducto` (`idProducto`) ON DELETE RESTRICT,
  CONSTRAINT `ckEstadoCompraStock` CHECK ((`estadoCompraStock` in (0,1))),
  CONSTRAINT `ckEstadoVentaStock` CHECK ((`estadoVentaStock` in (0,1))),
  CONSTRAINT `ckStockActualNoNegativo` CHECK ((`stockActualStock` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblstock`
--

LOCK TABLES `tblstock` WRITE;
/*!40000 ALTER TABLE `tblstock` DISABLE KEYS */;
INSERT INTO `tblstock` VALUES (1,1,1,1,135,135,120,135,35,20,400,265,12,1,1,'2026-11-14 18:34:39','2026-11-14 18:34:39'),(2,2,2,2,82,82,80,82,20,18,250,168,5,1,1,'2026-11-14 18:34:39','2026-11-14 18:34:39'),(3,3,3,3,50,50,60,50,15,25,220,170,3,1,1,'2026-11-14 18:34:39','2026-11-14 18:34:39'),(4,4,4,4,160,160,150,160,50,40,580,420,20,1,0,'2026-11-14 18:34:39','2026-11-14 18:34:39'),(5,5,5,5,100,100,95,100,20,15,330,230,8,0,1,'2026-11-14 18:34:39','2026-11-14 18:34:39'),(6,6,6,11,15,15,0,15,15,0,15,0,0,1,1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(7,6,7,11,15,15,0,15,15,0,15,0,0,1,1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(8,6,6,12,15,15,0,15,15,0,15,0,0,1,1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(9,6,7,12,15,15,0,15,15,0,15,0,0,1,1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(10,6,6,13,15,15,0,15,15,0,15,0,0,1,1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(11,6,7,13,15,15,0,15,15,0,15,0,0,1,1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(12,6,6,14,15,15,0,15,15,0,15,0,0,1,1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(13,6,7,14,15,15,0,15,15,0,15,0,0,1,1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(14,6,6,15,15,15,0,15,15,0,15,0,0,1,1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(15,6,7,15,15,15,0,15,15,0,15,0,0,1,1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(16,6,6,16,15,15,0,15,15,0,15,0,0,1,1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(17,6,7,16,15,15,0,15,15,0,15,0,0,1,1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(18,6,6,17,15,15,0,15,15,0,15,0,0,1,1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(19,6,7,17,15,15,0,15,15,0,15,0,0,1,1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(20,6,6,18,15,15,0,15,15,0,15,0,0,1,1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(21,6,7,18,15,15,0,15,15,0,15,0,0,1,1,'2026-11-14 18:34:40','2026-11-14 18:34:40');
/*!40000 ALTER TABLE `tblstock` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblsucursal`
--

DROP TABLE IF EXISTS `tblsucursal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblsucursal` (
  `idSucursal` int NOT NULL AUTO_INCREMENT,
  `nombreSucursal` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcionSucursal` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ubicacionSucursal` varchar(500) COLLATE utf8mb4_unicode_ci NOT NULL,
  `paisSucursal` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idSucursal`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblsucursal`
--

LOCK TABLES `tblsucursal` WRITE;
/*!40000 ALTER TABLE `tblsucursal` DISABLE KEYS */;
INSERT INTO `tblsucursal` VALUES (1,'Sucursal Central Guatemala','Centro de distribución y atención mayorista','Avenida Petapa 32-36, zona 12, Ciudad de Guatemala','Guatemala','2026-11-14 18:34:39','2026-11-14 18:34:39'),(2,'Sucursal Mixco','Distribución para comercios del área occidental metropolitana','Calzada San Juan 10-80, zona 4, Mixco','Guatemala','2026-11-14 18:34:39','2026-11-14 18:34:39'),(3,'Sucursal Villa Nueva','Almacenamiento y distribución del corredor sur','5a avenida 4-55, zona 1, Villa Nueva','Guatemala','2026-11-14 18:34:39','2026-11-14 18:34:39'),(4,'Sucursal Quetzaltenango','Centro regional de distribución de occidente','7a calle 14-26, zona 3, Quetzaltenango','Guatemala','2026-11-14 18:34:39','2026-11-14 18:34:39'),(5,'Sucursal Escuintla','Centro regional de distribución de la costa sur','2a avenida 5-14, zona 1, Escuintla','Guatemala','2026-11-14 18:34:39','2026-11-14 18:34:39'),(6,'FAC-QA Guatemala','Sucursal de pruebas de facturación','Ciudad','Guatemala','2026-11-14 18:34:40','2026-11-14 18:34:40');
/*!40000 ALTER TABLE `tblsucursal` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbltarifatransporte`
--

DROP TABLE IF EXISTS `tbltarifatransporte`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbltarifatransporte` (
  `idTarifaTransporte` int NOT NULL AUTO_INCREMENT,
  `nombreTarifaTransporte` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `estadoTarifaTransporte` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idTarifaTransporte`),
  UNIQUE KEY `uqTarifaTransporteNombre` (`nombreTarifaTransporte`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbltarifatransporte`
--

LOCK TABLES `tbltarifatransporte` WRITE;
/*!40000 ALTER TABLE `tbltarifatransporte` DISABLE KEYS */;
INSERT INTO `tbltarifatransporte` VALUES (1,'Tarifa por kilómetro recorrido',1,'2026-11-14 18:34:39','2026-11-14 18:34:39'),(2,'Tarifa por kilogramo transportado',1,'2026-11-14 18:34:39','2026-11-14 18:34:39'),(3,'Tarifa por viaje interdepartamental',1,'2026-11-14 18:34:39','2026-11-14 18:34:39'),(4,'Tarifa por hora de espera',1,'2026-11-14 18:34:39','2026-11-14 18:34:39'),(5,'Tarifa por entrega realizada',1,'2026-11-14 18:34:39','2026-11-14 18:34:39');
/*!40000 ALTER TABLE `tbltarifatransporte` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbltelemetriatemperatura`
--

DROP TABLE IF EXISTS `tbltelemetriatemperatura`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbltelemetriatemperatura` (
  `idTelemetriaTemperatura` bigint NOT NULL AUTO_INCREMENT,
  `Fk_Encabezado_Viaje_Codigo` bigint NOT NULL,
  `fechaHoraTelemetriaTemperatura` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `temperaturaCelsiusTelemetriaTemperatura` decimal(5,2) NOT NULL,
  `humedadRelativaTelemetriaTemperatura` decimal(5,4) NOT NULL,
  `puertaAbiertaTelemetriaTemperatura` tinyint(1) NOT NULL DEFAULT '0',
  `ubicacionGpsTelemetriaTemperatura` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idTelemetriaTemperatura`),
  KEY `idxCorrelativoFechaTelemetriaTemperatura` (`Fk_Encabezado_Viaje_Codigo`,`fechaHoraTelemetriaTemperatura`),
  CONSTRAINT `Fk_Telemetria_Temperatura_Encabezado_Viaje` FOREIGN KEY (`Fk_Encabezado_Viaje_Codigo`) REFERENCES `tblencabezadoviaje` (`idEncabezadoViaje`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbltelemetriatemperatura`
--

LOCK TABLES `tbltelemetriatemperatura` WRITE;
/*!40000 ALTER TABLE `tbltelemetriatemperatura` DISABLE KEYS */;
INSERT INTO `tbltelemetriatemperatura` VALUES (1,1,'2026-10-20 07:30:00',3.20,0.7250,0,'Ruta Interamericana, Mixco, Guatemala','2026-11-14 18:34:39','2026-11-14 18:34:39'),(2,2,'2026-10-21 10:15:00',7.10,0.6800,0,'Calzada Aguilar Batres, Villa Nueva, Guatemala','2026-11-14 18:34:39','2026-11-14 18:34:39'),(3,3,'2026-10-22 09:40:00',4.00,0.9100,0,'Carretera a Quetzaltenango, Totonicapán','2026-11-14 18:34:39','2026-11-14 18:34:39'),(4,4,'2026-11-11 09:05:00',3.60,0.7350,1,'Carretera al Pacífico, km 87, Escuintla','2026-11-14 18:34:39','2026-11-14 18:34:39'),(5,5,'2026-10-24 12:30:00',-3.50,0.7050,0,'Ruta al Pacífico, Santa Lucía Cotzumalguapa','2026-11-14 18:34:39','2026-11-14 18:34:39');
/*!40000 ALTER TABLE `tbltelemetriatemperatura` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbltipocambio`
--

DROP TABLE IF EXISTS `tbltipocambio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbltipocambio` (
  `idTipoCambio` bigint NOT NULL AUTO_INCREMENT,
  `fechaTipoCambio` date NOT NULL,
  `valorTipoCambio` decimal(12,4) NOT NULL,
  `fuenteTipoCambio` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `versionTipoCambio` int NOT NULL DEFAULT '1',
  `cotizacionOriginalTipoCambio` text COLLATE utf8mb4_unicode_ci,
  `metodoTipoCambio` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'DIRECTA',
  `motivoRevisionTipoCambio` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Fk_Moneda_Origen_Codigo` bigint NOT NULL,
  `Fk_Moneda_Destino_Codigo` bigint NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idTipoCambio`),
  UNIQUE KEY `uqTipoCambio1` (`Fk_Moneda_Origen_Codigo`,`Fk_Moneda_Destino_Codigo`,`fechaTipoCambio`,`fuenteTipoCambio`,`versionTipoCambio`),
  KEY `idxTipoCambioMonedaDestino` (`Fk_Moneda_Destino_Codigo`),
  CONSTRAINT `Fk_TipoCambio_Moneda_Destino` FOREIGN KEY (`Fk_Moneda_Destino_Codigo`) REFERENCES `tblmoneda` (`idMoneda`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `Fk_TipoCambio_Moneda_Origen` FOREIGN KEY (`Fk_Moneda_Origen_Codigo`) REFERENCES `tblmoneda` (`idMoneda`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `ckTipoCambio1` CHECK ((`valorTipoCambio` > 0)),
  CONSTRAINT `ckTipoCambio2` CHECK ((`versionTipoCambio` > 0)),
  CONSTRAINT `ckTipoCambio3` CHECK ((`metodoTipoCambio` in (_utf8mb4'DIRECTA',_utf8mb4'INVERSA',_utf8mb4'CRUZADA'))),
  CONSTRAINT `ckTipoCambio4` CHECK ((`Fk_Moneda_Origen_Codigo` <> `Fk_Moneda_Destino_Codigo`))
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbltipocambio`
--

LOCK TABLES `tbltipocambio` WRITE;
/*!40000 ALTER TABLE `tbltipocambio` DISABLE KEYS */;
INSERT INTO `tbltipocambio` VALUES (1,'2026-11-04',7.7498,'Banguat',1,NULL,'DIRECTA',NULL,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(2,'2026-11-05',7.7515,'Banguat',1,NULL,'DIRECTA',NULL,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(3,'2026-11-06',7.7532,'Banguat',1,NULL,'DIRECTA',NULL,2,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(4,'2026-11-06',8.9840,'Banguat',1,NULL,'DIRECTA',NULL,3,1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(5,'2026-11-06',0.4215,'Banguat',1,NULL,'DIRECTA',NULL,4,1,'2026-11-14 18:34:36','2026-11-14 18:34:36');
/*!40000 ALTER TABLE `tbltipocambio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbltipocliente`
--

DROP TABLE IF EXISTS `tbltipocliente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbltipocliente` (
  `idTipoCliente` int NOT NULL AUTO_INCREMENT,
  `codigoTipoCliente` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nombreTipoCliente` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `porcentajeDescuentoTipoCliente` decimal(5,2) NOT NULL DEFAULT '0.00',
  `descripcionTipoCliente` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `activoTipoCliente` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idTipoCliente`),
  UNIQUE KEY `uqTipoClientecodigo` (`codigoTipoCliente`),
  UNIQUE KEY `uqTipoClientenombre` (`nombreTipoCliente`),
  CONSTRAINT `ckTipoClienteactivoBooleano` CHECK ((`activoTipoCliente` in (0,1))),
  CONSTRAINT `ckTipoClienteporcentajeDescuentoRango` CHECK ((`porcentajeDescuentoTipoCliente` between 0 and 100))
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbltipocliente`
--

LOCK TABLES `tbltipocliente` WRITE;
/*!40000 ALTER TABLE `tbltipocliente` DISABLE KEYS */;
INSERT INTO `tbltipocliente` VALUES (1,'FAC-QA','Clientes de prueba de Facturas',0.00,NULL,1,'2026-11-14 18:34:40','2026-11-14 18:34:40');
/*!40000 ALTER TABLE `tbltipocliente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbltipocuentabancaria`
--

DROP TABLE IF EXISTS `tbltipocuentabancaria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbltipocuentabancaria` (
  `idTipoCuentaBancaria` bigint NOT NULL AUTO_INCREMENT,
  `codigoTipoCuentaBancaria` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nombreTipoCuentaBancaria` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idTipoCuentaBancaria`),
  UNIQUE KEY `uqTipoCuentaBancaria1` (`codigoTipoCuentaBancaria`),
  CONSTRAINT `ckTipoCuentaBancaria1` CHECK ((`is_active` in (0,1)))
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbltipocuentabancaria`
--

LOCK TABLES `tbltipocuentabancaria` WRITE;
/*!40000 ALTER TABLE `tbltipocuentabancaria` DISABLE KEYS */;
INSERT INTO `tbltipocuentabancaria` VALUES (1,'MONETARIA','Cuenta monetaria',1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(2,'AHORRO','Cuenta de ahorro',1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(3,'NOMINA','Cuenta de nomina',1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(4,'PLAZO_FIJO','Deposito a plazo fijo',1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(5,'INVERSION','Cuenta de inversion',1,'2026-11-14 18:34:36','2026-11-14 18:34:36');
/*!40000 ALTER TABLE `tbltipocuentabancaria` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbltipomovimiento`
--

DROP TABLE IF EXISTS `tbltipomovimiento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbltipomovimiento` (
  `idTipoMovimiento` int NOT NULL AUTO_INCREMENT,
  `nombreTipoMovimiento` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcionTipoMovimiento` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `signoTipoMovimiento` char(1) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idTipoMovimiento`),
  UNIQUE KEY `uqTipoMovimientoNombre` (`nombreTipoMovimiento`),
  CONSTRAINT `ckSignoTipoMovimiento` CHECK ((`signoTipoMovimiento` in (_utf8mb4'+',_utf8mb4'-')))
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbltipomovimiento`
--

LOCK TABLES `tbltipomovimiento` WRITE;
/*!40000 ALTER TABLE `tbltipomovimiento` DISABLE KEYS */;
INSERT INTO `tbltipomovimiento` VALUES (1,'Ingreso por compra','Incremento de inventario por recepción de mercadería','+','2026-11-14 18:34:39','2026-11-14 18:34:39'),(2,'Salida por venta','Reducción de inventario por despacho a cliente','-','2026-11-14 18:34:39','2026-11-14 18:34:39'),(3,'Traslado de entrada','Ingreso a bodega destino por traslado interno','+','2026-11-14 18:34:39','2026-11-14 18:34:39'),(4,'Traslado de salida','Egreso de bodega origen por traslado interno','-','2026-11-14 18:34:39','2026-11-14 18:34:39'),(5,'Ajuste positivo','Incremento autorizado después de conciliación','+','2026-11-14 18:34:39','2026-11-14 18:34:39'),(6,'Salida por facturación','Descuento de existencias al emitir una factura','-','2026-11-14 18:34:40','2026-11-14 18:34:40');
/*!40000 ALTER TABLE `tbltipomovimiento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbltipopermiso`
--

DROP TABLE IF EXISTS `tbltipopermiso`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbltipopermiso` (
  `idTipoPermiso` int NOT NULL AUTO_INCREMENT,
  `nombreTipoPermiso` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcionTipoPermiso` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `conGoceSueldoTipoPermiso` tinyint(1) NOT NULL DEFAULT '1',
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idTipoPermiso`),
  UNIQUE KEY `uqNombreTipoPermiso` (`nombreTipoPermiso`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbltipopermiso`
--

LOCK TABLES `tbltipopermiso` WRITE;
/*!40000 ALTER TABLE `tbltipopermiso` DISABLE KEYS */;
INSERT INTO `tbltipopermiso` VALUES (1,'Cita médica','Consulta o examen médico',1,1,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(2,'Asunto personal','Trámites o asuntos personales sin goce',0,1,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(3,'Duelo familiar','Fallecimiento de un familiar',1,1,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(4,'Trámite personal','Gestiones en entidades públicas o privadas',1,1,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(5,'Asunto familiar','Situaciones familiares que requieren presencia',1,1,'2026-11-14 18:34:37','2026-11-14 18:34:37');
/*!40000 ALTER TABLE `tbltipopermiso` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbltipopuesto`
--

DROP TABLE IF EXISTS `tbltipopuesto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbltipopuesto` (
  `idTipoPuesto` int NOT NULL AUTO_INCREMENT,
  `nombreTipoPuesto` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idTipoPuesto`),
  UNIQUE KEY `uqNombreTipoPuesto` (`nombreTipoPuesto`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbltipopuesto`
--

LOCK TABLES `tbltipopuesto` WRITE;
/*!40000 ALTER TABLE `tbltipopuesto` DISABLE KEYS */;
INSERT INTO `tbltipopuesto` VALUES (1,'Administrativo',1,'2026-11-14 18:33:55','2026-11-14 18:33:55'),(2,'Operativo',1,'2026-11-14 18:33:55','2026-11-14 18:33:55'),(3,'Gerencial',1,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(4,'Técnico',1,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(5,'Ventas',1,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(6,'Supervisión',1,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(7,'Temporal',1,'2026-11-14 18:34:37','2026-11-14 18:34:37');
/*!40000 ALTER TABLE `tbltipopuesto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbltiposervicio`
--

DROP TABLE IF EXISTS `tbltiposervicio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbltiposervicio` (
  `idTipoServicio` int NOT NULL AUTO_INCREMENT,
  `nombreTipoServicio` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `estadoTipoServicio` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idTipoServicio`),
  UNIQUE KEY `uqTipoServicioNombre` (`nombreTipoServicio`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbltiposervicio`
--

LOCK TABLES `tbltiposervicio` WRITE;
/*!40000 ALTER TABLE `tbltiposervicio` DISABLE KEYS */;
INSERT INTO `tbltiposervicio` VALUES (1,'Transporte refrigerado',1,'2026-11-14 18:34:39','2026-11-14 18:34:39'),(2,'Distribución urbana',1,'2026-11-14 18:34:39','2026-11-14 18:34:39'),(3,'Entrega interdepartamental',1,'2026-11-14 18:34:39','2026-11-14 18:34:39'),(4,'Traslado entre centros regionales',1,'2026-11-14 18:34:39','2026-11-14 18:34:39'),(5,'Reposición a centro de distribución',1,'2026-11-14 18:34:39','2026-11-14 18:34:39');
/*!40000 ALTER TABLE `tbltiposervicio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbltipotransaccion`
--

DROP TABLE IF EXISTS `tbltipotransaccion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbltipotransaccion` (
  `idTipoTransaccion` bigint NOT NULL AUTO_INCREMENT,
  `codigoTipoTransaccion` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `nombreTipoTransaccion` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `naturalezaTipoTransaccion` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idTipoTransaccion`),
  UNIQUE KEY `uqTipoTransaccion1` (`codigoTipoTransaccion`),
  CONSTRAINT `ckTipoTransaccion1` CHECK ((`naturalezaTipoTransaccion` in (_utf8mb4'INGRESO',_utf8mb4'EGRESO',_utf8mb4'AMBOS'))),
  CONSTRAINT `ckTipoTransaccion2` CHECK ((`is_active` in (0,1)))
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbltipotransaccion`
--

LOCK TABLES `tbltipotransaccion` WRITE;
/*!40000 ALTER TABLE `tbltipotransaccion` DISABLE KEYS */;
INSERT INTO `tbltipotransaccion` VALUES (1,'TRANS-101','Pago a proveedores por cheque','EGRESO',1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(2,'TRANS-102','Pago de planilla por cheque','EGRESO',1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(3,'TRANS-103','Deposito de cliente','INGRESO',1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(4,'TRANS-104','Comision bancaria','EGRESO',1,'2026-11-14 18:34:36','2026-11-14 18:34:36'),(5,'TRANS-105','Transferencia entre cuentas propias','AMBOS',1,'2026-11-14 18:34:36','2026-11-14 18:34:36');
/*!40000 ALTER TABLE `tbltipotransaccion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbltipotransporte`
--

DROP TABLE IF EXISTS `tbltipotransporte`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbltipotransporte` (
  `idTipoTransporte` int NOT NULL AUTO_INCREMENT,
  `nombreTipoTransporte` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idTipoTransporte`),
  UNIQUE KEY `uqNombreTipoTransporte` (`nombreTipoTransporte`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbltipotransporte`
--

LOCK TABLES `tbltipotransporte` WRITE;
/*!40000 ALTER TABLE `tbltipotransporte` DISABLE KEYS */;
INSERT INTO `tbltipotransporte` VALUES (1,'Camión refrigerado','2026-11-14 18:34:39','2026-11-14 18:34:39'),(2,'Furgón refrigerado','2026-11-14 18:34:39','2026-11-14 18:34:39'),(3,'Camión de reparto refrigerado','2026-11-14 18:34:39','2026-11-14 18:34:39'),(4,'Panel isotérmico','2026-11-14 18:34:39','2026-11-14 18:34:39'),(5,'Cabezal con semirremolque refrigerado','2026-11-14 18:34:39','2026-11-14 18:34:39');
/*!40000 ALTER TABLE `tbltipotransporte` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbltransferenciainterna`
--

DROP TABLE IF EXISTS `tbltransferenciainterna`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbltransferenciainterna` (
  `idTransferenciaInterna` bigint NOT NULL AUTO_INCREMENT,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idTransferenciaInterna`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbltransferenciainterna`
--

LOCK TABLES `tbltransferenciainterna` WRITE;
/*!40000 ALTER TABLE `tbltransferenciainterna` DISABLE KEYS */;
INSERT INTO `tbltransferenciainterna` VALUES (1,1,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(2,1,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(3,1,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(4,1,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(5,1,'2026-11-14 18:34:37','2026-11-14 18:34:37');
/*!40000 ALTER TABLE `tbltransferenciainterna` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbltransporte`
--

DROP TABLE IF EXISTS `tbltransporte`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbltransporte` (
  `idTransporte` int NOT NULL AUTO_INCREMENT,
  `nroPlacaTransporte` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `marcaTransporte` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `modeloTransporte` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `anioTransporte` smallint NOT NULL,
  `esRefrigeradoTransporte` tinyint(1) NOT NULL DEFAULT '0',
  `Fk_Estado_Codigo` int NOT NULL,
  `Fk_Tipo_Transporte_Codigo` int NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idTransporte`),
  UNIQUE KEY `uqNroPlacaTransporte` (`nroPlacaTransporte`),
  KEY `idxIdEstadoTransporte` (`Fk_Estado_Codigo`),
  KEY `idxIdTipoTransporteTransporte` (`Fk_Tipo_Transporte_Codigo`),
  CONSTRAINT `Fk_Transporte_Estado` FOREIGN KEY (`Fk_Estado_Codigo`) REFERENCES `tblestado` (`idEstado`) ON DELETE RESTRICT,
  CONSTRAINT `Fk_Transporte_Tipo_Transporte` FOREIGN KEY (`Fk_Tipo_Transporte_Codigo`) REFERENCES `tbltipotransporte` (`idTipoTransporte`) ON DELETE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbltransporte`
--

LOCK TABLES `tbltransporte` WRITE;
/*!40000 ALTER TABLE `tbltransporte` DISABLE KEYS */;
INSERT INTO `tbltransporte` VALUES (1,'C-428BKV','Hino','500 Series',2022,1,1,1,'2026-11-14 18:34:39','2026-11-14 18:34:39'),(2,'C-693FTR','Isuzu','NQR',2021,1,3,2,'2026-11-14 18:34:39','2026-11-14 18:34:39'),(3,'C-185LPM','Mitsubishi Fuso','Canter',2023,1,1,3,'2026-11-14 18:34:39','2026-11-14 18:34:39'),(4,'P-734KDS','Hyundai','H100',2020,1,3,4,'2026-11-14 18:34:39','2026-11-14 18:34:39'),(5,'C-952RHG','Freightliner','M2 106',2024,1,1,5,'2026-11-14 18:34:39','2026-11-14 18:34:39');
/*!40000 ALTER TABLE `tbltransporte` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbltraslado`
--

DROP TABLE IF EXISTS `tbltraslado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbltraslado` (
  `idTraslado` int NOT NULL AUTO_INCREMENT,
  `codigoTraslado` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Fk_Bodega_Origen_Codigo` int NOT NULL,
  `Fk_Bodega_Destino_Codigo` int NOT NULL,
  `Fk_Transporte_Codigo` int DEFAULT NULL,
  `fechaSolicitudTraslado` datetime NOT NULL,
  `fechaSalidaTraslado` datetime DEFAULT NULL,
  `fechaLlegadaTraslado` datetime DEFAULT NULL,
  `estadoTraslado` enum('SOLICITADO','EN_TRANSITO','RECIBIDO','CANCELADO') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'SOLICITADO',
  `observacionesTraslado` varchar(500) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idTraslado`),
  UNIQUE KEY `uqCodigoTraslado` (`codigoTraslado`),
  KEY `Fk_Traslado_Bodega_Origen` (`Fk_Bodega_Origen_Codigo`),
  KEY `Fk_Traslado_Bodega_Destino` (`Fk_Bodega_Destino_Codigo`),
  KEY `Fk_Traslado_Transporte` (`Fk_Transporte_Codigo`),
  CONSTRAINT `Fk_Traslado_Bodega_Destino` FOREIGN KEY (`Fk_Bodega_Destino_Codigo`) REFERENCES `tblbodega` (`idBodega`) ON DELETE RESTRICT,
  CONSTRAINT `Fk_Traslado_Bodega_Origen` FOREIGN KEY (`Fk_Bodega_Origen_Codigo`) REFERENCES `tblbodega` (`idBodega`) ON DELETE RESTRICT,
  CONSTRAINT `Fk_Traslado_Transporte` FOREIGN KEY (`Fk_Transporte_Codigo`) REFERENCES `tbltransporte` (`idTransporte`) ON DELETE RESTRICT,
  CONSTRAINT `ckTrasladoBodegasDistintas` CHECK ((`Fk_Bodega_Origen_Codigo` <> `Fk_Bodega_Destino_Codigo`))
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbltraslado`
--

LOCK TABLES `tbltraslado` WRITE;
/*!40000 ALTER TABLE `tbltraslado` DISABLE KEYS */;
INSERT INTO `tbltraslado` VALUES (1,'TR-2026-0001',1,2,1,'2026-10-25 08:00:00','2026-10-25 09:00:00','2026-10-25 11:15:00','RECIBIDO','Mercadería recibida con temperatura de 3 grados Celsius.','2026-11-14 18:34:39','2026-11-14 18:34:39'),(2,'TR-2026-0002',2,3,2,'2026-10-26 07:30:00','2026-10-26 08:20:00','2026-10-26 10:45:00','RECIBIDO','Entrega conforme a guía de traslado y conteo de cajas.','2026-11-14 18:34:39','2026-11-14 18:34:39'),(3,'TR-2026-0003',3,4,3,'2026-10-27 05:50:00','2026-10-27 06:30:00','2026-10-27 14:20:00','RECIBIDO','Despacho interdepartamental sin novedades.','2026-11-14 18:34:39','2026-11-14 18:34:39'),(4,'TR-2026-0004',4,5,4,'2026-11-08 08:10:00','2026-11-08 09:00:00',NULL,'EN_TRANSITO','Unidad en carretera con entrega pendiente de confirmar.','2026-11-14 18:34:39','2026-11-14 18:34:39'),(5,'TR-2026-0005',5,1,5,'2026-11-10 10:00:00',NULL,NULL,'SOLICITADO','Traslado programado para reposición en bodega central.','2026-11-14 18:34:39','2026-11-14 18:34:39');
/*!40000 ALTER TABLE `tbltraslado` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbltrasladocxcdetalle`
--

DROP TABLE IF EXISTS `tbltrasladocxcdetalle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbltrasladocxcdetalle` (
  `idTrasladoCxCDetalle` int NOT NULL AUTO_INCREMENT,
  `idTrasladoCxCEncabezado` int NOT NULL,
  `numeroLineaTrasladoCxCDetalle` int NOT NULL,
  `cuentaTrasladoCxCDetalle` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcionTrasladoCxCDetalle` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `debeTrasladoCxCDetalle` decimal(12,4) NOT NULL,
  `haberTrasladoCxCDetalle` decimal(12,4) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idTrasladoCxCEncabezado`,`idTrasladoCxCDetalle`),
  UNIQUE KEY `uqTrasladoCxCDetalleClaveNegocio` (`idTrasladoCxCEncabezado`,`numeroLineaTrasladoCxCDetalle`),
  UNIQUE KEY `uqTrasladoCxCDetalleId` (`idTrasladoCxCDetalle`),
  CONSTRAINT `Fk_TrasladoCxCDetalle_TrasladoCxCEncabezado` FOREIGN KEY (`idTrasladoCxCEncabezado`) REFERENCES `tbltrasladocxcencabezado` (`idTrasladoCxCEncabezado`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `ckTrasladoCxCDetalleDebeHaberNoNegativos` CHECK (((`debeTrasladoCxCDetalle` >= 0) and (`haberTrasladoCxCDetalle` >= 0)))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbltrasladocxcdetalle`
--

LOCK TABLES `tbltrasladocxcdetalle` WRITE;
/*!40000 ALTER TABLE `tbltrasladocxcdetalle` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbltrasladocxcdetalle` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbltrasladocxcencabezado`
--

DROP TABLE IF EXISTS `tbltrasladocxcencabezado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbltrasladocxcencabezado` (
  `idTrasladoCxCEncabezado` int NOT NULL AUTO_INCREMENT,
  `idCierreMovimientoCxCEncabezado` int NOT NULL,
  `claveIntegracionTrasladoCxCEncabezado` varchar(80) COLLATE utf8mb4_unicode_ci NOT NULL,
  `estadoTrasladoCxCEncabezado` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'PENDIENTE',
  `referenciaContableTrasladoCxCEncabezado` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idUsuario` int NOT NULL,
  `fechaConfirmacionTrasladoCxCEncabezado` datetime DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idTrasladoCxCEncabezado`),
  UNIQUE KEY `uqTrasladoCxCEncabezadoclaveIntegracion` (`claveIntegracionTrasladoCxCEncabezado`),
  UNIQUE KEY `uqTrasladoCxCEncabezadoClaveNegocio` (`idCierreMovimientoCxCEncabezado`),
  KEY `idxTrasladoCxCEncabezadoUsuarioCodigo` (`idUsuario`),
  CONSTRAINT `Fk_TrasladoCxCEncabezado_CierreMovimientoCxCEncabezado` FOREIGN KEY (`idCierreMovimientoCxCEncabezado`) REFERENCES `tblcierremovimientocxcencabezado` (`idCierreMovimientoCxCEncabezado`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `Fk_TrasladoCxCEncabezado_Usuario` FOREIGN KEY (`idUsuario`) REFERENCES `tblusuario` (`idUsuario`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `ckTrasladoCxCEncabezadoValoresEstado` CHECK ((`estadoTrasladoCxCEncabezado` in (_utf8mb4'PENDIENTE',_utf8mb4'PREPARADO',_utf8mb4'ENVIADO',_utf8mb4'CONFIRMADO',_utf8mb4'RECHAZADO')))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbltrasladocxcencabezado`
--

LOCK TABLES `tbltrasladocxcencabezado` WRITE;
/*!40000 ALTER TABLE `tbltrasladocxcencabezado` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbltrasladocxcencabezado` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblubicaciontransporte`
--

DROP TABLE IF EXISTS `tblubicaciontransporte`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblubicaciontransporte` (
  `idUbicacionTransporte` int NOT NULL AUTO_INCREMENT,
  `Fk_Servicio_Transporte_Externo_Codigo` int NOT NULL,
  `ubicacionActualUbicacionTransporte` varchar(500) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fechaActualizacionUbicacionTransporte` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idUbicacionTransporte`),
  KEY `idxUbicacionServicioFecha` (`Fk_Servicio_Transporte_Externo_Codigo`,`fechaActualizacionUbicacionTransporte`),
  CONSTRAINT `Fk_Ubicacion_Transporte_Servicio_Transporte_Externo` FOREIGN KEY (`Fk_Servicio_Transporte_Externo_Codigo`) REFERENCES `tblserviciotransporteexterno` (`idServicioTransporteExterno`) ON DELETE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblubicaciontransporte`
--

LOCK TABLES `tblubicaciontransporte` WRITE;
/*!40000 ALTER TABLE `tblubicaciontransporte` DISABLE KEYS */;
INSERT INTO `tblubicaciontransporte` VALUES (1,1,'Centro de distribución de Mixco, Guatemala','2026-10-25 11:15:00','2026-11-14 18:34:39','2026-11-14 18:34:39'),(2,2,'Bodega principal de Villa Nueva, Guatemala','2026-10-26 10:45:00','2026-11-14 18:34:39','2026-11-14 18:34:39'),(3,3,'Centro regional de Quetzaltenango, Guatemala','2026-10-27 14:20:00','2026-11-14 18:34:39','2026-11-14 18:34:39'),(4,4,'Ruta al Pacífico, km 87, Escuintla','2026-11-11 10:15:00','2026-11-14 18:34:39','2026-11-14 18:34:39'),(5,5,'Patio de transportistas, Escuintla','2026-11-10 16:00:00','2026-11-14 18:34:39','2026-11-14 18:34:39');
/*!40000 ALTER TABLE `tblubicaciontransporte` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblusuario`
--

DROP TABLE IF EXISTS `tblusuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblusuario` (
  `idUsuario` int NOT NULL AUTO_INCREMENT,
  `idEmpleado` int NOT NULL,
  `nombreUsuario` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `contrasenaUsuario` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `ultimoAccesoUsuario` datetime NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idUsuario`),
  UNIQUE KEY `uqIdEmpleadoUsuario` (`idEmpleado`),
  UNIQUE KEY `uqUsuarioUsuario` (`nombreUsuario`),
  KEY `idxUsuarioIdEmpleado` (`idEmpleado`),
  CONSTRAINT `Fk_Usuario_Empleado` FOREIGN KEY (`idEmpleado`) REFERENCES `tblempleado` (`idEmpleado`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblusuario`
--

LOCK TABLES `tblusuario` WRITE;
/*!40000 ALTER TABLE `tblusuario` DISABLE KEYS */;
INSERT INTO `tblusuario` VALUES (1,1,'imelendez','$2b$10$e9CQKArQRmpf.IUtqpxYmOoO9vyh2./7ped56qEokwfgn7DkcacPC','2026-09-17 08:07:07',1,'2026-09-17 20:07:07','2026-09-17 20:07:07'),(2,2,'cramirez','$2b$10$ojN1MyPkUaylOuupBEGmhemdx5tQi4BdbbJrpSF2ZJjD0ZWM/lbe2','2026-09-17 08:07:07',1,'2026-09-17 20:07:07','2026-09-17 20:07:07'),(3,3,'mlopez','$2b$10$Bo9RDmJRGKKLxm1tSmRO1ODP0CiGmuqy/wcnJ6bs2MkOVe1OQml5i','2026-09-17 08:07:07',1,'2026-09-17 20:07:07','2026-09-17 20:07:07'),(12,14,'UsuarioExamen','$2a$11$m6Fi2WikM6YW5QbVZikQBuxMCXRfLjnxPleDRY75FLmVjYncKxEc6','2026-09-22 07:12:30',1,'2026-09-22 19:12:30','2026-09-22 19:12:30'),(13,19,'Pcapacitacion','$2a$11$Vee.0P876yc/Mnwy2ePINeGVsQoOLofGZT30VkeJz/B1y3ND7tSAq','2026-09-23 17:43:51',1,'2026-09-24 05:43:51','2026-09-24 05:43:51'),(15,25,'userRRHH','$2b$10$e9CQKArQRmpf.IUtqpxYmOoO9vyh2./7ped56qEokwfgn7DkcacPC','2026-09-17 08:07:07',1,'2026-09-17 20:07:07','2026-09-17 20:07:07'),(16,26,'userbancos','$2b$10$e9CQKArQRmpf.IUtqpxYmOoO9vyh2./7ped56qEokwfgn7DkcacPC','2026-09-17 08:07:07',1,'2026-09-17 20:07:07','2026-09-17 20:07:07'),(17,27,'userventas','$2b$10$e9CQKArQRmpf.IUtqpxYmOoO9vyh2./7ped56qEokwfgn7DkcacPC','2026-09-17 08:07:07',1,'2026-09-17 20:07:07','2026-09-17 20:07:07'),(18,28,'usercompras','$2b$10$e9CQKArQRmpf.IUtqpxYmOoO9vyh2./7ped56qEokwfgn7DkcacPC','2026-09-17 08:07:07',1,'2026-09-17 20:07:07','2026-09-17 20:07:07'),(19,29,'userlogistica','$2b$10$e9CQKArQRmpf.IUtqpxYmOoO9vyh2./7ped56qEokwfgn7DkcacPC','2026-09-17 08:07:07',1,'2026-09-17 20:07:07','2026-09-17 20:07:07'),(20,30,'usercontabilidad','$2b$10$e9CQKArQRmpf.IUtqpxYmOoO9vyh2./7ped56qEokwfgn7DkcacPC','2026-09-17 08:07:07',1,'2026-09-17 20:07:07','2026-09-17 20:07:07'),(21,31,'userauditoria','$2b$10$e9CQKArQRmpf.IUtqpxYmOoO9vyh2./7ped56qEokwfgn7DkcacPC','2026-09-17 08:07:07',1,'2026-09-17 20:07:07','2026-09-17 20:07:07'),(22,32,'UsuarioFinal','$2a$11$DesO3LP/82EcbskUY5pqd.wWuD1Dg3hfFuyj3RN2LKEzrV3uqvZeS','2026-11-24 09:57:45',1,'2026-11-24 15:57:45','2026-11-24 15:57:45');
/*!40000 ALTER TABLE `tblusuario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblusuariomoduloaplicacion`
--

DROP TABLE IF EXISTS `tblusuariomoduloaplicacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblusuariomoduloaplicacion` (
  `idUsuario` int NOT NULL,
  `idModulo` int NOT NULL,
  `idAplicacion` int NOT NULL,
  `derInsertarUsuarioModuloAplicacion` tinyint(1) NOT NULL DEFAULT '0',
  `derEditarUsuarioModuloAplicacion` tinyint(1) NOT NULL DEFAULT '0',
  `derEliminarUsuarioModuloAplicacion` tinyint(1) NOT NULL DEFAULT '0',
  `derImprimirUsuarioModuloAplicacion` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idUsuario`,`idModulo`,`idAplicacion`),
  KEY `idxUsrModAplIdModulo` (`idModulo`),
  KEY `idxUsrModAplIdAplicacion` (`idAplicacion`),
  CONSTRAINT `Fk_UsuarioModuloAplicacion_Aplicacion` FOREIGN KEY (`idAplicacion`) REFERENCES `tblaplicacion` (`idAplicacion`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Fk_UsuarioModuloAplicacion_Modulo` FOREIGN KEY (`idModulo`) REFERENCES `tblmodulo` (`idModulo`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Fk_UsuarioModuloAplicacion_Usuario` FOREIGN KEY (`idUsuario`) REFERENCES `tblusuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblusuariomoduloaplicacion`
--

LOCK TABLES `tblusuariomoduloaplicacion` WRITE;
/*!40000 ALTER TABLE `tblusuariomoduloaplicacion` DISABLE KEYS */;
INSERT INTO `tblusuariomoduloaplicacion` VALUES (1,4,12,1,1,1,1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(1,6000,6000,1,1,1,1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(1,6000,6001,1,1,1,1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(1,6000,6002,1,1,1,1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(1,6000,6003,1,1,1,1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(1,6000,6004,1,1,1,1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(1,6000,6005,1,1,1,1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(1,6000,6006,1,1,1,1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(1,6000,6007,1,1,1,1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(1,6000,6008,1,1,1,1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(1,6000,6009,1,1,1,1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(1,6000,6010,1,1,1,1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(1,6000,6011,1,1,1,1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(1,6000,6012,1,1,1,1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(1,6000,6013,1,1,1,1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(1,6000,6014,1,1,1,1,'2026-11-14 18:34:40','2026-11-14 18:34:40'),(3,7000,3,1,0,0,0,'2026-09-17 20:07:07','2026-09-17 20:07:07'),(13,13,15,0,0,0,0,'2026-09-24 05:49:15','2026-09-24 05:49:15');
/*!40000 ALTER TABLE `tblusuariomoduloaplicacion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblusuariorol`
--

DROP TABLE IF EXISTS `tblusuariorol`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblusuariorol` (
  `idUsuario` int NOT NULL,
  `idRol` int NOT NULL,
  `fechaAsignacionUsuarioRol` date NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idUsuario`,`idRol`),
  KEY `idxUsuarioRolIdRol` (`idRol`),
  CONSTRAINT `Fk_UsuarioRol_Rol` FOREIGN KEY (`idRol`) REFERENCES `tblrol` (`idRol`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Fk_UsuarioRol_Usuario` FOREIGN KEY (`idUsuario`) REFERENCES `tblusuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblusuariorol`
--

LOCK TABLES `tblusuariorol` WRITE;
/*!40000 ALTER TABLE `tblusuariorol` DISABLE KEYS */;
INSERT INTO `tblusuariorol` VALUES (1,1,'2026-09-17','2026-09-17 20:07:07','2026-09-17 20:07:07'),(2,2,'2026-09-17','2026-09-17 20:07:07','2026-09-17 20:07:07'),(3,2,'2026-09-17','2026-09-17 20:09:00','2026-09-17 20:09:00'),(12,12,'2026-09-22','2026-09-22 19:22:32','2026-09-22 19:22:32'),(13,14,'2026-09-23','2026-09-24 05:47:47','2026-09-24 05:47:47'),(15,15,'2026-09-17','2026-09-17 20:07:07','2026-09-17 20:07:07'),(16,16,'2026-09-17','2026-09-17 20:07:07','2026-09-17 20:07:07'),(17,17,'2026-09-17','2026-09-17 20:07:07','2026-09-17 20:07:07'),(18,18,'2026-09-17','2026-09-17 20:07:07','2026-09-17 20:07:07'),(19,20,'2026-09-17','2026-09-17 20:07:07','2026-09-17 20:07:07'),(20,19,'2026-09-17','2026-09-17 20:07:07','2026-09-17 20:07:07'),(21,1,'2026-09-17','2026-09-17 20:07:07','2026-09-17 20:07:07'),(22,1,'2026-11-24','2026-11-24 15:58:07','2026-11-24 15:58:07');
/*!40000 ALTER TABLE `tblusuariorol` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblvacacionempleado`
--

DROP TABLE IF EXISTS `tblvacacionempleado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblvacacionempleado` (
  `idVacacionEmpleado` int NOT NULL AUTO_INCREMENT,
  `idEmpleado` int NOT NULL,
  `idPeriodoVacacion` int NOT NULL,
  `fechaInicioVacacionEmpleado` date NOT NULL,
  `fechaFinVacacionEmpleado` date NOT NULL,
  `diasTomarVacacionEmpleado` decimal(5,2) NOT NULL DEFAULT '0.00',
  `observacionVacacionEmpleado` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `estadoVacacionEmpleado` enum('PENDIENTE','APROBADO','EN CURSO','FINALIZADO','ANULADO') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'PENDIENTE',
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idVacacionEmpleado`),
  KEY `Fk_VacacionEmpleado_Empleado` (`idEmpleado`),
  KEY `Fk_VacacionEmpleado_PeriodoVacacion` (`idPeriodoVacacion`),
  CONSTRAINT `Fk_VacacionEmpleado_Empleado` FOREIGN KEY (`idEmpleado`) REFERENCES `tblempleado` (`idEmpleado`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `Fk_VacacionEmpleado_PeriodoVacacion` FOREIGN KEY (`idPeriodoVacacion`) REFERENCES `tblperiodovacacion` (`idPeriodoVacacion`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `ckVacacionEmpleadoDias` CHECK ((`diasTomarVacacionEmpleado` > 0)),
  CONSTRAINT `ckVacacionEmpleadoFechas` CHECK ((`fechaFinVacacionEmpleado` >= `fechaInicioVacacionEmpleado`))
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblvacacionempleado`
--

LOCK TABLES `tblvacacionempleado` WRITE;
/*!40000 ALTER TABLE `tblvacacionempleado` DISABLE KEYS */;
INSERT INTO `tblvacacionempleado` VALUES (1,20,1,'2026-11-30','2026-12-04',5.00,'Vacaciones de fin de año','PENDIENTE',1,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(2,21,2,'2026-11-23','2026-11-27',5.00,NULL,'APROBADO',1,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(3,22,3,'2026-11-23','2026-11-27',5.00,NULL,'PENDIENTE',1,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(4,23,4,'2026-11-30','2026-12-04',5.00,'Viaje familiar','APROBADO',1,'2026-11-14 18:34:37','2026-11-14 18:34:37'),(5,24,5,'2026-11-09','2026-11-13',5.00,NULL,'APROBADO',1,'2026-11-14 18:34:37','2026-11-14 18:34:37');
/*!40000 ALTER TABLE `tblvacacionempleado` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblvehiculotransporte`
--

DROP TABLE IF EXISTS `tblvehiculotransporte`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblvehiculotransporte` (
  `idVehiculoTransporte` int NOT NULL AUTO_INCREMENT,
  `Fk_Servicio_Transporte_Externo_Codigo` int NOT NULL,
  `placaVehiculoTransporte` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tipoVehiculoTransporte` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `capacidadVehiculoTransporte` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idVehiculoTransporte`),
  UNIQUE KEY `uqVehiculoServicio` (`Fk_Servicio_Transporte_Externo_Codigo`),
  CONSTRAINT `Fk_Vehiculo_Transporte_Servicio_Transporte_Externo` FOREIGN KEY (`Fk_Servicio_Transporte_Externo_Codigo`) REFERENCES `tblserviciotransporteexterno` (`idServicioTransporteExterno`) ON DELETE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblvehiculotransporte`
--

LOCK TABLES `tblvehiculotransporte` WRITE;
/*!40000 ALTER TABLE `tblvehiculotransporte` DISABLE KEYS */;
INSERT INTO `tblvehiculotransporte` VALUES (1,1,'C-728GTF','Camión refrigerado','5 toneladas','2026-11-14 18:34:39','2026-11-14 18:34:39'),(2,2,'C-431NVP','Furgón de reparto','3 toneladas','2026-11-14 18:34:39','2026-11-14 18:34:39'),(3,3,'C-864SLM','Camión de carga','8 toneladas','2026-11-14 18:34:39','2026-11-14 18:34:39'),(4,4,'P-502DRQ','Panel isotérmico','1.5 toneladas','2026-11-14 18:34:39','2026-11-14 18:34:39'),(5,5,'C-319JKA','Camión refrigerado','6 toneladas','2026-11-14 18:34:39','2026-11-14 18:34:39');
/*!40000 ALTER TABLE `tblvehiculotransporte` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tblvendedor`
--

DROP TABLE IF EXISTS `tblvendedor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblvendedor` (
  `idVendedor` int NOT NULL AUTO_INCREMENT,
  `codigoVendedor` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `idEmpleado` int NOT NULL,
  `activoVendedor` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idVendedor`),
  UNIQUE KEY `uqVendedorcodigo` (`codigoVendedor`),
  UNIQUE KEY `uqVendedorEmpleadoCodigo` (`idEmpleado`),
  CONSTRAINT `Fk_Vendedor_Empleado` FOREIGN KEY (`idEmpleado`) REFERENCES `tblempleado` (`idEmpleado`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `ckVendedoractivoVendedorBooleano` CHECK ((`activoVendedor` in (0,1)))
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblvendedor`
--

LOCK TABLES `tblvendedor` WRITE;
/*!40000 ALTER TABLE `tblvendedor` DISABLE KEYS */;
INSERT INTO `tblvendedor` VALUES (1,'FAC-QA-V1',1,1,'2026-11-14 18:34:40','2026-11-14 18:34:40');
/*!40000 ALTER TABLE `tblvendedor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `vwautpagoordendetalle`
--

DROP TABLE IF EXISTS `vwautpagoordendetalle`;
/*!50001 DROP VIEW IF EXISTS `vwautpagoordendetalle`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vwautpagoordendetalle` AS SELECT 
 1 AS `idAutPagoOrden`,
 1 AS `Fk_AutOrdenCompra_Codigo`,
 1 AS `Fk_CuentaBancaria_Codigo`,
 1 AS `Fk_AutDisponibilidadFondos_Codigo`,
 1 AS `montoAsignadoAutPagoOrden`,
 1 AS `estadoAutPagoOrden`,
 1 AS `fechaReservaAutPagoOrden`,
 1 AS `Fk_OrdenPago_Codigo`,
 1 AS `created_at`,
 1 AS `updated_at`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vwbalancecuenta`
--

DROP TABLE IF EXISTS `vwbalancecuenta`;
/*!50001 DROP VIEW IF EXISTS `vwbalancecuenta`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vwbalancecuenta` AS SELECT 
 1 AS `codigoCuenta`,
 1 AS `nombreCuenta`,
 1 AS `tipoCuenta`,
 1 AS `clasificacionCuenta`,
 1 AS `periodoContableSaldo`,
 1 AS `saldoInicialCuenta`,
 1 AS `totalDebeCuenta`,
 1 AS `totalHaberCuenta`,
 1 AS `saldoCuenta`,
 1 AS `estadoSaldo`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vwlibrodiario`
--

DROP TABLE IF EXISTS `vwlibrodiario`;
/*!50001 DROP VIEW IF EXISTS `vwlibrodiario`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vwlibrodiario` AS SELECT 
 1 AS `codigoPoliza`,
 1 AS `fechaPoliza`,
 1 AS `periodoContablePoliza`,
 1 AS `estadoPoliza`,
 1 AS `moduloPoliza`,
 1 AS `lineaDetalle`,
 1 AS `codigoCuenta`,
 1 AS `nombreCuenta`,
 1 AS `tipoCuenta`,
 1 AS `debeDetalle`,
 1 AS `haberDetalle`,
 1 AS `descripcionDetalle`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vwpartidaconsolidadaperiodo`
--

DROP TABLE IF EXISTS `vwpartidaconsolidadaperiodo`;
/*!50001 DROP VIEW IF EXISTS `vwpartidaconsolidadaperiodo`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vwpartidaconsolidadaperiodo` AS SELECT 
 1 AS `idPartidaConsolidada`,
 1 AS `identificadorEmpresaPartidaConsolidada`,
 1 AS `fechaInicioPartidaConsolidada`,
 1 AS `fechaFinPartidaConsolidada`,
 1 AS `conceptoPartidaConsolidada`,
 1 AS `Fk_Moneda_Codigo`,
 1 AS `totalDebePartidaConsolidada`,
 1 AS `totalHaberPartidaConsolidada`,
 1 AS `estadoPartidaConsolidada`,
 1 AS `identificadorUsuarioGeneraPartidaConsolidada`,
 1 AS `fechaGeneracionPartidaConsolidada`,
 1 AS `identificadorUsuarioTrasladaPartidaConsolidada`,
 1 AS `fechaTrasladoPartidaConsolidada`,
 1 AS `claveTrasladoPartidaConsolidada`,
 1 AS `referenciaContabilidadPartidaConsolidada`,
 1 AS `mensajeResultadoTrasladoPartidaConsolidada`,
 1 AS `created_at`,
 1 AS `updated_at`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vwpolizacuadre`
--

DROP TABLE IF EXISTS `vwpolizacuadre`;
/*!50001 DROP VIEW IF EXISTS `vwpolizacuadre`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vwpolizacuadre` AS SELECT 
 1 AS `codigoPoliza`,
 1 AS `fechaPoliza`,
 1 AS `estadoPoliza`,
 1 AS `descripcionPoliza`,
 1 AS `totalLineasPoliza`,
 1 AS `totalDebePoliza`,
 1 AS `totalHaberPoliza`,
 1 AS `diferenciaPoliza`,
 1 AS `resultadoCuadre`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vwpolizaencabezadogeneral`
--

DROP TABLE IF EXISTS `vwpolizaencabezadogeneral`;
/*!50001 DROP VIEW IF EXISTS `vwpolizaencabezadogeneral`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vwpolizaencabezadogeneral` AS SELECT 
 1 AS `idPoliza`,
 1 AS `codigoPoliza`,
 1 AS `fechaPoliza`,
 1 AS `periodoContablePoliza`,
 1 AS `estadoPoliza`,
 1 AS `idModulo`,
 1 AS `moduloPoliza`,
 1 AS `documentoOrigenPoliza`,
 1 AS `descripcionPoliza`,
 1 AS `totalLineasPoliza`,
 1 AS `totalDebePoliza`,
 1 AS `totalHaberPoliza`,
 1 AS `idActualizacionSaldos`,
 1 AS `fechaRegistroPoliza`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vwpolizatraslado`
--

DROP TABLE IF EXISTS `vwpolizatraslado`;
/*!50001 DROP VIEW IF EXISTS `vwpolizatraslado`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vwpolizatraslado` AS SELECT 
 1 AS `moduloOrigen`,
 1 AS `documentoOrigen`,
 1 AS `codigoPoliza`,
 1 AS `fechaPoliza`,
 1 AS `estadoPoliza`,
 1 AS `montoTrasladado`,
 1 AS `fechaTraslado`*/;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `vwautpagoordendetalle`
--

/*!50001 DROP VIEW IF EXISTS `vwautpagoordendetalle`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY INVOKER */
/*!50001 VIEW `vwautpagoordendetalle` AS select `p`.`idAutPagoOrden` AS `idAutPagoOrden`,`d`.`Fk_AutOrdenCompra_Codigo` AS `Fk_AutOrdenCompra_Codigo`,`d`.`Fk_CuentaBancaria_Codigo` AS `Fk_CuentaBancaria_Codigo`,`p`.`Fk_AutDisponibilidadFondos_Codigo` AS `Fk_AutDisponibilidadFondos_Codigo`,`p`.`montoAsignadoAutPagoOrden` AS `montoAsignadoAutPagoOrden`,`p`.`estadoAutPagoOrden` AS `estadoAutPagoOrden`,`p`.`fechaReservaAutPagoOrden` AS `fechaReservaAutPagoOrden`,`p`.`Fk_OrdenPago_Codigo` AS `Fk_OrdenPago_Codigo`,`p`.`created_at` AS `created_at`,`p`.`updated_at` AS `updated_at` from (`tblautpagoorden` `p` join `tblautdisponibilidadfondos` `d` on((`d`.`idAutDisponibilidadFondos` = `p`.`Fk_AutDisponibilidadFondos_Codigo`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vwbalancecuenta`
--

/*!50001 DROP VIEW IF EXISTS `vwbalancecuenta`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vwbalancecuenta` AS select `c`.`codigoCuenta` AS `codigoCuenta`,`c`.`nombreCuenta` AS `nombreCuenta`,`c`.`tipoCuenta` AS `tipoCuenta`,`c`.`clasificacionCuenta` AS `clasificacionCuenta`,`s`.`periodoContableSaldoCuentaPeriodo` AS `periodoContableSaldo`,`s`.`saldoInicialSaldoCuentaPeriodo` AS `saldoInicialCuenta`,`s`.`cargoSaldoCuentaPeriodo` AS `totalDebeCuenta`,`s`.`abonoSaldoCuentaPeriodo` AS `totalHaberCuenta`,`s`.`saldoFinalSaldoCuentaPeriodo` AS `saldoCuenta`,`s`.`estadoSaldoCuentaPeriodo` AS `estadoSaldo` from (`tblsaldocuentaperiodo` `s` join `tblcuenta` `c` on((`c`.`idCuenta` = `s`.`idCuenta`))) where ((`s`.`is_active` = true) and (`c`.`is_active` = true)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vwlibrodiario`
--

/*!50001 DROP VIEW IF EXISTS `vwlibrodiario`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vwlibrodiario` AS select `pe`.`codigoPolizaEncabezado` AS `codigoPoliza`,`pe`.`fechaPolizaEncabezado` AS `fechaPoliza`,`pe`.`periodoContablePolizaEncabezado` AS `periodoContablePoliza`,`pe`.`estadoPolizaEncabezado` AS `estadoPoliza`,`m`.`nombreModuloContable` AS `moduloPoliza`,`pd`.`lineaPolizaDetalle` AS `lineaDetalle`,`c`.`codigoCuenta` AS `codigoCuenta`,`c`.`nombreCuenta` AS `nombreCuenta`,`c`.`tipoCuenta` AS `tipoCuenta`,`pd`.`debePolizaDetalle` AS `debeDetalle`,`pd`.`haberPolizaDetalle` AS `haberDetalle`,`pd`.`descripcionPolizaDetalle` AS `descripcionDetalle` from (((`tblpolizadetalle` `pd` join `tblpolizaencabezado` `pe` on((`pe`.`idPolizaEncabezado` = `pd`.`idPolizaEncabezado`))) join `tblcuenta` `c` on((`c`.`idCuenta` = `pd`.`idCuenta`))) join `tblmodulocontable` `m` on((`m`.`idModuloContable` = `pe`.`idModuloContable`))) where ((`pd`.`is_active` = true) and (`pe`.`is_active` = true)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vwpartidaconsolidadaperiodo`
--

/*!50001 DROP VIEW IF EXISTS `vwpartidaconsolidadaperiodo`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY INVOKER */
/*!50001 VIEW `vwpartidaconsolidadaperiodo` AS select `p`.`Pk_PartidaConsolidada` AS `idPartidaConsolidada`,`p`.`identificadorEmpresaPartidaConsolidada` AS `identificadorEmpresaPartidaConsolidada`,`p`.`fechaInicioPartidaConsolidada` AS `fechaInicioPartidaConsolidada`,last_day(`p`.`fechaInicioPartidaConsolidada`) AS `fechaFinPartidaConsolidada`,`p`.`conceptoPartidaConsolidada` AS `conceptoPartidaConsolidada`,`p`.`Fk_Moneda_Codigo` AS `Fk_Moneda_Codigo`,`p`.`totalDebePartidaConsolidada` AS `totalDebePartidaConsolidada`,`p`.`totalHaberPartidaConsolidada` AS `totalHaberPartidaConsolidada`,`p`.`estadoPartidaConsolidada` AS `estadoPartidaConsolidada`,`p`.`identificadorUsuarioGeneraPartidaConsolidada` AS `identificadorUsuarioGeneraPartidaConsolidada`,`p`.`fechaGeneracionPartidaConsolidada` AS `fechaGeneracionPartidaConsolidada`,`p`.`identificadorUsuarioTrasladaPartidaConsolidada` AS `identificadorUsuarioTrasladaPartidaConsolidada`,`p`.`fechaTrasladoPartidaConsolidada` AS `fechaTrasladoPartidaConsolidada`,`p`.`claveTrasladoPartidaConsolidada` AS `claveTrasladoPartidaConsolidada`,`p`.`referenciaContabilidadPartidaConsolidada` AS `referenciaContabilidadPartidaConsolidada`,`p`.`mensajeResultadoTrasladoPartidaConsolidada` AS `mensajeResultadoTrasladoPartidaConsolidada`,`p`.`created_at` AS `created_at`,`p`.`updated_at` AS `updated_at` from `tblpartidaconsolidada` `p` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vwpolizacuadre`
--

/*!50001 DROP VIEW IF EXISTS `vwpolizacuadre`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vwpolizacuadre` AS select `pe`.`codigoPolizaEncabezado` AS `codigoPoliza`,`pe`.`fechaPolizaEncabezado` AS `fechaPoliza`,`pe`.`estadoPolizaEncabezado` AS `estadoPoliza`,`pe`.`descripcionPolizaEncabezado` AS `descripcionPoliza`,count(`pd`.`idPolizaDetalle`) AS `totalLineasPoliza`,sum(`pd`.`debePolizaDetalle`) AS `totalDebePoliza`,sum(`pd`.`haberPolizaDetalle`) AS `totalHaberPoliza`,(sum(`pd`.`debePolizaDetalle`) - sum(`pd`.`haberPolizaDetalle`)) AS `diferenciaPoliza`,(case when (sum(`pd`.`debePolizaDetalle`) = sum(`pd`.`haberPolizaDetalle`)) then 'CUADRADA' else 'DESCUADRADA' end) AS `resultadoCuadre` from (`tblpolizaencabezado` `pe` join `tblpolizadetalle` `pd` on((`pd`.`idPolizaEncabezado` = `pe`.`idPolizaEncabezado`))) where ((`pe`.`is_active` = true) and (`pd`.`is_active` = true)) group by `pe`.`idPolizaEncabezado`,`pe`.`codigoPolizaEncabezado`,`pe`.`fechaPolizaEncabezado`,`pe`.`estadoPolizaEncabezado`,`pe`.`descripcionPolizaEncabezado` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vwpolizaencabezadogeneral`
--

/*!50001 DROP VIEW IF EXISTS `vwpolizaencabezadogeneral`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vwpolizaencabezadogeneral` AS select `pe`.`idPolizaEncabezado` AS `idPoliza`,`pe`.`codigoPolizaEncabezado` AS `codigoPoliza`,`pe`.`fechaPolizaEncabezado` AS `fechaPoliza`,`pe`.`periodoContablePolizaEncabezado` AS `periodoContablePoliza`,`pe`.`estadoPolizaEncabezado` AS `estadoPoliza`,`m`.`idModuloContable` AS `idModulo`,`m`.`nombreModuloContable` AS `moduloPoliza`,`pe`.`documentoOrigenPolizaEncabezado` AS `documentoOrigenPoliza`,`pe`.`descripcionPolizaEncabezado` AS `descripcionPoliza`,count(`pd`.`idPolizaDetalle`) AS `totalLineasPoliza`,ifnull(sum(`pd`.`debePolizaDetalle`),0) AS `totalDebePoliza`,ifnull(sum(`pd`.`haberPolizaDetalle`),0) AS `totalHaberPoliza`,`pe`.`idActualizacionSaldos` AS `idActualizacionSaldos`,`pe`.`created_at` AS `fechaRegistroPoliza` from ((`tblpolizaencabezado` `pe` join `tblmodulocontable` `m` on((`m`.`idModuloContable` = `pe`.`idModuloContable`))) left join `tblpolizadetalle` `pd` on(((`pd`.`idPolizaEncabezado` = `pe`.`idPolizaEncabezado`) and (`pd`.`is_active` = true)))) where (`pe`.`is_active` = true) group by `pe`.`idPolizaEncabezado`,`pe`.`codigoPolizaEncabezado`,`pe`.`fechaPolizaEncabezado`,`pe`.`periodoContablePolizaEncabezado`,`pe`.`estadoPolizaEncabezado`,`m`.`idModuloContable`,`m`.`nombreModuloContable`,`pe`.`documentoOrigenPolizaEncabezado`,`pe`.`descripcionPolizaEncabezado`,`pe`.`idActualizacionSaldos`,`pe`.`created_at` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vwpolizatraslado`
--

/*!50001 DROP VIEW IF EXISTS `vwpolizatraslado`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vwpolizatraslado` AS select `m`.`nombreModuloContable` AS `moduloOrigen`,`pe`.`documentoOrigenPolizaEncabezado` AS `documentoOrigen`,`pe`.`codigoPolizaEncabezado` AS `codigoPoliza`,`pe`.`fechaPolizaEncabezado` AS `fechaPoliza`,`pe`.`estadoPolizaEncabezado` AS `estadoPoliza`,sum(`pd`.`debePolizaDetalle`) AS `montoTrasladado`,`pe`.`created_at` AS `fechaTraslado` from ((`tblpolizaencabezado` `pe` join `tblmodulocontable` `m` on((`m`.`idModuloContable` = `pe`.`idModuloContable`))) join `tblpolizadetalle` `pd` on((`pd`.`idPolizaEncabezado` = `pe`.`idPolizaEncabezado`))) where (`pe`.`documentoOrigenPolizaEncabezado` is not null) group by `pe`.`idPolizaEncabezado`,`m`.`nombreModuloContable`,`pe`.`documentoOrigenPolizaEncabezado`,`pe`.`codigoPolizaEncabezado`,`pe`.`fechaPolizaEncabezado`,`pe`.`estadoPolizaEncabezado`,`pe`.`created_at` */;
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

-- Dump completed on 2026-11-24 10:28:25
