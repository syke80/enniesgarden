<?php
class ShopModule extends Module {
	protected function _access($sMethodName) {
		$oUserauth =& ModuleFactory::getModule('userauth');
		return $oUserauth->access('root');
	}

	public function path() {
		return array(
			'shop' => array(
				'method'      => 'default',
			),
			'shop/add' => array(
				'method'      => 'add',
			),
			'shop/edit' => array(
				'method'      => 'edit',
			),
			'shop/list' => array(
				'method'      => 'list',
			),
			'shop/delete' => array(
				'method'      => 'delete',
			),
		);
	}

	/**
	 * Megvizsgálja a bejelentkezett felhasználó hozzáférését
	 * a paraméterben megadott shophoz.
	 *
	 * @param  integer  $iIdShop  A shop azonosítója
	 *
	 * @return bool     TRUE ha van hozzá joga, FALSE ha nincs
	 */
	public function isOwner($iIdShop) {
		$oUserauth =& ModuleFactory::getModule('userauth');
		if ($oUserauth->access('root')) return TRUE;

		$aLoggedinUser = $oUserauth->getUser();
		return $iIdShop == $aLoggedinUser['id_shop'];
	}

	/**
	 * Rendereli a felvitel oldalt.
	 *
	 * @return string   A generált oldal tartalma
	 */
	protected function _reqAdd() {
		$oLanguageDao =& DaoFactory::getDao('language');
		return Output::render('shop_add', getLayoutVars() + array(
			'languagelist' => $oLanguageDao->getLanguageList(),
		));
	}

	/**
	 * Rendereli a "boltok listája" boxot
	 *
	 * @return string   A generált oldal tartalma
	 */
	protected function _reqList() {
		$oShopDao =& DaoFactory::getDao('shop');

		return Output::render('shop_list', getLayoutVars() + array(
			'list' => $oShopDao->getShopList()
		));
	}

	/**
	 * Rendereli a szerkesztés oldalt
	 *
	 * @param  int      $iIdShop
	 *
	 * @return string   A generált oldal tartalma
	 */
	protected function _reqEdit($iIdShop) {
		if (!isset($iIdShop)) showErrorPage(404);
		if (!$this->isOwner($aVars['id_shop'])) showErrorPage(403);

		$oShopDao =& DaoFactory::getDao('shop');
		$oLanguageDao =& DaoFactory::getDao('language');
		$oShippingMethodDao =& DaoFactory::getDao('shipping_method');
		$oPaymentMethodDao  =& DaoFactory::getDao('payment_method');

		// Összes elérhető nyelv lekérdezése. Ha a nyelv kapcsolódik a shophoz, akkor a tömbben a checked elem értéke TRUE lesz. 
		$aLanguageList = $oLanguageDao->getLanguageList();
		$aSelectedLanguageList = $oShopDao->getLanguageList($iIdShop);
		foreach ($aLanguageList as &$aLanguage) {
			$aLanguage['checked'] = FALSE;
			foreach ($aSelectedLanguageList as $aSelectedLanguage) {
				if ($aLanguage['id_language'] == $aSelectedLanguage['id_language']) $aLanguage['checked'] = TRUE;
			}
		}

		return Output::render('shop_edit', getLayoutVars() + array(
			'languagelist'         => $aLanguageList,
			'info'                 => $oShopDao->getShop($iIdShop),
			'shipping_method_list' => $oShippingMethodDao->getMethodList($iIdShop),
			'payment_method_list'  => $oPaymentMethodDao->getMethodList($iIdShop),
		));
	}

	/**
	 * Rendereli a törlés oldalt
	 *
	 * @param  int      $iIdShop
	 *
	 * @return string   A generált oldal tartalma
	 */
	protected function _reqDelete($iIdShop) {
		if (!isset($iIdShop)) showErrorPage(404);
		if (!$this->isOwner($aVars['id_shop'])) showErrorPage(403);

		$oShopDao =& DaoFactory::getDao('shop');

		return Output::render('shop_delete', getLayoutVars() + array(
			'info' => $oShopDao->getShop($iIdShop)
		));
	}

	/**
	 * A bolttal kapcsolatos webszolgáltatások
	 *   GET    /shop                Rendereli a bolt admin index oldalát
	 *   PUT    /shop                Létrehoz egy boltot
	 *   PUT    /shop/{id_shop}      Módosítja a bolt adatait
	 *   DELETE /shop/{id_shop}      Törli a boltot
	 *
	 * @param  int $iIdShop          Opcionális: A bolt azonosítója
	 *
	 * @return string|json           GET esetén a generált oldal tartalma
	 *                               PUT / POST / DELETE esetén a feldolgozás közben bekövetkező hibák
	 */
	protected function _reqDefault($iIdShop=0) {
		$aVars = Request::getRequestVars();
		if (empty($iIdShop)) {
			switch (Request::getRequestMethod()) {
				case 'GET': return Output::render('shop', getLayoutVars());
				break;
				case 'PUT':
					$aRequiredVars = array(
						'permalink', 'name',
						'company_name', 'company_email', 'company_phone', 'company_city', 'company_address', 'company_postcode', 'company_country', 'company_description'
					);
					if (array_keys_exists($aRequiredVars, $aVars)) return $this->_wsAdd($aVars);
					break;
			}
		} else {
			if (!$this->isOwner($aVars['id_shop'])) showErrorPage(403);
			switch (Request::getRequestMethod()) {
				case 'PUT':
					$aRequiredVars = array(
						'permalink', 'name',
						'company_name', 'company_email', 'company_phone', 'company_city', 'company_address', 'company_postcode', 'company_country', 'company_description'
					);
					if (array_keys_exists($aRequiredVars, $aVars)) return $this->_wsEdit($iIdShop, $aVars);
					break;
				case 'DELETE':
					return $this->_wsDelete($iIdShop, $aVars);
					break;
			}
		}
	}

	/**
	 * Webszolgáltatás: bolt létrehozása
	 *
	 * @param  array    $aVars  A formból beérkező változók:
	 *                          permalink, name,
	 *                          img_resize_type, img_width, img_height, img_th_width, img_th_height
	 *
	 * @return json     A feldolgozás közben bekövetkező hibák
	 */
	private function _wsAdd($aVars) {
		$aVars = cleanValues($aVars);
		$aRes['error'] = array();

		$oShopDao =& DaoFactory::getDao('shop');

		// Kötelezően kitöltendő mezők ellenőrzése
		if (empty($aVars['permalink'])) $aRes['error'][] = 'empty_permalink';
		if (empty($aVars['name'])) $aRes['error'][] = 'empty_name';
		if (empty($aVars['language'])) $aRes['error'][] = 'empty_language';
/*
		if (
			empty($aVars['company_name']) ||
			empty($aVars['company_email']) ||
			empty($aVars['company_phone']) ||
			empty($aVars['company_city']) ||
			empty($aVars['company_address']) ||
			empty($aVars['company_postcode']) ||
			empty($aVars['company_country'])
		) $aRes['error'][] = 'empty_companydata';
*/
		if (!empty($aRes['error'])) return Output::json($aRes);

		// unique mezők ellenőrzése
		$aShop = $oShopDao->getShopByPermalink($aVars['permalink']);
		if (!empty($aShop)) {
			$aRes['error'][] = 'already_permalink';
			return Output::json($aRes);
		}

		$aRes['id_shop'] = $oShopDao->insertShop(
			$aVars['permalink'], $aVars['name'],
			$aVars['company_name'], $aVars['company_url'], $aVars['company_email'], $aVars['company_phone'],
			$aVars['company_city'], $aVars['company_address'], $aVars['company_postcode'], $aVars['company_country'], $aVars['company_description']
		);

		// Nyelvek beírása
		$oShopDao->deleteLanguages($aRes['id_shop']);
		$oShopDao->insertLanguages($aRes['id_shop'], $aVars['language']);

		return Output::json($aRes);
	}

	/**
	 * Webszolgáltatás: bolt szerkesztése
	 *
	 * @param  int      $iIdShop  A bolt azonosítója
	 * @param  array    $aVars    A formból beérkező változók:
	 *                            permalink, name,
	 *                            img_resize_type, img_width, img_height, img_th_width, img_th_height
	 *
	 * @return json     A feldolgozás közben bekövetkező hibák
	 */
	private function _wsEdit($iIdShop, $aVars) {
		$aVars = cleanValues($aVars);
		$aRes['error'] = array();

		$oShopDao =& DaoFactory::getDao('shop');

		// kötelezően kitöltendő mezők ellenőrzése
		if (empty($aVars['permalink'])) $aRes['error'][] = 'empty_permalink';
		if (empty($aVars['name'])) $aRes['error'][] = 'empty_name';
		if (empty($aVars['language'])) $aRes['error'][] = 'empty_language';
/*
		if (
			empty($aVars['company_name']) ||
			empty($aVars['company_email']) ||
			empty($aVars['company_phone']) ||
			empty($aVars['company_city']) ||
			empty($aVars['company_address']) ||
			empty($aVars['company_postcode']) ||
			empty($aVars['company_country'])
		) $aRes['error'][] = 'empty_companydata';
*/
		if (!empty($aRes['error'])) return Output::json($aRes);

		// unique mezők ellenőrzése
		$aShop = $oShopDao->getShopByPermalink($aVars['permalink']);
		if (!empty($aShop) && $aShop['id_shop'] != $iIdShop) {
			$aRes['error'][] = 'already_permalink';
			return Output::json($aRes);
		}

		// Ha a company_url-ről lemaradt a http://, akkor hozzáírja
		if (!empty($aVars['company_url']) && substr($aVars['company_url'], 0, 4) != 'http') {
			$aVars['company_url'] = "http://{$aVars['company_url']}";
		}

		// Shop adatainak beírása
		$oShopDao->updateShop(
			$iIdShop, $aVars['permalink'], $aVars['name'],
			$aVars['company_name'], $aVars['company_url'], $aVars['company_email'], $aVars['company_phone'],
			$aVars['company_city'], $aVars['company_address'], $aVars['company_postcode'], $aVars['company_country'], $aVars['company_description']
		);

		// Nyelvek beírása
		$oShopDao->deleteLanguages($iIdShop);
		$oShopDao->insertLanguages($iIdShop, $aVars['language']);
		
		// Fizetési metódusok rögzítése
		$oPaymentMethodDao  =& DaoFactory::getDao('payment_method');
		$oShopDao->unlinkPaymentMethods($iIdShop);
		$aPaymentMethodList = $oPaymentMethodDao->getMethodList();
		foreach ($aPaymentMethodList as $aPaymentMethod) {
			if (isset($aVars['payment_'.$aPaymentMethod['id_payment_method']])) $oShopDao->linkPaymentMethod($iIdShop, $aPaymentMethod['id_payment_method'], $aVars['payment_'.$aPaymentMethod['id_payment_method']]);
		}

		// Szállítási metódusok rögzítése
		$oShippingMethodDao =& DaoFactory::getDao('shipping_method');
		$oShopDao->unlinkShippingMethods($iIdShop);
		$aShippingMethodList = $oShippingMethodDao->getMethodList();
		foreach ($aShippingMethodList as $aShippingMethod) {
			if (isset($aVars['shipping_'.$aShippingMethod['id_shipping_method']])) $oShopDao->linkShippingMethod($iIdShop, $aShippingMethod['id_shipping_method'], $aVars['shipping_'.$aShippingMethod['id_shipping_method']]);
		}

		return Output::json($aRes);
	}

	/**
	 * Webszolgáltatás: bolt törlése
	 *
	 * @param  int      $iIdShop  A bolt azonosítója
	 *
	 * @return json     Üres error tömb (nincs hibalehetőség)
	 */
	private function _wsDelete($iIdShop) {
		$aRes['error'] = array();

		$oShopDao =& DaoFactory::getDao('shop');
		$oProductPhotoDao =& DaoFactory::getDao('product_photo');
		$oPackPhotoDao =& DaoFactory::getDao('pack_photo');
		$oProductPhoto =& ModuleFactory::getModule('product_photo');
		$oPackPhoto =& ModuleFactory::getModule('pack_photo');

		// kapcsolódó termékek képeinek törlése
		$aPhotoList = $oProductPhotoDao->getPhotoListByIdShop($iIdShop);
		if ($aPhotoList) $oProductPhoto->unlinkPhotoList($aPhotoList);

		// kapcsolódó termékcsomagok képeinek törlése
		$aPhotoList = $oPackPhotoDao->getPhotoListByIdShop($iIdShop);
		if ($aPhotoList) $oPackPhoto->unlinkPhotoList($aPhotoList);

		$oShopDao->deleteShop($iIdShop);

		return Output::json($aRes);
	}
}
?>