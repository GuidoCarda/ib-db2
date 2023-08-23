CREATE DATABASE views1

create table secciones(
  id integer(2) primary key,
  nombre varchar(20),
  sueldo decimal(7,2)
);

create table empleados(
  legajo integer(5),
  documento char(8),
  sexo char(1),
  apellido varchar(20),
  nombre varchar(20),
  domicilio varchar(30),
  seccion_id integer(2) not null,
  cantidad_hijos integer(2),
  estado_civil char(10),
  fecha_ingreso date,
  primary key (legajo),
  foreign key (seccion_id) references secciones(id)
);


insert into secciones values(1,'Administracion',300);
insert into secciones values(2,'Contaduría',400);
insert into secciones values(3,'Sistemas',500);

insert into empleados values(100,'22222222','f','Lopez','Ana','Colon 123',1,2,'casado','2010/10/10');
insert into empleados values(102,'23333333','m','Lopez','Luis','Sucre 235',1,0,'soltero','2011/01/03’');
insert into empleados values(103,'24444444','m','Garcia','Marcos','Sarmiento 1234',2,3,'divorciado','1998/07/02');
insert into empleados values(104,'25555555','m','Gomez','Pablo','Bulnes 321',3,2,'casado','2008/10/10');
insert into empleados values(105,'26666666','f','Perez','Laura','Peru 1254',3,3,'casado','2000/05/09');

-- 1 - Crear una vista que muestre apellido,nombre, documento, domicilio, sexo y  cantidad de hijos de los empleados ordenados por apellido
CREATE VIEW empleados_by_apellido AS
SELECT apellido, 
       nombre, 
       documento,
       domicilio,
       sexo,
       cantidad_hijos 
FROM empelados ORDER BY apellido;


-- 2 - De la vista anterior crear otra vista que solo guarde los datos de los empleados que tengan al menos un hijo
CREATE VIEW empleados_by_apellido_with_hijos AS
SELECT * FROM empleados_by_apellido
WHERE cantidad_hijos > 0;

-- 3 - Crear una vista que muestre el nombre de los empleados, sexo, nombre de las secciones y cantidad de hijos. Mostrarla.
CREATE VIEW empleados_seccion_hijos AS
SELECT empleados.nombre, 
       empleados.sexo,
       empleados.cantidad_hijos,
       secciones.nombre as seccion
FROM empleados
INNER JOIN secciones ON empleados.seccion_id = secciones.id;


-- 4- Usando la vista creada, mostrar el nombre de la sección y la cantidad de empleados de cada una en ellas
SELECT seccion, COUNT(*) as cantidad_empleados 
FROM empleados_seccion_hijos 
GROUP BY seccion;


-- 5 -Crear una vista que guarde el año y la cantidad de empleados que ingresaron ese año
CREATE VIEW ingresos_por_anio AS 
SELECT YEAR(fecha_ingreso) anio_ingreso, 
       COUNT(id) cantidad_ingresos
FROM empleados 
GROUP BY YEAR(fecha_ingreso);


-- 6 - Crear una vista con los datos personales de los empleados que tienen hijos
CREATE VIEW datos_empleados_con_hijos AS
SELECT nombre, apellido, sexo, domicilio, documento, cantidad_hijos
FROM empleados 
WHERE cantidad_hijos > 0;

SELECT * FROM datos_empleados_con_hijos;

-- 7 - 

-- A - Crear una vista con los datos de las secciones.
CREATE VIEW vista_secciones AS 
SELECT * FROM secciones;

SELECT * FROM vista_secciones;

-- B - Agregar a la vista los datos de una nueva sección número 4, nombre ingeniería, sueldo $500. 
INSERT INTO vista_secciones (id,nombre, sueldo) VALUES (4,'ingenieria', 500);

SELECT * FROM vista_secciones;

-- C- Qué sucedió en la tabla secciones?
-- Se agrego el registro con los datos de la nueva seccion
-- Es decir, al modificar una vista, tambien se modifica la tabla original.


-- 8 - Modificar el sueldo agregado a la vista anterior asignándole $800. Que sucede en la tabla
UPDATE vista_secciones SET sueldo = 800 WHERE id = 4;

SELECT * FROM secciones;
SELECT * FROM vista_secciones;

-- La tabla original tambien se ve afectada por el cambio en la vista

-- 9 - Modificar el sueldo de la tabla secciones del código 1 a $900 de sueldo. Qué sucede con la vista?
UPDATE secciones SET sueldo = 900 WHERE id = 1;

SELECT * FROM secciones;
SELECT * FROM vista_secciones;
 
-- 10 - Mostrar la vista sumandole a los sueldos 100$

SELECT id, nombre, sueldo + 100 FROM vista_secciones;
SELECT * FROM vista_secciones;
SELECT * FROM secciones;

