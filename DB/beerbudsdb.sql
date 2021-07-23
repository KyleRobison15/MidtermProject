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
  `profile_image_url` VARCHAR(5000) NULL,
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
INSERT INTO `address` (`id`, `address`, `address2`, `city`, `state_province`, `postal_code`, `country_code`, `phone`) VALUES (3, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `address` (`id`, `address`, `address2`, `city`, `state_province`, `postal_code`, `country_code`, `phone`) VALUES (4, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `address` (`id`, `address`, `address2`, `city`, `state_province`, `postal_code`, `country_code`, `phone`) VALUES (5, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `address` (`id`, `address`, `address2`, `city`, `state_province`, `postal_code`, `country_code`, `phone`) VALUES (6, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `address` (`id`, `address`, `address2`, `city`, `state_province`, `postal_code`, `country_code`, `phone`) VALUES (7, '100 Paulaner Beer Road', NULL, 'Munich', 'Bavaria', '3000', 'GE', '12345678990');
INSERT INTO `address` (`id`, `address`, `address2`, `city`, `state_province`, `postal_code`, `country_code`, `phone`) VALUES (8, '200 Dogfish Head Lane', NULL, 'Milton', 'DE', '4000', 'US', '6666666666');
INSERT INTO `address` (`id`, `address`, `address2`, `city`, `state_province`, `postal_code`, `country_code`, `phone`) VALUES (9, '399 Barrel Brothers Street', NULL, 'Windsor', 'CA', '95492', 'US', '7076969487');
INSERT INTO `address` (`id`, `address`, `address2`, `city`, `state_province`, `postal_code`, `country_code`, `phone`) VALUES (10, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `address` (`id`, `address`, `address2`, `city`, `state_province`, `postal_code`, `country_code`, `phone`) VALUES (11, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `address` (`id`, `address`, `address2`, `city`, `state_province`, `postal_code`, `country_code`, `phone`) VALUES (12, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `address` (`id`, `address`, `address2`, `city`, `state_province`, `postal_code`, `country_code`, `phone`) VALUES (13, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `address` (`id`, `address`, `address2`, `city`, `state_province`, `postal_code`, `country_code`, `phone`) VALUES (14, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `address` (`id`, `address`, `address2`, `city`, `state_province`, `postal_code`, `country_code`, `phone`) VALUES (15, '800 East Lincoln Ave', NULL, 'Fort Collins', 'CO', '80524', 'US', '9704989070');
INSERT INTO `address` (`id`, `address`, `address2`, `city`, `state_province`, `postal_code`, `country_code`, `phone`) VALUES (16, '1 Busch Pl', NULL, 'St Louis', 'MO', '63118', 'US', '3145772693');
INSERT INTO `address` (`id`, `address`, `address2`, `city`, `state_province`, `postal_code`, `country_code`, `phone`) VALUES (17, '3750 Chestnut Place', NULL, 'Denver', 'CO', '80216', 'US', NULL);
INSERT INTO `address` (`id`, `address`, `address2`, `city`, `state_province`, `postal_code`, `country_code`, `phone`) VALUES (18, '500 Linden Street', NULL, 'Fort Collins', 'CO', '80524', 'US', '9702210524');
INSERT INTO `address` (`id`, `address`, `address2`, `city`, `state_province`, `postal_code`, `country_code`, `phone`) VALUES (19, 'St. James\'s Gate', NULL, 'Dublin', NULL, NULL, 'IR', '35314084800');
INSERT INTO `address` (`id`, `address`, `address2`, `city`, `state_province`, `postal_code`, `country_code`, `phone`) VALUES (20, 'Aarschotsesteenweg 20', NULL, 'Leuven', NULL, '3000', 'BE', NULL);
INSERT INTO `address` (`id`, `address`, `address2`, `city`, `state_province`, `postal_code`, `country_code`, `phone`) VALUES (21, '123 Default Address', NULL, 'Default City', 'VA', '20147', 'US', '1234567890');
INSERT INTO `address` (`id`, `address`, `address2`, `city`, `state_province`, `postal_code`, `country_code`, `phone`) VALUES (22, '123 Default Address', NULL, 'Default City', 'VA', '20147', 'US', '1234567890');

COMMIT;


-- -----------------------------------------------------
-- Data for table `brewery`
-- -----------------------------------------------------
START TRANSACTION;
USE `beer_budsdb`;
INSERT INTO `brewery` (`id`, `name`, `description`, `address_id`, `logo_image_url`) VALUES (1, 'Sierra Nevada', 'It changed tastes, made hops famous, and brought an industry back from extinction. That’s a hard-working beer.', 1, NULL);
INSERT INTO `brewery` (`id`, `name`, `description`, `address_id`, `logo_image_url`) VALUES (2, 'Paulaner Brewery', 'Paulaner is a German brewery, established in 1634 in Munich by the Minim friars of the Neudeck ob der Au cloister. The mendicant order and the brewery are named after Francis of Paola, the founder of the order. Paulaner is one of the six breweries who provide beer for Oktoberfest.', 7, NULL);
INSERT INTO `brewery` (`id`, `name`, `description`, `address_id`, `logo_image_url`) VALUES (3, 'Dogfish Head Craft Brewery', 'Brews delicious brews in the US', 8, NULL);
INSERT INTO `brewery` (`id`, `name`, `description`, `address_id`, `logo_image_url`) VALUES (4, 'Barrel Brothers Brewing Company', 'Wickedly dark brewers.', 9, NULL);
INSERT INTO `brewery` (`id`, `name`, `description`, `address_id`, `logo_image_url`) VALUES (5, 'Odelle', 'Founded in 1989, Odell Brewing was started by Doug Odell, his wife Wynne, and his sister Corkie. Over thirty years later, the culture of family and collaboration still thrives, fostering a brewery full of beer-centric people. It is this passion for beer that inspires Odell Brewing to create quality, hand-crafted, innovative brews.', 15, NULL);
INSERT INTO `brewery` (`id`, `name`, `description`, `address_id`, `logo_image_url`) VALUES (6, 'ShockTop', 'Shock top sure is a cool company. Try our beers!', 16, NULL);
INSERT INTO `brewery` (`id`, `name`, `description`, `address_id`, `logo_image_url`) VALUES (7, 'Blue Moon', 'Blue Moon has gained recognition, winning over drinkers and inspiring brewers across the country. In doing so, Blue Moon catapulted the craft movement forward, helping to shape the modern American beer scene. Now, over 20 years later, Blue Moon is still the #1 craft in the US* and is now also delighting consumers in 25+ countries globally.', 17, NULL);
INSERT INTO `brewery` (`id`, `name`, `description`, `address_id`, `logo_image_url`) VALUES (8, 'New Belgium', 'From the beginning, we’ve had the audacious goal of making world-class beer. But more than that, we’re committed to democratizing craft beer, so that more people and communities can enjoy it.', 18, NULL);
INSERT INTO `brewery` (`id`, `name`, `description`, `address_id`, `logo_image_url`) VALUES (9, 'Guiness', 'It takes adventurous spirit and irrepressible ingenuity to do things the Guinness way. From our humble beginnings in 1759 to the present day, we’ve gone to extraordinary lengths to bring you exceptional beer. But, while many milestones mark the way on our long and illustrious path, we’re not ones to rest on our laurels. As we like to put it: our greatest work is yet to come.', 19, NULL);
INSERT INTO `brewery` (`id`, `name`, `description`, `address_id`, `logo_image_url`) VALUES (10, 'Stella Artois', 'Stella Artois is the result of hundreds of years of brewing expertise so it’s worth just a few extra steps to ensure the best possible tasting experience for connoisseurs such as you. Before being poured, we always recommend it has been chilled to between 3-5°C and of course you should savour Stella Artois in its unique Chalice, the curves of which are designed to enhance the tempting taste and aroma. Take a sip. A malty middle and crisp finish should reveal the full, pleasantly bitter flavour that Stella Artois is known for and what makes it an in ideal accompaniment for a variety of cuisines from around the world.\n\n', 20, NULL);
INSERT INTO `brewery` (`id`, `name`, `description`, `address_id`, `logo_image_url`) VALUES (11, 'Victory Beer', 'Default Description', 21, NULL);
INSERT INTO `brewery` (`id`, `name`, `description`, `address_id`, `logo_image_url`) VALUES (12, 'Budweiser', 'Default Description', 22, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `user`
-- -----------------------------------------------------
START TRANSACTION;
USE `beer_budsdb`;
INSERT INTO `user` (`id`, `username`, `password`, `first_name`, `last_name`, `email`, `create_date`, `enabled`, `role`, `address_id`, `profile_image_url`) VALUES (1, 'KyleRobison', 'admin1', 'Kyle', 'Robison', 'admin1@example.com', '2017-07-16 12:00:00', 1, 'admin', 2, 'https://cache.pakistantoday.com.pk/top-gun-tom-cruise.jpg');
INSERT INTO `user` (`id`, `username`, `password`, `first_name`, `last_name`, `email`, `create_date`, `enabled`, `role`, `address_id`, `profile_image_url`) VALUES (2, 'BeerTaster25', 'beer', 'Bob', 'boblastname', 'beertaster@example.com', '2017-07-16 12:00:00', 1, 'user', 6, 'https://thumbs.dreamstime.com/b/closeup-man-drinking-beer-taster-glass-outdoor-restaurant-closeup-man-drinking-beer-taster-glass-120071957.jpg');
INSERT INTO `user` (`id`, `username`, `password`, `first_name`, `last_name`, `email`, `create_date`, `enabled`, `role`, `address_id`, `profile_image_url`) VALUES (3, 'TomStagnaro', 'admin', 'Tom', 'Stagnaro', 'tomstagnaro@example.com', '2018-07-16 12:00:00', 1, 'admin', 3, 'https://worldoffoodanddrink.worldtravelguide.net/wp-content/uploads/2017/02/Think-Beer-Craft-637982456-Click_and_Photo-copy.jpg');
INSERT INTO `user` (`id`, `username`, `password`, `first_name`, `last_name`, `email`, `create_date`, `enabled`, `role`, `address_id`, `profile_image_url`) VALUES (4, 'ChrisRiddle', 'admin', 'Chris', 'Riddle', 'chrisriddle@example.com', '2019-07-16 12:00:00', 1, 'admin', 4, 'https://static.independent.co.uk/2021/03/03/19/newFile-3.jpg?width=982&height=726&auto=webp&quality=75');
INSERT INTO `user` (`id`, `username`, `password`, `first_name`, `last_name`, `email`, `create_date`, `enabled`, `role`, `address_id`, `profile_image_url`) VALUES (5, 'MattLee', 'admin', 'Matt', 'Lee', 'mattlee@example.com', '2020-07-16 12:00:00', 1, 'admin', 5, 'https://www.maxim.com/.image/ar_1:1%2Cc_fill%2Ccs_srgb%2Cfl_progressive%2Cq_auto:good%2Cw_1200/MTU2MTQ3MTg2NDk5ODU2MTEy/iceman-top-gun-promo.jpg');
INSERT INTO `user` (`id`, `username`, `password`, `first_name`, `last_name`, `email`, `create_date`, `enabled`, `role`, `address_id`, `profile_image_url`) VALUES (6, 'BeerBlaster9000', 'beer', 'Mitchel', 'Wellington', 'mitchelwellington@example.com', '2020-07-16 12:00:00', 1, 'user', 10, 'https://drinksfeed.com/wp-content/blogs.dir/1/files/2020/01/can-cannon-xproducts-640x533-1.jpg');
INSERT INTO `user` (`id`, `username`, `password`, `first_name`, `last_name`, `email`, `create_date`, `enabled`, `role`, `address_id`, `profile_image_url`) VALUES (7, 'HopAndSkip96', 'beer', 'Brady', 'Ross', 'bradyross@example.com', '2020-07-16 12:00:00', 1, 'user', 11, 'https://c8.alamy.com/comp/C7H24N/senior-man-playing-hopscotch-in-the-park-C7H24N.jpg');
INSERT INTO `user` (`id`, `username`, `password`, `first_name`, `last_name`, `email`, `create_date`, `enabled`, `role`, `address_id`, `profile_image_url`) VALUES (8, 'WhinerTheDiner', 'beer', 'Samuel', 'Smith', 'samuelsmith@example.com', '2020-07-16 12:00:00', 1, 'user', 12, '2wCEAAoHCBYSFRgVFRUYGBgYGBgYHBwYGhoYGBoaHBwZHBwYHBocIS4lHh4tIBocJkYmKy81NUM1GiQ7QDszPy40NTEBDAwMEA8QHxISHz0rJCg0PT82OjgxNDQ0PzQ9MTQ0MTQ0NjQ0NzU0NDE2NDQ0NjQ2NDQ9NDQxNDE2NDQ0PTQxNP');
INSERT INTO `user` (`id`, `username`, `password`, `first_name`, `last_name`, `email`, `create_date`, `enabled`, `role`, `address_id`, `profile_image_url`) VALUES (9, 'SurferDude89', 'beer', 'Caitlin', 'Kipps', 'caitlinkipps@example.com', '2020-07-16 12:00:00', 1, 'user', 13, 'https://static.wikia.nocookie.net/characterprofile/images/5/5c/Silver_The_Hedgehog_Sirfer.png/revision/latest/scale-to-width-down/250?cb=20161105175410');
INSERT INTO `user` (`id`, `username`, `password`, `first_name`, `last_name`, `email`, `create_date`, `enabled`, `role`, `address_id`, `profile_image_url`) VALUES (10, 'PinkyDestroyerOfFoam', 'beer', 'Jordan', 'Darnell', 'jordandarnell@example.com', '2020-07-16 12:00:00', 1, 'user', 14, 'https://1.bp.blogspot.com/_QnWMzNoOKj0/TP7mSBocGDI/AAAAAAAABu0/10VpIaFuTIg/s1600/nose+shot+cropped.jpg');

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
INSERT INTO `beer` (`id`, `name`, `description`, `alcohol_by_volume`, `color_srm`, `bitterness_ibu`, `brewery_id`, `user_id`, `sub_category_id`, `beer_image_url`) VALUES (1, 'Hazy Little Thing', 'Nice Hazy IPA', 6.7, 6, 35, 1, 1, 17, 'https://i5.walmartimages.com/asr/0d5e1929-6bc5-4de3-9b22-5bde01d552a2_1.ba1b2c9a02efcaa3605013344b7380bb.jpeg');
INSERT INTO `beer` (`id`, `name`, `description`, `alcohol_by_volume`, `color_srm`, `bitterness_ibu`, `brewery_id`, `user_id`, `sub_category_id`, `beer_image_url`) VALUES (2, 'Paulaner Hefe Weizen', 'Germany- Hefeweizen- A specially top-fermented yeast gives this beer its unmistakable character: tangy, light, fruity, and only a tad bitter. Its natural tastes remain due to the unfiltered method of brewing.', 5.5, 5, 30, 2, 3, 13, 'https://products1.imgix.drizly.com/mi_5057.jpg?auto=format%2Ccompress&ch=Width%2CDPR&fm=jpg&q=20');
INSERT INTO `beer` (`id`, `name`, `description`, `alcohol_by_volume`, `color_srm`, `bitterness_ibu`, `brewery_id`, `user_id`, `sub_category_id`, `beer_image_url`) VALUES (3, 'Dogfish Head SeaQuenchAle', 'Delaware- American Wild Ale- 4.9% ABV. We begin by brewing a Kolsch with wheat & Munich Malt, then a salty Gose with black limes, coriander & sea salt, followed up with a citrusy-tart Berlinerweiss made with lime juice & lime peel. All three beers are then blended together = SeaQuench!', 4.9, 4, 55, 3, 4, 27, 'https://www.totalwine.com/dynamic/x490,6pk/media/sys_master/twmmedia/hba/hde/12567275012126.png');
INSERT INTO `beer` (`id`, `name`, `description`, `alcohol_by_volume`, `color_srm`, `bitterness_ibu`, `brewery_id`, `user_id`, `sub_category_id`, `beer_image_url`) VALUES (4, 'Dark Sarcasm Porter', 'Barrel Brothers Brewing\'s Dark Sarcasm Porter is a rich and smooth treat. This full-bodied ale has notes of cocoa, coffee, toffee, and hints of vanilla without being too sweet. Pair with chili or soy-glazed mushrooms.', 7, 9, 40, 4, 5, 45, 'https://goodeggs4.imgix.net/7b156e08-b202-45a6-9674-5bbd1c5333a4.jpg?w=840&h=525&fm=jpg&q=80&fit=crop');
INSERT INTO `beer` (`id`, `name`, `description`, `alcohol_by_volume`, `color_srm`, `bitterness_ibu`, `brewery_id`, `user_id`, `sub_category_id`, `beer_image_url`) VALUES (5, 'Mystery Beer', 'Mystery taste', 8, 5, 65, 4, 3, 1, 'https://cdn.shopify.com/s/files/1/0359/0750/2124/products/mysterybeer_2464x.jpg?v=1605550900');
INSERT INTO `beer` (`id`, `name`, `description`, `alcohol_by_volume`, `color_srm`, `bitterness_ibu`, `brewery_id`, `user_id`, `sub_category_id`, `beer_image_url`) VALUES (6, '90 Shilling', '90 Shilling is our smooth and complex flagship beer. A medium-bodied amber ale with a distinct burnished copper color and a deeply pleasant aroma. The name 90 Shilling comes from the Scottish method of taxing beer. Only the highest quality beers were taxed 90 Shillings. We think you’ll find this original ale brilliantly refreshing, and worth every Shilling.', 5.3, 0, 32, 5, 1, 1, 'https://www.odellbrewing.com/wp-content/uploads/2020/04/90-Shilling-ProductCrops-e1588041326994.png');
INSERT INTO `beer` (`id`, `name`, `description`, `alcohol_by_volume`, `color_srm`, `bitterness_ibu`, `brewery_id`, `user_id`, `sub_category_id`, `beer_image_url`) VALUES (7, 'Sour Monkey', 'Fruity notes from imported Belgian yeast swirl through a precise souring. Pucker up to a bite of citrus laden tang ending with a delectable experience.', 9.5, 0, 10, 11, 2, 1, 'https://www.biagiowineandspirits.com/wp-content/uploads/2019/05/img5590.png');
INSERT INTO `beer` (`id`, `name`, `description`, `alcohol_by_volume`, `color_srm`, `bitterness_ibu`, `brewery_id`, `user_id`, `sub_category_id`, `beer_image_url`) VALUES (8, 'ShockTop Belgian White', 'This spiced Belgian-style wheat ale is the pinnacle of refreshment brewed with real orange, lemon and lime peels for a smooth, citrusy finish. The beer that’s always down to chill — and be chilled.', 4.0, 0, 10, 6, 3, 1, 'https://d2aam04nmhpdf8.cloudfront.net/images/images/000/025/168/xlarge/shock-top.jpg?1546530943');
INSERT INTO `beer` (`id`, `name`, `description`, `alcohol_by_volume`, `color_srm`, `bitterness_ibu`, `brewery_id`, `user_id`, `sub_category_id`, `beer_image_url`) VALUES (9, 'Blue Moon Belgian White', 'A wheat beer brewed with Valencia orange peel for a subtle sweetness and bright, citrus aroma.', 5.4, 0, 9, 7, 4, 1, 'https://www.bluemoonbrewingcompany.com/sites/bluemoon/files/styles/beers/public/beers/2018-06/BlueMoon-BelgianWhite.png?itok=AonO8W6_');
INSERT INTO `beer` (`id`, `name`, `description`, `alcohol_by_volume`, `color_srm`, `bitterness_ibu`, `brewery_id`, `user_id`, `sub_category_id`, `beer_image_url`) VALUES (10, 'Bud Light', 'Bud Light is brewed using a blend of premium aroma hop varieties, both American-grown and imported, and a combination of barley malts and rice. Its superior drinkability and refreshing flavor makes it the world’s favorite light beer.', 4.2, 0, 6, 12, 1, 1, 'https://thumbor.thedailymeal.com/sPcrDgOkMkucI3QSPNrK3VNePek=/870x565/filters:focal(829x460:830x461)/https://www.thedailymeal.com/sites/default/files/story/2017/budlight-shutterstock.JPG');
INSERT INTO `beer` (`id`, `name`, `description`, `alcohol_by_volume`, `color_srm`, `bitterness_ibu`, `brewery_id`, `user_id`, `sub_category_id`, `beer_image_url`) VALUES (11, 'Stella Artois', 'Stella Artois is a classic Belgian lager, golden in color with a floral, hop aroma, well-balanced fruity malty sweetness, crisp hop bitterness and a soft dry finish. All natural ingredients give Stella Artois a clean, crisp palate. The fresh, pale malt aromas offer a sweet herbal note and a lingering hoppy finish.Stella is made with traditional malted barley and the finest European hops to provide superior quality and its full characteristic flavor.', 5.2, 0, 24, 10, 2, 1, 'https://bierstation.com/wp-content/uploads/2020/09/a61c8d33-b10e-40dd-9fff-21bafeff2d6b-4.png');
INSERT INTO `beer` (`id`, `name`, `description`, `alcohol_by_volume`, `color_srm`, `bitterness_ibu`, `brewery_id`, `user_id`, `sub_category_id`, `beer_image_url`) VALUES (12, 'Fat Tire', 'Fat Tire delivers drinkers everywhere a flavorful, balanced beer with a fresh herbal hop profile, fine malt presence and a touch of fruity yeast, making it a timeless beer with broad appeal.', 5.2, 0, 22, 8, 3, 1, 'https://www.newbelgium.com/siteassets/beer/fat-tire/beer-fat-tire-amber-ale-desktop.png');
INSERT INTO `beer` (`id`, `name`, `description`, `alcohol_by_volume`, `color_srm`, `bitterness_ibu`, `brewery_id`, `user_id`, `sub_category_id`, `beer_image_url`) VALUES (13, 'Guiness Draught', 'Rich and creamy. Distinctively black. Velvety in its finish. This iconic beer is defined by harmony. Sip after sip, sweet counters bitter as the malt arrives on cue to compliment a base of roasted barley. Just as the unmistakable white head sits flush atop the dark beer, so do the flavors counter and combine perfectly. This is our greatest innovation. Truly unique. Perfectly balanced. Made of More', 4.2, 0, 0, 9, 4, 1, 'https://2fdltvvn8wp2rn64ywgk8o17-wpengine.netdna-ssl.com/wp-content/uploads/2016/03/guinness-draught.jpg');

COMMIT;


-- -----------------------------------------------------
-- Data for table `rating`
-- -----------------------------------------------------
START TRANSACTION;
USE `beer_budsdb`;
INSERT INTO `rating` (`rating`, `beer_id`, `user_id`, `comment`, `rating_date`) VALUES (5, 6, 1, 'Excellent', '2021-05-01 12:05:32');
INSERT INTO `rating` (`rating`, `beer_id`, `user_id`, `comment`, `rating_date`) VALUES (5, 6, 2, 'Excellent', '2021-05-01 12:05:32');
INSERT INTO `rating` (`rating`, `beer_id`, `user_id`, `comment`, `rating_date`) VALUES (5, 6, 3, 'Excellent', '2021-05-01 12:05:32');
INSERT INTO `rating` (`rating`, `beer_id`, `user_id`, `comment`, `rating_date`) VALUES (5, 6, 4, 'Excellent', '2021-05-01 12:05:32');
INSERT INTO `rating` (`rating`, `beer_id`, `user_id`, `comment`, `rating_date`) VALUES (5, 6, 5, 'Excellent', '2021-05-01 12:05:32');
INSERT INTO `rating` (`rating`, `beer_id`, `user_id`, `comment`, `rating_date`) VALUES (5, 6, 6, 'Excellent', '2021-05-01 12:05:32');
INSERT INTO `rating` (`rating`, `beer_id`, `user_id`, `comment`, `rating_date`) VALUES (4, 6, 7, 'Good', '2021-05-01 12:05:32');
INSERT INTO `rating` (`rating`, `beer_id`, `user_id`, `comment`, `rating_date`) VALUES (5, 9, 1, 'Excellent', '2021-05-01 12:05:32');
INSERT INTO `rating` (`rating`, `beer_id`, `user_id`, `comment`, `rating_date`) VALUES (5, 9, 2, 'Excellent', '2021-05-01 12:05:32');
INSERT INTO `rating` (`rating`, `beer_id`, `user_id`, `comment`, `rating_date`) VALUES (5, 9, 3, 'Excellent', '2021-05-01 12:05:32');
INSERT INTO `rating` (`rating`, `beer_id`, `user_id`, `comment`, `rating_date`) VALUES (4, 9, 4, 'Good', '2021-05-01 12:05:32');
INSERT INTO `rating` (`rating`, `beer_id`, `user_id`, `comment`, `rating_date`) VALUES (5, 2, 1, 'Excellent', '2021-05-01 12:05:32');
INSERT INTO `rating` (`rating`, `beer_id`, `user_id`, `comment`, `rating_date`) VALUES (5, 2, 2, 'Excellent', '2021-05-01 12:05:32');
INSERT INTO `rating` (`rating`, `beer_id`, `user_id`, `comment`, `rating_date`) VALUES (5, 2, 3, 'Excellent', '2021-05-01 12:05:32');
INSERT INTO `rating` (`rating`, `beer_id`, `user_id`, `comment`, `rating_date`) VALUES (5, 2, 4, 'Excellent', '2021-05-01 12:05:32');
INSERT INTO `rating` (`rating`, `beer_id`, `user_id`, `comment`, `rating_date`) VALUES (3, 2, 5, 'Okay', '2021-05-01 12:05:32');
INSERT INTO `rating` (`rating`, `beer_id`, `user_id`, `comment`, `rating_date`) VALUES (5, 7, 1, 'Excellent', '2021-05-01 12:05:32');
INSERT INTO `rating` (`rating`, `beer_id`, `user_id`, `comment`, `rating_date`) VALUES (5, 7, 2, 'Excellent', '2021-05-01 12:05:32');
INSERT INTO `rating` (`rating`, `beer_id`, `user_id`, `comment`, `rating_date`) VALUES (5, 7, 3, 'Excellent', '2021-05-01 12:05:32');
INSERT INTO `rating` (`rating`, `beer_id`, `user_id`, `comment`, `rating_date`) VALUES (5, 7, 4, 'Excellent', '2021-05-01 12:05:32');
INSERT INTO `rating` (`rating`, `beer_id`, `user_id`, `comment`, `rating_date`) VALUES (5, 7, 5, 'Excellent', '2021-05-01 12:05:32');
INSERT INTO `rating` (`rating`, `beer_id`, `user_id`, `comment`, `rating_date`) VALUES (2, 7, 6, 'Not Good', '2021-05-01 12:05:32');
INSERT INTO `rating` (`rating`, `beer_id`, `user_id`, `comment`, `rating_date`) VALUES (5, 1, 1, 'Excellent', '2021-05-01 12:05:32');
INSERT INTO `rating` (`rating`, `beer_id`, `user_id`, `comment`, `rating_date`) VALUES (5, 1, 2, 'Excellent', '2021-05-01 12:05:32');
INSERT INTO `rating` (`rating`, `beer_id`, `user_id`, `comment`, `rating_date`) VALUES (5, 1, 3, 'Excellent', '2021-05-01 12:05:32');
INSERT INTO `rating` (`rating`, `beer_id`, `user_id`, `comment`, `rating_date`) VALUES (5, 1, 4, 'Excellent', '2021-05-01 12:05:32');
INSERT INTO `rating` (`rating`, `beer_id`, `user_id`, `comment`, `rating_date`) VALUES (3, 1, 5, 'Okay', '2021-05-01 12:05:32');
INSERT INTO `rating` (`rating`, `beer_id`, `user_id`, `comment`, `rating_date`) VALUES (5, 3, 1, 'Excellent', '2021-05-01 12:05:32');
INSERT INTO `rating` (`rating`, `beer_id`, `user_id`, `comment`, `rating_date`) VALUES (5, 3, 2, 'Excellent', '2021-05-01 12:05:32');
INSERT INTO `rating` (`rating`, `beer_id`, `user_id`, `comment`, `rating_date`) VALUES (5, 3, 3, 'Excellent', '2021-05-01 12:05:32');
INSERT INTO `rating` (`rating`, `beer_id`, `user_id`, `comment`, `rating_date`) VALUES (5, 3, 4, 'Excellent', '2021-05-01 12:05:32');
INSERT INTO `rating` (`rating`, `beer_id`, `user_id`, `comment`, `rating_date`) VALUES (1, 3, 5, 'Excellent', '2021-05-01 12:05:32');
INSERT INTO `rating` (`rating`, `beer_id`, `user_id`, `comment`, `rating_date`) VALUES (5, 4, 1, 'Excellent', '2021-05-01 12:05:32');
INSERT INTO `rating` (`rating`, `beer_id`, `user_id`, `comment`, `rating_date`) VALUES (5, 4, 2, 'Excellent', '2021-05-01 12:05:32');
INSERT INTO `rating` (`rating`, `beer_id`, `user_id`, `comment`, `rating_date`) VALUES (5, 4, 3, 'Excellent', '2021-05-01 12:05:32');
INSERT INTO `rating` (`rating`, `beer_id`, `user_id`, `comment`, `rating_date`) VALUES (5, 4, 4, 'Excellent', '2021-05-01 12:05:32');
INSERT INTO `rating` (`rating`, `beer_id`, `user_id`, `comment`, `rating_date`) VALUES (5, 4, 5, 'Excellent', '2021-05-01 12:05:32');
INSERT INTO `rating` (`rating`, `beer_id`, `user_id`, `comment`, `rating_date`) VALUES (2, 4, 6, 'Not Good', '2021-05-01 12:05:32');
INSERT INTO `rating` (`rating`, `beer_id`, `user_id`, `comment`, `rating_date`) VALUES (1, 4, 7, 'Bad', '2021-05-01 12:05:32');
INSERT INTO `rating` (`rating`, `beer_id`, `user_id`, `comment`, `rating_date`) VALUES (5, 5, 1, 'Excellent', '2021-05-01 12:05:32');
INSERT INTO `rating` (`rating`, `beer_id`, `user_id`, `comment`, `rating_date`) VALUES (5, 5, 2, 'Excellent', '2021-05-01 12:05:32');
INSERT INTO `rating` (`rating`, `beer_id`, `user_id`, `comment`, `rating_date`) VALUES (5, 5, 3, 'Excellent', '2021-05-01 12:05:32');
INSERT INTO `rating` (`rating`, `beer_id`, `user_id`, `comment`, `rating_date`) VALUES (5, 5, 4, 'Excellent', '2021-05-01 12:05:32');
INSERT INTO `rating` (`rating`, `beer_id`, `user_id`, `comment`, `rating_date`) VALUES (1, 5, 5, 'Bad', '2021-05-01 12:05:32');
INSERT INTO `rating` (`rating`, `beer_id`, `user_id`, `comment`, `rating_date`) VALUES (1, 5, 6, 'Bad', '2021-05-01 12:05:32');
INSERT INTO `rating` (`rating`, `beer_id`, `user_id`, `comment`, `rating_date`) VALUES (5, 8, 1, 'Excellent', '2021-05-01 12:05:32');
INSERT INTO `rating` (`rating`, `beer_id`, `user_id`, `comment`, `rating_date`) VALUES (5, 8, 2, 'Excellent', '2021-05-01 12:05:32');
INSERT INTO `rating` (`rating`, `beer_id`, `user_id`, `comment`, `rating_date`) VALUES (5, 8, 3, 'Excellent', '2021-05-01 12:05:32');
INSERT INTO `rating` (`rating`, `beer_id`, `user_id`, `comment`, `rating_date`) VALUES (5, 8, 4, 'Excellent', '2021-05-01 12:05:32');
INSERT INTO `rating` (`rating`, `beer_id`, `user_id`, `comment`, `rating_date`) VALUES (5, 8, 5, 'Excellent', '2021-05-01 12:05:32');
INSERT INTO `rating` (`rating`, `beer_id`, `user_id`, `comment`, `rating_date`) VALUES (1, 8, 6, 'Bad', '2021-05-01 12:05:32');
INSERT INTO `rating` (`rating`, `beer_id`, `user_id`, `comment`, `rating_date`) VALUES (2, 8, 7, 'Not Good', '2021-05-01 12:05:32');
INSERT INTO `rating` (`rating`, `beer_id`, `user_id`, `comment`, `rating_date`) VALUES (2, 10, 1, 'Bad', '2021-05-01 12:05:32');
INSERT INTO `rating` (`rating`, `beer_id`, `user_id`, `comment`, `rating_date`) VALUES (2, 10, 2, 'Bad', '2021-05-01 12:05:32');
INSERT INTO `rating` (`rating`, `beer_id`, `user_id`, `comment`, `rating_date`) VALUES (5, 12, 1, 'Excellent', '2021-05-01 12:05:32');
INSERT INTO `rating` (`rating`, `beer_id`, `user_id`, `comment`, `rating_date`) VALUES (5, 12, 2, 'Excellent', '2021-05-01 12:05:32');
INSERT INTO `rating` (`rating`, `beer_id`, `user_id`, `comment`, `rating_date`) VALUES (5, 12, 3, 'Excellent', '2021-05-01 12:05:32');
INSERT INTO `rating` (`rating`, `beer_id`, `user_id`, `comment`, `rating_date`) VALUES (1, 12, 4, 'Bad', '2021-05-01 12:05:32');
INSERT INTO `rating` (`rating`, `beer_id`, `user_id`, `comment`, `rating_date`) VALUES (1, 12, 5, 'Bad', '2021-05-01 12:05:32');
INSERT INTO `rating` (`rating`, `beer_id`, `user_id`, `comment`, `rating_date`) VALUES (3, 12, 6, 'Okay', '2021-05-01 12:05:32');
INSERT INTO `rating` (`rating`, `beer_id`, `user_id`, `comment`, `rating_date`) VALUES (1, 13, 1, 'Bad', '2021-05-01 12:05:32');

COMMIT;


-- -----------------------------------------------------
-- Data for table `favorite_beer`
-- -----------------------------------------------------
START TRANSACTION;
USE `beer_budsdb`;
INSERT INTO `favorite_beer` (`beer_id`, `user_id`) VALUES (1, 2);

COMMIT;

