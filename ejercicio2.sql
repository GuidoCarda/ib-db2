CREATE DATABASE empresaVentas 

CREATE TABLE proveedores (
  id INT PRIMARY KEY AUTO_INCREMENT,
  nombre VARCHAR(25),
  telefono VARCHAR(30),
  pagina_web VARCHAR(30)
)

CREATE TABLE categorias (
  id INT PRIMARY KEY AUTO_INCREMENT,
  nombre VARCHAR(25),
  descripcion VARCHAR(255)
)

CREATE TABLE clientes (
  id INT PRIMARY KEY AUTO_INCREMENT,
  nombre VARCHAR(25),
  calle VARCHAR(20),
  numero INT,
  ciudad VARCHAR(20),
  comuna VARCHAR(20),
)

CREATE TABLE telefonos (
  id INT PRIMARY KEY AUTO_INCREMENT,
  telefono INT,
  cliente_id INT,
  FOREIGN KEY (cliente_id) references clientes(id)
)

CREATE TABLE ventas (
  id INT PRIMARY KEY AUTO_INCREMENT,
  fecha DATETIME,
  descuento INT,
  monto_final INT,
  cliente_id INT,
  FOREIGN KEY (cliente_id) REFERENCES clientes(id)
)

CREATE TABLE productos (
  id INT PRIMARY KEY AUTO_INCREMENT,
  nombre VARCHAR(25),
  precio DECIMAL(10,2),
  stock INT,
  proveedor_id INT,
  categoria_id INT,
  FOREIGN KEY (proveedor_id) REFERENCES proveedores(id),
  FOREIGN KEY (categoria_id) REFERENCES categorias(id)
)

CREATE TABLE productos_ventas (
  id INT PRIMARY KEY AUTO_INCREMENT,
  cantidad INT,
  precio INT,
  monto_total INT,
  venta_id INT,
  producto_id INT,
  FOREIGN KEY (venta_id) REFERENCES ventas(id),
  FOREIGN KEY (producto_id) REFERENCES productos(id)
)

ALTER TABLE proveedores MODIFY COLUMN telefono VARCHAR(25)  
ALTER TABLE telefonos MODIFY COLUMN telefono VARCHAR(25)


ALTER TABLE clientes MODIFY COLUMN numero INT

INSERT INTO categorias (nombre, descripcion) 
VALUES ('teclados','Esta categoria contiene teclados'),
      ('mouses','Esta categoria contiene mouses');


INSERT INTO clientes (nombre, calle, numero, ciudad,comuna)
VALUES ('joanco', 'La juguetona', 69, 'Funes', 'Funes'),
       ('mateo', 'mitre', 3241, 'Rosario', 'Rosario'),
       ('lucas', 'san juan', 2030, 'Rosario', 'Rosario'),
       ('pedro', 'pelegrini', 150, 'Rosario', 'Rosario'),
       ('matias', 'catamarca', 2132, 'Rosario', 'Rosario')

INSERT INTO proveedores (nombre,telefono, pagina_web)
VALUES 
  ('kingstone', '156942341', 'www.kingstone.com'),
  ('logitech', '155423512', 'www.logitech.com'), 
  ('genius', '155423512', 'www.genius.com') 




INSERT INTO productos (nombre, precio, stock, proveedor_id, categoria_id) 
VALUES
  ('teclado g332', 20000,10,1,1),
  ('mouse pepito', 20000,20,1,2),
  ('mouse matrix', 20000,15,2,2),
  ('teclado kumara', 20000,5,3,1),
  ('teclado g348', 20000,10,2,1),


INSERT INTO ventas (monto_final, descuento, cliente_id) 
VALUES
  (5000, 30, 1),
  (10000, 20, 2),
  (12000, 15, 3),
  (8000, 25, 3),
  (22000, 15, 3)



SELECT * FROM productos
SELECT * FROM productos WHERE proveedor_id = 1 OR proveedor_id = 2
SELECT nombre FROM productos WHERE proveedor_id = 1

SELECT p.nombre, c.nombre FROM productos p, categorias c WHERE p.id = 1












