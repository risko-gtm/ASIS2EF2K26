create table if not exists tbl_Vendedor( 
pk_idVendedor int not null, 
nombreVendedor varchar(50) not null, 
direccionVendedor varchar(30) not null , 
telefonoVendedor varchar(20) not null , 
estadoVendedor int not null,
is_active BOOLEAN NOT NULL DEFAULT TRUE,
created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
CONSTRAINT Pk_Vendedor PRIMARY KEY (PK_idVendedor) )  Engine=InnoDB;
