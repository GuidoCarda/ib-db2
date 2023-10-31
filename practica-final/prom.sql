CREATE DATABASE empresa_dptos;
USE empresa_dptos;

CREATE TABLE centros(
  id int unsigned primary key auto_increment,
  nombre varchar(20),
  direccion varchar(20)
);

CREATE TABLE departamentos(
  id int unsigned primary key auto_increment,
  nombre varchar(20),
  direccion varchar(20),
  presupuesto float,
  centro_id int unsigned,
  FOREIGN KEY (centro_id) REFERENCES centros(id)
);

CREATE TABLE empleados(
  id int unsigned primary key auto_increment,
  nombre varchar(20),
  fecha_nacimiento date,
  fecha_ingreso date,
  salario float,
  comision float,
  nro_hijos int,
  departamento_id int unsigned,
  FOREIGN KEY (departamento_id) REFERENCES departamentos(id)
);

INSERT INTO centros (id, nombre, direccion)
VALUES  ('0104', 'Oeste', 'avenida 01'),
        ('0105', 'Este', 'avenida 021'),
        ('0106', 'Norte', 'avenida 03');

INSERT INTO departamentos (id, centro_id, nombre ,direccion, presupuesto )
VALUES
      (1,'0104', 'A1', 'avenida 100', 100000),
      (2,'0104', 'A2', 'avenida 200', 1500000),
      (3,'0105', 'C1', 'avenida 300', 2300000),
      (4,'0106', 'D1', 'avenida 400', 220000),
      (5,'0106', 'D2', 'avenida 500', 200000)

INSERT INTO empleados (id, Nombre, fecha_nacimiento, fecha_ingreso, departamento, comision, salario, nro_hijos )
VALUES
      (10, 'Juan Garcia', '1995/01/15', '2015/01/01', 1, 20000,100000,5),
      (20, 'Pedro Perez', '1998/01/10', '2015/10/01', 1, 20000,100000,2),
      (30, 'Mariana Gomez', '2000/10/10', '2005/01/01', 2, 15000,100000,1),
      (40, 'Mateo Lucca', '2000/10/20','2017/01/01', 3, 17000,50000,25),
      (50, 'Nadia Garcia', '2001/11/10','2018/01/01', 3, 15000,85000,5),
      (60, 'Mateo Gonzalez', '1995/11/10','2022/01/01',4, 15000,85000,2),
      (70, 'Lucas Garcia', '2001/05/10','2018/12/01', 4, 15000,85000,3),
      (80, 'Martin Manes', '2001/02/10','2018/01/31', 4, 15000,85000,1);

-- 4 - Mostrar los nombres de los empleados con los datos del departamento en
-- donde trabajan y el centro al que pertenecen. Ordenar por centro. 
SELECT * FROM empleados;
SELECT * FROM departamentos;
SELECT * FROM centros;

-- Using joins
SELECT e.nombre as empleado, 
       d.nombre as departamento, 
       c.nombre as centro
FROM empleados e
INNER JOIN departamentos d ON e.departamento_id = d.id
INNER JOIN centros c ON d.centro_id = c.id;

-- Using where clause
SELECT e.nombre as empleado,
       d.nombre as departamento,
       c.nombre as centro
FROM empleados e, departamentos d, centros c
WHERE e.departamento_id = d.id AND d.centro_id = c.id;


-- 5 - Subir los sueldos de todos los empleados un 20 porciento.
SELECT nombre, salario FROM empleados;
UPDATE empleados SET salario = salario * 1.20;
SELECT nombre, salario FROM empleados;

-- 6 - Contar la cantidad de empleados del departamento A1, mostrar nombre
-- del departamento y cantidadEmpleados.

SELECT d.nombre as departamento,
       count(e.id) as cantidadEmpleados
FROM empleados e
INNER JOIN departamentos d ON e.departamento_id = d.id
WHERE d.nombre like '%a1'
GROUP BY departamento_id;

-- 7 -Crear una nueva tabla llamada Especialidad. Crearle los campos IDESPECILIDAD y
-- NOMBRE. Indicar el primer campo como clave

CREATE TABLE especialidad(
  id int unsigned primary key auto_increment,
  nombre varchar(50)
);


-- 8- Cargar la tabla con estos dos especialidades
-- 1 Informatica
-- 2 RRHH

INSERT INTO especialidad (nombre) VALUES ('Informatica'),('RRHH');

-- 9- Como relacionarías la tabla EMPLEADOS con ESPECIALIDAD, sabiendo que un
-- empleado puede tener una especialidad pero muchos de ellos pueden compartir
-- especialidad

-- Agregaria el campo especialidad a la tabla empleados, ya que se trata de una relacion 1 a n, donde cada empleado tiene una especialidad, pero una especialidad puede ser compartida por muchos empleados

ALTER TABLE empleados ADD especialidad_id INT UNSIGNED;
ALTER TABLE empleados ADD FOREIGN KEY (especialidad_id) REFERENCES especialidad(id);

-- 10 - Cargar el campo especialidad con números aleatorios entre 1 y 2

UPDATE empleados SET especialidad_id = CEIL(RAND() * 2);

-- 11 - Mostrar el id, nombre y fecha de nacimiento y cantidad de hijos de aquellos empleados
-- nacidos entre el 2000 y el 2005; solo mostrar los que tienen màs de 2 hijos

SELECT e.id, 
       e.nombre,
       e.fecha_nacimiento,
       e.nro_hijos
FROM empleados e
WHERE YEAR(e.fecha_nacimiento) BETWEEN 2000 AND 2005
      AND e.nro_hijos > 2;

-- 12 - Suponiendo que en los próximos dos años el costo de vida va a aumentar un 8 % anual
-- y que se suben los salarios solo un 2 % anual, hallar para los empleados tengan entre 1 y 4
-- hijos su nombre y su sueldo anual, actual y para cada uno de los próximos dos años (usar
-- Between)
SELECT e.nombre,
       e.salario * 12 as salario_anual,
       e.salario as salario_actual,
       e.salario * 1.02 * 12 as primer_anio,
       e.salario * 1.02 * 1.02 * 12 as segundo_anio
FROM empleados e
WHERE e.nro_hijos BETWEEN 1 AND 5;

-- 13 - Hallar el salario medio, mínimo y máximo de los empleados de la empresa.

SELECT MIN(salario), AVG(salario), MAX(salario) FROM empleados;

-- 14 - Guardar en una variable el promedio de los salarios de los empleados. Mostrar aquellos
-- salarios que son mayores al promedio, se debe ver el id del empleado, el nombre, nombre
-- del departamento que trabaja y salario.

SET @promedio_salarios = (SELECT AVG(salario) FROM empleados);
SET @promedio_salarios := (SELECT AVG(salario) FROM empleados);

SELECT e.id, 
       e.nombre,
       d.nombre,
       e.salario
FROM empleados e
INNER JOIN departamentos d ON e.departamento_id = d.id
WHERE salario > @promedio_salarios;


-- Con subselect
SELECT e.id, 
       e.nombre,
       d.nombre,
       e.salario
FROM empleados e
INNER JOIN departamentos d ON e.departamento_id = d.id
WHERE salario > (SELECT AVG(salario) FROM empleados);


-- 15 -Agregar dos empleados sin departamento. Luego mostrar todos los nombres de
-- empleados empleados sin departamento.


INSERT INTO empleados (id, nombre, fecha_nacimiento, fecha_ingreso, departamento_id, comision, salario, nro_hijos, especialidad_id)
VALUES
      (90, 'Joaquin Vesco', '2001/05/10','2018/12/01', null, 15000,85000,3,1),
      (100, 'Mateo Salguero', '2002/08/25','2018/01/31', null, 15000,85000,1,2);


SELECT nombre FROM empleados WHERE departamento_id IS NULL;

SELECT e.nombre
FROM empleados e
LEFT JOIN departamentos d ON e.departamento_id = d.id
WHERE e.departamento_id IS NULL;

-- 16 - Contar la cantidad de empleados por departamento, mostrando nombre del
-- departamento y “cantidad de empleados”. Usar Join.
SELECT d.nombre AS departamento,
       COUNT(e.id) AS 'cantidad de empleados'
FROM empleados e
INNER JOIN departamentos d ON e.departamento_id = d.id
GROUP BY e.departamento_id;

-- 17 - Crear una vista que muestre el nombre de los empleados, nombre del centro y
-- cantidad de hijos.

  CREATE VIEW v_empleados_centro_hijos AS
  SELECT e.nombre AS empleado,
         e.nro_hijos AS hijos,
         c.nombre AS centro
  FROM empleados e
  INNER JOIN departamentos d on e.departamento_id = d.id
  INNER JOIN centros c on d.centro_id = c.id;

-- 18 - Usando la vista creada, mostrar el nombre del centro y la cantidad de empleados de cada una en ellas

SELECT * FROM v_empleados_centro_hijos;

SELECT centro, 
       count(centro) cantidad_empleados
FROM v_empleados_centro_hijos
GROUP BY centro;

-- 19 - Crear un stored procedure que recibe el nombre del departamento y luego aumente en un
-- 10% los presupuestos de ese departamento

CREATE PROCEDURE sp_aumentar_presupuesto_dpto(IN departamento VARCHAR(20)) 
UPDATE departamentos SET presupuesto = presupuesto * 1.10 WHERE nombre = departamento;

CALL sp_aumentar_presupuesto_dpto('A1');
CALL sp_aumentar_presupuesto_dpto('C1');
CALL sp_aumentar_presupuesto_dpto('A1');