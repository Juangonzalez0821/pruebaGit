-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 03-10-2024 a las 04:31:37
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `2024-10-2`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Cliente` (IN `pidCliente` INT, IN `pNombrecliente` VARCHAR(50), IN `pEdad` INT, IN `pX` INT)   BEGIN
    IF pX = 1 THEN
        INSERT INTO cliente ( NombreCliente, Edad) 
        VALUES ( p_NombreCliente, p_Edad);
    
    ELSEIF pX = 2 THEN
        UPDATE cliente 
        SET NombreCliente = p_NombreCliente, 
            Edad = p_Edad 
        WHERE IdCliente = pidCliente;
    
    ELSEIF pX = 3 THEN
        DELETE FROM cliente 
        WHERE IdCliente = pidCliente;
        
    END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Final` (IN `pApellido` VARCHAR(50), IN `pIdEmpresa` INT, IN `pValor` INT)   BEGIN
    DECLARE NumClientesApellido INT DEFAULT 0;
    DECLARE TotalVentasEmpresa INT DEFAULT 0;

    SELECT COUNT(Cliente.IdCliente) INTO NumClientesApellido From Cliente 
    INNER JOIN EmpresaCliente ON Cliente.IdCliente = EmpresaCliente.IdCliente 
    WHERE IdEmpresa = pIdEmpresa AND NombreCliente LIKE CONCAT('%', pApellido, '%');

    SELECT SUM(TotalVentas ) INTO TotalVentasEmpresa FROM empresa WHERE IdEmpresa = pIdEmpresa;

    IF TotalVentasEmpresa > pValor THEN
        INSERT INTO log ( DetalleLog) VALUES ( CONCAT('El total de Ventas es: ',TotalVentasEmpresa,' de la Empresa Con Id: ', pIdEmpresa ));
    ELSEIF NumClientesApellido > 0 THEN
        INSERT INTO log ( DetalleLog) VALUES ( CONCAT('se conto el apellido: ',pApellido,' de la empresa con id: ',pIdEmpresa, ' y dio como resultado. ', NumClientesApellido));
    ELSE
        INSERT INTO log ( DetalleLog) VALUES ( 'no cumple ninguna condicion');
    END IF;   
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_procesoCliente` ()   BEGIN

    DECLARE Cliente_total_sum INT;

    SELECT SUM(Ahorros) INTO Cliente_total_sum FROM Cliente;
    IF Cliente_total_sum > 0 THEN
        INSERT INTO log ( DetalleLog) VALUES ( CONCAT('El total de Ahorros es: ',Cliente_total_sum,' lo que indica que es mayor que cero')  );
    ELSE
        INSERT INTO log ( DetalleLog) VALUES ( CONCAT('El total de Ahorros es: ',Cliente_total_sum,' lo que indica que es Menor que cero')  );
    END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_procesoEmpresa` ()   BEGIN
    DECLARE empresas_count INT;
    DECLARE empresas_total_sum INT;
    SELECT COUNT(IdEmpresa) INTO empresas_count FROM empresa  ;
    SELECT SUM(TotalVentas) INTO empresas_total_sum FROM empresa;
    IF empresas_total_sum > 200 THEN
      INSERT INTO log ( DetalleLog) VALUES ( CONCAT('El total de ventas es: ',empresas_total_sum)  );
    END IF;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cliente`
--

CREATE TABLE `cliente` (
  `IdCliente` int(11) NOT NULL,
  `NombreCliente` varchar(50) NOT NULL,
  `Edad` int(2) NOT NULL,
  `Ahorros` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `cliente`
--

INSERT INTO `cliente` (`IdCliente`, `NombreCliente`, `Edad`, `Ahorros`) VALUES
(1, 'Juan Gonzalez ', 22, 1000),
(2, 'Carlos Ortega', 35, 200),
(3, 'Camila Casas', 33, 320);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `empresa`
--

CREATE TABLE `empresa` (
  `IdEmpresa` int(11) NOT NULL,
  `NombreEmpresa` varchar(50) NOT NULL,
  `TotalVentas` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `empresa`
--

INSERT INTO `empresa` (`IdEmpresa`, `NombreEmpresa`, `TotalVentas`) VALUES
(1, 'Harris ', 300);

--
-- Disparadores `empresa`
--
DELIMITER $$
CREATE TRIGGER `Empresa_trigger_au` AFTER UPDATE ON `empresa` FOR EACH ROW BEGIN 
    INSERT INTO log (DetalleLog) VALUES (CONCAT('ha cambiado el nombre de la empresa: ', NEW.NombreEmpresa));
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `empresa_trigger_au_DELETE` AFTER DELETE ON `empresa` FOR EACH ROW BEGIN
  INSERT INTO log (DetalleLog ) VALUES ( CONCAT( ' ha borrado el dato con id: ',OLD.IdEmpresa,' Con el Nombre: ',OLD.NombreEmpresa, ' y el Totalventas: ', OLD.TotalVentas) );
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `empresacliente`
--

CREATE TABLE `empresacliente` (
  `IdEmpresaCliente` int(11) NOT NULL,
  `IdCliente` int(11) NOT NULL,
  `IdEmpresa` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `empresacliente`
--

INSERT INTO `empresacliente` (`IdEmpresaCliente`, `IdCliente`, `IdEmpresa`) VALUES
(1, 1, 1),
(2, 2, 1),
(3, 3, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `log`
--

CREATE TABLE `log` (
  `IdLog` int(11) NOT NULL,
  `Fecha` timestamp NOT NULL DEFAULT current_timestamp(),
  `DetalleLog` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `log`
--

INSERT INTO `log` (`IdLog`, `Fecha`, `DetalleLog`) VALUES
(1, '2024-10-03 00:36:39', 'ha cambiado el nombre de la empresa: Harris LTDA.'),
(2, '2024-10-03 00:43:30', 'ha cambiado el nombre de la empresa: Harris '),
(3, '2024-10-03 01:30:08', 'ha cambiado el nombre de la empresa: Harris '),
(4, '2024-10-03 01:35:24', 'El total de ventas es: 400'),
(5, '2024-10-03 01:41:29', ' ha borrado el dato con id: 2 Con el Nombre: Artur'),
(6, '2024-10-03 01:55:02', 'El total de Ahorros es: 1520 lo que indica que es mayor que cero'),
(7, '2024-10-03 02:17:26', 'El total de Ventas es: 300 de la Empresa Con Id: 1'),
(8, '2024-10-03 02:17:58', 'El total de Ventas es: 300 de la Empresa Con Id: 1'),
(9, '2024-10-03 02:18:39', 'se conto el apellido: Ortega de la empresa con id: 1 y dio como resultado. 1');

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `v_empresa`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `v_empresa` (
`NombreEmpresa` varchar(50)
,`NombreCliente` varchar(50)
,`Edad` int(2)
);

-- --------------------------------------------------------

--
-- Estructura para la vista `v_empresa`
--
DROP TABLE IF EXISTS `v_empresa`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_empresa`  AS SELECT `empresa`.`NombreEmpresa` AS `NombreEmpresa`, `cliente`.`NombreCliente` AS `NombreCliente`, `cliente`.`Edad` AS `Edad` FROM ((`empresa` join `empresacliente` on(`empresacliente`.`IdEmpresa` = `empresa`.`IdEmpresa`)) join `cliente` on(`cliente`.`IdCliente` = `empresacliente`.`IdCliente`)) WHERE `empresa`.`NombreEmpresa` = 'Harris' AND `cliente`.`NombreCliente` like '%casas%' ;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `cliente`
--
ALTER TABLE `cliente`
  ADD PRIMARY KEY (`IdCliente`);

--
-- Indices de la tabla `empresa`
--
ALTER TABLE `empresa`
  ADD PRIMARY KEY (`IdEmpresa`);

--
-- Indices de la tabla `empresacliente`
--
ALTER TABLE `empresacliente`
  ADD PRIMARY KEY (`IdEmpresaCliente`),
  ADD KEY `IdCliente` (`IdCliente`),
  ADD KEY `IdEmpresa` (`IdEmpresa`);

--
-- Indices de la tabla `log`
--
ALTER TABLE `log`
  ADD PRIMARY KEY (`IdLog`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `cliente`
--
ALTER TABLE `cliente`
  MODIFY `IdCliente` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `empresa`
--
ALTER TABLE `empresa`
  MODIFY `IdEmpresa` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `empresacliente`
--
ALTER TABLE `empresacliente`
  MODIFY `IdEmpresaCliente` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `log`
--
ALTER TABLE `log`
  MODIFY `IdLog` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `empresacliente`
--
ALTER TABLE `empresacliente`
  ADD CONSTRAINT `empresacliente_ibfk_1` FOREIGN KEY (`IdCliente`) REFERENCES `cliente` (`IdCliente`),
  ADD CONSTRAINT `empresacliente_ibfk_2` FOREIGN KEY (`IdEmpresa`) REFERENCES `empresa` (`IdEmpresa`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;