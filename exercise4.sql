-- MySQL Script generated by MySQL Workbench
-- Tue 23 Jan 2018 11:21:07 CET
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema oef5
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema oef5
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `oef5` DEFAULT CHARACTER SET utf8 ;
USE `oef5` ;

-- -----------------------------------------------------
-- Table `oef5`.`Doctor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `oef5`.`Doctor` (
  `Doctor_ID` INT UNSIGNED NOT NULL,
  `name` VARCHAR(45) NULL,
  `Date_of_birth` DATE NULL,
  `adress` VARCHAR(45) NULL,
  `phone_number` VARCHAR(10) NULL,
  `salary` FLOAT NULL,
  PRIMARY KEY (`Doctor_ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `oef5`.`Medical`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `oef5`.`Medical` (
  `Medical_id` INT UNSIGNED NOT NULL,
  `overtime_rate` DECIMAL(4,2) NULL,
  `doctor_ID` INT UNSIGNED NULL,
  PRIMARY KEY (`Medical_id`),
  INDEX `medical-doctor_idx` (`doctor_ID` ASC),
  CONSTRAINT `medical-doctor`
    FOREIGN KEY (`doctor_ID`)
    REFERENCES `oef5`.`Doctor` (`Doctor_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `oef5`.`Specialist`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `oef5`.`Specialist` (
  `Specialist_id` INT UNSIGNED NOT NULL,
  `field_area` VARCHAR(45) NULL,
  `doctor_ID` INT UNSIGNED NULL,
  PRIMARY KEY (`Specialist_id`),
  INDEX `specialist-doctor_idx` (`doctor_ID` ASC),
  CONSTRAINT `specialist-doctor`
    FOREIGN KEY (`doctor_ID`)
    REFERENCES `oef5`.`Doctor` (`Doctor_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `oef5`.`Patient`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `oef5`.`Patient` (
  `patient_id` INT UNSIGNED NOT NULL,
  `name` VARCHAR(45) NULL,
  `adress` VARCHAR(45) NULL,
  `phone_number` DECIMAL(10) NULL,
  `Date_of_birth` DATE NULL,
  PRIMARY KEY (`patient_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `oef5`.`appointment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `oef5`.`appointment` (
  `app_id` INT UNSIGNED NOT NULL,
  `date` DATE NULL,
  `time` DATETIME NULL,
  `patient_id` INT UNSIGNED NULL,
  `doctor_ID` INT UNSIGNED NULL,
  PRIMARY KEY (`app_id`),
  INDEX `app-patient_idx` (`patient_id` ASC),
  INDEX `app-docter_idx` (`doctor_ID` ASC),
  CONSTRAINT `app-patient`
    FOREIGN KEY (`patient_id`)
    REFERENCES `oef5`.`Patient` (`patient_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `app-docter`
    FOREIGN KEY (`doctor_ID`)
    REFERENCES `oef5`.`Doctor` (`Doctor_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `oef5`.`Payment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `oef5`.`Payment` (
  `payment_id` INT UNSIGNED NOT NULL,
  `Details` VARCHAR(45) NULL,
  `method` VARCHAR(45) NULL,
  `patient_id` INT UNSIGNED NULL,
  PRIMARY KEY (`payment_id`),
  INDEX `payment-patient_idx` (`patient_id` ASC),
  CONSTRAINT `payment-patient`
    FOREIGN KEY (`patient_id`)
    REFERENCES `oef5`.`Patient` (`patient_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `oef5`.`Bill`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `oef5`.`Bill` (
  `bill_id` INT UNSIGNED NOT NULL,
  `total` DECIMAL(10) NULL,
  `doctor_id` INT UNSIGNED NULL,
  PRIMARY KEY (`bill_id`),
  INDEX `bill-patient_idx` (`doctor_id` ASC),
  CONSTRAINT `bill-patient`
    FOREIGN KEY (`doctor_id`)
    REFERENCES `oef5`.`Doctor` (`Doctor_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `oef5`.`Payment_has_Bill`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `oef5`.`Payment_has_Bill` (
  `Payment_payment_id` INT UNSIGNED NOT NULL,
  `Bill_bill_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`Payment_payment_id`, `Bill_bill_id`),
  INDEX `fk_Payment_has_Bill_Bill1_idx` (`Bill_bill_id` ASC),
  INDEX `fk_Payment_has_Bill_Payment1_idx` (`Payment_payment_id` ASC),
  CONSTRAINT `fk_Payment_has_Bill_Payment1`
    FOREIGN KEY (`Payment_payment_id`)
    REFERENCES `oef5`.`Payment` (`payment_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Payment_has_Bill_Bill1`
    FOREIGN KEY (`Bill_bill_id`)
    REFERENCES `oef5`.`Bill` (`bill_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
