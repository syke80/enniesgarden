<?php
class ListModule extends Module {
	protected function _access($sMethodName) {
		return TRUE;
	}

	public function path() {
		return array(
			'list' => array(
				'method'      => 'default',
			),
		);
	}

	/**
	 * Terméklista boxokat renderel
	 *
	 * Háromféle listát tud generálni a $sType változó alapján:
	 *    new:      Teljes terméklista fordított időrendi sorrendben
	 *    featured: Azok a termékek amiknél az "ajánló" checkbox be lett jelölve az admin felületen
	 *    sale:     Azok a termékek amiknél az "akciós" checkbox be lett jelölve az admin felületen
	 *
	 * @param  string   $sType   A lista típusa
	 * @param  int      $iLimit  A megjelenítendő termékek száma.
	 *                           Ha 0, vagy nincs megadva, akkor az összes találat megjelenik
	 *
	 * @return string   A generált oldal tartalma
	 */
	protected function _reqDefault($sType, $iLimit=0) {
		$oProductDao =& DaoFactory::getDao('product');
		$oPackDao =& DaoFactory::getDao('pack');
		switch ($sType) {
			case 'all':
				$aProductList = $oProductDao->getProductList($GLOBALS['siteconfig']['shop_permalink'], 'en', '', '', $iLimit);
				$aProductList = $aProductList['list'];
//				$aProductList += $oPackDao->getPackList($GLOBALS['siteconfig']['shop_permalink'], 'en', $iLimit);


				break;
			case 'new':
				$aProductList = $oProductDao->getNewList($GLOBALS['siteconfig']['shop_permalink'], $iLimit);
				break;
			case 'featured':
				$aProductList = $oProductDao->getFeaturedList($GLOBALS['siteconfig']['shop_permalink'], $iLimit);
				break;
			case 'sale':
				$aProductList = $oProductDao->getSaleList($GLOBALS['siteconfig']['shop_permalink'], $iLimit);
				break;
		}

		return Output::render('list', getLayoutVars() + array(
			'type' => $sType,
			'productlist' => $aProductList
		), 'blank');
	}
}
?>