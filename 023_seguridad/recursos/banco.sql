-- phpMyAdmin SQL Dump
-- version 4.6.5.2
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 20-04-2017 a las 23:14:05
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
CREATE DEFINER=`root`@`localhost` PROCEDURE `asociar_cuenta` (IN `icid` INT, IN `icuen` INT)  NO SQL
insert into posesiones(cliente_id, cuenta_id) values (icid, icuen)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `cliente_direccion_id` (IN `iid` INT)  NO SQL
select clientes.dirección from clientes where clientes.cliente_id=iid$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `cliente_dni_id` (IN `iid` INT)  NO SQL
select clientes.DNI from clientes where clientes.cliente_id=iid$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `cliente_email_id` (IN `iid` INT)  NO SQL
select clientes.email from clientes where clientes.cliente_id=iid$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `cliente_id_dni` (IN `idni` VARCHAR(50))  NO SQL
select clientes.cliente_id from clientes where clientes.DNI=idni$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `cliente_id_email` (IN `iemail` VARCHAR(50))  NO SQL
select clientes.cliente_id from clientes where clientes.email like iemail$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `cliente_id_nombre` (IN `inombre` VARCHAR(50))  NO SQL
select clientes.cliente_id from clientes where clientes.nombre=inombre$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `cliente_nombre_id` (IN `iid` INT)  NO SQL
SELECT clientes.nombre from clientes where clientes.cliente_id=iid$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `crear_cuenta` (IN `idesc` VARCHAR(500), IN `ifondos` DECIMAL(10,2), IN `inombre` VARCHAR(50))  NO SQL
insert into cuentas(descripción, fondos, nombre) values(idesc, ifondos, inombre)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `cuenta_id` (IN `inombre` VARCHAR(100))  NO SQL
select cuentas.cuenta_id from cuentas where cuentas.nombre=inombre$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `disociar_cuenta` (IN `icid` INT)  NO SQL
delete from posesiones where posesiones.cliente_id=icid$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `eliminar_cuenta` (IN `cuenta_ide` INT(11))  NO SQL
delete from cuentas where cuenta_id=cuenta_ide$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `fondos_nombre_cuenta` (IN `inombre` VARCHAR(50))  NO SQL
select cuentas.fondos from cuentas where cuentas.nombre=inombre$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_cuentas` (IN `cid` INT)  NO SQL
select cuentas.cuenta_id, cuentas.descripción, cuentas.fondos, cuentas.nombre from cuentas where cuentas.cuenta_id in (select posesiones.cuenta_id from posesiones where posesiones.cliente_id=cid)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_salt` (IN `iemail` VARCHAR(100))  NO SQL
select clientes.salt from clientes where clientes.email=iemail$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `login` (IN `iemail` VARCHAR(50), IN `ipwd` VARCHAR(500))  NO SQL
select count(*) from clientes where clientes.email=iemail and clientes.pwd=ipwd$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `movimientos_in` (IN `icid` INT, IN `iclid` INT)  NO SQL
select 
transacciones.fecha, clientes.nombre, transacciones.cantidad, transacciones.concepto 
from 
transacciones 

left join clientes on clientes.cliente_id=transacciones.cliente1_id

where 
(transacciones.cuenta2_id=icid and transacciones.cliente2_id=iclid)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `movimientos_out` (IN `icid` INT, IN `iclid` INT)  NO SQL
select 
transacciones.fecha, clientes.nombre, transacciones.cantidad, transacciones.concepto 
from 
transacciones 

left join clientes on clientes.cliente_id=transacciones.cliente2_id

where 
(transacciones.cuenta1_id=icid and transacciones.cliente1_id=iclid)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `nombres_cuenta` (IN `icid` INT)  NO SQL
select cuentas.cuenta_id,cuentas.nombre from cuentas where cuentas.cuenta_id IN (SELECT posesiones.cuenta_id from posesiones where posesiones.cliente_id=icid)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `nuevo_cliente` (IN `inombre` VARCHAR(50), IN `iemail` VARCHAR(50), IN `idni` VARCHAR(20), IN `idir` VARCHAR(300), IN `ipwd` VARCHAR(500), IN `isalt` VARCHAR(500))  NO SQL
INSERT into clientes(nombre, email, DNI, dirección, pwd, salt) values(inombre, iemail, idni, idir, ipwd, isalt)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `seleccionar_cuentas` (IN `cuenta_ide` INT(11))  NO SQL
select * from cuentas where cuenta_id=cuenta_ide$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `seleccionar_cuenta_id` (IN `icid` INT(11))  NO SQL
select posesiones.cuenta_id from posesiones where posesiones.cliente_id=icid$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `transacción` (IN `icid1` INT, IN `icid2` INT, IN `icu1` INT(100), IN `icu2` INT(100), IN `ifec` VARCHAR(50), IN `info` VARCHAR(500), IN `ican` DECIMAL(10,2))  NO SQL
insert into transacciones(cliente1_id, cliente2_id, cuenta1_id, cuenta2_id, fecha, concepto, cantidad) values (icid1, icid2, icu1, icu2, ifec, info, ican)$$

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
  `dirección` varchar(300) NOT NULL,
  `pwd` varchar(500) NOT NULL,
  `salt` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `clientes`
--

INSERT INTO `clientes` (`cliente_id`, `nombre`, `email`, `DNI`, `dirección`, `pwd`, `salt`) VALUES
(1, 'arturo', 'arturo@gmail.com', '99999999', 'c/ madrid', '$2a$16$TCEgQQKU9Y4Y28lYRQ8Ipub72awFWDU7dvi5RhpOCsZunc2UpYIzG', '$2a$16$TCEgQQKU9Y4Y28lYRQ8Ipu'),
(2, 'Jaime', 'jaime@jaime.net', '010101001', '01010101', '$2a$16$DOAlxOFuEIiHj7WYdZ9vLOCfk2ap3LstIgRNwO.Qu6a0Gf2Fgxqn6', '$2a$16$DOAlxOFuEIiHj7WYdZ9vLO'),
(3, 'Prueba', 'prueba@prueba.es', 'prupruprueba', 'pruebapru', '$2a$16$yj.mGsyDLnlACsnNTR/FtuYGKcydvKHhzs5gkeQXzd8jt4XKLgabO', '$2a$16$yj.mGsyDLnlACsnNTR/Ftu'),
(4, 'Banco', 'banco@banco.net', '123123123', '123123231', '$2a$16$4k6NCrRCqGVCPVFQRCb70ebe0zzW/PBneardcr2lNdpgXb1i05geq', '$2a$16$4k6NCrRCqGVCPVFQRCb70e'),
(6, 'soy muy malo', 'elmalo@kk.com', '000', 'mi casa', '$2a$16$6xX5HD0jwRIm8qiIT3RpuuAAaJJIbYvIzlHyacuGc7v2smv8.eTBm', '$2a$16$6xX5HD0jwRIm8qiIT3Rpuu'),
(7, 'Minerva McGonagall', 'aliciapa@gmail.com', '', '', '$2a$16$BP3WMXCmziPthDlkT9BooeY56jpb.mLxDVm6zAV5t0U9cD6SlcQBa', '$2a$16$BP3WMXCmziPthDlkT9Booe'),
(8, 'Falso123', 'falso@falso2.com', '', '', '$2a$16$MoQuYoyiowOl1KA.rc9Ih.65hPIZlZB9AjXzYG.5LDKcp2HOiBHiu', '$2a$16$MoQuYoyiowOl1KA.rc9Ih.'),
(9, 'PruebaRegistro', 'pruebaregistro@prueba.es', '', '', '$2a$16$XyOevqtTw2Skng/X.yW4Q.Ob9Fz721TWXXmg4oioUdegysQTU7ZAS', '$2a$16$XyOevqtTw2Skng/X.yW4Q.'),
(10, 'Culote', 'culo@culo.net', '', '', '$2a$16$f8.xyWc9vBPFvSp2Gn8Ctu0CDgoG77L7RizDmjJ6Aix0Ph6Wnq67i', '$2a$16$f8.xyWc9vBPFvSp2Gn8Ctu'),
(11, 'celo', 'celo@celo.celo', '', '', '$2a$16$vq7VpdRLy7hiUS2HV1ZLhePMTgUCwL72occltyUvqv3qKCO0jP1oS', '$2a$16$vq7VpdRLy7hiUS2HV1ZLhe'),
(12, 'regist', 'regist@regist.net', '', '', '$2a$16$XO7qahi1q3OHRiUa3WT1yeXcJ1JAPjfvM8PetojzVUzw/NnFPW5nu', '$2a$16$XO7qahi1q3OHRiUa3WT1ye'),
(13, 'prupru2', 'prupru2@prupru.es', '', '', '$2a$16$Ryt0TrJ4HBS4lB3UXNCzo.cQf3aBvKkPFHqZiMCsV7INHhpWeU.li', '$2a$16$Ryt0TrJ4HBS4lB3UXNCzo.');

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

--
-- Volcado de datos para la tabla `cuentas`
--

INSERT INTO `cuentas` (`cuenta_id`, `descripción`, `fondos`, `nombre`) VALUES
(2, 'jubilacion', '800102.00', 'jubilacion'),
(3, 'jubilacion', '800000.00', 'jubilacion'),
(4, 'jubilacion', '16000.00', 'jubilacion'),
(5, 'fundacion', '90000.00', 'fundacion'),
(6, 'fundacion', '270000.00', 'fundacion'),
(7, 'fundacion', '60000.00', 'fundacion'),
(8, 'fundacion', '80000.00', 'fundacion'),
(9, 'fundacion', '575687.00', 'fundacion'),
(10, 'fundacion', '346546.00', 'fundacion'),
(11, 'fundacion', '47856880.00', 'fundacion'),
(12, 'fundacion', '24543666.00', 'fundacion'),
(13, 'fundacion', '235346.00', 'fundacion'),
(15, '123', '123.00', 'Cuenta3'),
(16, 'asdassda', '123.00', 'cuentas2'),
(19, 'Prueba de creacion de cuenta', '55100.00', 'cuenta de prueba'),
(20, 'Cuenta para los movimientos', '0.00', 'movimientos'),
(21, 'Cuenta del banco', '-2000.00', 'cuenta del banco'),
(22, '', '0.00', 'casa'),
(23, 'lo que afano', '0.00', 'misrobos'),
(24, 'ijpasdpiadsojpsa', '10.00', 'Cuenta de prueba'),
(25, 'askdpjsa', '1.00', 'Cuenta de prueba 3'),
(26, 'Prueba de creacion', '100.00', 'PruebaCreacion'),
(27, 'nuevas', '234.67', 'Tarjeta de Tungsteno'),
(28, 'prueba de las restricciones', '100.00', 'pruebarestriccciones'),
(29, '123', '123.00', 'FalsaFalsa123'),
(30, 'celo', '100.00', 'celocelo'),
(31, 'prupru', '123.00', 'cuentaprupru'),
(32, 'cjcjc', '1100.00', 'prupru2cuenta');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `posesiones`
--

CREATE TABLE `posesiones` (
  `id` int(11) NOT NULL,
  `cliente_id` int(11) NOT NULL,
  `cuenta_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `posesiones`
--

INSERT INTO `posesiones` (`id`, `cliente_id`, `cuenta_id`) VALUES
(7, 2, 4),
(8, 3, 5),
(9, 1, 10),
(10, 1, 12),
(11, 2, 19),
(13, 4, 21),
(16, 2, 26),
(18, 7, 28),
(20, 11, 30),
(21, 12, 31),
(22, 13, 32);

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
  `fecha` varchar(50) NOT NULL,
  `concepto` varchar(500) NOT NULL,
  `cantidad` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `transacciones`
--

INSERT INTO `transacciones` (`id`, `cliente1_id`, `cliente2_id`, `cuenta1_id`, `cuenta2_id`, `fecha`, `concepto`, `cantidad`) VALUES
(3, 2, 2, 4, 4, 'Thu Apr 20 18:15:57 CEST 2017', 'Transferencia de prueba', '100.00'),
(4, 2, 2, 19, 4, 'Thu Apr 20 18:16:25 CEST 2017', 'Otra transferencia de prueba', '100.00'),
(5, 2, 4, 4, 19, 'Thu Apr 20 20:31:56 CEST 2017', 'Prueba transferencia a Banco', '100.00'),
(6, 2, 4, 4, 19, 'Thu Apr 20 20:32:17 CEST 2017', 'Prueba ingreso con cuenta banco creada', '100.00'),
(7, 2, 4, 4, 19, 'Thu Apr 20 20:32:38 CEST 2017', 'Prueba retiro con cuenta banco creada', '100.00'),
(8, 4, 2, 4, 19, 'Thu Apr 20 20:36:12 CEST 2017', 'Prueba ingreso con cuenta banco creada', '200.00'),
(9, 4, 2, 4, 19, 'Thu Apr 20 20:38:07 CEST 2017', 'Prueba ingreso con cuenta banco creada', '200.00'),
(10, 4, 2, 19, 4, 'Thu Apr 20 20:39:19 CEST 2017', 'Prueba ingreso con cuenta banco creada', '600.00'),
(11, 2, 4, 4, 19, 'Thu Apr 20 20:39:40 CEST 2017', 'Pago deuda Yakuza', '5000.00'),
(12, 2, 4, 4, 19, 'Thu Apr 20 20:40:04 CEST 2017', 'Le doy mi dinero al banco', '50000.00'),
(13, 4, 2, 21, 21, 'Thu Apr 20 20:41:34 CEST 2017', 'Prueba banco hacia afuera', '100.00'),
(14, 4, 2, 21, 4, 'Thu Apr 20 20:44:05 CEST 2017', 'Prueba sacar dinero', '1000.00'),
(15, 2, 4, 4, 21, 'Thu Apr 20 20:45:37 CEST 2017', 'Prueba sacar dinero', '10000.00'),
(16, 4, 2, 21, 4, 'Thu Apr 20 20:46:00 CEST 2017', 'Prueba ingresar dinero', '10000.00'),
(17, 4, 11, 30, 30, 'Thu Apr 20 22:14:04 CEST 2017', 'regalito', '500.00'),
(18, 4, 12, 31, 31, 'Thu Apr 20 22:20:22 CEST 2017', 'rico', '500.00'),
(19, 4, 13, 32, 32, 'Thu Apr 20 22:24:10 CEST 2017', 'Ingreso', '100.00'),
(20, 4, 13, 32, 32, 'Thu Apr 20 22:27:22 CEST 2017', 'prueba', '500.00'),
(21, 4, 13, 32, 32, 'Thu Apr 20 22:32:20 CEST 2017', '500', '500.00'),
(22, 4, 13, 32, 32, 'Thu Apr 20 22:34:56 CEST 2017', '500', '500.00'),
(23, 4, 13, 32, 32, 'Thu Apr 20 22:36:14 CEST 2017', '500', '500.00'),
(24, 4, 13, 32, 32, 'Thu Apr 20 22:37:27 CEST 2017', '500', '500.00'),
(25, 4, 13, 21, 32, 'Thu Apr 20 22:41:55 CEST 2017', '500', '500.00'),
(26, 13, 4, 32, 21, 'Thu Apr 20 22:42:08 CEST 2017', '500', '500.00'),
(27, 4, 13, 21, 32, 'Thu Apr 20 22:49:21 CEST 2017', 'euritos', '1000.00');

--
-- Disparadores `transacciones`
--
DELIMITER $$
CREATE TRIGGER `actualizar_fondos` AFTER INSERT ON `transacciones` FOR EACH ROW BEGIN
	update cuentas set cuentas.fondos=cuentas.fondos+NEW.cantidad where cuentas.cuenta_id=NEW.cuenta2_id ;
	update cuentas set cuentas.fondos=cuentas.fondos-NEW.cantidad where cuentas.cuenta_id=NEW.cuenta1_id ;
END
$$
DELIMITER ;

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
  MODIFY `cliente_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;
--
-- AUTO_INCREMENT de la tabla `cuentas`
--
ALTER TABLE `cuentas`
  MODIFY `cuenta_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;
--
-- AUTO_INCREMENT de la tabla `posesiones`
--
ALTER TABLE `posesiones`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;
--
-- AUTO_INCREMENT de la tabla `transacciones`
--
ALTER TABLE `transacciones`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;
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
