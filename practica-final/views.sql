-- Una empresa almacena la información de sus empleados en dos tablas llamadas "empleados" y "secciones". Creamos la base de datos y a continuación las dos tablas:

CREATE DATABASE empresa_views;
USE empresa_views;

create table secciones(
  codigo integer(2),
  nombre varchar(20),
  sueldo decimal(7,2),
  primary key (codigo)
);


 create table empleados(
  legajo integer(5),
  documento char(8),
  sexo char(1),
  apellido varchar(20),
  nombre varchar(20),
  domicilio varchar(30),
  seccion integer(2) not null,
  cantidadhijos integer(2),
  estadocivil char(10),
  fechaingreso date,
  primary key (legajo),
  foreign key (seccion) references secciones(codigo)
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

CREATE VIEW empleados_por_apellido AS
SELECT apellido, 
       nombre, 
       documento,
       domicilio,
       sexo, 
       cantidadhijos
FROM empleados
ORDER BY apellido


-- 2 - De la vista anterior crear otra vista que solo guarde los datos de los empleados que tengan al menos un hijo
CREATE VIEW empleados_con_hijos_por_apellido AS
SELECT * 
FROM empleados_por_apellido 
WHERE cantidadhijos > 0;


-- 3 - Crear una vista que muestre el nombre de los empleados, sexo, nombre de las secciones y cantidad de hijos. Mostrarla.

CREATE VIEW empleados_secciones AS
SELECT e.nombre,
       e.apellido,
       e.sexo,
       e.cantidadhijos,
       s.nombre as seccion
FROM empleados e
INNER JOIN secciones s ON e.seccion = s.codigo;

CREATE VIEW empleados_secciones_where AS
SELECT e.nombre,
       e.apellido,
       e.sexo,
       e.cantidadhijos,
       s.nombre as seccion
FROM empleados e, secciones s 
WHERE e.seccion = s.codigo;



SELECT * FROM empleados_secciones;
SELECT * FROM empleados_secciones_where;


-- 4- Usando la vista creada, mostrar el nombre de la sección y la cantidad de empleados de cada una en ellas

SELECT seccion, 
       count(seccion) as cantidad_empleados
FROM empleados_secciones
GROUP BY seccion


-- 5 -Crear una vista que guarde el año y la cantidad de empleados que ingresaron ese año
CREATE VIEW ingresos_por_anio AS
SELECT YEAR(fechaingreso) as anio,
       count(legajo) as ingresos
FROM empleados
GROUP BY YEAR(fechaingreso)

-- 6 - Crear una vista con los datos personales de los empleados que tienen hijos
CREATE VIEW datos_empleados_con_hijos AS
SELECT nombre, 
       apellido, 
       documento, 
       sexo,
       domicilio,
       estadocivil
FROM empleados 
WHERE cantidadhijos > 0;

SELECT * FROM datos_empleados_con_hijos;

-- 7 - 

-- A - Crear una vista con los datos de las secciones.
CREATE VIEW datos_secciones AS
SELECT codigo, nombre, sueldo FROM secciones;

-- B - Agregar a la vista los datos de una nueva sección número 4, nombre ingeniería, sueldo $500.

SELECT * FROM secciones;
SELECT * FROM datos_secciones;

INSERT INTO datos_secciones VALUES(4, 'Ingenieria', 500);

-- C- Qué sucedió en la tabla secciones?

SELECT * FROM secciones;
SELECT * FROM datos_secciones;

-- La tabla secciones se ve modificada


-- 8 - Modificar el sueldo agregado a la vista anterior asignándole $800. Que sucede en la tabla


SELECT * FROM secciones;
SELECT * FROM datos_secciones;

UPDATE datos_secciones SET sueldo = 800 WHERE codigo = 4;

SELECT * FROM secciones;
SELECT * FROM datos_secciones;

-- La tabla original se ve afectada

-- 9 - Modificar el sueldo de la tabla secciones del código 1 a $900 de sueldo. Qué sucede con la vista?
SELECT * FROM secciones;
SELECT * FROM datos_secciones;

UPDATE secciones SET sueldo = 900 WHERE codigo = 1;

SELECT * FROM secciones;
SELECT * FROM datos_secciones;

-- 10 - Mostrar la vista sumandole a los sueldos 100$

SELECT *,
       sueldo + 100
FROM datos_secciones;

SELECT * FROM secciones;
SELECT * FROM datos_secciones;