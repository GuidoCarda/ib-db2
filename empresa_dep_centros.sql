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

-- 17 -  Mostrar los numeros, nombre y fecha de nacimiento de aquellos empleados nacidos entre el 2000 y el 2005

SELECT id as numero, nombre, fecha_nacimiento FROM empleados WHERE YEAR(fecha_nacimiento) BETWEEN '2000' AND '2005'

-- 18 - Mostrar los numeros, nombre de los empleados , junto al nombre su especialidad.

SELECT empleados.id as numero, empleados.nombre, especialidades.nombre  
FROM empleados, especialidades
WHERE empleados.especialidad_id = especialidades.id

SELECT empleados.id as numero, 
       empleados.nombre, 
       especialidades.nombre 
FROM empleados
INNER JOIN especialidades ON empleados.especialidad_id = especialidades.id


-- 19 - Mostrar el numero y nombre del empleado, el nombre al departamento que pertenece y el nombre del centro al que pertenece ese departamento


--v1
SELECT empleados.id as nunero,
       empleados.nombre as empleado,
       departamentos.nombre as departamento,
       centros.nombre as centro
FROM empleados, departamentos, centros
WHERE empleados.departamento_id = departamentos.id AND departamentos.centro_id = centros.id


--v2
SELECT empleados.id,
       empleados.nombre,
       departamentos.nombre,
       centros.nombre
FROM empleados
INNER JOIN departamentos ON empleados.departamento_id = departamentos.id
INNER JOIN centros ON departamentos.centro_id = centros.id

-- 20 -  Hallar, por orden alfabético, los nombres de los departamentos cuyo tipo de director es en funciones.

SELECT nombre from departamentos WHERE tipo_director = "F" ORDER BY nombre
SELECT nombre from departamentos WHERE tipo_director like "F" ORDER BY nombre

-- 21 - Obtener un listado telefónico de los empleados incluyendo nombre de empleado, número de empleado y número de teléfono. Por orden alfabético descendente.

SELECT id as numero,
       nombre,
       telefono
FROM empleados
ORDER BY telefono DESC

-- 22 - Obtener un listado telefónico de los empleados del departamento 120 incluyendo nombre de empleado, número de empleado y número de teléfono. Por orden alfabético ascendente

SELECT nombre,
       id as numero,
       telefono       
FROM empleados
WHERE departamento_id = 120
ORDER BY nombre ASC

-- 23-  Hallar la comisión, nombre y salario de los empleados clasificados por salario, y dentro de salario por orden alfabético.

SELECT comision, 
       nombre, 
       salario
FROM empleados
ORDER BY salario, nombre 

-- 24-  Hallar la comisión, nombre y salario de los empleados que tienen tres hijos

SELECT nombre,
       comision,
       salario
FROM empleados
WHERE nro_hijos = 3

-- 25 Obtener salario y nombre de los empleados sin hijos y cuyo salario es mayor que 2000 y menor que 2500. 

SELECT nombre, salario
FROM empleados 
WHERE nro_hijos = 0 AND salario BETWEEN 2000 AND 2500

-- 26 -  Obtener los nombres de los departamentos donde trabajan empleados cuyo salario sea inferior a 1500

SELECT departamentos.nombre
FROM departamentos, empleados
WHERE  empleados.departamento_id = departamentos.id AND empleados.salario < 1500 

-- //  Operadores lógicos // --

-- 27 - Mostrar los empleados cuyo salario sea mayor a 2000 y la comisión sea igual a 0
SELECT nombre, salario, comision
FROM empleados
WHERE salario > 2000 AND comision = 0


-- 28 - Mostrar los empleados cuyo salario sea mayor a 2000, pero que la comisión no sea igual a 0

SELECT * 
FROM empleados
WHERE salario > 2000 AND comision != 0


-- //  Operadores relacionales // --
-- 29 - Suponiendo que en los próximos dos años el costo de vida va a aumentar un 8 % anual y que se suben los salarios solo un 2 % anual, hallar para los empleados tengan entre 1 y  4 hijos, su nombre y su sueldo actual,sueldo anual y sueldo para cada uno de los próximos dos años  (usar Between)

SELECT nombre, 
       salario, 
       salario * 12 as salario_anual,
       ROUND(salario * 12 * 1.02, 2) as salario_primer_año,
       ROUND(salario * 12 * 1.02 * 1.02, 2) as salario_segundo_año
FROM empleados
WHERE nro_hijos BETWEEN 1 AND 4


-- 30 Mostrar los numeros y nombres de los empleados cuyo nombre comienza con A

SELECT id as numero, nombre 
FROM empleados 
WHERE nombre like "a%"

-- 31 Mostrar los numeros y nombres de los empleados cuyos nombres sean Mateo, Julio, Luciano (usar in)

SELECT id as numero,
       nombre
FROM empleados
WHERE nombre in ("MATEO", 'Julio', 'Luciano')

-- 32  En una campania de ayuda familiar se ha decidido dar a los empleados una paga extra de 600 para aquellos que tienen entre 1 y 3 hijos y un salario menor a 2000. Obtener por orden alfabetico para estos empelados: nombre, salario y salario total que van a cobrar incluyendo esta paga extra

SELECT nombre, 
       salario,
       salario + 600
FROM empleados
WHERE (nro_hijos Between 1 AND 3) AND salario < 2000
ORDER BY nombre 

-- 33 Hallar el salario medio, minimo y maximo de los empleads de la empresa.

SELECT MIN(salario) as minimo, 
       ROUND(SUM(salario) / COUNT(salario),2) as promedio ,
       MAX(salario) as maximo 
FROM empleados

-- 34 Hallar el numero de empleados de la empresa.
SELECT COUNT(*) FROM empleados

-- 35 Hallar el numero de empleados del departamento 120
SELECT COUNT(*) 
FROM empleados 
WHERE (departamento_id = 120)

-- 36 Hallar el numero de empleados de la empresa del departamento 120 y la suma de los salarios de esos empelados

SELECT COUNT(*), SUM (salarios)
FROM empleados
WHERE departamento_id = 120

