CREATE DATABASE IF NOT EXISTS prueba_joins;
USE prueba_joins;

CREATE TABLE empleado(
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  nombre varchar(50) not null,
  apellido varchar(50) not null,
  fecha_nacimiento date not null,
  fecha_contratacion date not null,
  salario int not null,
  id_departamento int UNSIGNED,
  FOREIGN KEY (id_departamento) REFERENCES departamento(id)
);

CREATE TABLE departamento(
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  nombre varchar(50) not null
);

INSERT INTO departamento(nombre) VALUES ('Ventas');
INSERT INTO departamento(nombre) VALUES ('Marketing');
INSERT INTO departamento(nombre) VALUES ('Finanzas');
INSERT INTO departamento(nombre) VALUES ('Recursos Humanos');
INSERT INTO departamento(nombre) VALUES ('Sistemas');

INSERT INTO empleado (nombre, apellido, fecha_nacimiento, fecha_contratacion, salario, id_departamento) 
VALUES ('Juan', 'Perez', '1980-01-01', '2000-01-01', 10000, 1),
        ('Pedro', 'Gomez', '1980-01-01', '2000-01-01', 10000, 1),
        ('Maria', 'Lopez', '1980-01-01', '2000-01-01', 10000, 2),
        ('Jose', 'Gonzalez', '1980-01-01', '2000-01-01', 10000, 2),
        ('Ana', 'Rodriguez', '1980-01-01', '2000-01-01', 10000, null),
        ('Carlos', 'Fernandez', '1980-01-01', '2000-01-01', 10000, null),
        ('Laura', 'Martinez', '1980-01-01', '2000-01-01', 10000, 4),
        ('Luis', 'Sanchez', '1980-01-01', '2000-01-01', 10000, 4),
        ('Andrea', 'Garcia', '1980-01-01', '2000-01-01', 10000, 5),
        ('Jorge', 'Gutierrez', '1980-01-01', '2000-01-01', 10000, 5);


SELECT * FROM empleado;

SELECT * 
FROM empleado
INNER JOIN departamento ON empleado.id_departamento = departamento.id;


SELECT *
FROM empleado
RIGHT JOIN departamento ON empleado.id_departamento = departamento.id


SELECT *
FROM empleado
LEFT JOIN departamento on empleado.id_departamento = departamento.id

SELECT * 
FROM empleado
LEFT JOIN departamento ON empleado.id_departamento = departamento.id
WHERE departamento.id IS NULL


SELECT *
FROM departamento
INNER JOIN empleado ON departamento.id = empleado.id_departamento

SELECT * 
FROM departamento
LEFT JOIN empleado ON departamento.id = empleado.id_departamento

SELECT *
FROM departamento
LEFT JOIN empleado ON departamento.id = empleado.id_departamento
WHERE empleado.id_departamento IS NULL

SELECT *
FROM departamento
RIGHT JOIN empleado ON departamento.id = empleado.id_departamento


