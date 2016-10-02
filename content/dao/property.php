<?php
/**
 * A termékjellemzőkkel foglalkozó adatbázis osztály
 * A property táblában vannak tárolva a kategóriákhoz rendelt jellemzők, pl szín, anyag
 * A property_value táblában a jellemzőkhöz tartozó értékek, pl. szín: piros, kék, fehér, anyag: bőr, textil
 * A product_property_value tábla köti össze a termékeket az értékekkel
 */

class PropertyDao extends Dao {
	/**
	 * Egy kategóriához tartozó jellemzők listája
	 *
	 * @param integer $iIdCategory
	 *
	 * @return array
	 */
	public function getPropertyList($iIdCategory, $sLanguageIso) {
		return $this->rConnection->getList("
			SELECT property_text.*, language.iso AS language_iso
			FROM property
			INNER JOIN property_text
			ON property.id_property = property_text.id_property
			INNER JOIN language
			ON property_text.id_language = language.id_language
			WHERE id_category = :0
			AND language.iso = :1
		", func_get_args());
	}

	/**
	 * Egy termékjellemző adatai
	 *
	 * @param  integer $iIdProperty
	 *
	 * @return array
	 */
	public function getProperty($iIdProperty) {
		return $this->rConnection->getRow(
			"SELECT * FROM property WHERE id_property = :iIdProperty",
			array(
				'iIdProperty' => $iIdProperty
			)
		);
	}

	/**
	 * Egy érték adatai
	 *
	 * @param  integer  $iIdValue
	 *
	 * @return array
	 */
	public function getValue($iIdValue) {
		return $this->rConnection->getRow(
			"SELECT * FROM property_value WHERE id_value = :iIdValue",
			array(
				'iIdValue' => $iIdValue
			)
		);
	}

	/**
	 * Egy termékjellemző adatai a neve és a kategória azonosítója alapján
	 *
	 * @param  integer $iIdProperty
	 *
	 * @return array
	 */
	public function getPropertyByIdCategoryAndName($iIdCategory, $sName, $sLanguageIso) {
		return $this->rConnection->getRow("
			SELECT *
			FROM property
			INNER JOIN property_text
			ON property.id_property = property_text.id_property
			INNER JOIN language
			ON language.id_language = property_text.id_language
			WHERE id_category = :0
			AND property_text.name = :1
			AND language.iso = :2
		", func_get_args());
	}

	/**
	 * Egy érték adatai a neve és a jellemző azonosítója alapján
	 *
	 * @param  integer $iIdProperty
	 *
	 * @return array
	 */
	public function getPropertyValueByIdPropertyAndName($iIdProperty, $sName) {
		return $this->rConnection->getRow(
			"SELECT * FROM property_value WHERE id_property = :iIdProperty AND name = :sName",
			array(
				'iIdProperty' => $iIdProperty,
				'sName' => $sName
			)
		);
	}

	/**
	 * Egy jellemző törlése.
	 *
	 * @param  integer
	 *
	 * @return void
	 */
	public function deleteProperty($iIdProperty) {
		$this->rConnection->execute("
			DELETE FROM
				property
			WHERE
				property.id_property=:iIdProperty
			", array(
				'iIdProperty' => $iIdProperty
			)
		);
	}

	/**
	 * Egy érték törlése.
	 *
	 * @param  integer
	 *
	 * @return void
	 */
	public function deletePropertyValue($iIdValue) {
		$this->rConnection->execute("
			DELETE
				property_value, product_property_value
			FROM
				property_value
			LEFT JOIN
				product_property_value
			ON
				property_value.id_value = product_property_value.id_value
			WHERE
				property_value.id_value=:iIdValue
		", array(
				'iIdValue' => $iIdValue
			)
		);
	}

	/**
	 * Jellemző létrehozása
	 *
	 * @param  integer  $iIdCategory  A kategória azonosítója amihez a jellemző tartozik
	 *
	 * @return integer  A létrehozott jellemző azonosítója
	 */
	public function insertProperty($iIdCategory) {
		return $this->rConnection->insert('
			INSERT INTO property (id_category)
			VALUES (:0)
		', func_get_args());
	}

	/**
	 * Jellemzőhöz tartozó érték létrehozása
	 *
	 * @param  integer  $iIdProperty  A jellemző azonosítója amihez az érték tartozik
	 * @param  string   $sName        Az érték neve
	 *
	 * @return integer  A létrehozott érték azonosítója
	 */
	public function insertPropertyValue($iIdProperty) {
		return $this->rConnection->insert('
			INSERT INTO property_value (id_property)
			VALUES (:0)
		', func_get_args());
	}

	/**
	 * Módosítja egy jellemző adatait
	 *
	 * @param  integer  $iIdProperty        A jellemző azonosítója
	 * @param  string   $aNames             A jellemző neve: array('en'=>'angol nev', 'hu'->'magyar nev')
	 */
	public function updateProperty($iIdProperty, $aNames) {
		$oLanguageDao =& DaoFactory::getDao('language');
		foreach ($aNames as $sLanguageIso=>$sName) {
			$aLanguage = $oLanguageDao->getLanguageFromIso($sLanguageIso);
			$this->rConnection->execute("
				REPLACE INTO property_text (id_property, id_language, name)
				VALUES ({$iIdProperty}, {$aLanguage['id_language']}, '{$sName}')
			");
		}
	}

	/**
	 * Módosítja egy jellemző adatait
	 *
	 * @param  integer  $iIdProperty        A jellemző azonosítója
	 * @param  string   $aValues            A jellemző erteke: array('en'=>'angol nev', 'hu'->'magyar nev')
	 */
	public function updatePropertyValue($iIdPropertyValue, $aValues) {
		$oLanguageDao =& DaoFactory::getDao('language');
		foreach ($aValues as $sLanguageIso=>$sValue) {
			$aLanguage = $oLanguageDao->getLanguageFromIso($sLanguageIso);
			$this->rConnection->execute("
				REPLACE INTO property_value_text (id_property_value, id_language, value)
				VALUES ({$iIdPropertyValue}, {$aLanguage['id_language']}, '{$sValue}')
			");
		}
	}

	/**
	 * Egy jellemzőhöz tartozó értékek listája
	 *
	 * @param integer $iIdProperty  A jellemző azonosítója
	 *
	 * @return array
	 */
	public function getPropertyValueList($iIdProperty, $sLanguageIso) {
		return $this->rConnection->getList("
			SELECT
				property_value.id_property,
				property_value.id_value,
				property_value_text.*
			FROM property_value
			INNER JOIN property_value_text
			ON property_value.id_value = property_value_text.id_property_value
			INNER JOIN language
			ON property_value_text.id_language = language.id_language
			WHERE id_property = :0
			AND language.iso = :1
		", func_get_args());
	}
}
?>