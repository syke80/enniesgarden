<?php
function getLayoutVars() {
	$oUserauth =& ModuleFactory::getModule('userauth');
	$oShopDao =& DaoFactory::getDao('shop');

	$aLayoutVars['siteconfig'] = $GLOBALS['siteconfig'];
	$aLayoutVars['user']       = $oUserauth->getUser();

	$aLayoutVars['module']       = Request::getModuleName();
	$aLayoutVars['modulemethod'] = Request::getModuleMethodName();

	$aLayoutVars['module']     = Request::getModuleName();
	$aLayoutVars['skin']       = isset($GLOBALS['skin']) ? $GLOBALS['skin'] : '';
	$aLayoutVars['shoplist']   = $oShopDao->getShopList();
	
	return $aLayoutVars;
}
?>