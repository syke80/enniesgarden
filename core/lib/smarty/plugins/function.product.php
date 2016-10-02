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
 *         - list:        Terméklista lekérdezése
 *                        all|new|featured|sale
 *         - lang_iso     A szöveges információk nyelve (en|hu|de|stb.)  
 * -------------------------------------------------------------
 */
function tpl_function_product($params, &$tpl) {
	if (!isset($params['list']) || !isset($params['limit'])) return;

	$sLangIso = isset($params['lang_iso']) ? $params['lang_iso'] : ''; 

	$oProductDao =& DaoFactory::getDao('product');
	$oPackDao =& DaoFactory::getDao('pack');
	$aPackList = '';
	switch ($params['list']) {
		case 'all':
			// PHP 5.3...
			$aProductList = $oProductDao->getProductList($GLOBALS['siteconfig']['shop_permalink'], $sLangIso, '', '', $params['limit']);
			$aProductList = $aProductList['list'];
			$aPackList = $oPackDao->getPackList($GLOBALS['siteconfig']['shop_permalink'], $sLangIso, '', '', $params['limit']);
			$aPackList = $aPackList['list'];
			break;
		case 'new':
			$aProductList = $oProductDao->getNewList($GLOBALS['siteconfig']['shop_permalink'], $params['limit']);
			break;
		case 'featured':
			$aProductList = $oProductDao->getFeaturedList($GLOBALS['siteconfig']['shop_permalink'], $params['limit']);
			break;
		case 'sale':
			$aProductList = $oProductDao->getSaleList($GLOBALS['siteconfig']['shop_permalink'], $params['limit']);
			break;
	}

	return Output::render('list', getLayoutVars() + array(
		'type'        => $params['list'],
		'productlist' => $aProductList,
		'packlist'    => $aPackList,
		'lang_iso'    => $sLangIso,
	));

}
?>
