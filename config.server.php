<?php
	define('DOCROOT',              'D:/Sites/enniesgarden');      // A weboldal helye. Pl. /var/www/website
	define('DIR_CORE',             DOCROOT.'/core');
	define('DIR_CONTENT',          DOCROOT.'/content');
	define('DIR_TEMP',             DOCROOT.'/temp');
	define('DIR_CACHE',            DOCROOT.'/temp');
	define('DIR_SMARTY_COMPILED',  DOCROOT.'/temp/compiled');
	define('DIR_DEBUG',            DOCROOT.'/temp/debug');     // A debug osztály ide generálja a log.txt-t és az msg.txt-t
	define('DIR_FILES',            DIR_CONTENT.'/files');          // A modulokkal létrehozott (generált, feltöltött) fájlok helye (nem resze a repositorynak)

	$GLOBALS['db_config']['default']['driver']   = 'mysql';
	$GLOBALS['db_config']['default']['host']     = '127.0.0.1';
	$GLOBALS['db_config']['default']['port']     = '3306';
	$GLOBALS['db_config']['default']['username'] = 'root';
	$GLOBALS['db_config']['default']['password'] = '';
	$GLOBALS['db_config']['default']['db']       = 'enniesgarden';

/*
	$GLOBALS['smtp_config']['host']     = '';
	$GLOBALS['smtp_config']['port']     = 25;
//	$GLOBALS['smtp_config']['auth'] = true;
	$GLOBALS['smtp_config']['username'] = '';
	$GLOBALS['smtp_config']['password'] = '';
*/

  	$GLOBALS['smtp_config']['host'] = 'smtp.gmail.com';
	$GLOBALS['smtp_config']['port'] = 465;
	$GLOBALS['smtp_config']['auth'] = true;
	$GLOBALS['smtp_config']['username'] = 'syke80@gmail.com';
	$GLOBALS['smtp_config']['password'] = '*9uR2gQL';
	$GLOBALS['smtp_config']['secure'] = 'ssl';

/*
  	$GLOBALS['smtp_config']['host'] = 'smtp.gmail.com';
	$GLOBALS['smtp_config']['port'] = 587;
	$GLOBALS['smtp_config']['auth'] = true;
	$GLOBALS['smtp_config']['username'] = 'syke80@gmail.com';
	$GLOBALS['smtp_config']['password'] = '*9uR2gQL';
	$GLOBALS['smtp_config']['secure'] = 'tls';
*/

	define('_DEVEL', 1);
?>