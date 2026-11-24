-- ==================================================================
-- Área : Contabilidad
-- Autor : Oskar Cermeño
-- Carné : 0901-23-15379
-- Fecha : 24/11/2026
-- ==================================================================
-- Propósito :
--  Registra la aplicación 10016 Mantenimiento de pacientes, sus
--  permisos para el rol Administrador y el reporte de pacientes.
-- Reglas especificas:
--  La ruta del reporte es la del repositorio en esta computadora.
-- ==================================================================

USE dbsistemaembutidos;

INSERT IGNORE INTO tblaplicacion (idAplicacion, idModulo, nombreAplicacion, descripcionAplicacion, is_active)
VALUES (10016, 10000, 'Mantenimiento de pacientes', '10016 - Mantenimiento de pacientes con Navegador', 1);

INSERT IGNORE INTO tblrolmoduloaplicacion (idRol, idModulo, idAplicacion, derInsertarRolModuloAplicacion,
    derEditarRolModuloAplicacion, derEliminarRolModuloAplicacion, derImprimirRolModuloAplicacion)
VALUES (1, 10000, 10016, 1, 1, 1, 1);

INSERT IGNORE INTO tblReporte (numeroReporte, nombreReporte, rutaReporte, fechaReporte)
VALUES (1, 'Reporte de pacientes', 'C:\\Users\\oskar\\Desktop\\ASIS2EF2K26\\codigo\\modulos\\contabilidad\\Bibliotecas de Contabilidad\\Contabilidad\\CapaVista_Contabilidad\\Reportes\\RpReportePacientes.rdlc', CURDATE());

INSERT IGNORE INTO tblAplicacionReporte (idAplicacion, numeroReporte)
VALUES (10016, 1);
