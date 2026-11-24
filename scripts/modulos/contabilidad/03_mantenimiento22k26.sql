use  dbsistemaembutidos;

create table if not exists tbl_vendedor(
pk_idVendedor int not null,
nombreVendedor varchar(50),
direccionVendedor varchar(30),
telefonoVendedor varchar(20),
estadoVendedor int );