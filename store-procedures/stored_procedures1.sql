CREATE DATABASE stored_procedures1

-- 1 - Crear un procedimiento almacenado que ingresando dos números, nos devuelva el promedio de ambos.
-- You can either return a value
CREATE PROCEDURE average(in num1 int, in num2 int, out result int)
SET result = (num1 + num2) / 2;

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
SET result = num + 1;

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
DELIMITER //
CREATE PROCEDURE get_book_count_by_editorial(in query varchar(255))
BEGIN
  DECLARE book_count INT;
  SELECT COUNT(*) INTO book_count FROM libros WHERE editorial = query;
  SELECT book_count AS cantidad_libros;
END
//
DELIMITER ;

CALL get_book_count_by_editorial("Planeta"); -- > 3

-- 11 - Recorrer la tabla y buscar la cantidad de veces que aparecen libros del Editorial X, mostrar 0 sino encuentra ninguno, 1 si encuentra 1 y 2 si encuentra más de 1.(no usar Count)


DELIMITER //
CREATE PROCEDURE get_book_count_summary_by_editorial(IN query VARCHAR(255))
BEGIN
  DECLARE books_found INT;
  SELECT * FROM libros WHERE editorial = query;
  SET books_found = FOUND_ROWS();

  CASE  
    WHEN books_found > 1 THEN SELECT 2 as resultado;
    WHEN books_found = 1 THEN SELECT 1 as resultado;
    ELSE SELECT 0 as resultado;
  END CASE;

END
//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE get_book_count_summary_by_editorial_v2(IN query VARCHAR(255))
BEGIN
  DECLARE books_found INT;
  SELECT * FROM libros WHERE editorial = query;
  SET books_found = FOUND_ROWS();

  IF (books_found > 1) THEN
    SELECT 2 as resultado;
  ELSEIF (books_found = 1) THEN 
    SELECT 1 as resultado;
  ELSE 
    SELECT 0 as resultado;
  END IF;
END
//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE get_book_count_summary_by_editorial_v3(IN editorialQuery VARCHAR(255))
BEGIN
  DECLARE books_found INT;
  DECLARE result INT;

  SELECT * FROM libros WHERE editorial = editorialQuery;
  SET books_found = FOUND_ROWS();

  IF (books_found > 1) THEN
    SET result = 2;
  ELSEIF (books_found = 1) THEN 
    SET result = 1;
  ELSE 
    SET result = 0;
  END IF;

  SELECT result;
END
//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE get_book_count_summary_by_editorial_v4(IN editorialQuery VARCHAR(255), OUT result INT)
BEGIN
  DECLARE books_found INT;
  SELECT * FROM libros WHERE editorial = editorialQuery;
  SET books_found = FOUND_ROWS();

  IF (books_found > 1) THEN
    SELECT 2 INTO result;
  ELSEIF (books_found = 1) THEN 
    SELECT 1 INTO result;
  ELSE 
    SELECT 0 INTO result;
  END IF;
END
//
DELIMITER ;



-- 12 - Crear un stored procedure que recibe el nombre de una editorial y luego aumente en un 10% los precios de los libros de tal editorial:

DELIMITER //
CREATE PROCEDURE update_books_price_by_editorial(IN editorialQuery VARCHAR(255))
BEGIN 
  UPDATE libros SET precio = precio * 1.10 WHERE editorial = editorialQuery;
END
//
DELIMITER ;
-- 13 - Crear un procedimiento que recibe 2 parámetros, el nombre de una editorial y el valor de incremento:`

DELIMITER //
CREATE PROCEDURE update_books_price_by_editorial_with_value(IN editorialQuery VARCHAR(255), IN increment DOUBLE)
BEGIN
  UPDATE libros SET precio = precio * increment WHERE editorial = editorialQuery;
END
//
DELIMITER ;
-- 14 - Crear un procedimiento almacenado que ingrese un nuevo libro en la tabla "libros":`
DELIMITER //
CREATE PROCEDURE add_book(
  IN titulo VARCHAR(255),
  IN precio DOUBLE,
  IN editorial VARCHAR(255),
  IN autor VARCHAR(255)
)
BEGIN
  INSERT INTO libros (titulo, precio, editorial,autor) VALUES (titulo, precio, editorial,autor);
END
//
DELIMITER ;

call add_book("Atomic habits", 50.25, "Planeta", "James Clear");

-- 15 - Crear un procedimiento almacenado que recibe el nombre de un autor  y nos retorna la suma de precios de todos sus libros y su promedio

DELIMITER //
CREATE PROCEDURE get_author_total_prices_and_average(in autorQuery VARCHAR(255))
BEGIN 
  SELECT SUM(precio) AS total_precios,
         ROUND(AVG(precio),2) AS promedio
  FROM libros 
  WHERE autor = autorQuery;
END
//
DELIMITER ;

call get_author_total_prices_and_average("Richard Bach");

