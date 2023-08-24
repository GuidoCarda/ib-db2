CREATE DATABASE stored_procedures1

-- 1 - Crear un procedimiento almacenado que ingresando dos números, nos devuelva el promedio de ambos.
-- You can either return a value
CREATE PROCEDURE average(in num1 int, in num2 int, out result int)
SET result = (num1 + num2) / 2

CALL average(5,123, @result);
SELECT * FROM @result;

-- or dont return anything
DELIMITER $$
CREATE PROCEDURE average2(num1 int,num2 int)
BEGIN 
  DECLARE result INT;
  SET result = (num1 + num2) / 2;
  SELECT result
END
$$
DELIMITER ;

call average2(12,5);

-- 2 - Crear un procedimiento almacenado que reciba un parámetro de entrada/salida con un entero y lo retorne incrementado en 1:
CREATE PROCEDURE increment_by_one(in num int, out result int)
SET result = num + 1

call increment_by_one(10, @result);
SELECT @result;

DELIMITER //
CREATE PROCEDURE increment_by_one_v2(in num int, out result int)
BEGIN
  SET result = num + 1;
END
//
DELIMITER ;

CALL increment_by_one_v2(5,@incremented);
SELECT @incremented;

-- 3 - Confeccionemos un procedimiento almacenado que reciba dos enteros, realize la suma,	y seguidamente ejecute el comando select para recuperar el contenido de dicha variable local:

DELIMITER //
CREATE PROCEDURE get_sum(in num1 int, in num2 int)
BEGIN
  DECLARE result INT;
  SET result = num1 + num2;
  SELECT result;
END
//
DELIMITER ; 

CALL get_sum(5,25);

-- 4- Crear un procedimiento almacenado que muestre el mayor de 2 enteros que le pasamos como parámetro(Usar If):
DELIMITER //
CREATE PROCEDURE get_greater_number(in num1 int, in num2 int )
BEGIN
  DECLARE result INT;
  
  IF(num1>num2)THEN
    SET result = num1;
  ELSE
    SET result = num2;
  END IF;

  SELECT result;
END
//
DELIMITER ;

CALL get_greater_number(20,5);
CALL get_greater_number(20,55);

-- 5 - Crear un procedimiento almacenado que muestre el mayor de 3 enteros(Usar If):

DELIMITER //
CREATE PROCEDURE get_greatest_of_3(in num1 int, in num2 int, in num3 int)
BEGIN
  DECLARE result INT;
  IF(num1 > num2 AND num1 > num3)THEN
    SET result = num1;
  ELSEIF(num2 > num1 AND num2 > num3)THEN
    SET result = num2;
  ELSE
    SET result = num3;
  END IF;

  SELECT result;
END
//
DELIMITER ;

-- 6 - Confeccionar un procedimiento almacenado que le enviemos un entero comprendido entre 1 y 3. El segundo parámetro debe retornar el tipo de medalla que representa dicho número, sabiendo que (Usar Case): Si es 1 muestra “Oro”, si es 2 muestra “plata” y si es 3, muestra “BRonce”

DELIMITER //
CREATE PROCEDURE get_medal(in medalId int, out medal varchar(50))
BEGIN
  CASE medalId
    WHEN 1 THEN SET medal = 'Oro';
    WHEN 2 THEN SET medal = "Plata";
    WHEN 3 THEN SET medal = "Bronce";
    ELSE SET medal = 'Suerte la proxima :p';
  END CASE;
END
//
DELIMITER ;

CALL get_medal(1,@medal1);
SELECT @medal1;

CALL get_medal(2,@medal2);
SELECT @medal2;

CALL get_medal(3,@medal3);
SELECT @medal3;

CALL get_medal(10,@medal4);
SELECT @medal4;

-- 7 - Crear la siguientes tabla

CREATE TABLE libros(
  codigo INT auto_increment,
  titulo VARCHAR(40),
  autor VARCHAR(30),
  editorial VARCHAR(20),
  precio DECIMAL(5,2),
  PRIMARY KEY(codigo) 
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

-- v1
DELIMITER //
CREATE PROCEDURE get_book_count()
BEGIN
  SELECT COUNT(codigo) as cantidad_libros FROM libros;
END
//
DELIMITER ;

-- v2 ( como es una unica linea no es necesario los delimiters y el begin & end)
CREATE PROCEDURE get_book_count_v2()
SELECT COUNT(codigo) as cantidad_libros FROM libros;

CALL get_book_count();
CALL get_book_count_v2();

-- 10 - Crear procedimiento que muestre la cantidad de libros de la editorial X que hay en la bd.(Pasarle el nombre de una editorial)
-- 11 - Recorrer la tabla y buscar la cantidad de veces que aparecen libros del Editorial X, mostrar 0 sino encuentra ninguno, 1 si encuentra 1 y 2 si encuentra más de 1.(no usar Count)
-- 12 - Crear un stored procedure que recibe el nombre de una editorial y luego aumente en un 10% los precios de los libros de tal editorial:
-- 13 - Crear un procedimiento que recibe 2 parámetros, el nombre de una editorial y el valor de incremento:
-- 14 - Crear un procedimiento almacenado que ingrese un nuevo libro en la tabla "libros":
-- 15 - Crear un procedimiento almacenado que recibe el nombre de un autor  y nos retorna la suma de precios de todos sus libros y su promedio

