-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 04-05-2023 a las 16:28:29
-- Versión del servidor: 10.4.27-MariaDB
-- Versión de PHP: 8.2.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `empresax`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `centros`
--

CREATE TABLE `centros` (
  `id` int(11) NOT NULL,
  `nombre` varchar(50) DEFAULT NULL,
  `direccion` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `centros`
--

INSERT INTO `centros` (`id`, `nombre`, `direccion`) VALUES
(10, 'SEDE CENTRAL', 'C/ ATOCHA, 820, MADRID'),
(20, 'RELACION CON CLIENTES', 'C/ ATOCHA, 405, MADRID');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `departamentos`
--

CREATE TABLE `departamentos` (
  `id` int(11) NOT NULL,
  `director_id` int(11) DEFAULT NULL,
  `centro_id` int(11) DEFAULT NULL,
  `departamento_id` int(11) DEFAULT NULL,
  `tipo_director` enum('P','F') DEFAULT NULL,
  `presupuesto` float DEFAULT NULL,
  `nombre` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `departamentos`
--

INSERT INTO `departamentos` (`id`, `director_id`, `centro_id`, `departamento_id`, `tipo_director`, `presupuesto`, `nombre`) VALUES
(100, 260, 10, NULL, 'P', 72, 'DIRECCION GENERAL'),
(110, 180, 20, 100, 'P', 90, 'DIRECCION COMERCIAL'),
(111, 180, 20, 110, 'F', 66, 'SECTOR INDUSTRIAL'),
(112, 270, 20, 110, 'P', 54, 'SECTOR SERVICIOS'),
(120, 150, 10, 100, 'F', 18, 'ORGANIZACION'),
(121, 150, 10, 120, 'P', 12, 'PERSONAL'),
(122, 350, 10, 120, 'P', 36, 'PROCESO DE DATOS'),
(130, 310, 10, 100, 'P', 12, 'FINANZAS');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `empleados`
--

CREATE TABLE `empleados` (
  `id` int(11) NOT NULL,
  `nombre` varchar(30) DEFAULT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `fecha_nacimiento` date DEFAULT NULL,
  `fecha_incorporacion` date DEFAULT NULL,
  `salario` float DEFAULT NULL,
  `comision` float DEFAULT NULL,
  `nro_hijos` int(11) DEFAULT NULL CHECK (`nro_hijos` >= 0),
  `departamento_id` int(11) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `especialidad_id` int(11) DEFAULT NULL,
  `adicional_sueldo` decimal(5,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `empleados`
--

INSERT INTO `empleados` (`id`, `nombre`, `telefono`, `fecha_nacimiento`, `fecha_incorporacion`, `salario`, `comision`, `nro_hijos`, `departamento_id`, `email`, `especialidad_id`, `adicional_sueldo`) VALUES
(1, 'JUAN PEREZ', '555-1234', '1980-08-23', '2022-01-05', 2576, 5000, 2, 100, 'JUANPEREZ@empresa.com.ar', 3, '161.99'),
(2, 'JOAQUIN VESCO', '555-5678', '2002-09-23', '2021-01-05', 1321, 5000, 0, 110, 'JOAQUINVESCO@empresa.com.ar', 2, '231.24'),
(3, 'PEDRO ALCANTAR', '555-9876', '1999-05-25', '2019-02-16', 1876, 0, 0, 111, 'PEDROALCANTAR@empresa.com.ar', 2, '120.24'),
(4, 'ROBERTO CARLOS', '555-2468', '1960-03-25', '1988-02-16', 4420, 100000, 4, 112, 'ROBERTOCARLOS@empresa.com.ar', 1, '107.49'),
(5, 'MATEO SALGUERO', '555-3690', '2001-09-10', '2023-01-03', 3471, 0, 0, 120, 'MATEOSALGUERO@empresa.com.ar', 2, '226.71'),
(6, 'JUAN CARLOS CABUTIA', '555-1212', '1956-10-29', '1980-05-10', 3097, 75000, 3, 121, 'JUANCARLOSCABUTIA@empresa.com.ar', 2, '111.10'),
(7, 'LUCAS RAMIREZ', '555-5656', '2001-10-29', '2022-10-05', 4071, 1300, 0, 122, 'LUCASRAMIREZ@empresa.com.ar', 1, '225.38'),
(8, 'MARIA GOMEZ', '555-7890', '1995-06-10', '2020-05-15', 2066, 2000, 0, 130, 'MARIAGOMEZ@empresa.com.ar', 1, '243.60'),
(9, 'MARIO FERNANDEZ', '555-2345', '1985-03-22', '2015-02-10', 1116, 3000, 2, 100, 'MARIOFERNANDEZ@empresa.com.ar', 2, '141.84'),
(10, 'LAURA MARTINEZ', '555-8901', '1990-11-15', '2017-09-20', 2384, 0, 1, 111, 'LAURAMARTINEZ@empresa.com.ar', 2, '178.43'),
(11, 'CARLOS GONZALEZ', '555-4567', '1978-07-08', '2010-06-01', 3571, 5000, 3, 120, 'CARLOSGONZALEZ@empresa.com.ar', 1, '216.60'),
(12, 'JULIA RODRIGUEZ', '555-6789', '1987-01-20', '2019-11-10', 1704, 1000, 2, 130, 'JULIARODRIGUEZ@empresa.com.ar', 3, '147.73'),
(13, 'ANDRES SANCHEZ', '555-1357', '1998-12-03', '2021-06-05', 4808, 4000, 0, 112, 'ANDRESSANCHEZ@empresa.com.ar', 1, '138.86'),
(450, 'Mateo', NULL, '2001-02-20', '2001-02-20', 1929, 100, 2, 100, 'mateo@empresa.com.ar', 2, '151.11');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `especialidades`
--

CREATE TABLE `especialidades` (
  `id` int(11) NOT NULL,
  `nombre` varchar(50) DEFAULT NULL,
  `caracteristica` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `especialidades`
--

INSERT INTO `especialidades` (`id`, `nombre`, `caracteristica`) VALUES
(1, 'MATEMÁTICA', NULL),
(2, 'INGENIERÍA', NULL),
(3, 'RH', NULL);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `centros`
--
ALTER TABLE `centros`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `departamentos`
--
ALTER TABLE `departamentos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `departamento_id` (`departamento_id`),
  ADD KEY `centro_id` (`centro_id`);

--
-- Indices de la tabla `empleados`
--
ALTER TABLE `empleados`
  ADD PRIMARY KEY (`id`),
  ADD KEY `departamento_id` (`departamento_id`),
  ADD KEY `especialidad_id` (`especialidad_id`);

--
-- Indices de la tabla `especialidades`
--
ALTER TABLE `especialidades`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `centros`
--
ALTER TABLE `centros`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT de la tabla `departamentos`
--
ALTER TABLE `departamentos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=131;

--
-- AUTO_INCREMENT de la tabla `empleados`
--
ALTER TABLE `empleados`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=451;

--
-- AUTO_INCREMENT de la tabla `especialidades`
--
ALTER TABLE `especialidades`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `departamentos`
--
ALTER TABLE `departamentos`
  ADD CONSTRAINT `departamentos_ibfk_1` FOREIGN KEY (`departamento_id`) REFERENCES `departamentos` (`id`),
  ADD CONSTRAINT `departamentos_ibfk_2` FOREIGN KEY (`centro_id`) REFERENCES `centros` (`id`);

--
-- Filtros para la tabla `empleados`
--
ALTER TABLE `empleados`
  ADD CONSTRAINT `empleados_ibfk_1` FOREIGN KEY (`departamento_id`) REFERENCES `departamentos` (`id`),
  ADD CONSTRAINT `empleados_ibfk_2` FOREIGN KEY (`especialidad_id`) REFERENCES `especialidades` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
