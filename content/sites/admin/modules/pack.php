<?php
class PackModule extends Module {
	protected function _access($sMethodName) {
		$oUserauth =& ModuleFactory::getModule('userauth');
		return $oUserauth->access('stock_admin');
	}

	public function path() {
		return array(
			'pack' => array(
				'method'      => 'default',
			),
			'pack/add' => array(
				'method'      => 'add',
			),
			'pack/edit' => array(
				'method'      => 'edit',
			),
			'pack/list' => array(
				'method'      => 'list',
			),
			'pack/delete' => array(
				'method'      => 'delete',
			),
			'pack/product' => array(
				'method'      => 'product',
			),
		);
	}

	/**
	 * Megvizsgálja a bejelentkezett felhasználó hozzáférését
	 * a paraméterben megadott termékhez.
	 * Ha a felhasználó boltjának egy kategóriájához tartozik a termék, akkor TRUE.
	 *
	 * @param  integer  $iIdPack    A csomag azonosítója
	 *
	 * @return bool     TRUE ha van hozzá joga, FALSE ha nincs
	 */
	public function isOwner($iIdPack) {
		$oUserauth =& ModuleFactory::getModule('userauth');
		if ($oUserauth->access('root')) return TRUE;

		$oPackDao =& DaoFactory::getDao('pack');
		// Ha a megadott id hibás, akkor FALSE a visszatérési érték
		$aPack = $oPackDao->getPack($iIdPack);
		if (empty($aPack)) return FALSE;

		$oCategoryModule = ModuleFactory::getModule('category');
		return $oCategoryModule->isOwner($aPack['id_category']);
	}

	/**
	 * Rendereli a felvitel oldalt.
	 *
	 * @return string   A generált oldal tartalma
	 */
	protected function _reqAdd() {
		$oUserauth =& ModuleFactory::getModule('userauth');
		$aUserInfo = $oUserauth->getUser();

		$oShopDao =& DaoFactory::getDao('shop');
		$oCategoryDao =& DaoFactory::getDao('category');

		$oUserauth =& ModuleFactory::getModule('userauth');
		$aUserInfo = $oUserauth->getUser();

		return Output::render('pack_add', getLayoutVars() + array(
			'categorylist' => $oCategoryDao->getCategoryList($aUserInfo['id_shop'], 'en')['list'],
			'languagelist' => $oShopDao->getLanguageList($aUserInfo['id_shop']),
		));
	}

	/**
	 * Egy csomaghoz tartozó szöveges tartalmak lekérdezése
	 */	 	
	private function _getText($iIdPack) {
		$oPackDao =& DaoFactory::getDao('pack');
		$aPack = $oPackDao->getPack($iIdPack);

		$oShopDao =& DaoFactory::getDao('shop');
		$aLanguageList = $oShopDao->getLanguageList($aPack['id_shop']);

		// Szöveges tartalmak lekérdezése
		foreach ($aLanguageList as $aLanguage) {
			$aText[$aLanguage['id_language']] = $oPackDao->getText($iIdPack, $aLanguage['id_language']);
		}
		
		return $aText;
	}

	/**
	 * Rendereli a szerkesztés oldalt
	 *
	 * @param  int      $iIdPack
	 *
	 * @return string   A generált oldal tartalma
	 */
	protected function _reqEdit($iIdPack) {
		if (!isset($iIdPack)) showErrorPage(404);
		if (!$this->isOwner($iIdPack)) showErrorPage(403);

		$oShopDao     =& DaoFactory::getDao('shop');
		$oCategoryDao =& DaoFactory::getDao('category');
		$oPackDao     =& DaoFactory::getDao('pack');

		$aPack = $oPackDao->getPack($iIdPack);
		$aLanguageList = $oShopDao->getLanguageList($aPack['id_shop']);
		$aText = $this->_getText($iIdPack);

		$oUserauth =& ModuleFactory::getModule('userauth');
		$aUserInfo = $oUserauth->getUser();

		return Output::render('pack_edit', getLayoutVars() + array(
			'info'         => $aPack,
			'id_shop'      => $aPack['id_shop'],
			'categorylist' => $oCategoryDao->getCategoryList($aUserInfo['id_shop'], 'en')['list'],
			'languagelist' => $aLanguageList,
			'text'         => $aText,
		));
	}

	/**
	 * Visszaadja a csomagok listáját
	 *
	 * @return string   A generált oldal tartalma
	 */
	protected function _reqList($sLanguageIso) {
		$oUserauth =& ModuleFactory::getModule('userauth');
		$aUserInfo = $oUserauth->getUser();

		$oPackDao =& DaoFactory::getDao('pack');
		$aPackList = $oPackDao->getPackList($aUserInfo['id_shop'], $sLanguageIso);

		return Output::json($aPackList);
	}

	/**
	 * Rendereli a törlés oldalt
	 *
	 * @param  int      $iIdPack
	 * @param  string   $sLanguageIso
	 *
	 * @return string   A generált oldal tartalma
	 */
	protected function _reqDelete($iIdPack, $sLanguageIso) {
		if (!isset($iIdPack)) showErrorPage(404);
		if (!$this->isOwner($iIdPack)) showErrorPage(403);

		$oPackDao =& DaoFactory::getDao('pack');

		return Output::render('pack_delete', getLayoutVars() + array(
			'info' => $oPackDao->getPackFull($iIdPack, $sLanguageIso)
		));
	}

	/**
	 * A csomaggal kapcsolatos webszolgáltatások
	 *   GET    /pack                   Rendereli a csomag admin főoldalát
	 *   PUT    /pack                   Létrehoz egy csomagot
	 *   PUT    /pack/{id_pack}         Módosítja a csomag adatait
	 *   DELETE /pack/{id_pack}         Törli a csomagot
	 *
	 * @param  int $iIdPack             Opcionális: A csomag azonosítója
	 *
	 * @return string|json              GET esetén a generált oldal tartalma
	 *                                  PUT / POST / DELETE esetén a feldolgozás közben bekövetkező hibák
	 */
	protected function _reqDefault($iIdPack=0) {
		$aVars = Request::getRequestVars();
		if (empty($iIdPack)) {
			switch (Request::getRequestMethod()) {
				case 'GET':
					$oUserauth =& ModuleFactory::getModule('userauth');
					$aUserInfo = $oUserauth->getUser();
					$oShopDao =& DaoFactory::getDao('shop');
					return Output::render('pack', getLayoutVars() + array(
						'languagelist' => $oShopDao->getLanguageList($aUserInfo['id_shop']),
					));
					break;
				case 'PUT':
					$aRequiredVars = array(
						'id_category', 'price'
					);
					if (array_keys_exists($aRequiredVars, $aVars)) return $this->_wsAdd($aVars);
					break;
			}
		} else {
			if (!$this->isOwner($iIdPack)) showErrorPage(403);
			switch (Request::getRequestMethod()) {
				case 'PUT':
					$aRequiredVars = array(
						'price'
					);
					if (array_keys_exists($aRequiredVars, $aVars)) return $this->_wsEdit($iIdPack, $aVars);
					break;
				case 'DELETE':
					return $this->_wsDelete($iIdPack, $aVars);
					break;
			}
		}
	}

	/**
	 * A csomagon belüli termékekkel kapcsolatos webszolgáltatások
	 *   GET    /pack/product/{id_pack}/{language_iso}   A csomag termékeinek listája
	 *   POST   /pack/product/{id_pack}                  Egy csomagban szereplo termek mennyiseget noveli (id_product, quantity)
	 *   PUT    /pack/product/{id_pack}                  Egy csomagban szereplo termek mennyiseget allitja be meghatarozott ertekre (id_product, quantity)
	 *
	 * @param  int $iIdPack               A csomag azonosítója
	 *
	 * @return string|json                GET esetén a generált oldal tartalma
	 *                                    PUT / POST / DELETE esetén a feldolgozás közben bekövetkező hibák
	 */
	protected function _reqProduct($iIdPack, $sLanguageIso='') {
		if (empty($iIdPack)) return;

		$aVars = Request::getRequestVars();

		switch (Request::getRequestMethod()) {
			case 'GET':
				$oPackDao =& DaoFactory::getDao('pack');
				$aProductList = $oPackDao->getLinkedProductList($iIdPack, $sLanguageIso);
				return Output::json($aProductList);
				break;
			case 'POST':
				$aRequiredVars = array(
					'id_product', 'quantity'
				);
				if (array_keys_exists($aRequiredVars, $aVars)) return $this->_wsProductAdd($iIdPack, $aVars);
				break;
			case 'PUT':
				$aRequiredVars = array(
					'id_product', 'quantity'
				);
				if (array_keys_exists($aRequiredVars, $aVars)) return $this->_wsProductSet($iIdPack, $aVars);
				break;
		}
	}

	/**
	 * Webszolgáltatás: csomag létrehozása
	 *
	 * @param  array    $aVars  A formból beérkező változók:
	 *                          id_shop, price, {language_iso}_permalink, {language_iso}_name
	 *
	 * @return json     A feldolgozás közben bekövetkező hibák
	 */
	private function _wsAdd($aVars) {
		// Változó(k)hoz való jogosultság ellenőrzése
		$oCategoryModule = ModuleFactory::getModule('category');
		if (!$oCategoryModule->isOwner($aVars['id_category'])) showErrorPage(403);

		$aVars = cleanValues($aVars);
		$aRes['error'] = array();

		$oPackDao =& DaoFactory::getDao('pack');
		$oShopDao =& DaoFactory::getDao('shop');

		$oUserauth =& ModuleFactory::getModule('userauth');
		$aUserInfo = $oUserauth->getUser();
		$aLanguageList = $oShopDao->getLanguageList($aUserInfo['id_shop']);

		// Kötelezően kitöltendő mezők ellenőrzése, visszatérés a hibakóddal
		foreach ($aLanguageList as $aLanguage) {
			if (empty($aVars[$aLanguage['iso'].'_permalink'])) $aRes['error'][] = 'empty_permalink|'.$aLanguage['iso'];
			if (empty($aVars[$aLanguage['iso'].'_name'])) $aRes['error'][] = 'empty_name|'.$aLanguage['iso'];
		}
		// Mezők érvényességének ellenőrzése
		if (!empty($aVars['price']) && !is_numeric($aVars['price'])) $aRes['error'][] = 'invalid_price';

		// Unique mezők ellenőrzése, visszatérés a hibakóddal
		foreach ($aLanguageList as $aLanguage) {
			if (!empty($aVars[$aLanguage['iso'].'_permalink'])) { 
				$aPack = $oPackDao->getPackByPermalink($aVars['id_shop'], $aVars[$aLanguage['iso'].'_permalink']);
				if (!empty($aPack) && $aPack['id_pack'] != $iIdPack) $aRes['error'][] = 'already_permalink|'.$aLanguage['iso'];
			}
		}

		// Hiba esetén visszatérés a hibakóddal
		if (!empty($aRes['error'])) return Output::json($aRes);

		// Nyelvtől független adatok rögzítése
		$aRes['id_pack'] = $oPackDao->insertPack($aVars['id_category'], $aVars['price']);

		// Szöveges adatok rögzítése minden nyelven
		foreach ($aLanguageList as $aLanguage) {
			$oPackDao->replaceText($aRes['id_pack'], $aLanguage['id_language'], $aVars[$aLanguage['iso'].'_permalink'], $aVars[$aLanguage['iso'].'_name'], $aVars[$aLanguage['iso'].'_short_description'], $aVars[$aLanguage['iso'].'_long_description']);
		}

		return Output::json($aRes);
	}

	/**
	 * Webszolgáltatás: csomag szerkesztése
	 *
	 * @param  int      $iIdPack     A csomag azonosítója
	 * @param  array    $aVars       A formból beérkező változók:
	 *                               id_pack, price, {language_iso}_permalink, {language_iso}_name
	 *
	 * @return json     A feldolgozás közben bekövetkező hibák
	 */
	private function _wsEdit($iIdPack, $aVars) {
		$aRes['error'] = array();

		// Változó(k)hoz való jogosultság ellenőrzése
		$oCategoryModule = ModuleFactory::getModule('category');
		if (!$this->isOwner($iIdPack)) showErrorPage(403);

		$oPackDao =& DaoFactory::getDao('pack');
		$oShopDao =& DaoFactory::getDao('shop');
		
		$aPackInfo = $oPackDao->getPack($iIdPack);
		$aLanguageList = $oShopDao->getLanguageList($aPackInfo['id_shop']);
		
		// Kötelezően kitöltendő mezők ellenőrzése, visszatérés a hibakóddal
		foreach ($aLanguageList as $aLanguage) {
			if (empty($aVars[$aLanguage['iso'].'_permalink'])) $aRes['error'][] = 'empty_permalink|'.$aLanguage['iso'];
			if (empty($aVars[$aLanguage['iso'].'_name'])) $aRes['error'][] = 'empty_name|'.$aLanguage['iso'];
		}
		// Mezők érvényességének ellenőrzése
		if (!empty($aVars['price']) && !is_numeric($aVars['price'])) $aRes['error'][] = 'invalid_price';

		// Unique mezők ellenőrzése, visszatérés a hibakóddal
		foreach ($aLanguageList as $aLanguage) {
			if (!empty($aVars[$aLanguage['iso'].'_permalink'])) { 
				$aPack = $oPackDao->getPackByPermalink($aPackInfo['id_shop'], $aVars[$aLanguage['iso'].'_permalink']);
				if (!empty($aPack) && $aPack['id_pack'] != $iIdPack) $aRes['error'][] = 'already_permalink|'.$aLanguage['iso'];
			}
		}

		// Hiba esetén visszatérés a hibakóddal
		if (!empty($aRes['error'])) return Output::json($aRes);

		// Nyelvtől független adatok rögzítése
		$oPackDao->updatePack($iIdPack, $aVars['id_category'], $aVars['price']);

		// Szöveges adatok rögzítése minden nyelven
		foreach ($aLanguageList as $aLanguage) {
			$oPackDao->replaceText($iIdPack, $aLanguage['id_language'], $aVars[$aLanguage['iso'].'_permalink'], $aVars[$aLanguage['iso'].'_name'], $aVars[$aLanguage['iso'].'_short_description'], $aVars[$aLanguage['iso'].'_long_description']);
		}

		return Output::json($aRes);
	}

	/**
	 * Webszolgáltatás: csomag törlése
	 *
	 * @param  int      $iIdPack  A csomag azonosítója
	 *
	 * @return json     Üres error tömb (nincs hibalehetőség)
	 */
	private function _wsDelete($iIdPack) {
		$aRes['error'] = array();

		$oPackDao =& DaoFactory::getDao('pack');
		//$oPhotoDao =& DaoFactory::getDao('photo');
		//$oPhoto =& ModuleFactory::getModule('photo');

		// Csomag képeinek törlése
//		$aPhotoList = $oPhotoDao->getPhotoListByIdProduct($iIdProduct);
//		if ($aPhotoList) $oPhoto->unlinkPhotoList($aPhotoList);

		// Termék törlése
		$oPackDao->deletePack($iIdPack);
		return Output::json($aRes);
	}

	/**
	 * Webszolgáltatás: Termék mennyiségének növelése egy csomagban
	 *
	 * @param  array    $aVars  A formból beérkező változók:
	 *                          id_product, quantity
	 *
	 * @return json     A feldolgozás közben bekövetkező hibák
	 */
	private function _wsProductAdd($iIdPack, $aVars) {
		// Változó(k)hoz való jogosultság ellenőrzése
		$oShopModule = ModuleFactory::getModule('shop');
		if (!$this->isOwner($iIdPack)) showErrorPage(403);

		$aVars = cleanValues($aVars);
		$aRes['error'] = array();

		$oPackDao =& DaoFactory::getDao('pack');

		// Product infok kiolvasása a csomagból
		$iQuantity = $oPackDao->getProductQuantity($iIdPack, $aVars['id_product']);

		// Beírás az adatbázisba
		$oPackDao->setProductQuantity($iIdPack, $aVars['id_product'], $iQuantity + $aVars['quantity']);

		return Output::json($aRes);
	}

	/**
	 * Webszolgáltatás: Termék mennyiségének beállítása egy csomagban
	 *
	 * @param  array    $aVars  A formból beérkező változók:
	 *                          id_product, quantity
	 *
	 * @return json     A feldolgozás közben bekövetkező hibák
	 */
	private function _wsProductSet($iIdPack, $aVars) {
		// Változó(k)hoz való jogosultság ellenőrzése
		$oShopModule = ModuleFactory::getModule('shop');
		if (!$this->isOwner($iIdPack)) showErrorPage(403);

		$aVars = cleanValues($aVars);
		$aRes['error'] = array();

		$oPackDao =& DaoFactory::getDao('pack');

		// Beírás az adatbázisba
		$oPackDao->setProductQuantity($iIdPack, $aVars['id_product'], $aVars['quantity']);

		return Output::json($aRes);
	}
}
?>