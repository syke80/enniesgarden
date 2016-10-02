-- phpMyAdmin SQL Dump
-- version 4.2.7
-- http://www.phpmyadmin.net
--
-- Host: localhost:3301
-- Generation Time: Aug 23, 2014 at 09:50 AM
-- Server version: 5.5.38-0ubuntu0.14.04.1
-- PHP Version: 5.5.9-1ubuntu4.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `enniesgarden`
--

-- --------------------------------------------------------

--
-- Table structure for table `category`
--

CREATE TABLE IF NOT EXISTS `category` (
`id_category` bigint(20) NOT NULL,
  `id_shop` bigint(20) NOT NULL,
  `factory_id` varchar(255) DEFAULT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=79 ;

--
-- Dumping data for table `category`
--

INSERT INTO `category` (`id_category`, `id_shop`, `factory_id`) VALUES
(76, 30, NULL),
(77, 30, NULL),
(78, 30, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `category_text`
--

CREATE TABLE IF NOT EXISTS `category_text` (
  `id_category` bigint(20) NOT NULL DEFAULT '0',
  `id_language` tinyint(4) NOT NULL DEFAULT '0',
  `permalink` varchar(255) DEFAULT NULL,
  `name` tinytext
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `category_text`
--

INSERT INTO `category_text` (`id_category`, `id_language`, `permalink`, `name`) VALUES
(76, 1, 'jam', 'Jam'),
(77, 1, 'marmalade', 'Marmalade'),
(78, 1, 'curd', 'Curd');

-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

CREATE TABLE IF NOT EXISTS `customer` (
`id_customer` bigint(20) NOT NULL,
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
  `billing_postcode` varchar(32) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `language`
--

CREATE TABLE IF NOT EXISTS `language` (
`id_language` tinyint(4) NOT NULL,
  `iso` char(2) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL
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
-- Table structure for table `menu`
--

CREATE TABLE IF NOT EXISTS `menu` (
`id_menu` bigint(20) NOT NULL,
  `name` varchar(255) DEFAULT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=6 ;

--
-- Dumping data for table `menu`
--

INSERT INTO `menu` (`id_menu`, `name`) VALUES
(5, 'ennies-garden-en');

-- --------------------------------------------------------

--
-- Table structure for table `menu_item`
--

CREATE TABLE IF NOT EXISTS `menu_item` (
`id_menu_item` int(11) NOT NULL,
  `id_menu` bigint(20) NOT NULL,
  `id_parent` int(11) DEFAULT NULL,
  `title` tinytext,
  `url` tinytext,
  `is_popup` enum('y','n') NOT NULL DEFAULT 'n',
  `order` int(11) NOT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=72 ;

--
-- Dumping data for table `menu_item`
--

INSERT INTO `menu_item` (`id_menu_item`, `id_menu`, `id_parent`, `title`, `url`, `is_popup`, `order`) VALUES
(67, 5, NULL, 'Home', '/', 'n', 0),
(68, 5, NULL, 'Jam', '/jam/', 'n', 0),
(69, 5, NULL, 'Marmalade', '/marmalade/', 'n', 0),
(70, 5, NULL, 'Curd', '/curd/', 'n', 0),
(71, 5, NULL, 'Basket', '/basket/', 'n', 0);

-- --------------------------------------------------------

--
-- Table structure for table `order`
--

CREATE TABLE IF NOT EXISTS `order` (
`id_order` bigint(20) NOT NULL,
  `id_shop` bigint(20) NOT NULL,
  `id_language` tinyint(20) NOT NULL,
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
  `shipping_cost` decimal(15,4) NOT NULL DEFAULT '0.0000',
  `total` decimal(15,4) NOT NULL,
  `shipping_status` enum('pending','approved','shipped','canceled') NOT NULL DEFAULT 'pending',
  `payment_status` enum('pending','success') NOT NULL DEFAULT 'pending',
  `id_shipping_method` int(11) NOT NULL,
  `id_payment_method` int(11) NOT NULL,
  `date_order` datetime NOT NULL,
  `date_modified` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `order_product`
--

CREATE TABLE IF NOT EXISTS `order_product` (
`id_order_product` bigint(20) NOT NULL,
  `id_order` bigint(20) NOT NULL,
  `stock_id` varchar(255) NOT NULL,
  `name` tinytext NOT NULL,
  `quantity` int(11) NOT NULL,
  `total` decimal(15,4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `pack`
--

CREATE TABLE IF NOT EXISTS `pack` (
`id_pack` bigint(20) NOT NULL,
  `id_shop` bigint(20) NOT NULL,
  `price` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `pack_photo`
--

CREATE TABLE IF NOT EXISTS `pack_photo` (
`id_photo` bigint(20) NOT NULL,
  `id_pack` bigint(20) NOT NULL,
  `order` int(11) DEFAULT NULL,
  `filename` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `pack_product`
--

CREATE TABLE IF NOT EXISTS `pack_product` (
  `id_pack` bigint(20) NOT NULL DEFAULT '0',
  `id_product` bigint(20) NOT NULL DEFAULT '0',
  `quantity` int(11) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `pack_text`
--

CREATE TABLE IF NOT EXISTS `pack_text` (
  `id_pack` bigint(20) NOT NULL DEFAULT '0',
  `id_language` tinyint(4) NOT NULL DEFAULT '0',
  `permalink` varchar(255) DEFAULT NULL,
  `name` tinytext,
  `short_description` mediumtext NOT NULL,
  `long_description` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `page`
--

CREATE TABLE IF NOT EXISTS `page` (
`id_page` bigint(20) NOT NULL,
  `id_site` varchar(255) DEFAULT NULL,
  `permalink` varchar(255) DEFAULT NULL,
  `id_category` bigint(20) DEFAULT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=12 ;

--
-- Dumping data for table `page`
--

INSERT INTO `page` (`id_page`, `id_site`, `permalink`, `id_category`) VALUES
(3, 'www', '', 2),
(11, 'www', '_footer-en', 1);

-- --------------------------------------------------------

--
-- Table structure for table `page_category`
--

CREATE TABLE IF NOT EXISTS `page_category` (
`id_category` bigint(20) NOT NULL,
  `id_site` varchar(255) NOT NULL,
  `name` varchar(255) DEFAULT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `page_category`
--

INSERT INTO `page_category` (`id_category`, `id_site`, `name`) VALUES
(1, 'www', 'hu'),
(2, 'www', 'en');

-- --------------------------------------------------------

--
-- Table structure for table `page_content`
--

CREATE TABLE IF NOT EXISTS `page_content` (
  `id_page` bigint(20) NOT NULL DEFAULT '0',
  `id_region` bigint(20) NOT NULL DEFAULT '0',
  `id_category` bigint(20) DEFAULT NULL,
  `content` longtext
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `page_content`
--

INSERT INTO `page_content` (`id_page`, `id_region`, `id_category`, `content`) VALUES
(3, 1, NULL, ''),
(3, 2, NULL, '<div class="featured">\n	<p>\n		<img alt="" src="/content/files/page/images/marmelade-croissant.jpg" style="width: 100%;" /></p>\n</div>\n'),
(3, 3, NULL, ''),
(3, 4, NULL, ''),
(3, 5, NULL, 'en'),
(3, 6, NULL, ''),
(11, 1, NULL, ''),
(11, 2, NULL, '<p>\n	Footer tartalma</p>\n'),
(11, 3, NULL, ''),
(11, 4, NULL, ''),
(11, 5, NULL, 'hu'),
(11, 6, NULL, '');

-- --------------------------------------------------------

--
-- Table structure for table `page_region`
--

CREATE TABLE IF NOT EXISTS `page_region` (
`id_region` bigint(20) NOT NULL,
  `id_site` varchar(255) DEFAULT NULL,
  `name` tinytext,
  `type` enum('wysiwyg','plaintext') NOT NULL DEFAULT 'plaintext'
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=7 ;

--
-- Dumping data for table `page_region`
--

INSERT INTO `page_region` (`id_region`, `id_site`, `name`, `type`) VALUES
(1, 'www', 'Title', 'plaintext'),
(2, 'www', 'Body', 'wysiwyg'),
(3, 'www', 'Keywords', 'plaintext'),
(4, 'www', 'Description', 'plaintext'),
(5, 'www', 'Language code', 'plaintext'),
(6, 'www', 'Aside', 'wysiwyg');

-- --------------------------------------------------------

--
-- Table structure for table `payment_method`
--

CREATE TABLE IF NOT EXISTS `payment_method` (
`id_payment_method` bigint(20) NOT NULL,
  `name` varchar(255) DEFAULT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=6 ;

--
-- Dumping data for table `payment_method`
--

INSERT INTO `payment_method` (`id_payment_method`, `name`) VALUES
(1, 'personal'),
(2, 'paypal'),
(3, 'cc'),
(4, 'cod'),
(5, 'wire_transfer');

-- --------------------------------------------------------

--
-- Table structure for table `product`
--

CREATE TABLE IF NOT EXISTS `product` (
`id_product` bigint(20) NOT NULL,
  `id_category` bigint(20) NOT NULL,
  `price` decimal(11,2) DEFAULT NULL,
  `is_featured` enum('y','n') NOT NULL DEFAULT 'n',
  `is_sale` enum('y','n') NOT NULL DEFAULT 'n',
  `barcode` varchar(13) DEFAULT NULL,
  `quantity` bigint(20) DEFAULT NULL,
  `id_supplier` bigint(20) DEFAULT NULL,
  `product_code` varchar(32) NOT NULL,
  `is_active` enum('y','n') NOT NULL DEFAULT 'y'
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1655 ;

--
-- Dumping data for table `product`
--

INSERT INTO `product` (`id_product`, `id_category`, `price`, `is_featured`, `is_sale`, `barcode`, `quantity`, `id_supplier`, `product_code`, `is_active`) VALUES
(1628, 76, 3.90, 'n', 'n', '', 0, 0, '', 'y'),
(1629, 76, 3.90, 'n', 'n', '', 0, 0, '', 'y'),
(1630, 76, 3.90, 'n', 'n', '', 0, 0, '', 'y'),
(1631, 76, 3.90, 'n', 'n', '', 0, 0, '', 'y'),
(1632, 76, 3.90, 'n', 'n', '', 0, 0, '', 'y'),
(1633, 76, 3.90, 'n', 'n', '', 0, 0, '', 'y'),
(1634, 76, 3.90, 'n', 'n', '', 0, 0, '', 'y'),
(1635, 76, 3.90, 'n', 'n', '', 0, 0, '', 'y'),
(1636, 76, 3.90, 'n', 'n', '', 0, 0, '', 'y'),
(1637, 76, 3.90, 'n', 'n', '', 0, 0, '', 'y'),
(1638, 76, 3.90, 'n', 'n', '', 0, 0, '', 'y'),
(1639, 76, 3.90, 'n', 'n', '', 0, 0, '', 'y'),
(1640, 76, 3.90, 'n', 'n', '', 0, 0, '', 'y'),
(1641, 76, 3.90, 'n', 'n', '', 0, 0, '', 'y'),
(1642, 78, 3.90, 'n', 'n', '', 0, 0, '', 'y'),
(1643, 78, 3.90, 'n', 'n', '', 0, 0, '', 'y'),
(1644, 78, 3.90, 'n', 'n', '', 0, 0, '', 'y'),
(1645, 78, 3.90, 'n', 'n', '', 0, 0, '', 'y'),
(1646, 78, 3.90, 'n', 'n', '', 0, 0, '', 'y'),
(1647, 77, 3.90, 'n', 'n', '', 0, 0, '', 'y'),
(1648, 77, 3.90, 'n', 'n', '', 0, 0, '', 'y'),
(1649, 77, 3.90, 'n', 'n', '', 0, 0, '', 'y'),
(1650, 77, 3.90, 'n', 'n', '', 0, 0, '', 'y'),
(1651, 77, 3.90, 'n', 'n', '', 0, 0, '', 'y'),
(1652, 77, 3.90, 'n', 'n', '', 0, 0, '', 'y'),
(1653, 77, 3.90, 'n', 'n', '', 0, 0, '', 'y'),
(1654, 77, 3.90, 'n', 'n', '', 0, 0, '', 'y');

-- --------------------------------------------------------

--
-- Table structure for table `product_payment_method`
--

CREATE TABLE IF NOT EXISTS `product_payment_method` (
  `id_product` bigint(20) NOT NULL DEFAULT '0',
  `id_payment_method` bigint(20) NOT NULL DEFAULT '0',
  `price` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `product_photo`
--

CREATE TABLE IF NOT EXISTS `product_photo` (
`id_photo` bigint(20) NOT NULL,
  `id_product` bigint(20) NOT NULL,
  `order` int(11) DEFAULT NULL,
  `filename` varchar(255) NOT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1265 ;

--
-- Dumping data for table `product_photo`
--

INSERT INTO `product_photo` (`id_photo`, `id_product`, `order`, `filename`) VALUES
(1229, 1645, 0, '1229.jpg'),
(1233, 1630, 0, '1233.jpg'),
(1234, 1642, 0, '1234.jpg'),
(1235, 1638, 0, '1235.jpg'),
(1238, 1629, 0, '1238.jpg'),
(1239, 1644, 0, '1239.jpg'),
(1241, 1646, 0, '1241.jpg'),
(1242, 1634, 0, '1242.jpg'),
(1243, 1640, 0, '1243.jpg'),
(1244, 1639, 0, '1244.jpg'),
(1245, 1636, 0, '1245.jpg'),
(1246, 1637, 0, '1246.jpg'),
(1247, 1643, 0, '1247.jpg'),
(1248, 1641, 0, '1248.jpg'),
(1250, 1635, 0, '1250.jpg'),
(1252, 1628, 0, '1252.jpg'),
(1253, 1632, 0, '1253.jpg'),
(1254, 1631, 0, '1254.jpg'),
(1257, 1647, 0, '1257.jpg'),
(1258, 1648, 0, '1258.jpg'),
(1259, 1649, 0, '1259.jpg'),
(1260, 1650, 0, '1260.jpg'),
(1261, 1651, 0, '1261.jpg'),
(1262, 1652, 0, '1262.jpg'),
(1263, 1653, 0, '1263.jpg'),
(1264, 1654, 0, '1264.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `product_property_value`
--

CREATE TABLE IF NOT EXISTS `product_property_value` (
  `id_product` bigint(20) NOT NULL,
  `id_value` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `product_shipping`
--

CREATE TABLE IF NOT EXISTS `product_shipping` (
  `id_product` bigint(20) NOT NULL DEFAULT '0',
  `id_shipping_method` bigint(20) DEFAULT NULL,
  `price` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `product_shipping_method`
--

CREATE TABLE IF NOT EXISTS `product_shipping_method` (
  `id_product` bigint(20) NOT NULL DEFAULT '0',
  `id_shipping_method` bigint(20) NOT NULL DEFAULT '0',
  `price` int(11) DEFAULT NULL
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
  `long_description` longtext
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `product_text`
--

INSERT INTO `product_text` (`id_product`, `id_language`, `name`, `permalink`, `short_description`, `long_description`) VALUES
(1628, 1, 'Raspberry Jam', 'raspberry-jam', '', '<div>\n	One of our best-selling products, we fell in love with this sweet and slightly-tart flavour, the first time we tried it. It seems our customers feel the same way, as they keep on buying it. Unbeatable on scones with a spoonful of cream.</div>\n'),
(1629, 1, 'Strawberry Jam', 'strawberry-jam', '', '<p>\n	We believe that all proud jam makers must prove themselves with the quality of their Strawberry Jam. For this reason we have put all of our experience and knowhow into the creation of this, our signature product. You are guaranteed a classic jam fit for a modern table.</p>\n'),
(1630, 1, 'Blackcurrant Jam', 'blackcurrant-jam', '', '<div>\n	We believe that Blackcurrant is truly the king of jams, and for this reason, we stole this recipe from Ennie’s grandma, so that you can enjoy it too. Shhh, please don’t tell her!</div>\n'),
(1631, 1, 'Strawberry Jam with Marc de champagne', 'strawberry-with-marc-de-champagne', '', '<div>\n	The rich flavour of brandy turns this classic strawberry jam into a distinctly decadent treat. Capture the heart of your loved one this Christmas with a jar of something truly luxurious.</div>\n<div>\n	Also available in a special gift box.</div>\n'),
(1632, 1, 'Rhubarb and ginger', 'rhubarb-and-ginger', '', ''),
(1633, 1, 'Apricot', 'apricot', '', ''),
(1634, 1, 'Blackberry and Apple Jam', 'blackberry-and-apple-jam', '', '<div>\n	We have picked two favourite fruits from our English country garden to combine for this jam, offering a taste of a perfect summer’s day in every jar. Guaranteed to bring a smile to your children’s sandwiches.</div>\n<div>\n	&nbsp;</div>\n'),
(1635, 1, 'Pear and ginger', 'pear-and-ginger', '', ''),
(1636, 1, 'Fig', 'fig', '', ''),
(1637, 1, 'Gooseberry and Elderflower Jam', 'gooseberry-and-elderflower-jam', '', '<div>\n	This modern classic combines the unique sweet and sour essence of gooseberries with the elusive floral aroma of elderflower. A flavor that is difficult to define but impossible to resist.</div>\n'),
(1638, 1, 'Morello cherry', 'morello-cherry', '', ''),
(1639, 1, 'Blueberry', 'blueberry', '', ''),
(1640, 1, 'Blackcurrant and sole gin', 'blackcurrant-and-sole-gin', '', ''),
(1641, 1, 'Morello cherry and vintage port Jam', 'morello-cherry-and-vintage-port-jam', '', '<p>\n	A drop of port turns your morning breakfast table into a gourmet experience. All the flavour and goodness that you would expect from our Cherry Jam, brought out with a hint of port from Grandma’s cupboard.</p>\n'),
(1642, 1, 'Passionfruit Curd', 'passionfruit-curd', '', '<p>\n	When we first discovered this incredible new curd, we couldn’t wait to share it with our friends. The exotic flavour of passion fruit breathes new life into your kitchen, perfect with pancakes, muffins, scones or just toast. Invite your friends round to try it but make sure there’s plenty for everybody.</p>\n'),
(1643, 1, 'Lemon Curd', 'lemon-curd', '', '<div>\n	Our lemons are grown on hillsides in full sunlight, to bring a splash of brightness to your morning routine. Try it on toast, muffins or as a filling inside your favourite cake.&nbsp;</div>\n'),
(1644, 1, 'Very ginger', 'very-ginger', '', ''),
(1645, 1, 'Raspberry', 'raspberry', '', ''),
(1646, 1, 'All butter lemon curd', 'all-butter-lemon-curd', '', ''),
(1647, 1, 'Orange with ginger', 'orange-with-ginger', '', ''),
(1648, 1, 'Vintage thick cut orange Marmalade', 'vintage-thick-cut-orange-marmalade', '', '<div>\n	The secret of a truly special marmalade is all in the fruit. We use only the ripest, hand-picked oranges to ensure the ideal combination of fruit and peel, for a heady combination of sweet and bitter flavour with a vintage thick cut texture to match.</div>\n'),
(1649, 1, 'Orange Marmalade with whiskey', 'orange-marmalade-with-whiskey', '', '<div>\n	We have reinvented a favourite breakfast item with this marmalade, in which a drop of whisky brings a hint of the Highlands to your table.&nbsp;</div>\n<div>\n	Makes a perfect present for birthdays, Christmas or any time for the men in your home. Also available in a special gift box.</div>\n'),
(1650, 1, 'Wild moroccan orange', 'wild-moroccan-orange', '', ''),
(1651, 1, 'Seville orange Marmalade', 'seville-orange-marmalade', '', '<p>\n	We travelled all the way to Spain in search of the perfect marriage of sweetness and bitterness for our marmalade. Now we have brought back this classic recipe, with a citrus-scented breeze from Seville in every jar.</p>\n'),
(1652, 1, 'Three fruit', 'three-fruit', '', ''),
(1653, 1, 'Pink grapefruit', 'pink-grapefruit', '', ''),
(1654, 1, 'Lemon and Lime Marmalade', 'lemon-and-lime-maramalade', '', '<p>\n	Add some zest to your morning table with this blend of the zingiest limes and lemons. Guaranteed to wake you up with a burst of freshness first thing in the day, or any time you need a pick-me-up.</p>\n');

-- --------------------------------------------------------

--
-- Table structure for table `property`
--

CREATE TABLE IF NOT EXISTS `property` (
`id_property` bigint(20) NOT NULL,
  `id_category` bigint(20) NOT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=8 ;

-- --------------------------------------------------------

--
-- Table structure for table `property_text`
--

CREATE TABLE IF NOT EXISTS `property_text` (
  `id_property` bigint(20) NOT NULL DEFAULT '0',
  `id_language` bigint(20) NOT NULL DEFAULT '0',
  `name` tinytext
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `property_value`
--

CREATE TABLE IF NOT EXISTS `property_value` (
`id_value` bigint(20) NOT NULL,
  `id_property` bigint(20) NOT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=35 ;

-- --------------------------------------------------------

--
-- Table structure for table `property_value_text`
--

CREATE TABLE IF NOT EXISTS `property_value_text` (
  `id_property_value` bigint(20) NOT NULL DEFAULT '0',
  `id_language` bigint(20) NOT NULL DEFAULT '0',
  `value` tinytext
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `shipping_method`
--

CREATE TABLE IF NOT EXISTS `shipping_method` (
`id_shipping_method` bigint(20) NOT NULL,
  `name` varchar(255) DEFAULT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `shipping_method`
--

INSERT INTO `shipping_method` (`id_shipping_method`, `name`) VALUES
(1, 'personal'),
(2, 'post'),
(3, 'post+cod');

-- --------------------------------------------------------

--
-- Table structure for table `shop`
--

CREATE TABLE IF NOT EXISTS `shop` (
`id_shop` bigint(20) NOT NULL,
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
  `company_description` tinytext
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=31 ;

--
-- Dumping data for table `shop`
--

INSERT INTO `shop` (`id_shop`, `permalink`, `name`, `company_name`, `company_url`, `company_email`, `company_phone`, `company_address`, `company_city`, `company_postcode`, `company_country`, `company_description`) VALUES
(30, 'ennies-garden', 'Ennie''s Garden', '', '', '', '', '', '', '', '', '');

-- --------------------------------------------------------

--
-- Table structure for table `shop_language`
--

CREATE TABLE IF NOT EXISTS `shop_language` (
  `id_shop` bigint(20) DEFAULT NULL,
  `id_language` tinyint(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `shop_language`
--

INSERT INTO `shop_language` (`id_shop`, `id_language`) VALUES
(30, 1);

-- --------------------------------------------------------

--
-- Table structure for table `shop_payment_method`
--

CREATE TABLE IF NOT EXISTS `shop_payment_method` (
  `id_shop` bigint(20) NOT NULL DEFAULT '0',
  `id_payment_method` bigint(20) NOT NULL DEFAULT '0',
  `price` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `shop_payment_method`
--

INSERT INTO `shop_payment_method` (`id_shop`, `id_payment_method`, `price`) VALUES
(28, 1, 0),
(28, 4, 0),
(28, 5, 0),
(30, 2, 0);

-- --------------------------------------------------------

--
-- Table structure for table `shop_shipping_method`
--

CREATE TABLE IF NOT EXISTS `shop_shipping_method` (
  `id_shop` bigint(20) NOT NULL DEFAULT '0',
  `id_shipping_method` bigint(20) NOT NULL DEFAULT '0',
  `price` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `shop_shipping_method`
--

INSERT INTO `shop_shipping_method` (`id_shop`, `id_shipping_method`, `price`) VALUES
(28, 1, 0),
(28, 2, 1000),
(28, 3, 1700);

-- --------------------------------------------------------

--
-- Table structure for table `supplier`
--

CREATE TABLE IF NOT EXISTS `supplier` (
`id_supplier` bigint(20) NOT NULL,
  `id_shop` bigint(20) NOT NULL,
  `name` tinytext
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE IF NOT EXISTS `user` (
`id_user` bigint(20) NOT NULL,
  `id_shop` bigint(20) DEFAULT NULL,
  `username` varchar(255) NOT NULL,
  `name` tinytext NOT NULL,
  `passw` char(32) NOT NULL,
  `email` tinytext NOT NULL,
  `reg_timestamp` datetime NOT NULL,
  `access` enum('root','shop_admin','stock_admin','inacive','disabled') NOT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=25 ;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id_user`, `id_shop`, `username`, `name`, `passw`, `email`, `reg_timestamp`, `access`) VALUES
(1, NULL, 'root', 'root', '25d55ad283aa400af464c76d713c07ad', 'webshop@sykeonline.com', '0000-00-00 00:00:00', 'root'),
(24, 30, 'eniko', 'root', '903515345eee11db267f3d9fb8b77c9a', 'eniko@enniesgarden.co.uk', '0000-00-00 00:00:00', 'shop_admin');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `category`
--
ALTER TABLE `category`
 ADD PRIMARY KEY (`id_category`), ADD KEY `id_shop` (`id_shop`);

--
-- Indexes for table `category_text`
--
ALTER TABLE `category_text`
 ADD PRIMARY KEY (`id_category`,`id_language`), ADD KEY `permalink` (`permalink`), ADD KEY `id_language` (`id_language`);

--
-- Indexes for table `customer`
--
ALTER TABLE `customer`
 ADD PRIMARY KEY (`id_customer`), ADD UNIQUE KEY `id_shop` (`id_shop`,`email`), ADD KEY `passw` (`passw`);

--
-- Indexes for table `language`
--
ALTER TABLE `language`
 ADD PRIMARY KEY (`id_language`);

--
-- Indexes for table `menu`
--
ALTER TABLE `menu`
 ADD PRIMARY KEY (`id_menu`);

--
-- Indexes for table `menu_item`
--
ALTER TABLE `menu_item`
 ADD PRIMARY KEY (`id_menu_item`), ADD KEY `id_menu` (`id_menu`);

--
-- Indexes for table `order`
--
ALTER TABLE `order`
 ADD PRIMARY KEY (`id_order`), ADD KEY `id_shop` (`id_shop`), ADD KEY `payment_status` (`payment_status`), ADD KEY `id_language` (`id_language`);

--
-- Indexes for table `order_product`
--
ALTER TABLE `order_product`
 ADD PRIMARY KEY (`id_order_product`), ADD KEY `id_order` (`id_order`);

--
-- Indexes for table `pack`
--
ALTER TABLE `pack`
 ADD PRIMARY KEY (`id_pack`), ADD KEY `id_shop` (`id_shop`);

--
-- Indexes for table `pack_photo`
--
ALTER TABLE `pack_photo`
 ADD PRIMARY KEY (`id_photo`), ADD UNIQUE KEY `id_pack_order` (`id_pack`,`order`), ADD KEY `id_pack` (`id_pack`);

--
-- Indexes for table `pack_product`
--
ALTER TABLE `pack_product`
 ADD PRIMARY KEY (`id_pack`,`id_product`), ADD KEY `id_product` (`id_product`);

--
-- Indexes for table `pack_text`
--
ALTER TABLE `pack_text`
 ADD PRIMARY KEY (`id_pack`,`id_language`), ADD KEY `id_language` (`id_language`);

--
-- Indexes for table `page`
--
ALTER TABLE `page`
 ADD PRIMARY KEY (`id_page`), ADD UNIQUE KEY `page` (`id_site`,`permalink`), ADD KEY `id_category` (`id_category`);

--
-- Indexes for table `page_category`
--
ALTER TABLE `page_category`
 ADD PRIMARY KEY (`id_category`);

--
-- Indexes for table `page_content`
--
ALTER TABLE `page_content`
 ADD PRIMARY KEY (`id_page`,`id_region`), ADD KEY `id_region` (`id_region`), ADD KEY `id_category` (`id_category`);

--
-- Indexes for table `page_region`
--
ALTER TABLE `page_region`
 ADD PRIMARY KEY (`id_region`);

--
-- Indexes for table `payment_method`
--
ALTER TABLE `payment_method`
 ADD PRIMARY KEY (`id_payment_method`);

--
-- Indexes for table `product`
--
ALTER TABLE `product`
 ADD PRIMARY KEY (`id_product`), ADD KEY `is_featured` (`is_featured`), ADD KEY `is_sale` (`is_sale`), ADD KEY `id_category` (`id_category`), ADD KEY `product_code` (`product_code`);

--
-- Indexes for table `product_payment_method`
--
ALTER TABLE `product_payment_method`
 ADD PRIMARY KEY (`id_product`,`id_payment_method`), ADD KEY `id_payment_method` (`id_payment_method`);

--
-- Indexes for table `product_photo`
--
ALTER TABLE `product_photo`
 ADD PRIMARY KEY (`id_photo`), ADD UNIQUE KEY `id_product_order` (`id_product`,`order`), ADD KEY `id_product` (`id_product`);

--
-- Indexes for table `product_property_value`
--
ALTER TABLE `product_property_value`
 ADD PRIMARY KEY (`id_product`,`id_value`), ADD KEY `id_value` (`id_value`);

--
-- Indexes for table `product_shipping`
--
ALTER TABLE `product_shipping`
 ADD PRIMARY KEY (`id_product`), ADD KEY `id_shipping_method` (`id_shipping_method`);

--
-- Indexes for table `product_shipping_method`
--
ALTER TABLE `product_shipping_method`
 ADD PRIMARY KEY (`id_product`,`id_shipping_method`), ADD KEY `id_shipping_method` (`id_shipping_method`);

--
-- Indexes for table `product_text`
--
ALTER TABLE `product_text`
 ADD PRIMARY KEY (`id_product`,`id_language`), ADD KEY `id_language` (`id_language`), ADD KEY `permalink` (`permalink`);

--
-- Indexes for table `property`
--
ALTER TABLE `property`
 ADD PRIMARY KEY (`id_property`), ADD KEY `id_category` (`id_category`);

--
-- Indexes for table `property_text`
--
ALTER TABLE `property_text`
 ADD PRIMARY KEY (`id_property`,`id_language`);

--
-- Indexes for table `property_value`
--
ALTER TABLE `property_value`
 ADD PRIMARY KEY (`id_value`), ADD KEY `id_property` (`id_property`);

--
-- Indexes for table `property_value_text`
--
ALTER TABLE `property_value_text`
 ADD PRIMARY KEY (`id_property_value`,`id_language`);

--
-- Indexes for table `shipping_method`
--
ALTER TABLE `shipping_method`
 ADD PRIMARY KEY (`id_shipping_method`);

--
-- Indexes for table `shop`
--
ALTER TABLE `shop`
 ADD PRIMARY KEY (`id_shop`), ADD UNIQUE KEY `permalink` (`permalink`);

--
-- Indexes for table `shop_language`
--
ALTER TABLE `shop_language`
 ADD KEY `shop_language_ibfk_1` (`id_shop`), ADD KEY `shop_language_ibfk_2` (`id_language`);

--
-- Indexes for table `shop_payment_method`
--
ALTER TABLE `shop_payment_method`
 ADD PRIMARY KEY (`id_shop`,`id_payment_method`), ADD KEY `id_payment_method` (`id_payment_method`);

--
-- Indexes for table `shop_shipping_method`
--
ALTER TABLE `shop_shipping_method`
 ADD PRIMARY KEY (`id_shop`,`id_shipping_method`), ADD KEY `id_shipping_method` (`id_shipping_method`);

--
-- Indexes for table `supplier`
--
ALTER TABLE `supplier`
 ADD PRIMARY KEY (`id_supplier`), ADD KEY `id_shop` (`id_shop`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
 ADD PRIMARY KEY (`id_user`), ADD UNIQUE KEY `username` (`username`), ADD KEY `id_shop` (`id_shop`), ADD KEY `passw` (`passw`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `category`
--
ALTER TABLE `category`
MODIFY `id_category` bigint(20) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=79;
--
-- AUTO_INCREMENT for table `customer`
--
ALTER TABLE `customer`
MODIFY `id_customer` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `language`
--
ALTER TABLE `language`
MODIFY `id_language` tinyint(4) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `menu`
--
ALTER TABLE `menu`
MODIFY `id_menu` bigint(20) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT for table `menu_item`
--
ALTER TABLE `menu_item`
MODIFY `id_menu_item` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=72;
--
-- AUTO_INCREMENT for table `order`
--
ALTER TABLE `order`
MODIFY `id_order` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `order_product`
--
ALTER TABLE `order_product`
MODIFY `id_order_product` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `pack`
--
ALTER TABLE `pack`
MODIFY `id_pack` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `pack_photo`
--
ALTER TABLE `pack_photo`
MODIFY `id_photo` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `page`
--
ALTER TABLE `page`
MODIFY `id_page` bigint(20) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=12;
--
-- AUTO_INCREMENT for table `page_category`
--
ALTER TABLE `page_category`
MODIFY `id_category` bigint(20) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `page_region`
--
ALTER TABLE `page_region`
MODIFY `id_region` bigint(20) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT for table `payment_method`
--
ALTER TABLE `payment_method`
MODIFY `id_payment_method` bigint(20) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT for table `product`
--
ALTER TABLE `product`
MODIFY `id_product` bigint(20) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=1655;
--
-- AUTO_INCREMENT for table `product_photo`
--
ALTER TABLE `product_photo`
MODIFY `id_photo` bigint(20) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=1265;
--
-- AUTO_INCREMENT for table `property`
--
ALTER TABLE `property`
MODIFY `id_property` bigint(20) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT for table `property_value`
--
ALTER TABLE `property_value`
MODIFY `id_value` bigint(20) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=35;
--
-- AUTO_INCREMENT for table `shipping_method`
--
ALTER TABLE `shipping_method`
MODIFY `id_shipping_method` bigint(20) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `shop`
--
ALTER TABLE `shop`
MODIFY `id_shop` bigint(20) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=31;
--
-- AUTO_INCREMENT for table `supplier`
--
ALTER TABLE `supplier`
MODIFY `id_supplier` bigint(20) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
MODIFY `id_user` bigint(20) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=25;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `category`
--
ALTER TABLE `category`
ADD CONSTRAINT `category_ibfk_1` FOREIGN KEY (`id_shop`) REFERENCES `shop` (`id_shop`) ON DELETE CASCADE;

--
-- Constraints for table `category_text`
--
ALTER TABLE `category_text`
ADD CONSTRAINT `category_text_ibfk_2` FOREIGN KEY (`id_category`) REFERENCES `category` (`id_category`) ON DELETE CASCADE,
ADD CONSTRAINT `category_text_ibfk_3` FOREIGN KEY (`id_language`) REFERENCES `language` (`id_language`) ON DELETE CASCADE;

--
-- Constraints for table `customer`
--
ALTER TABLE `customer`
ADD CONSTRAINT `customer_ibfk_2` FOREIGN KEY (`id_shop`) REFERENCES `shop` (`id_shop`) ON DELETE CASCADE;

--
-- Constraints for table `menu_item`
--
ALTER TABLE `menu_item`
ADD CONSTRAINT `menu_item_ibfk_1` FOREIGN KEY (`id_menu`) REFERENCES `menu` (`id_menu`) ON DELETE CASCADE;

--
-- Constraints for table `order`
--
ALTER TABLE `order`
ADD CONSTRAINT `order_ibfk_1` FOREIGN KEY (`id_shop`) REFERENCES `shop` (`id_shop`),
ADD CONSTRAINT `order_ibfk_2` FOREIGN KEY (`id_language`) REFERENCES `language` (`id_language`);

--
-- Constraints for table `order_product`
--
ALTER TABLE `order_product`
ADD CONSTRAINT `order_product_ibfk_3` FOREIGN KEY (`id_order`) REFERENCES `order` (`id_order`) ON DELETE CASCADE;

--
-- Constraints for table `pack`
--
ALTER TABLE `pack`
ADD CONSTRAINT `pack_ibfk_1` FOREIGN KEY (`id_shop`) REFERENCES `shop` (`id_shop`) ON DELETE CASCADE;

--
-- Constraints for table `pack_photo`
--
ALTER TABLE `pack_photo`
ADD CONSTRAINT `pack_photo_ibfk_1` FOREIGN KEY (`id_pack`) REFERENCES `pack` (`id_pack`) ON DELETE CASCADE;

--
-- Constraints for table `pack_product`
--
ALTER TABLE `pack_product`
ADD CONSTRAINT `pack_product_ibfk_1` FOREIGN KEY (`id_pack`) REFERENCES `pack` (`id_pack`) ON DELETE CASCADE,
ADD CONSTRAINT `pack_product_ibfk_2` FOREIGN KEY (`id_product`) REFERENCES `product` (`id_product`) ON DELETE CASCADE;

--
-- Constraints for table `pack_text`
--
ALTER TABLE `pack_text`
ADD CONSTRAINT `pack_text_ibfk_1` FOREIGN KEY (`id_pack`) REFERENCES `pack` (`id_pack`) ON DELETE CASCADE,
ADD CONSTRAINT `pack_text_ibfk_2` FOREIGN KEY (`id_language`) REFERENCES `language` (`id_language`) ON DELETE CASCADE;

--
-- Constraints for table `page`
--
ALTER TABLE `page`
ADD CONSTRAINT `page_ibfk_1` FOREIGN KEY (`id_category`) REFERENCES `page_category` (`id_category`) ON DELETE CASCADE;

--
-- Constraints for table `page_content`
--
ALTER TABLE `page_content`
ADD CONSTRAINT `page_content_ibfk_3` FOREIGN KEY (`id_page`) REFERENCES `page` (`id_page`) ON DELETE CASCADE,
ADD CONSTRAINT `page_content_ibfk_4` FOREIGN KEY (`id_region`) REFERENCES `page_region` (`id_region`) ON DELETE CASCADE,
ADD CONSTRAINT `page_content_ibfk_5` FOREIGN KEY (`id_category`) REFERENCES `page_category` (`id_category`) ON DELETE CASCADE;

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
ADD CONSTRAINT `product_text_ibfk_3` FOREIGN KEY (`id_product`) REFERENCES `product` (`id_product`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD CONSTRAINT `product_text_ibfk_4` FOREIGN KEY (`id_language`) REFERENCES `language` (`id_language`) ON DELETE CASCADE ON UPDATE CASCADE;

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
ADD CONSTRAINT `shop_language_ibfk_1` FOREIGN KEY (`id_shop`) REFERENCES `shop` (`id_shop`) ON DELETE CASCADE,
ADD CONSTRAINT `shop_language_ibfk_2` FOREIGN KEY (`id_language`) REFERENCES `language` (`id_language`) ON DELETE CASCADE;

--
-- Constraints for table `supplier`
--
ALTER TABLE `supplier`
ADD CONSTRAINT `supplier_ibfk_1` FOREIGN KEY (`id_shop`) REFERENCES `shop` (`id_shop`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `user`
--
ALTER TABLE `user`
ADD CONSTRAINT `user_ibfk_2` FOREIGN KEY (`id_shop`) REFERENCES `shop` (`id_shop`) ON DELETE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
