CREATE TABLE `device` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `serial` varchar(40) NOT NULL,
  `name` varchar(50) NOT NULL,
  `when` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;
UPDATE db_version SET version = 5 WHERE db="data";