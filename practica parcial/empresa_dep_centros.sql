CREATE DATABASE practica1

CREATE TABLE centros (
  id INT PRIMARY KEY AUTO_INCREMENT,
  nombre VARCHAR(255),
  direccion VARCHAR(255)
)

CREATE TABLE departamentos(
  id INT PRIMARY KEY AUTO_INCREMENT,
  nombre VARCHAR(255),
  presupuesto DECIMAL(9,2),
  tipo_director ENUM('P', 'F'),
  director_id INT,
  centro_id INT,
  departamento_id INT,
  FOREIGN KEY (director_id) REFERENCES departamentos(id),
  FOREIGN KEY (centro_id) REFERENCES centros(id),
  FOREIGN KEY (departamento_id) REFERENCES departamentos(id)
)

-- DATE FORMAT 'YYYYMMDD' or 'YYMMDD

CREATE TABLE empleados(
  id INT PRIMARY KEY AUTO_INCREMENT,
  nombre VARCHAR(255),
  telefono VARCHAR(10),
  fecha_nacimiento DATE,
  fecha_incorporacion DATE,
  salario DECIMAL(9,2),
  comision DECIMAL(9,2),
  nro_hijos INT UNSIGNED,
  departamento_id INT,
  FOREIGN KEY (departamento_id) REFERENCES departamentos(id)
)

-- inserts

INSERT INTO centros (id,nombre,direccion) 
VALUES (10, 'sede central', 'c/atocha,820,madrid'),
       (20, 'relacion con clientes', 'c/atocha,420,madrid')

INSERT INTO departamentos (id, centro_id,director_id, tipo_director, presupuesto, departamento_id, nombre)
VALUES
  (100,10,260,"P",72,NULL,"DIRECCION GENERAL"),
  (110,20,180,"P",90,100,"DIRECCION COMERCIAL"),
  (111,20,180,"F",66,110,"SECTOR INDUSTRIAL"),
  (112,20,270,"P",54,110,"SECTOR SERVICIOS"),
  (120,10,150,"F",18,100,"ORGANIZACION"),
  (121,10,150,"P",12,120,"PERSONAL"),
  (122,10,350,"P",36,120,"PROCESO DE DATOS"),
  (130,10,310,"P",12,100,"FINANZAS"),

--4 Insertar 12 datos en la tabla empleados

INSERT INTO empleados (nombre, fecha_nacimiento, fecha_incorporacion, salario, comision, nro_hijos, departamento_id, telefono)
VALUES 
("JUAN PEREZ", "1980-08-23", "2022-01-05", 120000, 5000, 2, 100, "555-1234"),
("JOAQUIN VESCO", "2002-09-23", "2021-01-05", 130000, 5000, 0, 110, "555-5678"),
("PEDRO ALCANTAR", "1999-05-25", "2019-02-16", 110000, 0, 0, 111, "555-9876"),
("ROBERTO CARLOS", "1960-03-25", "1988-02-16", 1235000, 100000, 4, 112, "555-2468"),
("MATEO SALGUERO", "2001-09-10", "2023-01-03", 95000, 0, 0, 120, "555-3690"),
("JUAN CARLOS CABUTIA", "1956-10-29", "1980-05-10", 1450000, 75000, 3, 121, "555-1212"),
("LUCAS RAMIREZ", "2001-10-29", "2022-10-05", 110000, 1300, 0, 122, "555-5656"),
("MARIA GOMEZ", "1995-06-10", "2020-05-15", 80000, 2000, 0, 130, "555-7890"),
("MARIO FERNANDEZ", "1985-03-22", "2015-02-10", 95000, 3000, 2, 100, "555-2345"),
("LAURA MARTINEZ", "1990-11-15", "2017-09-20", 105000, 0, 1, 111, "555-8901"),
("CARLOS GONZALEZ", "1978-07-08", "2010-06-01", 125000, 5000, 3, 120, "555-4567"),
("JULIA RODRIGUEZ", "1987-01-20", "2019-11-10", 90000, 1000, 2, 130, "555-6789"),
("ANDRES SANCHEZ", "1998-12-03", "2021-06-05", 110000, 4000, 0, 112, "555-1357")
