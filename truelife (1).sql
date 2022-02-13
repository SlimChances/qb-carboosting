-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 13, 2022 at 09:49 AM
-- Server version: 10.4.22-MariaDB
-- PHP Version: 8.0.13

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `truelife`
--

-- --------------------------------------------------------

--
-- Table structure for table `boosting`
--

CREATE TABLE `boosting` (
  `#` int(11) NOT NULL,
  `citizenid` varchar(255) NOT NULL,
  `BNE` text NOT NULL DEFAULT '0',
  `background` varchar(255) DEFAULT NULL,
  `vin` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `boosting`
--


-- --------------------------------------------------------

--
-- Table structure for table `boost_queue`
--

CREATE TABLE `boost_queue` (
  `identifier` varchar(60) NOT NULL,
  `pSrc` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
ALTER TABLE `boosting`
  ADD PRIMARY KEY (`#`),
  ADD KEY `citizenid` (`citizenid`);

--
-- Indexes for table `boost_queue`
--
ALTER TABLE `boost_queue`
  ADD PRIMARY KEY (`identifier`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `boosting`
--
ALTER TABLE `boosting`
  MODIFY `#` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
