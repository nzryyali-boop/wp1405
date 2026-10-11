-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Oct 11, 2026 at 07:42 PM
-- Server version: 11.4.13-MariaDB
-- PHP Version: 8.4.25

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `ir123486_wp1405`
--

-- --------------------------------------------------------

--
-- Table structure for table `attendance`
--

CREATE TABLE `attendance` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `shift_id` bigint(20) UNSIGNED NOT NULL,
  `personnel_id` bigint(20) UNSIGNED NOT NULL,
  `status` enum('present','absent','leave','sick','mission','disciplinary','other') NOT NULL,
  `note` varchar(500) DEFAULT NULL,
  `recorded_by` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `audit_logs`
--

CREATE TABLE `audit_logs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `action` varchar(120) NOT NULL,
  `entity_type` varchar(100) DEFAULT NULL,
  `entity_id` bigint(20) UNSIGNED DEFAULT NULL,
  `details` text DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `audit_logs`
--

INSERT INTO `audit_logs` (`id`, `user_id`, `action`, `entity_type`, `entity_id`, `details`, `ip_address`, `created_at`) VALUES
(1, 1, 'login', NULL, NULL, NULL, '5.123.110.180', '2026-10-10 16:15:40'),
(2, 1, 'login', NULL, NULL, NULL, '5.123.65.240', '2026-10-11 15:36:57');

-- --------------------------------------------------------

--
-- Table structure for table `equipment`
--

CREATE TABLE `equipment` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `equipment_code` varchar(80) NOT NULL,
  `name` varchar(160) NOT NULL,
  `project_id` bigint(20) UNSIGNED DEFAULT NULL,
  `site_id` bigint(20) UNSIGNED DEFAULT NULL,
  `ownership` enum('owned','contractor') NOT NULL DEFAULT 'owned',
  `work_mode` enum('hourly','service','both') NOT NULL DEFAULT 'both',
  `is_active` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `equipment_eligible_drivers`
--

CREATE TABLE `equipment_eligible_drivers` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `equipment_id` bigint(20) UNSIGNED NOT NULL,
  `personnel_id` bigint(20) UNSIGNED NOT NULL,
  `is_primary` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `job_groups`
--

CREATE TABLE `job_groups` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(120) NOT NULL,
  `color` varchar(20) NOT NULL DEFAULT '#dbeafe',
  `is_active` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `job_groups`
--

INSERT INTO `job_groups` (`id`, `name`, `color`, `is_active`) VALUES
(1, 'راننده کامیون', '#d9f2d9', 1),
(2, 'راننده بیل مکانیکی', '#fff0b3', 1),
(3, 'راننده لودر', '#e2f0d9', 1),
(4, 'کنترل و سایر', '#e9ddff', 1);

-- --------------------------------------------------------

--
-- Table structure for table `load_ids`
--

CREATE TABLE `load_ids` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `code` varchar(60) NOT NULL,
  `title` varchar(160) NOT NULL,
  `origin` varchar(160) DEFAULT NULL,
  `destination` varchar(160) DEFAULT NULL,
  `tariff` decimal(14,2) NOT NULL DEFAULT 0.00,
  `notes` varchar(500) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `monthly_closures`
--

CREATE TABLE `monthly_closures` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `project_id` bigint(20) UNSIGNED NOT NULL,
  `year_number` smallint(5) UNSIGNED NOT NULL,
  `month_number` tinyint(3) UNSIGNED NOT NULL,
  `closed_by` bigint(20) UNSIGNED DEFAULT NULL,
  `closed_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `personnel`
--

CREATE TABLE `personnel` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `personnel_code` varchar(60) NOT NULL,
  `national_id` varchar(20) DEFAULT NULL,
  `first_name` varchar(100) NOT NULL,
  `last_name` varchar(100) NOT NULL,
  `job_group_id` bigint(20) UNSIGNED DEFAULT NULL,
  `default_project_id` bigint(20) UNSIGNED DEFAULT NULL,
  `default_site_id` bigint(20) UNSIGNED DEFAULT NULL,
  `shift_group` enum('A','B','C') DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `personnel`
--

INSERT INTO `personnel` (`id`, `personnel_code`, `national_id`, `first_name`, `last_name`, `job_group_id`, `default_project_id`, `default_site_id`, `shift_group`, `is_active`) VALUES
(1, '507', NULL, 'امیر گوهری', '.', 1, 1, 5, 'C', 1),
(2, '1951', NULL, 'محسن عباسلو', '.', 1, 1, 5, 'C', 1),
(3, '287', NULL, 'محمدرضا خواجوئي نژاد', '.', 1, 1, 5, 'C', 1),
(4, '291', NULL, 'حامد  حسینی گیسمونی', '.', 1, 1, 5, 'C', 1),
(5, '2312', NULL, 'مسلم موسی پورسیاه جل', '.', 1, 1, 5, 'C', 1),
(6, '449', NULL, 'احمد جهانشاهی', '.', 1, 3, 9, 'C', 1),
(7, '1226', NULL, 'محمود پورخسروانی', '.', 1, 3, 9, 'C', 1),
(8, '503', NULL, 'محمد جواد صفی پور', '.', 1, 2, 7, 'C', 1),
(9, '3851', NULL, 'وحید علیرضایی', '.', 1, 2, 7, 'C', 1),
(10, '120', NULL, 'مجید زید آبادی', '.', 1, 1, 5, 'C', 1),
(11, '1130', NULL, 'مصطفی شهبا', '.', 1, 1, 5, 'C', 1),
(12, '1223', NULL, 'عنایت عباسلو', '.', 1, 1, 5, 'C', 1),
(13, '3044', NULL, 'میثم پور قاسمی رنجبر', '.', 1, 1, 5, 'C', 1),
(14, '1237', NULL, 'محمد حسین شرفی پور', '.', 1, 1, 5, 'C', 1),
(15, '589', NULL, 'امجد اسکندری نسب سیاهکوهی', '.', 1, 1, 5, 'C', 1),
(16, '1249', NULL, 'رضا شاه کرمی', '.', 1, 1, 5, 'C', 1),
(17, '182', NULL, 'علی قلندری کر', '.', 2, 1, 5, 'C', 1),
(18, '2655', NULL, 'علیرضا اسکندری', '.', 2, 1, 5, 'C', 1),
(19, '2664', NULL, 'محمد ساردویی نسب', '.', 2, 1, 5, 'C', 1),
(20, '2667', NULL, 'حجت ولی پور', '.', 2, 1, 5, 'C', 1),
(21, '2772', NULL, 'مهدی شیبانی', '.', 2, 1, 5, 'C', 1),
(22, '3260', NULL, 'مهرداد گرکانی', '.', 2, 1, 5, 'C', 1),
(23, '3315', NULL, 'محسن عزیزپور', '.', 2, 1, 5, 'C', 1),
(24, '2127', NULL, 'محمد شهزادپور', '.', 3, 1, 5, 'C', 1),
(25, '2139', NULL, 'رضا لطفی نژادسیرجانی', '.', 3, 1, 5, 'C', 1),
(26, '2183', NULL, 'مهدی خواجویی نژآد', '.', 3, 1, 5, 'C', 1),
(27, '160', NULL, 'مجتبی طغرلی نژاد', '.', 1, 1, 5, 'C', 1),
(28, '295', NULL, 'مهدی سلجوقی', '.', 1, 1, 5, 'C', 1),
(29, '543', NULL, 'روح الله بلوردی', '.', 1, 1, 5, 'C', 1),
(30, '548', NULL, 'امیر ملک قاسمی', '.', 1, 1, 5, 'C', 1),
(31, '581', NULL, 'عباس بالاهنگ', '.', 1, 1, 5, 'C', 1),
(32, '604', NULL, 'علی خواجوئی', '.', 1, 1, 5, 'C', 1),
(33, '1278', NULL, 'جلال سرحدی عسکری', '.', 1, 1, 5, 'C', 1),
(34, '1590', NULL, 'ابراهیم جهانشاهی افشار', '.', 1, 1, 5, 'C', 1),
(35, '1612', NULL, 'علی مکی آبادی', '.', 1, 1, 5, 'C', 1),
(36, '1614', NULL, 'مجید جعفر قلی پور', '.', 1, 1, 5, 'C', 1),
(37, '1775', NULL, 'مجتبی  محمدعلی نژاد', '.', 1, 1, 5, 'C', 1),
(38, '2175', NULL, 'سجاد حدیدی', '.', 1, 1, 5, 'C', 1),
(39, '2220', NULL, 'میثم گنبدکناری', '.', 1, 1, 5, 'C', 1),
(40, '2242', NULL, 'محمد کناری', '.', 1, 1, 5, 'C', 1),
(41, '2253', NULL, 'مهران وکیلی پورتکلو', '.', 1, 1, 5, 'C', 1),
(42, '2332', NULL, 'عباس آزادی پورقهستانی', '.', 1, 1, 5, 'C', 1),
(43, '2395', NULL, 'مهدی همدم', '.', 1, 1, 5, 'C', 1),
(44, '2402', NULL, 'رضا شهریاری پور', '.', 1, 1, 5, 'C', 1),
(45, '2407', NULL, 'سجاد صادقی پور', '.', 1, 1, 5, 'C', 1),
(46, '2410', NULL, 'مهرداد گلزاری', '.', 1, 1, 5, 'C', 1),
(47, '2450', NULL, 'مسعود مداحی نیا', '.', 1, 1, 5, 'C', 1),
(48, '3026', NULL, 'محمد ده یادگاری', '.', 1, 1, 5, 'C', 1),
(49, '3147', NULL, 'حسن هاشمی نژاد', '.', 1, 1, 5, 'C', 1),
(50, '3155', NULL, 'حسن بیگلری', '.', 1, 1, 5, 'C', 1),
(51, '3157', NULL, 'امیر اسمعیلی نژاد', '.', 1, 1, 5, 'C', 1),
(52, '3241', NULL, 'فرهاد عمادآبادی', '.', 1, 1, 5, 'C', 1),
(53, '3263', NULL, 'مجتبی مکی آبادی', '.', 1, 1, 5, 'C', 1),
(54, '3274', NULL, 'سید هادی رضوی نسب', '.', 1, 1, 5, 'C', 1),
(55, '3485', NULL, 'مسعود سعیدی', '.', 1, 1, 5, 'C', 1),
(56, '6462', NULL, 'هادی محیاپور', '.', 1, 1, 5, 'C', 1),
(57, '7322', NULL, 'عباس هلیرودی', '.', 1, 1, 5, 'C', 1),
(58, '7723', NULL, 'مصطفی قاسمی نژاد', '.', 1, 1, 5, 'C', 1),
(59, '7730', NULL, 'احسان اسفندیارپور', '.', 1, 1, 5, 'C', 1),
(60, '8364', NULL, 'محمد شول', '.', 1, 1, 5, 'C', 1),
(61, '8386', NULL, 'حسین شیبانی', '.', 1, 1, 5, 'C', 1),
(62, '8521', NULL, 'علی قدوسی', '.', 1, 1, 5, 'C', 1),
(63, '8614', NULL, 'وحید عوض پور', '.', 1, 1, 5, 'C', 1),
(64, '8615', NULL, 'اباذر عباسی', '.', 1, 1, 5, 'C', 1),
(65, '8664', NULL, 'وحید اسد پور', '.', 1, 1, 5, 'C', 1),
(66, '1102', NULL, 'علیرضا قاسمی نژادراینی', '.', 3, 3, 9, 'C', 1),
(67, '2106', NULL, 'سعید اشرف زاده افشار', '.', 3, 3, 9, 'C', 1),
(68, '2109', NULL, 'ناصر ارجمندقهستانی', '.', 3, 3, 9, 'C', 1),
(69, '2122', NULL, 'حمید گلزاری', '.', 3, 3, 9, 'C', 1),
(70, '2248', NULL, 'ایمان آب دار', '.', 3, 3, 9, 'C', 1),
(71, '2422', NULL, 'محمدرضا قاسمی نژادرائینی', '.', 3, 3, 9, 'C', 1),
(72, '2487', NULL, 'مسلم برزه', '.', 3, 3, 9, 'C', 1),
(73, '3336', NULL, 'ابوالفضل نصرت آبادی', '.', 3, 3, 9, 'C', 1),
(74, '3379', NULL, 'رضا میرشکارپور', '.', 3, 3, 9, 'C', 1),
(75, '3389', NULL, 'امیر نجمی نژاد', '.', 3, 3, 9, 'C', 1),
(76, '3405', NULL, 'حسین علی پور لری', '.', 3, 3, 9, 'C', 1),
(77, '7597', NULL, 'امیر حسین بیگلری پناهی', '.', 3, 3, 9, 'C', 1),
(78, '7757', NULL, 'مهدی نقدی فر', '.', 3, 3, 9, 'C', 1),
(79, '504', NULL, 'حمید عزت ابادی', '.', 1, 3, 9, 'C', 1),
(80, '1179', NULL, 'خسرو حاج ابراهیمی', '.', 1, 3, 9, 'C', 1),
(81, '1490', NULL, 'امین غضنفری', '.', 1, 3, 9, 'C', 1),
(82, '1762', NULL, 'محمدعلی تقی زاده پیکری', '.', 1, 3, 9, 'C', 1),
(83, '2176', NULL, 'سیدایمان خاکساری', '.', 1, 3, 9, 'C', 1),
(84, '2177', NULL, 'مسلم ایل نشین', '.', 1, 3, 9, 'C', 1),
(85, '2205', NULL, 'عباس شماعی زاده', '.', 1, 3, 9, 'C', 1),
(86, '2207', NULL, 'محمود جهانشاهی نسب', '.', 1, 3, 9, 'C', 1),
(87, '2217', NULL, 'روح الله عباسی قرائی', '.', 1, 3, 9, 'C', 1),
(88, '2327', NULL, 'وحید عباسلو', '.', 1, 3, 9, 'C', 1),
(89, '2394', NULL, 'کاظم صالحی', '.', 1, 3, 9, 'C', 1),
(90, '2409', NULL, 'حسن پژگان', '.', 1, 3, 9, 'C', 1),
(91, '2411', NULL, 'علیرضا شریفی', '.', 1, 3, 9, 'C', 1),
(92, '2511', NULL, 'مهدی حمزه نژاد', '.', 1, 3, 9, 'C', 1),
(93, '3047', NULL, 'حسن پورجعفرآبادی', '.', 1, 3, 9, 'C', 1),
(94, '3079', NULL, 'علی سالاری', '.', 1, 3, 9, 'C', 1),
(95, '3185', NULL, 'احمد موسی پور', '.', 1, 3, 9, 'C', 1),
(96, '3476', NULL, 'رامین افرومند', '.', 1, 3, 9, 'C', 1),
(97, '3478', NULL, 'غلامرضا سرحدی', '.', 1, 3, 9, 'C', 1),
(98, '3706', NULL, 'علی رضا سالاری', '.', 1, 3, 9, 'C', 1),
(99, '3815', NULL, 'سید امین فاقعی', '.', 1, 3, 9, 'C', 1),
(100, '4639', NULL, 'اسماعیل دهقانی', '.', 1, 3, 9, 'C', 1),
(101, '4738', NULL, 'محمد سالاری', '.', 1, 3, 9, 'C', 1),
(102, '6345', NULL, 'اصغر جهانجاتی', '.', 1, 3, 9, 'C', 1),
(103, '7306', NULL, 'شهرام حسن ‍‍پور', '.', 1, 3, 9, 'C', 1),
(104, '7789', NULL, 'سید حامد ایرانژاد', '.', 1, 3, 9, 'C', 1),
(105, '8622', NULL, 'جواد مهیاپور', '.', 1, 3, 9, 'C', 1),
(106, '8674', NULL, 'علی سالاری', '.', 1, 3, 9, 'C', 1),
(107, '8948', NULL, 'علی اصغر حق گوی', '.', 1, 3, 9, 'C', 1),
(108, '8982', NULL, 'علیرضا اتحادی', '.', 1, 3, 9, 'C', 1),
(109, '8601', NULL, 'سعید اباذری', '.', 1, 3, 9, 'C', 1),
(110, '8624', NULL, 'محمد رسول قیاسی زاده', '.', 1, 3, 9, 'C', 1),
(111, '8659', NULL, 'امین خنجر پور', '.', 1, 3, 9, 'C', 1),
(112, '8970', NULL, 'مهدی بشیر خباز', '.', 1, 3, 9, 'C', 1),
(113, '2125', NULL, 'یاور عباسی قرائی', '.', 3, 2, 7, 'C', 1),
(114, '2254', NULL, 'رضا نورمندی پور', '.', 3, 2, 7, 'C', 1),
(115, '2449', NULL, 'محمدرضا پورگهردی', '.', 3, 2, 7, 'C', 1),
(116, '3390', NULL, 'نادر جهانشاهی', '.', 3, 2, 7, 'C', 1),
(117, '3395', NULL, 'حسام نجمیان', '.', 3, 2, 7, 'C', 1),
(118, '7599', NULL, 'مسلم رجبی پور', '.', 3, 2, 7, 'C', 1),
(119, '1212', NULL, 'جواد محمودآبادی', '.', 1, 2, 7, 'C', 1),
(120, '2310', NULL, 'مصطفی شهسواری گوغری', '.', 1, 2, 7, 'C', 1),
(121, '3040', NULL, 'محمد مددی زاده', '.', 1, 2, 7, 'C', 1),
(122, '3126', NULL, 'یاسر مظفری', '.', 1, 2, 7, 'C', 1),
(123, '3127', NULL, 'حسن اسکندری', '.', 1, 2, 7, 'C', 1),
(124, '3158', NULL, 'امین فتحی زاده', '.', 1, 2, 7, 'C', 1),
(125, '3180', NULL, 'فرشید قاسمی', '.', 1, 2, 7, 'C', 1),
(126, '7495', NULL, 'امین نورمندی پور', '.', 1, 2, 7, 'C', 1),
(127, '7515', NULL, 'افشین کاشانی', '.', 1, 2, 7, 'C', 1),
(128, '7745', NULL, 'ایمان سالاری', '.', 1, 2, 7, 'C', 1),
(129, '8068', NULL, 'مصلح زارع', '.', 1, 2, 7, 'C', 1),
(130, '8119', NULL, 'سید محسن موسوی', '.', 1, 2, 7, 'C', 1),
(131, '8244', NULL, 'سهیل اسماعیل زاده', '.', 1, 2, 7, 'C', 1),
(132, '8989', NULL, 'محسن انیسه', '.', 1, 2, 7, 'C', 1);

-- --------------------------------------------------------

--
-- Table structure for table `projects`
--

CREATE TABLE `projects` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(160) NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `projects`
--

INSERT INTO `projects` (`id`, `name`, `is_active`) VALUES
(1, 'گل‌ گهر', 1),
(2, 'جهان فولاد', 1),
(3, 'توسعه آهن', 1);

-- --------------------------------------------------------

--
-- Table structure for table `shifts`
--

CREATE TABLE `shifts` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `project_id` bigint(20) UNSIGNED NOT NULL,
  `shift_group` enum('A','B','C') NOT NULL,
  `shift_type` enum('day','night') NOT NULL,
  `shift_date` date NOT NULL COMMENT 'Persian date should be converted by application; night shift date is start date',
  `starts_at` datetime NOT NULL,
  `ends_at` datetime NOT NULL,
  `supervisor_user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `status` enum('open','closed') NOT NULL DEFAULT 'open',
  `closed_at` datetime DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sites`
--

CREATE TABLE `sites` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `project_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(160) NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sites`
--

INSERT INTO `sites` (`id`, `project_id`, `name`, `is_active`) VALUES
(5, 1, 'گل گهر', 1),
(7, 2, 'جهان فولاد', 1),
(9, 3, 'توسعه آهن', 1);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `username` varchar(80) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `full_name` varchar(160) NOT NULL,
  `role` enum('admin','shift_supervisor','manager','deputy','president','employee') NOT NULL DEFAULT 'employee',
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `failed_attempts` int(11) NOT NULL DEFAULT 0,
  `locked_until` datetime DEFAULT NULL,
  `last_login_at` datetime DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `password_hash`, `full_name`, `role`, `is_active`, `failed_attempts`, `locked_until`, `last_login_at`, `created_at`) VALUES
(1, 'admin', '$2y$10$lOI06o0j42m9v/puI05e7OHppSJJEv/wd6CofBWyGOS1mtCA9ubsy', 'مدیر سامانه', 'admin', 1, 0, NULL, '2026-10-11 19:06:57', '2026-10-10 16:14:49');

-- --------------------------------------------------------

--
-- Table structure for table `work_entries`
--

CREATE TABLE `work_entries` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `shift_id` bigint(20) UNSIGNED NOT NULL,
  `personnel_id` bigint(20) UNSIGNED NOT NULL,
  `equipment_id` bigint(20) UNSIGNED DEFAULT NULL,
  `work_mode` enum('hourly','service') NOT NULL,
  `productive_hours` decimal(5,2) NOT NULL DEFAULT 0.00,
  `performance_score` tinyint(3) UNSIGNED DEFAULT NULL,
  `description` varchar(500) DEFAULT NULL,
  `recorded_by` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `work_services`
--

CREATE TABLE `work_services` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `work_entry_id` bigint(20) UNSIGNED NOT NULL,
  `load_id` bigint(20) UNSIGNED NOT NULL,
  `service_count` decimal(10,2) NOT NULL DEFAULT 0.00
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `work_stoppages`
--

CREATE TABLE `work_stoppages` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `work_entry_id` bigint(20) UNSIGNED NOT NULL,
  `hours` decimal(5,2) NOT NULL DEFAULT 0.00,
  `reason` enum('repair','other') NOT NULL DEFAULT 'other',
  `description` varchar(500) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `attendance`
--
ALTER TABLE `attendance`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_shift_person` (`shift_id`,`personnel_id`),
  ADD KEY `personnel_id` (`personnel_id`),
  ADD KEY `recorded_by` (`recorded_by`);

--
-- Indexes for table `audit_logs`
--
ALTER TABLE `audit_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `idx_audit_created` (`created_at`);

--
-- Indexes for table `equipment`
--
ALTER TABLE `equipment`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `equipment_code` (`equipment_code`),
  ADD KEY `project_id` (`project_id`),
  ADD KEY `site_id` (`site_id`);

--
-- Indexes for table `equipment_eligible_drivers`
--
ALTER TABLE `equipment_eligible_drivers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_equipment_driver` (`equipment_id`,`personnel_id`),
  ADD KEY `personnel_id` (`personnel_id`);

--
-- Indexes for table `job_groups`
--
ALTER TABLE `job_groups`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `load_ids`
--
ALTER TABLE `load_ids`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `code` (`code`);

--
-- Indexes for table `monthly_closures`
--
ALTER TABLE `monthly_closures`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_project_month` (`project_id`,`year_number`,`month_number`),
  ADD KEY `closed_by` (`closed_by`);

--
-- Indexes for table `personnel`
--
ALTER TABLE `personnel`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personnel_code` (`personnel_code`),
  ADD KEY `job_group_id` (`job_group_id`),
  ADD KEY `default_project_id` (`default_project_id`);

--
-- Indexes for table `projects`
--
ALTER TABLE `projects`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `shifts`
--
ALTER TABLE `shifts`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_project_shift` (`project_id`,`shift_group`,`shift_type`,`shift_date`),
  ADD KEY `supervisor_user_id` (`supervisor_user_id`);

--
-- Indexes for table `sites`
--
ALTER TABLE `sites`
  ADD PRIMARY KEY (`id`),
  ADD KEY `project_id` (`project_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indexes for table `work_entries`
--
ALTER TABLE `work_entries`
  ADD PRIMARY KEY (`id`),
  ADD KEY `shift_id` (`shift_id`),
  ADD KEY `personnel_id` (`personnel_id`),
  ADD KEY `equipment_id` (`equipment_id`),
  ADD KEY `recorded_by` (`recorded_by`);

--
-- Indexes for table `work_services`
--
ALTER TABLE `work_services`
  ADD PRIMARY KEY (`id`),
  ADD KEY `work_entry_id` (`work_entry_id`),
  ADD KEY `load_id` (`load_id`);

--
-- Indexes for table `work_stoppages`
--
ALTER TABLE `work_stoppages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `work_entry_id` (`work_entry_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `attendance`
--
ALTER TABLE `attendance`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `audit_logs`
--
ALTER TABLE `audit_logs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `equipment`
--
ALTER TABLE `equipment`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `equipment_eligible_drivers`
--
ALTER TABLE `equipment_eligible_drivers`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `job_groups`
--
ALTER TABLE `job_groups`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `load_ids`
--
ALTER TABLE `load_ids`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `monthly_closures`
--
ALTER TABLE `monthly_closures`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `personnel`
--
ALTER TABLE `personnel`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=133;

--
-- AUTO_INCREMENT for table `projects`
--
ALTER TABLE `projects`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `shifts`
--
ALTER TABLE `shifts`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `sites`
--
ALTER TABLE `sites`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `work_entries`
--
ALTER TABLE `work_entries`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `work_services`
--
ALTER TABLE `work_services`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `work_stoppages`
--
ALTER TABLE `work_stoppages`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `attendance`
--
ALTER TABLE `attendance`
  ADD CONSTRAINT `attendance_ibfk_1` FOREIGN KEY (`shift_id`) REFERENCES `shifts` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `attendance_ibfk_2` FOREIGN KEY (`personnel_id`) REFERENCES `personnel` (`id`),
  ADD CONSTRAINT `attendance_ibfk_3` FOREIGN KEY (`recorded_by`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `audit_logs`
--
ALTER TABLE `audit_logs`
  ADD CONSTRAINT `audit_logs_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `equipment`
--
ALTER TABLE `equipment`
  ADD CONSTRAINT `equipment_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `equipment_ibfk_2` FOREIGN KEY (`site_id`) REFERENCES `sites` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `equipment_eligible_drivers`
--
ALTER TABLE `equipment_eligible_drivers`
  ADD CONSTRAINT `equipment_eligible_drivers_ibfk_1` FOREIGN KEY (`equipment_id`) REFERENCES `equipment` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `equipment_eligible_drivers_ibfk_2` FOREIGN KEY (`personnel_id`) REFERENCES `personnel` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `monthly_closures`
--
ALTER TABLE `monthly_closures`
  ADD CONSTRAINT `monthly_closures_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`),
  ADD CONSTRAINT `monthly_closures_ibfk_2` FOREIGN KEY (`closed_by`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `personnel`
--
ALTER TABLE `personnel`
  ADD CONSTRAINT `personnel_ibfk_1` FOREIGN KEY (`job_group_id`) REFERENCES `job_groups` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `personnel_ibfk_2` FOREIGN KEY (`default_project_id`) REFERENCES `projects` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `shifts`
--
ALTER TABLE `shifts`
  ADD CONSTRAINT `shifts_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`),
  ADD CONSTRAINT `shifts_ibfk_2` FOREIGN KEY (`supervisor_user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `sites`
--
ALTER TABLE `sites`
  ADD CONSTRAINT `sites_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`);

--
-- Constraints for table `work_entries`
--
ALTER TABLE `work_entries`
  ADD CONSTRAINT `work_entries_ibfk_1` FOREIGN KEY (`shift_id`) REFERENCES `shifts` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `work_entries_ibfk_2` FOREIGN KEY (`personnel_id`) REFERENCES `personnel` (`id`),
  ADD CONSTRAINT `work_entries_ibfk_3` FOREIGN KEY (`equipment_id`) REFERENCES `equipment` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `work_entries_ibfk_4` FOREIGN KEY (`recorded_by`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `work_services`
--
ALTER TABLE `work_services`
  ADD CONSTRAINT `work_services_ibfk_1` FOREIGN KEY (`work_entry_id`) REFERENCES `work_entries` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `work_services_ibfk_2` FOREIGN KEY (`load_id`) REFERENCES `load_ids` (`id`);

--
-- Constraints for table `work_stoppages`
--
ALTER TABLE `work_stoppages`
  ADD CONSTRAINT `work_stoppages_ibfk_1` FOREIGN KEY (`work_entry_id`) REFERENCES `work_entries` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
