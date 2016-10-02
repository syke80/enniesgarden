<?php
/**
 * Smarty-Light plugin
 * -------------------------------------------------------------
 * Type:     function
 * Name:     load
 * Purpose:  Betölti egy url tartalmát
 * Input:
 *         - url
 * -------------------------------------------------------------
 */
function _get_menu_tree($sName) {
	$oMenuDao =& DaoFactory::getDao('menu'); 
	$aMenu = $oMenuDao->getMenuFromName($sName);
	$aMenuItemList = $oMenuDao->getAllMenuItem($aMenu['id_menu']);
	if (empty($aMenuItemList)) return false;
	$aMenuItemTree = array();
	foreach ($aMenuItemList as $aMenuItem) {
		if ($aMenuItem['id_parent'] == 0) {
			if (!isset($aMenuItemTree[$aMenuItem['id_menu_item']])) $aMenuItemTree[$aMenuItem['id_menu_item']] = array();
			$aMenuItemTree[$aMenuItem['id_menu_item']] = array_merge($aMenuItemTree[$aMenuItem['id_menu_item']], $aMenuItem);
		}
		else {
			$aMenuItemTree[$aMenuItem['id_parent']]['children'][$aMenuItem['id_menu_item']] = $aMenuItem;
		}
	}
	return $aMenuItemTree;
}

function tpl_function_menu($params, &$tpl) {
	$aMenuTree = _get_menu_tree($params['name']);
	$tpl->assign($params['assign'], $aMenuTree);
}
?>
