<?php
class SearchModule extends Module {
	protected function _access($sMethodName) {
		return TRUE;
	}

	public function path() {
		return array(
			'search' => array(
				'method'      => 'default',
				'id_language' => 'en',
			),
		);
	}

	/**
	 * Rendereli a keresés találati oldalát.
	 * Ha nincs megadva search string, akkor átirányít a főoldalra.
	 *
	 * @param  string   $sSearchStr
	 *
	 * @return string   A generált oldal tartalma
	 */
	protected function _reqDefault($sSearchStr) {
		if (!isset($sSearchStr)) Request::redirect($GLOBALS['siteconfig']['site_url']);

		$oShopDao =& DaoFactory::getDao('shop');
		$oProductDao =& DaoFactory::getDao('product');

		$aShop = $oShopDao->getShopByPermalink($GLOBALS['siteconfig']['shop_permalink']);
		$aSearchStringList = explode(' ', $sSearchStr);

		return Output::render('search', getLayoutVars() + array(
			'search_str' => $sSearchStr,
			'productlist' => $oProductDao->search($aShop['id_shop'], $GLOBALS['id_language'], $aSearchStringList),
		));
	}
}
?>