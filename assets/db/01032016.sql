-- MySQL Script generated by MySQL Workbench
-- 02/10/16 15:20:44
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema offersdb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `offersdb` ;

-- -----------------------------------------------------
-- Schema offersdb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `offersdb` DEFAULT CHARACTER SET utf8 ;
USE `offersdb` ;

-- Table `offersdb`.`measure`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `offersdb`.`measure` ;

CREATE TABLE IF NOT EXISTS `offersdb`.`measure` (
  `measure_id` bigint(11) NOT NULL AUTO_INCREMENT,
  `measure_name` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`measure_id`),
  UNIQUE INDEX `idmeasure_id_UNIQUE` (`measure_id` ASC))
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8;
-- -----------------------------------------------------
-- Table `offersdb`.`vendor`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `offersdb`.`vendor` ;

CREATE TABLE IF NOT EXISTS `offersdb`.`vendor` (
  `vendor_id` bigint(11) NOT NULL AUTO_INCREMENT,
  `vendor_name` VARCHAR(45) NULL DEFAULT NULL,
  `vendor_phone` VARCHAR(45) NULL DEFAULT NULL,
  `vendor_email` VARCHAR(45) NULL DEFAULT NULL,
  `vendor_addr` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`vendor_id`),
  UNIQUE INDEX `idvendor_UNIQUE` (`vendor_id` ASC))
ENGINE = InnoDB
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = utf8
COMMENT = 'vendor of goods';


-- -----------------------------------------------------
-- Table `offersdb`.`contact`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `offersdb`.`contact` ;

-- -----------------------------------------------------
-- Table `offersdb`.`manufactur`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `offersdb`.`manufactur` ;

CREATE TABLE IF NOT EXISTS `offersdb`.`manufactur` (
  `manufactur_id` bigint(11) NOT NULL AUTO_INCREMENT,
  `manufactur_name` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`manufactur_id`),
  UNIQUE INDEX `idmanufactur_id_UNIQUE` (`manufactur_id` ASC))
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `offersdb`.`part`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `offersdb`.`part` ;

CREATE TABLE IF NOT EXISTS `offersdb`.`part` (
  `part_id` bigint(11) NOT NULL AUTO_INCREMENT,
  `part_name` VARCHAR(45) NULL DEFAULT NULL,
  `manufactur_id` bigint(11) NULL DEFAULT NULL,
  `photo` longblob NULL DEFAULT NULL,
  PRIMARY KEY (`part_id`),
  UNIQUE INDEX `id_part_UNIQUE` (`part_id` ASC),
  INDEX `fk_part_manufactur1_idx` (`manufactur_id` ASC),
  CONSTRAINT `fk_part_manufactur1`
    FOREIGN KEY (`manufactur_id`)
    REFERENCES `offersdb`.`manufactur` (`manufactur_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8
COMMENT = 'type of computer part (computer accessory)';


-- -----------------------------------------------------
-- Table `offersdb`.`typeofspec`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `offersdb`.`typeofspec` ;

-- -----------------------------------------------------
-- Table `offersdb`.`specification`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `offersdb`.`specification` ;

CREATE TABLE IF NOT EXISTS `offersdb`.`specification` (
  `spec_id` bigint(11) NOT NULL AUTO_INCREMENT,
  `spec_name` VARCHAR(45) NULL DEFAULT NULL,
  `measure_id` bigint(11) NOT NULL,
  PRIMARY KEY (`spec_id`),
  INDEX `fk_specification_measure1_idx` (`measure_id` ASC),
  CONSTRAINT `fk_specification_measure1`
    FOREIGN KEY (`measure_id`)
    REFERENCES `offersdb`.`measure` (`measure_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
  )
ENGINE = InnoDB
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `offersdb`.`description`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `offersdb`.`description` ;

CREATE TABLE IF NOT EXISTS `offersdb`.`description` (
  `descript_id` bigint(11) NOT NULL AUTO_INCREMENT,
  `descript_name` VARCHAR(45) NULL DEFAULT NULL,
  `descript_value` VARCHAR(45) NULL DEFAULT NULL,
  `spec_id` bigint(11) NOT NULL,
  `part_id` bigint(11) NOT NULL,
  PRIMARY KEY (`descript_id`),
  INDEX `fk_description_specification1_idx` (`spec_id` ASC),
  INDEX `fk_description_part1_idx` (`part_id` ASC),
  CONSTRAINT `fk_description_part1`
    FOREIGN KEY (`part_id`)
    REFERENCES `offersdb`.`part` (`part_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_description_specification1`
    FOREIGN KEY (`spec_id`)
    REFERENCES `offersdb`.`specification` (`spec_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `offersdb`.`valuta`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `offersdb`.`valuta` ;

-- -----------------------------------------------------
-- Table `offersdb`.`offer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `offersdb`.`offer` ;

CREATE TABLE IF NOT EXISTS `offersdb`.`offer` (
  `offer_id` bigint(11) NOT NULL AUTO_INCREMENT,
  `offer_date` DATETIME NULL DEFAULT NULL,
  `offer_price` float NOT NULL,
  `currency` VARCHAR(45) NULL DEFAULT NULL,
  `part_id` bigint(11) NOT NULL,
  `vendor_id` bigint(11) NOT NULL,
  `offer_num` int(10) NOT NULL,
  `offer_sum` float NOT NULL,
  PRIMARY KEY (`offer_id`, `part_id`, `vendor_id`),
  UNIQUE INDEX `id_offer_UNIQUE` (`offer_id` ASC),
  INDEX `fk_offer_part1_idx` (`part_id` ASC),
  INDEX `fk_offer_vendor1_idx` (`vendor_id` ASC),
  CONSTRAINT `fk_offer_part1`
    FOREIGN KEY (`part_id`)
    REFERENCES `offersdb`.`part` (`part_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_offer_vendor1`
    FOREIGN KEY (`vendor_id`)
    REFERENCES `offersdb`.`vendor` (`vendor_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 22
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `offersdb`.`role`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `offersdb`.`role` ;

-- -----------------------------------------------------
-- Table `offersdb`.`user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `offersdb`.`user` ;

CREATE TABLE IF NOT EXISTS `offersdb`.`user` (
  `user_id` bigint(11) NOT NULL AUTO_INCREMENT,

  `login` VARCHAR(255) NULL DEFAULT NULL,
  `password` VARCHAR(255) NULL DEFAULT NULL,
  `firstname` VARCHAR(255) NULL DEFAULT NULL,
  `lastname` VARCHAR(255) NULL DEFAULT NULL,
  `email` VARCHAR(255) NULL DEFAULT NULL,
  `phone` VARCHAR(255) NULL DEFAULT NULL,
  `role` VARCHAR(255) NULL DEFAULT NULL,
  `vendor_id` bigint(11) NULL DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE INDEX `user_id_UNIQUE` (`user_id` ASC),
  INDEX `fk_user_vendor1_idx` (`vendor_id` ASC),
  CONSTRAINT `fk_user_vendor1`
    FOREIGN KEY (`vendor_id`)
    REFERENCES `offersdb`.`vendor` (`vendor_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `offersdb`.`cart`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `offersdb`.`cart` ;

CREATE TABLE IF NOT EXISTS `offersdb`.`cart` (
  `cart_id` bigint(11) NOT NULL,
  `user_id` bigint(11) NOT NULL,
  PRIMARY KEY (`cart_id`),
  INDEX `fk_cart_user1_idx` (`user_id` ASC),
  CONSTRAINT `fk_cart_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `offersdb`.`user` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `offersdb`.`order`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `offersdb`.`order` ;

CREATE TABLE IF NOT EXISTS `offersdb`.`order` (
  `booking_id` bigint(11) NOT NULL,
  `booking_num` int(10) NULL,
  `booking_sum` real NULL,
  `booking_date` DATETIME NULL,
  `offer_id` bigint(11) NOT NULL,
  `part_id` bigint(11) NOT NULL,
  `user_id` bigint(11) NOT NULL,
  `cart_id` bigint(11) NOT NULL,
  `booking_status` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`booking_id`, `offer_id`),
  UNIQUE INDEX `order_id_UNIQUE` (`booking_id` ASC),
  INDEX `fk_order_offer1_idx` (`offer_id` ASC, `part_id` ASC),
  INDEX `fk_order_user1_idx` (`user_id` ASC),
  INDEX `fk_order_cart1_idx` (`cart_id` ASC),
  CONSTRAINT `fk_order_offer1`
    FOREIGN KEY (`offer_id` , `part_id`)
    REFERENCES `offersdb`.`offer` (`offer_id` , `part_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_order_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `offersdb`.`user` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_order_cart1`
    FOREIGN KEY (`cart_id`)
    REFERENCES `offersdb`.`cart` (`cart_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `offersdb`.`phone`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `offersdb`.`phone` ;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
