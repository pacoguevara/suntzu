-- phpMyAdmin SQL Dump
-- version 4.0.3
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Jul 21, 2014 at 09:59 PM
-- Server version: 5.6.19
-- PHP Version: 5.4.24

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `bticino_db`
--
CREATE DATABASE IF NOT EXISTS `bticino_db` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `bticino_db`;

-- --------------------------------------------------------

--
-- Table structure for table `db_version`
--

CREATE TABLE IF NOT EXISTS `db_version` (
  `db` varchar(10) NOT NULL,
  `version` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `db_version`
--

INSERT INTO `db_version` (`db`, `version`) VALUES
('data', 5);

-- --------------------------------------------------------

--
-- Table structure for table `device`
--

CREATE TABLE IF NOT EXISTS `device` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` int(11) NOT NULL,
  `serial` varchar(40) NOT NULL,
  `name` varchar(50) NOT NULL,
  `when` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=6 ;

--
-- Dumping data for table `device`
--

INSERT INTO `device` (`id`, `type`, `serial`, `name`, `when`) VALUES
(1, 2, '702442500', 'Dimmer', '2014-06-27 18:50:31'),
(2, 1, '702495401', 'Switch A', '2014-06-27 18:50:33'),
(3, 1, '702495402', 'Switch B', '2014-06-27 18:50:34'),
(5, 3, '702495401', 'Cocina', '2014-07-11 01:10:15');

-- --------------------------------------------------------

--
-- Table structure for table `device_scene`
--

CREATE TABLE IF NOT EXISTS `device_scene` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `device` int(11) NOT NULL,
  `scene` int(11) NOT NULL,
  `when` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `start` varchar(20) NOT NULL,
  `end` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=10 ;

--
-- Dumping data for table `device_scene`
--

INSERT INTO `device_scene` (`id`, `device`, `scene`, `when`, `start`, `end`) VALUES
(1, 1, 52, '2014-06-25 16:07:41', '*1*7*702442500#9##', '*1*0*702442500#9##'),
(2, 2, 52, '2014-06-25 16:18:21', '*1*3*702442500#9##', '*1*0*702442500#9##'),
(3, 1, 2, '2014-07-20 17:15:31', '*1*5*702442500#9##', '*1*0*702442500#9##'),
(4, 2, 2, '2014-07-20 17:15:38', '*1*1*702495401#9##', '*1*0*702495401#9##'),
(5, 3, 3, '2014-07-20 17:20:11', '*1*1*702495402#9##', '*1*0*702495402#9##'),
(6, 1, 8, '2014-07-20 20:44:42', '*1*4*702442500#9##', '*1*0*702442500#9##'),
(7, 2, 8, '2014-07-20 20:44:50', '*1*1*702495401#9##', '*1*0*702495401#9##'),
(8, 3, 8, '2014-07-20 20:44:54', '*1*1*702495402#9##', '*1*0*702495402#9##'),
(9, 5, 8, '2014-07-20 20:44:58', '*1*1*702495401#9##', '*1*0*702495401#9##');

-- --------------------------------------------------------

--
-- Table structure for table `device_type`
--

CREATE TABLE IF NOT EXISTS `device_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `description` varchar(40) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `device_type`
--

INSERT INTO `device_type` (`id`, `description`) VALUES
(1, 'Switch'),
(2, 'Dimmer'),
(3, 'Persianas');

-- --------------------------------------------------------

--
-- Table structure for table `floor`
--

CREATE TABLE IF NOT EXISTS `floor` (
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
-- Table structure for table `rol`
--

CREATE TABLE IF NOT EXISTS `rol` (
  `id` int(2) NOT NULL,
  `description` varchar(40) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `rol`
--

INSERT INTO `rol` (`id`, `description`) VALUES
(1, 'Usuario Final'),
(2, 'Integrador'),
(3, 'Cuenta Maestra');

-- --------------------------------------------------------

--
-- Table structure for table `scene`
--

CREATE TABLE IF NOT EXISTS `scene` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `floor` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `when` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `schedule` int(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `floorKey` (`floor`),
  KEY `scene_schedule` (`schedule`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=9 ;

--
-- Dumping data for table `scene`
--

INSERT INTO `scene` (`id`, `floor`, `name`, `when`, `schedule`) VALUES
(8, 1, 'De Noche', '2014-07-20 20:44:26', 22);

-- --------------------------------------------------------

--
-- Table structure for table `schedule`
--

CREATE TABLE IF NOT EXISTS `schedule` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `description` varchar(80) NOT NULL,
  `start` varchar(20) NOT NULL,
  `end` varchar(20) NOT NULL,
  `enabled` int(1) NOT NULL DEFAULT '1',
  `when` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `concurrent` varchar(10) DEFAULT NULL,
  `cronjobStart` varchar(50) DEFAULT NULL,
  `cronjobEnd` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=23 ;

--
-- Dumping data for table `schedule`
--

INSERT INTO `schedule` (`id`, `description`, `start`, `end`, `enabled`, `when`, `concurrent`, `cronjobStart`, `cronjobEnd`) VALUES
(0, 'Default', '00:00 XX', '00:00 XX', 0, '2014-06-12 17:06:13', NULL, NULL, NULL),
(22, 'En la escuela', '08:52', '18:52', 1, '2014-07-20 13:53:06', '1,3,5', '52 08 * * 1,3,5', '52 18 * * 1,3,5');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE IF NOT EXISTS `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `rol` int(11) NOT NULL,
  `name` varchar(40) NOT NULL,
  `last_name` varchar(40) NOT NULL,
  `username` varchar(40) NOT NULL,
  `password` varchar(40) NOT NULL,
  `email` varchar(40) NOT NULL,
  `when` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `rol`, `name`, `last_name`, `username`, `password`, `email`, `when`) VALUES
(1, 3, 'Eduardo', 'Ibarra', 'ed', '202cb962ac59075b964b07152d234b70', 'ibredu@gmail.com', '2014-07-05 00:02:22'),
(2, 1, 'Charlotte', 'Di Stefano', 'char', '202cb962ac59075b964b07152d234b70', 'char@char.com', '2014-07-05 01:47:48'),
(3, 2, 'Erik', 'Martínez', 'erik', '202cb962ac59075b964b07152d234b70', 'erik@gmail.com', '2014-07-05 20:34:16');

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
