CREATE TABLE carreras (
  id INT PRIMARY KEY AUTO_INCREMENT,
  nombre VARCHAR(50) 
)

CREATE TABLE alumnos (
  id INT PRIMARY KEY AUTO_INCREMENT,
  nombre VARCHAR(50),
  fecha DATE,
  sexo ENUM('H','M'),
  carrera_id INT,
  FOREIGN KEY (carrera_id) REFERENCES carreras(id)
)

CREATE TABLE matriculas (
  id INT PRIMARY KEY AUTO_INCREMENT,
  fecha DATE,
  alumno_id INT,
  curso_id INT,
  FOREIGN KEY (alumno_id) REFERENCES alumnos(id),
  FOREIGN KEY (curso_id) REFERENCES cursos(id)
)

CREATE TABLE cursos (
  id INT PRIMARY KEY AUTO_INCREMENT,
  nombre VARCHAR(50),
  cant_cred INT CHECK (cant_cred > 0),
  carrera_id INT,
  FOREIGN KEY (carrera_id) REFERENCES carreras(id)
)

INSERT INTO carreras (nombre) VALUES ('RRHH','DS')

INSERT INTO ALUMNOS VALUES 
  (1,"JUAN", "1990/01/01", "M", 1), 
  (2,"LUCAS",  "1998/01/03", "M", 1), 
  (3,"MARIA", "1999/12/03", "F", 1), 
  (4,"MALENA",  "1997/12/22", "F", 2), 
  (5,"JUAN", "1999/11/01", "M", 2), 
  (6,"MARIANA", "2000/11/03", "F", 2);


INSERT INTO cursos (nombre, cant_cred, carrera_id) VALUES 
  ('ingles', 100, 1),
  ('ing de software', 150, 2),
  ('programacion', 120, 2)

ALTER TABLE alumnos MODIFY COLUMN sexo ENUM('M','F')