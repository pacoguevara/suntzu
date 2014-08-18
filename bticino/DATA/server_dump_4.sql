-- phpMyAdmin SQL Dump
-- version 4.0.6
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Jun 13, 2014 at 07:39 PM
-- Server version: 5.5.33
-- PHP Version: 5.5.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `bticino_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `db_version`
--

CREATE TABLE `db_version` (
  `db` varchar(10) NOT NULL,
  `version` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `db_version`
--

INSERT INTO `db_version` (`db`, `version`) VALUES
('data', 1);

-- --------------------------------------------------------

--
-- Table structure for table `floor`
--

CREATE TABLE `floor` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(40) NOT NULL,
  `when` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `floor`
--

INSERT INTO `floor` (`id`, `name`, `when`) VALUES
(1, 'Planta baja', '2014-06-05 15:22:11'),
(2, 'Segundo Piso', '2014-06-05 15:22:11');

-- --------------------------------------------------------

--
-- Table structure for table `scene`
--

CREATE TABLE `scene` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `floor` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `when` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `schedule` int(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `floorKey` (`floor`),
  KEY `scene_schedule` (`schedule`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=35 ;

--
-- Dumping data for table `scene`
--

INSERT INTO `scene` (`id`, `floor`, `name`, `when`, `schedule`) VALUES
(31, 2, 'Hora de Dormir', '2014-06-12 17:10:55', 7),
(32, 1, 'Estamos de Vacaciones', '2014-06-12 17:11:13', 3),
(33, 1, 'En la noche', '2014-06-12 17:39:47', 9),
(34, 1, 'De día', '2014-06-12 23:00:36', 3);

-- --------------------------------------------------------

--
-- Table structure for table `schedule`
--

CREATE TABLE `schedule` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `description` varchar(80) NOT NULL,
  `start` varchar(20) NOT NULL,
  `end` varchar(20) NOT NULL,
  `mo` int(1) NOT NULL DEFAULT '0',
  `tu` int(1) NOT NULL DEFAULT '0',
  `th` int(1) NOT NULL DEFAULT '0',
  `we` int(1) NOT NULL DEFAULT '0',
  `fr` int(1) NOT NULL DEFAULT '0',
  `sa` int(1) NOT NULL DEFAULT '0',
  `su` int(1) NOT NULL DEFAULT '0',
  `enabled` int(1) NOT NULL DEFAULT '1',
  `when` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=10 ;

--
-- Dumping data for table `schedule`
--

INSERT INTO `schedule` (`id`, `description`, `start`, `end`, `mo`, `tu`, `th`, `we`, `fr`, `sa`, `su`, `enabled`, `when`) VALUES
(0, 'Default', '00:00 XX', '00:00 XX', 0, 0, 0, 0, 0, 0, 0, 0, '2014-06-12 17:06:13'),
(3, 'Vacaciones', '05:58 PM', '00:58 PM', 0, 0, 0, 0, 0, 0, 0, 1, '2014-06-11 22:58:12'),
(7, 'Trabajar', '07:47 PM', '07:47 PM', 0, 0, 0, 0, 0, 0, 0, 1, '2014-06-12 00:47:47'),
(9, 'Luces de Noche', '07:00 PM', '08:00 AM', 0, 0, 0, 0, 0, 0, 0, 1, '2014-06-12 17:39:33');

--
-- Constraints for dumped tables
--

--
-- Constraints for table `scene`
--
ALTER TABLE `scene`
  ADD CONSTRAINT `floorKey` FOREIGN KEY (`floor`) REFERENCES `floor` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `scene_schedule` FOREIGN KEY (`schedule`) REFERENCES `schedule` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
