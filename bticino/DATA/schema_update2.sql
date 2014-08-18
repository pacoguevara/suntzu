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
INSERT INTO `scene` (`id`, `floor`, `name`, `when`, `schedule`) VALUES
(31, 2, 'Hora de Dormir', '2014-06-12 17:10:55', 7),
(32, 1, 'Estamos de Vacaciones', '2014-06-12 17:11:13', 3),
(33, 1, 'En la noche', '2014-06-12 17:39:47', 9),
(34, 1, 'De día', '2014-06-12 23:00:36', 3);
CREATE TABLE `db_version` (
  `db` varchar(10) NOT NULL,
  `version` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
UPDATE db_version SET version = 2 WHERE db="data";