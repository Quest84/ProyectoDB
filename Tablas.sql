#Tabla Institucion
CREATE TABLE institucion(
	id_escuela int NOT NULL,
	matricula varchar(30) NOT NULL,
	nombre varchar(100) NOT NULL,
	ubicacion varchar(30) NOT NULL,
	telefono varchar(15) NOT NULL,
	correo varchar(30) NOT NULL,
	CONSTRAINT pk_escuela PRIMARY KEY (id_escuela)
);
#Tabla carreras
CREATE TABLE carreras ( 
	clave_carrera varchar(10) NOT NULL,  
	nombre varchar (100),
	objetivo_general varchar (500),
	especialidad varchar(100), 
	perfil_de_egreso varchar (500), 
	ambito_laboral varchar(500), 
	id_escuela int NOT NULL, 
	CONSTRAINT carreras_pk PRIMARY KEY (clave_carrera), 
	CONSTRAINT carreras_fk1 FOREIGN KEY(id_escuela) REFERENCES institucion (id_escuela) ON DELETE CASCADE );
#Tabla semestre
CREATE TABLE semestre(
	id_semestre int NOT NULL,
	nombre varchar(30) NOT NULL,
	periodo varchar(30) NOT NULL,
	clave_carrera varchar (10) NOT NULL,
	CONSTRAINT fk_carrera_semestre FOREIGN KEY (clave_carrera) REFERENCES carreras (clave_carrera),
	CONSTRAINT pk_semestre PRIMARY KEY (id_semestre)
);
#Tabla grupos
CREATE TABLE grupo (
id_grupo INT NOT NULL,
edificio VARCHAR(5),
num_grupo VARCHAR(10),
id_semestre INT NOT NULL,
CONSTRAINT pk_grupo PRIMARY KEY (id_grupo),
CONSTRAINT fk_semestre FOREIGN KEY (id_semestre) REFERENCES semestre(id_semestre) ON DELETE CASCADE 
);
#Tabla pago
CREATE TABLE pagos(
	id_pago int NOT NULL,
	folio varchar(30) NOT NULL,
	tipoPago varchar(50) NOT NULL,
	Cantidad int NOT NULL,
	CONSTRAINT pk_pago PRIMARY KEY (id_pago)
);

#Tabla persona
CREATE TABLE persona(
	id_persona int NOT NULL,
	nombre varchar(30),
	apellido_paterno varchar(40),
	apellido_materno varchar(40),
	curp varchar(18),
	sexo char,
	estado varchar(50) DEFAULT 'Estado de México' NOT NULL,
	telefono varchar(10),
	correo varchar(50),
	codigo_postal varchar(5),
	municipio varchar(50),
	localidad varchar(50),
	colonia varchar(50),
	calle varchar(50),
	CONSTRAINT pk_id_persona PRIMARY KEY(id_persona)
);
#Tabla alumno
CREATE TABLE alumnos(
	num_control varchar(13) NOT NULL PRIMARY KEY,
	id_persona int,
	constraint per_alu FOREIGN KEY (id_persona) REFERENCES persona(id_persona)
	ON DELETE CASCADE 
);
#Tabla docentes
CREATE TABLE docente (
id_docente INT NOT NULL,
cedula VARCHAR(8),
grado_academico VARCHAR(30),
especialidad VARCHAR(30),
num_seguro_social VARCHAR(11),
id_persona INT NOT NULL,
constraint fk_docente_persona FOREIGN KEY (id_persona) REFERENCES persona(id_persona),
CONSTRAINT docente_pk PRIMARY KEY (id_docente)
);

 #Tabla materias
 CREATE TABLE materias( 
	clave_materia VARCHAR(10) NOT NULL, 
	nombre varchar(30), 
	unidades int, 
	creditos int, 
	horas_practicas int, 
	horas_teoricas int, 
    id_docente int,
    id_semestre int,
	CONSTRAINT materias_pk PRIMARY KEY (clave_materia), 
	CONSTRAINT materias_fk1 FOREIGN KEY(id_docente) REFERENCES docente(id_docente)  ON DELETE CASCADE ,
	CONSTRAINT materias_fk2 FOREIGN KEY (id_semestre) REFERENCES semestre (id_semestre)  ON DELETE CASCADE 
); 
# Tabla unidades
CREATE TABLE unidades(
	id_unidad varchar(10) NOT NULL PRIMARY KEY,
	num_unidad int,
	descripcion varchar(50),
	clave_materia varchar(10)  NOT NULL,
	CONSTRAINT materia_unidades FOREIGN KEY(clave_materia) REFERENCES materias(clave_materia)
	ON DELETE CASCADE 
);
#Tabla opcion
CREATE TABLE opcion(
	id_opcion int not null, 
	nombre_opcion varchar(50) not null,
	descripcion varchar(50) not null, 
	CONSTRAINT id_opcion_pk primary key(id_opcion)
);

#Tabla calificaciones
CREATE TABLE calificaciones(
	num_control varchar(13) not null ,
	id_unidad varchar(10) not null,
	calificacion int not null,
	id_opcion int not null,
	CONSTRAINT alumnos_calificaciones FOREIGN KEY(num_control) REFERENCES alumnos(num_control)ON DELETE CASCADE ,
	CONSTRAINT unidad_calificaciones FOREIGN KEY(id_unidad) REFERENCES unidades(id_unidad)ON DELETE CASCADE ,
	CONSTRAINT opcion_calificaciones FOREIGN KEY(id_opcion) REFERENCES opcion(id_opcion)ON DELETE CASCADE 
);

#Tabla preincripcion
CREATE TABLE preinscripcion (
folio INT NOT NULL, fecha DATE, carrera_alterna1 varchar(10) NOT NULL, carrera_alterna2 varchar(10) NOT NULL, carrera_alterna3 varchar(10) NOT NULL,
id_persona INT NOT NULL, fotografia VARCHAR(20), escuela_procedencia VARCHAR(100), municipio_escuela VARCHAR(100), promedio VARCHAR(10),
CONSTRAINT folio_PK PRIMARY KEY (folio) ,
CONSTRAINT carrera1_FK FOREIGN KEY (carrera_alterna1) REFERENCES carreras (clave_carrera) ON DELETE CASCADE ,
CONSTRAINT carrera2_FK FOREIGN KEY (carrera_alterna2) REFERENCES carreras(clave_carrera) ON DELETE CASCADE, 
CONSTRAINT carrera3_FK FOREIGN KEY (carrera_alterna3) REFERENCES carreras (clave_carrera) ON DELETE CASCADE ,
CONSTRAINT idpersona_FK FOREIGN KEY (id_persona) REFERENCES persona (id_persona) ON DELETE CASCADE);
#Tabla 
CREATE TABLE examen (
id_examen INT NOT NULL 
, horario VARCHAR(5)
, fecha DATE 
, lugar_aplicacion VARCHAR(30) 
, id_pago INT 
, folio INT 
, CONSTRAINT EXAMEN_PK PRIMARY KEY (id_examen ),
CONSTRAINT fk_examen_pago FOREIGN KEY (folio) REFERENCES preinscripcion (folio) ON DELETE CASCADE);

#Tabla resultados examen
create table resultados (
id_resultado int not null,
resultado varchar(30),
id_examen int not null,
folio int not null,
num_aciertos int not null,
constraint id_resultados_pk primary key(id_resultado),
constraint id_examen_fk foreign key(id_examen) references examen(id_examen) ON DELETE CASCADE ,
constraint id_folio_fk foreign key(folio) references preinscripcion(folio) ON DELETE CASCADE 
);

# Tabla CargaAcademica
CREATE TABLE carga_academica(
	id_carga_acad int NOT NULL,
	num_control	varchar(13) NOT NULL,
	id_grupo int NOT NULL,
	CONSTRAINT pk_carga PRIMARY KEY (id_carga_acad),
	CONSTRAINT fk_control_carga FOREIGN KEY (num_control) REFERENCES alumnos (num_control) ON DELETE CASCADE ,
	CONSTRAINT fk_grupo_carga FOREIGN KEY (id_grupo) REFERENCES grupo (id_grupo) ON DELETE CASCADE 
);

# Tabla Inscripciones
CREATE TABLE inscripciones(
	id_inscripcion int,
	id_carga_acad  int,
	PRIMARY KEY (id_inscripcion),
	CONSTRAINT fk_carga_inscr FOREIGN KEY (id_carga_acad) REFERENCES Carga_academica (id_carga_acad)
	ON DELETE CASCADE 
);

# Tabla MateriasCarga
CREATE TABLE materias_carga(
	id_carga_acad  int NOT NULL,
	clave_materia varchar(10) NOT NULL,
	CONSTRAINT fk_carga_materia FOREIGN KEY (id_carga_acad) REFERENCES carga_academica (id_carga_acad),
	CONSTRAINT fk_materia_carga FOREIGN KEY (clave_materia) REFERENCES materias(clave_materia)ON DELETE CASCADE 
);

CREATE TABLE inscripciones_pago(
	id_inscripcion int NOT NULL,
	id_pago int NOT NULL,
	CONSTRAINT fk_insc_pago FOREIGN KEY (id_inscripcion) REFERENCES inscripciones (id_inscripcion)ON DELETE CASCADE ,
	CONSTRAINT fk_pago_insc FOREIGN KEY (id_pago) REFERENCES Pagos (id_pago)ON DELETE CASCADE 
);
#Tabla tipo
create table tipo(
id_tipo int not null,
nombre varchar(50),
descripcion varchar(100) ,
precio int,
constraint id_tipo_pk primary key(id_tipo)
);

#Tabla constancia
create table constancia(
id_constancia int not null, 
fecha date,
num_control varchar(13) not null, 
id_tipo int not null,
id_pago int not null,
constraint id_constancia_pk primary key(id_tipo),
constraint num_control_fk foreign key(num_control)
references alumnos(num_control)ON DELETE CASCADE,
constraint id_tipo_fk foreign key(id_tipo)references tipo(id_tipo) ON DELETE CASCADE ,
constraint id_pago_fk foreign key(id_pago)references pagos(id_pago) ON DELETE CASCADE
);
#tabla certificado
CREATE TABLE certificados(
	id_certificado varchar(20) NOT NULL PRIMARY KEY,
	num_control varchar(13) NOT NULL,
	id_tipo_certificado int,
	id_pago int,
	CONSTRAINT alumno_certificado FOREIGN KEY(num_control) REFERENCES alumnos (num_control)
	ON DELETE CASCADE ,
	CONSTRAINT tipo_certificado FOREIGN KEY(id_tipo_certificado) REFERENCES tipo(id_tipo)
	ON DELETE CASCADE ,
	CONSTRAINT pago_certificado FOREIGN KEY(id_pago) REFERENCES pagos(id_pago)
	ON DELETE CASCADE
);
