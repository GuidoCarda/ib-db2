CREATE TABLE tareas(
  id INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(255)
)

CREATE TABLE localidades(
  id INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(255)
)

CREATE TABLE tipos_articulos(
  id INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(255)
)

CREATE TABLE modelos(
  id INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(255),
  tipo_articulo_id INT,
  FOREIGN KEY (tipo_articulo_id) REFERENCES tipos_articulos(id)
)

CREATE TABLE articulos(
  id INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(255),
  costo DECIMAL(8,2),
  modelo_id INT,
  FOREIGN KEY (modelo_id) REFERENCES modelos(id)
)


CREATE TABLE sucursales(
  id INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(255),
  localidad_id INT,
  FOREIGN KEY (localidad_id) REFERENCES localidades(id)
)

CREATE TABLE proveedores(
  id INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(255),
  sucursal_id INT,
  FOREIGN KEY (sucursal_id) REFERENCES sucursales(id)
)

CREATE TABLE empleados(
  id INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(255),
  sueldo DECIMAL(8,2),
  edad INT,
  sucursal_id INT,
  tarea_id INT,
  FOREIGN KEY (sucursal_id) REFERENCES sucursales(id),
  FOREIGN KEY (tarea_id) REFERENCES tareas(id)
)

CREATE TABLE proveedores_articulos(
  id INT AUTO_INCREMENT PRIMARY KEY,
  proveedor_id INT,
  articulo_id INT,
  FOREIGN KEY (proveedor_id) REFERENCES proveedores(id),
  FOREIGN KEY (articulo_id) REFERENCES articulos(id)
)




-- 2 sucursales que se encuentran en  2 localidades diferentes 
INSERT INTO localidades (nombre) VALUES ('rosario'),('funes'),('roldan')
INSERT INTO sucursales (nombre, localidad_id) VALUES ('casa central', 1), ('funes', 2)

-- En la sucursal 1 hay 5 empleados y en la 2, 3 empleados.
INSERT INTO empleados (nombre, sueldo, edad, sucursal_id, tarea_id) 
VALUES  ('Juan Perez', 2500, 30, 1, 1),
  ('María López', 3000, 35, 1, 2),
  ('Carlos Ramirez', 2000, 28, 1, 3),
  ('Ana Martínez', 2800, 32, 1, 1),
  ('Pedro González', 2200, 27, 1, 3),
  ('Luisa Torres', 2600, 31, 2, 2),
  ('Andrés Herrera', 1900, 26, 2, 3),
  ('Sofía Jiménez', 2400, 29, 2, 1);


-- Hay 3 tipos de tareas.
INSERT INTO tareas VALUES ('ventas'),('inventarios'),('finanzas')



-- Hay 3 proveedores, el primero distribuye 2 artículos, el segundo distribuye 3 y el tercero distribuye también 2 artículos.Hay 2 tipos de artículos(tipo A:regular y B:modelable).

INSERT INTO proveedores (nombre, sucursal_id)
VALUES
  ('Proveedor 1', 1),
  ('Proveedor 2', 2),
  ('Proveedor 3', 1);

-- Hay 3 modelos de tipos de articulos (x,Y, Z). Podemos tener articulos de tipo A y modelo X, o de Tipo A y modelo Y, o de tipo B y modelo X, etc
INSERT INTO tipos_articulos (nombre) VALUES ('A'),('B') 
INSERT INTO modelos (nombre, tipo_articulo_id) VALUES ('X',1),('X',2),('Y',1),('Y',2),('Z',1),('Z',2)


INSERT INTO articulos (nombre, modelo_id)
VALUES
  ('Laptop', 1),
  ('Laptop Gaming', 1),
  ('Monitor', 2),
  ('Monitor Curvo', 2),
  ('Teclado', 3),
  ('Teclado Inalámbrico', 3),
  ('Mouse', 4),
  ('Mouse Ergonómico', 4),
  ('Impresora', 5),
  ('Impresora Multifuncional', 5),
  ('Router', 6),
  ('Router WiFi', 6);


INSERT INTO proveedores_articulos (proveedor_id, articulo_id)
VALUES
  (1, 1),
  (1, 2),
  (2, 3),
  (2, 4),
  (2, 5),
  (3, 6),
  (3, 7);


UPDATE articulos SET costo = FLOOR(RAND() * (1000 - 100 + 1) + 100);

-- 1. Mostrar el listado de articulos solamente de aquellos artículos cuyo costo es mayor a $150 y menor a $300.

SELECT *
FROM articulos
WHERE costo BETWEEN 150 AND 300

-- 2. Mostrar id, nombre y sueldo de los empleados cuyo sueldo es mayor a el empleado cuyo nombre es Juan Perez.

SELECT id, nombre, sueldo
FROM empleados
WHERE sueldo > (SELECT sueldo FROM empleados WHERE nombre like '%juan p%')

-- 3. Mostrar el  id, nombre y sueldo del empleado que más cobra.

SELECT nombre, sueldo from empleados order by sueldo desc limit 1

SELECT nombre, sueldo
FROM empleados
WHERE sueldo = ( SELECT MAX(sueldo) from empleados ) 


-- 4. Mostrar el  id, nombre y sueldo de los empleados cuyo salario supera al máximo salario de los empleados de la sucursal 1

SELECT id, nombre, sueldo 
FROM empleados
WHERE sueldo > (SELECT MAX(SALARIO) FROM empleados WHERE sucursal_id = 1)

SELECT MAX(SALARIO) FROM empleados WHERE sucursal_id = 1

-- 5. Obtener los nombres y salarios de los empleados cuyo salario coincide con la comisión multiplicada por 10 de algún otro o la suya propia.
-- 6. Obtener los nombres y el salario de los empleados de la sucursal 1 si en ella hay alguno que gane más de $130000
-- 7. Mostrar el id, nombre y edad de los empleados cuyo sueldo es mayor a $200000 y ordenado por edad.
-- 8. Mostrar el id, nombre de los articulos agrupados por tipos.
-- 9. Mostrar el id, nombre de los articulos agrupados por tipos y modelos.
-- 10. Mostrar el id, nombre y suma de los costos de los articulos agrupados por tipos y modelos.
