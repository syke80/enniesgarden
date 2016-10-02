<?php
	define('DOCROOT',              '');                        // A weboldal helye. Pl. /var/www/website
	define('DIR_CORE',             DOCROOT.'/core');
	define('DIR_CONTENT',          DOCROOT.'/content');
	define('DIR_TEMP',             DOCROOT.'/temp');
	define('DIR_CACHE',            DOCROOT.'/temp');
	define('DIR_SMARTY_COMPILED',  DOCROOT.'/temp/compiled');
	define('DIR_DEBUG',            DOCROOT.'/temp/debug');     // A debug osztály ide generálja a log.txt-t és az msg.txt-t
	define('DIR_FILES',            DIR_CONTENT.'/files');      // A modulokkal létrehozott (generált, feltöltött) fájlok helye (nem resze a repositorynak)

	$GLOBALS['db_config']['default']['driver']   = 'mysql';
	$GLOBALS['db_config']['default']['host']     = 'localhost';
	$GLOBALS['db_config']['default']['port']     = '3306';
	$GLOBALS['db_config']['default']['username'] = '';
	$GLOBALS['db_config']['default']['password'] = '';
	$GLOBALS['db_config']['default']['db']       = '';

	$GLOBALS['smtp_config']['host']     = '';
	$GLOBALS['smtp_config']['port']     = 25;
	$GLOBALS['smtp_config']['username'] = '';
	$GLOBALS['smtp_config']['password'] = '';

	define('_DEVEL', 1);
?>