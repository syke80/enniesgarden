<?php
/**
 * Smarty-Light plugin
 * -------------------------------------------------------------
 * Type:     function
 * Name:     siteconfig
 * Purpose:  Lekérdezi egy site konfigját a site id alapján
 *          
 * Input:
 *         - id_site: A site azonosítója.
 *         - assign:  A változó neve, amibe az eredmény kerül. 
 * -------------------------------------------------------------
 */
function tpl_function_siteconfig($params, &$tpl) {
	foreach ($GLOBALS['sites'] as $url=>$site) {
		if ($site['id_site'] == $params['id_site']) $tpl->assign($params['assign'], $site+array('site_url' => $url));
	}
	return FALSE;
}
?>
