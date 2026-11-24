use dbsistemaembutidos;

create table if not exists tbl_cliente(
	pk_idCliente int not null,
    nombreCliente varchar(50),
    direccionCliente varchar(30), 
    telefonoCliente varchar(20), 
    estadoCliente int
);

select * from tbl_cliente;
select * from tblbitacora;