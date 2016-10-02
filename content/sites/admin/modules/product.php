<?php
class ProductModule extends Module {
	protected function _access($sMethodName) {
		$oUserauth =& ModuleFactory::getModule('userauth');
		return $oUserauth->access('stock_admin');
	}

	public function path() {
		return array(
			'product' => array(
				'method'      => 'default',
			),
			'product/add' => array(
				'method'      => 'add',
			),
			'product/edit' => array(
				'method'      => 'edit',
			),
			'product/list' => array(
				'method'      => 'list',
			),
			'product/delete' => array(
				'method'      => 'delete',
			),
			'product/edit/property' => array(
				'method'      => 'editProperty',
			),
		);
	}

	/**
	 * Megvizsgálja a bejelentkezett felhasználó hozzáférését
	 * a paraméterben megadott termékhez.
	 * Ha a felhasználó boltjának egy kategóriájához tartozik a termék, akkor TRUE.
	 *
	 * @param  integer  $iIdProduct  A termék azonosítója
	 *
	 * @return bool     TRUE ha van hozzá joga, FALSE ha nincs
	 */
	public function isOwner($iIdProduct) {
		$oUserauth =& ModuleFactory::getModule('userauth');
		if ($oUserauth->access('root')) return TRUE;

		$oProductDao =& DaoFactory::getDao('product');
		// Ha a megadott id hibás, akkor FALSE a visszatérési érték
		$aProduct = $oProductDao->getProduct($iIdProduct);
		if (empty($aProduct)) return FALSE;

		$oCategoryModule = ModuleFactory::getModule('category');
		return $oCategoryModule->isOwner($aProduct['id_category']);
	}

	/**
	 * Rendereli a felvitel oldalt.
	 *
	 * @return string   A generált oldal tartalma
	 */
	protected function _reqAdd() {
		$oUserauth =& ModuleFactory::getModule('userauth');
		$aUserInfo = $oUserauth->getUser();
		$oCategoryDao =& DaoFactory::getDao('category');

		$oShopDao =& DaoFactory::getDao('shop');

		$oUserauth =& ModuleFactory::getModule('userauth');
		$aUserInfo = $oUserauth->getUser();

		// PHP 5.3 miatt... Eredetileg $oCategoryDao->getCategoryList($aUserInfo['id_shop'], 'en')['list'] van a rendernel
		$aCategoryList = $oCategoryDao->getCategoryList($aUserInfo['id_shop'], 'en');
		$aCategoryList = $aCategoryList['list'];

		return Output::render('product_add', getLayoutVars() + array(
			'categorylist' => $aCategoryList,
			'languagelist' => $oShopDao->getLanguageList($aUserInfo['id_shop']),
		));
	}

	/**
	 * Egy termékhez tartozó szöveges tartalmak lekérdezése
	 */	 	
	private function _getText($iIdProduct) {
		$oProductDao =& DaoFactory::getDao('product');
		$aProduct = $oProductDao->getProductFull($iIdProduct);

		$oShopDao =& DaoFactory::getDao('shop');
		$aLanguageList = $oShopDao->getLanguageList($aProduct['id_shop']);

		// Szöveges tartalmak lekérdezése
		foreach ($aLanguageList as $aLanguage) {
			$aText[$aLanguage['id_language']] = $oProductDao->getText($iIdProduct, $aLanguage['id_language']);
		}
		
		return $aText;
	}

	/**
	 * Rendereli a szerkesztés oldalt
	 *
	 * @param  int      $iIdProduct
	 *
	 * @return string   A generált oldal tartalma
	 */
	protected function _reqEdit($iIdProduct) {
		if (!isset($iIdProduct)) showErrorPage(404);
		if (!$this->isOwner($iIdProduct)) showErrorPage(403);

		$oShopDao           =& DaoFactory::getDao('shop');
		$oProductDao        =& DaoFactory::getDao('product');
		$oCategoryDao       =& DaoFactory::getDao('category');
		$oShippingMethodDao =& DaoFactory::getDao('shipping_method');
		$oPaymentMethodDao  =& DaoFactory::getDao('payment_method');

		$aProduct = $oProductDao->getProductFull($iIdProduct);

		$aLanguageList = $oShopDao->getLanguageList($aProduct['id_shop']);

		$aText = $this->_getText($iIdProduct);

		$oUserauth =& ModuleFactory::getModule('userauth');
		$aUserInfo = $oUserauth->getUser();

		// PHP 5.3 miatt... Eredetileg $oCategoryDao->getCategoryList($aUserInfo['id_shop'], 'en')['list'] van a rendernel
		$aCategoryList = $oCategoryDao->getCategoryList($aUserInfo['id_shop'], 'en');
		$aCategoryList = $aCategoryList['list'];

		return Output::render('product_edit', getLayoutVars() + array(
			'info'                 => $aProduct,
			'id_shop'              => $aProduct['id_shop'],
			'categorylist'         => $aCategoryList,
			'languagelist'         => $aLanguageList,
			'text'                 => $aText,
			'shipping_method_list' => $oShippingMethodDao->getMethodList($iIdProduct),
			'payment_method_list'  => $oPaymentMethodDao->getMethodList($iIdProduct),
		));
	}

	/**
	 * Rendereli a "termékek listája" boxot
	 *
	 * @return string   A generált oldal tartalma
	 */
	protected function _reqList($sLanguageIso) {
		$aVars = Request::getRequestVars();

		$oUserauth =& ModuleFactory::getModule('userauth');
		$aUserInfo = $oUserauth->getUser();

		$oProductDao =& DaoFactory::getDao('product');
		$aProductList = $oProductDao->getProductList($aUserInfo['id_shop'], $sLanguageIso, $aVars['order'], $aVars['filter'], $aVars['limit'], $aVars['page']);

		$oCategoryDao =& DaoFactory::getDao('category');
		$oSupplierDao =& DaoFactory::getDao('supplier');

		return Output::json($aProductList + array(
			'distinct' => array(
				'category_name' => $oCategoryDao->getDistinctCategory($aUserInfo['id_shop'], $sLanguageIso),
				'supplier_name' => $oSupplierDao->getDistinctSupplier($aUserInfo['id_shop']),
			),
		));
/*
		return Output::render('product_list', getLayoutVars() + array(
			'language_iso' => $sLanguageIso,
			'list' => $aProductList,
		));
*/
	}

	/**
	 * Rendereli a törlés oldalt
	 *
	 * @param  int      $iIdProduct
	 *
	 * @return string   A generált oldal tartalma
	 */
	protected function _reqDelete($iIdProduct, $sLanguageIso) {
		if (!isset($iIdProduct)) showErrorPage(404);
		if (!$this->isOwner($iIdProduct)) showErrorPage(403);

		$oProductDao =& DaoFactory::getDao('product');

		return Output::render('product_delete', getLayoutVars() + array(
			'info' => $oProductDao->getProductFull($iIdProduct, $sLanguageIso)
		));
	}

	/**
	 * Rendereli a szerkesztés oldalon a tulajdonságok listáját
	 *
	 * Lekérdezi egy kategóriához tartozó tulajdonságok listáját és a tulajdonsághoz tartozó értékeket
	 *
	 * A templatenek átadott $aPropertyList változó felépítése:
	 *   array(
	 *     [0] = array(
	 *       'name' => 'Szín'
	 *       'valuelist' => array (
	 *         array('name' => 'Fekete', 'ischecked' => 'TRUE'),
	 *         array('name' => 'Fehér', 'ischecked' => 'TRUE'),
	 *         array('name' => 'Piros', 'ischecked' => 'TRUE')
	 *       )
	 *     ),
	 *     [1] = array (
	 *       'name' => 'Nem'
	 *       'valuelist' => array (
	 *         array('name' => 'Női', 'ischecked' => 'TRUE'),
	 *         array('name' => 'Férfi', 'ischecked' => 'FALSE')
	 *       )
	 *     )
	 *  )
	 *
	 * @param  int      $iIdCategory
	 * @param  int      $iIdProduct      (opcionális) Ha meg van adva, akkor jelöli azokat az
	 *                                   elemeket amik a termékhez vannak linkelve
	 *
	 * @return string   A generált oldal tartalma
	 */
	protected function _reqEditProperty($iIdCategory, $iIdProduct, $sLanguageIso) {
		if (!isset($iIdCategory)) showErrorPage(404);
		$oCategoryModule = ModuleFactory::getModule('category');
		if (!$oCategoryModule->isOwner($iIdCategory)) showErrorPage(403);
		if (!empty($iIdProduct) && !$this->isOwner($iIdProduct)) showErrorPage(403);

		$oPropertyDao =& DaoFactory::getDao('property');
		$oProductDao =& DaoFactory::getDao('product');

		// Ha meg van adva product azonosító, akkor le kell kérdezni a termék propertyvalue listáját
		if ($iIdProduct) $aLinkedValueList = $oProductDao->getLinkedPropertyValueList($iIdProduct, $sLanguageIso);

		$aPropertyList = $oPropertyDao->getPropertyList($iIdCategory, $sLanguageIso);
		if (!empty($aPropertyList)) {
			foreach ($aPropertyList as &$aProperty) {
				$aProperty['valuelist'] = $oPropertyDao->getPropertyValueList($aProperty['id_property'], $sLanguageIso);

				if ($aProperty['valuelist']) {
					foreach ($aProperty['valuelist'] as &$aValue) {
						$aValue['ischecked'] = FALSE;
						if (!empty($iIdProduct) && !empty($aLinkedValueList)) {
							foreach ($aLinkedValueList as $aLinkedValue) {
								if ($aLinkedValue['id_value'] == $aValue['id_value']) $aValue['ischecked'] = TRUE;
							}
						}
					}
				}
			}
		}

		return Output::render('product_edit_property', getLayoutVars() + array(
			'language_iso' => $sLanguageIso,
			'propertylist' => $aPropertyList
		));
	}

	/**
	 * A termékkel kapcsolatos webszolgáltatások
	 *   GET    /product                Rendereli a termék admin index oldalát
	 *   PUT    /product                Létrehoz egy terméket
	 *   PUT    /product/{id_product}   Módosítja a termék adatait
	 *   DELETE /product/{id_product}   Törli a terméket
	 *
	 * @param  int $iIdProduct          Opcionális: A termék azonosítója
	 *
	 * @return string|json              GET esetén a generált oldal tartalma
	 *                                  PUT / POST / DELETE esetén a feldolgozás közben bekövetkező hibák
	 */
	protected function _reqDefault($iIdProduct=0) {
		$aVars = Request::getRequestVars();
		if (empty($iIdProduct)) {
			switch (Request::getRequestMethod()) {
				case 'GET':
					$oUserauth =& ModuleFactory::getModule('userauth');
					$aUserInfo = $oUserauth->getUser();
					$oShopDao =& DaoFactory::getDao('shop');
					return Output::render('product', getLayoutVars() + array(
						'languagelist' => $oShopDao->getLanguageList($aUserInfo['id_shop']),
					));
					break;
				case 'PUT':
					$aRequiredVars = array(
						'id_category', 'price', 'is_featured', 'is_sale'
					);
					if (array_keys_exists($aRequiredVars, $aVars)) return $this->_wsAdd($aVars);
					break;
			}
		} else {
			if (!$this->isOwner($iIdProduct)) showErrorPage(403);
			switch (Request::getRequestMethod()) {
				case 'PUT':
					$aRequiredVars = array(
						'id_category', 'price', 'is_featured', 'is_sale'
					);
					if (array_keys_exists($aRequiredVars, $aVars)) return $this->_wsEdit($iIdProduct, $aVars);
					break;
				case 'DELETE':
					return $this->_wsDelete($iIdProduct, $aVars);
					break;
			}
		}
	}

	/**
	 * Webszolgáltatás: termék létrehozása
	 *
	 * @param  array    $aVars  A formból beérkező változók:
	 *                          id_category, permalink, name, short_description, long_description,
	 *                          price, is_featured, is_sale, barcode, quantity
	 *                          id_value: a termékhez rendelt tulajdonság-értékek listája (opcionális, array)
	 *
	 * @return json     A feldolgozás közben bekövetkező hibák
	 */
	private function _wsAdd($aVars) {
		// Változó(k)hoz való jogosultság ellenőrzése
		$oCategoryModule = ModuleFactory::getModule('category');
		if (!$oCategoryModule->isOwner($aVars['id_category'])) showErrorPage(403);

		//$aVars = cleanValues($aVars);
		$aRes['error'] = array();

		$oProductDao =& DaoFactory::getDao('product');

		$oCategoryDao =& DaoFactory::getDao('category');
		$oShopDao =& DaoFactory::getDao('shop');

		$aCategoryInfo = $oCategoryDao->getCategory($aVars['id_category']);
		$aLanguageList = $oShopDao->getLanguageList($aCategoryInfo['id_shop']);

		// Kötelezően kitöltendő mezők ellenőrzése, visszatérés a hibakóddal
		if (empty($aVars['id_category'])) $aRes['error'][] = 'empty_category';
		foreach ($aLanguageList as $aLanguage) {
			if (empty($aVars[$aLanguage['iso'].'_permalink'])) $aRes['error'][] = 'empty_permalink|'.$aLanguage['iso'];
			if (empty($aVars[$aLanguage['iso'].'_name'])) $aRes['error'][] = 'empty_name|'.$aLanguage['iso'];
		}
		// Mezők érvényességének ellenőrzése
		if (!empty($aVars['price']) && !is_numeric($aVars['price'])) $aRes['error'][] = 'invalid_price';

		// Unique mezők ellenőrzése, visszatérés a hibakóddal
		foreach ($aLanguageList as $aLanguage) {
			if (!empty($aVars[$aLanguage['iso'].'_permalink'])) { 
				$aProduct = $oProductDao->getProductByPermalink($aVars['id_category'], $aLanguage['id_language'], $aVars[$aLanguage['iso'].'_permalink']);
				if (!empty($aProduct) && $aProduct['id_product'] != $iIdProduct) $aRes['error'][] = 'already_permalink_in_category|'.$aLanguage['iso'];
			}
		}

		// Hiba esetén visszatérés a hibakóddal
		if (!empty($aRes['error'])) return Output::json($aRes);

		// Nyelvtől független adatok rögzítése
		$aRes['id_product'] = $oProductDao->insertProduct($aVars['id_category'], $aVars['is_featured'], $aVars['is_sale'], $aVars['price'], $aVars['barcode'], $aVars['quantity']);

		// Szöveges adatok rögzítése minden nyelven
		foreach ($aLanguageList as $aLanguage) {
			$oProductDao->replaceText($aRes['id_product'], $aLanguage['id_language'], $aVars[$aLanguage['iso'].'_permalink'], $aVars[$aLanguage['iso'].'_name'], $aVars[$aLanguage['iso'].'_short_description'], $aVars[$aLanguage['iso'].'_long_description']);
		}

		return Output::json($aRes);
	}

	/**
	 * Webszolgáltatás: termék szerkesztése
	 *
	 * @param  int      $iIdProduct  A termék azonosítója
	 * @param  array    $aVars       A formból beérkező változók:
	 *                               id_category, permalink, name, short_description, long_description,
	 *                               price, is_featured, is_sale, barcode, quantity
	 *                               id_value: a termékhez rendelt tulajdonság-értékek listája (opcionális, array)
	 *
	 * @return json     A feldolgozás közben bekövetkező hibák
	 */
	private function _wsEdit($iIdProduct, $aVars) {
		// Változó(k)hoz való jogosultság ellenőrzése
		$oCategoryModule = ModuleFactory::getModule('category');
		if (!$oCategoryModule->isOwner($aVars['id_category'])) showErrorPage(403);

		//$aVars = cleanValues($aVars);
		$aRes['error'] = array();

		$oProductDao =& DaoFactory::getDao('product');
		$oCategoryDao =& DaoFactory::getDao('category');
		$oShopDao =& DaoFactory::getDao('shop');
		
		$aCategoryInfo = $oCategoryDao->getCategory($aVars['id_category']);
		$aLanguageList = $oShopDao->getLanguageList($aCategoryInfo['id_shop']);
		
		// Kötelezően kitöltendő mezők ellenőrzése, visszatérés a hibakóddal
		if (empty($aVars['id_category'])) $aRes['error'][] = 'empty_category';
		foreach ($aLanguageList as $aLanguage) {
			if (empty($aVars[$aLanguage['iso'].'_permalink'])) $aRes['error'][] = 'empty_permalink|'.$aLanguage['iso'];
			if (empty($aVars[$aLanguage['iso'].'_name'])) $aRes['error'][] = 'empty_name|'.$aLanguage['iso'];
		}
		// Mezők érvényességének ellenőrzése
		if (!empty($aVars['price']) && !is_numeric($aVars['price'])) $aRes['error'][] = 'invalid_price';

		// Unique mezők ellenőrzése, visszatérés a hibakóddal
		foreach ($aLanguageList as $aLanguage) {
			if (!empty($aVars[$aLanguage['iso'].'_permalink'])) { 
				$aProduct = $oProductDao->getProductByPermalink($aVars['id_category'], $aLanguage['id_language'], $aVars[$aLanguage['iso'].'_permalink']);
				if (!empty($aProduct) && $aProduct['id_product'] != $iIdProduct) $aRes['error'][] = 'already_permalink_in_category|'.$aLanguage['iso'];
			}
		}

		// Hiba esetén visszatérés a hibakóddal
		if (!empty($aRes['error'])) return Output::json($aRes);

		// Nyelvtől független adatok rögzítése
		$oProductDao->updateProduct($iIdProduct, $aVars['id_category'], $aVars['is_featured'], $aVars['is_sale'], $aVars['price'], $aVars['barcode'], $aVars['product_code'], $aVars['quantity'], $aVars['id_supplier'], $aVars['is_active']);
		// Szöveges adatok rögzítése minden nyelven
		foreach ($aLanguageList as $aLanguage) {
			$oProductDao->replaceText($iIdProduct, $aLanguage['id_language'], $aVars[$aLanguage['iso'].'_permalink'], $aVars[$aLanguage['iso'].'_name'], $aVars[$aLanguage['iso'].'_short_description'], $aVars[$aLanguage['iso'].'_long_description']);
		}

		// Jellemzők rögzítése
		$oProductDao->unlinkPropertyValues($iIdProduct);
		if (isset($aVars['id_value'])) $oProductDao->linkPropertyValueList($iIdProduct, $aVars['id_value']);

		$oPaymentMethodDao  =& DaoFactory::getDao('payment_method');
		// Fizetési metódusok rögzítése
		$oProductDao->unlinkPaymentMethods($iIdProduct);
		$aPaymentMethodList = $oPaymentMethodDao->getMethodList();
		foreach ($aPaymentMethodList as $aPaymentMethod) {
			if (isset($aVars['payment_'.$aPaymentMethod['id_payment_method']])) $oProductDao->linkPaymentMethod($iIdProduct, $aPaymentMethod['id_payment_method'], $aVars['payment_'.$aPaymentMethod['id_payment_method']]);
		}
		
		$oShippingMethodDao =& DaoFactory::getDao('shipping_method');
		// Szállítási metódusok rögzítése
		$oProductDao->unlinkShippingMethods($iIdProduct);
		$aShippingMethodList = $oShippingMethodDao->getMethodList();
		foreach ($aShippingMethodList as $aShippingMethod) {
			if (isset($aVars['shipping_'.$aShippingMethod['id_shipping_method']])) $oProductDao->linkShippingMethod($iIdProduct, $aShippingMethod['id_shipping_method'], $aVars['shipping_'.$aShippingMethod['id_shipping_method']]);
		}

		return Output::json($aRes);
	}

	/**
	 * Webszolgáltatás: termék törlése
	 *
	 * @param  int      $iIdProduct  A termék azonosítója
	 *
	 * @return json     Üres error tömb (nincs hibalehetőség)
	 */
	private function _wsDelete($iIdProduct) {
		$aRes['error'] = array();

		$oProductDao =& DaoFactory::getDao('product');
		$oPhotoDao =& DaoFactory::getDao('product_photo');
		$oPhoto =& ModuleFactory::getModule('product_photo');

		// Termék képeinek törlése
		$aPhotoList = $oPhotoDao->getPhotoListByIdProduct($iIdProduct);
		if ($aPhotoList) $oPhoto->unlinkPhotoList($aPhotoList);

		// Termék törlése
		$oProductDao->deleteProduct($iIdProduct);
		return Output::json($aRes);
	}
}
?>