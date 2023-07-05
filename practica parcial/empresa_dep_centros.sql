CREATE DATABASE practica1

CREATE TABLE centros (
  id INT PRIMARY KEY AUTO_INCREMENT,
  nombre VARCHAR(255),
  direccion VARCHAR(255)
)

CREATE TABLE departamentos(
  id INT PRIMARY KEY AUTO_INCREMENT,
  nombre VARCHAR(255),
  presupuesto DECIMAL(9,2),
  tipo_director ENUM('P', 'F'),
  director_id INT,
  centro_id INT,
  departamento_id INT,
  FOREIGN KEY (centro_id) REFERENCES centros(id),
  FOREIGN KEY (departamento_id) REFERENCES departamentos(id)
)


-- DATE FORMAT 'YYYYMMDD' or 'YYMMDD

CREATE TABLE empleados(
  id INT PRIMARY KEY AUTO_INCREMENT,
  nombre VARCHAR(255),
  telefono VARCHAR(10),
  fecha_nacimiento DATE,
  fecha_incorporacion DATE,
  salario DECIMAL(9,2),
  comision DECIMAL(9,2),
  nro_hijos INT UNSIGNED,
  departamento_id INT,
  FOREIGN KEY (departamento_id) REFERENCES departamentos(id)
)

-- inserts

INSERT INTO centros (id,nombre,direccion) 
VALUES (10, 'sede central', 'c/atocha,820,madrid'),
       (20, 'relacion con clientes', 'c/atocha,420,madrid')

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


-- 5 - Agregar a la tabla empleados el campo email.
ALTER TABLE empleados ADD email VARCHAR(255)
-- 6 - Cargar los email de los empleados (pueden poner el nombre@gmail.com)
UPDATE empleados SET email = concat( replace ( lower (nombre) ,' ', '') ,'@gmail.com')

-- 7 -  Subir todos los salarios de los empleados en un 15 %
UPDATE empleados SET salario = salario * 1.15

-- 8 - Cambiar el nombre de la columna director de la tabla departamentos a 
-- ALTER TABLE table_name CHANGE old_name new_name data_type
ALTER TABLE departamentos CHANGE director_id directorGeneral INT

-- 9 -Crear una nueva tabla llamada Especialidad. Crearle los campos IDESPECILIDAD (autonumerico), NOMBRE, CARACTERISTICA. Indicar el primer campo como clave

CREATE TABLE especialidades (
  id INT PRIMARY KEY AUTO_INCREMENT,
  nombre VARCHAR(255),
  caracteristica VARCHAR(255)
)

-- 10 -  Cargar la tabla con estos tres especialidades

-- IDESPECILIDAD 
-- NOMBRE
-- 1
-- MATEMÁTICA
-- 2
-- INGENIERÍA
-- 3
-- RH

INSERT INTO especialidades (nombre) VALUES ('MATEMÁTICA'),('INGENIERÍA'),('RH')


-- 11- Como relacionarías la tabla EMPLEADOS con ESPECIALIDAD, sabiendo que un empleado puede tener una especialidad pero muchos de ellos pueden compartir especialidad

ALTER TABLE empleados ADD especialidad_id INT;
ALTER TABLE empleados ADD FOREIGN KEY (especialidad_id) references especialidades(id);

-- 12 - Agregar un campo en la tabla empleados con los siguientes datos: numero 450, nombre Mateo, fecha de nacimiento 20/02/2001, fecha de ingreso  15/10/2010, salario 2000, email mateo@gmail.com, comision 100, hijos 2, departamento Direccion General, especialidad RH.
INSERT INTO empleados (id,nombre,fecha_nacimiento,fecha_incorporacion, salario, email,comision, nro_hijos, departamento_id ,especialidad_id) VALUES (450,'Mateo','2001-02-20', "/2010-10-15",2000, 'mateo@gmail.com', 100, 2,100,3)

-- 13 - Cargar el campo especialidad con números aleatorios entre 1 y 3.
-- Tener en cuenta la siguiente ayuda
-- RAND() * (MAX - MIN) + MIN
UPDATE empleados SET especialidad_id = RAND() * (3 - 1) + 1 WHERE especialidad_id IS NULL

-- 14 - Mostrar todos los datos de la tabla Empleados
SELECT * FROM empleados

-- 15 - Mostrar los numeros y nombre de la tabla Empleados ordenados por nombre
SELECT id, nombre FROM empleados ORDER BY nombre

-- 16 - Mostrar  los numeros y nombre de la tabla empleados de aquellos empleados llamados Mateo.
SELECT id, nombre FROM empleados WHERE nombre LIKE '%mateo%'


-- 16-1 Mostrar  los numeros y nombre de la tabla empleados de aquellos empleados llamados Mateo o llamado Julio
SELECT id, nombre FROM empleados WHERE nombre LIKE '%mateo%' OR nombre LIKE '%julia%'

-- 17 -  Mostrar los numeros, nombre y fecha de nacimiento de aquellos empleados nacidos entre el 2000 y el 2005

SELECT id, nombre, fecha_nacimiento FROM empleados 
WHERE YEAR(fecha_nacimiento) BETWEEN 2000 AND 2005

SELECT id as numero, nombre, fecha_nacimiento FROM empleados 
WHERE YEAR(fecha_nacimiento) BETWEEN '2000' AND '2005'

SELECT id, nombre, fecha_nacimiento FROM empleados
WHERE YEAR(fecha_nacimiento) >= 2000 AND YEAR(fecha_nacimiento) <= 2005

-- 18 - Mostrar los numeros, nombre de los empleados , junto al nombre su especialidad.
SELECT empleados.id as numero,
       empleados.nombre,
       especialidades.nombre
FROM empleados, especialidades
WHERE empleados.especialidad_id = especialidades.id 

SELECT empleados.id as numero,
       empleados.nombre as empleado,
       especialidades.nombre as especialidad
FROM empleados
INNER JOIN especialidades ON empleados.especialidad_id = especialidades.id

-- 19 - Mostrar el numero y nombre del empleado, el nombre al departamento que pertenece y el nombre del centro al que pertenece ese departamento

SELECT empleados.id as numero,
       empleados.nombre as empleado,
       departamentos.nombre as departamento,
       centros.nombre as centro
FROM empleados, departamentos, centros
WHERE empleados.departamento_id = departamentos.id AND departamentos.centro_id = centros.id

SELECT empleados.id as numero,
       empleados.nombre as empleado,
       departamentos.nombre as departamento,
       centros.nombre as centro
FROM empleados
INNER JOIN departamentos ON empleados.departamento_id = departamentos.id
INNER JOIN centros ON departamentos.centro_id = centros.id

-- 20 -  Hallar, por orden alfabético, los nombres de los departamentos cuyo tipo de director es en funciones.
SELECT nombre FROM departamentos WHERE tipo_director = 'F' ORDER BY nombre

-- 21 - Obtener un listado telefónico de los empleados incluyendo nombre de empleado, número de empleado y número de teléfono. Por orden alfabético descendente.

SELECT id as numero,
       nombre,
       telefono
FROM empleados 
ORDER BY nombre DESC
       
-- 22 - Obtener un listado telefónico de los empleados del departamento 120 incluyendo nombre de empleado, número de empleado y número de teléfono. Por orden alfabético ascendente.
SELECT id as numero,
       nombre,
       telefono
FROM empleados 
WHERE departamento_id = 120
ORDER BY nombre

-- 23-  Hallar la comisión, nombre y salario de los empleados clasificados por salario, y dentro de salario por orden alfabético.
SELECT nombre,
       salario,
       comision
FROM empleados
ORDER BY  salario, nombre

-- 24-  Hallar la comisión, nombre y salario de los empleados que tienen tres hijos
SELECT nombre, comision, salario FROM empleados WHERE nro_hijos = 3

-- 25 Obtener salario y nombre de los empleados sin hijos y cuyo salario es mayor que 2000 y menor que 2500. 
SELECT salario, nombre FROM empleados WHERE  nro_hijos = 0 AND salario BETWEEN 100000 AND 130000

-- 26 -  Obtener los nombres de los departamentos donde trabajan empleados cuyo salario sea inferior a 1500

SELECT departamentos.nombre as empleado
FROM empleados, departamentos
WHERE empleados.salario < 120000 AND empleados.departamento_id = departamentos.id
GROUP BY departamentos.nombre

SELECT departamentos.nombre 
FROM departamentos
INNER JOIN empleados ON departamentos.id = empleados.departamento_id 
                        AND empleados.salario < 120000
GROUP BY departamentos.nombre

-- Operadores lógicos
-- 27 - Mostrar los empleados cuyo salario sea mayor a 2000 y la comisión sea igual a 0
SELECT * FROM empleados WHERE salario > 100000 AND comision = 0

-- 28 - Mostrar los empleados cuyo salario sea mayor a 2000, pero que la comisión no sea igual a 0
SELECT * FROM empleados WHERE salario > 100000 AND comision != 0

-- Operadores relacionales
-- 29 - Suponiendo que en los próximos dos años el costo de vida va a aumentar un 8 % anual y que se suben los salarios solo un 2 % anual, hallar para los empleados tengan entre 1 y  4 hijos, su nombre y su sueldo actual,sueldo anual y sueldo para cada uno de los próximos dos años  (usar Between)

SELECT nombre,
       salario,
       round(salario * 12, 2) as salario_anual,
       ROUND(salario * 12 * 1.02,2) as salario_primer_aumento,
       ROUND(salario * 12 * 1.02 * 1.02, 2) as salario_segundo_aumento 
FROM empleados
WHERE nro_hijos BETWEEN 1 AND 4

-- 30- Mostrar los numeros y nombres de los empleados cuyo nombre comienza con A.
SELECT id as numero,
       nombre
FROM empleados WHERE nombre like 'a%'

-- 31 -  Mostrar los numeros y nombres de los empleados cuyo nombres sean Mateo, Julio y Luciano (Usar IN)
SELECT id as numero,
       nombres 
FROM empleados
WHERE lower(nombre) IN ('mateo', 'roberto', 'maria')


-- 32 - En una campaña de ayuda familiar se ha decidido dar a los empleados una paga extra de 600 para aquellos que tienen entre 1 y 3 hijos y un salario menor a 2000 . Obtener por orden alfabético para estos empleados: nombre, salario y salario total que van a cobrar incluyendo esta paga extra.

SELECT nombre,
       salario,
       salario + 600 as salario_total,
       nro_hijos
FROM empleados
WHERE nro_hijos BETWEEN 1 AND 3 AND salario < 125000

-- Funciones de agrupamiento
-- 33 . Hallar el salario medio, mínimo y máximo de los empleados de la empresa.
SELECT MAX(salario), MIN(salario), ROUND(AVG(salario), 2) FROM empleados

-- 34.  Hallar el número de empleados de la empresa
SELECT COUNT(id) as nro_empleados FROM empleados

-- 35.  Hallar el número de empleados de la empresa del departamento 120

SELECT COUNT(id) as nro_empleados_dep_120 FROM empleados WHERE departamento_id = 120

-- 36.  Hallar el número de empleados de la empresa del departamento 120 y la suma de las salarios de esos empleados.
SELECT COUNT(id), SUM(salario) FROM empleados WHERE departamento_id = 120

-- 37.  Obtener por orden alfabético los salarios y nombres de los empleados tales que su salario más un 40 % supera al máximo salario.


SELECT nombre, salario
FROM empleados
WHERE salario * 1.40 > (SELECT MAX(salario) FROM empleados) 
      AND salario != (SELECT MAX(salario) FROM empleados)
-- la segunda validacion es porque la query me trae el salario mas alto, y este es al que estoy comparando los demas, por lo tanto no lo quiero en la respuesta.
SELECT MAX(salario) FROM empleados


--usando variables
SET @maximo_salario = SELECT MAX(salario) FROM empleados

SELECT NOMBRE, salario
FROM empleados 
WHERE salario * 1.40 > @maximo_salario AND salario != @maximo_salario


-- 38. Hallar cuántos empleados hay en cada departamento.

SELECT departamento_id, COUNT(id)
FROM empleados 
GROUP BY departamento_id 

-- 39. Hallar para cada departamento el salario medio, el mínimo y el máximo.

SELECT departamento_id, 
       MAX(salario), 
       MIN(salario), 
       ROUND(AVG(salario)) 
FROM empleados
GROUP BY departamento_id

-- 40 - Mostrar la cantidad de empleados que pertenecen al centro “sede central” (tener en cuenta que hay que buscar los empleados que pertenezcan a departamentos de ese centro)

SELECT COUNT(empleados.id) nro_empleados_sede_central
FROM empleados, departamentos, centros
WHERE empleados.departamento_id = departamentos.id 
      AND departamentos.centro_id = centros.id 
      AND centros.nombre LIKE '%sede central%'


-- Consultas con funciones
-- 41 - Crear una campo en empleados que se llame adicionalSueldo, crearlo tipo decimal, con dos decimales. Cargarles números aleatorios entre 100,00 y 250,00.
-- 42 - Mostrar nombre empleados, salario y adicional ordenado por adicional. El adicional debe mostrarse sin decimales.
-- 43 - Igual al anterior pero con un único decimal.
-- 44 - Mostrar nombre de empleados junto al sueldo anual del mismo, tener en cuenta que cada empleado ganará mensualmente el salario más la comisión, más el adicional.

-- 45 -Mostrar el nombre del empleado, el nombre del mes actual Y el salario
-- 46 - Si suponemos que el mes próximo los empleados ganarán un 15 % más en su salario, mostrar el nombre del empleado, el nombre de este mes, el salario de este mes,  el nombre del mes próximo y el salario del mes próximo
-- 47 -  Obtener los nombres de los empleados que cumplen años este mes.
-- 48 - Obtener los nombres y fecha exacta de nacimiento de los empleados cuya fecha de nacimiento es anterior al año 2000.
-- 49 - Obtener los empleados cuyo nacimiento fue en Lunes
-- 50 - Obtener los empleados y su mes de incorporación siempre que esté entre los meses de Enero y Junio (ambos inclusive)
-- 51 - Obtener los nombres y dia, mes y año de la fecha exacta de incorporación de los empleados cuya fecha de incorporación a la empresa es anterior al año 2000. (mostrarlo con el formato de este ejemplo 25 de mayo de 1995)
-- 52 - Cambiar los mails al servidor empresa.com.ar  (por ej si el mail es mateo@gmail.com, deberá quedar mateo@empresa.com.ar
-- 53 - Mostrar los nombres  de los empleados todos a mayusculas y los mails a minusculas
