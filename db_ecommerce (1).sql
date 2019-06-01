-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: 01-Jun-2019 às 05:46
-- Versão do servidor: 10.1.38-MariaDB
-- versão do PHP: 7.3.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_ecommerce`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_addresses_save` (`pidaddress` INT(11), `pidperson` INT(11), `pdesaddress` VARCHAR(128), `desnumber` VARCHAR(16), `pdescomplement` VARCHAR(32), `pdescity` VARCHAR(32), `pdesstate` VARCHAR(32), `pdescountry` VARCHAR(32), `pdeszipcode` CHAR(8), `pdesdistrict` VARCHAR(32))  BEGIN

	IF pidaddress > 0 THEN
		
		UPDATE tb_addresses
        SET
			idperson = pidperson,
            desaddress = pdesaddress,
            desnumber = pdesnumber,
            descomplement = pdescomplement,
            descity = pdescity,
            desstate = pdesstate,
            descountry = pdescountry,
            deszipcode = pdeszipcode, 
            desdistrict = pdesdistrict
		WHERE idaddress = pidaddress;
        
    ELSE
		
		INSERT INTO tb_addresses (idperson, desaddress, desnumber, descomplement, descity, desstate, descountry, deszipcode, desdistrict)
        VALUES(pidperson, pdesaddress, desnumber, pdescomplement, pdescity, pdesstate, pdescountry, pdeszipcode, pdesdistrict);
        
        SET pidaddress = LAST_INSERT_ID();
        
    END IF;
    
    SELECT * FROM tb_addresses WHERE idaddress = pidaddress;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_carts_save` (IN `pidcart` INT, IN `pdessessionid` VARCHAR(64), IN `piduser` INT, IN `pdeszipcode` CHAR(8), IN `pvlfreight` DECIMAL(10,2), IN `pnrdays` INT)  BEGIN

    IF pidcart > 0 THEN
        
        UPDATE tb_carts
        SET
            dessessionid = pdessessionid,
            iduser = piduser,
            deszipcode = pdeszipcode,
            vlfreight = pvlfreight,
            nrdays = pnrdays
        WHERE idcart = pidcart;
        
    ELSE
        
        INSERT INTO tb_carts (dessessionid, iduser, deszipcode, vlfreight, nrdays)
        VALUES(pdessessionid, piduser, pdeszipcode, pvlfreight, pnrdays);
        
        SET pidcart = LAST_INSERT_ID();
        
    END IF;
    
    SELECT * FROM tb_carts WHERE idcart = pidcart;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_categories_save` (`pidcategory` INT, `pdescategory` VARCHAR(64))  BEGIN
	
	IF pidcategory > 0 THEN
		
		UPDATE tb_categories
        SET descategory = pdescategory
        WHERE idcategory = pidcategory;
        
    ELSE
		
		INSERT INTO tb_categories (descategory) VALUES(pdescategory);
        
        SET pidcategory = LAST_INSERT_ID();
        
    END IF;
    
    SELECT * FROM tb_categories WHERE idcategory = pidcategory;
    
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_orders_save` (`pidorder` INT, `pidcart` INT(11), `piduser` INT(11), `pidstatus` INT(11), `pidaddress` INT(11), `pvltotal` DECIMAL(10,2))  BEGIN
	
	IF pidorder > 0 THEN
		
		UPDATE tb_orders
        SET
			idcart = pidcart,
            iduser = piduser,
            idstatus = pidstatus,
            idaddress = pidaddress,
            vltotal = pvltotal
		WHERE idorder = pidorder;
        
    ELSE
    
		INSERT INTO tb_orders (idcart, iduser, idstatus, idaddress, vltotal)
        VALUES(pidcart, piduser, pidstatus, pidaddress, pvltotal);
		
		SET pidorder = LAST_INSERT_ID();
        
    END IF;
    
    SELECT * 
    FROM tb_orders a
    INNER JOIN tb_ordersstatus b USING(idstatus)
    INNER JOIN tb_carts c USING(idcart)
    INNER JOIN tb_users d ON d.iduser = a.iduser
    INNER JOIN tb_addresses e USING(idaddress)
    WHERE idorder = pidorder;
    
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_products_save` (IN `pidproduct` INT(11), IN `pdesproduct` VARCHAR(64), IN `pvlprice` DECIMAL(10,2), IN `pvlwidth` DECIMAL(10,2), IN `pvlheight` DECIMAL(10,2), IN `pvllength` DECIMAL(10,2), IN `pvlweight` DECIMAL(10,2), IN `pdesurl` VARCHAR(128), IN `pdescricao` VARCHAR(128))  BEGIN
	
	IF pidproduct > 0 THEN
		
		UPDATE tb_products
        SET 
			desproduct = pdesproduct,
            vlprice = pvlprice,
            vlwidth = pvlwidth,
            vlheight = pvlheight,
            vllength = pvllength,
            vlweight = pvlweight,
            desurl = pdesurl,
            descricao = pdescricao
        WHERE idproduct = pidproduct;
        
    ELSE
		
		INSERT INTO tb_products (desproduct, vlprice, vlwidth, vlheight, vllength, vlweight, desurl,descricao) 
        VALUES(pdesproduct, pvlprice, pvlwidth, pvlheight, pvllength, pvlweight, pdesurl, pdescricao);
        
        SET pidproduct = LAST_INSERT_ID();
        
    END IF;
    
    SELECT * FROM tb_products WHERE idproduct = pidproduct;
    
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_userspasswordsrecoveries_create` (`piduser` INT, `pdesip` VARCHAR(45))  BEGIN
	
	INSERT INTO tb_userspasswordsrecoveries (iduser, desip)
    VALUES(piduser, pdesip);
    
    SELECT * FROM tb_userspasswordsrecoveries
    WHERE idrecovery = LAST_INSERT_ID();
    
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_usersupdate_save` (`piduser` INT, `pdesperson` VARCHAR(64), `pdeslogin` VARCHAR(64), `pdespassword` VARCHAR(256), `pdesemail` VARCHAR(128), `pnrphone` BIGINT, `pinadmin` TINYINT)  BEGIN
	
    DECLARE vidperson INT;
    
	SELECT idperson INTO vidperson
    FROM tb_users
    WHERE iduser = piduser;
    
    UPDATE tb_persons
    SET 
		desperson = pdesperson,
        desemail = pdesemail,
        nrphone = pnrphone
	WHERE idperson = vidperson;
    
    UPDATE tb_users
    SET
		deslogin = pdeslogin,
        despassword = pdespassword,
        inadmin = pinadmin
	WHERE iduser = piduser;
    
    SELECT * FROM tb_users a INNER JOIN tb_persons b USING(idperson) WHERE a.iduser = piduser;
    
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_users_delete` (`piduser` INT)  BEGIN
    
    DECLARE vidperson INT;
    
    SET FOREIGN_KEY_CHECKS = 0;
	
	SELECT idperson INTO vidperson
    FROM tb_users
    WHERE iduser = piduser;
	
    DELETE FROM tb_addresses WHERE idperson = vidperson;
    DELETE FROM tb_addresses WHERE idaddress IN(SELECT idaddress FROM tb_orders WHERE iduser = piduser);
	DELETE FROM tb_persons WHERE idperson = vidperson;
    
    DELETE FROM tb_userslogs WHERE iduser = piduser;
    DELETE FROM tb_userspasswordsrecoveries WHERE iduser = piduser;
    DELETE FROM tb_orders WHERE iduser = piduser;
    DELETE FROM tb_cartsproducts WHERE idcart IN(SELECT idcart FROM tb_carts WHERE iduser = piduser);
    DELETE FROM tb_carts WHERE iduser = piduser;
    DELETE FROM tb_users WHERE iduser = piduser;
    
    SET FOREIGN_KEY_CHECKS = 1;
    
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_users_save` (`pdesperson` VARCHAR(64), `pdeslogin` VARCHAR(64), `pdespassword` VARCHAR(256), `pdesemail` VARCHAR(128), `pnrphone` BIGINT, `pinadmin` TINYINT)  BEGIN
	
    DECLARE vidperson INT;
    
	INSERT INTO tb_persons (desperson, desemail, nrphone)
    VALUES(pdesperson, pdesemail, pnrphone);
    
    SET vidperson = LAST_INSERT_ID();
    
    INSERT INTO tb_users (idperson, deslogin, despassword, inadmin)
    VALUES(vidperson, pdeslogin, pdespassword, pinadmin);
    
    SELECT * FROM tb_users a INNER JOIN tb_persons b USING(idperson) WHERE a.iduser = LAST_INSERT_ID();
    
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `tb_addresses`
--

CREATE TABLE `tb_addresses` (
  `idaddress` int(11) NOT NULL,
  `idperson` int(11) NOT NULL,
  `desaddress` varchar(128) NOT NULL,
  `desnumber` varchar(16) NOT NULL,
  `descomplement` varchar(32) DEFAULT NULL,
  `descity` varchar(32) NOT NULL,
  `desstate` varchar(32) NOT NULL,
  `descountry` varchar(32) NOT NULL,
  `deszipcode` char(8) NOT NULL,
  `desdistrict` varchar(32) NOT NULL,
  `dtregister` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `tb_addresses`
--

INSERT INTO `tb_addresses` (`idaddress`, `idperson`, `desaddress`, `desnumber`, `descomplement`, `descity`, `desstate`, `descountry`, `deszipcode`, `desdistrict`, `dtregister`) VALUES
(1, 22, 'Rua Thalassa', '172', 'casa', 'Nova Lima', 'MG', 'Brasil', '34011030', 'Vale do Sol', '2019-05-28 14:02:48'),
(2, 22, 'Avenida Ademar Saraiva Leão', '187', '', 'São Bernardo do Campo', 'SP', 'Brasil', '0985312', 'Alvarenga', '2019-05-28 14:15:00'),
(3, 22, 'Avenida Ademar Saraiva Leão', '321', '', 'São Bernardo do Campo', 'SP', 'Brasil', '09853120', 'Alvarenga', '2019-05-28 14:16:15'),
(4, 22, 'Rua Santa Clara', '54', 'de 1 ao fim - lado ímpar', 'Rio de Janeiro', 'RJ', 'Brasil', '2204101', 'Copacabana', '2019-05-28 14:17:13'),
(5, 22, 'Rua Santa Clara', '45', 'de 1 ao fim - lado ímpar', 'Rio de Janeiro', 'RJ', 'Brasil', '22041011', 'Copacabana', '2019-05-28 14:18:12'),
(6, 22, 'Praça Centro Cívico', '548', 'até 499/500', 'Boa Vista', 'RR', 'Brasil', '69301380', 'Centro', '2019-05-28 14:20:07'),
(7, 22, 'Praça Centro Cívico', '500', 'até 499/500', 'Boa Vista', 'RR', 'Brasil', '6930138', 'Centro', '2019-05-28 14:21:09'),
(8, 22, 'Praça Centro Cívico', '500', 'até 499/500', 'Boa Vista', 'RR', 'Brasil', '6930138', 'Centro', '2019-05-28 14:29:29'),
(9, 22, 'Rua Santa Clara', '4', 'de 1 ao fim - lado ímpar', 'Rio de Janeiro', 'RJ', 'Brasil', '22041011', 'Copacabana', '2019-05-28 14:31:02'),
(10, 22, 'Avenida A', '747', 'casa', 'Belo Horizonte', 'MG', 'Brasil', '3067277', 'IndependÃªncia (Barreiro)', '2019-05-28 15:09:19'),
(11, 22, 'Avenida A', '231', 'casa', 'Belo Horizonte', 'MG', 'Brasil', '3067277', 'IndependÃªncia (Barreiro)', '2019-05-28 15:10:18'),
(12, 22, 'Rua Thalassa', '172', 'casa', 'Nova Lima', 'MG', 'Brasil', '34011030', 'Vale do Sol', '2019-05-28 15:39:17'),
(13, 22, 'Rua Thalassa', '172', 'casa', 'Nova Lima', 'MG', 'Brasil', '34011030', 'Vale do Sol', '2019-05-28 17:26:58'),
(14, 22, 'Rua 21 de Abril', '323', 'casa', 'São Paulo', 'SP', 'Brasil', '0304700', 'BrÃ¡s', '2019-05-28 17:28:01'),
(15, 22, 'Rua Thalassa', '172', 'casa', 'Nova Lima', 'MG', 'Brasil', '34011030', 'Vale do Sol', '2019-05-28 17:33:37'),
(16, 22, 'Rua 2 de Fevereiro', '231', '', 'São Paulo', 'SP', 'Brasil', '04236094', 'Cidade Nova HeliÃ³polis', '2019-05-28 17:38:10'),
(17, 22, 'Rua 2 de Fevereiro', '', '', 'São Paulo', 'SP', 'Brasil', '04236094', 'Cidade Nova HeliÃ³polis', '2019-05-28 17:53:06'),
(18, 22, 'Rua Thalassa', '', '', 'Nova Lima', 'MG', 'Brasil', '34011030', 'Vale do Sol', '2019-05-29 14:45:28'),
(19, 22, 'Rua Thalassa', '', '', 'Nova Lima', 'MG', 'Brasil', '34011030', 'Vale do Sol', '2019-05-29 14:58:08'),
(20, 22, 'Rua Thalassa', '', '', 'Nova Lima', 'MG', 'Brasil', '34011030', 'Vale do Sol', '2019-05-29 14:59:13'),
(21, 22, 'Rua Thalassa', '', '', 'Nova Lima', 'MG', 'Brasil', '34011030', 'Vale do Sol', '2019-05-29 14:59:50'),
(22, 22, 'Rua Thalassa', '172', 'casa', 'Nova Lima', 'MG', 'Brasil', '34011030', 'Vale do Sol', '2019-05-29 15:03:24'),
(23, 22, 'Rua Thalassa', '172', '', 'Nova Lima', 'MG', 'Brasil', '34011030', 'Vale do Sol', '2019-05-29 15:04:40'),
(24, 22, 'Rua Thalassa', '172', '', 'Nova Lima', 'MG', 'Brasil', '34011030', 'Vale do Sol', '2019-05-29 15:06:38'),
(25, 22, 'Rua Thalassa', '172', '', 'Nova Lima', 'MG', 'Brasil', '34011030', 'Vale do Sol', '2019-05-29 15:08:24'),
(26, 22, 'Rua Thalassa', '172', '', 'Nova Lima', 'MG', 'Brasil', '34011030', 'Vale do Sol', '2019-05-29 15:10:15'),
(27, 22, 'Rua Thalassa', '172', '', 'Nova Lima', 'MG', 'Brasil', '34011030', 'Vale do Sol', '2019-05-29 15:12:12'),
(28, 22, 'Rua Thalassa', '172', 'casa', 'Nova Lima', 'MG', 'Brasil', '34011030', 'Vale do Sol', '2019-05-29 15:14:32'),
(29, 22, 'Rua Thalassa', '172', 'casa', 'Nova Lima', 'MG', 'Brasil', '34011030', 'Vale do Sol', '2019-05-29 15:15:15'),
(30, 22, 'Rua Thalassa', '172', 'casa', 'Nova Lima', 'MG', 'Brasil', '34011030', 'Vale do Sol', '2019-05-29 15:15:43'),
(31, 22, 'Rua Thalassa', '172', 'casa', 'Nova Lima', 'MG', 'Brasil', '34011030', 'Vale do Sol', '2019-05-29 15:19:26'),
(32, 22, 'Rua Thalassa', '172', 'casa', 'Nova Lima', 'MG', 'Brasil', '34011030', 'Vale do Sol', '2019-05-29 15:19:54'),
(33, 22, 'Rua Thalassa', '172', 'casa', 'Nova Lima', 'MG', 'Brasil', '34011030', 'Vale do Sol', '2019-05-29 15:21:16'),
(34, 22, 'Rua Thalassa', '172', '', 'Nova Lima', 'MG', 'Brasil', '34011030', 'Vale do Sol', '2019-05-29 15:22:20'),
(35, 22, 'Rua Thalassa', '172', 'casa', 'Nova Lima', 'MG', 'Brasil', '34011030', 'Vale do Sol', '2019-05-29 15:23:25'),
(36, 22, 'Rua Thalassa', '172', 'casa', 'Nova Lima', 'MG', 'Brasil', '34011030', 'Vale do Sol', '2019-05-29 15:24:06'),
(37, 22, 'Rua Thalassa', '', '', 'Nova Lima', 'MG', 'Brasil', '34011030', 'Vale do Sol', '2019-05-29 15:24:48'),
(38, 22, 'Rua Thalassa', '1721', 'casa', 'Nova Lima', 'MG', 'Brasil', '34011030', 'Vale do Sol', '2019-05-29 15:25:29'),
(39, 22, 'Rua Thalassa', '1721', 'casa', 'Nova Lima', 'MG', 'Brasil', '34011030', 'Vale do Sol', '2019-05-29 15:25:31'),
(40, 22, 'Rua Thalassa', '1721', 'casa', 'Nova Lima', 'MG', 'Brasil', '34011030', 'Vale do Sol', '2019-05-29 15:25:32'),
(41, 22, 'Rua Thalassa', '1721', 'casa', 'Nova Lima', 'MG', 'Brasil', '34011030', 'Vale do Sol', '2019-05-29 15:25:33'),
(42, 22, 'Rua Thalassa', '1721', 'casa', 'Nova Lima', 'MG', 'Brasil', '34011030', 'Vale do Sol', '2019-05-29 15:25:33'),
(43, 22, 'Rua Thalassa', '1721', 'casa', 'Nova Lima', 'MG', 'Brasil', '34011030', 'Vale do Sol', '2019-05-29 15:25:33'),
(44, 22, 'Rua Thalassa', '1721', 'casa', 'Nova Lima', 'MG', 'Brasil', '34011030', 'Vale do Sol', '2019-05-29 15:25:46'),
(45, 22, 'Rua Thalassa', '', '', 'Nova Lima', 'MG', 'Brasil', '34011030', 'Vale do Sol', '2019-05-29 15:25:58'),
(46, 22, 'Rua Thalassa', '', '', 'Nova Lima', 'MG', 'Brasil', '34011030', 'Vale do Sol', '2019-05-29 15:30:17'),
(53, 22, 'Rua Thalassa', '', '', 'Nova Lima', 'MG', 'Brasil', '34011030', 'Vale do Sol', '2019-05-30 16:11:07'),
(54, 22, 'Rua Thalassa', '', '', 'Nova Lima', 'MG', 'Brasil', '34011030', 'Vale do Sol', '2019-05-30 16:14:51'),
(55, 22, 'Rua Thalassa', '', '', 'Nova Lima', 'MG', 'Brasil', '23545-03', 'Vale do Sol', '2019-05-30 16:57:51'),
(56, 22, 'Rua 11', '', '(Vl Alzira I)', 'Rio de Janeiro', 'RJ', 'Brasil', '23580440', 'PaciÃªncia', '2019-05-30 17:06:01'),
(57, 22, 'Rua 11', '435', '(Vl Alzira I)', 'Rio de Janeiro', 'RJ', 'Brasil', '23580440', 'PaciÃªncia', '2019-05-30 17:49:34'),
(58, 22, 'Rua 11', '435', '(Vl Alzira I)', 'Rio de Janeiro', 'RJ', 'Brasil', '23580440', 'PaciÃªncia', '2019-05-30 17:53:34'),
(59, 22, 'Rua 11', '321', '(Vl Alzira I)', 'Rio de Janeiro', 'RJ', 'Brasil', '23580440', 'PaciÃªncia', '2019-05-30 17:55:28'),
(60, 22, 'Rua 11', '32', '(Vl Alzira I)', 'Rio de Janeiro', 'RJ', 'Brasil', '23580440', 'PaciÃªncia', '2019-05-30 17:56:16'),
(61, 22, 'Rua 11', '32', '(Vl Alzira I)', 'Rio de Janeiro', 'RJ', 'Brasil', '23580440', 'PaciÃªncia', '2019-05-30 17:57:11'),
(62, 22, 'Rua 11', '32', '(Vl Alzira I)', 'Rio de Janeiro', 'RJ', 'Brasil', '23580440', 'PaciÃªncia', '2019-05-30 17:59:23'),
(63, 22, 'Rua 11', '98', '(Vl Alzira I)', 'Rio de Janeiro', 'RJ', 'Brasil', '23580440', 'PaciÃªncia', '2019-05-30 18:03:13'),
(65, 22, 'Rua Thalassa', '1721', '', 'Nova Lima', 'MG', 'Brasil', '34011030', 'Vale do Sol', '2019-05-31 11:15:19'),
(66, 37, 'Avenida Geraldo Athayde', '23', 'de 1 ao fim - lado ímpar', 'Montes Claros', 'MG', 'Brasil', '39400292', 'Alto SÃ£o JoÃ£o', '2019-06-01 03:43:25');

-- --------------------------------------------------------

--
-- Estrutura da tabela `tb_carts`
--

CREATE TABLE `tb_carts` (
  `idcart` int(11) NOT NULL,
  `dessessionid` varchar(64) NOT NULL,
  `iduser` int(11) DEFAULT NULL,
  `deszipcode` char(8) DEFAULT NULL,
  `vlfreight` decimal(10,2) DEFAULT NULL,
  `nrdays` int(11) DEFAULT NULL,
  `dtregister` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `tb_carts`
--

INSERT INTO `tb_carts` (`idcart`, `dessessionid`, `iduser`, `deszipcode`, `vlfreight`, `nrdays`, `dtregister`) VALUES
(1, '8hcko3j7hmgp8sv7ggnseueupv', NULL, '22041080', NULL, 2, '2017-09-04 18:50:50'),
(2, 'm8iq807es95o2hj1a30772df1d', NULL, '21615338', '72.92', 2, '2017-09-06 13:12:50'),
(4, 'a8frnbabuqu60gguivlmrpagin', NULL, '01310100', '61.12', 1, '2017-09-08 11:39:01'),
(5, '51jglmd9n3cdirc1ah75m31pt1', NULL, NULL, NULL, NULL, '2017-09-14 11:26:39'),
(6, 'tlvjs3tas1bml5uit8b5qgjn9l', NULL, '01310100', '42.79', 1, '2017-09-21 13:18:21'),
(8, 'pfpfh71r5l2mbh51no3tq0rrqp', NULL, NULL, NULL, NULL, '2019-05-23 12:57:56'),
(9, '37ft58jcd8ffqmjleeg4ofloq4', NULL, NULL, NULL, NULL, '2019-05-23 13:14:12'),
(10, '7hd6g87ld4mt074r1aq7csskcf', NULL, '', '0.00', 0, '2019-05-23 13:16:55'),
(11, 't24q14shkmq8o8aeuheblbms3n', NULL, '05407002', '54.58', 3, '2019-05-23 15:37:27'),
(12, 'nomv7fdkn695h6uhe3gcncgeok', NULL, NULL, NULL, NULL, '2019-05-24 03:01:22'),
(13, '3guuabg30otgkj40tl02jpkn4v', NULL, NULL, NULL, NULL, '2019-05-24 03:01:22'),
(14, '6mko2c8l8issmn29vm7v12l3je', NULL, NULL, NULL, NULL, '2019-05-24 12:54:12'),
(15, 'blk2svmikpf03cbl66kk33pvv9', NULL, NULL, NULL, NULL, '2019-05-24 12:54:13'),
(16, '0cog88n593cm0df8j0g50c4365', NULL, NULL, NULL, NULL, '2019-05-24 13:31:50'),
(17, 'pgefrmkbhirajauekjdbgloipo', NULL, '22041080', '151.46', 2, '2019-05-24 14:06:35'),
(18, 't53vuem2iu9d0n1qn19mctaeor', NULL, NULL, NULL, NULL, '2019-05-24 16:53:07'),
(19, 'cqsu2u3sn3td9vf9134ldgd8e7', NULL, NULL, NULL, NULL, '2019-05-24 16:58:32'),
(20, '800g9f4gnvk3neacl5jrkfjivn', NULL, NULL, NULL, NULL, '2019-05-24 17:03:06'),
(21, 'n1l10d58vhpgfu591fn86qoa7q', NULL, NULL, NULL, NULL, '2019-05-24 17:09:38'),
(22, 'npd3rhpqbpq54oev2avppdsjan', NULL, '34011030', NULL, NULL, '2019-05-24 17:31:54'),
(23, 'quuhrnlsdkrhg2d3dvm70sm8ak', NULL, NULL, NULL, NULL, '2019-05-24 19:05:51'),
(24, 'd7forn9oqpogt17jhtls5e0d9f', NULL, NULL, NULL, NULL, '2019-05-24 20:51:11'),
(25, '7cct46q9pboi6ik9a5ql0injh7', NULL, NULL, NULL, NULL, '2019-05-24 20:53:28'),
(26, 'q92a8e352dg0p4rtt972gmac16', NULL, NULL, NULL, NULL, '2019-05-24 22:57:47'),
(27, '8e5urtdo637hnd8v8do6ndsph5', NULL, NULL, NULL, NULL, '2019-05-24 22:57:47'),
(28, 'o3f91pc8h6jv9tgmrhgfle7667', NULL, '34011030', '0.00', 0, '2019-05-25 09:56:28'),
(29, 'ivl3eij7ulhebsv2hgc4nl3r8d', NULL, '34011030', '0.00', 0, '2019-05-26 13:19:56'),
(30, 'f6ad0e8o6fb0d9ig5rg009arm7', NULL, NULL, NULL, NULL, '2019-05-27 01:27:48'),
(31, '24t2hpobj6i74mqcs0d9k694eh', NULL, NULL, NULL, NULL, '2019-05-27 01:44:36'),
(32, 'i63avci716mclfdpqvhvhifpar', NULL, NULL, NULL, NULL, '2019-05-27 02:34:28'),
(33, 'rf2ebugjj2vp5kbfllmitrdne0', NULL, '34011030', '0.00', 0, '2019-05-27 12:19:49'),
(34, 'su1fdhohplgjedi6c1hekpj66f', NULL, NULL, NULL, NULL, '2019-05-27 16:46:50'),
(35, '43q05sfh2sq6g5917pf5fa9ism', NULL, NULL, NULL, NULL, '2019-05-27 16:50:33'),
(36, '16u57v4cneuuc98ar3i1860lef', NULL, NULL, NULL, NULL, '2019-05-27 17:18:20'),
(37, 'kg1t0ij0rn6j2ghjfjqdcteg3u', NULL, '34011030', '27.23', 1, '2019-05-27 18:49:47'),
(38, '91u38gp34d52u57dbect3jf72n', NULL, NULL, NULL, NULL, '2019-05-27 19:23:15'),
(39, 'jibuu2gf4e8h65is4k76glqgk8', NULL, NULL, NULL, NULL, '2019-05-27 22:12:49'),
(40, 'o5dlh9uo3lcl38814pp73fr39h', NULL, '34011030', '27.23', 1, '2019-05-28 02:19:16'),
(41, '91cnc84vcbeu633uubqpcuru4s', NULL, '23545-03', NULL, NULL, '2019-05-28 02:24:47'),
(42, 'rum31abimgh7dio551gn4rmudh', NULL, '34011030', '21.21', 1, '2019-05-28 12:09:10'),
(43, 'jfmih5h23ajp6ds8stdr4b2r8i', NULL, '22041011', '36.01', 2, '2019-05-28 14:29:40'),
(44, 'dja4v6stmpplhe8l8re66br4ig', NULL, '34011030', '21.21', 1, '2019-05-28 15:37:40'),
(45, '56l4svgpv66m76lhgqohalphpk', NULL, '04236094', '36.01', 3, '2019-05-28 17:36:25'),
(46, 'n9k32feanjlmpiu2fjeghgh046', 22, NULL, NULL, NULL, '2019-05-29 03:19:55'),
(47, 'oih34r73s9c05pnq04as1n9dj3', NULL, NULL, NULL, NULL, '2019-05-29 03:27:07'),
(48, 'q45jn2hgoeplr7unaen3bak490', NULL, '34011030', '21.21', 1, '2019-05-29 12:26:57'),
(49, '3c8lg7nogs7qj5op7fsr3aie83', NULL, '34011030', '0.00', 0, '2019-05-29 13:25:27'),
(50, 'obeldfcr2v6paduv1t3ss66dil', NULL, '34011030', '57.55', 1, '2019-05-29 15:02:28'),
(51, 'ut7cpasjp12j9cnklfghfo43gb', NULL, '57086037', '75.11', 7, '2019-05-29 15:59:26'),
(52, 'au3gccv4evcpgbthm9ubcavmip', NULL, '34011030', NULL, NULL, '2019-05-29 17:30:28'),
(53, '5rcm7s89d9d1p59ebjacib7gte', NULL, '34011030', NULL, NULL, '2019-05-29 17:34:11'),
(54, 'g9qofip418ibumm8j8ts2m2re4', NULL, '34011030', '23.53', 1, '2019-05-29 17:53:20'),
(55, 'gcqq1s0akrlalvfvbu2j7bs36s', NULL, '34011030', '21.21', 1, '2019-05-29 20:01:15'),
(56, 'vf2rtsjnhd8o7mgd7008pio7ph', NULL, NULL, NULL, NULL, '2019-05-29 20:01:27'),
(57, 'actgbl1ctq1co58olh6vp9h5ck', NULL, '34011030', '0.00', 0, '2019-05-30 00:04:03'),
(58, '9r8noam67qc4q0tu7vg16cg5vi', NULL, '34011030', '27.23', 1, '2019-05-30 01:13:22'),
(59, 'snmm5mfmaa3ch3urmuol1r3c08', NULL, '34011030', '22.81', 5, '2019-05-30 12:44:48'),
(60, '71osavaesat6m2ja515gan5971', NULL, NULL, NULL, NULL, '2019-05-30 15:48:46'),
(61, '3anvh1ueff7umtllm0kce6c3pk', NULL, NULL, NULL, NULL, '2019-05-30 15:52:15'),
(62, 'mecmt6vop22grqng05drl83np9', NULL, NULL, NULL, NULL, '2019-05-30 15:54:06'),
(63, 'u0dpks9qj1bm51hrnfsc19hrq9', NULL, '23580440', '23.41', 5, '2019-05-30 15:54:51'),
(64, 'h4p31cqhu70oba9o0tp0u4jg5t', NULL, '2354503', '26.95', 13, '2019-05-30 16:55:34'),
(65, 'f6tt6asvd5aker1nncs7pn77so', NULL, NULL, NULL, NULL, '2019-05-30 18:50:52'),
(66, '7ani5thssp3gcvuv515ouml6u4', NULL, NULL, NULL, NULL, '2019-05-31 02:34:06'),
(67, 'hvdkkr46aqhc1qocs9gcmkrapm', NULL, '34011030', '30.71', 5, '2019-05-31 10:25:57'),
(68, 'grk0tp9si3p0vr7impirk8pec2', NULL, NULL, NULL, NULL, '2019-05-31 13:12:01'),
(69, 'irs364os3oeh0kam8dc974hsqt', NULL, NULL, NULL, NULL, '2019-05-31 14:25:51'),
(70, 'ktpn61pa30unpbv571ttaerpb5', NULL, NULL, NULL, NULL, '2019-05-31 15:48:30'),
(71, 'mmkqo3gdrq7pkvmpc5829oases', NULL, NULL, NULL, NULL, '2019-05-31 19:27:56'),
(72, '5m8edum5kl81p14jen9p4rtbdq', NULL, NULL, NULL, NULL, '2019-05-31 19:27:56'),
(73, '697qiqpcookaeoph343d11rp1k', NULL, '34011030', '0.00', 0, '2019-05-31 22:03:29'),
(74, 'ecu48hef67a7nm9u4rrr335qnd', NULL, NULL, NULL, NULL, '2019-05-31 22:07:49'),
(75, 'g8pjkubspc6v4jq3edstnqmlml', NULL, NULL, NULL, NULL, '2019-05-31 22:11:41'),
(76, 'qtvll575r3f9q80egbp6oe4iha', NULL, NULL, NULL, NULL, '2019-05-31 22:13:29'),
(77, '45aoq5o709oqq7rq1h4h7g7fk5', NULL, '39400292', '23.85', 6, '2019-06-01 02:51:03'),
(78, '3f0g1bcmah5k6ona4ouqrl0hpt', NULL, NULL, NULL, NULL, '2019-06-01 03:16:22');

-- --------------------------------------------------------

--
-- Estrutura da tabela `tb_cartsproducts`
--

CREATE TABLE `tb_cartsproducts` (
  `idcartproduct` int(11) NOT NULL,
  `idcart` int(11) NOT NULL,
  `idproduct` int(11) NOT NULL,
  `dtremoved` datetime DEFAULT NULL,
  `dtregister` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `tb_cartsproducts`
--

INSERT INTO `tb_cartsproducts` (`idcartproduct`, `idcart`, `idproduct`, `dtremoved`, `dtregister`) VALUES
(145, 59, 19, '2019-05-30 11:42:57', '2019-05-30 14:27:59'),
(146, 59, 20, '2019-05-30 11:38:35', '2019-05-30 14:31:17'),
(147, 59, 21, '2019-05-30 11:36:46', '2019-05-30 14:34:31'),
(148, 59, 21, '2019-05-30 11:39:45', '2019-05-30 14:37:13'),
(149, 59, 21, '2019-05-30 11:39:45', '2019-05-30 14:39:26'),
(150, 59, 20, '2019-05-30 11:42:53', '2019-05-30 14:39:57'),
(151, 59, 21, '2019-05-30 11:40:50', '2019-05-30 14:40:33'),
(152, 59, 23, '2019-05-30 11:46:22', '2019-05-30 14:42:42'),
(153, 59, 19, '2019-05-30 11:46:24', '2019-05-30 14:44:56'),
(154, 59, 23, '2019-05-30 12:10:13', '2019-05-30 14:46:27'),
(155, 59, 20, '2019-05-30 11:55:55', '2019-05-30 14:52:56'),
(156, 59, 23, '2019-05-30 12:14:28', '2019-05-30 15:10:16'),
(157, 59, 23, '2019-05-30 12:18:20', '2019-05-30 15:14:14'),
(158, 59, 23, '2019-05-30 12:18:36', '2019-05-30 15:18:28'),
(159, 59, 22, '2019-05-30 12:19:10', '2019-05-30 15:18:46'),
(160, 59, 23, NULL, '2019-05-30 15:19:12'),
(161, 59, 23, NULL, '2019-05-30 15:19:20'),
(162, 63, 23, '2019-05-30 14:49:15', '2019-05-30 16:10:23'),
(163, 64, 23, NULL, '2019-05-30 16:55:58'),
(164, 64, 20, NULL, '2019-05-30 16:56:25'),
(165, 63, 20, '2019-05-30 14:40:44', '2019-05-30 17:03:16'),
(166, 63, 19, '2019-05-30 14:54:49', '2019-05-30 17:46:45'),
(167, 63, 19, '2019-05-30 14:54:49', '2019-05-30 17:46:52'),
(168, 63, 20, '2019-05-30 15:01:58', '2019-05-30 17:54:44'),
(169, 63, 19, NULL, '2019-05-30 17:56:03'),
(170, 63, 20, '2019-05-30 15:01:58', '2019-05-30 18:01:36'),
(171, 67, 20, '2019-05-31 08:04:57', '2019-05-31 11:00:17'),
(172, 67, 21, '2019-05-31 08:03:00', '2019-05-31 11:00:28'),
(173, 67, 21, '2019-05-31 08:03:04', '2019-05-31 11:01:18'),
(174, 67, 22, '2019-05-31 08:03:13', '2019-05-31 11:02:57'),
(175, 67, 21, '2019-05-31 08:04:43', '2019-05-31 11:03:02'),
(176, 67, 21, '2019-05-31 08:04:46', '2019-05-31 11:03:07'),
(177, 67, 21, '2019-05-31 08:04:48', '2019-05-31 11:03:55'),
(178, 67, 21, '2019-05-31 08:04:50', '2019-05-31 11:03:55'),
(179, 67, 21, '2019-05-31 08:04:51', '2019-05-31 11:03:55'),
(180, 67, 21, '2019-05-31 08:04:53', '2019-05-31 11:03:57'),
(181, 67, 21, '2019-05-31 08:05:01', '2019-05-31 11:03:58'),
(182, 67, 21, '2019-05-31 08:05:05', '2019-05-31 11:03:59'),
(183, 67, 21, '2019-05-31 08:05:09', '2019-05-31 11:04:06'),
(184, 67, 19, '2019-05-31 08:04:55', '2019-05-31 11:04:09'),
(185, 67, 19, '2019-05-31 08:05:16', '2019-05-31 11:04:12'),
(186, 67, 20, '2019-05-31 08:09:42', '2019-05-31 11:04:13'),
(187, 67, 21, '2019-05-31 08:09:29', '2019-05-31 11:05:07'),
(188, 67, 19, '2019-05-31 08:11:40', '2019-05-31 11:05:12'),
(189, 67, 21, '2019-05-31 08:09:30', '2019-05-31 11:09:25'),
(190, 67, 21, '2019-05-31 08:09:36', '2019-05-31 11:09:25'),
(191, 67, 21, '2019-05-31 08:11:44', '2019-05-31 11:09:25'),
(192, 67, 19, '2019-05-31 08:11:43', '2019-05-31 11:09:48'),
(193, 67, 19, NULL, '2019-05-31 11:09:51'),
(194, 67, 21, '2019-05-31 08:11:46', '2019-05-31 11:11:34'),
(195, 67, 21, '2019-05-31 08:13:57', '2019-05-31 11:11:35'),
(196, 67, 21, '2019-05-31 08:14:00', '2019-05-31 11:11:49'),
(197, 67, 21, '2019-05-31 08:14:14', '2019-05-31 11:11:50'),
(198, 67, 21, '2019-05-31 08:15:05', '2019-05-31 11:11:53'),
(199, 67, 21, NULL, '2019-05-31 11:14:52'),
(200, 73, 23, NULL, '2019-05-31 22:03:42'),
(201, 77, 20, '2019-06-01 00:31:57', '2019-06-01 03:31:51'),
(202, 77, 20, '2019-06-01 00:31:58', '2019-06-01 03:31:53'),
(203, 77, 20, '2019-06-01 00:32:02', '2019-06-01 03:31:54'),
(204, 77, 20, '2019-06-01 00:32:02', '2019-06-01 03:32:00'),
(205, 77, 20, '2019-06-01 00:32:04', '2019-06-01 03:32:00'),
(206, 77, 20, '2019-06-01 00:32:06', '2019-06-01 03:32:01'),
(207, 77, 20, NULL, '2019-06-01 03:32:05');

-- --------------------------------------------------------

--
-- Estrutura da tabela `tb_categories`
--

CREATE TABLE `tb_categories` (
  `idcategory` int(11) NOT NULL,
  `descategory` varchar(32) NOT NULL,
  `dtregister` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `tb_categories`
--

INSERT INTO `tb_categories` (`idcategory`, `descategory`, `dtregister`) VALUES
(4, 'ManutenÃ§Ã£o', '2019-05-23 13:10:30'),
(5, 'Orquideas', '2019-05-23 13:10:36'),
(6, 'Cultivo', '2019-05-23 13:10:41');

-- --------------------------------------------------------

--
-- Estrutura da tabela `tb_cupons`
--

CREATE TABLE `tb_cupons` (
  `id` int(11) NOT NULL,
  `nome` varchar(10) NOT NULL,
  `valor` int(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `tb_cupons`
--

INSERT INTO `tb_cupons` (`id`, `nome`, `valor`) VALUES
(2, 'vitor', 20),
(4, 'dois', 5),
(6, 'teste', 5);

-- --------------------------------------------------------

--
-- Estrutura da tabela `tb_emails`
--

CREATE TABLE `tb_emails` (
  `id` int(11) NOT NULL,
  `email` varchar(110) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `tb_emails`
--

INSERT INTO `tb_emails` (`id`, `email`) VALUES
(1, 'vitn47@gmail.com');

-- --------------------------------------------------------

--
-- Estrutura da tabela `tb_orders`
--

CREATE TABLE `tb_orders` (
  `idorder` int(11) NOT NULL,
  `idcart` int(11) NOT NULL,
  `iduser` int(11) NOT NULL,
  `idstatus` int(11) NOT NULL,
  `idaddress` int(11) NOT NULL,
  `vltotal` decimal(10,2) NOT NULL,
  `dtregister` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `tb_orders`
--

INSERT INTO `tb_orders` (`idorder`, `idcart`, `iduser`, `idstatus`, `idaddress`, `vltotal`, `dtregister`) VALUES
(66, 77, 37, 1, 66, '90.85', '2019-06-01 03:43:27');

-- --------------------------------------------------------

--
-- Estrutura da tabela `tb_ordersstatus`
--

CREATE TABLE `tb_ordersstatus` (
  `idstatus` int(11) NOT NULL,
  `desstatus` varchar(32) NOT NULL,
  `dtregister` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `tb_ordersstatus`
--

INSERT INTO `tb_ordersstatus` (`idstatus`, `desstatus`, `dtregister`) VALUES
(1, 'Em Aberto', '2017-03-13 03:00:00'),
(2, 'Aguardando Pagamento', '2017-03-13 03:00:00'),
(3, 'Pago', '2017-03-13 03:00:00'),
(4, 'Entregue', '2017-03-13 03:00:00');

-- --------------------------------------------------------

--
-- Estrutura da tabela `tb_persons`
--

CREATE TABLE `tb_persons` (
  `idperson` int(11) NOT NULL,
  `desperson` varchar(64) NOT NULL,
  `desemail` varchar(128) DEFAULT NULL,
  `nrphone` bigint(20) DEFAULT NULL,
  `dtregister` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `tb_persons`
--

INSERT INTO `tb_persons` (`idperson`, `desperson`, `desemail`, `nrphone`, `dtregister`) VALUES
(22, 'vitor', 'vitn47@gmail.com', 2312, '2019-05-27 14:22:52'),
(26, 'vitor', 'fd@teste.com.br', 121, '2019-05-27 22:46:01'),
(37, 'yuri', 'yuri@gmail.com', 565, '2019-06-01 02:51:43'),
(42, 'criandos', 'criandos@gmail.com', 123213, '2019-06-01 03:07:59'),
(43, 'ult', 'ult@gmail.com', 231, '2019-06-01 03:08:23');

-- --------------------------------------------------------

--
-- Estrutura da tabela `tb_products`
--

CREATE TABLE `tb_products` (
  `idproduct` int(11) NOT NULL,
  `desproduct` varchar(64) NOT NULL,
  `vlprice` decimal(10,2) NOT NULL,
  `vlwidth` decimal(10,2) NOT NULL,
  `vlheight` decimal(10,2) NOT NULL,
  `vllength` decimal(10,2) NOT NULL,
  `vlweight` decimal(10,2) NOT NULL,
  `desurl` varchar(128) NOT NULL,
  `dtregister` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `descricao` varchar(1000) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `tb_products`
--

INSERT INTO `tb_products` (`idproduct`, `desproduct`, `vlprice`, `vlwidth`, `vlheight`, `vllength`, `vlweight`, `desurl`, `dtregister`, `descricao`) VALUES
(19, 'Laelia', '20.00', '11.00', '20.00', '20.00', '0.30', 'laelia', '2019-05-30 14:27:22', 'teste'),
(20, 'pumila', '67.00', '11.00', '20.00', '20.00', '0.30', 'pumila', '2019-05-30 14:31:06', 'e'),
(21, 'Dendrobium', '20.00', '11.00', '20.00', '20.00', '0.30', 'dendrobium', '2019-05-30 14:34:00', 'de'),
(22, 'Bicolor', '890.00', '11.00', '20.00', '20.00', '0.30', 'bicolor', '2019-05-30 14:41:27', 'b'),
(23, 'vaso', '10.00', '11.00', '5.00', '16.00', '0.80', 'vaso', '2019-05-30 14:42:27', 'v');

-- --------------------------------------------------------

--
-- Estrutura da tabela `tb_productscategories`
--

CREATE TABLE `tb_productscategories` (
  `idcategory` int(11) NOT NULL,
  `idproduct` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `tb_users`
--

CREATE TABLE `tb_users` (
  `iduser` int(11) NOT NULL,
  `idperson` int(11) NOT NULL,
  `deslogin` varchar(64) NOT NULL,
  `despassword` varchar(256) NOT NULL,
  `inadmin` tinyint(4) NOT NULL DEFAULT '0',
  `dtregister` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `tb_users`
--

INSERT INTO `tb_users` (`iduser`, `idperson`, `deslogin`, `despassword`, `inadmin`, `dtregister`) VALUES
(22, 22, 'vitor', '$2y$12$lQwLuZPGra4oV3KYEssihO1Sn2HlcSsdlfmxKTCtrPRhRTH/Qmnw6', 1, '2019-05-27 14:23:03'),
(26, 26, 'fd@teste.com.br', '$2y$12$viixrB94U6r4VWgVTYpN8e2DlOpxG71wA0qDX9DuP5bWNsR2zR/Wm', 0, '2019-05-27 22:46:01'),
(37, 37, 'yuri', '$2y$12$yOlu1UgLesoFiHBMYllpQuX.ERNgvP/pg3SwpV7jlCNlLHr9dTGqW', 1, '2019-06-01 02:51:43'),
(42, 42, 'criandos@gmail.com', '$2y$12$GdqHuc51Xk4XTNBBOMO0venkkw0m.JDz6K6moZBUsQorkDKhgrOUy', 0, '2019-06-01 03:07:59'),
(43, 43, 'ult', '$2y$12$gF7x2b3PrqYExRXf.KvpKO.qN7pqn1QHX01sjQT8O1PLzgoTDxbgm', 1, '2019-06-01 03:08:23');

-- --------------------------------------------------------

--
-- Estrutura da tabela `tb_userslogs`
--

CREATE TABLE `tb_userslogs` (
  `idlog` int(11) NOT NULL,
  `iduser` int(11) NOT NULL,
  `deslog` varchar(128) NOT NULL,
  `desip` varchar(45) NOT NULL,
  `desuseragent` varchar(128) NOT NULL,
  `dessessionid` varchar(64) NOT NULL,
  `desurl` varchar(128) NOT NULL,
  `dtregister` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `tb_userspasswordsrecoveries`
--

CREATE TABLE `tb_userspasswordsrecoveries` (
  `idrecovery` int(11) NOT NULL,
  `iduser` int(11) NOT NULL,
  `desip` varchar(45) NOT NULL,
  `dtrecovery` datetime DEFAULT NULL,
  `dtregister` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `tb_userspasswordsrecoveries`
--

INSERT INTO `tb_userspasswordsrecoveries` (`idrecovery`, `iduser`, `desip`, `dtrecovery`, `dtregister`) VALUES
(13, 22, '127.0.0.1', '2019-05-27 11:24:03', '2019-05-27 14:23:40'),
(14, 22, '127.0.0.1', '2019-05-27 12:50:45', '2019-05-27 15:50:04'),
(15, 22, '::1', '2019-05-28 14:59:09', '2019-05-28 17:58:34');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `tb_addresses`
--
ALTER TABLE `tb_addresses`
  ADD PRIMARY KEY (`idaddress`),
  ADD KEY `fk_addresses_persons_idx` (`idperson`);

--
-- Indexes for table `tb_carts`
--
ALTER TABLE `tb_carts`
  ADD PRIMARY KEY (`idcart`),
  ADD KEY `FK_carts_users_idx` (`iduser`);

--
-- Indexes for table `tb_cartsproducts`
--
ALTER TABLE `tb_cartsproducts`
  ADD PRIMARY KEY (`idcartproduct`),
  ADD KEY `FK_cartsproducts_carts_idx` (`idcart`),
  ADD KEY `fk_cartsproducts_products_idx` (`idproduct`);

--
-- Indexes for table `tb_categories`
--
ALTER TABLE `tb_categories`
  ADD PRIMARY KEY (`idcategory`);

--
-- Indexes for table `tb_cupons`
--
ALTER TABLE `tb_cupons`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tb_emails`
--
ALTER TABLE `tb_emails`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tb_orders`
--
ALTER TABLE `tb_orders`
  ADD PRIMARY KEY (`idorder`),
  ADD KEY `FK_orders_users_idx` (`iduser`),
  ADD KEY `fk_orders_ordersstatus_idx` (`idstatus`),
  ADD KEY `fk_orders_carts_idx` (`idcart`),
  ADD KEY `fk_orders_addresses_idx` (`idaddress`);

--
-- Indexes for table `tb_ordersstatus`
--
ALTER TABLE `tb_ordersstatus`
  ADD PRIMARY KEY (`idstatus`);

--
-- Indexes for table `tb_persons`
--
ALTER TABLE `tb_persons`
  ADD PRIMARY KEY (`idperson`);

--
-- Indexes for table `tb_products`
--
ALTER TABLE `tb_products`
  ADD PRIMARY KEY (`idproduct`);

--
-- Indexes for table `tb_productscategories`
--
ALTER TABLE `tb_productscategories`
  ADD PRIMARY KEY (`idcategory`,`idproduct`),
  ADD KEY `fk_productscategories_products_idx` (`idproduct`);

--
-- Indexes for table `tb_users`
--
ALTER TABLE `tb_users`
  ADD PRIMARY KEY (`iduser`),
  ADD KEY `FK_users_persons_idx` (`idperson`);

--
-- Indexes for table `tb_userslogs`
--
ALTER TABLE `tb_userslogs`
  ADD PRIMARY KEY (`idlog`),
  ADD KEY `fk_userslogs_users_idx` (`iduser`);

--
-- Indexes for table `tb_userspasswordsrecoveries`
--
ALTER TABLE `tb_userspasswordsrecoveries`
  ADD PRIMARY KEY (`idrecovery`),
  ADD KEY `fk_userspasswordsrecoveries_users_idx` (`iduser`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `tb_addresses`
--
ALTER TABLE `tb_addresses`
  MODIFY `idaddress` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=67;

--
-- AUTO_INCREMENT for table `tb_carts`
--
ALTER TABLE `tb_carts`
  MODIFY `idcart` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=79;

--
-- AUTO_INCREMENT for table `tb_cartsproducts`
--
ALTER TABLE `tb_cartsproducts`
  MODIFY `idcartproduct` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=208;

--
-- AUTO_INCREMENT for table `tb_categories`
--
ALTER TABLE `tb_categories`
  MODIFY `idcategory` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `tb_cupons`
--
ALTER TABLE `tb_cupons`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `tb_emails`
--
ALTER TABLE `tb_emails`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `tb_orders`
--
ALTER TABLE `tb_orders`
  MODIFY `idorder` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=67;

--
-- AUTO_INCREMENT for table `tb_ordersstatus`
--
ALTER TABLE `tb_ordersstatus`
  MODIFY `idstatus` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `tb_persons`
--
ALTER TABLE `tb_persons`
  MODIFY `idperson` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=44;

--
-- AUTO_INCREMENT for table `tb_products`
--
ALTER TABLE `tb_products`
  MODIFY `idproduct` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `tb_users`
--
ALTER TABLE `tb_users`
  MODIFY `iduser` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=44;

--
-- AUTO_INCREMENT for table `tb_userslogs`
--
ALTER TABLE `tb_userslogs`
  MODIFY `idlog` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tb_userspasswordsrecoveries`
--
ALTER TABLE `tb_userspasswordsrecoveries`
  MODIFY `idrecovery` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- Constraints for dumped tables
--

--
-- Limitadores para a tabela `tb_addresses`
--
ALTER TABLE `tb_addresses`
  ADD CONSTRAINT `fk_addresses_persons` FOREIGN KEY (`idperson`) REFERENCES `tb_persons` (`idperson`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Limitadores para a tabela `tb_carts`
--
ALTER TABLE `tb_carts`
  ADD CONSTRAINT `fk_carts_users` FOREIGN KEY (`iduser`) REFERENCES `tb_users` (`iduser`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Limitadores para a tabela `tb_cartsproducts`
--
ALTER TABLE `tb_cartsproducts`
  ADD CONSTRAINT `fk_cartsproducts_carts` FOREIGN KEY (`idcart`) REFERENCES `tb_carts` (`idcart`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_cartsproducts_products` FOREIGN KEY (`idproduct`) REFERENCES `tb_products` (`idproduct`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Limitadores para a tabela `tb_orders`
--
ALTER TABLE `tb_orders`
  ADD CONSTRAINT `fk_orders_addresses` FOREIGN KEY (`idaddress`) REFERENCES `tb_addresses` (`idaddress`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_orders_carts` FOREIGN KEY (`idcart`) REFERENCES `tb_carts` (`idcart`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_orders_ordersstatus` FOREIGN KEY (`idstatus`) REFERENCES `tb_ordersstatus` (`idstatus`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_orders_users` FOREIGN KEY (`iduser`) REFERENCES `tb_users` (`iduser`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Limitadores para a tabela `tb_productscategories`
--
ALTER TABLE `tb_productscategories`
  ADD CONSTRAINT `fk_productscategories_categories` FOREIGN KEY (`idcategory`) REFERENCES `tb_categories` (`idcategory`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_productscategories_products` FOREIGN KEY (`idproduct`) REFERENCES `tb_products` (`idproduct`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Limitadores para a tabela `tb_users`
--
ALTER TABLE `tb_users`
  ADD CONSTRAINT `fk_users_persons` FOREIGN KEY (`idperson`) REFERENCES `tb_persons` (`idperson`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Limitadores para a tabela `tb_userslogs`
--
ALTER TABLE `tb_userslogs`
  ADD CONSTRAINT `fk_userslogs_users` FOREIGN KEY (`iduser`) REFERENCES `tb_users` (`iduser`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Limitadores para a tabela `tb_userspasswordsrecoveries`
--
ALTER TABLE `tb_userspasswordsrecoveries`
  ADD CONSTRAINT `fk_userspasswordsrecoveries_users` FOREIGN KEY (`iduser`) REFERENCES `tb_users` (`iduser`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
