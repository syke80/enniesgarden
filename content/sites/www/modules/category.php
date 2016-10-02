<?php
class CategoryModule extends Module {
	protected function _access($sMethodName) {
		return TRUE;
	}

	public function path() {
	}

	/**
	 * Rendereli a paraméterben megadott kategória oldalát.
	 *
	 * @param  string   $sPermalinkCategory  A kategória permalinkje
	 *
	 * @return string   A generált oldal tartalma
	 */
	protected function _reqDefault($sPermalinkCategory) {
		if (!isset($sPermalinkCategory)) return FALSE;

		$sFilter = isset($_GET['filter']) ? $_GET['filter'] : '';
		
		$oProductDao =& DaoFactory::getDao('product');
		$oPackDao =& DaoFactory::getDao('pack');
		$oCategoryDao =& DaoFactory::getDao('category');
		$oPropertyDao =& DaoFactory::getDao('property');

		$aCategory = $oCategoryDao->getCategoryByShopAndPermalink($GLOBALS['siteconfig']['shop_permalink'], $sPermalinkCategory);

		// Kategória ellenőrzése. Ha nem létezik, akkor 404
		if (empty($aCategory)) return FALSE;

		// Filter tömb létrehozása
		// A templatenek lesz rá szüksége, hogy tudja mit kell checkedre állítani
		if (!empty($sFilter)) {
			$aFilterProperty = explode(';', $sFilter);
			foreach ($aFilterProperty as $aProperty) {
				$aInfo = explode(":", $aProperty);
				$aFilter[$aInfo[0]] = explode(',', $aInfo[1]);
			}
		}
		else $aFilter = NULL;

		// Property-k listája, property_value-k listája a szűréshez
		$aPropertyList = $oPropertyDao->getPropertyList($aCategory['id_category'], $aCategory['language_iso']);
		if ($aPropertyList) {
			foreach ($aPropertyList as &$aProperty) {
				$aProperty['valuelist'] = $oPropertyDao->getPropertyValueList($aProperty['id_property'], $aCategory['language_iso']);
				foreach ($aProperty['valuelist'] as &$aValue) {
					$aValue['checked'] =  (
						isset($aFilter[$aProperty['id_property']]) &&
						in_array($aValue['id_value'], $aFilter[$aProperty['id_property']])
					) ? TRUE : FALSE;
				}
			}
		}

		return Output::render('category', getLayoutVars() + array(
			'category' => $aCategory,
			'productlist' => $oProductDao->getProductListByIdCategory($aCategory['id_category'], $aCategory['language_iso'], $aFilter),
			'packlist' => $oPackDao->getPackListByIdCategory($aCategory['id_category'], $aCategory['language_iso']),
			'propertylist' => $aPropertyList,
			'permalink_category' => $sPermalinkCategory,
			'filter' => $aFilter
		));
	}
}
?>