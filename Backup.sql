-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Jul 20, 2024 at 02:33 PM
-- Server version: 8.0.37-0ubuntu0.22.04.3
-- PHP Version: 8.3.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `mnev2`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`hacker`@`localhost` PROCEDURE `GenerateUniqueUserCode` (OUT `code` VARCHAR(4))   BEGIN
    DECLARE newCode VARCHAR(4);
    DECLARE isUnique BOOLEAN DEFAULT FALSE;

    WHILE isUnique = FALSE DO
        SET newCode = LPAD(FLOOR(RAND() * 9000) + 1000, 4, "0");
        SELECT NOT EXISTS(
            SELECT 1 FROM users WHERE UserCode = newCode
        ) INTO isUnique;
    END WHILE;

    SET code = newCode;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `cache`
--

CREATE TABLE `cache` (
  `key` varchar(255) NOT NULL,
  `value` mediumtext NOT NULL,
  `expiration` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cache_locks`
--

CREATE TABLE `cache_locks` (
  `key` varchar(255) NOT NULL,
  `owner` varchar(255) NOT NULL,
  `expiration` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `entities`
--

CREATE TABLE `entities` (
  `id` bigint UNSIGNED NOT NULL,
  `Entity` varchar(255) NOT NULL,
  `EntityID` varchar(255) NOT NULL,
  `EntityProjectDetails` text NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `entities`
--

INSERT INTO `entities` (`id`, `Entity`, `EntityID`, `EntityProjectDetails`, `created_at`, `updated_at`) VALUES
(2, 'Ethiopia', 'fdb7f1f1cf5742d85b34d5bdf2e5e3c0', 'MPA ENTITY', '2024-07-03 05:34:08', '2024-07-03 05:34:08'),
(4, 'STP', '94a8a9c32a22811040c5eafadeb698fe', 'MPA ENTITY', '2024-07-03 10:03:28', '2024-07-03 10:03:28'),
(5, 'DRC', 'cf647582323c0f9a767a3149cfda960f', 'MPA ENTITY', '2024-07-03 10:04:31', '2024-07-03 10:04:31'),
(6, 'Rwanda', '26bc6cd17ef8f6d206f10eefd507fc3e', 'MPA ENTITY', '2024-07-03 10:04:50', '2024-07-03 10:04:50'),
(7, 'Burundi', '4eac152325738352f51e16046d3dbe7f', 'MPA ENTITY', '2024-07-03 10:05:30', '2024-07-03 10:05:30'),
(8, 'ECSA-HC', 'ac7eaa6a06a1b0e19eb41e5dbe224d58', 'MPA ENTITY', '2024-07-03 10:06:37', '2024-07-03 10:06:37'),
(9, 'IGAD', '7848dc358943f0c74dfe6a00f00fc8e1', 'MPA ENTITY', '2024-07-03 10:06:56', '2024-07-03 10:06:56'),
(10, 'Kenya', 'da1dbd6dadb88a7c3065bfc3df4f9edb', 'MPA ENTITY', '2024-07-03 10:07:29', '2024-07-03 10:07:29'),
(11, 'Zimbabwe', '254a49c3-9415-776e-d56a-7465a98442a3', 'Zimbabwe', NULL, NULL),
(12, 'Zambia', '54e4975e-0b8a-ba48-4004-f41cb949510e', 'Zambia', NULL, NULL),
(13, 'ss', 'ae2f3f3d-4120-d0c2-5697-8b0b75ba47cb', 'sss', NULL, NULL);

--
-- Triggers `entities`
--
DELIMITER $$
CREATE TRIGGER `before_insert_entities` BEFORE INSERT ON `entities` FOR EACH ROW BEGIN
    SET NEW.EntityID = CONCAT(
        SUBSTRING(MD5(RAND()), 1, 8), '-',
        SUBSTRING(MD5(RAND()), 1, 4), '-',
        SUBSTRING(MD5(RAND()), 1, 4), '-',
        SUBSTRING(MD5(RAND()), 1, 4), '-',
        SUBSTRING(MD5(RAND()), 1, 12)
    );
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint UNSIGNED NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `indicator_reports`
--

CREATE TABLE `indicator_reports` (
  `id` bigint UNSIGNED NOT NULL,
  `RID` varchar(255) NOT NULL,
  `IID` varchar(255) NOT NULL,
  `Entity` text NOT NULL,
  `ReportedBy` text,
  `Response` text NOT NULL,
  `Comments` text NOT NULL,
  `IndicatorResponsePercentageScore` varchar(200) NOT NULL,
  `ApprovalStatus` varchar(200) NOT NULL DEFAULT 'false',
  `ResponseType` varchar(200) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint UNSIGNED NOT NULL,
  `queue` varchar(255) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` tinyint UNSIGNED NOT NULL,
  `reserved_at` int UNSIGNED DEFAULT NULL,
  `available_at` int UNSIGNED NOT NULL,
  `created_at` int UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `job_batches`
--

CREATE TABLE `job_batches` (
  `id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `total_jobs` int NOT NULL,
  `pending_jobs` int NOT NULL,
  `failed_jobs` int NOT NULL,
  `failed_job_ids` longtext NOT NULL,
  `options` mediumtext,
  `cancelled_at` int DEFAULT NULL,
  `created_at` int NOT NULL,
  `finished_at` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(2, '0001_01_01_000001_create_cache_table', 1),
(3, '0001_01_01_000002_create_jobs_table', 1),
(4, '2024_07_08_174030_create_entities_table', 1),
(5, '2024_07_08_180525_create_indicator_reports_table', 2),
(7, '2024_07_08_212936_create_personal_access_tokens_table', 3),
(8, '2024_07_10_213621_create_reporting_timelines_table', 4),
(9, '2024_07_08_180611_create_project_indicators_table', 5),
(14, '0001_01_01_000000_create_users_table', 6);

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `project_indicators`
--

CREATE TABLE `project_indicators` (
  `id` bigint UNSIGNED NOT NULL,
  `IndicatorPrimaryCategory` varchar(255) DEFAULT NULL,
  `IndicatorSecondaryCategory` varchar(255) DEFAULT NULL,
  `EntityID` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `IID` varchar(255) NOT NULL,
  `Indicator` varchar(255) DEFAULT NULL,
  `IndicatorDefinition` varchar(255) NOT NULL,
  `IndicatorQuestion` varchar(255) NOT NULL,
  `RemarksComments` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `SourceOfData` varchar(255) DEFAULT NULL,
  `ResponseType` varchar(255) NOT NULL,
  `ReportingPeriod` varchar(200) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `project_indicators`
--

INSERT INTO `project_indicators` (`id`, `IndicatorPrimaryCategory`, `IndicatorSecondaryCategory`, `EntityID`, `IID`, `Indicator`, `IndicatorDefinition`, `IndicatorQuestion`, `RemarksComments`, `SourceOfData`, `ResponseType`, `ReportingPeriod`, `created_at`, `updated_at`) VALUES
(11, 'Regional Results Framework', 'Country Specific Intermediate Results Indicators', 'cf647582323c0f9a767a3149cfda960f', 'ac8f238f6bb7811defa5', 'sss', 'ss9999999999', 'AccountRoleAccountRole', 'AccountRole', NULL, 'Text', 'Bi-Annual Report', NULL, NULL),
(12, 'Country Results Framework', 'Country Specific Intermediate Results Indicators', 'cf647582323c0f9a767a3149cfda960f', '6868ed1883aec567883d', 'dkldkldkl', 'ss9999999999', 'hgghgg', 'jjhjhjjh', NULL, 'Percentage', 'Bi-Annual Report', NULL, NULL),
(13, 'Country Results Framework', 'Country Specific Intermediate Results Indicators', 'cf647582323c0f9a767a3149cfda960f', '066f776e1651b4e5b621', 'dkldkldkl', 'dkldkldkl', 'dkldkldkl', 'dkldkldkl', NULL, 'Percentage', 'Bi-Annual Report', NULL, NULL);

--
-- Triggers `project_indicators`
--
DELIMITER $$
CREATE TRIGGER `before_insert_project_indicators` BEFORE INSERT ON `project_indicators` FOR EACH ROW BEGIN
    SET NEW.IID = CONCAT(
        SUBSTRING(MD5(RAND()), 1, 8),
        SUBSTRING(MD5(RAND()), 1, 4),
        SUBSTRING(MD5(RAND()), 1, 4),
        SUBSTRING(MD5(RAND()), 1, 4)
    );
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `reporting_timelines`
--

CREATE TABLE `reporting_timelines` (
  `id` bigint UNSIGNED NOT NULL,
  `ReportName` varchar(255) NOT NULL,
  `Type` varchar(255) NOT NULL,
  `Description` varchar(255) NOT NULL,
  `ReportingID` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `Year` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `status` varchar(200) DEFAULT 'active'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `reporting_timelines`
--

INSERT INTO `reporting_timelines` (`id`, `ReportName`, `Type`, `Description`, `ReportingID`, `Year`, `created_at`, `updated_at`, `status`) VALUES
(5, 'Annual Report 2024', 'Annual Report', 'Annual Report 2024', 'f78f0f80-48df-67e6-1b61-4f2d3eefa771', 2024, NULL, NULL, 'Active'),
(6, 'Bi - Annual Report 2024 (July)', 'Bi-Annual Report', 'Bi - Annual Report 2024 (July)', '442f379c-28c3-a47c-4c2e-f6cb45796286', 2024, NULL, NULL, 'Active'),
(7, 'Bi - Annual Report 2024 (December)', 'Quarterly Report', 'Bi - Annual Report 2024 (December)', '2f84dd24-7aa1-6b7f-4130-052b0eec1867', 2024, NULL, NULL, 'active'),
(8, 'Quarter 1 report 2024', 'Quarterly Report', 'Quarter 1 report 2024', '5bc6cbf7-67c9-24ad-0511-d24e58023b1f', 2024, NULL, NULL, 'active'),
(9, 'Quarter 2 report 2024', 'Quarterly Report', 'Quarter 2 report 2024', '0c8195f1-6947-4930-8239-34cb488b6b7c', 2024, NULL, NULL, 'active'),
(10, 'Quarter 3 report 2024', 'Quarterly Report', 'Quarter 3 report 2024', 'df86fb09-ee39-0f85-2d49-08d0122e953a', 2024, NULL, NULL, 'active'),
(11, 'Quarter 4 report 2024', 'Quarterly Report', 'Quarter 4 report 2024', '99c37be6-6edf-6de5-3cb5-1066fb83ce43', 2024, NULL, NULL, 'active');

--
-- Triggers `reporting_timelines`
--
DELIMITER $$
CREATE TRIGGER `before_insert_reporting_timelines` BEFORE INSERT ON `reporting_timelines` FOR EACH ROW BEGIN
    SET NEW.RID = CONCAT(
        SUBSTRING(MD5(RAND()), 1, 8), '-',
        SUBSTRING(MD5(RAND()), 1, 4), '-',
        SUBSTRING(MD5(RAND()), 1, 4), '-',
        SUBSTRING(MD5(RAND()), 1, 4), '-',
        SUBSTRING(MD5(RAND()), 1, 12)
    );
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) NOT NULL,
  `user_id` bigint UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text,
  `payload` longtext NOT NULL,
  `last_activity` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('6iyq5EZYat5sGMYHBraM6er4XYCONA4Y1L0Efzo6', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/126.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiM2Z4SUJtb2M4U0tyZVVFM3B2UkI5d1J6OWx4bXFmQjMyam0xemdubyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1721291636),
('Pptql579omozE5GjIQmOqnvjBaUvIPfptXHCP5zw', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/126.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiMFdPRHp3MlZKM0lsQWpVd1pDZVkzV3RrVGQzSlJXM1g5N01GUXJnRCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1721239198);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `EntityID` varchar(255) DEFAULT NULL,
  `UserCode` varchar(255) DEFAULT NULL,
  `Phone` varchar(255) DEFAULT NULL,
  `Nationality` varchar(255) DEFAULT NULL,
  `PhoneNumber` varchar(255) DEFAULT NULL,
  `Address` varchar(255) DEFAULT NULL,
  `ParentOrganization` varchar(255) DEFAULT NULL,
  `Sex` varchar(255) DEFAULT NULL,
  `JobTitle` varchar(255) DEFAULT NULL,
  `AccountRole` varchar(255) DEFAULT NULL,
  `UserID` varchar(255) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `EntityID`, `UserCode`, `Phone`, `Nationality`, `PhoneNumber`, `Address`, `ParentOrganization`, `Sex`, `JobTitle`, `AccountRole`, `UserID`, `email`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
(9, 'Ayebare Timothy', NULL, '9702', '0786190179', 'Ugandan', '0786190179', 'Kampala, Uganda', 'HD Resouces LTD', 'Male', 'ICT', 'AdminAccount', '5edd5f893929066653b9', 'vexa256@gmail.com', NULL, NULL, NULL, NULL, NULL);

--
-- Triggers `users`
--
DELIMITER $$
CREATE TRIGGER `before_insert_user` BEFORE INSERT ON `users` FOR EACH ROW BEGIN
    CALL GenerateUniqueUserCode(NEW.UserCode);
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `before_insert_users` BEFORE INSERT ON `users` FOR EACH ROW BEGIN
    SET NEW.UserID = CONCAT(
        SUBSTRING(MD5(RAND()), 1, 8),
        SUBSTRING(MD5(RAND()), 1, 4),
        SUBSTRING(MD5(RAND()), 1, 4),
        SUBSTRING(MD5(RAND()), 1, 4)
    );
END
$$
DELIMITER ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cache`
--
ALTER TABLE `cache`
  ADD PRIMARY KEY (`key`);

--
-- Indexes for table `cache_locks`
--
ALTER TABLE `cache_locks`
  ADD PRIMARY KEY (`key`);

--
-- Indexes for table `entities`
--
ALTER TABLE `entities`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `indicator_reports`
--
ALTER TABLE `indicator_reports`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`);

--
-- Indexes for table `job_batches`
--
ALTER TABLE `job_batches`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indexes for table `project_indicators`
--
ALTER TABLE `project_indicators`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `reporting_timelines`
--
ALTER TABLE `reporting_timelines`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `entities`
--
ALTER TABLE `entities`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `indicator_reports`
--
ALTER TABLE `indicator_reports`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `project_indicators`
--
ALTER TABLE `project_indicators`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `reporting_timelines`
--
ALTER TABLE `reporting_timelines`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
