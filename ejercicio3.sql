CREATE DATABASE ejercicio03

CREATE TABLE productos (
  id VARCHAR(6) PRIMARY KEY,
  nombre VARCHAR(255),
  stock INT,
  dimensiones VARCHAR(255),
   gama_id INT,
  precio_venta DECIMAL(8,2),
  FOREIGN KEY (gama_id) REFERENCES gamas(id)
)

CREATE TABLE gamas (
  id INT PRIMARY KEY AUTO_INCREMENT,
  nombre VARCHAR(50)
)

CREATE TABLE clientes (
  id INT PRIMARY KEY AUTO_INCREMENT,
  nombre VARCHAR(255),
  telefono VARCHAR(255),
  direccion VARCHAR(255),
  ciudad VARCHAR(255),
  limite_cred DECIMAL(8,2)
)

CREATE TABLE oficinas (
  id VARCHAR(7) PRIMARY KEY,
  ciudad VARCHAR(255),
  domicilio VARCHAR(255),
  telefono VARCHAR(255)
)

CREATE TABLE empleados (
  id INT PRIMARY KEY,
  nombre VARCHAR(255), 
  tefono VARCHAR(255),
  direccion VARCHAR(255),
  ciudad VARCHAR(255),
  oficina_id VARCHAR(7),
  jefe_id INT,
  FOREIGN KEY (jefe_id) REFERENCES empleados(id)
  FOREIGN KEY (oficina_id) REFERENCES oficinas(id)
)


CREATE TABLE compras (
  id INT PRIMARY KEY,
  fecha DATE,
  estado VARCHAR(255)
  cliente_id INT,
  empleado_id INT,
  FOREIGN KEY (cliente_id) REFERENCES clientes(id),
  FOREIGN KEY (empleado_id) REFERENCES empleados(id)
)

CREATE TABLE compra_producto(
  id INT PRIMARY KEY AUTO_INCREMENT,
  cantidad INT,
  producto_id INT,
  compra_id INT,
  FOREIGN KEY (producto_id) REFERENCES productos(id),\
  FOREIGN KEY (compra_id) REFERENCES compras(id)
)



INSERT INTO gama VALUES ('10','Plantas para jardin decorativas'), ('20','Herramientas para todo tipo de acción'),('30','Plantas aromáticas'),('40','Árboles pequeños de producción frutal');


INSERT INTO oficina VALUES 
('BCN-ROS','Rosario','341235242','Mitre 333'),
('BCN-FUN','Funes','34111111','San Juan 514'),
('BCN-PER','Perez','34122222','Pelegrini 514'), 
('BCN-ROL','Roldan','3412345667','San Martin 1514');


INSERT INTO empleados VALUES 
(1,'Marcos Perez','3413897','San Juan 514', 'Rosario','BCN-ROL',NULL), 
(2,'Juan Andes','341353421','San Martin 1514', 'Rosario','BCN-ROS',1), 
(3,'Mariana Papalao','341223344','Entre Rios 222', 'Rosario','BCN-PER',1), 
(4,'Daniel Dartes','341223322','San Juan 111', 'Funes','BCN-FUN',1),
(5,'Mariana Paris','341444444','Entre Rios 1222', 'Funes','BCN-FUN',3), 
(6,'Daniel Mariani','341223322','San Juan 11', 'Roldan','BCN-ROL',3), 
(7,'Juana Juarez','341223322','Sarmiento  2211', 'Roldan','BCN-ROL',3);


INSERT INTO clientes VALUES 
(1,'Daniel G','5556901745','False Street 52 2 A','San Francisco',3000),
(2,'Anne Wright','5557410345','Wall-e Avenue 34','USA',19.60),
(3,'Gerudo Valley','5552323129','Oaks Avenue nº22','USA',22.10),
(4,'Juan Perez','5552323129','San juan nº22','Rosario',234.85),
(5,'David Serrano','675598001','Azores 321','Funes',11.50),
(6,'Jose Tacaño','655983045','Fuentes 6252','Rosario',11.20),
(7,'Antonio Lasas','34916540145','Mitre 543','Funes',8.15),
(8,'Akane Tendo','55591233210','Null Street nº69','USA',696.60);

INSERT INTO productos (id,nombre,gama_id, dimensiones, precio_venta, stock) VALUES 
('11679','Sierra de Poda 400MM',20,'0,258',1500.15 ,10),
('21636','Pala',20,'0,156',125.50 , 14),
('22225','Rastrillo de Jardín',20,'1,064',590, 2), 
('AR-001','Ajedrea',40,'15,20',530.50, 7), 
('AR-002','Lavándula Dentata',30,'15,20',550, 5), 
('AR-008','Thymus Citriodra (Tomillo limón)',30,'1,064', 890.50, 20),
('FR-100','Nectarina',40,'8,10',1000.60, 8), 
('FR-16','Calamondin Copa EXTRA Con FRUTA',40,'10,120',990, 11)

INSERT INTO compras VALUES 
(1,'2006-01-17','Entregado',2,1), 
(2,'2007-10-26','Entregado',2,5),
(3,'2008-06-25','Rechazado',1,3), 
(4,'2009-01-26','Pendiente',3,1), 
(8,'2008-11-14','Entregado',3,2), 
(9,'2008-12-27','Entregado',4,1), 
(10,'2009-01-15','Pendiente',4,2), 
(11,'2009-01-20','Pendiente',3,1);

ALTER TABLE compra_producto ADD precio_unidad DECIMAL(5,2);

ALTER TABLE compra_producto ADD numero_linea INT

INSERT INTO compra_producto (id,producto_id, compra_id, cantidad, precio_unidad, numero_linea)  VALUES 
(1,'11679', 10, 5,70.3,1), 
(2,'22225', 10, 3,70.3,2), 
(3,'21636',10,40,43.50,3),
(4,'11679', 8, 5,76.3,1),
(5,'21636', 8, 5,70.3,2), 
(6,'11679', 3, 5,70.3,1), 
(7,'FR-100', 3, 5,78.3,2), 
(8,'AR-008', 3, 5,70.3,3),
(9,'AR-008', 1, 5,170.3,1),
(10,'11679', 1, 5,90.3,2);


-- 1.Devuelve un listado con el código de oficina y la ciudad de la misma. 

SELECT id, ciudad from oficinas

-- 2. Devuelve un listado con la ciudad y el teléfono de las oficinas de Rosario. 

SELECT id, ciudad FROM oficinas WHERE ciudad like 'ros%'


-- 30 Devuelve un listado con el nombre y telefono de los empleados cuyo jefe tiene un código de jefe igual a 1. 


SELECT nombre, tefono FROM empleados WHERE jefe_id = 1

ALTER TABLE empleados CHANGE COLUMN tefono telefono VARCHAR(255)

-- 4. Devuelve un listado con el nombre de los todos los clientes rosarinos.

SELECT nombre FROM clientes WHERE ciudad like "ros%"

-- 5. Devuelve un listado con el nombre de los todos los clientes cuyo límite de crédito esta entre 10 y 300.

SELECT nombre FROM clientes WHERE limite_cred BETWEEN(10 AND 300)
SELECT nombre, limite_cred FROM clientes WHERE limite_cred BETWEEN 10 AND 300

-- 6. Mostrar los pedidos hechos en el  2008. 

SELECT * FROM compras WHERE YEAR(fecha) = 2008 

-- 7. Devuelve un listado con el código de pedido, nombre del cliente y fecha del pedido. (usar Join)

SELECT compras.id, clientes.nombre, compras.fecha FROM compras
INNER JOIN clientes ON clientes.id = compras.cliente_id


-- 8.Mostrar los nombres de los  clientes que no realizaron compras

SELECT clientes.nombre FROM compras
RIGHT JOIN clientes ON compras.cliente_id = clientes.id
WHERE compras.cliente_id IS null

-- SELECT * FROM clientes
-- WHERE (SELECT cliente_id FROM compras)


-- 9. Devuelve un listado con el código de pedido, nombre del cliente, nombre del empleado  y fecha del pedido

SELECT compras.id, clientes.nombre, empleados.nombre, compras.fecha FROM compras
INNER JOIN clientes ON clientes.id = compras.cliente_id
INNER JOIN empleados ON empleados.id = compras.empleado_id

-- 10.  Devuelve un listado con el código de pedido, nombre del cliente, nombre del empleado  y fecha del pedido de los pedidos pendientes

SELECT compras.id, clientes.nombre, empleados.nombre, compras.fecha FROM compras
INNER JOIN clientes ON clientes.id = compras.cliente_id
INNER JOIN empleados ON empleados.id = compras.empleado_id
WHERE compras.estado like 'pendiente%'


SELECT compras.id, 
       clientes.nombre, 
       empleados.nombre, 
       compras.fecha
FROM compras, clientes, empleados
WHERE compras.cliente_id = clientes.id 
      AND compras.empleado_id = empleados.id
      AND compras.estado like 'pendiente%' 


-- 11. Calcula el número de clientes que tiene la empresa. 

SELECT COUNT(id) as cant_clientes from clientes

-- 12 . Mostrar el nombre del cliente que tiene menor límite de crédito y el que tiene mayo límite de crédito

SELECT nombre, limite_cred 
FROM clientes 
WHERE limite_cred = (SELECT min(limite_cred) from clientes) 
      OR  limite_cred = (SELECT max(limite_cred) from clientes)


-- 13 . Contar la cantidad de empleados de cada jefe

SELECT jefe_id ,
       count(id) as cant_empleados 
FROM empleados 
WHERE jefe_id IS NOT NULL 
GROUP BY jefe_id 


-- 14 . Contar la cantidad de empleados de cada jefe, mostrar el nombre del empleado

SELECT cuenta_empleados.jefe_id, empleados.nombre , cant_empleados 
FROM empleados, 
    (
    SELECT jefe_id, count(id) as cant_empleados
    FROM empleados
    WHERE jefe_id IS NOT NULL
    GROUP BY jefe_id
  ) as cuenta_empleados
WHERE empleados.id = cuenta_empleados.jefe_id

-- 15- Agregar a la tabla empleados el campo email.

ALTER TABLE empleados add email varchar(255)

-- 16 -Cargar  los mails de los empleados, se armarán automáticamente de la siguiente manera, nombreDelEMpleado@empresa.com.ar  

UPDATE empleados SET email = CONCAT(nombre, '@empresa.com.ar')
UPDATE empleados SET email = CONCAT(nombre, '@empresa.com.ar')


-- 17 - Subir todos los limites de credito de los clientes en un 5 %

UPDATE clientes SET limite_cred = limite_cred * 1.05


-- 18 -Mostrar los id de pedidos y fechas de aquellos pedidos realizados entre el 2008 y el 2010

SELECT id, fecha FROM compras WHERE YEAR(fecha) BETWEEN 2008 AND 2010

-- 19 - Mostrar los id y nombres de los empleados cuyo nombre comienza con A.

SELECT  id, nombre FROM empleados WHERE nombre like 'm%'

-- 20 - Mostrar los id y nombres de los empleados cuyo nombres sean Daniel  Dartes y Mariana Juarez(Usar IN)

SELECT id, nombre FROM empleados WHERE nombre IN ("Daniel Dartes", "Juan Andes")

-- 20 - Mostrar los nombres de los empleados que son de alguna oficina de la ciudad de Rosario.

SELECT nombre FROM empleados WHERE empleados.oficina_id like '%Ros%'

SELECT empleados.nombre, oficinas.ciudad FROM empleados  
INNER JOIN oficinas ON oficinas.id = empleados.oficina_id
WHERE oficinas.ciudad like '%Ros%'

-- 21 - Mostrar los nombres de los empleados de la empresa, junto al nombre de sus jefes.


--Get unique values
SELECT DISTINCT jefe_id FROM empleados WHERE jefe_id IS NOT NULL


--Id de jefe junto a su nombre 
SELECT empleados.id, empleados.nombre 
FROM empleados,  
     (SELECT DISTINCT jefe_id as id 
      FROM empleados 
      WHERE jefe_id IS NOT NULL
     ) as jefes
WHERE empleados.id = jefes.id


SELECT empleados.nombre as empleado, jefes.nombre as jefe
FROM empleados,
    (
     SELECT empleados.id, empleados.nombre 
     FROM empleados,  
        ( 
          SELECT DISTINCT jefe_id as id 
          FROM empleados 
          WHERE jefe_id IS NOT NULL
        ) as jefes
     WHERE empleados.id = jefes.id
    ) as jefes
WHERE empleados.jefe_id = jefes.id

-- 22 -Mostrar los nombres de los empleados de la empresa, junto al nombre de sus jefes, pero solo los que son de la ciudad de Rosario o de Funes

SELECT empleados.nombre as empleado, 
       jefes.nombre as jefe,
       empleados.ciudad as ciudad_empleado
FROM empleados,
    (
     SELECT empleados.id, empleados.nombre 
     FROM empleados,  
        ( 
          SELECT DISTINCT jefe_id as id 
          FROM empleados 
          WHERE jefe_id IS NOT NULL
        ) as jefes
     WHERE empleados.id = jefes.id
    ) as jefes
WHERE empleados.jefe_id = jefes.id AND empleados.ciudad IN ('Rosario', 'Funes')


-- 23- Mostrar los nombres de los empleados de la empresa, junto al nombre de sus jefes, pero solo los que son de la ciudad de Rosario o de Funes y cuyo jefe sea "Marcos Perez"


SELECT empleados.nombre as empleado, 
       jefes.nombre as jefe,
       empleados.ciudad as ciudad_empleado
FROM empleados,
    (
     SELECT empleados.id, empleados.nombre 
     FROM empleados,  
        ( 
          SELECT DISTINCT jefe_id as id 
          FROM empleados 
          WHERE jefe_id IS NOT NULL
        ) as jefes
     WHERE empleados.id = jefes.id
    ) as jefes
WHERE empleados.jefe_id = jefes.id 
      AND empleados.ciudad IN ('Rosario', 'Funes')
      AND jefes.nombre = "Marcos Perez"



-- 24. Contar la cantidad de pedidos de cada estado

SELECT estado, COUNT(id) as cantidad FROM compras GROUP BY estado

-- 25 - Crear la tabla ciudad, que contenga codPostal y nombre de ciudad. Cargar con 4 ciudades. (Rosario, Funes, Roldan y Perez)

CREATE TABLE ciudades(
  id INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(255)
)

--   26. Crear una tabla llamada ciudad que contenga codpostal y nombre de ciudad, cargar con 4 ciudades (Rosario, Funes, Roldan y perez)

CREATE TABLE ciudades (
  id INT PRIMARY KEY AUTO_INCREMENT,
  nombre VARCHAR(255),
)

INSERT INTO ciudades (nombre) VALUES ('Rosario'), ('Funes'), ('Roldan'),('Perez')

-- 26 modificar los campos ciudad de la tabla de clientes y de empleados, cambiandolo por codPostal
ALTER TABLE empleados CHANGE ciudad cod_postal INT
ALTER TABLE empleados CHANGE ciudad cod_postal INT


-- 27 . Relacionar Ciudad con Clientes y ciudad con empleados
ALTER TABLE clientes 
ADD FOREIGN KEY (cod_postal) REFERENCES ciudades(id)

ALTER TABLE empleados
ADD FOREIGN KEY (cod_postal) REFERENCES ciudades(id)


-- 28 - Cargar la tabla empleados según el siguiente criterio:
-- 	Si la oficina  es   BCN-ROS será Rosario
--       Si la oficina  es   BCN-Fun será Funes
-- 	Etc

UPDATE empleados SET cod_postal = 1 WHERE oficina_id like '%ros%';
UPDATE empleados SET cod_postal = 2 WHERE oficina_id like '%fun%';
UPDATE empleados SET cod_postal = 3 WHERE oficina_id like '%rol%';


-- 29 - Suponiendo que en los próximos dos meses el precio de los productos va a aumentar un 8 % mensual, mostrar para los productos que tienen un stock superior a 0, su precio actual, el del mes próximo y el de dentro de dos meses; Ordenado por el precio actual. 

SELECT precio_venta, 
       ROUND(precio_venta * 1.08, 2) as mes_proximo,
       ROUND(precio_venta * 1.08 * 1.08,2) as dentro_dos_meses
FROM productos
WHERE stock > 0 
ORDER BY precio_venta


-- 30 -  Hallar el número de productos de gama Plantas aromáticas  y la suma de los precio de venta de todos ellos.

SELECT COUNT(productos.id) as cantidad_productos, 
       SUM(productos.precio_venta) as total_precio_venta 
FROM productos
INNER JOIN gamas ON productos.gama_id = gamas.id
WHERE gamas.nombre like '%plantas aromaticas%'


SELECT COUNT(productos.id) as cantidad_productos,
       SUM(productos.precio_venta) as total_precio_venta
FROM productos, gamas
WHERE productos.gama_id = gamas.id 
      AND gamas.nombre like '%plantas aromaticas%'