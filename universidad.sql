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


ALTER TABLE alumnos ADD email VARCHAR(30)

UPDATE alumnos SET email = concat(nombre, '@gmail.com') WHERE id = 1
UPDATE cursos SET cant_cred = cant_cred + 20
UPDATE cursos SET nombre = concat(nombre, ' TECNICO') WHERE nombre = 'INGLES' 


CREATE TABLE docentes (
  id INT PRIMARY KEY AUTO_INCREMENT,
  nombre VARCHAR(50),
  fecha_nac DATE,
  especialidad VARCHAR(30)
)

INSERT INTO docentes (nombre, fecha_nac, especialIdiad) VALUES 
("daniela","1995-01-01","INGLES"),
("pedro","1994-10-01","INGENIERIA")

//v1
ALTER TABLE cursos ADD docente_id INT;
ALTER TABLE cursos ADD FOREIGN KEY (docente_id) REFERENCES docentes(id);

//v2
ALTER TABLE cursos ADD docente_id REFERENCES docentes(id);


INSERT INTO alumnos (nombre, fecha, sexo, carrera_id, email) VALUES ('MATEO', '2001-02-20' ,'M', 2,'mateo@gmail.com')
INSERT INTO matriculas (fecha,alumno_id, curso_id) VALUES (CURDATE(), 7, 2), (CURDATE(), 7, 3);


//ALTER TABLE matriculas MODIFY COLUMN id INT AUTO_INCREMENT


INSERT INTO matriculas (fecha,alumno_id, curso_id) values (CURDATE(), 3, 2), (CURDATE(), 3, 3);

-- 13
SELECT * FROM alumnos

--14
SELECT id, nombre FROM alumnos

--15
SELECT id, nombre FROM alumnos ORDER BY nombre 

--16
SELECT id, nombre FROM alumnos WHERE nombre like 'juan'

--17
SELECT id, nombre, fecha FROM alumnos WHERE year(fecha) BETWEEN '1990' AND '1999' 

--18
SELECT a.id, a.nombre, c.nombre FROM alumnos a, carreras c WHERE a.carrera_id = c.id

SELECT a.id, 
       a.nombre,
       c.nombre 
FROM alumnos a 
INNER JOIN carreras c ON c.id = a.carrera_id 

--19

UPDATE cursos SET docente_id = 1 WHERE carrera_id = 1
UPDATE cursos SET docente_id = 2 WHERE carrera_id in (2,3) 

SELECT cursos.nombre, docentes.nombre FROM cursos, docentes WHERE cursos.docente_id = docentes.id

SELECT cursos.nombre as Curso,
       docentes.nombre as Docente
FROM cursos
INNER JOIN docentes ON cursos.docente_id = docentes.id

--20

SELECT matriculas.id, 
       alumnos.nombre,
       cursos.nombre,
       matriculas.fecha
FROM matriculas 
INNER JOIN alumnos ON matriculas.alumno_id = alumnos.id
INNER JOIN cursos ON matriculas.curso_id = cursos.id    
ORDER BY alumnos.id

-- id matricula
-- nombre alumno
-- nombre materia
-- fecha matriculacion