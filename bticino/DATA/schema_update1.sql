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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=0;
