<?php
/**
 * Smarty-Light plugin
 * -------------------------------------------------------------
 * Type:     function
 * Name:     loadfromskin
 * Purpose:  Visszaadja egy file url-jét a megfelelő skin könyvtárból.
 *           Ha a kiválasztott skinben nem található, akkor a defaultból tölti
 * Input:
 *         - file: a file neve és relatív url-je. pl css/page.css
 * -------------------------------------------------------------
 */
function tpl_function_loadfromskin($params, &$tpl) {
	extract($params);

/*
	if (file_exists(DIR_SKIN.'/'.$file)) return(URL_SKIN.'/'.$file);
	if (file_exists(DIR_SKIN_DEFAULT.'/'.$file)) return(URL_SKIN_DEFAULT.'/'.$file);
*/
	if (file_exists(DIR_SKIN.'/'.$file)) {
		$mtime = isset($params['append_mtime']) ? '?version='.filemtime(DIR_SKIN.'/'.$file) : '';
		return(URL_SKIN.'/'.$file.$mtime);
	}
	else {
		$mtime = isset($params['append_mtime']) ? '?version='.filemtime("{$GLOBALS['server_root']}/skins/default/{$file}") : '';
		return(URL_SKIN_DEFAULT.'/'.$file.$mtime);
	}

	return FALSE;
}
?>
