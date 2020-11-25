# tabla de alumnos 
CREATE TABLE alumnos(
num_control varchar(13) NOT NULL PRIMARY KEY,
id_persona int,
constraint per_alu FOREIGN KEY (id_persona) REFERENCES persona(id_persona)
ON DELETE CASCADE
);

# tabla unidades
CREATE TABLE unidades(
id_unidad varchar(10) NOT NULL PRIMARY KEY,
num_unidad number(1),
descripcion varchar(50),
clave_materia int,
CONSTRAINT materia_unidades FOREIGN KEY(clave_materia) REFERENCES materias(clave_materia)
ON DELETE CASCADE
);

# tabla persona
CREATE TABLE persona(
id_persona int NOT NULL PRIMARY KEY,
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
