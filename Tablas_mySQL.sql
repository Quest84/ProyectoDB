# tabla tipo certificado
/*CREATE TABLE tipo_certificado(
id_tipo varchar(2) NOT NULL PRIMARY KEY,
nombre varchar (35),
precio int
);*/
#tabla certificado
CREATE TABLE certificados(
id_certificado varchar(20) NOT NULL PRIMARY KEY,
num_control varchar(13) NOT NULL,
id_tipo_certificado int,
id_pago int,
CONSTRAINT alumno_certificado FOREIGN KEY(num_control) REFERENCES alumnos (num_control)
ON DELETE CASCADE
ON UPDATE CASCADE,
CONSTRAINT tipo_certificado FOREIGN KEY(id_tipo_certificado) REFERENCES tipo(id_tipo)
ON DELETE CASCADE
ON UPDATE CASCADE,
CONSTRAINT pago_certificado FOREIGN KEY(id_pago) REFERENCES Pagos(id_pago)
ON DELETE CASCADE
ON UPDATE CASCADE
);
# tabla de alumnos 
CREATE TABLE alumnos(
num_control varchar(13) NOT NULL PRIMARY KEY,
id_persona int,
constraint per_alu FOREIGN KEY (id_persona) REFERENCES persona(id_persona)
ON DELETE CASCADE
ON UPDATE CASCADE
);

# tabla unidades
CREATE TABLE unidades(
id_unidad varchar(10) NOT NULL PRIMARY KEY,
num_unidad tinyint,
descripcion varchar(50),
clave_materia int,
CONSTRAINT materia_unidades FOREIGN KEY(clave_materia) REFERENCES materias(clave_materia)
ON DELETE CASCADE
ON UPDATE CASCADE
);

# tabla persona
CREATE TABLE persona(
	id_persona int NOT NULL,
	nombre varchar(30),
	apellido_paterno varchar(40),
	apellido_materno varchar(40),
	curp varchar(18),
	sexo char,
	estado varchar(50) DEFAULT 'Estado de México' NOT NULL,
	telefono long,
	correo varchar(13),
	codigo_postal varchar(5),
	municipio varchar(50),
	localidad varchar(50),
	colonia varchar(50),
	calle varchar(50),
	CONSTRAINT pk_id_persona PRIMARY KEY(id_persona)
);

# tabla opcion
CREATE TABLE opcion(
	id_opcion int not null, 
	nombre_opcion varchar(50) not null,
	descripcion varchar(50) not null, 
	CONSTRAINT id_opcion_pk primary key(id_opcion)
);

# Tabla Inscripciones
CREATE TABLE Inscripciones(
	id_inscripcion int,
	id_cargaAcad int,
	num_control varchar(30),
	PRIMARY KEY (id_inscripcion),
	CONSTRAINT fk_carga_inscr FOREIGN KEY (id_cargaAcad) REFERENCES CargaAcademica (id_cargaAcad),
	CONSTRAINT fk_ncontr_inscr FOREIGN KEY (num_control) REFERENCES alumnos (num_control),
	ON DELETE CASCADE
);

# Test mySQL


#tabla docente en MySQL
create table Docente (
Id_docente int not null auto_increment,
Cedula varchar(20) not null,
Grado_academico varchar(30) not null,
Especialidad varchar(30) not null,
Num_seguro_social varchar(11) not null,
Id_persona int not null,
primary key (Id_docente)
);

#TABLA GRUPO EN MySQL
CREATE TABLE `grupo` (
 `Id_Grupo` int NOT NULL AUTO_INCREMENT,
  `Edificio` varchar(20) NOT NULL,
  `Num_Grupo` varchar(10) NOT NULL,
  PRIMARY KEY (`Id_Grupo`)
	
#TABLA EXAMEN EN MySQL
	create table examen(
ID_EXAMEN INT NOT NULL 
, HORARIO time 
, FECHA DATE 
, LUGAR_APLICACION VARCHAR(30) 
, ID_PAGO INT 
, NUM_FOLIO_PRE INT 
, CONSTRAINT EXAMEN_PK PRIMARY KEY 
  (
    ID_EXAMEN 
  )
);


