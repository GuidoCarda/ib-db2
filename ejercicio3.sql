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