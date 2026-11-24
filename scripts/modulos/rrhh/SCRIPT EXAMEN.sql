use dbSistemaembutidos;

create table if not exists tbl_paciente( 
pk_idPaciente int not null, 
nombrePaciente varchar(50), 
apellidoPaciente varchar(50), 
fechaNacimientoPaciente date, 
sexoPaciente varchar(15), 
direccionPaciente varchar(30), 
telefonoPaciente varchar(20),
estadoPaciente int );

ALTER TABLE tbl_paciente
ADD PRIMARY KEY (pk_idPaciente);

create table if not exists tbl_Cliente(
pk_idCliente int not null,
nombreCliente varchar(50),
direccionCliente varchar(30),
telefonoCliente varchar(20),
estadoCliente int );
ALTER TABLE tbl_Cliente
ADD PRIMARY KEY (pk_idCliente);


INSERT INTO tblReporte (numeroReporte, nombreReporte, rutaReporte, fechaReporte)
VALUES (9151, 'Reporte de Clientes',
        'CapaVista_Mantenimiento2k26.Reportes.RpReporteCliente.rdlc',
        CURDATE());

INSERT INTO tblAplicacionReporte (idAplicacion, numeroReporte)
VALUES (9151, 9151);
