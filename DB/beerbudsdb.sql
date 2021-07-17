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
  `city` VARCHAR(100) NOT NULL,
  `state_province` VARCHAR(100) NOT NULL,
  `postal_code` VARCHAR(10) NOT NULL,
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
  `color_srm_value` INT NULL,
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
INSERT INTO `user` (`id`, `username`, `password`, `first_name`, `last_name`, `email`, `create_date`, `enabled`, `role`, `address_id`) VALUES (1, 'KyleRobison', 'admin1', 'Kyle', 'Robison', 'admin1@example.com', '2017-07-16', 1, 'admin', 2);
INSERT INTO `user` (`id`, `username`, `password`, `first_name`, `last_name`, `email`, `create_date`, `enabled`, `role`, `address_id`) VALUES (2, 'BeerTaster25', 'beer', 'Beer', 'Taster', 'beertaster@example.com', '2017-07-16', 1, 'user', 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `main_category`
-- -----------------------------------------------------
START TRANSACTION;
USE `beer_budsdb`;
INSERT INTO `main_category` (`id`, `name`) VALUES (4, 'India Pale Ale');

COMMIT;


-- -----------------------------------------------------
-- Data for table `sub_category`
-- -----------------------------------------------------
START TRANSACTION;
USE `beer_budsdb`;
INSERT INTO `sub_category` (`id`, `name`, `main_category_id`) VALUES (17, 'New England IPA', 4);

COMMIT;


-- -----------------------------------------------------
-- Data for table `beer`
-- -----------------------------------------------------
START TRANSACTION;
USE `beer_budsdb`;
INSERT INTO `beer` (`id`, `name`, `description`, `alcohol_by_volume`, `color_srm_value`, `bitterness_ibu`, `brewery_id`, `user_id`, `sub_category_id`, `beer_image_url`) VALUES (1, 'Hazy Little Thing', 'Nice Hazy IPA', 6.7, 6, 35, 1, 1, 17, NULL);

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

