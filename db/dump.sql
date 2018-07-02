-- MySQL Script generated by MySQL Workbench
-- dom 22 abr 2018 17:41:38 -03
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema secure_hood
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema secure_hood
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `secure_hood` DEFAULT CHARACTER SET utf8 ;
USE `secure_hood` ;

-- -----------------------------------------------------
-- Table `secure_hood`.`usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `secure_hood`.`usuario` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `senha` VARCHAR(255) NOT NULL,
  `primeiroNome` VARCHAR(45) NULL,
  `ultimoNome` VARCHAR(45) NULL,
  `msgPanicoPadrao` TEXT NULL,
  `usuarioAtivo` TINYINT(1) NULL,
  `dataCriacao` DATETIME NULL,
  `caminhoFotoPerfil` VARCHAR(255) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `secure_hood`.`grupo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `secure_hood`.`grupo` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nomeGrupo` VARCHAR(45) NOT NULL,
  `descricao` TEXT NULL,
  `codigoGrupo` MEDIUMTEXT NULL,
  `grupoAtivo` TINYINT(1) NOT NULL,
  `dataCriacao` DATETIME NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `secure_hood`.`usuario_grupo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `secure_hood`.`usuario_grupo` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `usuario_id` INT NOT NULL,
  `grupo_id` INT NOT NULL,
  `admin` TINYINT(1) NOT NULL,
  `dataEntrada` DATETIME NULL,
  `membroAceito` CHAR NOT NULL,
  `usuario_solicitante` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_usuario-grupo_usuario_idx` (`usuario_id` ASC),
  INDEX `fk_usuario-grupo_grupo1_idx` (`grupo_id` ASC),
  INDEX `fk_usuario_grupo_usuario1_idx` (`usuario_solicitante` ASC),
  CONSTRAINT `fk_usuario-grupo_usuario`
    FOREIGN KEY (`usuario_id`)
    REFERENCES `secure_hood`.`usuario` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_usuario-grupo_grupo1`
    FOREIGN KEY (`grupo_id`)
    REFERENCES `secure_hood`.`grupo` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_usuario_grupo_usuario1`
    FOREIGN KEY (`usuario_solicitante`)
    REFERENCES `secure_hood`.`usuario` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `secure_hood`.`mensagem`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `secure_hood`.`mensagem` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `titulo` VARCHAR(45) NOT NULL,
  `mensagem` TEXT NOT NULL,
  `nivel` INT NOT NULL,
  `dataCriacao` DATETIME NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `secure_hood`.`usuario_mensagem`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `secure_hood`.`usuario_mensagem` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `usuario_id` INT NOT NULL,
  `mensagem_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_usuario-mensagem_usuario1_idx` (`usuario_id` ASC),
  INDEX `fk_usuario-mensagem_mensagem1_idx` (`mensagem_id` ASC),
  CONSTRAINT `fk_usuario-mensagem_usuario1`
    FOREIGN KEY (`usuario_id`)
    REFERENCES `secure_hood`.`usuario` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_usuario-mensagem_mensagem1`
    FOREIGN KEY (`mensagem_id`)
    REFERENCES `secure_hood`.`mensagem` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `secure_hood`.`mensagem_grupo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `secure_hood`.`mensagem_grupo` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `mensagem_id` INT NOT NULL,
  `grupo_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_mensagem-grupo_mensagem1_idx` (`mensagem_id` ASC),
  INDEX `fk_mensagem-grupo_grupo1_idx` (`grupo_id` ASC),
  CONSTRAINT `fk_mensagem-grupo_mensagem1`
    FOREIGN KEY (`mensagem_id`)
    REFERENCES `secure_hood`.`mensagem` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_mensagem-grupo_grupo1`
    FOREIGN KEY (`grupo_id`)
    REFERENCES `secure_hood`.`grupo` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `secure_hood`.`mensagem_usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `secure_hood`.`mensagem_usuario` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `remetente_id` INT NOT NULL,
  `destinatario_id` INT NOT NULL,
  `lida` TINYINT(1) NOT NULL,
  `dataCriacao` DATETIME NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_mensagem-usuario_usuario1_idx` (`remetente_id` ASC),
  INDEX `fk_mensagem-usuario_usuario2_idx` (`destinatario_id` ASC),
  CONSTRAINT `fk_mensagem-usuario_usuario1`
    FOREIGN KEY (`remetente_id`)
    REFERENCES `secure_hood`.`usuario` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_mensagem-usuario_usuario2`
    FOREIGN KEY (`destinatario_id`)
    REFERENCES `secure_hood`.`usuario` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
