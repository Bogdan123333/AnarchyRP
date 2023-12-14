-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 14, 2023 at 06:49 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `anarchy`
--
CREATE DATABASE IF NOT EXISTS `anarchy` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `anarchy`;

-- --------------------------------------------------------

--
-- Table structure for table `housing`
--

CREATE TABLE `housing` (
  `test` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `showroom_stock`
--

CREATE TABLE `showroom_stock` (
  `vehicleSpawnCode` longtext NOT NULL,
  `vehicleName` longtext NOT NULL,
  `stock` int(11) NOT NULL DEFAULT 0,
  `type` longtext NOT NULL DEFAULT 'car'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `showroom_stock`
--

INSERT INTO `showroom_stock` (`vehicleSpawnCode`, `vehicleName`, `stock`, `type`) VALUES
('17m760i', 'BMW M760i', 0, 'car'),
('c63s', 'Mercedes C63SAMG', 0, 'car'),
('gcmx3m2022', 'BMW X3M', 0, 'car'),
('18macan', 'Porsche Macan Turbo', 0, 'car'),
('ast', 'Aston Martin Vanquish', 0, 'car'),
('918', 'Porsche 918 Spider', 0, 'car'),
('rs7', 'Audi RS7', 0, 'car'),
('bmwx7', 'BMW X750i', 0, 'car'),
('911t4s2', 'Porsche 911 Targa 4S', 0, 'car'),
('gt17', 'Ford GT', 0, 'car'),
('audirs6tk', 'Audi RS6', 0, 'car'),
('745le', 'BMW 745le', 0, 'car'),
('rmodrs6', 'Audi RS6 2021', 0, 'car'),
('r820', 'Audi R8', 0, 'car'),
('rs7c8', 'Audi RS7 SportBack', 0, 'car'),
('youga3', 'Duba Youga', 0, 'car'),
('rumpo3', 'Duba Rumpo', 0, 'car'),
('manchez2', 'Manchez', 0, 'car'),
('trophytruck', 'Trophy Truck', 0, 'car'),
('squaddie', 'Duba Squaddie', 0, 'car'),
('surfer2', 'Duba Surfer', 0, 'car'),
('hellion', 'Hellion', 0, 'car'),
('cheburek', 'Cheburek', 0, 'car'),
('a8audi', 'Audi A8 2005', 0, 'car'),
('sanderos2', 'Dacia Sandero Stepway', 0, 'car'),
('benzc32', 'Mercedes-Benz C32', 0, 'car'),
('sandero', 'Dacia Sandero', 0, 'car'),
('850csi', 'BMW 850csi', 0, 'car'),
('m5e28', 'BMW M5e28', 0, 'car'),
('w210amg', 'Mercedes-Benz E55', 0, 'car'),
('b5s4', 'Audi S4', 0, 'car'),
('c5rs6', 'Audi A6 2003', 0, 'car'),
('20r1', 'Yamaha R1-2020', 0, 'car'),
('tmsm', 'TMF450', 0, 'car'),
('h2carb', 'Kawasaki H2', 0, 'car'),
('foxharley1', 'Harley-Davidson SoftAil', 0, 'car'),
('bmws', 'BMW S1000RR', 0, 'car'),
('rsv4', 'Aprilia RSV4', 0, 'car'),
('diavel', 'Ducati Diavel', 0, 'car'),
('bros60', 'Honda Bros', 0, 'car'),
('bugatti', 'Bugatti Veyron', 0, 'car'),
('wycalt', 'Bugatti Atlantic', 0, 'car'),
('ben17', 'Bentley SuperSport', 0, 'car'),
('rmodbacalar', 'Bentley Continental', 0, 'car'),
('divo', 'Bugatti Divo', 0, 'car'),
('bug300ss', 'Bugatti SuperSport 300', 0, 'car'),
('youga2', 'Youga', 0, 'car'),
('nspeedo', 'Duba Speedo', 0, 'car'),
('Squalo', 'Squalo', 0, 'boats'),
('Seashark', 'SkyJey', 0, 'boats'),
('tug', 'Vapor Transport', 0, 'boats'),
('Speeder', 'Speeder Lux', 0, 'boats'),
('submersible', 'Submarin Kraken', 0, 'boats'),
('Dinghy', 'Gonflabila', 0, 'boats'),
('jetmax', 'JetMax', 0, 'boats'),
('toro', 'Lampadati Toro Lux', 0, 'boats'),
('Tropic', 'Tropic', 0, 'boats'),
('submersible2', 'Submarin Submersible', 0, 'boats'),
('maverick', 'Maverick', 0, 'airplane'),
('volatus', 'Volatus', 0, 'airplane'),
('frogger', 'Frogger', 0, 'airplane'),
('supervolito2', 'Supervolito', 0, 'airplane');

-- --------------------------------------------------------

--
-- Table structure for table `stocks`
--

CREATE TABLE `stocks` (
  `model` longtext DEFAULT NULL,
  `stock` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `stocks`
--

INSERT INTO `stocks` (`model`, `stock`) VALUES
('Imola', 0),
('rmodjesko', 0),
('rmodbolide', 0),
('supersport', 0),
('rmodbugatti', 0),
('rmodchiron300', 0),
('rmodmk7', 0),
('vwt6przemo', 0),
('saveirosurf', 0),
('jettagli', 0),
('c63hr', 0),
('evcs850', 0),
('rmodc63amg', 0),
('rmodg65', 0),
('mayg900', 0),
('gronos6x6', 0),
('12cls63', 0),
('19sclass', 0),
('190e', 0),
('rmodbiposto', 0),
('arch', 0),
('19msctntgt', 0),
('tesroad20', 0),
('cullinan', 0),
('waldphantom', 0),
('mcullinan', 0),
('dawnonyx', 0),
('rmodcharger69', 0),
('rmodzl1', 0),
('laferrari17', 0),
('alphard', 0),
('bentaygaplsd', 0),
('bmw8mm', 0),
('dtdmansq60', 0),
('ocnetrongt', 0),
('G632019', 0),
('bcps', 0),
('812mnsry', 0),
('impronta4', 0),
('488', 0),
('rmodf12tdf', 0),
('audia9', 0),
('rmodrs7', 0),
('RS6abtp', 0),
('rs7c8wb', 0),
('s8d4', 0),
('g700brabusretuned', 0),
('ford31weaver', 0),
('bmwg07', 0),
('alpinab7', 0),
('bmwx6mham', 0),
('g20wide', 0),
('m2', 0),
('m6e24', 0),
('rmodbmwm8', 0),
('rmodmi8lb', 0),
('acz4', 0),
('22m5', 0),
('745le', 0),
('rmodsian', 0),
('venatus', 0),
('huracanp', 0),
('beetleRWB', 0),
('zoeesport', 0),
('1500ghoul', 0),
('knightxv', 0),
('rmodjeep', 0),
('ateamvan', 0),
('cayennecoupegts', 0),
('pts21', 0),
('rmodporsche918', 0),
('macanpd600m', 0),
('rmodskyline34', 0),
('rmodz350pandem', 0);

-- --------------------------------------------------------

--
-- Table structure for table `vrp_arme`
--

CREATE TABLE `vrp_arme` (
  `user_id` int(11) NOT NULL,
  `clasa` varchar(100) DEFAULT NULL,
  `weapon` varchar(100) DEFAULT NULL,
  `gloante` int(11) DEFAULT NULL,
  `hash` varchar(100) NOT NULL,
  `componente` longtext DEFAULT NULL,
  `inventar` int(11) NOT NULL DEFAULT 0,
  `poateSaVanda` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `vrp_srv_data`
--

CREATE TABLE `vrp_srv_data` (
  `dkey` varchar(255) NOT NULL DEFAULT '',
  `dvalue` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `vrp_srv_data`
--

INSERT INTO `vrp_srv_data` (`dkey`, `dvalue`) VALUES
('vRP:hidden_trs', '{\"lsd bar\":{\"position\":[1992.5993652344,3044.1806640625,47.215068817139],\"timestamp\":1702573698},\"cocaine dealer\":{\"position\":[-631.00543212891,-229.42568969727,38.057052612305],\"timestamp\":1702573698},\"police2\":{\"position\":[1851.6605224609,3690.6713867188,34.267044067383],\"timestamp\":1702573698},\"police1\":{\"position\":[439.57083129883,-995.072265625,30.689596176147],\"timestamp\":1702573698},\"police3\":{\"position\":[-449.43395996094,6010.796875,31.716377258301],\"timestamp\":1702573698},\"ems\":{\"position\":[465.04064941406,3569.1174316406,33.238555908203],\"timestamp\":1702573698}}');

-- --------------------------------------------------------

--
-- Table structure for table `vrp_users`
--

CREATE TABLE `vrp_users` (
  `id` int(11) NOT NULL,
  `whitelisted` tinyint(1) DEFAULT NULL,
  `banned` tinyint(1) DEFAULT 0,
  `bannedTemp` int(255) DEFAULT 0,
  `bannedBy` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bannedReason` text DEFAULT NULL,
  `BanTempZile` int(255) NOT NULL DEFAULT 0,
  `BanTempData` varchar(255) DEFAULT NULL,
  `BanTempExpire` varchar(255) DEFAULT NULL,
  `adminLvl` int(11) NOT NULL DEFAULT 0,
  `aJailTime` int(255) NOT NULL DEFAULT 0,
  `aJailReason` text DEFAULT NULL,
  `faction` text NOT NULL DEFAULT 'user',
  `isFactionLeader` int(255) NOT NULL DEFAULT 0,
  `isFactionCoLeader` int(255) NOT NULL DEFAULT 0,
  `factionRank` text NOT NULL,
  `bankMoney` int(255) NOT NULL DEFAULT 9000000,
  `walletMoney` int(255) NOT NULL DEFAULT 1000000,
  `donationCoins` int(255) NOT NULL DEFAULT 0,
  `Giftpoints` int(255) NOT NULL DEFAULT 0,
  `hoursPlayed` float NOT NULL DEFAULT 0,
  `age` int(11) NOT NULL DEFAULT 18,
  `firstName` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT 'Nume',
  `secondName` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT 'Prenume',
  `finalSansa` int(11) NOT NULL DEFAULT 0,
  `raport` int(11) NOT NULL DEFAULT 0,
  `skin` longtext NOT NULL DEFAULT '',
  `job` varchar(100) NOT NULL DEFAULT 'Somer',
  `phone_number` varchar(10) DEFAULT NULL,
  `data` varchar(255) DEFAULT NULL,
  `phone` varchar(100) DEFAULT NULL,
  `username` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_login` varchar(100) DEFAULT NULL,
  `bantime` varchar(100) NOT NULL DEFAULT '',
  `banreason` varchar(100) NOT NULL DEFAULT '',
  `banadmin` varchar(100) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `vrp_user_business`
--

CREATE TABLE `vrp_user_business` (
  `user_id` int(11) NOT NULL,
  `name` varchar(30) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `capital` int(11) DEFAULT NULL,
  `laundered` int(11) DEFAULT NULL,
  `reset_timestamp` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `vrp_user_data`
--

CREATE TABLE `vrp_user_data` (
  `user_id` int(11) NOT NULL,
  `dkey` varchar(255) NOT NULL,
  `dvalue` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `vrp_user_homes`
--

CREATE TABLE `vrp_user_homes` (
  `user_id` int(11) NOT NULL DEFAULT 0,
  `home` varchar(255) NOT NULL,
  `number` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `vrp_user_identities`
--

CREATE TABLE `vrp_user_identities` (
  `user_id` int(11) NOT NULL,
  `registration` varchar(100) DEFAULT NULL,
  `phone` varchar(100) DEFAULT NULL,
  `firstname` varchar(100) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `age` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `vrp_user_ids`
--

CREATE TABLE `vrp_user_ids` (
  `id` int(255) NOT NULL,
  `identifier` varchar(255) NOT NULL DEFAULT '',
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `vrp_user_moneys`
--

CREATE TABLE `vrp_user_moneys` (
  `user_id` int(11) NOT NULL,
  `wallet` int(11) DEFAULT NULL,
  `bank` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `vrp_user_tokens`
--

CREATE TABLE `vrp_user_tokens` (
  `token` varchar(200) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `banned` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `vrp_user_vehicles`
--

CREATE TABLE `vrp_user_vehicles` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `vehicle` varchar(255) NOT NULL DEFAULT '',
  `veh_type` varchar(255) NOT NULL DEFAULT 'car',
  `garage` text NOT NULL,
  `gSlot` int(255) NOT NULL DEFAULT 1,
  `vehicle_plate` varchar(50) NOT NULL,
  `impounded` int(255) NOT NULL DEFAULT 0,
  `modifications` mediumtext DEFAULT NULL,
  `rented` tinyint(1) NOT NULL DEFAULT 0,
  `rentedid` varchar(200) NOT NULL DEFAULT '',
  `rentedtime` varchar(2048) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `vrp_warnings`
--

CREATE TABLE `vrp_warnings` (
  `warning_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `warning_type` varchar(25) DEFAULT NULL,
  `duration` int(11) DEFAULT NULL,
  `admin` varchar(100) DEFAULT NULL,
  `warning_date` date DEFAULT NULL,
  `reason` varchar(2000) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `vrp_srv_data`
--
ALTER TABLE `vrp_srv_data`
  ADD PRIMARY KEY (`dkey`);

--
-- Indexes for table `vrp_users`
--
ALTER TABLE `vrp_users`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `vrp_user_business`
--
ALTER TABLE `vrp_user_business`
  ADD PRIMARY KEY (`user_id`);

--
-- Indexes for table `vrp_user_data`
--
ALTER TABLE `vrp_user_data`
  ADD PRIMARY KEY (`user_id`,`dkey`);

--
-- Indexes for table `vrp_user_homes`
--
ALTER TABLE `vrp_user_homes`
  ADD PRIMARY KEY (`user_id`);

--
-- Indexes for table `vrp_user_ids`
--
ALTER TABLE `vrp_user_ids`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id_2` (`id`),
  ADD KEY `fk_user_ids_users` (`user_id`),
  ADD KEY `id` (`id`),
  ADD KEY `identifier` (`identifier`);

--
-- Indexes for table `vrp_user_moneys`
--
ALTER TABLE `vrp_user_moneys`
  ADD PRIMARY KEY (`user_id`);

--
-- Indexes for table `vrp_user_tokens`
--
ALTER TABLE `vrp_user_tokens`
  ADD PRIMARY KEY (`token`);

--
-- Indexes for table `vrp_user_vehicles`
--
ALTER TABLE `vrp_user_vehicles`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `vrp_warnings`
--
ALTER TABLE `vrp_warnings`
  ADD PRIMARY KEY (`warning_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `vrp_users`
--
ALTER TABLE `vrp_users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `vrp_user_ids`
--
ALTER TABLE `vrp_user_ids`
  MODIFY `id` int(255) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `vrp_user_vehicles`
--
ALTER TABLE `vrp_user_vehicles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `vrp_warnings`
--
ALTER TABLE `vrp_warnings`
  MODIFY `warning_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `vrp_user_business`
--
ALTER TABLE `vrp_user_business`
  ADD CONSTRAINT `fk_user_business_users` FOREIGN KEY (`user_id`) REFERENCES `vrp_users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `vrp_user_moneys`
--
ALTER TABLE `vrp_user_moneys`
  ADD CONSTRAINT `fk_user_moneys_users` FOREIGN KEY (`user_id`) REFERENCES `vrp_users` (`id`) ON DELETE CASCADE;
--
-- Database: `phpmyadmin`
--
CREATE DATABASE IF NOT EXISTS `phpmyadmin` DEFAULT CHARACTER SET utf8 COLLATE utf8_bin;
USE `phpmyadmin`;

-- --------------------------------------------------------

--
-- Table structure for table `pma__bookmark`
--

CREATE TABLE `pma__bookmark` (
  `id` int(10) UNSIGNED NOT NULL,
  `dbase` varchar(255) NOT NULL DEFAULT '',
  `user` varchar(255) NOT NULL DEFAULT '',
  `label` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `query` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Bookmarks';

-- --------------------------------------------------------

--
-- Table structure for table `pma__central_columns`
--

CREATE TABLE `pma__central_columns` (
  `db_name` varchar(64) NOT NULL,
  `col_name` varchar(64) NOT NULL,
  `col_type` varchar(64) NOT NULL,
  `col_length` text DEFAULT NULL,
  `col_collation` varchar(64) NOT NULL,
  `col_isNull` tinyint(1) NOT NULL,
  `col_extra` varchar(255) DEFAULT '',
  `col_default` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Central list of columns';

-- --------------------------------------------------------

--
-- Table structure for table `pma__column_info`
--

CREATE TABLE `pma__column_info` (
  `id` int(5) UNSIGNED NOT NULL,
  `db_name` varchar(64) NOT NULL DEFAULT '',
  `table_name` varchar(64) NOT NULL DEFAULT '',
  `column_name` varchar(64) NOT NULL DEFAULT '',
  `comment` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `mimetype` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `transformation` varchar(255) NOT NULL DEFAULT '',
  `transformation_options` varchar(255) NOT NULL DEFAULT '',
  `input_transformation` varchar(255) NOT NULL DEFAULT '',
  `input_transformation_options` varchar(255) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Column information for phpMyAdmin';

-- --------------------------------------------------------

--
-- Table structure for table `pma__designer_settings`
--

CREATE TABLE `pma__designer_settings` (
  `username` varchar(64) NOT NULL,
  `settings_data` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Settings related to Designer';

-- --------------------------------------------------------

--
-- Table structure for table `pma__export_templates`
--

CREATE TABLE `pma__export_templates` (
  `id` int(5) UNSIGNED NOT NULL,
  `username` varchar(64) NOT NULL,
  `export_type` varchar(10) NOT NULL,
  `template_name` varchar(64) NOT NULL,
  `template_data` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Saved export templates';

-- --------------------------------------------------------

--
-- Table structure for table `pma__favorite`
--

CREATE TABLE `pma__favorite` (
  `username` varchar(64) NOT NULL,
  `tables` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Favorite tables';

-- --------------------------------------------------------

--
-- Table structure for table `pma__history`
--

CREATE TABLE `pma__history` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `username` varchar(64) NOT NULL DEFAULT '',
  `db` varchar(64) NOT NULL DEFAULT '',
  `table` varchar(64) NOT NULL DEFAULT '',
  `timevalue` timestamp NOT NULL DEFAULT current_timestamp(),
  `sqlquery` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='SQL history for phpMyAdmin';

-- --------------------------------------------------------

--
-- Table structure for table `pma__navigationhiding`
--

CREATE TABLE `pma__navigationhiding` (
  `username` varchar(64) NOT NULL,
  `item_name` varchar(64) NOT NULL,
  `item_type` varchar(64) NOT NULL,
  `db_name` varchar(64) NOT NULL,
  `table_name` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Hidden items of navigation tree';

-- --------------------------------------------------------

--
-- Table structure for table `pma__pdf_pages`
--

CREATE TABLE `pma__pdf_pages` (
  `db_name` varchar(64) NOT NULL DEFAULT '',
  `page_nr` int(10) UNSIGNED NOT NULL,
  `page_descr` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='PDF relation pages for phpMyAdmin';

-- --------------------------------------------------------

--
-- Table structure for table `pma__recent`
--

CREATE TABLE `pma__recent` (
  `username` varchar(64) NOT NULL,
  `tables` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Recently accessed tables';

--
-- Dumping data for table `pma__recent`
--

INSERT INTO `pma__recent` (`username`, `tables`) VALUES
('root', '[{\"db\":\"anarchy\",\"table\":\"showroom_stock\"},{\"db\":\"anarchy\",\"table\":\"housing\"},{\"db\":\"anarchy\",\"table\":\"stocks\"}]');

-- --------------------------------------------------------

--
-- Table structure for table `pma__relation`
--

CREATE TABLE `pma__relation` (
  `master_db` varchar(64) NOT NULL DEFAULT '',
  `master_table` varchar(64) NOT NULL DEFAULT '',
  `master_field` varchar(64) NOT NULL DEFAULT '',
  `foreign_db` varchar(64) NOT NULL DEFAULT '',
  `foreign_table` varchar(64) NOT NULL DEFAULT '',
  `foreign_field` varchar(64) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Relation table';

-- --------------------------------------------------------

--
-- Table structure for table `pma__savedsearches`
--

CREATE TABLE `pma__savedsearches` (
  `id` int(5) UNSIGNED NOT NULL,
  `username` varchar(64) NOT NULL DEFAULT '',
  `db_name` varchar(64) NOT NULL DEFAULT '',
  `search_name` varchar(64) NOT NULL DEFAULT '',
  `search_data` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Saved searches';

-- --------------------------------------------------------

--
-- Table structure for table `pma__table_coords`
--

CREATE TABLE `pma__table_coords` (
  `db_name` varchar(64) NOT NULL DEFAULT '',
  `table_name` varchar(64) NOT NULL DEFAULT '',
  `pdf_page_number` int(11) NOT NULL DEFAULT 0,
  `x` float UNSIGNED NOT NULL DEFAULT 0,
  `y` float UNSIGNED NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Table coordinates for phpMyAdmin PDF output';

-- --------------------------------------------------------

--
-- Table structure for table `pma__table_info`
--

CREATE TABLE `pma__table_info` (
  `db_name` varchar(64) NOT NULL DEFAULT '',
  `table_name` varchar(64) NOT NULL DEFAULT '',
  `display_field` varchar(64) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Table information for phpMyAdmin';

-- --------------------------------------------------------

--
-- Table structure for table `pma__table_uiprefs`
--

CREATE TABLE `pma__table_uiprefs` (
  `username` varchar(64) NOT NULL,
  `db_name` varchar(64) NOT NULL,
  `table_name` varchar(64) NOT NULL,
  `prefs` text NOT NULL,
  `last_update` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Tables'' UI preferences';

-- --------------------------------------------------------

--
-- Table structure for table `pma__tracking`
--

CREATE TABLE `pma__tracking` (
  `db_name` varchar(64) NOT NULL,
  `table_name` varchar(64) NOT NULL,
  `version` int(10) UNSIGNED NOT NULL,
  `date_created` datetime NOT NULL,
  `date_updated` datetime NOT NULL,
  `schema_snapshot` text NOT NULL,
  `schema_sql` text DEFAULT NULL,
  `data_sql` longtext DEFAULT NULL,
  `tracking` set('UPDATE','REPLACE','INSERT','DELETE','TRUNCATE','CREATE DATABASE','ALTER DATABASE','DROP DATABASE','CREATE TABLE','ALTER TABLE','RENAME TABLE','DROP TABLE','CREATE INDEX','DROP INDEX','CREATE VIEW','ALTER VIEW','DROP VIEW') DEFAULT NULL,
  `tracking_active` int(1) UNSIGNED NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Database changes tracking for phpMyAdmin';

-- --------------------------------------------------------

--
-- Table structure for table `pma__userconfig`
--

CREATE TABLE `pma__userconfig` (
  `username` varchar(64) NOT NULL,
  `timevalue` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `config_data` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='User preferences storage for phpMyAdmin';

--
-- Dumping data for table `pma__userconfig`
--

INSERT INTO `pma__userconfig` (`username`, `timevalue`, `config_data`) VALUES
('root', '2023-12-14 17:49:45', '{\"Console\\/Mode\":\"collapse\"}');

-- --------------------------------------------------------

--
-- Table structure for table `pma__usergroups`
--

CREATE TABLE `pma__usergroups` (
  `usergroup` varchar(64) NOT NULL,
  `tab` varchar(64) NOT NULL,
  `allowed` enum('Y','N') NOT NULL DEFAULT 'N'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='User groups with configured menu items';

-- --------------------------------------------------------

--
-- Table structure for table `pma__users`
--

CREATE TABLE `pma__users` (
  `username` varchar(64) NOT NULL,
  `usergroup` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Users and their assignments to user groups';

--
-- Indexes for dumped tables
--

--
-- Indexes for table `pma__bookmark`
--
ALTER TABLE `pma__bookmark`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `pma__central_columns`
--
ALTER TABLE `pma__central_columns`
  ADD PRIMARY KEY (`db_name`,`col_name`);

--
-- Indexes for table `pma__column_info`
--
ALTER TABLE `pma__column_info`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `db_name` (`db_name`,`table_name`,`column_name`);

--
-- Indexes for table `pma__designer_settings`
--
ALTER TABLE `pma__designer_settings`
  ADD PRIMARY KEY (`username`);

--
-- Indexes for table `pma__export_templates`
--
ALTER TABLE `pma__export_templates`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `u_user_type_template` (`username`,`export_type`,`template_name`);

--
-- Indexes for table `pma__favorite`
--
ALTER TABLE `pma__favorite`
  ADD PRIMARY KEY (`username`);

--
-- Indexes for table `pma__history`
--
ALTER TABLE `pma__history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `username` (`username`,`db`,`table`,`timevalue`);

--
-- Indexes for table `pma__navigationhiding`
--
ALTER TABLE `pma__navigationhiding`
  ADD PRIMARY KEY (`username`,`item_name`,`item_type`,`db_name`,`table_name`);

--
-- Indexes for table `pma__pdf_pages`
--
ALTER TABLE `pma__pdf_pages`
  ADD PRIMARY KEY (`page_nr`),
  ADD KEY `db_name` (`db_name`);

--
-- Indexes for table `pma__recent`
--
ALTER TABLE `pma__recent`
  ADD PRIMARY KEY (`username`);

--
-- Indexes for table `pma__relation`
--
ALTER TABLE `pma__relation`
  ADD PRIMARY KEY (`master_db`,`master_table`,`master_field`),
  ADD KEY `foreign_field` (`foreign_db`,`foreign_table`);

--
-- Indexes for table `pma__savedsearches`
--
ALTER TABLE `pma__savedsearches`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `u_savedsearches_username_dbname` (`username`,`db_name`,`search_name`);

--
-- Indexes for table `pma__table_coords`
--
ALTER TABLE `pma__table_coords`
  ADD PRIMARY KEY (`db_name`,`table_name`,`pdf_page_number`);

--
-- Indexes for table `pma__table_info`
--
ALTER TABLE `pma__table_info`
  ADD PRIMARY KEY (`db_name`,`table_name`);

--
-- Indexes for table `pma__table_uiprefs`
--
ALTER TABLE `pma__table_uiprefs`
  ADD PRIMARY KEY (`username`,`db_name`,`table_name`);

--
-- Indexes for table `pma__tracking`
--
ALTER TABLE `pma__tracking`
  ADD PRIMARY KEY (`db_name`,`table_name`,`version`);

--
-- Indexes for table `pma__userconfig`
--
ALTER TABLE `pma__userconfig`
  ADD PRIMARY KEY (`username`);

--
-- Indexes for table `pma__usergroups`
--
ALTER TABLE `pma__usergroups`
  ADD PRIMARY KEY (`usergroup`,`tab`,`allowed`);

--
-- Indexes for table `pma__users`
--
ALTER TABLE `pma__users`
  ADD PRIMARY KEY (`username`,`usergroup`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `pma__bookmark`
--
ALTER TABLE `pma__bookmark`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pma__column_info`
--
ALTER TABLE `pma__column_info`
  MODIFY `id` int(5) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pma__export_templates`
--
ALTER TABLE `pma__export_templates`
  MODIFY `id` int(5) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pma__history`
--
ALTER TABLE `pma__history`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pma__pdf_pages`
--
ALTER TABLE `pma__pdf_pages`
  MODIFY `page_nr` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pma__savedsearches`
--
ALTER TABLE `pma__savedsearches`
  MODIFY `id` int(5) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- Database: `test`
--
CREATE DATABASE IF NOT EXISTS `test` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `test`;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
