<?php
/*
 * Smarty-Light plugin
 * -------------------------------------------------------------
 * Type:     function
 * Name:     page
 * Purpose:  Lekérdez egy tartalmat a page táblákból
 * Credit:   syke
 *
 * Input:  
 *         - id_site:     Az website azonosítója (pl.: www, universal, travel).
 *                        Ha nincs megadva, akkor az épp futó site-hoz tartozó tartalmakat kérdezi le 
 *         - permalink:   Az oldal permalinkje (pl.: product/qbon-travel).
 *         - region:      A régió neve (pl.: title, description, keywords, content, banner)
 *         - assign:      A változó neve, amibe az eredmény kerül.
 *                        Ha nincs megadva, akkor kiírja a kimenetre.
 * -------------------------------------------------------------
 */
function tpl_function_page($params, &$tpl) {
	if (!isset($params['permalink']) || !isset($params['region'])) return;
	if (!isset($params['id_site'])) $params['id_site'] = $GLOBALS['siteconfig']['id_site'];
	
	$oPageDao =& DaoFactory::getDao('page');
	$aPage = $oPageDao->getContent($params['id_site'], $params['permalink'], $params['region']);
	if (!empty($params['assign'])) {
		$tpl->assign($params['assign'], $aPage['content']);
		return false;
	}
	else {
		return $aPage['content'];
	}
}
?>
