-- A partir del siguiente modelo E/R 

-- 1 - Crear la BD y las tablas
CREATE DATABASE empleados;
USE empleados;

CREATE TABLE departamento (
  codigo INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL,
  presupuesto DOUBLE UNSIGNED NOT NULL,
  gastos DOUBLE UNSIGNED NOT NULL
);

CREATE TABLE empleado (
  codigo INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  nif VARCHAR(9) NOT NULL UNIQUE,
  nombre VARCHAR(100) NOT NULL,
  apellido1 VARCHAR(100) NOT NULL,
  apellido2 VARCHAR(100),
  codigo_departamento INT UNSIGNED,
  FOREIGN KEY (codigo_departamento) REFERENCES departamento(codigo)
);

-- 2 - Insertar los datos

INSERT INTO departamento VALUES(1, 'Desarrollo', 120000, 6000);
INSERT INTO departamento VALUES(2, 'Sistemas', 150000, 21000);
INSERT INTO departamento VALUES(3, 'Recursos Humanos', 280000, 25000);
INSERT INTO departamento VALUES(4, 'Contabilidad', 110000, 3000);
INSERT INTO departamento VALUES(5, 'I+D', 375000, 380000);
INSERT INTO departamento VALUES(6, 'Proyectos', 0, 0);
INSERT INTO departamento VALUES(7, 'Publicidad', 0, 1000);

INSERT INTO empleado VALUES(1, '32481596F', 'Aarón', 'Rivero', 'Gómez', 1);
INSERT INTO empleado VALUES(2, 'Y5575632D', 'Adela', 'Salas', 'Díaz', 2);
INSERT INTO empleado VALUES(3, 'R6970642B', 'Adolfo', 'Rubio', 'Flores', 3);
INSERT INTO empleado VALUES(4, '77705545E', 'Adrián', 'Suárez', NULL, 4);
INSERT INTO empleado VALUES(5, '17087203C', 'Marcos', 'Loyola', 'Méndez', 5);
INSERT INTO empleado VALUES(6, '38382980M', 'María', 'Santana', 'Moreno', 1);
INSERT INTO empleado VALUES(7, '80576669X', 'Pilar', 'Ruiz', NULL, 2);
INSERT INTO empleado VALUES(8, '71651431Z', 'Pepe', 'Ruiz', 'Santana', 3);
INSERT INTO empleado VALUES(9, '56399183D', 'Juan', 'Gómez', 'López', 2);
INSERT INTO empleado VALUES(10, '46384486H', 'Diego','Flores', 'Salas', 5);
INSERT INTO empleado VALUES(11, '67389283A', 'Marta','Herrera', 'Gil', 1);
INSERT INTO empleado VALUES(12, '41234836R', 'Irene','Salas', 'Flores', NULL);
INSERT INTO empleado VALUES(13, '82635162B', 'Juan Antonio','Sáez', 'Guerrero', NULL);
-- 3 - Realizar las siguientes consultas
-- a - Lista el nombre y los apellidos de todos los empleados.

SELECT nombre, apellido1 FROM empleado

-- b - Lista el nombre y apellidos de los empleados en una única columna, convirtiendo todos los caracteres en mayúscula.

SELECT UPPER(CONCAT(nombre,' ',apellido1)) AS nombre_completo  FROM empleado

-- c - Lista el nombre de cada departamento y el valor del presupuesto actual del que dispone. Para calcular este dato tendrá que restar al valor del presupuesto inicial (columna presupuesto) los gastos que se han generado (columna gastos). Tenga en cuenta que en algunos casos pueden existir valores negativos. Utilice un alias apropiado para la nueva columna columna que está calculando.

SELECT nombre, presupuesto - gastos AS presupuesto_actual FROM departamento

-- d - Devuelve una lista con el nombre de los departamentos y el presupuesto, de aquellos que tienen un presupuesto mayor o igual a 150000 euros.

SELECT nombre, presupuesto FROM departamento WHERE presupuesto >= 150000

SELECT nombre, 
       presupuesto - gastos AS presupuesto_actual 
FROM departamento 
WHERE presupuesto - gastos >= 150000

-- e - Devuelve una lista con el nombre de los departamentos y el presupesto, de aquellos que tienen un presupuesto entre 100000 y 200000 euros. Sin utilizar el operador BETWEEN.
SELECT nombre, presupuesto 
FROM departamento
WHERE presupuesto >= 100000 AND presupuesto <= 200000 

-- f - Devuelve una lista con el nombre de los departamentos, gastos y presupuesto, de quellos departamentos donde los gastos sean mayores que el presupuesto del que disponen.
SELECT nombre, presupuesto, gastos
FROM departamento
WHERE gastos > presupuesto


-- g - Lista los nombres, apellidos y nif de los empleados que trabajan en los departamentos 2, 4 o 5.

SELECT nombre, apellido1, apellido2, nif, codigo_departamento 
FROM empleado 
WHERE codigo_departamento IN (2,4,5)


SELECT empleado.nombre,
      empleado.apellido1,
      empleado.apellido2,
      empleado.nif,
      departamento.codigo as codigo_departamento,
      departamento.nombre as nombre_departamento
FROM empleado
INNER JOIN departamento ON empleado.codigo_departamento = departamento.codigo
WHERE empleado.codigo_departamento IN (2,4,5)

SELECT CONCAT(
        empleado.nombre,' ',
        empleado.apellido1,' ', 
        empleado.apellido2
       ) AS empleado,
       empleado.nif,
       departamento.codigo as codigo_departamento,
       departamento.nombre as nombre_departamento
FROM empleado
INNER JOIN departamento ON empleado.codigo_departamento = departamento.codigo
WHERE empleado.codigo_departamento IN (2,4,5)

-- h - Devuelve un listado con los empleados y los datos de los departamentos donde trabaja cada uno. Ordena el resultado, en primer lugar por el nombre del departamento (en orden alfabético) y en segundo lugar por los apellidos y el nombre de los empleados.

SELECT e.nombre,
       e.apellido1,
       e.apellido2,
       d.codigo,
       d.nombre,
       d.presupuesto,
       d.gastos
FROM empleado e
INNER JOIN departamento d ON e.codigo_departamento = d.codigo
ORDER BY d.nombre, e.apellido1, e.apellido2, e.nombre

-- i - Devuelve un listado con el código, el nombre del departamento y el valor del presupuesto actual del que dispone, solamente de aquellos departamentos que tienen empleados. El valor del presupuesto actual lo puede calcular restando al valor del presupuesto inicial (columna presupuesto) el valor de los gastos que ha generado (columna gastos).


SELECT d.codigo, 
       d.nombre, 
       d.presupuesto - d.gastos AS presupuesto_actual
FROM departamento d
INNER JOIN empleado e ON d.codigo = e.codigo_departamento AND e.codigo_departamento IS NOT NULL
GROUP BY d.codigo

-- j - Devuelve el nombre del departamento donde trabaja el empleado Pepe Ruiz Santana.

SELECT departamento.nombre, empleado.nombre, empleado.apellido1, empleado.apellido2
FROM empleado 
INNER JOIN departamento ON empleado.codigo_departamento = departamento.codigo
WHERE empleado.nombre = 'Pepe' 
      AND empleado.apellido1 = 'Ruiz' 
      AND empleado.apellido2 =  'Santana'

-- k - Devuelve un listado con todos los empleados junto con los datos de los departamentos donde trabajan. Este listado también debe incluir los empleados que no tienen ningún departamento asociado.

SELECT * 
FROM empleado e 
LEFT JOIN departamento d ON e.codigo_departamento = d.codigo 

-- l - Devuelve un listado donde sólo aparezcan aquellos empleados que no tienen ningún departamento asociado.
SELECT * 
FROM empleado 
WHERE empleado.codigo_departamento IS NULL;

SELECT * 
FROM empleado e 
LEFT JOIN departamento d ON e.codigo_departamento = d.codigo 
WHERE d.codigo IS NULL;

-- m -Devuelve un listado donde sólo aparezcan aquellos departamentos que no tienen ningún empleado asociado

SELECT * 
FROM departamento d
LEFT JOIN empleado e ON d.codigo = e.codigo_departamento
WHERE e.codigo_departamento IS NULL


-- n - Devuelve un listado con todos los empleados junto con los datos de los departamentos donde trabajan. El listado debe incluir los empleados que no tienen ningún departamento asociado y los departamentos que no tienen ningún empleado asociado. Ordene el listado alfabéticamente por el nombre del departamento.

SELECT *
FROM empleado e
LEFT JOIN departamento d1 ON e.codigo_departamento = d1.codigo
UNION
SELECT *
FROM empleado e
RIGHT JOIN departamento d2 ON e.codigo_departamento = d2.codigo
ORDER BY d.nombre

-- o -Calcula el nombre del departamento y el presupuesto que tiene asignado, del departamento con menor presupuesto.

SELECT nombre, presupuesto FROM departamento ORDER BY presupuesto ASC LIMIT 1

SELECT nombre, presupuesto 
FROM departamento 
WHERE presupuesto = (SELECT MIN(presupuesto) FROM departamento)  

-- p -Calcula el número de empleados que hay en cada departamento. Tienes que devolver dos columnas, una con el nombre del departamento y otra con el número de empleados que tiene asignados.

-- Se devuelven tambien los departamentos que no tienne empleados asignados con un 0
SELECT d.nombre as departamento, 
       COUNT(e.codigo) as cantidad_empleados
FROM departamento d
LEFT JOIN empleado e ON d.codigo = e.codigo_departamento
GROUP BY d.codigo

-- Se devuelven solo los departamentos que tienen empleados asignados
SELECT d.nombre as departamento, 
       COUNT(e.codigo) as cantidad_empleados
FROM departamento d
INNER JOIN empleado e ON d.codigo = e.codigo_departamento
GROUP BY d.codigo


-- q-Calcula el número de empleados que trabajan en cada unos de los departamentos que tienen un presupuesto mayor a 200000 euros.
SELECT d.nombre as departamento,
       COUNT(e.codigo) AS cantidad_empleados,
       d.presupuesto AS presupuesto
FROM departamento d 
LEFT JOIN empleado e ON d.codigo = e.codigo_departamento
WHERE d.presupuesto > 200000
GROUP BY d.codigo



-- r -Devuelve un listado con todos los empleados que tiene el departamento de Sistemas. (Sin utilizar INNER JOIN).

SELECT e.nif, 
       e.nombre, 
       e.apellido1, 
       e.apellido2, 
       d.nombre as departamento
FROM empleado e, departamento d
WHERE e.codigo_departamento = d.codigo 
      AND d.nombre like '%sistemas';


-- s -Devuelve el nombre del departamento con menor presupuesto y la cantidad que tiene asignada.
SELECT nombre, presupuesto 
FROM departamento
ORDER BY presupuesto ASC 
LIMIT 1;

SELECT nombre, presupuesto
FROM departamento
WHERE presupuesto = (SELECT MIN(presupuesto) FROM departamento)

-- t -Devuelve los nombres de los departamentos que tienen empleados asociados. (Utilizando ALL o ANY).

SELECT *
FROM departamento
WHERE codigo = ANY (SELECT codigo_departamento FROM empleado)

-- u -Devuelve los nombres de los departamentos que tienen empleados asociados. (Utilizando IN o NOT IN).

-- mismo resultado en ambos casos
SELECT *
FROM departamento
WHERE codigo IN (SELECT codigo_departamento FROM empleado)

SELECT *
FROM departamento
WHERE codigo IN (SELECT codigo_departamento FROM empleado WHERE codigo_departamento IS NOT NULL)




-- v- Crear procedimiento que muestre la cantidad de empleados que hay en la bd
DELIMITER //
CREATE PROCEDURE obtener_total_empleados()
BEGIN 
  SELECT count(codigo) as total_empleados FROM empleado;
END
//
DELIMITER ;

CALL obtener_total_empleados;


-- w- Crear procedimiento que muestre la cantidad de empleados del departamento Sistemas
DELIMITER //
CREATE PROCEDURE total_empleados_sistemas()
BEGIN 
  SELECT count(empleado.codigo) as total
  FROM empleado
  INNER JOIN departamento ON empleado.codigo_departamento = departamento.codigo
  WHERE departamento.nombre like '%sistemas';
END
//
DELIMITER ;

CALL total_empleados_sistemas;

-- x- Crear un procedimiento almacenado que ingrese un nuevo departamento
DELIMITER //
CREATE PROCEDURE crear_departamento(IN nombre VARCHAR(100), IN presupuesto DOUBLE, IN gastos DOUBLE)
BEGIN 
  INSERT INTO departamento (nombre, presupuesto, gastos) VALUES (nombre, presupuesto, gastos);
END
//
DELIMITER ;

CALL crear_departamento('Gestion de proyectos', 2000, 0);


-- z - Crear una vista que muestre apellido1  y nombre de los empleados ordenados por apellido
CREATE VIEW empleados_ord_apellido AS
SELECT apellido1, nombre 
FROM empleado
ORDER BY apellido1;

-- z2 -  Crear una vista que muestre apellido1, nombre y nombre del departamento de los empleados ordenados por apellido

CREATE VIEW empleados_departamento_ord_apellido AS
SELECT e.apellido1,
       e.nombre,
       d.nombre as departamento
FROM empleado e
INNER JOIN departamento d ON e.codigo_departamento = d.codigo
ORDER BY e.apellido1;





