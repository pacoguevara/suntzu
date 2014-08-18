CREATE TABLE IF NOT EXISTS `rol` (
  `id` int(2) NOT NULL,
  `description` varchar(40) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `rol` (`id`, `description`) VALUES
(1, 'Usuario Final'),
(2, 'Integrador'),
(3, 'Cuenta Maestra');

ALTER TABLE  `device` ADD  `type` INT NOT NULL AFTER  `id` ;

ALTER TABLE scene DROP FOREIGN KEY scene_schedule;

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