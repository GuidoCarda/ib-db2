-- 1 - Crear un procedimiento almacenado que ingresando dos números, nos devuelva el promedio de ambos.

CREATE PROCEDURE promedio(num1 int, num2 int, out resultado int)
SET resultado = (num1 + num2) / 2

call promedio(5,10,@resultado);
SELECT @resultado;

-- 2 - Crear un procedimiento almacenado que reciba un parámetro de entrada/salida con un entero y lo retorne incrementado en 1:

CREATE PROCEDURE incrementarUno(in num int, out resultado int )
SET resultado = num + 1


CALL incrementarUno(10, @resultado);
SELECT @resultado;


-- 3 - Confeccionemos un procedimiento almacenado que reciba dos enteros, 	y seguidamente ejecute el comando select para recuperar el contenido de dicha variable local:
 

DELIMITER $$
CREATE PROCEDURE getSum(num1 INT, num2 INT)
BEGIN
	DECLARE sum INT;
	SET sum = num1 + num2;
END
$$
DELIMITER ;



-- 4- Crear un procedimiento almacenado que muestre el mayor de 2 enteros que le pasamos como parámetro(Usar If):


-- 5 - Crear un procedimiento almacenado que muestre el mayor de 3 enteros(Usar If):


-- 6 - Confeccionar un procedimiento almacenado que le enviemos un entero comprendido entre 1 y 3. El segundo parámetro debe retornar el tipo de medalla que representa dicho número, sabiendo que (Usar Case): Si es 1 muestra “Oro”, si es 2 muestra “plata” y si es 3, muestra “BRonce”
