-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema beer_budsdb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `beer_budsdb` ;

-- -----------------------------------------------------
-- Schema beer_budsdb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `beer_budsdb` DEFAULT CHARACTER SET utf8 ;
USE `beer_budsdb` ;

-- -----------------------------------------------------
-- Table `address`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `address` ;

CREATE TABLE IF NOT EXISTS `address` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `address` VARCHAR(100) NULL,
  `address2` VARCHAR(100) NULL,
  `city` VARCHAR(100) NULL,
  `state_province` VARCHAR(100) NULL,
  `postal_code` VARCHAR(10) NULL,
  `country_code` VARCHAR(2) NULL,
  `phone` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `brewery`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `brewery` ;

CREATE TABLE IF NOT EXISTS `brewery` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `description` TEXT NULL,
  `address_id` INT NOT NULL,
  `logo_image_url` VARCHAR(5000) NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_brewery_address1`
    FOREIGN KEY (`address_id`)
    REFERENCES `address` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_brewery_address1_idx` ON `brewery` (`address_id` ASC);


-- -----------------------------------------------------
-- Table `user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `user` ;

CREATE TABLE IF NOT EXISTS `user` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(45) NOT NULL,
  `password` VARCHAR(200) NOT NULL,
  `first_name` VARCHAR(100) NULL,
  `last_name` VARCHAR(100) NULL,
  `email` VARCHAR(100) NULL,
  `create_date` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `enabled` TINYINT NOT NULL,
  `role` VARCHAR(45) NULL,
  `address_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_user_address1`
    FOREIGN KEY (`address_id`)
    REFERENCES `address` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE UNIQUE INDEX `username_UNIQUE` ON `user` (`username` ASC);

CREATE INDEX `fk_user_address1_idx` ON `user` (`address_id` ASC);

CREATE UNIQUE INDEX `email_UNIQUE` ON `user` (`email` ASC);


-- -----------------------------------------------------
-- Table `main_category`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `main_category` ;

CREATE TABLE IF NOT EXISTS `main_category` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sub_category`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sub_category` ;

CREATE TABLE IF NOT EXISTS `sub_category` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `main_category_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_sub_category_main_category1`
    FOREIGN KEY (`main_category_id`)
    REFERENCES `main_category` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_sub_category_main_category1_idx` ON `sub_category` (`main_category_id` ASC);


-- -----------------------------------------------------
-- Table `beer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `beer` ;

CREATE TABLE IF NOT EXISTS `beer` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `description` TEXT NULL,
  `alcohol_by_volume` DOUBLE NULL,
  `color_srm` INT NULL,
  `bitterness_ibu` INT NULL,
  `brewery_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  `sub_category_id` INT NOT NULL,
  `beer_image_url` VARCHAR(5000) NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_beer_brewery1`
    FOREIGN KEY (`brewery_id`)
    REFERENCES `brewery` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_beer_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_beer_sub_category1`
    FOREIGN KEY (`sub_category_id`)
    REFERENCES `sub_category` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_beer_brewery1_idx` ON `beer` (`brewery_id` ASC);

CREATE INDEX `fk_beer_user1_idx` ON `beer` (`user_id` ASC);

CREATE INDEX `fk_beer_sub_category1_idx` ON `beer` (`sub_category_id` ASC);


-- -----------------------------------------------------
-- Table `rating`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `rating` ;

CREATE TABLE IF NOT EXISTS `rating` (
  `rating` INT NOT NULL DEFAULT 0,
  `beer_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  `comment` TEXT NULL,
  `rating_date` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`beer_id`, `user_id`),
  CONSTRAINT `fk_rating_beer1`
    FOREIGN KEY (`beer_id`)
    REFERENCES `beer` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_rating_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_rating_beer1_idx` ON `rating` (`beer_id` ASC);

CREATE INDEX `fk_rating_user1_idx` ON `rating` (`user_id` ASC);


-- -----------------------------------------------------
-- Table `favorite_beer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `favorite_beer` ;

CREATE TABLE IF NOT EXISTS `favorite_beer` (
  `beer_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`beer_id`, `user_id`),
  CONSTRAINT `fk_user_beer_beer`
    FOREIGN KEY (`beer_id`)
    REFERENCES `beer` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_beer_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_user_beer_user1_idx` ON `favorite_beer` (`user_id` ASC);

SET SQL_MODE = '';
DROP USER IF EXISTS beerbuds@localhost;
SET SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
CREATE USER 'beerbuds'@'localhost' IDENTIFIED BY 'password';

GRANT SELECT, INSERT, TRIGGER, UPDATE, DELETE ON TABLE * TO 'beerbuds'@'localhost';

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `address`
-- -----------------------------------------------------
START TRANSACTION;
USE `beer_budsdb`;
INSERT INTO `address` (`id`, `address`, `address2`, `city`, `state_province`, `postal_code`, `country_code`, `phone`) VALUES (1, '1075 E 20th Street', '', 'Chico', 'CA', '95928', 'US', '5308933520');
INSERT INTO `address` (`id`, `address`, `address2`, `city`, `state_province`, `postal_code`, `country_code`, `phone`) VALUES (2, '100 Main Street', NULL, 'Atlanta', 'GA', '50000', 'US', NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `brewery`
-- -----------------------------------------------------
START TRANSACTION;
USE `beer_budsdb`;
INSERT INTO `brewery` (`id`, `name`, `description`, `address_id`, `logo_image_url`) VALUES (1, 'Sierra Nevada', 'It changed tastes, made hops famous, and brought an industry back from extinction. That’s a hard-working beer.', 1, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `user`
-- -----------------------------------------------------
START TRANSACTION;
USE `beer_budsdb`;
INSERT INTO `user` (`id`, `username`, `password`, `first_name`, `last_name`, `email`, `create_date`, `enabled`, `role`, `address_id`) VALUES (1, 'KyleRobison', 'admin1', 'Kyle', 'Robison', 'admin1@example.com', '2017-07-16 12:00:00', 1, 'admin', 2);
INSERT INTO `user` (`id`, `username`, `password`, `first_name`, `last_name`, `email`, `create_date`, `enabled`, `role`, `address_id`) VALUES (2, 'BeerTaster25', 'beer', 'Beer', 'Taster', 'beertaster@example.com', '2017-07-16 12:00:00', 1, 'user', 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `main_category`
-- -----------------------------------------------------
START TRANSACTION;
USE `beer_budsdb`;
INSERT INTO `main_category` (`id`, `name`) VALUES (1, 'Pale Ale');
INSERT INTO `main_category` (`id`, `name`) VALUES (2, 'Dark Lager');
INSERT INTO `main_category` (`id`, `name`) VALUES (3, 'Brown Ale');
INSERT INTO `main_category` (`id`, `name`) VALUES (4, 'India Pale Ale');
INSERT INTO `main_category` (`id`, `name`) VALUES (5, 'Wheat Beer');
INSERT INTO `main_category` (`id`, `name`) VALUES (6, 'Strong Ale');
INSERT INTO `main_category` (`id`, `name`) VALUES (7, 'Belgian Style');
INSERT INTO `main_category` (`id`, `name`) VALUES (8, 'Hybrid Beer');
INSERT INTO `main_category` (`id`, `name`) VALUES (9, 'Porter');
INSERT INTO `main_category` (`id`, `name`) VALUES (10, 'Stout');
INSERT INTO `main_category` (`id`, `name`) VALUES (11, 'Bock');
INSERT INTO `main_category` (`id`, `name`) VALUES (12, 'Scottish-Style Ale');
INSERT INTO `main_category` (`id`, `name`) VALUES (13, 'Wild or Sour Beer');
INSERT INTO `main_category` (`id`, `name`) VALUES (14, 'Pilsner or Pale Lager');
INSERT INTO `main_category` (`id`, `name`) VALUES (15, 'Specialty Beer');

COMMIT;


-- -----------------------------------------------------
-- Data for table `sub_category`
-- -----------------------------------------------------
START TRANSACTION;
USE `beer_budsdb`;
INSERT INTO `sub_category` (`id`, `name`, `main_category_id`) VALUES (1, 'American Amber Ale', 1);
INSERT INTO `sub_category` (`id`, `name`, `main_category_id`) VALUES (2, 'American Pale Ale', 1);
INSERT INTO `sub_category` (`id`, `name`, `main_category_id`) VALUES (3, 'Blonde Ale', 1);
INSERT INTO `sub_category` (`id`, `name`, `main_category_id`) VALUES (4, 'English-Style Bitter', 1);
INSERT INTO `sub_category` (`id`, `name`, `main_category_id`) VALUES (5, 'English-Style Pale Ale (ESB)', 1);
INSERT INTO `sub_category` (`id`, `name`, `main_category_id`) VALUES (6, 'American Amber Lager', 2);
INSERT INTO `sub_category` (`id`, `name`, `main_category_id`) VALUES (7, 'German-Style Dunkel', 2);
INSERT INTO `sub_category` (`id`, `name`, `main_category_id`) VALUES (8, 'German-Style Marzen / Oktoberfest', 2);
INSERT INTO `sub_category` (`id`, `name`, `main_category_id`) VALUES (9, 'German-Style Schwarzbier', 2);
INSERT INTO `sub_category` (`id`, `name`, `main_category_id`) VALUES (10, 'Vienna-Style Lager', 2);
INSERT INTO `sub_category` (`id`, `name`, `main_category_id`) VALUES (11, 'American Brown Ale', 3);
INSERT INTO `sub_category` (`id`, `name`, `main_category_id`) VALUES (12, 'English-Style Brown Ale', 3);
INSERT INTO `sub_category` (`id`, `name`, `main_category_id`) VALUES (13, 'English-Style Mild', 3);
INSERT INTO `sub_category` (`id`, `name`, `main_category_id`) VALUES (14, 'American IPA', 4);
INSERT INTO `sub_category` (`id`, `name`, `main_category_id`) VALUES (15, 'English-Style IPA', 4);
INSERT INTO `sub_category` (`id`, `name`, `main_category_id`) VALUES (16, 'Imperial India Pale Ale', 4);
INSERT INTO `sub_category` (`id`, `name`, `main_category_id`) VALUES (17, 'New England IPA', 4);
INSERT INTO `sub_category` (`id`, `name`, `main_category_id`) VALUES (18, 'American-Style Wheat Wine Ale', 5);
INSERT INTO `sub_category` (`id`, `name`, `main_category_id`) VALUES (19, 'American Wheat', 5);
INSERT INTO `sub_category` (`id`, `name`, `main_category_id`) VALUES (20, 'Belgian-Style Witbier', 5);
INSERT INTO `sub_category` (`id`, `name`, `main_category_id`) VALUES (21, 'Berliner-Style Weisse', 5);
INSERT INTO `sub_category` (`id`, `name`, `main_category_id`) VALUES (22, 'German-Style Dunkelweizen', 5);
INSERT INTO `sub_category` (`id`, `name`, `main_category_id`) VALUES (23, 'German-Style Hefeweizen', 5);
INSERT INTO `sub_category` (`id`, `name`, `main_category_id`) VALUES (24, 'American Barley Wine', 6);
INSERT INTO `sub_category` (`id`, `name`, `main_category_id`) VALUES (25, 'American Imperial Red Ale', 6);
INSERT INTO `sub_category` (`id`, `name`, `main_category_id`) VALUES (26, 'British-Style Barley Wine Ale', 6);
INSERT INTO `sub_category` (`id`, `name`, `main_category_id`) VALUES (27, 'English-Style Old Ale', 6);
INSERT INTO `sub_category` (`id`, `name`, `main_category_id`) VALUES (28, 'Belgian-Style Blonde Ale', 7);
INSERT INTO `sub_category` (`id`, `name`, `main_category_id`) VALUES (29, 'Belgian-Style Dubbel', 7);
INSERT INTO `sub_category` (`id`, `name`, `main_category_id`) VALUES (30, 'Belgian-Style Golden Strong Ale', 7);
INSERT INTO `sub_category` (`id`, `name`, `main_category_id`) VALUES (31, 'Belgian-Style Pale Ale', 7);
INSERT INTO `sub_category` (`id`, `name`, `main_category_id`) VALUES (32, 'Belgian-Style Quadrupel', 7);
INSERT INTO `sub_category` (`id`, `name`, `main_category_id`) VALUES (33, 'Belgian-Style Saison', 7);
INSERT INTO `sub_category` (`id`, `name`, `main_category_id`) VALUES (34, 'Belgian-Style Tripel', 7);
INSERT INTO `sub_category` (`id`, `name`, `main_category_id`) VALUES (35, 'American Cream Ale', 8);
INSERT INTO `sub_category` (`id`, `name`, `main_category_id`) VALUES (36, 'French-Style Biere de Garde', 8);
INSERT INTO `sub_category` (`id`, `name`, `main_category_id`) VALUES (37, 'California Common', 8);
INSERT INTO `sub_category` (`id`, `name`, `main_category_id`) VALUES (38, 'German-Style Brown/Altbier', 8);
INSERT INTO `sub_category` (`id`, `name`, `main_category_id`) VALUES (39, 'German-Style Kolsch', 8);
INSERT INTO `sub_category` (`id`, `name`, `main_category_id`) VALUES (40, 'Irish-Style Red Beer', 8);
INSERT INTO `sub_category` (`id`, `name`, `main_category_id`) VALUES (41, 'American Imperial Porter', 9);
INSERT INTO `sub_category` (`id`, `name`, `main_category_id`) VALUES (42, 'Baltic-Style Porter', 9);
INSERT INTO `sub_category` (`id`, `name`, `main_category_id`) VALUES (43, 'English-Style Brown Porter', 9);
INSERT INTO `sub_category` (`id`, `name`, `main_category_id`) VALUES (44, 'Robust Porter', 9);
INSERT INTO `sub_category` (`id`, `name`, `main_category_id`) VALUES (45, 'Smoke Porter', 9);
INSERT INTO `sub_category` (`id`, `name`, `main_category_id`) VALUES (46, 'American Imperial Stout', 10);
INSERT INTO `sub_category` (`id`, `name`, `main_category_id`) VALUES (47, 'American Stout', 10);
INSERT INTO `sub_category` (`id`, `name`, `main_category_id`) VALUES (48, 'English-Style Oatmeal Stout', 10);
INSERT INTO `sub_category` (`id`, `name`, `main_category_id`) VALUES (49, 'English-Style Sweet Stout (Milk Stout)', 10);
INSERT INTO `sub_category` (`id`, `name`, `main_category_id`) VALUES (50, 'Irish-Style Dry Stout', 10);
INSERT INTO `sub_category` (`id`, `name`, `main_category_id`) VALUES (51, 'German-Style Bock', 11);
INSERT INTO `sub_category` (`id`, `name`, `main_category_id`) VALUES (52, 'German-Style Doppelbock', 11);
INSERT INTO `sub_category` (`id`, `name`, `main_category_id`) VALUES (53, 'German-Style Maibock', 11);
INSERT INTO `sub_category` (`id`, `name`, `main_category_id`) VALUES (54, 'German-Style Weizenbock', 11);
INSERT INTO `sub_category` (`id`, `name`, `main_category_id`) VALUES (55, 'Scotch Ale/Wee Heavy', 12);
INSERT INTO `sub_category` (`id`, `name`, `main_category_id`) VALUES (56, 'Scottish-Style Ale', 12);
INSERT INTO `sub_category` (`id`, `name`, `main_category_id`) VALUES (57, 'American Brett', 13);
INSERT INTO `sub_category` (`id`, `name`, `main_category_id`) VALUES (58, 'American Sour', 13);
INSERT INTO `sub_category` (`id`, `name`, `main_category_id`) VALUES (59, 'Belgian-Style Flanders', 13);
INSERT INTO `sub_category` (`id`, `name`, `main_category_id`) VALUES (60, 'Belgian-Style Fruit Lambic', 13);
INSERT INTO `sub_category` (`id`, `name`, `main_category_id`) VALUES (61, 'Belgian-Style Lambic/Gueuze', 13);
INSERT INTO `sub_category` (`id`, `name`, `main_category_id`) VALUES (62, 'Contemporary Gose', 13);
INSERT INTO `sub_category` (`id`, `name`, `main_category_id`) VALUES (63, 'American Lager', 14);
INSERT INTO `sub_category` (`id`, `name`, `main_category_id`) VALUES (64, 'Bohemian-Style Pilsener', 14);
INSERT INTO `sub_category` (`id`, `name`, `main_category_id`) VALUES (65, 'European-Style Export', 14);
INSERT INTO `sub_category` (`id`, `name`, `main_category_id`) VALUES (66, 'German-Style Helles', 14);
INSERT INTO `sub_category` (`id`, `name`, `main_category_id`) VALUES (67, 'German-Style Pilsner', 14);
INSERT INTO `sub_category` (`id`, `name`, `main_category_id`) VALUES (68, 'American Black Ale', 15);
INSERT INTO `sub_category` (`id`, `name`, `main_category_id`) VALUES (69, 'Barrel-Aged Beer', 15);
INSERT INTO `sub_category` (`id`, `name`, `main_category_id`) VALUES (70, 'Chocolate Beer', 15);
INSERT INTO `sub_category` (`id`, `name`, `main_category_id`) VALUES (71, 'Coffee Beer', 15);
INSERT INTO `sub_category` (`id`, `name`, `main_category_id`) VALUES (72, 'Fruit and Field Beer', 15);
INSERT INTO `sub_category` (`id`, `name`, `main_category_id`) VALUES (73, 'Gluten-Free Beer', 15);
INSERT INTO `sub_category` (`id`, `name`, `main_category_id`) VALUES (74, 'Herb and Spice Beer', 15);
INSERT INTO `sub_category` (`id`, `name`, `main_category_id`) VALUES (75, 'Honey Beer', 15);
INSERT INTO `sub_category` (`id`, `name`, `main_category_id`) VALUES (76, 'Pumpkin Beer', 15);
INSERT INTO `sub_category` (`id`, `name`, `main_category_id`) VALUES (77, 'Rye Beer', 15);
INSERT INTO `sub_category` (`id`, `name`, `main_category_id`) VALUES (78, 'Session Beer', 15);
INSERT INTO `sub_category` (`id`, `name`, `main_category_id`) VALUES (79, 'Smoke Beer', 15);
INSERT INTO `sub_category` (`id`, `name`, `main_category_id`) VALUES (80, 'Specialty Beer', 15);

COMMIT;


-- -----------------------------------------------------
-- Data for table `beer`
-- -----------------------------------------------------
START TRANSACTION;
USE `beer_budsdb`;
INSERT INTO `beer` (`id`, `name`, `description`, `alcohol_by_volume`, `color_srm`, `bitterness_ibu`, `brewery_id`, `user_id`, `sub_category_id`, `beer_image_url`) VALUES (1, 'Hazy Little Thing', 'Nice Hazy IPA', 6.7, 6, 35, 1, 1, 17, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `rating`
-- -----------------------------------------------------
START TRANSACTION;
USE `beer_budsdb`;
INSERT INTO `rating` (`rating`, `beer_id`, `user_id`, `comment`, `rating_date`) VALUES (5, 1, 2, 'One of my favorites', NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `favorite_beer`
-- -----------------------------------------------------
START TRANSACTION;
USE `beer_budsdb`;
INSERT INTO `favorite_beer` (`beer_id`, `user_id`) VALUES (1, 2);

COMMIT;

