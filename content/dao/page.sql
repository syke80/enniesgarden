CREATE TABLE IF NOT EXISTS `page` (
  `id_page` bigint(20) NOT NULL AUTO_INCREMENT,
  `id_site` varchar(255) DEFAULT NULL,
  `permalink` varchar(255) DEFAULT NULL,
  `id_category` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id_page`),
  UNIQUE KEY `page` (`id_site`,`permalink`),
  KEY `id_category` (`id_category`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `page_category` (
  `id_category` bigint(20) NOT NULL AUTO_INCREMENT,
  `id_site` varchar(255) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_category`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `page_content` (
  `id_page` bigint(20) NOT NULL DEFAULT '0',
  `id_region` bigint(20) NOT NULL DEFAULT '0',
  `id_category` bigint(20) DEFAULT NULL,
  `content` longtext,
  PRIMARY KEY (`id_page`,`id_region`),
  KEY `id_region` (`id_region`),
  KEY `id_category` (`id_category`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `page_region` (
  `id_region` bigint(20) NOT NULL AUTO_INCREMENT,
  `id_site` varchar(255) DEFAULT NULL,
  `name` tinytext,
  `type` enum('wysiwyg','plaintext') NOT NULL DEFAULT 'plaintext',
  PRIMARY KEY (`id_region`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

INSERT INTO `page_region` (`id_region`, `id_site`, `name`, `type`) VALUES
(1, 'www', 'Title', 'plaintext'),
(2, 'www', 'Content', 'wysiwyg'),
(3, 'www', 'Keywords', 'plaintext'),
(4, 'www', 'Description', 'plaintext'),
(5, 'www', 'Language code', 'plaintext');

ALTER TABLE `page`
  ADD CONSTRAINT `page_ibfk_1` FOREIGN KEY (`id_category`) REFERENCES `page_category` (`id_category`) ON DELETE CASCADE;

ALTER TABLE `page_content`
  ADD CONSTRAINT `page_content_ibfk_3` FOREIGN KEY (`id_page`) REFERENCES `page` (`id_page`) ON DELETE CASCADE,
  ADD CONSTRAINT `page_content_ibfk_4` FOREIGN KEY (`id_region`) REFERENCES `page_region` (`id_region`) ON DELETE CASCADE,
  ADD CONSTRAINT `page_content_ibfk_5` FOREIGN KEY (`id_category`) REFERENCES `page_category` (`id_category`) ON DELETE CASCADE;
