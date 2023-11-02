

-- 1. Devuelve un listado de los empleados cuyo puesto es “Representante
-- de ventas”, mostrando nombre y apellido del empleado, código de
-- oficina y ciudad donde se encuentra la misma.

SELECT e.nombre, 
       e.apellido1, 
       o.codigo_oficina,
       o.ciudad,
       e.puesto
FROM empleado e
INNER JOIN oficina o
ON e.codigo_oficina = o.codigo_oficina
WHERE e.puesto = 'Representante Ventas';

-- 2. Devuelve un listado con el código de cliente de aquellos clientes que
-- realizaron algún pago en 2008. Tenga en cuenta que deberá eliminar
-- aquellos códigos de cliente que aparezcan repetidos.


-- Opcion 1
SELECT DISTINCT p.codigo_cliente
FROM pago p
WHERE YEAR(p.fecha_pago) = 2008;

-- Opcion 2
SELECT p.codigo_cliente
FROM pago p
WHERE YEAR(p.fecha_pago) = 2008
GROUP BY p.codigo_cliente;


-- 3. Devuelve un listado con el código de pedido, código de cliente, fecha
-- esperada y fecha de entrega de los pedidos que no han sido entregados
-- a tiempo y se han rechazado.

SELECT p.codigo_pedido ,
       p.codigo_cliente ,
       p.fecha_esperada,
       p.fecha_entrega 
FROM pedido p
WHERE p.fecha_esperada < p.fecha_entrega
AND p.estado = 'Rechazado';

-- 4. Devuelve un listado que muestre el nombre de cada empleados y el
-- nombre de su jefe

-- USANDO JOIN
SELECT CONCAT(e.nombre, ' ',  e.apellido1,' ',  e.apellido2) as empleado,
       CONCAT( j.nombre,' ', j.apellido1,' ', j.apellido2) as jefe
FROM empleado e
INNER JOIN empleado j ON e.codigo_jefe = j.codigo_empleado;

-- USANDO SUBSELECT
SELECT CONCAT(e.nombre, ' ',  e.apellido1,' ',  e.apellido2)  AS empleado,
       CONCAT( j.nombre,' ', j.apellido1, ' ', j.apellido2) as jefe
FROM 
  empleado e,
  (
  SELECT codigo_empleado,
         nombre,
         apellido1,
         apellido2
  FROM empleado
  ) as j
WHERE e.codigo_jefe = j.codigo_empleado;


-- 5. Devuelve la descripción de la gama de los productos y la cantidad de
-- productos que hay de cada uno

SELECT gp.descripcion_texto,
       COUNT(p.codigo_producto) as cantidad
FROM gama_producto gp
INNER JOIN producto p ON gp.gama = p.gama
GROUP BY p.gama;

-- 6. Mostrar quien es el cliente que compró último. Tener en cuenta que hay
-- que buscar el ultimo pedido realizada. (usar subconsultas y join)

-- Mostrando TODOS los datos del cliente
SELECT c.*
FROM pedido p
INNER JOIN cliente c ON p.codigo_cliente = c.codigo_cliente
WHERE p.fecha_pedido = (SELECT MAX(p2.fecha_pedido) FROM pedido p2);

-- Mostrando algunos datos del cliente y del pedido
SELECT c.codigo_cliente, c.nombre_cliente, p.fecha_pedido, p.codigo_pedido
FROM pedido p
INNER JOIN cliente c ON p.codigo_cliente = c.codigo_cliente
WHERE p.fecha_pedido = (SELECT MAX(p2.fecha_pedido) FROM pedido p2);


-- 7. Crear un stored procedure que recibe la gama X y luego aumente en un
-- 10% los precios de venta de los productos que son de esa
-- gama(mostrar nombre del producto, gama, y precio de venta del
-- producto antes de la ejecución del procedimiento y luego después de la
-- ejecución )

DELIMITER //
CREATE PROCEDURE aumentar_precio(IN gama VARCHAR(50))
BEGIN
    
  UPDATE producto p
  SET p.precio_venta = p.precio_venta * 1.1
  WHERE p.gama = gama;

END //
DELIMITER ;

SELECT p.nombre, p.gama, p.precio_venta
FROM producto p
WHERE p.gama = 'Frutales';

CALL aumentar_precio('Frutales');

SELECT p.nombre, p.gama, p.precio_venta
FROM producto p
WHERE p.gama = 'Frutales';

-- 8. Crear un trigger que antes de guardar una nueva gama, convierta los datos a mayusculas
-- (gama, descripcion_texto, descripción_html)

DELIMITER //
CREATE TRIGGER insertar_gama_en_mayusculas BEFORE INSERT ON gama_producto FOR EACH ROW
BEGIN
  SET NEW.gama = UPPER(NEW.gama);
  SET NEW.descripcion_texto = UPPER(NEW.descripcion_texto);
  SET NEW.descripcion_html = UPPER(NEW.descripcion_html);
END //
DELIMITER ;

INSERT INTO gama_producto (gama, descripcion_texto, descripcion_html) 
VALUES ('Abono', 'Sustancia que se echa en la tierra laborable para que aumente su fertilidad', '<p>Sustancia que se echa en la tierra laborable para que aumente su fertilidad<p>');