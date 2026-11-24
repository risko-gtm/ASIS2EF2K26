-- ==================================================================
-- Área : Contabilidad
-- Autor : Oskar Cermeño
-- Carné : 0901-23-15379
-- Fecha : 24/11/2026
-- ==================================================================
-- Propósito :
--  LDD de la tabla tbl_paciente para el mantenimiento de pacientes.
-- Reglas especificas:
--  El Navegador necesita la llave primaria pk_idPaciente.
-- ==================================================================

USE dbsistemaembutidos;

DROP TABLE IF EXISTS tbl_paciente;

CREATE TABLE tbl_paciente (
    pk_idPaciente INT NOT NULL,
    nombrePaciente VARCHAR(50),
    apellidoPaciente VARCHAR(50),
    fechaNacimientoPaciente DATE,
    sexoPaciente VARCHAR(15),
    direccionPaciente VARCHAR(30),
    telefonoPaciente VARCHAR(20),
    estadoPaciente INT,
    PRIMARY KEY (pk_idPaciente)
);
