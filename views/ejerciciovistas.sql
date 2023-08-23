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

CREATE VIEW vista_empleados AS SELECT apellido, nombre, documento, domicilio, sexo, cantidadhijos FROM empleados ORDER BY apellido

FROM * FROM vista_empleados

-- 2 - De la vista anterior crear otra vista que solo guarde los datos de los empleados que tengan al menos un hijo

CREATE VIEW empleados_con_hijos AS SELECT * FROM vista_empleados WHERE cantidadhijos >= 1

SELECT * FROM empleados_con_hijos

-- 3 - Crear una vista que muestre el nombre de los empleados, sexo, nombre de las secciones y cantidad de hijos. Mostrarla.

CREATE VIEW vista_tres AS 
SELECT empleados.nombre, 
       empleados.sexo, 
       empleados.cantidadhijos,
       secciones.nombre as seccion
FROM empleados, secciones
WHERE empleados.seccion = secciones.codigo

-- Con join
CREATE VIEW vista_tres AS 
SELECT empleados.nombre, 
       empleados.sexo, 
       empleados.cantidadhijos,
       secciones.nombre as seccion
FROM empleados
INNER JOIN secciones ON secciones.codigo = empleados.seccion 

SELECT * FROM vista_tres

-- 4- Usando la vista creada, mostrar el nombre de la sección y la cantidad de empleados de cada una en ellas

SELECT seccion, COUNT(*) FROM vista_tres GROUP BY seccion

-- 5 -Crear una vista que guarde el año y la cantidad de empleados que ingresaron ese año

CREATE VIEW vista_ingresantes AS 
SELECT YEAR(fechaingreso), COUNT(*) 
FROM empleados 
GROUP BY YEAR(fechaingreso)

SELECT * FROM vista_ingresantes


-- 6 - Crear una vista con los datos personales de los empleados que tienen hijos
   CREATE VIEW vista_datos_personales AS 
  SELECT documento ,sexo ,
  apellido,
  nombre,
  domicilio,
  estadocivil
  FROM empleados
  WHERE cantidadhijos >= 1;

  SELECT * FROM vista_datos_personales;


-- 7 - 

-- A - Crear una vista con los datos de las secciones.
-- B - Agregar a la vista los datos de una nueva sección número 4, nombre ingeniería, sueldo $500. 

CREATE VIEW vista_secciones AS SELECT * FROM secciones

INSERT INTO vista_secciones (codigo,nombre,sueldo) VALUES (4, 'ingenieria', 500)
INSERT INTO secciones (codigo,nombre,sueldo) VALUES (5, 'filosofia', 10)


SELECT * FROM vista_secciones

-- C- Qué sucedió en la tabla secciones?
--Se agrego la seccion ingenieria

-- 8 - Modificar el sueldo agregado a la vista anterior asignándole $800. Que sucede en la tabla

UPDATE vista_secciones SET sueldo = 800 WHERE codigo = 4

-- 9 - Modificar el sueldo de la tabla secciones del código 1 a $900 de sueldo. Qué sucede con la vista?

UPDATE secciones SET sueldo = 900 WHERE codigo = 1
-- Se actualizan los dos pai
 
-- 10 - Mostrar la vista sumandole a los sueldos 100$

SELECT codigo, nombre, (sueldo + 100) as sueldo_aumentado FROM vista_secciones
