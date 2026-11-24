USE dbsistemaembutidos;

-- Registro inicial para el módulo 7200.
-- Estos IDs de aplicación deben coincidir con los de los formularios.
-- La aplicación 7201 ya existe en el módulo y se reutiliza para Clientes.
SET @ruta_reportes = 'C:/proyectoasis22k26/codigo/modulos/prueba/Prueba/CapaVista_Prueba/Reportes/';

START TRANSACTION;

INSERT INTO tblaplicacion (idAplicacion, idModulo, nombreAplicacion, descripcionAplicacion, is_active)
VALUES
    (7202, 7200, 'Productos', 'Mantenimiento de productos del módulo de prueba', 1),
    (7203, 7200, 'Vendedores', 'Mantenimiento de vendedores del módulo de prueba', 1);

INSERT INTO tblReporte (numeroReporte, nombreReporte, rutaReporte, fechaReporte)
VALUES
    (7201, 'Pruebas - Clientes', CONCAT(@ruta_reportes, 'Clientes.rdlc'), CURRENT_DATE),
    (7202, 'Pruebas - Productos', CONCAT(@ruta_reportes, 'Productos.rdlc'), CURRENT_DATE),
    (7203, 'Pruebas - Vendedores', CONCAT(@ruta_reportes, 'Vendedores.rdlc'), CURRENT_DATE);

INSERT INTO tblAplicacionReporte (idAplicacion, numeroReporte)
VALUES (7201, 7201), (7202, 7202), (7203, 7203);

COMMIT;

SELECT a.idAplicacion, a.nombreAplicacion, r.numeroReporte, r.rutaReporte
FROM tblaplicacion AS a
JOIN tblAplicacionReporte AS ar ON ar.idAplicacion = a.idAplicacion
JOIN tblReporte AS r ON r.numeroReporte = ar.numeroReporte
WHERE a.idModulo = 7200 AND a.idAplicacion IN (7201, 7202, 7203)
ORDER BY a.idAplicacion;

-- Si administras los permisos por SQL, asigna el ID del rol autorizado y
-- ejecuta este bloque aparte. También puedes conceder Imprimir desde Seguridad.
-- SET @id_rol = ...;
-- INSERT INTO tblrolmoduloaplicacion
--     (idRol, idModulo, idAplicacion, derImprimirRolModuloAplicacion)
-- VALUES
--     (@id_rol, 7200, 7201, 1),
--     (@id_rol, 7200, 7202, 1),
--     (@id_rol, 7200, 7203, 1)
-- ON DUPLICATE KEY UPDATE derImprimirRolModuloAplicacion = 1;
