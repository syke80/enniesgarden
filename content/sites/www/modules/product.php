<?php
class ProductModule extends Module {
	protected function _access($sMethodName) {
		return TRUE;
	}

	public function path() {
	}

	/**
	 * Rendereli a paraméterben megadott termék oldalát.
	 *
	 * @param  string   $sPermalink1  Ha csak 1 parametert kapunk, akkor a termék permalinkje
	 *                                Ha 2 parameter van, akkor ez a kategoria permalinkje	 
	 * @param  string   $sPermalink2  Ha 2 parameter van, akkor ez a termek permalinkje 
	 *
	 * @return string   A generált oldal tartalma
	 */
	protected function _reqDefault($sPermalink1, $sPermalink2 = '') {
		if (!isset($sPermalink1)) return FALSE;

		$oProductDao =& DaoFactory::getDao('product');
		$oPhotoDao =& DaoFactory::getDao('product_photo');
		$oCategoryDao =& DaoFactory::getDao('category');

		$aProduct = $oProductDao->getProductByPermalinks($GLOBALS['siteconfig']['shop_permalink'], $sPermalink1, $sPermalink2);
		if (empty($aProduct)) return FALSE;

		// Termék képei
		$aPhotoList = $oPhotoDao->getPhotoListByIdProduct($aProduct['id_product']);

		// Termék tulajdonságai. A $aPropertyList-ben lesz a végeredmény.
		$aValueList = $oProductDao->getLinkedPropertyValueList($aProduct['id_product'], $aProduct['language_iso']);
		$aPropertyList = array();
		if (!empty($aValueList)) {
			foreach ($aValueList as $aValue) {
				if (!isset($aPropertyList[$aValue['id_property']])) {
					$aPropertyList[$aValue['id_property']] = array(
						'name' => $aValue['property_name'],
						'valuelist' => array()
					);
				}
				$aPropertyList[$aValue['id_property']]['valuelist'][] = array(
					'id_value' => $aValue['id_value'],
					'name' => $aValue['value_name']
				);
			}
		}

		return Output::render('product', getLayoutVars() + array(
			'product' => $aProduct,
			'category' => $oCategoryDao->getCategory($aProduct['id_category']),
			'photolist' => $aPhotoList,
			'photolist_count' => count($aPhotoList),
			'propertylist' => $aPropertyList
		));
	}
}
?>