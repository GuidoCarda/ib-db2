-- Crear la siguiente bd con sus tablas

CREATE DATABASE  stored_procedures2;
USE stored_procedures2;

CREATE TABLE alumno (
  id INT PRIMARY KEY AUTO_INCREMENT,
  nombre VARCHAR(20) NOT NULL,
  apellido VARCHAR(20) NOT NULL,
  fecha_nac  DATE,
  edad INT 
);


INSERT INTO alumno VALUES (NULL,'Guillem','Homet','1992/12/20',NULL);
INSERT INTO alumno VALUES (NULL,'Marta','Ros','1993/01/21',NULL);
INSERT INTO alumno VALUES (NULL,'Miquel','RodrÃ­guez','1990/10/11',NULL);


CREATE TABLE profesor(
  id INT PRIMARY KEY AUTO_INCREMENT,
  nombre VARCHAR(20) NOT NULL,
  apellido VARCHAR(20) NOT NULL,
  fecha_nac DATE,
  edad INT
);

INSERT INTO profesor VALUES (NULL,'Maria','Ribas','1985/10/06',NULL);
INSERT INTO profesor VALUES (NULL,'Carles','Pujol','1978/06/14',NULL);

-- 1 - Crea un procedimiento almacenado que busque todos los alumnos cuyo nombre comience con una letra determinada. Para ejecutar se usa por ejemplo CALL buscar('R%');

DELIMITER //
CREATE PROCEDURE buscar(in letra VARCHAR(255))
BEGIN
  SELECT * FROM alumno WHERE nombre like letra; 
END
//
DELIMITER ;

CALL buscar('M%');

-- 2 - Crea un procedimiento que busque los profesores por nombre y apellido. Primero debe preguntar si el primer parametro es nulo, buscara por apellido; si el primer parámetro es nulo, buscará por nombre; y si ninguno es nulo, buscara por nombre y apellido.

DELIMITER //
CREATE PROCEDURE buscar_profesores(in c_nombre varchar(255), in c_apellido varchar(255))
BEGIN 
  IF c_nombre is NOT NULL AND c_apellido is NOT NULL THEN
    SELECT * FROM profesor WHERE nombre = c_nombre AND apellido = c_apellido;
  ELSEIF c_nombre is NOT NULL THEN
    SELECT * FROM profesor WHERE nombre = c_nombre;
  ELSE 
    SELECT * FROM profesor WHERE apellido = c_apellido;
  END IF;
END 
//
DEIMITER ;

CALL buscar_profesores('Maria', NULL);
CALL buscar_profesores(NULL, 'Ribas');
CALL buscar_profesores('Carles', 'Pujol');
CALL buscar_profesores('Carles', 'Ribas');


-- 3 -  Crea un procedimento que incremente el valor del codi en un valor que nosotros le enviemos como parámetro.

DELIMITER //
CREATE PROCEDURE incrementar_ids(in valor int)
BEGIN 
  	UPDATE alumno SET id = id + valor;
END
//
DELIMITER ; 

-- 4 - Crea un procedimeno al cual se le envie como parámetro, primeramente la tabla a la que se quiere agregar elementos, en segundo lugar dichos elementos para nombre, apellido y fecha de nacimiento. Por último el procedimiento deberá  determine si es si los datos se agregarán en la tabla de alumnos o profesor, según sea el primer parametro
  
DELIMITER //
CREATE PROCEDURE insertar_registro(
  in tabla varchar(15),
  in n varchar(30),
  in a varchar(30),
  in fn DATE
) 
BEGIN
  IF TABLA == 'alumno' THEN
    INSERT INTO alumno VALUES (null, n, a, fn);
  ELSEIF TABLA == 'profesor' THEN
    INSERT INTO profesor VALUES (null, n, a, fn);
  END IF;
END
//
DELIMITER;

-- 5 - Modificar la fecha de un alumno cuyo codigo se pasa como parámetro
-- 6 - Mostrar la edad de un profesor o alumno cuyo codigo se pasa como parámetro
    
-- 7 - Eliminar los alumnos cuyos codigos esten comprendidos entre dos números pasados como parámetros (por ejemplo los alumnos cuyo codigo tienen entre 3 y 5, o sea 3,4 y 5)
-- 8 - Crear un procedimiento almacenado que cargue datos de nuevos alumnos. Cargar como mínimo 3 alumnos

-- 9 - calcular las edades de los alumnos y los docentes y cargarlas en la bd
