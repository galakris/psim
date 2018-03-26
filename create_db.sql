SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Library` DEFAULT CHARACTER SET utf8 ;
USE `Library` ;

-- -----------------------------------------------------
-- Table `Library`.`Persons`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Library`.`Persons` (
  `Person_ID` INT NOT NULL AUTO_INCREMENT,
  `PESEL` VARCHAR(11) NOT NULL,
  `Surname` VARCHAR(45) NOT NULL,
  `Name` VARCHAR(45) NOT NULL,
  `Phone_number` VARCHAR(13) NOT NULL,
  PRIMARY KEY (`Person_ID`),
  UNIQUE INDEX `PESEL_UNIQUE` (`PESEL` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Library`.`Accounts`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Library`.`Accounts` (
  `Account_ID` INT NOT NULL AUTO_INCREMENT,
  `Persons_Person_ID` INT NOT NULL,
  `Login` VARCHAR(45) NOT NULL,
  `Password` VARCHAR(45) NOT NULL,
  `Email` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Account_ID`),
  INDEX `fk_Accounts_Persons1_idx` (`Persons_Person_ID` ASC),
  UNIQUE INDEX `Login_UNIQUE` (`Login` ASC),
  CONSTRAINT `fk_Accounts_Persons1`
    FOREIGN KEY (`Persons_Person_ID`)
    REFERENCES `Library`.`Persons` (`Person_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Library`.`Books`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Library`.`Books` (
  `Book_ID` INT NOT NULL AUTO_INCREMENT,
  `ISBN` VARCHAR(13) NULL,
  `Title` VARCHAR(45) NOT NULL,
  `Release_date` DATE NOT NULL,
  `Publisher` VARCHAR(45) NOT NULL,
  `Pages` INT(10) NOT NULL,
  `Issue_number` VARCHAR(10) NOT NULL,
  `Dimensions` VARCHAR(13) NULL,
  `Status` INT(1) NOT NULL,
  PRIMARY KEY (`Book_ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Library`.`Loans`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Library`.`Loans` (
  `Loan_ID` INT NOT NULL AUTO_INCREMENT,
  `Accounts_Account_ID` INT NOT NULL,
  `Books_Book_ID` INT NOT NULL,
  `Date_of_rental` DATE NOT NULL,
  `Date_of_return` DATE NOT NULL,
  PRIMARY KEY (`Loan_ID`),
  INDEX `fk_Loans_Accounts1_idx` (`Accounts_Account_ID` ASC),
  INDEX `fk_Loans_Books1_idx` (`Books_Book_ID` ASC),
  CONSTRAINT `fk_Loans_Accounts1`
    FOREIGN KEY (`Accounts_Account_ID`)
    REFERENCES `Library`.`Accounts` (`Account_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Loans_Books1`
    FOREIGN KEY (`Books_Book_ID`)
    REFERENCES `Library`.`Books` (`Book_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Library`.`Authors`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Library`.`Authors` (
  `Author_ID` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(45) NOT NULL,
  `Surname` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Author_ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Library`.`Books_has_Authors`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Library`.`Books_has_Authors` (
  `book_author_bridge_ID` INT NOT NULL AUTO_INCREMENT,
  `Books_Book_ID` INT NOT NULL,
  `Authors_Author_ID` INT NOT NULL,
  INDEX `fk_Books_has_Authors_Authors1_idx` (`Authors_Author_ID` ASC),
  INDEX `fk_Books_has_Authors_Books1_idx` (`Books_Book_ID` ASC),
  PRIMARY KEY (`book_author_bridge_ID`),
  CONSTRAINT `fk_Books_has_Authors_Books1`
    FOREIGN KEY (`Books_Book_ID`)
    REFERENCES `Library`.`Books` (`Book_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Books_has_Authors_Authors1`
    FOREIGN KEY (`Authors_Author_ID`)
    REFERENCES `Library`.`Authors` (`Author_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Library`.`Reservations`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Library`.`Reservations` (
  `Reservation_ID` INT NOT NULL AUTO_INCREMENT,
  `Accounts_Account_ID` INT NOT NULL,
  `Books_Book_ID` INT NOT NULL,
  `Reservation_date` DATE NOT NULL,
  `Expiration_date` DATE NOT NULL,
  PRIMARY KEY (`Reservation_ID`),
  INDEX `fk_Reservations_Accounts1_idx` (`Accounts_Account_ID` ASC),
  INDEX `fk_Reservations_Books1_idx` (`Books_Book_ID` ASC),
  CONSTRAINT `fk_Reservations_Accounts1`
    FOREIGN KEY (`Accounts_Account_ID`)
    REFERENCES `Library`.`Accounts` (`Account_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Reservations_Books1`
    FOREIGN KEY (`Books_Book_ID`)
    REFERENCES `Library`.`Books` (`Book_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Library`.`Categories`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Library`.`Categories` (
  `Category_ID` INT NOT NULL AUTO_INCREMENT,
  `Category` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Category_ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Library`.`Books_has_Categories`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Library`.`Books_has_Categories` (
  `book_category_bridge` INT NOT NULL AUTO_INCREMENT,
  `Books_Book_ID` INT NOT NULL,
  `Categories_Category_ID` INT NOT NULL,
  INDEX `fk_Books_has_Categories_Categories1_idx` (`Categories_Category_ID` ASC),
  INDEX `fk_Books_has_Categories_Books1_idx` (`Books_Book_ID` ASC),
  PRIMARY KEY (`book_category_bridge`),
  CONSTRAINT `fk_Books_has_Categories_Books1`
    FOREIGN KEY (`Books_Book_ID`)
    REFERENCES `Library`.`Books` (`Book_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Books_has_Categories_Categories1`
    FOREIGN KEY (`Categories_Category_ID`)
    REFERENCES `Library`.`Categories` (`Category_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;