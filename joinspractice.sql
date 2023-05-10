-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 10-05-2023 a las 14:55:56
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
-- Base de datos: `joinspractice`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clientes`
--

CREATE TABLE `clientes` (
  `ID` int(11) NOT NULL,
  `NOMBRE` char(100) DEFAULT NULL,
  `APELLIDO` char(100) DEFAULT NULL,
  `DNI` char(20) DEFAULT NULL,
  `CORREO` char(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `clientes`
--

INSERT INTO `clientes` (`ID`, `NOMBRE`, `APELLIDO`, `DNI`, `CORREO`) VALUES
(1, 'JUAN', 'PEREZ', '09876541230', 'juanperez@correo.com'),
(2, 'DIEGO', 'RUIZ', '09658741236', 'diegoruiz@correo.com'),
(3, 'SUSANA', 'SOUSA', '09876541230', 'susana@correo.com'),
(4, 'JUANA', 'CLARENCE', '09876541230', 'juana@correo.com'),
(5, 'SOFIA', 'ALVARADO', '09876541230', 'sofia@correo.com');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos`
--

CREATE TABLE `productos` (
  `ID` int(11) NOT NULL,
  `CODIGO` char(30) DEFAULT NULL,
  `NOMBRE` char(100) DEFAULT NULL,
  `DESCRIPCION` char(150) DEFAULT NULL,
  `IDPROV` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `productos`
--

INSERT INTO `productos` (`ID`, `CODIGO`, `NOMBRE`, `DESCRIPCION`, `IDPROV`) VALUES
(1, 'AB-0001', 'MOUSE WIRELESS', 'UNO DE LOS MEJORES MOUSE WIRELESS', 1),
(2, 'CD-0002', 'TECLADO WIRELESS', 'UNO DE LOS MEJORES TECLADOS WIRELESS', 1),
(3, 'FG-0003', 'PARLANTES', 'UNO DE LOS MEJORES PARLANTES DEL MERCADO', 2),
(4, 'HI-0004', 'MONITOR GAMER', 'UNO DE LOS MEJORES MONITORES GAMER', 2),
(5, 'JK-0005', 'CPU GAMER', 'UNO DE LOS MEJORES CPU GAMER', 1),
(6, 'RR-0006', 'CPU', 'UNO DE LOS MEJORES CPU -- GAMER', 1),
(7, 'TT-0007', 'teclado', 'UNO DE LOS MEJORES TECLADOS', 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `proveedores`
--

CREATE TABLE `proveedores` (
  `IDPROV` int(11) NOT NULL,
  `NOMBRE` char(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `proveedores`
--

INSERT INTO `proveedores` (`IDPROV`, `NOMBRE`) VALUES
(1, 'JUAN PEREZ'),
(2, 'ROBERTO GONZALEZ'),
(3, 'Natalia Perez');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ventas`
--

CREATE TABLE `ventas` (
  `ID` int(11) NOT NULL,
  `CLIENTEID` int(11) NOT NULL,
  `FECHA` datetime DEFAULT NULL,
  `TOTAL` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `ventas`
--

INSERT INTO `ventas` (`ID`, `CLIENTEID`, `FECHA`, `TOTAL`) VALUES
(1, 1, '2021-02-05 00:00:00', 500),
(2, 1, '2021-02-05 00:00:00', 500),
(3, 2, '2021-03-05 00:00:00', 300),
(4, 3, '2021-03-05 00:00:00', 800),
(5, 2, '2021-06-05 00:00:00', 700),
(6, 1, '2021-07-05 00:00:00', 100),
(7, 2, '2021-07-05 00:00:00', 260),
(8, 4, '2021-08-05 00:00:00', 350);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ventas_detalle`
--

CREATE TABLE `ventas_detalle` (
  `ID` int(11) NOT NULL,
  `VENTA_ID` int(11) NOT NULL,
  `PRODUCTOID` int(11) NOT NULL,
  `CANTIDAD` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `ventas_detalle`
--

INSERT INTO `ventas_detalle` (`ID`, `VENTA_ID`, `PRODUCTOID`, `CANTIDAD`) VALUES
(1, 1, 1, 5),
(2, 1, 2, 4),
(3, 1, 3, 3),
(4, 1, 1, 5),
(5, 2, 2, 1),
(6, 2, 3, 8),
(7, 3, 2, 10),
(8, 3, 1, 11),
(9, 4, 1, 10),
(10, 1, 1, 1);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `clientes`
--
ALTER TABLE `clientes`
  ADD PRIMARY KEY (`ID`);

--
-- Indices de la tabla `productos`
--
ALTER TABLE `productos`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `IDPROV` (`IDPROV`);

--
-- Indices de la tabla `proveedores`
--
ALTER TABLE `proveedores`
  ADD PRIMARY KEY (`IDPROV`);

--
-- Indices de la tabla `ventas`
--
ALTER TABLE `ventas`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `CLIENTEID` (`CLIENTEID`);

--
-- Indices de la tabla `ventas_detalle`
--
ALTER TABLE `ventas_detalle`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `VENTA_ID` (`VENTA_ID`),
  ADD KEY `PRODUCTOID` (`PRODUCTOID`);

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `productos`
--
ALTER TABLE `productos`
  ADD CONSTRAINT `productos_ibfk_1` FOREIGN KEY (`IDPROV`) REFERENCES `proveedores` (`IDPROV`);

--
-- Filtros para la tabla `ventas`
--
ALTER TABLE `ventas`
  ADD CONSTRAINT `ventas_ibfk_1` FOREIGN KEY (`CLIENTEID`) REFERENCES `clientes` (`ID`);

--
-- Filtros para la tabla `ventas_detalle`
--
ALTER TABLE `ventas_detalle`
  ADD CONSTRAINT `ventas_detalle_ibfk_1` FOREIGN KEY (`VENTA_ID`) REFERENCES `ventas` (`ID`),
  ADD CONSTRAINT `ventas_detalle_ibfk_2` FOREIGN KEY (`PRODUCTOID`) REFERENCES `productos` (`ID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
