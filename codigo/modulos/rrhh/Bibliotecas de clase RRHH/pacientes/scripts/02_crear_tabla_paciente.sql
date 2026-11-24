-- Ejecutar en la misma base utilizada por el DSN del Navegador.
USE dbsistemaembutidos;

-- Si ya existe, revisar su estructura antes de usar el mantenimiento.
CREATE TABLE IF NOT EXISTS tblpaciente (
    idPaciente INT NOT NULL AUTO_INCREMENT,
    nombrePaciente VARCHAR(50) NOT NULL,
    apellidoPaciente VARCHAR(50) NOT NULL,
    fechaNacimientoPaciente DATE NOT NULL,
    sexoPaciente VARCHAR(15) NOT NULL,
    direccionPaciente VARCHAR(30) NOT NULL,
    telefonoPaciente VARCHAR(20) NOT NULL,
    estadoPaciente INT NOT NULL DEFAULT 1,
    PRIMARY KEY (idPaciente)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DESCRIBE tblpaciente;
