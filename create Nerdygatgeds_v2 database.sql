-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema nerdygadgets_v2
-- -----------------------------------------------------
-- This is a new version of the nerdygadgets database because the old one fucking sucked. When using the old one it felt like you were having a conversation with a old demented chimpanzee.

-- -----------------------------------------------------
-- Schema nerdygadgets_v2
--
-- This is a new version of the nerdygadgets database because the old one fucking sucked. When using the old one it felt like you were having a conversation with a old demented chimpanzee.
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `nerdygadgets_v2` DEFAULT CHARACTER SET utf8 COLLATE utf8_bin ;
USE `nerdygadgets_v2` ;

-- -----------------------------------------------------
-- Table `nerdygadgets_v2`.`customers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nerdygadgets_v2`.`customers` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(45) NOT NULL,
  `prefix` VARCHAR(45) NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `streetname` VARCHAR(45) NOT NULL,
  `house_number` VARCHAR(45) NOT NULL,
  `postal_code` VARCHAR(45) NOT NULL,
  `city` VARCHAR(45) NOT NULL,
  `phonenumber` VARCHAR(45) NULL,
  `email` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `nerdygadgets_v2`.`products`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nerdygadgets_v2`.`products` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `color` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `nerdygadgets_v2`.`product_stocks`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nerdygadgets_v2`.`product_stocks` (
  `row` INT NOT NULL,
  `collum` INT NOT NULL,
  `product_id` INT NOT NULL,
  PRIMARY KEY (`row`, `collum`),
  INDEX `fk_product_stocks_products1_idx` (`product_id` ASC) VISIBLE,
  CONSTRAINT `fk_product_stocks_products1`
    FOREIGN KEY (`product_id`)
    REFERENCES `nerdygadgets_v2`.`products` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `nerdygadgets_v2`.`orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nerdygadgets_v2`.`orders` (
  `order_number` INT NOT NULL AUTO_INCREMENT,
  `customer_id` INT NOT NULL,
  PRIMARY KEY (`order_number`),
  INDEX `fk_orders_customers_idx` (`customer_id` ASC) VISIBLE,
  CONSTRAINT `fk_orders_customers`
    FOREIGN KEY (`customer_id`)
    REFERENCES `nerdygadgets_v2`.`customers` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `nerdygadgets_v2`.`order_lines`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nerdygadgets_v2`.`order_lines` (
  `order_number` INT NOT NULL,
  `product_id` INT NOT NULL,
  `amount` INT NOT NULL,
  PRIMARY KEY (`order_number`, `product_id`),
  INDEX `fk_order_lines_products1_idx` (`product_id` ASC) VISIBLE,
  CONSTRAINT `fk_order_lines_orders1`
    FOREIGN KEY (`order_number`)
    REFERENCES `nerdygadgets_v2`.`orders` (`order_number`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_order_lines_products1`
    FOREIGN KEY (`product_id`)
    REFERENCES `nerdygadgets_v2`.`products` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
