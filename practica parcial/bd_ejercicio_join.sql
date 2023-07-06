-- En base a la siguiente imagen, crear la bd, las tablas y sus relaciones
-- 1 - Usando el archivo crear la bd, las tablas y cargar los datos como indica el
-- archivo.

CREATE DATABASE bd_ejercicio_join

--EJECUTAR EN ESTE MISMO ORDEN 
CREATE TABLE clientes (
  id	     INT NOT NULL PRIMARY KEY,
  nombre   VARCHAR(100),
  apellido VARCHAR(100),
  dni		 VARCHAR(20),
  correo	 VARCHAR(100)
);

CREATE TABLE proveedores(
  id INT NOT NULL PRIMARY KEY,
  nombre  VARCHAR(100)
);

CREATE TABLE productos(
  id INT  NOT NULL PRIMARY KEY,
  codigo	 CHAR(30),
  nombre	 CHAR(100),
  descripcion CHAR(150),
  proveedor_id INT NOT NULL,
  FOREIGN KEY (proveedor_id ) REFERENCES proveedores(id)
);

CREATE TABLE ventas(
  id INT NOT NULL PRIMARY KEY,
  cliente_id INT NOT NULL,
  fecha DATETIME,
  total INT,
  FOREIGN KEY (cliente_id) REFERENCES clientes(id)
);

CREATE TABLE ventas_detalle(
  id	     INT  NOT NULL PRIMARY KEY,
  venta_id INT NOT NULL,
  producto_id INT NOT NULL,
  cantidad INT,
  FOREIGN KEY (venta_id) REFERENCES ventas(id),
  FOREIGN KEY (producto_id) REFERENCES productos(id)
);

------INSERT----
INSERT INTO CLIENTES (ID,NOMBRE, APELLIDO, DNI, CORREO)
VALUES (1,'JUAN','PEREZ','09876541230','juanperez@correo.com'),
(2,'DIEGO','RUIZ','09658741236','diegoruiz@correo.com'),
(3,'SUSANA','SOUSA','09876541230','susana@correo.com'),
(4,'JUANA','CLARENCE','09876541230','juana@correo.com'),
(5,'SOFIA','ALVARADO','09876541230','sofia@correo.com');

INSERT INTO proveedores (id,NOMBRE)
VALUES (1,'JUAN PEREZ'),
(2,'ROBERTO GONZALEZ');


INSERT INTO VENTAS(ID, cliente_id, FECHA, TOTAL)
VALUES(1, 1,"2021/02/05",500),
(2,1,"2021/02/05",500),
(3,2,"2021/03/05",300),
(4,3,"2021/03/05",800),
(5,2,"2021/06/05",700),
(6,1,"2021/07/05",100),
(7,2,"2021/07/05",260),
(8,4,"2021/08/05",350);

INSERT INTO PRODUCTOS (ID, CODIGO, NOMBRE, DESCRIPCION,proveedor_id)
VALUES(1,'AB-0001','MOUSE WIRELESS','UNO DE LOS MEJORES MOUSE WIRELESS',1),
(2,'CD-0002','TECLADO WIRELESS','UNO DE LOS MEJORES TECLADOS WIRELESS',1),
(3,'FG-0003','PARLANTES ','UNO DE LOS MEJORES PARLANTES DEL MERCADO',2),
(4,'HI-0004','MONITOR GAMER','UNO DE LOS MEJORES MONITORES GAMER',2),
(5,'JK-0005','CPU GAMER','UNO DE LOS MEJORES CPU GAMER',1);

INSERT INTO VENTAS_DETALLE(ID,venta_id,producto_id,CANTIDAD)
VALUES(1,1,1,5),
(2,1,2,4),
(3,1,3,3),
(4,1,1,5),
(5,2,2,1),
(6,2,3,8),
(7,3,2,10),
(8,3,1,11),
(9,4,1,10),
(10,1,1,1);

-- 2 - Mostrar todas las ventas, dejando ver el id de la venta, la fecha y el nombre del
-- cliente. Hacerlo sin usar Join/Usar inner Join/Usar Right Join/Usar left Join
-- SIN JOIN
SELECT ventas.id, ventas.fecha, clientes.nombre
FROM ventas, clientes
WHERE ventas.cliente_id = clientes.id

-- INNER JOIN
SELECT ventas.id, ventas.fecha, clientes.nombre
FROM ventas
INNER JOIN clientes ON ventas.cliente_id = clientes.id

-- RIGHT JOIN
SELECT ventas.id, ventas.fecha, clientes.nombre
FROM clientes
RIGHT JOIN ventas ON clientes.id = ventas.cliente_id

-- LEFT JOIN
SELECT ventas.id, ventas.fecha, clientes.nombre
FROM ventas
LEFT JOIN clientes ON ventas.cliente_id = clientes.id


-- 3 - Agregar el proveedor número 3 que se llama Natalia Perez.
INSERT INTO proveedores (id, nombre) values (3, 'NATALIA PEREZ')  

-- Agregar dos productos nuevos, (6,'RR-0006','CPU','UNO DE LOS MEJORES CPU
-- GAMER',1),(7,'TT-0007','teclado','UNO DE LOS MEJORES TECLADOS',2) ;
INSERT INTO productos (id,codigo,nombre,descripcion,proveedor_id)
VALUES (6,'RR-0006','CPU','UNO DE LOS MEJORES CPU -- GAMER',1),
       (7,'TT-0007','teclado','UNO DE LOS MEJORES TECLADOS',2) ;


-- 4- Mostrar todos los productos con su nombre y el nombre del proveedor, solo
-- mostrar los productos que solo tengan proveedores
SELECT productos.nombre as producto,
       proveedores.nombre as proveedor
FROM productos 
LEFT JOIN proveedores ON productos.proveedor_id = proveedores.id

SELECT productos.nombre as producto,
       proveedores.nombre as proveedor
FROM productos, proveedores 
WHERE productos.proveedor_id = proveedores.id



-- 5- Mostrar los nombres de todos los proveedores junto a los nombres de los
-- productos que proveen cada uno

SELECT proveedores.nombre, productos.nombre
FROM proveedores
RIGHT JOIN productos ON proveedores.id = productos.proveedor_id

-- 6- Mostrar los nombres de todos los proveedores y la cantidad de productos que
-- proveen cada uno

SELECT proveedores.nombre,
       COUNT(productos.id)
FROM proveedores
INNER JOIN productos ON proveedores.id = productos.proveedor_id
GROUP BY proveedores.id


-- 7 - Mostrar por producto, la cantidad total que se vendió en el total de ventas (aún
-- los que no se vendieron)

SELECT productos.nombre, SUM(ventas_detalle.cantidad)
FROM productos
LEFT JOIN ventas_detalle ON productos.id = ventas_detalle.producto_id
GROUP BY productos.id


-- 8 - Detalle de cada una de las ventas (cuantos y que productos fueron registrados
-- en cada venta)

SELECT ventas_detalle.venta_id as venta, 
       productos.nombre as producto, 
       ventas_detalle.cantidad as cantidad
FROM ventas_detalle
INNER JOIN productos ON ventas_detalle.producto_id = productos.id

-- EXTRA Mostrar el id y fecha de aquella venta cuyo total es mayor, hacerlo con variable y con subconsulta
SELECT id, fecha
FROM ventas
WHERE total = (SELECT MAX(total) FROM VENTAS)

SET @max := (SELECT MAX(total) from ventas);
SELECT id, fecha
FROM ventas
WHERE total = @max;

-- 9 - Guardar en una variable el promedio de los totales de ventas. Mostrar aquellas
-- ventas que son mayores al promedio, se debe ver el id de la venta, fecha y nombre
-- del cliente (usar Join).


SET @promedio = (SELECT ROUND(AVG(total)) from ventas);

SELECT ventas.id, ventas.fecha, clientes.nombre, ventas.total
FROM ventas
INNER JOIN clientes ON ventas.cliente_id = clientes.id
WHERE total > @promedio


-- 10 - Realizar la consulta anterior usando subconsulta
SELECT ventas.id, ventas.fecha, clientes.nombre, ventas.total
FROM ventas
INNER JOIN clientes ON ventas.cliente_id = clientes.id
WHERE total > (SELECT ROUND(AVG(total)) FROM ventas)

-- 11 - Guardar el id del producto del cual se vendió la mayor cantidad y mostrar el
-- nombre de su proveedor. (Usar variables y join)

SET @id_producto_mayor := SELECT producto_id FROM ventas_detalle WHERE cantidad = (SELECT MAX(cantidad) FROM ventas_detalle);

SELECT proveedores.nombre
FROM proveedores
INNER JOIN productos ON proveedores.id = productos.proveedor_id
WHERE productos.id = @id_producto_mayor


SELECT @id_mas_vendido := producto_id 
FROM (
  SELECT producto_id ,
         SUM(cantidad) as total_vendido
  FROM ventas_detalle
  GROUP BY producto_id
  ORDER BY total_vendido
  LIMIT 1 
) as ventas_acumuladas

SELECT nombre FROM productos WHERE id = @id_mas_vendido 

-- Mostrar mas vendido mas la cantidad

SELECT ventas_acumuladas.producto_id, productos.nombre, ventas_acumuladas.total_vendido
FROM (
  SELECT producto_id ,
         SUM(cantidad) as total_vendido
  FROM ventas_detalle
  GROUP BY producto_id
  ORDER BY total_vendido
  LIMIT 1 
) as ventas_acumuladas
INNER JOIN productos on ventas_acumuladas.producto_id = productos.id


-- 12 - Mostrar quien es el cliente que compró último. Tener en cuenta que hay que
-- buscar la última venta realizada. (usar subconsultas y join)

SELECT ventas.id, ventas.fecha,clientes.nombre
FROM ventas
INNER JOIN clientes ON ventas.cliente_id = clientes.id
WHERE ventas.fecha = (SELECT MAX (ventas.fecha) from ventas)


-- 13 - Mostrar el listado de productos que provee el proveedor, que tambien provee
-- el producto teclado( o dicho de otra manera, cuáles productos provee el proveedor
-- de los teclados). Usar Subconsultas y join`

SELECT proveedor.id, productos.nombre
FROM productos
INNER JOIN proveedores ON productos.proveedor_id = proveedores.id
WHERE proveedores.id = (SELECT proveedor_id FROM productos WHERE nombre like '%teclado%')