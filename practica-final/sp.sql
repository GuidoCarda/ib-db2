
CREATE DATABASE libreria_sp;
USE libreria_sp;

-- 1 - Crear un procedimiento almacenado que ingresando dos números, nos devuelva el promedio de ambos.


DELIMITER //
CREATE PROCEDURE sp_promedio_v1(IN num1 INT, IN num2 INT)
BEGIN
  SELECT ROUND((num1 + num2) / 2) as promedio;
END
//
DELIMITER ;


DELIMITER //
CREATE PROCEDURE sp_promedio_v2(IN num1 INT, IN num2 INT)
BEGIN
  DECLARE result INT;
  SET result = ROUND((num1 + num2) / 2);
  SELECT result;
END
//
DELIMITER ;


DELIMITER //
CREATE PROCEDURE sp_promedio_v3(IN num1 INT, IN num2 INT, OUT result INT)
BEGIN
  SET result = ROUND((num1 + num2) / 2);
END
//
DELIMITER ;

CALL sp_promedio_v1(2,30);
CALL sp_promedio_v2(2,30);
CALL sp_promedio_v3(2,30,@result);
SELECT @result;


-- 2 - Crear un procedimiento almacenado que reciba un parámetro de entrada/salida con un entero y lo retorne incrementado en 1:
CREATE PROCEDURE sp_incrementar_uno(IN num INT, OUT result INT)
SET result = num + 1;

CALL sp_incrementar_uno(5, @result);
SELECT @result;


-- 3 - Confeccionemos un procedimiento almacenado que reciba dos enteros, realize la suma,	y seguidamente ejecute el comando select para recuperar el contenido de dicha variable local:
DELIMITER //
CREATE PROCEDURE sp_obtener_suma(IN num1 INT, IN num2 INT)
BEGIN
  DECLARE result INT;
  SET result = num1 + num2;
  SELECT result;
END
//
DELIMITER ;

CALL sp_obtener_suma(5,24);


-- 4- Crear un procedimiento almacenado que muestre el mayor de 2 enteros que le pasamos como parámetro(Usar If):

DELIMITER //
CREATE PROCEDURE sp_obtener_mayor(IN num1 INT, IN num2 INT)
BEGIN
  IF num1 > num2 THEN
    SELECT num1 as mayor;
  ELSE
    SELECT num2 as mayor;
  END IF;
END
//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_obtener_mayor_v2(IN num1 INT, IN num2 INT)
BEGIN 
  DECLARE mayor INT;
  IF num1 > num2 THEN
    SET mayor = num1;
  ELSE
    SET mayor = num2;
  END IF;

  SELECT mayor;
END
//
DELIMITER ;

CALL sp_obtener_mayor(2,10);
CALL sp_obtener_mayor_v2(2,10);
CALL sp_obtener_mayor(40,10);
CALL sp_obtener_mayor_v2(40,10);

-- 5 - Crear un procedimiento almacenado que muestre el mayor de 3 enteros(Usar If):
DELIMITER //
CREATE PROCEDURE sp_obtener_mayor_de_tres(IN num1 INT,IN num2 INT,IN num3 INT)
BEGIN
  DECLARE mayor INT;
  
  IF num1 > num2 AND num1 > num3 THEN
    SET mayor = num1;
  ELSEIF num2 > num1 AND num2 > num3 THEN
    SET mayor = num2;
  ELSE
    SET mayor = num3;
  END IF;
  
  SELECT mayor;
END
// 
DELIMITER ;


CALL sp_obtener_mayor_de_tres(1,2,3);
CALL sp_obtener_mayor_de_tres(1,3,2);
CALL sp_obtener_mayor_de_tres(2,1,3);
CALL sp_obtener_mayor_de_tres(2,3,1);
CALL sp_obtener_mayor_de_tres(3,1,2);
CALL sp_obtener_mayor_de_tres(3,2,1);


 -- 6 - Confeccionar un procedimiento almacenado que le enviemos un entero comprendido entre 1 y 3. El segundo parámetro debe retornar el tipo de medalla que representa dicho número, sabiendo que (Usar Case): Si es 1 muestra “Oro”, si es 2 muestra “plata” y si es 3, muestra “BRonce”
 
DELIMITER //
CREATE PROCEDURE sp_obtener_medalla_v1(IN posicion INT, OUT medalla VARCHAR(10))
BEGIN 
  CASE posicion
    WHEN 1 THEN SET medalla = 'Oro';
    WHEN 2 THEN SET medalla = 'Plata';
    ELSE SET medalla = 'bronce';
  END CASE;
END
// 
DELIMITER ;

CALL sp_obtener_medalla_v1(1, @medalla);
SELECT @medalla;

CALL sp_obtener_medalla_v1(2, @medalla2);
SELECT @medalla2;

CALL sp_obtener_medalla_v1(3, @medalla3);
SELECT @medalla3;



-- 7 - Crear la siguientes tabla

create table libros(
  codigo int auto_increment,
  titulo varchar(40),
  autor varchar(30),
  editorial varchar(20),
  precio decimal(5,2),
  primary key(codigo) 
 );

 insert into libros (titulo,autor,editorial,precio) 
  values ('Uno','Richard Bach','Planeta',15);
 insert into libros (titulo,autor,editorial,precio) 
  values ('Ilusiones','Richard Bach','Planeta',12);
 insert into libros (titulo,autor,editorial,precio) 
  values ('El aleph','Borges','Emece',25);
 insert into libros (titulo,autor,editorial,precio) 
  values ('Aprenda PHP','Mario Molina','Nuevo siglo',50);
 insert into libros (titulo,autor,editorial,precio) 
  values ('Matematica estas ahi','Paenza','Nuevo siglo',18);
 insert into libros (titulo,autor,editorial,precio) 
  values ('Puente al infinito','Bach Richard','Sudamericana',14);
 insert into libros (titulo,autor,editorial,precio) 
  values ('Antología','J. L. Borges','Paidos',24);
 insert into libros (titulo,autor,editorial,precio) 
  values ('Java en 10 minutos','Mario Molina','Siglo XXI',45);
 insert into libros (titulo,autor,editorial,precio) 
  values ('Cervantes y el quijote','Borges- Casares','Planeta',34);

-- 9 - Crear procedimiento que muestre la cantidad de libros que hay en la bd
CREATE PROCEDURE sp_cantidad_libros()
SELECT count(codigo) as 'cantidad de libros' FROM libros;

CALL sp_cantidad_libros;

-- 10 - Crear procedimiento que muestre la cantidad de libros de la editorial X que hay en la bd.(Pasarle el nombre de una editorial)
CREATE PROCEDURE sp_cantidad_libros_editorial(IN consulta VARCHAR(20))
SELECT count(codigo) as total FROM libros WHERE editorial = consulta;

CREATE PROCEDURE sp_cantidad_libros_editorial_v2(IN consulta VARCHAR(20), OUT total INT)
SET total = (SELECT count(codigo) FROM libros WHERE editorial = consulta);


CALL sp_cantidad_libros_editorial('Planeta');
CALL sp_cantidad_libros_editorial_v2('Planeta', @total);
SELECT @total;

-- 11 - Recorrer la tabla y buscar la cantidad de veces que aparecen libros del Editorial X, mostrar 0 sino encuentra ninguno, 1 si encuentra 1 y 2 si encuentra más de 1.(no usar Count)
DELIMITER //
CREATE PROCEDURE sp_existencia_editorial(IN consulta VARCHAR(20))
BEGIN
  DECLARE libros_encontrados INT;
  SELECT * FROM libros WHERE editorial = consulta;
  SET libros_encontrados = FOUND_ROWS();

  CASE
    WHEN libros_encontrados > 1 THEN SELECT 2 AS resultado;
    WHEN libros_encontrados = 1 THEN SELECT 1 AS resultado;
    ELSE SELECT 0 as resultado;
  END CASE;
END
//
DELIMITER ;

CALL sp_existencia_editorial('Planeta');



-- 12 - Crear un stored procedure que recibe el nombre de una editorial y luego aumente en un 10% los precios de los libros de tal editorial:
-- 13 - Crear un procedimiento que recibe 2 parámetros, el nombre de una editorial y el valor de incremento:
-- 14 - Crear un procedimiento almacenado que ingrese un nuevo libro en la tabla "libros":
-- 15 - Crear un procedimiento almacenado que recibe el nombre de un autor  y nos retorna la suma de precios de todos sus libros y su promedio
