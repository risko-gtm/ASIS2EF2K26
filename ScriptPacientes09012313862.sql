create table if not exists tblPaciente(
 idPaciennte  int not null primary key,
 nombrePaciente varchar(50),
 apellidoPaciente varchar(50),
 fechaNacimientoPaciente date,
 sexoPaciente varchar(15),
 direccionPaciente varchar(30),
 telefonoPaciente varchar(20),
 estadoPaciente  tinyint(1) NOT NULL DEFAULT '1'
 );