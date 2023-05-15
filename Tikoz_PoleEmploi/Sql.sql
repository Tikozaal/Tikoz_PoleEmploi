INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES
('jardinier', 0, 'novice', 'Intérimaire ', 200, 'null', 'null'),
('eboueur', 0, 'novice', 'Intérimaire ', 200, 'null', 'null'),
('raffineur', 0, 'novice', 'Intérimaire', 200, 'null', 'null')
;

INSERT INTO `jobs` (`name`, `label`) VALUES
('raffineur', 'Raffineur'),
('eboueur', 'Eboueur'),
('jardinier', 'Jardinier')
;

INSERT INTO `items` (`name`, `label`, `weight`) VALUES
('petrole', "pétrole", 1.0),
('essence', "éssence", 1.0)
;

CREATE TABLE `tikoz_poleemploi` (
  `id` int(6) NOT NULL,
  `identifier` varchar(100) NOT NULL,
  `job` varchar(15) NOT NULL,
  `name` varchar(40) NOT NULL,
  `num` int(15) NOT NULL,
  `motiv` varchar(96) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

ALTER TABLE `tikoz_poleemploi`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `tikoz_poleemploi`
  MODIFY `id` int(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;
COMMIT;