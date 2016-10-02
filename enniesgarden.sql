-- phpMyAdmin SQL Dump
-- version 4.2.7
-- http://www.phpmyadmin.net
--
-- Host: localhost:3301
-- Generation Time: Jul 15, 2015 at 03:34 PM
-- Server version: 5.5.38-0ubuntu0.14.04.1
-- PHP Version: 5.5.9-1ubuntu4.5

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=82 ;

--
-- Dumping data for table `category`
--

INSERT INTO `category` (`id_category`, `id_shop`, `factory_id`) VALUES
(76, 30, NULL),
(77, 30, NULL),
(78, 30, NULL),
(79, 30, NULL),
(80, 30, NULL),
(81, 30, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `category_text`
--

CREATE TABLE IF NOT EXISTS `category_text` (
  `id_category` bigint(20) NOT NULL DEFAULT '0',
  `id_language` tinyint(4) NOT NULL DEFAULT '0',
  `permalink` varchar(255) DEFAULT NULL,
  `name` tinytext,
  `description` tinytext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `category_text`
--

INSERT INTO `category_text` (`id_category`, `id_language`, `permalink`, `name`, `description`) VALUES
(76, 1, 'jam', 'Jam', 'If you want to wake up to more than just a simple jar of jam at your breakfast table, you’ve come to the right place. Click here to discover all of them.'),
(77, 1, 'marmalade', 'Marmalade', 'We have carefully chosen citrus fruits from around the world for our luxury Marmalade selection. Click here to discover all of them!'),
(78, 1, 'curd', 'Curd', 'We believe that the best Curd should be velvety soft and bursting with flavour. Add some zing to your mornings with exciting flavours. Open a jar today!'),
(79, 1, 'other', 'Other', ''),
(80, 1, 'christmas-gift-sets', 'Christmas Gift Sets', 'Save yourself stress this Christmas and do your shopping online. Our range of exciting seasonal gift sets are available. Check our gift sets now!'),
(81, 1, 'perfect-dunking', 'Perfect Dunking', '');

-- --------------------------------------------------------

--
-- Table structure for table `coupon`
--

CREATE TABLE IF NOT EXISTS `coupon` (
`id_coupon` bigint(20) NOT NULL,
  `code` varchar(255) DEFAULT NULL,
  `type` enum('10-percent','free-delivery','free-product') DEFAULT NULL,
  `info` tinytext,
  `expiration` datetime DEFAULT NULL,
  `unlimited` enum('y','n') NOT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=5 ;

--
-- Dumping data for table `coupon`
--

INSERT INTO `coupon` (`id_coupon`, `code`, `type`, `info`, `expiration`, `unlimited`) VALUES
(1, 'Shake up your wake up', '10-percent', NULL, '2015-03-01 00:00:00', 'y'),
(2, 'Leicester', 'free-delivery', NULL, '2015-12-31 00:00:00', 'y'),
(4, 'butter-test', 'free-product', 'butter-shortbread', '2015-03-24 00:00:00', 'y');

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `customer`
--

INSERT INTO `customer` (`id_customer`, `id_shop`, `email`, `passw`, `phone`, `shipping_name`, `shipping_address`, `shipping_city`, `shipping_postcode`, `billing_name`, `billing_address`, `billing_city`, `billing_postcode`) VALUES
(1, 30, 'eniko.agh@gmail.com', '5f4dcc3b5aa765d61d8327deb882cf99', '9213ö8139ö8', 'ooohjoioibkj', 'eljkfjl', 'hjkjhk', 'le2 8ae', 'ooohjoioibkj', 'eljkfjl', 'hjkjhk', 'le2 8ae');

-- --------------------------------------------------------

--
-- Table structure for table `gallery_image`
--

CREATE TABLE IF NOT EXISTS `gallery_image` (
`id_gallery_image` bigint(20) NOT NULL,
  `id_shop` bigint(20) NOT NULL,
  `filename` varchar(255) DEFAULT NULL,
  `title` tinytext
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=83 ;

--
-- Dumping data for table `gallery_image`
--

INSERT INTO `gallery_image` (`id_gallery_image`, `id_shop`, `filename`, `title`) VALUES
(35, 30, 'blackcurrant-jam-cookies.jpg', 'Three jar of Blackcurrant Jam and thumbprint cookies'),
(36, 30, 'breakfast-croissant-strawberry-jam.jpg', 'Croissant for breakfast with Strawberry Jam and butter'),
(37, 30, 'breakfast-jam-tea-croissant.jpg', 'Croissant and Jam'),
(38, 30, 'blackcurrant-jam-with-cookies.jpg', 'Three jar of Blackcurrant Jam with cookies'),
(39, 30, 'breakfast-strawberry-jam.jpg', 'Croissant with jam and tea'),
(40, 30, 'croissant-tea-strawberry-jam.jpg', 'Best breakfast'),
(41, 30, 'jam-croissant-jam.jpg', 'Special breakfast with strawberry extra jam and a few butter'),
(42, 30, 'strawberry-jam-croissant-tea.jpg', 'Tea and croissant with strawberry jam'),
(43, 30, 'strawberry-jam-with-croissant.jpg', 'Delicious breakfast treat: strawberry extra jam, butter, croissant and tea'),
(44, 30, 'tea-and-croissant-with-strawberry-jam.jpg', 'Two jar of strawberry jam two croissant and a cup of tea'),
(45, 30, 'thumbprint-cookies-blackcurrant-jam-with-tea.jpg', 'Thumbprint cookies with Blackcurrant Jam'),
(46, 30, 'thumbprint-cookies-tea.jpg', 'Thumbprint cookies with Blackcurrant Jam on a napkins and Wild Berry Tea'),
(49, 30, 'thumbprint-cookies-jam-tea.jpg', 'A plate of thumbprint cookies and a cup of tea'),
(50, 30, 'thumbprint-cookies-blackcurrant-jam.jpg', 'Thumbprint cookies with blackcurrant jam and tea'),
(51, 30, 'thumbprint-cookies-strawberry-jam.jpg', 'Heart shaped thumbprint cookies with strawberry jam'),
(53, 30, 'thumbprint-cookies-with-tea.jpg', 'Thumbprint cookies on a napkin and tea'),
(54, 30, 'carrotcake-with-jam-frosting.jpg', 'Four layer carrot cake with berry jam and cream cheese frosting'),
(55, 30, 'brie-in-puff-pastry-with-raspberry-jam.png', 'Brie in puff pastry with raspberry jam on a plate'),
(56, 30, 'every-time-is-tea-time.png', 'Every time is tea time, lot of mugs on a table'),
(57, 30, 'greekyogurt-with-jam.png', 'Greek yogurt with jam topping. Healthy and delicious dessert or breakfast.'),
(58, 30, 'cocktail-with-jam-and-vodka.jpg', 'Cocktail with pink grapefruit marmalade and vodka'),
(59, 30, 'homemade-raspberry-vinaigrette.png', 'Homemade raspberry vinaigrette from raspberry jam'),
(60, 30, 'oil-lamp-made-from-empty-jam-jar.png', 'Oil lamp made from an empty jam jar'),
(61, 30, 'pancake-day-raspberry-jam.png', 'Red pancakes with raspberry jam'),
(62, 30, 'pancake-day.png', 'A man is baking pancakes'),
(63, 30, 'pancakes-and-strawberry-on-a-chopping-board.png', 'Pancakes on a chopping board with strawberries'),
(64, 30, 'reuse-empty-jar-candle.png', 'Candle holder made from an empty jam jar'),
(65, 30, 'monday-morning-blues-breakfast.png', 'Croissant with Strawberry Jam with Marc de Champagne'),
(66, 30, 'smoothie-served-in-a-jam-jar.jpg', 'Smoothie served in a jam jar'),
(67, 30, 'tea-is-the-second-most-popular-beverage.png', 'Tea is the second most consumed beverage on Earth'),
(68, 30, 'national-toast-day.png', '25 February National Toast Day'),
(69, 30, 'poppyseed-cake-with-lemon-curd.png', 'Weekend baking project - Poppy seed cake with lemon curd'),
(70, 30, 'monday-morning.png', '"Monday, Monday, so good to me; Monday morning, it was all I hoped it would be." '),
(71, 30, 'free-gentleman.jpg', 'Women''s Day - A true gentleman buys Ennie''s Garden jam for the love of his life'),
(75, 30, 'croissant-with-apricot-jam-and-a-cup-of-coffe.png', 'All you need is breakfast in bed!'),
(76, 30, 'fig-jam-grilled-bacon-and-brie.png', 'What''s your favourite pairing for fig extra jam? We recommend it with grilled bacon & brie'),
(77, 30, 'hanging-flower-pot-from-jam-jar.png', 'Reuse empty jam jar - make a hanging flower pot'),
(78, 30, 'cooking-with-ennies-garden-fruit-preserves.jpg', 'With Ennie’s Garden fruit preserves the cooking is sweet entertainment'),
(79, 30, 'herb-bouquet-stuffed cornish-game-hens-with-orange-marmalade-glaze.png', 'Herb bouquet-stuffed cornish game hens with orange marmalade glaze is being prepared. It takes time but well worth it.'),
(80, 30, 'passionfruit-flower.png', 'Do you know which fruit this flower belongs to? Yes, passion fruit! So succulent, so tasty. ……. we had to make curd with it.'),
(81, 30, 'spring-tableware.png', 'Spring is here. Bring it to your table too'),
(82, 30, 'extra-jam-meaning.jpg', 'Extra jam is subject to somewhat stricter rules that set higher standards for the minimum fruit content - wikipedia');

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=8 ;

--
-- Dumping data for table `menu`
--

INSERT INTO `menu` (`id_menu`, `name`) VALUES
(5, 'ennies-garden-en'),
(6, 'ennies-garden-en-2'),
(7, 'ennies-garden-en-1');

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=82 ;

--
-- Dumping data for table `menu_item`
--

INSERT INTO `menu_item` (`id_menu_item`, `id_menu`, `id_parent`, `title`, `url`, `is_popup`, `order`) VALUES
(67, 5, NULL, 'Home', '/', 'n', 0),
(68, 5, NULL, 'Jam', '/jam/', 'n', 0),
(69, 5, NULL, 'Marmalade', '/marmalade/', 'n', 0),
(70, 5, NULL, 'Curd', '/curd/', 'n', 0),
(71, 5, NULL, 'Basket', '/basket/', 'n', 0),
(74, 6, NULL, 'Jam', '/jam/', 'n', 0),
(75, 6, NULL, 'Marmalade', '/marmalade/', 'n', 0),
(76, 6, NULL, 'Curd', '/curd/', 'n', 0),
(78, 7, NULL, 'Home', '/', 'n', 0),
(79, 7, NULL, 'Shipping Information', '/shipping-information/', 'n', 0),
(80, 7, NULL, 'Basket', '/basket/', 'n', 0),
(81, 6, NULL, 'Perfect Dunking', 'http://www.enniesgarden.co.uk/perfect-dunking/', 'n', 0);

-- --------------------------------------------------------

--
-- Table structure for table `order`
--

CREATE TABLE IF NOT EXISTS `order` (
`id_order` bigint(20) NOT NULL,
  `hash` char(16) NOT NULL,
  `id_shop` bigint(20) NOT NULL,
  `id_language` tinyint(20) NOT NULL,
  `email` tinytext NOT NULL,
  `phone` tinytext NOT NULL,
  `shipping_name` tinytext NOT NULL,
  `shipping_address` tinytext NOT NULL,
  `shipping_city` tinytext NOT NULL,
  `shipping_postcode` varchar(32) NOT NULL,
  `billing_name` tinytext,
  `billing_address` tinytext,
  `billing_city` tinytext,
  `billing_postcode` tinytext,
  `shipping_cost` decimal(11,2) NOT NULL DEFAULT '0.00',
  `total` decimal(11,2) NOT NULL,
  `shipping_status` enum('pending','approved','shipped','canceled') NOT NULL DEFAULT 'pending',
  `payment_status` enum('pending','confirmed','success','declined','canceled') NOT NULL DEFAULT 'pending',
  `payment_method` enum('paypal','charityclear') NOT NULL,
  `payment_response` longtext NOT NULL,
  `id_shipping_method` int(11) NOT NULL,
  `id_payment_method` int(11) NOT NULL,
  `id_coupon` bigint(20) DEFAULT NULL,
  `date_order` datetime NOT NULL,
  `date_modified` datetime NOT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=60 ;

--
-- Dumping data for table `order`
--

INSERT INTO `order` (`id_order`, `hash`, `id_shop`, `id_language`, `email`, `phone`, `shipping_name`, `shipping_address`, `shipping_city`, `shipping_postcode`, `billing_name`, `billing_address`, `billing_city`, `billing_postcode`, `shipping_cost`, `total`, `shipping_status`, `payment_status`, `payment_method`, `payment_response`, `id_shipping_method`, `id_payment_method`, `id_coupon`, `date_order`, `date_modified`) VALUES
(1, 'c5be06fc5828d9a5', 30, 1, 'syke80@gmail.com', 'qwe', 'qwe', 'qwe', 'qwe', '123', 'qwe', 'qwe', 'qwe', '123', '6.90', '10.80', 'canceled', 'pending', 'paypal', '', 2, 3, NULL, '2014-10-09 16:15:37', '2015-03-09 13:50:43'),
(2, '427a3adccffc210c', 30, 1, 'syke80@gmail.com', 'qwe', 'qwe', 'qwe', 'qwe', '123', 'qwe', 'qwe', 'qwe', '123', '6.90', '10.80', 'canceled', 'pending', 'paypal', '', 2, 3, NULL, '2014-10-09 16:21:04', '2015-03-09 13:50:49'),
(3, '7251e7f923c0ac5d', 30, 1, 'Dvhgff@dgv.com', '1357', 'Ghffv', 'Cbgs', 'Fjuhbb', 'Dnnf', 'Ghffv', 'Cbgs', 'Fjuhbb', 'Dnnf', '6.90', '14.70', 'canceled', 'pending', 'paypal', '', 2, 3, NULL, '2014-10-14 22:43:07', '2015-03-09 13:50:55'),
(4, '61d61fe5966ff798', 30, 1, 'Dvhgff@dgv.com', '1357', 'Ghffv', 'Cbgs', 'Fjuhbb', 'Dnnf', 'Ghffv', 'Cbgs', 'Fjuhbb', 'Dnnf', '6.90', '14.70', 'canceled', 'pending', 'paypal', '', 2, 3, NULL, '2014-10-14 22:43:24', '2015-03-09 13:51:01'),
(5, '834576a762769d56', 30, 1, 'eniko.agh@gmail.com', '12132445687', 'd', '56 grace rig', 'dsddsf', 'le28ae', 'd', '56 grace rig', 'dsddsf', 'le28ae', '6.90', '10.80', 'canceled', 'pending', 'paypal', '', 2, 3, NULL, '2014-10-17 22:51:29', '2015-03-09 13:51:07'),
(6, '7b1d7a5833a0369a', 30, 1, 'eniko.agh@gmail.com', '12132445687', 'ddsfsd', '56 grace rig', 'dsddsf', 'le28ae', 'ddsfsd', '56 grace rig', 'dsddsf', 'le28ae', '6.90', '10.80', 'canceled', 'pending', 'paypal', '', 2, 3, NULL, '2014-10-17 22:52:30', '2015-03-09 13:51:16'),
(7, 'f5a9b6fb88df4724', 30, 1, 'syke@outlook.com', '7473478980', 'Attila Keszthelyi', '56 Grace Road', 'Leicester', 'LE2 8AE', 'Attila Keszthelyi', '56 Grace Road', 'Leicester', 'LE2 8AE', '0.00', '3.90', 'canceled', 'pending', 'paypal', '', 4, 3, NULL, '2014-10-17 22:56:17', '2015-03-09 13:51:22'),
(8, '209d2d711aa42b54', 30, 1, 'syke@outlook.com', '7473478980', 'Attila Keszthelyi', '56 Grace Road', 'Leicester', 'LE2 8AE', 'Attila Keszthelyi', '56 Grace Road', 'Leicester', 'LE2 8AE', '0.00', '3.90', 'canceled', 'pending', 'paypal', '', 4, 3, NULL, '2014-10-17 22:56:25', '2015-03-09 13:51:29'),
(9, '0dc744a765e07b37', 30, 1, 'syke@outlook.com', '7473478980', 'Attila Keszthelyi', '56 Grace Road', 'Leicester', 'LE2 8AE', 'Attila Keszthelyi', '56 Grace Road', 'Leicester', 'LE2 8AE', '0.00', '3.90', 'canceled', 'pending', 'paypal', '', 4, 3, NULL, '2014-10-17 22:58:04', '2015-03-09 13:51:35'),
(10, '30a41b02237d7701', 30, 1, 'syke@outlook.com', '7473478980', 'Attila Keszthelyi', '56 Grace Road', 'Leicester', 'LE2 8AE', 'Attila Keszthelyi', '56 Grace Road', 'Leicester', 'LE2 8AE', '0.00', '3.90', 'canceled', 'pending', 'paypal', '', 4, 3, NULL, '2014-10-17 23:00:18', '2015-03-09 13:51:41'),
(11, '9a5f0f72989ea41e', 30, 1, 'syke@outlook.com', '7473478980', 'Attila Keszthelyi', '56 Grace Road', 'Leicester', 'LE2 8AE', 'Attila Keszthelyi', '56 Grace Road', 'Leicester', 'LE2 8AE', '0.00', '3.90', 'canceled', 'pending', 'paypal', '', 4, 3, NULL, '2014-10-17 23:24:09', '2015-03-09 13:51:46'),
(12, 'b41c56c4c2c82434', 30, 1, 'eniko.agh@gmail.com', '12321983239', 'suhfhfsiehu', '4353 kjsefkfjse ', 'uihsdfhsidfhu', 'le28akjd', 'suhfhfsiehu', '4353 kjsefkfjse ', 'uihsdfhsidfhu', 'le28akjd', '6.90', '10.80', 'canceled', 'pending', 'paypal', '', 2, 3, NULL, '2014-10-17 23:24:51', '2015-03-09 13:51:52'),
(13, '4141290e071fb845', 30, 1, 'qwe@qwe.com', '123', 'qwe', 'qwe', 'qwe', 'qwe', 'qwe', 'qwe', 'qwe', 'qwe', '6.90', '10.80', 'canceled', 'pending', 'paypal', '', 2, 3, NULL, '2014-10-23 12:00:29', '2015-03-09 13:51:57'),
(14, 'cbb3e9c17feabf13', 30, 1, 'eniko.agh@gmail.com', '9213ö8139ö8', 'ooohjoioibkj', 'eljkfjl', 'hjkjhk', 'le2 8ae', 'ooohjoioibkj', 'eljkfjl', 'hjkjhk', 'le2 8ae', '6.90', '10.80', 'canceled', 'pending', 'paypal', '', 2, 3, NULL, '2014-10-27 21:44:32', '2015-03-09 13:52:03'),
(15, '63e9ee6fef97e338', 30, 1, '', '', '', '', '', '', '', '', '', '', '4.90', '9.80', 'canceled', 'confirmed', 'paypal', 'a:25:{s:5:"TOKEN";s:20:"EC-3AP91471B59772417";s:28:"SUCCESSPAGEREDIRECTREQUESTED";s:5:"false";s:9:"TIMESTAMP";s:20:"2014-11-25T01:03:53Z";s:13:"CORRELATIONID";s:13:"b2b80748c3ae1";s:3:"ACK";s:7:"Success";s:7:"VERSION";s:5:"109.0";s:5:"BUILD";s:8:"13630372";s:23:"INSURANCEOPTIONSELECTED";s:5:"false";s:23:"SHIPPINGOPTIONISDEFAULT";s:5:"false";s:27:"PAYMENTINFO_0_TRANSACTIONID";s:17:"89F61161L2430882K";s:29:"PAYMENTINFO_0_TRANSACTIONTYPE";s:15:"expresscheckout";s:25:"PAYMENTINFO_0_PAYMENTTYPE";s:7:"instant";s:23:"PAYMENTINFO_0_ORDERTIME";s:20:"2014-11-25T01:03:53Z";s:17:"PAYMENTINFO_0_AMT";s:4:"9.80";s:20:"PAYMENTINFO_0_FEEAMT";s:4:"0.53";s:20:"PAYMENTINFO_0_TAXAMT";s:4:"0.00";s:26:"PAYMENTINFO_0_CURRENCYCODE";s:3:"GBP";s:27:"PAYMENTINFO_0_PAYMENTSTATUS";s:9:"Completed";s:27:"PAYMENTINFO_0_PENDINGREASON";s:4:"None";s:24:"PAYMENTINFO_0_REASONCODE";s:4:"None";s:35:"PAYMENTINFO_0_PROTECTIONELIGIBILITY";s:8:"Eligible";s:39:"PAYMENTINFO_0_PROTECTIONELIGIBILITYTYPE";s:51:"ItemNotReceivedEligible,UnauthorizedPaymentEligible";s:37:"PAYMENTINFO_0_SECUREMERCHANTACCOUNTID";s:13:"F6CL584Y57P2Y";s:23:"PAYMENTINFO_0_ERRORCODE";s:1:"0";s:17:"PAYMENTINFO_0_ACK";s:7:"Success";}', 9, 2, NULL, '2014-11-25 01:07:12', '2015-03-09 13:54:06'),
(16, '3949a61aaa2827ef', 30, 1, '', '', '', '', '', '', '', '', '', '', '4.90', '9.80', 'canceled', 'confirmed', 'paypal', 'a:25:{s:5:"TOKEN";s:20:"EC-1ED62823SW774573A";s:28:"SUCCESSPAGEREDIRECTREQUESTED";s:5:"false";s:9:"TIMESTAMP";s:20:"2014-11-25T01:21:03Z";s:13:"CORRELATIONID";s:12:"f21fd3ed1860";s:3:"ACK";s:7:"Success";s:7:"VERSION";s:5:"109.0";s:5:"BUILD";s:8:"13630372";s:23:"INSURANCEOPTIONSELECTED";s:5:"false";s:23:"SHIPPINGOPTIONISDEFAULT";s:5:"false";s:27:"PAYMENTINFO_0_TRANSACTIONID";s:17:"39Y88224YK395435T";s:29:"PAYMENTINFO_0_TRANSACTIONTYPE";s:15:"expresscheckout";s:25:"PAYMENTINFO_0_PAYMENTTYPE";s:7:"instant";s:23:"PAYMENTINFO_0_ORDERTIME";s:20:"2014-11-25T01:21:03Z";s:17:"PAYMENTINFO_0_AMT";s:4:"9.80";s:20:"PAYMENTINFO_0_FEEAMT";s:4:"0.53";s:20:"PAYMENTINFO_0_TAXAMT";s:4:"0.00";s:26:"PAYMENTINFO_0_CURRENCYCODE";s:3:"GBP";s:27:"PAYMENTINFO_0_PAYMENTSTATUS";s:9:"Completed";s:27:"PAYMENTINFO_0_PENDINGREASON";s:4:"None";s:24:"PAYMENTINFO_0_REASONCODE";s:4:"None";s:35:"PAYMENTINFO_0_PROTECTIONELIGIBILITY";s:8:"Eligible";s:39:"PAYMENTINFO_0_PROTECTIONELIGIBILITYTYPE";s:51:"ItemNotReceivedEligible,UnauthorizedPaymentEligible";s:37:"PAYMENTINFO_0_SECUREMERCHANTACCOUNTID";s:13:"F6CL584Y57P2Y";s:23:"PAYMENTINFO_0_ERRORCODE";s:1:"0";s:17:"PAYMENTINFO_0_ACK";s:7:"Success";}', 9, 2, NULL, '2014-11-25 01:24:23', '2015-03-09 13:54:11'),
(17, '3f1bf1e6822e1df5', 30, 1, '', '', '', '', '', '', '', '', '', '', '4.90', '9.80', 'canceled', 'confirmed', 'paypal', 'a:25:{s:5:"TOKEN";s:20:"EC-0RE8291641718281Y";s:28:"SUCCESSPAGEREDIRECTREQUESTED";s:5:"false";s:9:"TIMESTAMP";s:20:"2014-11-25T01:33:16Z";s:13:"CORRELATIONID";s:13:"be605cf2dcaed";s:3:"ACK";s:7:"Success";s:7:"VERSION";s:5:"109.0";s:5:"BUILD";s:8:"13630372";s:23:"INSURANCEOPTIONSELECTED";s:5:"false";s:23:"SHIPPINGOPTIONISDEFAULT";s:5:"false";s:27:"PAYMENTINFO_0_TRANSACTIONID";s:17:"92M022945C724513L";s:29:"PAYMENTINFO_0_TRANSACTIONTYPE";s:15:"expresscheckout";s:25:"PAYMENTINFO_0_PAYMENTTYPE";s:7:"instant";s:23:"PAYMENTINFO_0_ORDERTIME";s:20:"2014-11-25T01:33:16Z";s:17:"PAYMENTINFO_0_AMT";s:4:"9.80";s:20:"PAYMENTINFO_0_FEEAMT";s:4:"0.53";s:20:"PAYMENTINFO_0_TAXAMT";s:4:"0.00";s:26:"PAYMENTINFO_0_CURRENCYCODE";s:3:"GBP";s:27:"PAYMENTINFO_0_PAYMENTSTATUS";s:9:"Completed";s:27:"PAYMENTINFO_0_PENDINGREASON";s:4:"None";s:24:"PAYMENTINFO_0_REASONCODE";s:4:"None";s:35:"PAYMENTINFO_0_PROTECTIONELIGIBILITY";s:8:"Eligible";s:39:"PAYMENTINFO_0_PROTECTIONELIGIBILITYTYPE";s:51:"ItemNotReceivedEligible,UnauthorizedPaymentEligible";s:37:"PAYMENTINFO_0_SECUREMERCHANTACCOUNTID";s:13:"F6CL584Y57P2Y";s:23:"PAYMENTINFO_0_ERRORCODE";s:1:"0";s:17:"PAYMENTINFO_0_ACK";s:7:"Success";}', 9, 2, NULL, '2014-11-25 01:36:24', '2015-03-09 13:54:16'),
(18, '479b05c7ee4aea65', 30, 1, '', '', '', '', '', '', '', '', '', '', '4.90', '9.80', 'canceled', 'confirmed', 'paypal', 'a:25:{s:5:"TOKEN";s:20:"EC-65J16620JL483925W";s:28:"SUCCESSPAGEREDIRECTREQUESTED";s:5:"false";s:9:"TIMESTAMP";s:20:"2014-11-25T01:37:53Z";s:13:"CORRELATIONID";s:12:"88ff43efbb7b";s:3:"ACK";s:7:"Success";s:7:"VERSION";s:5:"109.0";s:5:"BUILD";s:8:"13630372";s:23:"INSURANCEOPTIONSELECTED";s:5:"false";s:23:"SHIPPINGOPTIONISDEFAULT";s:5:"false";s:27:"PAYMENTINFO_0_TRANSACTIONID";s:17:"7HK74239FX912544P";s:29:"PAYMENTINFO_0_TRANSACTIONTYPE";s:15:"expresscheckout";s:25:"PAYMENTINFO_0_PAYMENTTYPE";s:7:"instant";s:23:"PAYMENTINFO_0_ORDERTIME";s:20:"2014-11-25T01:37:53Z";s:17:"PAYMENTINFO_0_AMT";s:4:"9.80";s:20:"PAYMENTINFO_0_FEEAMT";s:4:"0.53";s:20:"PAYMENTINFO_0_TAXAMT";s:4:"0.00";s:26:"PAYMENTINFO_0_CURRENCYCODE";s:3:"GBP";s:27:"PAYMENTINFO_0_PAYMENTSTATUS";s:9:"Completed";s:27:"PAYMENTINFO_0_PENDINGREASON";s:4:"None";s:24:"PAYMENTINFO_0_REASONCODE";s:4:"None";s:35:"PAYMENTINFO_0_PROTECTIONELIGIBILITY";s:8:"Eligible";s:39:"PAYMENTINFO_0_PROTECTIONELIGIBILITYTYPE";s:51:"ItemNotReceivedEligible,UnauthorizedPaymentEligible";s:37:"PAYMENTINFO_0_SECUREMERCHANTACCOUNTID";s:13:"F6CL584Y57P2Y";s:23:"PAYMENTINFO_0_ERRORCODE";s:1:"0";s:17:"PAYMENTINFO_0_ACK";s:7:"Success";}', 9, 2, NULL, '2014-11-25 01:41:29', '2015-03-09 13:54:20'),
(19, '027c3bf024ac0b11', 30, 1, '', '', '', '', '', '', '', '', '', '', '4.90', '14.70', 'canceled', 'confirmed', 'paypal', 'a:25:{s:5:"TOKEN";s:20:"EC-6V464912XB073000B";s:28:"SUCCESSPAGEREDIRECTREQUESTED";s:5:"false";s:9:"TIMESTAMP";s:20:"2014-11-25T01:41:01Z";s:13:"CORRELATIONID";s:13:"a35ad13aab98f";s:3:"ACK";s:7:"Success";s:7:"VERSION";s:5:"109.0";s:5:"BUILD";s:8:"13630372";s:23:"INSURANCEOPTIONSELECTED";s:5:"false";s:23:"SHIPPINGOPTIONISDEFAULT";s:5:"false";s:27:"PAYMENTINFO_0_TRANSACTIONID";s:17:"5DA05927PT574603D";s:29:"PAYMENTINFO_0_TRANSACTIONTYPE";s:15:"expresscheckout";s:25:"PAYMENTINFO_0_PAYMENTTYPE";s:7:"instant";s:23:"PAYMENTINFO_0_ORDERTIME";s:20:"2014-11-25T01:41:01Z";s:17:"PAYMENTINFO_0_AMT";s:5:"14.70";s:20:"PAYMENTINFO_0_FEEAMT";s:4:"0.70";s:20:"PAYMENTINFO_0_TAXAMT";s:4:"0.00";s:26:"PAYMENTINFO_0_CURRENCYCODE";s:3:"GBP";s:27:"PAYMENTINFO_0_PAYMENTSTATUS";s:9:"Completed";s:27:"PAYMENTINFO_0_PENDINGREASON";s:4:"None";s:24:"PAYMENTINFO_0_REASONCODE";s:4:"None";s:35:"PAYMENTINFO_0_PROTECTIONELIGIBILITY";s:8:"Eligible";s:39:"PAYMENTINFO_0_PROTECTIONELIGIBILITYTYPE";s:51:"ItemNotReceivedEligible,UnauthorizedPaymentEligible";s:37:"PAYMENTINFO_0_SECUREMERCHANTACCOUNTID";s:13:"F6CL584Y57P2Y";s:23:"PAYMENTINFO_0_ERRORCODE";s:1:"0";s:17:"PAYMENTINFO_0_ACK";s:7:"Success";}', 9, 2, NULL, '2014-11-25 01:44:45', '2015-03-09 13:54:26'),
(20, 'ab80eb56bab8a725', 30, 1, '', '', '', '', '', '', '', '', '', '', '4.90', '9.80', 'canceled', 'confirmed', 'paypal', 'a:25:{s:5:"TOKEN";s:20:"EC-9FG24660SX704942L";s:28:"SUCCESSPAGEREDIRECTREQUESTED";s:5:"false";s:9:"TIMESTAMP";s:20:"2014-11-25T01:48:43Z";s:13:"CORRELATIONID";s:13:"da3fa8b5c5213";s:3:"ACK";s:7:"Success";s:7:"VERSION";s:5:"109.0";s:5:"BUILD";s:8:"13630372";s:23:"INSURANCEOPTIONSELECTED";s:5:"false";s:23:"SHIPPINGOPTIONISDEFAULT";s:5:"false";s:27:"PAYMENTINFO_0_TRANSACTIONID";s:17:"62B20930MP545005V";s:29:"PAYMENTINFO_0_TRANSACTIONTYPE";s:15:"expresscheckout";s:25:"PAYMENTINFO_0_PAYMENTTYPE";s:7:"instant";s:23:"PAYMENTINFO_0_ORDERTIME";s:20:"2014-11-25T01:48:43Z";s:17:"PAYMENTINFO_0_AMT";s:4:"9.80";s:20:"PAYMENTINFO_0_FEEAMT";s:4:"0.53";s:20:"PAYMENTINFO_0_TAXAMT";s:4:"0.00";s:26:"PAYMENTINFO_0_CURRENCYCODE";s:3:"GBP";s:27:"PAYMENTINFO_0_PAYMENTSTATUS";s:9:"Completed";s:27:"PAYMENTINFO_0_PENDINGREASON";s:4:"None";s:24:"PAYMENTINFO_0_REASONCODE";s:4:"None";s:35:"PAYMENTINFO_0_PROTECTIONELIGIBILITY";s:8:"Eligible";s:39:"PAYMENTINFO_0_PROTECTIONELIGIBILITYTYPE";s:51:"ItemNotReceivedEligible,UnauthorizedPaymentEligible";s:37:"PAYMENTINFO_0_SECUREMERCHANTACCOUNTID";s:13:"F6CL584Y57P2Y";s:23:"PAYMENTINFO_0_ERRORCODE";s:1:"0";s:17:"PAYMENTINFO_0_ACK";s:7:"Success";}', 9, 2, NULL, '2014-11-25 01:51:02', '2015-03-09 13:54:30'),
(21, 'f75ef9198ad724bf', 30, 1, '', '', '', '', '', '', '', '', '', '', '4.90', '19.60', 'canceled', 'confirmed', 'paypal', 'a:25:{s:5:"TOKEN";s:20:"EC-8SH51235FK922900W";s:28:"SUCCESSPAGEREDIRECTREQUESTED";s:5:"false";s:9:"TIMESTAMP";s:20:"2014-11-25T11:33:25Z";s:13:"CORRELATIONID";s:13:"5b23e19ea8605";s:3:"ACK";s:7:"Success";s:7:"VERSION";s:5:"109.0";s:5:"BUILD";s:8:"13630372";s:23:"INSURANCEOPTIONSELECTED";s:5:"false";s:23:"SHIPPINGOPTIONISDEFAULT";s:5:"false";s:27:"PAYMENTINFO_0_TRANSACTIONID";s:17:"7SC21276YD582270D";s:29:"PAYMENTINFO_0_TRANSACTIONTYPE";s:15:"expresscheckout";s:25:"PAYMENTINFO_0_PAYMENTTYPE";s:7:"instant";s:23:"PAYMENTINFO_0_ORDERTIME";s:20:"2014-11-25T11:33:25Z";s:17:"PAYMENTINFO_0_AMT";s:5:"19.60";s:20:"PAYMENTINFO_0_FEEAMT";s:4:"0.87";s:20:"PAYMENTINFO_0_TAXAMT";s:4:"0.00";s:26:"PAYMENTINFO_0_CURRENCYCODE";s:3:"GBP";s:27:"PAYMENTINFO_0_PAYMENTSTATUS";s:9:"Completed";s:27:"PAYMENTINFO_0_PENDINGREASON";s:4:"None";s:24:"PAYMENTINFO_0_REASONCODE";s:4:"None";s:35:"PAYMENTINFO_0_PROTECTIONELIGIBILITY";s:8:"Eligible";s:39:"PAYMENTINFO_0_PROTECTIONELIGIBILITYTYPE";s:51:"ItemNotReceivedEligible,UnauthorizedPaymentEligible";s:37:"PAYMENTINFO_0_SECUREMERCHANTACCOUNTID";s:13:"F6CL584Y57P2Y";s:23:"PAYMENTINFO_0_ERRORCODE";s:1:"0";s:17:"PAYMENTINFO_0_ACK";s:7:"Success";}', 9, 2, NULL, '2014-11-25 11:37:11', '2015-03-09 13:54:35'),
(22, 'a1b24927b002eda7', 30, 1, '', '', '', '', '', '', '', '', '', '', '4.90', '14.70', 'canceled', 'pending', 'paypal', '', 9, 2, NULL, '2014-11-25 11:43:27', '2015-03-09 13:54:40'),
(23, 'ad6721f953a560dd', 30, 1, '', '', '', '', '', '', '', '', '', '', '4.90', '14.70', 'canceled', 'confirmed', 'paypal', 'a:25:{s:5:"TOKEN";s:20:"EC-84Y75346FP3858000";s:28:"SUCCESSPAGEREDIRECTREQUESTED";s:5:"false";s:9:"TIMESTAMP";s:20:"2014-11-25T11:41:35Z";s:13:"CORRELATIONID";s:13:"33f3152fe4826";s:3:"ACK";s:7:"Success";s:7:"VERSION";s:5:"109.0";s:5:"BUILD";s:8:"13630372";s:23:"INSURANCEOPTIONSELECTED";s:5:"false";s:23:"SHIPPINGOPTIONISDEFAULT";s:5:"false";s:27:"PAYMENTINFO_0_TRANSACTIONID";s:17:"2PG09515GK6767248";s:29:"PAYMENTINFO_0_TRANSACTIONTYPE";s:15:"expresscheckout";s:25:"PAYMENTINFO_0_PAYMENTTYPE";s:7:"instant";s:23:"PAYMENTINFO_0_ORDERTIME";s:20:"2014-11-25T11:41:34Z";s:17:"PAYMENTINFO_0_AMT";s:5:"14.70";s:20:"PAYMENTINFO_0_FEEAMT";s:4:"0.70";s:20:"PAYMENTINFO_0_TAXAMT";s:4:"0.00";s:26:"PAYMENTINFO_0_CURRENCYCODE";s:3:"GBP";s:27:"PAYMENTINFO_0_PAYMENTSTATUS";s:9:"Completed";s:27:"PAYMENTINFO_0_PENDINGREASON";s:4:"None";s:24:"PAYMENTINFO_0_REASONCODE";s:4:"None";s:35:"PAYMENTINFO_0_PROTECTIONELIGIBILITY";s:8:"Eligible";s:39:"PAYMENTINFO_0_PROTECTIONELIGIBILITYTYPE";s:51:"ItemNotReceivedEligible,UnauthorizedPaymentEligible";s:37:"PAYMENTINFO_0_SECUREMERCHANTACCOUNTID";s:13:"F6CL584Y57P2Y";s:23:"PAYMENTINFO_0_ERRORCODE";s:1:"0";s:17:"PAYMENTINFO_0_ACK";s:7:"Success";}', 9, 2, NULL, '2014-11-25 11:45:18', '2015-03-09 13:54:45'),
(24, '1d333f9f8287bf4a', 30, 1, '', '', '', '', '', '', '', '', '', '', '4.90', '9.80', 'canceled', 'confirmed', 'paypal', 'a:25:{s:5:"TOKEN";s:20:"EC-8YA48895SM381900C";s:28:"SUCCESSPAGEREDIRECTREQUESTED";s:5:"false";s:9:"TIMESTAMP";s:20:"2014-11-25T11:43:27Z";s:13:"CORRELATIONID";s:13:"c000fc5d3e0ab";s:3:"ACK";s:7:"Success";s:7:"VERSION";s:5:"109.0";s:5:"BUILD";s:8:"13630372";s:23:"INSURANCEOPTIONSELECTED";s:5:"false";s:23:"SHIPPINGOPTIONISDEFAULT";s:5:"false";s:27:"PAYMENTINFO_0_TRANSACTIONID";s:17:"86Y699346L4271015";s:29:"PAYMENTINFO_0_TRANSACTIONTYPE";s:15:"expresscheckout";s:25:"PAYMENTINFO_0_PAYMENTTYPE";s:7:"instant";s:23:"PAYMENTINFO_0_ORDERTIME";s:20:"2014-11-25T11:43:27Z";s:17:"PAYMENTINFO_0_AMT";s:4:"9.80";s:20:"PAYMENTINFO_0_FEEAMT";s:4:"0.53";s:20:"PAYMENTINFO_0_TAXAMT";s:4:"0.00";s:26:"PAYMENTINFO_0_CURRENCYCODE";s:3:"GBP";s:27:"PAYMENTINFO_0_PAYMENTSTATUS";s:9:"Completed";s:27:"PAYMENTINFO_0_PENDINGREASON";s:4:"None";s:24:"PAYMENTINFO_0_REASONCODE";s:4:"None";s:35:"PAYMENTINFO_0_PROTECTIONELIGIBILITY";s:8:"Eligible";s:39:"PAYMENTINFO_0_PROTECTIONELIGIBILITYTYPE";s:51:"ItemNotReceivedEligible,UnauthorizedPaymentEligible";s:37:"PAYMENTINFO_0_SECUREMERCHANTACCOUNTID";s:13:"F6CL584Y57P2Y";s:23:"PAYMENTINFO_0_ERRORCODE";s:1:"0";s:17:"PAYMENTINFO_0_ACK";s:7:"Success";}', 9, 2, NULL, '2014-11-25 11:47:11', '2015-03-09 13:54:49'),
(25, '4150904caf7bc051', 30, 1, '', '', '', '', '', '', '', '', '', '', '4.90', '9.80', 'canceled', 'confirmed', 'paypal', 'a:25:{s:5:"TOKEN";s:20:"EC-7GD65009XS541700X";s:28:"SUCCESSPAGEREDIRECTREQUESTED";s:5:"false";s:9:"TIMESTAMP";s:20:"2014-11-25T17:51:24Z";s:13:"CORRELATIONID";s:13:"cb3b2d9212362";s:3:"ACK";s:7:"Success";s:7:"VERSION";s:5:"109.0";s:5:"BUILD";s:8:"13630372";s:23:"INSURANCEOPTIONSELECTED";s:5:"false";s:23:"SHIPPINGOPTIONISDEFAULT";s:5:"false";s:27:"PAYMENTINFO_0_TRANSACTIONID";s:17:"07B26791DS915664H";s:29:"PAYMENTINFO_0_TRANSACTIONTYPE";s:15:"expresscheckout";s:25:"PAYMENTINFO_0_PAYMENTTYPE";s:7:"instant";s:23:"PAYMENTINFO_0_ORDERTIME";s:20:"2014-11-25T17:51:24Z";s:17:"PAYMENTINFO_0_AMT";s:4:"9.80";s:20:"PAYMENTINFO_0_FEEAMT";s:4:"0.53";s:20:"PAYMENTINFO_0_TAXAMT";s:4:"0.00";s:26:"PAYMENTINFO_0_CURRENCYCODE";s:3:"GBP";s:27:"PAYMENTINFO_0_PAYMENTSTATUS";s:9:"Completed";s:27:"PAYMENTINFO_0_PENDINGREASON";s:4:"None";s:24:"PAYMENTINFO_0_REASONCODE";s:4:"None";s:35:"PAYMENTINFO_0_PROTECTIONELIGIBILITY";s:8:"Eligible";s:39:"PAYMENTINFO_0_PROTECTIONELIGIBILITYTYPE";s:51:"ItemNotReceivedEligible,UnauthorizedPaymentEligible";s:37:"PAYMENTINFO_0_SECUREMERCHANTACCOUNTID";s:13:"F6CL584Y57P2Y";s:23:"PAYMENTINFO_0_ERRORCODE";s:1:"0";s:17:"PAYMENTINFO_0_ACK";s:7:"Success";}', 9, 2, NULL, '2014-11-25 17:54:54', '2015-03-09 13:54:55'),
(26, 'd2245d0b3f444909', 30, 1, '', '', '', '', '', '', '', '', '', '', '4.90', '9.80', 'canceled', 'confirmed', 'paypal', 'a:25:{s:5:"TOKEN";s:20:"EC-3MR18509X3961013K";s:28:"SUCCESSPAGEREDIRECTREQUESTED";s:5:"false";s:9:"TIMESTAMP";s:20:"2014-11-25T18:05:26Z";s:13:"CORRELATIONID";s:13:"c8cd43128e555";s:3:"ACK";s:7:"Success";s:7:"VERSION";s:5:"109.0";s:5:"BUILD";s:8:"13630372";s:23:"INSURANCEOPTIONSELECTED";s:5:"false";s:23:"SHIPPINGOPTIONISDEFAULT";s:5:"false";s:27:"PAYMENTINFO_0_TRANSACTIONID";s:17:"1495143633387593S";s:29:"PAYMENTINFO_0_TRANSACTIONTYPE";s:15:"expresscheckout";s:25:"PAYMENTINFO_0_PAYMENTTYPE";s:7:"instant";s:23:"PAYMENTINFO_0_ORDERTIME";s:20:"2014-11-25T18:05:26Z";s:17:"PAYMENTINFO_0_AMT";s:4:"9.80";s:20:"PAYMENTINFO_0_FEEAMT";s:4:"0.53";s:20:"PAYMENTINFO_0_TAXAMT";s:4:"0.00";s:26:"PAYMENTINFO_0_CURRENCYCODE";s:3:"GBP";s:27:"PAYMENTINFO_0_PAYMENTSTATUS";s:9:"Completed";s:27:"PAYMENTINFO_0_PENDINGREASON";s:4:"None";s:24:"PAYMENTINFO_0_REASONCODE";s:4:"None";s:35:"PAYMENTINFO_0_PROTECTIONELIGIBILITY";s:8:"Eligible";s:39:"PAYMENTINFO_0_PROTECTIONELIGIBILITYTYPE";s:51:"ItemNotReceivedEligible,UnauthorizedPaymentEligible";s:37:"PAYMENTINFO_0_SECUREMERCHANTACCOUNTID";s:13:"F6CL584Y57P2Y";s:23:"PAYMENTINFO_0_ERRORCODE";s:1:"0";s:17:"PAYMENTINFO_0_ACK";s:7:"Success";}', 9, 2, NULL, '2014-11-25 18:07:55', '2015-03-09 13:55:00'),
(27, '2d8d7dff43978447', 30, 1, '', '', '', '', '', '', '', '', '', '', '4.90', '9.80', 'canceled', 'confirmed', 'paypal', 'a:25:{s:5:"TOKEN";s:20:"EC-8J323400972987739";s:28:"SUCCESSPAGEREDIRECTREQUESTED";s:5:"false";s:9:"TIMESTAMP";s:20:"2014-11-25T19:05:13Z";s:13:"CORRELATIONID";s:12:"ed44a96f593f";s:3:"ACK";s:7:"Success";s:7:"VERSION";s:5:"109.0";s:5:"BUILD";s:8:"13630372";s:23:"INSURANCEOPTIONSELECTED";s:5:"false";s:23:"SHIPPINGOPTIONISDEFAULT";s:5:"false";s:27:"PAYMENTINFO_0_TRANSACTIONID";s:17:"530502624W6130327";s:29:"PAYMENTINFO_0_TRANSACTIONTYPE";s:15:"expresscheckout";s:25:"PAYMENTINFO_0_PAYMENTTYPE";s:7:"instant";s:23:"PAYMENTINFO_0_ORDERTIME";s:20:"2014-11-25T19:05:12Z";s:17:"PAYMENTINFO_0_AMT";s:4:"9.80";s:20:"PAYMENTINFO_0_FEEAMT";s:4:"0.53";s:20:"PAYMENTINFO_0_TAXAMT";s:4:"0.00";s:26:"PAYMENTINFO_0_CURRENCYCODE";s:3:"GBP";s:27:"PAYMENTINFO_0_PAYMENTSTATUS";s:9:"Completed";s:27:"PAYMENTINFO_0_PENDINGREASON";s:4:"None";s:24:"PAYMENTINFO_0_REASONCODE";s:4:"None";s:35:"PAYMENTINFO_0_PROTECTIONELIGIBILITY";s:8:"Eligible";s:39:"PAYMENTINFO_0_PROTECTIONELIGIBILITYTYPE";s:51:"ItemNotReceivedEligible,UnauthorizedPaymentEligible";s:37:"PAYMENTINFO_0_SECUREMERCHANTACCOUNTID";s:13:"F6CL584Y57P2Y";s:23:"PAYMENTINFO_0_ERRORCODE";s:1:"0";s:17:"PAYMENTINFO_0_ACK";s:7:"Success";}', 9, 2, NULL, '2014-11-25 19:08:55', '2015-03-09 13:55:04'),
(28, '0de34a5893aba802', 30, 1, '', '', '', '', '', '', '', '', '', '', '4.90', '9.80', 'canceled', 'confirmed', 'paypal', 'a:25:{s:5:"TOKEN";s:20:"EC-72468445T5003124F";s:28:"SUCCESSPAGEREDIRECTREQUESTED";s:5:"false";s:9:"TIMESTAMP";s:20:"2014-11-25T19:18:18Z";s:13:"CORRELATIONID";s:13:"532dcd80ae55c";s:3:"ACK";s:7:"Success";s:7:"VERSION";s:5:"109.0";s:5:"BUILD";s:8:"13630372";s:23:"INSURANCEOPTIONSELECTED";s:5:"false";s:23:"SHIPPINGOPTIONISDEFAULT";s:5:"false";s:27:"PAYMENTINFO_0_TRANSACTIONID";s:17:"574746971H618721G";s:29:"PAYMENTINFO_0_TRANSACTIONTYPE";s:15:"expresscheckout";s:25:"PAYMENTINFO_0_PAYMENTTYPE";s:7:"instant";s:23:"PAYMENTINFO_0_ORDERTIME";s:20:"2014-11-25T19:18:18Z";s:17:"PAYMENTINFO_0_AMT";s:4:"9.80";s:20:"PAYMENTINFO_0_FEEAMT";s:4:"0.53";s:20:"PAYMENTINFO_0_TAXAMT";s:4:"0.00";s:26:"PAYMENTINFO_0_CURRENCYCODE";s:3:"GBP";s:27:"PAYMENTINFO_0_PAYMENTSTATUS";s:9:"Completed";s:27:"PAYMENTINFO_0_PENDINGREASON";s:4:"None";s:24:"PAYMENTINFO_0_REASONCODE";s:4:"None";s:35:"PAYMENTINFO_0_PROTECTIONELIGIBILITY";s:8:"Eligible";s:39:"PAYMENTINFO_0_PROTECTIONELIGIBILITYTYPE";s:51:"ItemNotReceivedEligible,UnauthorizedPaymentEligible";s:37:"PAYMENTINFO_0_SECUREMERCHANTACCOUNTID";s:13:"F6CL584Y57P2Y";s:23:"PAYMENTINFO_0_ERRORCODE";s:1:"0";s:17:"PAYMENTINFO_0_ACK";s:7:"Success";}', 9, 2, NULL, '2014-11-25 19:15:11', '2015-03-09 13:55:08'),
(29, 'a65663f0dc19b96e', 30, 1, '', '', '', '', '', '', '', '', '', '', '4.90', '9.80', 'canceled', 'confirmed', 'paypal', 'a:25:{s:5:"TOKEN";s:20:"EC-4F9039064F1721549";s:28:"SUCCESSPAGEREDIRECTREQUESTED";s:5:"false";s:9:"TIMESTAMP";s:20:"2014-11-25T19:34:01Z";s:13:"CORRELATIONID";s:13:"a5fc3b572690c";s:3:"ACK";s:7:"Success";s:7:"VERSION";s:5:"109.0";s:5:"BUILD";s:8:"13630372";s:23:"INSURANCEOPTIONSELECTED";s:5:"false";s:23:"SHIPPINGOPTIONISDEFAULT";s:5:"false";s:27:"PAYMENTINFO_0_TRANSACTIONID";s:17:"7BF16452C1810840X";s:29:"PAYMENTINFO_0_TRANSACTIONTYPE";s:15:"expresscheckout";s:25:"PAYMENTINFO_0_PAYMENTTYPE";s:7:"instant";s:23:"PAYMENTINFO_0_ORDERTIME";s:20:"2014-11-25T19:34:01Z";s:17:"PAYMENTINFO_0_AMT";s:4:"9.80";s:20:"PAYMENTINFO_0_FEEAMT";s:4:"0.53";s:20:"PAYMENTINFO_0_TAXAMT";s:4:"0.00";s:26:"PAYMENTINFO_0_CURRENCYCODE";s:3:"GBP";s:27:"PAYMENTINFO_0_PAYMENTSTATUS";s:9:"Completed";s:27:"PAYMENTINFO_0_PENDINGREASON";s:4:"None";s:24:"PAYMENTINFO_0_REASONCODE";s:4:"None";s:35:"PAYMENTINFO_0_PROTECTIONELIGIBILITY";s:8:"Eligible";s:39:"PAYMENTINFO_0_PROTECTIONELIGIBILITYTYPE";s:51:"ItemNotReceivedEligible,UnauthorizedPaymentEligible";s:37:"PAYMENTINFO_0_SECUREMERCHANTACCOUNTID";s:13:"F6CL584Y57P2Y";s:23:"PAYMENTINFO_0_ERRORCODE";s:1:"0";s:17:"PAYMENTINFO_0_ACK";s:7:"Success";}', 9, 2, NULL, '2014-11-25 19:36:32', '2015-03-09 13:55:13'),
(30, 'c816e97903b06f3b', 30, 1, '', '', '', '', '', '', '', '', '', '', '4.90', '9.80', 'canceled', 'confirmed', 'paypal', 'a:25:{s:5:"TOKEN";s:20:"EC-1P481244EE382873T";s:28:"SUCCESSPAGEREDIRECTREQUESTED";s:5:"false";s:9:"TIMESTAMP";s:20:"2014-11-25T20:07:15Z";s:13:"CORRELATIONID";s:13:"3b07210039b89";s:3:"ACK";s:7:"Success";s:7:"VERSION";s:5:"109.0";s:5:"BUILD";s:8:"13630372";s:23:"INSURANCEOPTIONSELECTED";s:5:"false";s:23:"SHIPPINGOPTIONISDEFAULT";s:5:"false";s:27:"PAYMENTINFO_0_TRANSACTIONID";s:17:"6UM65366M52556614";s:29:"PAYMENTINFO_0_TRANSACTIONTYPE";s:15:"expresscheckout";s:25:"PAYMENTINFO_0_PAYMENTTYPE";s:7:"instant";s:23:"PAYMENTINFO_0_ORDERTIME";s:20:"2014-11-25T20:07:15Z";s:17:"PAYMENTINFO_0_AMT";s:4:"9.80";s:20:"PAYMENTINFO_0_FEEAMT";s:4:"0.53";s:20:"PAYMENTINFO_0_TAXAMT";s:4:"0.00";s:26:"PAYMENTINFO_0_CURRENCYCODE";s:3:"GBP";s:27:"PAYMENTINFO_0_PAYMENTSTATUS";s:9:"Completed";s:27:"PAYMENTINFO_0_PENDINGREASON";s:4:"None";s:24:"PAYMENTINFO_0_REASONCODE";s:4:"None";s:35:"PAYMENTINFO_0_PROTECTIONELIGIBILITY";s:8:"Eligible";s:39:"PAYMENTINFO_0_PROTECTIONELIGIBILITYTYPE";s:51:"ItemNotReceivedEligible,UnauthorizedPaymentEligible";s:37:"PAYMENTINFO_0_SECUREMERCHANTACCOUNTID";s:13:"F6CL584Y57P2Y";s:23:"PAYMENTINFO_0_ERRORCODE";s:1:"0";s:17:"PAYMENTINFO_0_ACK";s:7:"Success";}', 9, 2, NULL, '2014-11-25 20:10:40', '2015-03-09 13:55:17'),
(31, 'f9f178e67bd6bece', 30, 1, '', '', '', '', '', '', '', '', '', '', '4.90', '9.80', 'canceled', 'confirmed', 'paypal', 'a:25:{s:5:"TOKEN";s:20:"EC-05N77547292876006";s:28:"SUCCESSPAGEREDIRECTREQUESTED";s:5:"false";s:9:"TIMESTAMP";s:20:"2014-11-25T20:08:28Z";s:13:"CORRELATIONID";s:13:"701764df5d327";s:3:"ACK";s:7:"Success";s:7:"VERSION";s:5:"109.0";s:5:"BUILD";s:8:"13630372";s:23:"INSURANCEOPTIONSELECTED";s:5:"false";s:23:"SHIPPINGOPTIONISDEFAULT";s:5:"false";s:27:"PAYMENTINFO_0_TRANSACTIONID";s:17:"78X792419F492823S";s:29:"PAYMENTINFO_0_TRANSACTIONTYPE";s:15:"expresscheckout";s:25:"PAYMENTINFO_0_PAYMENTTYPE";s:7:"instant";s:23:"PAYMENTINFO_0_ORDERTIME";s:20:"2014-11-25T20:08:28Z";s:17:"PAYMENTINFO_0_AMT";s:4:"9.80";s:20:"PAYMENTINFO_0_FEEAMT";s:4:"0.53";s:20:"PAYMENTINFO_0_TAXAMT";s:4:"0.00";s:26:"PAYMENTINFO_0_CURRENCYCODE";s:3:"GBP";s:27:"PAYMENTINFO_0_PAYMENTSTATUS";s:9:"Completed";s:27:"PAYMENTINFO_0_PENDINGREASON";s:4:"None";s:24:"PAYMENTINFO_0_REASONCODE";s:4:"None";s:35:"PAYMENTINFO_0_PROTECTIONELIGIBILITY";s:8:"Eligible";s:39:"PAYMENTINFO_0_PROTECTIONELIGIBILITYTYPE";s:51:"ItemNotReceivedEligible,UnauthorizedPaymentEligible";s:37:"PAYMENTINFO_0_SECUREMERCHANTACCOUNTID";s:13:"F6CL584Y57P2Y";s:23:"PAYMENTINFO_0_ERRORCODE";s:1:"0";s:17:"PAYMENTINFO_0_ACK";s:7:"Success";}', 9, 2, NULL, '2014-11-25 20:12:12', '2015-03-09 13:55:23'),
(32, 'd0f5645f9ea9459b', 30, 1, '', '', '', '', '', '', '', '', '', '', '4.90', '9.80', 'canceled', 'confirmed', 'paypal', 'a:25:{s:5:"TOKEN";s:20:"EC-4K8429889L138121B";s:28:"SUCCESSPAGEREDIRECTREQUESTED";s:5:"false";s:9:"TIMESTAMP";s:20:"2014-11-25T20:18:23Z";s:13:"CORRELATIONID";s:13:"fe37148d111ca";s:3:"ACK";s:7:"Success";s:7:"VERSION";s:5:"109.0";s:5:"BUILD";s:8:"13630372";s:23:"INSURANCEOPTIONSELECTED";s:5:"false";s:23:"SHIPPINGOPTIONISDEFAULT";s:5:"false";s:27:"PAYMENTINFO_0_TRANSACTIONID";s:17:"7M578462K2842761H";s:29:"PAYMENTINFO_0_TRANSACTIONTYPE";s:15:"expresscheckout";s:25:"PAYMENTINFO_0_PAYMENTTYPE";s:7:"instant";s:23:"PAYMENTINFO_0_ORDERTIME";s:20:"2014-11-25T20:18:22Z";s:17:"PAYMENTINFO_0_AMT";s:4:"9.80";s:20:"PAYMENTINFO_0_FEEAMT";s:4:"0.53";s:20:"PAYMENTINFO_0_TAXAMT";s:4:"0.00";s:26:"PAYMENTINFO_0_CURRENCYCODE";s:3:"GBP";s:27:"PAYMENTINFO_0_PAYMENTSTATUS";s:9:"Completed";s:27:"PAYMENTINFO_0_PENDINGREASON";s:4:"None";s:24:"PAYMENTINFO_0_REASONCODE";s:4:"None";s:35:"PAYMENTINFO_0_PROTECTIONELIGIBILITY";s:8:"Eligible";s:39:"PAYMENTINFO_0_PROTECTIONELIGIBILITYTYPE";s:51:"ItemNotReceivedEligible,UnauthorizedPaymentEligible";s:37:"PAYMENTINFO_0_SECUREMERCHANTACCOUNTID";s:13:"F6CL584Y57P2Y";s:23:"PAYMENTINFO_0_ERRORCODE";s:1:"0";s:17:"PAYMENTINFO_0_ACK";s:7:"Success";}', 9, 2, NULL, '2014-11-25 20:21:52', '2015-03-09 13:55:28'),
(33, '448bba1fd7ad5401', 30, 1, 'info-buyer@enniesgarden.co.uk', '', 'Test Buyer', '1 Main Terrace', 'Wolverhampton', 'W12 4LQ', 'Test Buyer', '1 Main Terrace', 'Wolverhampton', 'W12 4LQ', '4.90', '9.80', 'canceled', 'success', 'paypal', 'a:25:{s:5:"TOKEN";s:20:"EC-22548711V1679184M";s:28:"SUCCESSPAGEREDIRECTREQUESTED";s:5:"false";s:9:"TIMESTAMP";s:20:"2014-11-25T21:24:17Z";s:13:"CORRELATIONID";s:13:"d75405a1b4a6b";s:3:"ACK";s:7:"Success";s:7:"VERSION";s:5:"109.0";s:5:"BUILD";s:8:"13630372";s:23:"INSURANCEOPTIONSELECTED";s:5:"false";s:23:"SHIPPINGOPTIONISDEFAULT";s:5:"false";s:27:"PAYMENTINFO_0_TRANSACTIONID";s:17:"2CV2974594553752M";s:29:"PAYMENTINFO_0_TRANSACTIONTYPE";s:15:"expresscheckout";s:25:"PAYMENTINFO_0_PAYMENTTYPE";s:7:"instant";s:23:"PAYMENTINFO_0_ORDERTIME";s:20:"2014-11-25T21:24:17Z";s:17:"PAYMENTINFO_0_AMT";s:4:"9.80";s:20:"PAYMENTINFO_0_FEEAMT";s:4:"0.53";s:20:"PAYMENTINFO_0_TAXAMT";s:4:"0.00";s:26:"PAYMENTINFO_0_CURRENCYCODE";s:3:"GBP";s:27:"PAYMENTINFO_0_PAYMENTSTATUS";s:9:"Completed";s:27:"PAYMENTINFO_0_PENDINGREASON";s:4:"None";s:24:"PAYMENTINFO_0_REASONCODE";s:4:"None";s:35:"PAYMENTINFO_0_PROTECTIONELIGIBILITY";s:8:"Eligible";s:39:"PAYMENTINFO_0_PROTECTIONELIGIBILITYTYPE";s:51:"ItemNotReceivedEligible,UnauthorizedPaymentEligible";s:37:"PAYMENTINFO_0_SECUREMERCHANTACCOUNTID";s:13:"F6CL584Y57P2Y";s:23:"PAYMENTINFO_0_ERRORCODE";s:1:"0";s:17:"PAYMENTINFO_0_ACK";s:7:"Success";}', 9, 2, NULL, '2014-11-25 21:28:01', '2015-03-09 13:53:24'),
(34, '4afc5310c038637e', 30, 1, '', '', '', '', '', '', '', '', '', '', '4.90', '14.70', 'canceled', 'pending', 'paypal', '', 9, 2, NULL, '2014-11-27 14:20:03', '2015-03-09 13:55:32'),
(35, 'd0e911f20d3f402d', 30, 1, 'syke@outlook.com', '', 'Attila Keszthelyi', '1 Main Terrace', 'Wolverhampton', 'W12 4LQ', 'Attila Keszthelyi', '1 Main Terrace', 'Wolverhampton', 'W12 4LQ', '4.90', '19.60', 'shipped', 'confirmed', 'paypal', 'a:25:{s:5:"TOKEN";s:20:"EC-6DC85369EC241143V";s:28:"SUCCESSPAGEREDIRECTREQUESTED";s:5:"false";s:9:"TIMESTAMP";s:20:"2014-11-27T14:29:05Z";s:13:"CORRELATIONID";s:13:"414e9fcb5a0cf";s:3:"ACK";s:7:"Success";s:7:"VERSION";s:5:"109.0";s:5:"BUILD";s:8:"13630372";s:23:"INSURANCEOPTIONSELECTED";s:5:"false";s:23:"SHIPPINGOPTIONISDEFAULT";s:5:"false";s:27:"PAYMENTINFO_0_TRANSACTIONID";s:17:"77267414W6556980E";s:29:"PAYMENTINFO_0_TRANSACTIONTYPE";s:15:"expresscheckout";s:25:"PAYMENTINFO_0_PAYMENTTYPE";s:7:"instant";s:23:"PAYMENTINFO_0_ORDERTIME";s:20:"2014-11-27T14:29:05Z";s:17:"PAYMENTINFO_0_AMT";s:5:"19.60";s:20:"PAYMENTINFO_0_FEEAMT";s:4:"0.87";s:20:"PAYMENTINFO_0_TAXAMT";s:4:"0.00";s:26:"PAYMENTINFO_0_CURRENCYCODE";s:3:"GBP";s:27:"PAYMENTINFO_0_PAYMENTSTATUS";s:9:"Completed";s:27:"PAYMENTINFO_0_PENDINGREASON";s:4:"None";s:24:"PAYMENTINFO_0_REASONCODE";s:4:"None";s:35:"PAYMENTINFO_0_PROTECTIONELIGIBILITY";s:8:"Eligible";s:39:"PAYMENTINFO_0_PROTECTIONELIGIBILITYTYPE";s:51:"ItemNotReceivedEligible,UnauthorizedPaymentEligible";s:37:"PAYMENTINFO_0_SECUREMERCHANTACCOUNTID";s:13:"F6CL584Y57P2Y";s:23:"PAYMENTINFO_0_ERRORCODE";s:1:"0";s:17:"PAYMENTINFO_0_ACK";s:7:"Success";}', 9, 2, NULL, '2014-11-27 14:31:34', '2015-02-22 12:22:52'),
(36, '41530857f952d8f2', 30, 1, 'syke@outlook.com', '', 'Attila Keszthelyi', '1 Main Terrace', 'Wolverhampton', 'W12 4LQ', 'Attila Keszthelyi', '1 Main Terrace', 'Wolverhampton', 'W12 4LQ', '4.90', '9.80', 'canceled', 'success', 'paypal', 'a:25:{s:5:"TOKEN";s:20:"EC-55K5977401129433C";s:28:"SUCCESSPAGEREDIRECTREQUESTED";s:5:"false";s:9:"TIMESTAMP";s:20:"2014-11-27T14:41:14Z";s:13:"CORRELATIONID";s:11:"c168e1880ec";s:3:"ACK";s:7:"Success";s:7:"VERSION";s:5:"109.0";s:5:"BUILD";s:8:"13630372";s:23:"INSURANCEOPTIONSELECTED";s:5:"false";s:23:"SHIPPINGOPTIONISDEFAULT";s:5:"false";s:27:"PAYMENTINFO_0_TRANSACTIONID";s:17:"2G581426TC091583P";s:29:"PAYMENTINFO_0_TRANSACTIONTYPE";s:15:"expresscheckout";s:25:"PAYMENTINFO_0_PAYMENTTYPE";s:7:"instant";s:23:"PAYMENTINFO_0_ORDERTIME";s:20:"2014-11-27T14:41:13Z";s:17:"PAYMENTINFO_0_AMT";s:4:"9.80";s:20:"PAYMENTINFO_0_FEEAMT";s:4:"0.53";s:20:"PAYMENTINFO_0_TAXAMT";s:4:"0.00";s:26:"PAYMENTINFO_0_CURRENCYCODE";s:3:"GBP";s:27:"PAYMENTINFO_0_PAYMENTSTATUS";s:9:"Completed";s:27:"PAYMENTINFO_0_PENDINGREASON";s:4:"None";s:24:"PAYMENTINFO_0_REASONCODE";s:4:"None";s:35:"PAYMENTINFO_0_PROTECTIONELIGIBILITY";s:8:"Eligible";s:39:"PAYMENTINFO_0_PROTECTIONELIGIBILITYTYPE";s:51:"ItemNotReceivedEligible,UnauthorizedPaymentEligible";s:37:"PAYMENTINFO_0_SECUREMERCHANTACCOUNTID";s:13:"F6CL584Y57P2Y";s:23:"PAYMENTINFO_0_ERRORCODE";s:1:"0";s:17:"PAYMENTINFO_0_ACK";s:7:"Success";}', 9, 2, NULL, '2014-11-27 14:45:03', '2015-03-09 13:52:36'),
(37, 'a75135171a5a6c97', 30, 1, 'syke@outlook.com', '', 'Attila Keszthelyi', '1 Main Terrace', 'Wolverhampton', 'W12 4LQ', 'Attila Keszthelyi', '1 Main Terrace', 'Wolverhampton', 'W12 4LQ', '4.90', '9.80', 'shipped', 'success', 'paypal', 'a:25:{s:5:"TOKEN";s:20:"EC-8PK66978KC939233S";s:28:"SUCCESSPAGEREDIRECTREQUESTED";s:5:"false";s:9:"TIMESTAMP";s:20:"2014-11-27T16:53:24Z";s:13:"CORRELATIONID";s:13:"1f72220b5c12c";s:3:"ACK";s:7:"Success";s:7:"VERSION";s:5:"109.0";s:5:"BUILD";s:8:"13630372";s:23:"INSURANCEOPTIONSELECTED";s:5:"false";s:23:"SHIPPINGOPTIONISDEFAULT";s:5:"false";s:27:"PAYMENTINFO_0_TRANSACTIONID";s:17:"21U36886XH317894G";s:29:"PAYMENTINFO_0_TRANSACTIONTYPE";s:15:"expresscheckout";s:25:"PAYMENTINFO_0_PAYMENTTYPE";s:7:"instant";s:23:"PAYMENTINFO_0_ORDERTIME";s:20:"2014-11-27T16:53:24Z";s:17:"PAYMENTINFO_0_AMT";s:4:"9.80";s:20:"PAYMENTINFO_0_FEEAMT";s:4:"0.53";s:20:"PAYMENTINFO_0_TAXAMT";s:4:"0.00";s:26:"PAYMENTINFO_0_CURRENCYCODE";s:3:"GBP";s:27:"PAYMENTINFO_0_PAYMENTSTATUS";s:9:"Completed";s:27:"PAYMENTINFO_0_PENDINGREASON";s:4:"None";s:24:"PAYMENTINFO_0_REASONCODE";s:4:"None";s:35:"PAYMENTINFO_0_PROTECTIONELIGIBILITY";s:8:"Eligible";s:39:"PAYMENTINFO_0_PROTECTIONELIGIBILITYTYPE";s:51:"ItemNotReceivedEligible,UnauthorizedPaymentEligible";s:37:"PAYMENTINFO_0_SECUREMERCHANTACCOUNTID";s:13:"F6CL584Y57P2Y";s:23:"PAYMENTINFO_0_ERRORCODE";s:1:"0";s:17:"PAYMENTINFO_0_ACK";s:7:"Success";}', 9, 2, NULL, '2014-11-27 16:57:12', '2014-11-27 21:11:09'),
(38, '3d30d616b54eac57', 30, 1, 'replugged@freemail.hu', '', 'Attila Keszthelyi', '56 Grace rd', 'Leicester', 'LE2 8AE', 'Attila Keszthelyi', '56 Grace rd', 'Leicester', 'LE2 8AE', '4.90', '9.80', 'canceled', 'confirmed', 'paypal', 'a:25:{s:5:"TOKEN";s:20:"EC-55T44504HG448472S";s:28:"SUCCESSPAGEREDIRECTREQUESTED";s:5:"false";s:9:"TIMESTAMP";s:20:"2014-11-28T12:49:05Z";s:13:"CORRELATIONID";s:13:"a487f890c7fa2";s:3:"ACK";s:7:"Success";s:7:"VERSION";s:5:"109.0";s:5:"BUILD";s:8:"13630372";s:23:"INSURANCEOPTIONSELECTED";s:5:"false";s:23:"SHIPPINGOPTIONISDEFAULT";s:5:"false";s:27:"PAYMENTINFO_0_TRANSACTIONID";s:17:"49U17697RV931254K";s:29:"PAYMENTINFO_0_TRANSACTIONTYPE";s:15:"expresscheckout";s:25:"PAYMENTINFO_0_PAYMENTTYPE";s:7:"instant";s:23:"PAYMENTINFO_0_ORDERTIME";s:20:"2014-11-28T12:49:04Z";s:17:"PAYMENTINFO_0_AMT";s:4:"9.80";s:20:"PAYMENTINFO_0_FEEAMT";s:4:"0.63";s:20:"PAYMENTINFO_0_TAXAMT";s:4:"0.00";s:26:"PAYMENTINFO_0_CURRENCYCODE";s:3:"GBP";s:27:"PAYMENTINFO_0_PAYMENTSTATUS";s:9:"Completed";s:27:"PAYMENTINFO_0_PENDINGREASON";s:4:"None";s:24:"PAYMENTINFO_0_REASONCODE";s:4:"None";s:35:"PAYMENTINFO_0_PROTECTIONELIGIBILITY";s:8:"Eligible";s:39:"PAYMENTINFO_0_PROTECTIONELIGIBILITYTYPE";s:51:"ItemNotReceivedEligible,UnauthorizedPaymentEligible";s:37:"PAYMENTINFO_0_SECUREMERCHANTACCOUNTID";s:13:"CUBUFKDL96EVQ";s:23:"PAYMENTINFO_0_ERRORCODE";s:1:"0";s:17:"PAYMENTINFO_0_ACK";s:7:"Success";}', 9, 2, NULL, '2014-11-28 12:52:05', '2015-03-09 13:52:42'),
(39, 'f9020dcb50bdb321', 30, 1, '', '', '', '', '', '', '', '', '', '', '4.90', '9.80', 'canceled', 'pending', 'paypal', '', 9, 2, NULL, '2014-12-02 11:27:32', '2015-03-09 13:55:37'),
(40, 'fa53792906be132d', 30, 1, '', '', '', '', '', '', '', '', '', '', '0.00', '9.59', 'canceled', 'pending', 'paypal', '', 9, 2, NULL, '2014-12-10 12:11:26', '2015-03-09 13:55:41'),
(41, '2dce9f0af2832ae5', 30, 1, 'replugged@freemail.hu', '', 'Attila Keszthelyi', '56 Grace rd', 'Leicester', 'LE2 8AE', 'Attila Keszthelyi', '56 Grace rd', 'Leicester', 'LE2 8AE', '0.00', '9.59', 'canceled', 'success', 'paypal', 'a:25:{s:5:"TOKEN";s:20:"EC-33162354JP588145A";s:28:"SUCCESSPAGEREDIRECTREQUESTED";s:5:"false";s:9:"TIMESTAMP";s:20:"2014-12-10T12:25:11Z";s:13:"CORRELATIONID";s:12:"904fcf5e331a";s:3:"ACK";s:7:"Success";s:7:"VERSION";s:5:"109.0";s:5:"BUILD";s:8:"14107150";s:23:"INSURANCEOPTIONSELECTED";s:5:"false";s:23:"SHIPPINGOPTIONISDEFAULT";s:5:"false";s:27:"PAYMENTINFO_0_TRANSACTIONID";s:17:"4LC62158RE792480X";s:29:"PAYMENTINFO_0_TRANSACTIONTYPE";s:15:"expresscheckout";s:25:"PAYMENTINFO_0_PAYMENTTYPE";s:7:"instant";s:23:"PAYMENTINFO_0_ORDERTIME";s:20:"2014-12-10T12:25:10Z";s:17:"PAYMENTINFO_0_AMT";s:4:"9.59";s:20:"PAYMENTINFO_0_FEEAMT";s:4:"0.62";s:20:"PAYMENTINFO_0_TAXAMT";s:4:"0.00";s:26:"PAYMENTINFO_0_CURRENCYCODE";s:3:"GBP";s:27:"PAYMENTINFO_0_PAYMENTSTATUS";s:9:"Completed";s:27:"PAYMENTINFO_0_PENDINGREASON";s:4:"None";s:24:"PAYMENTINFO_0_REASONCODE";s:4:"None";s:35:"PAYMENTINFO_0_PROTECTIONELIGIBILITY";s:8:"Eligible";s:39:"PAYMENTINFO_0_PROTECTIONELIGIBILITYTYPE";s:51:"ItemNotReceivedEligible,UnauthorizedPaymentEligible";s:37:"PAYMENTINFO_0_SECUREMERCHANTACCOUNTID";s:13:"CUBUFKDL96EVQ";s:23:"PAYMENTINFO_0_ERRORCODE";s:1:"0";s:17:"PAYMENTINFO_0_ACK";s:7:"Success";}', 9, 2, NULL, '2014-12-10 12:27:17', '2015-03-09 13:53:05'),
(42, '55edc7dcdceb22b2', 30, 1, 'info-buyer@enniesgarden.co.uk', '', 'Test Buyer', '1 Main Terrace', 'Wolverhampton', 'W12 4LQ', 'Test Buyer', '1 Main Terrace', 'Wolverhampton', 'W12 4LQ', '0.00', '9.59', 'canceled', 'success', 'paypal', 'a:25:{s:5:"TOKEN";s:20:"EC-09P835473E5206720";s:28:"SUCCESSPAGEREDIRECTREQUESTED";s:5:"false";s:9:"TIMESTAMP";s:20:"2014-12-10T12:33:08Z";s:13:"CORRELATIONID";s:13:"41681542a7976";s:3:"ACK";s:7:"Success";s:7:"VERSION";s:5:"109.0";s:5:"BUILD";s:8:"14107150";s:23:"INSURANCEOPTIONSELECTED";s:5:"false";s:23:"SHIPPINGOPTIONISDEFAULT";s:5:"false";s:27:"PAYMENTINFO_0_TRANSACTIONID";s:17:"22333248M0373273F";s:29:"PAYMENTINFO_0_TRANSACTIONTYPE";s:15:"expresscheckout";s:25:"PAYMENTINFO_0_PAYMENTTYPE";s:7:"instant";s:23:"PAYMENTINFO_0_ORDERTIME";s:20:"2014-12-10T12:33:08Z";s:17:"PAYMENTINFO_0_AMT";s:4:"9.59";s:20:"PAYMENTINFO_0_FEEAMT";s:4:"0.53";s:20:"PAYMENTINFO_0_TAXAMT";s:4:"0.00";s:26:"PAYMENTINFO_0_CURRENCYCODE";s:3:"GBP";s:27:"PAYMENTINFO_0_PAYMENTSTATUS";s:9:"Completed";s:27:"PAYMENTINFO_0_PENDINGREASON";s:4:"None";s:24:"PAYMENTINFO_0_REASONCODE";s:4:"None";s:35:"PAYMENTINFO_0_PROTECTIONELIGIBILITY";s:8:"Eligible";s:39:"PAYMENTINFO_0_PROTECTIONELIGIBILITYTYPE";s:51:"ItemNotReceivedEligible,UnauthorizedPaymentEligible";s:37:"PAYMENTINFO_0_SECUREMERCHANTACCOUNTID";s:13:"F6CL584Y57P2Y";s:23:"PAYMENTINFO_0_ERRORCODE";s:1:"0";s:17:"PAYMENTINFO_0_ACK";s:7:"Success";}', 9, 2, NULL, '2014-12-10 12:36:56', '2015-03-09 13:53:19'),
(43, '66192ead9b7c9e5e', 30, 1, 'info-buyer@enniesgarden.co.uk', '', 'Test Buyer', '1 Main Terrace', 'Wolverhampton', 'W12 4LQ', 'Test Buyer', '1 Main Terrace', 'Wolverhampton', 'W12 4LQ', '0.00', '9.59', 'canceled', 'success', 'paypal', 'a:25:{s:5:"TOKEN";s:20:"EC-2VM98565P44867146";s:28:"SUCCESSPAGEREDIRECTREQUESTED";s:5:"false";s:9:"TIMESTAMP";s:20:"2014-12-10T12:36:28Z";s:13:"CORRELATIONID";s:13:"92c7748236082";s:3:"ACK";s:7:"Success";s:7:"VERSION";s:5:"109.0";s:5:"BUILD";s:8:"14107150";s:23:"INSURANCEOPTIONSELECTED";s:5:"false";s:23:"SHIPPINGOPTIONISDEFAULT";s:5:"false";s:27:"PAYMENTINFO_0_TRANSACTIONID";s:17:"647109776D808971T";s:29:"PAYMENTINFO_0_TRANSACTIONTYPE";s:15:"expresscheckout";s:25:"PAYMENTINFO_0_PAYMENTTYPE";s:7:"instant";s:23:"PAYMENTINFO_0_ORDERTIME";s:20:"2014-12-10T12:36:28Z";s:17:"PAYMENTINFO_0_AMT";s:4:"9.59";s:20:"PAYMENTINFO_0_FEEAMT";s:4:"0.53";s:20:"PAYMENTINFO_0_TAXAMT";s:4:"0.00";s:26:"PAYMENTINFO_0_CURRENCYCODE";s:3:"GBP";s:27:"PAYMENTINFO_0_PAYMENTSTATUS";s:9:"Completed";s:27:"PAYMENTINFO_0_PENDINGREASON";s:4:"None";s:24:"PAYMENTINFO_0_REASONCODE";s:4:"None";s:35:"PAYMENTINFO_0_PROTECTIONELIGIBILITY";s:8:"Eligible";s:39:"PAYMENTINFO_0_PROTECTIONELIGIBILITYTYPE";s:51:"ItemNotReceivedEligible,UnauthorizedPaymentEligible";s:37:"PAYMENTINFO_0_SECUREMERCHANTACCOUNTID";s:13:"F6CL584Y57P2Y";s:23:"PAYMENTINFO_0_ERRORCODE";s:1:"0";s:17:"PAYMENTINFO_0_ACK";s:7:"Success";}', 9, 2, NULL, '2014-12-10 12:40:25', '2015-03-09 13:53:30'),
(44, '952aea944ed920f5', 30, 1, 'replugged@freemail.hu', '', 'Keszthelyi Attila', 'Lajos u. 117\r\nIII/17', 'Budapest', '1036', 'Keszthelyi Attila', 'Lajos u. 117\r\nIII/17', 'Budapest', '1036', '0.00', '14.99', 'canceled', 'success', 'paypal', 'a:25:{s:5:"TOKEN";s:20:"EC-7J466891RP7623059";s:28:"SUCCESSPAGEREDIRECTREQUESTED";s:5:"false";s:9:"TIMESTAMP";s:20:"2014-12-10T18:38:07Z";s:13:"CORRELATIONID";s:13:"fc5869dd25e27";s:3:"ACK";s:7:"Success";s:7:"VERSION";s:5:"109.0";s:5:"BUILD";s:8:"14107150";s:23:"INSURANCEOPTIONSELECTED";s:5:"false";s:23:"SHIPPINGOPTIONISDEFAULT";s:5:"false";s:27:"PAYMENTINFO_0_TRANSACTIONID";s:17:"9DM32516PH858982V";s:29:"PAYMENTINFO_0_TRANSACTIONTYPE";s:15:"expresscheckout";s:25:"PAYMENTINFO_0_PAYMENTTYPE";s:7:"instant";s:23:"PAYMENTINFO_0_ORDERTIME";s:20:"2014-12-10T18:38:06Z";s:17:"PAYMENTINFO_0_AMT";s:5:"14.99";s:20:"PAYMENTINFO_0_FEEAMT";s:4:"0.86";s:20:"PAYMENTINFO_0_TAXAMT";s:4:"0.00";s:26:"PAYMENTINFO_0_CURRENCYCODE";s:3:"GBP";s:27:"PAYMENTINFO_0_PAYMENTSTATUS";s:9:"Completed";s:27:"PAYMENTINFO_0_PENDINGREASON";s:4:"None";s:24:"PAYMENTINFO_0_REASONCODE";s:4:"None";s:35:"PAYMENTINFO_0_PROTECTIONELIGIBILITY";s:8:"Eligible";s:39:"PAYMENTINFO_0_PROTECTIONELIGIBILITYTYPE";s:51:"ItemNotReceivedEligible,UnauthorizedPaymentEligible";s:37:"PAYMENTINFO_0_SECUREMERCHANTACCOUNTID";s:13:"CUBUFKDL96EVQ";s:23:"PAYMENTINFO_0_ERRORCODE";s:1:"0";s:17:"PAYMENTINFO_0_ACK";s:7:"Success";}', 9, 2, NULL, '2014-12-10 18:42:18', '2015-03-09 13:53:37'),
(45, '9f593eacbf518fdf', 30, 1, '', '', '', '', '', '', '', '', '', '', '0.00', '9.80', 'canceled', 'pending', 'paypal', '', 9, 2, NULL, '2014-12-11 20:26:45', '2015-03-09 13:55:45'),
(46, '819cd5c94a521b3c', 30, 1, '', '', '', '', '', '', '', '', '', '', '0.00', '4.90', 'canceled', 'pending', 'paypal', '', 9, 2, NULL, '2014-12-12 21:45:58', '2015-03-09 13:55:49'),
(47, 'e38ec9815ed6489f', 30, 1, '', '', '', '', '', '', '', '', '', '', '0.00', '3.90', 'canceled', 'pending', 'paypal', '', 9, 2, NULL, '2014-12-14 13:03:53', '2015-03-09 13:55:54'),
(48, 'd6679f8cf1cf3f9f', 30, 1, 'info-buyer@enniesgarden.co.uk', '', 'Test Buyer', '1 Main Terrace', 'Wolverhampton', 'W12 4LQ', 'Test Buyer', '1 Main Terrace', 'Wolverhampton', 'W12 4LQ', '2.99', '7.89', 'shipped', 'confirmed', 'paypal', 'a:25:{s:5:"TOKEN";s:20:"EC-59P517770V7164936";s:28:"SUCCESSPAGEREDIRECTREQUESTED";s:5:"false";s:9:"TIMESTAMP";s:20:"2015-01-07T13:19:13Z";s:13:"CORRELATIONID";s:13:"2ba3228bb8d95";s:3:"ACK";s:7:"Success";s:7:"VERSION";s:5:"109.0";s:5:"BUILD";s:8:"14685089";s:23:"INSURANCEOPTIONSELECTED";s:5:"false";s:23:"SHIPPINGOPTIONISDEFAULT";s:5:"false";s:27:"PAYMENTINFO_0_TRANSACTIONID";s:17:"99T19983W7187780T";s:29:"PAYMENTINFO_0_TRANSACTIONTYPE";s:15:"expresscheckout";s:25:"PAYMENTINFO_0_PAYMENTTYPE";s:7:"instant";s:23:"PAYMENTINFO_0_ORDERTIME";s:20:"2015-01-07T13:19:12Z";s:17:"PAYMENTINFO_0_AMT";s:4:"7.89";s:20:"PAYMENTINFO_0_FEEAMT";s:4:"0.47";s:20:"PAYMENTINFO_0_TAXAMT";s:4:"0.00";s:26:"PAYMENTINFO_0_CURRENCYCODE";s:3:"GBP";s:27:"PAYMENTINFO_0_PAYMENTSTATUS";s:9:"Completed";s:27:"PAYMENTINFO_0_PENDINGREASON";s:4:"None";s:24:"PAYMENTINFO_0_REASONCODE";s:4:"None";s:35:"PAYMENTINFO_0_PROTECTIONELIGIBILITY";s:8:"Eligible";s:39:"PAYMENTINFO_0_PROTECTIONELIGIBILITYTYPE";s:51:"ItemNotReceivedEligible,UnauthorizedPaymentEligible";s:37:"PAYMENTINFO_0_SECUREMERCHANTACCOUNTID";s:13:"F6CL584Y57P2Y";s:23:"PAYMENTINFO_0_ERRORCODE";s:1:"0";s:17:"PAYMENTINFO_0_ACK";s:7:"Success";}', 9, 2, NULL, '2015-01-07 13:23:44', '2015-01-07 13:29:03'),
(49, 'c4a3296b97ad937a', 30, 1, 'info-buyer@enniesgarden.co.uk', '', 'Test Buyer', '1 Main Terrace', 'Wolverhampton', 'W12 4LQ', 'Test Buyer', '1 Main Terrace', 'Wolverhampton', 'W12 4LQ', '2.99', '6.89', 'canceled', 'confirmed', 'paypal', 'a:25:{s:5:"TOKEN";s:20:"EC-5MV38959120103302";s:28:"SUCCESSPAGEREDIRECTREQUESTED";s:5:"false";s:9:"TIMESTAMP";s:20:"2015-01-09T23:44:04Z";s:13:"CORRELATIONID";s:13:"3656142729e9c";s:3:"ACK";s:7:"Success";s:7:"VERSION";s:5:"109.0";s:5:"BUILD";s:8:"14726230";s:23:"INSURANCEOPTIONSELECTED";s:5:"false";s:23:"SHIPPINGOPTIONISDEFAULT";s:5:"false";s:27:"PAYMENTINFO_0_TRANSACTIONID";s:17:"1BM97486TA4153026";s:29:"PAYMENTINFO_0_TRANSACTIONTYPE";s:15:"expresscheckout";s:25:"PAYMENTINFO_0_PAYMENTTYPE";s:7:"instant";s:23:"PAYMENTINFO_0_ORDERTIME";s:20:"2015-01-09T23:44:04Z";s:17:"PAYMENTINFO_0_AMT";s:4:"6.89";s:20:"PAYMENTINFO_0_FEEAMT";s:4:"0.43";s:20:"PAYMENTINFO_0_TAXAMT";s:4:"0.00";s:26:"PAYMENTINFO_0_CURRENCYCODE";s:3:"GBP";s:27:"PAYMENTINFO_0_PAYMENTSTATUS";s:9:"Completed";s:27:"PAYMENTINFO_0_PENDINGREASON";s:4:"None";s:24:"PAYMENTINFO_0_REASONCODE";s:4:"None";s:35:"PAYMENTINFO_0_PROTECTIONELIGIBILITY";s:8:"Eligible";s:39:"PAYMENTINFO_0_PROTECTIONELIGIBILITYTYPE";s:51:"ItemNotReceivedEligible,UnauthorizedPaymentEligible";s:37:"PAYMENTINFO_0_SECUREMERCHANTACCOUNTID";s:13:"F6CL584Y57P2Y";s:23:"PAYMENTINFO_0_ERRORCODE";s:1:"0";s:17:"PAYMENTINFO_0_ACK";s:7:"Success";}', 9, 2, NULL, '2015-01-09 23:47:48', '2015-03-09 13:53:44'),
(50, 'c3addb91933fe810', 30, 1, '', '', '', '', '', '', '', '', '', '', '2.99', '7.40', 'canceled', 'pending', 'paypal', '', 9, 2, 1, '2015-01-21 13:40:32', '2015-03-09 13:55:58'),
(51, '8b0fc6553f21d6bc', 30, 1, '', '', '', '', '', '', '', '', '', '', '2.99', '16.98', 'canceled', 'pending', 'paypal', '', 9, 2, NULL, '2015-01-29 11:04:26', '2015-03-09 13:56:02'),
(52, '0f5bcac65346162e', 30, 1, 'syke80@gmail.com', '', '', '', '', '', '', '', '', '', '0.00', '4.90', 'canceled', 'pending', 'paypal', '', 9, 2, 2, '2015-02-08 23:41:26', '2015-03-09 13:53:51'),
(53, '367095b65268763f', 30, 1, 'jim.baker2912@btinternet.com', '', 'Jim Baker', '33 King Edward Road\r\nWaltham Cross', 'Hertfordshire', 'EN8 7HX', 'Jim Baker', '33 King Edward Road\r\nWaltham Cross', 'Hertfordshire', 'EN8 7HX', '0.00', '27.00', 'shipped', 'success', 'paypal', 'a:25:{s:5:"TOKEN";s:20:"EC-9X558645JJ432992W";s:28:"SUCCESSPAGEREDIRECTREQUESTED";s:5:"false";s:9:"TIMESTAMP";s:20:"2015-02-21T21:29:11Z";s:13:"CORRELATIONID";s:12:"94ac5c2c191b";s:3:"ACK";s:7:"Success";s:7:"VERSION";s:5:"109.0";s:5:"BUILD";s:8:"15295733";s:23:"INSURANCEOPTIONSELECTED";s:5:"false";s:23:"SHIPPINGOPTIONISDEFAULT";s:5:"false";s:27:"PAYMENTINFO_0_TRANSACTIONID";s:17:"6XX08778NR010851W";s:29:"PAYMENTINFO_0_TRANSACTIONTYPE";s:15:"expresscheckout";s:25:"PAYMENTINFO_0_PAYMENTTYPE";s:7:"instant";s:23:"PAYMENTINFO_0_ORDERTIME";s:20:"2015-02-21T21:29:09Z";s:17:"PAYMENTINFO_0_AMT";s:5:"27.00";s:20:"PAYMENTINFO_0_FEEAMT";s:4:"1.12";s:20:"PAYMENTINFO_0_TAXAMT";s:4:"0.00";s:26:"PAYMENTINFO_0_CURRENCYCODE";s:3:"GBP";s:27:"PAYMENTINFO_0_PAYMENTSTATUS";s:9:"Completed";s:27:"PAYMENTINFO_0_PENDINGREASON";s:4:"None";s:24:"PAYMENTINFO_0_REASONCODE";s:4:"None";s:35:"PAYMENTINFO_0_PROTECTIONELIGIBILITY";s:8:"Eligible";s:39:"PAYMENTINFO_0_PROTECTIONELIGIBILITYTYPE";s:51:"ItemNotReceivedEligible,UnauthorizedPaymentEligible";s:37:"PAYMENTINFO_0_SECUREMERCHANTACCOUNTID";s:13:"CUBUFKDL96EVQ";s:23:"PAYMENTINFO_0_ERRORCODE";s:1:"0";s:17:"PAYMENTINFO_0_ACK";s:7:"Success";}', 9, 2, NULL, '2015-02-21 21:35:54', '2015-02-23 09:22:55'),
(54, 'ec5bf50bb4d15277', 30, 1, '', '', '', '', '', '', '', '', '', '', '2.99', '27.28', 'canceled', 'pending', 'paypal', '', 9, 2, NULL, '2015-03-01 13:49:21', '2015-03-09 13:56:07'),
(55, '35fb9f282458c381', 30, 1, '', '', '', '', '', '', '', '', '', '', '2.99', '6.89', 'canceled', 'pending', 'paypal', '', 9, 2, NULL, '2015-03-02 21:38:34', '2015-03-09 13:56:12'),
(56, '2dafa999f2e2ba9c', 30, 1, 'jamesward1@outlook.com', '', 'J WARD', '64 Glenhead Drive', 'Motherwell', 'ML1 2DS', 'J WARD', '64 Glenhead Drive', 'Motherwell', 'ML1 2DS', '2.99', '27.69', 'shipped', 'success', 'paypal', 'a:25:{s:5:"TOKEN";s:20:"EC-5LU73709H2202314T";s:28:"SUCCESSPAGEREDIRECTREQUESTED";s:5:"false";s:9:"TIMESTAMP";s:20:"2015-03-07T17:36:53Z";s:13:"CORRELATIONID";s:13:"bdf3ed9bd80de";s:3:"ACK";s:7:"Success";s:7:"VERSION";s:5:"109.0";s:5:"BUILD";s:8:"15640276";s:23:"INSURANCEOPTIONSELECTED";s:5:"false";s:23:"SHIPPINGOPTIONISDEFAULT";s:5:"false";s:27:"PAYMENTINFO_0_TRANSACTIONID";s:17:"2HR96864D2684842M";s:29:"PAYMENTINFO_0_TRANSACTIONTYPE";s:15:"expresscheckout";s:25:"PAYMENTINFO_0_PAYMENTTYPE";s:7:"instant";s:23:"PAYMENTINFO_0_ORDERTIME";s:20:"2015-03-07T17:36:52Z";s:17:"PAYMENTINFO_0_AMT";s:5:"27.69";s:20:"PAYMENTINFO_0_FEEAMT";s:4:"1.14";s:20:"PAYMENTINFO_0_TAXAMT";s:4:"0.00";s:26:"PAYMENTINFO_0_CURRENCYCODE";s:3:"GBP";s:27:"PAYMENTINFO_0_PAYMENTSTATUS";s:9:"Completed";s:27:"PAYMENTINFO_0_PENDINGREASON";s:4:"None";s:24:"PAYMENTINFO_0_REASONCODE";s:4:"None";s:35:"PAYMENTINFO_0_PROTECTIONELIGIBILITY";s:8:"Eligible";s:39:"PAYMENTINFO_0_PROTECTIONELIGIBILITYTYPE";s:51:"ItemNotReceivedEligible,UnauthorizedPaymentEligible";s:37:"PAYMENTINFO_0_SECUREMERCHANTACCOUNTID";s:13:"CUBUFKDL96EVQ";s:23:"PAYMENTINFO_0_ERRORCODE";s:1:"0";s:17:"PAYMENTINFO_0_ACK";s:7:"Success";}', 9, 2, NULL, '2015-03-07 17:41:52', '2015-03-08 13:33:29'),
(57, '2adfa0b1d133c4ff', 30, 1, '', '', '', '', '', '', '', '', '', '', '2.99', '17.69', 'pending', 'pending', 'paypal', '', 9, 2, NULL, '2015-03-12 16:17:36', '2015-03-12 16:17:36'),
(58, '0a020d3b8485949a', 30, 1, '', '', '', '', '', '', '', '', '', '', '2.99', '7.89', 'pending', 'pending', 'paypal', '', 9, 2, NULL, '2015-03-18 16:00:53', '2015-03-18 16:00:53'),
(59, '28e2ecddaaa132f6', 30, 1, '', '', '', '', '', '', '', '', '', '', '2.99', '6.78', 'pending', 'pending', 'paypal', '', 9, 2, NULL, '2015-04-03 10:25:20', '2015-04-03 10:25:20');

-- --------------------------------------------------------

--
-- Table structure for table `order_pack`
--

CREATE TABLE IF NOT EXISTS `order_pack` (
`id_order_pack` bigint(20) NOT NULL,
  `id_order` bigint(20) NOT NULL,
  `barcode` varchar(13) NOT NULL,
  `id_pack` bigint(20) NOT NULL,
  `name` tinytext NOT NULL,
  `quantity` int(11) NOT NULL,
  `total` decimal(15,4) NOT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `order_pack`
--

INSERT INTO `order_pack` (`id_order_pack`, `id_order`, `barcode`, `id_pack`, `name`, `quantity`, `total`) VALUES
(1, 44, '', 3, 'Gift set for Him', 1, '14.9900'),
(2, 51, '', 5, 'Luxury Wake-Up Kit', 1, '13.9900'),
(3, 54, '', 2, 'Dunker''s Delight', 1, '9.5900');

-- --------------------------------------------------------

--
-- Table structure for table `order_product`
--

CREATE TABLE IF NOT EXISTS `order_product` (
`id_order_product` bigint(20) NOT NULL,
  `id_order` bigint(20) NOT NULL,
  `barcode` varchar(13) NOT NULL,
  `id_product` bigint(20) NOT NULL,
  `name` tinytext NOT NULL,
  `quantity` int(11) NOT NULL,
  `total` decimal(15,4) NOT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=31 ;

--
-- Dumping data for table `order_product`
--

INSERT INTO `order_product` (`id_order_product`, `id_order`, `barcode`, `id_product`, `name`, `quantity`, `total`) VALUES
(1, 35, '', 1628, 'Raspberry Extra Jam', 2, '9.8000'),
(2, 35, '', 1630, 'Blackcurrant Extra Jam', 1, '4.9000'),
(3, 36, '', 1628, 'Raspberry Extra Jam', 1, '4.9000'),
(4, 37, '', 1628, 'Raspberry Extra Jam', 1, '4.9000'),
(5, 38, '', 1628, 'Raspberry Extra Jam', 1, '4.9000'),
(6, 39, '', 1649, 'Orange Marmalade with Whisky', 1, '4.9000'),
(7, 45, '', 1628, 'Raspberry Extra Jam', 2, '9.8000'),
(8, 46, '', 1629, 'Strawberry Extra Jam', 1, '4.9000'),
(9, 47, '', 1641, 'Morello Cherry Extra Jam with Port', 1, '3.9000'),
(10, 48, '', 1628, 'Raspberry Extra Jam', 1, '4.9000'),
(11, 49, '', 1635, 'Pear and Ginger Jam', 1, '3.9000'),
(12, 50, '', 1628, 'Raspberry Extra Jam', 1, '4.9000'),
(13, 52, '', 1628, 'Raspberry Extra Jam', 1, '4.9000'),
(14, 53, '', 1649, 'Orange Marmalade with Whisky', 1, '5.1000'),
(15, 53, '', 1648, 'Vintage Thick Cut Orange Marmalade', 1, '4.9000'),
(16, 53, '', 1640, 'Blackcurrant Jam with Sole Gin', 1, '4.1000'),
(17, 53, '', 1646, 'All Butter Lemon Curd', 1, '3.9000'),
(18, 53, '', 1631, 'Strawberry Jam with Marc de Champagne', 1, '5.1000'),
(19, 53, '', 1635, 'Pear and Ginger Jam', 1, '3.9000'),
(20, 54, '', 1643, 'Lemon Curd', 3, '14.7000'),
(21, 55, '', 1636, 'Fig Extra Jam', 1, '3.9000'),
(22, 56, '', 1647, 'Orange Marmalade with Ginger', 1, '4.9000'),
(23, 56, '', 1649, 'Orange Marmalade with Whisky', 1, '5.1000'),
(24, 56, '', 1650, 'Wild Moroccan Orange Marmalade', 3, '14.7000'),
(25, 57, '', 1642, 'Passionfruit Curd', 1, '4.9000'),
(26, 57, '', 1643, 'Lemon Curd', 2, '9.8000'),
(27, 58, '', 1628, 'Raspberry Extra Jam', 1, '4.9000'),
(29, 59, '', 1665, 'Luxurious hand-baked Butter Shortbread', 1, '3.7900');

-- --------------------------------------------------------

--
-- Table structure for table `pack`
--

CREATE TABLE IF NOT EXISTS `pack` (
`id_pack` bigint(20) NOT NULL,
  `id_category` bigint(20) NOT NULL,
  `price` decimal(11,2) DEFAULT NULL,
  `barcode` varchar(13) NOT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=9 ;

--
-- Dumping data for table `pack`
--

INSERT INTO `pack` (`id_pack`, `id_category`, `price`, `barcode`) VALUES
(2, 80, '9.59', ''),
(3, 80, '14.99', ''),
(4, 80, '14.59', ''),
(5, 80, '13.99', ''),
(6, 80, '13.99', ''),
(7, 80, '15.99', ''),
(8, 80, '39.59', '');

-- --------------------------------------------------------

--
-- Table structure for table `pack_photo`
--

CREATE TABLE IF NOT EXISTS `pack_photo` (
`id_photo` bigint(20) NOT NULL,
  `id_pack` bigint(20) NOT NULL,
  `order` int(11) DEFAULT NULL,
  `filename` varchar(255) NOT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=100 ;

--
-- Dumping data for table `pack_photo`
--

INSERT INTO `pack_photo` (`id_photo`, `id_pack`, `order`, `filename`) VALUES
(26, 4, 2, '26.jpg'),
(27, 4, 3, '27.jpg'),
(30, 3, 2, '30.jpg'),
(31, 3, 3, '31.jpg'),
(35, 6, 2, '35.jpg'),
(37, 5, 2, '37.jpg'),
(38, 7, 2, '38.jpg'),
(39, 7, 3, '39.jpg'),
(40, 7, 4, '40.jpg'),
(57, 7, 0, '57.jpg'),
(58, 6, 0, '58.jpg'),
(59, 2, 0, '59.jpg'),
(60, 3, 0, '60.jpg'),
(62, 4, 0, '62.jpg'),
(63, 5, 0, '63.jpg'),
(64, 8, 0, '64.jpg'),
(73, 4, 1, '73.jpg'),
(74, 3, 1, '74.jpg'),
(75, 2, 1, '75.jpg'),
(76, 6, 1, '76.jpg'),
(77, 7, 1, '77.jpg'),
(78, 5, 1, '78.jpg'),
(80, 8, 2, '80.jpg'),
(81, 8, 3, '81.jpg'),
(82, 8, 4, '82.jpg'),
(83, 8, 5, '83.jpg'),
(84, 8, 6, '84.jpg'),
(85, 8, 7, '85.jpg'),
(86, 8, 1, '86.jpg'),
(87, 2, 2, '87.jpg'),
(89, 2, 3, '89.jpg'),
(90, 3, 4, '90.jpg'),
(91, 4, 4, '91.jpg'),
(92, 5, 3, '92.jpg'),
(93, 5, 4, '93.jpg'),
(94, 6, 3, '94.jpg'),
(95, 6, 4, '95.jpg'),
(96, 8, 8, '96.jpg'),
(97, 8, 9, '97.jpg'),
(99, 8, 10, '99.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `pack_product`
--

CREATE TABLE IF NOT EXISTS `pack_product` (
  `id_pack` bigint(20) NOT NULL DEFAULT '0',
  `id_product` bigint(20) NOT NULL DEFAULT '0',
  `quantity` int(11) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `pack_product`
--

INSERT INTO `pack_product` (`id_pack`, `id_product`, `quantity`) VALUES
(2, 1663, 1),
(2, 1665, 1),
(3, 1629, 1),
(3, 1649, 1),
(3, 1663, 1),
(4, 1630, 1),
(4, 1631, 1),
(4, 1665, 1),
(5, 1648, 1),
(5, 1664, 1),
(5, 1665, 1),
(6, 1642, 1),
(6, 1663, 1),
(6, 1665, 1),
(7, 1628, 1),
(7, 1643, 1),
(7, 1650, 1),
(8, 1629, 1),
(8, 1641, 1),
(8, 1643, 1),
(8, 1645, 1),
(8, 1647, 1),
(8, 1652, 1),
(8, 1663, 1),
(8, 1664, 1),
(8, 1665, 1);

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

--
-- Dumping data for table `pack_text`
--

INSERT INTO `pack_text` (`id_pack`, `id_language`, `permalink`, `name`, `short_description`, `long_description`) VALUES
(2, 1, 'dunkers-delight', 'Dunker''s Delight', '', '<p>\n	Tea and biscuit box set:</p>\n<p>\n	Our Butter Shortbread is perfect for dunking, try it out with our Afternoon tea blend for a comforting pick-me-up at any time of the day.</p>\n<p>\n	Includes:</p>\n<ul>\n	<li>\n		A tube of Finest Quality Afternoon Tea (45 bags/ 125g)</li>\n	<li>\n		A tube of Delicious Hand-baked Traditional Butter Shortbread (150g)</li>\n</ul>\n'),
(3, 1, 'gift-set-for-him', 'Gift set for Him', '', '<p>\n	Stuck for a gift for Grandpa this Christmas?</p>\n<p>\n	Our Marmalade with a hint of whiskey matches perfectly with this strong tea blend for lovers of big flavours. We''ve tried the recipe out on the men in our family, so we can guarantee it''s suitable not only for Grandpa, but also husbands, sons, brothers and men of all shapes and sizes...</p>\n<p>\n	Includes:</p>\n<ul>\n	<li>\n		A jar of Strawberry Extra Jam (340g)</li>\n	<li>\n		A jar of Orange Marmalade with Whisky (340g)</li>\n	<li>\n		A tube of Finest Quality Afternoon Tea (45 bags/ 125g)</li>\n</ul>\n'),
(4, 1, 'gift-set-for-her', 'Gift set for Her', '', '<p>\n	Treat your mother this Christmas with our special gift set.</p>\n<p>\n	Our Strawberry with Marc de Champagne Jam and a box of Butter Shortbread is a sweet and luxurious surprise, waiting to be unwrapped on Christmas morning. For all those angels in your family with a taste for the finer things in life.</p>\n<p>\n	Includes:</p>\n<ul>\n	<li>\n		A Jar of Blackcurrant Extra Jam (340g)</li>\n	<li>\n		A Jar of Strawberry Jam with Marc de Champagne (340g)</li>\n	<li>\n		A tube of Delicious Hand-baked Traditional Butter Shortbread (150g)</li>\n</ul>\n'),
(5, 1, 'luxury-wake-up-kit', 'Luxury Wake-Up Kit', '', '<p>\n	Do you have trouble waking up in the morning?</p>\n<p>\n	Give yourself something to look forward to when the alarm clock sounds, with this gift set, offering a hearty breakfast cuppa and a tasty marmalde to start your day off the right way.</p>\n<p>\n	Includes:</p>\n<ul>\n	<li>\n		Vintage Thick Cut Orange Marmalade (340g)</li>\n	<li>\n		A tube of Finest Quality English Breakfast Tea (50 bags/ 125g)</li>\n	<li>\n		A tube of Delicious Hand-baked Traditional Butter Shortbread (150g)</li>\n</ul>\n'),
(6, 1, 'tea-party-in-a-box', 'Tea Party in a Box', '', '<p>\n	Throw yourself a tea party or surprise a friend with this gift set, containing all you need for a luxurious afternoon at your own table.</p>\n<p>\n	Includes:</p>\n<ul>\n	<li>\n		A jar of Passionfruit Curd (320g)</li>\n	<li>\n		A tube of Finest Quality Afternoon Tea (45 bags/ 125g)</li>\n	<li>\n		A tube of Delicious Hand-baked Traditional Butter Shortbread (150g)</li>\n</ul>\n'),
(7, 1, 'sweet-trio', 'Sweet Trio', '', '<p>\n	Can''t decide which jar to order? Why not check out our best sellers? Find out why so many customers came back for more...</p>\n<p>\n	Includes:</p>\n<ul>\n	<li>\n		A jar of Raspberry Extra Jam (340g)</li>\n	<li>\n		A jar of Lemon Curd (340g)</li>\n	<li>\n		A jar of Wild Moroccan Orange Marmalade (340g)</li>\n</ul>\n<p>\n	Limited edition!<br />\n	Each item comes dressed in elegant Christmas wrapping, ready to be put directly under the tree of your loved one.</p>\n'),
(8, 1, 'gourmet-set', 'Gourmet Set', '', '<p>\n	Lift the lid on our handmade goodies for a tasty surprise, every family member will find their own favourite in this collection.</p>\n<p>\n	Includes:</p>\n<ul>\n	<li>\n		A jar of Strawberry Extra Jam (340g)</li>\n	<li>\n		A jar of Morello Cherry Extra Jam with Port (340g)</li>\n	<li>\n		A jar of Lemon Curd (320g)</li>\n	<li>\n		A jar of Raspberry Curd (310g)</li>\n	<li>\n		A jar of Orange Marmalade with Ginger (340g)</li>\n	<li>\n		A jar of Three Fruit Marmalade (340g)</li>\n	<li>\n		A tube of Finest Quality Afternoon Tea (45 bags/ 125g)</li>\n	<li>\n		A tube of Finest Quality English Breakfast Tea (50 bags/ 125g)</li>\n	<li>\n		A tube of Delicious Hand-baked Traditional Butter Shortbread (150g)</li>\n</ul>\n');

-- --------------------------------------------------------

--
-- Table structure for table `page`
--

CREATE TABLE IF NOT EXISTS `page` (
`id_page` bigint(20) NOT NULL,
  `id_site` varchar(255) DEFAULT NULL,
  `permalink` varchar(255) DEFAULT NULL,
  `is_public` enum('y','n') NOT NULL DEFAULT 'y',
  `id_category` bigint(20) DEFAULT NULL,
  `last_update` date NOT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=39 ;

--
-- Dumping data for table `page`
--

INSERT INTO `page` (`id_page`, `id_site`, `permalink`, `is_public`, `id_category`, `last_update`) VALUES
(3, 'www', '', 'y', 2, '2014-12-01'),
(11, 'www', '_footer-en', 'n', 1, '2015-02-05'),
(14, 'www', 'about-us/', 'y', 2, '2015-01-17'),
(16, 'www', 'faq/', 'y', NULL, '2015-02-03'),
(17, 'www', '_featured', 'n', NULL, '2015-03-03'),
(18, 'www', 'terms-and-conditions/', 'y', 2, '2015-02-03'),
(19, 'www', 'contact-us/', 'y', NULL, '2014-11-12'),
(20, 'www', 'shipping-information/', 'y', 2, '2015-03-12'),
(21, 'www', 'premium-preserve/', 'y', NULL, '2015-01-03'),
(22, 'www', 'animated-mornings/', 'y', 2, '2015-03-16'),
(24, 'www', 'premium-jam/', 'y', 2, '2014-12-31'),
(25, 'www', 'premium-curd/', 'y', 2, '2014-12-31'),
(26, 'www', 'premium-marmalade/', 'y', 2, '2014-12-31'),
(27, 'www', 'jam/', 'y', NULL, '2015-01-28'),
(28, 'www', 'animated-mornings-with-jam/', 'y', 2, '2015-01-04'),
(29, 'www', 'animated-mornings-with-curd/', 'y', 2, '2015-01-04'),
(30, 'www', 'animated-mornings-with-marmalade/', 'y', 2, '2015-01-04'),
(31, 'www', 'good-cake-preserves/', 'y', 2, '2015-01-20'),
(32, 'www', 'marmalade/', 'y', 2, '2015-01-28'),
(33, 'www', 'curd/', 'y', 2, '2015-01-28'),
(34, 'www', 'perfect-dunking/', 'y', 2, '2015-01-17'),
(35, 'www', 'rules-of-the-competition/', 'y', 2, '2015-02-08'),
(36, 'www', 'our-partners/', 'y', 2, '2015-03-03'),
(37, 'www', 'gallery/', 'y', 2, '2015-02-19'),
(38, 'www', 'products/', 'y', 2, '2015-03-24');

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
(3, 1, NULL, 'Ennie''s Garden'),
(3, 2, NULL, '<div class="featured">\n	<p>\n		<img alt="" src="/content/files/page/images/marmelade-croissant.jpg" style="width: 100%;" /></p>\n</div>\n'),
(3, 3, NULL, 'delicious, hand-crafted, jam, marmalade, curd'),
(3, 4, NULL, 'A wide range of delicious, hand-crafted jams, marmalades and curds. Click here to check out all our goodies.'),
(3, 5, NULL, 'en'),
(3, 6, NULL, ''),
(11, 1, NULL, ''),
(11, 2, NULL, '<p>\n	Footer tartalma</p>\n'),
(11, 3, NULL, ''),
(11, 4, NULL, ''),
(11, 5, NULL, 'hu'),
(11, 6, NULL, ''),
(14, 1, NULL, 'About us'),
(14, 2, NULL, '<h1>\n	About us</h1>\n<h2>\n	The Beginning</h2>\n<p>\n	The story of Ennie’s Garden begins in a little cottage in the countryside in my childhood.<br />\n	Here I would gather apples and pears from the garden with my brother, or pick berries in their season. Grandma had a recipe for everything and she was always on the move in the kitchen.<br />\n	Here I learnt the secret of making jam.<br />\n	Grandma always told us: “Mother Nature is beautiful and kind. If you respect her, she will respect you. If you sacrifie your time, she will be grateful and share her riches with you.”</p>\n<h2>\n	This story still continues today...</h2>\n<p>\n	I shared these jams with my friends and neighbours, who gave me the confidence to become a full-time jam maker.</p>\n<p>\n	This is why I opened Ennie’s Garden with some friends in order to share these “secrets” with lovers of great tastes and culinary experiences everywhere.</p>\n<p>\n	Here you can find many traditional recipes from Grandmother’s cookbook as well exciting new flavours in the pages that we have added.</p>\n<p>\n	We are passionate about preserving the classic taste of the traditional recipes that you know and love, but we have also reinvented a number of jams and marmalades with a modern twist, we hope that you will like them.</p>\n<p>\n	Our long-term commitment is to earn the loyalty of our growing family of customers by never compromising on the quality of Ennie’s Garden products. Each individual jar is as precious to us as a special gift. We greatly appreciate your interest in our range and we welcome your comments and suggestions.</p>\n<p>\n	In addition, we are involved with the local community and charity movements. We are based in Leicester and can be found at weekends at Leicester Market. If you belong to a local Leicestershire charity and would like to work with us please don’t hesitate to get in touch.</p>\n<p class="p1">\n	Are you ready to a true gastronomic treat?<br />\n	Check out our <a href="http://www.enniesgarden.co.uk/jam/"><span class="s1">jams</span></a>, <a href="http://www.enniesgarden.co.uk/curd/"><span class="s1">curds</span></a>, <a href="http://www.enniesgarden.co.uk/marmalade/"><span class="s1">marmalades</span></a> &amp; <a href="http://www.enniesgarden.co.uk/perfect-dunking/"><span class="s1">dunking materials</span></a>.</p>\n<p>\n	For more information, stories or recipes follow us on <a href="https://www.facebook.com/enniesgarden" target="_blank">facebook</a> and&nbsp;<a href="http://www.google.com/+EnniesgardenCoUk" target="_blank">g+</a>.</p>\n<p>\n	<img alt="" src="/content/files/page/images/group-with-name-web%282%29.jpg" style="width: 600px;" /></p>\n'),
(14, 3, NULL, ''),
(14, 4, NULL, ''),
(14, 5, NULL, 'en'),
(14, 6, NULL, ''),
(16, 1, NULL, 'Frequently Asked Questions'),
(16, 2, NULL, '<h1>\n	Frequently Asked Questions</h1>\n<h2>\n	<u>Questions related to the payment and order</u></h2>\n<p>\n	&nbsp;</p>\n<h3>\n	What type of payment method can I use?</h3>\n<p>\n	You can pay with paypal secure payment.</p>\n<h3>\n	Are payments made through your site secure?</h3>\n<p>\n	Yes, they are. All transactions are taken via Charityclear, which is a worldwide online payment gateway. This also means that we do not hold or store any of your card details.</p>\n<h3>\n	How do I know that my order was successful?</h3>\n<p>\n	After completing every step of the checkout you will&nbsp; be notified via email. If you have any questions about your order please contact us.</p>\n<h3>\n	I have placed my order, what is the next step?</h3>\n<p>\n	The next step is ours. We will process your order and pass it on to the delivery service. You will be notified for every process of your order.<br />\n	All orders are processed the day they are placed, or on the first available working day.&nbsp;</p>\n<h3>\n	What can I do if I change my mind, or want to cancel an order?</h3>\n<p>\n	Contact us via email (ennie@enniesgarden.co.uk) as soon as possible. If your order is still in process we will cancel it and transfer back your money. If your order has already been dispatched, send it back as soon as it arrives and we will transfer back your money. In this case the shipping fee cannot be refunded.</p>\n<h2>\n	<u>Questions related to the guarantee</u></h2>\n<p>\n	&nbsp;</p>\n<h3>\n	100% Satisfaction Guarantee! WOW!</h3>\n<p>\n	Your satisfaction is our top priority. We guarantee the quality of our products and we want you to be completely satisfied with your purchases.<br />\n	If you are not completely satisfied with any of our products, please send it back within 30 days along with the invoice number and your account details so that we can refund the amount.<br />\n	For more information please contact us by email: ennie@enniesgarden.co.uk<br />\n	Thanks to our satisfaction guarantee, you can order our products with peace of mind, especially since all Ennie’s Garden products are made exclusively with natural ingredients and no artificial preservatives or dyes.</p>\n<h3>\n	Where should I send back unwanted products?</h3>\n<p>\n	Please send back any unwanted products to this address:<br />\n	Ennie’s Garden<br />\n	56 Grace road<br />\n	Leicester<br />\n	LE2 8AE</p>\n<h2>\n	<u>Questions related to delivery</u></h2>\n<p>\n	&nbsp;</p>\n<h3>\n	How much does delivery cost?</h3>\n<p>\n	Delivery costs £4.90<br />\n	We are currently working to lower shipping prices, as soon as we find a cheaper solution we will change them.</p>\n<h3>\n	Where do you ship?</h3>\n<p>\n	Primarily we ship in UK Mainland. If you have a special request please contact us by email and we will do our best to help you.</p>\n<h3>\n	How fast can I get my package?</h3>\n<p>\n	Your order should arrive in 1-2 business days.<br />\n	The parcel delivery service will contact you via text message the night before they attempt delivery.<br />\n	If I select a product that is eligible for free delivery, do I still have to pay for the delivery of other products that I buy at the same time?<br />\n	No. If you buy a product marked with free delivery you do not have to pay for the delivery of other products bought at the same time.</p>\n<h3>\n	What should I do if I have a problem with my order?</h3>\n<p>\n	In the event of an error with your order, please contact us immediately by email and we will be happy to assist you.</p>\n<h2>\n	<u>Questions related to the goodies</u></h2>\n<p>\n	&nbsp;</p>\n<h3>\n	Do your products contain any ingredients that can be harmful for allergies?</h3>\n<p>\n	Most of our products are made in premises where nuts, mustard, egg, milk, soya, celery fish, sulphites and gluten are also used. Please check individual item descriptions for specific ingredients.</p>\n<h3>\n	What can I eat your jam, marmalade or curd with?</h3>\n<p>\n	There are no limits to what you can do with our products. They are ideal for all kinds of desserts, muffins, pies or simply for toast, you can try them on top of yoghurt, ice cream, porridge or cottage cream. Please check individual item descriptions for specific serving recommendations.</p>\n<h3>\n	How much do your items weigh?</h3>\n<p>\n	All of our jars are between 310 and 340g net.</p>\n<h3>\n	How should I keep my jam, curd and marmalade?</h3>\n<p>\n	We always recommend storing jars in a cool environment before opening. After opening keep them in the fridge and consume within 4 weeks.</p>\n<h3>\n	What is the shelf life of your jam, marmalade and curd?</h3>\n<p>\n	The shelf life of jam and marmalade is 1 year after the production date,&nbsp; for curd it is 6 months. You can find the exact date on the lid of the jar.</p>\n<h3>\n	How often do you make new flavours?</h3>\n<p>\n	Part of the fun at the Ennie’s Garden is experimenting and creating new ideas! We will keep you updated through our Newsletter, Facebook &amp; Google+. So get following!<br />\n	If you have any ideas or recommendations, do not hesitate to let us know!</p>\n<p>\n	If you can’t find an answer to your question on this page, please do not hesitate to <a href="http://www.enniesgarden.co.uk/contact-us/">contact us</a>.</p>\n'),
(16, 3, NULL, ''),
(16, 4, NULL, ''),
(16, 5, NULL, 'en'),
(16, 6, NULL, ''),
(17, 1, NULL, ''),
(17, 2, NULL, '<p>\n	<img alt="" src="/content/files/page/images/featured-spring-web2.jpg" /></p>\n<div class="text">\n	<h1>\n		Tea Time Treat</h1>\n	<p>\n		Serve a traditional cup of tea with some smooth &amp; buttery biscuits and enjoy the first rays of the spring sun.</p>\n	<p>\n		<a href="http://www.enniesgarden.co.uk/perfect-dunking/">Give it a try!</a></p>\n</div>\n'),
(17, 3, NULL, ''),
(17, 4, NULL, ''),
(17, 5, NULL, ''),
(17, 6, NULL, ''),
(18, 1, NULL, 'Terms and Conditions'),
(18, 2, NULL, '<h1>\n	Terms and Conditions</h1>\n<p>\n	Please read these Terms &amp; Conditions carefully as they affect your rights and liabilities under the law and set out the terms under Ennie’s Garden.</p>\n<h2>\n	1. Descriptions, prices and product information</h2>\n<p>\n	We have taken care to describe and show items as accurately as possible. Despite this, slight variations in items may occur. Product information is provided on Enniesgarden.co.uk. If there is anything that you do not understand, or if you wish to obtain further information, please contact us at ennie@enniesgarden.co.uk.<br />\n	The price of an item does not include the delivery charge.</p>\n<h2>\n	2. Availability</h2>\n<p>\n	We always aim to ensure that the full product range is kept in stock. If an item is out of stock it will be removed from the Ennie’s Garden Site or be given a later delivery date. If for any other reason beyond our reasonable control we are unable to supply a particular item, we will not be liable to you except to ensure that you are not charged for that item.</p>\n<h2>\n	3. Bulk buy policy</h2>\n<p>\n	To ensure availability of all our products, customers may be limited to a maximum number of items.</p>\n<h2>\n	4. UK Delivery</h2>\n<p>\n	UK Delivery will be made to the address specified when you complete the order. Please note we only deliver to addresses within the UK.<br />\n	Our standard UK delivery is a 1-3 day service (excluding sundays and bank holidays). Deliveries to the Scottish Highlands and Islands, the Scilly Isles, the Isle of Man and Northern Ireland may take slightly longer. However, we will try to despatch your order from our warehouse on the same day you place it.<br />\n	For all UK deliveries we always aim to deliver our orders on time. Unfortunately there may be occasions where an unavoidable situation will mean this cannot happen and we will always endeavour to call you to let you know if there is a problem. Ownership of an item will not pass to you until we have delivered it, either directly or by leaving it in a safe place or with a neighbour - see below. Once an item is delivered, risk of damage to or loss of the item passes to you.<br />\n	The cost of standard UK delivery is £2.99. You pay only one delivery charge per order, regardless of the number of deliveries that may be necessary. All items are delivered to the address specified in the order between 7am and 8pm, Mondays to Saturdays only. Our couriers will attempt to deliver the package to you at your door, however, if you are out and want your parcel left in a specific location please use our delivery instructions on the checkout page. Our couriers will make every effort to ensure that your parcel is left in a safe and secure place and a card will be left indicating where the parcel can be found. If we were unable to deliver your order for any reason, please contact the number on the card to rearrange delivery.<br />\n	We will keep you informed of the progress of your order by e-mail.</p>\n<h2>\n	<a name="returns-and-refunds">5. Returns &amp; refunds</a></h2>\n<p>\n	If you are not completely satisfied with any of our products, please send it back within 30 days along with the invoice number and your account details so that we can refund the amount.<br />\n	Please note we do not currently provide a free delivery on returns policy. If you wish to return items to us you must pay for delivery.</p>\n<p>\n	If you want to cancel an order contact us via email (ennie@enniesgarden.co.uk) as soon as possible.<br />\n	If your order is still in process we will cancel it and transfer back your money.<br />\n	If your order has already been dispatched, send it back as soon as it arrives and we will transfer back your money. In this case the shipping fee cannot be refunded.</p>\n<h2>\n	6. Payments</h2>\n<p>\n	You can pay with the following cards via Paypal secure page:<br />\n	Visa / Delta / Electron<br />\n	MasterCard / Eurocard<br />\n	Maestro<br />\n	American Express.<br />\n	Debit cards (also known as bank cards) are accepted if they have a Visa or MasterCard logo.<br />\n	Your credit/debit card details will be encrypted by the Ennie’s Garden Site to minimise the possibility of unauthorised access or disclosure.<br />\n	Authority for payment must be given at the time of order. If there is a problem taking payment for all or part of your order we will contact you by email.</p>\n<h2>\n	7. Free gifts and promotional items; use of Gift Cards, vouchers and eCoupons</h2>\n<p>\n	Free gifts and promotional items that are given away in conjunction with a purchase may be despatched to you separately and delivery times may vary.<br />\n	If you change your mind and return your item under the returns policy in section above you must also return any free gift or promotional item associated with the promotion and received by you as a result of that order.</p>\n<h2>\n	8. Privacy</h2>\n<p>\n	This privacy policy sets out how Ennie’s Garden uses and protects any information that you give to Ennie’s Garden when you use this website.<br />\n	We are committed to ensuring that your privacy is protected. Should we ask you to provide certain information by which you can be identified when using this website, you can be assured that it will only be used in accordance with this privacy statement.<br />\n	We may change this policy from time to time by updating this page. You should check this page from time to time to ensure that you are happy with any changes. This policy is effective from 1st October 2014.<br />\n	What we collect<br />\n	We may collect the following information:<br />\n	Name<br />\n	Contact information including email address<br />\n	Demographic information such as postcode<br />\n	Other information relevant to customer surveys and/or offers<br />\n	What we do with the information we gather<br />\n	The only personal information about you we retain is the information that has been volunteered by you. We require this information to understand your needs and provide you with a better service, and in particular for the following reasons:<br />\n	Internal record keeping<br />\n	We may use the information to improve our products and services<br />\n	We may periodically send promotional email about new products, special offers or other information which we think you may find interesting using the email address which you have provided<br />\n	From time to time, we may also use your information to contact you for market research purposes<br />\n	We may contact you by email, phone or mail. We may use the information to customise the website according to your interests<br />\n	Controlling your personal information<br />\n	We will not sell, distribute or lease your personal information to third parties unless we have your permission or are required by law to do so. We may use your personal information to send you promotional information about third parties which we think you may find interesting if you tell us that you wish this to happen.<br />\n	You may request details of personal information which we hold about you under the Data Protection Act 1998. A small fee will be payable.<br />\n	If you would like a copy of the information held on you please contact us.<br />\n	If you believe that any information we are holding on you is incorrect or incomplete, please email us as soon as possible, at the above address. We will promptly correct any information found to be incorrect.<br />\n	Security<br />\n	We are committed to ensuring that your information is secure. In order to prevent unauthorised access or disclosure we have put in place suitable physical, electronic and managerial procedures to safeguard and secure the information we collect online.<br />\n	Payment: We use PayPal and Worldpay to provide a secure online payment service. Using these methods, we receive sufficient information to fulfil your order. We do not have access to your credit card information which is collected by PayPal. The privacy policy of this secure payment service is available on their website at www.paypal.co.uk.</p>\n<p>\n	Mailing lists: We use MailChimp for distributing our newsletter. When you subscribe, your email address, and optionally your name, is added to our mailing list database which is securely hosted by MailChimp. To remove your details from our mailing list; each newsletter sent includes an ‘Unsubscribe from newsletter’ link at the bottom of each newsletter. See the MailChimp Privacy Policy.<br />\n	How we use cookies<br />\n	A cookie is a small text file containing a string of characters that is sent to your browser from a web server and stored on your computer. A cookie does not give us access to your computer or any information about you, other than the data you choose to share with us.<br />\n	Kitchen Garden Foods has conducted an audit of the cookies used on our website. The cookies identified and their purpose are as follows:<br />\n	Google Analytics: We use Google Analytics to analyse traffic to our website and to gain an understanding of how the website is used. This provides information to help us to improve the website for our visitors and refine the marketing of our product range.<br />\n	Google Analytics collects information anonymously i.e. no personally identifiable information is collected. The cookies used by Analytics gather statistics such as the time of the visit, whether the visitor has been to the site before and which website and page referred the visitor to the web page. Google uses different cookies for each website and visitors are not tracked across multiple sites.<br />\n	The following cookies are set by Google Analytics:<br />\n	_utma, _utmb, _utmc, _utmz and on occasion _utmv and/or _utmx.<br />\n	For more information about Google Analytics visit the Google Analytics website.<br />\n	PayPal: PayPal provides the secure online shopping facilities for our website. When you click on an ''Add to Basket'' button, PayPal sets cookies in order to keep track of your shopping basket. These cookies are essential for the functioning of our on-line store. For details of how PayPal uses cookies please see the PayPal privacy policy on www.paypal.co.uk.<br />\n	Social Networking: To encourage interactive dialogue about our company and its products, throughout this website there are buttons which link to our pages on Facebook, Twitter and Linkedin. These sites may place cookies on your computer. Please refer to the following for their privacy policies: Facebook, Twitter.<br />\n	MailChimp: MailChimp may set cookies when subscribing to, or cancelling your subscription to our newsletter. For more information please see the MailChimp Privacy Policy.<br />\n	Declining Cookies<br />\n	You can choose to accept or decline cookies. Most web browsers automatically accept cookies, but you can usually modify your browser setting to decline cookies if you prefer. This may prevent you from taking full advantage of the website.</p>\n<h2>\n	8. Customer Services</h2>\n<p>\n	If you have any queries, please contact us.<br />\n	Email: ennie@enniesgarden.co.uk<br />\n	Skype: enniesgarden<br />\n	Last Updated: 16/10/14</p>\n'),
(18, 3, NULL, ''),
(18, 4, NULL, ''),
(18, 5, NULL, 'en'),
(18, 6, NULL, ''),
(19, 1, NULL, 'Contact Us | Ennie''s Garden'),
(19, 2, NULL, '<h1 style="text-align: center;">\n	Contact Us</h1>\n<p style="text-align: center;">\n	We are happy to answer any question you may have.<br />\n	Check out our easy-to-use contact form below or any of the other listed contact methods.</p>\n<h2 style="text-align: center;">\n	Meet us</h2>\n<p style="text-align: center;">\n	You can find us occasionally in Leicester Market, for more information follow us on social media or&nbsp; contact us any of the listed contact methods.<br />\n	Leicester Market, 11 Market Place, LE1 5HQ Leicester</p>\n'),
(19, 3, NULL, ''),
(19, 4, NULL, ''),
(19, 5, NULL, 'en'),
(19, 6, NULL, ''),
(20, 1, NULL, 'Shipping Information'),
(20, 2, NULL, '<h1>\n	Shipping Information</h1>\n<p>\n	Free delivery on all orders over £25.</p>\n<p>\n	Delivery Times:<br />\n	- Leicester: Next day&nbsp;(Include Weekends &amp; Public Holidays)<br />\n	- UK Mainland: 2-3 working days</p>\n<p>\n	All orders are processed the day they are placed, or on the first available working day.<br />\n	In most cases your order will arrive within a couple of days.<br />\n	Orders are shipped using MyHermes parcel delivery service.<br />\n	The parcel delivery service will contact you via text message the night before they attempt delivery.<br />\n	Shipping costs £2.99 on all orders under £25.<br />\n	We are currently working to lower shipping prices, as soon as we find a cheaper solution we will change them.</p>\n'),
(20, 3, NULL, ''),
(20, 4, NULL, 'We guarantee to ship your order as soon as possible. We are hard at work to ensure your order is expertly packed and promptly shipped.'),
(20, 5, NULL, 'en'),
(20, 6, NULL, ''),
(21, 1, NULL, ''),
(21, 2, NULL, '<h1>\n	Fed up with plastic food?<br />\n	Do you want to taste delicious real fruit preserve<span style="line-height: 1.5em;">?</span></h1>\n<div class="landing-text">\n	<p style="text-align: center;">\n		Forget <strong>chemicals</strong></p>\n	<p style="text-align: center;">\n		<img alt="" src="/content/files/page/images/bad-taste-industrial-jam.jpg" /></p>\n	<p style="text-align: center;">\n		...and choose delicious, healthy <strong>real fruit</strong></p>\n	<p style="text-align: center;">\n		<img alt="" src="/content/files/page/images/delicious-real-fruit-jam.jpg" /></p>\n	<p style="text-align: center;">\n		<strong>Get it right now!</strong></p>\n	<p style="text-align: center;">\n		Check our wide range of premium preserves and start eating really delicious sweets today.</p>\n</div>\n<h2 style="text-align: center;">\n	Jams</h2>\n<p>\n	[getcategory jam]</p>\n<h2 style="text-align: center;">\n	Marmalades</h2>\n<p>\n	[getcategory marmalade]</p>\n<h2 style="text-align: center;">\n	Curds</h2>\n<p>\n	[getcategory curd]</p>\n'),
(21, 3, NULL, 'real fruit preserves with no added preservatives, premium quality preserves, real fresh fruit preserves'),
(21, 4, NULL, 'Stop eating plastic food!\nMake your breakfast special with premium quality fruit preserves. '),
(21, 5, NULL, 'en'),
(21, 6, NULL, ''),
(22, 1, NULL, ''),
(22, 2, NULL, '<div class="landing-text">\n	<h1>\n		Are you bored with your breakfast?<br />\n		Jazz it up with preserves made from real fresh fruits!</h1>\n	<p>\n		<img alt="" src="/content/files/page/images/animated-mornings7.jpg" style="width: 100%;" /></p>\n	<p style="text-align: center;">\n		Make your mornings animated with delicious jams, curds and marmalades.&nbsp;</p>\n	<p style="text-align: center;">\n		Check out our wide range of <strong>premium quality</strong> preserves and <strong>get it right now!</strong></p>\n</div>\n<p style="text-align: center;">\n	Here is some ideas what to eat for breakfast</p>\n<p style="text-align: center;">\n	Do you have <strong>time to prepare</strong>?<br />\n	Try in Multigrain Breakfast Bar, Breakfast pie, French Toast, freshly baked Pancakes, Waffles or Doughnuts and put in your favourite Jam tart.&nbsp;</p>\n<p style="text-align: center;">\n	OR</p>\n<p style="text-align: center;">\n	Are you <strong>in a hurry</strong>?<br />\n	Put them on a slice of Bundt cake, Brioche and Fruit Loaf. Perfect with Waffle, Croissant, Scones, Doughnut, Crumplet, French Madeleines and Pancakes. Diversify your porridge, rice pudding, yogurt and cottage cheese cream.</p>\n<p style="text-align: center;">\n	Check out the individual product desriptions for further ideas.</p>\n<p style="text-align: center;">\n	<img alt="" src="/content/files/page/images/arrow-landingpage-one.jpg" style="width: 30px; height: 45px;" /><img alt="" src="/content/files/page/images/arrow-landingpage-one.jpg" style="width: 30px; height: 45px;" /></p>\n<h2 style="text-align: center;">\n	Jams</h2>\n<p>\n	[getcategory jam]</p>\n<h2 style="text-align: center;">\n	Marmalades</h2>\n<p>\n	[getcategory marmalade]</p>\n<h2 style="text-align: center;">\n	Curds</h2>\n<p>\n	[getcategory curd]</p>\n'),
(22, 3, NULL, 'fruit preserves\nboring breakfast\nbored with breakfast\nwhat to eat for breakfast\nbreakfast idea\nbreakfast ideas\neat morning\nmorning meal ideas\nbreakfast solution\nbreakfast plan'),
(22, 4, NULL, 'Jazz up your breakfast with premium quality fruit preserves. Breakfast ideas for sweet tooth.'),
(22, 5, NULL, 'en'),
(22, 6, NULL, ''),
(24, 1, NULL, ''),
(24, 2, NULL, '<h1>\n	Fed up with plastic food?<br />\n	Do you want to taste delicious real fruit jam<span style="line-height: 1.5em;">?</span></h1>\n<div class="landing-text">\n	<p style="text-align: center;">\n		Forget&nbsp;<strong>chemicals</strong></p>\n	<p style="text-align: center;">\n		<img alt="" src="/content/files/page/images/bad-taste-industrial-jam.jpg" /></p>\n	<p style="text-align: center;">\n		...and choose delicious, healthy&nbsp;<strong>real fruit</strong></p>\n	<p style="text-align: center;">\n		<img alt="" src="/content/files/page/images/delicious-real-fruit-jam.jpg" /></p>\n	<p style="text-align: center;">\n		Get it right now!</p>\n</div>\n<p>\n	[getcategory jam]</p>\n'),
(24, 3, NULL, 'real fruit jam with no added preservatives, premium quality jam, high fruit jam'),
(24, 4, NULL, 'Luxury fruit jams made from real fresh fruits. Forget the plastic food!'),
(24, 5, NULL, 'en'),
(24, 6, NULL, ''),
(25, 1, NULL, ''),
(25, 2, NULL, '<h1>\n	Fed up with plastic food?<br />\n	Do you want to taste delicious real fruit curd<span style="line-height: 1.5em;">?</span></h1>\n<div class="landing-text">\n	<p style="text-align: center;">\n		Forget&nbsp;<strong>chemicals</strong></p>\n	<p style="text-align: center;">\n		<img alt="" src="/content/files/page/images/bad-taste-industrial-jam.jpg" /></p>\n	<p style="text-align: center;">\n		...and choose delicious, healthy&nbsp;<strong>real fruit</strong></p>\n	<p style="text-align: center;">\n		<img alt="" src="/content/files/page/images/delicious-real-fruit-jam.jpg" /></p>\n	<p style="text-align: center;">\n		Get it right now!</p>\n</div>\n<p>\n	[getcategory curd]</p>\n'),
(25, 3, NULL, 'real fruit curd with no added preservatives, premium quality curd'),
(25, 4, NULL, 'Delicious curds made from the best quality ingredients.'),
(25, 5, NULL, 'en'),
(25, 6, NULL, ''),
(26, 1, NULL, ''),
(26, 2, NULL, '<h1>\n	Fed up with plastic food?<br />\n	Do you want to taste delicious real fruit marmalade<span style="line-height: 1.5em;">?</span></h1>\n<div class="landing-text">\n	<p style="text-align: center;">\n		Forget&nbsp;<strong>chemicals</strong></p>\n	<p style="text-align: center;">\n		<img alt="" src="/content/files/page/images/bad-taste-industrial-jam.jpg" /></p>\n	<p style="text-align: center;">\n		...and choose delicious, healthy&nbsp;<strong>real fruit</strong></p>\n	<p style="text-align: center;">\n		<img alt="" src="/content/files/page/images/delicious-real-fruit-jam.jpg" /></p>\n	<p style="text-align: center;">\n		Get it right now!</p>\n</div>\n<p>\n	[getcategory marmalade]</p>\n'),
(26, 3, NULL, 'real fruit marmalade with no added preservatives, premium quality marmalade, high fruit marmalade'),
(26, 4, NULL, 'We use only the best quality fresh fruits to our marmalades. '),
(26, 5, NULL, ''),
(26, 6, NULL, ''),
(27, 1, NULL, ''),
(27, 2, NULL, '<h1>\n	Jam</h1>\n<div class="category-text">\n	<p style="text-align: center;">\n		<span style="text-align: start;">We have carefully selected a range of&nbsp;</span><strong style="text-align: start;">"luxury" jams</strong><span style="text-align: start;">&nbsp;to satisfy everyone,&nbsp;from&nbsp;</span><strong style="text-align: start;">fans of traditional flavours</strong><span style="text-align: start;">&nbsp;to those looking for new and&nbsp;</span><strong style="text-align: start;">innovative recipes</strong><span style="text-align: start;">&nbsp;or&nbsp;</span><strong style="text-align: start;">unusual tastes</strong><span style="text-align: start;">. All our jams are made from the <strong>"</strong></span><strong style="text-align: start;">best quality fruit</strong><span style="text-align: start;"><strong>"</strong>, sourced from local farmyards whenever possible.</span></p>\n	<p style="text-align: center;">\n		If you want to wake up to more than just a simple jar of jam at your breakfast table, you’ve come to the right place.<br />\n		Open a jar today!</p>\n</div>\n<p>\n	[getcategory jam]</p>\n<div id="cke_pastebin" style="position: absolute; top: 103.783px; width: 1px; height: 1px; overflow: hidden; left: -1000px;">\n	&nbsp;</div>\n'),
(27, 3, NULL, 'premium jam, good quality jam, quality jam, healthy jam, luxury jam, traditional jam, jam, premium, healthy, luxury, quality, traditional, good, ennie''s garden, high fruit content, preservative free, made in England, British jam, British recipe jam'),
(27, 4, NULL, 'If you want to wake up to more than just a simple jar of jam at your breakfast table, you’ve come to the right place. Click here to discover all of them.'),
(27, 5, NULL, 'en'),
(27, 6, NULL, ''),
(28, 1, NULL, ''),
(28, 2, NULL, '<div class="landing-text">\n	<h1>\n		Are you bored with your breakfast?<br />\n		Jazz it up with jams made from real fresh fruits!</h1>\n	<p>\n		<img alt="" src="/content/files/page/images/animated-mornings7.jpg" style="width: 962px; height: 450px;" /></p>\n	<p style="text-align: center;">\n		Make your mornings animated with delicious jams.&nbsp;</p>\n	<p style="text-align: center;">\n		Check out our wide range of&nbsp;<strong>premium quality</strong>&nbsp;jams and&nbsp;<strong>get it right now!</strong></p>\n</div>\n<p style="text-align: center;">\n	Here is some ideas what to eat for breakfast</p>\n<p style="text-align: center;">\n	Do you have time to prepare?<br />\n	Put in multigrain breakfast bar, breakfast pie, muffin, &nbsp;doughnuts, jam tart, puff pastry filled with jam, eat with french toast, freshly baked pancakes, waffles and french madeleines</p>\n<p style="text-align: center;">\n	OR</p>\n<p style="text-align: center;">\n	Are you in a hurry?<br />\n	Put on the top of your porridge, yogurt, rice pudding &amp; cottage cheese cream, on a a slice of brioche, scones, eat with bundt cake, waffle, doughnuts, crumplet and croissant</p>\n<p style="text-align: center;">\n	Check out the individual product desriptions for further ideas.</p>\n<p style="text-align: center;">\n	<img alt="" src="/content/files/page/images/arrow-landingpage-one.jpg" style="width: 30px; height: 45px;" /><img alt="" src="/content/files/page/images/arrow-landingpage-one.jpg" style="width: 30px; height: 45px;" /></p>\n<p>\n	[getcategory jam]</p>\n'),
(28, 3, NULL, 'breakfast ideas\nsweet breakfast idea\nbreakfast idea with jam\nwhat to eat for breakfast\nmorning meal ideas\nbreakfast plan\nbreakfast solution\neat morning\nboring breakfast\nbored with breakfast '),
(28, 4, NULL, 'Shake up your wake up with delicious jams. Click here to discover the whole range.'),
(28, 5, NULL, 'en'),
(28, 6, NULL, ''),
(29, 1, NULL, ''),
(29, 2, NULL, '<div class="landing-text">\n	<h1>\n		Are you bored with your breakfast?<br />\n		Jazz it up with curds made from real fresh fruits!</h1>\n	<p>\n		<img alt="" src="/content/files/page/images/animated-mornings7.jpg" style="width: 962px; height: 450px;" /></p>\n	<p style="text-align: center;">\n		Make your mornings animated with delicious curds.&nbsp;</p>\n	<p style="text-align: center;">\n		Check out our&nbsp;<strong>premium quality</strong>&nbsp;curds and&nbsp;<strong>get them right now!</strong></p>\n</div>\n<p style="text-align: center;">\n	Here is some ideas what to eat for breakfast</p>\n<p style="text-align: center;">\n	Do you have time to prepare?<br />\n	Put in Brioche Crescent Rolls, Granola Tart with Greek Yogurt &amp; Curd, Sweet Rolls, Bread Ring, Cheese Cream Mousse, Polenta Cakes, Hand Pies, Braided Lemon Bread, Sweet Buns, Cupakes, and Tartelettes</p>\n<p style="text-align: center;">\n	OR</p>\n<p style="text-align: center;">\n	Are you in a hurry?<br />\n	Put on&nbsp;fruit loaf,&nbsp;cheesecake bagels,&nbsp;rice pudding,&nbsp;doughnuts, crumplet and cottage cheese cream</p>\n<p style="text-align: center;">\n	Check out the individual product desriptions for further ideas.</p>\n<p style="text-align: center;">\n	<img alt="" src="/content/files/page/images/arrow-landingpage-one.jpg" style="width: 30px; height: 45px;" /><img alt="" src="/content/files/page/images/arrow-landingpage-one.jpg" style="width: 30px; height: 45px;" /></p>\n<p>\n	[getcategory curd]</p>\n'),
(29, 3, NULL, 'breakfast ideas\nsweet breakfast idea\nbreakfast with curd\nwhat to eat for breakfast\nmorning meal ideas\nbreakfast plan\nbreakfast solution\neat morning\nboring breakfast\nbored with breakfast '),
(29, 4, NULL, 'We believe that the best curds should be velvety soft and bursting with flavour. Add some zing to your mornings with our exciting flavours like passion fruit and raspberry.'),
(29, 5, NULL, 'en'),
(29, 6, NULL, ''),
(30, 1, NULL, ''),
(30, 2, NULL, '<div class="landing-text">\n	<h1>\n		Are you bored with your breakfast?<br />\n		Jazz it up with marmalades made from real fresh fruits!</h1>\n	<p>\n		<img alt="" src="/content/files/page/images/animated-mornings7.jpg" style="width: 962px; height: 450px;" /></p>\n	<p style="text-align: center;">\n		Make your mornings animated with delicious marmalades.&nbsp;</p>\n	<p style="text-align: center;">\n		Check out our wide range of&nbsp;<strong>premium quality</strong>&nbsp;marmalades and&nbsp;<strong>get them right now!</strong></p>\n</div>\n<p style="text-align: center;">\n	Here is some ideas what to eat for breakfast wtih marmalade</p>\n<p style="text-align: center;">\n	Do you have time to prepare?<br />\n	Put on French Toast, freshly baked Pancakes and Waffles and Sponge Pudding. Try a Marmalade and Mustard glazed Ham or&nbsp;Eat with French Madeleines &nbsp;</p>\n<p style="text-align: center;">\n	OR</p>\n<p style="text-align: center;">\n	Are you in a hurry?<br />\n	Try on the top of a slice of Brioche,&nbsp;Fruit Loaf or Bundt Cake, eat with Scones, Doughnuts, Crumplet and Croissant. Irresistible on the top of Rice pudding as well.</p>\n<p style="text-align: center;">\n	Check out the individual product desriptions for further ideas.</p>\n<p style="text-align: center;">\n	<img alt="" src="/content/files/page/images/arrow-landingpage-one.jpg" style="width: 30px; height: 45px;" /><img alt="" src="/content/files/page/images/arrow-landingpage-one.jpg" style="width: 30px; height: 45px;" /></p>\n<p>\n	[getcategory marmalade]</p>\n'),
(30, 3, NULL, 'breakfast ideas\nbreakfast idea\nwhat to eat for breakfast\nmorning meal ideas\nbreakfast plan\nbreakfast solution\neat morning\nboring breakfast\nbored with breakfast '),
(30, 4, NULL, 'Ennie''s Garden marmalades makes your breakfast animated. Click for sweet breakfast ideas.\n'),
(30, 5, NULL, 'en'),
(30, 6, NULL, ''),
(31, 1, NULL, ''),
(31, 2, NULL, '<h1>\n	Do you want to bake cakes like a pro?<br />\n	<span style="line-height: 1.5em;">Use premium quality fruit preserves.</span></h1>\n<div class="landing-text">\n	<p style="text-align: center;">\n		<img alt="" src="/content/files/page/images/goodcake5.jpg" style="width: 1080px; height: 358px;" /></p>\n	<p style="text-align: center;">\n		Easy to use, not sticky, not wishy-washy, just perfect.<br />\n		Check our wide range of premium preserves and start eating really delicious sweets today.</p>\n	<p style="text-align: center;">\n		<strong>Get it right now!</strong></p>\n	<p style="text-align: center;">\n		<img alt="" src="/content/files/page/images/arrow-landingpage-one.jpg" style="width: 30px; height: 45px;" /><img alt="" src="/content/files/page/images/arrow-landingpage-one.jpg" style="width: 30px; height: 45px;" /></p>\n</div>\n<h2 style="text-align: center;">\n	Jams</h2>\n<p>\n	[getcategory jam]</p>\n<h2 style="text-align: center;">\n	Marmalades</h2>\n<p>\n	[getcategory marmalade]</p>\n<h2 style="text-align: center;">\n	Curds</h2>\n<p>\n	[getcategory curd]</p>\n'),
(31, 3, NULL, ''),
(31, 4, NULL, ''),
(31, 5, NULL, 'en'),
(31, 6, NULL, ''),
(32, 1, NULL, ''),
(32, 2, NULL, '<h1>\n	Marmalade</h1>\n<div class="category-text">\n	<p style="text-align: center;">\n		We have <strong>carefully chosen citrus fruits</strong> from around the world for our <strong>luxury Marmalade selection</strong>. There are <strong>no limits</strong> to what you can do with them, try with your usual <strong>breakfast</strong> or be creative at <strong>dinner times</strong>.</p>\n	<p style="text-align: center;">\n		Check out individual product description for more ideas and suggestion!</p>\n</div>\n<p>\n	[getcategory marmalade]</p>\n'),
(32, 3, NULL, 'premium marmalade, good quality marmalade, quality marmalade, healthy marmalade, luxury marmalade, traditional marmalade, marmalade, premium, healthy, luxury, quality, traditional, good, ennie''s garden, high fruit content, preservative free, made in England, British marmalade, British recipe marmalade'),
(32, 4, NULL, 'We have carefully chosen citrus fruits from around the world for our luxury Marmalade selection. Click now to discover all of them!\n'),
(32, 5, NULL, 'en'),
(32, 6, NULL, ''),
(33, 1, NULL, ''),
(33, 2, NULL, '<h1>\n	Curd</h1>\n<div class="category-text">\n	<p style="text-align: center;">\n		The best Curd should be <strong>velvety soft</strong> and <strong>bursting with flavour</strong>. We use <strong>selected fresh fruits</strong> and the <strong>best quality ingredients</strong> to guarantee <strong>premium quality</strong>.</p>\n	<p style="text-align: center;">\n		Ideal for all kinds of desserts, cupcakes, puddings, soufflés &amp; macarons. Add some zing to your life with exciting flavours.<br />\n		Open a jar today!</p>\n</div>\n<p>\n	[getcategory curd]</p>\n<div>\n	&nbsp;</div>\n'),
(33, 3, NULL, 'premium curd, good quality curd, quality curd, healthy curd, luxury curd, traditional curd, curd, premium, healthy, luxury, quality, traditional, good, ennie''s garden, preservative free, made in England, British curd, British recipe curd'),
(33, 4, NULL, 'We believe that the best Curd should be velvety soft and bursting with flavour. Add some zing to your mornings with exciting flavours. Open a jar today!'),
(33, 5, NULL, 'en'),
(33, 6, NULL, ''),
(34, 1, NULL, ''),
(34, 2, NULL, '<h1>\n	Perfect Dunking</h1>\n<p>\n	[getcategory perfect-dunking]</p>\n'),
(34, 3, NULL, ''),
(34, 4, NULL, ''),
(34, 5, NULL, 'en'),
(34, 6, NULL, ''),
(35, 1, NULL, ''),
(35, 2, NULL, '<h1>\n	General rules of the competition</h1>\n<div>\n	1. Anybody living in the United Kingdom can take part in the competition.&nbsp;</div>\n<div>\n	2. The competition closes 15 February 12:00pm.</div>\n<div>\n	3. The result of the competition will be announced on the Ennie''s Garden facebook page ...February.</div>\n<div>\n	4. We will choose the winner with the help of an online draw programme.</div>\n<div>\n	5. Promoter''s full name and business address:</div>\n<div>\n	6. Ennie''s Garden</div>\n<div>\n	&nbsp; &nbsp; 56 Grace road</div>\n<div>\n	&nbsp; &nbsp; Leicester</div>\n<div>\n	&nbsp; &nbsp; LE2 8AE</div>\n<div>\n	7. Your prize will be dispatched 16 February.</div>\n<div>\n	8. Please note that we are unable to deliver the prizes outside of England.</div>\n<div>\n	<div>\n		If you have any further questions related to the competition please do not hesitate to <a href="http://www.enniesgarden.co.uk/contact-us/">contact us</a>.</div>\n	<div>\n		Good luck!</div>\n	<div>\n		The Ennie''s Garden Team</div>\n</div>\n<div>\n	&nbsp;</div>\n<div style="text-align: center;">\n	If you can''t wait until the end of competition, <strong>buy a jar now</strong></div>\n<div style="text-align: center;">\n	<img alt="" src="/content/files/page/images/arrow-landingpage-one.jpg" style="width: 30px; height: 75px;" /><img alt="" src="/content/files/page/images/arrow-landingpage-one.jpg" style="width: 30px; height: 75px;" /><img alt="" src="/content/files/page/images/arrow-landingpage-one.jpg" style="width: 30px; height: 75px;" /></div>\n<div style="text-align: center;">\n	&nbsp;</div>\n<div>\n	[getcategory jam]</div>\n<div>\n	[getcategory perfect-dunking]</div>\n'),
(35, 3, NULL, ''),
(35, 4, NULL, ''),
(35, 5, NULL, 'en'),
(35, 6, NULL, ''),
(36, 1, NULL, ''),
(36, 2, NULL, '<h1>\n	Our partners</h1>\n<h2>\n	<img alt="four delicious Waltonbrook wines" src="/content/files/page/images/waltonbrook.jpg" style="width: 300px; height: 169px; float: right;" />If you are looking for a delicious bottle of wine with your dinner we recommend to try the Walton Brook wines.</h2>\n<p>\n	The vineyard was planted in 2008 on a sunny south-facing slope consisting of flint and limestone on a clay soil. Existing selections include Pinot Noir, Pinot Gris, Bacchus, Seyval, Solaris and Regent, with plans to increase plantings over the next few seasons. The vineyard currently has stock of 2 different types of dry white wine (Solaris and Bacchus)&nbsp; and a medium dry white (Seyval) for immediate purchase with two sparkling wines on the horizon for release in the Autumn after two years in bottle. Both the sparkling white and sparkling rose are made by the traditional ‘method champenoise’ and will be added to the online shopping facility when available. Visit the Walton Brook website to find out more at&nbsp;<a href="http://www.waltonbrook.com/" target="_blank"><span class="s1">www.waltonbrook.com</span></a></p>\n'),
(36, 3, NULL, ''),
(36, 4, NULL, ''),
(36, 5, NULL, 'en'),
(36, 6, NULL, ''),
(37, 1, NULL, ''),
(37, 2, NULL, '<h1>\n	Gallery</h1>\n<p>\n	[gallery]</p>\n'),
(37, 3, NULL, ''),
(37, 4, NULL, ''),
(37, 5, NULL, 'en'),
(37, 6, NULL, ''),
(38, 1, NULL, ''),
(38, 2, NULL, '<h1 style="text-align: center;">\n	Jam</h1>\n<p>\n	[getcategory jam]</p>\n<h1 style="text-align: center;">\n	Curd &amp; Marmalade</h1>\n<p>\n	[getcategory curd]</p>\n<p>\n	[getcategory marmalade]</p>\n'),
(38, 3, NULL, ''),
(38, 4, NULL, ''),
(38, 5, NULL, 'en'),
(38, 6, NULL, '');

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
  `name` varchar(255) DEFAULT NULL,
  `external_billing` enum('y','n') NOT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=6 ;

--
-- Dumping data for table `payment_method`
--

INSERT INTO `payment_method` (`id_payment_method`, `name`, `external_billing`) VALUES
(1, 'personal', 'n'),
(2, 'paypal', 'y'),
(3, 'cc', 'y'),
(4, 'cod', 'n'),
(5, 'wire_transfer', 'n');

-- --------------------------------------------------------

--
-- Table structure for table `paypal`
--

CREATE TABLE IF NOT EXISTS `paypal` (
`id_order` bigint(20) NOT NULL,
  `token` char(20) DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `payer_id` char(13) NOT NULL,
  `transaction_id` varchar(19) NOT NULL,
  `docheckout_sent` enum('y','n') NOT NULL DEFAULT 'n',
  `docheckout_successful` enum('y','n') NOT NULL DEFAULT 'n',
  `ipn_pending_notification` enum('y','n') NOT NULL DEFAULT 'n',
  `ipn_completed_notification` enum('y','n') NOT NULL DEFAULT 'n'
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=60 ;

--
-- Dumping data for table `paypal`
--

INSERT INTO `paypal` (`id_order`, `token`, `timestamp`, `payer_id`, `transaction_id`, `docheckout_sent`, `docheckout_successful`, `ipn_pending_notification`, `ipn_completed_notification`) VALUES
(15, 'EC-3AP91471B59772417', '2014-11-25 01:07:12', 'AGBDATLGSM93J', '', 'n', 'n', 'n', 'n'),
(16, 'EC-1ED62823SW774573A', '2014-11-25 01:24:23', 'AGBDATLGSM93J', '', 'n', 'n', 'n', 'n'),
(17, 'EC-0RE8291641718281Y', '2014-11-25 01:36:24', 'AGBDATLGSM93J', '', 'n', 'n', 'n', 'n'),
(18, 'EC-65J16620JL483925W', '2014-11-25 01:41:29', 'AGBDATLGSM93J', '', 'n', 'n', 'n', 'n'),
(19, 'EC-6V464912XB073000B', '2014-11-25 01:44:45', 'AGBDATLGSM93J', '', 'n', 'n', 'n', 'n'),
(20, 'EC-9FG24660SX704942L', '2014-11-25 01:51:02', 'AGBDATLGSM93J', '', 'n', 'n', 'n', 'n'),
(21, 'EC-8SH51235FK922900W', '2014-11-25 11:37:11', 'AGBDATLGSM93J', '', 'n', 'n', 'n', 'n'),
(22, 'EC-7DD40650RU719312K', '2014-11-25 11:43:27', '', '', 'n', 'n', 'n', 'n'),
(23, 'EC-84Y75346FP3858000', '2014-11-25 11:45:18', 'AGBDATLGSM93J', '', 'n', 'n', 'n', 'n'),
(24, 'EC-8YA48895SM381900C', '2014-11-25 11:47:11', 'AGBDATLGSM93J', '', 'n', 'n', 'n', 'n'),
(25, 'EC-7GD65009XS541700X', '2014-11-25 17:54:54', 'AGBDATLGSM93J', '', 'n', 'n', 'n', 'n'),
(26, 'EC-3MR18509X3961013K', '2014-11-25 18:07:55', 'AGBDATLGSM93J', '', 'n', 'n', 'n', 'n'),
(27, 'EC-8J323400972987739', '2014-11-25 19:08:55', 'AGBDATLGSM93J', '530502624W6130327', 'n', 'n', 'n', 'n'),
(28, 'EC-72468445T5003124F', '2014-11-25 19:15:11', 'AGBDATLGSM93J', '574746971H618721G', 'n', 'n', 'n', 'n'),
(29, 'EC-4F9039064F1721549', '2014-11-25 19:36:32', 'AGBDATLGSM93J', '7BF16452C1810840X', 'n', 'n', 'n', 'n'),
(30, 'EC-1P481244EE382873T', '2014-11-25 20:10:40', 'AGBDATLGSM93J', '6UM65366M52556614', 'n', 'n', 'n', 'n'),
(31, 'EC-05N77547292876006', '2014-11-25 20:12:12', 'AGBDATLGSM93J', '78X792419F492823S', 'n', 'n', 'n', 'n'),
(32, 'EC-4K8429889L138121B', '2014-11-25 20:21:52', 'AGBDATLGSM93J', '7M578462K2842761H', 'y', 'y', 'n', 'y'),
(33, 'EC-22548711V1679184M', '2014-11-25 21:28:01', 'AGBDATLGSM93J', '2CV2974594553752M', 'y', 'y', 'n', 'y'),
(34, 'EC-39G29981SL911881C', '2014-11-27 14:20:03', '', '', 'n', 'n', 'n', 'n'),
(35, 'EC-6DC85369EC241143V', '2014-11-27 14:31:34', 'UMF85Z888YYFQ', '77267414W6556980E', 'y', 'y', 'n', 'y'),
(36, 'EC-55K5977401129433C', '2014-11-27 14:45:03', 'UMF85Z888YYFQ', '2G581426TC091583P', 'y', 'y', 'n', 'y'),
(37, 'EC-8PK66978KC939233S', '2014-11-27 16:57:12', 'UMF85Z888YYFQ', '21U36886XH317894G', 'y', 'y', 'n', 'y'),
(38, 'EC-55T44504HG448472S', '2014-11-28 12:52:05', 'J3K9NLCF6VS2W', '49U17697RV931254K', 'y', 'y', 'n', 'n'),
(39, 'EC-66349720P0162162W', '2014-12-02 11:27:32', '', '', 'n', 'n', 'n', 'n'),
(40, 'EC-4G568048XR965964P', '2014-12-10 12:11:26', '', '', 'n', 'n', 'n', 'n'),
(41, 'EC-33162354JP588145A', '2014-12-10 12:27:17', 'J3K9NLCF6VS2W', '4LC62158RE792480X', 'y', 'y', 'n', 'y'),
(42, 'EC-09P835473E5206720', '2014-12-10 12:36:56', 'AGBDATLGSM93J', '22333248M0373273F', 'y', 'y', 'n', 'y'),
(43, 'EC-2VM98565P44867146', '2014-12-10 12:40:25', 'AGBDATLGSM93J', '647109776D808971T', 'y', 'y', 'n', 'y'),
(44, 'EC-7J466891RP7623059', '2014-12-10 18:42:18', 'J3K9NLCF6VS2W', '9DM32516PH858982V', 'y', 'y', 'n', 'y'),
(45, 'EC-0CM33811H19569800', '2014-12-11 20:26:45', '', '', 'n', 'n', 'n', 'n'),
(46, 'EC-4WX47857H5846421H', '2014-12-12 21:45:58', '', '', 'n', 'n', 'n', 'n'),
(47, 'EC-7R522122P0700854D', '2014-12-14 13:03:53', '', '', 'n', 'n', 'n', 'n'),
(48, 'EC-59P517770V7164936', '2015-01-07 13:23:44', 'AGBDATLGSM93J', '99T19983W7187780T', 'y', 'y', 'n', 'n'),
(49, 'EC-5MV38959120103302', '2015-01-09 23:47:48', 'AGBDATLGSM93J', '1BM97486TA4153026', 'y', 'y', 'n', 'n'),
(50, 'EC-2YL34433E6431430N', '2015-01-21 13:40:32', '', '', 'n', 'n', 'n', 'n'),
(51, 'EC-7CV87419V91793209', '2015-01-29 11:04:26', '', '', 'n', 'n', 'n', 'n'),
(52, 'EC-85097413XG928013A', '2015-02-08 23:41:26', '', '', 'n', 'n', 'n', 'n'),
(53, 'EC-9X558645JJ432992W', '2015-02-21 21:35:54', '5S2E5BSS34PQG', '6XX08778NR010851W', 'y', 'y', 'n', 'y'),
(54, 'EC-0KJ34906Y4994840S', '2015-03-01 13:49:21', '', '', 'n', 'n', 'n', 'n'),
(55, 'EC-6WN40932MV907170J', '2015-03-02 21:38:34', '', '', 'n', 'n', 'n', 'n'),
(56, 'EC-5LU73709H2202314T', '2015-03-07 17:41:52', 'AXMPG4MDDMYWA', '2HR96864D2684842M', 'y', 'y', 'n', 'y'),
(57, 'EC-95A39841N4350264T', '2015-03-12 16:17:36', '', '', 'n', 'n', 'n', 'n'),
(58, 'EC-1SY62026EK7049222', '2015-03-18 16:00:53', '', '', 'n', 'n', 'n', 'n'),
(59, 'EC-5F098337RL140752R', '2015-04-03 10:25:20', '', '', 'n', 'n', 'n', 'n');

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1666 ;

--
-- Dumping data for table `product`
--

INSERT INTO `product` (`id_product`, `id_category`, `price`, `is_featured`, `is_sale`, `barcode`, `quantity`, `id_supplier`, `product_code`, `is_active`) VALUES
(1628, 76, '4.90', 'n', 'n', '', NULL, 0, '', 'y'),
(1629, 76, '4.90', 'n', 'n', '', NULL, 0, '', 'y'),
(1630, 76, '4.90', 'n', 'n', '', NULL, 0, '', 'y'),
(1631, 76, '5.10', 'n', 'n', '', NULL, 0, '', 'y'),
(1632, 76, '3.90', 'n', 'n', '', NULL, 0, '', 'y'),
(1633, 76, '3.90', 'n', 'n', '', NULL, 0, '', 'y'),
(1634, 76, '3.90', 'n', 'n', '', NULL, 0, '', 'y'),
(1635, 76, '3.90', 'n', 'n', '', NULL, 0, '', 'y'),
(1636, 76, '3.90', 'n', 'n', '', NULL, 0, '', 'y'),
(1637, 76, '3.90', 'n', 'n', '', NULL, 0, '', 'y'),
(1638, 76, '3.90', 'n', 'n', '', NULL, 0, '', 'y'),
(1639, 76, '3.90', 'n', 'n', '', NULL, 0, '', 'y'),
(1640, 76, '4.10', 'n', 'n', '', NULL, 0, '', 'y'),
(1641, 76, '4.10', 'n', 'n', '', NULL, 0, '', 'y'),
(1642, 78, '4.90', 'n', 'n', '', NULL, 0, '', 'y'),
(1643, 78, '4.90', 'n', 'n', '', NULL, 0, '', 'y'),
(1644, 78, '3.90', 'n', 'n', '', NULL, 0, '', 'n'),
(1645, 78, '4.10', 'n', 'n', '', NULL, 0, '', 'y'),
(1646, 78, '3.90', 'n', 'n', '', NULL, 0, '', 'y'),
(1647, 77, '4.90', 'n', 'n', '', NULL, 0, '', 'y'),
(1648, 77, '4.90', 'n', 'n', '', NULL, 0, '', 'y'),
(1649, 77, '5.10', 'n', 'n', '', NULL, 0, '', 'y'),
(1650, 77, '4.90', 'n', 'n', '', NULL, 0, '', 'y'),
(1651, 77, '3.90', 'n', 'n', '605499120019', NULL, 0, '', 'y'),
(1652, 77, '3.90', 'n', 'n', '', NULL, 0, '', 'y'),
(1653, 77, '3.90', 'n', 'n', '', NULL, 0, '', 'y'),
(1654, 77, '3.90', 'n', 'n', '', NULL, 0, '', 'n'),
(1663, 81, '4.49', 'n', 'n', '', NULL, 0, '', 'y'),
(1664, 81, '4.49', 'n', 'n', '', NULL, 0, '', 'y'),
(1665, 81, '3.79', 'n', 'n', '', NULL, 0, '', 'y');

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1457 ;

--
-- Dumping data for table `product_photo`
--

INSERT INTO `product_photo` (`id_photo`, `id_product`, `order`, `filename`) VALUES
(1339, 1655, 0, '1339.jpg'),
(1340, 1656, 0, '1340.jpg'),
(1341, 1657, 0, '1341.jpg'),
(1342, 1658, 0, '1342.jpg'),
(1343, 1659, 0, '1343.jpg'),
(1344, 1660, 0, '1344.jpg'),
(1345, 1661, 0, '1345.jpg'),
(1346, 1662, 0, '1346.jpg'),
(1364, 1644, 0, '1364.jpg'),
(1368, 1654, 0, '1368.jpg'),
(1414, 1630, 0, '1414.jpg'),
(1415, 1629, 0, '1415.jpg'),
(1416, 1628, 0, '1416.jpg'),
(1417, 1631, 0, '1417.jpg'),
(1418, 1647, 0, '1418.jpg'),
(1419, 1648, 0, '1419.jpg'),
(1420, 1649, 0, '1420.jpg'),
(1421, 1650, 0, '1421.jpg'),
(1424, 1636, 0, '1424.jpg'),
(1425, 1632, 0, '1425.jpg'),
(1428, 1637, 0, '1428.jpg'),
(1429, 1633, 0, '1429.jpg'),
(1430, 1634, 0, '1430.jpg'),
(1432, 1639, 0, '1432.jpg'),
(1436, 1640, 0, '1436.jpg'),
(1438, 1638, 0, '1438.jpg'),
(1439, 1641, 0, '1439.jpg'),
(1441, 1635, 0, '1441.jpg'),
(1442, 1645, 0, '1442.jpg'),
(1443, 1646, 0, '1443.jpg'),
(1444, 1652, 0, '1444.jpg'),
(1445, 1653, 0, '1445.jpg'),
(1447, 1643, 0, '1447.jpg'),
(1448, 1642, 0, '1448.jpg'),
(1449, 1651, 0, '1449.jpg'),
(1452, 1664, 0, '1452.jpg'),
(1454, 1665, 0, '1454.jpg'),
(1456, 1663, 0, '1456.jpg');

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
(1628, 1, 'Raspberry Extra Jam', 'raspberry-jam', 'Looking for something a bit different to liven up your tea party? This Raspberry Jam is unbeatable on scones with a spoonful of cream. Give it a try today!', '<div class="advantages">\n	<p>\n		<img alt="" src="/content/files/page/images/perfect-cakes-2.jpg" style="width: 50px; height: 50px;" />Traditional recipe you know and love</p>\n	<p>\n		<img alt="" src="/content/files/page/images/fresh-fruit-2.jpg" style="width: 50px; height: 50px; vertical-align: middle;" />Made from real fresh fruit</p>\n	<p>\n		<img alt="" src="/content/files/page/images/no-preservatives-2.jpg" style="width: 50px; height: 50px; vertical-align: middle;" />No added preservatives</p>\n	<p>\n		<img alt="" src="/content/files/page/images/premium-quality-2.jpg" style="width: 50px; height: 50px; vertical-align: middle;" />Premium quality</p>\n	<p>\n		<img alt="" src="/content/files/page/images/high-fruit-3.jpg" style="width: 50px; height: 50px;" />High fruit content</p>\n</div>\n<p class="p1">\n	One of our best-selling products, you''ll fall in love with this sweet and slightly-tart flavour, after the first taste. &nbsp;<br />\n	Spread softly on your toast &amp; unbeatable on scones with a spoonful of cream. Perfect in cream horns, banbury cakes and Viennese whirls.</p>\n<p>\n	Ingredients:</p>\n<ul>\n	<li>\n		Sugar</li>\n	<li>\n		Raspberries</li>\n	<li>\n		Gelling Agent: Pectin</li>\n	<li>\n		Acidity Regulator: Citric Acid</li>\n</ul>\n<p>\n	Product Weight: 340g<br />\n	Prepared with 53g fruit per 100g<br />\n	Total sugar content 61g per 100g</p>\n<p>\n	<img alt="" src="/content/files/page/images/gold-2011-1-v1.jpg" style="width: 50px; height: 50px;" /></p>\n'),
(1629, 1, 'Strawberry Extra Jam', 'strawberry-jam', 'Strawberry Jam is the benchmark of all good jam-makers, that’s why we have put all of our experience and knowhow into this recipe. Open a jar today!', '<div class="advantages">\n	<p>\n		<img alt="" src="/content/files/page/images/perfect-cakes-2.jpg" style="width: 50px; height: 50px;" />Traditional recipe you know and love</p>\n	<p>\n		<img alt="" src="/content/files/page/images/fresh-fruit-2.jpg" style="width: 50px; height: 50px;" />Made from real fresh fruit</p>\n	<p>\n		<img alt="" src="/content/files/page/images/no-preservatives-2.jpg" style="width: 50px; height: 50px;" />No added preservatives</p>\n	<p>\n		<img alt="" src="/content/files/page/images/premium-quality-2.jpg" style="width: 50px; height: 50px;" />Premium quality</p>\n	<p>\n		<img alt="" src="/content/files/page/images/high-fruit-3.jpg" style="width: 50px; height: 50px;" />High fruit content</p>\n</div>\n<p class="p1">\n	We believe that all proud jam makers must prove themselves with the quality of their Strawberry Jam. For this reason we have put all of our experience and knowhow into the creation of this, our signature product. You are guaranteed a classic jam fit for a modern table.<br />\n	Try it on jam tart, shortbread tarts, jam roly poly, linzer cookie, breakfast pie and posset.<br />\n	Enjoy the taste of real fresh fruit in every bite.</p>\n<p>\n	Ingredients:</p>\n<ul>\n	<li>\n		Strawberries</li>\n	<li>\n		Sugar</li>\n	<li>\n		Gelling Agent: Pectin</li>\n	<li>\n		Acidity Regulator: Citric Acid</li>\n</ul>\n<p>\n	Product Weight: 340g<br />\n	Prepared with 57g fruit per 100g<br />\n	Total sugar content 60g per 100g</p>\n<p>\n	<img alt="" src="/content/files/page/images/gold-2011-1-v1.jpg" style="width: 50px; height: 50px;" /></p>\n'),
(1630, 1, 'Blackcurrant Extra Jam', 'blackcurrant-jam', 'We believe that Blackcurrant is truly the king of jams and we hope that you will agree with us. Click here to try it for yourself!', '<div class="advantages">\n	<p>\n		<img alt="" src="/content/files/page/images/perfect-cakes-2.jpg" style="width: 50px; height: 50px;" />Traditional recipe you know and love</p>\n	<p>\n		<img alt="" src="/content/files/page/images/fresh-fruit-2.jpg" style="width: 50px; height: 50px;" />Made from real fresh fruit</p>\n	<p>\n		<img alt="" src="/content/files/page/images/no-preservatives-2.jpg" style="width: 50px; height: 50px;" />No added preservatives</p>\n	<p>\n		<img alt="" src="/content/files/page/images/premium-quality-2.jpg" style="width: 50px; height: 50px;" />Premium quality</p>\n	<p>\n		<img alt="" src="/content/files/page/images/high-fruit-3.jpg" style="width: 50px; height: 50px;" />High fruit content</p>\n</div>\n<p class="p1">\n	We believe that Blackcurrant is truly the king of jams, and for this reason, we stole this recipe from Ennie''s grandma, so that you can enjoy it too. Shhh, please don''t tell her!<br />\n	Perfect with rice pudding, cheesecake or simply on top of your yogurt or cottage cheese cream.</p>\n<p>\n	Ingredients:</p>\n<ul>\n	<li>\n		Blackcurrants</li>\n	<li>\n		Sugar</li>\n	<li>\n		Gelling Agent: Pectin</li>\n</ul>\n<p>\n	Product Weight: 340g<br />\n	Prepared with 58g fruit per 100g<br />\n	Total sugar content 62g per 100g</p>\n<p>\n	<img alt="" src="/content/files/page/images/gold-2012-2-v1.jpg" style="width: 50px; height: 50px;" /></p>\n'),
(1631, 1, 'Strawberry Jam with Marc de Champagne', 'strawberry-jam-with-marc-de-champagne', 'The rich flavour of brandy turns this classic strawberry jam into a distinctly decadent treat. Try it in pancakes, victoria sponge or scones. Try it today!', '<div class="advantages">\n	<p>\n		<img alt="" src="/content/files/page/images/perfect-cakes-2.jpg" style="width: 50px; height: 50px;" />Special taste for special occasions</p>\n	<p>\n		<img alt="" src="/content/files/page/images/fresh-fruit-2.jpg" style="width: 50px; height: 50px;" />Made from real fresh fruit</p>\n	<p>\n		<img alt="" src="/content/files/page/images/no-preservatives-2.jpg" style="width: 50px; height: 50px;" />No added preservatives</p>\n	<p>\n		<img alt="" src="/content/files/page/images/premium-quality-2.jpg" style="width: 50px; height: 50px;" />Premium quality</p>\n</div>\n<p class="p1">\n	The rich flavour of brandy turns this classic strawberry jam into a distinctly decadent treat.<br />\n	The smell of your Victoria Sponge or Artic roll filled with this jam will make your family proud and your neighbours crazy.<br />\n	A perfect present for true gourmands.</p>\n<p>\n	Ingredients:</p>\n<ul>\n	<li>\n		Strawberries</li>\n	<li>\n		Sugar</li>\n	<li>\n		Marc de Champagne 60% ABV (2%)</li>\n	<li>\n		Gelling Agent: Pectin</li>\n	<li>\n		Acidity Regulator: Citric Acid</li>\n</ul>\n<p>\n	Product Weight: 340g<br />\n	Prepared with 56g fruit per 100g<br />\n	Total sugar content 60g per 100g</p>\n'),
(1632, 1, 'Rhubarb and Ginger Extra Jam', 'rhubarb-and-ginger-extra-jam', 'The comforting warmth of ginger is wrapped up with the strong, earthy tones of rhubarb in this special jam. Bring some cheer to the table. Open a jar today!', '<div class="advantages">\n	<p>\n		<img alt="" src="/content/files/page/images/perfect-cakes-2.jpg" style="width: 50px; height: 50px;" />Perfect flavour combination</p>\n	<p>\n		<img alt="" src="/content/files/page/images/fresh-fruit-2.jpg" style="width: 50px; height: 50px;" />Made from real fresh fruit</p>\n	<p>\n		<img alt="" src="/content/files/page/images/no-preservatives-2.jpg" style="width: 50px; height: 50px;" />No added preservatives</p>\n	<p>\n		<img alt="" src="/content/files/page/images/premium-quality-2.jpg" style="width: 50px; height: 50px;" />Premium quality</p>\n	<p>\n		<img alt="" src="/content/files/page/images/high-fruit-3.jpg" style="width: 50px; height: 50px;" />High fruit content</p>\n</div>\n<p>\n	A jam to keep you cosy on cold days, the comforting warmth of ginger wrapped up with the strong, earthy tones of rhubarb.<br />\n	Try it with meringue bar, on a slice of toothsome bundt cake or cranachan to bring some cheer to the darkening nights.</p>\n<p>\n	Ingredients:</p>\n<ul>\n	<li>\n		Sugar</li>\n	<li>\n		Rhubarb</li>\n	<li>\n		Stem Ginger (10%) [Ginger, Sugar]</li>\n	<li>\n		Lemon</li>\n	<li>\n		Acidity Regulator: Citric Acid</li>\n	<li>\n		Gelling Agent: Pectin</li>\n</ul>\n<p>\n	Product Weight: 340g<br />\n	Prepared with 40g fruit per 100g<br />\n	Total sugar content 60g per 100g</p>\n<p>\n	<img alt="" src="/content/files/page/images/tastewest-2011-silver-v1.jpg" style="width: 36px; height: 50px;" /></p>\n'),
(1633, 1, 'Finest Apricot Jam', 'finest-apricot-jam', 'It brings a picnic to your kitchen table. A perfect partner for muffins, pancakes and doughnuts. Destined to become a family favourite. Open a jar today!', '<div class="advantages">\n	<p>\n		<img alt="" src="/content/files/page/images/perfect-cakes-2.jpg" style="width: 50px; height: 50px;" />Traditional recipe you know and love</p>\n	<p>\n		<img alt="" src="/content/files/page/images/fresh-fruit-2.jpg" style="width: 50px; height: 50px;" />Made from real fresh fruit</p>\n	<p>\n		<img alt="" src="/content/files/page/images/no-preservatives-2.jpg" style="width: 50px; height: 50px;" />No added preservatives</p>\n	<p>\n		<img alt="" src="/content/files/page/images/premium-quality-2.jpg" style="width: 50px; height: 50px;" />Premium quality</p>\n</div>\n<p class="p1">\n	All the charm of an English summer''s day in the park, but don''t worry if it''s raining, our apricot jam is like a picnic at your kitchen table.<br />\n	A perfect partner for muffins, crepes, jammy doughnuts and fresh &amp; crispy artisanal bread.&nbsp;If you like to experiment with tastes, try it with your multigrain homemade breakfast bars.</p>\n<p>\n	Ingredients:</p>\n<ul>\n	<li>\n		Apricot Pulp</li>\n	<li>\n		Sugar</li>\n	<li>\n		Acidity Regulator: Citric Acid</li>\n	<li>\n		Gelling Agent: Pectin</li>\n</ul>\n<p>\n	Product Weight: 340g<br />\n	Prepared with 58g fruit per 100g<br />\n	Total sugar content 61g per 100g</p>\n<p>\n	<img alt="" src="/content/files/page/images/west-2010-bronze-v1.jpg" style="width: 29px; height: 50px;" /></p>\n'),
(1634, 1, 'Blackberry and Apple Jam', 'blackberry-and-apple-jam', 'We have combined two favourite fruits from our English country garden for a taste of a summer’s day. Bring a smile to your children’s sandwiches. Try it now!', '<div class="advantages">\n	<p>\n		<img alt="" src="/content/files/page/images/perfect-cakes-2.jpg" style="width: 50px; height: 50px;" />Perfect flavour combination</p>\n	<p>\n		<img alt="" src="/content/files/page/images/fresh-fruit-2.jpg" style="width: 50px; height: 50px;" />Made from real fresh fruit</p>\n	<p>\n		<img alt="" src="/content/files/page/images/no-preservatives-2.jpg" style="width: 50px; height: 50px;" />No added preservatives</p>\n	<p>\n		<img alt="" src="/content/files/page/images/premium-quality-2.jpg" style="width: 50px; height: 50px;" />Premium quality</p>\n</div>\n<p class="p1">\n	We have picked two favourite fruits from our English country garden to combine for this jam, offering a taste of a perfect summer''s day in every jar. Guaranteed to bring a smile to your children''s sandwiches.<br />\n	Try in homemade marshmallows, lebkuchen &amp; banbury cakes.</p>\n<p>\n	Ingredients:</p>\n<ul>\n	<li>\n		Sugar</li>\n	<li>\n		Blackberries</li>\n	<li>\n		Bramley Apples [Apples, Water]</li>\n	<li>\n		Acidity Regulator: Citric Acid</li>\n	<li>\n		Gelling Agent: Pectin</li>\n</ul>\n<p>\n	Product Weight: 340g<br />\n	Prepared with 36g Blackberries &amp; 16g Apples per 100g<br />\n	Total sugar content 60g per 100g</p>\n<p>\n	<img alt="" src="/content/files/page/images/wat-201-bronze-v1.jpg" style="width: 50px; height: 50px;" /></p>\n'),
(1635, 1, 'Pear and Ginger Jam', 'pear-and-ginger-jam', 'We love the way the warmth of ginger complements the coolness of ripe pear in this jam, and we''re sure that you will too. Open a jar today!', '<div class="advantages">\n	<p>\n		<img alt="" src="/content/files/page/images/perfect-cakes-2.jpg" style="width: 50px; height: 50px;" />Perfect flavour combination</p>\n	<p>\n		<img alt="" src="/content/files/page/images/fresh-fruit-2.jpg" style="width: 50px; height: 50px;" />Made from real fresh fruit</p>\n	<p>\n		<img alt="" src="/content/files/page/images/no-preservatives-2.jpg" style="width: 50px; height: 50px;" />No added preservatives</p>\n	<p>\n		<img alt="" src="/content/files/page/images/premium-quality-2.jpg" style="width: 50px; height: 50px;" />Premium quality</p>\n</div>\n<p class="p1">\n	Our chef has created something truly special with this jam.<span class="s1"> </span>You''ll love the way the warmth of ginger complements the coolness of pear.<br />\n	This is a jam that doesn''t spread smoothly, if you like your toast with a thick layer of preserve and juicy pieces of fruit, this is a perfect choice.<span class="s1">&nbsp;</span>Give it a try now!</p>\n<p>\n	Ingredients:</p>\n<ul>\n	<li>\n		Sugar</li>\n	<li>\n		Pear [Pear, Sugar, Water, Critic Acid]</li>\n	<li>\n		Lemon</li>\n	<li>\n		Stem Ginger (5%) [Ginger, Sugar]</li>\n	<li>\n		Gelling Agent: Pectin</li>\n	<li>\n		Acidity Regulator: Citric Acid</li>\n	<li>\n		Spices</li>\n</ul>\n<p>\n	Product Weight: 340g<br />\n	Prepared with 38g fruit per 100g<br />\n	Total sugar content 62g per 100g</p>\n<p>\n	<img alt="" src="/content/files/page/images/wat-201-bronze-v1.jpg" style="width: 50px; height: 50px;" /></p>\n'),
(1636, 1, 'Fig Extra Jam', 'fig-extra-jam', 'Our Fig Jam is so succulent you can feel all the goodness of the fruit melt in your mouth. Try it on toast, scones and cakes. Click here to try it for yourself!', '<div class="advantages">\n	<p>\n		<img alt="" src="/content/files/page/images/perfect-cakes-2.jpg" style="width: 50px; height: 50px;" />Special ingredient for specific dishes</p>\n	<p>\n		<img alt="" src="/content/files/page/images/fresh-fruit-2.jpg" style="width: 50px; height: 50px;" />Made from real fresh fruit</p>\n	<p>\n		<img alt="" src="/content/files/page/images/no-preservatives-2.jpg" style="width: 50px; height: 50px;" />No added preservatives</p>\n	<p>\n		<img alt="" src="/content/files/page/images/premium-quality-2.jpg" style="width: 50px; height: 50px;" />Premium quality</p>\n	<p>\n		<img alt="" src="/content/files/page/images/high-fruit-3.jpg" style="width: 50px; height: 50px;" />High fruit content</p>\n</div>\n<p class="p1">\n	Our Fig Jam is so succulent you can feel all the goodness of the fruit melt in your mouth.<span class="s1"> </span>Try it once with Herb-Roasted Pork or add to your Cornbread.<br />\n	Warning, if you try it straight from your teaspoon you won''t be able to stop until the jar is empty!</p>\n<p>\n	Ingredients:</p>\n<ul>\n	<li>\n		Fig</li>\n	<li>\n		Sugar</li>\n	<li>\n		Acidity Regulator: Citric Acid</li>\n	<li>\n		Lemon</li>\n	<li>\n		Gelling Agent: Pectin</li>\n</ul>\n<p>\n	Product Weight: 340g<br />\n	Prepared with 56g fruit per 100g<br />\n	Total sugar content 60g per 100g</p>\n'),
(1637, 1, 'Gooseberry and Elderflower Jam', 'gooseberry-and-elderflower-jam', 'This jam combines the sweet and sour essence of gooseberries with the elusive aroma of elderflower. Difficult to define but impossible to resist. Try it today!', '<div class="advantages">\n	<p>\n		<img alt="" src="/content/files/page/images/perfect-cakes-2.jpg" style="width: 50px; height: 50px;" />Special ingredients for specific dishes</p>\n	<p>\n		<img alt="" src="/content/files/page/images/fresh-fruit-2.jpg" style="width: 50px; height: 50px;" />Made from real fresh fruit</p>\n	<p>\n		<img alt="" src="/content/files/page/images/no-preservatives-2.jpg" style="width: 50px; height: 50px;" />No added preservatives</p>\n	<p>\n		<img alt="" src="/content/files/page/images/premium-quality-2.jpg" style="width: 50px; height: 50px;" />Premium quality</p>\n</div>\n<p class="p1">\n	This modern classic combines the unique sweet and sour essence of gooseberries with the elusive floral aroma of elderflower. A flavour that is difficult to define but impossible to resist.<br />\n	This is a jam that is easier to taste than to describe, the elusive flavours will change your idea of how jam should taste.<br />\n	Add it to your home-made ice cream, or fill your macaron with it.<br />\n	Be daring and try it in a rum-based cocktail.</p>\n<p>\n	Ingredients:</p>\n<ul>\n	<li>\n		Sugar</li>\n	<li>\n		Gooseberry</li>\n	<li>\n		Elderflower (0,5%)</li>\n	<li>\n		Gelling Agent: Pectin</li>\n	<li>\n		Demerara Sugar [Sugar Beet, Cane Molasses]</li>\n</ul>\n<p>\n	Product Weight: 340g<br />\n	Prepared with 51g fruit per 100g<br />\n	Total sugar content 62g per 100g</p>\n<p>\n	<img alt="" src="/content/files/page/images/gold-2011-2-v1.jpg" style="width: 50px; height: 50px;" /></p>\n'),
(1638, 1, 'Morello Cherry Extra Jam ', 'morello-cherry-extra-jam', 'Be knocked out by the beautiful dark colour of Morello Cherries. It tastes just as special as it looks, sweet and with a touch of richness. Open a jar today!', '<div class="advantages">\n	<p>\n		<img alt="" src="/content/files/page/images/perfect-cakes-2.jpg" style="width: 50px; height: 50px;" />Traditional recipe you know and love</p>\n	<p>\n		<img alt="" src="/content/files/page/images/fresh-fruit-2.jpg" style="width: 50px; height: 50px;" />Made from real fresh fruit</p>\n	<p>\n		<img alt="" src="/content/files/page/images/no-preservatives-2.jpg" style="width: 50px; height: 50px;" />No added preservatives</p>\n	<p>\n		<img alt="" src="/content/files/page/images/premium-quality-2.jpg" style="width: 50px; height: 50px;" />Premium quality</p>\n	<p>\n		<img alt="" src="/content/files/page/images/high-fruit-3.jpg" style="width: 50px; height: 50px;" />High fruit content</p>\n</div>\n<p class="p1">\n	Take the lid off this jar and be knocked out by the beautiful dark red colour of our Morello Cherries. The jam tastes just as special as it looks, sweet and yet with an alluring touch of sourness.<br />\n	Almond, pistachio and dark chocolate really bring out the taste of this jam. &nbsp;<br />\n	We recommend this jam as a filling for your crepe with dark chocolate sauce, with almond biscotti for snack, in muesli on weekdays or poured on <span class="s1">roast duck as cherry sauce for a festive occasion.</span></p>\n<p>\n	Ingredients:</p>\n<ul>\n	<li>\n		Sugar</li>\n	<li>\n		Morello Cherries</li>\n	<li>\n		Gelling Agent: Pectin</li>\n	<li>\n		Acidity Regulator: Critic Acid</li>\n</ul>\n<p>\n	Product Weight: 340g<br />\n	Prepared with 55g fruit per 100g<br />\n	Total sugar content: 60g per 100g</p>\n<p>\n	<img alt="" src="/content/files/page/images/wat-201-bronze-v1.jpg" style="width: 50px; height: 50px;" /></p>\n'),
(1639, 1, 'Blueberry Jam', 'blueberry-jam', 'A jam that looks as good as it tastes, with a deep blue body and a bold flavour to match. Try it in cheesecake or muffins. Click here for more details.', '<div class="advantages">\n	<p>\n		<img alt="" src="/content/files/page/images/perfect-cakes-2.jpg" style="width: 50px; height: 50px;" />Traditional recipe you know and love</p>\n	<p>\n		<img alt="" src="/content/files/page/images/fresh-fruit-2.jpg" style="width: 50px; height: 50px;" />Made from real fresh fruit</p>\n	<p>\n		<img alt="" src="/content/files/page/images/no-preservatives-2.jpg" style="width: 50px; height: 50px;" />No added preservatives</p>\n	<p>\n		<img alt="" src="/content/files/page/images/premium-quality-2.jpg" style="width: 50px; height: 50px;" />Premium quality</p>\n</div>\n<p class="p1">\n	A jam that looks as good as it tastes, with a deep blue body and a bold flavour to match. Try it in cheesecake, eccles cake or italian crostata, alongside a freshly-made cappuccino to surprise your friends.<br />\n	On hot summer days refresh yourself with blueberry crushed ice.</p>\n<p>\n	Ingredients:</p>\n<ul>\n	<li>\n		Sugar</li>\n	<li>\n		Blueberries</li>\n	<li>\n		Gelling Agent: Pectin</li>\n	<li>\n		Acidity Regulator: Citric Acid</li>\n	<li>\n		Lemon</li>\n</ul>\n<p>\n	Product Weight: 340g<br />\n	Prepared with 53g fruit per 100g<br />\n	Total sugar content 61g per 100g</p>\n'),
(1640, 1, 'Blackcurrant Jam with Sloe Gin', 'blackcurrant-jam-with-sloe-gin', 'We took one of Grandma''s favourite recipes and gave it a modern twist. A truly unforgettable flavour, perfect with a dollop of cream on your scone. Try it now!', '<div class="advantages">\n	<p>\n		<img alt="" src="/content/files/page/images/perfect-cakes-2.jpg" style="width: 50px; height: 50px;" />Special taste for special occasions</p>\n	<p>\n		<img alt="" src="/content/files/page/images/fresh-fruit-2.jpg" style="width: 50px; height: 50px;" />Made from real fresh fruit</p>\n	<p>\n		<img alt="" src="/content/files/page/images/no-preservatives-2.jpg" style="width: 50px; height: 50px;" />No added preservatives</p>\n	<p>\n		<img alt="" src="/content/files/page/images/premium-quality-2.jpg" style="width: 50px; height: 50px;" />Premium quality</p>\n</div>\n<p class="p1">\n	We took one of Grandma''s favourite recipes and gave it a modern twist. Now the warmth of Sloe Gin enriches the natural sweetness of English blackcurrants, for a flavour both satisfying and exciting. A truly unforgettable flavour, perfect in cakes or with a dollop of cream on your scone.<br />\n	Dislocate yourself from boring weekdays, put on the top of a slice crispy bread and grilled brie. Strange &amp; delicious.</p>\n<p>\n	Ingredients:</p>\n<ul>\n	<li>\n		Sugar</li>\n	<li>\n		Blackcurrants</li>\n	<li>\n		Sloe Gin 25% ABV (3%) [Sloe Infusion, Water, Sugar, Gin Distillate]</li>\n	<li>\n		Gelling Agent: Pectin</li>\n</ul>\n<p>\n	Product Weight: 340g<br />\n	Prepared with 52g fruit per 100g<br />\n	Total sugar content 62g per 100g</p>\n<p>\n	<img alt="" src="/content/files/page/images/tastewest-2012-silver-v1.jpg" style="width: 50px; height: 50px;" /></p>\n'),
(1641, 1, 'Morello Cherry Extra Jam with Port', 'morello-cherry-extra-jam-with-port', 'A drop of port turns your morning breakfast table into a gourmet experience. Perfect on porridge, crispy scones or simply for toast. Get it now!', '<div class="advantages">\n	<p>\n		<img alt="" src="/content/files/page/images/perfect-cakes-2.jpg" style="width: 50px; height: 50px;" />Special taste for special occasions</p>\n	<p>\n		<img alt="" src="/content/files/page/images/fresh-fruit-2.jpg" style="width: 50px; height: 50px;" />Made from real fresh fruit</p>\n	<p>\n		<img alt="" src="/content/files/page/images/no-preservatives-2.jpg" style="width: 50px; height: 50px;" />No added preservatives</p>\n	<p>\n		<img alt="" src="/content/files/page/images/premium-quality-2.jpg" style="width: 50px; height: 50px;" />Premium quality</p>\n	<p>\n		<img alt="" src="/content/files/page/images/high-fruit-3.jpg" style="width: 50px; height: 50px;" />High fruit content</p>\n</div>\n<p class="p1">\n	A drop of port turns your dining<span class="s1"> </span>table into a gourmet experience. All the flavour and goodness that you would expect from our Cherry Jam, brought out with a hint of port from Grandma''s cupboard.<br />\n	On weekdays put on the top of a slice of brioche and use at special occasions in truffles, &nbsp;chocolate mousses, Black Forest Pavlova, cherry &amp; almond sundaes. All of your guest will praise you.</p>\n<p>\n	Ingredients:</p>\n<ul>\n	<li>\n		Morello Cherries</li>\n	<li>\n		Sugar</li>\n	<li>\n		Port 19.5%, ABV (3%) [Port, Sulphur dioxide]</li>\n	<li>\n		Gelling Agent: Pectin</li>\n	<li>\n		Acidity Regulator: Citric Acid</li>\n</ul>\n<p>\n	Product Weight: 340g<br />\n	Prepared with 55g fruit per 100g<br />\n	Total sugar content 62g per 100g</p>\n<p>\n	<img alt="" src="/content/files/page/images/gold-2011-2-v1.jpg" style="width: 50px; height: 50px;" /><img alt="" src="/content/files/page/images/tastewest-2012-silver-v1.jpg" style="width: 50px; height: 50px;" /></p>\n'),
(1642, 1, 'Passionfruit Curd', 'passionfruit-curd', 'The exotic flavour of passion fruit breathes new life into your kitchen, perfect with pancakes, muffins or just toast. Click here to find out more!', '<div class="advantages">\n	<p>\n		<img alt="" src="/content/files/page/images/perfect-cakes-2.jpg" style="width: 50px; height: 50px;" />Something different to brighten your day</p>\n	<p>\n		<img alt="" src="/content/files/page/images/fresh-fruit-2.jpg" style="width: 50px; height: 50px;" />Made from real fresh fruit</p>\n	<p>\n		<img alt="" src="/content/files/page/images/no-preservatives-2.jpg" style="width: 50px; height: 50px;" />No added preservatives</p>\n	<p>\n		<img alt="" src="/content/files/page/images/premium-quality-2.jpg" style="width: 50px; height: 50px;" />Premium quality</p>\n</div>\n<p class="p1">\n	The exotic flavour of passion fruit breathes new life into your kitchen, perfect in panna cotta, angel food cake, sponge drops, verrine and on spicy caramelized peaches.<span class="s1"> </span>Invite your friends round to try it but make sure there''s plenty for everybody.</p>\n<p>\n	Ingredients:</p>\n<ul>\n	<li>\n		Sugar</li>\n	<li>\n		<strong>Egg</strong></li>\n	<li>\n		Unsalted Butter [<strong>Milk</strong>]</li>\n	<li>\n		Passion Fruit Juice Concentrate (14%)</li>\n	<li>\n		Acidity Regulator: Citric&nbsp;Acid</li>\n	<li>\n		Gelling Agent: Pectin</li>\n</ul>\n<p>\n	Allergy advice: For allergens,&nbsp;see ingredients in <strong>bold</strong><br />\n	Product Weight:&nbsp;320g</p>\n<p>\n	<img alt="" src="/content/files/page/images/gold-2012-3-v1.jpg" style="width: 50px; height: 50px;" /></p>\n'),
(1643, 1, 'Lemon Curd', 'lemon-curd', 'Taste the sunlight over the lemon groves in this special curd, it brings a splash of brightness to your morning routine. Click here to try it for yourself!', '<div class="advantages">\n	<p>\n		<img alt="" src="/content/files/page/images/perfect-cakes-2.jpg" style="width: 50px; height: 50px;" />Traditional recipe you know and love</p>\n	<p>\n		<img alt="" src="/content/files/page/images/fresh-fruit-2.jpg" style="width: 50px; height: 50px;" />Made from real fresh fruit</p>\n	<p>\n		<img alt="" src="/content/files/page/images/no-preservatives-2.jpg" style="width: 50px; height: 50px;" />No added preservatives</p>\n	<p>\n		<img alt="" src="/content/files/page/images/premium-quality-2.jpg" style="width: 50px; height: 50px;" />Premium quality</p>\n</div>\n<p class="p1">\n	Our lemons are grown on hillsides in full sunlight, to bring a splash of brightness to your morning routine.<br />\n	Try it on toast, muffins or as a filling inside your favourite cake, in delicious lime pudding, polenta cakes and cupcakes.</p>\n<p>\n	Ingredients:</p>\n<ul>\n	<li>\n		Sugar</li>\n	<li>\n		Egg</li>\n	<li>\n		Unsalted Butter [Milk]</li>\n	<li>\n		Lemon (13%)</li>\n	<li>\n		Acidity Regulator: Citric Acid</li>\n	<li>\n		Gelling Agent: Pectin</li>\n</ul>\n<p>\n	Allergy advice: For allergens, see ingredients in bold<br />\n	Product Weight: 320g</p>\n<p>\n	<img alt="" src="/content/files/page/images/gold-2012-2-v1.jpg" style="width: 50px; height: 50px;" /></p>\n'),
(1644, 1, 'Very Ginger Curd', 'very-ginger-curd', 'For those who like exciting flavours, our Very Ginger Curd is bursting with warmth and zing. Guaranteed to lighten up the greyest days. Open a jar today!', '<p>\n	For those who like exciting flavours, our Very Ginger Curd is bursting with warmth and zing. Try it on toast or add a kick to any dish with just a spoonful. Guaranteed to lighten up the greyest days.</p>\n'),
(1645, 1, 'Raspberry Curd', 'raspberry-curd', 'For raspberry lovers, we have sealed all that irresistible red berry flavour into a smooth curd experience in this jar. Perfect with scones. Open a jar today!', '<div class="advantages">\n	<p>\n		<img alt="" src="/content/files/page/images/perfect-cakes-2.jpg" style="width: 50px; height: 50px;" />Something different to brighten your day</p>\n	<p>\n		<img alt="" src="/content/files/page/images/fresh-fruit-2.jpg" style="width: 50px; height: 50px;" />Made from real fresh fruit</p>\n	<p>\n		<img alt="" src="/content/files/page/images/no-preservatives-2.jpg" style="width: 50px; height: 50px;" />No added preservatives</p>\n	<p>\n		<img alt="" src="/content/files/page/images/premium-quality-2.jpg" style="width: 50px; height: 50px;" />Premium quality</p>\n</div>\n<p class="p1">\n	A heavenly-fragranced curd that spreads softly on your toast and goes perfectly with muffins, in lemon curd sponge cake, <span class="s1">profiteroles, macarons and poppyseed cake</span>.<br />\n	You have come to the right place if you are looking for a treat every morning. You are guaranteed to not get bored with it.</p>\n<p class="p1">\n	Ingredients:</p>\n<ul>\n	<li>\n		Sugar</li>\n	<li>\n		<strong>Egg</strong></li>\n	<li>\n		Unsalted Butter [<strong>Milk</strong>]</li>\n	<li>\n		Raspberry Concentrate</li>\n	<li>\n		Acidity Regulator: Citric Acid</li>\n	<li>\n		Gelling Agent: Pectin</li>\n</ul>\n<p>\n	Allergy advice: For allergens, see ingredients in <strong>bold</strong>.<br />\n	Product Weight: 310g</p>\n'),
(1646, 1, 'All Butter Lemon Curd', 'all-butter-lemon-curd', 'A perfect accompaniment to your afternoon cup of tea. Try our All Butter Lemon Curd with biscuits or freshly-baked scones. Click here to try it for yourself!', '<div class="advantages">\n	<p>\n		<img alt="" src="/content/files/page/images/perfect-cakes-2.jpg" style="width: 50px; height: 50px;" />Traditional recipe you know and love</p>\n	<p>\n		<img alt="" src="/content/files/page/images/fresh-fruit-2.jpg" style="width: 50px; height: 50px;" />Made from real fresh fruit</p>\n	<p>\n		<img alt="" src="/content/files/page/images/no-preservatives-2.jpg" style="width: 50px; height: 50px;" />No added preservatives</p>\n	<p>\n		<img alt="" src="/content/files/page/images/premium-quality-2.jpg" style="width: 50px; height: 50px;" />Premium quality</p>\n</div>\n<p>\n	A perfect accompaniment to your afternoon cup of tea.<br />\n	Try our All Butter Lemon Curd with biscuits or freshly-baked scones, luscious lemon squares and meringues<span class="s1">&nbsp;</span>to really savour all the freshness and smoothness in every jar.</p>\n<p>\n	Ingredients:</p>\n<ul>\n	<li>\n		Sugar</li>\n	<li>\n		Unsalted Butter (21%) [<strong>Milk</strong>]</li>\n	<li>\n		<strong>Egg</strong></li>\n	<li>\n		Lemon (13%)</li>\n	<li>\n		Acidity Regulator: Citric Acid</li>\n	<li>\n		Gelling Agent: Pectin</li>\n</ul>\n<p>\n	Allergy advice: For allergens, see ingredients in <strong>bold</strong><br />\n	Product Weight: 320g</p>\n<p>\n	<img alt="" src="/content/files/page/images/wat-201-bronze-v1.jpg" style="width: 50px; height: 50px;" /></p>\n'),
(1647, 1, 'Orange Marmalade with Ginger', 'orange-marmalade-with-ginger', 'A breakfast treat. Liven up your mornings with a burst of citrus flavour and the warm spice of Ginger on your toast. Click here to try it for yourself!', '<div class="advantages">\n	<p>\n		<img alt="" src="/content/files/page/images/perfect-cakes-2.jpg" style="width: 50px; height: 50px;" />Something different to brighten your day</p>\n	<p>\n		<img alt="" src="/content/files/page/images/fresh-fruit-2.jpg" style="width: 50px; height: 50px;" />Made from real fresh fruit</p>\n	<p>\n		<img alt="" src="/content/files/page/images/no-preservatives-2.jpg" style="width: 50px; height: 50px;" />No added preservatives</p>\n	<p>\n		<img alt="" src="/content/files/page/images/premium-quality-2.jpg" style="width: 50px; height: 50px;" />Premium quality</p>\n</div>\n<p class="p1">\n	A breakfast treat! Liven up your mornings with a burst of citrus flavour and a hint of Ginger on your toast.<br />\n	We think that muffins, marmalade loaves and steamed orange pudding<span class="s1"> </span>really bring out the warmth of this ginger treat.</p>\n<p>\n	Ingredients:</p>\n<ul>\n	<li>\n		Sugar</li>\n	<li>\n		Seville Bitter Orange Pulp</li>\n	<li>\n		Stem Ginger (8%) [Ginger, Sugar]</li>\n	<li>\n		Acidity Regulator: Citric Acid</li>\n	<li>\n		Spices</li>\n</ul>\n<p>\n	Product Weight: 340g<br />\n	Prepared with 48g fruit per 100g<br />\n	Total sugar content 62g per 100g</p>\n<p>\n	<img alt="" src="/content/files/page/images/gold-2012-1-v1.jpg" style="width: 50px; height: 50px;" /></p>\n'),
(1648, 1, 'Vintage Thick Cut Orange Marmalade', 'vintage-thick-cut-orange-marmalade', 'The secret of a truly special marmalade is all in the fruit. We use only the ripest oranges to ensure the perfect combination of taste and texture. Try it now!', '<div class="advantages">\n	<p>\n		<img alt="" src="/content/files/page/images/perfect-cakes-2.jpg" style="width: 50px; height: 50px;" />Modern twists on an old favourite</p>\n	<p>\n		<img alt="" src="/content/files/page/images/fresh-fruit-2.jpg" style="width: 50px; height: 50px;" />Made from real fresh fruit</p>\n	<p>\n		<img alt="" src="/content/files/page/images/no-preservatives-2.jpg" style="width: 50px; height: 50px;" />No added preservatives</p>\n	<p>\n		<img alt="" src="/content/files/page/images/premium-quality-2.jpg" style="width: 50px; height: 50px;" />Premium quality</p>\n</div>\n<p class="p1">\n	The secret of a truly special marmalade is all in the fruit. We use only the ripest, hand-picked oranges to ensure the ideal combination of fruit and peel, for a heady combination of sweet and bitter flavour with a vintage thick cut texture to match.<br />\n	Add to your favourite cakes, truffles, mousses and fruit bread. The big traces of peel make these desserts more enjoyable.</p>\n<p>\n	Ingredients:</p>\n<ul>\n	<li>\n		Sugar</li>\n	<li>\n		Seville Orange Pulp</li>\n	<li>\n		Sweet Orange Pulp</li>\n	<li>\n		Brown Sugar</li>\n	<li>\n		Acidity Regulator: Citric Acid</li>\n	<li>\n		Gelling Agent: Pectin</li>\n</ul>\n<p>\n	Product Weight: 340g<br />\n	Prepared with 56g fruit per 100g<br />\n	Total sugar content 61g per 100g</p>\n<p>\n	<img alt="" src="/content/files/page/images/gold-2012-1-v1.jpg" style="width: 50px; height: 50px;" /></p>\n'),
(1649, 1, 'Orange Marmalade with Whisky', 'orange-marmalade-with-whiskey', 'We have reinvented a favourite breakfast item with this marmalade, in which a drop of whisky brings a hint of the Highlands to your table. Try it today!', '<div class="advantages">\n	<p>\n		<img alt="" src="/content/files/page/images/perfect-cakes-2.jpg" style="width: 50px; height: 50px;" />Special taste for special occasions</p>\n	<p>\n		<img alt="" src="/content/files/page/images/fresh-fruit-2.jpg" style="width: 50px; height: 50px;" />Made from real fresh fruit</p>\n	<p>\n		<img alt="" src="/content/files/page/images/no-preservatives-2.jpg" style="width: 50px; height: 50px;" />No added preservatives</p>\n	<p>\n		<img alt="" src="/content/files/page/images/premium-quality-2.jpg" style="width: 50px; height: 50px;" />Premium quality</p>\n</div>\n<p class="p1">\n	We have reinvented a traditional favourite item with this marmalade, in which a drop of whisky brings a hint of the Highlands to your table.<br />\n	The usability of this marmalade is endless, perfect in desserts and impeccable with savouries &amp; roasted meats.<br />\n	Some idea of the many: orange marmalade truffles, sponge puddings, orange with whisky marmalade and mustard glazed ham, homemade seasonal terrine with orange and whisky marmalade, turducken with whisky marmalade and mustard glaze, roasted poussin with a whisky marmalade sauce...<br />\n	Makes a perfect present for birthdays, men''s day, Christmas<span class="s1"> </span>or any time for the men in your home.</p>\n<p>\n	Ingredients:</p>\n<ul>\n	<li>\n		Sugar</li>\n	<li>\n		Seville Bitter Orange Pulp</li>\n	<li>\n		Sweet Orange Pulp</li>\n	<li>\n		Whisky 40% ABV (3%) [Whisky, Caramel]</li>\n	<li>\n		Acidity Regulator: Citric Acid</li>\n</ul>\n<p>\n	Product Weight: 340g<br />\n	Prepared with 55g fruit per 100g<br />\n	Total sugar content 61g per 100g</p>\n<p>\n	<img alt="" src="/content/files/page/images/west-2014-gold-v1.jpg" style="width: 50px; height: 50px;" /></p>\n'),
(1650, 1, 'Wild Moroccan Orange Marmalade', 'wild-moroccan-orange-marmalade', 'A wonderful marmalade with a strong and robust flavour that''s made especially to orange lovers. \nPerfect with muffin or simply on toast. Open a jar today!', '<div class="advantages">\n	<p>\n		<img alt="" src="/content/files/page/images/perfect-cakes-2.jpg" style="width: 50px; height: 50px;" />Something different to brighten your day</p>\n	<p>\n		<img alt="" src="/content/files/page/images/fresh-fruit-2.jpg" style="width: 50px; height: 50px;" />Made from real fresh fruit</p>\n	<p>\n		<img alt="" src="/content/files/page/images/no-preservatives-2.jpg" style="width: 50px; height: 50px;" />No added preservatives</p>\n	<p>\n		<img alt="" src="/content/files/page/images/premium-quality-2.jpg" style="width: 50px; height: 50px;" />Premium quality</p>\n</div>\n<p class="p1">\n	A wonderful marmalade with a strong and robust flavour that''s made especially to orange lovers.<br />\n	Perfect on toasted fruit bread, sponge pudding &amp; french toast<span class="s1"> </span>sure to become a favourite.<br />\n	Make toast for the kids and enjoy the sound of the crunch.</p>\n<p>\n	Ingredients:</p>\n<ul>\n	<li>\n		Sugar</li>\n	<li>\n		Moroccan Wild Orange</li>\n	<li>\n		Water</li>\n	<li>\n		Lemon Juice</li>\n	<li>\n		Lemon Zest</li>\n	<li>\n		Gelling Agent: Pectin</li>\n</ul>\n<p>\n	Product Weight: 340g<br />\n	Prepared with 34g fruit per 100g<br />\n	Total sugar content 63g per 100g</p>\n'),
(1651, 1, 'Seville Orange Medium Cut Marmalade', 'seville-orange-marmalade', 'A classic recipe, with a citrus-scented breeze from Seville in every jar. Bring your mornings to life with this citrus treat. Click here to try it for yourself!', '<div class="advantages">\n	<p>\n		<img alt="" src="/content/files/page/images/perfect-cakes-2.jpg" style="width: 50px; height: 50px;" />Something different to brighten your day</p>\n	<p>\n		<img alt="" src="/content/files/page/images/fresh-fruit-2.jpg" style="width: 50px; height: 50px;" />Made from real fresh fruit</p>\n	<p>\n		<img alt="" src="/content/files/page/images/no-preservatives-2.jpg" style="width: 50px; height: 50px;" />No added preservatives</p>\n	<p>\n		<img alt="" src="/content/files/page/images/premium-quality-2.jpg" style="width: 50px; height: 50px;" />Premium quality</p>\n</div>\n<p class="p1">\n	We travelled all the way to Spain in search of the perfect marriage of sweetness and bitterness for our marmalade. Now we have brought back this classic recipe, now you can enjoy the citrus-scented breeze from Seville in every jar.<br />\n	Perfect partner if you organize a tea-party. Flawless in tea cakes, muffins, orange cream pudding, chocolate &amp; orange pot, jaffa cakes, bakewell tart and so on.<br />\n	Perfect with savouries as well. Try with sweet citrus and herb bouquet-stuffed cornish game hens with orange marmalade glaze, marmalade and mustard glazed ham.</p>\n<p>\n	Ingredients:</p>\n<ul>\n	<li>\n		Sugar</li>\n	<li>\n		Seville Bitter Orange Pulp</li>\n	<li>\n		Sweet Orange Pulp</li>\n	<li>\n		Acidity Regulator: Citric Acid</li>\n</ul>\n<p>\n	Product Weight: 340g<br />\n	Prepared with 55g fruit per 100g<br />\n	Total sugar content 60g per 100g</p>\n'),
(1652, 1, 'Three Fruit Marmalade', 'three-fruit-maramalade', 'An unforgettable marmalade with fresh Lemon, aromatic Grapefruit and luscious Orange. Recommended for all citrus lovers. Click here to try it for yourself!', '<div class="advantages">\n	<p>\n		<img alt="" src="/content/files/page/images/perfect-cakes-2.jpg" style="width: 50px; height: 50px;" />Perfect flavour combination</p>\n	<p>\n		<img alt="" src="/content/files/page/images/fresh-fruit-2.jpg" style="width: 50px; height: 50px;" />Made from real fresh fruit</p>\n	<p>\n		<img alt="" src="/content/files/page/images/no-preservatives-2.jpg" style="width: 50px; height: 50px;" />No added preservatives</p>\n	<p>\n		<img alt="" src="/content/files/page/images/premium-quality-2.jpg" style="width: 50px; height: 50px;" />Premium quality</p>\n</div>\n<p class="p1">\n	Our chef has perfectly blended the qualities of these three fruits, so that you can taste each one in every mouthful - fresh Lemon, aromatic Grapefruit and luscious Orange are here combined for an unforgettable marmalade.<br />\n	Awesome treat if you cook chili and three-fruit marmalade glazed chicken wings, eat with a slice of sharp cheddar or put on thumbprint cookies.</p>\n<p>\n	Ingredients:</p>\n<ul>\n	<li>\n		Sugar</li>\n	<li>\n		Grapefruit Pulp</li>\n	<li>\n		Seville Bitter Orange Pulp</li>\n	<li>\n		Lemon</li>\n	<li>\n		Acidity Regulator: Citric Acid</li>\n</ul>\n<p>\n	Product Weight: 340g<br />\n	Prepared with 19g fruit per 100g<br />\n	Total sugar content 61g per 100g</p>\n<p>\n	<img alt="" src="/content/files/page/images/gold-2009-1-v1.jpg" style="width: 50px; height: 50px;" /></p>\n'),
(1653, 1, 'Pink Grapefruit Marmalade', 'pink-grapefruit-maramalade', 'For all citrus lovers! Try our Pink Grapefruit as an alternative to your usual orange marmalade, with all the rich flavour you expect, plus a burst of sunlight.', '<div class="advantages">\n	<p>\n		<img alt="" src="/content/files/page/images/perfect-cakes-2.jpg" style="width: 50px; height: 50px;" />Exotic flavour to brighten your day</p>\n	<p>\n		<img alt="" src="/content/files/page/images/fresh-fruit-2.jpg" style="width: 50px; height: 50px;" />Made from real fresh fruit</p>\n	<p>\n		<img alt="" src="/content/files/page/images/no-preservatives-2.jpg" style="width: 50px; height: 50px;" />No added preservatives</p>\n	<p>\n		<img alt="" src="/content/files/page/images/premium-quality-2.jpg" style="width: 50px; height: 50px;" />Premium quality</p>\n</div>\n<p class="p1">\n	For all citrus lovers, try our Pink Grapefruit recipe as an alternative to your usual orange marmalade, with all the rich flavour you expect, plus a burst of sunlight.<br />\n	Perfect in vodka based cocktails, marmalade sundaes and madeleines.</p>\n<p>\n	Ingredients:</p>\n<ul>\n	<li>\n		Sugar</li>\n	<li>\n		Pink Grapefruit</li>\n	<li>\n		Water</li>\n	<li>\n		Acidity Regulator: Citric Acid</li>\n	<li>\n		Gelling Agent: Pectin</li>\n</ul>\n<p>\n	Product Weight: 340g<br />\n	Prepared with 34g fruit per 100g<br />\n	Total sugar content 60g per 100g</p>\n'),
(1654, 1, 'Lemon and Lime Marmalade', 'lemon-and-lime-maramalade', 'Guaranteed to wake you up with a burst of freshness first thing in the day, or any time you need a pick-me-up. Click here to try it for yourself!', '<p>\n	Add some zest to your morning table with this blend of the zingiest limes and lemons. Guaranteed to wake you up with a burst of freshness first thing in the day, or any time you need a pick-me-up.</p>\n'),
(1663, 1, 'Finest Quality Afternoon Tea', 'afternoon-tea', 'Do you find yourself out of energy before the end of the afternoon?\nThis medium strong tea offers a comforting pick-me-up at any time of day. Try it now!', '<p class="p1">\n	Do you find yourself tired and out of energy before the end of the afternoon?<br />\n	You''ve come to the right place. This medium strong tea offers a comforting pick-me-up at any time of day.<br />\n	Keeping alive an English tradition, serve it with sandwiches and cupcakes or try it on its own with biscuits.<br />\n	Can be drunk with or without milk.</p>\n<p class="p1">\n	Blended and packed in the UK.<br />\n	Product Weight: 125g (45 bags)</p>\n'),
(1664, 1, 'Finest Quality English Breakfast Tea', 'breakfast-tea', 'Can''t face the morning without a cup of hearty English tea?\nKick start your routine with a familiar breakfast tea in this premium edition. Try it now!', '<p class="p1">\n	Can''t face the morning without a cup of hearty English tea?<br />\n	Kick start your routine with a familiar breakfast tea in this premium edition.<br />\n	Drink it in the classic way or try it with a spoonful of honey or a slice of lemon on rainy mornings.</p>\n<p class="p1">\n	Blended and packed in the UK.<br />\n	Product Weight: 125g (50 bags)</p>\n'),
(1665, 1, 'Luxurious hand-baked Butter Shortbread', 'butter-shortbread', 'Too delicious to save in the cupboard, make every day a special occasion with these smooth and buttery biscuits that truly melt in the mouth. Try it now!', '<p class="p1">\n	Too delicious to save in the cupboard, make every day a special occasion with these smooth and buttery biscuits that truly melt in the mouth.<br />\n	Perfect with your favourite brew or even a drop of whiskey.<br />\n	The finest ingredients and a traditional recipe make this a perfect gift.</p>\n<p class="p1">\n	Ingredients:</p>\n<ul class="ul1">\n	<li class="li2">\n		<strong>Wheat</strong> Flour</li>\n	<li class="li2">\n		Cornflour</li>\n	<li class="li2">\n		Sugar</li>\n	<li class="li2">\n		Vegetable Fat</li>\n	<li class="li2">\n		Butter (10%) (<strong>Milk</strong>)</li>\n</ul>\n<p class="p1">\n	Allergy advice: For allergens, see ingredients in&nbsp;<strong>bold</strong><br />\n	Product Weight: 150g</p>\n');

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=10 ;

--
-- Dumping data for table `shipping_method`
--

INSERT INTO `shipping_method` (`id_shipping_method`, `name`) VALUES
(1, 'personal'),
(2, 'post-3-day'),
(3, 'post+cod'),
(4, 'free-post-3-day'),
(5, 'post-1-day'),
(6, 'locker-drop-off'),
(7, 'free-post-1-day'),
(8, 'free-locker-drop-off'),
(9, 'hermes');

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
  `price` decimal(11,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `shop_payment_method`
--

INSERT INTO `shop_payment_method` (`id_shop`, `id_payment_method`, `price`) VALUES
(28, 1, '0.00'),
(28, 4, '0.00'),
(28, 5, '0.00'),
(30, 2, '0.00'),
(30, 3, '0.00');

-- --------------------------------------------------------

--
-- Table structure for table `shop_shipping_method`
--

CREATE TABLE IF NOT EXISTS `shop_shipping_method` (
`id` bigint(20) NOT NULL,
  `id_shop` bigint(20) NOT NULL DEFAULT '0',
  `id_shipping_method` bigint(20) NOT NULL DEFAULT '0',
  `price` decimal(11,2) DEFAULT NULL,
  `interval_min` decimal(11,2) DEFAULT NULL,
  `interval_max` decimal(11,2) DEFAULT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=8 ;

--
-- Dumping data for table `shop_shipping_method`
--

INSERT INTO `shop_shipping_method` (`id`, `id_shop`, `id_shipping_method`, `price`, `interval_min`, `interval_max`) VALUES
(4, 30, 2, '6.90', NULL, NULL),
(5, 30, 4, '0.00', NULL, NULL),
(6, 30, 9, '2.99', NULL, '24.99'),
(7, 30, 9, '0.00', '25.00', NULL);

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
(1, NULL, 'syke', 'syke', '25d55ad283aa400af464c76d713c07ad', 'webshop@sykeonline.com', '0000-00-00 00:00:00', 'root'),
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
-- Indexes for table `coupon`
--
ALTER TABLE `coupon`
 ADD PRIMARY KEY (`id_coupon`), ADD UNIQUE KEY `code` (`code`);

--
-- Indexes for table `customer`
--
ALTER TABLE `customer`
 ADD PRIMARY KEY (`id_customer`), ADD UNIQUE KEY `id_shop` (`id_shop`,`email`), ADD KEY `passw` (`passw`);

--
-- Indexes for table `gallery_image`
--
ALTER TABLE `gallery_image`
 ADD PRIMARY KEY (`id_gallery_image`), ADD UNIQUE KEY `filename` (`filename`), ADD KEY `id_shop` (`id_shop`);

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
 ADD PRIMARY KEY (`id_order`), ADD KEY `id_shop` (`id_shop`), ADD KEY `payment_status` (`payment_status`), ADD KEY `id_language` (`id_language`), ADD KEY `id_coupon` (`id_coupon`);

--
-- Indexes for table `order_pack`
--
ALTER TABLE `order_pack`
 ADD PRIMARY KEY (`id_order_pack`), ADD KEY `id_order` (`id_order`), ADD KEY `id_pack` (`id_pack`);

--
-- Indexes for table `order_product`
--
ALTER TABLE `order_product`
 ADD PRIMARY KEY (`id_order_product`), ADD KEY `id_order` (`id_order`), ADD KEY `id_product` (`id_product`);

--
-- Indexes for table `pack`
--
ALTER TABLE `pack`
 ADD PRIMARY KEY (`id_pack`), ADD KEY `id_shop` (`id_category`);

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
-- Indexes for table `paypal`
--
ALTER TABLE `paypal`
 ADD PRIMARY KEY (`id_order`);

--
-- Indexes for table `product`
--
ALTER TABLE `product`
 ADD PRIMARY KEY (`id_product`), ADD KEY `is_featured` (`is_featured`), ADD KEY `is_sale` (`is_sale`), ADD KEY `id_category` (`id_category`), ADD KEY `product_code` (`product_code`), ADD KEY `is_active` (`is_active`);

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
 ADD PRIMARY KEY (`id`), ADD KEY `id_shipping_method` (`id_shipping_method`), ADD KEY `id_shop` (`id_shop`), ADD KEY `interval_min` (`interval_min`), ADD KEY `interval_max` (`interval_max`);

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
MODIFY `id_category` bigint(20) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=82;
--
-- AUTO_INCREMENT for table `coupon`
--
ALTER TABLE `coupon`
MODIFY `id_coupon` bigint(20) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `customer`
--
ALTER TABLE `customer`
MODIFY `id_customer` bigint(20) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `gallery_image`
--
ALTER TABLE `gallery_image`
MODIFY `id_gallery_image` bigint(20) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=83;
--
-- AUTO_INCREMENT for table `language`
--
ALTER TABLE `language`
MODIFY `id_language` tinyint(4) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `menu`
--
ALTER TABLE `menu`
MODIFY `id_menu` bigint(20) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT for table `menu_item`
--
ALTER TABLE `menu_item`
MODIFY `id_menu_item` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=82;
--
-- AUTO_INCREMENT for table `order`
--
ALTER TABLE `order`
MODIFY `id_order` bigint(20) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=60;
--
-- AUTO_INCREMENT for table `order_pack`
--
ALTER TABLE `order_pack`
MODIFY `id_order_pack` bigint(20) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `order_product`
--
ALTER TABLE `order_product`
MODIFY `id_order_product` bigint(20) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=31;
--
-- AUTO_INCREMENT for table `pack`
--
ALTER TABLE `pack`
MODIFY `id_pack` bigint(20) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=9;
--
-- AUTO_INCREMENT for table `pack_photo`
--
ALTER TABLE `pack_photo`
MODIFY `id_photo` bigint(20) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=100;
--
-- AUTO_INCREMENT for table `page`
--
ALTER TABLE `page`
MODIFY `id_page` bigint(20) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=39;
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
-- AUTO_INCREMENT for table `paypal`
--
ALTER TABLE `paypal`
MODIFY `id_order` bigint(20) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=60;
--
-- AUTO_INCREMENT for table `product`
--
ALTER TABLE `product`
MODIFY `id_product` bigint(20) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=1666;
--
-- AUTO_INCREMENT for table `product_photo`
--
ALTER TABLE `product_photo`
MODIFY `id_photo` bigint(20) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=1457;
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
MODIFY `id_shipping_method` bigint(20) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=10;
--
-- AUTO_INCREMENT for table `shop`
--
ALTER TABLE `shop`
MODIFY `id_shop` bigint(20) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=31;
--
-- AUTO_INCREMENT for table `shop_shipping_method`
--
ALTER TABLE `shop_shipping_method`
MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=8;
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
-- Constraints for table `gallery_image`
--
ALTER TABLE `gallery_image`
ADD CONSTRAINT `gallery_image_ibfk_1` FOREIGN KEY (`id_shop`) REFERENCES `shop` (`id_shop`) ON DELETE CASCADE ON UPDATE CASCADE;

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
-- Constraints for table `order_pack`
--
ALTER TABLE `order_pack`
ADD CONSTRAINT `order_pack_ibfk_3` FOREIGN KEY (`id_order`) REFERENCES `order` (`id_order`) ON DELETE CASCADE,
ADD CONSTRAINT `order_pack_ibfk_4` FOREIGN KEY (`id_pack`) REFERENCES `pack` (`id_pack`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `order_product`
--
ALTER TABLE `order_product`
ADD CONSTRAINT `order_product_ibfk_4` FOREIGN KEY (`id_product`) REFERENCES `product` (`id_product`),
ADD CONSTRAINT `order_product_ibfk_3` FOREIGN KEY (`id_order`) REFERENCES `order` (`id_order`) ON DELETE CASCADE;

--
-- Constraints for table `pack`
--
ALTER TABLE `pack`
ADD CONSTRAINT `pack_ibfk_1` FOREIGN KEY (`id_category`) REFERENCES `category` (`id_category`) ON DELETE CASCADE ON UPDATE CASCADE;

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
-- Constraints for table `paypal`
--
ALTER TABLE `paypal`
ADD CONSTRAINT `paypal_ibfk_1` FOREIGN KEY (`id_order`) REFERENCES `order` (`id_order`) ON DELETE CASCADE ON UPDATE CASCADE;

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
-- Constraints for table `shop_shipping_method`
--
ALTER TABLE `shop_shipping_method`
ADD CONSTRAINT `shop_shipping_method_ibfk_2` FOREIGN KEY (`id_shop`) REFERENCES `shop` (`id_shop`),
ADD CONSTRAINT `shop_shipping_method_ibfk_1` FOREIGN KEY (`id_shipping_method`) REFERENCES `shipping_method` (`id_shipping_method`);

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
