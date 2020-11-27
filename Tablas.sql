# tabla tipo certificado
/*CREATE TABLE tipo_certificado(
	id_tipo varchar(2) NOT NULL PRIMARY KEY,
	nombre varchar (35),
	precio number(3)
);*/
#tabla certificado
CREATE TABLE certificados(
	id_certificado varchar(20) NOT NULL PRIMARY KEY,
	num_control varchar(13) NOT NULL,
	id_tipo_certificado varchar(2),
	id_pago int,
	CONSTRAINT alumno_certificado FOREIGN KEY(num_control) REFERENCES alumnos (num_control)
	ON DELETE CASCADE ENABLE,
	CONSTRAINT tipo_certificado FOREIGN KEY(id_tipo_certificado) REFERENCES tipo(id_tipo)
	ON DELETE CASCADE ENABLE,
	CONSTRAINT pago_certificado FOREIGN KEY(id_pago) REFERENCES Pagos(id_pago)
	ON DELETE CASCADE ENABLE
);
# tabla de alumnos 
CREATE TABLE alumnos(
	num_control varchar(13) NOT NULL PRIMARY KEY,
	id_persona number,
	constraint per_alu FOREIGN KEY (id_persona) REFERENCES persona(id_persona)
	ON DELETE CASCADE ENABLE
);

# tabla unidades
CREATE TABLE unidades(
	id_unidad varchar(10) NOT NULL PRIMARY KEY,
	num_unidad number(1),
	descripcion varchar(50),
	clave_materia varchar int NOT NULL,
	CONSTRAINT materia_unidades FOREIGN KEY(clave_materia) REFERENCES materias(clave_materia)
	ON DELETE CASCADE ENABLE
);

# tabla persona
CREATE TABLE persona(
	id_persona number NOT NULL,
	nombre varchar(30),
	apellido_paterno varchar(40),
	apellido_materno varchar(40),
	curp varchar(18),
	sexo char,
	estado varchar(50) DEFAULT 'Estado de México' NOT NULL,
	telefono number(10),
	correo varchar(13),
	codigo_postal varchar(5),
	municipio varchar(50),
	localidad varchar(50),
	colonia varchar(50),
	calle varchar(50),
	CONSTRAINT pk_id_persona PRIMARY KEY(id_persona)
);
#Tabla opcion
CREATE TABLE opcion(
	id_opcion number not null, 
	nombre_opcion varchar(50) not null,
	descripcion varchar(50) not null, 
	CONSTRAINT id_opcion_pk primary key(id_opcion)
);


#Tabla calificaciones
CREATE TABLE calificaciones(
	num_control varchar(13) not null ,
	id_unidad varchar(10) not null,
	calificacion number(4,2) not null,
	id_opcion int not null,
	CONSTRAINT alumnos_calificaciones FOREIGN KEY(num_control) REFERENCES alumnos(num_control),
	CONSTRAINT unidad_calificaciones FOREIGN KEY(id_unidad) REFERENCES unidades(id_unidad),
	CONSTRAINT opcion_calificaciones FOREIGN KEY(id_opcion) REFERENCES opcion(id_opcion)
	ON DELETE CASCADE ENABLE
	
);

#Tabla preinscripcion
CREATE TABLE preinscripcion (
folio INT NOT NULL, fecha DATE, carrera_alterna1 varchar(10) NOT NULL, carrera_alterna2 varchar(10) NOT NULL, carrera_alterna3 varchar(10) NOT NULL,
id_persona INT NOT NULL, fotografia NVARCHAR2(20), escuela_procedencia NVARCHAR2(100), municipio_escuela NVARCHAR2(100), promedio VARCHAR2(10),
CONSTRAINT folio_PK PRIMARY KEY (folio) ENABLE,
CONSTRAINT carrera1_FK FOREIGN KEY (carrera_alterna1) REFERENCES carrera (clave_carrera) ON DELETE CASCADE ENABLE,
CONSTRAINT carrera2_FK FOREIGN KEY (carrera_alterna2) REFERENCES carrera (clave_carrera) ON DELETE CASCADE ENABLE, 
CONSTRAINT carrera3_FK FOREIGN KEY (carrera_alterna3) REFERENCES carrera (clave_carrera) ON DELETE CASCADE ENABLE,
CONSTRAINT idpersona_FK FOREIGN KEY (id_persona) REFERENCES persona (id_persona) ON DELETE CASCADE ENABLE);

#Tabla constancia
create table constancia(
id_constancia int not null, 
fecha date,
num_control varchar(13) not null, 
id_tipo int not null,
id_pago int not null,
constraint id_constancia_pk primary key(id_tipo),
constraint num_control_fk foreign key(num_control)
references alumno(num_control)ON DELETE CASCADE,
constraint id_tipo_fk foreign key(id_tipo)
references tipo(id_tipo) ON DELETE CASCADE ENABLE,
constraint id_pago_fk foreign key(id_pago)
references pago(id_pago) ON DELETE CASCADE ENABLE
);

#Tabla tipo para contancias
create table tipo(
id_tipo int not null,
nombre varchar(50),
descripcion varchar(100) ,
precio number(3),
constraint id_tipo_pk primary key(id_tipo)
);

#Tabla resultados examen
create table resultados (
id_resultados int not null,
resultado varchar(30),
id_examen int not null,
folio int not null,
num_aciertos int not null,
constraint id_resultados_pk primary key(id_resultado),
constraint id_examen_fk foreign key(id_examen) references examen(id_examen) ON DELETE CASCADE ENABLE,
constraint id_folio_fk foreign key(folio) references preinscripcion(folio) ON DELETE CASCADE ENABLE
);

#Creacion de tabla examen en Oracle
CREATE TABLE EXAMEN (
  ID_EXAMEN INT NOT NULL 
, HORARIO DATE 
, FECHA DATE 
, LUGAR_APLICACION VARCHAR2(30) 
, ID_PAGO INT 
, NUM_FOLIO_PRE INT 
, CONSTRAINT EXAMEN_PK PRIMARY KEY 
  (
    ID_EXAMEN 
  )
  ENABLE 
);

#creacion de tabla grupo en Oracle

CREATE TABLE GRUPO (
ID_GRUPO INT NOT NULL,
EDIFICIO VARCHAR2(5),
NUM_GRUPO VARCHAR2(10),
ID_SEMESTRE INT NOT NULL,
CONSTRAINT PK_GRUPO PRIMARY KEY (ID_GRUPO),
CONSTRAINT FK_SEMESTRE FOREIGN KEY (ID_SEMESTRE) REFERENCES SEMESTRE(ID_SEMESTRE) ON DELETE CASCADE ENABLE
);


################### MODULO INSCRIPCIONES ###################
# Tabla Pagos
CREATE TABLE Pagos(
	id_pago int NOT NULL,
	Folio varchar(30) NOT NULL,
	TipoPago varchar(30) NOT NULL,
	Cantidad int NOT NULL,
	CONSTRAINT pk_pago PRIMARY KEY (id_pago)
	ON DELETE CASCADE 
);


# Tabla CargaAcademica
CREATE TABLE CargaAcademica(
	id_cargaAcad int NOT NULL,
	num_control	int NOT NULL,
	id_grupo int NOT NULL,
	id_semestre int NOT NULL,
	CONSTRAINT pk_carga PRIMARY KEY (id_cargaAcad),
	CONSTRAINT fk_control_carga FOREIGN KEY (num_control) REFERENCES alumnos (num_control) ON DELETE CASCADE ENABLE,
	CONSTRAINT fk_grupo_carga FOREIGN KEY (id_grupo) REFERENCES grupo (id_grupo) ON DELETE CASCADE ENABLE,
	CONSTRAINT fk_semestre_carga FOREIGN KEY (id_semestre) REFERENCES Semestre(id_semestre)
	ON DELETE CASCADE ENABLE
);

# Tabla MateriasCarga
CREATE TABLE Materias_Carga(
	id_cargaAcad int NOT NULL,
	clave_materia int NOT NULL,
	CONSTRAINT fk_carga_materia FOREIGN KEY (id_cargaAcad) REFERENCES CargaAcademica (id_cargaAcad),
	CONSTRAINT fk_materia_carga FOREIGN KEY (clave_materia) REFERENCES Materias(clave_materia),
	PRIMARY KEY(id_cargaAcad, clave_materia)
	ON DELETE CASCADE ENABLE
);

# Tabla Inscripciones
CREATE TABLE Inscripciones(
	id_inscripcion int,
	id_cargaAcad int,
	PRIMARY KEY (id_inscripcion),
	CONSTRAINT fk_carga_inscr FOREIGN KEY (id_cargaAcad) REFERENCES CargaAcademica (id_cargaAcad),
	ON DELETE CASCADE ENABLE
);

CREATE TABLE Inscripcione_Pago(
	id_inscripcion int NOT NULL,
	id_pago int NOT NULL,
	CONSTRAINT fk_insc_pago FOREIGN KEY (id_inscripcion) REFERENCES Inscripciones (id_inscripcion),
	CONSTRAINT fk_pago_insc FOREIGN KEY (id_pago) REFERENCES Pagos (id_pago),
	PRIMARY KEY(id_inscripcion, id_pago)
	ON DELETE CASCADE ENABLE

);

#######################################################################
 
 #Tabla materias
 CREATE TABLE materias( 
	clave_materia int NOT NULL, 
	nombre varchar(30), 
	unidades int, 
	creditos int, 
	horas_practicas int, 
	horas_teoricas int, 
	CONSTRAINT materias_pk PRIMARY KEY (clave_materia), 
	CONSTRAINT materias_fk1 FOREIGN KEY(id_docente) REFERENCES docente(id_docente)  ON DELETE CASCADE ,
	CONSTRAINT materias_fk2 FOREIGN KEY (id_semestre) REFERENCES semestre (id_semestre)  ON DELETE CASCADE 
); 
	
#Tabla carreras
CREATE TABLE carreras ( 
	clave_carrera varchar(10) NOT NULL,  
	nombre varchar (30),
	objetivo_general varchar (300),
	especialidad varchar(100), 
	perfil_de_egreso varchar (300), 
	ambito_laboral varchar(260), 
	id_escuela int NOT NULL, 
	CONSTRAINT carreras_pk PRIMARY KEY (clave_carrera), 
	CONSTRAINT carreras_fk1 FOREIGN KEY(id_escuela) REFERENCES institucion (id_escuela) ON DELETE CASCADE ENABLE  );
	
#Tabla docentes oracle

CREATE TABLE DOCENTE (
ID_DOCENTE INT NOT NULL,
CEDULA VARCHAR2(8),
GRADO_ACADEMICO VARCHAR2(30),
ESPECIALIDAD VARCHAR2(30),
NUM_SEGURO_SOCIAL VARCHAR2(11),
CONSTRAINT DOCENTE_PK PRIMARY KEY (ID_PERSONA)
);


CREATE TABLE Semestre(
	id_semestre int NOT NULL,
	Nombre varchar(30) NOT NULL,
	Periodo varchar(30) NOT NULL,
	clave_carrera varchar (10) NOT NULL,
	CONSTRAINT fk_carrera_semestre FOREIGN KEY clave_carrera REFERENCES carreras (clave_carrera),
	CONSTRAINT pk_semestre PRIMARY KEY (id_semestre)
	ON DELETE CASCADE
);


CREATE TABLE Institucion(
	id_escuela int NOT NULL,
	Matricula varchar(30) NOT NULL,
	Nombre varchar(30) NOT NULL,
	Ubicacion varchar(30) NOT NULL,
	Telefono varchar(15) NOT NULL,
	Correo varchar(30) NOT NULL,
	CONSTRAINT pk_escuela PRIMARY KEY (id_escuela)
);
	
	
	CREATE TABLE PAGO (
ID_PAGO INT NOT NULL,
CONCEPTO_DE_PAGO VARCHAR2(30),
FOLIO NUMBER(20),
CANTIDAD INT,
CONSTRAINT PK_PAGO PRIMARY KEY (ID_PAGO)
);
