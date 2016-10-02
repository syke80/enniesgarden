<?php
class CategoryModule extends Module {
	protected function _access($sMethodName) {
		$oUserauth =& ModuleFactory::getModule('userauth');

		return $oUserauth->access('stock_admin');
	}

	public function path() {
		return array(
			'category' => array(
				'method'      => 'default',
			),
			'category/add' => array(
				'method'      => 'add',
			),
			'category/edit' => array(
				'method'      => 'edit',
			),
			'category/list' => array(
				'method'      => 'list',
			),
			'category/delete' => array(
				'method'      => 'delete',
			),
			'category/edit/property' => array(
				'method'      => 'editProperty',
			),
		);
	}

	/**
	 * Megvizsgálja a bejelentkezett felhasználó hozzáférését
	 * a paraméterben megadott kategóriához.
	 * Ha a felhasználó boltjához tartozik a kategória, akkor TRUE.
	 *
	 * @param  integer  $iIdCategory  A kategória azonosítója
	 *
	 * @return bool     TRUE ha van hozzá joga, FALSE ha nincs
	 */
	public function isOwner($iIdCategory) {
		$oUserauth =& ModuleFactory::getModule('userauth');
		if ($oUserauth->access('root')) return TRUE;

		$oCategoryDao =& DaoFactory::getDao('category');
		// Ha a megadott id hibás, akkor FALSE a visszatérési érték
		$aCategory = $oCategoryDao->getCategory($iIdCategory);
		if (empty($aCategory)) return FALSE;

		$aLoggedinUser = $oUserauth->getUser();
		return $aCategory['id_shop'] == $aLoggedinUser['id_shop'];
	}

	/**
	 * Egy kategóriához tartozó szöveges tartalmak lekérdezése
	 */	 	
	private function _getText($iIdCategory) {
		$oCategoryDao =& DaoFactory::getDao('category');
		$aCategory = $oCategoryDao->getCategory($iIdCategory);

		$oShopDao =& DaoFactory::getDao('shop');
		$aLanguageList = $oShopDao->getLanguageList($aCategory['id_shop']);

		// Szöveges tartalmak lekérdezése
		foreach ($aLanguageList as $aLanguage) {
			$aText[$aLanguage['id_language']] = $oCategoryDao->getText($iIdCategory, $aLanguage['id_language']);
		}
		
		return $aText;
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
		return Output::render('category_add', getLayoutVars() + array(
			'languagelist' => $oShopDao->getLanguageList($aUserInfo['id_shop']),
		));
	}

	/**
	 * Rendereli a "kategóriák listája" boxot
	 *
	 * @return string   A generált oldal tartalma
	 */
	protected function _reqList($sLanguageIso) {
		$aVars = Request::getRequestVars();

		$oUserauth =& ModuleFactory::getModule('userauth');
		$aUserInfo = $oUserauth->getUser();

		$oCategoryDao =& DaoFactory::getDao('category');

		return Output::json($oCategoryDao->getCategoryList($aUserInfo['id_shop'], $sLanguageIso, $aVars['order'], $aVars['filter'], $aVars['limit'], $aVars['page']));
	}

	/**
	 * Rendereli a szerkesztés oldalt
	 *
	 * @param  int      $iIdCategory
	 *
	 * @return string   A generált oldal tartalma
	 */
	protected function _reqEdit($iIdCategory) {
		if (!isset($iIdCategory)) showErrorPage(404);
		if (!$this->isOwner($iIdCategory)) showErrorPage(403);

		$oShopDao =& DaoFactory::getDao('shop');
		$oCategoryDao =& DaoFactory::getDao('category');

    $aCategory = $oCategoryDao->getCategory($iIdCategory);
		$aLanguageList = $oShopDao->getLanguageList($aCategory['id_shop']);
		$aText = $this->_getText($iIdCategory);

		return Output::render('category_edit', getLayoutVars() + array(
			'info' => $aCategory,
			'languagelist' => $aLanguageList,
			'text' => $aText,
		));
	}

	/**
	 * Rendereli a törlés oldalt
	 *
	 * @param  int      $iIdCategory
	 *
	 * @return string   A generált oldal tartalma
	 */
	protected function _reqDelete($iIdCategory) {
		if (!isset($iIdCategory)) showErrorPage(404);
		if (!$this->isOwner($iIdCategory)) showErrorPage(403);

		$oCategoryDao =& DaoFactory::getDao('category');

		$sLanguageIso = isset($_GET['language']) ? $_GET['language'] : '';
		return Output::render('category_delete', getLayoutVars() + array(
			'info' => $oCategoryDao->getCategory($iIdCategory, $sLanguageIso)
		));
	}

	/**
	 * Property box tartalma
	 * Az $iIdCategory-ban megadott kategóriához tartozó propertyk listája
	 * Az $iIdPropertyEdit-ben megadott property szerkeszthető lesz
	 */
	protected function _reqEditProperty($iIdCategory, $sLanguageIso, $iIdPropertyEdit=0) {
		if (!isset($iIdCategory)) showErrorPage(404);

		$oPropertyDao =& DaoFactory::getDao('property');
		return Output::render('category_edit_property', getLayoutVars() + array(
			'list' => $oPropertyDao->getPropertyList($iIdCategory, $sLanguageIso),
			'language_iso' => $sLanguageIso,
			'id_category' => $iIdCategory,
			'id_property_edit' => $iIdPropertyEdit
		));
	}

	/**
	 * A felhasználóval kapcsolatos webszolgáltatások
	 *   GET    /category                Rendereli a kategória admin index oldalát
	 *   PUT    /category                Létrehoz egy kategóriát
	 *   PUT    /category/{id_category}  Módosítja a kategória adatait
	 *   DELETE /category/{id_category}  Törli a kategóriát
	 *
	 * @param  int $iIdCategory      Opcionális: A kategória azonosítója
	 *
	 * @return string|json           GET esetén a generált oldal tartalma
	 *                               PUT / POST / DELETE esetén a feldolgozás közben bekövetkező hibák
	 */
	protected function _reqDefault($iIdCategory=0) {
		$aVars = Request::getRequestVars();
		if (empty($iIdCategory)) {
			switch (Request::getRequestMethod()) {
				case 'GET':
					$oUserauth =& ModuleFactory::getModule('userauth');
					$aUserInfo = $oUserauth->getUser();
					$oShopDao =& DaoFactory::getDao('shop');
					return Output::render('category', getLayoutVars() + array(
						'languagelist' => $oShopDao->getLanguageList($aUserInfo['id_shop']),
					));
					break;
				case 'PUT':
					$aRequiredVars = array('id_shop');
					if (array_keys_exists($aRequiredVars, $aVars)) return $this->_wsAdd($aVars);
					break;
			}
		} else {
			switch (Request::getRequestMethod()) {
				case 'PUT':
					return $this->_wsEdit($iIdCategory, $aVars);
					break;
				case 'DELETE':
					return $this->_wsDelete($iIdCategory, $aVars);
					break;
			}
		}
	}

	/**
	 * Webszolgáltatás: kategória létrehozása
	 *
	 * @param  array    $aVars  A formból beérkező változók:
	 *                          id_shop, permalink, name
	 *
	 * @return json     A feldolgozás közben bekövetkező hibák
	 */
	private function _wsAdd($aVars) {
		// Változó(k)hoz való jogosultság ellenőrzése
		$oShopModule = ModuleFactory::getModule('shop');
		if (!$oShopModule->isOwner($aVars['id_shop'])) showErrorPage(403);

		$aVars = cleanValues($aVars);
		$aRes['error'] = array();

		$oShopDao =& DaoFactory::getDao('shop');
		$oCategoryDao =& DaoFactory::getDao('category');

		$aLanguageList = $oShopDao->getLanguageList($aVars['id_shop']);

		// Kötelezően kitöltendő mezők ellenőrzése
		foreach ($aLanguageList as $aLanguage) {
			if (empty($aVars[$aLanguage['iso'].'_permalink'])) $aRes['error'][] = 'empty_permalink|'.$aLanguage['iso'];
			if (empty($aVars[$aLanguage['iso'].'_name'])) $aRes['error'][] = 'empty_name|'.$aLanguage['iso'];
		}
		if (!empty($aRes['error'])) return Output::json($aRes);

		// Unique mezők ellenőrzése, visszatérés a hibakóddal
		foreach ($aLanguageList as $aLanguage) {
			if (!empty($aVars[$aLanguage['iso'].'_permalink'])) { 
				if ($oCategoryDao->checkPermalinkExists($aVars['id_shop'], $aVars[$aLanguage['iso'].'_permalink'])) $aRes['error'][] = 'already_permalink|'.$aLanguage['iso'];
			}
		}

		// Hiba esetén visszatérés a hibakóddal
		if (!empty($aRes['error'])) return Output::json($aRes);

		// Nyelvtől független adatok rögzítése
		$aRes['id_category'] = $oCategoryDao->insertCategory($aVars['id_shop']);

		// Szöveges adatok rögzítése minden nyelven
		foreach ($aLanguageList as $aLanguage) {
			$oCategoryDao->replaceText($aRes['id_category'], $aLanguage['id_language'], $aVars[$aLanguage['iso'].'_permalink'], $aVars[$aLanguage['iso'].'_name'], $aVars[$aLanguage['iso'].'_description']);
		}

		return Output::json($aRes);
	}

	/**
	 * Webszolgáltatás: kategória szerkesztése
	 *
	 * @param  int      $iIdCategory  A felhasználó azonosítója
	 * @param  array    $aVars        A formból beérkező változók:
	 *                                permalink, name
	 *
	 * @return json     A feldolgozás közben bekövetkező hibák
	 */
	private function _wsEdit($iIdCategory, $aVars) {
		$aVars = cleanValues($aVars);
		$aRes['error'] = array();

		$oShopDao =& DaoFactory::getDao('shop');
		$oCategoryDao =& DaoFactory::getDao('category');
		$oUserauth =& ModuleFactory::getModule('userauth');
		$aUserInfo = $oUserauth->getUser();

		$aCategory = $oCategoryDao->getCategory($iIdCategory);
		$aLanguageList = $oShopDao->getLanguageList($aCategory['id_shop']);

		// Kötelezően kitöltendő mezők ellenőrzése
		foreach ($aLanguageList as $aLanguage) {
			if (empty($aVars[$aLanguage['iso'].'_permalink'])) $aRes['error'][] = 'empty_permalink|'.$aLanguage['iso'];
			if (empty($aVars[$aLanguage['iso'].'_name'])) $aRes['error'][] = 'empty_name|'.$aLanguage['iso'];
		}
		if (!empty($aRes['error'])) return Output::json($aRes);

		// Unique mezők ellenőrzése, visszatérés a hibakóddal
		foreach ($aLanguageList as $aLanguage) {
			if (!empty($aVars[$aLanguage['iso'].'_permalink'])) { 
				if ($oCategoryDao->checkPermalinkExists($aVars['id_shop'], $aVars[$aLanguage['iso'].'_permalink'], $iIdCategory)) $aRes['error'][] = 'already_permalink|'.$aLanguage['iso'];
			}
		}

		// Szöveges adatok rögzítése minden nyelven
		foreach ($aLanguageList as $aLanguage) {
			$oCategoryDao->replaceText($iIdCategory, $aLanguage['id_language'], $aVars[$aLanguage['iso'].'_permalink'], $aVars[$aLanguage['iso'].'_name'], $aVars[$aLanguage['iso'].'_description']);
		}

		return Output::json($aRes);
	}

	/**
	 * Webszolgáltatás: kategória törlése
	 *
	 * @param  int      $iIdCategory  A kategória azonosítója
	 *
	 * @return json     Üres error tömb (nincs hibalehetőség)
	 */
	private function _wsDelete($iIdCategory) {
		$aRes['error'] = array();

		$oCategoryDao =& DaoFactory::getDao('category');
		$oPhotoDao =& DaoFactory::getDao('product_photo');
		$oPhoto =& ModuleFactory::getModule('product_photo');

		// kapcsolódó termékek képeinek törlése
		$aPhotoList = $oPhotoDao->getPhotoListByIdCategory($iIdCategory);
		if ($aPhotoList) $oPhoto->unlinkPhotoList($aPhotoList);

		$oCategoryDao->deleteCategory($iIdCategory);

		return Output::json($aRes);
	}
}
?>