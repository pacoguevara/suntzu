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