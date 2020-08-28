-- phpMyAdmin SQL Dump
-- version 5.0.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 22-08-2020 a las 20:55:00
-- Versión del servidor: 10.4.11-MariaDB
-- Versión de PHP: 7.4.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `demo`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `account_payables`
--

CREATE TABLE `account_payables` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `description` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `reference` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `datedoc` date DEFAULT NULL,
  `datedue` date DEFAULT NULL,
  `amount` double(12,2) NOT NULL DEFAULT 0.00,
  `provider_id` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `aplications`
--

CREATE TABLE `aplications` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `docSource` bigint(20) UNSIGNED DEFAULT NULL,
  `docLink` bigint(20) UNSIGNED DEFAULT NULL,
  `reference` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `active` enum('1','0') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1',
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `banks`
--

CREATE TABLE `banks` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `branch` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `account` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `clabe` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `initialDay` date DEFAULT NULL,
  `initialBalance` double(12,2) NOT NULL DEFAULT 0.00,
  `fund_id` bigint(20) UNSIGNED DEFAULT NULL,
  `active` enum('1','0') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1',
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `banks`
--

INSERT INTO `banks` (`id`, `name`, `branch`, `account`, `clabe`, `initialDay`, `initialBalance`, `fund_id`, `active`, `user_id`, `created_at`, `updated_at`) VALUES
(1, 'Banamex 2323', '2365', '2322323', '4141241515', '2020-01-01', 1000.00, 1, '1', 0, NULL, NULL),
(2, 'HSBC 342', '33', '342', '415415421541254', '2020-08-16', 0.00, 1, '1', 2, '2020-08-17 03:56:05', '2020-08-17 03:56:59');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `budgetsold`
--

CREATE TABLE `budgetsold` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `code` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `year` int(4) NOT NULL,
  `netAmt` double(12,2) NOT NULL DEFAULT 0.00,
  `active` enum('1','0') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1',
  `closed` enum('1','0') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `budgetsold`
--

INSERT INTO `budgetsold` (`id`, `code`, `name`, `year`, `netAmt`, `active`, `closed`, `user_id`, `created_at`, `updated_at`) VALUES
(1, 'Vigilancia2020', 'Presupuesto 2020 vigilancia', 2020, 10000.00, '1', '0', 2, NULL, '2020-08-15 00:51:09'),
(2, 'Pintura2020', 'Presupuesto 2020 pintura', 2020, 10000.00, '1', '0', 2, NULL, '2020-08-07 22:17:49'),
(3, 'EnergiaElectrica2020', 'Presupuesto 2020 energia', 2020, 10000.00, '1', '0', 2, '2020-08-06 16:39:23', '2020-08-07 22:17:28'),
(4, 'Asfalto2020', 'Presupuesto 2020 asfalto', 2020, 10000.00, '1', '0', 2, '2020-08-06 16:40:15', '2020-08-07 22:17:28'),
(5, 'Limpieza2020', 'Presupuesto 2020 limpieza', 2020, 10000.00, '1', '0', 2, '2020-08-06 16:42:24', '2020-08-07 22:17:28');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `budget_expenditures`
--

CREATE TABLE `budget_expenditures` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `code` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `year` bigint(20) NOT NULL DEFAULT 0,
  `netAmt` double(12,2) NOT NULL DEFAULT 0.00,
  `active` enum('1','0') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1',
  `closed` enum('1','0') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `budget_expenditures`
--

INSERT INTO `budget_expenditures` (`id`, `code`, `name`, `year`, `netAmt`, `active`, `closed`, `user_id`, `created_at`, `updated_at`) VALUES
(1, 'Papeleria', 'Gastos de papeleria', 2020, 100.00, '1', '0', 2, NULL, '2020-08-17 05:11:03');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `budget_incomes`
--

CREATE TABLE `budget_incomes` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `code` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `year` bigint(20) NOT NULL DEFAULT 0,
  `netAmt` double(12,2) NOT NULL DEFAULT 0.00,
  `active` enum('1','0') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1',
  `closed` enum('1','0') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `budget_incomes`
--

INSERT INTO `budget_incomes` (`id`, `code`, `name`, `year`, `netAmt`, `active`, `closed`, `user_id`, `created_at`, `updated_at`) VALUES
(1, 'CuotaMensual', 'Cuota mensual ordinaria', 2020, 10000.00, '1', '0', 0, NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `companies`
--

CREATE TABLE `companies` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `companyCode` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `rfc` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `movil` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `colony` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `town` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `city` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `zipCode` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `active` enum('1','0') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1',
  `email` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='It contains the Company data';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `condominias`
--

CREATE TABLE `condominias` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `code` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` bigint(20) NOT NULL,
  `owner_id` bigint(20) DEFAULT NULL,
  `tenant_id` bigint(20) DEFAULT NULL,
  `occupied` enum('1','0') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1',
  `active` enum('1','0') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1',
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `condominias`
--

INSERT INTO `condominias` (`id`, `code`, `type`, `owner_id`, `tenant_id`, `occupied`, `active`, `user_id`, `created_at`, `updated_at`) VALUES
(1, 'Condominio101', 1, 1, 1, '1', '1', 2, NULL, '2020-08-07 00:00:12'),
(2, 'Condominio102', 1, 1, 2, '1', '1', 2, NULL, '2020-08-06 23:53:00'),
(3, 'Condominio201', 2, 2, 3, '1', '1', 2, NULL, '2020-08-07 00:00:20'),
(4, 'Condominio202', 2, 2, 4, '1', '1', 2, NULL, '2020-08-07 00:00:27'),
(5, 'Condominio301', 3, 2, 5, '0', '1', 2, '2020-08-07 00:04:36', '2020-08-16 22:13:24');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `condominia_quotas`
--

CREATE TABLE `condominia_quotas` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `condominia_id` bigint(20) UNSIGNED DEFAULT NULL,
  `year` bigint(20) UNSIGNED DEFAULT NULL,
  `period` bigint(20) UNSIGNED DEFAULT NULL,
  `type` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `amount` double(12,2) NOT NULL DEFAULT 0.00,
  `datedoc` date DEFAULT NULL,
  `datedue` date DEFAULT NULL,
  `fund_id` bigint(20) UNSIGNED DEFAULT NULL,
  `budget_incomes_id` bigint(20) UNSIGNED DEFAULT NULL,
  `active` enum('1','0') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1',
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `condominia_quotas`
--

INSERT INTO `condominia_quotas` (`id`, `condominia_id`, `year`, `period`, `type`, `description`, `amount`, `datedoc`, `datedue`, `fund_id`, `budget_incomes_id`, `active`, `user_id`, `created_at`, `updated_at`) VALUES
(5, 1, 2020, 1, 'CuotaMensual', 'Cuota de Mnnto Mensual Periodo 1 2020', 1300.00, '2020-01-02', '2020-01-12', 1, 1, '1', 2, '2020-08-19 02:55:10', '2020-08-19 02:55:10'),
(6, 2, 2020, 1, 'CuotaMensual', 'Cuota de Mnnto Mensual Periodo 1 2020', 1300.00, '2020-01-02', '2020-01-12', 1, 1, '1', 2, '2020-08-19 02:55:10', '2020-08-19 02:55:10'),
(7, 3, 2020, 1, 'CuotaMensual', 'Cuota de Mnnto Mensual Periodo 1 2020', 1000.00, '2020-01-02', '2020-01-12', 1, 1, '1', 2, '2020-08-19 02:55:10', '2020-08-19 02:55:10'),
(8, 4, 2020, 1, 'CuotaMensual', 'Cuota de Mnnto Mensual Periodo 1 2020', 1000.00, '2020-01-02', '2020-01-12', 1, 1, '1', 2, '2020-08-19 02:55:10', '2020-08-19 02:55:10'),
(9, 5, 2020, 1, 'CuotaMensual', 'Cuota de Mnnto Mensual Periodo 1 2020', 2000.00, '2020-01-02', '2020-01-12', 1, 1, '1', 2, '2020-08-19 02:55:10', '2020-08-19 02:55:10'),
(10, 1, 2020, 2, 'CuotaMensual', 'Cuota de Mnnto Mensual Periodo 2 2020', 1300.00, '2020-02-03', '2020-02-13', 1, 1, '1', 2, '2020-08-19 02:55:44', '2020-08-19 02:55:44'),
(11, 2, 2020, 2, 'CuotaMensual', 'Cuota de Mnnto Mensual Periodo 2 2020', 1300.00, '2020-02-03', '2020-02-13', 1, 1, '1', 2, '2020-08-19 02:55:44', '2020-08-19 02:55:44'),
(12, 3, 2020, 2, 'CuotaMensual', 'Cuota de Mnnto Mensual Periodo 2 2020', 1000.00, '2020-02-03', '2020-02-13', 1, 1, '1', 2, '2020-08-19 02:55:44', '2020-08-19 02:55:44'),
(13, 4, 2020, 2, 'CuotaMensual', 'Cuota de Mnnto Mensual Periodo 2 2020', 1000.00, '2020-02-03', '2020-02-13', 1, 1, '1', 2, '2020-08-19 02:55:44', '2020-08-19 02:55:44'),
(14, 5, 2020, 2, 'CuotaMensual', 'Cuota de Mnnto Mensual Periodo 2 2020', 2000.00, '2020-02-03', '2020-02-13', 1, 1, '1', 2, '2020-08-19 02:55:44', '2020-08-19 02:55:44'),
(15, 1, 2020, 3, 'CuotaMensual', 'Cuota de Mnnto Mensual Periodo 3 2020', 1300.00, '2020-03-02', '2020-03-12', 1, 1, '1', 2, '2020-08-19 02:57:17', '2020-08-19 02:57:17'),
(16, 2, 2020, 3, 'CuotaMensual', 'Cuota de Mnnto Mensual Periodo 3 2020', 1300.00, '2020-03-02', '2020-03-12', 1, 1, '1', 2, '2020-08-19 02:57:17', '2020-08-19 02:57:17'),
(17, 3, 2020, 3, 'CuotaMensual', 'Cuota de Mnnto Mensual Periodo 3 2020', 1000.00, '2020-03-02', '2020-03-12', 1, 1, '1', 2, '2020-08-19 02:57:17', '2020-08-19 02:57:17'),
(18, 4, 2020, 3, 'CuotaMensual', 'Cuota de Mnnto Mensual Periodo 3 2020', 1000.00, '2020-03-02', '2020-03-12', 1, 1, '1', 2, '2020-08-19 02:57:17', '2020-08-19 02:57:17'),
(19, 5, 2020, 3, 'CuotaMensual', 'Cuota de Mnnto Mensual Periodo 3 2020', 2000.00, '2020-03-02', '2020-03-12', 1, 1, '1', 2, '2020-08-19 02:57:17', '2020-08-19 02:57:17'),
(20, 1, 2020, 4, 'CuotaMensual', 'Cuota de Mnnto Mensual Periodo 4 2020', 1300.00, '2020-04-01', '2020-04-11', 1, 1, '1', 2, '2020-08-19 02:57:48', '2020-08-19 02:57:48'),
(21, 2, 2020, 4, 'CuotaMensual', 'Cuota de Mnnto Mensual Periodo 4 2020', 1300.00, '2020-04-01', '2020-04-11', 1, 1, '1', 2, '2020-08-19 02:57:48', '2020-08-19 02:57:48'),
(22, 3, 2020, 4, 'CuotaMensual', 'Cuota de Mnnto Mensual Periodo 4 2020', 1000.00, '2020-04-01', '2020-04-11', 1, 1, '1', 2, '2020-08-19 02:57:48', '2020-08-19 02:57:48'),
(23, 4, 2020, 4, 'CuotaMensual', 'Cuota de Mnnto Mensual Periodo 4 2020', 1000.00, '2020-04-01', '2020-04-11', 1, 1, '1', 2, '2020-08-19 02:57:48', '2020-08-19 02:57:48'),
(24, 5, 2020, 4, 'CuotaMensual', 'Cuota de Mnnto Mensual Periodo 4 2020', 2000.00, '2020-04-01', '2020-04-11', 1, 1, '1', 2, '2020-08-19 02:57:48', '2020-08-19 02:57:48');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `condominia_types`
--

CREATE TABLE `condominia_types` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `code` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cooperation` double(12,2) NOT NULL DEFAULT 0.00,
  `active` enum('1','0') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1',
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `condominia_types`
--

INSERT INTO `condominia_types` (`id`, `code`, `description`, `cooperation`, `active`, `user_id`, `created_at`, `updated_at`) VALUES
(1, 'Nivel1', 'Planta Baja', 1300.00, '1', 2, NULL, '2020-08-07 02:02:33'),
(2, 'Nivel2', 'Planta Alta', 1000.00, '1', 2, NULL, '2020-08-07 03:27:18'),
(3, 'Nivel3', 'Suite PH', 2000.00, '1', 2, '2020-08-07 02:07:33', '2020-08-09 00:37:45');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `controlpermissions`
--

CREATE TABLE `controlpermissions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `readonly` enum('1','0') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  `suspended` enum('1','0') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `controlpermissions`
--

INSERT INTO `controlpermissions` (`id`, `readonly`, `suspended`, `created_at`, `updated_at`) VALUES
(1, '0', '0', NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `customers`
--

CREATE TABLE `customers` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `customerCode` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `rfc` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `movil` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `colony` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `town` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `city` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `zipCode` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `artrm_id` bigint(20) UNSIGNED DEFAULT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `active` enum('1','0') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1',
  `email` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='It contains the Customer data';

--
-- Volcado de datos para la tabla `customers`
--

INSERT INTO `customers` (`id`, `name`, `customerCode`, `rfc`, `movil`, `address`, `colony`, `town`, `city`, `zipCode`, `artrm_id`, `user_id`, `active`, `email`, `created_at`, `updated_at`) VALUES
(1, 'Empacadora La Mora S. A. de C. V.', 'La Mora', 'MORA1341445', '4423453333', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1', 'mora@mail.com', NULL, NULL),
(2, 'Envases Desechables Noria  S. A. de C. V.', 'La Noria', 'NORI1341445', '4428617299', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1', 'noria@mail.com', NULL, NULL),
(3, 'Distribuidora de Francia  S. A. de C. V.', 'Francia', 'FRAM1341445', '4429172881', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1', 'francia@mail.com', NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `debits`
--

CREATE TABLE `debits` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `condominia_id` bigint(20) UNSIGNED DEFAULT NULL,
  `datedoc` date DEFAULT NULL,
  `datedue` date DEFAULT NULL,
  `year` bigint(20) UNSIGNED DEFAULT NULL,
  `period` bigint(20) UNSIGNED DEFAULT NULL,
  `type` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `amount` double(12,2) NOT NULL DEFAULT 0.00,
  `percentagediscount` bigint(20) UNSIGNED DEFAULT NULL,
  `fund` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `budgetIncome_id` bigint(20) UNSIGNED DEFAULT NULL,
  `active` enum('1','0') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1',
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `deposits`
--

CREATE TABLE `deposits` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `datedoc` date DEFAULT NULL,
  `reference` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `comment` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `amount` double(12,2) NOT NULL DEFAULT 0.00,
  `type` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bank_id` bigint(20) DEFAULT NULL,
  `condominia_id` bigint(20) UNSIGNED DEFAULT NULL,
  `active` enum('1','0') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1',
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `deposits`
--

INSERT INTO `deposits` (`id`, `datedoc`, `reference`, `comment`, `amount`, `type`, `bank_id`, `condominia_id`, `active`, `user_id`, `created_at`, `updated_at`) VALUES
(3, '2020-01-06', '739562', 'pago mnto', 1500.00, 'Pago', 1, 1, '1', 2, '2020-08-19 03:01:38', '2020-08-19 03:01:38'),
(4, '2020-02-10', '924873', 'pago mnto', 1100.00, 'Pago', 1, 1, '1', 2, '2020-08-19 03:04:04', '2020-08-19 03:04:04'),
(5, '2020-03-09', '785488', 'pago mnto', 2000.00, 'Pago', 1, 1, '1', 2, '2020-08-19 03:05:23', '2020-08-19 03:05:23'),
(6, '2020-04-06', '783216', 'pago mnto', 1000.00, 'Pago', 1, 1, '1', 2, '2020-08-19 03:07:58', '2020-08-19 03:07:58'),
(7, '2020-01-06', '783456', 'pago mnto', 1300.00, 'Pago', 1, 2, '1', 2, '2020-08-19 03:24:33', '2020-08-19 03:24:33'),
(8, '2020-02-03', '935234', 'pago mnto', 1300.00, 'Pago', 1, 2, '1', 2, '2020-08-19 03:25:28', '2020-08-19 03:25:28'),
(9, '2020-03-02', '672344', 'pago mnto', 1300.00, 'Pago', 1, 2, '1', 2, '2020-08-19 03:25:56', '2020-08-19 03:25:56'),
(10, '2020-04-06', '237644', 'pago mnto', 1300.00, 'Pago', 1, 2, '1', 2, '2020-08-19 03:27:04', '2020-08-19 03:27:04'),
(11, '2020-01-07', '219312', 'pago mnto', 2000.00, 'Pago', 1, 3, '1', 2, '2020-08-19 03:29:30', '2020-08-19 03:29:30'),
(12, '2020-03-04', '321311', 'pago mnto', 2000.00, 'Pago', 1, 3, '1', 2, '2020-08-19 03:30:00', '2020-08-19 03:30:00'),
(14, '2020-01-08', '124244', 'pago mnto', 1000.00, 'Pago', 1, 4, '1', 2, '2020-08-19 03:33:10', '2020-08-19 03:33:10'),
(15, '2020-02-06', '312133', 'pago mnto', 1000.00, 'Pago', 1, 4, '1', 2, '2020-08-19 03:33:52', '2020-08-19 03:33:52'),
(16, '2020-03-06', '324466', 'pago mnto', 1000.00, 'Pago', 1, 4, '1', 2, '2020-08-19 03:35:02', '2020-08-19 03:35:02'),
(17, '2020-04-09', '552311', 'pago mnto', 1000.00, 'Pago', 1, 4, '1', 2, '2020-08-19 03:35:42', '2020-08-19 03:35:42'),
(18, '2020-01-08', '443222', 'pago mnto', 3000.00, 'Pago', 1, 5, '1', 2, '2020-08-19 03:36:51', '2020-08-19 03:36:51'),
(19, '2020-02-07', '642233', 'pago mnto', 2000.00, 'Pago', 1, 5, '1', 2, '2020-08-19 03:37:36', '2020-08-19 03:37:36'),
(20, '2020-03-09', '552211', 'pago mnto', 1000.00, 'Pago', 1, 5, '1', 2, '2020-08-19 03:38:51', '2020-08-19 03:38:51'),
(21, '2020-04-06', '235565', 'pago mnto', 2000.00, 'Pago', 1, 5, '1', 2, '2020-08-19 03:39:56', '2020-08-19 03:39:56');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `events`
--

CREATE TABLE `events` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `description` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `dateEvent` date DEFAULT NULL,
  `until` date DEFAULT NULL,
  `active` enum('1','0') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1',
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `events`
--

INSERT INTO `events` (`id`, `description`, `dateEvent`, `until`, `active`, `user_id`, `created_at`, `updated_at`) VALUES
(1, 'Corte de suministro electrico 10:00hrs a 14:00hrs', '2020-08-24', NULL, '1', 2, NULL, '2020-08-15 22:20:39'),
(2, 'Corte de suministro de', '2020-08-15', NULL, '1', 2, '2020-08-15 22:23:35', '2020-08-15 22:23:35');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `expenses`
--

CREATE TABLE `expenses` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `datedoc` date DEFAULT NULL,
  `datedue` date DEFAULT NULL,
  `dateapp` date DEFAULT NULL,
  `description` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `referenceapp` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `provider_id` bigint(20) UNSIGNED DEFAULT NULL,
  `budget_id` bigint(20) UNSIGNED DEFAULT NULL,
  `amount` double(12,2) NOT NULL DEFAULT 0.00,
  `amountapp` double(12,2) NOT NULL DEFAULT 0.00,
  `approved` enum('1','0') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  `active` enum('1','0') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1',
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `expenses`
--

INSERT INTO `expenses` (`id`, `datedoc`, `datedue`, `dateapp`, `description`, `referenceapp`, `provider_id`, `budget_id`, `amount`, `amountapp`, `approved`, `active`, `user_id`, `created_at`, `updated_at`) VALUES
(1, '2020-08-03', NULL, NULL, 'Pago de servicio', 'deposito 7172', 1, 3, 1321.00, 1321.00, '0', '1', 2, NULL, '2020-08-08 03:14:58'),
(2, '2020-08-05', NULL, NULL, 'Segundo Pago', NULL, 2, 1, 2073.00, 0.00, '0', '1', 2, NULL, '2020-08-08 03:15:30'),
(3, '2020-01-01', NULL, NULL, 'Renovación de tuberías', NULL, 2, 2, 1235.00, 0.00, '0', '1', 2, '2020-08-07 22:57:49', '2020-08-07 22:57:49'),
(4, '2020-08-07', NULL, NULL, 'Mantenimiento de patios', NULL, 4, 4, 2359.00, 0.00, '0', '0', 2, '2020-08-07 23:19:58', '2020-08-08 03:15:49');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `facilities`
--

CREATE TABLE `facilities` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `regulation` varchar(1000) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cost` double(12,2) NOT NULL DEFAULT 0.00,
  `active` enum('1','0') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1',
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `facilities`
--

INSERT INTO `facilities` (`id`, `name`, `description`, `regulation`, `cost`, `active`, `user_id`, `created_at`, `updated_at`) VALUES
(1, 'Piscina Techada', 'Piscina para un max. de 30 personas, clima ...', 'Horario desde 8:00 hrs a 18.00 hrs', 1000.00, '1', 2, NULL, '2020-08-16 20:24:51'),
(2, 'Jardin de eventos', '150 mts cuadrados', 'Horario desde 8:00 hrs a 18.00 hrs', 1000.00, '1', 2, '2020-08-16 20:26:24', '2020-08-16 20:26:42');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `facilities_reserves`
--

CREATE TABLE `facilities_reserves` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `dateStart` datetime DEFAULT NULL,
  `dateEnd` datetime DEFAULT NULL,
  `facilities_id` bigint(20) UNSIGNED DEFAULT NULL,
  `tenant_id` bigint(20) UNSIGNED DEFAULT NULL,
  `reason` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `confirm` enum('1','0') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  `active` enum('1','0') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1',
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `funds`
--

CREATE TABLE `funds` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `code` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `active` enum('1','0') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1',
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `funds`
--

INSERT INTO `funds` (`id`, `code`, `description`, `active`, `user_id`, `created_at`, `updated_at`) VALUES
(1, 'Ordinario', 'Fondo Ordinario.', '1', 2, NULL, '2020-08-17 02:44:13'),
(2, 'Extraordinario', 'Fondo Extraordinario', '1', 2, '2020-08-17 02:44:49', '2020-08-19 06:57:20');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `logs`
--

CREATE TABLE `logs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `event` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `logs`
--

INSERT INTO `logs` (`id`, `user_id`, `event`, `created_at`, `updated_at`) VALUES
(1, 2, 'Login success', '2020-08-05 08:29:44', '2020-08-05 08:29:44'),
(2, 2, 'Login success', '2020-08-05 08:31:43', '2020-08-05 08:31:43'),
(3, 2, 'Login success', '2020-08-05 08:35:03', '2020-08-05 08:35:03'),
(4, 0, 'Login failed carlos_asrnet@hotmail.com', '2020-08-05 08:35:16', '2020-08-05 08:35:16'),
(5, 2, 'Login success', '2020-08-05 08:35:23', '2020-08-05 08:35:23'),
(6, 2, 'Login success', '2020-08-05 08:43:29', '2020-08-05 08:43:29'),
(7, 0, 'Login failed carlos_asrnet@hotmail.com', '2020-08-05 08:54:42', '2020-08-05 08:54:42'),
(8, 2, 'Login success', '2020-08-05 08:54:46', '2020-08-05 08:54:46'),
(9, 2, 'Login success', '2020-08-05 22:58:01', '2020-08-05 22:58:01'),
(10, 2, 'Login success', '2020-08-06 00:44:18', '2020-08-06 00:44:18'),
(11, 2, 'Login success', '2020-08-05 20:08:05', '2020-08-05 20:08:05'),
(12, 2, 'Login success', '2020-08-05 21:20:21', '2020-08-05 21:20:21'),
(13, 2, 'Menu', '2020-08-05 21:20:33', '2020-08-05 21:20:33'),
(14, 2, 'Profile', '2020-08-05 21:20:37', '2020-08-05 21:20:37'),
(15, 2, 'Usuario', '2020-08-05 21:20:40', '2020-08-05 21:20:40'),
(16, 2, 'Template', '2020-08-05 21:20:42', '2020-08-05 21:20:42'),
(17, 2, 'Login success', '2020-08-06 02:07:09', '2020-08-06 02:07:09'),
(18, 2, 'Profile', '2020-08-06 02:07:19', '2020-08-06 02:07:19'),
(19, 2, 'Login success', '2020-08-06 02:07:44', '2020-08-06 02:07:44'),
(20, 2, 'Error404', '2020-08-06 02:07:54', '2020-08-06 02:07:54'),
(21, 2, 'Budgets', '2020-08-06 02:10:44', '2020-08-06 02:10:44'),
(22, 2, 'Login success', '2020-08-06 03:23:29', '2020-08-06 03:23:29'),
(23, 2, 'Budgets', '2020-08-06 03:23:34', '2020-08-06 03:23:34'),
(24, 2, 'Login success', '2020-08-06 04:46:46', '2020-08-06 04:46:46'),
(25, 2, 'Budgets', '2020-08-06 04:47:02', '2020-08-06 04:47:02'),
(26, 2, 'Home', '2020-08-06 05:00:19', '2020-08-06 05:00:19'),
(27, 2, 'Budgets', '2020-08-06 05:00:28', '2020-08-06 05:00:28'),
(28, 2, 'Home', '2020-08-06 05:02:58', '2020-08-06 05:02:58'),
(29, 2, 'Budgets', '2020-08-06 05:03:08', '2020-08-06 05:03:08'),
(30, 2, 'Home', '2020-08-06 05:08:09', '2020-08-06 05:08:09'),
(31, 2, 'Usuario', '2020-08-06 05:08:13', '2020-08-06 05:08:13'),
(32, 2, 'Profile', '2020-08-06 05:08:25', '2020-08-06 05:08:25'),
(33, 2, 'Menu', '2020-08-06 05:08:28', '2020-08-06 05:08:28'),
(34, 2, 'Usuario', '2020-08-06 05:09:47', '2020-08-06 05:09:47'),
(35, 2, 'Budgets', '2020-08-06 05:10:56', '2020-08-06 05:10:56'),
(36, 2, 'Home', '2020-08-06 05:24:27', '2020-08-06 05:24:27'),
(37, 2, 'Budgets', '2020-08-06 05:33:59', '2020-08-06 05:33:59'),
(38, 2, 'Login success', '2020-08-06 05:48:53', '2020-08-06 05:48:53'),
(39, 2, 'Budgets', '2020-08-06 05:49:02', '2020-08-06 05:49:02'),
(40, 2, 'Login success', '2020-08-06 06:53:34', '2020-08-06 06:53:34'),
(41, 2, 'Budgets', '2020-08-06 06:53:42', '2020-08-06 06:53:42'),
(42, 2, 'Login success', '2020-08-06 07:57:45', '2020-08-06 07:57:45'),
(43, 2, 'Budgets', '2020-08-06 07:57:52', '2020-08-06 07:57:52'),
(44, 2, 'Login success', '2020-08-06 08:19:08', '2020-08-06 08:19:08'),
(45, 2, 'Budgets', '2020-08-06 08:19:38', '2020-08-06 08:19:38'),
(46, 2, 'Home', '2020-08-06 08:36:30', '2020-08-06 08:36:30'),
(47, 2, 'Login success', '2020-08-06 08:55:51', '2020-08-06 08:55:51'),
(48, 2, 'Budgets', '2020-08-06 08:55:59', '2020-08-06 08:55:59'),
(49, 2, 'Login success', '2020-08-06 15:29:25', '2020-08-06 15:29:25'),
(50, 2, 'Budgets', '2020-08-06 15:29:36', '2020-08-06 15:29:36'),
(51, 0, 'Login failed carlos_asrnet@hotmail.com', '2020-08-06 15:54:01', '2020-08-06 15:54:01'),
(52, 2, 'Login success', '2020-08-06 15:54:05', '2020-08-06 15:54:05'),
(53, 2, 'Budgets', '2020-08-06 15:54:10', '2020-08-06 15:54:10'),
(54, 2, 'Login success', '2020-08-06 15:55:54', '2020-08-06 15:55:54'),
(55, 2, 'Budgets', '2020-08-06 15:56:05', '2020-08-06 15:56:05'),
(56, 2, 'Home', '2020-08-06 16:11:44', '2020-08-06 16:11:44'),
(57, 2, 'Budgets', '2020-08-06 16:11:50', '2020-08-06 16:11:50'),
(58, 2, 'Home', '2020-08-06 16:14:26', '2020-08-06 16:14:26'),
(59, 2, 'Budgets', '2020-08-06 16:14:30', '2020-08-06 16:14:30'),
(60, 2, 'Home', '2020-08-06 16:47:20', '2020-08-06 16:47:20'),
(61, 2, 'Budgets', '2020-08-06 16:47:45', '2020-08-06 16:47:45'),
(62, 2, 'Login success', '2020-08-06 17:02:32', '2020-08-06 17:02:32'),
(63, 2, 'Budgets', '2020-08-06 17:02:41', '2020-08-06 17:02:41'),
(64, 2, 'Home', '2020-08-06 17:05:24', '2020-08-06 17:05:24'),
(65, 2, 'Budgets', '2020-08-06 17:07:00', '2020-08-06 17:07:00'),
(66, 2, 'Login success', '2020-08-06 17:16:23', '2020-08-06 17:16:23'),
(67, 2, 'Budgets', '2020-08-06 17:16:30', '2020-08-06 17:16:30'),
(68, 2, 'Home', '2020-08-06 17:25:46', '2020-08-06 17:25:46'),
(69, 2, 'Budgets', '2020-08-06 17:25:51', '2020-08-06 17:25:51'),
(70, 2, 'Home', '2020-08-06 17:26:52', '2020-08-06 17:26:52'),
(71, 2, 'Budgets', '2020-08-06 17:26:55', '2020-08-06 17:26:55'),
(72, 2, 'Home', '2020-08-06 17:27:52', '2020-08-06 17:27:52'),
(73, 2, 'Login success', '2020-08-06 17:36:56', '2020-08-06 17:36:56'),
(74, 2, 'BudgeClo', '2020-08-06 17:37:05', '2020-08-06 17:37:05'),
(75, 2, 'Home', '2020-08-06 17:41:24', '2020-08-06 17:41:24'),
(76, 2, 'Budgets', '2020-08-06 17:41:31', '2020-08-06 17:41:31'),
(77, 2, 'Home', '2020-08-06 17:43:00', '2020-08-06 17:43:00'),
(78, 2, 'Error404', '2020-08-06 17:43:09', '2020-08-06 17:43:09'),
(79, 2, 'Budgets', '2020-08-06 17:43:25', '2020-08-06 17:43:25'),
(80, 2, 'Home', '2020-08-06 17:43:51', '2020-08-06 17:43:51'),
(81, 2, 'BudgeClo', '2020-08-06 17:44:00', '2020-08-06 17:44:00'),
(82, 2, 'Login success', '2020-08-06 18:30:03', '2020-08-06 18:30:03'),
(83, 2, 'BudgeClo', '2020-08-06 18:30:09', '2020-08-06 18:30:09'),
(84, 2, 'Home', '2020-08-06 18:56:57', '2020-08-06 18:56:57'),
(85, 2, 'Budgets', '2020-08-06 18:57:02', '2020-08-06 18:57:02'),
(86, 2, 'Home', '2020-08-06 18:57:34', '2020-08-06 18:57:34'),
(87, 2, 'BudgeClo', '2020-08-06 18:57:48', '2020-08-06 18:57:48'),
(88, 0, 'Login failed carlos_asrnet@hotmail.com', '2020-08-06 19:30:24', '2020-08-06 19:30:24'),
(89, 2, 'Login success', '2020-08-06 19:30:30', '2020-08-06 19:30:30'),
(90, 2, 'BudgeClo', '2020-08-06 19:30:37', '2020-08-06 19:30:37'),
(91, 2, 'Home', '2020-08-06 20:09:12', '2020-08-06 20:09:12'),
(92, 0, 'Login failed carlos_asrnet@hotmail.com', '2020-08-06 21:42:07', '2020-08-06 21:42:07'),
(93, 2, 'Login success', '2020-08-06 21:42:12', '2020-08-06 21:42:12'),
(94, 2, 'Condomin', '2020-08-06 21:55:50', '2020-08-06 21:55:50'),
(95, 2, 'Login success', '2020-08-06 22:42:22', '2020-08-06 22:42:22'),
(96, 2, 'Condomin', '2020-08-06 22:42:39', '2020-08-06 22:42:39'),
(97, 2, 'Home', '2020-08-06 23:18:37', '2020-08-06 23:18:37'),
(98, 2, 'Condomin', '2020-08-06 23:20:02', '2020-08-06 23:20:02'),
(99, 2, 'Home', '2020-08-06 23:21:25', '2020-08-06 23:21:25'),
(100, 2, 'Condomin', '2020-08-06 23:21:34', '2020-08-06 23:21:34'),
(101, 2, 'Login success', '2020-08-06 23:42:45', '2020-08-06 23:42:45'),
(102, 2, 'Condomin', '2020-08-06 23:42:51', '2020-08-06 23:42:51'),
(103, 2, 'Home', '2020-08-06 23:55:13', '2020-08-06 23:55:13'),
(104, 2, 'Condomin', '2020-08-06 23:55:20', '2020-08-06 23:55:20'),
(105, 2, 'Home', '2020-08-07 00:05:43', '2020-08-07 00:05:43'),
(106, 2, 'Condomin', '2020-08-07 00:06:31', '2020-08-07 00:06:31'),
(107, 2, 'Home', '2020-08-07 00:07:10', '2020-08-07 00:07:10'),
(108, 2, 'Error404', '2020-08-07 00:13:08', '2020-08-07 00:13:08'),
(109, 2, 'CondTyp', '2020-08-07 00:14:11', '2020-08-07 00:14:11'),
(110, 2, 'Condomin', '2020-08-07 00:27:02', '2020-08-07 00:27:02'),
(111, 2, 'Home', '2020-08-07 00:27:12', '2020-08-07 00:27:12'),
(112, 2, 'CondTyp', '2020-08-07 00:27:19', '2020-08-07 00:27:19'),
(113, 2, 'Budgets', '2020-08-07 00:31:31', '2020-08-07 00:31:31'),
(114, 2, 'Home', '2020-08-07 00:33:40', '2020-08-07 00:33:40'),
(115, 2, 'CondTyp', '2020-08-07 00:33:43', '2020-08-07 00:33:43'),
(116, 2, 'Login success', '2020-08-07 00:51:51', '2020-08-07 00:51:51'),
(117, 2, 'CondTyp', '2020-08-07 00:52:01', '2020-08-07 00:52:01'),
(118, 2, 'Login success', '2020-08-07 01:54:08', '2020-08-07 01:54:08'),
(119, 2, 'CondTyp', '2020-08-07 01:54:15', '2020-08-07 01:54:15'),
(120, 2, 'Home', '2020-08-07 02:08:06', '2020-08-07 02:08:06'),
(121, 2, 'Condomin', '2020-08-07 02:08:30', '2020-08-07 02:08:30'),
(122, 2, 'Home', '2020-08-07 02:10:01', '2020-08-07 02:10:01'),
(123, 2, 'CondTyp', '2020-08-07 02:10:16', '2020-08-07 02:10:16'),
(124, 2, 'Home', '2020-08-07 02:12:43', '2020-08-07 02:12:43'),
(125, 2, 'BudgeClo', '2020-08-07 02:12:59', '2020-08-07 02:12:59'),
(126, 2, 'Home', '2020-08-07 02:13:09', '2020-08-07 02:13:09'),
(127, 2, 'Condomin', '2020-08-07 02:13:51', '2020-08-07 02:13:51'),
(128, 2, 'Home', '2020-08-07 02:13:55', '2020-08-07 02:13:55'),
(129, 2, 'Budgets', '2020-08-07 02:13:59', '2020-08-07 02:13:59'),
(130, 2, 'Home', '2020-08-07 02:14:03', '2020-08-07 02:14:03'),
(131, 2, 'CondTyp', '2020-08-07 02:14:05', '2020-08-07 02:14:05'),
(132, 2, 'Home', '2020-08-07 02:14:18', '2020-08-07 02:14:18'),
(133, 2, 'Budgets', '2020-08-07 02:35:56', '2020-08-07 02:35:56'),
(134, 2, 'Home', '2020-08-07 02:36:05', '2020-08-07 02:36:05'),
(135, 2, 'BudgeClo', '2020-08-07 02:36:16', '2020-08-07 02:36:16'),
(136, 2, 'Home', '2020-08-07 02:36:20', '2020-08-07 02:36:20'),
(137, 2, 'Budgets', '2020-08-07 02:36:24', '2020-08-07 02:36:24'),
(138, 2, 'Home', '2020-08-07 02:36:53', '2020-08-07 02:36:53'),
(139, 2, 'Error404', '2020-08-07 02:49:58', '2020-08-07 02:49:58'),
(140, 2, 'Login success', '2020-08-07 02:50:33', '2020-08-07 02:50:33'),
(141, 2, 'Quota', '2020-08-07 02:50:37', '2020-08-07 02:50:37'),
(142, 2, 'Home', '2020-08-07 03:02:16', '2020-08-07 03:02:16'),
(143, 2, 'Quota', '2020-08-07 03:03:08', '2020-08-07 03:03:08'),
(144, 2, 'Home', '2020-08-07 03:25:04', '2020-08-07 03:25:04'),
(145, 2, 'CondTyp', '2020-08-07 03:25:15', '2020-08-07 03:25:15'),
(146, 2, 'Home', '2020-08-07 03:26:06', '2020-08-07 03:26:06'),
(147, 2, 'Quota', '2020-08-07 03:26:15', '2020-08-07 03:26:15'),
(148, 2, 'Home', '2020-08-07 03:27:10', '2020-08-07 03:27:10'),
(149, 2, 'CondTyp', '2020-08-07 03:27:12', '2020-08-07 03:27:12'),
(150, 2, 'Home', '2020-08-07 03:27:23', '2020-08-07 03:27:23'),
(151, 2, 'Quota', '2020-08-07 03:27:26', '2020-08-07 03:27:26'),
(152, 2, 'Home', '2020-08-07 03:27:38', '2020-08-07 03:27:38'),
(153, 2, 'Budgets', '2020-08-07 03:27:42', '2020-08-07 03:27:42'),
(154, 2, 'Home', '2020-08-07 03:27:53', '2020-08-07 03:27:53'),
(155, 2, 'Condomin', '2020-08-07 03:27:56', '2020-08-07 03:27:56'),
(156, 2, 'Home', '2020-08-07 03:28:12', '2020-08-07 03:28:12'),
(157, 2, 'Quota', '2020-08-07 03:28:15', '2020-08-07 03:28:15'),
(158, 2, 'Login success', '2020-08-07 03:52:57', '2020-08-07 03:52:57'),
(159, 2, 'Quota', '2020-08-07 03:53:07', '2020-08-07 03:53:07'),
(160, 2, 'Home', '2020-08-07 03:53:18', '2020-08-07 03:53:18'),
(161, 2, 'Quota', '2020-08-07 03:53:27', '2020-08-07 03:53:27'),
(162, 2, 'Home', '2020-08-07 04:04:07', '2020-08-07 04:04:07'),
(163, 2, 'Quota', '2020-08-07 04:04:26', '2020-08-07 04:04:26'),
(164, 2, 'Home', '2020-08-07 04:05:53', '2020-08-07 04:05:53'),
(165, 2, 'Condomin', '2020-08-07 04:06:00', '2020-08-07 04:06:00'),
(166, 2, 'Home', '2020-08-07 04:06:43', '2020-08-07 04:06:43'),
(167, 2, 'Condomin', '2020-08-07 04:06:47', '2020-08-07 04:06:47'),
(168, 2, 'Home', '2020-08-07 04:07:12', '2020-08-07 04:07:12'),
(169, 2, 'CondTyp', '2020-08-07 04:07:15', '2020-08-07 04:07:15'),
(170, 2, 'Home', '2020-08-07 04:07:22', '2020-08-07 04:07:22'),
(171, 2, 'Condomin', '2020-08-07 04:07:26', '2020-08-07 04:07:26'),
(172, 2, 'Home', '2020-08-07 04:07:43', '2020-08-07 04:07:43'),
(173, 2, 'CondTyp', '2020-08-07 04:07:50', '2020-08-07 04:07:50'),
(174, 2, 'Home', '2020-08-07 04:07:58', '2020-08-07 04:07:58'),
(175, 2, 'Quota', '2020-08-07 04:08:01', '2020-08-07 04:08:01'),
(176, 2, 'Home', '2020-08-07 04:09:23', '2020-08-07 04:09:23'),
(177, 2, 'CondTyp', '2020-08-07 04:09:25', '2020-08-07 04:09:25'),
(178, 2, 'Home', '2020-08-07 04:10:18', '2020-08-07 04:10:18'),
(179, 2, 'Condomin', '2020-08-07 04:10:23', '2020-08-07 04:10:23'),
(180, 2, 'Home', '2020-08-07 04:10:47', '2020-08-07 04:10:47'),
(181, 2, 'Quota', '2020-08-07 04:10:50', '2020-08-07 04:10:50'),
(182, 2, 'Home', '2020-08-07 04:11:45', '2020-08-07 04:11:45'),
(183, 2, 'Condomin', '2020-08-07 04:11:49', '2020-08-07 04:11:49'),
(184, 2, 'Home', '2020-08-07 04:12:10', '2020-08-07 04:12:10'),
(185, 2, 'CondTyp', '2020-08-07 04:12:14', '2020-08-07 04:12:14'),
(186, 2, 'Home', '2020-08-07 04:12:26', '2020-08-07 04:12:26'),
(187, 2, 'Quota', '2020-08-07 04:12:32', '2020-08-07 04:12:32'),
(188, 2, 'Home', '2020-08-07 04:12:44', '2020-08-07 04:12:44'),
(189, 2, 'Budgets', '2020-08-07 04:12:47', '2020-08-07 04:12:47'),
(190, 2, 'Home', '2020-08-07 04:12:59', '2020-08-07 04:12:59'),
(191, 2, 'Condomin', '2020-08-07 04:13:03', '2020-08-07 04:13:03'),
(192, 2, 'Home', '2020-08-07 04:13:40', '2020-08-07 04:13:40'),
(193, 2, 'CondTyp', '2020-08-07 04:13:46', '2020-08-07 04:13:46'),
(194, 2, 'Home', '2020-08-07 04:13:59', '2020-08-07 04:13:59'),
(195, 2, 'Condomin', '2020-08-07 04:14:02', '2020-08-07 04:14:02'),
(196, 2, 'Home', '2020-08-07 04:14:06', '2020-08-07 04:14:06'),
(197, 2, 'Condomin', '2020-08-07 04:18:30', '2020-08-07 04:18:30'),
(198, 2, 'Home', '2020-08-07 04:18:44', '2020-08-07 04:18:44'),
(199, 2, 'Budgets', '2020-08-07 04:18:50', '2020-08-07 04:18:50'),
(200, 2, 'Home', '2020-08-07 04:19:00', '2020-08-07 04:19:00'),
(201, 2, 'CondTyp', '2020-08-07 04:19:05', '2020-08-07 04:19:05'),
(202, 2, 'Home', '2020-08-07 04:19:13', '2020-08-07 04:19:13'),
(203, 2, 'Quota', '2020-08-07 04:19:16', '2020-08-07 04:19:16'),
(204, 2, 'Home', '2020-08-07 04:19:39', '2020-08-07 04:19:39'),
(205, 2, 'BudgeClo', '2020-08-07 04:19:45', '2020-08-07 04:19:45'),
(206, 2, 'Home', '2020-08-07 04:19:48', '2020-08-07 04:19:48'),
(207, 2, 'Quota', '2020-08-07 04:19:52', '2020-08-07 04:19:52'),
(208, 2, 'Home', '2020-08-07 04:20:37', '2020-08-07 04:20:37'),
(209, 2, 'Provider', '2020-08-07 04:32:19', '2020-08-07 04:32:19'),
(210, 2, 'CondTyp', '2020-08-07 04:35:29', '2020-08-07 04:35:29'),
(211, 2, 'Home', '2020-08-07 04:35:31', '2020-08-07 04:35:31'),
(212, 2, 'Provider', '2020-08-07 04:42:02', '2020-08-07 04:42:02'),
(213, 2, 'Login success', '2020-08-07 04:56:12', '2020-08-07 04:56:12'),
(214, 2, 'Quota', '2020-08-07 04:56:24', '2020-08-07 04:56:24'),
(215, 2, 'Home', '2020-08-07 04:56:26', '2020-08-07 04:56:26'),
(216, 2, 'Provider', '2020-08-07 04:56:29', '2020-08-07 04:56:29'),
(217, 2, 'Home', '2020-08-07 04:56:41', '2020-08-07 04:56:41'),
(218, 2, 'Login success', '2020-08-07 04:56:53', '2020-08-07 04:56:53'),
(219, 2, 'Provider', '2020-08-07 04:56:59', '2020-08-07 04:56:59'),
(220, 2, 'Home', '2020-08-07 05:02:44', '2020-08-07 05:02:44'),
(221, 2, 'Quota', '2020-08-07 05:02:46', '2020-08-07 05:02:46'),
(222, 2, 'Home', '2020-08-07 05:02:52', '2020-08-07 05:02:52'),
(223, 2, 'Provider', '2020-08-07 05:02:56', '2020-08-07 05:02:56'),
(224, 2, 'Home', '2020-08-07 05:07:33', '2020-08-07 05:07:33'),
(225, 2, 'Provider', '2020-08-07 05:07:42', '2020-08-07 05:07:42'),
(226, 2, 'Home', '2020-08-07 05:08:31', '2020-08-07 05:08:31'),
(227, 2, 'Provider', '2020-08-07 05:09:49', '2020-08-07 05:09:49'),
(228, 2, 'Home', '2020-08-07 05:15:12', '2020-08-07 05:15:12'),
(229, 2, 'Provider', '2020-08-07 05:15:49', '2020-08-07 05:15:49'),
(230, 2, 'Home', '2020-08-07 05:16:00', '2020-08-07 05:16:00'),
(231, 2, 'Expense', '2020-08-07 05:30:54', '2020-08-07 05:30:54'),
(232, 2, 'Login success', '2020-08-07 05:57:40', '2020-08-07 05:57:40'),
(233, 2, 'Expense', '2020-08-07 06:00:47', '2020-08-07 06:00:47'),
(234, 2, 'Home', '2020-08-07 06:06:16', '2020-08-07 06:06:16'),
(235, 2, 'Provider', '2020-08-07 06:06:19', '2020-08-07 06:06:19'),
(236, 2, 'Home', '2020-08-07 06:07:13', '2020-08-07 06:07:13'),
(237, 2, 'Expense', '2020-08-07 06:07:19', '2020-08-07 06:07:19'),
(238, 2, 'Login success', '2020-08-07 06:57:53', '2020-08-07 06:57:53'),
(239, 2, 'Expense', '2020-08-07 06:57:58', '2020-08-07 06:57:58'),
(240, 2, 'Home', '2020-08-07 07:10:00', '2020-08-07 07:10:00'),
(241, 2, 'Login success', '2020-08-07 17:29:12', '2020-08-07 17:29:12'),
(242, 2, 'Expense', '2020-08-07 17:29:21', '2020-08-07 17:29:21'),
(243, 2, 'Home', '2020-08-07 17:50:29', '2020-08-07 17:50:29'),
(244, 2, 'Expense', '2020-08-07 17:50:40', '2020-08-07 17:50:40'),
(245, 2, 'Home', '2020-08-07 18:06:53', '2020-08-07 18:06:53'),
(246, 2, 'Expense', '2020-08-07 18:08:20', '2020-08-07 18:08:20'),
(247, 2, 'Home', '2020-08-07 18:20:04', '2020-08-07 18:20:04'),
(248, 2, 'Provider', '2020-08-07 18:20:08', '2020-08-07 18:20:08'),
(249, 2, 'Home', '2020-08-07 18:21:37', '2020-08-07 18:21:37'),
(250, 2, 'Provider', '2020-08-07 18:21:40', '2020-08-07 18:21:40'),
(251, 2, 'Home', '2020-08-07 18:21:46', '2020-08-07 18:21:46'),
(252, 2, 'Expense', '2020-08-07 18:21:54', '2020-08-07 18:21:54'),
(253, 2, 'Home', '2020-08-07 18:23:52', '2020-08-07 18:23:52'),
(254, 2, 'Login success', '2020-08-07 19:01:48', '2020-08-07 19:01:48'),
(255, 2, 'Condomin', '2020-08-07 19:01:57', '2020-08-07 19:01:57'),
(256, 2, 'Home', '2020-08-07 19:09:03', '2020-08-07 19:09:03'),
(257, 2, 'Condomin', '2020-08-07 19:09:11', '2020-08-07 19:09:11'),
(258, 2, 'Home', '2020-08-07 19:14:45', '2020-08-07 19:14:45'),
(259, 2, 'Condomin', '2020-08-07 19:23:20', '2020-08-07 19:23:20'),
(260, 2, 'Login success', '2020-08-07 20:06:09', '2020-08-07 20:06:09'),
(261, 2, 'Condomin', '2020-08-07 20:06:13', '2020-08-07 20:06:13'),
(262, 2, 'Home', '2020-08-07 20:14:47', '2020-08-07 20:14:47'),
(263, 2, 'Login success', '2020-08-07 21:07:27', '2020-08-07 21:07:27'),
(264, 2, 'Condomin', '2020-08-07 21:07:35', '2020-08-07 21:07:35'),
(265, 2, 'Home', '2020-08-07 21:09:48', '2020-08-07 21:09:48'),
(266, 2, 'Expense', '2020-08-07 21:49:08', '2020-08-07 21:49:08'),
(267, 2, 'Home', '2020-08-07 21:49:30', '2020-08-07 21:49:30'),
(268, 2, 'Expense', '2020-08-07 21:54:38', '2020-08-07 21:54:38'),
(269, 2, 'Home', '2020-08-07 22:03:43', '2020-08-07 22:03:43'),
(270, 2, 'Budgets', '2020-08-07 22:03:47', '2020-08-07 22:03:47'),
(271, 2, 'Login success', '2020-08-07 22:08:15', '2020-08-07 22:08:15'),
(272, 2, 'Budgets', '2020-08-07 22:08:25', '2020-08-07 22:08:25'),
(273, 2, 'Home', '2020-08-07 22:14:18', '2020-08-07 22:14:18'),
(274, 2, 'Expense', '2020-08-07 22:14:24', '2020-08-07 22:14:24'),
(275, 2, 'Home', '2020-08-07 22:14:36', '2020-08-07 22:14:36'),
(276, 2, 'Expense', '2020-08-07 22:14:39', '2020-08-07 22:14:39'),
(277, 2, 'Home', '2020-08-07 22:15:54', '2020-08-07 22:15:54'),
(278, 2, 'Budgets', '2020-08-07 22:16:07', '2020-08-07 22:16:07'),
(279, 2, 'Home', '2020-08-07 22:17:17', '2020-08-07 22:17:17'),
(280, 2, 'BudgeClo', '2020-08-07 22:17:21', '2020-08-07 22:17:21'),
(281, 2, 'Home', '2020-08-07 22:17:30', '2020-08-07 22:17:30'),
(282, 2, 'Budgets', '2020-08-07 22:17:34', '2020-08-07 22:17:34'),
(283, 2, 'Home', '2020-08-07 22:18:03', '2020-08-07 22:18:03'),
(284, 2, 'Login success', '2020-08-07 22:28:16', '2020-08-07 22:28:16'),
(285, 2, 'Monthf', '2020-08-07 22:28:24', '2020-08-07 22:28:24'),
(286, 2, 'Home', '2020-08-07 22:59:06', '2020-08-07 22:59:06'),
(287, 2, 'Monthf', '2020-08-07 22:59:11', '2020-08-07 22:59:11'),
(288, 2, 'Login success', '2020-08-07 23:29:10', '2020-08-07 23:29:10'),
(289, 2, 'Monthf', '2020-08-07 23:29:14', '2020-08-07 23:29:14'),
(290, 2, 'Login success', '2020-08-08 00:29:27', '2020-08-08 00:29:27'),
(291, 2, 'Monthf', '2020-08-08 00:29:34', '2020-08-08 00:29:34'),
(292, 2, 'Login success', '2020-08-08 02:40:20', '2020-08-08 02:40:20'),
(293, 2, 'Monthf', '2020-08-08 02:40:27', '2020-08-08 02:40:27'),
(294, 2, 'Home', '2020-08-08 03:11:08', '2020-08-08 03:11:08'),
(295, 2, 'Expense', '2020-08-08 03:28:55', '2020-08-08 03:28:55'),
(296, 2, 'Home', '2020-08-08 03:33:16', '2020-08-08 03:33:16'),
(297, 2, 'Monthf', '2020-08-08 03:33:19', '2020-08-08 03:33:19'),
(298, 2, 'Home', '2020-08-08 03:37:27', '2020-08-08 03:37:27'),
(299, 2, 'Login success', '2020-08-08 03:44:05', '2020-08-08 03:44:05'),
(300, 2, 'Monthf', '2020-08-08 03:44:14', '2020-08-08 03:44:14'),
(301, 2, 'Home', '2020-08-08 03:57:41', '2020-08-08 03:57:41'),
(302, 2, 'Monthf', '2020-08-08 03:58:48', '2020-08-08 03:58:48'),
(303, 2, 'Login success', '2020-08-08 04:44:24', '2020-08-08 04:44:24'),
(304, 2, 'Monthf', '2020-08-08 04:44:34', '2020-08-08 04:44:34'),
(305, 2, 'Home', '2020-08-08 05:23:36', '2020-08-08 05:23:36'),
(306, 2, 'Monthf', '2020-08-08 05:23:46', '2020-08-08 05:23:46'),
(307, 2, 'Monthf', '2020-08-08 05:24:48', '2020-08-08 05:24:48'),
(308, 2, 'Home', '2020-08-08 05:32:58', '2020-08-08 05:32:58'),
(309, 2, 'Monthf', '2020-08-08 05:33:42', '2020-08-08 05:33:42'),
(310, 2, 'Home', '2020-08-08 05:34:24', '2020-08-08 05:34:24'),
(311, 2, 'Monthf', '2020-08-08 05:34:28', '2020-08-08 05:34:28'),
(312, 2, 'Home', '2020-08-08 05:34:49', '2020-08-08 05:34:49'),
(313, 2, 'Expense', '2020-08-08 05:36:10', '2020-08-08 05:36:10'),
(314, 2, 'Home', '2020-08-08 05:36:18', '2020-08-08 05:36:18'),
(315, 2, 'BudgeClo', '2020-08-08 05:36:37', '2020-08-08 05:36:37'),
(316, 2, 'Home', '2020-08-08 05:36:46', '2020-08-08 05:36:46'),
(317, 2, 'Quotaj', '2020-08-08 05:42:53', '2020-08-08 05:42:53'),
(318, 2, 'Login success', '2020-08-08 05:52:29', '2020-08-08 05:52:29'),
(319, 2, 'Quotaj', '2020-08-08 05:52:35', '2020-08-08 05:52:35'),
(320, 2, 'Monthf', '2020-08-08 06:36:46', '2020-08-08 06:36:46'),
(321, 2, 'Home', '2020-08-08 06:36:53', '2020-08-08 06:36:53'),
(322, 2, 'Quotaj', '2020-08-08 06:36:58', '2020-08-08 06:36:58'),
(323, 2, 'Login success', '2020-08-08 06:53:25', '2020-08-08 06:53:25'),
(324, 2, 'Quotaj', '2020-08-08 06:53:29', '2020-08-08 06:53:29'),
(325, 2, 'Condomin', '2020-08-08 07:00:36', '2020-08-08 07:00:36'),
(326, 2, 'Home', '2020-08-08 07:00:44', '2020-08-08 07:00:44'),
(327, 2, 'Quota', '2020-08-08 07:00:47', '2020-08-08 07:00:47'),
(328, 2, 'Home', '2020-08-08 07:00:57', '2020-08-08 07:00:57'),
(329, 2, 'Quotaj', '2020-08-08 07:01:01', '2020-08-08 07:01:01'),
(330, 2, 'Expense', '2020-08-08 07:02:34', '2020-08-08 07:02:34'),
(331, 2, 'Home', '2020-08-08 07:02:49', '2020-08-08 07:02:49'),
(332, 2, 'Quotaj', '2020-08-08 07:03:25', '2020-08-08 07:03:25'),
(333, 2, 'Error404', '2020-08-08 07:22:11', '2020-08-08 07:22:11'),
(334, 2, 'Login success', '2020-08-08 07:23:00', '2020-08-08 07:23:00'),
(335, 2, 'Expensej', '2020-08-08 07:23:04', '2020-08-08 07:23:04'),
(336, 2, 'Quotaj', '2020-08-08 07:40:12', '2020-08-08 07:40:12'),
(337, 2, 'Expensej', '2020-08-08 07:40:39', '2020-08-08 07:40:39'),
(338, 2, 'Login success', '2020-08-08 08:38:29', '2020-08-08 08:38:29'),
(339, 2, 'CondTyp', '2020-08-08 08:38:34', '2020-08-08 08:38:34'),
(340, 2, 'Home', '2020-08-08 08:38:37', '2020-08-08 08:38:37'),
(341, 2, 'Monthf', '2020-08-08 08:38:41', '2020-08-08 08:38:41'),
(342, 2, 'Home', '2020-08-08 08:40:45', '2020-08-08 08:40:45'),
(343, 2, 'Monthf', '2020-08-08 08:40:53', '2020-08-08 08:40:53'),
(344, 2, 'Home', '2020-08-08 08:40:55', '2020-08-08 08:40:55'),
(345, 2, 'Expense', '2020-08-08 08:40:57', '2020-08-08 08:40:57'),
(346, 2, 'Home', '2020-08-08 08:41:23', '2020-08-08 08:41:23'),
(347, 2, 'BudgeClo', '2020-08-08 08:41:26', '2020-08-08 08:41:26'),
(348, 2, 'Home', '2020-08-08 08:41:30', '2020-08-08 08:41:30'),
(349, 2, 'Quotaj', '2020-08-08 08:41:34', '2020-08-08 08:41:34'),
(350, 2, 'Expensej', '2020-08-08 08:41:39', '2020-08-08 08:41:39'),
(351, 2, 'Quotaj', '2020-08-08 08:42:54', '2020-08-08 08:42:54'),
(352, 2, 'Home', '2020-08-08 08:49:12', '2020-08-08 08:49:12'),
(353, 2, 'Quotaj', '2020-08-08 08:49:16', '2020-08-08 08:49:16'),
(354, 2, 'Expensej', '2020-08-08 08:53:45', '2020-08-08 08:53:45'),
(355, 2, 'Home', '2020-08-08 08:57:06', '2020-08-08 08:57:06'),
(356, 2, 'Quotaj', '2020-08-08 08:57:09', '2020-08-08 08:57:09'),
(357, 2, 'Expensej', '2020-08-08 08:57:14', '2020-08-08 08:57:14'),
(358, 2, 'Login success', '2020-08-08 19:50:02', '2020-08-08 19:50:02'),
(359, 2, 'Quotaj', '2020-08-08 20:09:56', '2020-08-08 20:09:56'),
(360, 2, 'Expensej', '2020-08-08 20:10:12', '2020-08-08 20:10:12'),
(361, 2, 'Login success', '2020-08-08 21:05:19', '2020-08-08 21:05:19'),
(362, 2, 'Monthf', '2020-08-08 21:05:28', '2020-08-08 21:05:28'),
(363, 2, 'Home', '2020-08-08 21:05:37', '2020-08-08 21:05:37'),
(364, 2, 'CondTyp', '2020-08-08 21:05:43', '2020-08-08 21:05:43'),
(365, 2, 'Home', '2020-08-08 21:17:25', '2020-08-08 21:17:25'),
(366, 2, 'CondTyp', '2020-08-08 21:17:31', '2020-08-08 21:17:31'),
(367, 2, 'Home', '2020-08-08 21:18:26', '2020-08-08 21:18:26'),
(368, 2, 'CondTyp', '2020-08-08 21:19:37', '2020-08-08 21:19:37'),
(369, 2, 'Home', '2020-08-08 21:19:43', '2020-08-08 21:19:43'),
(370, 2, 'CondTyp', '2020-08-08 21:20:25', '2020-08-08 21:20:25'),
(371, 2, 'Provider', '2020-08-08 21:29:16', '2020-08-08 21:29:16'),
(372, 2, 'Quota', '2020-08-08 21:31:17', '2020-08-08 21:31:17'),
(373, 2, 'CondTyp', '2020-08-08 21:33:09', '2020-08-08 21:33:09'),
(374, 2, 'Quota', '2020-08-08 21:33:11', '2020-08-08 21:33:11'),
(375, 2, 'Provider', '2020-08-08 21:33:13', '2020-08-08 21:33:13'),
(376, 2, 'Budgets', '2020-08-08 21:33:19', '2020-08-08 21:33:19'),
(377, 2, 'Condomin', '2020-08-08 21:34:37', '2020-08-08 21:34:37'),
(378, 2, 'Monthf', '2020-08-08 21:35:55', '2020-08-08 21:35:55'),
(379, 2, 'Expense', '2020-08-08 21:36:45', '2020-08-08 21:36:45'),
(380, 2, 'BudgeClo', '2020-08-08 21:38:51', '2020-08-08 21:38:51'),
(381, 2, 'Quotaj', '2020-08-08 21:40:00', '2020-08-08 21:40:00'),
(382, 2, 'Expensej', '2020-08-08 21:40:04', '2020-08-08 21:40:04'),
(383, 2, 'Login success', '2020-08-08 22:15:03', '2020-08-08 22:15:03'),
(384, 2, 'Deposit', '2020-08-08 22:15:09', '2020-08-08 22:15:09'),
(385, 2, 'CondTyp', '2020-08-08 22:53:21', '2020-08-08 22:53:21'),
(386, 2, 'Quota', '2020-08-08 22:56:42', '2020-08-08 22:56:42'),
(387, 2, 'Provider', '2020-08-08 22:58:46', '2020-08-08 22:58:46'),
(388, 2, 'Quota', '2020-08-08 23:00:36', '2020-08-08 23:00:36'),
(389, 2, 'CondTyp', '2020-08-08 23:00:40', '2020-08-08 23:00:40'),
(390, 2, 'Budgets', '2020-08-08 23:00:45', '2020-08-08 23:00:45'),
(391, 2, 'Condomin', '2020-08-08 23:02:27', '2020-08-08 23:02:27'),
(392, 2, 'Monthf', '2020-08-08 23:04:07', '2020-08-08 23:04:07'),
(393, 2, 'Expense', '2020-08-08 23:07:10', '2020-08-08 23:07:10'),
(394, 2, 'BudgeClo', '2020-08-08 23:08:52', '2020-08-08 23:08:52'),
(395, 2, 'Deposit', '2020-08-08 23:10:30', '2020-08-08 23:10:30'),
(396, 2, 'Quotaj', '2020-08-08 23:10:37', '2020-08-08 23:10:37'),
(397, 2, 'Expensej', '2020-08-08 23:12:40', '2020-08-08 23:12:40'),
(398, 2, 'Login success', '2020-08-08 23:16:25', '2020-08-08 23:16:25'),
(399, 2, 'Quotaj', '2020-08-08 23:16:33', '2020-08-08 23:16:33'),
(400, 2, 'Deposit', '2020-08-09 00:10:57', '2020-08-09 00:10:57'),
(401, 2, 'Login success', '2020-08-09 00:30:02', '2020-08-09 00:30:02'),
(402, 2, 'Expense', '2020-08-09 00:31:44', '2020-08-09 00:31:44'),
(403, 2, 'Home', '2020-08-09 00:32:20', '2020-08-09 00:32:20'),
(404, 2, 'CondTyp', '2020-08-09 00:32:30', '2020-08-09 00:32:30'),
(405, 2, 'Quota', '2020-08-09 00:32:41', '2020-08-09 00:32:41'),
(406, 2, 'Provider', '2020-08-09 00:32:50', '2020-08-09 00:32:50'),
(407, 2, 'Budgets', '2020-08-09 00:32:57', '2020-08-09 00:32:57'),
(408, 2, 'Condomin', '2020-08-09 00:33:04', '2020-08-09 00:33:04'),
(409, 2, 'CondTyp', '2020-08-09 00:37:33', '2020-08-09 00:37:33'),
(410, 2, 'Quota', '2020-08-09 00:37:51', '2020-08-09 00:37:51'),
(411, 2, 'Provider', '2020-08-09 00:38:00', '2020-08-09 00:38:00'),
(412, 2, 'Condomin', '2020-08-09 00:38:24', '2020-08-09 00:38:24'),
(413, 2, 'Monthf', '2020-08-09 00:38:33', '2020-08-09 00:38:33'),
(414, 2, 'Expense', '2020-08-09 00:38:43', '2020-08-09 00:38:43'),
(415, 2, 'BudgeClo', '2020-08-09 00:42:23', '2020-08-09 00:42:23'),
(416, 2, 'Deposit', '2020-08-09 00:42:30', '2020-08-09 00:42:30'),
(417, 2, 'Expense', '2020-08-09 00:43:35', '2020-08-09 00:43:35'),
(418, 2, 'Deposit', '2020-08-09 00:46:38', '2020-08-09 00:46:38'),
(419, 2, 'Login success', '2020-08-09 02:22:23', '2020-08-09 02:22:23'),
(420, 2, 'Deposit', '2020-08-09 02:22:39', '2020-08-09 02:22:39'),
(421, 2, 'Quotaj', '2020-08-09 02:23:05', '2020-08-09 02:23:05'),
(422, 2, 'Expensej', '2020-08-09 02:27:26', '2020-08-09 02:27:26'),
(423, 2, 'Deposit', '2020-08-09 02:34:17', '2020-08-09 02:34:17'),
(424, 2, 'Monthf', '2020-08-09 03:05:15', '2020-08-09 03:05:15'),
(425, 2, 'BudgeClo', '2020-08-09 03:05:19', '2020-08-09 03:05:19'),
(426, 2, 'Expense', '2020-08-09 03:05:25', '2020-08-09 03:05:25'),
(427, 2, 'Deposit', '2020-08-09 03:05:35', '2020-08-09 03:05:35'),
(428, 2, 'Login success', '2020-08-09 17:34:59', '2020-08-09 17:34:59'),
(429, 2, 'Deposit', '2020-08-09 17:35:10', '2020-08-09 17:35:10'),
(430, 2, 'CondTyp', '2020-08-09 18:01:18', '2020-08-09 18:01:18'),
(431, 2, 'Home', '2020-08-09 18:01:19', '2020-08-09 18:01:19'),
(432, 2, 'Deposit', '2020-08-09 18:05:16', '2020-08-09 18:05:16'),
(433, 2, 'Quotaj', '2020-08-09 18:28:38', '2020-08-09 18:28:38'),
(434, 2, 'Deposit', '2020-08-09 18:28:56', '2020-08-09 18:28:56'),
(435, 2, 'Login success', '2020-08-09 18:41:31', '2020-08-09 18:41:31'),
(436, 2, 'Deposit', '2020-08-09 18:41:37', '2020-08-09 18:41:37'),
(437, 2, 'Quotaj', '2020-08-09 18:42:41', '2020-08-09 18:42:41'),
(438, 2, 'Deposit', '2020-08-09 18:43:37', '2020-08-09 18:43:37'),
(439, 2, 'Quotaj', '2020-08-09 18:44:00', '2020-08-09 18:44:00'),
(440, 2, 'Deposit', '2020-08-09 18:44:18', '2020-08-09 18:44:18'),
(441, 2, 'CondTyp', '2020-08-09 19:29:13', '2020-08-09 19:29:13'),
(442, 2, 'Condomin', '2020-08-09 19:29:17', '2020-08-09 19:29:17'),
(443, 2, 'Quota', '2020-08-09 19:32:16', '2020-08-09 19:32:16'),
(444, 2, 'Provider', '2020-08-09 19:32:22', '2020-08-09 19:32:22'),
(445, 2, 'Budgets', '2020-08-09 19:32:26', '2020-08-09 19:32:26'),
(446, 2, 'Condomin', '2020-08-09 19:32:32', '2020-08-09 19:32:32'),
(447, 2, 'Monthf', '2020-08-09 19:32:55', '2020-08-09 19:32:55'),
(448, 2, 'Expense', '2020-08-09 19:32:59', '2020-08-09 19:32:59'),
(449, 2, 'BudgeClo', '2020-08-09 19:37:45', '2020-08-09 19:37:45'),
(450, 2, 'Deposit', '2020-08-09 19:37:49', '2020-08-09 19:37:49'),
(451, 2, 'Login success', '2020-08-09 19:46:32', '2020-08-09 19:46:32'),
(452, 2, 'Deposit', '2020-08-09 19:46:48', '2020-08-09 19:46:48'),
(453, 2, 'Monthf', '2020-08-09 19:47:25', '2020-08-09 19:47:25'),
(454, 2, 'Expense', '2020-08-09 19:47:31', '2020-08-09 19:47:31'),
(455, 2, 'Deposit', '2020-08-09 19:48:48', '2020-08-09 19:48:48'),
(456, 2, 'Home', '2020-08-09 20:13:15', '2020-08-09 20:13:15'),
(457, 2, 'Deposit', '2020-08-09 20:16:07', '2020-08-09 20:16:07'),
(458, 2, 'Condomin', '2020-08-09 20:16:33', '2020-08-09 20:16:33'),
(459, 2, 'Deposit', '2020-08-09 20:17:05', '2020-08-09 20:17:05'),
(460, 2, 'Home', '2020-08-09 20:18:07', '2020-08-09 20:18:07'),
(461, 2, 'CondTyp', '2020-08-09 20:20:05', '2020-08-09 20:20:05'),
(462, 2, 'Home', '2020-08-09 20:38:01', '2020-08-09 20:38:01'),
(463, 2, 'Login success', '2020-08-09 20:47:28', '2020-08-09 20:47:28'),
(464, 2, 'CondTyp', '2020-08-09 20:47:35', '2020-08-09 20:47:35'),
(465, 2, 'Quota', '2020-08-09 20:48:50', '2020-08-09 20:48:50'),
(466, 2, 'Condomin', '2020-08-09 20:49:04', '2020-08-09 20:49:04'),
(467, 2, 'Home', '2020-08-09 20:51:27', '2020-08-09 20:51:27'),
(468, 2, 'CondTyp', '2020-08-09 20:55:20', '2020-08-09 20:55:20'),
(469, 2, 'Home', '2020-08-09 21:05:40', '2020-08-09 21:05:40'),
(470, 2, 'CondTyp', '2020-08-09 21:06:37', '2020-08-09 21:06:37'),
(471, 2, 'Quota', '2020-08-09 21:06:42', '2020-08-09 21:06:42'),
(472, 2, 'Provider', '2020-08-09 21:07:08', '2020-08-09 21:07:08'),
(473, 2, 'Budgets', '2020-08-09 21:07:41', '2020-08-09 21:07:41'),
(474, 2, 'Condomin', '2020-08-09 21:08:30', '2020-08-09 21:08:30'),
(475, 2, 'Monthf', '2020-08-09 21:08:56', '2020-08-09 21:08:56'),
(476, 2, 'Expense', '2020-08-09 21:09:46', '2020-08-09 21:09:46'),
(477, 2, 'BudgeClo', '2020-08-09 21:10:17', '2020-08-09 21:10:17'),
(478, 2, 'Deposit', '2020-08-09 21:10:23', '2020-08-09 21:10:23'),
(479, 2, 'Quotaj', '2020-08-09 21:10:45', '2020-08-09 21:10:45'),
(480, 2, 'Expensej', '2020-08-09 21:10:49', '2020-08-09 21:10:49'),
(481, 2, 'Home', '2020-08-09 21:24:38', '2020-08-09 21:24:38'),
(482, 2, 'CondTyp', '2020-08-09 21:24:47', '2020-08-09 21:24:47'),
(483, 2, 'Quota', '2020-08-09 21:24:52', '2020-08-09 21:24:52'),
(484, 2, 'Provider', '2020-08-09 21:24:59', '2020-08-09 21:24:59'),
(485, 2, 'Quota', '2020-08-09 21:25:03', '2020-08-09 21:25:03'),
(486, 2, 'Budgets', '2020-08-09 21:25:07', '2020-08-09 21:25:07'),
(487, 2, 'Condomin', '2020-08-09 21:27:12', '2020-08-09 21:27:12'),
(488, 2, 'CondTyp', '2020-08-09 21:27:48', '2020-08-09 21:27:48'),
(489, 2, 'Quota', '2020-08-09 21:28:14', '2020-08-09 21:28:14'),
(490, 2, 'Provider', '2020-08-09 21:28:37', '2020-08-09 21:28:37'),
(491, 2, 'Condomin', '2020-08-09 21:29:33', '2020-08-09 21:29:33'),
(492, 2, 'Monthf', '2020-08-09 21:29:39', '2020-08-09 21:29:39'),
(493, 2, 'Expense', '2020-08-09 21:30:17', '2020-08-09 21:30:17'),
(494, 2, 'BudgeClo', '2020-08-09 21:30:34', '2020-08-09 21:30:34'),
(495, 2, 'Deposit', '2020-08-09 21:31:07', '2020-08-09 21:31:07'),
(496, 2, 'Quotaj', '2020-08-09 21:31:44', '2020-08-09 21:31:44'),
(497, 2, 'Expensej', '2020-08-09 21:32:48', '2020-08-09 21:32:48'),
(498, 2, 'Quotaj', '2020-08-09 21:43:38', '2020-08-09 21:43:38'),
(499, 2, 'Expensej', '2020-08-09 21:43:42', '2020-08-09 21:43:42'),
(500, 2, 'Usuario', '2020-08-09 21:44:13', '2020-08-09 21:44:13'),
(501, 2, 'Menu', '2020-08-09 21:45:29', '2020-08-09 21:45:29'),
(502, 2, 'Profile', '2020-08-09 21:45:37', '2020-08-09 21:45:37'),
(503, 5, 'Login success', '2020-08-09 21:46:33', '2020-08-09 21:46:33'),
(504, 5, 'Quota', '2020-08-09 21:46:45', '2020-08-09 21:46:45'),
(505, 5, 'Home', '2020-08-09 21:46:53', '2020-08-09 21:46:53'),
(506, 2, 'Login success', '2020-08-09 21:47:05', '2020-08-09 21:47:05'),
(507, 2, 'Quotaj', '2020-08-09 21:47:25', '2020-08-09 21:47:25'),
(508, 2, 'Expensej', '2020-08-09 21:47:30', '2020-08-09 21:47:30'),
(509, 2, 'CondTyp', '2020-08-09 21:47:46', '2020-08-09 21:47:46'),
(510, 2, 'Home', '2020-08-09 21:50:31', '2020-08-09 21:50:31'),
(511, 2, 'Quotaj', '2020-08-09 21:50:40', '2020-08-09 21:50:40'),
(512, 2, 'CondTyp', '2020-08-09 21:50:49', '2020-08-09 21:50:49'),
(513, 2, 'Condomin', '2020-08-09 21:58:09', '2020-08-09 21:58:09'),
(514, 2, 'Home', '2020-08-09 22:29:05', '2020-08-09 22:29:05'),
(515, 2, 'CondTyp', '2020-08-09 22:30:25', '2020-08-09 22:30:25'),
(516, 2, 'Login success', '2020-08-09 22:49:11', '2020-08-09 22:49:11'),
(517, 2, 'CondTyp', '2020-08-09 22:49:15', '2020-08-09 22:49:15'),
(518, 2, 'Condomin', '2020-08-09 22:54:52', '2020-08-09 22:54:52'),
(519, 2, 'Login success', '2020-08-09 23:05:08', '2020-08-09 23:05:08'),
(520, 2, 'CondTyp', '2020-08-09 23:05:13', '2020-08-09 23:05:13'),
(521, 2, 'Monthf', '2020-08-09 23:30:25', '2020-08-09 23:30:25'),
(522, 2, 'Login success', '2020-08-10 23:07:18', '2020-08-10 23:07:18'),
(523, 2, 'Monthf', '2020-08-10 23:09:13', '2020-08-10 23:09:13'),
(524, 2, 'Home', '2020-08-10 23:37:36', '2020-08-10 23:37:36'),
(525, 2, 'Login success', '2020-08-11 05:15:32', '2020-08-11 05:15:32'),
(526, 2, 'Monthf', '2020-08-11 05:15:38', '2020-08-11 05:15:38'),
(527, 2, 'Usuario', '2020-08-11 06:12:06', '2020-08-11 06:12:06'),
(528, 2, 'Monthf', '2020-08-11 06:12:16', '2020-08-11 06:12:16'),
(529, 2, 'Login success', '2020-08-11 06:18:24', '2020-08-11 06:18:24'),
(530, 2, 'Monthf', '2020-08-11 06:18:32', '2020-08-11 06:18:32'),
(531, 2, 'Login success', '2020-08-11 17:10:22', '2020-08-11 17:10:22'),
(532, 2, 'Menu', '2020-08-11 17:26:48', '2020-08-11 17:26:48'),
(533, 2, 'Home', '2020-08-11 17:33:29', '2020-08-11 17:33:29'),
(534, 2, 'Profile', '2020-08-11 17:33:45', '2020-08-11 17:33:45'),
(535, 2, 'Home', '2020-08-11 17:34:02', '2020-08-11 17:34:02'),
(536, 2, 'Tenant', '2020-08-11 17:34:18', '2020-08-11 17:34:18'),
(537, 2, 'Login success', '2020-08-11 17:38:14', '2020-08-11 17:38:14'),
(538, 2, 'Tenant', '2020-08-11 17:38:20', '2020-08-11 17:38:20'),
(539, 2, 'Fund', '2020-08-11 17:50:26', '2020-08-11 17:50:26'),
(540, 2, 'Usuario', '2020-08-11 17:50:42', '2020-08-11 17:50:42'),
(541, 2, 'Profile', '2020-08-11 17:50:50', '2020-08-11 17:50:50'),
(542, 2, 'Home', '2020-08-11 17:53:00', '2020-08-11 17:53:00'),
(543, 2, 'Profile', '2020-08-11 18:17:04', '2020-08-11 18:17:04'),
(544, 2, 'Home', '2020-08-11 18:17:20', '2020-08-11 18:17:20'),
(545, 0, 'Login failed erenstoag', '2020-08-11 18:17:53', '2020-08-11 18:17:53'),
(546, 0, 'Login failed erenstoag', '2020-08-11 18:18:01', '2020-08-11 18:18:01'),
(547, 0, 'Login failed erenstoag', '2020-08-11 18:18:04', '2020-08-11 18:18:04'),
(548, 2, 'Login success', '2020-08-11 18:18:15', '2020-08-11 18:18:15'),
(549, 2, 'Usuario', '2020-08-11 18:18:21', '2020-08-11 18:18:21'),
(550, 5, 'Login success', '2020-08-11 18:19:13', '2020-08-11 18:19:13'),
(551, 5, 'CondTyp', '2020-08-11 18:52:07', '2020-08-11 18:52:07'),
(552, 5, 'Quota', '2020-08-11 18:52:20', '2020-08-11 18:52:20'),
(553, 5, 'Provider', '2020-08-11 18:52:29', '2020-08-11 18:52:29'),
(554, 5, 'Budgets', '2020-08-11 18:52:41', '2020-08-11 18:52:41'),
(555, 5, 'Condomin', '2020-08-11 18:52:54', '2020-08-11 18:52:54'),
(556, 5, 'Tenant', '2020-08-11 18:53:21', '2020-08-11 18:53:21'),
(557, 5, 'Bankacct', '2020-08-11 18:53:25', '2020-08-11 18:53:25'),
(558, 5, 'Expense', '2020-08-11 18:53:33', '2020-08-11 18:53:33'),
(559, 5, 'Monthf', '2020-08-11 18:53:36', '2020-08-11 18:53:36'),
(560, 5, 'BudgeClo', '2020-08-11 18:53:55', '2020-08-11 18:53:55'),
(561, 5, 'Deposit', '2020-08-11 18:53:59', '2020-08-11 18:53:59'),
(562, 5, 'Event', '2020-08-11 18:54:04', '2020-08-11 18:54:04'),
(563, 5, 'Aplicat', '2020-08-11 18:54:10', '2020-08-11 18:54:10'),
(564, 5, 'Repair', '2020-08-11 18:54:15', '2020-08-11 18:54:15'),
(565, 5, 'Quotaj', '2020-08-11 18:54:21', '2020-08-11 18:54:21'),
(566, 5, 'Expensej', '2020-08-11 18:54:31', '2020-08-11 18:54:31'),
(567, 5, 'Fund', '2020-08-11 18:54:36', '2020-08-11 18:54:36'),
(568, 5, 'Expensej', '2020-08-11 18:54:40', '2020-08-11 18:54:40'),
(569, 5, 'Bankacct', '2020-08-11 18:55:49', '2020-08-11 18:55:49'),
(570, 5, 'Tenant', '2020-08-11 18:56:02', '2020-08-11 18:56:02'),
(571, 5, 'Login success', '2020-08-11 21:28:15', '2020-08-11 21:28:15'),
(572, 5, 'Monthf', '2020-08-11 21:28:24', '2020-08-11 21:28:24'),
(573, 5, 'Deposit', '2020-08-11 21:28:44', '2020-08-11 21:28:44'),
(574, 5, 'Event', '2020-08-11 21:28:47', '2020-08-11 21:28:47'),
(575, 5, 'Aplicat', '2020-08-11 21:28:52', '2020-08-11 21:28:52'),
(576, 5, 'Repair', '2020-08-11 21:28:54', '2020-08-11 21:28:54'),
(577, 5, 'Quotaj', '2020-08-11 21:29:04', '2020-08-11 21:29:04'),
(578, 5, 'Expensej', '2020-08-11 21:29:07', '2020-08-11 21:29:07'),
(579, 5, 'Fund', '2020-08-11 21:29:11', '2020-08-11 21:29:11'),
(580, 5, 'CondTyp', '2020-08-11 21:29:29', '2020-08-11 21:29:29'),
(581, 5, 'Quota', '2020-08-11 21:31:09', '2020-08-11 21:31:09'),
(582, 5, 'Provider', '2020-08-11 21:31:38', '2020-08-11 21:31:38'),
(583, 5, 'Budgets', '2020-08-11 21:31:47', '2020-08-11 21:31:47'),
(584, 5, 'Condomin', '2020-08-11 21:52:50', '2020-08-11 21:52:50'),
(585, 5, 'Tenant', '2020-08-11 21:53:40', '2020-08-11 21:53:40'),
(586, 2, 'Login success', '2020-08-12 17:30:41', '2020-08-12 17:30:41'),
(587, 2, 'Login success', '2020-08-12 17:30:42', '2020-08-12 17:30:42'),
(588, 2, 'Login success', '2020-08-13 04:16:01', '2020-08-13 04:16:01'),
(589, 2, 'Tenant', '2020-08-13 04:16:16', '2020-08-13 04:16:16'),
(590, 2, 'Login success', '2020-08-14 00:14:58', '2020-08-14 00:14:58'),
(591, 2, 'Login success', '2020-08-14 02:16:06', '2020-08-14 02:16:06'),
(592, 2, 'CondTyp', '2020-08-14 02:21:18', '2020-08-14 02:21:18'),
(593, 2, 'Quota', '2020-08-14 02:21:22', '2020-08-14 02:21:22'),
(594, 2, 'Provider', '2020-08-14 02:21:39', '2020-08-14 02:21:39'),
(595, 2, 'Budgets', '2020-08-14 02:23:46', '2020-08-14 02:23:46'),
(596, 2, 'Condomin', '2020-08-14 02:23:53', '2020-08-14 02:23:53'),
(597, 2, 'Tenant', '2020-08-14 02:24:08', '2020-08-14 02:24:08'),
(598, 2, 'CondTyp', '2020-08-14 03:02:10', '2020-08-14 03:02:10'),
(599, 2, 'Quota', '2020-08-14 03:02:15', '2020-08-14 03:02:15'),
(600, 2, 'Provider', '2020-08-14 03:02:21', '2020-08-14 03:02:21'),
(601, 2, 'Tenant', '2020-08-14 03:04:42', '2020-08-14 03:04:42'),
(602, 2, 'Provider', '2020-08-14 03:04:52', '2020-08-14 03:04:52'),
(603, 2, 'Condomin', '2020-08-14 03:05:45', '2020-08-14 03:05:45'),
(604, 2, 'Bankacct', '2020-08-14 03:05:52', '2020-08-14 03:05:52'),
(605, 2, 'Tenant', '2020-08-14 03:05:55', '2020-08-14 03:05:55'),
(606, 2, 'Login success', '2020-08-14 03:17:33', '2020-08-14 03:17:33'),
(607, 2, 'Condomin', '2020-08-14 03:17:51', '2020-08-14 03:17:51'),
(608, 2, 'Tenant', '2020-08-14 03:17:57', '2020-08-14 03:17:57'),
(609, 2, 'Condomin', '2020-08-14 03:23:42', '2020-08-14 03:23:42'),
(610, 2, 'Tenant', '2020-08-14 03:24:39', '2020-08-14 03:24:39'),
(611, 2, 'Login success', '2020-08-14 04:20:52', '2020-08-14 04:20:52'),
(612, 2, 'Tenant', '2020-08-14 04:20:56', '2020-08-14 04:20:56'),
(613, 2, 'Bankacct', '2020-08-14 04:29:17', '2020-08-14 04:29:17'),
(614, 2, 'Usuario', '2020-08-14 04:36:44', '2020-08-14 04:36:44'),
(615, 2, 'Profile', '2020-08-14 04:36:47', '2020-08-14 04:36:47'),
(616, 2, 'Bankacct', '2020-08-14 04:37:06', '2020-08-14 04:37:06'),
(617, 2, 'Profile', '2020-08-14 04:49:55', '2020-08-14 04:49:55'),
(618, 2, 'Owner', '2020-08-14 04:50:33', '2020-08-14 04:50:33'),
(619, 2, 'Login success', '2020-08-14 05:31:43', '2020-08-14 05:31:43'),
(620, 2, 'Owner', '2020-08-14 05:31:50', '2020-08-14 05:31:50'),
(621, 2, 'Home', '2020-08-14 05:32:40', '2020-08-14 05:32:40'),
(622, 2, 'Owner', '2020-08-14 05:33:34', '2020-08-14 05:33:34'),
(623, 2, 'Profile', '2020-08-14 05:56:49', '2020-08-14 05:56:49'),
(624, 2, 'Login success', '2020-08-15 00:37:59', '2020-08-15 00:37:59'),
(625, 2, 'Condomin', '2020-08-15 00:38:20', '2020-08-15 00:38:20'),
(626, 2, 'Owner', '2020-08-15 00:38:27', '2020-08-15 00:38:27'),
(627, 2, 'Tenant', '2020-08-15 00:40:31', '2020-08-15 00:40:31'),
(628, 2, 'Home', '2020-08-15 00:49:38', '2020-08-15 00:49:38'),
(629, 2, 'Owner', '2020-08-15 00:49:56', '2020-08-15 00:49:56'),
(630, 2, 'CondTyp', '2020-08-15 00:50:28', '2020-08-15 00:50:28'),
(631, 2, 'Quota', '2020-08-15 00:50:36', '2020-08-15 00:50:36'),
(632, 2, 'Provider', '2020-08-15 00:50:41', '2020-08-15 00:50:41'),
(633, 2, 'Budgets', '2020-08-15 00:50:50', '2020-08-15 00:50:50'),
(634, 2, 'Tenant', '2020-08-15 00:51:28', '2020-08-15 00:51:28'),
(635, 2, 'Bankacct', '2020-08-15 00:52:30', '2020-08-15 00:52:30'),
(636, 2, 'Login success', '2020-08-15 03:49:09', '2020-08-15 03:49:09'),
(637, 2, 'Bankacct', '2020-08-15 03:49:15', '2020-08-15 03:49:15'),
(638, 2, 'Login success', '2020-08-15 04:57:40', '2020-08-15 04:57:40'),
(639, 2, 'Bankacct', '2020-08-15 04:57:52', '2020-08-15 04:57:52'),
(640, 2, 'Owner', '2020-08-15 05:10:47', '2020-08-15 05:10:47'),
(641, 2, 'CondTyp', '2020-08-15 05:11:00', '2020-08-15 05:11:00'),
(642, 2, 'Quota', '2020-08-15 05:11:16', '2020-08-15 05:11:16'),
(643, 2, 'Provider', '2020-08-15 05:11:27', '2020-08-15 05:11:27'),
(644, 2, 'Budgets', '2020-08-15 05:11:37', '2020-08-15 05:11:37'),
(645, 2, 'Condomin', '2020-08-15 05:11:51', '2020-08-15 05:11:51'),
(646, 2, 'Tenant', '2020-08-15 05:11:54', '2020-08-15 05:11:54'),
(647, 2, 'Bankacct', '2020-08-15 05:12:11', '2020-08-15 05:12:11'),
(648, 2, 'Owner', '2020-08-15 05:12:37', '2020-08-15 05:12:37'),
(649, 2, 'CondTyp', '2020-08-15 05:46:53', '2020-08-15 05:46:53'),
(650, 2, 'Quota', '2020-08-15 05:49:33', '2020-08-15 05:49:33'),
(651, 2, 'Provider', '2020-08-15 05:50:42', '2020-08-15 05:50:42'),
(652, 2, 'Budgets', '2020-08-15 05:51:40', '2020-08-15 05:51:40'),
(653, 2, 'Condomin', '2020-08-15 05:52:58', '2020-08-15 05:52:58'),
(654, 2, 'Tenant', '2020-08-15 05:53:41', '2020-08-15 05:53:41'),
(655, 2, 'Bankacct', '2020-08-15 05:54:30', '2020-08-15 05:54:30'),
(656, 2, 'Login success', '2020-08-15 06:01:23', '2020-08-15 06:01:23'),
(657, 2, 'Monthf', '2020-08-15 06:01:29', '2020-08-15 06:01:29'),
(658, 2, 'Expense', '2020-08-15 06:01:42', '2020-08-15 06:01:42'),
(659, 2, 'BudgeClo', '2020-08-15 06:01:59', '2020-08-15 06:01:59'),
(660, 2, 'Deposit', '2020-08-15 06:02:09', '2020-08-15 06:02:09'),
(661, 2, 'Event', '2020-08-15 06:02:28', '2020-08-15 06:02:28'),
(662, 2, 'Aplicat', '2020-08-15 06:02:34', '2020-08-15 06:02:34'),
(663, 2, 'Repair', '2020-08-15 06:02:38', '2020-08-15 06:02:38'),
(664, 2, 'Quotaj', '2020-08-15 06:02:44', '2020-08-15 06:02:44'),
(665, 2, 'Expensej', '2020-08-15 06:02:48', '2020-08-15 06:02:48'),
(666, 2, 'Fund', '2020-08-15 06:03:01', '2020-08-15 06:03:01'),
(667, 2, 'Deposit', '2020-08-15 06:03:07', '2020-08-15 06:03:07'),
(668, 2, 'Monthf', '2020-08-15 06:41:42', '2020-08-15 06:41:42'),
(669, 2, 'Expense', '2020-08-15 06:41:45', '2020-08-15 06:41:45'),
(670, 2, 'Event', '2020-08-15 06:41:54', '2020-08-15 06:41:54'),
(671, 2, 'Aplicat', '2020-08-15 06:41:58', '2020-08-15 06:41:58'),
(672, 2, 'Repair', '2020-08-15 06:42:05', '2020-08-15 06:42:05'),
(673, 2, 'Condomin', '2020-08-15 06:42:12', '2020-08-15 06:42:12'),
(674, 0, 'Login failed carlos_asrnet@hotmail.com', '2020-08-15 07:01:57', '2020-08-15 07:01:57'),
(675, 2, 'Login success', '2020-08-15 07:02:03', '2020-08-15 07:02:03'),
(676, 2, 'Condomin', '2020-08-15 07:02:14', '2020-08-15 07:02:14'),
(677, 2, 'Deposit', '2020-08-15 07:27:13', '2020-08-15 07:27:13'),
(678, 2, 'Condomin', '2020-08-15 07:30:16', '2020-08-15 07:30:16'),
(679, 2, 'Login success', '2020-08-15 16:20:18', '2020-08-15 16:20:18'),
(680, 2, 'Condomin', '2020-08-15 16:20:24', '2020-08-15 16:20:24'),
(681, 2, 'Tenant', '2020-08-15 16:23:54', '2020-08-15 16:23:54'),
(682, 2, 'Condomin', '2020-08-15 16:24:26', '2020-08-15 16:24:26'),
(683, 2, 'Login success', '2020-08-15 17:22:22', '2020-08-15 17:22:22'),
(684, 2, 'Condomin', '2020-08-15 17:22:48', '2020-08-15 17:22:48'),
(685, 2, 'Owner', '2020-08-15 17:35:58', '2020-08-15 17:35:58'),
(686, 2, 'CondTyp', '2020-08-15 17:36:06', '2020-08-15 17:36:06'),
(687, 2, 'Quota', '2020-08-15 17:36:12', '2020-08-15 17:36:12'),
(688, 2, 'Provider', '2020-08-15 17:36:17', '2020-08-15 17:36:17'),
(689, 2, 'Budgets', '2020-08-15 17:36:27', '2020-08-15 17:36:27'),
(690, 2, 'Tenant', '2020-08-15 17:36:42', '2020-08-15 17:36:42'),
(691, 2, 'Bankacct', '2020-08-15 17:36:47', '2020-08-15 17:36:47'),
(692, 2, 'Condomin', '2020-08-15 17:36:54', '2020-08-15 17:36:54'),
(693, 2, 'Bankacct', '2020-08-15 17:37:57', '2020-08-15 17:37:57'),
(694, 2, 'Quotaj', '2020-08-15 17:38:10', '2020-08-15 17:38:10'),
(695, 2, 'Expensej', '2020-08-15 17:38:13', '2020-08-15 17:38:13'),
(696, 2, 'Fund', '2020-08-15 17:38:20', '2020-08-15 17:38:20'),
(697, 2, 'Repair', '2020-08-15 17:38:27', '2020-08-15 17:38:27'),
(698, 2, 'Aplicat', '2020-08-15 17:38:29', '2020-08-15 17:38:29'),
(699, 2, 'Event', '2020-08-15 17:38:34', '2020-08-15 17:38:34'),
(700, 2, 'Deposit', '2020-08-15 17:38:37', '2020-08-15 17:38:37'),
(701, 2, 'Monthf', '2020-08-15 17:40:59', '2020-08-15 17:40:59'),
(702, 2, 'Expense', '2020-08-15 17:45:06', '2020-08-15 17:45:06'),
(703, 2, 'BudgeClo', '2020-08-15 17:47:38', '2020-08-15 17:47:38'),
(704, 2, 'Deposit', '2020-08-15 17:47:44', '2020-08-15 17:47:44'),
(705, 2, 'Event', '2020-08-15 17:47:58', '2020-08-15 17:47:58'),
(706, 2, 'Aplicat', '2020-08-15 17:48:09', '2020-08-15 17:48:09'),
(707, 2, 'Repair', '2020-08-15 17:48:12', '2020-08-15 17:48:12'),
(708, 2, 'Monthf', '2020-08-15 18:17:33', '2020-08-15 18:17:33'),
(709, 2, 'Login success', '2020-08-15 19:23:57', '2020-08-15 19:23:57'),
(710, 2, 'Expense', '2020-08-15 19:24:11', '2020-08-15 19:24:11'),
(711, 2, 'Monthf', '2020-08-15 19:24:50', '2020-08-15 19:24:50'),
(712, 2, 'Login success', '2020-08-15 20:34:27', '2020-08-15 20:34:27'),
(713, 2, 'Monthf', '2020-08-15 20:34:32', '2020-08-15 20:34:32'),
(714, 2, 'Home', '2020-08-15 20:53:03', '2020-08-15 20:53:03'),
(715, 2, 'Monthf', '2020-08-15 20:57:53', '2020-08-15 20:57:53'),
(716, 2, 'Home', '2020-08-15 20:58:02', '2020-08-15 20:58:02'),
(717, 2, 'Monthf', '2020-08-15 20:58:14', '2020-08-15 20:58:14'),
(718, 2, 'Home', '2020-08-15 20:58:24', '2020-08-15 20:58:24'),
(719, 2, 'Expense', '2020-08-15 21:00:15', '2020-08-15 21:00:15'),
(720, 2, 'Deposit', '2020-08-15 21:00:32', '2020-08-15 21:00:32'),
(721, 2, 'Event', '2020-08-15 21:00:41', '2020-08-15 21:00:41'),
(722, 2, 'Aplicat', '2020-08-15 21:01:06', '2020-08-15 21:01:06'),
(723, 2, 'Repair', '2020-08-15 21:01:11', '2020-08-15 21:01:11'),
(724, 2, 'Event', '2020-08-15 21:01:15', '2020-08-15 21:01:15'),
(725, 2, 'Monthf', '2020-08-15 21:10:30', '2020-08-15 21:10:30'),
(726, 2, 'Home', '2020-08-15 21:10:31', '2020-08-15 21:10:31'),
(727, 2, 'Event', '2020-08-15 21:11:34', '2020-08-15 21:11:34'),
(728, 2, 'Login success', '2020-08-15 21:35:00', '2020-08-15 21:35:00'),
(729, 2, 'Event', '2020-08-15 21:35:06', '2020-08-15 21:35:06'),
(730, 2, 'Quota', '2020-08-15 21:58:01', '2020-08-15 21:58:01'),
(731, 2, 'Monthf', '2020-08-15 21:58:14', '2020-08-15 21:58:14'),
(732, 2, 'Event', '2020-08-15 22:01:28', '2020-08-15 22:01:28'),
(733, 2, 'Repair', '2020-08-15 22:23:52', '2020-08-15 22:23:52'),
(734, 2, 'Login success', '2020-08-15 22:44:02', '2020-08-15 22:44:02'),
(735, 2, 'Repair', '2020-08-15 22:44:11', '2020-08-15 22:44:11'),
(736, 2, 'Login success', '2020-08-16 00:16:19', '2020-08-16 00:16:19'),
(737, 2, 'Quotaj', '2020-08-16 00:16:26', '2020-08-16 00:16:26'),
(738, 2, 'Expensej', '2020-08-16 00:16:33', '2020-08-16 00:16:33'),
(739, 2, 'Fund', '2020-08-16 00:16:47', '2020-08-16 00:16:47'),
(740, 2, 'Aplicat', '2020-08-16 00:16:54', '2020-08-16 00:16:54'),
(741, 2, 'Fund', '2020-08-16 00:17:04', '2020-08-16 00:17:04'),
(742, 2, 'Expense', '2020-08-16 00:17:27', '2020-08-16 00:17:27'),
(743, 2, 'Budgets', '2020-08-16 00:18:54', '2020-08-16 00:18:54'),
(744, 2, 'Repair', '2020-08-16 00:20:57', '2020-08-16 00:20:57'),
(745, 2, 'Login success', '2020-08-16 01:22:18', '2020-08-16 01:22:18'),
(746, 2, 'Owner', '2020-08-16 01:22:22', '2020-08-16 01:22:22'),
(747, 2, 'CondTyp', '2020-08-16 01:22:29', '2020-08-16 01:22:29'),
(748, 2, 'Quota', '2020-08-16 01:22:44', '2020-08-16 01:22:44'),
(749, 2, 'Provider', '2020-08-16 01:22:59', '2020-08-16 01:22:59'),
(750, 2, 'Budgets', '2020-08-16 01:23:10', '2020-08-16 01:23:10'),
(751, 2, 'Condomin', '2020-08-16 01:23:20', '2020-08-16 01:23:20'),
(752, 2, 'Tenant', '2020-08-16 01:23:33', '2020-08-16 01:23:33'),
(753, 2, 'Bankacct', '2020-08-16 01:23:42', '2020-08-16 01:23:42'),
(754, 2, 'Monthf', '2020-08-16 01:24:00', '2020-08-16 01:24:00'),
(755, 2, 'Expense', '2020-08-16 01:24:18', '2020-08-16 01:24:18'),
(756, 2, 'BudgeClo', '2020-08-16 01:25:11', '2020-08-16 01:25:11'),
(757, 2, 'Deposit', '2020-08-16 01:25:21', '2020-08-16 01:25:21'),
(758, 2, 'Event', '2020-08-16 01:25:33', '2020-08-16 01:25:33'),
(759, 2, 'Aplicat', '2020-08-16 01:25:46', '2020-08-16 01:25:46'),
(760, 2, 'Repair', '2020-08-16 01:25:52', '2020-08-16 01:25:52'),
(761, 2, 'Login success', '2020-08-16 18:07:45', '2020-08-16 18:07:45'),
(762, 2, 'Profile', '2020-08-16 18:11:40', '2020-08-16 18:11:40'),
(763, 2, 'Home', '2020-08-16 18:13:40', '2020-08-16 18:13:40'),
(764, 2, 'Login success', '2020-08-16 18:13:50', '2020-08-16 18:13:50'),
(765, 2, 'Profile', '2020-08-16 18:14:33', '2020-08-16 18:14:33');
INSERT INTO `logs` (`id`, `user_id`, `event`, `created_at`, `updated_at`) VALUES
(766, 2, 'Residen', '2020-08-16 18:20:43', '2020-08-16 18:20:43'),
(767, 2, 'Login success', '2020-08-16 19:14:13', '2020-08-16 19:14:13'),
(768, 2, 'Residen', '2020-08-16 19:14:22', '2020-08-16 19:14:22'),
(769, 2, 'Home', '2020-08-16 19:19:44', '2020-08-16 19:19:44'),
(770, 2, 'Residen', '2020-08-16 19:19:48', '2020-08-16 19:19:48'),
(771, 2, 'Home', '2020-08-16 19:20:39', '2020-08-16 19:20:39'),
(772, 2, 'Residen', '2020-08-16 19:21:26', '2020-08-16 19:21:26'),
(773, 2, 'Home', '2020-08-16 19:21:31', '2020-08-16 19:21:31'),
(774, 2, 'Residen', '2020-08-16 19:21:34', '2020-08-16 19:21:34'),
(775, 2, 'Home', '2020-08-16 19:21:38', '2020-08-16 19:21:38'),
(776, 2, 'Residen', '2020-08-16 19:23:04', '2020-08-16 19:23:04'),
(777, 2, 'Home', '2020-08-16 19:24:02', '2020-08-16 19:24:02'),
(778, 2, 'Residen', '2020-08-16 19:24:05', '2020-08-16 19:24:05'),
(779, 2, 'Home', '2020-08-16 19:41:26', '2020-08-16 19:41:26'),
(780, 2, 'Residen', '2020-08-16 19:41:30', '2020-08-16 19:41:30'),
(781, 2, 'Profile', '2020-08-16 19:45:57', '2020-08-16 19:45:57'),
(782, 2, 'Faciliti', '2020-08-16 19:46:15', '2020-08-16 19:46:15'),
(783, 2, 'Residen', '2020-08-16 19:50:41', '2020-08-16 19:50:41'),
(784, 2, 'Home', '2020-08-16 19:50:43', '2020-08-16 19:50:43'),
(785, 2, 'Faciliti', '2020-08-16 19:57:21', '2020-08-16 19:57:21'),
(786, 2, 'Login success', '2020-08-16 20:17:52', '2020-08-16 20:17:52'),
(787, 2, 'Residen', '2020-08-16 20:17:57', '2020-08-16 20:17:57'),
(788, 2, 'Faciliti', '2020-08-16 20:17:59', '2020-08-16 20:17:59'),
(789, 2, 'Profile', '2020-08-16 20:36:45', '2020-08-16 20:36:45'),
(790, 2, 'Reservat', '2020-08-16 20:37:05', '2020-08-16 20:37:05'),
(791, 2, 'Profile', '2020-08-16 21:03:30', '2020-08-16 21:03:30'),
(792, 2, 'Error404', '2020-08-16 21:04:27', '2020-08-16 21:04:27'),
(793, 2, 'Confirm', '2020-08-16 21:06:20', '2020-08-16 21:06:20'),
(794, 2, 'Reservat', '2020-08-16 21:06:23', '2020-08-16 21:06:23'),
(795, 2, 'Confirm', '2020-08-16 21:07:14', '2020-08-16 21:07:14'),
(796, 2, 'Reservat', '2020-08-16 21:15:43', '2020-08-16 21:15:43'),
(797, 2, 'Login success', '2020-08-16 21:25:54', '2020-08-16 21:25:54'),
(798, 2, 'Profile', '2020-08-16 21:26:00', '2020-08-16 21:26:00'),
(799, 2, 'Condomin', '2020-08-16 21:26:39', '2020-08-16 21:26:39'),
(800, 2, 'CondTyp', '2020-08-16 21:31:50', '2020-08-16 21:31:50'),
(801, 2, 'Owner', '2020-08-16 21:33:05', '2020-08-16 21:33:05'),
(802, 2, 'Home', '2020-08-16 21:33:48', '2020-08-16 21:33:48'),
(803, 2, 'Tenant', '2020-08-16 21:33:54', '2020-08-16 21:33:54'),
(804, 2, 'Profile', '2020-08-16 21:38:34', '2020-08-16 21:38:34'),
(805, 2, 'Vehicle', '2020-08-16 21:39:09', '2020-08-16 21:39:09'),
(806, 2, 'Condomin', '2020-08-16 21:42:43', '2020-08-16 21:42:43'),
(807, 2, 'Vehicle', '2020-08-16 22:00:43', '2020-08-16 22:00:43'),
(808, 2, 'Condomin', '2020-08-16 22:05:54', '2020-08-16 22:05:54'),
(809, 2, 'Vehicle', '2020-08-16 22:15:46', '2020-08-16 22:15:46'),
(810, 2, 'Condomin', '2020-08-16 22:22:11', '2020-08-16 22:22:11'),
(811, 2, 'Home', '2020-08-16 22:22:11', '2020-08-16 22:22:11'),
(812, 2, 'Login success', '2020-08-16 22:29:01', '2020-08-16 22:29:01'),
(813, 2, 'Login success', '2020-08-16 23:29:52', '2020-08-16 23:29:52'),
(814, 2, 'Fund', '2020-08-16 23:29:57', '2020-08-16 23:29:57'),
(815, 2, 'Vehicle', '2020-08-16 23:30:02', '2020-08-16 23:30:02'),
(816, 2, 'Faciliti', '2020-08-16 23:38:16', '2020-08-16 23:38:16'),
(817, 2, 'Home', '2020-08-16 23:38:18', '2020-08-16 23:38:18'),
(818, 2, 'Vehicle', '2020-08-16 23:42:55', '2020-08-16 23:42:55'),
(819, 2, 'Profile', '2020-08-17 00:15:59', '2020-08-17 00:15:59'),
(820, 2, 'Sendmail', '2020-08-17 00:16:27', '2020-08-17 00:16:27'),
(821, 2, 'Menu', '2020-08-17 00:18:35', '2020-08-17 00:18:35'),
(822, 2, 'Profile', '2020-08-17 00:19:46', '2020-08-17 00:19:46'),
(823, 2, 'ProfUsr', '2020-08-17 00:22:22', '2020-08-17 00:22:22'),
(824, 2, 'Login success', '2020-08-17 01:09:44', '2020-08-17 01:09:44'),
(825, 2, 'Profile', '2020-08-17 01:09:54', '2020-08-17 01:09:54'),
(826, 2, 'Fund', '2020-08-17 01:10:10', '2020-08-17 01:10:10'),
(827, 2, 'Menu', '2020-08-17 01:36:41', '2020-08-17 01:36:41'),
(828, 2, 'Home', '2020-08-17 01:36:42', '2020-08-17 01:36:42'),
(829, 2, 'Fund', '2020-08-17 01:38:34', '2020-08-17 01:38:34'),
(830, 2, 'Login success', '2020-08-17 02:27:42', '2020-08-17 02:27:42'),
(831, 2, 'Fund', '2020-08-17 02:27:49', '2020-08-17 02:27:49'),
(832, 2, 'Vehicle', '2020-08-17 02:44:58', '2020-08-17 02:44:58'),
(833, 2, 'Home', '2020-08-17 02:46:52', '2020-08-17 02:46:52'),
(834, 2, 'Bankacct', '2020-08-17 02:47:01', '2020-08-17 02:47:01'),
(835, 2, 'Menu', '2020-08-17 02:52:55', '2020-08-17 02:52:55'),
(836, 2, 'Profile', '2020-08-17 02:54:49', '2020-08-17 02:54:49'),
(837, 2, 'Bankstat', '2020-08-17 02:55:24', '2020-08-17 02:55:24'),
(838, 2, 'Bankacct', '2020-08-17 02:55:35', '2020-08-17 02:55:35'),
(839, 2, 'Residen', '2020-08-17 03:24:48', '2020-08-17 03:24:48'),
(840, 2, 'Condomin', '2020-08-17 03:24:50', '2020-08-17 03:24:50'),
(841, 2, 'Bankacct', '2020-08-17 03:26:19', '2020-08-17 03:26:19'),
(842, 2, 'Login success', '2020-08-17 03:28:28', '2020-08-17 03:28:28'),
(843, 2, 'Bankacct', '2020-08-17 03:28:43', '2020-08-17 03:28:43'),
(844, 2, 'Condomin', '2020-08-17 03:44:33', '2020-08-17 03:44:33'),
(845, 2, 'Bankacct', '2020-08-17 03:46:17', '2020-08-17 03:46:17'),
(846, 2, 'Menu', '2020-08-17 04:11:06', '2020-08-17 04:11:06'),
(847, 2, 'Profile', '2020-08-17 04:15:18', '2020-08-17 04:15:18'),
(848, 2, 'budgIn', '2020-08-17 04:22:20', '2020-08-17 04:22:20'),
(849, 2, 'BudgEx', '2020-08-17 04:22:22', '2020-08-17 04:22:22'),
(850, 2, 'budgIn', '2020-08-17 04:28:21', '2020-08-17 04:28:21'),
(851, 2, 'Login success', '2020-08-17 04:29:08', '2020-08-17 04:29:08'),
(852, 2, 'budgIn', '2020-08-17 04:29:13', '2020-08-17 04:29:13'),
(853, 2, 'Faciliti', '2020-08-17 04:34:32', '2020-08-17 04:34:32'),
(854, 2, 'Home', '2020-08-17 04:34:33', '2020-08-17 04:34:33'),
(855, 2, 'budgIn', '2020-08-17 04:36:48', '2020-08-17 04:36:48'),
(856, 2, 'Home', '2020-08-17 05:03:54', '2020-08-17 05:03:54'),
(857, 2, 'BudgEx', '2020-08-17 05:03:59', '2020-08-17 05:03:59'),
(858, 2, 'budgIn', '2020-08-17 05:11:32', '2020-08-17 05:11:32'),
(859, 2, 'Monthf', '2020-08-17 05:17:05', '2020-08-17 05:17:05'),
(860, 2, 'Login success', '2020-08-17 05:34:19', '2020-08-17 05:34:19'),
(861, 2, 'Monthf', '2020-08-17 05:34:25', '2020-08-17 05:34:25'),
(862, 2, 'Home', '2020-08-17 06:18:27', '2020-08-17 06:18:27'),
(863, 2, 'Monthf', '2020-08-17 06:18:40', '2020-08-17 06:18:40'),
(864, 2, 'Home', '2020-08-17 06:18:54', '2020-08-17 06:18:54'),
(865, 2, 'Monthf', '2020-08-17 06:19:09', '2020-08-17 06:19:09'),
(866, 2, 'Home', '2020-08-17 06:20:09', '2020-08-17 06:20:09'),
(867, 2, 'Monthf', '2020-08-17 06:20:19', '2020-08-17 06:20:19'),
(868, 2, 'Home', '2020-08-17 06:20:30', '2020-08-17 06:20:30'),
(869, 2, 'Monthf', '2020-08-17 06:22:21', '2020-08-17 06:22:21'),
(870, 2, 'Home', '2020-08-17 06:22:43', '2020-08-17 06:22:43'),
(871, 2, 'Monthf', '2020-08-17 06:24:36', '2020-08-17 06:24:36'),
(872, 2, 'Home', '2020-08-17 06:24:58', '2020-08-17 06:24:58'),
(873, 2, 'Monthf', '2020-08-17 06:27:34', '2020-08-17 06:27:34'),
(874, 2, 'Home', '2020-08-17 06:27:51', '2020-08-17 06:27:51'),
(875, 2, 'Monthf', '2020-08-17 06:28:52', '2020-08-17 06:28:52'),
(876, 2, 'Home', '2020-08-17 06:29:11', '2020-08-17 06:29:11'),
(877, 2, 'Monthf', '2020-08-17 06:29:24', '2020-08-17 06:29:24'),
(878, 2, 'Home', '2020-08-17 06:29:38', '2020-08-17 06:29:38'),
(879, 2, 'Monthf', '2020-08-17 06:31:19', '2020-08-17 06:31:19'),
(880, 2, 'Login success', '2020-08-17 06:35:31', '2020-08-17 06:35:31'),
(881, 2, 'Monthf', '2020-08-17 06:35:40', '2020-08-17 06:35:40'),
(882, 2, 'Home', '2020-08-17 06:40:58', '2020-08-17 06:40:58'),
(883, 2, 'Monthf', '2020-08-17 06:41:01', '2020-08-17 06:41:01'),
(884, 2, 'Home', '2020-08-17 06:49:07', '2020-08-17 06:49:07'),
(885, 2, 'Monthf', '2020-08-17 06:55:23', '2020-08-17 06:55:23'),
(886, 2, 'Home', '2020-08-17 07:01:42', '2020-08-17 07:01:42'),
(887, 2, 'Monthf', '2020-08-17 07:04:49', '2020-08-17 07:04:49'),
(888, 2, 'Menu', '2020-08-17 07:28:01', '2020-08-17 07:28:01'),
(889, 2, 'Profile', '2020-08-17 07:28:38', '2020-08-17 07:28:38'),
(890, 2, 'Measucon', '2020-08-17 07:30:51', '2020-08-17 07:30:51'),
(891, 2, 'Monthf', '2020-08-17 07:32:49', '2020-08-17 07:32:49'),
(892, 2, 'Login success', '2020-08-17 07:35:46', '2020-08-17 07:35:46'),
(893, 2, 'Quota', '2020-08-17 07:35:51', '2020-08-17 07:35:51'),
(894, 2, 'Bankacct', '2020-08-17 08:29:44', '2020-08-17 08:29:44'),
(895, 2, 'Quota', '2020-08-17 08:29:55', '2020-08-17 08:29:55'),
(896, 2, 'Measucon', '2020-08-17 08:35:29', '2020-08-17 08:35:29'),
(897, 2, 'Monthf', '2020-08-17 08:35:33', '2020-08-17 08:35:33'),
(898, 2, 'Login success', '2020-08-17 08:50:42', '2020-08-17 08:50:42'),
(899, 2, 'Monthf', '2020-08-17 08:51:15', '2020-08-17 08:51:15'),
(900, 2, 'Quota', '2020-08-17 08:55:38', '2020-08-17 08:55:38'),
(901, 2, 'Measucon', '2020-08-17 09:01:48', '2020-08-17 09:01:48'),
(902, 2, 'Monthf', '2020-08-17 09:01:52', '2020-08-17 09:01:52'),
(903, 2, 'Login success', '2020-08-17 17:55:35', '2020-08-17 17:55:35'),
(904, 2, 'Monthf', '2020-08-17 17:55:45', '2020-08-17 17:55:45'),
(905, 2, 'Quota', '2020-08-17 17:56:41', '2020-08-17 17:56:41'),
(906, 2, 'Measucon', '2020-08-17 17:57:51', '2020-08-17 17:57:51'),
(907, 2, 'Monthf', '2020-08-17 17:57:55', '2020-08-17 17:57:55'),
(908, 2, 'Home', '2020-08-17 18:29:05', '2020-08-17 18:29:05'),
(909, 2, 'Monthf', '2020-08-17 18:30:01', '2020-08-17 18:30:01'),
(910, 2, 'Home', '2020-08-17 18:31:58', '2020-08-17 18:31:58'),
(911, 2, 'Monthf', '2020-08-17 18:32:23', '2020-08-17 18:32:23'),
(912, 2, 'Quota', '2020-08-17 18:48:40', '2020-08-17 18:48:40'),
(913, 2, 'Login success', '2020-08-17 18:58:55', '2020-08-17 18:58:55'),
(914, 2, 'Monthf', '2020-08-17 18:59:04', '2020-08-17 18:59:04'),
(915, 2, 'Measucon', '2020-08-17 19:09:28', '2020-08-17 19:09:28'),
(916, 2, 'Home', '2020-08-17 19:15:17', '2020-08-17 19:15:17'),
(917, 2, 'Testprnt', '2020-08-17 19:15:24', '2020-08-17 19:15:24'),
(918, 2, 'Home', '2020-08-17 19:15:30', '2020-08-17 19:15:30'),
(919, 2, 'Monthf', '2020-08-17 19:16:34', '2020-08-17 19:16:34'),
(920, 2, 'Home', '2020-08-17 19:16:38', '2020-08-17 19:16:38'),
(921, 2, 'Sendmail', '2020-08-17 19:16:48', '2020-08-17 19:16:48'),
(922, 2, 'Monthf', '2020-08-17 19:17:01', '2020-08-17 19:17:01'),
(923, 2, 'Home', '2020-08-17 19:17:35', '2020-08-17 19:17:35'),
(924, 2, 'Menu', '2020-08-17 19:51:29', '2020-08-17 19:51:29'),
(925, 2, 'Profile', '2020-08-17 19:53:28', '2020-08-17 19:53:28'),
(926, 2, 'Dirverse', '2020-08-17 19:53:50', '2020-08-17 19:53:50'),
(927, 2, 'Measucon', '2020-08-17 19:53:54', '2020-08-17 19:53:54'),
(928, 2, 'Dirverse', '2020-08-17 19:55:30', '2020-08-17 19:55:30'),
(929, 2, 'Measucon', '2020-08-17 19:55:34', '2020-08-17 19:55:34'),
(930, 2, 'Login success', '2020-08-17 19:59:31', '2020-08-17 19:59:31'),
(931, 2, 'Deposit', '2020-08-17 19:59:41', '2020-08-17 19:59:41'),
(932, 2, 'Home', '2020-08-17 20:01:37', '2020-08-17 20:01:37'),
(933, 2, 'Deposit', '2020-08-17 20:01:45', '2020-08-17 20:01:45'),
(934, 2, 'Condomin', '2020-08-17 20:02:29', '2020-08-17 20:02:29'),
(935, 2, 'Deposit', '2020-08-17 20:02:39', '2020-08-17 20:02:39'),
(936, 2, 'Profile', '2020-08-17 20:49:48', '2020-08-17 20:49:48'),
(937, 2, 'Bankstat', '2020-08-17 20:50:22', '2020-08-17 20:50:22'),
(938, 2, 'Dirverse', '2020-08-17 20:52:09', '2020-08-17 20:52:09'),
(939, 2, 'Measucon', '2020-08-17 20:52:15', '2020-08-17 20:52:15'),
(940, 2, 'Login success', '2020-08-17 21:14:50', '2020-08-17 21:14:50'),
(941, 2, 'Deposit', '2020-08-17 21:15:29', '2020-08-17 21:15:29'),
(942, 2, 'Bankstat', '2020-08-17 21:36:20', '2020-08-17 21:36:20'),
(943, 2, 'Menu', '2020-08-17 21:40:39', '2020-08-17 21:40:39'),
(944, 2, 'Profile', '2020-08-17 21:42:32', '2020-08-17 21:42:32'),
(945, 2, 'Statecom', '2020-08-17 21:44:38', '2020-08-17 21:44:38'),
(946, 2, 'Profile', '2020-08-17 21:45:20', '2020-08-17 21:45:20'),
(947, 2, 'Login success', '2020-08-17 22:21:42', '2020-08-17 22:21:42'),
(948, 2, 'Statecom', '2020-08-17 22:25:52', '2020-08-17 22:25:52'),
(949, 2, 'Home', '2020-08-17 22:55:49', '2020-08-17 22:55:49'),
(950, 2, 'Statecom', '2020-08-17 22:58:06', '2020-08-17 22:58:06'),
(951, 2, 'Bankstat', '2020-08-17 23:05:23', '2020-08-17 23:05:23'),
(952, 2, 'Statecom', '2020-08-17 23:05:25', '2020-08-17 23:05:25'),
(953, 2, 'Login success', '2020-08-17 23:22:55', '2020-08-17 23:22:55'),
(954, 2, 'Statecom', '2020-08-17 23:23:02', '2020-08-17 23:23:02'),
(955, 2, 'Login success', '2020-08-18 00:52:16', '2020-08-18 00:52:16'),
(956, 2, 'Statecom', '2020-08-18 00:52:27', '2020-08-18 00:52:27'),
(957, 2, 'Dirverse', '2020-08-18 01:31:56', '2020-08-18 01:31:56'),
(958, 2, 'Measucon', '2020-08-18 01:31:58', '2020-08-18 01:31:58'),
(959, 2, 'Deposit', '2020-08-18 01:32:03', '2020-08-18 01:32:03'),
(960, 2, 'Login success', '2020-08-18 01:52:31', '2020-08-18 01:52:31'),
(961, 2, 'Deposit', '2020-08-18 01:52:45', '2020-08-18 01:52:45'),
(962, 2, 'Bankstat', '2020-08-18 01:53:04', '2020-08-18 01:53:04'),
(963, 2, 'Statecom', '2020-08-18 01:53:07', '2020-08-18 01:53:07'),
(964, 2, 'Residen', '2020-08-18 01:57:52', '2020-08-18 01:57:52'),
(965, 2, 'Condomin', '2020-08-18 01:58:10', '2020-08-18 01:58:10'),
(966, 2, 'Deposit', '2020-08-18 01:58:47', '2020-08-18 01:58:47'),
(967, 2, 'Statecom', '2020-08-18 02:00:31', '2020-08-18 02:00:31'),
(968, 2, 'Login success', '2020-08-18 04:51:43', '2020-08-18 04:51:43'),
(969, 2, 'Statecom', '2020-08-18 04:51:52', '2020-08-18 04:51:52'),
(970, 2, 'Login success', '2020-08-18 05:53:26', '2020-08-18 05:53:26'),
(971, 2, 'Statecom', '2020-08-18 05:53:34', '2020-08-18 05:53:34'),
(972, 2, 'Login success', '2020-08-18 06:54:08', '2020-08-18 06:54:08'),
(973, 2, 'Statecom', '2020-08-18 06:54:19', '2020-08-18 06:54:19'),
(974, 2, 'Login success', '2020-08-18 22:52:29', '2020-08-18 22:52:29'),
(975, 2, 'Home', '2020-08-18 23:42:49', '2020-08-18 23:42:49'),
(976, 2, 'Login success', '2020-08-19 02:29:47', '2020-08-19 02:29:47'),
(977, 2, 'ProfUsr', '2020-08-19 02:48:33', '2020-08-19 02:48:33'),
(978, 2, 'Profile', '2020-08-19 02:48:40', '2020-08-19 02:48:40'),
(979, 2, 'Home', '2020-08-19 02:54:10', '2020-08-19 02:54:10'),
(980, 2, 'Monthf', '2020-08-19 02:54:32', '2020-08-19 02:54:32'),
(981, 2, 'Home', '2020-08-19 02:55:15', '2020-08-19 02:55:15'),
(982, 2, 'Monthf', '2020-08-19 02:55:29', '2020-08-19 02:55:29'),
(983, 2, 'Home', '2020-08-19 02:55:50', '2020-08-19 02:55:50'),
(984, 2, 'Monthf', '2020-08-19 02:56:10', '2020-08-19 02:56:10'),
(985, 2, 'Home', '2020-08-19 02:57:22', '2020-08-19 02:57:22'),
(986, 2, 'Monthf', '2020-08-19 02:57:30', '2020-08-19 02:57:30'),
(987, 2, 'Home', '2020-08-19 02:57:53', '2020-08-19 02:57:53'),
(988, 2, 'Bankstat', '2020-08-19 02:57:59', '2020-08-19 02:57:59'),
(989, 2, 'Statecom', '2020-08-19 02:58:05', '2020-08-19 02:58:05'),
(990, 2, 'Deposit', '2020-08-19 03:00:11', '2020-08-19 03:00:11'),
(991, 2, 'Statecom', '2020-08-19 03:01:48', '2020-08-19 03:01:48'),
(992, 2, 'Login success', '2020-08-19 03:03:16', '2020-08-19 03:03:16'),
(993, 2, 'Deposit', '2020-08-19 03:03:22', '2020-08-19 03:03:22'),
(994, 2, 'CondTyp', '2020-08-19 03:27:51', '2020-08-19 03:27:51'),
(995, 2, 'Deposit', '2020-08-19 03:28:21', '2020-08-19 03:28:21'),
(996, 2, 'Statecom', '2020-08-19 03:28:37', '2020-08-19 03:28:37'),
(997, 2, 'Login success', '2020-08-19 03:30:17', '2020-08-19 03:30:17'),
(998, 2, 'Statecom', '2020-08-19 03:30:22', '2020-08-19 03:30:22'),
(999, 2, 'Dirverse', '2020-08-19 03:53:56', '2020-08-19 03:53:56'),
(1000, 2, 'Measucon', '2020-08-19 03:53:59', '2020-08-19 03:53:59'),
(1001, 2, 'Statecom', '2020-08-19 03:54:52', '2020-08-19 03:54:52'),
(1002, 2, 'Aplicat', '2020-08-19 03:57:06', '2020-08-19 03:57:06'),
(1003, 2, 'Deposit', '2020-08-19 04:00:12', '2020-08-19 04:00:12'),
(1004, 2, 'Statecom', '2020-08-19 04:00:37', '2020-08-19 04:00:37'),
(1005, 2, 'Home', '2020-08-19 04:08:44', '2020-08-19 04:08:44'),
(1006, 2, 'Deposit', '2020-08-19 04:23:07', '2020-08-19 04:23:07'),
(1007, 2, 'Menu', '2020-08-19 04:24:03', '2020-08-19 04:24:03'),
(1008, 2, 'Profile', '2020-08-19 04:25:49', '2020-08-19 04:25:49'),
(1009, 2, 'Login success', '2020-08-19 04:32:20', '2020-08-19 04:32:20'),
(1010, 2, 'ProfUsr', '2020-08-19 04:32:25', '2020-08-19 04:32:25'),
(1011, 2, 'Profile', '2020-08-19 04:32:31', '2020-08-19 04:32:31'),
(1012, 2, 'Menu', '2020-08-19 04:32:52', '2020-08-19 04:32:52'),
(1013, 2, 'Profile', '2020-08-19 04:34:00', '2020-08-19 04:34:00'),
(1014, 2, 'PayExpen', '2020-08-19 04:34:57', '2020-08-19 04:34:57'),
(1015, 2, 'Deposit', '2020-08-19 04:38:01', '2020-08-19 04:38:01'),
(1016, 2, 'Menu', '2020-08-19 04:48:17', '2020-08-19 04:48:17'),
(1017, 2, 'ProfUsr', '2020-08-19 04:49:28', '2020-08-19 04:49:28'),
(1018, 2, 'Profile', '2020-08-19 04:49:35', '2020-08-19 04:49:35'),
(1019, 2, 'Error404', '2020-08-19 04:50:48', '2020-08-19 04:50:48'),
(1020, 2, 'Home', '2020-08-19 04:51:49', '2020-08-19 04:51:49'),
(1021, 2, 'Incomes', '2020-08-19 04:51:57', '2020-08-19 04:51:57'),
(1022, 2, 'Expenses', '2020-08-19 04:52:00', '2020-08-19 04:52:00'),
(1023, 2, 'Login success', '2020-08-19 05:12:18', '2020-08-19 05:12:18'),
(1024, 2, 'Faciliti', '2020-08-19 06:11:13', '2020-08-19 06:11:13'),
(1025, 2, 'Residen', '2020-08-19 06:11:30', '2020-08-19 06:11:30'),
(1026, 2, 'Condomin', '2020-08-19 06:11:44', '2020-08-19 06:11:44'),
(1027, 2, 'Login success', '2020-08-19 06:16:28', '2020-08-19 06:16:28'),
(1028, 2, 'Condomin', '2020-08-19 06:16:33', '2020-08-19 06:16:33'),
(1029, 2, 'Faciliti', '2020-08-19 06:25:41', '2020-08-19 06:25:41'),
(1030, 2, 'Condomin', '2020-08-19 06:25:53', '2020-08-19 06:25:53'),
(1031, 2, 'CondTyp', '2020-08-19 06:26:06', '2020-08-19 06:26:06'),
(1032, 2, 'Owner', '2020-08-19 06:28:42', '2020-08-19 06:28:42'),
(1033, 2, 'CondTyp', '2020-08-19 06:28:51', '2020-08-19 06:28:51'),
(1034, 2, 'Owner', '2020-08-19 06:29:10', '2020-08-19 06:29:10'),
(1035, 2, 'Tenant', '2020-08-19 06:37:51', '2020-08-19 06:37:51'),
(1036, 2, 'Owner', '2020-08-19 06:47:49', '2020-08-19 06:47:49'),
(1037, 2, 'Home', '2020-08-19 06:49:23', '2020-08-19 06:49:23'),
(1038, 2, 'Vehicle', '2020-08-19 06:49:28', '2020-08-19 06:49:28'),
(1039, 2, 'Fund', '2020-08-19 06:56:56', '2020-08-19 06:56:56'),
(1040, 2, 'Residen', '2020-08-19 06:58:29', '2020-08-19 06:58:29'),
(1041, 2, 'Vehicle', '2020-08-19 06:58:36', '2020-08-19 06:58:36'),
(1042, 2, 'Fund', '2020-08-19 06:58:44', '2020-08-19 06:58:44'),
(1043, 2, 'Bankacct', '2020-08-19 07:01:14', '2020-08-19 07:01:14'),
(1044, 2, 'budgIn', '2020-08-19 07:04:24', '2020-08-19 07:04:24'),
(1045, 2, 'BudgEx', '2020-08-19 07:04:48', '2020-08-19 07:04:48'),
(1046, 2, 'Quota', '2020-08-19 07:05:32', '2020-08-19 07:05:32'),
(1047, 2, 'Reservat', '2020-08-19 07:09:01', '2020-08-19 07:09:01'),
(1048, 2, 'Confirm', '2020-08-19 07:09:38', '2020-08-19 07:09:38'),
(1049, 2, 'Reservat', '2020-08-19 07:09:41', '2020-08-19 07:09:41'),
(1050, 2, 'Sendmail', '2020-08-19 07:10:51', '2020-08-19 07:10:51'),
(1051, 2, 'Monthf', '2020-08-19 07:10:56', '2020-08-19 07:10:56'),
(1052, 2, 'Dirverse', '2020-08-19 07:11:25', '2020-08-19 07:11:25'),
(1053, 2, 'Measucon', '2020-08-19 07:11:29', '2020-08-19 07:11:29'),
(1054, 2, 'Deposit', '2020-08-19 07:11:35', '2020-08-19 07:11:35'),
(1055, 2, 'Aplicat', '2020-08-19 07:11:45', '2020-08-19 07:11:45'),
(1056, 2, 'Discount', '2020-08-19 07:11:50', '2020-08-19 07:11:50'),
(1057, 2, 'Surcharg', '2020-08-19 07:11:58', '2020-08-19 07:11:58'),
(1058, 2, 'Expense', '2020-08-19 07:12:03', '2020-08-19 07:12:03'),
(1059, 2, 'PayExpen', '2020-08-19 07:12:17', '2020-08-19 07:12:17'),
(1060, 2, 'Expense', '2020-08-19 07:12:24', '2020-08-19 07:12:24'),
(1061, 2, 'Home', '2020-08-19 07:14:10', '2020-08-19 07:14:10'),
(1062, 2, 'Login success', '2020-08-19 07:19:44', '2020-08-19 07:19:44'),
(1063, 2, 'Expense', '2020-08-19 07:19:50', '2020-08-19 07:19:50'),
(1064, 2, 'Login success', '2020-08-19 17:27:38', '2020-08-19 17:27:38'),
(1065, 2, 'Profile', '2020-08-19 17:27:45', '2020-08-19 17:27:45'),
(1066, 2, 'Usuario', '2020-08-19 17:28:04', '2020-08-19 17:28:04'),
(1067, 2, 'Login success', '2020-08-20 04:02:59', '2020-08-20 04:02:59'),
(1068, 2, 'Faciliti', '2020-08-20 04:03:06', '2020-08-20 04:03:06'),
(1069, 2, 'Home', '2020-08-20 04:20:52', '2020-08-20 04:20:52'),
(1070, 2, 'Statecom', '2020-08-20 04:21:02', '2020-08-20 04:21:02'),
(1071, 2, 'Faciliti', '2020-08-20 04:23:19', '2020-08-20 04:23:19'),
(1072, 2, 'Template', '2020-08-20 04:27:22', '2020-08-20 04:27:22'),
(1073, 2, 'Statecom', '2020-08-20 04:46:29', '2020-08-20 04:46:29'),
(1074, 2, 'Home', '2020-08-20 04:48:32', '2020-08-20 04:48:32'),
(1075, 2, 'Residen', '2020-08-20 04:48:52', '2020-08-20 04:48:52'),
(1076, 2, 'Home', '2020-08-20 04:49:10', '2020-08-20 04:49:10'),
(1077, 2, 'Login success', '2020-08-20 05:00:34', '2020-08-20 05:00:34'),
(1078, 2, 'Login success', '2020-08-22 03:21:55', '2020-08-22 03:21:55'),
(1079, 2, 'Faciliti', '2020-08-22 03:22:03', '2020-08-22 03:22:03'),
(1080, 2, 'Residen', '2020-08-22 03:22:07', '2020-08-22 03:22:07'),
(1081, 2, 'Condomin', '2020-08-22 03:22:13', '2020-08-22 03:22:13'),
(1082, 2, 'Owner', '2020-08-22 03:22:24', '2020-08-22 03:22:24'),
(1083, 2, 'Tenant', '2020-08-22 03:23:31', '2020-08-22 03:23:31'),
(1084, 2, 'Vehicle', '2020-08-22 03:23:41', '2020-08-22 03:23:41'),
(1085, 2, 'Fund', '2020-08-22 03:23:48', '2020-08-22 03:23:48'),
(1086, 2, 'Bankacct', '2020-08-22 03:23:56', '2020-08-22 03:23:56'),
(1087, 2, 'Quota', '2020-08-22 03:34:35', '2020-08-22 03:34:35'),
(1088, 2, 'budgIn', '2020-08-22 03:34:58', '2020-08-22 03:34:58'),
(1089, 2, 'Home', '2020-08-22 03:35:13', '2020-08-22 03:35:13'),
(1090, 2, 'PayExpen', '2020-08-22 03:35:50', '2020-08-22 03:35:50'),
(1091, 2, 'Expense', '2020-08-22 03:35:55', '2020-08-22 03:35:55'),
(1092, 2, 'Surcharg', '2020-08-22 03:36:34', '2020-08-22 03:36:34'),
(1093, 2, 'Discount', '2020-08-22 03:36:37', '2020-08-22 03:36:37'),
(1094, 2, 'Aplicat', '2020-08-22 03:36:42', '2020-08-22 03:36:42'),
(1095, 2, 'Deposit', '2020-08-22 03:36:44', '2020-08-22 03:36:44'),
(1096, 2, 'Measucon', '2020-08-22 03:37:04', '2020-08-22 03:37:04'),
(1097, 2, 'Dirverse', '2020-08-22 03:37:11', '2020-08-22 03:37:11'),
(1098, 2, 'Condomin', '2020-08-22 03:40:09', '2020-08-22 03:40:09');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `measured_consumptions`
--

CREATE TABLE `measured_consumptions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `description` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `costPerUnit` double(12,2) NOT NULL DEFAULT 0.00,
  `dateReading` date DEFAULT NULL,
  `dateDue` date DEFAULT NULL,
  `fund` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `budgetExpenditure_id` bigint(20) UNSIGNED DEFAULT NULL,
  `condominia_id` bigint(20) UNSIGNED DEFAULT NULL,
  `ReadPrev` double(12,2) NOT NULL DEFAULT 0.00,
  `ReadNew` double(12,2) NOT NULL DEFAULT 0.00,
  `amount` double(12,2) NOT NULL DEFAULT 0.00,
  `active` enum('1','0') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1',
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `menus`
--

CREATE TABLE `menus` (
  `id` bigint(20) UNSIGNED NOT NULL COMMENT 'Id key',
  `type` bigint(20) UNSIGNED NOT NULL COMMENT 'Option type',
  `orderlist` tinyint(4) DEFAULT 0 COMMENT 'List order in menu',
  `label` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Option label',
  `link` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Option link',
  `description` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Option descripcion',
  `icon` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Option icon',
  `active` enum('1','0') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1' COMMENT 'Option status',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='It contains the list Menus';

--
-- Volcado de datos para la tabla `menus`
--

INSERT INTO `menus` (`id`, `type`, `orderlist`, `label`, `link`, `description`, `icon`, `active`, `created_at`, `updated_at`) VALUES
(1, 1, 2, 'Usuario', 'Usuario', 'Ficha de Usuario', 'perm_identity', '1', NULL, NULL),
(2, 2, 7, 'Vehículo', 'Vehicle', 'Ficha de Vehículos', 'commute', '1', NULL, NULL),
(3, 2, 5, 'Propietario', 'Owner', 'Ficha de Propietarios', 'assignment_ind', '1', NULL, NULL),
(5, 1, 1, 'Opciones', 'Menu', '', 'list', '1', NULL, NULL),
(7, 4, 99, 'Cuotas', 'Quotaj', 'Consulta de Cuotas', 'blur_linear', '0', NULL, NULL),
(14, 3, 4, 'Cuota Mensual', 'Monthf', 'Registro cuota mensual', 'assignment', '1', NULL, NULL),
(15, 1, 3, 'Permisos', 'Profile', 'Ficha de Permisos a Usuario', 'chrome_reader_mode', '1', NULL, NULL),
(17, 4, 99, 'Gastos', 'Expensej', 'Consulta de Gastos', 'dynamic_feed', '0', NULL, NULL),
(24, 2, 4, 'Tipo Departamento', 'CondTyp', 'Ficha de tipos de departamento', 'all_out', '1', NULL, NULL),
(26, 1, 99, 'Template', 'Template', 'Plantilla para Pruebas', '', '1', NULL, NULL),
(27, 1, 99, 'Pruebas', 'Pruebas', 'Plantilla para Pruebas', '', '1', NULL, NULL),
(28, 2, 1, 'Amenidades', 'Faciliti', 'Ficha de amenidades', 'settings_applications', '1', NULL, NULL),
(29, 3, 11, 'Gasto', 'Expense', 'Registro de Gastos', 'description', '1', NULL, NULL),
(30, 2, 2, 'Residencial', 'Residen', 'Datos de la residencia', 'business', '1', NULL, NULL),
(31, 2, 8, 'Fondos', 'Fund', 'Ficha de fondos', 'bubble_chart', '1', NULL, NULL),
(32, 2, 12, 'Cuotas', 'Quota', 'Ficha de Cuotas', 'widgets', '1', NULL, '2020-08-11 17:29:28'),
(33, 2, 99, 'Proveedor', 'Provider', 'Ficha de Proveedores', 'assistant', '0', NULL, NULL),
(34, 3, 99, 'Cerrar Ppto', 'BudgeClo', 'Cerrar partidas de Ppto', 'check_circle_outline', '0', NULL, NULL),
(35, 2, 99, 'Presupuesto', 'Budgets', 'Catalogo de Presupuestos', 'assessment', '0', NULL, NULL),
(37, 3, 3, 'Envio de correo', 'Sendmail', 'Envio de mensajes electronicos', 'question_answer', '1', NULL, NULL),
(38, 2, 3, 'Departamento', 'Condomin', 'Catalogo de departamentos', 'album', '1', NULL, NULL),
(39, 3, 2, 'Confirmar reservación', 'Confirm', 'Confirmar reservaciones', 'playlist_add_check', '1', NULL, NULL),
(40, 3, 1, 'Reservar amenidad', 'Reservat', 'Reservación de amenidades', 'move_to_inbox', '1', NULL, NULL),
(42, 3, 7, 'Pagos', 'Deposit', 'Registro de Pagos', 'opacity', '1', NULL, NULL),
(43, 1, 99, 'Testprint', 'Testprnt', 'Pruebas de impresión', 'print', '1', NULL, NULL),
(44, 2, 6, 'Inquilino', 'Tenant', 'Catalogo de Inquilinos', 'perm_identity', '1', '2020-08-11 17:27:16', '2020-08-11 17:28:34'),
(45, 2, 9, 'Banco', 'Bankacct', 'Catalogo de Bancos', 'account_balance', '1', '2020-08-11 17:28:00', '2020-08-11 17:28:16'),
(46, 3, 99, 'Eventos', 'Event', 'Registro de eventos', 'speaker_notes', '0', '2020-08-11 17:30:13', '2020-08-11 17:30:13'),
(47, 3, 8, 'Aplicación de Pago', 'Aplicat', 'Aplicación de pagos', 'payment', '1', '2020-08-11 17:31:03', '2020-08-11 17:31:03'),
(48, 3, 99, 'Mnto Reparacione', 'Repair', 'Mantenimiento y reparaciones', 'build', '0', '2020-08-11 17:32:15', '2020-08-11 17:32:15'),
(49, 4, 3, 'Fondos', 'Funds', 'Fondos', 'table_view', '1', '2020-08-11 17:32:46', '2020-08-11 17:32:46'),
(50, 1, 4, 'Perfil Usuario', 'ProfUsr', 'Perfiles de usuario', 'horizontal_split', '1', '2020-08-17 00:19:35', '2020-08-17 00:19:35'),
(51, 4, 1, 'Estado de cuenta Banco', 'Bankstat', 'Estado de cuenta Banco', 'attach_money', '1', '2020-08-17 02:53:44', '2020-08-17 02:53:44'),
(52, 2, 10, 'Presupuesto Ingresos', 'budgIn', 'Ficha de presupuesto de Ingresos', 'insert_chart_outlined', '1', '2020-08-17 04:12:00', '2020-08-17 04:12:00'),
(53, 2, 11, 'Presupuesto Egresos', 'BudgEx', 'Ficha de presupuesto de egresos', 'blur_linear', '1', '2020-08-17 04:12:33', '2020-08-17 04:12:33'),
(54, 3, 6, 'Cuota consumo medido', 'Measucon', 'Cuota consumo medido', NULL, '1', '2020-08-17 07:28:33', '2020-08-17 07:28:33'),
(55, 3, 5, 'Cuota diversa', 'Dirverse', 'Registro de cuotas diversas', NULL, '1', '2020-08-17 19:52:54', '2020-08-17 19:52:54'),
(56, 4, 2, 'Estado de cuenta departamento', 'Statecom', 'Estado de cuenta departamento', NULL, '1', '2020-08-17 21:41:36', '2020-08-17 21:41:36'),
(57, 3, 9, 'Descuentos', 'Discount', 'Registro de descuentos', NULL, '1', '2020-08-19 04:24:29', '2020-08-19 04:24:29'),
(58, 3, 10, 'Recargos', 'Surcharg', 'Registro de recargos', NULL, '1', '2020-08-19 04:25:04', '2020-08-19 04:25:04'),
(59, 3, 12, 'Pagar gasto', 'PayExpen', 'Registro de pagos autorizados', NULL, '1', '2020-08-19 04:33:24', '2020-08-19 04:33:24'),
(60, 4, 4, 'Ingresos', 'Incomes', 'Consulta de ingresos', NULL, '1', '2020-08-19 04:48:53', '2020-08-19 04:48:53'),
(61, 4, 5, 'Egresos', 'Expenses', 'Consulta de egresos', NULL, '1', '2020-08-19 04:49:18', '2020-08-19 04:49:18');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `menutypes`
--

CREATE TABLE `menutypes` (
  `id` bigint(20) UNSIGNED NOT NULL COMMENT 'Id key',
  `description` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Description type menu',
  `icon` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Type menu Icon',
  `active` enum('1','0') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1' COMMENT 'Type menu active',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='It contains the menu types';

--
-- Volcado de datos para la tabla `menutypes`
--

INSERT INTO `menutypes` (`id`, `description`, `icon`, `active`, `created_at`, `updated_at`) VALUES
(1, 'Sistema', 'local_activity', '1', NULL, NULL),
(2, 'Catalogo', 'local_activity', '1', NULL, NULL),
(3, 'Registro', 'local_activity', '1', NULL, NULL),
(4, 'Consulta', 'local_activity', '1', NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '000_00_00_000020_create_profiles_table', 1),
(2, '000_00_00_000030_create_users_table', 1),
(3, '000_00_00_000040_create_menutypes_table', 1),
(4, '000_00_00_000050_create_menus_table', 1),
(5, '000_00_00_000210_create_logs_table', 1),
(6, '000_00_00_000270_create_controlpermissions_table', 1),
(7, '000_00_00_000060_create_customers_table', 2),
(8, '000_00_00_000070_create_companies_table', 3),
(9, '000_00_00_000280_create_budgets_table', 3),
(10, '000_00_00_000290_create_condominias_table', 4),
(11, '000_00_00_000300_create_condominia_types_table', 5),
(16, '000_00_00_000180_create_providers_table', 7),
(20, '000_00_00_000320_create_expenses_table', 10),
(21, '000_00_00_000340_create_deposits_table', 11),
(22, '000_00_00_000350_create_tenants_table', 12),
(24, '000_00_00_000370_create_events_table', 12),
(25, '000_00_00_000380_create_repairs_table', 12),
(26, '000_00_00_000390_create_aplications_table', 12),
(27, '000_00_00_000400_create_owners_table', 13),
(28, '000_00_00_000410_create_residences_table', 14),
(29, '000_00_00_000420_create_facilities_table', 14),
(30, '000_00_00_000430_create_facilities_reserves_table', 14),
(31, '000_00_00_000440_create_condominia_table', 14),
(32, '000_00_00_000450_create_vehicles_table', 14),
(35, '000_00_00_000480_create_debits_table', 14),
(36, '000_00_00_000490_create_measured_consumptions_table', 14),
(37, '000_00_00_000500_create_account_payables_table', 14),
(38, '000_00_00_000510_create_pay_expenses_table', 14),
(39, '000_00_00_000520_create_funds_table', 15),
(40, '000_00_00_000360_create_banks_table', 16),
(41, '000_00_00_000460_create_budget_expenditures_table', 17),
(44, '000_00_00_000330_create_condominia_quotas_table', 18),
(45, '000_00_00_000470_create_budget_incomes_table', 19),
(46, '000_00_00_000310_create_quotas_table', 20);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `owners`
--

CREATE TABLE `owners` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `movil` varchar(15) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `active` enum('1','0') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1',
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `owners`
--

INSERT INTO `owners` (`id`, `name`, `movil`, `email`, `active`, `user_id`, `created_at`, `updated_at`) VALUES
(1, 'Jairo Medrano Landa', '4426781199', 'jairo.medrano@mail.com', '1', 2, NULL, '2020-08-19 06:37:20'),
(2, 'Michel Mendoza Verde', '4425466626', 'michel.medrano@mail.com', '1', 2, '2020-08-14 05:54:06', '2020-08-19 06:37:36');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pay_expenses`
--

CREATE TABLE `pay_expenses` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `datedoc` date DEFAULT NULL,
  `amount` double(12,2) NOT NULL DEFAULT 0.00,
  `reference` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bank` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `comments` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `profiles`
--

CREATE TABLE `profiles` (
  `id` bigint(20) UNSIGNED NOT NULL COMMENT 'Id key',
  `usr_id` tinyint(4) DEFAULT NULL COMMENT 'Id user',
  `mnu_id` tinyint(4) DEFAULT NULL COMMENT 'Id Menu',
  `active` enum('1','0') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1' COMMENT 'Profile active',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='It contains the profile by user';

--
-- Volcado de datos para la tabla `profiles`
--

INSERT INTO `profiles` (`id`, `usr_id`, `mnu_id`, `active`, `created_at`, `updated_at`) VALUES
(1, 3, 1, '1', NULL, '2020-08-16 18:19:53'),
(2, 3, 5, '1', NULL, '2020-08-16 18:19:53'),
(3, 3, 15, '1', NULL, '2020-08-16 18:19:53'),
(4, 3, 2, '0', NULL, '2020-08-16 18:19:53'),
(5, 3, 9, '0', NULL, '2020-08-16 18:19:53'),
(6, 3, 3, '1', NULL, '2020-08-16 18:19:53'),
(7, 3, 4, '0', NULL, '2020-08-16 18:19:53'),
(8, 3, 12, '0', NULL, '2020-08-16 18:19:53'),
(9, 3, 13, '0', NULL, '2020-08-16 18:19:53'),
(10, 3, 14, '1', NULL, '2020-08-16 18:19:53'),
(11, 3, 8, '0', NULL, '2020-08-16 18:19:53'),
(12, 3, 7, '1', NULL, '2020-08-16 18:19:53'),
(13, 3, 16, '0', NULL, '2020-08-16 18:19:53'),
(14, 3, 17, '1', NULL, '2020-08-16 18:19:53'),
(15, 3, 18, '0', NULL, '2020-08-16 18:19:53'),
(16, 3, 19, '0', NULL, '2020-08-16 18:19:53'),
(17, 3, 20, '0', NULL, '2020-08-16 18:19:53'),
(18, 3, 21, '0', NULL, '2020-08-16 18:19:53'),
(19, 2, 5, '1', NULL, '2020-08-19 04:50:03'),
(20, 2, 15, '1', NULL, '2020-08-19 04:50:03'),
(21, 2, 19, '0', NULL, '2020-08-19 04:50:03'),
(22, 2, 20, '0', NULL, '2020-08-19 04:50:03'),
(23, 2, 21, '0', NULL, '2020-08-19 04:50:03'),
(24, 2, 22, '0', NULL, '2020-08-19 04:50:03'),
(25, 3, 22, '0', NULL, '2020-08-16 18:19:53'),
(26, 3, 23, '0', NULL, '2020-08-16 18:19:53'),
(27, 3, 24, '1', NULL, '2020-08-16 18:19:53'),
(28, 3, 25, '0', NULL, '2020-08-16 18:19:53'),
(29, 2, 1, '1', NULL, '2020-08-19 04:50:03'),
(30, 2, 2, '1', NULL, '2020-08-19 04:50:03'),
(31, 2, 9, '0', NULL, '2020-08-19 04:50:03'),
(32, 2, 3, '1', NULL, '2020-08-19 04:50:03'),
(33, 2, 23, '0', NULL, '2020-08-19 04:50:03'),
(34, 2, 24, '1', NULL, '2020-08-19 04:50:03'),
(35, 2, 4, '0', NULL, '2020-08-19 04:50:03'),
(36, 2, 12, '0', NULL, '2020-08-19 04:50:03'),
(37, 2, 13, '0', NULL, '2020-08-19 04:50:03'),
(38, 2, 14, '1', NULL, '2020-08-19 04:50:03'),
(39, 2, 8, '0', NULL, '2020-08-19 04:50:03'),
(40, 2, 16, '0', NULL, '2020-08-19 04:50:03'),
(41, 2, 25, '0', NULL, '2020-08-19 04:50:03'),
(42, 2, 7, '1', NULL, '2020-08-19 04:50:03'),
(43, 2, 17, '1', NULL, '2020-08-19 04:50:03'),
(44, 2, 18, '0', NULL, '2020-08-19 04:50:03'),
(45, 2, 26, '1', NULL, '2020-08-19 04:50:03'),
(46, 2, 28, '1', NULL, '2020-08-19 04:50:03'),
(47, 2, 29, '1', NULL, '2020-08-19 04:50:03'),
(48, 2, 27, '1', '2020-08-06 02:07:28', '2020-08-19 04:50:03'),
(49, 2, 43, '1', '2020-08-06 02:07:28', '2020-08-19 04:50:03'),
(50, 2, 30, '1', '2020-08-06 02:07:29', '2020-08-19 04:50:03'),
(51, 2, 31, '1', '2020-08-06 02:07:29', '2020-08-19 04:50:03'),
(52, 2, 32, '1', '2020-08-06 02:07:29', '2020-08-19 04:50:03'),
(53, 2, 33, '1', '2020-08-06 02:07:29', '2020-08-19 04:50:03'),
(54, 2, 35, '1', '2020-08-06 02:07:29', '2020-08-19 04:50:03'),
(55, 2, 38, '1', '2020-08-06 02:07:29', '2020-08-19 04:50:03'),
(56, 2, 34, '1', '2020-08-06 02:07:29', '2020-08-19 04:50:03'),
(57, 2, 37, '1', '2020-08-06 02:07:29', '2020-08-19 04:50:03'),
(58, 2, 39, '1', '2020-08-06 02:07:29', '2020-08-19 04:50:03'),
(59, 2, 40, '1', '2020-08-06 02:07:29', '2020-08-19 04:50:03'),
(60, 2, 42, '1', '2020-08-06 02:07:29', '2020-08-19 04:50:03'),
(61, 5, 24, '1', '2020-08-09 21:45:59', '2020-08-19 04:49:44'),
(62, 5, 32, '1', '2020-08-09 21:46:00', '2020-08-19 04:49:44'),
(63, 5, 33, '1', '2020-08-09 21:46:00', '2020-08-19 04:49:44'),
(64, 5, 35, '1', '2020-08-09 21:46:00', '2020-08-19 04:49:44'),
(65, 5, 38, '1', '2020-08-09 21:46:00', '2020-08-19 04:49:44'),
(66, 5, 29, '1', '2020-08-09 21:46:00', '2020-08-19 04:49:44'),
(67, 5, 14, '1', '2020-08-09 21:46:00', '2020-08-19 04:49:44'),
(68, 5, 34, '1', '2020-08-09 21:46:00', '2020-08-19 04:49:44'),
(69, 5, 42, '1', '2020-08-09 21:46:00', '2020-08-19 04:49:44'),
(70, 5, 7, '1', '2020-08-09 21:46:00', '2020-08-19 04:49:44'),
(71, 5, 17, '1', '2020-08-09 21:46:00', '2020-08-19 04:49:44'),
(72, 2, 44, '1', '2020-08-11 17:33:58', '2020-08-19 04:50:03'),
(73, 2, 45, '1', '2020-08-11 17:33:58', '2020-08-19 04:50:03'),
(74, 2, 46, '1', '2020-08-11 17:33:58', '2020-08-19 04:50:03'),
(75, 2, 47, '1', '2020-08-11 17:33:58', '2020-08-19 04:50:03'),
(76, 2, 48, '1', '2020-08-11 17:33:58', '2020-08-19 04:50:03'),
(77, 2, 49, '1', '2020-08-11 17:33:58', '2020-08-19 04:50:03'),
(78, 5, 1, '0', '2020-08-11 17:50:56', '2020-08-19 04:49:44'),
(79, 5, 5, '0', '2020-08-11 17:50:56', '2020-08-19 04:49:44'),
(80, 5, 15, '0', '2020-08-11 17:50:56', '2020-08-19 04:49:44'),
(81, 5, 27, '0', '2020-08-11 17:50:56', '2020-08-19 04:49:44'),
(82, 5, 26, '0', '2020-08-11 17:50:56', '2020-08-19 04:49:44'),
(83, 5, 43, '0', '2020-08-11 17:50:56', '2020-08-19 04:49:44'),
(84, 5, 44, '1', '2020-08-11 17:50:56', '2020-08-19 04:49:44'),
(85, 5, 45, '1', '2020-08-11 17:50:56', '2020-08-19 04:49:44'),
(86, 5, 46, '1', '2020-08-11 17:50:56', '2020-08-19 04:49:44'),
(87, 5, 47, '1', '2020-08-11 17:50:56', '2020-08-19 04:49:44'),
(88, 5, 48, '1', '2020-08-11 17:50:56', '2020-08-19 04:49:44'),
(89, 5, 49, '1', '2020-08-11 17:50:56', '2020-08-19 04:49:44'),
(90, 5, 3, '1', '2020-08-14 04:50:19', '2020-08-19 04:49:44'),
(91, 3, 26, '1', '2020-08-16 18:12:02', '2020-08-16 18:19:53'),
(92, 3, 27, '1', '2020-08-16 18:12:02', '2020-08-16 18:19:53'),
(93, 3, 43, '1', '2020-08-16 18:12:02', '2020-08-16 18:19:53'),
(94, 3, 30, '1', '2020-08-16 18:12:02', '2020-08-16 18:19:53'),
(95, 3, 32, '1', '2020-08-16 18:12:02', '2020-08-16 18:19:53'),
(96, 3, 33, '1', '2020-08-16 18:12:02', '2020-08-16 18:19:53'),
(97, 3, 35, '1', '2020-08-16 18:12:02', '2020-08-16 18:19:53'),
(98, 3, 38, '1', '2020-08-16 18:12:02', '2020-08-16 18:19:53'),
(99, 3, 44, '1', '2020-08-16 18:12:02', '2020-08-16 18:19:53'),
(100, 3, 45, '1', '2020-08-16 18:12:02', '2020-08-16 18:19:53'),
(101, 3, 29, '1', '2020-08-16 18:12:02', '2020-08-16 18:19:53'),
(102, 3, 34, '1', '2020-08-16 18:12:02', '2020-08-16 18:19:53'),
(103, 3, 42, '1', '2020-08-16 18:12:02', '2020-08-16 18:19:53'),
(104, 3, 46, '1', '2020-08-16 18:12:02', '2020-08-16 18:19:53'),
(105, 3, 47, '1', '2020-08-16 18:12:02', '2020-08-16 18:19:53'),
(106, 3, 48, '1', '2020-08-16 18:12:02', '2020-08-16 18:19:53'),
(107, 3, 49, '1', '2020-08-16 18:12:02', '2020-08-16 18:19:53'),
(108, 2, 50, '1', '2020-08-17 00:19:53', '2020-08-19 04:50:03'),
(109, 2, 51, '1', '2020-08-17 02:54:58', '2020-08-19 04:50:03'),
(110, 2, 53, '1', '2020-08-17 04:15:27', '2020-08-19 04:50:03'),
(111, 2, 52, '1', '2020-08-17 04:15:27', '2020-08-19 04:50:03'),
(112, 2, 54, '1', '2020-08-17 07:28:46', '2020-08-19 04:50:03'),
(113, 2, 55, '1', '2020-08-17 19:53:37', '2020-08-19 04:50:03'),
(114, 5, 28, '1', '2020-08-17 20:50:16', '2020-08-19 04:49:44'),
(115, 5, 30, '1', '2020-08-17 20:50:16', '2020-08-19 04:49:44'),
(116, 5, 2, '1', '2020-08-17 20:50:16', '2020-08-19 04:49:44'),
(117, 5, 31, '1', '2020-08-17 20:50:16', '2020-08-19 04:49:44'),
(118, 5, 40, '1', '2020-08-17 20:50:16', '2020-08-19 04:49:44'),
(119, 5, 55, '1', '2020-08-17 20:50:16', '2020-08-19 04:49:44'),
(120, 5, 51, '1', '2020-08-17 20:50:16', '2020-08-19 04:49:44'),
(121, 5, 37, '1', '2020-08-17 20:50:16', '2020-08-19 04:49:44'),
(122, 5, 53, '1', '2020-08-17 20:50:16', '2020-08-19 04:49:44'),
(123, 5, 52, '1', '2020-08-17 20:50:16', '2020-08-19 04:49:44'),
(124, 5, 54, '1', '2020-08-17 20:50:16', '2020-08-19 04:49:44'),
(125, 5, 39, '1', '2020-08-17 20:50:16', '2020-08-19 04:49:44'),
(126, 2, 56, '1', '2020-08-17 21:42:40', '2020-08-19 04:50:03'),
(127, 5, 56, '1', '2020-08-17 21:45:30', '2020-08-19 04:49:44'),
(128, 5, 57, '1', '2020-08-19 04:26:02', '2020-08-19 04:49:44'),
(129, 5, 58, '1', '2020-08-19 04:26:02', '2020-08-19 04:49:44'),
(130, 2, 57, '1', '2020-08-19 04:26:22', '2020-08-19 04:50:03'),
(131, 2, 58, '1', '2020-08-19 04:26:22', '2020-08-19 04:50:03'),
(132, 5, 59, '1', '2020-08-19 04:34:08', '2020-08-19 04:49:44'),
(133, 2, 59, '1', '2020-08-19 04:34:22', '2020-08-19 04:50:03'),
(134, 1, 5, '1', '2020-08-19 04:34:30', '2020-08-19 17:27:57'),
(135, 1, 1, '1', '2020-08-19 04:34:30', '2020-08-19 17:27:57'),
(136, 1, 15, '1', '2020-08-19 04:34:30', '2020-08-19 17:27:57'),
(137, 1, 50, '1', '2020-08-19 04:34:30', '2020-08-19 17:27:57'),
(138, 1, 26, '1', '2020-08-19 04:34:30', '2020-08-19 17:27:57'),
(139, 1, 27, '1', '2020-08-19 04:34:30', '2020-08-19 17:27:57'),
(140, 1, 43, '1', '2020-08-19 04:34:30', '2020-08-19 17:27:57'),
(141, 1, 28, '1', '2020-08-19 04:34:30', '2020-08-19 17:27:57'),
(142, 1, 30, '1', '2020-08-19 04:34:30', '2020-08-19 17:27:57'),
(143, 1, 38, '1', '2020-08-19 04:34:30', '2020-08-19 17:27:57'),
(144, 1, 24, '1', '2020-08-19 04:34:30', '2020-08-19 17:27:57'),
(145, 1, 3, '1', '2020-08-19 04:34:30', '2020-08-19 17:27:57'),
(146, 1, 44, '1', '2020-08-19 04:34:30', '2020-08-19 17:27:57'),
(147, 1, 2, '1', '2020-08-19 04:34:30', '2020-08-19 17:27:57'),
(148, 1, 31, '1', '2020-08-19 04:34:30', '2020-08-19 17:27:57'),
(149, 1, 45, '1', '2020-08-19 04:34:30', '2020-08-19 17:27:57'),
(150, 1, 52, '1', '2020-08-19 04:34:30', '2020-08-19 17:27:57'),
(151, 1, 53, '1', '2020-08-19 04:34:30', '2020-08-19 17:27:57'),
(152, 1, 32, '1', '2020-08-19 04:34:30', '2020-08-19 17:27:57'),
(153, 1, 40, '1', '2020-08-19 04:34:30', '2020-08-19 17:27:57'),
(154, 1, 39, '1', '2020-08-19 04:34:30', '2020-08-19 17:27:57'),
(155, 1, 37, '1', '2020-08-19 04:34:30', '2020-08-19 17:27:57'),
(156, 1, 14, '1', '2020-08-19 04:34:30', '2020-08-19 17:27:57'),
(157, 1, 55, '1', '2020-08-19 04:34:30', '2020-08-19 17:27:57'),
(158, 1, 54, '1', '2020-08-19 04:34:30', '2020-08-19 17:27:57'),
(159, 1, 42, '1', '2020-08-19 04:34:30', '2020-08-19 17:27:57'),
(160, 1, 47, '1', '2020-08-19 04:34:30', '2020-08-19 17:27:57'),
(161, 1, 57, '1', '2020-08-19 04:34:30', '2020-08-19 17:27:57'),
(162, 1, 58, '1', '2020-08-19 04:34:30', '2020-08-19 17:27:57'),
(163, 1, 29, '1', '2020-08-19 04:34:30', '2020-08-19 17:27:57'),
(164, 1, 59, '1', '2020-08-19 04:34:30', '2020-08-19 17:27:57'),
(165, 1, 51, '1', '2020-08-19 04:34:30', '2020-08-19 17:27:57'),
(166, 1, 56, '1', '2020-08-19 04:34:30', '2020-08-19 17:27:57'),
(167, 1, 49, '1', '2020-08-19 04:34:30', '2020-08-19 17:27:57'),
(168, 5, 61, '1', '2020-08-19 04:49:44', '2020-08-19 04:49:44'),
(169, 5, 60, '1', '2020-08-19 04:49:44', '2020-08-19 04:49:44'),
(170, 1, 60, '1', '2020-08-19 04:49:53', '2020-08-19 17:27:57'),
(171, 1, 61, '1', '2020-08-19 04:49:53', '2020-08-19 17:27:57'),
(172, 2, 60, '1', '2020-08-19 04:50:03', '2020-08-19 04:50:03'),
(173, 2, 61, '1', '2020-08-19 04:50:03', '2020-08-19 04:50:03');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `providers`
--

CREATE TABLE `providers` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `code` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `movil` varchar(15) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `active` enum('1','0') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1',
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `providers`
--

INSERT INTO `providers` (`id`, `code`, `description`, `movil`, `active`, `user_id`, `created_at`, `updated_at`) VALUES
(1, 'CFE', 'Pago de energia electrica', '4428916700', '1', 2, NULL, '2020-08-07 05:11:15'),
(2, 'SegIntegral', 'Servicio de seguridad Integral', '4429162892', '1', 2, NULL, '2020-08-07 06:06:43'),
(3, 'LimpiezaClean', 'Servicio de limpieza Clean', '4421818100', '1', 2, '2020-08-07 05:14:58', '2020-08-07 06:07:07'),
(4, 'ObrasPublicas', 'Arquitectura y Construccion', '4428991932', '1', 2, '2020-08-07 18:21:32', '2020-08-07 18:21:32');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `quotas`
--

CREATE TABLE `quotas` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `code` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `dueDays` tinyint(4) NOT NULL DEFAULT 0,
  `amount` double(12,2) NOT NULL DEFAULT 0.00,
  `percentagediscount` bigint(20) UNSIGNED DEFAULT NULL,
  `fund_id` bigint(20) UNSIGNED DEFAULT NULL,
  `budget_incomes_id` bigint(20) UNSIGNED DEFAULT NULL,
  `active` enum('1','0') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1',
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `quotas`
--

INSERT INTO `quotas` (`id`, `code`, `description`, `dueDays`, `amount`, `percentagediscount`, `fund_id`, `budget_incomes_id`, `active`, `user_id`, `created_at`, `updated_at`) VALUES
(1, 'CuotaMensual', 'Cuota ordinaria mensual', 10, 0.00, 3, 1, 1, '1', 2, '2020-08-17 08:05:50', '2020-08-17 08:34:12');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `repairs`
--

CREATE TABLE `repairs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `description` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `dateRepair` date DEFAULT NULL,
  `active` enum('1','0') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1',
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `repairs`
--

INSERT INTO `repairs` (`id`, `description`, `dateRepair`, `active`, `user_id`, `created_at`, `updated_at`) VALUES
(1, 'Mnto porton frontal', '2020-08-17', '1', 2, NULL, '2020-08-15 23:20:17');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `residences`
--

CREATE TABLE `residences` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(400) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` varchar(400) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `url` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `webpage` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `management` varchar(400) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `active` enum('1','0') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1',
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `residences`
--

INSERT INTO `residences` (`id`, `name`, `address`, `url`, `webpage`, `email`, `management`, `active`, `user_id`, `created_at`, `updated_at`) VALUES
(1, 'Condominio Palacios', 'AV. del sur No. 3421', 'www.palacios.masinfo.pw', 'www.palacios.com.mx', 'atencion@palacios.com.mx', 'Arrendadora y Servicios S. A. de C. V.', '1', 2, NULL, '2020-08-16 19:39:03');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tenants`
--

CREATE TABLE `tenants` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `movil` varchar(15) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `active` enum('1','0') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1',
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `tenants`
--

INSERT INTO `tenants` (`id`, `name`, `movil`, `email`, `active`, `user_id`, `created_at`, `updated_at`) VALUES
(1, 'Gerardo Moreno Diaz', '4428917890', 'moreno.diaz@mail.com', '1', 2, NULL, '2020-08-19 06:45:54'),
(2, 'Pedro Lopez', '3219031033', NULL, '1', 2, '2020-08-14 04:25:47', '2020-08-14 04:25:47'),
(3, 'Nayeli Mendez', '4425466626', NULL, '1', 2, '2020-08-14 04:26:42', '2020-08-14 04:26:42'),
(4, 'Juan Medina', '7192012911', NULL, '1', 2, '2020-08-15 00:52:19', '2020-08-15 00:52:19'),
(5, 'Mario Perez', '7282882882', NULL, '1', 2, '2020-08-15 16:24:20', '2020-08-15 16:24:20');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `sysname` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `firstname` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `midname` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `lastname` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `movil` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `active` enum('1','0') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1',
  `email` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='It contains the User data';

--
-- Volcado de datos para la tabla `users`
--

INSERT INTO `users` (`id`, `sysname`, `firstname`, `midname`, `lastname`, `movil`, `active`, `email`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'rasecfer', 'Fernando', 'Zambrans', 'Cardiel', '4423453333', '1', 'rasecfer@gmail.com', NULL, '$2y$10$wRHmWRd62O1NARWFB8oGUePlRMj9FJVo8y0RyC3.2QbHk1Tu2xOYe', NULL, NULL, '2020-08-19 17:28:21'),
(2, 'admin', 'Admin', 'D', 'Sistema', '9876543210', '1', 'carlos_asrnet@hotmail.com', NULL, '$2y$10$LILTZnFQd.zDMck2yMtdxO5VuRQh82Xd2vZNH8t8GrXp6FyomJSHi', NULL, NULL, '2020-08-05 20:11:07'),
(3, 'demo', 'Usuario', 'De', 'Mo', '3232322332', '1', 'sistema21mx@mail.com', NULL, '$2y$10$6YCiDpeg8p6iRvRtfkwECuenksFo/wqVfFdIVEp0zVp9yeiXN/UQi', NULL, NULL, NULL),
(4, 'prueba', 'Usuario', 'De', 'Prueba', '4425468383', '0', 'prueba@mail.com', NULL, '$2y$10$4pEjl4bdCA7jkfKTP5qbSuhvYXIKPjvn0VT.ukRoLQO6XPR6tJQUW', NULL, NULL, NULL),
(5, 'ernestoag', 'Ernesto', 'Admin', 'DSistema', '4429128437', '1', 'ernestoag', NULL, '$2y$10$PUJW0/Z/8KUP7xHRGLfk..Otoa20jKC2oTVJjqWMSBPCdEFYKM.wu', NULL, '2020-08-09 21:45:11', '2020-08-11 18:18:31');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `vehicles`
--

CREATE TABLE `vehicles` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `code` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parkingspace` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `active` enum('1','0') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1',
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `vehicles`
--

INSERT INTO `vehicles` (`id`, `code`, `description`, `parkingspace`, `active`, `user_id`, `created_at`, `updated_at`) VALUES
(1, 'UNA-8931', 'Renault clio verde esmeralda', 'Nivel 1 caja 1', '1', 2, NULL, '2020-08-19 06:56:41'),
(2, 'UNA-1901', 'Nissan Versa Rojo Metalico', 'Nivel 1 caja 3', '1', 2, '2020-08-17 00:08:52', '2020-08-19 06:56:22');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `account_payables`
--
ALTER TABLE `account_payables`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `aplications`
--
ALTER TABLE `aplications`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `banks`
--
ALTER TABLE `banks`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `budgetsold`
--
ALTER TABLE `budgetsold`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `budgets_code_unique` (`code`);

--
-- Indices de la tabla `budget_expenditures`
--
ALTER TABLE `budget_expenditures`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `budget_expenditures_code_unique` (`code`);

--
-- Indices de la tabla `budget_incomes`
--
ALTER TABLE `budget_incomes`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `budget_incomes_code_unique` (`code`);

--
-- Indices de la tabla `companies`
--
ALTER TABLE `companies`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `condominias`
--
ALTER TABLE `condominias`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `condominias_code_unique` (`code`);

--
-- Indices de la tabla `condominia_quotas`
--
ALTER TABLE `condominia_quotas`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `condominia_types`
--
ALTER TABLE `condominia_types`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `condominia_types_code_unique` (`code`);

--
-- Indices de la tabla `controlpermissions`
--
ALTER TABLE `controlpermissions`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `customers_customercode_unique` (`customerCode`);

--
-- Indices de la tabla `debits`
--
ALTER TABLE `debits`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `deposits`
--
ALTER TABLE `deposits`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `events`
--
ALTER TABLE `events`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `expenses`
--
ALTER TABLE `expenses`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `facilities`
--
ALTER TABLE `facilities`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `facilities_reserves`
--
ALTER TABLE `facilities_reserves`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `funds`
--
ALTER TABLE `funds`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `funds_code_unique` (`code`);

--
-- Indices de la tabla `logs`
--
ALTER TABLE `logs`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `measured_consumptions`
--
ALTER TABLE `measured_consumptions`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `menus`
--
ALTER TABLE `menus`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `menus_link_unique` (`link`);

--
-- Indices de la tabla `menutypes`
--
ALTER TABLE `menutypes`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `owners`
--
ALTER TABLE `owners`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `pay_expenses`
--
ALTER TABLE `pay_expenses`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `profiles`
--
ALTER TABLE `profiles`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `providers`
--
ALTER TABLE `providers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `providers_code_unique` (`code`);

--
-- Indices de la tabla `quotas`
--
ALTER TABLE `quotas`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `quotas_code_unique` (`code`);

--
-- Indices de la tabla `repairs`
--
ALTER TABLE `repairs`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `residences`
--
ALTER TABLE `residences`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `tenants`
--
ALTER TABLE `tenants`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- Indices de la tabla `vehicles`
--
ALTER TABLE `vehicles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `vehicles_code_unique` (`code`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `account_payables`
--
ALTER TABLE `account_payables`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `aplications`
--
ALTER TABLE `aplications`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `banks`
--
ALTER TABLE `banks`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `budgetsold`
--
ALTER TABLE `budgetsold`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `budget_expenditures`
--
ALTER TABLE `budget_expenditures`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `budget_incomes`
--
ALTER TABLE `budget_incomes`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `companies`
--
ALTER TABLE `companies`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `condominias`
--
ALTER TABLE `condominias`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `condominia_quotas`
--
ALTER TABLE `condominia_quotas`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT de la tabla `condominia_types`
--
ALTER TABLE `condominia_types`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `controlpermissions`
--
ALTER TABLE `controlpermissions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `customers`
--
ALTER TABLE `customers`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `debits`
--
ALTER TABLE `debits`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `deposits`
--
ALTER TABLE `deposits`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT de la tabla `events`
--
ALTER TABLE `events`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `expenses`
--
ALTER TABLE `expenses`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `facilities`
--
ALTER TABLE `facilities`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `facilities_reserves`
--
ALTER TABLE `facilities_reserves`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `funds`
--
ALTER TABLE `funds`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `logs`
--
ALTER TABLE `logs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1099;

--
-- AUTO_INCREMENT de la tabla `measured_consumptions`
--
ALTER TABLE `measured_consumptions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `menus`
--
ALTER TABLE `menus`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Id key', AUTO_INCREMENT=62;

--
-- AUTO_INCREMENT de la tabla `menutypes`
--
ALTER TABLE `menutypes`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Id key', AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=47;

--
-- AUTO_INCREMENT de la tabla `owners`
--
ALTER TABLE `owners`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `pay_expenses`
--
ALTER TABLE `pay_expenses`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `profiles`
--
ALTER TABLE `profiles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Id key', AUTO_INCREMENT=174;

--
-- AUTO_INCREMENT de la tabla `providers`
--
ALTER TABLE `providers`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `quotas`
--
ALTER TABLE `quotas`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `repairs`
--
ALTER TABLE `repairs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `residences`
--
ALTER TABLE `residences`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `tenants`
--
ALTER TABLE `tenants`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `vehicles`
--
ALTER TABLE `vehicles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
