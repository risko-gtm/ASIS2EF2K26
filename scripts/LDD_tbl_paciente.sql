/*
 * ==================================================================
 * Área      : Recursos Humanos - Examen Final
 * Autor     : Byron Alexander Chiquito Paredes - 0901-23-3747
 * Fecha     : 24/11/2026
 * ==================================================================
 * Propósito : LDD de la tabla tbl_paciente
 * ==================================================================
 */
USE `asis22k26`;

CREATE TABLE IF NOT EXISTS `tbl_paciente` (
  `pk_idPaciente`          INT NOT NULL AUTO_INCREMENT,
  `nombrePaciente`         VARCHAR(50) NOT NULL,
  `apellidoPaciente`       VARCHAR(50) NOT NULL,
  `fechaNacimientoPaciente` DATE NOT NULL,
  `sexoPaciente`           VARCHAR(15) NOT NULL,
  `direccionPaciente`      VARCHAR(30) NOT NULL,
  `telefonoPaciente`       VARCHAR(20) NOT NULL,
  `estadoPaciente`         INT NOT NULL DEFAULT 1,
  PRIMARY KEY (`pk_idPaciente`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT IGNORE INTO `tblaplicacion` (`idAplicacion`,`idModulo`,`nombreAplicacion`,`descripcionAplicacion`,`is_active`)
VALUES (9007, 9000, 'Pacientes', 'Catálogo de pacientes', 1);

INSERT IGNORE INTO `tblrolmoduloaplicacion`
  (`idRol`,`idModulo`,`idAplicacion`,`derInsertarRolModuloAplicacion`,`derEditarRolModuloAplicacion`,`derEliminarRolModuloAplicacion`,`derImprimirRolModuloAplicacion`)
VALUES (1, 9000, 9007, 1, 1, 1, 1),
       (15, 9000, 9007, 1, 1, 1, 1);
