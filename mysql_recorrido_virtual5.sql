

CREATE DATABASE recorrido_virtual5;

USE recorrido_virtual5;

CREATE TABLE Departamento(
id_departamento INT PRIMARy KEY AUTO_INCREMENT,
nombre VARCHAR(30),
descripcion VARCHAR(30)
);


CREATE TABLE Empleado(
matricula INT PRIMARY KEY AUTO_INCREMENT,
nombre VARCHAR (30),
a_paterno VARCHAR(30),
a_materno VARCHAR(30),
correo VARCHAR (30),
telefono INT,
curp VARCHAR(16)

);



CREATE TABLE Horario(
id_horario INT PRIMARY KEY AUTO_INCREMENT,
hora_inicio VARCHAR(5),
hora_fin VARCHAR(10)
);

CREATE TABLE Dia(
id_dia INT PRIMARY KEY AUTO_INCREMENT,
nombre_dia VARCHAR(10) 
);


CREATE TABLE Edificio(
id_edificio INT PRIMARY KEY AUTO_INCREMENT,
nombre_edificio VARCHAR(30)
);

/*Categoria Aula*/
CREATE TABLE Cat_aula(
id_cat_aula INT PRIMARY KEY AUTO_INCREMENT,
descripcion_cat VARCHAR(30)
);



CREATE TABLE Materia(
clave_materia VARCHAR(8) PRIMARY KEY,
nombre_materia VARCHAR(30),
creditos INT
);


/* Tablas de nivel 2*/

CREATE TABLE Cargo(
id_cargo INT PRIMARY KEY AUTO_INCREMENT,
descripcion_cargo VARCHAR(30),
fk_departamento INT,
CONSTRAINT fkc_departamento FOREIGN KEY (fk_departamento) REFERENCES Departamento(id_departamento)
);



CREATE TABLE Empleado_cargo(
id_empleado_cargo INT PRIMARY KEY AUTO_INCREMENT,
fk_matricula INT,
fk_cargo INT,
CONSTRAINT fkm_empleado FOREIGN KEY (fk_matricula) REFERENCES Empleado(matricula)
ON UPDATE CASCADE ON DELETE CASCADE,
CONSTRAINT fkec_cargo FOREIGN KEY (fk_cargo) REFERENCES Cargo(id_cargo)
ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE Horario_dia(
id_horario_dia INT PRIMARY KEY AUTO_INCREMENT,
fk_horario INT,
fk_dia INT,
CONSTRAINT fkhd_horario FOREIGN KEY (fk_horario) REFERENCES Horario(id_horario)
ON UPDATE CASCADE ON DELETE CASCADE,
CONSTRAINT fkhd_dia FOREIGN KEY (fk_dia) REFERENCES Dia(id_dia)
);

CREATE TABLE Aula(
id_aula INT PRIMARY KEY AUTO_INCREMENT,
nombre_aula VARCHAR(30),
fk_edificio INT,
fk_cat_aula INT,
CONSTRAINT fka_edificio FOREIGN KEY (fk_edificio) REFERENCES Edificio(id_edificio)
ON UPDATE CASCADE ON DELETE CASCADE,
CONSTRAINT fka_cAula FOREIGN KEY (fk_cat_aula) REFERENCES Cat_Aula(id_cat_aula) 
ON UPDATE CASCADE ON DELETE CASCADE
);


/* Tablas de nivel 3*/

CREATE TABLE Funcion_cargo(
id_funcion INT PRIMARY KEY AUTO_INCREMENT,
fk_cargo INT,
descripcion VARCHAR(500),
CONSTRAINT fkfc_cargo FOREIGN KEY (fk_cargo) REFERENCES Cargo(id_cargo)
ON UPDATE CASCADE ON DELETE CASCADE
);


CREATE TABLE horario_cargo(
id_horario_cargo INT PRIMARY KEY AUTO_INCREMENT,
fk_empleado_cargo INT,
fk_horario_dia INT,
fk_aula INT,
CONSTRAINT fkhc_ecargo FOREIGN KEY (fk_empleado_cargo) REFERENCES Empleado_cargo(fk_matricula)
ON UPDATE CASCADE ON DELETE CASCADE,
CONSTRAINT fkhc_hdia FOREIGN KEY (fk_horario_dia) REFERENCES Horario_dia(id_horario_dia)
ON UPDATE CASCADE ON DELETE CASCADE,
CONSTRAINT fkhc_aula FOREIGN KEY (fk_aula) REFERENCES aula(id_aula)
);

CREATE TABLE Rubrica(
id_rubrica INT PRIMARY KEY AUTO_INCREMENT,
fk_materia VARCHAR(8),
semestre INT,
CONSTRAINT fkr_materia FOREIGN KEY (fk_materia) REFERENCES Materia(clave_materia) 
ON UPDATE CASCADE ON DELETE CASCADE
);

/* Tablas de nivel 4*/


CREATE TABLE Curso(
id_curso INT PRIMARY KEY AUTO_INCREMENT,
grupo INT,
fk_rubrica INT,
ciclo_escolar VARCHAR(6),
CONSTRAINT fkcurso_rubrica FOREIGN KEY (fk_rubrica) REFERENCES Rubrica(id_rubrica)
ON UPDATE CASCADE ON DELETE CASCADE
);



/*Nivel 5*/

CREATE TABLE Curso_horario(
fk_horario_cargo INT AUTO_INCREMENT,
fk_curso INT,
CONSTRAINT fkch_hCargo FOREIGN KEY (fk_horario_cargo) REFERENCES Horario_cargo(id_horario_cargo)
ON UPDATE CASCADE ON DELETE CASCADE,
CONSTRAINT fkch_Curso FOREIGN KEY (fk_curso) REFERENCES Curso(id_curso) 
ON UPDATE CASCADE ON DELETE CASCADE,
PRIMARY KEY(fk_horario_cargo,fk_curso)
);


