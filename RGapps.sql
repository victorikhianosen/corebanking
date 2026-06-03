-- phpMyAdmin SQL Dump
-- version 5.2.1deb3
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Mar 16, 2026 at 09:25 AM
-- Server version: 8.0.45-0ubuntu0.24.04.1
-- PHP Version: 8.3.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `RGapps`
--

-- --------------------------------------------------------

--
-- Table structure for table `accountofficers`
--

CREATE TABLE `accountofficers` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `branch_id` bigint UNSIGNED DEFAULT NULL,
  `full_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `gender` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `accountofficers`
--

INSERT INTO `accountofficers` (`id`, `user_id`, `branch_id`, `full_name`, `email`, `gender`, `phone`, `address`, `created_at`, `updated_at`) VALUES
(1, 10, 1, 'Bolaji Lawal', 'bola@gmail.com', 'male', '090', '33 fanikayode', '2023-06-29 09:04:17', '2023-06-29 09:05:30'),
(2, 11, 1, 'Babalola Abimbola', 'bimbola@richgreenmasters.com', 'female', '09081560490', 'IKEJA GRA,LAGOS', '2023-06-29 11:53:15', '2023-06-29 11:53:15'),
(3, 13, 1, 'Seowu Timilehin', 'timilehin@richgreenmasters.com', 'Female', '07087850170', 'IKEJA GRA,LAGOS', '2023-06-29 13:04:54', '2023-06-29 13:04:54'),
(4, 14, 1, 'Opakunle Chika', 'chika@richgreenmasters.com', 'female', '08169039281', 'IKEJA,GR LAGOS', '2023-06-29 13:05:36', '2023-06-29 13:05:36'),
(5, 15, 1, 'Afor Esther', 'esther@richgreenmasters.com', 'female', '08030979751', 'IKEJA GRA,LAGOS', '2023-06-29 13:06:09', '2023-06-30 13:46:01'),
(6, 16, 1, 'Emeka Gloria', 'gloria@richgreenmasters.com', 'female', '08030979751', 'IKEJA GRA, LAGOS', '2023-06-29 13:06:39', '2023-06-29 13:06:39'),
(7, 17, 1, 'Agboola Muyiwa', 'muyiwaagbogba@richgreenmasters.com', 'male', '08033529203', 'IKEJA GRA,LAGOS', '2023-06-29 13:07:12', '2023-07-15 14:15:03'),
(8, 18, 1, 'Adegbite Vincent', 'vincent@richgreenmasters.com', 'male', '08023059171', 'IKEJA GRA, LAGOS', '2023-06-29 13:09:49', '2023-06-29 13:09:49'),
(9, 19, 1, 'Olaoye Feyi', 'feyi@richgreenmasters.com', 'female', '08054477034', 'IKEJA GRA,LAGOS', '2023-06-29 13:10:31', '2023-06-29 13:10:31'),
(10, 21, 1, 'Yusuf Ayotunde', 'AYOTUNDEYUSUF@RICHGREENMASTERS.COM', 'male', '08066790618', 'ikeja gra,lagos', '2023-06-29 13:12:11', '2023-07-15 14:14:26'),
(11, 12, 1, 'Adebowale Mayowa', 'mayowaadebowale@richgreenmasters.com', 'male', '09070464329', 'IKEJA GRA,LAGOS', '2023-07-07 13:06:34', '2023-07-15 14:15:50'),
(12, 29, 1, 'Obazee Moses', 'Mosesobazee@richgreenmasters.com', 'male', '08086867353', '9, Younis Bashorun off Ajose Adeogun', '2025-03-21 13:58:44', '2025-03-21 13:58:44'),
(13, 28, 1, 'Abiodun Emmanuel', 'abiodunemmanuel@richgreenmasters.com', 'male', '08023758113', '9 YOUNIS BASHORUN STREET OFF AJOSE ADEOGUN ROAD V.I', '2025-03-21 14:01:59', '2025-10-14 09:09:43'),
(14, 22, 1, 'Odejimi Samuel', 'samuel@richgreenmasters.com', 'male', '08065259551', 'ikeja Gra, lagos', '2025-10-14 09:09:06', '2025-10-14 09:09:06');

-- --------------------------------------------------------

--
-- Table structure for table `account_categories`
--

CREATE TABLE `account_categories` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `account_categories`
--

INSERT INTO `account_categories` (`id`, `name`, `type`, `description`, `created_at`, `updated_at`) VALUES
(1, 'accounts receivable', 'asset', 'Accounts Receivable', '2023-01-10 23:29:11', '2023-01-10 23:29:11'),
(2, 'accounts payable', 'liability', 'Accounts Payable', '2023-01-10 23:32:04', '2023-01-10 23:32:04'),
(3, 'account closing', 'Income', 'Account closed income', '2023-01-10 23:32:42', '2023-01-10 23:32:42'),
(6, 'accrued interest receivable', 'asset', 'Accrued Interest Receivable', '2023-01-11 15:36:38', '2023-01-11 15:36:38'),
(7, 'accumulated depreciation', 'asset', 'Accumulated Depreciation', '2023-01-11 15:36:38', '2023-01-11 15:36:38'),
(8, 'advances under micro leases', 'asset', 'Advances Under Micro Leases', '2023-01-11 15:36:38', '2023-01-11 15:36:38'),
(10, 'bad debts written off', 'expense', 'Bad Debts Written Off', '2023-01-11 15:36:38', '2023-01-11 15:36:38'),
(11, 'balances with banks', 'asset', 'Balances With Banks', '2023-01-11 15:36:38', '2023-01-11 15:36:38'),
(12, 'bill discounted', 'asset', 'Bill Discounted', '2023-01-11 15:36:38', '2023-01-11 15:36:38'),
(13, 'bonus reserves', 'capital', 'Bonus Reserves', '2023-01-11 15:36:38', '2023-01-11 15:36:38'),
(14, 'borrowings on lending', 'liability', 'Borrowings On Lending', '2023-01-11 15:36:38', '2023-01-11 15:36:38'),
(15, 'capital', 'capital', 'Capital', '2023-01-11 15:36:38', '2023-01-11 15:36:38'),
(16, 'cash asset', 'asset', 'Cash Asset', '2023-01-11 15:36:38', '2023-01-11 15:36:38'),
(17, 'cash balances', 'asset', 'CASH ITEMS', '2023-01-11 15:36:38', '2023-01-11 15:36:38'),
(18, 'cheques for collection and transit items', 'asset', 'Cheques For Collection And Transit Items', '2023-01-11 15:36:38', '2023-01-11 15:36:38'),
(20, 'commission', 'income', 'Commission', '2023-01-11 15:36:38', '2023-01-11 15:36:38'),
(21, 'debenture loan stock', 'liability', 'Debenture Loan Stock', '2023-01-11 15:36:38', '2023-01-11 15:36:38'),
(22, 'deferred grantsa and donations reserves', 'capital', 'Deferred Grantsa And Donations Reserves', '2023-01-11 15:36:38', '2023-01-11 15:36:38'),
(23, 'demand deposits', 'liability', 'Demand Deposits', '2023-01-11 15:36:38', '2023-01-11 15:36:38'),
(24, 'deposit', 'liability', 'Deposit', '2023-01-11 15:36:38', '2023-01-11 15:36:38'),
(26, 'deposit for shares', 'liability', 'Deposit For Shares', '2023-03-25 10:14:49', '2023-03-25 10:14:49'),
(27, 'depreciation expense', 'expense', 'Depreciation', '2023-03-25 10:14:49', '2023-03-25 10:14:49'),
(29, 'directors', 'expense', 'Directors', '2023-03-25 10:14:49', '2023-03-25 10:14:49'),
(30, 'dividends payable', 'liability', 'Dividends Payable', '2023-03-25 10:14:49', '2023-03-25 10:14:49'),
(32, 'due from banks in nigeria', 'asset', 'Due From Banks In Nigeria', '2023-03-25 10:14:49', '2023-03-25 10:14:49'),
(33, 'due from placements', 'asset', 'Due From Placements', '2023-03-25 10:14:49', '2023-03-25 10:14:49'),
(34, 'expense', 'expense', 'Expense', '2023-03-25 10:14:49', '2023-03-25 10:14:49'),
(35, 'federal government', 'liability', 'Federal Government', '2023-03-25 10:14:49', '2023-03-25 10:14:49'),
(36, 'fees and charges', 'income', 'Fees And Charges', '2023-03-25 10:14:49', '2023-03-25 10:14:49'),
(39, 'fixed assets', 'asset', 'Fixed Assets', '2023-03-25 10:14:49', '2023-03-25 10:14:49'),
(40, 'foreign exchange', 'liability', 'Foreign exchange', '2023-03-25 10:14:49', '2023-07-25 12:16:10'),
(41, 'freehold land and building', 'asset', 'Freehold Land And Building', '2023-03-25 10:14:49', '2023-03-25 10:14:49'),
(42, 'furniture and fixtures', 'asset', 'Furniture And Fixtures', '2023-03-25 10:14:49', '2023-03-25 10:14:49'),
(43, 'general loan and lease loss provision', 'liability', 'General Loan And Lease Loss Provision', '2023-03-25 10:14:49', '2023-03-25 10:14:49'),
(44, 'general reserve', 'capital', 'General Reserve', '2023-03-25 10:14:49', '2023-03-25 10:14:49'),
(45, 'goodwill and other intangible assets', 'asset', 'Goodwill And Other Intangible Assets', '2023-03-25 10:14:49', '2023-03-25 10:14:49'),
(46, 'hire purchase', 'asset', 'Hire Purchase', '2023-03-25 10:14:49', '2023-03-25 10:14:49'),
(47, 'ict', 'expense', 'Overhead', '2023-03-25 10:14:49', '2023-03-25 10:14:49'),
(48, 'fx income', 'income', 'Income', '2023-03-25 10:14:49', '2025-05-26 14:39:36'),
(49, 'income from investments', 'income', 'Income From Investments', '2023-03-25 10:14:49', '2023-03-25 10:14:49'),
(50, 'increase in deposit for share', 'capital', 'INCREASE IN DEPOSIT FOR SHARE', '2023-03-25 10:14:49', '2023-03-25 10:14:49'),
(51, 'interest accrued not paid', 'liability', 'Interest Accrued Not Paid', '2023-03-25 10:14:49', '2023-03-25 10:14:49'),
(52, 'interest expense', 'expense', 'Interest Expense', '2023-03-25 10:14:49', '2023-03-25 10:14:49'),
(53, 'interest in suspense', 'liability', 'Interest In Suspense', '2023-03-25 10:14:49', '2023-03-25 10:14:49'),
(54, 'interest on loans and advances', 'income', 'Interest On Loans And Advances', '2023-03-25 10:14:49', '2023-03-25 10:14:49'),
(55, 'irredeemable debenture', 'liability', 'Irredeemable Debenture', '2023-03-25 10:14:49', '2023-03-25 10:14:49'),
(56, 'issued and fully paid up capital', 'capital', 'Issued And Fully Paid Up Capital', '2023-03-25 10:14:49', '2023-03-25 10:14:49'),
(57, 'leasehold land and building', 'asset', 'Leasehold Land And Building', '2023-03-25 10:14:49', '2023-03-25 10:14:49'),
(58, 'liability', 'liability', 'Liability', '2023-03-25 10:14:49', '2023-03-25 10:14:49'),
(59, 'loans and advances', 'asset', 'Loans And Advances And Leases', '2023-03-25 10:14:49', '2023-05-07 12:47:58'),
(60, 'local government', 'liability', 'Local Government', '2023-03-25 10:14:49', '2023-03-25 10:14:49'),
(61, 'long term investments', 'asset', 'Long Term Investments', '2023-03-25 10:14:49', '2023-03-25 10:14:49'),
(62, 'mandatory deposits', 'liability', 'Mandatory Deposits', '2023-03-25 10:14:49', '2023-03-25 10:14:49'),
(63, 'micro loans', 'asset', 'Micro Loans', '2023-03-25 10:14:49', '2023-03-25 10:14:49'),
(64, 'miscellaneous other assets', 'asset', 'Miscellaneous Other Assets', '2023-03-25 10:14:49', '2023-03-25 10:14:49'),
(65, 'miscellaneous other liabilities', 'liability', 'Miscellaneous Other Liabilities', '2023-03-25 10:14:49', '2023-03-25 10:14:49'),
(66, 'motor vehicles', 'asset', 'Motor Vehicles', '2023-03-25 10:14:49', '2023-03-25 10:14:49'),
(67, 'office equipment', 'asset', 'Office Equipment', '2023-03-25 10:14:49', '2023-03-25 10:14:49'),
(68, 'operating expenses', 'expense', 'Operating Expenses', '2023-03-25 10:14:49', '2023-03-25 10:14:49'),
(69, 'other assets', 'asset', 'Other Assets', '2023-03-25 10:14:49', '2023-03-25 10:14:49'),
(70, 'other borrowings', 'liability', 'Other Borrowings', '2023-03-25 10:14:49', '2023-03-25 10:14:49'),
(71, 'other deposits', 'liability', 'Other Deposits', '2023-03-25 10:14:49', '2023-03-25 10:14:49'),
(72, 'other income', 'income', 'Other Income', '2023-03-25 10:14:49', '2023-03-25 10:14:49'),
(73, 'other income from non financial services', 'income', 'Other Income From Non Financial Services', '2023-03-25 10:14:49', '2023-03-25 10:14:49'),
(74, 'other liabilities', 'liability', 'Other Liabilities', '2023-03-25 10:14:49', '2023-03-25 10:14:49'),
(75, 'other loans', 'asset', 'Other Loans', '2023-03-25 10:14:49', '2023-03-25 10:14:49'),
(76, 'other long term investments', 'asset', 'Other Long Term Investments', '2023-03-25 10:14:49', '2023-03-25 10:14:49'),
(77, 'other prepayments', 'asset', 'Other Prepayments', '2023-03-25 10:14:49', '2023-03-25 10:14:49'),
(78, 'other reserves', 'capital', 'Other Reserves', '2023-03-25 10:14:49', '2023-03-25 10:14:49'),
(79, 'other short term investments', 'asset', 'Other Short Term Investments', '2023-03-25 10:14:49', '2023-03-25 10:14:49'),
(80, 'overdrafts', 'asset', 'Overdrafts', '2023-03-25 10:14:49', '2023-03-25 10:14:49'),
(81, 'overheads', 'expense', 'Overheads', '2023-03-25 10:14:49', '2023-03-25 10:14:49'),
(82, 'penalties paid', 'expense', 'Penalties Paid', '2023-03-25 10:14:49', '2023-03-25 10:14:49'),
(83, 'petty cash', 'asset', 'PETTY CASH', '2023-03-25 10:14:49', '2023-03-25 10:14:49'),
(84, 'plant and machinery', 'asset', 'Plant And Machinery', '2023-03-25 10:14:49', '2023-03-25 10:14:49'),
(85, 'preference shares', 'capital', 'Preference Shares', '2023-03-25 10:14:49', '2023-03-25 10:14:49'),
(86, 'related parties group assets', 'asset', 'Related Parties Group Assets', '2023-03-25 10:14:49', '2025-09-23 11:42:13'),
(87, 'prepaid rent', 'asset', 'Prepaid Rent', '2023-03-25 10:14:49', '2023-03-25 10:14:49'),
(88, 'provision for bad debts', 'expense', 'Provision For Bad Debts', '2023-03-25 10:14:49', '2023-03-25 10:14:49'),
(89, 'provision for diminution in the value of investments', 'liability', 'Provision For Diminution In The Value Of Investments', '2023-03-25 10:14:49', '2023-03-25 10:14:49'),
(90, 'provision for losses on off balance sheet items', 'liability', 'Provision For Losses On Off Balance Sheet Items', '2023-03-25 10:14:49', '2023-03-25 10:14:49'),
(91, 'provision for losses on other assets', 'liability', 'Provision For Losses On Other Assets', '2023-03-25 10:14:49', '2023-03-25 10:14:49'),
(92, 'provision for other known losses', 'liability', 'Provision For Other Known Losses', '2023-03-25 10:14:49', '2023-03-25 10:14:49'),
(93, 'provision for taxation', 'liability', 'Provision For Taxation', '2023-03-25 10:14:49', '2023-03-25 10:14:49'),
(94, 'quoted companies', 'asset', 'Quoted Companies', '2023-03-25 10:14:49', '2023-03-25 10:14:49'),
(95, 'redeemable debenture', 'liability', 'Redeemable Debenture', '2023-03-25 10:14:49', '2023-03-25 10:14:49'),
(96, 'refinancing facilities', 'liability', 'Refinancing Facilities', '2023-03-25 10:14:49', '2023-03-25 10:14:49'),
(97, 'reserves', 'capital', 'Reserves', '2023-03-25 10:14:49', '2023-03-25 10:14:49'),
(98, 'retained profit or loss', 'capital', 'Retained Profit Or Loss', '2023-03-25 10:14:49', '2023-03-25 10:14:49'),
(99, 'revaluation reserves', 'capital', 'Revaluation Reserves', '2023-03-25 10:14:49', '2023-03-25 10:14:49'),
(100, 'secured with treasury bills', 'asset', 'Secured With Treasury Bills', '2023-03-25 10:14:49', '2023-03-25 10:14:49'),
(101, 'share premium', 'capital', 'Share Premium', '2023-03-25 10:14:49', '2023-03-25 10:14:49'),
(102, 'short term investments', 'asset', 'Short Term Investments', '2023-03-25 10:14:49', '2023-03-25 10:14:49'),
(104, 'small and medium enterprise loans', 'asset', 'Small And Medium Enterprise Loans', '2023-03-25 10:14:49', '2023-03-25 10:14:49'),
(105, 'specific loan and lease loss provision', 'liability', 'Specific Loan And Lease Loss Provision', '2023-03-25 10:14:49', '2023-03-25 10:14:49'),
(106, 'staff costs', 'expense', 'Staff Costs', '2023-03-25 10:14:49', '2023-03-25 10:14:49'),
(107, 'staff loans', 'asset', 'Staff Loans', '2023-03-25 10:14:49', '2023-03-25 10:14:49'),
(108, 'state government', 'liability', 'State Government', '2023-03-25 10:14:49', '2023-03-25 10:14:49'),
(109, 'stationery', 'asset', 'Stationery', '2023-03-25 10:14:49', '2023-03-25 10:14:49'),
(110, 'statutory reserve', 'capital', 'Statutory Reserve', '2023-03-25 10:14:49', '2023-03-25 10:14:49'),
(112, 'subsidiary companies', 'asset', 'Subsidiary Companies', '2023-03-25 10:14:49', '2023-03-25 10:14:49'),
(113, 'suspense accounts( assets)', 'asset', 'Suspense Account For Other Assets', '2023-03-25 10:14:49', '2023-03-25 10:14:49'),
(114, 'suspense accounts( liabilities)', 'liability', 'Suspense Account For Other Liabilities', '2023-03-25 10:14:49', '2023-03-25 10:14:49'),
(115, 'takings from', 'liability', 'Takings From', '2023-03-25 10:14:49', '2023-03-25 10:14:49'),
(117, 'takings from other institutions', 'liability', 'Takings From Other Institutions', '2023-03-25 10:14:49', '2023-03-25 10:14:49'),
(118, 'term or time deposits', 'liability', 'Term Or Time Deposits', '2023-03-25 10:14:49', '2023-03-25 10:14:49'),
(119, 'transit account', 'asset', 'This is transit account', '2023-03-25 10:14:49', '2023-03-25 10:14:49'),
(120, 'treasury bills', 'asset', 'Treasury Bills', '2023-03-25 10:14:49', '2023-03-25 10:14:49'),
(121, 'unaudited loss to date', 'capital', 'Unaudited Loss To Date', '2023-03-25 10:14:49', '2023-03-25 10:14:49'),
(122, 'unaudited profit to date', 'liability', 'Unaudited Profit To Date', '2023-03-25 10:14:49', '2023-03-25 10:14:49'),
(123, 'uncleared effects and transit items', 'liability', 'Uncleared Effects And Transit Items', '2023-03-25 10:14:49', '2023-03-25 10:14:49'),
(124, 'unearned income', 'liability', 'Unearned Income', '2023-03-25 10:14:49', '2023-03-25 10:14:49'),
(126, 'unpaid advances under micro leases principal', 'asset', 'Unpaid Advances Under Micro Leases Principal', '2023-03-25 10:14:49', '2023-03-25 10:14:49'),
(127, 'unpaid bill discounted principal', 'asset', 'Unpaid Bill Discounted Principal', '2023-03-25 10:14:49', '2023-03-25 10:14:49'),
(128, 'unpaid hire purchase principal', 'asset', 'Unpaid Hire Purchase Principal', '2023-03-25 10:14:49', '2023-03-25 10:14:49'),
(129, 'unpaid micro loan principal', 'asset', 'Unpaid Micro Loan Principal', '2023-03-25 10:14:49', '2023-03-25 10:14:49'),
(130, 'unpaid other loans principal', 'asset', 'Unpaid Other Loans Principal', '2023-03-25 10:14:49', '2023-03-25 10:14:49'),
(131, 'unpaid small and medium enterprise loans principal', 'asset', 'Unpaid Small And Medium Enterprise Loans Principal', '2023-03-25 10:14:49', '2023-03-25 10:14:49'),
(132, 'unpaid staff loans principal', 'asset', 'Unpaid Staff Loans Principal', '2023-03-25 10:14:49', '2023-03-25 10:14:49'),
(133, 'fx due from banks', 'asset', 'FX in Banks', '2023-03-25 10:14:49', '2023-09-25 09:38:44'),
(134, 'e-channel (unsecured)', 'asset', 'Unsecured', '2023-03-25 10:14:49', '2023-06-09 20:48:06'),
(135, 'voluntary savings deposits', 'liability', 'Voluntary Savings Deposits', '2023-03-25 10:14:49', '2023-03-25 10:14:49'),
(136, 'fx expenses', 'expense', 'FX expense', '2023-09-25 17:57:39', '2023-09-25 17:57:39');

-- --------------------------------------------------------

--
-- Table structure for table `account_types`
--

CREATE TABLE `account_types` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(225) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `account_types`
--

INSERT INTO `account_types` (`id`, `name`, `code`, `created_at`, `updated_at`) VALUES
(1, 'asset', '10', NULL, '2023-01-15 05:54:00'),
(2, 'liability', '20', NULL, NULL),
(3, 'capital', '30', NULL, NULL),
(4, 'Income', '40', NULL, NULL),
(5, 'expense', '50', NULL, '2023-01-15 05:54:25');

-- --------------------------------------------------------

--
-- Table structure for table `assets`
--

CREATE TABLE `assets` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED DEFAULT NULL,
  `asset_type_id` bigint UNSIGNED DEFAULT NULL,
  `branch_id` bigint UNSIGNED DEFAULT NULL,
  `purchase_date` date DEFAULT NULL,
  `purchase_price` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `replacement_value` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `initial` varchar(225) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `serial_number` text COLLATE utf8mb4_unicode_ci,
  `bought_from` text COLLATE utf8mb4_unicode_ci,
  `note` text COLLATE utf8mb4_unicode_ci,
  `file` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `asset_types`
--

CREATE TABLE `asset_types` (
  `id` bigint UNSIGNED NOT NULL,
  `name` text COLLATE utf8mb4_unicode_ci,
  `type` enum('current','fixed','intangible','other') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `initial` varchar(225) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `branch_id` bigint DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `asset_valuations`
--

CREATE TABLE `asset_valuations` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED DEFAULT NULL,
  `asset_id` bigint UNSIGNED DEFAULT NULL,
  `branch_id` bigint UNSIGNED DEFAULT NULL,
  `amount` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `audittrails`
--

CREATE TABLE `audittrails` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED DEFAULT NULL,
  `branch_id` bigint UNSIGNED DEFAULT NULL,
  `user` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `module` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `audittrails`
--

INSERT INTO `audittrails` (`id`, `user_id`, `branch_id`, `user`, `module`, `notes`, `created_at`, `updated_at`) VALUES
(1, 5, NULL, 'Lawal Rasak', 'customer', 'activated a customer account', '2025-09-02 18:19:47', '2025-09-02 18:19:47'),
(2, 5, NULL, 'Lawal Rasak', 'customer', 'activated a customer account', '2025-09-02 18:20:58', '2025-09-02 18:20:58'),
(3, 5, NULL, 'Lawal Rasak', 'customer', 'activated a customer account', '2025-09-02 18:22:04', '2025-09-02 18:22:04'),
(4, 5, NULL, 'Lawal Rasak', 'customer', 'activated a customer account', '2025-09-02 18:23:03', '2025-09-02 18:23:03'),
(5, 5, NULL, 'Lawal Rasak', 'customer', 'activated a customer account', '2025-09-02 18:23:25', '2025-09-02 18:23:25'),
(18188, 1, NULL, 'admin system', 'fixed deposit', 'added a fixed deposit with code:34267970', '2026-02-06 14:17:26', '2026-02-06 14:17:26'),
(18189, 1, NULL, 'admin system', 'investment', 'Approved a Fixed Deposit with code:34267970', '2026-02-06 14:20:19', '2026-02-06 14:20:19'),
(18190, 1, NULL, 'admin system', 'fixed deposit', 'added a fixed deposit with code:29306531', '2026-03-02 09:42:49', '2026-03-02 09:42:49'),
(18191, 1, NULL, 'admin system', 'fixed deposit', 'added a fixed deposit with code:41129781', '2026-03-02 10:42:18', '2026-03-02 10:42:18'),
(18192, 1, NULL, 'admin system', 'investment', 'Approved a Fixed Deposit with code:41129781', '2026-03-02 10:54:24', '2026-03-02 10:54:24'),
(18193, 1, NULL, 'admin system', 'investment', 'Approved a Fixed Deposit with code:29306531', '2026-03-02 10:58:21', '2026-03-02 10:58:21'),
(18194, 1, NULL, 'admin system', 'fixed deposit', 'added a fixed deposit with code:19879297', '2026-03-02 11:08:56', '2026-03-02 11:08:56'),
(18195, 1, NULL, 'admin system', 'investment', 'Approved a Fixed Deposit with code:19879297', '2026-03-02 11:53:27', '2026-03-02 11:53:27'),
(18196, 1, NULL, 'admin system', 'fixed deposit', 'updated fixed deposit', '2026-03-02 14:14:03', '2026-03-02 14:14:03'),
(18197, 1, NULL, 'admin system', 'investment', 'Approved a Fixed Deposit with code:19879297', '2026-03-02 14:51:26', '2026-03-02 14:51:26'),
(18198, 1, NULL, 'admin system', 'investment', 'Approved a Fixed Deposit with code:19879297', '2026-03-02 14:55:33', '2026-03-02 14:55:33'),
(18199, 1, NULL, 'admin system', 'fixed deposit', 'added a fixed deposit with code:97520906', '2026-03-02 14:57:23', '2026-03-02 14:57:23'),
(18200, 1, NULL, 'admin system', 'investment', 'Approved a Fixed Deposit with code:97520906', '2026-03-02 14:58:31', '2026-03-02 14:58:31'),
(18201, 1, NULL, 'admin system', 'fixed deposit', 'added a fixed deposit with code:67262172', '2026-03-06 08:17:22', '2026-03-06 08:17:22'),
(18202, 1, NULL, 'admin system', 'investment', 'Approved a Fixed Deposit with code:67262172', '2026-03-06 08:17:51', '2026-03-06 08:17:51'),
(18203, 1, NULL, 'admin system', 'investment', 'Approved a Fixed Deposit with code:67262172', '2026-03-06 08:29:42', '2026-03-06 08:29:42'),
(18204, 1, NULL, 'admin system', 'investment', 'Approved a Fixed Deposit with code:67262172', '2026-03-06 08:36:48', '2026-03-06 08:36:48'),
(18205, 1, NULL, 'admin system', 'investment', 'Approved a Fixed Deposit with code:67262172', '2026-03-06 08:59:18', '2026-03-06 08:59:18'),
(18206, 1, NULL, 'admin system', 'fixed deposit', 'added a fixed deposit with code:14632028', '2026-03-09 13:38:04', '2026-03-09 13:38:04'),
(18207, 1, NULL, 'admin system', 'investment', 'Approved a Fixed Deposit with code:14632028', '2026-03-09 13:40:21', '2026-03-09 13:40:21'),
(18208, 1, NULL, 'admin system', 'fixed deposit', 'updated fixed deposit', '2026-03-09 13:49:05', '2026-03-09 13:49:05'),
(18209, 1, NULL, 'admin system', 'investment', 'Approved a Fixed Deposit with code:14632028', '2026-03-09 13:49:17', '2026-03-09 13:49:17'),
(18211, 1, NULL, 'admin system', 'investment', 'Approved a Fixed Deposit with code:14632028', '2026-03-09 13:51:54', '2026-03-09 13:51:54'),
(18212, 1, NULL, 'admin system', 'investment', 'Approved a Fixed Deposit with code:14632028', '2026-03-09 13:57:24', '2026-03-09 13:57:24'),
(18213, 1, NULL, 'admin system', 'investment', 'Approved a Fixed Deposit with code:14632028', '2026-03-09 14:02:15', '2026-03-09 14:02:15'),
(18214, 1, NULL, 'admin system', 'investment', 'Approved a Fixed Deposit with code:14632028', '2026-03-09 14:43:06', '2026-03-09 14:43:06'),
(18215, 1, NULL, 'admin system', 'fixed deposit', 'added a fixed deposit with code:96925391', '2026-03-09 14:52:00', '2026-03-09 14:52:00'),
(18216, 1, NULL, 'admin system', 'investment', 'Approved a Fixed Deposit with code:96925391', '2026-03-09 14:52:20', '2026-03-09 14:52:20'),
(18217, 1, NULL, 'admin system', 'investment', 'Approved a Fixed Deposit with code:96925391', '2026-03-10 10:41:53', '2026-03-10 10:41:53'),
(18218, 1, NULL, 'admin system', 'fixed deposit', 'updated fixed deposit', '2026-03-10 10:45:35', '2026-03-10 10:45:35'),
(18219, 1, NULL, 'admin system', 'investment', 'Approved a Fixed Deposit with code:96925391', '2026-03-10 10:45:45', '2026-03-10 10:45:45'),
(18220, 1, NULL, 'admin system', 'fixed deposit', 'updated fixed deposit', '2026-03-10 15:25:52', '2026-03-10 15:25:52'),
(18221, 1, NULL, 'admin system', 'investment', 'Approved a Fixed Deposit with code:96925391', '2026-03-10 15:26:08', '2026-03-10 15:26:08'),
(18222, 1, NULL, 'admin system', 'investment', 'Approved a Fixed Deposit with code:96925391', '2026-03-10 15:42:02', '2026-03-10 15:42:02'),
(18223, 1, NULL, 'admin system', 'fixed deposit', 'added a fixed deposit with code:36598982', '2026-03-12 11:45:46', '2026-03-12 11:45:46'),
(18224, 1, NULL, 'admin system', 'investment', 'Approved a Fixed Deposit with code:36598982', '2026-03-12 11:46:15', '2026-03-12 11:46:15');

-- --------------------------------------------------------

--
-- Table structure for table `banks`
--

CREATE TABLE `banks` (
  `id` bigint UNSIGNED NOT NULL,
  `bank_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `bank_code` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `short_code` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `logo` varchar(225) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `banks`
--

INSERT INTO `banks` (`id`, `bank_name`, `bank_code`, `short_code`, `logo`, `created_at`, `updated_at`) VALUES
(1, '3Line', '110005', '', NULL, NULL, NULL),
(2, 'Ab MFB', '090270', '', NULL, NULL, NULL),
(3, 'Abbey Mortgage Bank', '070010', '', NULL, NULL, NULL),
(4, 'Above Only MFB', '090260', '', NULL, NULL, NULL),
(5, 'Abu MFB', '090197', '', NULL, NULL, NULL),
(6, 'Access Bank Nigeria', '000014', '044', NULL, NULL, NULL),
(7, 'Access Yello and Beta', '100052', '', NULL, NULL, NULL),
(8, 'Accessmoney', '100013', '323', NULL, NULL, NULL),
(9, 'Accion MFB', '090134', '', NULL, NULL, NULL),
(10, 'Addosser MFB', '090160', '', NULL, NULL, NULL),
(11, 'Adeyemi College Staff MFB', '090268', '', NULL, NULL, NULL),
(12, 'Afekhafe MFB', '090292', '', NULL, NULL, NULL),
(13, 'Ag Mortgage Bank', '100028', '', NULL, NULL, NULL),
(14, 'Al-Barkah MFB', '090133', '', NULL, NULL, NULL),
(15, 'Al-Hayat MFB', '090277', '', NULL, NULL, NULL),
(16, 'Alekun MFB', '090259', '', NULL, NULL, NULL),
(17, 'Alert MFB', '090297', '', NULL, NULL, NULL),
(18, 'Allworkers MFB', '090131', '', NULL, NULL, NULL),
(19, 'Alpha Kapital MFB', '090169', '', NULL, NULL, NULL),
(20, 'Amju Unique MFB', '090180', '', NULL, NULL, NULL),
(21, 'AMML MFB', '090116', '', NULL, NULL, NULL),
(22, 'Apeks MFB', '090143', '', NULL, NULL, NULL),
(23, 'Arise MFB', '090282', '', NULL, NULL, NULL),
(24, 'Aso Savings And Loans', '090001', '401', NULL, NULL, NULL),
(25, 'Assetmatrix MFB', '090287', '', NULL, NULL, NULL),
(26, 'Astrapolaris MFB', '090172', '', NULL, NULL, NULL),
(27, 'Auchi MFB', '090264', '', NULL, NULL, NULL),
(28, 'Baines Credit MFB', '090188', '', NULL, NULL, NULL),
(29, 'Balogun Gambari MFB', '090326', '', NULL, NULL, NULL),
(30, 'Baobab MFB', '090136', '', NULL, NULL, NULL),
(31, 'BC Kash MFB', '090127', '', NULL, NULL, NULL),
(32, 'Boctrust MFB', '090117', '', NULL, NULL, NULL),
(33, 'Bosak MFB', '090176', '', NULL, NULL, NULL),
(34, 'Bowen MFB', '090148', '', NULL, NULL, NULL),
(35, 'Brent Mortgage Bank', '070015', '', NULL, NULL, NULL),
(36, 'Brethren MFB', '090293', '', NULL, NULL, NULL),
(37, 'Brightway MFB', '090308', '', NULL, NULL, NULL),
(38, 'Cellulant', '100005', '', NULL, NULL, NULL),
(39, 'CEMCS MFB', '090154', '50823', NULL, NULL, NULL),
(40, 'Chikum MFB', '090141', '', NULL, NULL, NULL),
(41, 'CIT MFB', '090144', '', NULL, NULL, NULL),
(42, 'Citibank Nigeria', '000009', '023', NULL, NULL, NULL),
(43, 'Consumer MFB', '090130', '', NULL, NULL, NULL),
(44, 'Contec Global Infotech', '100032', '', NULL, NULL, NULL),
(45, 'Coronation Merchant Bank', '060001', '902', NULL, NULL, NULL),
(46, 'Covenant', '070006', '', NULL, NULL, NULL),
(47, 'Credit Afrique MFB', '090159', '', NULL, NULL, NULL),
(48, 'Daylight MFB', '090167', '', NULL, NULL, NULL),
(49, 'E-Barcs MFB', '090156', '', NULL, NULL, NULL),
(50, 'Eagle Flight MFB', '090294', '', NULL, NULL, NULL),
(51, 'Eartholeum (Qik Qik)', '100021', '', NULL, NULL, NULL),
(52, 'Ecobank Bank', '000010', '050', NULL, NULL, NULL),
(53, 'Ecobank Xpress', '100008', '307', NULL, NULL, NULL),
(54, 'EdFin MFB', '090310', '', NULL, NULL, NULL),
(55, 'Ekondo MFB', '090097', '562', NULL, NULL, NULL),
(56, 'Emeralds MFB', '090273', '', NULL, NULL, NULL),
(57, 'Empire Trust MFB', '090114', '', NULL, NULL, NULL),
(58, 'Esan MFB', '090189', '', NULL, NULL, NULL),
(59, 'Eso-E MFB', '090166', '', NULL, NULL, NULL),
(60, 'Etranzact', '100006', '', NULL, NULL, NULL),
(61, 'Evangel MFB', '090304', '', NULL, NULL, NULL),
(62, 'Fast MFB', '090179', '', NULL, NULL, NULL),
(63, 'FBNQuest Merchant Bank', '060002', '911', NULL, NULL, NULL),
(64, 'FCMB Easy Account', '100031', '', NULL, NULL, NULL),
(65, 'FCT MFB', '090290', '', NULL, NULL, NULL),
(66, 'Federal University Dutse MFB', '090318', '', NULL, NULL, NULL),
(67, 'Fedpoly Nasarawa MFB', '090298', '', NULL, NULL, NULL),
(68, 'FETS (My Wallet)', '100001', '', NULL, NULL, NULL),
(69, 'FFS Microfinance', '090153', '', NULL, NULL, NULL),
(70, 'Fidelity Bank', '000007', '070', NULL, NULL, NULL),
(71, 'Fidelity Mobile', '100019', '', NULL, NULL, NULL),
(72, 'Fidfund MFB', '090126', '', NULL, NULL, NULL),
(73, 'Finatrust MFB', '090111', '', NULL, NULL, NULL),
(74, 'First Apple', '110004', '', NULL, NULL, NULL),
(75, 'First Bank of Nigeria', '000016', '011', NULL, NULL, NULL),
(76, 'First City Monument Bank', '000003', '214', NULL, NULL, NULL),
(77, 'First Gen Mortgage Bank', '070014', '', NULL, NULL, NULL),
(78, 'First Multiple MFB', '090163', '', NULL, NULL, NULL),
(79, 'First Option MFB', '090285', '', NULL, NULL, NULL),
(80, 'First Royal MFB', '090164', '', NULL, NULL, NULL),
(81, 'First Trust Mortgage Bank', '090005', '', NULL, NULL, NULL),
(82, 'First Trust Mortgage Bank', '090107', '', NULL, NULL, NULL),
(83, 'Firstmonie Wallet', '100014', '', NULL, NULL, NULL),
(84, 'Flutterwave Tech Solutions', '110002', '', NULL, NULL, NULL),
(85, 'Fortis MFB', '070002', '', NULL, NULL, NULL),
(86, 'Fortis Mobile', '100016', '', NULL, NULL, NULL),
(87, 'FSDH Merchant Bank', '400001', '501', NULL, NULL, NULL),
(88, 'Full Range MFB', '090145', '', NULL, NULL, NULL),
(89, 'Futo MFB', '090158', '', NULL, NULL, NULL),
(90, 'Gashua MFB', '090168', '', NULL, NULL, NULL),
(91, 'Gateway Mortgage Bank', '070009', '', NULL, NULL, NULL),
(92, 'Globus Bank', '000027', '103', NULL, NULL, NULL),
(93, 'Glory MFB', '090278', '', NULL, NULL, NULL),
(94, 'Gomoney', '100022', NULL, NULL, NULL, NULL),
(95, 'Gowans MFB', '090122', '', NULL, NULL, NULL),
(96, 'Greenbank MFB', '090178', '', NULL, NULL, NULL),
(97, 'Greenville MFB', '090269', '', NULL, NULL, NULL),
(98, 'Grooming MFB', '090195', '', NULL, NULL, NULL),
(99, 'GT Mobile Money', '100009', '315', NULL, NULL, NULL),
(100, 'Guaranty Trust Bank', '000013', '058', NULL, NULL, NULL),
(101, 'Hackman MFB', '090147', '', NULL, NULL, NULL),
(102, 'Haggai Mortgage Bank', '070017', '', NULL, NULL, NULL),
(103, 'Hala MFB', '090291', '', NULL, NULL, NULL),
(104, 'Hasal MFB', '090121', '50383', NULL, NULL, NULL),
(105, 'Hedonmark', '100017', '', NULL, NULL, NULL),
(106, 'Heritage Bank', '000020', '030', NULL, NULL, NULL),
(107, 'Ibile MFB', '090118', '', NULL, NULL, NULL),
(108, 'Ikire MFB', '090275', '', NULL, NULL, NULL),
(109, 'Ikire MFB', '090279', '', NULL, NULL, NULL),
(110, 'Imo State MFB', '090258', '', NULL, NULL, NULL),
(111, 'Imperial Homes Mortgage Bank', '100024', '', NULL, NULL, NULL),
(112, 'Infinity MFB', '090157', '', NULL, NULL, NULL),
(113, 'Infinity Trust Mortgage Bank', '070016', '', NULL, NULL, NULL),
(114, 'Innovectives Kesh', '100029', '', NULL, NULL, NULL),
(115, 'Interswitch', '110003', '', NULL, NULL, NULL),
(116, 'IRL MFB', '090149', '', NULL, NULL, NULL),
(117, 'Itex Integrated Services', '090211', '', NULL, NULL, NULL),
(118, 'Jaiz Bank', '000006', '301', NULL, NULL, NULL),
(119, 'Jubilee Life', '090003', '', NULL, NULL, NULL),
(120, 'Kadpoly MFB', '090320', '', NULL, NULL, NULL),
(121, 'KCMB MFB', '090191', '', NULL, NULL, NULL),
(122, 'Kegow', '100015', '', NULL, NULL, NULL),
(123, 'Keystone Bank', '000002', '082', NULL, NULL, NULL),
(124, 'Kontagora MFB', '090299', '', NULL, NULL, NULL),
(125, 'Kredi Bank', '090380', '50200', NULL, NULL, NULL),
(126, 'Kuda MFB', '090267', '50211', NULL, NULL, NULL),
(127, 'La Fayette MFB', '090155', '', NULL, NULL, NULL),
(128, 'Lagos Building Investment Company', '070012', '', NULL, NULL, NULL),
(129, 'LAPO MFB', '090177', '', NULL, NULL, NULL),
(130, 'Lavender MFB', '090271', '', NULL, NULL, NULL),
(131, 'Lovonus MFB', '090265', '', NULL, NULL, NULL),
(132, 'M-Kudi', '100011', '', NULL, NULL, NULL),
(133, 'Mainstreet MFB', '090171', '', NULL, NULL, NULL),
(134, 'Malachy MFB', '090174', '', NULL, NULL, NULL),
(135, 'Megapraise MFB', '090280', '', NULL, NULL, NULL),
(136, 'Microvis MFB', '090113', '', NULL, NULL, NULL),
(137, 'Midland MFB', '090192', '', NULL, NULL, NULL),
(138, 'Mimoney Intellifin Solutions', '100027', '', NULL, NULL, NULL),
(139, 'Mint-Finex MFB', '090281', '', NULL, NULL, NULL),
(140, 'Money Trust MFB', '090129', '', NULL, NULL, NULL),
(141, 'Moneybox', '100020', '', NULL, NULL, NULL),
(142, 'Mutual Benefits Mifb', '090190', '', NULL, NULL, NULL),
(143, 'Mutual Trust MFB', '090151', '', NULL, NULL, NULL),
(144, 'Nargata MFB', '090152', '', NULL, NULL, NULL),
(145, 'Ndiorah MFB', '090128', '', NULL, NULL, NULL),
(146, 'New Dawn MFB', '090205', '', NULL, NULL, NULL),
(147, 'New Prudential Bank', '090108', '', NULL, NULL, NULL),
(148, 'Nigerian Navy MFB', '090263', '', NULL, NULL, NULL),
(149, 'Nigerian Police Force MFB', '070001', '', NULL, NULL, NULL),
(150, 'Nirsal MFB', '090194', '', NULL, NULL, NULL),
(151, 'Nnew Women MFB', '090283', '', NULL, NULL, NULL),
(152, 'Nova Merchant Bank', '060003', '561', NULL, NULL, NULL),
(153, 'Ohafia MFB', '090119', '', NULL, NULL, NULL),
(154, 'Okpoga MFB', '090161', '', NULL, NULL, NULL),
(155, 'Olabisi Onabanjo University MFB', '090272', '', NULL, NULL, NULL),
(156, 'Omiye MFB', '090295', '', NULL, NULL, NULL),
(157, 'Omoluabi Mortgage Bank', '070007', '', NULL, NULL, NULL),
(158, 'One Finance', '100026', '565', NULL, NULL, NULL),
(159, 'Paga', '100002', '', NULL, NULL, NULL),
(160, 'Page Financials', '070008', '', NULL, NULL, NULL),
(161, 'Palmpay', '100033', '', NULL, NULL, NULL),
(162, 'Parallex MFB', '090004', '526', NULL, NULL, NULL),
(163, 'Parkway-Readycash', '100003', '311', NULL, NULL, NULL),
(164, 'Patrickgold MFB', '090317', '', NULL, NULL, NULL),
(165, 'Payattitude Online', '110001', '', NULL, NULL, NULL),
(166, 'Paycom (Opay)', '100004', '999992', NULL, NULL, NULL),
(167, 'Paystack Payments', '110006', '', NULL, NULL, NULL),
(168, 'Pecantrust MFB', '090137', '', NULL, NULL, NULL),
(169, 'Pennywise MFB', '090196', '', NULL, NULL, NULL),
(170, 'Personal Trust MFB', '090135', '', NULL, NULL, NULL),
(171, 'Petra MFB', '090165', '', NULL, NULL, NULL),
(172, 'Pillar MFB', '090289', '', NULL, NULL, NULL),
(173, 'Platinum Mortgage Bank', '070013', '', NULL, NULL, NULL),
(174, 'Polaris Bank', '000008', '076', NULL, NULL, NULL),
(175, 'Polyuwana MFB', '090296', '', NULL, NULL, NULL),
(176, 'Prestige MFB', '090274', '', NULL, NULL, NULL),
(177, 'Providus Bank', '000023', '101', NULL, NULL, NULL),
(178, 'Purplemoney MFB', '090303', '', NULL, NULL, NULL),
(179, 'Quickfund MFB', '090261', '', NULL, NULL, NULL),
(180, 'Rahama MFB', '090170', '', NULL, NULL, NULL),
(181, 'Rand Merchant Bank', '000024', '502', NULL, NULL, NULL),
(182, 'Refuge Mortgage Bank', '070011', '', NULL, NULL, NULL),
(183, 'Regent MFB', '090125', '', NULL, NULL, NULL),
(184, 'Reliance MFB', '090173', '', NULL, NULL, NULL),
(185, 'Renmoney MFB', '090198', '', NULL, NULL, NULL),
(186, 'Richway MFB', '090132', '', NULL, NULL, NULL),
(187, 'Moniepoint MFB', '090405', '50515', NULL, NULL, NULL),
(188, 'Royal Exchange MFB', '090138', '', NULL, NULL, NULL),
(189, 'Rubies MFB', '090175', '125', NULL, NULL, NULL),
(190, 'Safe Haven MFB', '090286', '', NULL, NULL, NULL),
(191, 'Safetrust Mortgage Bank', '090006', '', NULL, NULL, NULL),
(192, 'Sagamu MFB', '090140', '', NULL, NULL, NULL),
(193, 'Seed Capital MFB', '090112', '', NULL, NULL, NULL),
(194, 'Sparkle Bank', '090325', '51310', NULL, NULL, NULL),
(195, 'Stanbic IBTC', '000012', '221', NULL, NULL, NULL),
(196, 'Stanbic IBTC @Ease Wal', '100007', '304', NULL, NULL, NULL),
(197, 'Standard Chartered Bank', '000021', '068', NULL, NULL, NULL),
(198, 'Stanford MFB', '090162', '', NULL, NULL, NULL),
(199, 'Stellas MFB', '090262', '', NULL, NULL, NULL),
(200, 'Sterling Bank', '000001', '232', NULL, NULL, NULL),
(201, 'Sulspap MFB', '090305', '', NULL, NULL, NULL),
(202, 'Suntrust Bank', '000022', '100', NULL, NULL, NULL),
(203, 'Tagpay', '100023', '', NULL, NULL, NULL),
(204, 'Taj Bank', '000026', '302', NULL, NULL, NULL),
(205, 'TCF MFB', '090115', '51211', NULL, NULL, NULL),
(206, 'TeamApt', '110007', '', NULL, NULL, NULL),
(207, 'Teasy Mobile', '100010', '', NULL, NULL, NULL),
(208, 'Titan Trust Bank', '000025', '102', NULL, NULL, NULL),
(209, 'Trident MFB', '090146', '', NULL, NULL, NULL),
(210, 'Trustbanc J6 MFB', '090123', '', NULL, NULL, NULL),
(211, 'Trustfund MFB', '090276', '', NULL, NULL, NULL),
(212, 'UNIBEN MFB', '090266', '', NULL, NULL, NULL),
(213, 'UNICAL MFB', '090193', '', NULL, NULL, NULL),
(214, 'Union Bank of Nigeria', '000018', '032', NULL, NULL, NULL),
(215, 'United Bank for Africa', '000004', '033', NULL, NULL, NULL),
(216, 'Unity Bank', '000011', '215', NULL, NULL, NULL),
(217, 'Unn MFB', '090251', '', NULL, NULL, NULL),
(218, 'VFD MFB', '090110', '566', NULL, NULL, NULL),
(219, 'Virtue MFB', '090150', '', NULL, NULL, NULL),
(220, 'Visa MFB', '090139', '', NULL, NULL, NULL),
(221, 'Vtnetwork', '100012', '', NULL, NULL, NULL),
(222, 'Wema Bank', '000017', '035', NULL, NULL, NULL),
(223, 'Wetland MFB', '090120', '', NULL, NULL, NULL),
(224, 'Xslnce MFB', '090124', '', NULL, NULL, NULL),
(225, 'Yes MFB', '090142', '', NULL, NULL, NULL),
(226, 'Zenith Bank', '000015', '057', NULL, NULL, NULL),
(227, 'Zenith Mobile', '100018', '322', NULL, NULL, NULL),
(228, 'Zinternet', '100025', '', NULL, NULL, NULL),
(229, 'waya MFB', '090590', NULL, NULL, '2023-05-12 11:49:06', '2023-05-12 11:49:06'),
(230, 'Paystack-Titan Bank', '100039', NULL, NULL, '2024-10-26 13:20:00', '2024-10-26 13:20:00');

-- --------------------------------------------------------

--
-- Table structure for table `beneficiaries`
--

CREATE TABLE `beneficiaries` (
  `id` bigint UNSIGNED NOT NULL,
  `customer_id` bigint UNSIGNED NOT NULL,
  `account_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `account_number` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `bank_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bank_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bank_shortcode` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `branch_id` bigint DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `branches`
--

CREATE TABLE `branches` (
  `id` bigint UNSIGNED NOT NULL,
  `branch_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `branch_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` text COLLATE utf8mb4_unicode_ci,
  `default_branch` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `branches`
--

INSERT INTO `branches` (`id`, `branch_name`, `branch_code`, `address`, `default_branch`, `created_at`, `updated_at`) VALUES
(1, 'Head Office ikeja', NULL, 'Suite 1, No 1B, Omorinre Johnson Close, Lekki Phase 1, Lagos', 0, '2022-11-18 21:21:43', '2022-11-21 14:56:09'),
(2, 'ikeja plaza', NULL, '234 awolowo road ikeja lagos', 0, '2022-11-21 14:24:19', '2022-11-21 14:24:19'),
(3, 'Mushin Branch', NULL, 'Mushin Road', 0, '2023-03-24 01:58:17', '2023-03-24 01:58:17');

-- --------------------------------------------------------

--
-- Table structure for table `branch_users`
--

CREATE TABLE `branch_users` (
  `id` bigint UNSIGNED NOT NULL,
  `branch_id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `capitals`
--

CREATE TABLE `capitals` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `branch_id` bigint UNSIGNED NOT NULL,
  `share_holder_name` varchar(225) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `percentage` varchar(225) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `amount` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `charges`
--

CREATE TABLE `charges` (
  `id` bigint UNSIGNED NOT NULL,
  `chargename` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `amount` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `branch_id` bigint DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `charges`
--

INSERT INTO `charges` (`id`, `chargename`, `amount`, `description`, `branch_id`, `created_at`, `updated_at`) VALUES
(2, 'Esusu', '1000', NULL, NULL, '2022-12-06 16:09:57', '2022-12-06 17:25:52'),
(3, 'Form Fees', '1000', NULL, NULL, '2022-12-06 16:10:15', '2022-12-06 17:38:40'),
(4, 'Monthly Charge', '300', 'Charge', NULL, '2022-12-06 16:10:59', '2023-05-07 14:23:08'),
(5, 'Process Fees', '150', NULL, NULL, '2022-12-06 16:11:28', '2022-12-06 16:15:08'),
(6, 'Transfer Charge', '9', NULL, NULL, '2022-12-06 16:11:55', '2023-05-03 11:52:01'),
(7, 'other charges', '1', 'other charges', NULL, '2023-05-02 16:01:49', '2023-05-02 16:01:49'),
(8, '1000 flatchgs', '1000', 'hfgf', NULL, '2023-05-07 14:31:16', '2023-05-07 14:31:55');

-- --------------------------------------------------------

--
-- Table structure for table `collaterals`
--

CREATE TABLE `collaterals` (
  `id` bigint UNSIGNED NOT NULL,
  `loan_id` bigint UNSIGNED DEFAULT NULL,
  `customer_id` bigint UNSIGNED DEFAULT NULL,
  `collateral_type_id` bigint UNSIGNED DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  `date` date DEFAULT NULL,
  `status` enum('returned_to_customer','repossessed','repossession_initiated','sold','lost','collateral_with_customer','deposited_into_branch') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `photo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `files` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `serial_number` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `model_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `model_number` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `manufacture_date` date DEFAULT NULL,
  `branch_id` bigint DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `collateral_types`
--

CREATE TABLE `collateral_types` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `branch_id` bigint DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE `customers` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED DEFAULT NULL,
  `branch_id` bigint UNSIGNED DEFAULT NULL,
  `accountofficer_id` bigint UNSIGNED DEFAULT NULL,
  `title` varchar(225) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `first_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_name` varchar(225) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `gender` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `section` varchar(225) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `religion` varchar(225) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `marital_status` varchar(225) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `residential_address` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `country` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `state` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `state_lga` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `account_type` varchar(225) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `exchangerate_id` bigint DEFAULT NULL,
  `acctno` varchar(225) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `refacct` text COLLATE utf8mb4_unicode_ci,
  `bvn` varchar(225) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nin` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `next_kin` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `kin_address` varchar(225) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `kin_phone` varchar(225) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `kin_relate` varchar(225) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `occupation` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `business_name` varchar(225) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `working_status` varchar(225) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `question` text COLLATE utf8mb4_unicode_ci,
  `answer` text COLLATE utf8mb4_unicode_ci,
  `means_of_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `upload_id` varchar(225) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `photo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `signature` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `username` varchar(225) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pin` varchar(225) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `otp` varchar(225) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `otp_expiration_date` datetime DEFAULT NULL,
  `phone_verify` tinyint(1) NOT NULL DEFAULT '0',
  `password` varchar(225) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `reg_date` varchar(225) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `source` enum('online','admin') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `transfer_limit` varchar(225) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `failed_logins` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `failed_balance` varchar(225) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `failed_pin` varchar(225) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` tinyint(1) DEFAULT '0',
  `lien` tinyint(1) NOT NULL DEFAULT '0',
  `referral_code` varchar(225) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `referral` varchar(225) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_login` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `linked_device` text COLLATE utf8mb4_unicode_ci,
  `ussd` tinyint(1) DEFAULT '0',
  `whatsapp` tinyint(1) NOT NULL DEFAULT '0',
  `enable_sms_alert` tinyint(1) NOT NULL DEFAULT '0',
  `enable_email_alert` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `customers`
--

INSERT INTO `customers` (`id`, `user_id`, `branch_id`, `accountofficer_id`, `title`, `first_name`, `last_name`, `email`, `phone`, `gender`, `section`, `religion`, `marital_status`, `residential_address`, `dob`, `country`, `state`, `state_lga`, `account_type`, `exchangerate_id`, `acctno`, `refacct`, `bvn`, `nin`, `next_kin`, `kin_address`, `kin_phone`, `kin_relate`, `occupation`, `business_name`, `working_status`, `question`, `answer`, `means_of_id`, `upload_id`, `photo`, `signature`, `username`, `pin`, `otp`, `otp_expiration_date`, `phone_verify`, `password`, `reg_date`, `source`, `transfer_limit`, `failed_logins`, `failed_balance`, `failed_pin`, `status`, `lien`, `referral_code`, `referral`, `last_login`, `linked_device`, `ussd`, `whatsapp`, `enable_sms_alert`, `enable_email_alert`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 21, NULL, 2, 'mr', 'AKINOLA', 'ISHOLA', 'AKINOLAISHOLA6@GMAIL.COM', '08023325173', 'male', 'rich green capital', 'christainity', 'married', '104 ISIBA OLUWO EGBEDA', '1947-08-21', 'Nigeria', 'Lagos', 'Ikeja', '1', NULL, '1014834577', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PENSIONER', NULL, 'pensioner', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '$2y$10$UeN1fHWsqU1zYv9lQUNq.OKcjD4QhQKxhMuDXrBD30bLShhLjg3iS', NULL, NULL, 0, NULL, '2023-06-29 14:07:33', 'admin', '500000', NULL, NULL, NULL, 1, 0, 'jvamgj', NULL, '2023-06-29 13:07:33', NULL, 0, 0, 0, 0, '2023-06-29 13:07:33', '2025-03-11 11:16:06', NULL),
(2, 21, NULL, 10, NULL, 'ADERINSOLA ABOSEDE', 'ADEKANMBI', 'DERINSOLA@GMAIL.COM', '08099448938', 'female', 'rich green masters', 'christainity', 'single', '36A OKUNOLA AINA STREET,MENDE MARYLAND', '1983-03-20', 'Nigeria', 'Lagos', 'Ikeja', '1', NULL, '1014218881', NULL, NULL, NULL, 'MOSADOLUWA', 'ADEKANMBI', '08035209412', NULL, NULL, NULL, NULL, NULL, NULL, 'international passport', NULL, NULL, NULL, NULL, '$2y$10$sSRvCixCCAnhVmLCq68APetyIrrVtja90s5cmFPmhtbDPrwp1gkMa', NULL, NULL, 0, NULL, '2023-06-29 14:22:35', 'admin', '500000', NULL, NULL, NULL, 1, 0, 'cbpgde', NULL, '2023-06-29 13:22:35', NULL, 0, 0, 0, 0, '2023-06-29 13:22:35', '2023-06-29 16:48:52', NULL),
(3, 20, NULL, NULL, 'mr', 'EMMANUEL GBENGA', 'ADEYEMI', 'adeemma04@yahoo.com', '08033644497', 'male', NULL, NULL, 'married', 'Flat 2 number 16 kayode Arikawe Ikosi-Ketu lagos', NULL, 'Nigeria', NULL, NULL, '1', NULL, '1012999595', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '$2y$10$uv.aY8OBL5IdbNUofuRsxuYBK0k8nFCt9sVOkvChJ80GOQPPals/2', NULL, NULL, 0, NULL, '2023-06-29 15:22:03', 'admin', '500000', NULL, '1', NULL, 1, 0, 'wu9ils', NULL, '2023-06-29 14:22:03', NULL, 0, 0, 0, 0, '2023-06-29 14:22:03', '2025-06-03 17:11:16', NULL),
(4, 20, NULL, NULL, 'mrs', 'OMOLARA VICTORIA', 'ADANRI', NULL, NULL, 'female', NULL, NULL, 'married', '9 IYA OLOYE CRESCENT MARYLAND LAGOS STATE', NULL, 'Nigeria', NULL, NULL, '1', NULL, '1018504911', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '$2y$10$VG5hsD5BIhJBJWhd7yCS1.41HY1l7grBtVJN6b2aOoR09.q2omTli', NULL, NULL, 0, NULL, '2023-06-29 15:25:06', 'admin', '500000', NULL, NULL, NULL, 1, 0, 'p4aony', NULL, '2023-06-29 14:25:06', NULL, 0, 0, 0, 0, '2023-06-29 14:25:06', '2023-06-29 15:18:46', NULL),
(5, 21, NULL, 11, 'mr', 'PASE OLUWADAMILARE', 'AFOLAYAN', 'FOLADARE@YAHOO.COM', '08023207849', 'male', 'rich green masters', 'christainity', 'married', 'PLOT 7 ADEBAYO STREET LAGOON VIEW ESTATE,OFF IBESE ROAD, IKORODU', NULL, 'Nigeria', 'Lagos', 'Ikorodu', '1', NULL, '1016021743', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'employee', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '$2y$10$cSws8ycKWr5LXf4MQG8f/uvlZBiVXwirFozNXWotvTf2iSDsBeC9e', NULL, NULL, 0, NULL, '2023-06-29 15:33:02', 'admin', '500000', NULL, NULL, NULL, 1, 0, 'qwvurz', NULL, '2023-06-29 14:33:02', NULL, 0, 0, 0, 0, '2023-06-29 14:33:02', '2025-09-02 18:23:03', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `emails`
--

CREATE TABLE `emails` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED DEFAULT NULL,
  `branch_id` bigint UNSIGNED DEFAULT NULL,
  `subject` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `message` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `recipient` varchar(225) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `emails`
--

INSERT INTO `emails` (`id`, `user_id`, `branch_id`, `subject`, `message`, `recipient`, `created_at`, `updated_at`) VALUES
(1, 33, NULL, 'RichGreen Masters Investment Limited Password Reset', 'Your new Login password: 43325104<br> Please make changes to password after login.', 'Prudence@cashmatrix.ng', '2025-09-03 11:40:28', '2025-09-03 11:40:28'),
(2, 36, NULL, 'RichGreen Masters Investment Limited Password Reset', 'Your new Login password: 67325782<br> Please make changes to password after login.', 'judith@cashmatrix.ng', '2025-09-03 11:56:59', '2025-09-03 11:56:59'),
(3, 30, NULL, 'RichGreen Masters Investment Limited Credit Alert', 'Credit Amt: N2,698,760.00<br> Desc: MIGRATION/YUSUF AYOTUNDE EBENEZER <br>Avail Bal: N2,698,760.00<br>Date: 2025-09-03<br>Ref: Glc202509030149151423', 'princious.tunde@gmail.com', '2025-09-03 14:13:20', '2025-09-03 14:13:20'),
(4, 29, NULL, 'RichGreen Masters Investment Limited Debit Alert', 'Debit Amt: N1,000,000.00<br> Desc: LOAN DISBURSED 25/09/2025 <br>Avail Bal: N0.00<br>Date: 2025-09-26<br>Ref: Cgl202509260514574461', 'TVADEGBITE@GMAIL.COM', '2025-09-26 19:25:27', '2025-09-26 19:25:27'),
(5, 29, NULL, 'RichGreen Masters Investment Limited Credit Alert', 'Credit Amt: N128,434.00<br> Desc: LOAN REPAYMENT-ADEGBITE VINCEN--30/09/2025 <br>Avail Bal: N128,434.00<br>Date: 2025-10-01<br>Ref: Glc202510010120599011', 'TVADEGBITE@GMAIL.COM', '2025-10-01 14:38:20', '2025-10-01 14:38:20'),
(6, 1, NULL, 'loan repayment', 'An outstanding loan has been debited <br>Avail Bal: N2,000,000.00<br> Date: 2025-10-03<br>Ref: R202510030925387748', 'TVADEGBITE@GMAIL.COM', '2025-10-03 09:25:38', '2025-10-03 09:25:38'),
(7, 1, NULL, 'loan repayment', 'An outstanding loan has been debited <br>Avail Bal: N1,901,566.00<br> Date: 2025-10-03<br>Ref: R202510030935547962', 'TVADEGBITE@GMAIL.COM', '2025-10-03 09:35:54', '2025-10-03 09:35:54'),
(8, 1, NULL, 'loan repayment', 'An outstanding loan has been debited <br>Avail Bal: N1,800,179.00<br> Date: 2025-10-03<br>Ref: R202510030939111939', 'TVADEGBITE@GMAIL.COM', '2025-10-03 09:39:11', '2025-10-03 09:39:11'),
(9, 1, NULL, 'loan repayment', 'An outstanding loan has been debited <br>Avail Bal: N1,695,750.00<br> Date: 2025-10-03<br>Ref: R202510030939249584', 'TVADEGBITE@GMAIL.COM', '2025-10-03 09:39:24', '2025-10-03 09:39:24'),
(10, 1, NULL, 'loan repayment', 'An outstanding loan has been debited <br>Avail Bal: N1,588,189.00<br> Date: 2025-10-03<br>Ref: R202510030939413323', 'TVADEGBITE@GMAIL.COM', '2025-10-03 09:39:42', '2025-10-03 09:39:42'),
(11, 1, NULL, 'loan repayment', 'An outstanding loan has been debited <br>Avail Bal: N1,477,401.00<br> Date: 2025-10-03<br>Ref: R202510030940037888', 'TVADEGBITE@GMAIL.COM', '2025-10-03 09:40:03', '2025-10-03 09:40:03'),
(12, 1, NULL, 'loan repayment', 'An outstanding loan has been debited <br>Avail Bal: N1,363,289.00<br> Date: 2025-10-03<br>Ref: R202510030940146200', 'TVADEGBITE@GMAIL.COM', '2025-10-03 09:40:14', '2025-10-03 09:40:14'),
(13, 1, NULL, 'loan repayment', 'An outstanding loan has been debited <br>Avail Bal: N1,245,754.00<br> Date: 2025-10-03<br>Ref: R202510030942437297', 'TVADEGBITE@GMAIL.COM', '2025-10-03 09:42:43', '2025-10-03 09:42:43'),
(14, 1, NULL, 'loan repayment', 'An outstanding loan has been debited <br>Avail Bal: N1,124,693.00<br> Date: 2025-10-03<br>Ref: R202510030942522793', 'TVADEGBITE@GMAIL.COM', '2025-10-03 09:42:52', '2025-10-03 09:42:52'),
(15, 185, NULL, 'RichGreen Masters Investment Limited Credit Alert', 'Credit Amt: N80962.8<br> Desc: fixed deposit investment interest<br>Avail Bal: N80,962.80<br> Date: 2025-10-04<br>Ref: Fd202510040757557828', 'princious.tunde@gmail.com', '2025-10-04 07:57:55', '2025-10-04 07:57:55'),
(16, 185, NULL, 'RichGreen Masters Investment Limited Debit Alert', 'Debit Amt: N8096.28<br> Desc: Fixed deposit withholding tax <br>Avail Bal: N72,866.52<br> Date: 2025-10-04<br>Ref: Whtx202510040757566973', 'princious.tunde@gmail.com', '2025-10-04 07:57:56', '2025-10-04 07:57:56'),
(17, 29, NULL, 'RichGreen Masters Investment Limited Debit Alert', 'Debit Amt: N72,866.52<br> Desc: INT PAID TO YUSUF AYOTUNDE EBENEZER-03/10/2025 <br>Avail Bal: N0.00<br>Date: 2025-10-06<br>Ref: Cgl202510040758293975', 'princious.tunde@gmail.com', '2025-10-06 12:40:07', '2025-10-06 12:40:07'),
(18, 29, NULL, 'RichGreen Masters Investment Limited Debit Alert', 'Debit Amt: N1,124,693.00<br> Desc: LOAN DISBURSEMENT/ VINCENT ADEGBITE/ 3/10/2025 <br>Avail Bal: N0.00<br>Date: 2025-10-16<br>Ref: Cgl202510160141391698', 'TVADEGBITE@GMAIL.COM', '2025-10-16 13:43:13', '2025-10-16 13:43:13'),
(19, 185, NULL, 'RichGreen Masters Investment Limited Credit Alert', 'Credit Amt: N2,698,760.00<br> Desc: fixed deposit investment liquidation <br>Avail Bal: N2,698,760.00<br> Date: 2025-11-04<br>Ref: Fd202511041247258739', 'princious.tunde@gmail.com', '2025-11-04 12:47:25', '2025-11-04 12:47:25'),
(20, 29, NULL, 'RichGreen Masters Investment Limited Credit Alert', 'Credit Amt: N80,962.80<br> Desc: fixed deposit investment interest--93637082 <br>Avail Bal: N2,779,722.80<br>Date: 2025-11-04<br>Ref: Glc202511041252345140', 'princious.tunde@gmail.com', '2025-11-04 12:59:12', '2025-11-04 12:59:12'),
(21, 29, NULL, 'RichGreen Masters Investment Limited Debit Alert', 'Debit Amt: N8,096.28<br> Desc: withholding tax--93637082 <br>Avail Bal: N2,771,626.52<br>Date: 2025-11-04<br>Ref: Cgl202511041253083824', 'princious.tunde@gmail.com', '2025-11-04 12:59:50', '2025-11-04 12:59:50'),
(22, 1, NULL, 'Upcoming Payment Reminder', 'Dear ADEGBITE VINCENT BABATUNDE,You have an upcoming payment of N221,667.00 due on 01-12-2025 for loan 0210259101. Please make your payment. Thank you<br> Loan Payment: 0.00<br> Loan Due: 2,390,004.00<br>Loan Balance: 2,390,004.00', 'TVADEGBITE@GMAIL.COM', '2025-11-27 02:05:06', '2025-11-27 02:05:06'),
(23, 1, NULL, 'Missed Payment', 'Dear ADEGBITE VINCENT BABATUNDE,You missed  payment of N221,667.00 which was due on 01-12-2025 for loan 0210259101. Please make your payment. Thank you<br> Loan Payment: 0.00<br> Loan Due: 2,390,004.00<br>Loan Balance: 2,390,004.00', 'TVADEGBITE@GMAIL.COM', '2025-11-29 02:05:06', '2025-11-29 02:05:06'),
(24, 1, NULL, 'loan repayment', 'ADEGBITE VINCENT BABATUNDE, your loan of 221,667.00is not paid due to insuffient balance, an outstanding payment will be deducted from your account <br>Regards<br>RichGreen Masters Investment Limited', 'TVADEGBITE@GMAIL.COM', '2025-12-01 03:00:08', '2025-12-01 03:00:08'),
(25, 29, NULL, 'RichGreen Masters Investment Limited Credit Alert', 'Credit Amt: N221,667.00<br> Desc: LOAN REPAYMENT/CASHMATRIX/ADEGBITE VINCENT 02/12/2025 <br>Avail Bal: N0.00<br>Date: 2025-12-03<br>Ref: Glc202512030540527838', 'TVADEGBITE@GMAIL.COM', '2025-12-03 18:21:55', '2025-12-03 18:21:55'),
(26, 185, NULL, 'RichGreen Masters Investment Limited Credit Alert', 'Credit Amt: N2,854,775.31<br> Desc: fixed deposit investment <br>Avail Bal: N2,854,775.32<br> Date: 2025-12-04<br>Ref: Fd202512040500139658', 'princious.tunde@gmail.com', '2025-12-04 05:00:13', '2025-12-04 05:00:13'),
(27, 185, NULL, 'RichGreen Masters Investment Limited Debit Alert', 'Debit Amt: N8,314.88<br> Desc: Fixed deposit withholding tax <br>Avail Bal: N2,846,460.44<br> Date: 2025-12-04<br>Ref: Whtx202512040500146907', 'princious.tunde@gmail.com', '2025-12-04 05:00:14', '2025-12-04 05:00:14'),
(28, 1, NULL, 'Upcoming Payment Reminder', 'Dear ADEGBITE VINCENT BABATUNDE,You have an upcoming payment of N216,667.00 due on 01-01-2026 for loan 0210259101. Please make your payment. Thank you<br> Loan Payment: 221,667.00<br> Loan Due: 2,390,004.00<br>Loan Balance: 2,168,337.00', 'TVADEGBITE@GMAIL.COM', '2025-12-28 02:05:05', '2025-12-28 02:05:05'),
(29, 185, NULL, 'RichGreen Masters Investment Limited Credit Alert', 'Credit Amt: N2,771,626.51<br> Desc: fixed deposit investment liquidation <br>Avail Bal: N2,846,460.44<br> Date: 2025-12-29<br>Ref: Fd202512290949475084', 'princious.tunde@gmail.com', '2025-12-29 09:49:47', '2025-12-29 09:49:47'),
(30, 1, NULL, 'Missed Payment', 'Dear ADEGBITE VINCENT BABATUNDE,You missed  payment of N216,667.00 which was due on 01-01-2026 for loan 0210259101. Please make your payment. Thank you<br> Loan Payment: 221,667.00<br> Loan Due: 2,390,004.00<br>Loan Balance: 2,168,337.00', 'TVADEGBITE@GMAIL.COM', '2025-12-30 02:05:06', '2025-12-30 02:05:06'),
(31, 1, NULL, 'loan repayment', 'ADEGBITE VINCENT BABATUNDE, your loan of 216,667.00is not paid due to insuffient balance, an outstanding payment will be deducted from your account <br>Regards<br>RichGreen Masters Investment Limited', 'TVADEGBITE@GMAIL.COM', '2026-01-01 03:00:09', '2026-01-01 03:00:09'),
(32, 185, NULL, 'RichGreen Masters Investment Limited Credit Alert', 'Credit Amt: N2,931,854.25<br> Desc: fixed deposit investment <br>Avail Bal: N2,931,854.25<br> Date: 2026-01-04<br>Ref: Fd202601040500192952', 'princious.tunde@gmail.com', '2026-01-04 05:00:19', '2026-01-04 05:00:19'),
(33, 185, NULL, 'RichGreen Masters Investment Limited Debit Alert', 'Debit Amt: N8,539.38<br> Desc: Fixed deposit withholding tax <br>Avail Bal: N2,923,314.87<br> Date: 2026-01-04<br>Ref: Whtx202601040500195299', 'princious.tunde@gmail.com', '2026-01-04 05:00:19', '2026-01-04 05:00:19'),
(34, 185, NULL, 'RichGreen Masters Investment Limited Credit Alert', 'Credit Amt: N2,846,460.44<br> Desc: fixed deposit investment liquidation <br>Avail Bal: N2,923,314.87<br> Date: 2026-01-12<br>Ref: Fd202601121127461802', 'princious.tunde@gmail.com', '2026-01-12 11:27:46', '2026-01-12 11:27:46'),
(35, 29, NULL, 'RichGreen Masters Investment Limited Credit Alert', 'Credit Amt: N221,667.00<br> Desc: LOAN REPAYMENT/CASHMATRIX/ADEGBITE VINCENT   13/01/2026 <br>Avail Bal: N5,000.00<br>Date: 2026-01-13<br>Ref: Glc202601130934104634', 'TVADEGBITE@GMAIL.COM', '2026-01-13 09:36:22', '2026-01-13 09:36:22'),
(36, 185, NULL, 'RichGreen Masters Investment Limited Credit Alert', 'Credit Amt: N2,923,314.87<br> Desc: fixed deposit investment liquidation <br>Avail Bal: N2,923,314.87<br> Date: 2026-01-16<br>Ref: Fd202601161229457446', 'princious.tunde@gmail.com', '2026-01-16 12:29:45', '2026-01-16 12:29:45'),
(37, 29, NULL, 'RichGreen Masters Investment Limited Debit Alert', 'Debit Amt: N100,000.00<br> Desc: PART LIQUIDATION--YUSUF AYOTUNDE EBENEZER/16/01/2026 <br>Avail Bal: N2,823,314.87<br>Date: 2026-01-19<br>Ref: Cgl202601190909293188', 'princious.tunde@gmail.com', '2026-01-19 13:05:39', '2026-01-19 13:05:39'),
(38, 1, NULL, 'Upcoming Payment Reminder', 'Dear ADEGBITE VINCENT BABATUNDE,You have an upcoming payment of N211,667.00 due on 01-02-2026 for loan 0210259101. Please make your payment. Thank you<br> Loan Payment: 221,667.00<br> Loan Due: 2,390,004.00<br>Loan Balance: 2,168,337.00', 'TVADEGBITE@GMAIL.COM', '2026-01-28 02:05:07', '2026-01-28 02:05:07'),
(39, 1, NULL, 'Missed Payment', 'Dear ADEGBITE VINCENT BABATUNDE,You missed  payment of N211,667.00 which was due on 01-02-2026 for loan 0210259101. Please make your payment. Thank you<br> Loan Payment: 221,667.00<br> Loan Due: 2,390,004.00<br>Loan Balance: 2,168,337.00', 'TVADEGBITE@GMAIL.COM', '2026-01-30 02:05:07', '2026-01-30 02:05:07'),
(40, 1, NULL, 'loan repayment', 'ADEGBITE VINCENT BABATUNDE, your loan of 211,667.00is not paid due to insuffient balance, an outstanding payment will be deducted from your account <br>Regards<br>RichGreen Masters Investment Limited', 'TVADEGBITE@GMAIL.COM', '2026-02-01 03:00:10', '2026-02-01 03:00:10'),
(41, 185, NULL, 'RichGreen Masters Investment Limited Credit Alert', 'Credit Amt: N2823314.87<br> Desc: fixed deposit investment liquidation <br>Avail Bal: N2,876,957.85<br> Date: 2026-02-04<br>Ref: Fd202602040112359695', 'princious.tunde@gmail.com', '2026-02-04 13:12:35', '2026-02-04 13:12:35'),
(42, 185, NULL, 'RichGreen Masters Investment Limited Debit Alert', 'Debit Amt: N5364.298253<br> Desc: Fixed deposit withholding tax <br>Avail Bal: N2,871,593.55<br> Date: 2026-02-04<br>Ref: Whtx202602040112364060', 'princious.tunde@gmail.com', '2026-02-04 13:12:36', '2026-02-04 13:12:36'),
(43, 20, NULL, 'RichGreen Masters Investment Limited Credit Alert', 'Credit Amt: N32,538.78<br> Desc: SHORTFALL ON INTEREST <br>Avail Bal: N2,904,132.33<br>Date: 2026-02-04<br>Ref: Glc202602040213595615', 'princious.tunde@gmail.com', '2026-02-04 15:52:23', '2026-02-04 15:52:23'),
(44, 29, NULL, 'RichGreen Masters Investment Limited Debit Alert', 'Debit Amt: N50,000.00<br> Desc: RETURN002/ YUSUF AYOTUNDE EBENEZER--04/02/2026 <br>Avail Bal: N0.00<br>Date: 2026-02-05<br>Ref: Cgl202602050217272963', 'princious.tunde@gmail.com', '2026-02-05 19:47:14', '2026-02-05 19:47:14');

-- --------------------------------------------------------

--
-- Table structure for table `exchangerates`
--

CREATE TABLE `exchangerates` (
  `id` bigint UNSIGNED NOT NULL,
  `currency` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `currency_rate` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `currency_symbol` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `overdraftgl` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `exchangerates`
--

INSERT INTO `exchangerates` (`id`, `currency`, `currency_rate`, `currency_symbol`, `overdraftgl`, `created_at`, `updated_at`) VALUES
(1, 'dollar', '885', '$', '10163749', '2023-08-14 16:08:43', '2025-10-17 13:05:27'),
(2, 'pounds', '1145', '£', '10503840', '2023-08-22 16:11:16', '2025-10-17 13:44:51'),
(3, 'euro', '925', '€', '10801964', '2023-08-22 16:11:38', '2025-10-17 13:45:12'),
(4, 'canadian dollar', '780', 'CA$', '10761641', '2023-08-22 16:16:04', '2025-10-17 13:47:48');

-- --------------------------------------------------------

--
-- Table structure for table `expenses`
--

CREATE TABLE `expenses` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `expense_type_id` bigint UNSIGNED NOT NULL,
  `branch_id` bigint UNSIGNED DEFAULT NULL,
  `amount` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expense_account` varchar(225) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `credit_account` varchar(225) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `expslip` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date` date DEFAULT NULL,
  `month` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `year` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `recurring` tinyint NOT NULL DEFAULT '0',
  `recur_frequency` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `recur_start_date` date DEFAULT NULL,
  `recur_end_date` date DEFAULT NULL,
  `recur_next_date` date DEFAULT NULL,
  `recur_type` enum('daily','weekly','monthly','yearly') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `note` text COLLATE utf8mb4_unicode_ci,
  `file` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `expense_types`
--

CREATE TABLE `expense_types` (
  `id` bigint UNSIGNED NOT NULL,
  `expcat` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `branch_id` bigint DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `expense_types`
--

INSERT INTO `expense_types` (`id`, `expcat`, `name`, `branch_id`, `created_at`, `updated_at`) VALUES
(1, 'operating expenses', 'Stationeries', NULL, '2023-09-25 10:06:34', '2023-09-25 10:06:34'),
(2, 'admin expenses', 'SHAGAMU FARMS exp gl', NULL, '2023-09-29 18:03:17', '2023-09-29 18:03:17');

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint UNSIGNED NOT NULL,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fixed_deposits`
--

CREATE TABLE `fixed_deposits` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED DEFAULT NULL,
  `customer_id` bigint UNSIGNED NOT NULL,
  `fixed_deposit_product_id` bigint UNSIGNED NOT NULL,
  `accountofficer_id` bigint UNSIGNED NOT NULL,
  `approved_by_id` bigint UNSIGNED DEFAULT NULL,
  `declined_by_id` bigint UNSIGNED DEFAULT NULL,
  `closed_by_id` bigint UNSIGNED DEFAULT NULL,
  `fixed_deposit_code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `reference` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `old_disbursedate` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `old_maturedate` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `release_date` date DEFAULT NULL,
  `maturity_date` date DEFAULT NULL,
  `interest_start_date` date DEFAULT NULL,
  `first_payment_date` date DEFAULT NULL,
  `principal` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `interest_method` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `interest_rate` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `interest_period` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'day',
  `duration` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `duration_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'year',
  `payment_cycle` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'monthly',
  `status_id` int DEFAULT NULL,
  `fd_status` enum('open','fully_paid','defaulted','restructured','processing') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'open',
  `balance` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `applied_amount` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `approved_amount` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `approved_notes` text COLLATE utf8mb4_unicode_ci,
  `enable_withholding_tax` tinyint(1) DEFAULT '0',
  `withholding_tax` varchar(225) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `auto_book_investment` tinyint(1) NOT NULL DEFAULT '0',
  `closed_notes` text COLLATE utf8mb4_unicode_ci,
  `declined_notes` text COLLATE utf8mb4_unicode_ci,
  `approved_date` date DEFAULT NULL,
  `closed_date` date DEFAULT NULL,
  `declined_date` date DEFAULT NULL,
  `written_off_date` date DEFAULT NULL,
  `status` enum('pending','approved','disbursed','declined','withdrawn','written_off','closed','pending_reschedule','rescheduled','trashed') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `system_approve` tinyint(1) DEFAULT '0',
  `deleted_at` timestamp NULL DEFAULT NULL,
  `branch_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `fixed_deposits`
--

INSERT INTO `fixed_deposits` (`id`, `user_id`, `customer_id`, `fixed_deposit_product_id`, `accountofficer_id`, `approved_by_id`, `declined_by_id`, `closed_by_id`, `fixed_deposit_code`, `reference`, `old_disbursedate`, `old_maturedate`, `release_date`, `maturity_date`, `interest_start_date`, `first_payment_date`, `principal`, `interest_method`, `interest_rate`, `interest_period`, `duration`, `duration_type`, `payment_cycle`, `status_id`, `fd_status`, `balance`, `applied_amount`, `approved_amount`, `approved_notes`, `enable_withholding_tax`, `withholding_tax`, `auto_book_investment`, `closed_notes`, `declined_notes`, `approved_date`, `closed_date`, `declined_date`, `written_off_date`, `status`, `system_approve`, `deleted_at`, `branch_id`, `created_at`, `updated_at`) VALUES
(1, 28, 561, 1, 10, NULL, 29, NULL, '63427985', NULL, NULL, NULL, '2025-08-21', '2025-10-20', NULL, '2025-09-20', '1032252', 'monthly', '24', 'year', '1', 'month', 'monthly', NULL, 'open', '1032252', '1032252', NULL, NULL, 1, '10', 1, NULL, 'wrong posting', NULL, NULL, '2025-09-04', NULL, 'declined', 0, NULL, NULL, '2025-09-04 16:33:41', '2025-09-04 17:47:20'),
(2, 28, 560, 1, 10, NULL, 21, NULL, '85695285', NULL, NULL, NULL, '2025-08-21', '2025-10-20', NULL, '2025-09-20', '1032252', 'monthly', '24', 'year', '1', 'month', 'monthly', NULL, 'open', '1032252', '1032252', NULL, NULL, 1, '10', 1, NULL, 'DECLINE', NULL, NULL, '2025-09-04', NULL, 'declined', 0, NULL, NULL, '2025-09-04 16:34:55', '2025-09-04 17:49:03'),
(3, 28, 733, 1, 10, NULL, 21, NULL, '82351362', NULL, NULL, NULL, '2025-08-19', '2025-12-18', NULL, '2025-09-18', '6000000', 'monthly', '34', 'year', '3', 'month', 'monthly', NULL, 'open', '6000000', '6000000', NULL, NULL, 0, '10', 1, NULL, 'DECLINED', NULL, NULL, '2025-09-04', NULL, 'declined', 0, NULL, NULL, '2025-09-04 16:37:16', '2025-09-04 17:50:42'),
(4, 28, 142, 1, 10, NULL, 21, NULL, '19381001', NULL, NULL, NULL, '2025-08-21', '2025-12-20', NULL, '2025-09-20', '98000000', 'monthly', '30', 'year', '3', 'month', 'monthly', NULL, 'open', '98000000', '98000000', NULL, NULL, 0, '5', 1, NULL, 'DECLINE', NULL, NULL, '2025-09-04', NULL, 'declined', 0, NULL, NULL, '2025-09-04 16:39:51', '2025-09-04 17:52:27'),
(5, 28, 620, 1, 10, NULL, 28, NULL, '72877506', NULL, NULL, NULL, '2025-08-18', '2026-03-17', NULL, '2025-09-17', '47506780', 'monthly', '36', 'year', '6', 'month', 'monthly', NULL, 'open', '47506780', '47506780', NULL, NULL, 1, '10', 1, NULL, 'WRONG', NULL, NULL, '2025-09-04', NULL, 'declined', 0, NULL, NULL, '2025-09-04 16:41:51', '2025-09-04 16:50:54'),
(1844, 1, 3, 1, 10, 1, NULL, NULL, '34267970', NULL, NULL, NULL, '2026-02-06', '2026-05-06', NULL, '2026-03-06', '20000', 'monthly', '18', 'year', '3', 'month', 'monthly', NULL, 'open', '20000', '20000', '20000', 'Fixed Deposit 34267970--approved', 0, '5', 0, NULL, NULL, '2026-02-06', NULL, NULL, NULL, 'approved', 0, NULL, NULL, '2026-02-06 14:17:26', '2026-02-06 14:20:19'),
(1845, 1, 3, 1, 5, 1, NULL, NULL, '29306531', NULL, NULL, NULL, '2026-03-02', '2026-03-23', NULL, '2026-03-03', '10000', 'rollover', '18', 'year', '20', 'days', 'daily', NULL, 'open', '10000', '10000', '10000', 'Fixed Deposit 29306531--approved', 0, '5', 0, NULL, NULL, '2026-03-02', NULL, NULL, NULL, 'approved', 0, NULL, NULL, '2026-03-02 09:42:49', '2026-03-02 10:58:21'),
(1846, 1, 3, 1, 8, 1, NULL, NULL, '41129781', NULL, NULL, NULL, '2026-03-02', '2026-03-18', NULL, '2026-03-03', '5000', 'rollover', '18', 'year', '15', 'days', 'daily', NULL, 'open', '5000', '5000', '5000', 'Fixed Deposit 41129781--approved', 0, '5', 0, NULL, NULL, '2026-03-02', NULL, NULL, NULL, 'approved', 0, NULL, NULL, '2026-03-02 10:42:18', '2026-03-02 10:54:24'),
(1847, 1, 3, 1, 8, 1, NULL, NULL, '19879297', NULL, NULL, NULL, '2026-03-02', NULL, NULL, '2026-04-02', '8000', 'rollover', '18', 'year', '30', 'days', 'daily', NULL, 'open', '8000', '8000', '8000', 'Fixed Deposit 19879297--tdhsjf', 0, '5', 0, NULL, NULL, '2026-03-02', NULL, NULL, NULL, 'approved', 0, NULL, NULL, '2026-03-02 11:08:56', '2026-03-02 14:55:33'),
(1848, 1, 3, 1, 11, 1, NULL, NULL, '97520906', NULL, NULL, NULL, '2026-03-02', '2026-03-23', NULL, '2026-03-03', '9000', 'monthly', '18', 'year', '20', 'days', 'daily', NULL, 'open', '9000', '9000', '9000', 'Fixed Deposit 97520906--yrhgkerg', 0, '5', 0, NULL, NULL, '2026-03-02', NULL, NULL, NULL, 'approved', 0, NULL, NULL, '2026-03-02 14:57:23', '2026-03-02 14:58:30'),
(1849, 1, 3, 1, 1, 1, NULL, NULL, '67262172', NULL, NULL, NULL, '2026-03-06', '2026-06-06', NULL, '2026-04-06', '10000', 'monthly', '18', 'year', '2', 'month', 'monthly', NULL, 'open', '10000', '10000', '10000', 'Fixed Deposit 67262172--afsyddj', 0, '5', 0, NULL, NULL, '2026-03-06', NULL, NULL, NULL, 'approved', 0, NULL, NULL, '2026-03-06 08:17:22', '2026-03-06 08:59:18'),
(1850, 1, 3, 1, 8, 1, NULL, NULL, '14632028', NULL, NULL, NULL, '2026-03-09', '2026-06-09', NULL, '2026-04-09', '10000', 'rollover', '18', 'year', '2', 'month', 'monthly', NULL, 'open', '10000', '10000', '10000', 'Fixed Deposit 14632028--bvgcvbn', 0, '5', 0, NULL, NULL, '2026-03-09', NULL, NULL, NULL, 'approved', 0, NULL, NULL, '2026-03-09 13:38:04', '2026-03-09 14:43:06'),
(1851, 1, 3, 1, 10, 1, NULL, NULL, '96925391', NULL, NULL, NULL, '2026-03-10', '2026-03-26', NULL, '2026-03-11', '10000', 'rollover', '18', 'year', '15', 'days', 'daily', NULL, 'open', '10000', '10000', '10000', 'Fixed Deposit 96925391--sdggfsdjf', 0, '5', 0, NULL, NULL, '2026-03-10', NULL, NULL, NULL, 'approved', 0, NULL, NULL, '2026-03-09 14:52:00', '2026-03-10 15:42:02'),
(1852, 1, 3, 1, 10, 1, NULL, NULL, '36598982', NULL, NULL, NULL, '2026-03-12', '2026-03-23', NULL, '2026-03-13', '10000', 'rollover', '18', 'year', '10', 'days', 'daily', NULL, 'open', '10000', '10000', '10000', 'Fixed Deposit 36598982--dgsdhgj', 0, '5', 0, NULL, NULL, '2026-03-12', NULL, NULL, NULL, 'approved', 0, NULL, NULL, '2026-03-12 11:45:46', '2026-03-12 11:46:15');

-- --------------------------------------------------------

--
-- Table structure for table `fixed_deposit_products`
--

CREATE TABLE `fixed_deposit_products` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `minimum_principal` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `default_principal` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `maximum_principal` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `interest_method` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `interest_rate` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `interest_period` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'year',
  `minimum_interest_rate` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `default_interest_rate` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `maximum_interest_rate` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `interest_payment` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'monthly',
  `default_duration` varchar(225) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `default_duration_type` varchar(225) COLLATE utf8mb4_unicode_ci DEFAULT 'monthly',
  `branch_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `fixed_deposit_products`
--

INSERT INTO `fixed_deposit_products` (`id`, `user_id`, `name`, `minimum_principal`, `default_principal`, `maximum_principal`, `interest_method`, `interest_rate`, `interest_period`, `minimum_interest_rate`, `default_interest_rate`, `maximum_interest_rate`, `interest_payment`, `default_duration`, `default_duration_type`, `branch_id`, `created_at`, `updated_at`) VALUES
(1, 5, 'fixed deposit', '100', '1000000', '5000000000', 'monthly', NULL, 'month', '2', '2', '2', 'monthly', '2', 'month', NULL, '2023-07-05 12:41:38', '2024-05-08 13:45:41'),
(2, 5, 'call deposit', '100', '1000000', '5000000000', 'monthly', NULL, 'month', '3', '3', '5', 'monthly', '3', 'month', NULL, '2023-07-05 12:42:32', '2025-10-15 17:30:13'),
(3, 5, 'fixed deposit @4%', '100', '1000000', '5000000000', 'monthly', NULL, 'month', '4', '4', '4', 'monthly', '5', 'month', NULL, '2023-07-05 12:44:16', '2024-05-08 13:34:46');

-- --------------------------------------------------------

--
-- Table structure for table `fxmgmts`
--

CREATE TABLE `fxmgmts` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED DEFAULT NULL,
  `accountofficer_id` bigint UNSIGNED DEFAULT NULL,
  `exchangerate_id` bigint UNSIGNED DEFAULT NULL,
  `customer` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `purchase_exchange_rate` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sales_exchange_rate` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `naria_amount` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `foreign_amount` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fee_amount` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  `fx_reference` varchar(225) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `purchase_naria_from` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `purchase_recieve_currency` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payment_mode` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sales_from` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `glcredit` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sales_paid_to` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sales_margin` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `glmargin` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `debitglmargin` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `beneficiary` text COLLATE utf8mb4_unicode_ci,
  `beneficiary_bank` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `depositor` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `actual_payment` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `swift_bank_charges` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `fxtype` varchar(225) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `initiated_by` varchar(225) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `approved_by` varchar(225) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `branch_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tranx_date` date DEFAULT NULL,
  `rev_status` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `fxmgmts`
--

INSERT INTO `fxmgmts` (`id`, `user_id`, `accountofficer_id`, `exchangerate_id`, `customer`, `purchase_exchange_rate`, `sales_exchange_rate`, `naria_amount`, `foreign_amount`, `fee_amount`, `fx_reference`, `purchase_naria_from`, `purchase_recieve_currency`, `payment_mode`, `sales_from`, `glcredit`, `sales_paid_to`, `sales_margin`, `glmargin`, `debitglmargin`, `beneficiary`, `beneficiary_bank`, `depositor`, `actual_payment`, `swift_bank_charges`, `description`, `fxtype`, `initiated_by`, `approved_by`, `status`, `branch_id`, `tranx_date`, `rev_status`, `created_at`, `updated_at`) VALUES
(1, 20, 4, 1, 'CERBA LANCET', '1520', '1535', '8749500', '5700', '0', 'Fx202510211211365341', NULL, NULL, 'bank', '143', NULL, '257', '85500', NULL, NULL, 'CERBA LANCET', 'STANDARD CHARTERED', 'RICHGREEN', NULL, '51200', '@1535/5700(dollar)--sales', 'sales', 'Abiodun Shoyomi', NULL, 'declined', NULL, '2025-10-21', 0, '2025-10-21 12:11:36', '2025-10-21 12:11:36');

-- --------------------------------------------------------

--
-- Table structure for table `general_ledgers`
--

CREATE TABLE `general_ledgers` (
  `id` bigint UNSIGNED NOT NULL,
  `account_category_id` bigint UNSIGNED DEFAULT NULL,
  `user_id` bigint UNSIGNED DEFAULT NULL,
  `branch_id` bigint UNSIGNED DEFAULT NULL,
  `gl_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `gl_code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `gl_type` enum('asset','liability','capital','income','expense') COLLATE utf8mb4_unicode_ci NOT NULL,
  `account_balance` decimal(30,2) NOT NULL DEFAULT '0.00',
  `currency_id` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `general_ledgers`
--

INSERT INTO `general_ledgers` (`id`, `account_category_id`, `user_id`, `branch_id`, `gl_name`, `gl_code`, `gl_type`, `account_balance`, `currency_id`, `status`, `created_at`, `updated_at`) VALUES
(1, 41, 1, NULL, 'lekki devt. property', '10738800', 'asset', 15834650000.00, NULL, 1, '2023-01-11 23:28:50', '2025-12-23 16:56:44'),
(2, 133, 1, 2, 'rich energy zenith dollars', '10238602', 'asset', 0.00, '1', 1, '2023-01-11 23:28:50', '2025-08-05 15:54:08'),
(3, 133, 1, 2, 'asset matrix gl usd', '10677960', 'asset', 0.00, NULL, 1, '2023-01-11 23:28:50', '2025-04-09 11:27:13'),
(4, 16, 1, 2, 'naira equivalent of dollar', '10458556', 'asset', 0.00, '1', 0, '2023-01-11 23:28:50', '2025-05-26 14:23:40'),
(6, NULL, 1, 2, 'micro insurance premium', '20153814', 'liability', 0.00, NULL, 0, '2023-01-11 23:28:50', '2023-06-10 22:43:31'),
(7, 40, 1, 2, 'pounds cash', '20142330', 'liability', 0.00, '2', 1, '2023-01-11 23:28:50', '2023-07-25 12:18:17'),
(9, NULL, 1, 2, 'statutory reserve', '30572266', 'capital', 0.00, NULL, 0, '2023-01-11 23:28:50', '2023-01-11 23:28:50'),
(11, 97, 1, 2, '2023 financial year p&l', '30785510', 'capital', 0.00, NULL, 1, '2023-01-11 23:28:50', '2023-07-23 05:22:46'),
(12, 41, 1, 2, 'felicity court property -lekki phase 1-', '10133520', 'asset', 92000000.00, NULL, 1, '2023-01-11 23:28:50', '2025-09-24 19:17:26'),
(13, 102, 1, 2, 'purchase of dollar gl (naira)', '10396991', 'asset', 3592539935.75, NULL, 1, '2023-01-11 23:28:50', '2026-02-05 20:14:31'),
(14, 102, 1, 2, 'purchase of pounds gl (naira)', '10598041', 'asset', 536053008.16, NULL, 1, '2023-01-11 23:28:50', '2026-02-05 18:31:41'),
(15, NULL, 1, 2, 'staff salary fee interest income', '40863081', 'income', 0.00, NULL, 0, '2023-01-11 23:28:50', '2023-06-10 23:24:59'),
(16, 72, 1, 2, 'agent income', '40830744', 'income', 0.00, NULL, 1, '2023-01-11 23:28:50', '2025-05-22 13:46:57'),
(17, 68, 1, 2, 'mining expense', '50452090', 'expense', 0.00, NULL, 1, '2023-01-11 23:28:50', '2025-08-28 17:29:44'),
(18, 47, 1, 2, 'pos purchase', '50282581', 'expense', 0.00, NULL, 1, '2023-01-11 23:28:50', '2025-04-01 12:14:10'),
(19, NULL, 1, 2, 'investment note - interest expense', '50218625', 'expense', 0.00, NULL, 1, '2023-01-11 23:28:50', '2025-04-02 23:06:57'),
(20, NULL, 1, 2, 'suspense account(liability)', '20993529', 'liability', 0.00, NULL, 0, '2023-01-13 21:52:44', '2023-06-10 23:30:23'),
(21, 80, 1, 2, 'overdraft savings gl dollar', '10163749', 'asset', 118.24, '1', 0, '2023-01-15 20:16:57', '2025-11-29 06:10:40'),
(22, NULL, 1, 2, 'suspense account(capital)', '30235195', 'capital', 0.00, NULL, 0, '2023-01-15 20:17:57', '2023-06-10 23:30:23'),
(23, NULL, 1, 2, 'suspense account(income)', '40171757', 'income', 0.00, NULL, 0, '2023-01-15 20:18:14', '2023-06-10 23:30:23'),
(24, NULL, 1, 2, 'suspense account(expense)', '50180282', 'expense', 0.00, NULL, 0, '2023-01-15 20:18:40', '2023-06-10 23:30:23'),
(25, 17, 1, 1, 'vault account', '10373391', 'asset', 0.00, NULL, 1, '2023-01-16 19:06:18', '2023-06-10 23:33:11'),
(26, 17, 1, 1, 'teller\'s till 1', '10923392', 'asset', 0.00, NULL, 1, '2023-01-16 19:15:16', '2026-02-03 11:23:11'),
(27, 32, 1, 2, 'ggt diagnostic fidelity', '10327129', 'asset', 0.00, NULL, 1, '2023-01-16 19:15:44', '2025-10-01 13:43:57'),
(28, 102, 1, 2, 'investment in mining', '10127293', 'asset', 47700000.00, NULL, 1, '2023-01-16 19:16:02', '2025-09-12 16:35:50'),
(29, 134, 1, 2, 'giftbills account', '10839235', 'asset', 500000.00, NULL, 1, '2023-03-20 20:30:37', '2025-10-27 14:29:59'),
(30, 134, 1, 1, 'vtpass account', '10221490', 'asset', 1000000.00, NULL, 1, '2023-03-20 20:30:55', '2025-11-19 12:34:19'),
(31, 32, 1, 2, 'company account(serling bank)', '10997918', 'asset', 0.00, NULL, 1, '2023-03-21 12:50:21', '2023-07-18 00:33:52'),
(32, 20, 1, 2, 'vtpass income', '40469341', 'income', 0.00, NULL, 1, '2023-03-22 14:10:26', '2023-06-27 16:48:44'),
(33, 20, 1, 2, 'giftbills income', '40920905', 'income', 0.00, NULL, 1, '2023-03-22 14:10:55', '2023-06-09 21:24:42'),
(34, NULL, 1, 2, 'recova loan collection account', '10205117', 'asset', 0.00, NULL, 1, '2023-03-25 18:41:20', '2025-04-09 15:50:33'),
(35, 134, 1, 2, 'investment in software', '10480994', 'asset', 0.00, NULL, 1, '2023-03-25 18:41:20', '2025-04-07 18:58:22'),
(36, 133, 1, 2, 'rg fcmb dollar', '10462565', 'asset', 3000.00, '1', 1, '2023-03-25 18:41:20', '2025-11-06 16:32:28'),
(37, 32, 1, 2, 'rg providus 5403876856', '10549120', 'asset', 1072583433.46, NULL, 1, '2023-03-25 18:41:20', '2026-02-06 10:12:22'),
(38, 32, 1, 1, 'igwt global 1012954941 keystone', '10575245', 'asset', -87200000.00, NULL, 1, '2023-03-25 18:41:20', '2025-12-01 15:35:00'),
(39, 16, 1, 2, 'naira equivalent of pounds', '10672141', 'asset', 0.00, '2', 0, '2023-03-25 18:41:20', '2025-05-26 14:25:23'),
(40, 131, 1, 2, 'all loan principal overdue', '10596204', 'asset', 0.00, NULL, 1, '2023-03-25 18:41:20', '2025-04-07 19:00:37'),
(41, 32, 1, 2, 'rg providus cocoa', '10531478', 'asset', 0.00, NULL, 1, '2023-03-25 18:41:20', '2025-07-14 14:30:53'),
(42, 16, 1, NULL, 'walk-in- fx (pounds transfers)', '10580145', 'asset', 22565.96, '2', 1, '2023-03-25 18:41:20', '2026-02-05 18:33:07'),
(43, 61, 1, 2, 'carrillion- lekki phase1', '10129645', 'asset', 0.00, NULL, 1, '2023-03-25 18:41:20', '2025-06-11 09:44:00'),
(44, 41, 1, 2, 'silverado properties- lekki phase 1', '10723449', 'asset', 300000000.00, NULL, 1, '2023-03-25 18:41:20', '2025-09-12 15:04:28'),
(45, 133, 1, 2, 'rg gtb dollar', '10816836', 'asset', 76642.07, '1', 1, '2023-03-25 18:41:20', '2026-02-05 19:10:15'),
(46, 113, 1, 2, 'migration savings dumping gl- pounds', '10689188', 'asset', 1167317.63, '2', 1, '2023-03-25 18:41:20', '2026-01-16 19:42:08'),
(47, 61, 1, 2, 'ggt diagnostics solutions limited', '10931732', 'asset', 301487000.00, NULL, 1, '2023-03-25 18:41:20', '2025-09-12 16:13:15'),
(48, 113, 1, 2, 'reconcilliation suspense', '10791190', 'asset', -10662332506.98, NULL, 1, '2023-03-25 18:41:20', '2025-12-15 16:15:54'),
(49, 102, 1, 2, 'scrap vessel-makas-08052025', '10733634', 'asset', 0.00, NULL, 1, '2023-03-25 18:41:20', '2025-07-30 13:40:04'),
(50, 133, 1, 2, 'rgm materials polaris dollars', '10270839', 'asset', 0.00, '1', 1, '2023-03-25 18:41:20', '2023-09-25 10:03:49'),
(51, 102, 1, NULL, 'investment in globe masters ltd gl', '10336725', 'asset', 0.00, NULL, 1, '2023-03-25 18:41:20', '2025-06-06 16:34:08'),
(52, 102, 1, 2, 'scrap vessel metal gl', '10985214', 'asset', 1185000000.00, NULL, 1, '2023-03-25 18:41:20', '2025-09-12 16:36:17'),
(53, 41, 1, 2, 'bareland at egbeda / akowonjo gl', '10260766', 'asset', 123600000.00, NULL, 1, '2023-03-25 18:41:20', '2025-09-12 15:04:57'),
(54, 32, 1, 2, 'rgm consolidated fid 5540025060', '10596872', 'asset', 1045525739.73, NULL, 1, '2023-03-25 18:41:20', '2026-01-20 17:39:35'),
(55, 61, 1, 2, 'pilot securities', '10515156', 'asset', 1328400000.00, NULL, 1, '2023-03-25 18:41:20', '2025-09-12 16:13:52'),
(56, 17, 1, 1, 'cash advance', '10228259', 'asset', 0.00, NULL, 1, '2023-03-25 18:41:20', '2025-04-02 16:53:21'),
(57, 32, 1, 2, 'rgm consolidated fbn 2044943958', '10618593', 'asset', 73194999.22, NULL, 1, '2023-03-25 18:41:20', '2026-02-05 20:09:56'),
(58, 32, 1, 2, 'richgreen masters capital fbn', '10619464', 'asset', 116800000.00, NULL, 1, '2023-03-25 18:41:20', '2026-01-30 18:05:05'),
(59, 32, 1, 2, 'rg fbn od acc 2045095201', '10477669', 'asset', 0.00, NULL, 1, '2023-03-25 18:41:20', '2025-04-26 16:51:41'),
(60, 133, 1, 2, 'rg gtb gbp', '10603042', 'asset', 10950.00, '2', 1, '2023-03-25 18:41:20', '2026-01-07 18:08:14'),
(61, 102, 1, 2, 'fringe infrastructure limited investment', '10469967', 'asset', 150000000.00, NULL, 1, '2023-03-25 18:41:20', '2025-09-12 16:38:09'),
(62, 61, 1, 2, 'subwaysob bdc ltd gl', '10568595', 'asset', 518961559.09, NULL, 1, '2023-03-25 18:41:20', '2025-09-12 16:22:08'),
(63, 61, 1, 2, 'springoak bdc gl', '10222684', 'asset', 100000000.00, NULL, 1, '2023-03-25 18:41:20', '2025-09-12 16:23:22'),
(64, 113, 1, 2, 'migration savings dumping gl- dollar-', '10359880', 'asset', 6229749.52, '1', 1, '2023-03-25 18:41:20', '2026-01-16 16:03:07'),
(65, 17, 1, 2, 'teller till -euro', '10628294', 'asset', -100.00, '3', 1, '2023-03-25 18:41:20', '2025-10-23 13:37:35'),
(66, 133, 1, 2, 'rg providus usd', '10929204', 'asset', 296957.95, '1', 1, '2023-03-25 18:41:20', '2026-01-20 16:01:13'),
(67, 41, 1, 2, 'property at lekki phase 1 , 2 bedroom, amusa 8-10 estate, plot7a', '10512808', 'asset', 137500000.00, NULL, 1, '2023-03-25 18:41:20', '2026-01-13 15:57:18'),
(68, 61, 1, 2, 'sambethel stores gl', '10553282', 'asset', 364273500.00, NULL, 1, '2023-03-25 18:41:20', '2025-09-12 16:26:42'),
(69, 41, 1, 2, 'bare land at opic, isheri, lagos', '10311588', 'asset', 75000000.00, NULL, 1, '2023-03-25 18:41:20', '2025-09-12 15:05:57'),
(70, 41, 1, 2, 'bare land at sangotedo, ajah, lagos', '10704117', 'asset', 200000000.00, NULL, 1, '2023-03-25 18:41:20', '2025-09-12 15:06:21'),
(71, 32, 1, 2, 'asset matrix virtual account gl', '10897866', 'asset', 0.00, NULL, 1, '2023-03-25 18:41:20', '2025-04-04 13:03:37'),
(72, 41, 1, 2, 'property at 4, oluseun close, abule odu, egbeda', '10591127', 'asset', 100000000.00, NULL, 1, '2023-03-25 18:41:20', '2025-09-12 15:06:50'),
(73, 133, 1, 2, 'rg uba dollar', '10342266', 'asset', 10600.00, '1', 1, '2023-03-25 18:41:20', '2025-12-03 18:46:07'),
(74, 17, 1, 2, 'rg uk-- pastor funso', '10798823', 'asset', 0.00, NULL, 1, '2023-03-25 18:41:20', '2025-04-02 21:54:59'),
(75, 41, 1, 2, 'property at 4, alhaji ajadi street, egbeda, lagos', '10536390', 'asset', 229000000.00, NULL, 1, '2023-03-25 18:41:20', '2026-02-02 18:47:06'),
(76, 41, 1, 2, 'property at peace estate, aboru lagos', '10354762', 'asset', 180000000.00, NULL, 1, '2023-03-25 18:41:20', '2025-09-12 15:07:50'),
(77, 41, 1, 2, 'property at 9, olaiya treet, egbeda, lagos', '10446027', 'asset', 250000000.00, NULL, 1, '2023-03-25 18:41:20', '2025-12-12 17:13:49'),
(78, 41, 1, 2, 'property at 25, talabi estate, adeniyi jones, ikeja', '10653231', 'asset', 350000000.00, NULL, 1, '2023-03-25 18:41:20', '2025-09-12 15:09:17'),
(79, 32, 1, 2, 'rgm energy fbn', '10994226', 'asset', 0.00, NULL, 1, '2023-03-25 18:41:20', '2025-05-26 14:16:12'),
(80, 32, 1, 2, 'sambethel superstore wema bank 0122836181', '10680550', 'asset', 0.00, NULL, 1, '2023-03-25 18:41:20', '2023-07-31 13:11:27'),
(81, NULL, 1, 2, 'keystone fixed deposit', '10822350', 'asset', 0.00, NULL, 1, '2023-03-25 18:41:20', '2025-03-07 10:45:37'),
(82, 133, 1, 2, 'cap plc gl', '10907795', 'asset', 0.00, NULL, 1, '2023-03-25 18:41:20', '2025-04-09 15:21:37'),
(83, 113, 1, 2, 'migration savings dumping gl naira', '10237333', 'asset', 41638391667.37, NULL, 1, '2023-03-25 18:41:20', '2026-01-28 15:35:54'),
(84, 32, 1, 2, 'gtb bank rg 0654019026', '10424117', 'asset', 50620789.81, NULL, 1, '2023-03-25 18:41:20', '2026-02-05 20:19:07'),
(86, 102, 1, 2, 'pipleves ltd investment', '10570254', 'asset', 90000000.00, NULL, 1, '2023-03-25 18:41:20', '2025-12-19 12:09:06'),
(87, 133, 1, 2, 'richgreen keystone(usd) 1009085906', '10514759', 'asset', 140000.00, '1', 1, '2023-03-25 18:41:20', '2025-12-09 16:03:34'),
(88, 61, 1, 2, 'rgm material solution ltd gl', '10761396', 'asset', 250000000.00, NULL, 1, '2023-03-25 18:41:20', '2025-09-12 16:27:22'),
(89, 102, 1, 2, 'cocoa inventory gl', '10570200', 'asset', 0.00, NULL, 1, '2023-03-25 18:41:20', '2025-07-24 18:44:06'),
(90, 102, 1, 2, 'cashew inventory gl', '10909105', 'asset', 0.00, NULL, 1, '2023-03-25 18:41:20', '2025-07-24 18:07:39'),
(91, 17, 1, 2, 'petty cash gl', '10987740', 'asset', 673730.00, NULL, 1, '2023-03-25 18:41:20', '2026-02-05 18:27:03'),
(92, 59, 1, 2, 'loan gl pounds', '10639015', 'asset', 0.00, '2', 1, '2023-03-25 18:41:20', '2025-08-12 13:42:27'),
(93, 41, 1, NULL, 'ggt diagnostics head office', '10195849', 'asset', 611890000.00, NULL, 1, '2023-03-25 18:41:20', '2025-12-30 15:14:52'),
(94, 80, 1, 2, 'overdraft savings gl cad', '10761641', 'asset', 0.00, '4', 1, '2023-03-25 18:41:20', '2025-09-03 12:19:02'),
(95, 32, 1, 2, 'sterling bank sambethel 0068969186', '10763261', 'asset', 0.00, NULL, 1, '2023-03-25 18:41:20', '2025-08-08 14:08:17'),
(96, 69, 1, NULL, 'monthly contribution investment', '10677203', 'asset', 20000000.00, NULL, 1, '2023-03-25 18:41:20', '2025-09-12 16:47:11'),
(97, 102, 1, 2, 'apex group gl', '10849135', 'asset', 509871360.00, NULL, 1, '2023-03-25 18:41:20', '2026-01-22 18:21:00'),
(98, 17, 1, 2, 'teller till -naira', '10355402', 'asset', 900000.00, NULL, 1, '2023-03-25 18:41:20', '2025-10-10 18:20:52'),
(99, 17, 1, 2, 'teller till -dollar', '10905338', 'asset', 1300671.86, '1', 1, '2023-03-25 18:41:20', '2026-02-05 19:10:15'),
(100, 17, 1, 2, 'teller till -pounds', '10759778', 'asset', 4900.00, '2', 1, '2023-03-25 18:41:20', '2026-01-30 19:02:14'),
(101, 41, 1, 2, 'akowonjo property(fixed asset)', '10751172', 'asset', 250000000.00, NULL, 1, '2023-03-25 18:41:20', '2025-09-12 15:12:31'),
(102, 61, 1, 2, 'dot financials', '10972852', 'asset', 903460000.00, NULL, 1, '2023-03-25 18:41:20', '2025-12-31 15:23:54'),
(103, 16, 1, 2, 'walk-in-fx (dollar transfers)', '10829844', 'asset', -918949.06, '1', 1, '2023-03-25 18:41:20', '2026-02-05 20:14:49'),
(104, 41, 1, 2, 'asset matrix project', '10437817', 'asset', 31500000.00, NULL, 1, '2023-03-25 18:41:20', '2025-11-20 17:22:02'),
(105, 114, 1, 2, 'migration overdraft dumping gl- naira-', '10424650', 'asset', 0.00, NULL, 1, '2023-03-25 18:41:20', '2025-09-03 15:50:42'),
(106, 61, 1, 2, 'rgm consolidated-cashew', '10803542', 'asset', 0.00, NULL, 1, '2023-03-25 18:41:20', '2025-07-30 13:39:09'),
(107, 32, 1, 2, 'richgreen masters capital keystone bank (1013633993)', '10822434', 'asset', 0.00, NULL, 1, '2023-03-25 18:41:20', '2025-05-02 17:40:42'),
(108, 61, 1, 2, 'rg real estate project cost gl', '10494427', 'asset', 0.00, NULL, 1, '2023-03-25 18:41:20', '2025-04-12 11:59:11'),
(109, 102, 1, 2, 'prime host-sesame export', '10754001', 'asset', 7657000.00, NULL, 1, '2023-03-25 18:41:20', '2026-02-04 17:53:09'),
(110, 17, 1, 2, 'tellers till cad', '10143701', 'asset', 20.00, '4', 1, '2023-03-25 18:41:20', '2025-12-11 17:37:24'),
(112, 59, 1, 2, 'loan outstanding suspense gl', '10816440', 'asset', -232218333.00, NULL, 0, '2023-03-25 18:41:20', '2025-11-21 06:29:33'),
(113, 113, 1, 2, 'migration savings dumping gl- cad', '10227446', 'asset', 441018.19, '4', 1, '2023-03-25 18:41:20', '2025-12-12 14:22:36'),
(114, 80, 1, 2, 'overdraft savings gl naira', '10178524', 'asset', 552801867.40, NULL, 0, '2023-03-25 18:41:20', '2025-11-29 06:10:17'),
(115, 86, 1, 2, 'transactions with asset matrix mfb', '10704086', 'asset', 226645870.70, NULL, 1, '2023-03-25 18:41:20', '2026-02-05 18:47:19'),
(116, 59, 1, 2, 'loan gl dollar', '10620745', 'asset', 33000.00, '1', 1, '2023-03-25 18:41:20', '2026-01-09 03:00:09'),
(117, 113, 1, 2, 'migration liabilities dumping gl', '10192640', 'asset', 0.00, NULL, 1, '2023-03-25 18:41:20', '2025-09-12 11:46:17'),
(118, 16, 1, 2, 'zilla gl', '10515452', 'asset', 0.00, NULL, 1, '2023-03-25 18:41:20', '2025-04-02 22:24:36'),
(119, 133, 1, 2, 'rg wema usd 0620189613', '10158294', 'asset', -12600.00, '1', 1, '2023-03-25 18:41:20', '2025-12-24 14:32:03'),
(120, 32, 1, 2, 'keystone bank rg 1007039314', '10409042', 'asset', 0.00, NULL, 1, '2023-03-25 18:41:20', '2025-10-01 13:44:50'),
(121, 32, 1, 2, 'polaris bank rg 4010026420', '10130271', 'asset', 0.00, NULL, 1, '2023-03-25 18:41:20', '2025-04-09 15:37:47'),
(122, 32, 1, 2, 'zenith bank rich energy concept--- rg—1218542571', '10569288', 'asset', 0.00, NULL, 1, '2023-03-25 18:41:20', '2025-04-07 18:57:32'),
(123, 32, 1, 2, 'polaris rgm material', '10446819', 'asset', 0.00, NULL, 1, '2023-03-25 18:41:20', '2025-04-07 19:02:06'),
(124, 80, 1, 2, 'overdraft naira gl', '10936739', 'asset', 0.00, NULL, 0, '2023-03-25 18:41:20', '2025-09-04 10:42:51'),
(125, 32, 1, 2, 'ggt diagnostics gl', '10757150', 'asset', 0.00, NULL, 1, '2023-03-25 18:41:21', '2025-09-01 15:50:44'),
(127, 32, 1, 2, 'sambethel stores keystone bank 1009015684', '10264337', 'asset', -99400000.00, NULL, 1, '2023-03-25 18:41:21', '2025-12-01 15:30:01'),
(128, 32, 1, NULL, 'uba 1 rg', '10603851', 'asset', 241550000.00, NULL, 1, '2023-03-25 18:41:21', '2026-01-13 17:03:11'),
(129, 32, 1, 2, 'rg premium trust bank-0040199009', '10357093', 'asset', 0.00, NULL, 1, '2023-03-25 18:41:21', '2025-10-01 13:45:37'),
(130, 32, 1, 2, 'zenith bank rg 1013712410', '10677628', 'asset', 400000.00, NULL, 1, '2023-03-25 18:41:21', '2026-02-05 19:11:09'),
(131, 16, 1, 1, 'shortages', '10259119', 'asset', 0.00, NULL, 1, '2023-03-25 18:41:21', '2023-06-10 23:17:59'),
(132, 41, 1, NULL, 'orelope house', '10275374', 'asset', 209357800.00, NULL, 1, '2023-03-25 18:41:21', '2025-12-08 14:54:16'),
(133, 32, 1, 2, 'abbey bank gl', '10125377', 'asset', 0.00, NULL, 1, '2023-03-25 18:41:21', '2025-08-07 20:25:45'),
(134, 59, 1, 2, 'staff loans', '10297264', 'asset', 0.00, NULL, 1, '2023-03-25 18:41:21', '2025-04-23 12:50:24'),
(135, 16, 1, 2, 'dway remit', '10207237', 'asset', 0.00, NULL, 1, '2023-03-25 18:41:21', '2025-04-02 22:17:57'),
(136, 16, 1, 2, 'lockit tech', '10653699', 'asset', 0.00, NULL, 1, '2023-03-25 18:41:21', '2025-04-02 22:16:52'),
(137, 133, 1, 2, 'sasha fx gl', '10564344', 'asset', 0.00, NULL, 1, '2023-03-25 18:41:21', '2025-04-09 15:40:55'),
(138, 133, 1, 2, 'rgm consolidated company ltd fbn 2045482896', '10229831', 'asset', 0.00, NULL, 1, '2023-03-25 18:41:21', '2025-05-01 15:50:34'),
(139, 41, 1, 2, 'shagamu farm at shagamu, ogun state', '10989932', 'asset', 413020000.00, NULL, 1, '2023-03-25 18:41:21', '2026-02-02 18:45:05'),
(140, 133, 1, 2, 'uac fx gl', '10990965', 'asset', 0.00, NULL, 1, '2023-03-25 18:41:21', '2025-06-13 19:27:51'),
(141, 84, 1, NULL, 'excavator (320 tons)', '10490462', 'asset', 65000000.00, NULL, 1, '2023-03-25 18:41:21', '2025-09-12 16:34:34'),
(142, 32, 1, 2, 'richgreen cash matrix', '10582327', 'asset', 0.00, NULL, 1, '2023-03-25 18:41:21', '2025-04-09 15:41:29'),
(143, 32, 1, 2, 'rgm gtb', '10567334', 'asset', 0.00, NULL, 1, '2023-03-25 18:41:21', '2025-10-21 12:11:36'),
(144, 133, 1, 2, 'rg uk( oyeku) gbp', '10644379', 'asset', 0.00, NULL, 1, '2023-03-25 18:41:21', '2025-04-04 14:15:07'),
(145, 32, 1, 2, 'rgm consolidated keystone gl', '10428615', 'asset', 50000000.00, NULL, 1, '2023-03-25 18:41:21', '2025-12-22 15:10:33'),
(146, 133, 1, 2, 'rg uk gbp- pst sunkanmi', '10444331', 'asset', 0.00, NULL, 1, '2023-03-25 18:41:21', '2025-04-24 12:44:39'),
(147, NULL, 1, 2, 'unpaid account - sms charges', '10256593', 'asset', 0.00, NULL, 1, '2023-03-25 18:41:21', '2023-03-25 18:41:21'),
(148, 41, 1, 2, 'horizon ville estate property christ embassy road lekki', '10589628', 'asset', 366000000.00, NULL, 1, '2023-03-25 18:41:21', '2025-10-01 16:40:39'),
(149, 16, 1, 2, 'walk-in fx sales', '10287989', 'asset', -1447892724.61, NULL, 1, '2023-03-25 18:41:21', '2026-02-05 18:38:10'),
(150, 133, 1, 2, 'sambethel energy polaris dollars', '10210663', 'asset', 0.00, '1', 1, '2023-03-25 18:41:21', '2023-09-25 10:03:49'),
(151, 32, 1, 2, 'temitope keystone -1012561512', '10555103', 'asset', 0.00, NULL, 1, '2023-03-25 18:41:21', '2025-06-13 18:30:09'),
(152, 133, 1, 2, 'danbethel polaris dollar', '10501673', 'asset', 0.00, '1', 1, '2023-03-25 18:41:21', '2023-09-25 10:03:49'),
(153, 32, 1, 2, 'rgm energy solution gtb 0683928498', '10445253', 'asset', 1000000.00, NULL, 1, '2023-03-25 18:41:21', '2026-01-20 16:56:50'),
(154, 59, 1, 1, 'micro loans', '10739869', 'asset', 0.00, NULL, 1, '2023-03-25 18:41:21', '2025-08-05 09:20:08'),
(155, 133, 1, 2, 'sambethel enery dollar', '10849727', 'asset', 0.00, '1', 1, '2023-03-25 18:41:21', '2025-04-07 18:55:43'),
(156, 32, 1, 2, 'rg taj bank', '10776733', 'asset', 2000000.00, NULL, 1, '2023-03-25 18:41:21', '2025-11-26 14:27:10'),
(157, 41, 1, 2, 'abuja property', '10333690', 'asset', 1078514000.00, NULL, 1, '2023-03-25 18:41:21', '2026-02-04 19:11:43'),
(158, 16, 1, 2, 'gm fetch', '10391365', 'asset', 0.00, NULL, 1, '2023-03-25 18:41:21', '2025-07-25 16:47:52'),
(159, 133, 1, 2, '95229280--richgreen masters limited-revolut', '10464895', 'asset', 0.00, NULL, 1, '2023-03-25 18:41:21', '2025-05-06 12:56:00'),
(160, 102, 1, 2, 'placement with other banks (fd)', '10928019', 'asset', 0.00, NULL, 1, '2023-03-25 18:41:21', '2025-12-02 17:33:46'),
(161, 41, 1, NULL, 'assetmatrix head office', '10384176', 'asset', 250000000.00, NULL, 1, '2023-03-25 18:41:21', '2025-09-12 15:17:28'),
(162, 133, 1, 2, 'rgm capital -zenith pounds 5061559702', '10156659', 'asset', 0.00, '2', 1, '2023-03-25 18:41:21', '2025-06-11 17:40:28'),
(163, 102, 1, 2, 'call placements', '10882898', 'asset', 0.00, NULL, 1, '2023-03-25 18:41:21', '2025-07-14 18:41:17'),
(164, 133, 1, 2, 'rg stanbic dollar', '10481970', 'asset', -57000.00, '1', 1, '2023-03-25 18:41:21', '2026-01-28 17:14:51'),
(165, 133, 1, 2, 'esosa fx gl', '10141887', 'asset', 0.00, NULL, 1, '2023-03-25 18:41:21', '2024-03-18 10:37:54'),
(166, 133, 1, 2, 'rg access dollars', '10322812', 'asset', 0.00, '1', 1, '2023-03-25 18:41:21', '2025-04-08 11:44:49'),
(167, 41, 1, 2, 'scandic court 3, property, apt unit 106, blk31, lekki peninsula ilasan village ikate', '10833445', 'asset', 97816000.00, NULL, 1, '2023-03-25 18:41:21', '2025-12-08 18:51:19'),
(168, 133, 1, 2, 'rgm consolidated usd access 1886571660', '10894405', 'asset', -276756.96, '1', 1, '2023-03-25 18:41:21', '2026-02-05 18:34:58'),
(169, 59, 1, 1, 'business/sme loans', '10156223', 'asset', 35638188735.57, NULL, 1, '2023-03-25 18:41:21', '2026-02-06 03:00:13'),
(170, 32, 1, 2, 'subway sub bdc keystone bank', '10357622', 'asset', 0.00, NULL, 1, '2023-03-25 18:41:21', '2025-08-19 13:58:31'),
(171, 61, 1, NULL, 'marine vessel i (250 tons)', '10268368', 'asset', 210000000.00, NULL, 1, '2023-03-25 18:41:21', '2025-09-12 16:30:15'),
(172, 133, 1, 2, 'richgreen polaris dollar', '10116963', 'asset', 0.00, '1', 1, '2023-03-25 18:41:21', '2025-04-04 13:46:42'),
(173, 32, 1, 2, 'rgm consolidated company limited', '10805505', 'asset', 0.00, NULL, 1, '2023-03-25 18:41:21', '2025-05-01 15:44:54'),
(174, 32, 1, 2, 'polaris danbethel logistics', '10812793', 'asset', 0.00, NULL, 1, '2023-03-25 18:41:21', '2025-04-07 18:54:03'),
(175, 32, 1, 2, 'cash matrix gl', '10342218', 'asset', -675000000.00, NULL, 1, '2023-03-25 18:41:21', '2025-10-27 15:27:48'),
(176, 32, 1, 2, 'ggt keystone-1012573764', '10776316', 'asset', -161600000.00, NULL, 1, '2023-03-25 18:41:21', '2025-12-01 15:53:24'),
(177, 41, 1, 2, 'property at 9, younnis  bashorun v.i', '10473578', 'asset', 3509060000.00, NULL, 1, '2023-03-25 18:41:21', '2025-11-21 11:06:44'),
(178, 133, 1, 2, 'rgm evergy  gtb dollar', '10473113', 'asset', -5965.00, '1', 1, '2023-03-25 18:41:21', '2026-02-03 19:06:35'),
(179, 61, 1, 2, 'richgreen masters capital limited', '10721495', 'asset', 200000000.00, NULL, 1, '2023-03-25 18:41:21', '2025-09-12 16:29:48'),
(180, 32, 1, 2, 'transit gl', '10459040', 'asset', -5650000.00, NULL, 1, '2023-03-25 18:41:21', '2026-01-30 13:30:24'),
(181, 32, 1, 2, 'fidelity bank rgm 5610047314', '10899792', 'asset', 0.00, NULL, 1, '2023-03-25 18:41:21', '2025-11-21 17:44:59'),
(182, 32, 1, 2, 'sambethel energy access bank 0773074352', '10266043', 'asset', 0.00, NULL, 1, '2023-03-25 18:41:21', '2025-04-07 18:52:35'),
(183, 102, 1, 2, 'other bank investment', '10407676', 'asset', 0.00, NULL, 1, '2023-03-25 18:41:21', '2025-09-17 17:53:05'),
(184, 16, 1, 2, 'triumphant word christian centre', '10243906', 'asset', -500000.00, NULL, 1, '2023-03-25 18:41:21', '2026-01-22 12:10:12'),
(185, 32, 1, 2, 'rgm materials solution -fbn2046671462', '10914615', 'asset', -393695.15, NULL, 1, '2023-03-25 18:41:21', '2026-01-22 16:25:59'),
(186, 133, 1, 2, 'rgm capital -zenith usd 5075065282', '10738624', 'asset', 425195.10, '1', 1, '2023-03-25 18:41:21', '2026-02-05 18:18:18'),
(187, 32, 1, 2, 'rg keystone 1009085690', '10137901', 'asset', 5709110349.94, NULL, 1, '2023-03-25 18:41:21', '2026-02-03 17:57:58'),
(188, NULL, 1, 2, 'ussd session stock', '10893901', 'asset', 0.00, NULL, 1, '2023-03-25 18:41:21', '2023-03-25 18:41:21'),
(189, 102, 1, 2, 'investment with infinity pharmaceutical and chemical ltd', '10293144', 'asset', 20180000.00, NULL, 1, '2023-03-25 18:41:21', '2025-11-13 17:08:04'),
(190, 133, 1, 2, 'promassidor fx gl', '10406291', 'asset', 0.00, NULL, 1, '2023-03-25 18:41:21', '2025-04-09 15:19:36'),
(191, 80, 1, 2, 'overdraft savings gl euro', '10801964', 'asset', 0.00, '3', 1, '2023-03-25 18:41:21', '2025-09-03 12:19:02'),
(193, 32, 1, 2, 'rgm sterling bank -0022322837', '10572320', 'asset', 0.00, NULL, 1, '2023-03-25 18:41:21', '2025-05-21 15:09:10'),
(194, 41, 1, 2, 'leslies court property lekki phase1', '10253101', 'asset', 350000000.00, NULL, 1, '2023-03-25 18:41:21', '2025-09-12 15:42:25'),
(195, 57, 1, 2, 'improvement to building(lease)', '10465194', 'asset', 17500000.00, NULL, 1, '2023-03-25 18:41:21', '2025-12-24 16:54:27'),
(196, 84, 1, 2, 'plant and machinery', '10280383', 'asset', 120350300.00, NULL, 1, '2023-03-25 18:41:21', '2025-09-12 16:35:24'),
(197, 42, 1, 2, 'furnitures and fittings', '10968173', 'asset', 23988810.00, NULL, 1, '2023-03-25 18:41:21', '2026-01-23 17:00:10'),
(198, 66, 1, 2, 'motor vehicles', '10815485', 'asset', 247930000.00, NULL, 1, '2023-03-25 18:41:21', '2025-12-01 16:28:36'),
(199, 32, 1, 2, 'rg ecobank 3802057929', '10111426', 'asset', 0.00, NULL, 1, '2023-03-25 18:41:21', '2025-10-01 13:46:22'),
(200, 67, 1, 2, 'office equipments', '10661678', 'asset', 26546560.00, NULL, 1, '2023-03-25 18:41:21', '2026-01-27 14:32:00'),
(201, 133, 1, 2, 'sambethel energy pounds', '10741843', 'asset', 0.00, '2', 1, '2023-03-25 18:41:21', '2025-04-04 13:49:22'),
(202, 67, 1, 2, 'computer softwares', '10135007', 'asset', 19602210.00, NULL, 1, '2023-03-25 18:41:21', '2025-10-27 13:00:55'),
(203, 32, 1, 2, 'rgm consolidated fbn bank gl', '10310574', 'asset', -45000000.00, NULL, 1, '2023-03-25 18:41:21', '2025-10-13 16:58:32'),
(204, 7, 1, 2, 'accumulated depreciation - motor vehicle', '10604716', 'asset', 0.00, NULL, 1, '2023-03-25 18:41:21', '2025-04-09 15:42:44'),
(205, 7, 1, 2, 'accumulated depreciation - office equipment', '10633833', 'asset', 0.00, NULL, 1, '2023-03-25 18:41:21', '2025-04-02 22:32:21'),
(206, 41, 1, 2, 'commercial property at 46, dopemu road', '10587620', 'asset', 283000000.00, NULL, 1, '2023-03-25 18:41:21', '2025-12-08 14:55:16'),
(207, 7, 1, 2, 'accumulated depreciation - plant and machinery', '10209522', 'asset', 0.00, NULL, 1, '2023-03-25 18:41:21', '2025-04-02 22:31:14'),
(208, 7, 1, 2, 'accumulated depreciation - computer equipment', '10948566', 'asset', 0.00, NULL, 1, '2023-03-25 18:41:21', '2025-04-02 22:29:48'),
(209, 32, 1, 2, 'rgm material solution wema0126487622', '10734172', 'asset', 6368227000.18, NULL, 1, '2023-03-25 18:41:21', '2026-02-05 20:21:13'),
(210, 41, 1, 2, '2 units of flats at orji murray street, lekki, lagos', '10888337', 'asset', 250000000.00, NULL, 1, '2023-03-25 18:41:21', '2025-09-12 15:54:46'),
(211, 41, 1, 2, 'property at plot 24, mulmaco estate, ikotun, lagos', '10368005', 'asset', 150000000.00, NULL, 1, '2023-03-25 18:41:21', '2025-09-12 15:55:47'),
(212, 7, 1, 2, 'accumulated depreciation - electrical equipment', '10883566', 'asset', 0.00, NULL, 1, '2023-03-25 18:41:21', '2023-06-09 15:24:08'),
(213, 7, 1, 2, 'accumulated depreciation building/building improve(lease)', '10742965', 'asset', 0.00, NULL, 1, '2023-03-25 18:41:21', '2023-06-09 09:52:53'),
(214, 7, 1, 2, 'accumulated depreciation - furniture/fittings', '10624112', 'asset', 0.00, NULL, 1, '2023-03-25 18:41:21', '2025-04-02 22:28:37'),
(215, 102, 1, 2, 'treasury bills', '10525945', 'asset', 0.00, NULL, 1, '2023-03-25 18:41:21', '2023-06-09 08:25:12'),
(216, 102, 1, 2, 'treasury bill investments-', '10350854', 'asset', 0.00, NULL, 1, '2023-03-25 18:41:21', '2025-07-08 15:52:56'),
(217, 41, 1, NULL, 'plot of land at shell estate lekki', '10166461', 'asset', 762500.00, NULL, 1, '2023-03-25 18:41:21', '2025-10-09 18:33:00'),
(218, 32, 1, 2, 'rg cashmatrix 5000024360', '10486203', 'asset', 750149661.07, NULL, 1, '2023-03-25 18:41:21', '2026-02-06 11:51:29'),
(219, 133, 1, 2, 'rich energy polaris dollars', '10454536', 'asset', 0.00, '1', 1, '2023-03-25 18:41:21', '2025-04-07 18:53:32'),
(220, 80, 1, 2, 'overdraft savings gl pounds', '10503840', 'asset', 0.00, '2', 1, '2023-03-25 18:41:21', '2025-09-03 12:49:56'),
(221, 32, 1, 2, 'rg globus', '10172158', 'asset', 498698040.00, NULL, 1, '2023-03-25 18:41:21', '2026-02-05 20:24:25'),
(222, 133, 1, 2, 'rgm energy fbn dollar', '10296765', 'asset', -32000.00, '1', 1, '2023-03-25 18:41:21', '2025-12-05 14:08:41'),
(223, 112, 1, 2, 'nnpc gl', '10939567', 'asset', 0.00, NULL, 1, '2023-03-25 18:41:21', '2025-07-24 18:04:43'),
(224, 32, 1, 2, 'richgreen keystone-1012873189', '10157254', 'asset', 365250000.00, NULL, 1, '2023-03-25 18:41:21', '2025-12-30 17:08:35'),
(225, 133, 1, 2, 'rg fidelity dollar', '10124650', 'asset', 0.00, '1', 1, '2023-03-25 18:41:21', '2025-04-09 15:56:23'),
(226, 32, 1, 2, 'asset matrix mfb gl', '10209695', 'asset', 1160162598.08, NULL, 1, '2023-03-25 18:41:21', '2026-02-06 13:11:48'),
(227, 113, 1, 2, 'migration savings dumping gl- euro', '10314721', 'asset', 0.00, '3', 1, '2023-03-25 18:41:21', '2025-09-03 10:43:41'),
(228, 32, 1, NULL, 'wema bank rg 0123749963', '10667246', 'asset', 679593496.21, NULL, 1, '2023-03-25 18:41:21', '2026-02-05 20:24:49'),
(229, 61, 1, 2, 'bestbridge investment limited', '10626102', 'asset', 214608.44, NULL, 1, '2023-03-25 18:41:21', '2025-12-09 11:45:05'),
(230, 32, 1, 2, 'richgreen masters capital zenith', '10134702', 'asset', 2955886713.00, NULL, 1, '2023-03-25 18:41:21', '2026-02-05 20:04:53'),
(231, 32, 1, 2, 'sambethel store uba  2107492366', '10957923', 'asset', -5000000.00, NULL, 1, '2023-03-25 18:41:21', '2025-11-11 13:02:03'),
(232, 32, 1, 2, 'polaris bank sambethel 4010027692', '10955696', 'asset', 0.00, NULL, 1, '2023-03-25 18:41:21', '2025-04-07 18:44:18'),
(233, 133, 1, 2, 'rg uk gbp account', '10209491', 'asset', -12121.47, '2', 1, '2023-03-25 18:41:21', '2026-02-05 18:33:07'),
(234, 32, 1, 2, 'stanbic bank rg 0022322837', '10402295', 'asset', 9440000.00, NULL, 1, '2023-03-25 18:41:21', '2026-01-23 14:13:52'),
(235, 32, 1, NULL, 'access bank rg 0692453096', '10434862', 'asset', -20207577.78, NULL, 1, '2023-03-25 18:41:21', '2026-01-22 12:09:20'),
(236, 32, 1, 2, 'fcmb bank rg 2216295046', '10923105', 'asset', 41534413.63, NULL, 1, '2023-03-25 18:41:21', '2026-02-05 19:56:59'),
(237, 32, 1, 2, 'sambethel energy polaris bank', '10603240', 'asset', 0.00, NULL, 1, '2023-03-25 18:41:21', '2025-04-07 18:43:00'),
(238, 16, 1, 2, 'naira equivalent of euro', '10550168', 'asset', 0.00, '3', 0, '2023-03-25 18:41:21', '2025-05-26 14:26:16'),
(239, 32, 1, 2, 'danbethel marine service ltd -zenith bank 1218542564(ngn)', '10686150', 'asset', 100000.00, NULL, 1, '2023-03-25 18:41:21', '2025-10-21 16:48:47'),
(240, 102, 1, 2, 'project with pilot securiteis ltd', '10834107', 'asset', 1083095010.75, NULL, 1, '2023-03-25 18:41:21', '2025-09-12 16:40:10'),
(241, 32, 1, 2, 'rgm farms ltd- fidelity 5080135661', '10304215', 'asset', 0.00, NULL, 1, '2023-03-25 18:41:21', '2025-06-10 15:55:54'),
(242, 16, 1, 2, 'walk-in-fx (euro transfers)', '10243976', 'asset', 100.00, '3', 1, '2023-03-25 18:41:21', '2025-10-23 13:37:35'),
(243, 41, 1, 2, 'maynard estate- lafiaji community lekki- 4units', '10892223', 'asset', 320000000.00, NULL, 1, '2023-03-25 18:41:21', '2025-12-08 14:58:26'),
(244, 61, 1, 2, 'kano project investment', '10258652', 'asset', 30000000.00, NULL, 1, '2023-03-25 18:41:21', '2025-09-12 16:31:38'),
(245, 32, 1, 2, 'fidelity bank rg 5620075057', '10295295', 'asset', 2856621.88, NULL, 1, '2023-03-25 18:41:21', '2026-02-05 20:19:45'),
(246, 16, 1, 2, 'clina lancet', '10520985', 'asset', 0.00, NULL, 1, '2023-03-25 18:41:21', '2025-04-02 22:11:39'),
(247, 32, 1, 2, 'gtb igwt', '10405410', 'asset', -108500000.00, NULL, 1, '2023-03-25 18:41:21', '2026-01-12 16:40:11'),
(248, 32, 1, 2, 'polari rich energy', '10976303', 'asset', 0.00, NULL, 1, '2023-03-25 18:41:21', '2025-04-26 17:11:00'),
(249, 61, 1, 2, 'ggt connect international limited', '10705763', 'asset', 4700000000.00, NULL, 1, '2023-03-25 18:41:21', '2025-09-12 16:31:11'),
(250, 32, 1, 2, 'rgm consolidated fcmb 2004975053', '10389200', 'asset', 348000.00, NULL, 1, '2023-03-25 18:41:21', '2026-01-29 17:44:45'),
(251, 32, 1, NULL, 'rg uba2 1019392436', '10575242', 'asset', -186300000.00, NULL, 1, '2023-03-25 18:41:21', '2026-01-27 18:18:11'),
(252, 61, 1, 2, 'asset matrix microfinance bank limited', '10558417', 'asset', 144000000.00, NULL, 1, '2023-03-25 18:41:21', '2025-09-12 16:37:30'),
(253, 16, 1, 2, 'walking fx- cad', '10395687', 'asset', -114369.96, '4', 1, '2023-03-25 18:41:21', '2026-01-30 19:00:40'),
(254, 133, 1, 2, 'richgreen usd sterling gl', '10472786', 'asset', 0.00, NULL, 1, '2023-03-25 18:41:21', '2025-04-07 18:52:54'),
(255, 32, 1, 2, 'fidelity bank sambethel 5600287939', '10721320', 'asset', 0.00, NULL, 1, '2023-03-25 18:41:21', '2025-05-01 15:51:59'),
(256, 32, 1, 2, 'union bank --rg--0063858740', '10948061', 'asset', 525923262.17, NULL, 1, '2023-03-25 18:41:21', '2026-02-05 11:27:12'),
(257, 32, 1, 2, 'fbn bank rg 2026239464', '10865311', 'asset', 96624724.26, NULL, 1, '2023-03-25 18:41:21', '2026-02-06 10:12:22'),
(258, 32, 1, 2, 'sterling bank igwt 0020230022', '10213331', 'asset', 0.00, NULL, 1, '2023-03-25 18:41:21', '2025-04-09 15:44:04'),
(260, NULL, 1, 2, 'micro insurance premium', '20345639', 'liability', 0.00, NULL, 0, '2023-03-25 18:41:21', '2023-06-10 22:43:31'),
(261, 40, 1, 2, 'dollar cash', '20614386', 'liability', 0.00, '1', 1, '2023-03-25 18:41:21', '2025-04-04 13:44:11'),
(262, 2, 1, 1, 'overages', '20306545', 'liability', 0.00, NULL, 1, '2023-03-25 18:41:21', '2023-06-10 22:52:21'),
(263, 93, 1, 1, 'withholding tax ( head office)', '20391084', 'liability', 303702464.28, NULL, 1, '2023-03-25 18:41:21', '2026-02-06 05:00:21'),
(264, NULL, 1, 2, 'sundry creditors', '20302489', 'liability', 0.00, NULL, 0, '2023-03-25 18:41:21', '2023-06-10 23:30:23'),
(265, NULL, 1, 2, 'payee (liability)', '20586820', 'liability', 0.00, NULL, 0, '2023-03-25 18:41:21', '2023-06-10 22:45:47'),
(266, 40, 1, 2, 'euro cash', '20141511', 'liability', 0.00, '3', 1, '2023-03-25 18:41:21', '2023-07-25 12:18:54'),
(267, NULL, 1, 2, 'pension scheme', '20360253', 'liability', 0.00, NULL, 0, '2023-03-25 18:41:21', '2023-06-10 22:49:58'),
(269, NULL, 1, 2, 'nsitfund', '20719669', 'liability', 0.00, NULL, 0, '2023-03-25 18:41:21', '2023-06-10 22:45:47'),
(270, NULL, 1, 2, 'nhf', '20523094', 'liability', 0.00, NULL, 0, '2023-03-25 18:41:21', '2023-06-10 22:45:47'),
(271, NULL, 1, 2, 'deferred payment', '20251812', 'liability', 0.00, NULL, 0, '2023-03-25 18:41:21', '2023-06-10 22:29:40'),
(272, NULL, 1, 2, 'nipost stamp duty', '20157136', 'liability', 0.00, NULL, 0, '2023-03-25 18:41:21', '2023-06-10 22:45:47'),
(273, NULL, 1, 2, 'suspense acct-loan penalty', '20179874', 'liability', 0.00, NULL, 0, '2023-03-25 18:41:21', '2023-06-10 23:30:23'),
(274, 118, 1, 2, 'fixed deposit & investment gl', '20944548', 'liability', 38176227338.11, NULL, 1, '2023-03-25 18:41:21', '2026-03-12 11:46:15'),
(275, NULL, 1, 2, 'business loan - penalty in suspense', '20888915', 'liability', 0.00, NULL, 0, '2023-03-25 18:41:21', '2023-06-10 22:27:12'),
(276, 86, 1, 2, 'transactions with pilot securities', '10431229', 'asset', -43104000.00, NULL, 1, '2023-03-25 18:41:21', '2026-02-04 18:18:59'),
(277, NULL, 1, 2, 'esusu savings loan - penalty in suspense', '20486986', 'liability', 0.00, NULL, 0, '2023-03-25 18:41:21', '2023-06-10 22:33:23'),
(278, NULL, 1, 2, 'esusu xpress loan - penalty in suspense', '20136649', 'liability', 0.00, NULL, 0, '2023-03-25 18:41:21', '2023-06-10 22:37:54'),
(279, NULL, 1, 2, 'instant cash loan - penalty in suspense', '20630612', 'liability', 0.00, NULL, 0, '2023-03-25 18:41:21', '2023-06-10 22:40:14'),
(280, NULL, 1, 2, 'staff loan - penalty in suspense', '20769371', 'liability', 0.00, NULL, 0, '2023-03-25 18:41:21', '2023-06-10 23:23:14'),
(281, 114, 1, 2, 'migration overdraft dumping gl cad', '20184985', 'liability', 0.00, '4', 1, '2023-03-25 18:41:21', '2025-09-03 12:14:10'),
(282, NULL, 1, 2, 'am target savings - fees in suspense', '20954186', 'liability', 0.00, NULL, 0, '2023-03-25 18:41:21', '2023-06-10 22:25:19'),
(283, NULL, 1, 2, 'esusu xpress loan - fees in suspense', '20913425', 'liability', 0.00, NULL, 0, '2023-03-25 18:41:21', '2023-06-10 22:33:23'),
(284, 135, 1, 2, 'cad account gl', '20276747', 'liability', 166880.87, '4', 1, '2023-03-25 18:41:21', '2026-02-02 05:00:19'),
(285, 118, 1, 2, 'fixed deposit gl cad', '20128265', 'liability', 241524.28, '4', 1, '2023-03-25 18:41:21', '2026-02-02 05:00:19'),
(286, 93, 1, 2, 'withholding tax dollar', '20685315', 'liability', 14345.27, '1', 1, '2023-03-25 18:41:21', '2026-02-05 05:00:21'),
(287, 40, 1, 2, 'naira equivalent of pounds', '20754198', 'liability', 0.00, '2', 0, '2023-03-25 18:41:21', '2025-05-26 14:31:35'),
(288, NULL, 1, 2, 'staff savings - fees suspense', '20375467', 'liability', 0.00, NULL, 0, '2023-03-25 18:41:21', '2023-06-10 23:24:59'),
(289, 74, 1, 2, 'gmd current account', '20670888', 'liability', 0.00, NULL, 1, '2023-03-25 18:41:21', '2025-08-28 23:50:59'),
(290, 86, 1, 2, 'transactions with ggt diagnostic gl', '10433263', 'asset', 278438914.16, NULL, 1, '2023-03-25 18:41:21', '2026-02-05 20:02:36'),
(291, 118, 1, 2, 'fixed deposit gl euros', '20719646', 'liability', 0.00, '3', 1, '2023-03-25 18:41:21', '2024-06-12 12:39:10'),
(292, 118, 1, 2, 'fixed deposit gl pounds', '20794594', 'liability', 1275580.63, '2', 1, '2023-03-25 18:41:21', '2026-02-04 16:30:29'),
(293, 86, 1, 2, 'transactions with rich green capital', '10332909', 'asset', 6241807.53, NULL, 1, '2023-03-25 18:41:21', '2026-02-05 20:05:44'),
(294, NULL, 1, 2, 'staff loan - fees suspense', '20593345', 'liability', 0.00, NULL, 0, '2023-03-25 18:41:21', '2023-06-10 23:19:26'),
(295, 135, 1, 2, 'dollar account gl', '20242722', 'liability', 3397095.91, '1', 1, '2023-03-25 18:41:21', '2026-02-06 05:00:19'),
(296, 93, 1, 2, 'withholding tax cad', '20481975', 'liability', 830.22, '4', 1, '2023-03-25 18:41:21', '2026-02-02 05:00:19'),
(297, 74, 1, 2, 'investment note - interest payeable', '20517975', 'liability', 0.00, NULL, 1, '2023-03-25 18:41:21', '2025-08-13 02:49:13'),
(298, 2, 1, 2, 'on-lending payable', '20189693', 'liability', 0.00, NULL, 1, '2023-03-25 18:41:21', '2025-07-25 17:05:05'),
(299, 114, 1, 2, 'migration bank balances dumping gl', '20887950', 'liability', 4378852859.37, NULL, 1, '2023-03-25 18:41:21', '2025-10-10 17:26:54'),
(300, NULL, 1, 2, 'esusu xpress savings - interest payable', '20152469', 'liability', 0.00, NULL, 0, '2023-03-25 18:41:21', '2023-06-10 22:37:54'),
(301, 135, 1, 2, 'pounds account gl', '20776967', 'liability', 70140.96, '2', 1, '2023-03-25 18:41:21', '2026-02-04 16:30:29'),
(302, 74, 1, 2, 'customer insurance premium payable', '20496315', 'liability', 0.00, NULL, 1, '2023-03-25 18:41:21', '2025-12-22 14:46:18'),
(303, 93, 1, 2, 'withholding tax pounds', '20696956', 'liability', 1582.03, '2', 1, '2023-03-25 18:41:21', '2026-02-03 05:00:26'),
(304, 40, 1, 2, 'naira equivalent of euro', '20347879', 'liability', 0.00, '3', 0, '2023-03-25 18:41:21', '2025-05-26 14:33:01'),
(305, 54, 1, 2, 'loan interest income dollar', '40580075', 'income', 1030.00, '1', 1, '2023-03-25 18:41:21', '2026-01-09 03:00:09'),
(306, 54, 1, 2, 'loan interest income cad', '40653976', 'income', 0.00, '4', 1, '2023-03-25 18:41:21', '2025-08-06 17:13:24'),
(307, NULL, 1, 2, 'cheques in clearing', '20365684', 'liability', 0.00, NULL, 0, '2023-03-25 18:41:21', '2023-06-10 22:29:40'),
(308, NULL, 1, 2, 'staff savings - od interest in suspense', '20264988', 'liability', 0.00, NULL, 0, '2023-03-25 18:41:21', '2023-06-10 23:24:59'),
(309, 114, 1, 2, 'migration overdraft dumping gl-dollar', '20630379', 'liability', 0.00, '1', 1, '2023-03-25 18:41:21', '2025-09-03 12:14:10'),
(310, 114, 1, 2, 'migration overdraft dumping gl-euro', '20259228', 'liability', 0.00, '3', 1, '2023-03-25 18:41:21', '2025-09-03 12:14:10'),
(311, 53, 1, 2, 'loan interest in suspense', '20258512', 'liability', 0.00, NULL, 1, '2023-03-25 18:41:21', '2025-04-07 19:09:36'),
(312, 114, 1, 2, 'migration overdraft dumping gl-pounds', '20490606', 'liability', 0.00, '2', 1, '2023-03-25 18:41:22', '2025-09-03 12:14:10'),
(313, NULL, 1, 2, 'esusu loan - interest in suspense', '20336260', 'liability', 0.00, NULL, 0, '2023-03-25 18:41:22', '2023-06-10 21:26:56'),
(314, NULL, 1, 2, 'business loan - interest in suspense', '20469560', 'liability', 0.00, NULL, 0, '2023-03-25 18:41:22', '2023-06-10 22:27:12'),
(315, 54, 1, 2, 'loan interest income pounds', '40268835', 'income', 0.00, '2', 1, '2023-03-25 18:41:22', '2025-08-06 17:10:30'),
(316, 40, 1, 2, 'fx conversion suspense gl', '20117581', 'liability', 0.00, NULL, 1, '2023-03-25 18:41:22', '2025-05-26 14:34:09'),
(317, NULL, 1, 2, 'am target savings - od interest in suspense', '20552782', 'liability', 0.00, NULL, 0, '2023-03-25 18:41:22', '2023-06-10 22:25:19'),
(318, 135, 1, 2, 'euro account gl', '20409988', 'liability', 0.00, '3', 1, '2023-03-25 18:41:22', '2025-06-11 13:24:54'),
(319, 114, 1, 2, 'migration assets dumping gl', '20777085', 'liability', 36026487945.89, NULL, 1, '2023-03-25 18:41:22', '2025-10-22 17:02:06'),
(320, 86, 1, 2, 'transactions with sambethel stores gl', '10775013', 'asset', 15983252.03, NULL, 1, '2023-03-25 18:41:22', '2025-12-02 14:47:44'),
(321, 86, 1, 2, 'transactions with sambethel marine gl', '10448344', 'asset', 0.00, NULL, 1, '2023-03-25 18:41:22', '2025-09-23 12:05:46'),
(322, NULL, 1, 2, 'esusu xpress - od interest in suspense', '20192005', 'liability', 0.00, NULL, 0, '2023-03-25 18:41:22', '2023-06-10 22:33:23'),
(323, 2, 1, 1, 'income tax', '20740261', 'liability', 0.00, NULL, 0, '2023-03-25 18:41:22', '2024-10-31 12:05:43'),
(324, NULL, 1, 2, 'staff salary', '20297525', 'liability', 0.00, NULL, 0, '2023-03-25 18:41:22', '2023-06-10 23:24:59'),
(325, 124, 1, 2, 'loan fees in suspense', '20986758', 'liability', 0.00, NULL, 1, '2023-03-25 18:41:22', '2023-05-16 13:30:24'),
(326, NULL, 1, 2, 'fee suspense', '20335834', 'liability', 0.00, NULL, 0, '2023-03-25 18:41:22', '2023-06-10 22:37:54'),
(327, 135, 1, 1, 'current account', '20639526', 'liability', -1447044979.00, NULL, 0, '2023-03-25 18:41:22', '2025-11-29 08:12:34'),
(328, 118, 1, 2, 'fixed deposit gl dollar', '20398069', 'liability', 3955800.47, '1', 1, '2023-03-25 18:41:22', '2026-02-06 05:00:19'),
(329, 93, 1, 2, 'withholding tax euros', '20590802', 'liability', 0.00, '3', 1, '2023-03-25 18:41:22', '2023-08-23 15:53:11'),
(331, NULL, 1, 2, 'suspense acct - sms charges', '20557140', 'liability', 0.00, NULL, 0, '2023-03-25 18:41:22', '2023-06-10 23:30:23'),
(332, NULL, 1, 2, 'am target savings', '20962697', 'liability', 0.00, NULL, 0, '2023-03-25 18:41:22', '2023-06-10 22:25:19'),
(333, 135, 1, 1, 'savings account', '20993097', 'liability', 35615172737.20, NULL, 1, '2023-03-25 18:41:22', '2026-03-12 11:46:15'),
(334, 86, 1, 2, 'transactions with cash matrix gl', '10149468', 'asset', -601239650.00, NULL, 1, '2023-03-25 18:41:22', '2026-02-06 10:12:02'),
(335, 2, 1, 2, 'plethoria trustees and fiduciary services ltd creditors', '20740363', 'liability', 0.00, NULL, 1, '2023-03-25 18:41:22', '2025-04-09 17:20:31'),
(336, 40, 1, 2, 'naira equivalents of dollar', '20246589', 'liability', 0.00, '1', 0, '2023-03-25 18:41:22', '2025-05-26 14:30:18'),
(337, NULL, 1, 2, 'student ent scheme-fees in suspense', '20963487', 'liability', 0.00, NULL, 0, '2023-03-25 18:41:22', '2023-06-10 23:30:23'),
(338, NULL, 1, 2, 'interbank transfer fee suspense', '20389953', 'liability', 0.00, NULL, 0, '2023-03-25 18:41:22', '2023-06-10 22:40:14'),
(339, 40, 1, 2, 'cad cash', '20288971', 'liability', 0.00, '4', 1, '2023-03-25 18:41:22', '2023-08-24 15:55:00'),
(340, NULL, 1, 2, 'specific loan/lease loss account', '20289869', 'liability', 0.00, NULL, 0, '2023-03-25 18:41:22', '2023-06-10 23:06:53'),
(341, NULL, 1, 2, 'specific loan/lease prov - am salary advance', '20151603', 'liability', 0.00, NULL, 0, '2023-03-25 18:41:22', '2023-06-10 23:06:53'),
(342, NULL, 1, 2, 'specific loan/lease prov - am instant cash', '20993808', 'liability', 0.00, NULL, 0, '2023-03-25 18:41:22', '2023-06-10 23:06:53'),
(343, NULL, 1, 2, 'specific loan/lease prov - loans & adv', '20817066', 'liability', 0.00, NULL, 0, '2023-03-25 18:41:22', '2023-06-10 23:06:53'),
(344, NULL, 1, 2, 'general loan/lease loss account', '20324325', 'liability', 0.00, NULL, 0, '2023-03-25 18:41:22', '2023-06-10 22:37:54'),
(345, NULL, 1, 2, 'general loan/lease prov - am salary advance', '20938857', 'liability', 0.00, NULL, 0, '2023-03-25 18:41:22', '2023-06-10 22:37:54'),
(346, NULL, 1, 2, 'general loan/lease prov - instant cash', '20857553', 'liability', 0.00, NULL, 0, '2023-03-25 18:41:22', '2023-06-10 22:37:54'),
(347, NULL, 1, 2, 'general loan/lease prov - business loan', '20840603', 'liability', 0.00, NULL, 0, '2023-03-25 18:41:22', '2023-06-10 22:37:54'),
(348, 56, 1, 2, 'ordinary shared capital', '30488648', 'capital', 0.00, NULL, 1, '2023-03-25 18:41:22', '2025-07-30 13:50:46'),
(349, NULL, 1, 2, 'share holding', '30652948', 'capital', 0.00, NULL, 0, '2023-03-25 18:41:22', '2023-06-10 23:06:53'),
(350, NULL, 1, 2, 'increase in deposit for share(sub)', '30716369', 'capital', 0.00, NULL, 0, '2023-03-25 18:41:22', '2023-06-10 22:40:14'),
(351, NULL, 1, 2, 'statutory reserve', '30176453', 'capital', 0.00, NULL, 0, '2023-03-25 18:41:22', '2023-06-10 23:24:59'),
(353, NULL, 1, 2, '2012 financial year p&l', '30365556', 'capital', 0.00, NULL, 0, '2023-03-25 18:41:22', '2023-06-10 21:17:53'),
(354, NULL, 1, 2, '2013 financial year p&l', '30737491', 'capital', 0.00, NULL, 0, '2023-03-25 18:41:22', '2023-06-10 21:17:53'),
(355, NULL, 1, 2, '2014 financial year p&l', '30640563', 'capital', 0.00, NULL, 0, '2023-03-25 18:41:22', '2023-06-10 21:17:53'),
(356, NULL, 1, 2, '2015 financial year p & l', '30995845', 'capital', 0.00, NULL, 0, '2023-03-25 18:41:22', '2023-06-10 21:17:53'),
(357, NULL, 1, 2, '2016 financial year p & l', '30130407', 'capital', 0.00, NULL, 0, '2023-03-25 18:41:22', '2023-06-10 21:17:53'),
(358, NULL, 1, 2, 'general reserve', '30334129', 'capital', 0.00, NULL, 0, '2023-03-25 18:41:22', '2023-06-10 22:37:54'),
(359, NULL, 1, 2, '2018 financial year p & l', '30933656', 'capital', 0.00, NULL, 0, '2023-03-25 18:41:22', '2023-06-10 21:17:53'),
(360, NULL, 1, 2, '2019 financial year p & l', '30961767', 'capital', 0.00, NULL, 0, '2023-03-25 18:41:22', '2023-06-10 21:17:53'),
(361, NULL, 1, 2, '2020 financial year p & l', '30981150', 'capital', 0.00, NULL, 0, '2023-03-25 18:41:22', '2023-06-10 21:17:53'),
(362, NULL, 1, 2, 'previous yr p&l summary', '30498901', 'capital', 0.00, NULL, 0, '2023-03-25 18:41:22', '2023-06-10 22:58:08'),
(363, NULL, 1, 2, 'staff salary fee interest income', '40235936', 'income', 0.00, NULL, 0, '2023-03-25 18:41:22', '2023-06-10 23:24:59'),
(364, 72, 1, 2, 'commission income', '40405204', 'income', 0.00, NULL, 1, '2023-03-25 18:41:22', '2025-05-22 13:46:57'),
(365, 36, 1, 2, 'income (account closing)', '40752794', 'income', 0.00, NULL, 1, '2023-03-25 18:41:22', '2023-06-09 21:25:57'),
(366, 54, 1, 2, 'loan interest income naira', '40248362', 'income', 503272794.00, NULL, 1, '2023-03-25 18:41:22', '2026-02-06 03:00:13'),
(367, 72, 1, 2, 'gain on fixed asset disposal', '40358412', 'income', 0.00, NULL, 1, '2023-03-25 18:41:22', '2023-06-09 21:12:21'),
(368, 49, 1, 2, 'other investment income gl', '40732005', 'income', 0.00, NULL, 1, '2023-03-25 18:41:22', '2025-09-17 17:57:08'),
(369, 54, 1, 2, 'loan interest income euro', '40129108', 'income', 0.00, '3', 1, '2023-03-25 18:41:22', '2025-08-06 17:10:30'),
(370, NULL, 1, 2, 'esusu loan - interest income', '40833824', 'income', 0.00, NULL, 0, '2023-03-25 18:41:22', '2023-06-10 21:26:56'),
(371, 72, 1, 2, 'gains/ commission from sale of petrol/diesel', '40472895', 'income', 0.00, NULL, 1, '2023-03-25 18:41:22', '2025-04-12 11:57:42'),
(372, 72, 1, 2, 'gains/ commission from sale of dollars-', '40133621', 'income', 0.00, '1', 1, '2023-03-25 18:41:22', '2025-04-12 11:57:42'),
(373, NULL, 1, 2, 'instant cash loan - interest income', '40217326', 'income', 0.00, NULL, 0, '2023-03-25 18:41:22', '2023-06-10 22:40:14'),
(374, 72, 1, 2, 'gains/ commission from sale of pounds', '40610422', 'income', 0.00, '2', 1, '2023-03-25 18:41:22', '2025-06-11 13:22:24'),
(375, NULL, 1, 2, 'business loan - interest income', '40173578', 'income', 0.00, NULL, 1, '2023-03-25 18:41:22', '2023-09-20 20:22:15'),
(376, 72, 1, 2, 'ncome from sale of properties', '40528521', 'income', 0.00, NULL, 0, '2023-03-25 18:41:22', '2025-05-22 13:39:08'),
(377, 72, 1, 2, 'gains/ commission from sale of cashew', '40803733', 'income', 0.00, NULL, 1, '2023-03-25 18:41:22', '2025-04-12 11:57:42'),
(378, 49, 1, 2, 'dividend income', '40321281', 'income', 0.00, NULL, 1, '2023-03-25 18:41:22', '2025-05-22 13:46:57'),
(379, NULL, 1, 2, 'staff savings - od interest income', '40409304', 'income', 0.00, NULL, 0, '2023-03-25 18:41:22', '2023-06-10 23:24:59'),
(380, 36, 1, 2, 'investment manual liquidation charge dollar', '40305095', 'income', 0.00, '1', 1, '2023-03-25 18:41:22', '2023-08-23 15:44:03'),
(381, 72, 1, 2, 'income from sale of produce-', '40587183', 'income', 0.00, NULL, 0, '2023-03-25 18:41:22', '2025-05-22 13:40:37'),
(382, NULL, 1, 2, 'esusu xpress savings - od interest income', '40219716', 'income', 0.00, NULL, 0, '2023-03-25 18:41:22', '2023-06-10 22:37:54'),
(383, 36, 1, 2, 'loan fee income euro', '40649206', 'income', 0.00, '3', 1, '2023-03-25 18:41:22', '2025-08-06 17:10:30'),
(384, NULL, 1, 2, 'loan overdue- interest', '40224523', 'income', 0.00, NULL, 0, '2023-03-25 18:41:22', '2023-06-10 22:43:31'),
(385, NULL, 1, 2, 'esusu savings loan - interest income', '40232220', 'income', 0.00, NULL, 0, '2023-03-25 18:41:22', '2023-06-10 22:33:23'),
(386, 36, 1, 2, 'account closing', '40540409', 'income', 0.00, NULL, 1, '2023-03-25 18:41:22', '2023-06-09 19:54:47'),
(387, NULL, 1, 2, 'cheque sales income', '40860405', 'income', 0.00, NULL, 0, '2023-03-25 18:41:22', '2023-06-10 22:27:12'),
(388, 72, 1, 1, 'treasury bill income', '40275850', 'income', 0.00, NULL, 1, '2023-03-25 18:41:22', '2023-06-10 23:37:53'),
(389, NULL, 1, 2, 'fixed deposit income', '40784457', 'income', 0.00, NULL, 0, '2023-03-25 18:41:22', '2023-06-10 22:37:54'),
(390, 36, 1, 1, 'maintenance fee', '40238192', 'income', 0.00, NULL, 1, '2023-03-25 18:41:22', '2023-06-10 21:42:12');
INSERT INTO `general_ledgers` (`id`, `account_category_id`, `user_id`, `branch_id`, `gl_name`, `gl_code`, `gl_type`, `account_balance`, `currency_id`, `status`, `created_at`, `updated_at`) VALUES
(391, 20, 1, 2, 'commission on direct debit', '40926777', 'income', 0.00, NULL, 1, '2023-03-25 18:41:22', '2023-06-09 14:23:33'),
(392, 20, 1, 1, 'sales of withdrawal booklet', '40760502', 'income', 0.00, NULL, 1, '2023-03-25 18:41:22', '2023-06-10 23:12:57'),
(393, 36, 1, 2, 'loan fee income dollar', '40459749', 'income', 0.00, '1', 1, '2023-03-25 18:41:22', '2025-08-12 10:43:24'),
(394, 36, 1, 2, 'loan fee income pounds', '40972865', 'income', 0.00, '2', 1, '2023-03-25 18:41:22', '2025-08-06 17:10:30'),
(395, NULL, 1, 2, 'recova commission', '40857167', 'income', 0.00, NULL, 0, '2023-03-25 18:41:22', '2023-06-10 23:01:08'),
(396, 48, 1, NULL, 'realised fx exchange gain', '40875503', 'income', 13516316.49, NULL, 1, '2023-03-25 18:41:22', '2026-02-05 18:32:22'),
(397, 48, 1, 2, 'other interest income', '40506748', 'income', 0.00, NULL, 1, '2023-03-25 18:41:22', '2025-07-24 18:55:53'),
(398, 36, 1, 1, 'monthly admin fee', '40203722', 'income', 0.00, NULL, 1, '2023-03-25 18:41:22', '2023-06-10 22:05:48'),
(399, 36, 1, 2, 'advisory fees', '40891449', 'income', 0.00, NULL, 1, '2023-03-25 18:41:22', '2023-06-09 19:56:25'),
(400, 72, 1, 2, 'legal search fees(account opening)', '40530627', 'income', 0.00, NULL, 1, '2023-03-25 18:41:22', '2023-06-09 21:34:48'),
(401, 36, 1, 2, 'administrative fees', '40352528', 'income', 0.00, NULL, 1, '2023-03-25 18:41:22', '2023-06-09 19:55:51'),
(402, 36, 1, 2, 'application fees', '40766975', 'income', 0.00, NULL, 1, '2023-03-25 18:41:22', '2023-06-09 20:06:21'),
(403, NULL, 1, 2, 'training', '40814420', 'income', 0.00, NULL, 1, '2023-03-25 18:41:22', '2025-08-08 14:57:33'),
(404, 36, 1, 1, 'other charges', '40973920', 'income', 0.00, NULL, 1, '2023-03-25 18:41:22', '2025-04-04 12:54:53'),
(405, 36, 1, 1, 'transfer charges', '40857863', 'income', 0.00, NULL, 1, '2023-03-25 18:41:22', '2025-07-30 13:52:06'),
(406, 36, 1, 1, 'sms income account', '40898987', 'income', 0.00, NULL, 1, '2023-03-25 18:41:22', '2023-06-10 23:21:43'),
(407, 72, 1, 2, 'service charge income from subsidiaries', '40936558', 'income', 0.00, NULL, 0, '2023-03-25 18:41:22', '2025-05-26 19:39:49'),
(408, 36, 1, 2, 'e-channel fee income account', '40517303', 'income', 0.00, NULL, 1, '2023-03-25 18:41:22', '2023-06-09 20:29:19'),
(409, 36, 1, 2, 'loan fee income', '40953331', 'income', 2946292.97, NULL, 1, '2023-03-25 18:41:22', '2026-01-30 16:15:30'),
(410, 72, 1, 2, 'gains/ commission from sale of euros-', '40843915', 'income', 0.00, '3', 1, '2023-03-25 18:41:22', '2025-04-12 11:57:42'),
(411, 72, 1, 2, 'rental income', '40545266', 'income', 0.00, NULL, 0, '2023-03-25 18:41:22', '2025-05-22 13:42:52'),
(412, 72, 1, 2, 'gains/ commission from sale of cocoa', '40931582', 'income', 0.00, NULL, 1, '2023-03-25 18:41:22', '2025-04-12 11:57:42'),
(413, 49, 1, 2, 'interest income from placements', '40750866', 'income', 0.00, NULL, 1, '2023-03-25 18:41:22', '2026-01-07 18:17:20'),
(414, NULL, 1, 2, 'esusu savings - od fee income', '40558832', 'income', 0.00, NULL, 0, '2023-03-25 18:41:22', '2023-06-10 22:33:23'),
(415, NULL, 1, 2, 'esusu xpress - od fee income account', '40365730', 'income', 0.00, NULL, 0, '2023-03-25 18:41:22', '2023-06-10 22:33:23'),
(416, NULL, 1, 2, 'esusu savings loan - fee income', '40491917', 'income', 0.00, NULL, 0, '2023-03-25 18:41:22', '2023-06-10 22:33:23'),
(417, 36, 1, 2, 'investment manual liquidation charge pounds', '40775710', 'income', 0.00, '2', 1, '2023-03-25 18:41:22', '2023-08-23 15:48:47'),
(418, NULL, 1, 2, 'prepaid virtual airtime(income)', '40447439', 'income', 0.00, NULL, 0, '2023-03-25 18:41:22', '2023-06-10 22:58:08'),
(419, NULL, 1, 2, 'income from card transactions', '40375379', 'income', 0.00, NULL, 0, '2023-03-25 18:41:22', '2023-06-10 22:40:14'),
(420, 36, 1, 2, 'correspondent banking income', '40170667', 'income', 17525571.84, NULL, 1, '2023-03-25 18:41:22', '2026-02-05 19:56:59'),
(421, 36, 1, 2, 'investment manual liquidation charge cad', '40942289', 'income', 0.00, '4', 1, '2023-03-25 18:41:22', '2023-08-24 15:52:30'),
(422, 36, 1, 2, 'investment manual liquidation charge euro', '40420294', 'income', 0.00, '3', 1, '2023-03-25 18:41:22', '2023-08-23 15:47:01'),
(423, 72, 1, 2, 'income from sale of shares', '40835970', 'income', 0.00, NULL, 0, '2023-03-25 18:41:22', '2025-05-22 13:39:55'),
(424, NULL, 1, 2, 'esusu xpress loan - fee income', '40347618', 'income', 0.00, NULL, 0, '2023-03-25 18:41:22', '2023-06-10 22:33:23'),
(425, 36, 1, 2, 'investment manual liquidation charge', '40774946', 'income', 69773.04, NULL, 1, '2023-03-25 18:41:22', '2026-01-27 12:00:59'),
(426, 49, 1, 2, 'fee on other investment', '40192835', 'income', 0.00, NULL, 0, '2023-03-25 18:41:22', '2025-09-17 17:59:10'),
(427, 36, 1, 2, 'loan fee income cad', '40786773', 'income', 0.00, '4', 0, '2023-03-25 18:41:22', '2025-08-12 13:40:02'),
(428, 36, 1, 1, 'nibss transfer charges', '40754383', 'income', 0.00, NULL, 1, '2023-03-25 18:41:22', '2023-06-10 22:10:34'),
(429, NULL, 1, 2, 'payvice pos fee income', '40924607', 'income', 0.00, NULL, 0, '2023-03-25 18:41:22', '2023-06-10 22:45:47'),
(430, NULL, 1, 2, 'ussd fee income', '40267306', 'income', 0.00, NULL, 0, '2023-03-25 18:41:22', '2025-05-22 13:47:55'),
(431, 36, 1, 1, 'moniepoint pos income fee', '40548469', 'income', 0.00, NULL, 1, '2023-03-25 18:41:22', '2023-06-10 21:55:41'),
(432, NULL, 1, 2, 'marketing expense', '50143221', 'expense', 0.00, NULL, 0, '2023-03-25 18:41:22', '2023-06-10 22:43:31'),
(433, NULL, 1, 2, 'lease finance charges', '50412603', 'expense', 0.00, NULL, 0, '2023-03-25 18:41:22', '2023-06-10 22:43:31'),
(434, 81, 1, 2, 'tax', '50671605', 'expense', 0.00, NULL, 1, '2023-03-25 18:41:22', '2026-01-07 17:34:15'),
(435, 34, 1, 2, 'other expense', '50814096', 'expense', 0.00, NULL, 1, '2023-03-25 18:41:22', '2023-06-08 16:05:25'),
(436, 136, 1, 2, 'subway bdc expense gl', '50737081', 'expense', 0.00, NULL, 1, '2023-03-25 18:41:22', '2025-08-19 15:46:27'),
(437, 81, 1, 1, 'regulatory charge', '50602641', 'expense', 0.00, NULL, 1, '2023-03-25 18:41:22', '2023-06-10 23:09:30'),
(438, NULL, 1, 2, 'recova (fee) expense gl', '50671508', 'expense', 0.00, NULL, 0, '2023-03-25 18:41:22', '2023-06-10 22:58:08'),
(439, 81, 1, 2, 'bank charges  usd', '50534208', 'expense', -169.39, '1', 1, '2023-03-25 18:41:22', '2026-02-02 19:33:28'),
(440, 52, 1, 2, 'interest expense fd euros', '50921377', 'expense', 0.00, '3', 1, '2023-03-25 18:41:22', '2025-03-31 15:06:22'),
(441, NULL, 1, 2, 'investment note - interest expense', '50576790', 'expense', 0.00, NULL, 0, '2023-03-25 18:41:22', '2023-06-10 22:40:14'),
(442, NULL, 1, 2, 'other deposit interest expense', '50999624', 'expense', 0.00, NULL, 0, '2023-03-25 18:41:22', '2023-06-10 22:45:47'),
(443, 81, 1, 2, 'pof brokerage', '50275200', 'expense', 0.00, NULL, 1, '2023-03-25 18:41:22', '2025-04-02 23:27:25'),
(444, 81, 1, NULL, 'management expense ( mgt )', '50866646', 'expense', 62020.00, NULL, 1, '2023-03-25 18:41:22', '2026-02-04 19:44:38'),
(445, 81, 1, 2, 'brokerage gl', '50514924', 'expense', 115787261.69, NULL, 1, '2023-03-25 18:41:22', '2026-02-04 19:09:00'),
(446, 52, 1, 2, 'interest expense ( fd cad)', '50962524', 'expense', 16112.35, '4', 1, '2023-03-25 18:41:22', '2026-02-02 05:00:19'),
(447, 81, 1, 2, 'hibiscus flower export gl', '50267757', 'expense', 0.00, NULL, 1, '2023-03-25 18:41:22', '2025-04-09 18:32:57'),
(448, 81, 1, 2, 'asset matrix virtual account expense', '50792058', 'expense', 0.00, NULL, 1, '2023-03-25 18:41:22', '2025-04-02 23:25:43'),
(449, 68, 1, 2, 'cocoa expense gl', '50407642', 'expense', 0.00, NULL, 1, '2023-03-25 18:41:22', '2025-07-30 13:44:33'),
(450, 52, 1, 2, 'interest expense ( fixed deposit)', '50249457', 'expense', 1672032528.15, NULL, 1, '2023-03-25 18:41:22', '2026-02-06 05:00:26'),
(451, 106, 1, NULL, 'richgreen capital (sec) salary', '50182638', 'expense', 0.00, NULL, 1, '2023-03-25 18:41:22', '2025-08-01 20:00:24'),
(452, 52, 1, 2, 'interest expense fd pounds', '50359501', 'expense', 153691.50, '2', 1, '2023-03-25 18:41:22', '2026-02-04 15:50:53'),
(453, 81, 1, 2, 'sms expense account', '50880429', 'expense', 0.00, NULL, 1, '2023-03-25 18:41:22', '2026-01-07 17:36:46'),
(454, 81, 1, 1, 'banqpro subscription payment expense', '50486638', 'expense', 0.00, NULL, 1, '2023-03-25 18:41:22', '2025-03-31 15:48:00'),
(455, 81, 1, 2, 'c.a.c expense', '50871371', 'expense', 0.00, NULL, 1, '2023-03-25 18:41:22', '2025-04-02 23:14:53'),
(457, 81, 1, 2, 'e channel expense', '50574888', 'expense', 0.00, NULL, 1, '2023-03-25 18:41:22', '2025-04-02 23:23:41'),
(458, 41, 1, 2, 'maryland property(wema) 23a olatunbosun str shonibare estate maryland ikaja', '50266772', 'expense', 465000000.00, NULL, 1, '2023-03-25 18:41:22', '2025-09-23 17:21:29'),
(459, NULL, 1, 2, 'ussd session expense', '50232071', 'expense', 0.00, NULL, 1, '2023-03-25 18:41:22', '2023-03-25 18:41:22'),
(460, 136, 1, 2, 'fx commission', '50928409', 'expense', 0.00, NULL, 1, '2023-03-25 18:41:22', '2025-04-02 23:36:09'),
(461, 81, 1, 1, 'pre-incorporation expenses', '50950558', 'expense', 0.00, NULL, 1, '2023-03-25 18:41:22', '2023-06-10 22:59:01'),
(462, 81, 1, 2, 'office rent expense', '50132448', 'expense', 0.00, NULL, 1, '2023-03-25 18:41:22', '2025-04-02 23:17:05'),
(463, 81, 1, 1, 'motor vechcle-insurance', '50708190', 'expense', 0.00, NULL, 1, '2023-03-25 18:41:22', '2025-04-07 18:57:05'),
(464, 81, 1, 2, 'bank charges', '50409815', 'expense', -113800.00, NULL, 1, '2023-03-25 18:41:22', '2026-02-04 18:06:58'),
(465, 81, 1, 2, 'motor vechcle-fuel', '50414005', 'expense', 1883021.00, NULL, 1, '2023-03-25 18:41:22', '2026-02-06 11:50:30'),
(466, 81, 1, 2, 'printed stationeries', '50337932', 'expense', 754000.00, NULL, 1, '2023-03-25 18:41:22', '2026-01-27 17:21:53'),
(467, NULL, 1, 2, 'training expenses-local', '50896631', 'expense', 0.00, NULL, 1, '2023-03-25 18:41:22', '2025-04-01 12:22:03'),
(468, NULL, 1, 2, 'marketing expenses', '50686053', 'expense', 0.00, NULL, 0, '2023-03-25 18:41:22', '2023-06-10 22:43:31'),
(469, NULL, 1, 2, 'n.d.i.c', '50419641', 'expense', 0.00, NULL, 0, '2023-03-25 18:41:22', '2023-06-10 22:45:47'),
(470, 81, 1, 2, 'kano project expenses', '50564852', 'expense', 0.00, NULL, 1, '2023-03-25 18:41:22', '2025-03-31 15:23:57'),
(471, 81, 1, 2, 'legal fees', '50319729', 'expense', 50000.00, NULL, 1, '2023-03-25 18:41:22', '2026-01-26 19:20:44'),
(472, NULL, 1, 2, 'other asset (stationeries)', '50940504', 'expense', 0.00, NULL, 0, '2023-03-25 18:41:22', '2023-06-10 22:45:47'),
(473, 81, 1, 2, 'travel & hotel expenses', '50586187', 'expense', 0.00, NULL, 1, '2023-03-25 18:41:22', '2026-01-07 17:50:01'),
(474, 81, 1, 1, 'transportation', '50581240', 'expense', 84200.00, NULL, 1, '2023-03-25 18:41:22', '2026-02-04 19:50:25'),
(475, 81, 1, 1, 'security service - office', '50383563', 'expense', 70000.00, NULL, 1, '2023-03-25 18:41:22', '2026-01-28 14:25:45'),
(476, 81, 1, 2, 'electricity', '50578708', 'expense', 600000.00, NULL, 1, '2023-03-25 18:41:22', '2026-02-02 19:02:50'),
(477, 68, 1, 2, 'telephone', '50798781', 'expense', 65000.00, NULL, 1, '2023-03-25 18:41:22', '2026-02-03 18:58:51'),
(478, 81, 1, 2, 'publicity and advertisement', '50216027', 'expense', 182800.00, NULL, 1, '2023-03-25 18:41:22', '2026-01-20 15:46:47'),
(479, 29, 1, 2, 'board meetintg expenses', '50293041', 'expense', 0.00, NULL, 1, '2023-03-25 18:41:22', '2025-04-01 12:22:42'),
(480, NULL, 1, 2, 'group life insurance exp', '50190608', 'expense', 0.00, NULL, 0, '2023-03-25 18:41:22', '2023-06-10 22:37:54'),
(481, 81, 1, 2, 'furniture and equipment maintenance', '50155276', 'expense', 0.00, NULL, 1, '2023-03-25 18:41:22', '2025-08-21 14:11:27'),
(482, 81, 1, 2, 'computer maintenance', '50176483', 'expense', 415000.00, NULL, 1, '2023-03-25 18:41:22', '2026-01-08 15:23:43'),
(483, 81, 1, 2, 'vehicles maintenance', '50371896', 'expense', 1578850.00, NULL, 1, '2023-03-25 18:41:22', '2026-02-04 19:42:08'),
(484, 81, 1, 2, 'consultancy and professional', '50137384', 'expense', 0.00, NULL, 1, '2023-03-25 18:41:22', '2026-01-07 17:55:09'),
(485, 81, 1, 2, 'licensing and registration', '50677094', 'expense', 182700.00, NULL, 1, '2023-03-25 18:41:22', '2026-02-02 19:00:38'),
(486, 81, 1, NULL, 'plant & machinery maintenance', '50164686', 'expense', 0.00, NULL, 1, '2023-03-25 18:41:22', '2025-08-01 19:58:50'),
(487, NULL, 1, 2, 'loan recovery expense', '50288794', 'expense', 0.00, NULL, 0, '2023-03-25 18:41:22', '2023-06-10 22:43:31'),
(488, 81, 1, 2, 'audit expenses', '50708169', 'expense', 0.00, NULL, 1, '2023-03-25 18:41:22', '2026-01-07 17:56:51'),
(489, 81, 1, 2, 'marketing expenses', '50689798', 'expense', 0.00, NULL, 1, '2023-03-25 18:41:22', '2025-05-19 09:59:46'),
(490, 81, 1, 2, 'unprinted stationery', '50570619', 'expense', 244000.00, NULL, 1, '2023-03-25 18:41:22', '2026-02-06 11:04:13'),
(491, 81, 1, 2, 'entertainment - staff', '50929265', 'expense', 0.00, NULL, 1, '2023-03-25 18:41:22', '2026-01-07 18:01:13'),
(492, 81, 1, 2, 'entertainment - client', '50590389', 'expense', 94580.00, NULL, 1, '2023-03-25 18:41:22', '2026-02-03 19:02:08'),
(493, 1, 1, NULL, 'newspapers, books and magazines', '50732005', 'expense', 0.00, NULL, 1, '2023-03-25 18:41:22', '2025-03-31 15:50:31'),
(494, 81, 1, 1, 'postage and courier', '50564350', 'expense', 0.00, NULL, 1, '2023-03-25 18:41:22', '2025-03-31 15:47:04'),
(495, NULL, 1, 2, 'taxation expense account', '50595534', 'expense', 0.00, NULL, 0, '2023-03-25 18:41:22', '2023-06-10 23:30:23'),
(496, 81, 1, 2, 'water expense', '50235033', 'expense', 51000.00, NULL, 1, '2023-03-25 18:41:22', '2026-01-14 14:14:51'),
(497, 106, 1, 2, 'ggt connect salary', '50728695', 'expense', 0.00, NULL, 1, '2023-03-25 18:41:22', '2025-04-02 23:17:34'),
(498, 81, 1, 1, 'insurance premium', '50178260', 'expense', 0.00, NULL, 1, '2023-03-25 18:41:22', '2023-06-10 22:41:07'),
(499, 81, 1, NULL, 'office expenses', '50318693', 'expense', 39500.00, NULL, 1, '2023-03-25 18:41:22', '2026-02-04 19:51:44'),
(500, 81, 1, 2, 'generator(diesel)', '50824690', 'expense', 198000.00, NULL, 1, '2023-03-25 18:41:22', '2026-02-02 19:04:39'),
(501, 81, 1, 2, 'corporate gifts', '50880526', 'expense', 487000.00, NULL, 1, '2023-03-25 18:41:22', '2026-02-03 18:57:54'),
(502, NULL, 1, 2, 'utility bills', '50357731', 'expense', 0.00, NULL, 1, '2023-03-25 18:41:22', '2025-03-31 15:58:46'),
(503, 81, 1, 2, 'generator(petrol)', '50932240', 'expense', 0.00, NULL, 1, '2023-03-25 18:41:22', '2023-06-09 20:43:38'),
(504, NULL, 1, 2, 'general insurance expense', '50465330', 'expense', 0.00, NULL, 0, '2023-03-25 18:41:22', '2023-06-10 22:37:54'),
(505, 81, 1, 2, 'internet-services', '50280821', 'expense', 0.00, NULL, 1, '2023-03-25 18:41:22', '2026-01-07 18:05:31'),
(506, 81, 1, 1, 'wht expense', '50349936', 'expense', 0.00, NULL, 1, '2023-03-25 18:41:22', '2025-07-24 18:35:06'),
(507, 81, 1, 2, 'computer consumables', '50970546', 'expense', 25000.00, NULL, 1, '2023-03-25 18:41:22', '2026-02-05 19:58:06'),
(508, NULL, 1, 2, 'lease rental', '50445404', 'expense', 0.00, NULL, 0, '2023-03-25 18:41:22', '2023-06-10 22:43:31'),
(509, 106, 1, 2, 'health maintenance organisation', '50254457', 'expense', 0.00, NULL, 1, '2023-03-25 18:41:22', '2026-01-07 18:11:08'),
(510, 68, 1, 2, 'rates(local govt & states)', '50823444', 'expense', 0.00, NULL, 1, '2023-03-25 18:41:22', '2026-01-07 17:33:22'),
(511, 81, 1, 2, 'other subscription', '50196951', 'expense', 139187.82, NULL, 1, '2023-03-25 18:41:22', '2026-02-02 19:22:03'),
(512, 81, 1, 2, 'email expense', '50678901', 'expense', 0.00, NULL, 1, '2023-03-25 18:41:22', '2023-06-09 20:32:59'),
(513, 81, 1, 2, 'bvn expense account', '50536190', 'expense', 0.00, NULL, 1, '2023-03-25 18:41:22', '2025-08-08 16:31:06'),
(514, 81, 1, 2, 'digital services', '50133656', 'expense', 0.00, NULL, 1, '2023-03-25 18:41:22', '2023-06-09 20:32:21'),
(515, NULL, 1, 2, 'payvice pos(charges)', '50616817', 'expense', 0.00, NULL, 0, '2023-03-25 18:41:22', '2023-06-10 22:49:58'),
(516, NULL, 1, 2, 'nysc project expenses', '50357823', 'expense', 0.00, NULL, 0, '2023-03-25 18:41:22', '2023-06-10 22:45:47'),
(517, 81, 1, 1, 'moniepoint pos(charges)', '50809927', 'expense', 0.00, NULL, 1, '2023-03-25 18:41:22', '2023-06-10 21:58:37'),
(518, 106, 1, 2, 'staff salary', '50725226', 'expense', 0.00, NULL, 1, '2023-03-25 18:41:22', '2025-04-01 12:13:03'),
(519, NULL, 1, 2, 'housing allowance', '50439284', 'expense', 0.00, NULL, 0, '2023-03-25 18:41:22', '2023-06-10 22:40:14'),
(520, NULL, 1, 2, 'transport allowance', '50861671', 'expense', 0.00, NULL, 0, '2023-03-25 18:41:22', '2025-10-15 18:30:52'),
(521, NULL, 1, 2, 'lunch allowance', '50260802', 'expense', 0.00, NULL, 0, '2023-03-25 18:41:22', '2023-06-10 22:43:31'),
(522, NULL, 1, 2, 'utility allowance', '50983510', 'expense', 0.00, NULL, 1, '2023-03-25 18:41:22', '2023-03-25 18:41:22'),
(523, 106, 1, 2, 'staff cost', '50740271', 'expense', 0.00, NULL, 1, '2023-03-25 18:41:22', '2026-01-07 18:11:39'),
(524, 106, 1, NULL, 'medical allowance', '50478994', 'expense', 0.00, NULL, 1, '2023-03-25 18:41:22', '2026-01-07 18:12:17'),
(525, NULL, 1, 2, 'dressing allowance', '50935582', 'expense', 0.00, NULL, 0, '2023-03-25 18:41:22', '2023-06-10 22:31:06'),
(526, NULL, 1, 2, 'domestic allowance', '50232620', 'expense', 0.00, NULL, 0, '2023-03-25 18:41:22', '2023-06-10 22:31:06'),
(527, 106, 1, 2, 'leave allowance', '50481988', 'expense', 0.00, NULL, 1, '2023-03-25 18:41:22', '2023-06-09 14:34:38'),
(528, NULL, 1, 2, 'passage allowance', '50373328', 'expense', 0.00, NULL, 0, '2023-03-25 18:41:22', '2023-06-10 22:45:47'),
(529, NULL, 1, 2, 'industrial attachee allowance', '50524584', 'expense', 0.00, NULL, 0, '2023-03-25 18:41:22', '2023-06-10 22:40:14'),
(530, 81, 1, NULL, 'pension contribution ( silverlining / md)', '50686120', 'expense', 0.00, NULL, 1, '2023-03-25 18:41:22', '2026-01-07 18:07:09'),
(531, NULL, 1, 2, 'productivity allowance', '50410631', 'expense', 400000.00, NULL, 1, '2023-03-25 18:41:22', '2025-12-03 16:07:57'),
(532, NULL, 1, 2, 'entertainment allowance', '50748396', 'expense', 0.00, NULL, 0, '2023-03-25 18:41:22', '2023-06-10 21:26:56'),
(533, 68, 1, 1, 'salaries', '50777202', 'expense', 0.00, NULL, 1, '2023-03-25 18:41:22', '2023-06-10 23:11:25'),
(534, 81, 1, 2, 'staff welfare', '50192088', 'expense', 140000.00, NULL, 1, '2023-03-25 18:41:22', '2026-01-07 18:07:43'),
(535, NULL, 1, 2, 'marketing bonus', '50977135', 'expense', 0.00, NULL, 0, '2023-03-25 18:41:22', '2023-06-10 22:43:31'),
(536, NULL, 1, 2, 'payee', '50393627', 'expense', 0.00, NULL, 0, '2023-03-25 18:41:22', '2023-06-10 22:45:47'),
(537, NULL, 1, 2, 'staff welfare(2)', '50319507', 'expense', 0.00, NULL, 0, '2023-03-25 18:41:22', '2023-06-10 23:24:59'),
(538, 29, 1, 2, 'directors travelling expense', '50912004', 'expense', 0.00, NULL, 1, '2023-03-25 18:41:22', '2025-03-31 16:09:24'),
(539, 29, 1, 2, 'directors remuneration and expense', '50972841', 'expense', 0.00, NULL, 1, '2023-03-25 18:41:22', '2026-01-07 17:30:51'),
(540, 81, 1, 2, 'training cost', '50871849', 'expense', 0.00, NULL, 1, '2023-03-25 18:41:22', '2026-01-07 18:08:12'),
(541, 81, 1, 2, 'business development cost', '50765954', 'expense', 2924000.00, NULL, 1, '2023-03-25 18:41:22', '2026-01-21 17:39:28'),
(542, 136, 1, 2, 'realised fx exchange loss', '50625382', 'expense', 134803.92, NULL, 1, '2023-03-25 18:41:22', '2026-02-05 18:21:30'),
(543, 81, 1, 2, 'cashmatrix expense', '50600039', 'expense', 4406157.31, NULL, 1, '2023-03-25 18:41:22', '2026-02-02 19:42:55'),
(544, 81, 1, 2, 'apex group', '50758109', 'expense', 0.00, NULL, 1, '2023-03-25 18:41:22', '2025-04-24 15:15:10'),
(545, 81, 1, 2, 'gbp brokerage gl', '50518176', 'expense', 0.00, NULL, 1, '2023-03-25 18:41:22', '2025-03-31 15:44:17'),
(546, 27, 1, 2, 'depreciation expenses', '50218508', 'expense', 0.00, NULL, 1, '2023-03-25 18:41:22', '2025-04-02 23:10:49'),
(547, 81, 1, 2, 'pilot securities', '50593805', 'expense', 0.00, NULL, 1, '2023-03-25 18:41:22', '2025-04-02 23:26:18'),
(548, NULL, 1, 2, 'group', '50508562', 'expense', 0.00, NULL, 0, '2023-03-25 18:41:22', '2023-06-10 22:37:54'),
(549, 106, 1, NULL, 'out-of-station allowance', '50616293', 'expense', 1800000.00, NULL, 1, '2023-03-25 18:41:22', '2026-01-16 14:26:46'),
(550, 81, 1, 2, 'rg farms expenses', '50910751', 'expense', 500000.00, NULL, 1, '2023-03-25 18:41:22', '2026-01-21 17:26:47'),
(551, 10, 1, 1, 'bad debt expense', '50926990', 'expense', 0.00, NULL, 1, '2023-03-25 18:41:22', '2023-06-10 22:28:37'),
(552, 52, 1, 2, 'interest expense fd dollars', '50500086', 'expense', 342450.27, '1', 1, '2023-03-25 18:41:22', '2026-02-06 05:00:19'),
(553, 81, 1, 2, 'marine expenses', '50277011', 'expense', 0.00, NULL, 1, '2023-03-25 18:41:22', '2025-03-31 16:11:20'),
(554, 81, 1, 2, 'egbeda project', '50453990', 'expense', 0.00, NULL, 1, '2023-03-25 18:41:22', '2026-01-07 18:09:50'),
(555, 10, 1, 2, 'bad debt written off-lost-100%', '50760891', 'expense', 0.00, NULL, 1, '2023-03-25 18:41:22', '2023-06-09 20:09:09'),
(556, NULL, 1, 2, 'inte', '50709977', 'expense', 0.00, NULL, 0, '2023-03-25 18:41:22', '2023-06-10 22:40:14'),
(557, 81, 1, NULL, 'ghana project', '50231150', 'expense', 0.00, NULL, 1, '2023-03-25 18:41:22', '2025-04-02 23:34:52'),
(558, 81, 1, 2, 'repair & maintenance office premises', '50167764', 'expense', 131000.00, NULL, 1, '2023-03-25 18:41:22', '2026-02-05 18:50:46'),
(559, 36, 1, 2, 'fees & charges(income)', '40476030', 'income', 0.00, NULL, 1, '2023-03-29 15:17:31', '2023-06-09 14:25:04'),
(560, 134, 1, 1, 'moniepointmfb', '10794478', 'asset', 143100000.00, NULL, 1, '2023-05-02 16:38:45', '2025-10-16 10:21:29'),
(561, 17, 1, 1, 'wallet gl', '10733842', 'asset', 0.00, NULL, 1, '2023-05-08 14:48:53', '2023-06-27 09:32:20'),
(562, 41, 1, 2, 'improvement to building(purchase)', '10502088', 'asset', 0.00, NULL, 1, '2023-06-09 09:51:12', '2023-06-09 09:51:12'),
(563, 36, 1, 2, 'whatsapp fee income', '40628214', 'income', 0.00, NULL, 0, '2024-06-25 17:16:47', '2024-06-25 17:17:41'),
(564, 34, 21, NULL, 'ggt connect expenses', '50423642', 'expense', 0.00, NULL, 1, '2024-07-08 18:18:04', '2025-08-21 17:37:24'),
(565, 79, 21, 2, 'mv lio zhuang yu 15030 & mt dejikun 871605(vessels)', '10405892', 'asset', 322000000.00, NULL, 1, '2024-07-09 14:03:47', '2025-09-12 16:33:09'),
(566, 32, 21, NULL, 'danbethel marine bank dues', '10957418', 'asset', 50000000.00, NULL, 1, '2024-07-10 18:30:18', '2025-11-11 11:43:47'),
(567, 36, 21, NULL, 'transfer charge dollar', '40520867', 'income', 0.00, '1', 1, '2024-07-12 14:12:18', '2025-07-30 13:12:55'),
(568, 79, 21, NULL, 'shares subscriptions', '10535518', 'asset', 90600000.00, NULL, 1, '2024-07-22 15:24:28', '2025-09-12 16:33:50'),
(569, 32, 21, NULL, 'rgm consulting bank', '10907154', 'asset', 0.00, NULL, 1, '2024-08-07 18:02:42', '2025-04-07 19:04:38'),
(570, 34, 21, NULL, 'ilesha mining', '50299533', 'expense', 450000.00, NULL, 1, '2025-02-20 09:17:42', '2026-02-05 10:45:59'),
(571, 114, 21, NULL, 'migration suspense ngn', '20419118', 'liability', 0.00, NULL, 1, '2025-03-31 13:15:20', '2025-08-27 14:50:19'),
(572, 114, 21, 2, 'migration suspense usd', '20887876', 'liability', 9313.00, '1', 1, '2025-03-31 13:16:21', '2025-10-10 14:14:51'),
(573, 114, 21, 2, 'migration suspense gbp', '20537337', 'liability', 0.00, '2', 1, '2025-03-31 13:17:11', '2025-08-22 13:20:13'),
(574, 114, 21, NULL, 'migration suspense cad', '20570593', 'liability', 0.00, '4', 1, '2025-03-31 13:37:28', '2025-08-01 20:51:10'),
(575, 114, 21, 2, 'migration suspense eur', '20431288', 'liability', 0.00, '3', 1, '2025-03-31 13:38:12', '2025-06-20 13:34:47'),
(576, 102, 5, 2, 'purchase of cad gl (naira)', '10569099', 'asset', 139205788.00, NULL, 1, '2025-10-02 17:29:27', '2026-01-29 17:53:52'),
(577, 32, 5, 2, 'fcmb rgm consolidated company ltd usd', '10304074', 'asset', -7000.00, '1', 1, '2025-10-02 17:53:30', '2025-12-24 14:25:26'),
(578, 102, 5, 2, 'stocks trading acct with pilot secuties', '10813074', 'asset', 3151000000.00, NULL, 1, '2025-10-03 17:12:10', '2026-01-26 19:26:27'),
(579, 32, 5, 2, 'bank suspense gl', '10780714', 'asset', -1379100000.00, NULL, 1, '2025-10-08 09:49:03', '2026-01-15 16:29:33'),
(580, 133, 5, 2, 'rg masters inv- zenith bank usd (5070413091)', '10679255', 'asset', -152360.00, '1', 1, '2025-10-15 11:50:07', '2026-01-05 17:08:16'),
(581, 102, 5, 2, 'revenir investment dollar', '10654054', 'asset', 10000.00, '1', 1, '2025-10-20 15:45:32', '2025-11-05 13:32:58'),
(582, 61, 5, 2, 'sambethel properties ltd', '10942917', 'asset', 737300000.00, NULL, 1, '2025-10-20 16:13:47', '2025-10-22 17:46:45'),
(583, 102, 30, NULL, 'purchase of euro (naira)', '10820248', 'asset', 158826080.48, NULL, 1, '2025-10-24 16:53:11', '2026-01-23 13:13:33'),
(584, 70, 30, NULL, 'borrowings- keystone/ggt', '20993679', 'liability', -500000000.00, NULL, 1, '2025-10-24 16:56:26', '2025-10-27 17:37:01'),
(585, 133, 30, NULL, 'rg canada (seun andu)-cad', '10764258', 'asset', 66454.79, '4', 1, '2025-10-31 12:31:54', '2026-01-30 19:00:40'),
(586, 32, 30, NULL, 'rgm consolidated company -access 1885968148', '10493950', 'asset', 215230604.92, NULL, 1, '2025-11-04 18:30:06', '2026-01-27 17:50:08'),
(587, 32, 30, NULL, 'rgm consolidated company ltd -uba- 1028947111 ngn', '10666182', 'asset', 0.00, NULL, 1, '2025-11-10 10:32:50', '2025-11-11 18:18:20'),
(588, 86, 30, NULL, 'transactions with danbethel marine', '10315321', 'asset', 136240000.00, NULL, 1, '2025-11-13 17:50:06', '2026-01-29 16:31:05'),
(589, 61, 30, NULL, 'enervolve global ltd investment', '10330859', 'asset', 141243854.75, NULL, 1, '2025-11-18 11:19:59', '2026-01-22 11:42:57'),
(590, 70, 30, NULL, 'borrowings from keystone ifo rgm consolidated ltd', '20783504', 'liability', 450000000.00, NULL, 1, '2025-12-04 17:27:41', '2025-12-05 14:48:50'),
(591, 32, 30, NULL, 'rg cashmatrix acct 2-5000280683', '10810585', 'asset', -191966162.98, NULL, 1, '2025-12-11 14:54:37', '2026-02-06 11:50:30'),
(592, 32, 30, NULL, 'rg capital providus', '10259688', 'asset', 1000000.00, NULL, 1, '2025-12-12 16:18:09', '2025-12-15 13:06:01'),
(593, 113, 30, NULL, 'upfront interest manual suspense gl', '10786725', 'asset', 0.00, NULL, 1, '2025-12-31 10:37:30', '2026-01-05 10:26:59'),
(594, 2, 30, NULL, 'rg cashmatrix liquidation-50737081', '20574859', 'liability', -42255988.79, NULL, 1, '2026-01-05 18:15:34', '2026-02-06 09:54:02'),
(595, 2, 30, NULL, 'rg cashmatrix int-50728695', '20632547', 'liability', 273716668.51, NULL, 1, '2026-01-05 18:16:37', '2026-02-05 18:12:35'),
(596, 122, 30, NULL, 'retained earnings', '30602383', 'capital', 0.00, NULL, 1, '2026-01-07 11:44:38', '2026-01-07 11:44:38'),
(597, 98, 30, NULL, 'end of year closure profit', '30273935', 'capital', -2782014747.79, NULL, 1, '2026-01-07 11:49:04', '2026-01-07 18:18:23'),
(598, 32, 30, NULL, 'igwt global ventures ltd keystone-1013921812', '10130257', 'asset', 50000000.00, NULL, 1, '2026-01-07 15:48:26', '2026-02-02 19:14:08'),
(599, 86, 30, NULL, 'igwt global ventures transactions with', '10760134', 'asset', 0.00, NULL, 1, '2026-01-07 15:51:21', '2026-01-07 15:51:21'),
(600, 41, 30, NULL, 'ostia project cost- lekki', '10364990', 'asset', 1624700000.00, NULL, 1, '2026-01-19 18:30:21', '2026-01-28 13:23:23'),
(601, 136, 30, NULL, 'fx brokerage', '50789100', 'expense', 0.00, NULL, 1, '2026-01-23 15:21:12', '2026-01-23 15:21:12'),
(602, 52, 30, NULL, 'additional cost of fund -finder\'s cost', '50935800', 'expense', 0.00, NULL, 1, '2026-01-23 15:23:26', '2026-01-23 15:23:26'),
(603, 81, 30, NULL, 'legal and other expenses', '50678797', 'expense', 163693.00, NULL, 1, '2026-01-23 16:16:17', '2026-02-05 19:52:56'),
(604, 76, 30, NULL, 'imto investment gl', '10589050', 'asset', 10000000.00, NULL, 1, '2026-01-26 13:52:01', '2026-01-26 19:28:11'),
(605, 79, 30, NULL, 'placements with other institutions', '10527531', 'asset', 0.00, NULL, 1, '2026-01-26 15:15:09', '2026-01-26 15:15:09'),
(606, 79, 30, NULL, 'placement with cedrus capital', '10855138', 'asset', 0.00, NULL, 1, '2026-01-26 15:16:37', '2026-01-26 15:16:37'),
(607, 79, 30, NULL, 'placement with lovonus mfb', '10458622', 'asset', 1000000000.00, NULL, 1, '2026-01-26 15:17:39', '2026-01-26 19:27:15'),
(608, 98, 30, NULL, 'end of year closure profit/loss(dollar)', '30323708', 'capital', 0.00, '1', 1, '2026-01-28 12:16:51', '2026-01-28 12:16:51'),
(609, 98, 30, NULL, 'end of year closure profit/loss (pounds)', '30317752', 'capital', 0.00, '2', 1, '2026-01-28 12:17:56', '2026-01-28 12:17:56'),
(610, 98, 30, NULL, 'end of year closure profit/loss (euro)', '30449732', 'capital', 0.00, '3', 1, '2026-01-28 12:19:15', '2026-01-28 12:19:15'),
(611, 98, 30, NULL, 'end of year closure profit/loss (cad)', '30731702', 'capital', 0.00, '4', 1, '2026-01-28 12:23:00', '2026-01-28 12:23:00'),
(612, 32, 30, NULL, 'rg master\'s capital ltd-access 1950019205', '10557769', 'asset', 100000000.00, NULL, 1, '2026-01-29 15:54:03', '2026-01-29 16:21:51'),
(613, 34, 30, NULL, 'sales commission-st', '50592225', 'expense', 0.00, NULL, 1, '2026-02-03 13:22:54', '2026-02-03 13:22:54'),
(614, 68, 30, NULL, 'employer\'s contribution pension', '50801780', 'expense', 0.00, NULL, 1, '2026-02-03 13:31:13', '2026-02-03 13:31:13');

-- --------------------------------------------------------

--
-- Table structure for table `investment_schedules`
--

CREATE TABLE `investment_schedules` (
  `id` bigint UNSIGNED NOT NULL,
  `fixed_deposit_id` bigint UNSIGNED NOT NULL,
  `customer_id` bigint UNSIGNED NOT NULL,
  `branch_id` bigint UNSIGNED DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `due_date` date NOT NULL,
  `principal` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `interest` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `rollover` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `total_interest` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `total_due` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `closed` tinyint NOT NULL DEFAULT '0',
  `payment_date` date DEFAULT NULL,
  `payment_method` varchar(225) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `posted_by` varchar(225) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `investment_schedules`
--

INSERT INTO `investment_schedules` (`id`, `fixed_deposit_id`, `customer_id`, `branch_id`, `description`, `due_date`, `principal`, `interest`, `rollover`, `total_interest`, `total_due`, `closed`, `payment_date`, `payment_method`, `posted_by`, `created_at`, `updated_at`) VALUES
(1, 15, 356, NULL, 'interest payment', '2025-09-27', '80000000', '2400000', '0', '2400000', '2400000', 1, '2025-09-08', 'liquidated', 'ADEIZA ABIODUN EMMANUEL', '2025-09-04 18:22:17', '2025-09-08 11:48:57'),
(2, 15, 356, NULL, 'interest payment', '2025-10-27', '80000000', '2400000', '0', '2400000', '2400000', 1, '2025-09-08', 'liquidated', 'ADEIZA ABIODUN EMMANUEL', '2025-09-04 18:22:17', '2025-09-08 11:48:57'),
(3, 15, 356, NULL, 'interest payment', '2025-11-27', '80000000', '2400000', '0', '2400000', '82400000', 1, '2025-09-08', 'liquidated', 'ADEIZA ABIODUN EMMANUEL', '2025-09-04 18:22:17', '2025-09-08 11:48:57'),
(4, 16, 356, NULL, 'interest payment', '2025-09-27', '21952017', '658560.51', '0', '658560.51', '658560.51', 1, '2025-11-10', 'liquidated', 'Yusuf Ayotunde', '2025-09-04 18:36:46', '2025-11-10 19:45:38'),
(5, 16, 356, NULL, 'interest payment', '2025-10-27', '21952017', '658560.51', '19756.8153', '1336877.8353', '1336877.8353', 1, '2025-11-10', 'liquidated', 'Yusuf Ayotunde', '2025-09-04 18:36:46', '2025-11-10 19:45:38'),
(6555, 1844, 3, NULL, 'interest payment', '2026-03-06', '20000', '300', '0', '300', '300', 0, NULL, NULL, NULL, '2026-02-06 14:20:19', '2026-02-06 14:20:19'),
(6556, 1844, 3, NULL, 'interest payment', '2026-04-06', '20000', '300', '0', '300', '300', 0, NULL, NULL, NULL, '2026-02-06 14:20:19', '2026-02-06 14:20:19'),
(6557, 1844, 3, NULL, 'interest payment', '2026-05-06', '20000', '300', '0', '300', '20300', 0, NULL, NULL, NULL, '2026-02-06 14:20:19', '2026-02-06 14:20:19'),
(6558, 1846, 3, NULL, 'interest payment', '2026-03-04', '5000', '2.4657534246575', '0', '2.4657534246575', '2.4657534246575', 0, NULL, NULL, NULL, '2026-03-02 10:54:24', '2026-03-02 10:54:24'),
(6559, 1846, 3, NULL, 'interest payment', '2026-03-05', '5000', '2.4657534246575', '0.0012159879902421', '4.9327228373053', '4.9327228373053', 0, NULL, NULL, NULL, '2026-03-02 10:54:24', '2026-03-02 10:54:24'),
(6560, 1846, 3, NULL, 'interest payment', '2026-03-06', '5000', '2.4657534246575', '0.0024325756457944', '7.4009088376086', '7.4009088376086', 0, NULL, NULL, NULL, '2026-03-02 10:54:24', '2026-03-02 10:54:24'),
(6561, 1846, 3, NULL, 'interest payment', '2026-03-07', '5000', '2.4657534246575', '0.0036497632623823', '9.8703120255286', '9.8703120255286', 0, NULL, NULL, NULL, '2026-03-02 10:54:24', '2026-03-02 10:54:24'),
(6562, 1846, 3, NULL, 'interest payment', '2026-03-08', '5000', '2.4657534246575', '0.0048675511358771', '12.340933001322', '12.340933001322', 0, NULL, NULL, NULL, '2026-03-02 10:54:24', '2026-03-02 10:54:24'),
(6563, 1846, 3, NULL, 'interest payment', '2026-03-09', '5000', '2.4657534246575', '0.0060859395622958', '14.812772365542', '14.812772365542', 0, NULL, NULL, NULL, '2026-03-02 10:54:24', '2026-03-02 10:54:24'),
(6564, 1846, 3, NULL, 'interest payment', '2026-03-10', '5000', '2.4657534246575', '0.0073049288378014', '17.285830719037', '17.285830719037', 0, NULL, NULL, NULL, '2026-03-02 10:54:24', '2026-03-02 10:54:24'),
(6565, 1846, 3, NULL, 'interest payment', '2026-03-11', '5000', '2.4657534246575', '0.0085245192587032', '19.760108662953', '19.760108662953', 0, NULL, NULL, NULL, '2026-03-02 10:54:24', '2026-03-02 10:54:24'),
(6566, 1846, 3, NULL, 'interest payment', '2026-03-12', '5000', '2.4657534246575', '0.0097447111214565', '22.235606798732', '22.235606798732', 0, NULL, NULL, NULL, '2026-03-02 10:54:24', '2026-03-02 10:54:24'),
(6567, 1846, 3, NULL, 'interest payment', '2026-03-13', '5000', '2.4657534246575', '0.010965504722663', '24.712325728113', '24.712325728113', 0, NULL, NULL, NULL, '2026-03-02 10:54:24', '2026-03-02 10:54:24'),
(6568, 1846, 3, NULL, 'interest payment', '2026-03-14', '5000', '2.4657534246575', '0.012186900359069', '27.190266053129', '27.190266053129', 0, NULL, NULL, NULL, '2026-03-02 10:54:24', '2026-03-02 10:54:24'),
(6569, 1846, 3, NULL, 'interest payment', '2026-03-15', '5000', '2.4657534246575', '0.013408898327571', '29.669428376114', '29.669428376114', 0, NULL, NULL, NULL, '2026-03-02 10:54:24', '2026-03-02 10:54:24'),
(6570, 1846, 3, NULL, 'interest payment', '2026-03-16', '5000', '2.4657534246575', '0.014631498925207', '32.149813299697', '32.149813299697', 0, NULL, NULL, NULL, '2026-03-02 10:54:24', '2026-03-02 10:54:24'),
(6571, 1846, 3, NULL, 'interest payment', '2026-03-17', '5000', '2.4657534246575', '0.014631498925207', '32.149813299697', '32.149813299697', 0, NULL, NULL, NULL, '2026-03-02 10:54:24', '2026-03-02 10:54:24'),
(6572, 1846, 3, NULL, 'interest payment', '2026-03-18', '5000', '2.4657534246575', '0.014631498925207', '32.149813299697', '32.149813299697', 0, NULL, NULL, NULL, '2026-03-02 10:54:24', '2026-03-02 10:54:24'),
(6573, 1845, 3, NULL, 'interest payment', '2026-03-04', '10000', '4.9315068493151', '0', '4.9315068493151', '4.9315068493151', 0, NULL, NULL, NULL, '2026-03-02 10:58:21', '2026-03-02 10:58:21'),
(6574, 1845, 3, NULL, 'interest payment', '2026-03-05', '10000', '4.9315068493151', '0.0024319759804841', '9.8654456746106', '9.8654456746106', 0, NULL, NULL, NULL, '2026-03-02 10:58:21', '2026-03-02 10:58:21'),
(6575, 1845, 3, NULL, 'interest payment', '2026-03-06', '10000', '4.9315068493151', '0.0048651512915888', '14.801817675217', '14.801817675217', 0, NULL, NULL, NULL, '2026-03-02 10:58:21', '2026-03-02 10:58:21'),
(6576, 1845, 3, NULL, 'interest payment', '2026-03-07', '10000', '4.9315068493151', '0.0072995265247647', '19.740624051057', '19.740624051057', 0, NULL, NULL, NULL, '2026-03-02 10:58:21', '2026-03-02 10:58:21'),
(6577, 1845, 3, NULL, 'interest payment', '2026-03-08', '10000', '4.9315068493151', '0.0097351022717542', '24.681866002644', '24.681866002644', 0, NULL, NULL, NULL, '2026-03-02 10:58:21', '2026-03-02 10:58:21'),
(6578, 1845, 3, NULL, 'interest payment', '2026-03-09', '10000', '4.9315068493151', '0.012171879124592', '29.625544731084', '29.625544731084', 0, NULL, NULL, NULL, '2026-03-02 10:58:21', '2026-03-02 10:58:21'),
(6579, 1845, 3, NULL, 'interest payment', '2026-03-10', '10000', '4.9315068493151', '0.014609857675603', '34.571661438074', '34.571661438074', 0, NULL, NULL, NULL, '2026-03-02 10:58:21', '2026-03-02 10:58:21'),
(6580, 1845, 3, NULL, 'interest payment', '2026-03-11', '10000', '4.9315068493151', '0.017049038517406', '39.520217325907', '39.520217325907', 0, NULL, NULL, NULL, '2026-03-02 10:58:21', '2026-03-02 10:58:21'),
(6581, 1845, 3, NULL, 'interest payment', '2026-03-12', '10000', '4.9315068493151', '0.019489422242913', '44.471213597465', '44.471213597465', 0, NULL, NULL, NULL, '2026-03-02 10:58:21', '2026-03-02 10:58:21'),
(6582, 1845, 3, NULL, 'interest payment', '2026-03-13', '10000', '4.9315068493151', '0.021931009445325', '49.424651456225', '49.424651456225', 0, NULL, NULL, NULL, '2026-03-02 10:58:21', '2026-03-02 10:58:21'),
(6583, 1845, 3, NULL, 'interest payment', '2026-03-14', '10000', '4.9315068493151', '0.024373800718138', '54.380532106258', '54.380532106258', 0, NULL, NULL, NULL, '2026-03-02 10:58:21', '2026-03-02 10:58:21'),
(6584, 1845, 3, NULL, 'interest payment', '2026-03-15', '10000', '4.9315068493151', '0.026817796655141', '59.338856752229', '59.338856752229', 0, NULL, NULL, NULL, '2026-03-02 10:58:21', '2026-03-02 10:58:21'),
(6585, 1845, 3, NULL, 'interest payment', '2026-03-16', '10000', '4.9315068493151', '0.029262997850414', '64.299626599394', '64.299626599394', 0, NULL, NULL, NULL, '2026-03-02 10:58:21', '2026-03-02 10:58:21'),
(6586, 1845, 3, NULL, 'interest payment', '2026-03-17', '10000', '4.9315068493151', '0.029262997850414', '64.299626599394', '64.299626599394', 0, NULL, NULL, NULL, '2026-03-02 10:58:21', '2026-03-02 10:58:21'),
(6587, 1845, 3, NULL, 'interest payment', '2026-03-18', '10000', '4.9315068493151', '0.029262997850414', '64.299626599394', '64.299626599394', 0, NULL, NULL, NULL, '2026-03-02 10:58:21', '2026-03-02 10:58:21'),
(6588, 1845, 3, NULL, 'interest payment', '2026-03-19', '10000', '4.9315068493151', '0.029262997850414', '64.299626599394', '64.299626599394', 0, NULL, NULL, NULL, '2026-03-02 10:58:21', '2026-03-02 10:58:21'),
(6589, 1845, 3, NULL, 'interest payment', '2026-03-20', '10000', '4.9315068493151', '0.029262997850414', '64.299626599394', '64.299626599394', 0, NULL, NULL, NULL, '2026-03-02 10:58:21', '2026-03-02 10:58:21'),
(6590, 1845, 3, NULL, 'interest payment', '2026-03-21', '10000', '4.9315068493151', '0.029262997850414', '64.299626599394', '64.299626599394', 0, NULL, NULL, NULL, '2026-03-02 10:58:21', '2026-03-02 10:58:21'),
(6591, 1845, 3, NULL, 'interest payment', '2026-03-22', '10000', '4.9315068493151', '0.029262997850414', '64.299626599394', '64.299626599394', 0, NULL, NULL, NULL, '2026-03-02 10:58:21', '2026-03-02 10:58:21'),
(6592, 1845, 3, NULL, 'interest payment', '2026-03-23', '10000', '4.9315068493151', '0.029262997850414', '64.299626599394', '64.299626599394', 0, NULL, NULL, NULL, '2026-03-02 10:58:21', '2026-03-02 10:58:21'),
(6593, 1847, 3, NULL, 'interest payment', '2026-04-03', '8000', '3.9452054794521', '0', '3.9452054794521', '3.9452054794521', 0, NULL, NULL, NULL, '2026-03-02 14:51:26', '2026-03-02 14:51:26'),
(6594, 1847, 3, NULL, 'interest payment', '2026-04-04', '8000', '3.9452054794521', '0.0019455807843873', '7.8923565396885', '7.8923565396885', 0, NULL, NULL, NULL, '2026-03-02 14:51:26', '2026-03-02 14:51:26'),
(6595, 1847, 3, NULL, 'interest payment', '2026-04-05', '8000', '3.9452054794521', '0.003892121033271', '11.841454140174', '11.841454140174', 0, NULL, NULL, NULL, '2026-03-02 14:51:26', '2026-03-02 14:51:26'),
(6596, 1847, 3, NULL, 'interest payment', '2026-04-06', '8000', '3.9452054794521', '0.0058396212198117', '15.792499240846', '15.792499240846', 0, NULL, NULL, NULL, '2026-03-02 14:51:26', '2026-03-02 14:51:26'),
(6597, 1847, 3, NULL, 'interest payment', '2026-04-07', '8000', '3.9452054794521', '0.0077880818174034', '19.745492802115', '19.745492802115', 0, NULL, NULL, NULL, '2026-03-02 14:51:26', '2026-03-02 14:51:26'),
(6598, 1847, 3, NULL, 'interest payment', '2026-04-08', '8000', '3.9452054794521', '0.0097375032996732', '23.700435784867', '23.700435784867', 0, NULL, NULL, NULL, '2026-03-02 14:51:26', '2026-03-02 14:51:26'),
(6599, 1847, 3, NULL, 'interest payment', '2026-04-09', '8000', '3.9452054794521', '0.011687886140482', '27.657329150459', '27.657329150459', 0, NULL, NULL, NULL, '2026-03-02 14:51:26', '2026-03-02 14:51:26'),
(6600, 1847, 3, NULL, 'interest payment', '2026-04-10', '8000', '3.9452054794521', '0.013639230813925', '31.616173860725', '31.616173860725', 0, NULL, NULL, NULL, '2026-03-02 14:51:26', '2026-03-02 14:51:26'),
(6601, 1847, 3, NULL, 'interest payment', '2026-04-11', '8000', '3.9452054794521', '0.01559153779433', '35.576970877972', '35.576970877972', 0, NULL, NULL, NULL, '2026-03-02 14:51:26', '2026-03-02 14:51:26'),
(6602, 1847, 3, NULL, 'interest payment', '2026-04-12', '8000', '3.9452054794521', '0.01754480755626', '39.53972116498', '39.53972116498', 0, NULL, NULL, NULL, '2026-03-02 14:51:26', '2026-03-02 14:51:26'),
(6603, 1847, 3, NULL, 'interest payment', '2026-04-13', '8000', '3.9452054794521', '0.019499040574511', '43.504425685007', '43.504425685007', 0, NULL, NULL, NULL, '2026-03-02 14:51:26', '2026-03-02 14:51:26'),
(6604, 1847, 3, NULL, 'interest payment', '2026-04-14', '8000', '3.9452054794521', '0.021454237324113', '47.471085401783', '47.471085401783', 0, NULL, NULL, NULL, '2026-03-02 14:51:26', '2026-03-02 14:51:26'),
(6605, 1847, 3, NULL, 'interest payment', '2026-04-15', '8000', '3.9452054794521', '0.023410398280331', '51.439701279515', '51.439701279515', 0, NULL, NULL, NULL, '2026-03-02 14:51:26', '2026-03-02 14:51:26'),
(6606, 1847, 3, NULL, 'interest payment', '2026-04-16', '8000', '3.9452054794521', '0.023410398280331', '51.439701279515', '51.439701279515', 0, NULL, NULL, NULL, '2026-03-02 14:51:26', '2026-03-02 14:51:26'),
(6607, 1847, 3, NULL, 'interest payment', '2026-04-17', '8000', '3.9452054794521', '0.023410398280331', '51.439701279515', '51.439701279515', 0, NULL, NULL, NULL, '2026-03-02 14:51:26', '2026-03-02 14:51:26'),
(6608, 1847, 3, NULL, 'interest payment', '2026-04-18', '8000', '3.9452054794521', '0.023410398280331', '51.439701279515', '51.439701279515', 0, NULL, NULL, NULL, '2026-03-02 14:51:26', '2026-03-02 14:51:26'),
(6609, 1847, 3, NULL, 'interest payment', '2026-04-19', '8000', '3.9452054794521', '0.023410398280331', '51.439701279515', '51.439701279515', 0, NULL, NULL, NULL, '2026-03-02 14:51:26', '2026-03-02 14:51:26'),
(6610, 1847, 3, NULL, 'interest payment', '2026-04-20', '8000', '3.9452054794521', '0.023410398280331', '51.439701279515', '51.439701279515', 0, NULL, NULL, NULL, '2026-03-02 14:51:26', '2026-03-02 14:51:26'),
(6611, 1847, 3, NULL, 'interest payment', '2026-04-21', '8000', '3.9452054794521', '0.023410398280331', '51.439701279515', '51.439701279515', 0, NULL, NULL, NULL, '2026-03-02 14:51:26', '2026-03-02 14:51:26'),
(6612, 1847, 3, NULL, 'interest payment', '2026-04-22', '8000', '3.9452054794521', '0.023410398280331', '51.439701279515', '51.439701279515', 0, NULL, NULL, NULL, '2026-03-02 14:51:26', '2026-03-02 14:51:26'),
(6613, 1847, 3, NULL, 'interest payment', '2026-04-23', '8000', '3.9452054794521', '0.023410398280331', '51.439701279515', '51.439701279515', 0, NULL, NULL, NULL, '2026-03-02 14:51:26', '2026-03-02 14:51:26'),
(6614, 1847, 3, NULL, 'interest payment', '2026-04-24', '8000', '3.9452054794521', '0.023410398280331', '51.439701279515', '51.439701279515', 0, NULL, NULL, NULL, '2026-03-02 14:51:26', '2026-03-02 14:51:26'),
(6615, 1847, 3, NULL, 'interest payment', '2026-04-25', '8000', '3.9452054794521', '0.023410398280331', '51.439701279515', '51.439701279515', 0, NULL, NULL, NULL, '2026-03-02 14:51:26', '2026-03-02 14:51:26'),
(6616, 1847, 3, NULL, 'interest payment', '2026-04-26', '8000', '3.9452054794521', '0.023410398280331', '51.439701279515', '51.439701279515', 0, NULL, NULL, NULL, '2026-03-02 14:51:26', '2026-03-02 14:51:26'),
(6617, 1847, 3, NULL, 'interest payment', '2026-04-27', '8000', '3.9452054794521', '0.023410398280331', '51.439701279515', '51.439701279515', 0, NULL, NULL, NULL, '2026-03-02 14:51:26', '2026-03-02 14:51:26'),
(6618, 1847, 3, NULL, 'interest payment', '2026-04-28', '8000', '3.9452054794521', '0.023410398280331', '51.439701279515', '51.439701279515', 0, NULL, NULL, NULL, '2026-03-02 14:51:26', '2026-03-02 14:51:26'),
(6619, 1847, 3, NULL, 'interest payment', '2026-04-29', '8000', '3.9452054794521', '0.023410398280331', '51.439701279515', '51.439701279515', 0, NULL, NULL, NULL, '2026-03-02 14:51:26', '2026-03-02 14:51:26'),
(6620, 1847, 3, NULL, 'interest payment', '2026-04-30', '8000', '3.9452054794521', '0.023410398280331', '51.439701279515', '51.439701279515', 0, NULL, NULL, NULL, '2026-03-02 14:51:26', '2026-03-02 14:51:26'),
(6621, 1847, 3, NULL, 'interest payment', '2026-05-01', '8000', '3.9452054794521', '0.023410398280331', '51.439701279515', '51.439701279515', 0, NULL, NULL, NULL, '2026-03-02 14:51:26', '2026-03-02 14:51:26'),
(6622, 1847, 3, NULL, 'interest payment', '2026-05-02', '8000', '3.9452054794521', '0.023410398280331', '51.439701279515', '51.439701279515', 0, NULL, NULL, NULL, '2026-03-02 14:51:26', '2026-03-02 14:51:26'),
(6623, 1847, 3, NULL, 'interest payment', '2026-04-03', '8000', '3.9452054794521', '0', '3.9452054794521', '3.9452054794521', 0, NULL, NULL, NULL, '2026-03-02 14:55:33', '2026-03-02 14:55:33'),
(6624, 1847, 3, NULL, 'interest payment', '2026-04-04', '8000', '3.9452054794521', '0.0019455807843873', '7.8923565396885', '7.8923565396885', 0, NULL, NULL, NULL, '2026-03-02 14:55:33', '2026-03-02 14:55:33'),
(6625, 1847, 3, NULL, 'interest payment', '2026-04-05', '8000', '3.9452054794521', '0.003892121033271', '11.841454140174', '11.841454140174', 0, NULL, NULL, NULL, '2026-03-02 14:55:33', '2026-03-02 14:55:33'),
(6626, 1847, 3, NULL, 'interest payment', '2026-04-06', '8000', '3.9452054794521', '0.0058396212198117', '15.792499240846', '15.792499240846', 0, NULL, NULL, NULL, '2026-03-02 14:55:33', '2026-03-02 14:55:33'),
(6627, 1847, 3, NULL, 'interest payment', '2026-04-07', '8000', '3.9452054794521', '0.0077880818174034', '19.745492802115', '19.745492802115', 0, NULL, NULL, NULL, '2026-03-02 14:55:33', '2026-03-02 14:55:33'),
(6628, 1847, 3, NULL, 'interest payment', '2026-04-08', '8000', '3.9452054794521', '0.0097375032996732', '23.700435784867', '23.700435784867', 0, NULL, NULL, NULL, '2026-03-02 14:55:33', '2026-03-02 14:55:33'),
(6629, 1847, 3, NULL, 'interest payment', '2026-04-09', '8000', '3.9452054794521', '0.011687886140482', '27.657329150459', '27.657329150459', 0, NULL, NULL, NULL, '2026-03-02 14:55:33', '2026-03-02 14:55:33'),
(6630, 1847, 3, NULL, 'interest payment', '2026-04-10', '8000', '3.9452054794521', '0.013639230813925', '31.616173860725', '31.616173860725', 0, NULL, NULL, NULL, '2026-03-02 14:55:33', '2026-03-02 14:55:33'),
(6631, 1847, 3, NULL, 'interest payment', '2026-04-11', '8000', '3.9452054794521', '0.01559153779433', '35.576970877972', '35.576970877972', 0, NULL, NULL, NULL, '2026-03-02 14:55:33', '2026-03-02 14:55:33'),
(6632, 1847, 3, NULL, 'interest payment', '2026-04-12', '8000', '3.9452054794521', '0.01754480755626', '39.53972116498', '39.53972116498', 0, NULL, NULL, NULL, '2026-03-02 14:55:33', '2026-03-02 14:55:33'),
(6633, 1847, 3, NULL, 'interest payment', '2026-04-13', '8000', '3.9452054794521', '0.019499040574511', '43.504425685007', '43.504425685007', 0, NULL, NULL, NULL, '2026-03-02 14:55:33', '2026-03-02 14:55:33'),
(6634, 1847, 3, NULL, 'interest payment', '2026-04-14', '8000', '3.9452054794521', '0.021454237324113', '47.471085401783', '47.471085401783', 0, NULL, NULL, NULL, '2026-03-02 14:55:33', '2026-03-02 14:55:33'),
(6635, 1847, 3, NULL, 'interest payment', '2026-04-15', '8000', '3.9452054794521', '0.023410398280331', '51.439701279515', '51.439701279515', 0, NULL, NULL, NULL, '2026-03-02 14:55:33', '2026-03-02 14:55:33'),
(6636, 1847, 3, NULL, 'interest payment', '2026-04-16', '8000', '3.9452054794521', '0.023410398280331', '51.439701279515', '51.439701279515', 0, NULL, NULL, NULL, '2026-03-02 14:55:33', '2026-03-02 14:55:33'),
(6637, 1847, 3, NULL, 'interest payment', '2026-04-17', '8000', '3.9452054794521', '0.023410398280331', '51.439701279515', '51.439701279515', 0, NULL, NULL, NULL, '2026-03-02 14:55:33', '2026-03-02 14:55:33'),
(6638, 1847, 3, NULL, 'interest payment', '2026-04-18', '8000', '3.9452054794521', '0.023410398280331', '51.439701279515', '51.439701279515', 0, NULL, NULL, NULL, '2026-03-02 14:55:33', '2026-03-02 14:55:33'),
(6639, 1847, 3, NULL, 'interest payment', '2026-04-19', '8000', '3.9452054794521', '0.023410398280331', '51.439701279515', '51.439701279515', 0, NULL, NULL, NULL, '2026-03-02 14:55:33', '2026-03-02 14:55:33'),
(6640, 1847, 3, NULL, 'interest payment', '2026-04-20', '8000', '3.9452054794521', '0.023410398280331', '51.439701279515', '51.439701279515', 0, NULL, NULL, NULL, '2026-03-02 14:55:33', '2026-03-02 14:55:33'),
(6641, 1847, 3, NULL, 'interest payment', '2026-04-21', '8000', '3.9452054794521', '0.023410398280331', '51.439701279515', '51.439701279515', 0, NULL, NULL, NULL, '2026-03-02 14:55:33', '2026-03-02 14:55:33'),
(6642, 1847, 3, NULL, 'interest payment', '2026-04-22', '8000', '3.9452054794521', '0.023410398280331', '51.439701279515', '51.439701279515', 0, NULL, NULL, NULL, '2026-03-02 14:55:33', '2026-03-02 14:55:33'),
(6643, 1847, 3, NULL, 'interest payment', '2026-04-23', '8000', '3.9452054794521', '0.023410398280331', '51.439701279515', '51.439701279515', 0, NULL, NULL, NULL, '2026-03-02 14:55:33', '2026-03-02 14:55:33'),
(6644, 1847, 3, NULL, 'interest payment', '2026-04-24', '8000', '3.9452054794521', '0.023410398280331', '51.439701279515', '51.439701279515', 0, NULL, NULL, NULL, '2026-03-02 14:55:33', '2026-03-02 14:55:33'),
(6645, 1847, 3, NULL, 'interest payment', '2026-04-25', '8000', '3.9452054794521', '0.023410398280331', '51.439701279515', '51.439701279515', 0, NULL, NULL, NULL, '2026-03-02 14:55:33', '2026-03-02 14:55:33'),
(6646, 1847, 3, NULL, 'interest payment', '2026-04-26', '8000', '3.9452054794521', '0.023410398280331', '51.439701279515', '51.439701279515', 0, NULL, NULL, NULL, '2026-03-02 14:55:33', '2026-03-02 14:55:33'),
(6647, 1847, 3, NULL, 'interest payment', '2026-04-27', '8000', '3.9452054794521', '0.023410398280331', '51.439701279515', '51.439701279515', 0, NULL, NULL, NULL, '2026-03-02 14:55:33', '2026-03-02 14:55:33'),
(6648, 1847, 3, NULL, 'interest payment', '2026-04-28', '8000', '3.9452054794521', '0.023410398280331', '51.439701279515', '51.439701279515', 0, NULL, NULL, NULL, '2026-03-02 14:55:33', '2026-03-02 14:55:33'),
(6649, 1847, 3, NULL, 'interest payment', '2026-04-29', '8000', '3.9452054794521', '0.023410398280331', '51.439701279515', '51.439701279515', 0, NULL, NULL, NULL, '2026-03-02 14:55:33', '2026-03-02 14:55:33'),
(6650, 1847, 3, NULL, 'interest payment', '2026-04-30', '8000', '3.9452054794521', '0.023410398280331', '51.439701279515', '51.439701279515', 0, NULL, NULL, NULL, '2026-03-02 14:55:33', '2026-03-02 14:55:33'),
(6651, 1847, 3, NULL, 'interest payment', '2026-05-01', '8000', '3.9452054794521', '0.023410398280331', '51.439701279515', '51.439701279515', 0, NULL, NULL, NULL, '2026-03-02 14:55:33', '2026-03-02 14:55:33'),
(6652, 1847, 3, NULL, 'interest payment', '2026-05-02', '8000', '3.9452054794521', '0.023410398280331', '51.439701279515', '51.439701279515', 0, NULL, NULL, NULL, '2026-03-02 14:55:33', '2026-03-02 14:55:33'),
(6653, 1848, 3, NULL, 'interest payment', '2026-03-04', '9000', '4.4383561643836', '0', '4.4383561643836', '4.4383561643836', 0, NULL, NULL, NULL, '2026-03-02 14:58:30', '2026-03-02 14:58:30'),
(6654, 1848, 3, NULL, 'interest payment', '2026-03-05', '9000', '4.4383561643836', '0', '4.4383561643836', '4.4383561643836', 0, NULL, NULL, NULL, '2026-03-02 14:58:30', '2026-03-02 14:58:30'),
(6655, 1848, 3, NULL, 'interest payment', '2026-03-06', '9000', '4.4383561643836', '0', '4.4383561643836', '4.4383561643836', 0, NULL, NULL, NULL, '2026-03-02 14:58:30', '2026-03-02 14:58:30'),
(6656, 1848, 3, NULL, 'interest payment', '2026-03-07', '9000', '4.4383561643836', '0', '4.4383561643836', '4.4383561643836', 0, NULL, NULL, NULL, '2026-03-02 14:58:30', '2026-03-02 14:58:30'),
(6657, 1848, 3, NULL, 'interest payment', '2026-03-08', '9000', '4.4383561643836', '0', '4.4383561643836', '4.4383561643836', 0, NULL, NULL, NULL, '2026-03-02 14:58:30', '2026-03-02 14:58:30'),
(6658, 1848, 3, NULL, 'interest payment', '2026-03-09', '9000', '4.4383561643836', '0', '4.4383561643836', '4.4383561643836', 0, NULL, NULL, NULL, '2026-03-02 14:58:30', '2026-03-02 14:58:30'),
(6659, 1848, 3, NULL, 'interest payment', '2026-03-10', '9000', '4.4383561643836', '0', '4.4383561643836', '4.4383561643836', 0, NULL, NULL, NULL, '2026-03-02 14:58:30', '2026-03-02 14:58:30'),
(6660, 1848, 3, NULL, 'interest payment', '2026-03-11', '9000', '4.4383561643836', '0', '4.4383561643836', '4.4383561643836', 0, NULL, NULL, NULL, '2026-03-02 14:58:30', '2026-03-02 14:58:30'),
(6661, 1848, 3, NULL, 'interest payment', '2026-03-12', '9000', '4.4383561643836', '0', '4.4383561643836', '4.4383561643836', 0, NULL, NULL, NULL, '2026-03-02 14:58:30', '2026-03-02 14:58:30'),
(6662, 1848, 3, NULL, 'interest payment', '2026-03-13', '9000', '4.4383561643836', '0', '4.4383561643836', '4.4383561643836', 0, NULL, NULL, NULL, '2026-03-02 14:58:30', '2026-03-02 14:58:30'),
(6663, 1848, 3, NULL, 'interest payment', '2026-03-14', '9000', '4.4383561643836', '0', '4.4383561643836', '4.4383561643836', 0, NULL, NULL, NULL, '2026-03-02 14:58:30', '2026-03-02 14:58:30'),
(6664, 1848, 3, NULL, 'interest payment', '2026-03-15', '9000', '4.4383561643836', '0', '4.4383561643836', '4.4383561643836', 0, NULL, NULL, NULL, '2026-03-02 14:58:30', '2026-03-02 14:58:30'),
(6665, 1848, 3, NULL, 'interest payment', '2026-03-16', '9000', '4.4383561643836', '0', '4.4383561643836', '4.4383561643836', 0, NULL, NULL, NULL, '2026-03-02 14:58:30', '2026-03-02 14:58:30'),
(6666, 1848, 3, NULL, 'interest payment', '2026-03-17', '9000', '4.4383561643836', '0', '4.4383561643836', '4.4383561643836', 0, NULL, NULL, NULL, '2026-03-02 14:58:30', '2026-03-02 14:58:30'),
(6667, 1848, 3, NULL, 'interest payment', '2026-03-18', '9000', '4.4383561643836', '0', '4.4383561643836', '4.4383561643836', 0, NULL, NULL, NULL, '2026-03-02 14:58:30', '2026-03-02 14:58:30'),
(6668, 1848, 3, NULL, 'interest payment', '2026-03-19', '9000', '4.4383561643836', '0', '4.4383561643836', '4.4383561643836', 0, NULL, NULL, NULL, '2026-03-02 14:58:30', '2026-03-02 14:58:30'),
(6669, 1848, 3, NULL, 'interest payment', '2026-03-20', '9000', '4.4383561643836', '0', '4.4383561643836', '4.4383561643836', 0, NULL, NULL, NULL, '2026-03-02 14:58:30', '2026-03-02 14:58:30'),
(6670, 1848, 3, NULL, 'interest payment', '2026-03-21', '9000', '4.4383561643836', '0', '4.4383561643836', '4.4383561643836', 0, NULL, NULL, NULL, '2026-03-02 14:58:30', '2026-03-02 14:58:30'),
(6671, 1848, 3, NULL, 'interest payment', '2026-03-22', '9000', '4.4383561643836', '0', '4.4383561643836', '4.4383561643836', 0, NULL, NULL, NULL, '2026-03-02 14:58:30', '2026-03-02 14:58:30'),
(6672, 1848, 3, NULL, 'interest payment', '2026-03-23', '9000', '4.4383561643836', '0', '4.4383561643836', '9004.4383561644', 0, NULL, NULL, NULL, '2026-03-02 14:58:30', '2026-03-02 14:58:30'),
(6679, 1849, 3, NULL, 'interest payment', '2026-05-06', '10000', '150', '0', '150', '150', 0, NULL, NULL, NULL, '2026-03-06 08:59:18', '2026-03-06 08:59:18'),
(6680, 1849, 3, NULL, 'interest payment', '2026-06-06', '10000', '150', '0', '150', '10150', 0, NULL, NULL, NULL, '2026-03-06 08:59:18', '2026-03-06 08:59:18'),
(6724, 1851, 3, NULL, 'interest payment', '2026-03-12', '10000', '147.94520547945', '0', '147.94520547945', '147.94520547945', 0, NULL, NULL, NULL, '2026-03-10 15:42:02', '2026-03-10 15:42:02'),
(6725, 1851, 3, NULL, 'interest payment', '2026-03-13', '10000', '147.94520547945', '2.1887783824357', '298.07918934134', '298.07918934134', 0, NULL, NULL, NULL, '2026-03-10 15:42:02', '2026-03-10 15:42:02'),
(6726, 1851, 3, NULL, 'interest payment', '2026-03-14', '10000', '147.94520547945', '4.4099386916253', '450.43433351242', '450.43433351242', 0, NULL, NULL, NULL, '2026-03-10 15:42:02', '2026-03-10 15:42:02'),
(6727, 1851, 3, NULL, 'interest payment', '2026-03-15', '10000', '147.94520547945', '6.6639600026495', '605.04349899452', '605.04349899452', 0, NULL, NULL, NULL, '2026-03-10 15:42:02', '2026-03-10 15:42:02'),
(6728, 1851, 3, NULL, 'interest payment', '2026-03-16', '10000', '147.94520547945', '8.9513284782751', '761.94003295225', '761.94003295225', 0, NULL, NULL, NULL, '2026-03-10 15:42:02', '2026-03-10 15:42:02'),
(6729, 1851, 3, NULL, 'interest payment', '2026-03-17', '10000', '147.94520547945', '11.272537473814', '921.15777590551', '921.15777590551', 0, NULL, NULL, NULL, '2026-03-10 15:42:02', '2026-03-10 15:42:02'),
(6730, 1851, 3, NULL, 'interest payment', '2026-03-18', '10000', '147.94520547945', '13.628087643534', '1082.7310690285', '1082.7310690285', 0, NULL, NULL, NULL, '2026-03-10 15:42:02', '2026-03-10 15:42:02'),
(6731, 1851, 3, NULL, 'interest payment', '2026-03-19', '10000', '147.94520547945', '16.018487048641', '1246.6947615566', '1246.6947615566', 0, NULL, NULL, NULL, '2026-03-10 15:42:02', '2026-03-10 15:42:02'),
(6732, 1851, 3, NULL, 'interest payment', '2026-03-20', '10000', '147.94520547945', '18.444251266865', '1413.0842183029', '1413.0842183029', 0, NULL, NULL, NULL, '2026-03-10 15:42:02', '2026-03-10 15:42:02'),
(6733, 1851, 3, NULL, 'interest payment', '2026-03-21', '10000', '147.94520547945', '20.905903503659', '1581.935327286', '1581.935327286', 0, NULL, NULL, NULL, '2026-03-10 15:42:02', '2026-03-10 15:42:02'),
(6734, 1851, 3, NULL, 'interest payment', '2026-03-22', '10000', '147.94520547945', '23.403974705053', '1753.2845074705', '1753.2845074705', 0, NULL, NULL, NULL, '2026-03-10 15:42:02', '2026-03-10 15:42:02'),
(6735, 1851, 3, NULL, 'interest payment', '2026-03-23', '10000', '147.94520547945', '25.939003672167', '1927.1687166221', '1927.1687166221', 0, NULL, NULL, NULL, '2026-03-10 15:42:02', '2026-03-10 15:42:02'),
(6736, 1851, 3, NULL, 'interest payment', '2026-03-24', '10000', '147.94520547945', '28.511537177423', '2103.625459279', '2103.625459279', 0, NULL, NULL, NULL, '2026-03-10 15:42:02', '2026-03-10 15:42:02'),
(6737, 1851, 3, NULL, 'interest payment', '2026-03-25', '10000', '147.94520547945', '28.511537177423', '2103.625459279', '2103.625459279', 0, NULL, NULL, NULL, '2026-03-10 15:42:02', '2026-03-10 15:42:02'),
(6738, 1851, 3, NULL, 'interest payment', '2026-03-26', '10000', '147.94520547945', '28.511537177423', '2103.625459279', '2103.625459279', 0, NULL, NULL, NULL, '2026-03-10 15:42:02', '2026-03-10 15:42:02'),
(6739, 1852, 3, NULL, 'interest payment', '2026-03-14', '10000', '147.94520547945', '0', '147.94520547945', '147.94520547945', 0, NULL, NULL, NULL, '2026-03-12 11:46:15', '2026-03-12 11:46:15'),
(6740, 1852, 3, NULL, 'interest payment', '2026-03-15', '10000', '147.94520547945', '2.1887783824357', '298.07918934134', '298.07918934134', 0, NULL, NULL, NULL, '2026-03-12 11:46:15', '2026-03-12 11:46:15'),
(6741, 1852, 3, NULL, 'interest payment', '2026-03-16', '10000', '147.94520547945', '4.4099386916253', '450.43433351242', '450.43433351242', 0, NULL, NULL, NULL, '2026-03-12 11:46:15', '2026-03-12 11:46:15'),
(6742, 1852, 3, NULL, 'interest payment', '2026-03-17', '10000', '147.94520547945', '6.6639600026495', '605.04349899452', '605.04349899452', 0, NULL, NULL, NULL, '2026-03-12 11:46:15', '2026-03-12 11:46:15'),
(6743, 1852, 3, NULL, 'interest payment', '2026-03-18', '10000', '147.94520547945', '8.9513284782751', '761.94003295225', '761.94003295225', 0, NULL, NULL, NULL, '2026-03-12 11:46:15', '2026-03-12 11:46:15'),
(6744, 1852, 3, NULL, 'interest payment', '2026-03-19', '10000', '147.94520547945', '11.272537473814', '921.15777590551', '921.15777590551', 0, NULL, NULL, NULL, '2026-03-12 11:46:15', '2026-03-12 11:46:15'),
(6745, 1852, 3, NULL, 'interest payment', '2026-03-20', '10000', '147.94520547945', '13.628087643534', '1082.7310690285', '1082.7310690285', 0, NULL, NULL, NULL, '2026-03-12 11:46:15', '2026-03-12 11:46:15'),
(6746, 1852, 3, NULL, 'interest payment', '2026-03-21', '10000', '147.94520547945', '16.018487048641', '1246.6947615566', '1246.6947615566', 0, NULL, NULL, NULL, '2026-03-12 11:46:15', '2026-03-12 11:46:15'),
(6747, 1852, 3, NULL, 'interest payment', '2026-03-22', '10000', '147.94520547945', '18.444251266865', '1413.0842183029', '1413.0842183029', 0, NULL, NULL, NULL, '2026-03-12 11:46:15', '2026-03-12 11:46:15'),
(6748, 1852, 3, NULL, 'interest payment', '2026-03-23', '10000', '147.94520547945', '20.905903503659', '1581.935327286', '1581.935327286', 0, NULL, NULL, NULL, '2026-03-12 11:46:15', '2026-03-12 11:46:15');

-- --------------------------------------------------------

--
-- Table structure for table `investmet_repayments`
--

CREATE TABLE `investmet_repayments` (
  `id` bigint UNSIGNED NOT NULL,
  `fixed_deposit_id` bigint UNSIGNED NOT NULL,
  `accountofficer_id` bigint UNSIGNED DEFAULT NULL,
  `customer_id` bigint UNSIGNED NOT NULL,
  `branch_id` bigint UNSIGNED DEFAULT NULL,
  `user_id` bigint UNSIGNED DEFAULT NULL,
  `amount` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payment_method` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `collection_date` date NOT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `due_date` date NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `investmet_repayments`
--

INSERT INTO `investmet_repayments` (`id`, `fixed_deposit_id`, `accountofficer_id`, `customer_id`, `branch_id`, `user_id`, `amount`, `payment_method`, `collection_date`, `notes`, `due_date`, `created_at`, `updated_at`) VALUES
(1, 282, 8, 568, NULL, 21, '0', 'flat', '2025-09-04', 'interest payment --60900254', '2025-09-28', '2025-09-04 21:11:22', '2025-09-04 21:11:22'),
(2, 282, 8, 568, NULL, 21, '0', 'flat', '2025-09-04', 'interest payment --60900254', '2025-10-28', '2025-09-04 21:11:22', '2025-09-04 21:11:22'),
(3, 282, 8, 568, NULL, 21, '0', 'flat', '2025-09-04', 'interest payment --60900254', '2025-11-28', '2025-09-04 21:11:22', '2025-09-04 21:11:22'),
(4, 280, 10, 464, NULL, 21, '0', 'flat', '2025-09-04', 'interest payment --35542743', '2025-09-25', '2025-09-04 21:12:48', '2025-09-04 21:12:48'),
(5, 280, 10, 464, NULL, 21, '0', 'flat', '2025-09-04', 'interest payment --35542743', '2025-10-25', '2025-09-04 21:12:48', '2025-09-04 21:12:48');

-- --------------------------------------------------------

--
-- Table structure for table `loans`
--

CREATE TABLE `loans` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED DEFAULT NULL,
  `customer_id` bigint UNSIGNED NOT NULL,
  `loan_product_id` bigint UNSIGNED NOT NULL,
  `branch_id` bigint UNSIGNED DEFAULT NULL,
  `accountofficer_id` bigint UNSIGNED NOT NULL,
  `approved_by_id` bigint UNSIGNED DEFAULT NULL,
  `disbursed_by_id` bigint UNSIGNED DEFAULT NULL,
  `withdrawn_by_id` bigint UNSIGNED DEFAULT NULL,
  `declined_by_id` bigint UNSIGNED DEFAULT NULL,
  `written_off_by_id` bigint UNSIGNED DEFAULT NULL,
  `rescheduled_by_id` bigint UNSIGNED DEFAULT NULL,
  `closed_by_id` bigint UNSIGNED DEFAULT NULL,
  `loan_code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `reference` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `equity` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `purpose` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `old_disbursedate` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `old_maturedate` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `release_date` date DEFAULT NULL,
  `maturity_date` date DEFAULT NULL,
  `interest_start_date` date DEFAULT NULL,
  `first_payment_date` date DEFAULT NULL,
  `principal` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `interest_method` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `interest_rate` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `interest_period` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'day',
  `override_interest` tinyint(1) NOT NULL DEFAULT '0',
  `override_interest_amount` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `loan_duration` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `loan_duration_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'year',
  `repayment_cycle` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'monthly',
  `repayment_order` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `loan_fees_schedule` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'distribute_fees_evenly',
  `grace_on_interest_charged` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `loan_status_id` int DEFAULT NULL,
  `files` text COLLATE utf8mb4_unicode_ci,
  `description` text COLLATE utf8mb4_unicode_ci,
  `loan_status` enum('open','fully_paid','defaulted','restructured','processing') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'open',
  `balance` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  `override` tinyint(1) NOT NULL DEFAULT '0',
  `applied_amount` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `approved_amount` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `approved_notes` text COLLATE utf8mb4_unicode_ci,
  `disbursed_notes` text COLLATE utf8mb4_unicode_ci,
  `withdrawn_notes` text COLLATE utf8mb4_unicode_ci,
  `closed_notes` text COLLATE utf8mb4_unicode_ci,
  `rescheduled_notes` text COLLATE utf8mb4_unicode_ci,
  `declined_notes` text COLLATE utf8mb4_unicode_ci,
  `written_off_notes` text COLLATE utf8mb4_unicode_ci,
  `approved_date` date DEFAULT NULL,
  `disbursed_date` date DEFAULT NULL,
  `disbursed_by` varchar(225) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `withdrawn_date` date DEFAULT NULL,
  `closed_date` date DEFAULT NULL,
  `rescheduled_date` date DEFAULT NULL,
  `declined_date` date DEFAULT NULL,
  `written_off_date` date DEFAULT NULL,
  `processing_fee` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` enum('pending','approved','disbursed','declined','withdrawn','written_off','closed','pending_reschedule','rescheduled','trashed') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `provision_date` date DEFAULT NULL,
  `provision_amount` varchar(225) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `provision_type` varchar(225) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sector_id` bigint DEFAULT NULL,
  `debit_mandate` tinyint(1) DEFAULT NULL,
  `mandate_ref` varchar(225) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mandate_sessionid` varchar(225) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `loans`
--

INSERT INTO `loans` (`id`, `user_id`, `customer_id`, `loan_product_id`, `branch_id`, `accountofficer_id`, `approved_by_id`, `disbursed_by_id`, `withdrawn_by_id`, `declined_by_id`, `written_off_by_id`, `rescheduled_by_id`, `closed_by_id`, `loan_code`, `reference`, `equity`, `purpose`, `old_disbursedate`, `old_maturedate`, `release_date`, `maturity_date`, `interest_start_date`, `first_payment_date`, `principal`, `interest_method`, `interest_rate`, `interest_period`, `override_interest`, `override_interest_amount`, `loan_duration`, `loan_duration_type`, `repayment_cycle`, `repayment_order`, `loan_fees_schedule`, `grace_on_interest_charged`, `loan_status_id`, `files`, `description`, `loan_status`, `balance`, `override`, `applied_amount`, `approved_amount`, `approved_notes`, `disbursed_notes`, `withdrawn_notes`, `closed_notes`, `rescheduled_notes`, `declined_notes`, `written_off_notes`, `approved_date`, `disbursed_date`, `disbursed_by`, `withdrawn_date`, `closed_date`, `rescheduled_date`, `declined_date`, `written_off_date`, `processing_fee`, `status`, `provision_date`, `provision_amount`, `provision_type`, `sector_id`, `debit_mandate`, `mandate_ref`, `mandate_sessionid`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1, 28, 669, 6, NULL, 13, 29, 29, NULL, NULL, NULL, NULL, NULL, '2309259430', NULL, '2', 'TO AUGMENT BUSINESS TRANSACTION', NULL, NULL, '2025-08-14', '2025-09-13', NULL, '2025-09-13', '54000000', 'flat_rate', '7', 'month', 0, NULL, '1', 'month', 'monthly', NULL, 'distribute_fees_evenly', '0', NULL, NULL, NULL, 'open', '54000000', 0, '54000000', '54000000', 'LOAN BOOKED 14-08-2025', 'LOAN BOOKED 14-08-2025--2309259430', NULL, NULL, NULL, NULL, NULL, '2025-08-14', '2025-08-14', 'cash', NULL, NULL, NULL, NULL, NULL, NULL, 'closed', '2025-09-23', '540000', 'performing', 13, NULL, NULL, NULL, NULL, '2025-09-23 16:19:01', '2025-10-17 17:48:04'),
(2, 28, 778, 6, NULL, 12, 29, 29, NULL, NULL, NULL, NULL, NULL, '2309251115', NULL, '0', 'TO MEET URGENT PERSONAL NEEDS', NULL, NULL, '2025-08-22', '2025-11-21', NULL, '2025-09-21', '4000000', 'flat_rate', '4', 'month', 0, NULL, '3', 'month', 'monthly', NULL, 'distribute_fees_evenly', '0', NULL, NULL, NULL, 'open', '4000000', 0, '4000000', '4000000', 'LOAN BOOKEED 22-08-2025', 'LOAN BOOKEED 22-08-2025--2309251115', NULL, NULL, NULL, NULL, NULL, '2025-08-22', '2025-08-22', 'cash', NULL, NULL, NULL, NULL, NULL, NULL, 'closed', '2025-09-23', '40000', 'performing', 13, NULL, NULL, NULL, NULL, '2025-09-23 16:21:32', '2025-10-31 17:59:01'),
(3, 28, 694, 6, NULL, 12, 29, 29, NULL, NULL, NULL, NULL, NULL, '2309255131', NULL, '0', 'TO AUGMENT BUSINESS TRANSACTION', NULL, NULL, '2025-08-04', '2025-10-03', NULL, '2025-09-03', '355955000', 'flat_rate', '7', 'month', 0, NULL, '2', 'month', 'monthly', NULL, 'distribute_fees_evenly', '0', NULL, NULL, NULL, 'open', '355955000', 0, '355955000', '355955000', 'LOAN BOOKED 04-08-2025', 'LOAN BOOKED 04-08-2025--2309255131', NULL, NULL, NULL, NULL, NULL, '2025-08-04', '2025-08-04', 'cash', NULL, NULL, NULL, NULL, NULL, NULL, 'disbursed', '2025-09-23', '3559550', 'performing', 13, NULL, NULL, NULL, NULL, '2025-09-23 16:23:22', '2025-09-24 12:59:25'),
(4, 28, 779, 6, NULL, 12, 29, 29, NULL, NULL, NULL, NULL, NULL, '2309259877', NULL, '0', 'TO AUGMENT BUSINESS AND WORKING CAPITAL', NULL, NULL, '2025-08-19', '2025-11-18', NULL, '2025-09-18', '15000000', 'flat_rate', '5', 'month', 0, NULL, '3', 'month', 'monthly', NULL, 'distribute_fees_evenly', '0', NULL, NULL, NULL, 'open', '15000000', 0, '15000000', '15000000', 'LOAN BOOKED 19-08-2025', 'LOAN BOOKED 19-08-2025--2309259877', NULL, NULL, NULL, NULL, NULL, '2025-08-19', '2025-08-19', 'cash', NULL, NULL, NULL, NULL, NULL, NULL, 'closed', '2025-09-23', '150000', 'performing', 13, NULL, NULL, NULL, NULL, '2025-09-23 16:25:25', '2025-11-13 14:43:13'),
(5, 28, 771, 6, NULL, 12, NULL, NULL, NULL, 29, NULL, NULL, NULL, '2309252048', NULL, '0', 'TO AUGMENT WORKING CAPITAL', NULL, NULL, '2025-08-20', '2026-03-19', NULL, '2025-09-19', '5000000', 'flat_rate', '5', 'month', 0, NULL, '6', 'month', 'monthly', NULL, 'distribute_fees_evenly', '0', NULL, NULL, NULL, 'open', '5000000', 0, '5000000', NULL, NULL, NULL, NULL, NULL, NULL, 'WRONG TENOR', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-24', NULL, NULL, 'declined', '2025-09-23', '50000', 'performing', 13, NULL, NULL, NULL, NULL, '2025-09-23 16:44:28', '2025-09-24 13:02:15');

-- --------------------------------------------------------

--
-- Table structure for table `loan_comments`
--

CREATE TABLE `loan_comments` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `loan_id` bigint UNSIGNED NOT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `branch_id` bigint DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `loan_comments`
--

INSERT INTO `loan_comments` (`id`, `user_id`, `loan_id`, `notes`, `branch_id`, `created_at`, `updated_at`) VALUES
(1, 21, 4, 'SOFT LOAN', NULL, '2024-01-09 17:48:38', '2024-01-09 17:48:38'),
(2, 21, 26, 'Loan is collaterized by cedrus capitl ltd FD with Asset Matrix MFB', NULL, '2024-01-24 16:26:12', '2024-01-24 16:26:12'),
(3, 21, 31, 'ABIMBOLA IS THE RM. THE LOAN IS COLLATERIZED BY HIS FD OF 25,000,000 WITH RICHGREEN', NULL, '2024-02-17 12:04:41', '2024-02-17 12:04:41'),
(4, 21, 82, 'NNPC LOGISTICS FEE TO MR WALE LABISCO', NULL, '2024-06-06 16:42:16', '2024-06-06 16:42:16');

-- --------------------------------------------------------

--
-- Table structure for table `loan_fees`
--

CREATE TABLE `loan_fees` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `loan_fee_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `gl_code` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `branch_id` bigint DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `loan_fees`
--

INSERT INTO `loan_fees` (`id`, `name`, `loan_fee_type`, `gl_code`, `branch_id`, `created_at`, `updated_at`) VALUES
(1, 'management fees', 'percentage', '40953331', NULL, '2022-12-08 21:41:11', '2025-08-27 22:48:34'),
(2, 'process fees', 'percentage', '40953331', NULL, '2022-12-08 21:41:35', '2025-08-27 22:49:04');

-- --------------------------------------------------------

--
-- Table structure for table `loan_fee_metas`
--

CREATE TABLE `loan_fee_metas` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `parent_id` bigint UNSIGNED NOT NULL,
  `loan_fee_id` bigint UNSIGNED DEFAULT NULL,
  `category` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `loan_fees_schedule` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `branch_id` bigint DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `loan_fee_metas`
--

INSERT INTO `loan_fee_metas` (`id`, `user_id`, `parent_id`, `loan_fee_id`, `category`, `value`, `loan_fees_schedule`, `branch_id`, `created_at`, `updated_at`) VALUES
(9, 5, 5, 1, 'loan_product', '0', 'distribute_fees_evenly', NULL, '2024-01-11 17:35:57', '2025-08-07 20:14:37'),
(10, 5, 5, 2, 'loan_product', '0', 'distribute_fees_evenly', NULL, '2024-01-11 17:35:57', '2025-08-07 20:14:37'),
(11, 5, 6, 1, 'loan_product', '0', 'distribute_fees_evenly', NULL, '2024-01-11 18:12:24', '2025-09-24 12:04:05'),
(12, 5, 6, 2, 'loan_product', '0', 'distribute_fees_evenly', NULL, '2024-01-11 18:12:24', '2025-09-24 12:04:06');

-- --------------------------------------------------------

--
-- Table structure for table `loan_products`
--

CREATE TABLE `loan_products` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `gl_code` varchar(225) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `interest_gl` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `incomefee_gl` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `loan_disbursed_by` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `minimum_principal` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `default_principal` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `maximum_principal` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `interest_method` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `interest_rate` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `interest_period` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'year',
  `minimum_interest_rate` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `default_interest_rate` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `maximum_interest_rate` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `override_interest` tinyint(1) NOT NULL DEFAULT '0',
  `override_interest_amount` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `default_loan_duration` int DEFAULT NULL,
  `default_loan_duration_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'year',
  `repayment_cycle` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'monthly',
  `repayment_order` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `loan_fees_schedule` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'distribute_fees_evenly',
  `branch_access` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `grace_on_interest_charged` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `advanced_enabled` tinyint(1) NOT NULL DEFAULT '0',
  `enable_late_repayment_penalty` tinyint(1) NOT NULL DEFAULT '0',
  `enable_after_maturity_date_penalty` tinyint(1) NOT NULL DEFAULT '0',
  `after_maturity_date_penalty_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'percentage',
  `late_repayment_penalty_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'percentage',
  `late_repayment_penalty_calculate` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'overdue_principal',
  `after_maturity_date_penalty_calculate` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'overdue_principal',
  `late_repayment_penalty_amount` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `after_maturity_date_penalty_amount` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `late_repayment_penalty_grace_period` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `after_maturity_date_penalty_grace_period` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `late_repayment_penalty_recurring` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `after_maturity_date_penalty_recurring` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `branch_id` bigint DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `loan_products`
--

INSERT INTO `loan_products` (`id`, `user_id`, `name`, `gl_code`, `interest_gl`, `incomefee_gl`, `loan_disbursed_by`, `minimum_principal`, `default_principal`, `maximum_principal`, `interest_method`, `interest_rate`, `interest_period`, `minimum_interest_rate`, `default_interest_rate`, `maximum_interest_rate`, `override_interest`, `override_interest_amount`, `default_loan_duration`, `default_loan_duration_type`, `repayment_cycle`, `repayment_order`, `loan_fees_schedule`, `branch_access`, `grace_on_interest_charged`, `advanced_enabled`, `enable_late_repayment_penalty`, `enable_after_maturity_date_penalty`, `after_maturity_date_penalty_type`, `late_repayment_penalty_type`, `late_repayment_penalty_calculate`, `after_maturity_date_penalty_calculate`, `late_repayment_penalty_amount`, `after_maturity_date_penalty_amount`, `late_repayment_penalty_grace_period`, `after_maturity_date_penalty_grace_period`, `late_repayment_penalty_recurring`, `after_maturity_date_penalty_recurring`, `branch_id`, `created_at`, `updated_at`) VALUES
(5, 1, 'Quick Loan Naira', '10156223', '40248362', '40953331', '[\"cheque\",\"cash\",\"transfer\"]', '1000', '1000000', '10000000', 'flat_rate', NULL, 'month', '0', '0', '0', 0, '2000', 1, 'month', 'monthly', '[\"fees\",\"interest\",\"principal\",\"penalty\"]', 'distribute_fees_evenly', NULL, '5', 0, 1, 0, 'percentage', 'percentage', 'overdue_principal_interest', 'overdue_principal', '0', NULL, '0', NULL, '0', NULL, NULL, '2022-12-08 21:54:57', '2025-08-07 20:14:37'),
(6, 5, 'business loan naira', '10156223', '40248362', '40953331', '[\"transfer\"]', '100', '1000', '7520000000', 'flat_rate', NULL, 'month', '5', '5', '5', 0, NULL, 1, 'month', 'bi_monthly', '[\"fees\",\"interest\",\"principal\"]', 'distribute_fees_evenly', NULL, NULL, 0, 0, 0, 'percentage', 'percentage', 'overdue_principal', 'overdue_principal', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-06-01 12:26:21', '2025-09-24 12:04:05'),
(7, 5, 'staff loan', NULL, NULL, NULL, '[\"cash\",\"transfer\"]', '500', '5000', '1000000', 'flat_rate', NULL, 'month', '2', '2', '2', 0, NULL, 3, 'month', 'monthly', '[\"interest\",\"principal\"]', 'distribute_fees_evenly', NULL, '0', 0, 0, 0, 'percentage', 'percentage', 'overdue_principal', 'overdue_principal', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-06-09 11:23:05', '2023-06-09 11:30:54'),
(8, 5, 'rg loan dollar', '10620745', '40580075', '40459749', '[\"cash\"]', '1000', '5000', '100000', 'flat_rate', NULL, 'month', '5', '5', '5', 0, NULL, 3, 'month', 'monthly', '[\"fees\",\"interest\",\"principal\",\"penalty\"]', 'distribute_fees_evenly', NULL, '0', 0, 0, 0, 'percentage', 'percentage', 'overdue_principal', 'overdue_principal', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-07 20:31:25', '2025-08-07 20:31:25'),
(9, 5, 'other bank investment', '10407676', '40750866', '40192835', '[\"cash\",\"transfer\"]', '1000000', '1000000', '5000000000', 'flat_rate', NULL, 'month', '2', '2', '2', 0, NULL, 3, 'month', 'daily', NULL, 'distribute_fees_evenly', NULL, '0', 0, 1, 0, 'percentage', 'percentage', 'overdue_principal', 'overdue_principal', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-17 18:01:32', '2026-01-26 15:10:24');

-- --------------------------------------------------------

--
-- Table structure for table `loan_repayments`
--

CREATE TABLE `loan_repayments` (
  `id` bigint UNSIGNED NOT NULL,
  `loan_id` bigint UNSIGNED NOT NULL,
  `customer_id` bigint UNSIGNED NOT NULL,
  `branch_id` bigint UNSIGNED DEFAULT NULL,
  `user_id` bigint UNSIGNED DEFAULT NULL,
  `accountofficer_id` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `amount` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `repayment_method` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `collection_date` date NOT NULL,
  `type` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `reference` varchar(225) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `due_date` date NOT NULL,
  `status` tinyint(1) DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `loan_repayments`
--

INSERT INTO `loan_repayments` (`id`, `loan_id`, `customer_id`, `branch_id`, `user_id`, `accountofficer_id`, `amount`, `repayment_method`, `collection_date`, `type`, `reference`, `notes`, `due_date`, `status`, `created_at`, `updated_at`) VALUES
(1, 20, 678, NULL, 29, NULL, '127437298.77', 'flat', '2025-09-23', 'debit', NULL, 'loan disbursed--2309255684', '2025-10-01', 0, '2025-09-23 19:29:42', '2025-09-23 19:29:42'),
(2, 19, 703, NULL, 29, NULL, '10400000', 'flat', '2025-09-23', 'debit', NULL, 'loan disbursed--2309253258', '2025-11-06', 0, '2025-09-23 19:33:09', '2025-09-23 19:33:09'),
(3, 18, 708, NULL, 29, NULL, '46200000', 'flat', '2025-09-23', 'debit', NULL, 'loan disbursed--2309256008', '2026-11-11', 0, '2025-09-23 19:35:48', '2025-09-23 19:35:48'),
(4, 17, 735, NULL, 29, NULL, '1224000', 'flat', '2025-09-23', 'debit', NULL, 'loan disbursed--2309255496', '2025-12-29', 0, '2025-09-23 19:37:27', '2025-09-23 19:37:27'),
(5, 16, 756, NULL, 29, NULL, '110000', 'flat', '2025-09-23', 'debit', NULL, 'loan disbursed--2309258541', '2025-11-09', 0, '2025-09-23 19:40:30', '2025-09-23 19:40:30');

-- --------------------------------------------------------

--
-- Table structure for table `loan_schedules`
--

CREATE TABLE `loan_schedules` (
  `id` bigint UNSIGNED NOT NULL,
  `loan_id` bigint UNSIGNED NOT NULL,
  `customer_id` bigint UNSIGNED NOT NULL,
  `branch_id` bigint UNSIGNED DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `due_date` date NOT NULL,
  `principal` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `principal_balance` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `interest` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fees` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `penalty` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `due` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `system_generated` tinyint NOT NULL DEFAULT '0',
  `closed` tinyint NOT NULL DEFAULT '0',
  `missed` tinyint NOT NULL DEFAULT '0',
  `missed_penalty_applied` tinyint NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `loan_schedules`
--

INSERT INTO `loan_schedules` (`id`, `loan_id`, `customer_id`, `branch_id`, `description`, `due_date`, `principal`, `principal_balance`, `interest`, `fees`, `penalty`, `due`, `system_generated`, `closed`, `missed`, `missed_penalty_applied`, `created_at`, `updated_at`) VALUES
(1, 20, 678, NULL, 'repayment', '2025-05-01', '17128669', '85643344', '4110881', '0', NULL, '21239550', 0, 0, 0, 0, '2025-09-23 19:29:41', '2025-09-23 19:29:41'),
(2, 20, 678, NULL, 'repayment', '2025-06-01', '17128669', '68514675', '4110881', '0', NULL, '21239550', 0, 0, 0, 0, '2025-09-23 19:29:41', '2025-09-23 19:29:41'),
(3, 20, 678, NULL, 'repayment', '2025-07-01', '17128669', '51386006', '4110881', '0', NULL, '21239550', 0, 0, 0, 0, '2025-09-23 19:29:41', '2025-09-23 19:29:41'),
(4, 20, 678, NULL, 'repayment', '2025-08-01', '17128669', '34257337', '4110881', '0', NULL, '21239550', 0, 0, 0, 0, '2025-09-23 19:29:41', '2025-09-23 19:29:41'),
(5, 20, 678, NULL, 'repayment', '2025-09-01', '17128669', '17128668', '4110881', '0', NULL, '21239550', 0, 0, 0, 0, '2025-09-23 19:29:41', '2025-09-23 19:29:41');

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(5, '2014_10_12_000000_create_users_table', 1),
(6, '2014_10_12_100000_create_password_resets_table', 1),
(7, '2019_08_19_000000_create_failed_jobs_table', 1),
(8, '2019_12_14_000001_create_personal_access_tokens_table', 1),
(11, '2022_11_17_080247_create_role_users_table', 1),
(12, '2022_11_18_143436_create_accountofficers_table', 2),
(13, '2022_11_18_145138_create_branches_table', 3),
(14, '2022_11_18_172750_create_branch_users_table', 4),
(17, '2022_11_22_161644_create_permission_tables', 5),
(18, '2022_11_23_141005_create_assets_table', 6),
(19, '2022_11_23_145957_create_asset_types_table', 7),
(20, '2022_11_23_154131_create_asset_valuations_table', 7),
(21, '2022_11_24_123029_create_audittrails_table', 8),
(22, '2022_11_24_180905_create_customers_table', 9),
(23, '2022_11_24_185346_create_emails_table', 9),
(24, '2022_11_25_194848_create_expenses_table', 10),
(25, '2022_11_25_195133_create_expense_types_table', 10),
(27, '2022_11_30_160912_create_savings_products_table', 12),
(28, '2022_11_30_165326_create_savings_table', 13),
(29, '2022_11_30_191030_create_other_incomes_table', 13),
(30, '2022_11_30_191052_create_other_income_types_table', 13),
(31, '2022_12_01_165510_create_saving_fees_table', 14),
(32, '2022_12_02_111157_create_savings_transactions_table', 15),
(33, '2022_12_06_115910_create_charges_table', 16),
(40, '2022_12_07_115829_create_loans_table', 17),
(41, '2022_12_07_141947_create_loan_products_table', 17),
(42, '2022_12_07_152647_create_provision_rates_table', 17),
(43, '2022_12_08_141303_create_loan_fees_table', 18),
(44, '2022_12_08_141530_create_loan_fee_metas_table', 18),
(45, '2022_12_12_135443_create_loan_schedules_table', 19),
(46, '2022_12_12_145939_create_loan_repayments_table', 19),
(47, '2022_12_14_125639_create_collaterals_table', 20),
(48, '2022_12_14_125701_create_collateral_types_table', 20),
(49, '2022_12_14_133536_create_loan_comments_table', 20),
(50, '2022_12_25_120831_create_upload_transaction_statuses_table', 21),
(51, '2022_12_26_180717_create_capitals_table', 22),
(52, '2022_12_26_184514_create_payrolls_table', 23),
(54, '2022_12_26_193038_create_payroll_templates_table', 23),
(55, '2023_01_03_183009_create_payment_structures_table', 24),
(56, '2023_01_05_004739_create_payslips_table', 25),
(57, '2023_01_09_124700_create_savings_transaction_g_l_s_table', 26),
(59, '2023_01_10_171155_create_account_types_table', 27),
(60, '2023_01_10_184537_create_account_categories_table', 28),
(61, '2023_01_11_165954_create_general_ledgers_table', 29),
(62, '2022_12_26_185105_create_payroll_metas_table', 30),
(63, '2023_03_03_132331_create_statuses_table', 30),
(64, '2022_11_28_202102_create_settings_table', 31),
(65, '2023_03_22_121344_create_banks_table', 32),
(66, '2023_03_22_121852_create_beneficiaries_table', 32);

-- --------------------------------------------------------

--
-- Table structure for table `model_has_permissions`
--

CREATE TABLE `model_has_permissions` (
  `permission_id` bigint UNSIGNED NOT NULL,
  `model_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `model_has_roles`
--

CREATE TABLE `model_has_roles` (
  `role_id` bigint UNSIGNED NOT NULL,
  `model_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `model_has_roles`
--

INSERT INTO `model_has_roles` (`role_id`, `model_type`, `model_id`) VALUES
(1, 'App\\Models\\User', 1),
(1, 'App\\Models\\User', 5),
(1, 'App\\Models\\User', 7),
(1, 'App\\Models\\User', 8),
(5, 'App\\Models\\User', 10),
(4, 'App\\Models\\User', 11),
(4, 'App\\Models\\User', 12),
(4, 'App\\Models\\User', 13),
(4, 'App\\Models\\User', 14),
(4, 'App\\Models\\User', 15),
(4, 'App\\Models\\User', 16),
(4, 'App\\Models\\User', 17),
(4, 'App\\Models\\User', 18),
(4, 'App\\Models\\User', 19),
(5, 'App\\Models\\User', 20),
(5, 'App\\Models\\User', 21),
(4, 'App\\Models\\User', 22),
(5, 'App\\Models\\User', 23),
(6, 'App\\Models\\User', 24),
(5, 'App\\Models\\User', 25),
(5, 'App\\Models\\User', 26),
(6, 'App\\Models\\User', 27),
(2, 'App\\Models\\User', 28),
(5, 'App\\Models\\User', 29),
(1, 'App\\Models\\User', 30),
(1, 'App\\Models\\User', 31),
(6, 'App\\Models\\User', 32),
(6, 'App\\Models\\User', 33),
(6, 'App\\Models\\User', 34),
(6, 'App\\Models\\User', 35),
(6, 'App\\Models\\User', 36),
(6, 'App\\Models\\User', 37);

-- --------------------------------------------------------

--
-- Table structure for table `notification_payloads`
--

CREATE TABLE `notification_payloads` (
  `id` bigint UNSIGNED NOT NULL,
  `body` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `branch_id` varchar(225) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `other_incomes`
--

CREATE TABLE `other_incomes` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `branch_id` bigint UNSIGNED DEFAULT NULL,
  `other_income_type_id` bigint UNSIGNED NOT NULL,
  `amount` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  `income_date` date NOT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `files` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `other_income_types`
--

CREATE TABLE `other_income_types` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `branch_id` bigint DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `outstanding_loans`
--

CREATE TABLE `outstanding_loans` (
  `id` bigint UNSIGNED NOT NULL,
  `loan_id` bigint UNSIGNED NOT NULL,
  `customer_id` varchar(225) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `amount` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '0',
  `branch_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `outstanding_loans`
--

INSERT INTO `outstanding_loans` (`id`, `loan_id`, `customer_id`, `amount`, `branch_id`, `created_at`, `updated_at`) VALUES
(1, 13, '673', '600000', NULL, '2025-11-14 03:00:08', '2025-11-14 03:00:08'),
(2, 105, '747', '0', NULL, '2025-11-14 03:00:09', '2025-11-19 18:56:04'),
(3, 103, '803', '0', NULL, '2025-11-15 03:00:08', '2025-11-24 16:19:06'),
(4, 104, '804', '3146667', NULL, '2025-11-15 03:00:08', '2025-11-15 03:00:08'),
(5, 122, '823', '5000', NULL, '2025-11-19 03:00:10', '2025-11-19 03:00:10'),
(6, 10, '645', '0', NULL, '2025-11-20 03:00:08', '2025-11-25 10:45:36'),
(7, 110, '669', '63500000', NULL, '2025-11-22 03:00:08', '2025-11-22 03:00:08'),
(8, 24, '631', '28222222', NULL, '2025-11-23 03:00:08', '2025-11-23 03:00:08'),
(9, 74, '765', '0', NULL, '2025-11-23 03:00:09', '2026-01-09 13:55:50'),
(10, 113, '815', '72649500', NULL, '2025-11-23 03:00:09', '2025-11-23 03:00:09'),
(11, 118, '640', '5333333', NULL, '2025-11-23 03:00:09', '2025-11-23 03:00:09'),
(12, 64, '532', '6050000', NULL, '2025-11-24 03:00:09', '2025-11-24 03:00:09'),
(13, 67, '643', '0', NULL, '2025-11-24 03:00:09', '2026-02-02 19:26:41'),
(14, 68, '688', '4333333', NULL, '2025-11-24 03:00:09', '2025-11-24 03:00:09'),
(15, 69, '583', '3333333', NULL, '2025-11-24 03:00:09', '2025-11-24 03:00:09'),
(16, 83, '672', '1746063', NULL, '2025-11-24 03:00:09', '2026-02-03 17:43:57'),
(17, 85, '661', '0', NULL, '2025-11-24 03:00:09', '2025-12-12 17:01:56'),
(18, 88, '359', '550000', NULL, '2025-11-24 03:00:09', '2025-11-24 03:00:09'),
(19, 92, '601', '0', NULL, '2025-11-24 03:00:10', '2025-12-18 17:20:32'),
(20, 120, '821', '0', NULL, '2025-11-27 03:00:07', '2025-12-15 11:04:29'),
(21, 112, '678', '0', NULL, '2025-11-28 03:00:09', '2025-12-02 11:17:16'),
(22, 94, '656', '0', NULL, '2025-11-30 03:00:08', '2025-12-02 17:45:20'),
(23, 25, '648', '872577961', NULL, '2025-12-01 03:00:07', '2025-12-01 03:00:07'),
(24, 96, '793', '0', NULL, '2025-12-01 03:00:08', '2026-01-23 12:55:18'),
(25, 97, '31', '0', NULL, '2025-12-01 03:00:08', '2025-12-03 18:21:55'),
(26, 98, '648', '30766667', NULL, '2025-12-01 03:00:08', '2025-12-01 03:00:08'),
(27, 115, '640', '8000000', NULL, '2025-12-02 03:00:08', '2025-12-02 03:00:08'),
(28, 123, '779', '4540000', NULL, '2025-12-04 03:00:09', '2025-12-04 03:00:09'),
(29, 58, '458', '9416666', NULL, '2025-12-07 03:00:07', '2025-12-07 03:00:07'),
(30, 100, '648', '63900000', NULL, '2025-12-08 03:00:09', '2025-12-08 03:00:09'),
(31, 116, '640', '1333333', NULL, '2025-12-09 03:00:09', '2025-12-09 03:00:09'),
(32, 124, '766', '3240', NULL, '2025-12-09 03:00:09', '2025-12-09 03:00:09'),
(33, 125, '528', '24250000', NULL, '2025-12-09 03:00:09', '2026-01-05 17:44:05'),
(34, 117, '640', '5333333', NULL, '2025-12-10 03:00:10', '2025-12-10 03:00:10'),
(35, 130, '838', '306667', NULL, '2025-12-10 03:00:10', '2025-12-10 03:00:10'),
(36, 133, '676', '543888000', NULL, '2025-12-10 03:00:10', '2025-12-10 03:00:10'),
(37, 18, '708', '2566667', NULL, '2025-12-11 03:00:08', '2025-12-11 03:00:08'),
(38, 129, '837', '0', NULL, '2025-12-11 03:00:08', '2025-12-15 14:24:11'),
(39, 105, '747', '590000', NULL, '2025-12-14 03:00:09', '2025-12-14 03:00:09'),
(40, 103, '803', '793332.67', NULL, '2025-12-15 03:00:09', '2025-12-15 03:00:09'),
(41, 104, '804', '3146667', NULL, '2025-12-15 03:00:09', '2025-12-15 03:00:09'),
(42, 138, '846', '54980', NULL, '2025-12-17 03:00:08', '2025-12-17 03:00:08'),
(43, 122, '823', '5000', NULL, '2025-12-19 03:00:08', '2025-12-19 03:00:08'),
(44, 132, '842', '0', NULL, '2025-12-19 03:00:08', '2025-12-19 19:01:39'),
(45, 34, '771', '248925', NULL, '2025-12-20 03:00:09', '2025-12-20 03:00:09'),
(46, 134, '669', '262880000', NULL, '2025-12-20 03:00:09', '2025-12-20 03:00:09'),
(47, 135, '843', '0', NULL, '2025-12-20 03:00:09', '2025-12-23 13:24:49'),
(48, 24, '631', '28222222', NULL, '2025-12-23 03:00:09', '2025-12-23 03:00:09'),
(49, 74, '765', '6231873', NULL, '2025-12-23 03:00:10', '2025-12-23 03:00:10'),
(50, 118, '640', '5333333', NULL, '2025-12-23 03:00:10', '2025-12-23 03:00:10'),
(51, 64, '532', '6050000', NULL, '2025-12-24 03:00:09', '2025-12-24 03:00:09'),
(52, 67, '643', '2066667', NULL, '2025-12-24 03:00:09', '2025-12-24 03:00:09'),
(53, 68, '688', '4333333', NULL, '2025-12-24 03:00:09', '2025-12-24 03:00:09'),
(54, 69, '583', '3333333', NULL, '2025-12-24 03:00:09', '2025-12-24 03:00:09'),
(55, 72, '675', '179688', NULL, '2025-12-24 03:00:10', '2025-12-24 03:00:10'),
(56, 82, '479', '1500000', NULL, '2025-12-24 03:00:10', '2025-12-24 03:00:10'),
(57, 83, '672', '33746063', NULL, '2025-12-24 03:00:10', '2025-12-24 03:00:10'),
(58, 87, '689', '655200', NULL, '2025-12-24 03:00:10', '2025-12-24 03:00:10'),
(59, 92, '601', '1738106', NULL, '2025-12-24 03:00:10', '2025-12-24 03:00:10'),
(60, 141, '850', '38000000', NULL, '2025-12-24 03:00:11', '2026-01-26 13:27:59'),
(61, 140, '830', '42400000', NULL, '2025-12-25 03:00:08', '2025-12-25 03:00:08'),
(62, 17, '735', '108000', NULL, '2025-12-29 03:00:09', '2025-12-29 03:00:09'),
(63, 94, '656', '3733332.34', NULL, '2025-12-30 03:00:10', '2025-12-30 03:00:10'),
(64, 142, '788', '26500000', NULL, '2025-12-30 03:00:10', '2025-12-30 03:00:10'),
(65, 25, '648', '872577961', NULL, '2026-01-01 03:00:08', '2026-01-01 03:00:08'),
(66, 97, '31', '216667', NULL, '2026-01-01 03:00:09', '2026-01-01 03:00:09'),
(67, 98, '648', '30766667', NULL, '2026-01-01 03:00:09', '2026-01-01 03:00:09'),
(68, 115, '640', '8000000', NULL, '2026-01-02 03:00:11', '2026-01-02 03:00:11'),
(69, 143, '851', '0', NULL, '2026-01-02 03:00:11', '2026-01-05 16:03:13'),
(70, 123, '779', '1080000', NULL, '2026-01-04 03:00:10', '2026-01-04 03:00:10'),
(71, 58, '458', '9416666', NULL, '2026-01-07 03:00:10', '2026-01-07 03:00:10'),
(72, 144, '756', '60000', NULL, '2026-01-07 03:00:10', '2026-01-07 03:00:10'),
(73, 145, '556', '1168889', NULL, '2026-01-07 03:00:10', '2026-01-07 03:00:10'),
(74, 100, '648', '63900000', NULL, '2026-01-08 03:00:10', '2026-01-08 03:00:10'),
(75, 33, '771', '0', NULL, '2026-01-09 03:00:08', '2026-01-14 11:29:36'),
(76, 116, '640', '1333333', NULL, '2026-01-09 03:00:09', '2026-01-09 03:00:09'),
(77, 124, '766', '3240', NULL, '2026-01-09 03:00:09', '2026-01-09 03:00:09'),
(78, 34, '771', '1066706', NULL, '2026-01-10 03:00:11', '2026-01-10 03:00:11'),
(79, 117, '640', '5333333', NULL, '2026-01-10 03:00:11', '2026-01-10 03:00:11'),
(80, 130, '838', '306667', NULL, '2026-01-10 03:00:12', '2026-01-10 03:00:12'),
(81, 133, '676', '543888000', NULL, '2026-01-10 03:00:12', '2026-01-10 03:00:12'),
(82, 18, '708', '2566667', NULL, '2026-01-11 03:00:10', '2026-01-11 03:00:10'),
(83, 129, '837', '458333', NULL, '2026-01-11 03:00:11', '2026-01-11 03:00:11'),
(84, 128, '836', '9010000', NULL, '2026-01-13 03:00:10', '2026-02-05 19:16:19'),
(85, 105, '747', '590000', NULL, '2026-01-14 03:00:10', '2026-01-14 03:00:10'),
(86, 103, '803', '793333', NULL, '2026-01-15 03:00:09', '2026-01-15 03:00:09'),
(87, 104, '804', '3146667', NULL, '2026-01-15 03:00:10', '2026-01-15 03:00:10'),
(88, 131, '714', '4116666', NULL, '2026-01-16 03:00:12', '2026-01-16 03:00:12'),
(89, 147, '788', '27500000', NULL, '2026-01-16 03:00:12', '2026-01-16 03:00:12'),
(90, 34, '771', '85481', NULL, '2026-01-17 03:00:10', '2026-01-17 03:00:10'),
(91, 138, '846', '54980', NULL, '2026-01-17 03:00:11', '2026-01-17 03:00:11'),
(92, 148, '790', '6300000', NULL, '2026-01-17 03:00:11', '2026-01-17 03:00:11'),
(93, 149, '782', '22458750', NULL, '2026-01-22 03:00:11', '2026-01-22 03:00:11'),
(94, 150, '842', '4480000', NULL, '2026-01-22 03:00:12', '2026-01-22 03:00:12'),
(95, 160, '868', '150000', NULL, '2026-01-22 03:00:12', '2026-01-22 03:00:12'),
(96, 24, '631', '28222222', NULL, '2026-01-23 03:00:12', '2026-01-23 03:00:12'),
(97, 33, '771', '242433', NULL, '2026-01-23 03:00:12', '2026-01-23 03:00:12'),
(98, 74, '765', '6231873', NULL, '2026-01-23 03:00:13', '2026-01-23 03:00:13'),
(99, 118, '640', '5333333', NULL, '2026-01-23 03:00:13', '2026-01-23 03:00:13'),
(100, 34, '771', '1066706', NULL, '2026-01-24 03:00:11', '2026-01-24 03:00:11'),
(101, 64, '532', '6050000', NULL, '2026-01-24 03:00:11', '2026-01-24 03:00:11'),
(102, 65, '768', '5000000', NULL, '2026-01-24 03:00:11', '2026-01-24 03:00:11'),
(103, 67, '643', '2066667', NULL, '2026-01-24 03:00:11', '2026-01-24 03:00:11'),
(104, 68, '688', '4333333', NULL, '2026-01-24 03:00:11', '2026-01-24 03:00:11'),
(105, 72, '675', '314844', NULL, '2026-01-24 03:00:11', '2026-01-24 03:00:11'),
(106, 82, '479', '1500000', NULL, '2026-01-24 03:00:12', '2026-01-24 03:00:12'),
(107, 87, '689', '1782000', NULL, '2026-01-24 03:00:12', '2026-01-24 03:00:12'),
(108, 140, '830', '41200000', NULL, '2026-01-25 03:00:13', '2026-01-25 03:00:13'),
(109, 156, '771', '1625000', NULL, '2026-01-28 03:00:13', '2026-01-28 03:00:13'),
(110, 155, '866', '314667', NULL, '2026-01-29 03:00:12', '2026-01-29 03:00:12'),
(111, 28, '787', '4949425', NULL, '2026-01-30 03:00:10', '2026-01-30 03:00:10'),
(112, 33, '771', '242433', NULL, '2026-01-30 03:00:10', '2026-01-30 03:00:10'),
(113, 34, '771', '1066706', NULL, '2026-01-31 03:00:11', '2026-01-31 03:00:11'),
(114, 25, '648', '872577961', NULL, '2026-02-01 03:00:09', '2026-02-01 03:00:09'),
(115, 97, '31', '206667', NULL, '2026-02-01 03:00:10', '2026-02-01 03:00:10'),
(116, 98, '648', '30766667', NULL, '2026-02-01 03:00:10', '2026-02-01 03:00:10'),
(117, 137, '714', '1533333', NULL, '2026-02-02 03:00:12', '2026-02-02 03:00:12'),
(118, 143, '851', '1033333', NULL, '2026-02-02 03:00:12', '2026-02-02 03:00:12'),
(119, 123, '779', '780000', NULL, '2026-02-04 03:00:12', '2026-02-04 03:00:12'),
(120, 156, '771', '1609375', NULL, '2026-02-04 03:00:13', '2026-02-04 03:00:13'),
(121, 161, '856', '1040000', NULL, '2026-02-04 03:00:13', '2026-02-04 03:00:13'),
(122, 33, '771', '242433', NULL, '2026-02-06 03:00:13', '2026-02-06 03:00:13');

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payment_structures`
--

CREATE TABLE `payment_structures` (
  `id` bigint UNSIGNED NOT NULL,
  `payroll_id` bigint UNSIGNED NOT NULL,
  `branch_id` bigint DEFAULT NULL,
  `basic` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `other_allowance` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `gross_pay` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `paye_percent` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `paye` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `other_deduction` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `deduction` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `net_pay` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payrolls`
--

CREATE TABLE `payrolls` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `branch_id` bigint UNSIGNED NOT NULL,
  `employee_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(225) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `designation` varchar(225) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payment_method` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bank_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `account_number` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payroll_metas`
--

CREATE TABLE `payroll_metas` (
  `id` bigint UNSIGNED NOT NULL,
  `payroll_id` bigint UNSIGNED NOT NULL,
  `payroll_template_id` bigint UNSIGNED NOT NULL,
  `value` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `position` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `branch_id` bigint DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payroll_templates`
--

CREATE TABLE `payroll_templates` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `position` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` varchar(1) COLLATE utf8mb4_unicode_ci NOT NULL,
  `branch_id` bigint DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `payroll_templates`
--

INSERT INTO `payroll_templates` (`id`, `name`, `position`, `status`, `branch_id`, `created_at`, `updated_at`) VALUES
(1, 'Basic Salary', '1', '1', NULL, '2023-01-02 23:04:22', '2023-01-02 23:04:22'),
(2, 'other allowances', '1', '2', NULL, '2023-01-02 23:11:01', '2023-01-02 23:23:14'),
(3, 'Paye', '2', '2', NULL, '2023-01-02 23:14:24', '2023-01-04 14:54:03'),
(4, 'Other Deductions', '2', '2', NULL, '2023-01-02 23:28:16', '2023-01-02 23:28:16');

-- --------------------------------------------------------

--
-- Table structure for table `payslips`
--

CREATE TABLE `payslips` (
  `id` bigint UNSIGNED NOT NULL,
  `payroll_id` bigint UNSIGNED NOT NULL,
  `payment_structure_id` bigint UNSIGNED NOT NULL,
  `branch_id` bigint UNSIGNED DEFAULT NULL,
  `month` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `year` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `permissions`
--

CREATE TABLE `permissions` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `permissions`
--

INSERT INTO `permissions` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES
(1, 'manage users', 'web', '2022-11-22 19:55:04', '2022-11-22 19:55:04'),
(2, 'create users', 'web', '2022-11-22 19:56:30', '2022-11-22 19:56:30'),
(3, 'edit users', 'web', '2022-11-22 19:56:39', '2022-11-22 19:56:39'),
(4, 'view users', 'web', '2022-11-22 19:56:48', '2022-11-22 19:56:48'),
(6, 'update users', 'web', '2022-11-22 20:58:49', '2022-11-22 20:58:49'),
(7, 'delete users', 'web', '2022-11-22 20:59:03', '2022-11-22 20:59:03'),
(8, 'manage roles', 'web', '2022-11-22 21:02:01', '2022-11-22 21:02:01'),
(9, 'manage permissions', 'web', '2022-11-22 21:02:12', '2022-11-22 21:02:12'),
(10, 'borrowers', 'web', '2022-11-22 21:03:38', '2022-11-22 21:03:38'),
(11, 'view borrowers', 'web', '2022-11-22 21:03:52', '2022-11-22 21:03:52'),
(12, 'update borrowers', 'web', '2022-11-22 21:04:07', '2022-11-22 21:04:07'),
(13, 'delete borrowers', 'web', '2022-11-22 21:04:25', '2022-11-22 21:04:25'),
(14, 'create borrowers', 'web', '2022-11-22 21:04:47', '2022-11-22 21:04:47'),
(15, 'loans', 'web', '2022-11-22 21:05:13', '2022-11-22 21:05:13'),
(16, 'create loans', 'web', '2022-11-22 21:05:42', '2022-11-22 21:05:42'),
(17, 'update loans', 'web', '2022-11-22 21:06:42', '2022-11-22 21:06:42'),
(18, 'delete loans', 'web', '2022-11-22 21:06:53', '2022-11-22 21:06:53'),
(19, 'view loans', 'web', '2022-11-22 21:07:08', '2022-11-22 21:07:08'),
(20, 'loan products', 'web', '2022-11-22 21:07:24', '2022-11-22 21:07:24'),
(21, 'loan fees', 'web', '2022-11-22 21:07:45', '2022-11-22 21:07:45'),
(22, 'loan schedule', 'web', '2022-11-22 21:07:58', '2022-11-22 21:07:58'),
(23, 'repayments', 'web', '2022-11-22 21:08:09', '2022-11-22 21:08:09'),
(24, 'view repayments', 'web', '2022-11-22 21:08:28', '2022-11-22 21:08:28'),
(25, 'create repayments', 'web', '2022-11-22 21:08:38', '2022-11-22 21:08:38'),
(26, 'update repayments', 'web', '2022-11-22 21:09:00', '2022-11-22 21:09:30'),
(27, 'delete repayments', 'web', '2022-11-22 21:09:13', '2022-11-22 21:09:13'),
(28, 'payroll', 'web', '2022-11-22 21:10:10', '2022-11-22 21:10:10'),
(29, 'view payroll', 'web', '2022-11-22 21:10:14', '2022-11-22 21:10:14'),
(30, 'create payroll', 'web', '2022-11-22 21:10:20', '2022-11-22 21:10:20'),
(31, 'update payroll', 'web', '2022-11-22 21:10:34', '2022-11-22 21:10:34'),
(32, 'delete payroll', 'web', '2022-11-22 21:10:40', '2022-11-22 21:10:40'),
(33, 'expenses', 'web', '2022-11-22 21:11:19', '2022-11-22 21:11:19'),
(34, 'view expenses', 'web', '2022-11-22 21:11:24', '2022-11-22 21:11:24'),
(35, 'create expenses', 'web', '2022-11-22 21:11:35', '2022-11-22 21:11:35'),
(36, 'edit expenses', 'web', '2022-11-22 21:11:52', '2022-11-28 14:41:55'),
(37, 'delete expenses', 'web', '2022-11-22 21:11:59', '2022-11-22 21:11:59'),
(38, 'other income', 'web', '2022-11-22 21:12:13', '2022-11-22 21:12:13'),
(39, 'view other income', 'web', '2022-11-22 21:12:18', '2022-11-22 21:12:18'),
(40, 'create other income', 'web', '2022-11-22 21:12:23', '2022-11-22 21:12:23'),
(41, 'update other income', 'web', '2022-11-22 21:12:35', '2022-11-22 21:12:35'),
(42, 'delete other income', 'web', '2022-11-22 21:12:41', '2022-11-22 21:12:41'),
(43, 'collateral', 'web', '2022-11-22 21:12:59', '2022-11-22 21:12:59'),
(44, 'view collateral', 'web', '2022-11-22 21:13:03', '2022-11-22 21:13:03'),
(45, 'create collateral', 'web', '2022-11-22 21:13:11', '2022-11-22 21:13:11'),
(46, 'update collateral', 'web', '2022-11-22 21:13:18', '2022-11-22 21:13:18'),
(47, 'delete collateral', 'web', '2022-11-22 21:13:23', '2022-11-22 21:13:23'),
(48, 'reports', 'web', '2022-11-22 21:14:09', '2022-11-22 21:14:09'),
(49, 'communication', 'web', '2022-11-22 21:14:26', '2022-11-22 21:14:26'),
(50, 'create communication', 'web', '2022-11-22 21:14:31', '2022-11-22 21:14:31'),
(51, 'delete communication', 'web', '2022-11-22 21:14:38', '2022-11-22 21:14:38'),
(52, 'customer', 'web', '2022-11-22 21:16:05', '2022-11-28 14:43:56'),
(53, 'view customer', 'web', '2022-11-22 21:16:54', '2022-11-28 14:45:13'),
(54, 'create customer', 'web', '2022-11-22 21:17:00', '2022-11-28 14:43:35'),
(55, 'update customer', 'web', '2022-11-22 21:17:08', '2022-11-28 14:45:07'),
(56, 'delete customer', 'web', '2022-11-22 21:17:24', '2022-11-28 14:44:11'),
(57, 'settings', 'web', '2022-11-22 21:19:38', '2022-11-22 21:19:38'),
(59, 'view savings', 'web', '2022-11-22 21:21:23', '2022-11-22 21:21:23'),
(60, 'create savings', 'web', '2022-11-22 21:22:07', '2022-11-22 21:22:07'),
(61, 'update savings', 'web', '2022-11-22 21:22:15', '2022-11-22 21:22:15'),
(62, 'delete savings', 'web', '2022-11-22 21:22:22', '2022-11-22 21:22:22'),
(63, 'create savings transaction', 'web', '2022-11-22 21:22:51', '2022-11-22 21:22:51'),
(64, 'update savings transaction', 'web', '2022-11-22 21:23:00', '2022-11-22 21:23:00'),
(65, 'delete savings transaction', 'web', '2022-11-22 21:23:09', '2022-11-22 21:23:09'),
(66, 'audit trail', 'web', '2022-11-22 21:23:52', '2022-11-22 21:23:52'),
(67, 'savings', 'web', '2022-11-22 21:25:30', '2022-11-22 21:25:30'),
(68, 'view savings transaction', 'web', '2022-11-22 21:25:54', '2022-11-22 21:25:54'),
(69, 'manage savings products', 'web', '2022-11-22 21:26:09', '2022-11-22 21:26:09'),
(70, 'manage savings fees', 'web', '2022-11-22 21:26:21', '2022-11-22 21:26:21'),
(71, 'approve loans', 'web', '2022-11-22 21:26:32', '2022-11-22 21:26:32'),
(72, 'disburse loans', 'web', '2022-11-22 21:26:47', '2022-11-22 21:26:47'),
(73, 'approve borrowers', 'web', '2022-11-22 21:26:59', '2022-11-22 21:26:59'),
(74, 'withdraw loans', 'web', '2022-11-22 21:27:12', '2022-11-22 21:27:12'),
(75, 'write off loans', 'web', '2022-11-22 21:27:27', '2022-11-22 21:27:27'),
(76, 'reschedule loans', 'web', '2022-11-22 21:27:41', '2022-11-22 21:27:41'),
(77, 'dashboard', 'web', '2022-11-22 21:27:58', '2022-11-22 21:27:58'),
(78, 'loans released monthly graph', 'web', '2022-11-22 21:28:32', '2022-11-22 21:28:32'),
(79, 'loans collected monthly graph', 'web', '2022-11-22 21:28:45', '2022-11-22 21:28:45'),
(80, 'registered customers', 'web', '2022-11-22 21:29:08', '2023-01-07 06:23:57'),
(81, 'total loans released', 'web', '2022-11-22 21:29:18', '2022-11-22 21:29:18'),
(82, 'total collections', 'web', '2022-11-22 21:29:30', '2022-11-22 21:29:30'),
(83, 'total disbursed loans', 'web', '2022-11-22 21:29:44', '2022-11-22 21:29:44'),
(84, 'total loans pending', 'web', '2022-11-22 21:29:56', '2022-11-22 21:29:56'),
(85, 'loans approved', 'web', '2022-11-22 21:30:09', '2022-11-22 21:30:09'),
(86, 'loans declined', 'web', '2022-11-22 21:30:21', '2022-11-22 21:30:21'),
(87, 'close loans', 'web', '2022-11-22 21:30:31', '2024-02-08 14:07:28'),
(88, 'loans withdrawn', 'web', '2022-11-22 21:30:42', '2022-11-22 21:30:42'),
(89, 'loans written off', 'web', '2022-11-22 21:30:54', '2022-11-22 21:30:54'),
(90, 'loans rescheduled', 'web', '2022-11-22 21:31:10', '2022-11-22 21:31:10'),
(91, 'create guarantor', 'web', '2022-11-22 21:31:37', '2022-11-22 21:31:37'),
(92, 'update guarantor', 'web', '2022-11-22 21:31:45', '2022-11-22 21:31:45'),
(93, 'delete guarantor', 'web', '2022-11-22 21:31:53', '2022-11-22 21:31:53'),
(94, 'guarantor savings', 'web', '2022-11-22 21:38:25', '2022-11-22 21:38:25'),
(95, 'view capital', 'web', '2022-11-22 21:40:37', '2022-11-22 21:40:37'),
(96, 'create capital', 'web', '2022-11-22 21:40:46', '2022-11-22 21:40:46'),
(97, 'update capital', 'web', '2022-11-22 21:40:52', '2022-11-22 21:40:52'),
(98, 'delete capital', 'web', '2022-11-22 21:40:57', '2022-11-22 21:40:57'),
(99, 'capital', 'web', '2022-11-22 21:41:25', '2022-11-22 21:41:25'),
(100, 'assets', 'web', '2022-11-22 21:41:48', '2022-11-22 21:41:48'),
(101, 'view assets', 'web', '2022-11-22 21:41:53', '2022-11-22 21:41:53'),
(102, 'create assets', 'web', '2022-11-22 21:41:57', '2022-11-22 21:41:57'),
(103, 'update assets', 'web', '2022-11-22 21:42:06', '2022-11-22 21:42:06'),
(104, 'delete assets', 'web', '2022-11-22 21:42:12', '2022-11-22 21:42:12'),
(105, 'blacklist borrower', 'web', '2022-11-22 21:42:47', '2022-11-22 21:42:47'),
(106, 'manage borrower groups', 'web', '2022-11-22 21:42:59', '2022-11-22 21:42:59'),
(107, 'use loan calculator', 'web', '2022-11-22 21:43:12', '2022-11-22 21:43:12'),
(108, 'branches', 'web', '2022-11-22 21:43:26', '2022-11-22 21:43:26'),
(109, 'view branches', 'web', '2022-11-22 21:43:41', '2022-11-22 21:43:41'),
(110, 'create branches', 'web', '2022-11-22 21:43:47', '2022-11-22 21:43:47'),
(111, 'update branches', 'web', '2022-11-22 21:43:53', '2022-11-22 21:43:53'),
(112, 'delete branches', 'web', '2022-11-22 21:43:58', '2022-11-22 21:43:58'),
(113, 'assign users', 'web', '2022-11-22 21:45:54', '2022-11-22 21:45:54'),
(114, 'uploads', 'web', '2022-11-22 21:46:11', '2022-11-22 21:46:11'),
(115, 'manage account officer', 'web', '2022-11-22 21:46:48', '2022-11-22 21:46:48'),
(116, 'create account officer', 'web', '2022-11-22 21:47:04', '2022-11-22 21:47:04'),
(117, 'view account officer', 'web', '2022-11-22 21:48:04', '2022-11-22 21:48:04'),
(118, 'posting approved', 'web', '2022-11-22 21:49:33', '2022-11-22 21:49:33'),
(119, 'posting declined', 'web', '2022-11-22 21:49:45', '2022-11-22 21:49:45'),
(120, 'approve savings transaction', 'web', '2022-11-22 21:50:02', '2022-11-22 21:50:02'),
(121, 'savings transactions charges', 'web', '2022-11-22 21:50:16', '2022-11-22 21:50:16'),
(122, 'savings transaction withdrawal', 'web', '2022-11-22 21:50:32', '2022-11-22 21:50:32'),
(123, 'savings transactions deposit', 'web', '2022-11-22 21:50:45', '2022-11-22 21:50:45'),
(124, 'posting management', 'web', '2022-11-22 21:50:58', '2022-11-22 21:50:58'),
(125, 'create charges', 'web', '2022-11-22 21:51:17', '2022-12-06 15:16:13'),
(126, 'manage charges', 'web', '2022-11-22 21:51:30', '2022-12-06 15:15:30'),
(127, 'savings transactions reversal', 'web', '2022-11-22 21:51:43', '2022-11-22 21:51:43'),
(128, 'savings transactions fixed deposit', 'web', '2022-11-22 21:52:01', '2022-11-22 21:52:01'),
(129, 'savings transactions post deposit', 'web', '2022-11-22 21:52:15', '2022-11-22 21:52:15'),
(130, 'general ledger', 'web', '2022-11-22 21:52:34', '2022-11-22 21:52:34'),
(131, 'heritage gl', 'web', '2022-11-22 21:52:44', '2022-11-22 21:52:44'),
(132, 'create fixed deposit', 'web', '2022-11-22 21:52:56', '2022-11-22 21:52:56'),
(133, 'view fixed deposit', 'web', '2022-11-22 21:53:03', '2022-11-22 21:53:03'),
(134, 'create investment', 'web', '2022-11-22 21:53:20', '2022-11-22 21:53:20'),
(135, 'view investment', 'web', '2022-11-22 21:53:25', '2022-11-22 21:55:28'),
(136, 'savings transactions investment', 'web', '2022-11-22 21:53:43', '2022-11-22 21:53:43'),
(137, 'dashboard fixed deposit', 'web', '2022-11-22 21:53:57', '2022-11-22 21:53:57'),
(138, 'dashboard investment', 'web', '2022-11-22 21:54:09', '2022-11-22 21:54:09'),
(139, 'dashboard investment interest', 'web', '2022-11-22 21:54:23', '2022-11-22 21:54:23'),
(140, 'dashboard fixed deposit interest', 'web', '2022-11-22 21:54:45', '2022-11-22 21:54:45'),
(141, 'view communication', 'web', '2022-11-24 22:27:55', '2022-11-24 22:27:55'),
(142, 'edit customer', 'web', '2022-11-25 17:28:01', '2022-11-28 14:44:28'),
(143, 'edit other income', 'web', '2022-11-30 23:52:42', '2022-11-30 23:52:42'),
(144, 'view current', 'web', '2022-12-01 15:47:09', '2022-12-01 15:47:09'),
(145, 'edit savings', 'web', '2022-12-01 19:00:46', '2022-12-01 19:00:46'),
(146, 'edit charges', 'web', '2022-12-06 15:17:05', '2022-12-06 15:17:05'),
(147, 'delete charges', 'web', '2022-12-06 15:17:34', '2022-12-06 15:17:34'),
(148, 'view payslip', 'web', '2023-01-03 18:12:37', '2023-01-03 18:12:37'),
(149, 'create general ledger', 'web', '2023-01-18 15:33:38', '2023-01-18 15:33:38'),
(150, 'edit general ledger', 'web', '2023-01-18 15:34:11', '2023-01-18 15:34:11'),
(151, 'delete general ledger', 'web', '2023-01-18 15:36:33', '2023-01-18 15:36:33'),
(152, 'manage account category', 'web', '2023-01-18 15:36:53', '2023-01-18 15:36:53'),
(153, 'activate general ledger', 'web', '2023-01-18 15:37:45', '2023-01-18 15:37:45'),
(154, 'edit account category', 'web', '2023-01-18 15:37:55', '2023-01-18 15:37:55'),
(155, 'general ledger posting', 'web', '2023-01-18 15:39:45', '2023-01-18 15:39:45'),
(156, 'delete account category', 'web', '2023-01-18 15:40:00', '2023-01-18 15:40:00'),
(157, 'upload general ledger', 'web', '2023-01-18 15:42:54', '2023-01-18 15:42:54'),
(158, 'upload account category', 'web', '2023-01-18 15:43:25', '2023-01-18 15:43:25'),
(159, 'create account category', 'web', '2023-01-18 15:48:51', '2023-01-18 15:48:51'),
(160, 'fund approval', 'web', '2023-05-22 12:44:58', '2023-05-22 12:44:58'),
(161, 'subcription payment', 'web', '2023-06-14 08:05:45', '2023-06-14 08:05:45'),
(162, 'manage ipwhitelist', 'web', '2023-06-16 05:05:39', '2023-06-16 05:05:39'),
(163, 'manage bank', 'web', '2023-06-16 05:15:04', '2023-06-16 05:15:04'),
(164, 'fixed deposit liquidation', 'web', '2023-06-16 15:42:44', '2023-06-16 15:42:44'),
(165, 'fixed deposit product', 'web', '2023-06-16 15:43:45', '2023-06-16 15:43:45'),
(166, 'edit fixed deposit', 'web', '2023-06-20 09:50:31', '2023-06-20 09:50:31'),
(167, 'delete fixed deposit', 'web', '2023-06-20 09:50:41', '2023-06-20 09:50:41'),
(168, 'approve fixed deposit', 'web', '2023-06-20 17:08:17', '2023-06-20 17:08:17'),
(169, 'manage rate', 'web', '2023-07-30 20:13:29', '2023-07-30 20:13:29'),
(170, 'create fx', 'web', '2023-07-30 20:14:03', '2023-07-30 20:14:03'),
(171, 'edit fx', 'web', '2023-07-30 20:14:29', '2023-07-30 20:14:29'),
(172, 'delete fx', 'web', '2023-07-30 20:20:38', '2023-07-30 20:20:38'),
(173, 'fx sales', 'web', '2023-07-30 20:32:58', '2023-07-30 20:32:58'),
(174, 'fx purchase', 'web', '2023-07-30 20:33:13', '2023-07-30 20:33:13'),
(175, 'fx reversal', 'web', '2023-07-30 20:34:10', '2023-07-30 20:34:10'),
(176, 'manage fx', 'web', '2023-07-30 20:36:26', '2023-07-30 20:36:26'),
(177, 'wallet transaction', 'web', '2023-09-26 09:18:00', '2023-09-26 09:18:00'),
(179, 'upfront fdliquidation', 'web', '2024-02-16 12:30:28', '2024-02-16 12:30:28'),
(180, 'overdraft', 'web', '2024-04-26 12:17:57', '2024-04-26 12:17:57'),
(181, 'print-download statement', 'web', '2024-05-15 11:17:54', '2024-05-15 11:17:54'),
(182, 'reset qrcode', 'web', '2025-03-18 12:07:13', '2025-03-18 12:07:13'),
(183, 'reset users password', 'web', '2025-03-18 12:50:39', '2025-03-18 12:50:39'),
(184, 'unapprove loans', 'web', '2025-09-25 12:38:19', '2025-09-25 12:38:19'),
(185, 'undo disburse loans', 'web', '2025-09-25 12:42:41', '2025-09-25 12:42:41');

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `personal_access_tokens`
--

INSERT INTO `personal_access_tokens` (`id`, `tokenable_type`, `tokenable_id`, `name`, `token`, `abilities`, `last_used_at`, `expires_at`, `created_at`, `updated_at`) VALUES
(3, 'App\\Models\\Customer', 13, 'customerToken', 'e513d9084029d11e5ba46e89a55f2ccd8d7872ce81745553c668229106eebb86', '[\"customer\"]', '2023-03-14 17:09:12', NULL, '2023-03-14 16:13:19', '2023-03-14 17:09:12'),
(4, 'App\\Models\\Customer', 23, 'customerToken', '90434ae3d508e10521c0b90944a563d071f56eedacf30ed4af4ccf7df8b500f9', '[\"customer\"]', NULL, NULL, '2023-03-14 17:58:56', '2023-03-14 17:58:56'),
(5, 'App\\Models\\Customer', 13, 'customerToken', 'c9b0f1a02ab29d837356074b1cda7d5c8dd3f0a86ea4ba4d61818b43e98defb8', '[\"customer\"]', NULL, NULL, '2023-03-14 18:05:42', '2023-03-14 18:05:42'),
(6, 'App\\Models\\Customer', 23, 'customerToken', 'b9d2aef2cf11dc7e286527b2f5d4e296bff0fd77cffde59a42b2de9f3561f34b', '[\"customer\"]', '2023-03-14 18:14:42', NULL, '2023-03-14 18:09:56', '2023-03-14 18:14:42');

-- --------------------------------------------------------

--
-- Table structure for table `provision_rates`
--

CREATE TABLE `provision_rates` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `days` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `rate` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `branch_id` bigint DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `provision_rates`
--

INSERT INTO `provision_rates` (`id`, `name`, `days`, `rate`, `notes`, `branch_id`, `created_at`, `updated_at`) VALUES
(1, 'performing', '0', '1.00', NULL, NULL, NULL, NULL),
(2, 'pass & watch', '31', '5.00', NULL, NULL, NULL, NULL),
(3, 'substandard', '61', '10.00', NULL, NULL, NULL, NULL),
(4, 'doubtful', '91', '50.00', NULL, NULL, NULL, NULL),
(5, 'lost', '181', '100.00', NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `branch_id` bigint DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `name`, `guard_name`, `branch_id`, `created_at`, `updated_at`) VALUES
(1, 'super admin', 'web', NULL, '2022-11-22 20:00:18', '2022-11-22 20:00:18'),
(2, 'Treasury', 'web', NULL, '2022-11-22 20:35:56', '2023-09-25 09:18:33'),
(3, 'managing director', 'web', NULL, '2022-11-22 20:36:09', '2022-11-22 20:36:09'),
(4, 'Account Officer', 'web', NULL, '2023-06-04 16:19:06', '2024-03-07 11:54:50'),
(5, 'admin', 'web', NULL, '2023-06-04 22:17:26', '2023-06-04 22:17:26'),
(6, 'cash officer', 'web', NULL, '2023-11-09 09:52:48', '2023-11-09 09:52:48');

-- --------------------------------------------------------

--
-- Table structure for table `role_has_permissions`
--

CREATE TABLE `role_has_permissions` (
  `permission_id` bigint UNSIGNED NOT NULL,
  `role_id` bigint UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `role_has_permissions`
--

INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES
(1, 1),
(2, 1),
(3, 1),
(4, 1),
(6, 1),
(7, 1),
(8, 1),
(9, 1),
(10, 1),
(11, 1),
(12, 1),
(13, 1),
(14, 1),
(15, 1),
(16, 1),
(17, 1),
(18, 1),
(19, 1),
(20, 1),
(21, 1),
(22, 1),
(23, 1),
(24, 1),
(25, 1),
(26, 1),
(27, 1),
(28, 1),
(29, 1),
(30, 1),
(31, 1),
(32, 1),
(33, 1),
(34, 1),
(35, 1),
(36, 1),
(37, 1),
(38, 1),
(39, 1),
(40, 1),
(41, 1),
(42, 1),
(43, 1),
(44, 1),
(45, 1),
(46, 1),
(47, 1),
(48, 1),
(49, 1),
(50, 1),
(51, 1),
(52, 1),
(53, 1),
(54, 1),
(55, 1),
(56, 1),
(57, 1),
(59, 1),
(60, 1),
(61, 1),
(62, 1),
(63, 1),
(64, 1),
(65, 1),
(66, 1),
(67, 1),
(68, 1),
(69, 1),
(70, 1),
(71, 1),
(72, 1),
(73, 1),
(74, 1),
(75, 1),
(76, 1),
(77, 1),
(78, 1),
(79, 1),
(80, 1),
(81, 1),
(82, 1),
(83, 1),
(84, 1),
(85, 1),
(86, 1),
(87, 1),
(89, 1),
(90, 1),
(91, 1),
(92, 1),
(93, 1),
(94, 1),
(95, 1),
(96, 1),
(97, 1),
(98, 1),
(99, 1),
(100, 1),
(101, 1),
(102, 1),
(103, 1),
(104, 1),
(105, 1),
(106, 1),
(107, 1),
(108, 1),
(109, 1),
(110, 1),
(111, 1),
(112, 1),
(113, 1),
(114, 1),
(115, 1),
(116, 1),
(117, 1),
(118, 1),
(119, 1),
(120, 1),
(121, 1),
(122, 1),
(123, 1),
(124, 1),
(125, 1),
(126, 1),
(127, 1),
(128, 1),
(129, 1),
(130, 1),
(131, 1),
(132, 1),
(133, 1),
(134, 1),
(135, 1),
(136, 1),
(137, 1),
(138, 1),
(139, 1),
(140, 1),
(141, 1),
(142, 1),
(143, 1),
(144, 1),
(145, 1),
(146, 1),
(147, 1),
(148, 1),
(149, 1),
(150, 1),
(151, 1),
(152, 1),
(153, 1),
(154, 1),
(155, 1),
(156, 1),
(157, 1),
(158, 1),
(159, 1),
(160, 1),
(161, 1),
(162, 1),
(163, 1),
(164, 1),
(165, 1),
(166, 1),
(167, 1),
(168, 1),
(169, 1),
(170, 1),
(171, 1),
(172, 1),
(173, 1),
(174, 1),
(175, 1),
(176, 1),
(177, 1),
(179, 1),
(180, 1),
(181, 1),
(182, 1),
(183, 1),
(2, 2),
(10, 2),
(12, 2),
(14, 2),
(15, 2),
(16, 2),
(19, 2),
(20, 2),
(22, 2),
(23, 2),
(24, 2),
(25, 2),
(33, 2),
(34, 2),
(35, 2),
(36, 2),
(38, 2),
(40, 2),
(48, 2),
(50, 2),
(52, 2),
(53, 2),
(54, 2),
(55, 2),
(59, 2),
(60, 2),
(63, 2),
(67, 2),
(68, 2),
(71, 2),
(72, 2),
(73, 2),
(77, 2),
(78, 2),
(80, 2),
(84, 2),
(88, 2),
(100, 2),
(116, 2),
(117, 2),
(121, 2),
(122, 2),
(123, 2),
(125, 2),
(128, 2),
(129, 2),
(130, 2),
(132, 2),
(133, 2),
(134, 2),
(136, 2),
(137, 2),
(138, 2),
(139, 2),
(140, 2),
(142, 2),
(145, 2),
(146, 2),
(149, 2),
(150, 2),
(155, 2),
(157, 2),
(160, 2),
(163, 2),
(164, 2),
(168, 2),
(170, 2),
(173, 2),
(174, 2),
(175, 2),
(177, 2),
(179, 2),
(180, 2),
(181, 2),
(4, 3),
(161, 3),
(11, 4),
(19, 4),
(24, 4),
(52, 4),
(53, 4),
(59, 4),
(68, 4),
(77, 4),
(80, 4),
(101, 4),
(117, 4),
(133, 4),
(135, 4),
(137, 4),
(138, 4),
(144, 4),
(1, 5),
(2, 5),
(3, 5),
(7, 5),
(8, 5),
(9, 5),
(10, 5),
(11, 5),
(12, 5),
(13, 5),
(14, 5),
(15, 5),
(16, 5),
(17, 5),
(18, 5),
(19, 5),
(20, 5),
(21, 5),
(22, 5),
(23, 5),
(24, 5),
(25, 5),
(26, 5),
(27, 5),
(28, 5),
(29, 5),
(30, 5),
(31, 5),
(32, 5),
(33, 5),
(34, 5),
(35, 5),
(36, 5),
(37, 5),
(38, 5),
(39, 5),
(40, 5),
(41, 5),
(42, 5),
(43, 5),
(44, 5),
(45, 5),
(46, 5),
(47, 5),
(48, 5),
(49, 5),
(50, 5),
(51, 5),
(52, 5),
(53, 5),
(54, 5),
(55, 5),
(56, 5),
(59, 5),
(60, 5),
(61, 5),
(62, 5),
(63, 5),
(64, 5),
(65, 5),
(66, 5),
(67, 5),
(68, 5),
(69, 5),
(70, 5),
(71, 5),
(72, 5),
(73, 5),
(74, 5),
(75, 5),
(76, 5),
(77, 5),
(78, 5),
(79, 5),
(80, 5),
(81, 5),
(82, 5),
(83, 5),
(84, 5),
(85, 5),
(86, 5),
(87, 5),
(88, 5),
(89, 5),
(90, 5),
(91, 5),
(92, 5),
(93, 5),
(94, 5),
(95, 5),
(96, 5),
(97, 5),
(98, 5),
(99, 5),
(100, 5),
(101, 5),
(102, 5),
(103, 5),
(104, 5),
(105, 5),
(107, 5),
(108, 5),
(110, 5),
(112, 5),
(113, 5),
(114, 5),
(115, 5),
(116, 5),
(117, 5),
(118, 5),
(119, 5),
(120, 5),
(121, 5),
(122, 5),
(123, 5),
(124, 5),
(125, 5),
(126, 5),
(127, 5),
(128, 5),
(129, 5),
(130, 5),
(131, 5),
(132, 5),
(133, 5),
(134, 5),
(135, 5),
(136, 5),
(137, 5),
(138, 5),
(139, 5),
(140, 5),
(141, 5),
(142, 5),
(143, 5),
(144, 5),
(145, 5),
(146, 5),
(147, 5),
(148, 5),
(149, 5),
(150, 5),
(151, 5),
(152, 5),
(153, 5),
(154, 5),
(155, 5),
(156, 5),
(158, 5),
(159, 5),
(160, 5),
(161, 5),
(162, 5),
(163, 5),
(164, 5),
(165, 5),
(166, 5),
(168, 5),
(169, 5),
(170, 5),
(171, 5),
(172, 5),
(173, 5),
(174, 5),
(175, 5),
(176, 5),
(177, 5),
(181, 5),
(10, 6),
(14, 6),
(15, 6),
(16, 6),
(34, 6),
(35, 6),
(40, 6),
(43, 6),
(52, 6),
(53, 6),
(54, 6),
(59, 6),
(60, 6),
(63, 6),
(67, 6),
(68, 6),
(72, 6),
(77, 6),
(78, 6),
(84, 6),
(85, 6),
(86, 6),
(88, 6),
(89, 6),
(99, 6),
(116, 6),
(121, 6),
(122, 6),
(123, 6),
(124, 6),
(125, 6),
(128, 6),
(129, 6),
(130, 6),
(132, 6),
(134, 6),
(135, 6),
(136, 6),
(137, 6),
(138, 6),
(139, 6),
(140, 6),
(155, 6),
(170, 6),
(181, 6);

-- --------------------------------------------------------

--
-- Table structure for table `role_users`
--

CREATE TABLE `role_users` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `role_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `savings`
--

CREATE TABLE `savings` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED DEFAULT NULL,
  `customer_id` bigint UNSIGNED DEFAULT NULL,
  `savings_product_id` bigint UNSIGNED DEFAULT NULL,
  `account_balance` decimal(30,2) DEFAULT '0.00',
  `ledger_balance` decimal(30,2) NOT NULL DEFAULT '0.00',
  `lien_amount` varchar(225) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  `lien_deducted` varchar(225) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  `lien_remaining` varchar(225) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  `branch_id` bigint DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `savings`
--

INSERT INTO `savings` (`id`, `user_id`, `customer_id`, `savings_product_id`, `account_balance`, `ledger_balance`, `lien_amount`, `lien_deducted`, `lien_remaining`, `branch_id`, `created_at`, `updated_at`) VALUES
(1, 21, 1, 1, 0.00, 0.00, '0', '0', '0', NULL, '2023-06-29 13:07:33', '2026-01-09 17:14:07'),
(2, 21, 2, 1, 0.00, 0.00, '0', '0', '0', NULL, '2023-06-29 13:22:35', '2023-06-29 13:22:35'),
(3, 20, 3, 1, 7000.00, 0.00, '0', '0', '0', NULL, '2023-06-29 14:22:03', '2026-03-12 11:46:15'),
(4, 20, 4, 1, 0.00, 0.00, '0', '0', '0', NULL, '2023-06-29 14:25:06', '2025-09-01 19:20:30'),
(5, 21, 5, 1, 0.00, 0.00, '0', '0', '0', NULL, '2023-06-29 14:33:02', '2024-03-26 15:45:23');

-- --------------------------------------------------------

--
-- Table structure for table `savings_products`
--

CREATE TABLE `savings_products` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `product_number` int NOT NULL,
  `allow_overdraw` tinyint NOT NULL DEFAULT '0',
  `interest_rate` decimal(8,2) DEFAULT NULL,
  `minimum_balance` int NOT NULL DEFAULT '0',
  `interest_posting` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `interest_adding` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `savings_products`
--

INSERT INTO `savings_products` (`id`, `user_id`, `name`, `product_number`, `allow_overdraw`, `interest_rate`, `minimum_balance`, `interest_posting`, `interest_adding`, `notes`, `created_at`, `updated_at`) VALUES
(1, 1, 'Savings Account', 101, 0, 2.00, 0, '30', '0', NULL, '2022-12-01 18:56:38', '2023-03-27 13:16:08'),
(2, 1, 'Current Account', 201, 0, 0.00, 0, '30', '4', NULL, '2022-12-01 18:56:55', '2022-12-02 21:22:34');

-- --------------------------------------------------------

--
-- Table structure for table `savings_transactions`
--

CREATE TABLE `savings_transactions` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED DEFAULT NULL,
  `customer_id` bigint UNSIGNED DEFAULT NULL,
  `branch_id` bigint UNSIGNED DEFAULT NULL,
  `amount` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(225) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `device` varchar(225) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `system_interest` tinyint NOT NULL DEFAULT '0',
  `slip` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_approve` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `destination_account` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `transfer_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `reference_no` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `status` varchar(225) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status_type` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `trnx_type` varchar(225) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `initiated_by` varchar(225) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `approve_by` varchar(225) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `approve_date` datetime DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `savings_transactions`
--

INSERT INTO `savings_transactions` (`id`, `user_id`, `customer_id`, `branch_id`, `amount`, `type`, `device`, `system_interest`, `slip`, `is_approve`, `destination_account`, `transfer_type`, `reference_no`, `notes`, `status`, `status_type`, `trnx_type`, `initiated_by`, `approve_by`, `approve_date`, `created_at`, `updated_at`) VALUES
(1, 24, 356, NULL, '48500000', 'credit', 'core', 0, 'Glc202509030111273005', '1', NULL, 'glc', 'Cr202509030111279783', 'MIGRATION / CEDRUS TRUSTEES', 'declined', '1', 'trnsfer', 'Ajose-Adeogun Olakune', 'Yusuf Ayotunde', '2025-09-03 13:26:51', '2025-09-03 13:11:27', '2025-09-03 13:26:51'),
(2, 27, 630, NULL, '1173337', 'credit', 'core', 0, 'Glc202509030113111819', '1', NULL, 'glc', 'Cr202509030113113378', 'MIGRATION/JMr PASTOR MOSES OKEDIJI', 'declined', '1', 'trnsfer', 'Opeyemi Oluwakemi', 'Obazee Moses', '2025-09-03 13:20:58', '2025-09-03 13:13:11', '2025-09-03 13:20:58'),
(3, 28, 375, NULL, '10755711', 'credit', 'core', 0, 'Glc202509030113123600', '1', NULL, 'glc', 'Cr202509030113129587', 'MIGRATION/ UCHENNA IJEOMA JECINTA--14/08/2025', 'declined', '1', 'trnsfer', 'ADEIZA ABIODUN EMMANUEL', 'AYARA TUNJI', '2025-09-03 13:26:23', '2025-09-03 13:13:12', '2025-09-03 13:26:23'),
(4, 24, 331, NULL, '45400000', 'credit', 'core', 0, 'Glc202509030114063944', '1', NULL, 'glc', 'Cr202509030114065476', 'MIGRATION / CEDRUS CAPITAL LTD [trustees]', 'declined', '1', 'trnsfer', 'Ajose-Adeogun Olakune', 'AYARA TUNJI', '2025-09-03 13:25:57', '2025-09-03 13:14:06', '2025-09-03 13:25:57'),
(5, 36, 197, NULL, '14000000', 'credit', 'core', 0, 'Glc202509030114061736', '1', NULL, 'glc', 'Cr202509030114061999', 'MIGRATION/ACHUGO CHIAMAKA NMA', 'approved', '1', 'trnsfer', 'ORAKPOSIM JUDITH', 'Obazee Moses', '2025-09-03 13:25:57', '2025-09-03 13:14:06', '2025-09-03 13:25:57'),
(10392, 1, 3, NULL, '20000', 'debit', 'core', 0, NULL, NULL, NULL, NULL, 'Inv202602060320196019', 'fixed deposit 34267970--approved', 'approved', '2', 'trnsfer', 'admin system', 'admin system', NULL, '2026-02-06 14:20:19', '2026-02-06 14:20:19'),
(10395, 1, 3, NULL, '5000', 'debit', 'core', 0, NULL, NULL, NULL, NULL, 'Inv202603021154242505', 'fixed deposit 41129781--approved', 'approved', '2', 'trnsfer', 'admin system', 'admin system', NULL, '2026-03-02 10:54:24', '2026-03-02 10:54:24'),
(10396, 1, 3, NULL, '10000', 'debit', 'core', 0, NULL, NULL, NULL, NULL, 'Inv202603021158217414', 'fixed deposit 29306531--approved', 'approved', '2', 'trnsfer', 'admin system', 'admin system', NULL, '2026-03-02 10:58:21', '2026-03-02 10:58:21'),
(10405, 1, 3, NULL, '8000', 'debit', 'core', 0, NULL, NULL, NULL, NULL, 'Inv202603021253278488', 'fixed deposit 19879297--appr', 'approved', '2', 'trnsfer', 'admin system', 'admin system', NULL, '2026-03-02 11:53:27', '2026-03-02 11:53:27'),
(10406, 1, 3, NULL, '8000', 'debit', 'core', 0, NULL, NULL, NULL, NULL, 'Inv202603020351263024', 'fixed deposit 19879297--approfg', 'approved', '2', 'trnsfer', 'admin system', 'admin system', NULL, '2026-03-02 14:51:26', '2026-03-02 14:51:26'),
(10407, 1, 3, NULL, '8000', 'debit', 'core', 0, NULL, NULL, NULL, NULL, 'Inv202603020355331276', 'fixed deposit 19879297--tdhsjf', 'approved', '2', 'trnsfer', 'admin system', 'admin system', NULL, '2026-03-02 14:55:33', '2026-03-02 14:55:33'),
(10408, 1, 3, NULL, '9000', 'debit', 'core', 0, NULL, NULL, NULL, NULL, 'Inv202603020358302888', 'fixed deposit 97520906--yrhgkerg', 'approved', '2', 'trnsfer', 'admin system', 'admin system', NULL, '2026-03-02 14:58:30', '2026-03-02 14:58:30'),
(10409, 1, 3, NULL, '10000', 'debit', 'core', 0, NULL, NULL, NULL, NULL, 'Inv202603060917515033', 'fixed deposit 67262172--aproved', 'approved', '2', 'trnsfer', 'admin system', 'admin system', NULL, '2026-03-06 08:17:51', '2026-03-06 08:17:51'),
(10410, 1, 3, NULL, '10000', 'debit', 'core', 0, NULL, NULL, NULL, NULL, 'Inv202603060929421828', 'fixed deposit 67262172--arpyfg', 'approved', '2', 'trnsfer', 'admin system', 'admin system', NULL, '2026-03-06 08:29:42', '2026-03-06 08:29:42'),
(10411, 1, 3, NULL, '10000', 'debit', 'core', 0, NULL, NULL, NULL, NULL, 'Inv202603060936488820', 'fixed deposit 67262172--ghrgthrt', 'approved', '2', 'trnsfer', 'admin system', 'admin system', NULL, '2026-03-06 08:36:48', '2026-03-06 08:36:48'),
(10412, 1, 3, NULL, '10000', 'debit', 'core', 0, NULL, NULL, NULL, NULL, 'Inv202603060959189646', 'fixed deposit 67262172--afsyddj', 'approved', '2', 'trnsfer', 'admin system', 'admin system', NULL, '2026-03-06 08:59:18', '2026-03-06 08:59:18'),
(10413, 1, 3, NULL, '10000', 'debit', 'core', 0, NULL, NULL, NULL, NULL, 'Inv202603090240219813', 'fixed deposit 14632028--approd', 'approved', '2', 'trnsfer', 'admin system', 'admin system', NULL, '2026-03-09 13:40:21', '2026-03-09 13:40:21'),
(10414, 1, 3, NULL, '10000', 'debit', 'core', 0, NULL, NULL, NULL, NULL, 'Inv202603090249176055', 'fixed deposit 14632028--adfghsdjf', 'approved', '2', 'trnsfer', 'admin system', 'admin system', NULL, '2026-03-09 13:49:17', '2026-03-09 13:49:17'),
(10415, 1, 3, NULL, '10000', 'debit', 'core', 0, NULL, NULL, NULL, NULL, 'Inv202603090251541501', 'fixed deposit 14632028--dsdgh', 'approved', '2', 'trnsfer', 'admin system', 'admin system', NULL, '2026-03-09 13:51:54', '2026-03-09 13:51:54'),
(10416, 1, 3, NULL, '10000', 'debit', 'core', 0, NULL, NULL, NULL, NULL, 'Inv202603090257243830', 'fixed deposit 14632028--fhfhjgh', 'approved', '2', 'trnsfer', 'admin system', 'admin system', NULL, '2026-03-09 13:57:24', '2026-03-09 13:57:24'),
(10417, 1, 3, NULL, '10000', 'debit', 'core', 0, NULL, NULL, NULL, NULL, 'Inv202603090302158628', 'fixed deposit 14632028--asrfgh', 'approved', '2', 'trnsfer', 'admin system', 'admin system', NULL, '2026-03-09 14:02:15', '2026-03-09 14:02:15'),
(10418, 1, 3, NULL, '10000', 'debit', 'core', 0, NULL, NULL, NULL, NULL, 'Inv202603090343069334', 'fixed deposit 14632028--bvgcvbn', 'approved', '2', 'trnsfer', 'admin system', 'admin system', NULL, '2026-03-09 14:43:06', '2026-03-09 14:43:06'),
(10419, 1, 3, NULL, '10000', 'debit', 'core', 0, NULL, NULL, NULL, NULL, 'Inv202603090352208352', 'fixed deposit 96925391--apprugf', 'approved', '2', 'trnsfer', 'admin system', 'admin system', NULL, '2026-03-09 14:52:20', '2026-03-09 14:52:20'),
(10420, 1, 3, NULL, '10000', 'debit', 'core', 0, NULL, NULL, NULL, NULL, 'Inv202603101141531932', 'fixed deposit 96925391--jhfhskgr', 'approved', '2', 'trnsfer', 'admin system', 'admin system', NULL, '2026-03-10 10:41:53', '2026-03-10 10:41:53'),
(10421, 1, 3, NULL, '10000', 'debit', 'core', 0, NULL, NULL, NULL, NULL, 'Inv202603101145454799', 'fixed deposit 96925391--fdhg', 'approved', '2', 'trnsfer', 'admin system', 'admin system', NULL, '2026-03-10 10:45:45', '2026-03-10 10:45:45'),
(10422, 1, 3, NULL, '10000', 'debit', 'core', 0, NULL, NULL, NULL, NULL, 'Inv202603100426083235', 'fixed deposit 96925391--fggdfhd', 'approved', '2', 'trnsfer', 'admin system', 'admin system', NULL, '2026-03-10 15:26:08', '2026-03-10 15:26:08'),
(10423, 1, 3, NULL, '10000', 'debit', 'core', 0, NULL, NULL, NULL, NULL, 'Inv202603100442029264', 'fixed deposit 96925391--sdggfsdjf', 'approved', '2', 'trnsfer', 'admin system', 'admin system', NULL, '2026-03-10 15:42:02', '2026-03-10 15:42:02'),
(10424, 1, 3, NULL, '10000', 'debit', 'core', 0, NULL, NULL, NULL, NULL, 'Inv202603121246159128', 'fixed deposit 36598982--dgsdhgj', 'approved', '2', 'trnsfer', 'admin system', 'admin system', NULL, '2026-03-12 11:46:15', '2026-03-12 11:46:15');

-- --------------------------------------------------------

--
-- Table structure for table `savings_transaction_g_l_s`
--

CREATE TABLE `savings_transaction_g_l_s` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED DEFAULT NULL,
  `branch_id` bigint UNSIGNED DEFAULT NULL,
  `general_ledger_id` bigint UNSIGNED DEFAULT NULL,
  `amount` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` enum('deposit','rev_deposit','rev_withdrawal','withdrawal','esusu','monthly_charge','form_fees','bank_fees','interest','sms','dividend','guarantee','guarantee_restored','repayment','fd_interest','investment','process_fees','fixed_deposit','rev_fixed_deposit','loan','wht','rev_interest','transfer_charge','debit','credit','part_liquidate') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `device` varchar(225) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `slip` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `reference_no` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `status` text COLLATE utf8mb4_unicode_ci,
  `status_type` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `initiated_by` varchar(225) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `approved_by` varchar(225) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `approve_date` datetime DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `savings_transaction_g_l_s`
--

INSERT INTO `savings_transaction_g_l_s` (`id`, `user_id`, `branch_id`, `general_ledger_id`, `amount`, `type`, `device`, `slip`, `reference_no`, `notes`, `status`, `status_type`, `initiated_by`, `approved_by`, `approve_date`, `created_at`, `updated_at`) VALUES
(1, 24, NULL, 105, '48500000', 'debit', 'core', NULL, 'Glc202509030111273005', 'MIGRATION / CEDRUS TRUSTEES', 'declined', NULL, 'Ajose-Adeogun Olakune', 'Yusuf Ayotunde', '2025-09-03 13:26:51', '2025-09-03 13:11:27', '2025-09-03 13:26:51'),
(2, 27, NULL, 105, '1173337', 'debit', 'core', NULL, 'Glc202509030113111819', 'MIGRATION/JMr PASTOR MOSES OKEDIJI', 'declined', NULL, 'Opeyemi Oluwakemi', 'Obazee Moses', '2025-09-03 13:20:59', '2025-09-03 13:13:11', '2025-09-03 13:20:59'),
(3, 28, NULL, 105, '10755711', 'debit', 'core', NULL, 'Glc202509030113123600', 'MIGRATION/ UCHENNA IJEOMA JECINTA--14/08/2025', 'declined', NULL, 'ADEIZA ABIODUN EMMANUEL', 'AYARA TUNJI', '2025-09-03 13:26:23', '2025-09-03 13:13:12', '2025-09-03 13:26:23'),
(4, 24, NULL, 105, '45400000', 'debit', 'core', NULL, 'Glc202509030114063944', 'MIGRATION / CEDRUS CAPITAL LTD [trustees]', 'declined', NULL, 'Ajose-Adeogun Olakune', 'AYARA TUNJI', '2025-09-03 13:25:57', '2025-09-03 13:14:06', '2025-09-03 13:25:57'),
(5, 36, NULL, 105, '14000000', 'debit', 'core', NULL, 'Glc202509030114061736', 'MIGRATION/ACHUGO CHIAMAKA NMA', 'approved', NULL, 'ORAKPOSIM JUDITH', 'Obazee Moses', '2025-09-03 13:25:57', '2025-09-03 13:14:06', '2025-09-03 13:25:57'),
(30057, NULL, NULL, 333, '20000', 'debit', 'core', 'Inv202602060320196019', 'Svgl202602060320198290', 'customer debited', 'approved', NULL, 'admin system', NULL, NULL, '2026-02-06 14:20:19', '2026-02-06 14:20:19'),
(30058, NULL, NULL, 274, '20000', 'credit', 'core', 'Inv202602060320196019', 'Inv202602060320193474', 'credit investment', 'approved', NULL, 'admin system', NULL, NULL, '2026-02-06 14:20:19', '2026-02-06 14:20:19'),
(30063, NULL, NULL, 333, '5000', 'debit', 'core', 'Inv202603021154242505', 'Svgl202603021154247289', 'customer debited', 'approved', NULL, 'admin system', NULL, NULL, '2026-03-02 10:54:24', '2026-03-02 10:54:24'),
(30064, NULL, NULL, 274, '5000', 'credit', 'core', 'Inv202603021154242505', 'Inv202603021154241649', 'credit investment', 'approved', NULL, 'admin system', NULL, NULL, '2026-03-02 10:54:24', '2026-03-02 10:54:24'),
(30065, NULL, NULL, 333, '10000', 'debit', 'core', 'Inv202603021158217414', 'Svgl202603021158212496', 'customer debited', 'approved', NULL, 'admin system', NULL, NULL, '2026-03-02 10:58:21', '2026-03-02 10:58:21'),
(30066, NULL, NULL, 274, '10000', 'credit', 'core', 'Inv202603021158217414', 'Inv202603021158214905', 'credit investment', 'approved', NULL, 'admin system', NULL, NULL, '2026-03-02 10:58:21', '2026-03-02 10:58:21'),
(30083, NULL, NULL, 333, '8000', 'debit', 'core', 'Inv202603021253278488', 'Svgl202603021253279052', 'customer debited', 'approved', NULL, 'admin system', NULL, NULL, '2026-03-02 11:53:27', '2026-03-02 11:53:27'),
(30084, NULL, NULL, 274, '8000', 'credit', 'core', 'Inv202603021253278488', 'Inv202603021253273475', 'credit investment', 'approved', NULL, 'admin system', NULL, NULL, '2026-03-02 11:53:27', '2026-03-02 11:53:27'),
(30085, NULL, NULL, 333, '8000', 'debit', 'core', 'Inv202603020351263024', 'Svgl202603020351264235', 'customer debited', 'approved', NULL, 'admin system', NULL, NULL, '2026-03-02 14:51:26', '2026-03-02 14:51:26'),
(30086, NULL, NULL, 274, '8000', 'credit', 'core', 'Inv202603020351263024', 'Inv202603020351265778', 'credit investment', 'approved', NULL, 'admin system', NULL, NULL, '2026-03-02 14:51:26', '2026-03-02 14:51:26'),
(30087, NULL, NULL, 333, '8000', 'debit', 'core', 'Inv202603020355331276', 'Svgl202603020355337301', 'customer debited', 'approved', NULL, 'admin system', NULL, NULL, '2026-03-02 14:55:33', '2026-03-02 14:55:33'),
(30088, NULL, NULL, 274, '8000', 'credit', 'core', 'Inv202603020355331276', 'Inv202603020355338494', 'credit investment', 'approved', NULL, 'admin system', NULL, NULL, '2026-03-02 14:55:33', '2026-03-02 14:55:33'),
(30089, NULL, NULL, 333, '9000', 'debit', 'core', 'Inv202603020358302888', 'Svgl202603020358305699', 'customer debited', 'approved', NULL, 'admin system', NULL, NULL, '2026-03-02 14:58:30', '2026-03-02 14:58:30'),
(30090, NULL, NULL, 274, '9000', 'credit', 'core', 'Inv202603020358302888', 'Inv202603020358307875', 'credit investment', 'approved', NULL, 'admin system', NULL, NULL, '2026-03-02 14:58:30', '2026-03-02 14:58:30'),
(30091, NULL, NULL, 333, '10000', 'debit', 'core', 'Inv202603060917515033', 'Svgl202603060917519590', 'customer debited', 'approved', NULL, 'admin system', NULL, NULL, '2026-03-06 08:17:51', '2026-03-06 08:17:51'),
(30092, NULL, NULL, 274, '10000', 'credit', 'core', 'Inv202603060917515033', 'Inv202603060917518450', 'credit investment', 'approved', NULL, 'admin system', NULL, NULL, '2026-03-06 08:17:51', '2026-03-06 08:17:51'),
(30093, NULL, NULL, 333, '10000', 'debit', 'core', 'Inv202603060929421828', 'Svgl202603060929429097', 'customer debited', 'approved', NULL, 'admin system', NULL, NULL, '2026-03-06 08:29:42', '2026-03-06 08:29:42'),
(30094, NULL, NULL, 274, '10000', 'credit', 'core', 'Inv202603060929421828', 'Inv202603060929423241', 'credit investment', 'approved', NULL, 'admin system', NULL, NULL, '2026-03-06 08:29:42', '2026-03-06 08:29:42'),
(30095, NULL, NULL, 333, '10000', 'debit', 'core', 'Inv202603060936488820', 'Svgl202603060936481195', 'customer debited', 'approved', NULL, 'admin system', NULL, NULL, '2026-03-06 08:36:48', '2026-03-06 08:36:48'),
(30096, NULL, NULL, 274, '10000', 'credit', 'core', 'Inv202603060936488820', 'Inv202603060936481617', 'credit investment', 'approved', NULL, 'admin system', NULL, NULL, '2026-03-06 08:36:48', '2026-03-06 08:36:48'),
(30097, NULL, NULL, 333, '10000', 'debit', 'core', 'Inv202603060959189646', 'Svgl202603060959182951', 'customer debited', 'approved', NULL, 'admin system', NULL, NULL, '2026-03-06 08:59:18', '2026-03-06 08:59:18'),
(30098, NULL, NULL, 274, '10000', 'credit', 'core', 'Inv202603060959189646', 'Inv202603060959184494', 'credit investment', 'approved', NULL, 'admin system', NULL, NULL, '2026-03-06 08:59:18', '2026-03-06 08:59:18'),
(30099, NULL, NULL, 333, '10000', 'debit', 'core', 'Inv202603090240219813', 'Svgl202603090240213314', 'customer debited', 'approved', NULL, 'admin system', NULL, NULL, '2026-03-09 13:40:21', '2026-03-09 13:40:21'),
(30100, NULL, NULL, 274, '10000', 'credit', 'core', 'Inv202603090240219813', 'Inv202603090240213793', 'credit investment', 'approved', NULL, 'admin system', NULL, NULL, '2026-03-09 13:40:21', '2026-03-09 13:40:21'),
(30101, NULL, NULL, 333, '10000', 'debit', 'core', 'Inv202603090249176055', 'Svgl202603090249171403', 'customer debited', 'approved', NULL, 'admin system', NULL, NULL, '2026-03-09 13:49:17', '2026-03-09 13:49:17'),
(30102, NULL, NULL, 274, '10000', 'credit', 'core', 'Inv202603090249176055', 'Inv202603090249175670', 'credit investment', 'approved', NULL, 'admin system', NULL, NULL, '2026-03-09 13:49:17', '2026-03-09 13:49:17'),
(30103, NULL, NULL, 333, '10000', 'debit', 'core', 'Inv202603090251541501', 'Svgl202603090251545612', 'customer debited', 'approved', NULL, 'admin system', NULL, NULL, '2026-03-09 13:51:54', '2026-03-09 13:51:54'),
(30104, NULL, NULL, 274, '10000', 'credit', 'core', 'Inv202603090251541501', 'Inv202603090251547472', 'credit investment', 'approved', NULL, 'admin system', NULL, NULL, '2026-03-09 13:51:54', '2026-03-09 13:51:54'),
(30105, NULL, NULL, 333, '10000', 'debit', 'core', 'Inv202603090257243830', 'Svgl202603090257246513', 'customer debited', 'approved', NULL, 'admin system', NULL, NULL, '2026-03-09 13:57:24', '2026-03-09 13:57:24'),
(30106, NULL, NULL, 274, '10000', 'credit', 'core', 'Inv202603090257243830', 'Inv202603090257246548', 'credit investment', 'approved', NULL, 'admin system', NULL, NULL, '2026-03-09 13:57:24', '2026-03-09 13:57:24'),
(30107, NULL, NULL, 333, '10000', 'debit', 'core', 'Inv202603090302158628', 'Svgl202603090302153817', 'customer debited', 'approved', NULL, 'admin system', NULL, NULL, '2026-03-09 14:02:15', '2026-03-09 14:02:15'),
(30108, NULL, NULL, 274, '10000', 'credit', 'core', 'Inv202603090302158628', 'Inv202603090302155295', 'credit investment', 'approved', NULL, 'admin system', NULL, NULL, '2026-03-09 14:02:15', '2026-03-09 14:02:15'),
(30109, NULL, NULL, 333, '10000', 'debit', 'core', 'Inv202603090343069334', 'Svgl202603090343068024', 'customer debited', 'approved', NULL, 'admin system', NULL, NULL, '2026-03-09 14:43:06', '2026-03-09 14:43:06'),
(30110, NULL, NULL, 274, '10000', 'credit', 'core', 'Inv202603090343069334', 'Inv202603090343065445', 'credit investment', 'approved', NULL, 'admin system', NULL, NULL, '2026-03-09 14:43:06', '2026-03-09 14:43:06'),
(30111, NULL, NULL, 333, '10000', 'debit', 'core', 'Inv202603090352208352', 'Svgl202603090352203924', 'customer debited', 'approved', NULL, 'admin system', NULL, NULL, '2026-03-09 14:52:20', '2026-03-09 14:52:20'),
(30112, NULL, NULL, 274, '10000', 'credit', 'core', 'Inv202603090352208352', 'Inv202603090352203206', 'credit investment', 'approved', NULL, 'admin system', NULL, NULL, '2026-03-09 14:52:20', '2026-03-09 14:52:20'),
(30113, NULL, NULL, 333, '10000', 'debit', 'core', 'Inv202603101141531932', 'Svgl202603101141537905', 'customer debited', 'approved', NULL, 'admin system', NULL, NULL, '2026-03-10 10:41:53', '2026-03-10 10:41:53'),
(30114, NULL, NULL, 274, '10000', 'credit', 'core', 'Inv202603101141531932', 'Inv202603101141533752', 'credit investment', 'approved', NULL, 'admin system', NULL, NULL, '2026-03-10 10:41:53', '2026-03-10 10:41:53'),
(30115, NULL, NULL, 333, '10000', 'debit', 'core', 'Inv202603101145454799', 'Svgl202603101145456091', 'customer debited', 'approved', NULL, 'admin system', NULL, NULL, '2026-03-10 10:45:45', '2026-03-10 10:45:45'),
(30116, NULL, NULL, 274, '10000', 'credit', 'core', 'Inv202603101145454799', 'Inv202603101145454717', 'credit investment', 'approved', NULL, 'admin system', NULL, NULL, '2026-03-10 10:45:45', '2026-03-10 10:45:45'),
(30117, NULL, NULL, 333, '10000', 'debit', 'core', 'Inv202603100426083235', 'Svgl202603100426087609', 'customer debited', 'approved', NULL, 'admin system', NULL, NULL, '2026-03-10 15:26:08', '2026-03-10 15:26:08'),
(30118, NULL, NULL, 274, '10000', 'credit', 'core', 'Inv202603100426083235', 'Inv202603100426082523', 'credit investment', 'approved', NULL, 'admin system', NULL, NULL, '2026-03-10 15:26:08', '2026-03-10 15:26:08'),
(30119, NULL, NULL, 333, '10000', 'debit', 'core', 'Inv202603100442029264', 'Svgl202603100442023149', 'customer debited', 'approved', NULL, 'admin system', NULL, NULL, '2026-03-10 15:42:02', '2026-03-10 15:42:02'),
(30120, NULL, NULL, 274, '10000', 'credit', 'core', 'Inv202603100442029264', 'Inv202603100442024816', 'credit investment', 'approved', NULL, 'admin system', NULL, NULL, '2026-03-10 15:42:02', '2026-03-10 15:42:02'),
(30121, NULL, NULL, 333, '10000', 'debit', 'core', 'Inv202603121246159128', 'Svgl202603121246156304', 'customer debited', 'approved', NULL, 'admin system', NULL, NULL, '2026-03-12 11:46:15', '2026-03-12 11:46:15'),
(30122, NULL, NULL, 274, '10000', 'credit', 'core', 'Inv202603121246159128', 'Inv202603121246158613', 'credit investment', 'approved', NULL, 'admin system', NULL, NULL, '2026-03-12 11:46:15', '2026-03-12 11:46:15');

-- --------------------------------------------------------

--
-- Table structure for table `saving_fees`
--

CREATE TABLE `saving_fees` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `savings_products` text COLLATE utf8mb4_unicode_ci,
  `amount` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fees_posting` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fees_adding` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `new_fee_type` enum('full','pro_data') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'full',
  `branch_id` bigint DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sectors`
--

CREATE TABLE `sectors` (
  `id` bigint UNSIGNED NOT NULL,
  `sector` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `branch_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sectors`
--

INSERT INTO `sectors` (`id`, `sector`, `branch_id`, `created_at`, `updated_at`) VALUES
(1, 'Agriculture & Forestry', NULL, '2023-09-28 12:11:02', '2023-09-28 12:18:45'),
(2, 'Mining & Quarry', NULL, '2023-09-28 12:19:10', '2023-09-28 12:19:10'),
(3, 'Manufacturing & Food Processing', NULL, '2023-09-28 12:19:29', '2023-09-28 12:19:29'),
(4, 'Trade & Commerce', NULL, '2023-09-28 12:22:27', '2023-09-28 12:22:27'),
(5, 'Transport & Communication', NULL, '2023-09-28 12:23:05', '2023-09-28 12:23:05'),
(6, 'Real Estate & Construction', NULL, '2023-09-28 12:23:54', '2023-09-28 12:23:54'),
(7, 'Rent/Housing', NULL, '2023-09-28 12:24:31', '2023-09-28 12:24:31'),
(8, 'Consumer/Personal', NULL, '2023-09-28 12:24:51', '2023-09-28 12:24:51'),
(9, 'Health', NULL, '2023-09-28 12:25:04', '2023-09-28 12:25:04'),
(10, 'Education', NULL, '2023-09-28 12:25:19', '2023-09-28 12:25:19'),
(11, 'Tourism & Hospitality', NULL, '2023-09-28 12:25:35', '2023-09-28 12:25:35'),
(12, 'Purchase of Shares', NULL, '2023-09-28 12:25:54', '2023-09-28 12:25:54'),
(13, 'Others', NULL, '2023-09-28 12:26:17', '2023-09-28 12:29:07');

-- --------------------------------------------------------

--
-- Table structure for table `settings`
--

CREATE TABLE `settings` (
  `id` bigint UNSIGNED NOT NULL,
  `setting_key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `setting_value` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `settings`
--

INSERT INTO `settings` (`id`, `setting_key`, `setting_value`, `created_at`, `updated_at`) VALUES
(1, 'company_name', 'RichGreen Masters Investment Limited', NULL, '2026-01-09 12:14:00'),
(2, 'company_share', '200000000', NULL, '2026-01-09 12:14:00'),
(3, 'company_capital', '200000000', NULL, '2026-01-09 12:14:00'),
(4, 'bank_fund', '7342678394.15', NULL, '2026-01-09 12:17:16'),
(5, 'till_account', '10923392', NULL, '2026-01-09 12:14:00'),
(6, 'vault_account', '10373391', NULL, '2026-01-09 12:14:00'),
(7, 'giftbill_account', '10839235', NULL, '2026-01-09 12:14:00'),
(8, 'vtpass_account', '10221490', NULL, '2026-01-09 12:14:00'),
(9, 'company_account', '10997918', NULL, '2026-01-09 12:14:01'),
(10, 'online_transfer', '100000', NULL, '2026-01-09 12:14:01'),
(11, 'company_address', '33A1 Remi Fani Kayode Street Ikeja GRA', NULL, '2026-01-09 12:14:01'),
(12, 'company_currency', 'NGN', NULL, '2026-01-09 12:14:01'),
(13, 'company_website', 'https://www.richgreenmasters.com', NULL, '2026-01-09 12:14:01'),
(14, 'company_country', 'Nigeria', NULL, '2026-01-09 12:14:01'),
(15, 'system_version', '1.0', NULL, NULL),
(16, 'sms_enabled', '0', NULL, '2026-01-09 12:14:01'),
(17, 'active_sms', 'termii', NULL, '2026-01-09 12:14:01'),
(18, 'portal_address', 'http://www.richgreenmasters.com', NULL, '2026-01-09 12:14:01'),
(19, 'company_email', 'info@richgreenmasters.com', NULL, '2026-01-09 12:14:01'),
(20, 'company_phone', '08033197469', NULL, '2026-01-09 12:14:01'),
(21, 'currency_symbol', '₦', NULL, '2026-01-09 12:14:01'),
(22, 'currency_position', 'left', NULL, '2026-01-09 12:14:01'),
(23, 'company_logo', 'uploads/1705062669_rg.png', NULL, '2024-01-12 13:31:09'),
(24, 'login_background', 'uploads/1757058438_RG.png', NULL, '2025-09-05 08:47:18'),
(25, 'sms_public_key', 'TLiM5DkroxQm3PWj1feBTUnNJO4kIEiRP5gQq6fMiRsdzc4igHVeae568O3MKN', NULL, '2026-01-09 12:14:01'),
(26, 'sms_secret_key', NULL, NULL, '2026-01-09 12:14:01'),
(27, 'twilio_phone_number', NULL, NULL, '2026-01-09 12:14:01'),
(28, 'sms_baseurl', 'https://api.ng.termii.com/api/', NULL, '2026-01-09 12:14:01'),
(29, 'routesms_host', NULL, NULL, NULL),
(30, 'routesms_username', NULL, NULL, NULL),
(31, 'routesms_password', NULL, NULL, NULL),
(32, 'routesms_port', NULL, NULL, NULL),
(33, 'sms_sender', 'RichGreen', NULL, '2026-01-09 12:14:01'),
(34, 'clickatell_username', NULL, NULL, '2026-01-09 12:14:01'),
(35, 'clickatell_password', NULL, NULL, '2026-01-09 12:14:01'),
(36, 'clickatell_api_id', NULL, NULL, '2026-01-09 12:14:01'),
(37, 'clickatell_baseurl', NULL, NULL, '2026-01-09 12:14:01'),
(38, 'paypal_email', NULL, NULL, NULL),
(39, 'currency', 'USD', NULL, NULL),
(40, 'password_reset_subject', 'Password reset instructions', NULL, NULL),
(41, 'password_reset_template', 'Password reset instructions', NULL, NULL),
(42, 'payment_received_sms_template', 'Dear {borrowerFirstName}, we have received your payment of {paymentAmount} for loan {loanNumber}. New loan balance:{loanBalance}. Thank you', NULL, '2026-01-09 12:14:01'),
(43, 'payment_received_email_template', 'Dear {borrowerFirstName}, we have received your payment of {paymentAmount} for loan {loanNumber}. New loan balance:{loanBalance}. Thank you', NULL, '2026-01-09 12:14:01'),
(44, 'payment_received_email_subject', 'Payment Received', NULL, '2026-01-09 12:14:01'),
(45, 'payment_email_subject', 'Payment Receipt', NULL, '2026-01-09 12:14:01'),
(46, 'payment_email_template', 'Dear {borrowerFirstName}, find attached receipt of your payment of {paymentAmount} for loan {loanNumber} on {paymentDate}. New loan balance:{loanBalance}. Thank you', NULL, '2026-01-09 12:14:01'),
(47, 'borrower_statement_email_subject', 'Client Statement', NULL, '2026-01-09 12:14:01'),
(48, 'borrower_statement_email_template', 'Dear {borrowerFirstName}, find attached statement of your loans with us. Thank you', NULL, '2026-01-09 12:14:01'),
(49, 'loan_statement_email_subject', 'Loan Statement', NULL, '2026-01-09 12:14:01'),
(50, 'loan_statement_email_template', 'Dear {borrowerFirstName}, find attached loan statement for loan {loanNumber}. Thank you', NULL, '2026-01-09 12:14:01'),
(51, 'loan_schedule_email_subject', 'Loan Schedule', NULL, '2026-01-09 12:14:01'),
(52, 'loan_schedule_email_template', 'Dear {borrowerFirstName}, find attached loan schedule for loan {loanNumber}. Thank you', NULL, '2026-01-09 12:14:01'),
(53, 'cron_last_run', NULL, NULL, NULL),
(54, 'auto_apply_penalty', '1', NULL, '2026-01-09 12:14:01'),
(55, 'auto_payment_receipt_sms', '1', NULL, '2026-01-09 12:14:01'),
(56, 'auto_payment_receipt_email', '1', NULL, '2026-01-09 12:14:01'),
(57, 'auto_repayment_sms_reminder', '1', NULL, '2026-01-09 12:14:01'),
(58, 'auto_repayment_email_reminder', '1', NULL, '2026-01-09 12:14:01'),
(59, 'auto_repayment_days', '4', NULL, '2026-01-09 12:14:01'),
(60, 'auto_overdue_repayment_sms_reminder', '0', NULL, '2026-01-09 12:14:01'),
(61, 'auto_overdue_repayment_email_reminder', '1', NULL, '2026-01-09 12:14:01'),
(62, 'auto_overdue_repayment_days', '2', NULL, '2026-01-09 12:14:01'),
(63, 'auto_overdue_loan_sms_reminder', '0', NULL, '2026-01-09 12:14:01'),
(64, 'auto_overdue_loan_email_reminder', '1', NULL, '2026-01-09 12:14:01'),
(65, 'auto_overdue_loan_days', '2', NULL, '2026-01-09 12:14:01'),
(66, 'loan_overdue_email_subject', 'Loan Overdue', NULL, '2026-01-09 12:14:01'),
(67, 'loan_overdue_email_template', 'Dear {borrowerFirstName}, Your loan {loanNumber} is overdue. Please make your payment. Thank you', NULL, '2026-01-09 12:14:01'),
(68, 'loan_overdue_sms_template', 'Dear {borrowerFirstName}, Your loan {loanNumber} is overdue. Please make your payment. Thank you', NULL, '2026-01-09 12:14:01'),
(69, 'loan_payment_reminder_subject', 'Upcoming Payment Reminder', NULL, '2026-01-09 12:14:01'),
(70, 'loan_payment_reminder_email_template', 'Dear {borrowerFirstName},You have an upcoming payment of {paymentAmount} due on {paymentDate} for loan {loanNumber}. Please make your payment. Thank you', NULL, '2026-01-09 12:14:01'),
(71, 'loan_payment_reminder_sms_template', 'Dear {borrowerFirstName},You have an upcoming payment of {paymentAmount} due on {paymentDate} for loan {loanNumber}. Please make your payment. Thank you', NULL, '2026-01-09 12:14:01'),
(72, 'missed_payment_email_subject', 'Missed Payment', NULL, '2026-01-09 12:14:01'),
(73, 'missed_payment_email_template', 'Dear {borrowerFirstName},You missed  payment of {paymentAmount} which was due on {paymentDate} for loan {loanNumber}. Please make your payment. Thank you', NULL, '2026-01-09 12:14:01'),
(74, 'missed_payment_sms_template', 'Dear {borrowerFirstName},You missed  payment of {paymentAmount} which was due on {paymentDate} for loan {loanNumber}. Please make your payment. Thank you', NULL, '2026-01-09 12:14:01'),
(75, 'enable_cron', '1', NULL, '2026-01-09 12:14:01'),
(76, 'infobip_username', NULL, NULL, '2026-01-09 12:14:01'),
(77, 'infobip_password', NULL, NULL, '2026-01-09 12:14:01'),
(78, 'infobip_api_key', NULL, NULL, '2026-01-09 12:14:01'),
(79, 'infobip_baseurl', NULL, NULL, '2026-01-09 12:14:01'),
(80, 'welcome_note', 'Welcome to RichGreen Master\'s Investment Limited', NULL, '2026-01-09 12:14:01'),
(81, 'allow_self_registration', '1', NULL, '2026-01-09 12:14:01'),
(82, 'client_auto_activate_account', '1', NULL, '2026-01-09 12:14:01'),
(83, 'allow_client_login', '1', NULL, '2026-01-09 12:14:01'),
(84, 'client_request_guarantor', '1', NULL, '2026-01-09 12:14:01'),
(85, 'allow_client_apply', '1', NULL, '2026-01-09 12:14:01'),
(86, 'auto_post_savings_interest', '1', NULL, '2026-01-09 12:14:01'),
(87, 'enable_online_payment', '1', NULL, '2026-01-09 12:14:01'),
(88, 'payment_gateway', 'Flutterwave', NULL, '2026-01-09 12:14:01'),
(89, 'gateway_pub_key', 'FLWPUBK-7e29638573271bd98b7a8ff83c31a6c7-X', NULL, '2026-01-09 12:14:01'),
(90, 'gateway_secret_key', 'FLWSECK-48901f50145a4f75549013bdaf5c289f-189fe7889d9vt-X', NULL, '2026-01-09 12:14:01'),
(91, 'vtpass_income', '40469341', '2023-03-22 14:19:22', '2026-01-09 12:14:00'),
(92, 'giftbill_income', '40920905', '2023-03-22 14:19:22', '2026-01-09 12:14:00'),
(93, 'pos_charges', '50809927', '2023-03-29 14:54:59', '2026-01-09 12:14:00'),
(94, 'glcharges', '40857863', '2023-03-29 14:57:21', '2026-01-09 12:14:00'),
(95, 'transfer_charge', '6', '2023-05-02 11:57:39', '2026-01-09 12:14:00'),
(96, 'esusucharges', '2', '2023-05-02 11:57:39', '2026-01-09 12:14:00'),
(97, 'frmfeecharges', '3', '2023-05-02 11:57:39', '2026-01-09 12:14:00'),
(98, 'processcharges', '5', '2023-05-02 12:05:20', '2026-01-09 12:14:00'),
(99, 'monthlycharges', '4', '2023-05-02 12:05:20', '2026-01-09 12:14:00'),
(100, 'othercharges', '7', '2023-05-02 16:22:59', '2026-01-09 12:14:00'),
(101, 'othrchargesgl', '40973920', '2023-05-02 16:22:59', '2026-01-09 12:14:00'),
(102, 'monnifycharge', '10', NULL, '2026-01-09 12:14:00'),
(103, 'enable_2FA', '0', '2023-05-03 09:39:19', '2026-01-09 12:14:01'),
(104, 'moniepointgl', '10794478', '2023-05-03 09:39:19', '2026-01-09 12:14:00'),
(105, 'bankcharge', '10', '2023-05-03 10:13:03', '2026-01-09 12:14:00'),
(106, 'payoption', '3', '2023-05-04 08:55:36', '2026-01-09 12:14:01'),
(107, 'income_suspense', '40171757', '2023-05-06 11:59:51', '2026-01-09 12:14:00'),
(108, 'asset_suspense', '10163749', '2023-05-06 11:59:51', '2026-01-09 12:14:00'),
(109, 'liability_suspense', '20993529', '2023-05-06 11:59:51', '2026-01-09 12:14:00'),
(110, 'exps_suspense', '50180282', '2023-05-06 11:59:51', '2026-01-09 12:14:00'),
(111, 'capital_suspense', '30235195', '2023-05-06 11:59:51', '2026-01-09 12:14:00'),
(112, 'birthday_msg', 'Dear {name}, On this special day, your birthday, we at Asset Matrix MFB wish you a prosperous and successful year.', '2023-05-08 13:40:46', '2026-01-09 12:14:01'),
(113, 'deposit_limit', '1', '2023-05-22 13:05:50', '2026-01-09 12:14:01'),
(114, 'withdrawal_limit', '1', '2023-05-22 13:05:50', '2026-01-09 12:14:01'),
(115, 'company_code', '00653', '2023-06-08 09:41:48', '2026-01-09 12:14:00'),
(116, 'withholdingtax', '5', '2023-06-24 11:45:53', '2026-01-09 12:14:00'),
(117, 'fdcharge', '10', '2023-06-24 11:45:53', '2026-01-09 12:14:00'),
(118, 'fdliquid_interest', '40774946', '2023-06-24 16:24:27', '2026-01-09 12:14:00'),
(119, 'enable_virtual_ac', '1', '2023-06-24 16:24:27', '2026-01-09 12:14:00'),
(120, 'assetmtx', '10897866', '2023-07-10 19:02:59', '2026-01-09 12:14:00'),
(121, 'company_balance', '200', '2023-09-26 09:15:05', '2024-10-31 09:35:42'),
(122, 'inwardoption', '2', '2024-01-15 15:36:39', '2026-01-09 12:14:00'),
(123, 'bvnroute', '1', '2024-01-22 13:45:52', '2026-01-09 12:14:00'),
(124, 'enable_support_fee', '0', '2024-06-25 14:58:27', '2024-06-25 13:53:59'),
(125, 'support_fee', '0', '2024-06-25 14:58:27', '2024-06-25 13:53:59'),
(126, 'enable_auto_debit_loan_mandate', '0', '2024-11-15 16:37:21', '2024-11-15 16:37:21');

-- --------------------------------------------------------

--
-- Table structure for table `statuses`
--

CREATE TABLE `statuses` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `statuses`
--

INSERT INTO `statuses` (`id`, `name`, `created_at`, `updated_at`) VALUES
(1, 'Active', '2022-11-10 15:49:26', '2022-11-10 15:49:26'),
(2, 'Closed Account', '2022-11-10 15:49:26', '2022-11-10 15:49:26'),
(3, 'Complete', '2022-11-10 15:49:26', '2022-11-10 15:49:26'),
(4, 'Restricted', '2022-11-10 15:49:26', '2022-11-10 15:49:26'),
(5, 'Fraud Blocked', '2022-11-10 15:49:26', '2022-11-10 15:49:26'),
(6, 'Wrong Password Blocked', '2022-11-10 15:49:26', '2022-11-10 15:49:26'),
(7, 'Pending', '2022-11-10 15:49:26', '2022-11-10 15:49:26'),
(8, 'Dom Account', '2022-11-10 15:49:26', '2022-11-10 15:49:26'),
(9, 'Deleted', '2022-11-10 15:49:26', '2022-11-10 15:49:26'),
(10, 'Setup fee Payment', '2022-11-10 15:49:26', '2022-11-10 15:49:26'),
(11, 'Company Agreement', '2022-11-10 15:49:26', '2022-11-10 15:49:26');

-- --------------------------------------------------------

--
-- Table structure for table `subcription_logs`
--

CREATE TABLE `subcription_logs` (
  `id` bigint UNSIGNED NOT NULL,
  `subcription` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `amount_paid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `vat` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `total_paid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expense_account` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `credit_account` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `warning_date` date NOT NULL,
  `expiration_date` date NOT NULL,
  `payment_date` datetime NOT NULL,
  `note` text COLLATE utf8mb4_unicode_ci,
  `is_active` tinyint(1) NOT NULL DEFAULT '0',
  `branch_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `paymentref` varchar(225) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `subcription_logs`
--

INSERT INTO `subcription_logs` (`id`, `subcription`, `amount_paid`, `vat`, `total_paid`, `expense_account`, `credit_account`, `warning_date`, `expiration_date`, `payment_date`, `note`, `is_active`, `branch_id`, `paymentref`, `created_at`, `updated_at`) VALUES
(3, 'Monthly Subcription', '200', '7.5', '215', '50486638', '10923392', '2023-08-16', '2023-08-18', '2023-07-19 13:15:28', 'payment for monthly subcription package', 0, NULL, 'RX1_6416293', '2023-07-19 12:15:28', '2023-08-18 07:00:02'),
(4, 'Monthly Subcription', '1000', '7.5', '1075', '50486638', '10405410', '2023-09-14', '2023-09-16', '2023-08-17 18:07:25', 'payment for monthly subcription package', 0, NULL, 'RX1_1615194', '2023-08-17 18:07:25', '2023-09-16 07:00:03'),
(5, 'Monthly Subcription', '1000', '7.5', '1075', '50486638', '10424117', '2023-10-13', '2023-10-15', '2023-09-15 04:11:37', 'payment for monthly subcription package', 0, NULL, 'RX1_1455787', '2023-09-15 04:11:37', '2023-10-15 07:00:02'),
(6, 'Monthly Subcription', '1000', '7.5', '1075', '50486638', '10549120', '2023-11-13', '2023-11-15', '2023-10-16 09:34:23', 'payment for monthly subcription package', 0, NULL, 'RX1_1307694', '2023-10-16 09:34:23', '2023-11-15 07:00:02'),
(7, 'Monthly Subcription', '1000', '7.5', '1075', '50486638', '10549120', '2023-12-12', '2023-12-14', '2023-11-14 22:27:32', 'payment for monthly subcription package', 0, NULL, 'RX1_1572684', '2023-11-14 22:27:32', '2023-12-14 07:00:03'),
(8, 'Monthly Subcription', '1000', '7.5', '1075', '50486638', '10923392', '2024-01-11', '2024-01-13', '2023-12-14 03:00:25', 'payment for monthly subcription package', 0, NULL, 'RX1_1130934', '2023-12-14 03:00:25', '2024-01-13 07:00:02'),
(9, 'Monthly Subcription', '1000', '7.5', '1075', '50486638', '10405410', '2025-02-10', '2025-02-12', '2024-01-13 11:57:03', 'payment for monthly subcription package', 0, NULL, 'RX1_1139301', '2024-01-13 11:57:03', '2025-02-12 07:00:06'),
(10, 'Monthly Subcription', '1000', '7.5', '1075', '50486638', '10228259', '2025-03-12', '2025-03-14', '2025-02-12 09:58:19', 'payment for monthly subcription package', 0, NULL, 'RX1_1214482', '2025-02-12 09:58:19', '2025-03-14 07:00:07'),
(11, 'Bi-annual Subcription', '900', '7.5', '967', '50486638', '10987740', '2026-09-07', '2026-09-09', '2025-03-13 09:08:28', 'payment for bi-annual subcription package', 1, NULL, 'RX1_6634242', '2025-03-13 09:08:28', '2025-03-13 09:08:28');

-- --------------------------------------------------------

--
-- Table structure for table `subcription_plans`
--

CREATE TABLE `subcription_plans` (
  `id` bigint UNSIGNED NOT NULL,
  `package_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `duration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `price` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `vat` varchar(225) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `branch_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `subcription_plans`
--

INSERT INTO `subcription_plans` (`id`, `package_name`, `duration`, `price`, `vat`, `branch_id`, `created_at`, `updated_at`) VALUES
(1, 'Monthly Subcription', '30', '200', '7.5', NULL, '2023-06-14 12:57:28', '2025-02-28 03:38:23'),
(2, 'Quaterly Subcription', '90', '500', '7.5', NULL, '2023-06-14 13:00:10', '2025-02-28 03:38:03'),
(3, 'Bi-annual Subcription', '180', '900', '7.5', NULL, '2023-06-14 13:01:38', '2025-02-28 03:37:55'),
(4, 'Annual Subcription', '365', '1500', '7.5', NULL, '2023-06-14 13:02:21', '2025-02-28 03:37:41');

-- --------------------------------------------------------

--
-- Table structure for table `transaction_status`
--

CREATE TABLE `transaction_status` (
  `id` bigint NOT NULL,
  `status_type` varchar(225) COLLATE utf8mb4_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `transaction_status`
--

INSERT INTO `transaction_status` (`id`, `status_type`) VALUES
(1, 'deposit'),
(2, 'withdrawal'),
(3, 'reverse deposit'),
(4, 'reverse withdrawal'),
(5, 'fixed deposit charge'),
(6, 'monthly charge'),
(7, 'loan fees'),
(8, 'fixed deposit interest'),
(9, 'sms'),
(10, 'transfer charge'),
(11, 'withholding tax'),
(12, 'fixed deposit'),
(13, 'betting'),
(14, 'airtime Topup'),
(15, 'data subscription'),
(16, 'cable subcription'),
(17, 'electricity payment'),
(18, 'loan interest'),
(19, 'loan'),
(20, 'POS Cashout'),
(21, 'POS Bills Payment'),
(22, 'POS Funds Transfer'),
(23, 'POS Airtime Purchase'),
(24, 'POS Data Purchase'),
(25, 'POS Cable Subscription'),
(26, 'POS Bet Topup'),
(27, 'POS Electricity Purchase'),
(28, 'USSD Session Charge'),
(29, 'Whatsapp Session Charge');

-- --------------------------------------------------------

--
-- Table structure for table `upload_transaction_statuses`
--

CREATE TABLE `upload_transaction_statuses` (
  `id` bigint UNSIGNED NOT NULL,
  `branch_id` bigint UNSIGNED DEFAULT NULL,
  `customer_id` bigint UNSIGNED DEFAULT NULL,
  `general_ledger_id` bigint UNSIGNED DEFAULT NULL,
  `balance` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `amount` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `trx_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `gl_type` varchar(225) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `trx_date` date NOT NULL,
  `reason` text COLLATE utf8mb4_unicode_ci,
  `trx_status` tinyint(1) NOT NULL DEFAULT '0',
  `upload_status` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `upload_transaction_statuses`
--

INSERT INTO `upload_transaction_statuses` (`id`, `branch_id`, `customer_id`, `general_ledger_id`, `balance`, `amount`, `trx_type`, `gl_type`, `trx_date`, `reason`, `trx_status`, `upload_status`, `created_at`, `updated_at`) VALUES
(1, NULL, 663, 236, '261163538.39', '30000', 'debit', 'glc', '2025-03-25', 'awaiting approval', 1, 0, '2025-03-25 14:08:29', '2025-09-03 13:41:37'),
(2, NULL, 663, 236, '261168538.39', '30000', 'debit', 'glc', '2025-03-25', 'awaiting approval', 1, 0, '2025-03-25 14:12:10', '2025-09-03 13:41:37'),
(3, NULL, 663, 236, '261888538.39', '30000', 'debit', 'glc', '2025-03-25', 'awaiting approval', 1, 0, '2025-03-25 15:41:32', '2025-09-03 13:41:37'),
(4, NULL, 648, 251, '495001000', '30000000', 'debit', 'cgl', '2025-03-28', 'awaiting approval', 1, 1, '2025-03-28 13:10:53', '2025-03-28 13:10:53'),
(5, NULL, 648, 251, '495001000', '50000000', 'debit', 'cgl', '2025-03-28', 'awaiting approval', 1, 1, '2025-03-28 13:10:54', '2025-03-28 13:10:54');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint UNSIGNED NOT NULL,
  `first_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `username` varchar(225) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `gender` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` text COLLATE utf8mb4_unicode_ci,
  `phone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `city` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `role_id` bigint UNSIGNED DEFAULT NULL,
  `branch_id` bigint UNSIGNED DEFAULT NULL,
  `last_login` timestamp NULL DEFAULT NULL,
  `two_factor_code` varchar(225) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `two_factor_expire_at` datetime DEFAULT NULL,
  `is_2fa_enable` tinyint(1) DEFAULT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `account_type` varchar(225) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '0',
  `signature` varchar(225) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `first_name`, `last_name`, `username`, `email`, `gender`, `address`, `phone`, `city`, `notes`, `role_id`, `branch_id`, `last_login`, `two_factor_code`, `two_factor_expire_at`, `is_2fa_enable`, `email_verified_at`, `password`, `account_type`, `status`, `signature`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'system', 'admin', 'admin', 'henry@ggtconnect.com', 'male', '24 aja street ikeja', '080907462538', NULL, NULL, 1, 2, '2026-03-12 11:43:09', 'BUSFL32YQVCOYCYU', '2025-02-28 10:35:56', 1, NULL, '$2y$10$Zik5ZqcITCsgPVZSzhaatufcuQ6wb8gJW6vkUq2Jcm9JhMmtWCjiO', 'system', 1, NULL, NULL, '2022-11-17 07:28:17', '2026-03-12 11:43:09'),
(5, 'B', 'Lawal', 'Lawalappsrg', 'lawalcwd@gmail.com', 'male', '6 Roluga Street Soluyi Gbagada', '08037539600', NULL, NULL, 1, 2, '2025-10-21 13:54:29', '7KUOJ5IWXC4XHHDW', '2025-02-28 03:35:56', 1, NULL, '$2y$10$vvB9IKJXtvKTxIm0qlVNou186kVsQXJ5vxJN5fXd8da.TKw3VJjAW', 'system', 1, NULL, NULL, '2023-03-23 16:19:29', '2025-10-21 13:54:29'),
(7, 'Temitope', 'Oduseso', 'Temitope', 'topeoduseso@gmail.com', 'male', 'Lagos', '080', NULL, NULL, NULL, NULL, '2023-06-26 09:00:23', NULL, NULL, NULL, NULL, '$2y$10$Pd5DB9/1HIrbUziecmdFSOYXLssF820kZB6EorYWUNX/YVRL2dfuS', 'user', 0, NULL, NULL, '2023-05-01 19:04:50', '2023-09-15 04:02:42'),
(8, 'seun', 'olalani', 'seun', 'seunolalani@gmail.com', 'male', 'lagos ikeja', '09033992191', NULL, NULL, NULL, NULL, '2026-01-21 10:57:10', '6QIVIHXLBVACI44S', '2025-03-05 09:51:49', 1, NULL, '$2y$10$pWcrGy9R.fUxrESmdpa/NeIVds0.Yxs5a3D1QF5Qt2LAVMN5sKswC', 'system', 1, NULL, NULL, '2023-05-09 11:48:30', '2026-01-21 10:57:10');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `accountofficers`
--
ALTER TABLE `accountofficers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `account_categories`
--
ALTER TABLE `account_categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `account_types`
--
ALTER TABLE `account_types`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `assets`
--
ALTER TABLE `assets`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `asset_types`
--
ALTER TABLE `asset_types`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `asset_valuations`
--
ALTER TABLE `asset_valuations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `audittrails`
--
ALTER TABLE `audittrails`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `banks`
--
ALTER TABLE `banks`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `beneficiaries`
--
ALTER TABLE `beneficiaries`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `branches`
--
ALTER TABLE `branches`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `branch_users`
--
ALTER TABLE `branch_users`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `capitals`
--
ALTER TABLE `capitals`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `charges`
--
ALTER TABLE `charges`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `collaterals`
--
ALTER TABLE `collaterals`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `collateral_types`
--
ALTER TABLE `collateral_types`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `emails`
--
ALTER TABLE `emails`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `exchangerates`
--
ALTER TABLE `exchangerates`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `expenses`
--
ALTER TABLE `expenses`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `expense_types`
--
ALTER TABLE `expense_types`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `fixed_deposits`
--
ALTER TABLE `fixed_deposits`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `fixed_deposit_products`
--
ALTER TABLE `fixed_deposit_products`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `fxmgmts`
--
ALTER TABLE `fxmgmts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `general_ledgers`
--
ALTER TABLE `general_ledgers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `investment_schedules`
--
ALTER TABLE `investment_schedules`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `investmet_repayments`
--
ALTER TABLE `investmet_repayments`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `loans`
--
ALTER TABLE `loans`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `loan_comments`
--
ALTER TABLE `loan_comments`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `loan_fees`
--
ALTER TABLE `loan_fees`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `loan_fee_metas`
--
ALTER TABLE `loan_fee_metas`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `loan_products`
--
ALTER TABLE `loan_products`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `loan_repayments`
--
ALTER TABLE `loan_repayments`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `loan_schedules`
--
ALTER TABLE `loan_schedules`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `model_has_permissions`
--
ALTER TABLE `model_has_permissions`
  ADD PRIMARY KEY (`permission_id`,`model_id`,`model_type`),
  ADD KEY `model_has_permissions_model_id_model_type_index` (`model_id`,`model_type`);

--
-- Indexes for table `model_has_roles`
--
ALTER TABLE `model_has_roles`
  ADD PRIMARY KEY (`role_id`,`model_id`,`model_type`),
  ADD KEY `model_has_roles_model_id_model_type_index` (`model_id`,`model_type`);

--
-- Indexes for table `notification_payloads`
--
ALTER TABLE `notification_payloads`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `other_incomes`
--
ALTER TABLE `other_incomes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `other_income_types`
--
ALTER TABLE `other_income_types`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `outstanding_loans`
--
ALTER TABLE `outstanding_loans`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`);

--
-- Indexes for table `payment_structures`
--
ALTER TABLE `payment_structures`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `payrolls`
--
ALTER TABLE `payrolls`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `payroll_metas`
--
ALTER TABLE `payroll_metas`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `payroll_templates`
--
ALTER TABLE `payroll_templates`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `payslips`
--
ALTER TABLE `payslips`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `permissions_name_guard_name_unique` (`name`,`guard_name`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indexes for table `provision_rates`
--
ALTER TABLE `provision_rates`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `roles_name_guard_name_unique` (`name`,`guard_name`);

--
-- Indexes for table `role_has_permissions`
--
ALTER TABLE `role_has_permissions`
  ADD PRIMARY KEY (`permission_id`,`role_id`),
  ADD KEY `role_has_permissions_role_id_foreign` (`role_id`);

--
-- Indexes for table `role_users`
--
ALTER TABLE `role_users`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `savings`
--
ALTER TABLE `savings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `savings_products`
--
ALTER TABLE `savings_products`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `savings_transactions`
--
ALTER TABLE `savings_transactions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `savings_transaction_g_l_s`
--
ALTER TABLE `savings_transaction_g_l_s`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `saving_fees`
--
ALTER TABLE `saving_fees`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sectors`
--
ALTER TABLE `sectors`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `settings`
--
ALTER TABLE `settings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `statuses`
--
ALTER TABLE `statuses`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `subcription_logs`
--
ALTER TABLE `subcription_logs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `subcription_plans`
--
ALTER TABLE `subcription_plans`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `transaction_status`
--
ALTER TABLE `transaction_status`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `upload_transaction_statuses`
--
ALTER TABLE `upload_transaction_statuses`
  ADD PRIMARY KEY (`id`);

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
-- AUTO_INCREMENT for table `accountofficers`
--
ALTER TABLE `accountofficers`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `account_categories`
--
ALTER TABLE `account_categories`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=137;

--
-- AUTO_INCREMENT for table `account_types`
--
ALTER TABLE `account_types`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `assets`
--
ALTER TABLE `assets`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `asset_types`
--
ALTER TABLE `asset_types`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `asset_valuations`
--
ALTER TABLE `asset_valuations`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `audittrails`
--
ALTER TABLE `audittrails`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18225;

--
-- AUTO_INCREMENT for table `banks`
--
ALTER TABLE `banks`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=231;

--
-- AUTO_INCREMENT for table `beneficiaries`
--
ALTER TABLE `beneficiaries`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `branches`
--
ALTER TABLE `branches`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `branch_users`
--
ALTER TABLE `branch_users`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `capitals`
--
ALTER TABLE `capitals`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `charges`
--
ALTER TABLE `charges`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `collaterals`
--
ALTER TABLE `collaterals`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `collateral_types`
--
ALTER TABLE `collateral_types`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `customers`
--
ALTER TABLE `customers`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=898;

--
-- AUTO_INCREMENT for table `emails`
--
ALTER TABLE `emails`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=45;

--
-- AUTO_INCREMENT for table `exchangerates`
--
ALTER TABLE `exchangerates`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `expenses`
--
ALTER TABLE `expenses`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `expense_types`
--
ALTER TABLE `expense_types`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fixed_deposits`
--
ALTER TABLE `fixed_deposits`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1853;

--
-- AUTO_INCREMENT for table `fixed_deposit_products`
--
ALTER TABLE `fixed_deposit_products`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `fxmgmts`
--
ALTER TABLE `fxmgmts`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `general_ledgers`
--
ALTER TABLE `general_ledgers`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=615;

--
-- AUTO_INCREMENT for table `investment_schedules`
--
ALTER TABLE `investment_schedules`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6749;

--
-- AUTO_INCREMENT for table `investmet_repayments`
--
ALTER TABLE `investmet_repayments`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2088;

--
-- AUTO_INCREMENT for table `loans`
--
ALTER TABLE `loans`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=192;

--
-- AUTO_INCREMENT for table `loan_comments`
--
ALTER TABLE `loan_comments`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `loan_fees`
--
ALTER TABLE `loan_fees`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `loan_fee_metas`
--
ALTER TABLE `loan_fee_metas`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1049;

--
-- AUTO_INCREMENT for table `loan_products`
--
ALTER TABLE `loan_products`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `loan_repayments`
--
ALTER TABLE `loan_repayments`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=380;

--
-- AUTO_INCREMENT for table `loan_schedules`
--
ALTER TABLE `loan_schedules`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=644;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=67;

--
-- AUTO_INCREMENT for table `notification_payloads`
--
ALTER TABLE `notification_payloads`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `other_incomes`
--
ALTER TABLE `other_incomes`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `other_income_types`
--
ALTER TABLE `other_income_types`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `outstanding_loans`
--
ALTER TABLE `outstanding_loans`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=123;

--
-- AUTO_INCREMENT for table `payment_structures`
--
ALTER TABLE `payment_structures`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `payrolls`
--
ALTER TABLE `payrolls`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `payroll_metas`
--
ALTER TABLE `payroll_metas`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `payroll_templates`
--
ALTER TABLE `payroll_templates`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `payslips`
--
ALTER TABLE `payslips`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=186;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1044;

--
-- AUTO_INCREMENT for table `provision_rates`
--
ALTER TABLE `provision_rates`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `role_users`
--
ALTER TABLE `role_users`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `savings`
--
ALTER TABLE `savings`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=898;

--
-- AUTO_INCREMENT for table `savings_products`
--
ALTER TABLE `savings_products`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `savings_transactions`
--
ALTER TABLE `savings_transactions`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10425;

--
-- AUTO_INCREMENT for table `savings_transaction_g_l_s`
--
ALTER TABLE `savings_transaction_g_l_s`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30123;

--
-- AUTO_INCREMENT for table `saving_fees`
--
ALTER TABLE `saving_fees`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `sectors`
--
ALTER TABLE `sectors`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `settings`
--
ALTER TABLE `settings`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=127;

--
-- AUTO_INCREMENT for table `statuses`
--
ALTER TABLE `statuses`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `subcription_logs`
--
ALTER TABLE `subcription_logs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `subcription_plans`
--
ALTER TABLE `subcription_plans`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `transaction_status`
--
ALTER TABLE `transaction_status`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT for table `upload_transaction_statuses`
--
ALTER TABLE `upload_transaction_statuses`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=213;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `model_has_permissions`
--
ALTER TABLE `model_has_permissions`
  ADD CONSTRAINT `model_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `model_has_roles`
--
ALTER TABLE `model_has_roles`
  ADD CONSTRAINT `model_has_roles_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `role_has_permissions`
--
ALTER TABLE `role_has_permissions`
  ADD CONSTRAINT `role_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `role_has_permissions_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
