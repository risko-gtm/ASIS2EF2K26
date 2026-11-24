-- ============================================================================
-- Área: Bancos | Examen final Serie IV
-- Autor: Victor Josue Ortiz Samayoa | Carné: 0901-23-3424
-- Fecha: 24/11/2026
-- Objetivo: crear el catálogo de vendedores, registrar la aplicación 8014
--           y preparar el usuario usuariofinal con acceso a Seguridad y Bancos.
-- Requiere: DSN ODBC asis22k26 apuntando a dbsistemaembutidos.
-- ============================================================================

USE dbsistemaembutidos;

CREATE TABLE IF NOT EXISTS tbl_vendedor (
    pk_idVendedor INT NOT NULL,
    nombreVendedor VARCHAR(50),
    direccionVendedor VARCHAR(30),
    telefonoVendedor VARCHAR(20),
    estadoVendedor INT,
    PRIMARY KEY (pk_idVendedor)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- El Navegador valida permisos y escribe INSERT, UPDATE y DELETE en tblbitacora.
INSERT INTO tblmodulo (idModulo, nombreModulo, descripcionModulo, is_active)
VALUES (8000, 'Bancos', 'Módulo bancario del sistema Embutidos de Calidad.', 1)
ON DUPLICATE KEY UPDATE
    nombreModulo = VALUES(nombreModulo),
    descripcionModulo = VALUES(descripcionModulo),
    is_active = VALUES(is_active);

INSERT INTO tblaplicacion (idAplicacion, idModulo, nombreAplicacion, descripcionAplicacion, is_active)
VALUES (8014, 8000, 'Vendedores', 'Mantenimiento de vendedores del módulo Bancos.', 1)
ON DUPLICATE KEY UPDATE
    idModulo = VALUES(idModulo),
    nombreAplicacion = VALUES(nombreAplicacion),
    descripcionAplicacion = VALUES(descripcionAplicacion),
    is_active = VALUES(is_active);

INSERT INTO tblrol (nombreRol, descripcionRol, is_active)
VALUES ('PerfilExamenBancos', 'Acceso al catálogo de vendedores y a la bitácora de seguridad.', 1)
ON DUPLICATE KEY UPDATE
    descripcionRol = VALUES(descripcionRol),
    is_active = VALUES(is_active);

SET @rol_examen_bancos = (
    SELECT idRol FROM tblrol WHERE nombreRol = 'PerfilExamenBancos' LIMIT 1
);

INSERT INTO tblempleado (
    codigoEmpleado, dpiEmpleado, nitEmpleado, nombresEmpleado, apellidosEmpleado,
    puestoEmpleado, generoEmpleado, fechaNacimientoEmpleado, fechaContratacionEmpleado,
    telefonoEmpleado, correoEmpleado, is_active
)
SELECT
    'EMP-FINAL-3424', '0000000000000', '0000000-0', 'Usuario', 'Final',
    'Operador de examen', 'M', '2000-01-01', CURDATE(),
    '00000000', 'usuariofinal@embutidos.local', 1
WHERE NOT EXISTS (
    SELECT 1 FROM tblempleado WHERE codigoEmpleado = 'EMP-FINAL-3424'
);

SET @empleado_final = (
    SELECT idEmpleado FROM tblempleado WHERE codigoEmpleado = 'EMP-FINAL-3424' LIMIT 1
);

-- Contraseña de usuariofinal: Final2026!
-- El valor se genera con BCrypt, igual que el componente Seguridad.
INSERT INTO tblusuario (
    idEmpleado, nombreUsuario, contrasenaUsuario, ultimoAccesoUsuario, is_active
)
SELECT
    @empleado_final, 'usuariofinal',
    '$2a$11$O0rLGGa2SNXitcesDWoo3uUyc29sNONLOiCC2AggsIYyAE5NMP74a',
    NOW(), 1
WHERE NOT EXISTS (
    SELECT 1 FROM tblusuario WHERE nombreUsuario = 'usuariofinal'
);

SET @usuario_final = (
    SELECT idUsuario FROM tblusuario WHERE nombreUsuario = 'usuariofinal' LIMIT 1
);

INSERT INTO tblusuariorol (idUsuario, idRol, fechaAsignacionUsuarioRol)
VALUES (@usuario_final, @rol_examen_bancos, CURDATE())
ON DUPLICATE KEY UPDATE fechaAsignacionUsuarioRol = VALUES(fechaAsignacionUsuarioRol);

-- Seguridad: Bitácora (aplicación 12). Bancos: Vendedores (aplicación 8014).
INSERT INTO tblrolmoduloaplicacion (
    idRol, idModulo, idAplicacion,
    derInsertarRolModuloAplicacion, derEditarRolModuloAplicacion,
    derEliminarRolModuloAplicacion, derImprimirRolModuloAplicacion
)
VALUES
    (@rol_examen_bancos, 4, 12, 0, 0, 0, 1),
    (@rol_examen_bancos, 8000, 8014, 1, 1, 1, 1)
ON DUPLICATE KEY UPDATE
    derInsertarRolModuloAplicacion = VALUES(derInsertarRolModuloAplicacion),
    derEditarRolModuloAplicacion = VALUES(derEditarRolModuloAplicacion),
    derEliminarRolModuloAplicacion = VALUES(derEliminarRolModuloAplicacion),
    derImprimirRolModuloAplicacion = VALUES(derImprimirRolModuloAplicacion);

-- Guion para la evidencia: realice estas acciones desde el formulario Vendedores,
-- no por SQL, para que el Navegador las registre en tblbitacora.
-- 1) Ingrese tres vendedores con IDs 1, 2 y 3.
-- 2) Modifique el vendedor con ID 2.
-- 3) Elimine el vendedor con ID 3.
