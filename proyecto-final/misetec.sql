CREATE DATABASE misetec;
USE misetec;

CREATE TABLE tipo_servicio(
  id int primary key auto_increment,
  denominacion varchar(50),
  descripcion varchar(255)
);

CREATE TABLE estado_orden(
  id int primary key auto_increment,
  denominacion varchar(30)
);

CREATE TABLE equipo(
  id int primary key auto_increment,
  marca varchar(50),
  modelo varchar(50),
  tipo varchar(50),
  nro_serie varchar(50)
);

CREATE TABLE orden(
  id int primary key auto_increment,
  fecha_creacion date,
  fecha_finalizacion date,
  falla_equipo varchar(255),
  accesorios varchar(255),
  informe varchar(255),
  tipo_servicio_id int,
  equipo_id int,
  cliente_id int,
  personal_id int,
  foreign key (tipo_servicio_id) references tipo_servicio(id),
  foreign key (equipo_id) references equipo(id),
  foreign key (cliente_id) references cliente(id),
  foreign key (personal_id) references personal(id)
);

CREATE TABLE cliente(
  id int primary key auto_increment,
  nombre varchar(50),
  apellido varchar(50),
  email varchar(50),
  direccion varchar(50),
  telefono varchar(20),
  codigo_postal varchar(10)
);

CREATE TABLE personal(
  id int primary key auto_increment,
  nombre varchar(50),
  apellido varchar(50),
  nombre_usuario varchar(50),
  contrasenia varchar(50)
);

INSERT INTO estado_orden (denominacion) 
VALUES ('sin revisar'),
       ('en reparación'),
       ('reparación terminada'),
       ('pendiente de aprobación de garantía'),
       ('cambiar en garantía'),
       ('emitir nota de crédito');
      


