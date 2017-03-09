-- phpMyAdmin SQL Dump
-- version 4.6.5.2
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 09-03-2017 a las 21:41:52
-- Versión del servidor: 10.1.21-MariaDB
-- Versión de PHP: 5.6.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `banco`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `cliente_direccion_id` (IN `iid` INT)  NO SQL
select clientes.dirección from clientes where clientes.cliente_id=iid$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `cliente_dni_id` (IN `iid` INT)  NO SQL
select clientes.email from clientes where clientes.cliente_id=iid$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `cliente_email_id` (IN `iid` INT)  NO SQL
select clientes.email from clientes where clientes.cliente_id=iid$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `cliente_id_dni` (IN `idni` VARCHAR(50))  NO SQL
select clientes.cliente_id from clientes where clientes.DNI=idni$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `cliente_id_email` (IN `iemail` VARCHAR(50))  NO SQL
select clientes.cliente_id from clientes where clientes.email=iemail$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `cliente_id_nombre` (IN `inombre` VARCHAR(50))  NO SQL
select clientes.cliente_id from clientes where clientes.nombre=inombre$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `cliente_nombre_id` (IN `iid` INT)  NO SQL
SELECT clientes.nombre from clientes where clientes.cliente_id=iid$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `fondos_nombre_cuenta` (IN `inombre` VARCHAR(50))  NO SQL
select cuentas.fondos from cuentas where cuentas.nombre=inombre$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `nombres_cuenta` (IN `icid` INT)  NO SQL
select cuentas.nombre from cuentas where cuentas.cuenta_id=(SELECT posesiones.cuenta_id from posesiones where posesiones.cliente_id=icid)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `trans_cliente` (IN `icid` INT)  NO SQL
select transacciones.fecha, transacciones.concepto, transacciones.cantidad from transacciones where transacciones.cliente1_id=icid or transacciones.cliente2_id=icid order by transacciones.fecha DESC$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clientes`
--

CREATE TABLE `clientes` (
  `cliente_id` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `DNI` varchar(20) NOT NULL,
  `dirección` varchar(300) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cuentas`
--

CREATE TABLE `cuentas` (
  `cuenta_id` int(11) NOT NULL,
  `descripción` varchar(500) NOT NULL,
  `fondos` decimal(10,2) NOT NULL,
  `nombre` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `posesiones`
--

CREATE TABLE `posesiones` (
  `id` int(11) NOT NULL,
  `cliente_id` int(11) NOT NULL,
  `cuenta_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `transacciones`
--

CREATE TABLE `transacciones` (
  `id` int(11) NOT NULL,
  `cliente1_id` int(11) NOT NULL,
  `cliente2_id` int(11) NOT NULL,
  `cuenta1_id` int(11) NOT NULL,
  `cuenta2_id` int(11) NOT NULL,
  `fecha` int(11) NOT NULL,
  `concepto` varchar(500) NOT NULL,
  `cantidad` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `clientes`
--
ALTER TABLE `clientes`
  ADD PRIMARY KEY (`cliente_id`),
  ADD KEY `email` (`email`),
  ADD KEY `DNI` (`DNI`),
  ADD KEY `nombre` (`nombre`);

--
-- Indices de la tabla `cuentas`
--
ALTER TABLE `cuentas`
  ADD PRIMARY KEY (`cuenta_id`);

--
-- Indices de la tabla `posesiones`
--
ALTER TABLE `posesiones`
  ADD PRIMARY KEY (`id`),
  ADD KEY `cliente_id` (`cliente_id`),
  ADD KEY `cuenta_id` (`cuenta_id`);

--
-- Indices de la tabla `transacciones`
--
ALTER TABLE `transacciones`
  ADD PRIMARY KEY (`id`),
  ADD KEY `cliente1_id` (`cliente1_id`),
  ADD KEY `cliente2_id` (`cliente2_id`),
  ADD KEY `cuenta1_id` (`cuenta1_id`),
  ADD KEY `cuenta2_id` (`cuenta2_id`),
  ADD KEY `fecha` (`fecha`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `clientes`
--
ALTER TABLE `clientes`
  MODIFY `cliente_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `cuentas`
--
ALTER TABLE `cuentas`
  MODIFY `cuenta_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `posesiones`
--
ALTER TABLE `posesiones`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `transacciones`
--
ALTER TABLE `transacciones`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `posesiones`
--
ALTER TABLE `posesiones`
  ADD CONSTRAINT `posesiones_ibfk_1` FOREIGN KEY (`cuenta_id`) REFERENCES `cuentas` (`cuenta_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `posesiones_ibfk_2` FOREIGN KEY (`cliente_id`) REFERENCES `clientes` (`cliente_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `transacciones`
--
ALTER TABLE `transacciones`
  ADD CONSTRAINT `transacciones_ibfk_1` FOREIGN KEY (`cliente1_id`) REFERENCES `clientes` (`cliente_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `transacciones_ibfk_2` FOREIGN KEY (`cliente2_id`) REFERENCES `clientes` (`cliente_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `transacciones_ibfk_3` FOREIGN KEY (`cuenta1_id`) REFERENCES `cuentas` (`cuenta_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `transacciones_ibfk_4` FOREIGN KEY (`cuenta2_id`) REFERENCES `cuentas` (`cuenta_id`) ON DELETE CASCADE ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
