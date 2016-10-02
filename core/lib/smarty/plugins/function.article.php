<?php
/*
 * Smarty-Light plugin
 * -------------------------------------------------------------
 * Type:     function
 * Name:     article
 * Purpose:  Lekérdez egy tartalmat az article táblákból
 * Credit:   syke
 *
 * Input:  
 *         - region:      Az oldalon belül a régió azonosítója (pl.: content, keywords, description)
 *         - page:        Az oldal azonosítója (pl.: index, purchase).
 *                        Opcionális. Ha nincs kitöltve, akkor egy default értéket tartalmazhat, ami minden oldalnál ugyanaz.
 *         - id_country:  Az ország azonosítója.
 *                        Opcionális. Nincs értéke, ha nem használ országonként különböző tartalmat az oldal, vagy default értéket akarunk tárolni benne.
 *         - id_language: A nyelv azonosítója.   
 *                        Opcionális. Nincs értéke, ha nem használ nyelveket az oldal, vagy default értéket akarunk tárolni benne.
 *         - assign:      A változó neve, amibe az eredmény kerül.
 *                        Ha nincs megadva, akkor kiírja a kimenetre.
 * -------------------------------------------------------------
 */
function tpl_function_article($params, &$tpl) {
	if (!isset($params['page']) || !isset($params['region'])) return;
	if (!isset($params['id_site'])) $params['id_site'] = $GLOBALS['siteconfig']['id_site'];
	
	$oArticleDao =& DaoFactory::getDao('article');
	$aArticle = $oArticleDao->getContent($params['id_site'], $params['page'], $params['region']);

	if (!empty($params['assign'])) {
		$tpl->assign($params['assign'], $aArticle['content']);
		return false;
	}
	else {
		return $aArticle['content'];
	}
}
?>
