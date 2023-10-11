Create database triggers1;
use triggers1;

create table libros(
  codigo int,
  titulo varchar(40),
  autor varchar(30),
  editorial varchar(20),
  precio decimal(6,2)
 );

 create table ofertas(
  titulo varchar(40),
  autor varchar(30),
  precio decimal(6,2)
 );

 create table control(
  usuario varchar(30),
  fecha datetime
 );

-- 1-Crear un disparador que se dispare cada vez que se ingrese un registro en "libros"; el trigger debe ingresar en la tabla "control", el nombre del usuario(CURRENT_USER), la fecha en la cual se realizó un "insert" sobre "libros":

CREATE TRIGGER tr_registro_libro AFTER INSERT ON libros FOR EACH ROW
INSERT INTO control (usuario, fecha, operacion) VALUES (CURRENT_USER,now(), 'insert');


-- Probar:
-- insert into libros values(100,'Uno','Richard Bach',"",25);
--  Verificar si se agrego un registro en control
-- Agregar 4 libros.

insert into libros values(102,'Dos','Richard Bach',"",25);
insert into libros values(103,'Tres','Richard Bach',"",25);
insert into libros values(104,'Cuatro','Richard Bach',"",25);
insert into libros values(105,'Cinco','Richard Bach',"",25);

-- 2-Crear un trigger que se dispare cada vez que se borre un registro de "libros"; el trigger debe ingresar en la tabla "control", el nombre del usuario, la fecha y la hora en la cual se realizó un "delete" sobre "libros":

CREATE TRIGGER tr_eliminacion_libro AFTER DELETE ON libros FOR EACH ROW
INSERT INTO control (usuario, fecha, operacion) VALUES (CURRENT_USER, now(), 'delete');

-- Probar:
delete from libros where codigo<100;
--  Verificar si se agrego un registro en control por cada delete hecho


-- 3 - Agregar un campo a la tabla control,llamada operación, luego modificar los trigger para que se cargue el tipo de operación realizada.

ALTER TABLE control ADD operacion VARCHAR(50);  

-- CREATE TRIGGER tr_control_operacion AFTER ON control FOR EACH ROW


-- 4 - Crear un trigger que antes de guardar cada dato, convertimos los datos a mayusculas (titulo del libro y editorial del libro) usando la función UPPER


DELIMITER //
CREATE TRIGGER tr_insert_mayusculas BEFORE INSERT ON libros FOR EACH ROW
BEGIN 
  SET new.titulo = UPPER(new.titulo);
  SET new.editorial = UPPER(new.editorial);
END;
//
DELIMITER ;
-- Probar
-- insert into libros values(200,'Uno','Richard Bach',"emece",25);
-- Controlar la tabla libros y confirmar si el registro agregado se agrega en mayusculas el titulo y el editorial

-- 5 - Crear un trigger que antes de guardar cada dato, verifique si el precio del libro nuevo es mayor a 100, guarde 100; sino guarde el numero enviado como parámetro. 


DELIMITER //
CREATE TRIGGER tr_controlar_precio BEFORE INSERT ON libros FOR EACH ROW
BEGIN
  IF(new.precio > 100) THEN
    SET new.precio = 100;
  END IF;
END;
//
DELIMITER ;

-- Probar
-- insert into libros values(100,'Uno','Richard Bach',"emece",250);
-- Controlar la tabla libros y confirmar si el registro agregado se agrega tiene un precio = a 100.

-- 6- Agregar un campo stock de tipo integer a la tabla libros y luego agregar los siguientes libros: 
insert into libros(codigo,titulo, autor, editorial, precio, stock)
  values(1,'Uno','Richard Bach','Planeta',15,100);   
 insert into libros(codigo,titulo, autor, editorial, precio, stock)
  values(2,'Ilusiones','Richard Bach','Planeta',18,50);
 insert into libros(codigo,titulo, autor, editorial, precio, stock)
  values(3,'El aleph','Borges','Emece',25,200);
 insert into libros(tcodigo,itulo, autor, editorial, precio, stock)
  values(4,'Aprenda PHP','Mario Molina','Emece',45,200);

ALTER TABLE libros ADD stock INT;

-- Ahora Agregar una tabla ventas:
create table ventas(
  numero int auto_increment,
  codigolibro int,
  precio float,
  cantidad int,
  primary key (numero)
 );

-- Por último crear un trigger que al agregar un registro en ventas se reduzca el stock en la tabla libros del libro vendido

DELIMITER //
CREATE TRIGGER tr_controlar_stock AFTER INSERT ON ventas FOR EACH ROW
BEGIN 
  UPDATE libros SET stock = stock - new.cantidad WHERE codigo = new.codigoLibro;
END;
//
DELIMITER ;

-- Probar
insert into ventas(codigolibro, precio, cantidad) values(1, 15, 4);

-- 7 - Igual al anterior pero además deberá modificar el precio del libro al precio vendido


DELIMITER //
CREATE TRIGGER tr_actualizar_a_precio_venta AFTER INSERT ON ventas FOR EACH ROW
BEGIN
  UPDATE libros SET stock = stock - new.cantidad WHERE codigo = new.codigoLibro;
  UPDATE libros SET precio = new.precio WHERE codigo = new.codigoLibro;
END;
//
DELIMITER ; 


insert into ventas(codigolibro, precio, cantidad) values(3, 40, 10);
