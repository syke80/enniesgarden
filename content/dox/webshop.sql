-- phpMyAdmin SQL Dump
-- version 3.5.1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Aug 26, 2013 at 07:50 PM
-- Server version: 5.5.24-log
-- PHP Version: 5.4.3

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `fachet`
--

-- --------------------------------------------------------

--
-- Table structure for table `category`
--

CREATE TABLE IF NOT EXISTS `category` (
  `id_category` bigint(20) NOT NULL AUTO_INCREMENT,
  `id_shop` bigint(20) NOT NULL,
  `permalink` varchar(255) NOT NULL,
  `name` tinytext NOT NULL,
  PRIMARY KEY (`id_category`),
  UNIQUE KEY `id_shop` (`id_shop`,`permalink`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=49 ;

-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

CREATE TABLE IF NOT EXISTS `customer` (
  `id_customer` bigint(20) NOT NULL AUTO_INCREMENT,
  `id_shop` bigint(20) DEFAULT NULL,
  `email` varchar(128) NOT NULL,
  `passw` char(32) NOT NULL,
  `phone` tinytext NOT NULL,
  `shipping_name` tinytext NOT NULL,
  `shipping_address` tinytext NOT NULL,
  `shipping_city` tinytext NOT NULL,
  `shipping_postcode` varchar(32) NOT NULL,
  `billing_name` tinytext NOT NULL,
  `billing_address` tinytext NOT NULL,
  `billing_city` tinytext NOT NULL,
  `billing_postcode` varchar(32) NOT NULL,
  PRIMARY KEY (`id_customer`),
  UNIQUE KEY `id_shop` (`id_shop`,`email`),
  KEY `passw` (`passw`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `language`
--

CREATE TABLE IF NOT EXISTS `language` (
  `id_language` tinyint(4) NOT NULL AUTO_INCREMENT,
  `iso` char(2) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_language`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `language`
--

INSERT INTO `language` (`id_language`, `iso`, `name`) VALUES
(1, 'en', 'English'),
(2, 'hu', 'Magyar'),
(3, 'de', 'Deutsch');

-- --------------------------------------------------------

--
-- Table structure for table `order`
--

CREATE TABLE IF NOT EXISTS `order` (
  `id_order` bigint(20) NOT NULL AUTO_INCREMENT,
  `id_shop` bigint(20) NOT NULL,
  `email` tinytext NOT NULL,
  `phone` tinytext NOT NULL,
  `shipping_name` tinytext NOT NULL,
  `shipping_address` tinytext NOT NULL,
  `shipping_city` tinytext NOT NULL,
  `shipping_postcode` varchar(32) NOT NULL,
  `billing_name` tinytext NOT NULL,
  `billing_address` tinytext NOT NULL,
  `billing_city` tinytext NOT NULL,
  `billing_postcode` varchar(32) NOT NULL,
  `total` decimal(15,4) NOT NULL,
  `status` enum('pending','approved','shipped','canceled') NOT NULL DEFAULT 'pending',
  `date_order` datetime NOT NULL,
  `date_modified` datetime NOT NULL,
  PRIMARY KEY (`id_order`),
  KEY `id_shop` (`id_shop`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `order_product`
--

CREATE TABLE IF NOT EXISTS `order_product` (
  `id_order_product` bigint(20) NOT NULL AUTO_INCREMENT,
  `id_order` bigint(20) NOT NULL,
  `stock_id` varchar(255) NOT NULL,
  `name` tinytext NOT NULL,
  `quantity` int(11) NOT NULL,
  `total` decimal(15,4) NOT NULL,
  PRIMARY KEY (`id_order_product`),
  KEY `id_order` (`id_order`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `photo`
--

CREATE TABLE IF NOT EXISTS `photo` (
  `id_photo` bigint(20) NOT NULL AUTO_INCREMENT,
  `id_product` bigint(20) NOT NULL,
  `order` int(11) DEFAULT NULL,
  `filename` varchar(255) NOT NULL,
  PRIMARY KEY (`id_photo`),
  UNIQUE KEY `id_product_order` (`id_product`,`order`),
  KEY `id_product` (`id_product`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=25 ;

-- --------------------------------------------------------

--
-- Table structure for table `product`
--

CREATE TABLE IF NOT EXISTS `product` (
  `id_product` bigint(20) NOT NULL AUTO_INCREMENT,
  `id_category` bigint(20) NOT NULL,
  `permalink` varchar(255) NOT NULL,
  `stock_id` varchar(255) DEFAULT NULL,
  `name` tinytext NOT NULL,
  `short_description` mediumtext NOT NULL,
  `long_description` longtext NOT NULL,
  `price` int(11) DEFAULT NULL,
  `is_featured` enum('y','n') NOT NULL,
  `is_sale` enum('y','n') NOT NULL,
  PRIMARY KEY (`id_product`),
  UNIQUE KEY `id_category` (`id_category`,`permalink`),
  KEY `is_featured` (`is_featured`),
  KEY `is_sale` (`is_sale`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=85 ;

-- --------------------------------------------------------

--
-- Table structure for table `product_property_value`
--

CREATE TABLE IF NOT EXISTS `product_property_value` (
  `id_product` bigint(20) NOT NULL,
  `id_value` bigint(20) NOT NULL,
  PRIMARY KEY (`id_product`,`id_value`),
  KEY `id_value` (`id_value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `product_text`
--

CREATE TABLE IF NOT EXISTS `product_text` (
  `id_product` bigint(20) NOT NULL DEFAULT '0',
  `id_language` tinyint(4) NOT NULL DEFAULT '0',
  `name` tinytext,
  `permalink` varchar(255) DEFAULT NULL,
  `short_description` mediumtext,
  `long_description` longtext,
  PRIMARY KEY (`id_product`,`id_language`),
  KEY `id_language` (`id_language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `property`
--

CREATE TABLE IF NOT EXISTS `property` (
  `id_property` bigint(20) NOT NULL AUTO_INCREMENT,
  `id_category` bigint(20) NOT NULL,
  `name` tinytext NOT NULL,
  PRIMARY KEY (`id_property`),
  KEY `id_category` (`id_category`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=86 ;

-- --------------------------------------------------------

--
-- Table structure for table `property_value`
--

CREATE TABLE IF NOT EXISTS `property_value` (
  `id_value` bigint(20) NOT NULL AUTO_INCREMENT,
  `id_property` bigint(20) NOT NULL,
  `name` tinytext NOT NULL,
  PRIMARY KEY (`id_value`),
  KEY `id_property` (`id_property`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=22 ;

-- --------------------------------------------------------

--
-- Table structure for table `shop`
--

CREATE TABLE IF NOT EXISTS `shop` (
  `id_shop` bigint(20) NOT NULL AUTO_INCREMENT,
  `permalink` varchar(255) NOT NULL,
  `name` tinytext NOT NULL,
  `company_name` tinytext NOT NULL,
  `company_url` tinytext,
  `company_email` tinytext NOT NULL,
  `company_phone` tinytext NOT NULL,
  `company_address` tinytext NOT NULL,
  `company_city` tinytext NOT NULL,
  `company_postcode` tinytext NOT NULL,
  `company_country` tinytext NOT NULL,
  `company_description` tinytext,
  PRIMARY KEY (`id_shop`),
  UNIQUE KEY `permalink` (`permalink`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=18 ;

-- --------------------------------------------------------

--
-- Table structure for table `shop_language`
--

CREATE TABLE IF NOT EXISTS `shop_language` (
  `id_shop` bigint(20) DEFAULT NULL,
  `id_language` tinyint(4) DEFAULT NULL,
  KEY `shop_language_ibfk_1` (`id_shop`),
  KEY `shop_language_ibfk_2` (`id_language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE IF NOT EXISTS `user` (
  `id_user` bigint(20) NOT NULL AUTO_INCREMENT,
  `id_shop` bigint(20) DEFAULT NULL,
  `username` varchar(255) NOT NULL,
  `name` tinytext NOT NULL,
  `passw` char(32) NOT NULL,
  `email` tinytext NOT NULL,
  `reg_timestamp` datetime NOT NULL,
  `access` enum('root','shop_admin','stock_admin','inacive','disabled') NOT NULL,
  PRIMARY KEY (`id_user`),
  UNIQUE KEY `username` (`username`),
  KEY `id_shop` (`id_shop`),
  KEY `passw` (`passw`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=21 ;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id_user`, `id_shop`, `username`, `name`, `passw`, `email`, `reg_timestamp`, `access`) VALUES
(1, NULL, 'root', 'root', '25d55ad283aa400af464c76d713c07ad', 'webshop@sykeonline.com', '0000-00-00 00:00:00', 'root'),
(20, NULL, 'syke', 'Syke', '5f4dcc3b5aa765d61d8327deb882cf99', 'syke80@gmail.com', '2013-08-13 10:16:59', 'root');

--
-- Constraints for dumped tables
--

--
-- Constraints for table `category`
--
ALTER TABLE `category`
  ADD CONSTRAINT `category_ibfk_1` FOREIGN KEY (`id_shop`) REFERENCES `shop` (`id_shop`) ON DELETE CASCADE;

--
-- Constraints for table `customer`
--
ALTER TABLE `customer`
  ADD CONSTRAINT `customer_ibfk_2` FOREIGN KEY (`id_shop`) REFERENCES `shop` (`id_shop`) ON DELETE CASCADE;

--
-- Constraints for table `order`
--
ALTER TABLE `order`
  ADD CONSTRAINT `order_ibfk_1` FOREIGN KEY (`id_shop`) REFERENCES `shop` (`id_shop`);

--
-- Constraints for table `order_product`
--
ALTER TABLE `order_product`
  ADD CONSTRAINT `order_product_ibfk_3` FOREIGN KEY (`id_order`) REFERENCES `order` (`id_order`) ON DELETE CASCADE;

--
-- Constraints for table `photo`
--
ALTER TABLE `photo`
  ADD CONSTRAINT `photo_ibfk_1` FOREIGN KEY (`id_product`) REFERENCES `product` (`id_product`) ON DELETE CASCADE;

--
-- Constraints for table `product`
--
ALTER TABLE `product`
  ADD CONSTRAINT `product_ibfk_2` FOREIGN KEY (`id_category`) REFERENCES `category` (`id_category`) ON DELETE CASCADE;

--
-- Constraints for table `product_property_value`
--
ALTER TABLE `product_property_value`
  ADD CONSTRAINT `product_property_value_ibfk_3` FOREIGN KEY (`id_product`) REFERENCES `product` (`id_product`) ON DELETE CASCADE,
  ADD CONSTRAINT `product_property_value_ibfk_4` FOREIGN KEY (`id_value`) REFERENCES `property_value` (`id_value`) ON DELETE CASCADE;

--
-- Constraints for table `product_text`
--
ALTER TABLE `product_text`
  ADD CONSTRAINT `product_text_ibfk_1` FOREIGN KEY (`id_product`) REFERENCES `product` (`id_product`) ON DELETE CASCADE,
  ADD CONSTRAINT `product_text_ibfk_2` FOREIGN KEY (`id_language`) REFERENCES `language` (`id_language`) ON DELETE CASCADE;

--
-- Constraints for table `property`
--
ALTER TABLE `property`
  ADD CONSTRAINT `property_ibfk_1` FOREIGN KEY (`id_category`) REFERENCES `category` (`id_category`) ON DELETE CASCADE;

--
-- Constraints for table `property_value`
--
ALTER TABLE `property_value`
  ADD CONSTRAINT `property_value_ibfk_2` FOREIGN KEY (`id_property`) REFERENCES `property` (`id_property`) ON DELETE CASCADE;

--
-- Constraints for table `shop_language`
--
ALTER TABLE `shop_language`
  ADD CONSTRAINT `shop_language_ibfk_2` FOREIGN KEY (`id_language`) REFERENCES `language` (`id_language`) ON DELETE CASCADE,
  ADD CONSTRAINT `shop_language_ibfk_1` FOREIGN KEY (`id_shop`) REFERENCES `shop` (`id_shop`) ON DELETE CASCADE;

--
-- Constraints for table `user`
--
ALTER TABLE `user`
  ADD CONSTRAINT `user_ibfk_2` FOREIGN KEY (`id_shop`) REFERENCES `shop` (`id_shop`) ON DELETE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
