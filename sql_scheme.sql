-- Adminer 4.8.1 MySQL 8.0.19 dump

SET NAMES utf8;
SET time_zone = '+00:00';
SET foreign_key_checks = 0;
SET sql_mode = 'NO_AUTO_VALUE_ON_ZERO';

SET NAMES utf8mb4;

DROP TABLE IF EXISTS `events`;
CREATE TABLE `events` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` tinytext NOT NULL,
  `description` text NOT NULL,
  `date` date NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `events` (`id`, `title`, `description`, `date`) VALUES
(2,	'Павловский забег',	'',	'2026-02-15'),
(3,	'Сосновка, эстафета',	'',	'2026-02-21');

DROP TABLE IF EXISTS `events_users`;
CREATE TABLE `events_users` (
  `event_id` int NOT NULL,
  `user_id` int NOT NULL,
  `distance` int NOT NULL,
  KEY `event_id` (`event_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `events_users_ibfk_1` FOREIGN KEY (`event_id`) REFERENCES `events` (`id`),
  CONSTRAINT `events_users_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP VIEW IF EXISTS `events_users_distances`;
CREATE TABLE `events_users_distances` (`date` date, `distance` int, `title` tinytext, `name` varchar(100));


DROP TABLE IF EXISTS `pbs`;
CREATE TABLE `pbs` (
  `user_id` int NOT NULL,
  `distance` int NOT NULL,
  `result` time NOT NULL,
  KEY `user_id` (`user_id`),
  CONSTRAINT `pbs_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `reports`;
CREATE TABLE `reports` (
  `id` int NOT NULL AUTO_INCREMENT,
  `train_id` int NOT NULL,
  `text` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `stress` int NOT NULL,
  `user_id` int NOT NULL,
  `done` timestamp NOT NULL,
  `distance` float unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `train_id` (`train_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `reports_ibfk_1` FOREIGN KEY (`train_id`) REFERENCES `trains` (`id`),
  CONSTRAINT `reports_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `trains`;
CREATE TABLE `trains` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `event_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `event_id` (`event_id`),
  CONSTRAINT `trains_ibfk_1` FOREIGN KEY (`event_id`) REFERENCES `events` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `user_train`;
CREATE TABLE `user_train` (
  `user_id` int NOT NULL,
  `train_id` int NOT NULL,
  `date` date NOT NULL,
  `description` varchar(150) NOT NULL,
  KEY `user_id` (`user_id`),
  KEY `train_id` (`train_id`),
  CONSTRAINT `user_train_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `user_train_ibfk_2` FOREIGN KEY (`train_id`) REFERENCES `trains` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `is_admin` int NOT NULL,
  `is_trainer` int NOT NULL,
  `is_athlete` int NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `phone` varchar(15) NOT NULL,
  `trainer_id` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP VIEW IF EXISTS `users_pbs`;
CREATE TABLE `users_pbs` (`id` int, `name` varchar(100), `distance` int, `result` time);


DROP VIEW IF EXISTS `users_reports`;
CREATE TABLE `users_reports` (`date` date, `name` varchar(100), `title` varchar(255), `description` text, `text` text, `stress` int, `done` timestamp);


DROP TABLE IF EXISTS `events_users_distances`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`127.0.0.1` SQL SECURITY DEFINER VIEW `events_users_distances` AS select `e`.`date` AS `date`,`eu`.`distance` AS `distance`,`e`.`title` AS `title`,`u`.`name` AS `name` from ((`events_users` `eu` left join `events` `e` on((`e`.`id` = `eu`.`event_id`))) left join `users` `u` on((`u`.`id` = `eu`.`user_id`)));

DROP TABLE IF EXISTS `users_pbs`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`127.0.0.1` SQL SECURITY DEFINER VIEW `users_pbs` AS select `u`.`id` AS `id`,`u`.`name` AS `name`,`pbs`.`distance` AS `distance`,`pbs`.`result` AS `result` from (`users` `u` left join `pbs` on((`pbs`.`user_id` = `u`.`id`)));

DROP TABLE IF EXISTS `users_reports`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`127.0.0.1` SQL SECURITY DEFINER VIEW `users_reports` AS select `ut`.`date` AS `date`,`u`.`name` AS `name`,`t`.`title` AS `title`,`t`.`description` AS `description`,`r`.`text` AS `text`,`r`.`stress` AS `stress`,`r`.`done` AS `done` from (((`user_train` `ut` left join `users` `u` on((`u`.`id` = `ut`.`user_id`))) left join `reports` `r` on((`r`.`train_id` = `ut`.`train_id`))) left join `trains` `t` on((`t`.`id` = `ut`.`train_id`)));

-- 2026-02-06 11:24:41