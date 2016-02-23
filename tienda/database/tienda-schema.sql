-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema tienda
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `tienda` ;

-- -----------------------------------------------------
-- Schema tienda
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `tienda` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `tienda` ;

-- -----------------------------------------------------
-- Table `tienda`.`categorias`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tienda`.`categorias` ;

CREATE TABLE IF NOT EXISTS `tienda`.`categorias` (
  `id` INT NOT NULL AUTO_INCREMENT COMMENT '',
  `nombre` VARCHAR(100) NOT NULL COMMENT '',
  `orden` INT NOT NULL DEFAULT 1 COMMENT '',
  PRIMARY KEY (`id`)  COMMENT '')
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tienda`.`productos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tienda`.`productos` ;

CREATE TABLE IF NOT EXISTS `tienda`.`productos` (
  `id` INT NOT NULL AUTO_INCREMENT COMMENT '',
  `categorias_id` INT NOT NULL COMMENT '',
  `nombre` VARCHAR(100) NOT NULL COMMENT '',
  `descripcion` TEXT NULL COMMENT '',
  `precio` DECIMAL(10,2) NULL COMMENT '',
  `stock` INT NOT NULL DEFAULT 0 COMMENT '',
  `imagen` VARCHAR(255) NULL COMMENT '',
  `imagen_tipo` VARCHAR(100) NULL COMMENT '',
  `imagen_tamanio` INT(10) NULL COMMENT '',
  `creado` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '',
  `estado` INT(1) NOT NULL DEFAULT 1 COMMENT '',
  PRIMARY KEY (`id`)  COMMENT '',
  INDEX `fk_productos_categorias_idx` (`categorias_id` ASC)  COMMENT '',
  CONSTRAINT `fk_productos_categorias`
    FOREIGN KEY (`categorias_id`)
    REFERENCES `tienda`.`categorias` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tienda`.`roles`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tienda`.`roles` ;

CREATE TABLE IF NOT EXISTS `tienda`.`roles` (
  `id` INT NOT NULL AUTO_INCREMENT COMMENT '',
  `nombre` VARCHAR(20) NOT NULL COMMENT '',
  PRIMARY KEY (`id`)  COMMENT '')
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tienda`.`usuarios`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tienda`.`usuarios` ;

CREATE TABLE IF NOT EXISTS `tienda`.`usuarios` (
  `id` INT NOT NULL AUTO_INCREMENT COMMENT '',
  `username` VARCHAR(20) NOT NULL COMMENT '',
  `password` VARCHAR(40) NOT NULL COMMENT '',
  `nombres` VARCHAR(100) NOT NULL COMMENT '',
  `roles_id` INT NULL COMMENT '',
  `email` VARCHAR(100) NOT NULL COMMENT '',
  PRIMARY KEY (`id`)  COMMENT '',
  INDEX `fk_usuarios_roles1_idx` (`roles_id` ASC)  COMMENT '',
  CONSTRAINT `fk_usuarios_roles1`
    FOREIGN KEY (`roles_id`)
    REFERENCES `tienda`.`roles` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `tienda`.`departamentos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tienda`.`departamentos` ;

CREATE TABLE IF NOT EXISTS `tienda`.`departamentos` (
  `id` CHAR(2) NOT NULL COMMENT '',
  `nombre` VARCHAR(50) NOT NULL COMMENT '',
  PRIMARY KEY (`id`)  COMMENT '')
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tienda`.`provincias`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tienda`.`provincias` ;

CREATE TABLE IF NOT EXISTS `tienda`.`provincias` (
  `id` CHAR(4) NOT NULL COMMENT '',
  `nombre` VARCHAR(50) NOT NULL COMMENT '',
  `departamentos_id` CHAR(2) NOT NULL COMMENT '',
  PRIMARY KEY (`id`)  COMMENT '',
  INDEX `fk_provincias_departamentos1_idx` (`departamentos_id` ASC)  COMMENT '',
  CONSTRAINT `fk_provincias_departamentos1`
    FOREIGN KEY (`departamentos_id`)
    REFERENCES `tienda`.`departamentos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tienda`.`distritos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tienda`.`distritos` ;

CREATE TABLE IF NOT EXISTS `tienda`.`distritos` (
  `id` CHAR(6) NOT NULL COMMENT '',
  `nombre` VARCHAR(50) NOT NULL COMMENT '',
  `provincias_id` CHAR(4) NOT NULL COMMENT '',
  PRIMARY KEY (`id`)  COMMENT '',
  INDEX `fk_distritos_provincias1_idx` (`provincias_id` ASC)  COMMENT '',
  CONSTRAINT `fk_distritos_provincias1`
    FOREIGN KEY (`provincias_id`)
    REFERENCES `tienda`.`provincias` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tienda`.`clientes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tienda`.`clientes` ;

CREATE TABLE IF NOT EXISTS `tienda`.`clientes` (
  `id` INT NOT NULL AUTO_INCREMENT COMMENT '',
  `email` VARCHAR(100) NOT NULL COMMENT '',
  `password` VARCHAR(40) NOT NULL COMMENT '',
  `nombres` VARCHAR(100) NULL COMMENT '',
  `apellidos` VARCHAR(100) NULL COMMENT '',
  `sexo` CHAR(1) NULL COMMENT '',
  `nacimiento` DATETIME NULL COMMENT '',
  `distritos_id` CHAR(6) NULL COMMENT '',
  `direccion` VARCHAR(200) NULL COMMENT '',
  `foto` LONGBLOB NULL COMMENT '',
  `foto_tipo` VARCHAR(100) NULL COMMENT '',
  `foto_tamanio` INT(10) NULL COMMENT '',
  `estado` INT(1) NOT NULL DEFAULT 0 COMMENT '',
  PRIMARY KEY (`id`)  COMMENT '',
  INDEX `fk_clientes_distritos1_idx` (`distritos_id` ASC)  COMMENT '',
  CONSTRAINT `fk_clientes_distritos1`
    FOREIGN KEY (`distritos_id`)
    REFERENCES `tienda`.`distritos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tienda`.`mensajes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tienda`.`mensajes` ;

CREATE TABLE IF NOT EXISTS `tienda`.`mensajes` (
  `id` INT NOT NULL AUTO_INCREMENT COMMENT '',
  `contenido` VARCHAR(4000) NOT NULL COMMENT '',
  `fecha` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '',
  `usuarios_id` INT NOT NULL COMMENT '',
  PRIMARY KEY (`id`)  COMMENT '',
  INDEX `fk_mensajes_usuarios1_idx` (`usuarios_id` ASC)  COMMENT '',
  CONSTRAINT `fk_mensajes_usuarios1`
    FOREIGN KEY (`usuarios_id`)
    REFERENCES `tienda`.`usuarios` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tienda`.`pedidos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tienda`.`pedidos` ;

CREATE TABLE IF NOT EXISTS `tienda`.`pedidos` (
  `id` INT NOT NULL AUTO_INCREMENT COMMENT '',
  `clientes_id` INT NOT NULL COMMENT '',
  `fecha` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '',
  `total` DECIMAL(10,2) NOT NULL COMMENT '',
  `estado` CHAR(1) NOT NULL DEFAULT 'P' COMMENT 'P: Pedido\nR: Reparto\nE: Entregado\nC: Cancelado\nA: Anulado',
  PRIMARY KEY (`id`)  COMMENT '',
  INDEX `fk_pedidos_clientes1_idx` (`clientes_id` ASC)  COMMENT '',
  CONSTRAINT `fk_pedidos_clientes1`
    FOREIGN KEY (`clientes_id`)
    REFERENCES `tienda`.`clientes` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tienda`.`pedidos_has_productos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tienda`.`pedidos_has_productos` ;

CREATE TABLE IF NOT EXISTS `tienda`.`pedidos_has_productos` (
  `pedidos_id` INT NOT NULL COMMENT '',
  `productos_id` INT NOT NULL COMMENT '',
  `precio` DECIMAL(10,2) NOT NULL COMMENT '',
  `cantidad` INT NOT NULL COMMENT '',
  `subtotal` DECIMAL(10,2) NOT NULL COMMENT '',
  PRIMARY KEY (`pedidos_id`, `productos_id`)  COMMENT '',
  INDEX `fk_pedidos_has_productos_productos1_idx` (`productos_id` ASC)  COMMENT '',
  INDEX `fk_pedidos_has_productos_pedidos1_idx` (`pedidos_id` ASC)  COMMENT '',
  CONSTRAINT `fk_pedidos_has_productos_pedidos1`
    FOREIGN KEY (`pedidos_id`)
    REFERENCES `tienda`.`pedidos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pedidos_has_productos_productos1`
    FOREIGN KEY (`productos_id`)
    REFERENCES `tienda`.`productos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Data for table `tienda`.`roles`
-- -----------------------------------------------------
START TRANSACTION;
USE `tienda`;
INSERT INTO `tienda`.`roles` (`id`, `nombre`) VALUES (1, 'Administrador');
INSERT INTO `tienda`.`roles` (`id`, `nombre`) VALUES (2, 'Ventas');
INSERT INTO `tienda`.`roles` (`id`, `nombre`) VALUES (3, 'Almacen');

COMMIT;


-- -----------------------------------------------------
-- Data for table `tienda`.`usuarios`
-- -----------------------------------------------------
START TRANSACTION;
USE `tienda`;
INSERT INTO `tienda`.`usuarios` (`id`, `username`, `password`, `nombres`, `roles_id`, `email`) VALUES (1, 'ebenites', 'tecsup', 'Erick Benites', 1, 'ebenites@tecsup.edu.pe');
INSERT INTO `tienda`.`usuarios` (`id`, `username`, `password`, `nombres`, `roles_id`, `email`) VALUES (2, 'jaraujo', 'tecsup', 'Janeth Araujo', 2, 'jaraujo@tecsup.edu.pe');
INSERT INTO `tienda`.`usuarios` (`id`, `username`, `password`, `nombres`, `roles_id`, `email`) VALUES (3, 'jflores', 'tecsup', 'Jorge Flores', 3, 'jflores@tecsup.edu.pe');

COMMIT;


-- -----------------------------------------------------
-- Data for table `tienda`.`departamentos`
-- -----------------------------------------------------
START TRANSACTION;
USE `tienda`;
INSERT INTO `tienda`.`departamentos` (`id`, `nombre`) VALUES ('01', 'AMAZONAS');
INSERT INTO `tienda`.`departamentos` (`id`, `nombre`) VALUES ('02', 'ANCASH');
INSERT INTO `tienda`.`departamentos` (`id`, `nombre`) VALUES ('03', 'APURIMAC');
INSERT INTO `tienda`.`departamentos` (`id`, `nombre`) VALUES ('04', 'AREQUIPA');
INSERT INTO `tienda`.`departamentos` (`id`, `nombre`) VALUES ('05', 'AYACUCHO');
INSERT INTO `tienda`.`departamentos` (`id`, `nombre`) VALUES ('06', 'CAJAMARCA');
INSERT INTO `tienda`.`departamentos` (`id`, `nombre`) VALUES ('07', 'CALLAO');
INSERT INTO `tienda`.`departamentos` (`id`, `nombre`) VALUES ('08', 'CUSCO');
INSERT INTO `tienda`.`departamentos` (`id`, `nombre`) VALUES ('09', 'HUANCAVELICA');
INSERT INTO `tienda`.`departamentos` (`id`, `nombre`) VALUES ('10', 'HUANUCO');
INSERT INTO `tienda`.`departamentos` (`id`, `nombre`) VALUES ('11', 'ICA');
INSERT INTO `tienda`.`departamentos` (`id`, `nombre`) VALUES ('12', 'JUNIN');
INSERT INTO `tienda`.`departamentos` (`id`, `nombre`) VALUES ('13', 'LA LIBERTAD');
INSERT INTO `tienda`.`departamentos` (`id`, `nombre`) VALUES ('14', 'LAMBAYEQUE');
INSERT INTO `tienda`.`departamentos` (`id`, `nombre`) VALUES ('15', 'LIMA');
INSERT INTO `tienda`.`departamentos` (`id`, `nombre`) VALUES ('16', 'LORETO');
INSERT INTO `tienda`.`departamentos` (`id`, `nombre`) VALUES ('17', 'MADRE DE DIOS');
INSERT INTO `tienda`.`departamentos` (`id`, `nombre`) VALUES ('18', 'MOQUEGUA');
INSERT INTO `tienda`.`departamentos` (`id`, `nombre`) VALUES ('19', 'PASCO');
INSERT INTO `tienda`.`departamentos` (`id`, `nombre`) VALUES ('20', 'PIURA');
INSERT INTO `tienda`.`departamentos` (`id`, `nombre`) VALUES ('21', 'PUNO');
INSERT INTO `tienda`.`departamentos` (`id`, `nombre`) VALUES ('22', 'SAN MARTIN');
INSERT INTO `tienda`.`departamentos` (`id`, `nombre`) VALUES ('23', 'TACNA');
INSERT INTO `tienda`.`departamentos` (`id`, `nombre`) VALUES ('24', 'TUMBES');
INSERT INTO `tienda`.`departamentos` (`id`, `nombre`) VALUES ('25', 'UCAYALI');

COMMIT;


-- -----------------------------------------------------
-- Data for table `tienda`.`provincias`
-- -----------------------------------------------------
START TRANSACTION;
USE `tienda`;
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('0101', 'CHACHAPOYAS', '01');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('0102', 'BAGUA', '01');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('0103', 'BONGARA', '01');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('0104', 'CONDORCANQUI', '01');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('0105', 'LUYA', '01');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('0106', 'RODRIGUEZ DE MENDOZA', '01');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('0107', 'UTCUBAMBA', '01');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('0201', 'HUARAZ', '02');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('0202', 'AIJA', '02');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('0203', 'ANTONIO RAYMONDI', '02');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('0204', 'ASUNCION', '02');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('0205', 'BOLOGNESI', '02');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('0206', 'CARHUAZ', '02');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('0207', 'CARLOS FERMIN FITZCARRALD', '02');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('0208', 'CASMA', '02');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('0209', 'CORONGO', '02');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('0210', 'HUARI', '02');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('0211', 'HUARMEY', '02');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('0212', 'HUAYLAS', '02');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('0213', 'MARISCAL LUZURIAGA', '02');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('0214', 'OCROS', '02');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('0215', 'PALLASCA', '02');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('0216', 'POMABAMBA', '02');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('0217', 'RECUAY', '02');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('0218', 'SANTA', '02');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('0219', 'SIHUAS', '02');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('0220', 'YUNGAY', '02');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('0301', 'ABANCAY', '03');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('0302', 'ANDAHUAYLAS', '03');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('0303', 'ANTABAMBA', '03');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('0304', 'AYMARAES', '03');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('0305', 'COTABAMBAS', '03');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('0306', 'CHINCHEROS', '03');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('0307', 'GRAU', '03');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('0401', 'AREQUIPA', '04');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('0402', 'CAMANA', '04');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('0403', 'CARAVELI', '04');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('0404', 'CASTILLA', '04');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('0405', 'CAYLLOMA', '04');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('0406', 'CONDESUYOS', '04');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('0407', 'ISLAY', '04');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('0408', 'LA UNION', '04');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('0501', 'HUAMANGA', '05');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('0502', 'CANGALLO', '05');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('0503', 'HUANCA SANCOS', '05');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('0504', 'HUANTA', '05');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('0505', 'LA MAR', '05');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('0506', 'LUCANAS', '05');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('0507', 'PARINACOCHAS', '05');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('0508', 'PAUCAR DEL SARA SARA', '05');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('0509', 'SUCRE', '05');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('0510', 'VICTOR FAJARDO', '05');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('0511', 'VILCAS HUAMAN', '05');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('0601', 'CAJAMARCA', '06');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('0602', 'CAJABAMBA', '06');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('0603', 'CELENDIN', '06');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('0604', 'CHOTA', '06');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('0605', 'CONTUMAZA', '06');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('0606', 'CUTERVO', '06');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('0607', 'HUALGAYOC', '06');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('0608', 'JAEN', '06');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('0609', 'SAN IGNACIO', '06');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('0610', 'SAN MARCOS', '06');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('0611', 'SAN MIGUEL', '06');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('0612', 'SAN PABLO', '06');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('0613', 'SANTA CRUZ', '06');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('0701', 'CALLAO', '07');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('0801', 'CUSCO', '08');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('0802', 'ACOMAYO', '08');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('0803', 'ANTA', '08');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('0804', 'CALCA', '08');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('0805', 'CANAS', '08');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('0806', 'CANCHIS', '08');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('0807', 'CHUMBIVILCAS', '08');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('0808', 'ESPINAR', '08');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('0809', 'LA CONVENCION', '08');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('0810', 'PARURO', '08');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('0811', 'PAUCARTAMBO', '08');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('0812', 'QUISPICANCHI', '08');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('0813', 'URUBAMBA', '08');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('0901', 'HUANCAVELICA', '09');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('0902', 'ACOBAMBA', '09');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('0903', 'ANGARAES', '09');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('0904', 'CASTROVIRREYNA', '09');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('0905', 'CHURCAMPA', '09');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('0906', 'HUAYTARA', '09');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('0907', 'TAYACAJA', '09');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('1001', 'HUANUCO', '10');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('1002', 'AMBO', '10');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('1003', 'DOS DE MAYO', '10');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('1004', 'HUACAYBAMBA', '10');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('1005', 'HUAMALIES', '10');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('1006', 'LEONCIO PRADO', '10');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('1007', 'MARAÑON', '10');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('1008', 'PACHITEA', '10');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('1009', 'PUERTO INCA', '10');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('1010', 'LAURICOCHA', '10');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('1011', 'YAROWILCA', '10');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('1101', 'ICA', '11');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('1102', 'CHINCHA', '11');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('1103', 'NAZCA', '11');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('1104', 'PALPA', '11');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('1105', 'PISCO', '11');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('1201', 'HUANCAYO', '12');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('1202', 'CONCEPCION', '12');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('1203', 'CHANCHAMAYO', '12');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('1204', 'JAUJA', '12');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('1205', 'JUNIN', '12');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('1206', 'SATIPO', '12');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('1207', 'TARMA', '12');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('1208', 'YAULI', '12');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('1209', 'CHUPACA', '12');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('1301', 'TRUJILLO', '13');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('1302', 'ASCOPE', '13');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('1303', 'BOLIVAR', '13');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('1304', 'CHEPEN', '13');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('1305', 'JULCAN', '13');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('1306', 'OTUZCO', '13');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('1307', 'PACASMAYO', '13');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('1308', 'PATAZ', '13');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('1309', 'SANCHEZ CARRION', '13');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('1310', 'SANTIAGO DE CHUCO', '13');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('1311', 'GRAN CHIMU', '13');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('1312', 'VIRU', '13');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('1401', 'CHICLAYO', '14');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('1402', 'FERREÑAFE', '14');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('1403', 'LAMBAYEQUE', '14');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('1501', 'LIMA', '15');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('1502', 'BARRANCA', '15');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('1503', 'CAJATAMBO', '15');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('1504', 'CANTA', '15');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('1505', 'CAÑETE', '15');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('1506', 'HUARAL', '15');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('1507', 'HUAROCHIRI', '15');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('1508', 'HUAURA', '15');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('1509', 'OYON', '15');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('1510', 'YAUYOS', '15');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('1601', 'MAYNAS', '16');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('1602', 'ALTO AMAZONAS', '16');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('1603', 'LORETO', '16');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('1604', 'MARISCAL RAMON CASTILLA', '16');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('1605', 'REQUENA', '16');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('1606', 'UCAYALI', '16');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('1607', 'DATEM DEL MARAÑON', '16');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('1701', 'TAMBOPATA', '17');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('1702', 'MANU', '17');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('1703', 'TAHUAMANU', '17');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('1801', 'MARISCAL NIETO', '18');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('1802', 'GENERAL SANCHEZ CERRO', '18');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('1803', 'ILO', '18');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('1901', 'PASCO', '19');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('1902', 'DANIEL ALCIDES CARRION', '19');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('1903', 'OXAPAMPA', '19');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('2001', 'PIURA', '20');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('2002', 'AYABACA', '20');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('2003', 'HUANCABAMBA', '20');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('2004', 'MORROPON', '20');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('2005', 'PAITA', '20');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('2006', 'SULLANA', '20');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('2007', 'TALARA', '20');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('2008', 'SECHURA', '20');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('2101', 'PUNO', '21');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('2102', 'AZANGARO', '21');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('2103', 'CARABAYA', '21');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('2104', 'CHUCUITO', '21');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('2105', 'EL COLLAO', '21');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('2106', 'HUANCANE', '21');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('2107', 'LAMPA', '21');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('2108', 'MELGAR', '21');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('2109', 'MOHO', '21');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('2110', 'SAN ANTONIO DE PUTINA', '21');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('2111', 'SAN ROMAN', '21');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('2112', 'SANDIA', '21');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('2113', 'YUNGUYO', '21');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('2201', 'MOYOBAMBA', '22');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('2202', 'BELLAVISTA', '22');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('2203', 'EL DORADO', '22');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('2204', 'HUALLAGA', '22');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('2205', 'LAMAS', '22');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('2206', 'MARISCAL CACERES', '22');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('2207', 'PICOTA', '22');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('2208', 'RIOJA', '22');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('2209', 'SAN MARTIN', '22');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('2210', 'TOCACHE', '22');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('2301', 'TACNA', '23');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('2302', 'CANDARAVE', '23');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('2303', 'JORGE BASADRE', '23');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('2304', 'TARATA', '23');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('2401', 'TUMBES', '24');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('2402', 'CONTRALMIRANTE VILLAR', '24');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('2403', 'ZARUMILLA', '24');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('2501', 'CORONEL PORTILLO', '25');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('2502', 'ATALAYA', '25');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('2503', 'PADRE ABAD', '25');
INSERT INTO `tienda`.`provincias` (`id`, `nombre`, `departamentos_id`) VALUES ('2504', 'PURUS', '25');

COMMIT;


-- -----------------------------------------------------
-- Data for table `tienda`.`distritos`
-- -----------------------------------------------------
START TRANSACTION;
USE `tienda`;
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('010101', 'CHACHAPOYAS', '0101');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('010102', 'ASUNCION', '0101');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('010103', 'BALSAS', '0101');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('010104', 'CHETO', '0101');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('010105', 'CHILIQUIN', '0101');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('010106', 'CHUQUIBAMBA', '0101');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('010107', 'GRANADA', '0101');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('010108', 'HUANCAS', '0101');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('010109', 'LA JALCA', '0101');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('010110', 'LEIMEBAMBA', '0101');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('010111', 'LEVANTO', '0101');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('010112', 'MAGDALENA', '0101');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('010113', 'MARISCAL CASTILLA', '0101');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('010114', 'MOLINOPAMPA', '0101');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('010115', 'MONTEVIDEO', '0101');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('010116', 'OLLEROS', '0101');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('010117', 'QUINJALCA', '0101');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('010118', 'SAN FRANCISCO DE DAGUAS', '0101');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('010119', 'SAN ISIDRO DE MAINO', '0101');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('010120', 'SOLOCO', '0101');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('010121', 'SONCHE', '0101');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('010201', 'LA PECA', '0102');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('010202', 'ARAMANGO', '0102');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('010203', 'COPALLIN', '0102');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('010204', 'EL PARCO', '0102');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('010205', 'IMAZA', '0102');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('010301', 'JUMBILLA', '0103');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('010302', 'CHISQUILLA', '0103');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('010303', 'CHURUJA', '0103');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('010304', 'COROSHA', '0103');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('010305', 'CUISPES', '0103');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('010306', 'FLORIDA', '0103');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('010307', 'JAZAN', '0103');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('010308', 'RECTA', '0103');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('010309', 'SAN CARLOS', '0103');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('010310', 'SHIPASBAMBA', '0103');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('010311', 'VALERA', '0103');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('010312', 'YAMBRASBAMBA', '0103');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('010401', 'NIEVA', '0104');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('010402', 'EL CENEPA', '0104');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('010403', 'RIO SANTIAGO', '0104');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('010501', 'LAMUD', '0105');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('010502', 'CAMPORREDONDO', '0105');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('010503', 'COCABAMBA', '0105');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('010504', 'COLCAMAR', '0105');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('010505', 'CONILA', '0105');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('010506', 'INGUILPATA', '0105');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('010507', 'LONGUITA', '0105');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('010508', 'LONYA CHICO', '0105');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('010509', 'LUYA', '0105');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('010510', 'LUYA VIEJO', '0105');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('010511', 'MARIA', '0105');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('010512', 'OCALLI', '0105');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('010513', 'OCUMAL', '0105');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('010514', 'PISUQUIA', '0105');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('010515', 'PROVIDENCIA', '0105');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('010516', 'SAN CRISTOBAL', '0105');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('010517', 'SAN FRANCISCO DEL YESO', '0105');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('010518', 'SAN JERONIMO', '0105');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('010519', 'SAN JUAN DE LOPECANCHA', '0105');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('010520', 'SANTA CATALINA', '0105');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('010521', 'SANTO TOMAS', '0105');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('010522', 'TINGO', '0105');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('010523', 'TRITA', '0105');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('010601', 'SAN NICOLAS', '0106');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('010602', 'CHIRIMOTO', '0106');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('010603', 'COCHAMAL', '0106');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('010604', 'HUAMBO', '0106');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('010605', 'LIMABAMBA', '0106');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('010606', 'LONGAR', '0106');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('010607', 'MARISCAL BENAVIDES', '0106');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('010608', 'MILPUC', '0106');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('010609', 'OMIA', '0106');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('010610', 'SANTA ROSA', '0106');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('010611', 'TOTORA', '0106');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('010612', 'VISTA ALEGRE', '0106');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('010701', 'BAGUA GRANDE', '0107');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('010702', 'CAJARURO', '0107');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('010703', 'CUMBA', '0107');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('010704', 'EL MILAGRO', '0107');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('010705', 'JAMALCA', '0107');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('010706', 'LONYA GRANDE', '0107');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('010707', 'YAMON', '0107');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('020101', 'HUARAZ', '0201');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('020102', 'COCHABAMBA', '0201');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('020103', 'COLCABAMBA', '0201');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('020104', 'HUANCHAY', '0201');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('020105', 'INDEPENDENCIA', '0201');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('020106', 'JANGAS', '0201');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('020107', 'LA LIBERTAD', '0201');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('020108', 'OLLEROS', '0201');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('020109', 'PAMPAS', '0201');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('020110', 'PARIACOTO', '0201');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('020111', 'PIRA', '0201');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('020112', 'TARICA', '0201');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('020201', 'AIJA', '0202');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('020202', 'CORIS', '0202');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('020203', 'HUACLLAN', '0202');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('020204', 'LA MERCED', '0202');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('020205', 'SUCCHA', '0202');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('020301', 'LLAMELLIN', '0203');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('020302', 'ACZO', '0203');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('020303', 'CHACCHO', '0203');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('020304', 'CHINGAS', '0203');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('020305', 'MIRGAS', '0203');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('020306', 'SAN JUAN DE RONTOY', '0203');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('020401', 'CHACAS', '0204');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('020402', 'ACOCHACA', '0204');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('020501', 'CHIQUIAN', '0205');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('020502', 'ABELARDO PARDO LEZAMETA', '0205');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('020503', 'ANTONIO RAYMONDI', '0205');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('020504', 'AQUIA', '0205');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('020505', 'CAJACAY', '0205');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('020506', 'CANIS', '0205');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('020507', 'COLQUIOC', '0205');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('020508', 'HUALLANCA', '0205');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('020509', 'HUASTA', '0205');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('020510', 'HUAYLLACAYAN', '0205');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('020511', 'LA PRIMAVERA', '0205');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('020512', 'MANGAS', '0205');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('020513', 'PACLLON', '0205');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('020514', 'SAN MIGUEL DE CORPANQUI', '0205');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('020515', 'TICLLOS', '0205');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('020601', 'CARHUAZ', '0206');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('020602', 'ACOPAMPA', '0206');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('020603', 'AMASHCA', '0206');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('020604', 'ANTA', '0206');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('020605', 'ATAQUERO', '0206');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('020606', 'MARCARA', '0206');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('020607', 'PARIAHUANCA', '0206');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('020608', 'SAN MIGUEL DE ACO', '0206');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('020609', 'SHILLA', '0206');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('020610', 'TINCO', '0206');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('020611', 'YUNGAR', '0206');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('020701', 'SAN LUIS', '0207');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('020702', 'SAN NICOLAS', '0207');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('020703', 'YAUYA', '0207');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('020801', 'CASMA', '0208');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('020802', 'BUENA VISTA ALTA', '0208');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('020803', 'COMANDANTE NOEL', '0208');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('020804', 'YAUTAN', '0208');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('020901', 'CORONGO', '0209');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('020902', 'ACO', '0209');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('020903', 'BAMBAS', '0209');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('020904', 'CUSCA', '0209');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('020905', 'LA PAMPA', '0209');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('020906', 'YANAC', '0209');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('020907', 'YUPAN', '0209');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('021001', 'HUARI', '0210');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('021002', 'ANRA', '0210');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('021003', 'CAJAY', '0210');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('021004', 'CHAVIN DE HUANTAR', '0210');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('021005', 'HUACACHI', '0210');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('021006', 'HUACCHIS', '0210');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('021007', 'HUACHIS', '0210');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('021008', 'HUANTAR', '0210');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('021009', 'MASIN', '0210');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('021010', 'PAUCAS', '0210');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('021011', 'PONTO', '0210');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('021012', 'RAHUAPAMPA', '0210');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('021013', 'RAPAYAN', '0210');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('021014', 'SAN MARCOS', '0210');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('021015', 'SAN PEDRO DE CHANA', '0210');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('021016', 'UCO', '0210');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('021101', 'HUARMEY', '0211');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('021102', 'COCHAPETI', '0211');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('021103', 'CULEBRAS', '0211');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('021104', 'HUAYAN', '0211');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('021105', 'MALVAS', '0211');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('021201', 'CARAZ', '0212');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('021202', 'HUALLANCA', '0212');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('021203', 'HUATA', '0212');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('021204', 'HUAYLAS', '0212');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('021205', 'MATO', '0212');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('021206', 'PAMPAROMAS', '0212');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('021207', 'PUEBLO LIBRE', '0212');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('021208', 'SANTA CRUZ', '0212');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('021209', 'SANTO TORIBIO', '0212');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('021210', 'YURACMARCA', '0212');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('021301', 'PISCOBAMBA', '0213');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('021302', 'CASCA', '0213');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('021303', 'ELEAZAR GUZMAN BARRON', '0213');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('021304', 'FIDEL OLIVAS ESCUDERO', '0213');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('021305', 'LLAMA', '0213');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('021306', 'LLUMPA', '0213');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('021307', 'LUCMA', '0213');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('021308', 'MUSGA', '0213');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('021401', 'OCROS', '0214');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('021402', 'ACAS', '0214');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('021403', 'CAJAMARQUILLA', '0214');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('021404', 'CARHUAPAMPA', '0214');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('021405', 'COCHAS', '0214');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('021406', 'CONGAS', '0214');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('021407', 'LLIPA', '0214');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('021408', 'SAN CRISTOBAL DE RAJAN', '0214');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('021409', 'SAN PEDRO', '0214');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('021410', 'SANTIAGO DE CHILCAS', '0214');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('021501', 'CABANA', '0215');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('021502', 'BOLOGNESI', '0215');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('021503', 'CONCHUCOS', '0215');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('021504', 'HUACASCHUQUE', '0215');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('021505', 'HUANDOVAL', '0215');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('021506', 'LACABAMBA', '0215');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('021507', 'LLAPO', '0215');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('021508', 'PALLASCA', '0215');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('021509', 'PAMPAS', '0215');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('021510', 'SANTA ROSA', '0215');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('021511', 'TAUCA', '0215');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('021601', 'POMABAMBA', '0216');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('021602', 'HUAYLLAN', '0216');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('021603', 'PAROBAMBA', '0216');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('021604', 'QUINUABAMBA', '0216');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('021701', 'RECUAY', '0217');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('021702', 'CATAC', '0217');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('021703', 'COTAPARACO', '0217');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('021704', 'HUAYLLAPAMPA', '0217');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('021705', 'LLACLLIN', '0217');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('021706', 'MARCA', '0217');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('021707', 'PAMPAS CHICO', '0217');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('021708', 'PARARIN', '0217');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('021709', 'TAPACOCHA', '0217');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('021710', 'TICAPAMPA', '0217');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('021801', 'CHIMBOTE', '0218');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('021802', 'CACERES DEL PERU', '0218');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('021803', 'COISHCO', '0218');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('021804', 'MACATE', '0218');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('021805', 'MORO', '0218');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('021806', 'NEPEÑA', '0218');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('021807', 'SAMANCO', '0218');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('021808', 'SANTA', '0218');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('021809', 'NUEVO CHIMBOTE', '0218');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('021901', 'SIHUAS', '0219');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('021902', 'ACOBAMBA', '0219');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('021903', 'ALFONSO UGARTE', '0219');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('021904', 'CASHAPAMPA', '0219');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('021905', 'CHINGALPO', '0219');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('021906', 'HUAYLLABAMBA', '0219');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('021907', 'QUICHES', '0219');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('021908', 'RAGASH', '0219');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('021909', 'SAN JUAN', '0219');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('021910', 'SICSIBAMBA', '0219');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('022001', 'YUNGAY', '0220');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('022002', 'CASCAPARA', '0220');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('022003', 'MANCOS', '0220');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('022004', 'MATACOTO', '0220');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('022005', 'QUILLO', '0220');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('022006', 'RANRAHIRCA', '0220');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('022007', 'SHUPLUY', '0220');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('022008', 'YANAMA', '0220');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('030101', 'ABANCAY', '0301');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('030102', 'CHACOCHE', '0301');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('030103', 'CIRCA', '0301');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('030104', 'CURAHUASI', '0301');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('030105', 'HUANIPACA', '0301');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('030106', 'LAMBRAMA', '0301');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('030107', 'PICHIRHUA', '0301');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('030108', 'SAN PEDRO DE CACHORA', '0301');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('030109', 'TAMBURCO', '0301');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('030201', 'ANDAHUAYLAS', '0302');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('030202', 'ANDARAPA', '0302');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('030203', 'CHIARA', '0302');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('030204', 'HUANCARAMA', '0302');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('030205', 'HUANCARAY', '0302');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('030206', 'HUAYANA', '0302');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('030207', 'KISHUARA', '0302');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('030208', 'PACOBAMBA', '0302');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('030209', 'PACUCHA', '0302');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('030210', 'PAMPACHIRI', '0302');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('030211', 'POMACOCHA', '0302');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('030212', 'SAN ANTONIO DE CACHI', '0302');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('030213', 'SAN JERONIMO', '0302');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('030214', 'SAN MIGUEL DE CHACCRAMPA', '0302');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('030215', 'SANTA MARIA DE CHICMO', '0302');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('030216', 'TALAVERA', '0302');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('030217', 'TUMAY HUARACA', '0302');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('030218', 'TURPO', '0302');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('030219', 'KAQUIABAMBA', '0302');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('030301', 'ANTABAMBA', '0303');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('030302', 'EL ORO', '0303');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('030303', 'HUAQUIRCA', '0303');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('030304', 'JUAN ESPINOZA MEDRANO', '0303');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('030305', 'OROPESA', '0303');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('030306', 'PACHACONAS', '0303');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('030307', 'SABAINO', '0303');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('030401', 'CHALHUANCA', '0304');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('030402', 'CAPAYA', '0304');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('030403', 'CARAYBAMBA', '0304');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('030404', 'CHAPIMARCA', '0304');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('030405', 'COLCABAMBA', '0304');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('030406', 'COTARUSE', '0304');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('030407', 'HUAYLLO', '0304');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('030408', 'JUSTO APU SAHUARAURA', '0304');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('030409', 'LUCRE', '0304');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('030410', 'POCOHUANCA', '0304');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('030411', 'SAN JUAN DE CHACÑA', '0304');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('030412', 'SAÑAYCA', '0304');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('030413', 'SORAYA', '0304');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('030414', 'TAPAIRIHUA', '0304');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('030415', 'TINTAY', '0304');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('030416', 'TORAYA', '0304');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('030417', 'YANACA', '0304');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('030501', 'TAMBOBAMBA', '0305');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('030502', 'COTABAMBAS', '0305');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('030503', 'COYLLURQUI', '0305');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('030504', 'HAQUIRA', '0305');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('030505', 'MARA', '0305');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('030506', 'CHALLHUAHUACHO', '0305');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('030601', 'CHINCHEROS', '0306');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('030602', 'ANCO_HUALLO', '0306');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('030603', 'COCHARCAS', '0306');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('030604', 'HUACCANA', '0306');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('030605', 'OCOBAMBA', '0306');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('030606', 'ONGOY', '0306');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('030607', 'URANMARCA', '0306');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('030608', 'RANRACANCHA', '0306');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('030701', 'CHUQUIBAMBILLA', '0307');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('030702', 'CURPAHUASI', '0307');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('030703', 'GAMARRA', '0307');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('030704', 'HUAYLLATI', '0307');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('030705', 'MAMARA', '0307');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('030706', 'MICAELA BASTIDAS', '0307');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('030707', 'PATAYPAMPA', '0307');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('030708', 'PROGRESO', '0307');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('030709', 'SAN ANTONIO', '0307');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('030710', 'SANTA ROSA', '0307');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('030711', 'TURPAY', '0307');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('030712', 'VILCABAMBA', '0307');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('030713', 'VIRUNDO', '0307');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('030714', 'CURASCO', '0307');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('040101', 'AREQUIPA', '0401');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('040102', 'ALTO SELVA ALEGRE', '0401');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('040103', 'CAYMA', '0401');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('040104', 'CERRO COLORADO', '0401');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('040105', 'CHARACATO', '0401');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('040106', 'CHIGUATA', '0401');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('040107', 'JACOBO HUNTER', '0401');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('040108', 'LA JOYA', '0401');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('040109', 'MARIANO MELGAR', '0401');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('040110', 'MIRAFLORES', '0401');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('040111', 'MOLLEBAYA', '0401');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('040112', 'PAUCARPATA', '0401');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('040113', 'POCSI', '0401');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('040114', 'POLOBAYA', '0401');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('040115', 'QUEQUEÑA', '0401');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('040116', 'SABANDIA', '0401');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('040117', 'SACHACA', '0401');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('040118', 'SAN JUAN DE SIGUAS', '0401');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('040119', 'SAN JUAN DE TARUCANI', '0401');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('040120', 'SANTA ISABEL DE SIGUAS', '0401');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('040121', 'SANTA RITA DE SIGUAS', '0401');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('040122', 'SOCABAYA', '0401');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('040123', 'TIABAYA', '0401');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('040124', 'UCHUMAYO', '0401');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('040125', 'VITOR', '0401');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('040126', 'YANAHUARA', '0401');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('040127', 'YARABAMBA', '0401');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('040128', 'YURA', '0401');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('040129', 'JOSE LUIS BUSTAMANTE Y RIVERO', '0401');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('040201', 'CAMANA', '0402');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('040202', 'JOSE MARIA QUIMPER', '0402');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('040203', 'MARIANO NICOLAS VALCARCEL', '0402');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('040204', 'MARISCAL CACERES', '0402');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('040205', 'NICOLAS DE PIEROLA', '0402');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('040206', 'OCOÑA', '0402');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('040207', 'QUILCA', '0402');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('040208', 'SAMUEL PASTOR', '0402');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('040301', 'CARAVELI', '0403');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('040302', 'ACARI', '0403');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('040303', 'ATICO', '0403');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('040304', 'ATIQUIPA', '0403');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('040305', 'BELLA UNION', '0403');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('040306', 'CAHUACHO', '0403');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('040307', 'CHALA', '0403');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('040308', 'CHAPARRA', '0403');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('040309', 'HUANUHUANU', '0403');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('040310', 'JAQUI', '0403');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('040311', 'LOMAS', '0403');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('040312', 'QUICACHA', '0403');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('040313', 'YAUCA', '0403');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('040401', 'APLAO', '0404');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('040402', 'ANDAGUA', '0404');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('040403', 'AYO', '0404');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('040404', 'CHACHAS', '0404');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('040405', 'CHILCAYMARCA', '0404');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('040406', 'CHOCO', '0404');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('040407', 'HUANCARQUI', '0404');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('040408', 'MACHAGUAY', '0404');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('040409', 'ORCOPAMPA', '0404');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('040410', 'PAMPACOLCA', '0404');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('040411', 'TIPAN', '0404');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('040412', 'UÑON', '0404');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('040413', 'URACA', '0404');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('040414', 'VIRACO', '0404');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('040501', 'CHIVAY', '0405');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('040502', 'ACHOMA', '0405');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('040503', 'CABANACONDE', '0405');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('040504', 'CALLALLI', '0405');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('040505', 'CAYLLOMA', '0405');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('040506', 'COPORAQUE', '0405');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('040507', 'HUAMBO', '0405');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('040508', 'HUANCA', '0405');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('040509', 'ICHUPAMPA', '0405');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('040510', 'LARI', '0405');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('040511', 'LLUTA', '0405');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('040512', 'MACA', '0405');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('040513', 'MADRIGAL', '0405');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('040514', 'SAN ANTONIO DE CHUCA', '0405');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('040515', 'SIBAYO', '0405');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('040516', 'TAPAY', '0405');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('040517', 'TISCO', '0405');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('040518', 'TUTI', '0405');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('040519', 'YANQUE', '0405');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('040520', 'MAJES', '0405');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('040601', 'CHUQUIBAMBA', '0406');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('040602', 'ANDARAY', '0406');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('040603', 'CAYARANI', '0406');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('040604', 'CHICHAS', '0406');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('040605', 'IRAY', '0406');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('040606', 'RIO GRANDE', '0406');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('040607', 'SALAMANCA', '0406');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('040608', 'YANAQUIHUA', '0406');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('040701', 'MOLLENDO', '0407');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('040702', 'COCACHACRA', '0407');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('040703', 'DEAN VALDIVIA', '0407');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('040704', 'ISLAY', '0407');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('040705', 'MEJIA', '0407');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('040706', 'PUNTA DE BOMBON', '0407');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('040801', 'COTAHUASI', '0408');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('040802', 'ALCA', '0408');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('040803', 'CHARCANA', '0408');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('040804', 'HUAYNACOTAS', '0408');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('040805', 'PAMPAMARCA', '0408');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('040806', 'PUYCA', '0408');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('040807', 'QUECHUALLA', '0408');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('040808', 'SAYLA', '0408');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('040809', 'TAURIA', '0408');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('040810', 'TOMEPAMPA', '0408');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('040811', 'TORO', '0408');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('050101', 'AYACUCHO', '0501');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('050102', 'ACOCRO', '0501');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('050103', 'ACOS VINCHOS', '0501');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('050104', 'CARMEN ALTO', '0501');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('050105', 'CHIARA', '0501');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('050106', 'OCROS', '0501');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('050107', 'PACAYCASA', '0501');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('050108', 'QUINUA', '0501');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('050109', 'SAN JOSE DE TICLLAS', '0501');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('050110', 'SAN JUAN BAUTISTA', '0501');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('050111', 'SANTIAGO DE PISCHA', '0501');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('050112', 'SOCOS', '0501');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('050113', 'TAMBILLO', '0501');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('050114', 'VINCHOS', '0501');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('050115', 'JESUS NAZARENO', '0501');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('050201', 'CANGALLO', '0502');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('050202', 'CHUSCHI', '0502');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('050203', 'LOS MOROCHUCOS', '0502');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('050204', 'MARIA PARADO DE BELLIDO', '0502');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('050205', 'PARAS', '0502');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('050206', 'TOTOS', '0502');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('050301', 'SANCOS', '0503');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('050302', 'CARAPO', '0503');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('050303', 'SACSAMARCA', '0503');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('050304', 'SANTIAGO DE LUCANAMARCA', '0503');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('050401', 'HUANTA', '0504');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('050402', 'AYAHUANCO', '0504');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('050403', 'HUAMANGUILLA', '0504');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('050404', 'IGUAIN', '0504');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('050405', 'LURICOCHA', '0504');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('050406', 'SANTILLANA', '0504');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('050407', 'SIVIA', '0504');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('050408', 'LLOCHEGUA', '0504');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('050501', 'SAN MIGUEL', '0505');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('050502', 'ANCO', '0505');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('050503', 'AYNA', '0505');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('050504', 'CHILCAS', '0505');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('050505', 'CHUNGUI', '0505');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('050506', 'LUIS CARRANZA', '0505');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('050507', 'SANTA ROSA', '0505');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('050508', 'TAMBO', '0505');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('050601', 'PUQUIO', '0506');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('050602', 'AUCARA', '0506');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('050603', 'CABANA', '0506');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('050604', 'CARMEN SALCEDO', '0506');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('050605', 'CHAVIÑA', '0506');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('050606', 'CHIPAO', '0506');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('050607', 'HUAC-HUAS', '0506');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('050608', 'LARAMATE', '0506');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('050609', 'LEONCIO PRADO', '0506');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('050610', 'LLAUTA', '0506');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('050611', 'LUCANAS', '0506');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('050612', 'OCAÑA', '0506');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('050613', 'OTOCA', '0506');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('050614', 'SAISA', '0506');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('050615', 'SAN CRISTOBAL', '0506');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('050616', 'SAN JUAN', '0506');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('050617', 'SAN PEDRO', '0506');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('050618', 'SAN PEDRO DE PALCO', '0506');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('050619', 'SANCOS', '0506');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('050620', 'SANTA ANA DE HUAYCAHUACHO', '0506');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('050621', 'SANTA LUCIA', '0506');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('050701', 'CORACORA', '0507');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('050702', 'CHUMPI', '0507');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('050703', 'CORONEL CASTAÑEDA', '0507');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('050704', 'PACAPAUSA', '0507');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('050705', 'PULLO', '0507');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('050706', 'PUYUSCA', '0507');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('050707', 'SAN FRANCISCO DE RAVACAYCO', '0507');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('050708', 'UPAHUACHO', '0507');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('050801', 'PAUSA', '0508');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('050802', 'COLTA', '0508');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('050803', 'CORCULLA', '0508');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('050804', 'LAMPA', '0508');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('050805', 'MARCABAMBA', '0508');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('050806', 'OYOLO', '0508');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('050807', 'PARARCA', '0508');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('050808', 'SAN JAVIER DE ALPABAMBA', '0508');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('050809', 'SAN JOSE DE USHUA', '0508');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('050810', 'SARA SARA', '0508');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('050901', 'QUEROBAMBA', '0509');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('050902', 'BELEN', '0509');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('050903', 'CHALCOS', '0509');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('050904', 'CHILCAYOC', '0509');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('050905', 'HUACAÑA', '0509');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('050906', 'MORCOLLA', '0509');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('050907', 'PAICO', '0509');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('050908', 'SAN PEDRO DE LARCAY', '0509');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('050909', 'SAN SALVADOR DE QUIJE', '0509');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('050910', 'SANTIAGO DE PAUCARAY', '0509');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('050911', 'SORAS', '0509');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('051001', 'HUANCAPI', '0510');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('051002', 'ALCAMENCA', '0510');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('051003', 'APONGO', '0510');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('051004', 'ASQUIPATA', '0510');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('051005', 'CANARIA', '0510');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('051006', 'CAYARA', '0510');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('051007', 'COLCA', '0510');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('051008', 'HUAMANQUIQUIA', '0510');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('051009', 'HUANCARAYLLA', '0510');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('051010', 'HUAYA', '0510');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('051011', 'SARHUA', '0510');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('051012', 'VILCANCHOS', '0510');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('051101', 'VILCAS HUAMAN', '0511');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('051102', 'ACCOMARCA', '0511');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('051103', 'CARHUANCA', '0511');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('051104', 'CONCEPCION', '0511');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('051105', 'HUAMBALPA', '0511');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('051106', 'INDEPENDENCIA', '0511');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('051107', 'SAURAMA', '0511');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('051108', 'VISCHONGO', '0511');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('060101', 'CAJAMARCA', '0601');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('060102', 'ASUNCION', '0601');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('060103', 'CHETILLA', '0601');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('060104', 'COSPAN', '0601');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('060105', 'ENCAÑADA', '0601');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('060106', 'JESUS', '0601');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('060107', 'LLACANORA', '0601');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('060108', 'LOS BAÑOS DEL INCA', '0601');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('060109', 'MAGDALENA', '0601');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('060110', 'MATARA', '0601');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('060111', 'NAMORA', '0601');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('060112', 'SAN JUAN', '0601');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('060201', 'CAJABAMBA', '0602');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('060202', 'CACHACHI', '0602');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('060203', 'CONDEBAMBA', '0602');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('060204', 'SITACOCHA', '0602');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('060301', 'CELENDIN', '0603');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('060302', 'CHUMUCH', '0603');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('060303', 'CORTEGANA', '0603');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('060304', 'HUASMIN', '0603');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('060305', 'JORGE CHAVEZ', '0603');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('060306', 'JOSE GALVEZ', '0603');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('060307', 'MIGUEL IGLESIAS', '0603');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('060308', 'OXAMARCA', '0603');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('060309', 'SOROCHUCO', '0603');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('060310', 'SUCRE', '0603');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('060311', 'UTCO', '0603');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('060312', 'LA LIBERTAD DE PALLAN', '0603');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('060401', 'CHOTA', '0604');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('060402', 'ANGUIA', '0604');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('060403', 'CHADIN', '0604');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('060404', 'CHIGUIRIP', '0604');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('060405', 'CHIMBAN', '0604');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('060406', 'CHOROPAMPA', '0604');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('060407', 'COCHABAMBA', '0604');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('060408', 'CONCHAN', '0604');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('060409', 'HUAMBOS', '0604');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('060410', 'LAJAS', '0604');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('060411', 'LLAMA', '0604');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('060412', 'MIRACOSTA', '0604');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('060413', 'PACCHA', '0604');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('060414', 'PION', '0604');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('060415', 'QUEROCOTO', '0604');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('060416', 'SAN JUAN DE LICUPIS', '0604');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('060417', 'TACABAMBA', '0604');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('060418', 'TOCMOCHE', '0604');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('060419', 'CHALAMARCA', '0604');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('060501', 'CONTUMAZA', '0605');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('060502', 'CHILETE', '0605');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('060503', 'CUPISNIQUE', '0605');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('060504', 'GUZMANGO', '0605');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('060505', 'SAN BENITO', '0605');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('060506', 'SANTA CRUZ DE TOLED', '0605');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('060507', 'TANTARICA', '0605');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('060508', 'YONAN', '0605');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('060601', 'CUTERVO', '0606');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('060602', 'CALLAYUC', '0606');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('060603', 'CHOROS', '0606');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('060604', 'CUJILLO', '0606');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('060605', 'LA RAMADA', '0606');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('060606', 'PIMPINGOS', '0606');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('060607', 'QUEROCOTILLO', '0606');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('060608', 'SAN ANDRES DE CUTERVO', '0606');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('060609', 'SAN JUAN DE CUTERVO', '0606');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('060610', 'SAN LUIS DE LUCMA', '0606');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('060611', 'SANTA CRUZ', '0606');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('060612', 'SANTO DOMINGO DE LA CAPILLA', '0606');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('060613', 'SANTO TOMAS', '0606');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('060614', 'SOCOTA', '0606');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('060615', 'TORIBIO CASANOVA', '0606');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('060701', 'BAMBAMARCA', '0607');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('060702', 'CHUGUR', '0607');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('060703', 'HUALGAYOC', '0607');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('060801', 'JAEN', '0608');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('060802', 'BELLAVISTA', '0608');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('060803', 'CHONTALI', '0608');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('060804', 'COLASAY', '0608');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('060805', 'HUABAL', '0608');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('060806', 'LAS PIRIAS', '0608');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('060807', 'POMAHUACA', '0608');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('060808', 'PUCARA', '0608');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('060809', 'SALLIQUE', '0608');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('060810', 'SAN FELIPE', '0608');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('060811', 'SAN JOSE DEL ALTO', '0608');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('060812', 'SANTA ROSA', '0608');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('060901', 'SAN IGNACIO', '0609');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('060902', 'CHIRINOS', '0609');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('060903', 'HUARANGO', '0609');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('060904', 'LA COIPA', '0609');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('060905', 'NAMBALLE', '0609');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('060906', 'SAN JOSE DE LOURDES', '0609');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('060907', 'TABACONAS', '0609');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('061001', 'PEDRO GALVEZ', '0610');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('061002', 'CHANCAY', '0610');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('061003', 'EDUARDO VILLANUEVA', '0610');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('061004', 'GREGORIO PITA', '0610');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('061005', 'ICHOCAN', '0610');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('061006', 'JOSE MANUEL QUIROZ', '0610');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('061007', 'JOSE SABOGAL', '0610');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('061101', 'SAN MIGUEL', '0611');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('061102', 'BOLIVAR', '0611');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('061103', 'CALQUIS', '0611');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('061104', 'CATILLUC', '0611');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('061105', 'EL PRADO', '0611');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('061106', 'LA FLORIDA', '0611');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('061107', 'LLAPA', '0611');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('061108', 'NANCHOC', '0611');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('061109', 'NIEPOS', '0611');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('061110', 'SAN GREGORIO', '0611');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('061111', 'SAN SILVESTRE DE COCHAN', '0611');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('061112', 'TONGOD', '0611');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('061113', 'UNION AGUA BLANCA', '0611');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('061201', 'SAN PABLO', '0612');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('061202', 'SAN BERNARDINO', '0612');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('061203', 'SAN LUIS', '0612');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('061204', 'TUMBADEN', '0612');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('061301', 'SANTA CRUZ', '0613');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('061302', 'ANDABAMBA', '0613');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('061303', 'CATACHE', '0613');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('061304', 'CHANCAYBAÑOS', '0613');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('061305', 'LA ESPERANZA', '0613');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('061306', 'NINABAMBA', '0613');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('061307', 'PULAN', '0613');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('061308', 'SAUCEPAMPA', '0613');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('061309', 'SEXI', '0613');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('061310', 'UTICYACU', '0613');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('061311', 'YAUYUCAN', '0613');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('070101', 'CALLAO', '0701');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('070102', 'BELLAVISTA', '0701');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('070103', 'CARMEN DE LA LEGUA REYNOSO', '0701');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('070104', 'LA PERLA', '0701');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('070105', 'LA PUNTA', '0701');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('070106', 'VENTANILLA', '0701');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('080101', 'CUSCO', '0801');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('080102', 'CCORCA', '0801');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('080103', 'POROY', '0801');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('080104', 'SAN JERONIMO', '0801');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('080105', 'SAN SEBASTIAN', '0801');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('080106', 'SANTIAGO', '0801');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('080107', 'SAYLLA', '0801');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('080108', 'WANCHAQ', '0801');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('080201', 'ACOMAYO', '0802');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('080202', 'ACOPIA', '0802');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('080203', 'ACOS', '0802');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('080204', 'MOSOC LLACTA', '0802');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('080205', 'POMACANCHI', '0802');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('080206', 'RONDOCAN', '0802');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('080207', 'SANGARARA', '0802');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('080301', 'ANTA', '0803');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('080302', 'ANCAHUASI', '0803');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('080303', 'CACHIMAYO', '0803');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('080304', 'CHINCHAYPUJIO', '0803');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('080305', 'HUAROCONDO', '0803');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('080306', 'LIMATAMBO', '0803');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('080307', 'MOLLEPATA', '0803');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('080308', 'PUCYURA', '0803');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('080309', 'ZURITE', '0803');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('080401', 'CALCA', '0804');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('080402', 'COYA', '0804');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('080403', 'LAMAY', '0804');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('080404', 'LARES', '0804');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('080405', 'PISAC', '0804');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('080406', 'SAN SALVADOR', '0804');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('080407', 'TARAY', '0804');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('080408', 'YANATILE', '0804');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('080501', 'YANAOCA', '0805');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('080502', 'CHECCA', '0805');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('080503', 'KUNTURKANKI', '0805');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('080504', 'LANGUI', '0805');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('080505', 'LAYO', '0805');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('080506', 'PAMPAMARCA', '0805');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('080507', 'QUEHUE', '0805');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('080508', 'TUPAC AMARU', '0805');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('080601', 'SICUANI', '0806');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('080602', 'CHECACUPE', '0806');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('080603', 'COMBAPATA', '0806');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('080604', 'MARANGANI', '0806');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('080605', 'PITUMARCA', '0806');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('080606', 'SAN PABLO', '0806');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('080607', 'SAN PEDRO', '0806');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('080608', 'TINTA', '0806');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('080701', 'SANTO TOMAS', '0807');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('080702', 'CAPACMARCA', '0807');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('080703', 'CHAMACA', '0807');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('080704', 'COLQUEMARCA', '0807');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('080705', 'LIVITACA', '0807');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('080706', 'LLUSCO', '0807');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('080707', 'QUIÑOTA', '0807');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('080708', 'VELILLE', '0807');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('080801', 'ESPINAR', '0808');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('080802', 'CONDOROMA', '0808');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('080803', 'COPORAQUE', '0808');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('080804', 'OCORURO', '0808');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('080805', 'PALLPATA', '0808');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('080806', 'PICHIGUA', '0808');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('080807', 'SUYCKUTAMBO', '0808');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('080808', 'ALTO PICHIGUA', '0808');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('080901', 'SANTA ANA', '0809');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('080902', 'ECHARATE', '0809');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('080903', 'HUAYOPATA', '0809');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('080904', 'MARANURA', '0809');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('080905', 'OCOBAMBA', '0809');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('080906', 'QUELLOUNO', '0809');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('080907', 'KIMBIRI', '0809');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('080908', 'SANTA TERESA', '0809');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('080909', 'VILCABAMBA', '0809');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('080910', 'PICHARI', '0809');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('081001', 'PARURO', '0810');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('081002', 'ACCHA', '0810');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('081003', 'CCAPI', '0810');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('081004', 'COLCHA', '0810');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('081005', 'HUANOQUITE', '0810');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('081006', 'OMACHA', '0810');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('081007', 'PACCARITAMBO', '0810');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('081008', 'PILLPINTO', '0810');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('081009', 'YAURISQUE', '0810');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('081101', 'PAUCARTAMBO', '0811');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('081102', 'CAICAY', '0811');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('081103', 'CHALLABAMBA', '0811');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('081104', 'COLQUEPATA', '0811');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('081105', 'HUANCARANI', '0811');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('081106', 'KOSÑIPATA', '0811');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('081201', 'URCOS', '0812');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('081202', 'ANDAHUAYLILLAS', '0812');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('081203', 'CAMANTI', '0812');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('081204', 'CCARHUAYO', '0812');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('081205', 'CCATCA', '0812');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('081206', 'CUSIPATA', '0812');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('081207', 'HUARO', '0812');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('081208', 'LUCRE', '0812');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('081209', 'MARCAPATA', '0812');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('081210', 'OCONGATE', '0812');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('081211', 'OROPESA', '0812');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('081212', 'QUIQUIJANA', '0812');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('081301', 'URUBAMBA', '0813');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('081302', 'CHINCHERO', '0813');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('081303', 'HUAYLLABAMBA', '0813');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('081304', 'MACHUPICCHU', '0813');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('081305', 'MARAS', '0813');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('081306', 'OLLANTAYTAMBO', '0813');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('081307', 'YUCAY', '0813');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('090101', 'HUANCAVELICA', '0901');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('090102', 'ACOBAMBILLA', '0901');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('090103', 'ACORIA', '0901');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('090104', 'CONAYCA', '0901');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('090105', 'CUENCA', '0901');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('090106', 'HUACHOCOLPA', '0901');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('090107', 'HUAYLLAHUARA', '0901');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('090108', 'IZCUCHACA', '0901');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('090109', 'LARIA', '0901');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('090110', 'MANTA', '0901');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('090111', 'MARISCAL CACERES', '0901');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('090112', 'MOYA', '0901');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('090113', 'NUEVO OCCORO', '0901');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('090114', 'PALCA', '0901');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('090115', 'PILCHACA', '0901');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('090116', 'VILCA', '0901');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('090117', 'YAULI', '0901');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('090118', 'ASCENSION', '0901');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('090119', 'HUANDO', '0901');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('090201', 'ACOBAMBA', '0902');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('090202', 'ANDABAMBA', '0902');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('090203', 'ANTA', '0902');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('090204', 'CAJA', '0902');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('090205', 'MARCAS', '0902');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('090206', 'PAUCARA', '0902');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('090207', 'POMACOCHA', '0902');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('090208', 'ROSARIO', '0902');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('090301', 'LIRCAY', '0903');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('090302', 'ANCHONGA', '0903');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('090303', 'CALLANMARCA', '0903');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('090304', 'CCOCHACCASA', '0903');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('090305', 'CHINCHO', '0903');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('090306', 'CONGALLA', '0903');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('090307', 'HUANCA-HUANCA', '0903');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('090308', 'HUAYLLAY GRANDE', '0903');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('090309', 'JULCAMARCA', '0903');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('090310', 'SAN ANTONIO DE ANTAPARCO', '0903');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('090311', 'SANTO TOMAS DE PATA', '0903');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('090312', 'SECCLLA', '0903');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('090401', 'CASTROVIRREYNA', '0904');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('090402', 'ARMA', '0904');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('090403', 'AURAHUA', '0904');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('090404', 'CAPILLAS', '0904');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('090405', 'CHUPAMARCA', '0904');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('090406', 'COCAS', '0904');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('090407', 'HUACHOS', '0904');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('090408', 'HUAMATAMBO', '0904');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('090409', 'MOLLEPAMPA', '0904');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('090410', 'SAN JUAN', '0904');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('090411', 'SANTA ANA', '0904');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('090412', 'TANTARA', '0904');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('090413', 'TICRAPO', '0904');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('090501', 'CHURCAMPA', '0905');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('090502', 'ANCO', '0905');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('090503', 'CHINCHIHUASI', '0905');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('090504', 'EL CARMEN', '0905');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('090505', 'LA MERCED', '0905');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('090506', 'LOCROJA', '0905');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('090507', 'PAUCARBAMBA', '0905');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('090508', 'SAN MIGUEL DE MAYOCC', '0905');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('090509', 'SAN PEDRO DE CORIS', '0905');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('090510', 'PACHAMARCA', '0905');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('090601', 'HUAYTARA', '0906');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('090602', 'AYAVI', '0906');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('090603', 'CORDOVA', '0906');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('090604', 'HUAYACUNDO ARMA', '0906');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('090605', 'LARAMARCA', '0906');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('090606', 'OCOYO', '0906');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('090607', 'PILPICHACA', '0906');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('090608', 'QUERCO', '0906');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('090609', 'QUITO-ARMA', '0906');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('090610', 'SAN ANTONIO DE CUSICANCHA', '0906');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('090611', 'SAN FRANCISCO DE SANGAYAICO', '0906');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('090612', 'SAN ISIDRO', '0906');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('090613', 'SANTIAGO DE CHOCORVOS', '0906');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('090614', 'SANTIAGO DE QUIRAHUARA', '0906');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('090615', 'SANTO DOMINGO DE CAPILLAS', '0906');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('090616', 'TAMBO', '0906');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('090701', 'PAMPAS', '0907');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('090702', 'ACOSTAMBO', '0907');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('090703', 'ACRAQUIA', '0907');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('090704', 'AHUAYCHA', '0907');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('090705', 'COLCABAMBA', '0907');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('090706', 'DANIEL HERNANDEZ', '0907');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('090707', 'HUACHOCOLPA', '0907');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('090709', 'HUARIBAMBA', '0907');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('090710', 'ÑAHUIMPUQUIO', '0907');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('090711', 'PAZOS', '0907');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('090713', 'QUISHUAR', '0907');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('090714', 'SALCABAMBA', '0907');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('090715', 'SALCAHUASI', '0907');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('090716', 'SAN MARCOS DE ROCCHAC', '0907');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('090717', 'SURCUBAMBA', '0907');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('090718', 'TINTAY PUNCU', '0907');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('100101', 'HUANUCO', '1001');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('100102', 'AMARILIS', '1001');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('100103', 'CHINCHAO', '1001');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('100104', 'CHURUBAMBA', '1001');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('100105', 'MARGOS', '1001');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('100106', 'QUISQUI', '1001');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('100107', 'SAN FRANCISCO DE CAYRAN', '1001');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('100108', 'SAN PEDRO DE CHAULAN', '1001');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('100109', 'SANTA MARIA DEL VALLE', '1001');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('100110', 'YARUMAYO', '1001');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('100111', 'PILLCO MARCA', '1001');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('100201', 'AMBO', '1002');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('100202', 'CAYNA', '1002');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('100203', 'COLPAS', '1002');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('100204', 'CONCHAMARCA', '1002');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('100205', 'HUACAR', '1002');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('100206', 'SAN FRANCISCO', '1002');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('100207', 'SAN RAFAEL', '1002');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('100208', 'TOMAY KICHWA', '1002');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('100301', 'LA UNION', '1003');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('100307', 'CHUQUIS', '1003');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('100311', 'MARIAS', '1003');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('100313', 'PACHAS', '1003');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('100316', 'QUIVILLA', '1003');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('100317', 'RIPAN', '1003');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('100321', 'SHUNQUI', '1003');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('100322', 'SILLAPATA', '1003');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('100323', 'YANAS', '1003');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('100401', 'HUACAYBAMBA', '1004');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('100402', 'CANCHABAMBA', '1004');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('100403', 'COCHABAMBA', '1004');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('100404', 'PINRA', '1004');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('100501', 'LLATA', '1005');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('100502', 'ARANCAY', '1005');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('100503', 'CHAVIN DE PARIARCA', '1005');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('100504', 'JACAS GRANDE', '1005');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('100505', 'JIRCAN', '1005');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('100506', 'MIRAFLORES', '1005');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('100507', 'MONZON', '1005');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('100508', 'PUNCHAO', '1005');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('100509', 'PUÑOS', '1005');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('100510', 'SINGA', '1005');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('100511', 'TANTAMAYO', '1005');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('100601', 'RUPA-RUPA', '1006');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('100602', 'DANIEL ALOMIAS ROBLES', '1006');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('100603', 'HERMILIO VALDIZAN', '1006');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('100604', 'JOSE CRESPO Y CASTILLO', '1006');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('100605', 'LUYANDO', '1006');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('100606', 'MARIANO DAMASO BERAUN', '1006');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('100701', 'HUACRACHUCO', '1007');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('100702', 'CHOLON', '1007');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('100703', 'SAN BUENAVENTURA', '1007');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('100801', 'PANAO', '1008');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('100802', 'CHAGLLA', '1008');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('100803', 'MOLINO', '1008');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('100804', 'UMARI', '1008');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('100901', 'PUERTO INCA', '1009');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('100902', 'CODO DEL POZUZO', '1009');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('100903', 'HONORIA', '1009');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('100904', 'TOURNAVISTA', '1009');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('100905', 'YUYAPICHIS', '1009');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('101001', 'JESUS', '1010');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('101002', 'BAÑOS', '1010');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('101003', 'JIVIA', '1010');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('101004', 'QUEROPALCA', '1010');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('101005', 'RONDOS', '1010');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('101006', 'SAN FRANCISCO DE ASIS', '1010');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('101007', 'SAN MIGUEL DE CAURI', '1010');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('101101', 'CHAVINILLO', '1011');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('101102', 'CAHUAC', '1011');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('101103', 'CHACABAMBA', '1011');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('101104', 'APARICIO POMARES', '1011');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('101105', 'JACAS CHICO', '1011');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('101106', 'OBAS', '1011');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('101107', 'PAMPAMARCA', '1011');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('101108', 'CHORAS', '1011');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('110101', 'ICA', '1101');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('110102', 'LA TINGUIÑA', '1101');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('110103', 'LOS AQUIJES', '1101');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('110104', 'OCUCAJE', '1101');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('110105', 'PACHACUTEC', '1101');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('110106', 'PARCONA', '1101');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('110107', 'PUEBLO NUEVO', '1101');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('110108', 'SALAS', '1101');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('110109', 'SAN JOSE DE LOS MOLINOS', '1101');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('110110', 'SAN JUAN BAUTISTA', '1101');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('110111', 'SANTIAGO', '1101');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('110112', 'SUBTANJALLA', '1101');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('110113', 'TATE', '1101');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('110114', 'YAUCA DEL ROSARIO', '1101');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('110201', 'CHINCHA ALTA', '1102');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('110202', 'ALTO LARAN', '1102');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('110203', 'CHAVIN', '1102');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('110204', 'CHINCHA BAJA', '1102');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('110205', 'EL CARMEN', '1102');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('110206', 'GROCIO PRADO', '1102');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('110207', 'PUEBLO NUEVO', '1102');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('110208', 'SAN JUAN DE YANAC', '1102');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('110209', 'SAN PEDRO DE HUACARPANA', '1102');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('110210', 'SUNAMPE', '1102');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('110211', 'TAMBO DE MORA', '1102');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('110301', 'NAZCA', '1103');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('110302', 'CHANGUILLO', '1103');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('110303', 'EL INGENIO', '1103');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('110304', 'MARCONA', '1103');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('110305', 'VISTA ALEGRE', '1103');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('110401', 'PALPA', '1104');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('110402', 'LLIPATA', '1104');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('110403', 'RIO GRANDE', '1104');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('110404', 'SANTA CRUZ', '1104');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('110405', 'TIBILLO', '1104');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('110501', 'PISCO', '1105');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('110502', 'HUANCANO', '1105');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('110503', 'HUMAY', '1105');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('110504', 'INDEPENDENCIA', '1105');
INSERT INTO `tienda`.`distritos` (`id`, `nombre`, `provincias_id`) VALUES ('110505', 'PARACAS', '1105');

COMMIT;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
