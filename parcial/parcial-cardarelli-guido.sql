-- 1 Crea una bd
CREATE DATABASE parcial

-- 2 Crear las tablas
CREATE TABLE centros(
  id INT PRIMARY KEY AUTO_INCREMENT,
  nombre VARCHAR(20),
  direccion VARCHAR(20)
)

CREATE TABLE departamentos (
  id INT PRIMARY KEY AUTO_INCREMENT,
  nombre VARCHAR(20),
  direccion VARCHAR(20),
  presupuesto FLOAT,
  centro_id INT,
  FOREIGN KEY (centro_id) REFERENCES centros(id)
)

CREATE TABLE empleados (
  id INT PRIMARY KEY AUTO_INCREMENT,
  nombre VARCHAR(20),
  fecha_nacimiento DATE,
  fecha_ingreso DATE,
  comision FLOAT,
  salario FLOAT,
  nro_hijos INT,
  departamento_id INT,
  FOREIGN KEY (departamento_id) REFERENCES departamentos(id)
)

-- 3 cargar las tablas

INSERT INTO centros (id, nombre, direccion)
VALUES
('0104', 'Oeste', 'avenida 01'),
('0105', 'Este', 'avenida 021'),
('0106', 'Norte', 'avenida 03')

INSERT INTO departamentos (id, centro_id, nombre,direccion, presupuesto )
VALUES
(1,'0104', 'A1', 'avenida 100', 100000),
(2,'0104', 'A2', 'avenida 200', 1500000),
(3,'0105', 'C1', 'avenida 300', 2300000),
(4,'0106', 'D1', 'avenida 400', 220000),
(5,'0106', 'D2', 'avenida 500', 200000)


INSERT INTO EMpleados (id, nombre, fecha_nacimiento, fecha_ingreso, departamento_id, comision, salario, nro_hijos )
VALUES
(10, 'Juan Garcia', '1995/01/15', '2015/01/01', 1, 20000,100000,5),
(20, 'Pedro Perez', '1998/01/10', '2015/10/01', 1, 20000,100000,2),
(30, 'Mariana Gomez', '2000/10/10', '2005/01/01', 2, 15000,100000,1),
(40, 'Mateo Lucca', '2000/10/20','2017/01/01', 3, 17000,50000,25),
(50, 'Nadia Garcia', '2001/11/10','2018/01/01', 3, 15000,85000,5),
(60, 'Mateo Gonzalez', '1995/11/10','2022/01/01',4, 15000,85000,2),
(70, 'Lucas Garcia', '2001/05/10','2018/12/01', 4, 15000,85000,3),
(80, 'Martin Manes', '2001/02/10','2018/01/31', 4, 15000,85000,1)

-- 4 - Mostrar los nombres de los empleados con los datos del departamento en
-- donde trabajan y el centro al que pertenecen. Ordenar por centro

-- Usando where
SELECT empleados.nombre as empleado, 
       departamentos.nombre as departamento, 
       centros.nombre as centro
FROM empleados, departamentos, centros
WHERE empleados.departamento_id = departamentos.id 
      AND departamentos.centro_id = centros.id
ORDER BY centros.id

-- Usando INNER JOIN
SELECT empleados.nombre as empleado, 
       departamentos.nombre as departamento, 
       centros.nombre as centro
FROM empleados
INNER JOIN departamentos ON empleados.departamento_id = departamentos.id
INNER JOIN centros ON departamentos.centro_id = centros.id
ORDER BY centros.id

-- 5 - Subir los sueldos de todos los empleados un 20 porciento.
UPDATE empleados SET salario = salario * 1.20

-- 6 - Contar la cantidad de empleados del departamento A1, mostrar nombre
-- del departamento y cantidadEmpleados
SELECT departamentos.nombre as departamento, 
       COUNT(empleados.id) as cantidad_empleados
FROM empleados, departamentos 
WHERE empleados.departamento_id = departamentos.id 
      AND departamentos.nombre = 'A1' 

-- 7 -Crear una nueva tabla llamada Especialidad. Crearle los campos IDESPECILIDAD y
-- NOMBRE. Indicar el primer campo como clave

CREATE TABLE especialidad (
  id INT PRIMARY KEY AUTO_INCREMENT,
  nombre varchar(50)
)

-- 8- Cargar la tabla con estos dos especialidades
-- 1 Informatica
-- 2 RRHH
INSERT INTO especialidad (id, nombre) VALUES (1, 'Informatica'), (2, 'RRHH')

-- 9- Como relacionarías la tabla EMPLEADOS con ESPECIALIDAD, sabiendo que un
-- empleado puede tener una especialidad pero muchos de ellos pueden compartir
-- especialidad

-- Agregaria la foreign key especialidad_id a la tabla empleados

ALTER TABLE empleados ADD especialidad_id INT;
ALTER TABLE empleados ANDD FOREIGN KEY (especialidad_id) REFERENCES especialidad(id)

-- 10 - Cargar el campo especialidad con números aleatorios entre 1 y 2
-- RAND() * (MAX - MIN) + MIN
UPDATE empleados SET especialidad_id = RAND() * (2 - 1) + 1

-- 11 - Mostrar el id, nombre y fecha de nacimiento y cantidad de hijos de aquellos empleados
-- nacidos entre el 2000 y el 2005; solo mostrar los que tienen màs de 2 hijos

SELECT id, nombre, fecha_nacimiento, nro_hijos
FROM empleados
WHERE YEAR(fecha_nacimiento) BETWEEN 2000 AND 2005 
      AND nro_hijos > 2

-- 12 - Suponiendo que en los próximos dos años el costo de vida va a aumentar un 8 % anual
-- y que se suben los salarios solo un 2 % anual, hallar para los empleados tengan entre 1 y 4
-- hijos su nombre y su sueldo anual, actual y para cada uno de los próximos dos años (usar
-- Between)

SELECT nombre,
       salario,
       salario * 12 as salario_anual,
       ROUND(salario * 12 * 1.02,2) as salario_anual_primer_aumento,
       ROUND(salario * 12 * 1.02 * 1.02) as salario_anual_segundo_aumento
FROM empleados
WHERE nro_hijos BETWEEN 1 AND 4

-- 13 - Hallar el salario medio, mínimo y máximo de los empleados de la empresa.

SELECT MIN(salario) as salario_minimo,
       AVG(salario) as salario_medio,
       MAX(salario) as salario_maximo 
FROM empleados

-- 14 - Guardar en una variable el promedio de los salarios de los empleados. Mostrar aquellos
-- salarios que son mayores al promedio, se debe ver el id del empleado, el nombre, nombre
-- del departamento que trabaja y salario.

SET @promedio_salarios := (SELECT AVG(salario) FROM empleados);

SELECT empleados.id, 
       empleados.nombre,
       departamentos.nombre,
       empleados.salario
FROM empleados, departamentos
WHERE salario > @promedio_salarios 
      AND empleados.departamento_id = departamentos.id

-- 15 -Agregar dos empleados sin departamento. Luego mostrar todos los nombres de
-- empleados empleados sin departamento.

INSERT INTO empleados (id, nombre, fecha_nacimiento, fecha_ingreso, comision, salario, nro_hijos )
VALUES
  (90, 'Joaquin Aparicio', '1995/01/15', '2015/01/01', 20000,150000,5),
  (100, 'Mateo Salguero', '1998/01/10', '2015/10/01', 20000,75000,2),

SELECT nombre as empleados_sin_departamento
FROM empleados
WHERE empleados.departamento_id IS NULL

-- 16 - Contar la cantidad de empleados por departamento, mostrando nombre del
-- departamento y “cantidad de empleados”. Usar Join.

SELECT departamentos.nombre, COUNT(empleados.id) as cantidad_empleados
FROM departamentos
INNER JOIN empleados ON departamentos.id = empleados.departamento_id
GROUP BY departamentos.nombre