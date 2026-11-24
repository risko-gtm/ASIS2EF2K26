USE dbsistemaembutidos;

CREATE TABLE IF NOT EXISTS tbl_paciente (
    pk_idPaciente INT NOT NULL AUTO_INCREMENT,
    nombrePaciente VARCHAR(50),
    apellidoPaciente VARCHAR(50),
    fechaNacimientoPaciente DATE,
    sexoPaciente VARCHAR(15),
    direccionPaciente VARCHAR(30),
    telefonoPaciente VARCHAR(20),
    estadoPaciente INT,
    PRIMARY KEY (pk_idPaciente)
) ENGINE=InnoDB;


USE dbsistemaembutidos;

INSERT INTO tblmodulo (nombreModulo, descripcionModulo, is_active)
SELECT 'Bancos', 'Módulo bancario del sistema', 1
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM tblmodulo WHERE nombreModulo = 'Bancos');

INSERT INTO tblaplicacion (idAplicacion, idModulo, nombreAplicacion, descripcionAplicacion, is_active)
SELECT 8010, idModulo, 'Pacientes', 'Mantenimiento de pacientes', 1
FROM tblmodulo
WHERE nombreModulo = 'Bancos'
ON DUPLICATE KEY UPDATE nombreAplicacion = VALUES(nombreAplicacion);

INSERT INTO tblusuariomoduloaplicacion
    (idUsuario, idModulo, idAplicacion, derInsertarUsuarioModuloAplicacion, derEditarUsuarioModuloAplicacion, derEliminarUsuarioModuloAplicacion, derImprimirUsuarioModuloAplicacion)
SELECT u.idUsuario, a.idModulo, a.idAplicacion, 1, 1, 1, 1
FROM tblusuario u
INNER JOIN tblaplicacion a ON a.idAplicacion = 8010
WHERE u.nombreUsuario = 'usuariofinal'
ON DUPLICATE KEY UPDATE
    derInsertarUsuarioModuloAplicacion = 1,
    derEditarUsuarioModuloAplicacion = 1,
    derEliminarUsuarioModuloAplicacion = 1,
    derImprimirUsuarioModuloAplicacion = 1;

INSERT INTO tblusuariomoduloaplicacion
    (idUsuario, idModulo, idAplicacion, derInsertarUsuarioModuloAplicacion, derEditarUsuarioModuloAplicacion, derEliminarUsuarioModuloAplicacion, derImprimirUsuarioModuloAplicacion)
SELECT u.idUsuario, a.idModulo, a.idAplicacion, 0, 0, 0, 1
FROM tblusuario u
INNER JOIN tblmodulo m ON m.nombreModulo = 'Seguridad'
INNER JOIN tblaplicacion a ON a.idModulo = m.idModulo AND a.nombreAplicacion = 'Bitácora'
WHERE u.nombreUsuario = 'usuariofinal'
ON DUPLICATE KEY UPDATE
    derImprimirUsuarioModuloAplicacion = 1;