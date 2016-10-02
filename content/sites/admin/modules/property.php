<?php
class PropertyModule extends Module {
	protected function _access($sMethodName) {
		$oUserauth =& ModuleFactory::getModule('userauth');
		return $oUserauth->access('stock_admin');
	}

	public function path() {
		return array(
			'property' => array(
				'method'      => 'default',
			),
			'property/delete' => array(
				'method'      => 'delete',
			),
			'property/value' => array(
				'method'      => 'value',
			),
			'property/value/delete' => array(
				'method'      => 'valueDelete',
			),
		);
	}

	/**
	 * Megvizsgálja a bejelentkezett felhasználó hozzáférését
	 * a paraméterben megadott tulajdonsághoz.
	 * Ha a felhasználó boltjának egy kategóriájához tartozik a tulajdonság, akkor TRUE.
	 *
	 * @param  integer  $iIdProperty  A tulajdonság azonosítója
	 *
	 * @return bool     TRUE ha van hozzá joga, FALSE ha nincs
	 */
	public function isOwner($iIdProperty) {
		$oUserauth =& ModuleFactory::getModule('userauth');
		if ($oUserauth->access('root')) return TRUE;

		$oPropertyDao =& DaoFactory::getDao('property');
		// Ha a megadott id hibás, akkor FALSE a visszatérési érték
		$aProperty = $oPropertyDao->getProperty($iIdProperty);
		if (empty($aProperty)) return FALSE;

		$oCategoryModule = ModuleFactory::getModule('category');
		return $oCategoryModule->isOwner($aProperty['id_category']);
	}

	/**
	 * Megvizsgálja a bejelentkezett felhasználó hozzáférését
	 * a paraméterben megadott tulajdonság-értékhez.
	 * Ha a felhasználó boltjához tartozik a tulajdonság-érték, akkor TRUE.
	 *
	 * @param  integer  $iIdValue  Az érték azonosítója
	 *
	 * @return bool     TRUE ha van hozzá joga, FALSE ha nincs
	 */
	public function isOwnerValue($iIdValue) {
		$oUserauth =& ModuleFactory::getModule('userauth');
		if ($oUserauth->access('root')) return TRUE;

		$oPropertyDao =& DaoFactory::getDao('property');
		// Ha a megadott id hibás, akkor FALSE a visszatérési érték
		$aValue = $oPropertyDao->getValue($iIdValue);
		if (empty($aValue)) return FALSE;

		return $this->isOwner($aValue['id_property']);
	}

	/**
	 * Rendereli a tulajdonság törlése oldalt
	 *
	 * @param  int      $iIdProperty
	 *
	 * @return string   A generált oldal tartalma
	 */
	protected function _reqDelete($iIdProperty) {
		if (!isset($iIdProperty)) showErrorPage(404);
		if (!$this->isOwner($iIdProperty)) showErrorPage(403);

		$oPropertyDao =& DaoFactory::getDao('property');

		return Output::render('property_delete', getLayoutVars() + array(
			'info' => $oPropertyDao->getProperty($iIdProperty)
		));
	}

	/**
	 * Rendereli a tulajdonság-érték törlése oldalt
	 *
	 * @param  int      $iIdValue
	 *
	 * @return string   A generált oldal tartalma
	 */
	protected function _reqValueDelete($iIdValue) {
		if (!isset($iIdValue)) showErrorPage(404);
		if (!$this->isOwnerValue($iIdValue)) showErrorPage(403);

		$oPropertyDao =& DaoFactory::getDao('property');

		return Output::render('property_value_delete', getLayoutVars() + array(
			'info' => $oPropertyDao->getValue($iIdValue)
		));
	}

	/**
	 * A kategóriák tulajdonságaival kapcsolatos webszolgáltatások
	 *   PUT    /property                Létrehoz egy tulajdonságot
	 *   PUT    /property/{id_property}  Módosítja a tulajdonság adatait
	 *   DELETE /property/{id_property}  Törli a tulajdonságot
	 *
	 * @param  int $iIdProperty          Opcionális: A tulajdonság azonosítója
	 *
	 * @return json                      PUT / POST / DELETE esetén a feldolgozás közben bekövetkező hibák
	 */
	protected function _reqDefault($iIdProperty=0) {
		$aVars = Request::getRequestVars();
		if (empty($iIdProperty)) {
			switch (Request::getRequestMethod()) {
				case 'PUT':
					$aRequiredVars = array('id_category', 'language_iso', 'name');
					if (array_keys_exists($aRequiredVars, $aVars)) return $this->_wsAdd($aVars);
					break;
			}
		} else {
			if (!$this->isOwner($iIdProperty)) showErrorPage(403);
			switch (Request::getRequestMethod()) {
				case 'PUT':
					$aRequiredVars = array('language_iso', 'name');
					if (array_keys_exists($aRequiredVars, $aVars)) return $this->_wsEdit($iIdProperty, $aVars);
					break;
				case 'DELETE':
					return $this->_wsDelete($iIdProperty);
					break;
			}
		}
	}

	/**
	 * A tulajdonságok értékeivel kapcsolatos webszolgáltatások
	 *   PUT    /property/value              Létrehoz egy tulajdonságot
	 *   DELETE /property//value/{id_value}  Törli az értéket
	 *
	 * @param  int $iIdValue                 Opcionális: Az érték azonosítója
	 *
	 * @return json                          PUT / POST / DELETE esetén a feldolgozás közben bekövetkező hibák
	 */
	protected function _reqValue($iIdValue=0) {
		$aVars = Request::getRequestVars();
		if (empty($iIdValue)) {
			switch (Request::getRequestMethod()) {
				case 'PUT':
					$aRequiredVars = array('id_property', 'language_iso', 'name');
					if (array_keys_exists($aRequiredVars, $aVars)) return $this->_wsValueAdd($aVars);
					break;
			}
		} else {
			if (!$this->isOwnerValue($iIdValue)) showErrorPage(403);
			switch (Request::getRequestMethod()) {
				case 'DELETE':
					return $this->_wsValueDelete($iIdValue);
					break;
			}
		}
	}

	/**
	 * Webszolgáltatás: Tulajdonság létrehozása
	 *
	 * @param  array    $aVars        A formból beérkező változók: id_category, name
	 *
	 * @return json     A feldolgozás közben bekövetkező hibák
	 */
	private function _wsAdd($aVars) {
		// Változó(k)hoz való jogosultság ellenőrzése
		$oCategoryModule = ModuleFactory::getModule('category');
		if (!$oCategoryModule->isOwner($aVars['id_category'])) showErrorPage(403);

		$aVars = cleanValues($aVars);
		$aRes['error'] = array();

		$oPropertyDao =& DaoFactory::getDao('property');

		// kötelezően kitöltendő mezők ellenőrzése
		if (empty($aVars['name'])) $aRes['error'][] = 'empty_property';
		if (!empty($aRes['error'])) return Output::json($aRes);

		// unique mezők ellenőrzése
		$aPropertyTest = $oPropertyDao->getPropertyByIdCategoryAndName($aVars['id_category'], $aVars['name'], $aVars['language_iso']);
		if (!empty($aPropertyTest)) {
			$aRes['error'][] = 'already_property_in_category';
			return Output::json($aRes);
		}

		$aRes['id_property'] = $oPropertyDao->insertProperty($aVars['id_category']);

		// Nev beirasa az osszes nyelven
		$oUserauth =& ModuleFactory::getModule('userauth');
		$aUserInfo = $oUserauth->getUser();
		$oShopDao =& DaoFactory::getDao('shop');
		$aNames = array();
		foreach ($oShopDao->getLanguageList($aUserInfo['id_shop']) as $aLanguage) {
			$aNames[$aLanguage['iso']] = $aVars['name'];
		}
		$oPropertyDao->updateProperty($aRes['id_property'], $aNames);

		return Output::json($aRes);
	}

	/**
	 * Webszolgáltatás: Tulajdonság szerkesztése
	 *
	 * @param  int      $iIdProperty  A felhasználó azonosítója
	 * @param  array    $aVars        A formból beérkező változók: name
	 *
	 * @return json     A feldolgozás közben bekövetkező hibák
	 */
	private function _wsEdit($iIdProperty, $aVars) {
		$aVars = cleanValues($aVars);
		$aRes['error'] = array();

		$oPropertyDao =& DaoFactory::getDao('property');

		// kötelezően kitöltendő mezők ellenőrzése
		if (empty($aVars['name'])) $aRes['error'][] = 'empty_property';
		if (!empty($aRes['error'])) return Output::json($aRes);

		// unique mezők ellenőrzése
		$aProperty = $oPropertyDao->getProperty($iIdProperty);
		$aPropertyTest = $oPropertyDao->getPropertyByIdCategoryAndName($aProperty['id_category'], $aVars['name'], $aVars['language_iso']);
		if (!empty($aPropertyTest) && $aPropertyTest['id_property'] != $iIdProperty) {
			$aRes['error'][] = 'already_property_in_category';
			return Output::json($aRes);
		}

		$oPropertyDao->updateProperty($iIdProperty, array($aVars['language_iso'] => $aVars['name']));

		return Output::json($aRes);
	}

	/**
	 * Webszolgáltatás: Tulajdonság törlése
	 *
	 * @param  int      $iIdProperty  A tulajdonság azonosítója
	 *
	 * @return json     Üres error tömb (nincs hibalehetőség)
	 */
	private function _wsDelete($iIdProperty) {
		$aRes['error'] = array();

		$oPropertyDao =& DaoFactory::getDao('property');
		$oPropertyDao->deleteProperty($iIdProperty);

		return Output::json($aRes);
	}

	/**
	 * Webszolgáltatás: Tulajdonság-érték létrehozása
	 *
	 * @param  array    $aVars        A formból beérkező változók: id_property, name
	 *
	 * @return json     A feldolgozás közben bekövetkező hibák
	 */
	private function _wsValueAdd($aVars) {
		// Változó(k)hoz való jogosultság ellenőrzése
		if (!$this->isOwner($aVars['id_property'])) showErrorPage(403);

		$aVars = cleanValues($aVars);
		$aRes['error'] = array();

		$oPropertyDao =& DaoFactory::getDao('property');

		// kötelezően kitöltendő mezők ellenőrzése
		if (empty($aVars['name'])) $aRes['error'][] = 'empty_name';
		if (!empty($aRes['error'])) return Output::json($aRes);

		// unique mezők ellenőrzése
		$aPropertyValueTest = $oPropertyDao->getPropertyValueByIdPropertyAndName($aVars['id_property'], $aVars['name']);
		if (!empty($aPropertyValueTest)) { $aRes['error'][] = 'already_value_in_property'; return Output::json($aRes); }

		$aRes['id_property_value'] = $oPropertyDao->insertPropertyValue($aVars['id_property']);

		// Value beirasa az osszes nyelven
		$oUserauth =& ModuleFactory::getModule('userauth');
		$aUserInfo = $oUserauth->getUser();
		$oShopDao =& DaoFactory::getDao('shop');
		$aValues = array();
		foreach ($oShopDao->getLanguageList($aUserInfo['id_shop']) as $aLanguage) {
			$aValues[$aLanguage['iso']] = $aVars['name'];
		}
		$oPropertyDao->updatePropertyValue($aRes['id_property_value'], $aValues);

		return Output::json($aRes);
	}

	/**
	 * Webszolgáltatás: Tulajdonság-érték törlése
	 *
	 * @param  int      $iIdValue  A tulajdonság-érték azonosítója
	 *
	 * @return json     Üres error tömb (nincs hibalehetőség)
	 */
	private function _wsValueDelete($iIdValue) {
		$aRes['error'] = array();

		$oPropertyDao =& DaoFactory::getDao('property');
		$oPropertyDao->deletePropertyValue($iIdValue);

		return Output::json($aRes);
	}
}
?>