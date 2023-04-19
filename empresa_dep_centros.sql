CREATE DATABASE empresaX;

CREATE TABLE empleados(
  id INT PRIMARY KEY AUTO_INCREMENT,
  nombre VARCHAR(30),
  telefono VARCHAR(20),
  fecha_nacimiento DATE,
  fecha_incorporacion DATE,
  salario FLOAT,
  comision FLOAT,
  nro_hijos INT CHECK(nro_hijos >= 0),
  departamento_id INT,
  FOREIGN KEY (departamento_id) REFERENCES departamentos(id)
)

CREATE TABLE departamentos(
  id INT PRIMARY KEY AUTO_INCREMENT,
  director_id INT,
  centro_id INT,
  departamento_id INT,
  tipo_director ENUM('P','F'),
  presupuesto FLOAT,
  nombre VARCHAR(50),
  FOREIGN KEY (departamento_id) REFERENCES departamentos(id),
  FOREIGN KEY (centro_id) REFERENCES centros(id)
)

CREATE TABLE centros (
  id INT PRIMARY KEY AUTO_INCREMENT,
  nombre VARCHAR(50),
  direccion VARCHAR(50)
)


--2 Insertar los siguientes datos de la tabla de centros.

INSERT INTO centros (id, nombre,direccion) 
VALUES (10, "SEDE CENTRAL", "C/ ATOCHA, 820, MADRID"),
       (20, "RELACION CON CLIENTES", "C/ ATOCHA, 405, MADRID")
 

--3  Insertar los siguientes datos de la tabla de departamentos.

INSERT INTO departamentos (id, centro_id,director_id, tipo_director, presupuesto, departamento_id, nombre)
VALUES
  (100,10,260,"P",72,NULL,"DIRECCION GENERAL"),
  (110,20,180,"P",90,100,"DIRECCION COMERCIAL"),
  (111,20,180,"F",66,110,"SECTOR INDUSTRIAL"),
  (112,20,270,"P",54,110,"SECTOR SERVICIOS"),
  (120,10,150,"F",18,100,"ORGANIZACION"),
  (121,10,150,"P",12,120,"PERSONAL"),
  (122,10,350,"P",36,120,"PROCESO DE DATOS"),
  (130,10,310,"P",12,100,"FINANZAS"),

--4 Insertar 12 datos en la tabla empleados

INSERT INTO empleados (nombre, fecha_nacimiento, fecha_incorporacion, salario, comision, nro_hijos, departamento_id, telefono)
VALUES 
("JUAN PEREZ", "1980-08-23", "2022-01-05", 120000, 5000, 2, 100, "555-1234"),
("JOAQUIN VESCO", "2002-09-23", "2021-01-05", 130000, 5000, 0, 110, "555-5678"),
("PEDRO ALCANTAR", "1999-05-25", "2019-02-16", 110000, 0, 0, 111, "555-9876"),
("ROBERTO CARLOS", "1960-03-25", "1988-02-16", 1235000, 100000, 4, 112, "555-2468"),
("MATEO SALGUERO", "2001-09-10", "2023-01-03", 95000, 0, 0, 120, "555-3690"),
("JUAN CARLOS CABUTIA", "1956-10-29", "1980-05-10", 1450000, 75000, 3, 121, "555-1212"),
("LUCAS RAMIREZ", "2001-10-29", "2022-10-05", 110000, 1300, 0, 122, "555-5656"),
("MARIA GOMEZ", "1995-06-10", "2020-05-15", 80000, 2000, 0, 130, "555-7890"),
("MARIO FERNANDEZ", "1985-03-22", "2015-02-10", 95000, 3000, 2, 100, "555-2345"),
("LAURA MARTINEZ", "1990-11-15", "2017-09-20", 105000, 0, 1, 111, "555-8901"),
("CARLOS GONZALEZ", "1978-07-08", "2010-06-01", 125000, 5000, 3, 120, "555-4567"),
("JULIA RODRIGUEZ", "1987-01-20", "2019-11-10", 90000, 1000, 2, 130, "555-6789"),
("ANDRES SANCHEZ", "1998-12-03", "2021-06-05", 110000, 4000, 0, 112, "555-1357")


--5 - Agregar a la tabla empleados el campo email.

ALTER TABLE empleados ADD email VARCHAR(50)

--6 - Cargar los email de los empleados (pueden poner el nombre@gmail.com)

UPDATE empleados SET email = CONCAT(nombre, "@gmail.com");

--7 -  Subir todos los salarios de los empleados en un 15 %

UPDATE empleados SET salario = salario + salario * 0.15

--8 - Cambiar el nombre de la columna director de la tabla departamentos a directorGeneral

-- MODIFY TABLE departamentos COLUMN director

-- 9 -Crear una nueva tabla llamada Especialidad. Crearle los campos IDESPECILIDAD (autonumerico), NOMBRE, CARACTERISTICA. Indicar el primer campo como clave

CREATE TABLE especialidad (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(50),
  caracteristica VARCHAR(255)
)


-- 10 -  Cargar la tabla con estos tres especialidades

-- IDESPECILIDAD NOMBRE
-- 1             MATEMÁTICA
-- 2             INGENIERÍA
-- 3             RH


INSERT INTO especialidad(nombre) 
VALUES ("MATEMÁTICA"),
       ("INGENIERÍA"),
       ("RH")

-- Me daba toc el nombre
ALTER TABLE especialidad RENAME especialidades 

-- 11- Como relacionarías la tabla EMPLEADOS con ESPECIALIDAD, sabiendo que un empleado puede tener una especialidad pero muchos de ellos pueden compartir especialidad

-- Ya que cada empleado puede tener una unica especialidad, pero muchos pueden compartir la
-- misma especialidad, agregaria la foreign key especialidad_id en la tabla empleados

ALTER TABLE empleados ADD especialidad_id INT;
ALTER TABLE empleados ADD FOREIGN KEY (especialidad_id) REFERENCES especialidades(id);

-- 12 - Agregar un campo en la tabla empleados con los siguientes datos: numero 450, nombre Mateo, fecha de nacimiento 20/02/2001, fecha de ingreso  15/10/2010, salario 2000, email mateo@gmail.com, comision 100, hijos 2, departamento Direccion General, especialidad RH.

INSERT INTO empleados (id, nombre, fecha_nacimiento, fecha_incorporacion, salario, email, comision, nro_hijos, departamento_id, especialidad_id)
VALUES (450, "Mateo", "20/02/2001", "20/02/2001", 2000, "mateo@gmail.com", 100, 2, 100,3)

UPDATE empleados SET fecha_nacimiento = "2001-02-20" where id = 450
UPDATE empleados SET fecha_incorporacion = "2001-02-20" where id = 450


-- 13 - Cargar el campo especialidad con números aleatorios entre 1 y 3.

-- Get random number in range
--  RAND()* (MAX - MIN) + MIN
UPDATE empleados SET especialidad_id = RAND()*(3-1) + 1 WHERE especialidad_id IS NULL

-- 14 - Mostrar todos los datos de la tabla Empleados

SELECT * FROM empleados

-- 15 - Mostrar los numeros y nombre de la tabla Empleados ordenados por nombre

SELECT id, nombre FROM empleados ORDER BY nombre

-- 16 - Mostrar  los numeros y nombre de la tabla empleados de aquellos empleados llamados Mateo.

-- like finds any value that contains the given string

-- WHERE CustomerName LIKE 'a%'	Finds any values that start with "a"
-- WHERE CustomerName LIKE '%a'	Finds any values that end with "a"
-- WHERE CustomerName LIKE '%or%'	Finds any values that have "or" in any position
-- WHERE CustomerName LIKE '_r%'	Finds any values that have "r" in the second position
-- WHERE CustomerName LIKE 'a_%'	Finds any values that start with "a" and are at least 2 characters in length
-- WHERE CustomerName LIKE 'a__%'	Finds any values that start with "a" and are at least 3 characters in length
-- WHERE ContactName LIKE 'a%o'	Finds any values that start with "a" and ends with "o"

SELECT id, nombre FROM empleados WHERE nombre like 'mateo%'

-- 16-1 Mostrar  los numeros y nombre de la tabla empleados de aquellos empleados llamados Mateo o llamado Juan


SELECT id as numero, nombre FROM empleados WHERE nombre like 'mateo%' OR nombre like "juan%"


