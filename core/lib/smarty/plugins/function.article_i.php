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
 *         - id_site:     Az website azonosítója (pl.: www, universal, travel)
 *         - id_content:  Az oldal azonosítója (pl.: product/qbon-travel).
 *         - assign:      A változó neve, amibe az eredmény kerül.
 *                        Ha nincs megadva, akkor kiírja a kimenetre.
 * -------------------------------------------------------------
 */
function tpl_function_article_i($params, &$tpl) {
	if (!isset($params['id_content'])) return;
	if (!isset($params['id_site'])) $params['id_site'] = $GLOBALS['siteconfig']['id_site'];
	
	$oArticleDao =& DaoFactory::getDao('article');
	$aArticle = $oArticleDao->getIContent($params['id_site'], $params['id_content']);

	if (!empty($params['assign'])) {
		$tpl->assign($params['assign'], $aArticle['content']);
		return false;
	}
	else {
		return $aArticle['content'];
	}
}
?>
