# tabla tipo certificado
CREATE TABLE tipo_certificado(
id_tipo varchar(2) NOT NULL PRIMARY KEY,
nombre varchar (35),
precio int
);
#tabla certificado
CREATE TABLE certificados(
id_certificado varchar(20) NOT NULL PRIMARY KEY,
num_control varchar(13) NOT NULL,
id_tipo_certificado varchar(2),
id_pago int,
CONSTRAINT alumno_certificado FOREIGN KEY(num_control) REFERENCES alumnos (num_control)
ON DELETE CASCADE
ON UPDATE CASCADE,
CONSTRAINT tipo_certificado FOREIGN KEY(id_tipo_certificado) REFERENCES tipo_certificado (id_tipo)
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
	id_persona varchar(20) NOT NULL PRIMARY KEY,
	nombre varchar(30),
	apellido_paterno varchar(40),
	apellido_materno varchar(40),
	sexo char,
	telefono number(10),
	correo varchar(13),
	codigo_postal varchar(5),
	municipio varchar(50),
	locaidad varchar(50),
	colonia varchar(50),
	calle varchar(50),
	ON DELETE CASCADE
);

# tabla opcion
CREATE TABLE opcion(
	num_opcion int,
	id_opcion int NOT NULL PRIMARY KEY,
	descripcion varchar(30),
	ON DELETE CASCADE
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
