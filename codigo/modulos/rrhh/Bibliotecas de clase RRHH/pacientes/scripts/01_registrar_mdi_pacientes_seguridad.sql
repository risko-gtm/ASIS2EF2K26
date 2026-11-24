-- ============================================================================
-- Registro del MDI de Pacientes en el componente de Seguridad
-- Base principal: dbsistemaembutidos
-- Motor: MySQL 8.x
--
-- Este script registra el modulo, sus aplicaciones iniciales y otorga permisos
-- totales al perfil Administrador. No crea aun las tablas funcionales de
-- pacientes; esas deben formar parte del script propio del nuevo modulo.
-- ============================================================================

USE dbsistemaembutidos;
SET NAMES utf8mb4;

START TRANSACTION;

-- Bloque reservado para el nuevo modulo:
--   11000 = MDI principal
--   11001 = mantenimiento de pacientes
INSERT INTO tblmodulo
    (idModulo, nombreModulo, descripcionModulo, is_active)
VALUES
    (11000, 'Pacientes',
     'Modulo para la administracion y seguimiento de pacientes', 1) AS nuevo
ON DUPLICATE KEY UPDATE
    nombreModulo      = nuevo.nombreModulo,
    descripcionModulo = nuevo.descripcionModulo,
    is_active         = 1;

INSERT INTO tblaplicacion
    (idAplicacion, idModulo, nombreAplicacion, descripcionAplicacion, is_active)
VALUES
    (11000, 11000, 'MDI Pacientes',
     'Pantalla principal del modulo de Pacientes', 1),
    (11001, 11000, 'Pacientes',
     'Mantenimiento de pacientes: ingreso, consulta, modificacion, eliminacion y reporte', 1)
    AS nuevo
ON DUPLICATE KEY UPDATE
    idModulo              = nuevo.idModulo,
    nombreAplicacion      = nuevo.nombreAplicacion,
    descripcionAplicacion = nuevo.descripcionAplicacion,
    is_active             = 1;

-- Permisos completos para el perfil Administrador.
-- Se localiza el perfil por nombre para no depender de que siempre sea idRol=1.
INSERT INTO tblrolmoduloaplicacion
    (idRol, idModulo, idAplicacion,
     derInsertarRolModuloAplicacion,
     derEditarRolModuloAplicacion,
     derEliminarRolModuloAplicacion,
     derImprimirRolModuloAplicacion)
SELECT
    r.idRol,
    a.idModulo,
    a.idAplicacion,
    1, 1, 1, 1
FROM tblrol r
INNER JOIN tblaplicacion a
    ON a.idModulo = 11000
WHERE r.nombreRol = 'Administrador'
  AND r.is_active = 1
ON DUPLICATE KEY UPDATE
    derInsertarRolModuloAplicacion  = 1,
    derEditarRolModuloAplicacion   = 1,
    derEliminarRolModuloAplicacion = 1,
    derImprimirRolModuloAplicacion = 1;

COMMIT;

-- Verificacion del registro y de los permisos administrativos.
SELECT
    m.idModulo,
    m.nombreModulo,
    a.idAplicacion,
    a.nombreAplicacion,
    a.is_active
FROM tblmodulo m
INNER JOIN tblaplicacion a
    ON a.idModulo = m.idModulo
WHERE m.idModulo = 11000
ORDER BY a.idAplicacion;

SELECT
    r.nombreRol,
    p.idModulo,
    p.idAplicacion,
    p.derInsertarRolModuloAplicacion,
    p.derEditarRolModuloAplicacion,
    p.derEliminarRolModuloAplicacion,
    p.derImprimirRolModuloAplicacion
FROM tblrolmoduloaplicacion p
INNER JOIN tblrol r
    ON r.idRol = p.idRol
WHERE p.idModulo = 11000
  AND r.nombreRol = 'Administrador'
ORDER BY p.idAplicacion;
