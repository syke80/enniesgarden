<?php
/**
 * Smarty-Light plugin
 * -------------------------------------------------------------
 * Type:     function
 * Name:     mtimelink
 * Purpose:  Visszaadja egy file url-jét kiegészítve az utolsó módosítás dátumával
 *           Relatív útvonal kell, a site_url-t is a plugin rakja hozzá
 * Input:
 *         - file: a file neve és relatív url-je. pl www/css/page.css
 * -------------------------------------------------------------
 */
function tpl_function_mtimelink($params, &$tpl) {
	extract($params);

	if (file_exists(DIR_CONTENT.'/sites/'.$file)) {
		return($GLOBALS['siteconfig']['site_url'].'/content/sites/'.$file.'?version='.filemtime(DIR_CONTENT.'/sites/'.$file));
	}

	return FALSE;
}
?>
