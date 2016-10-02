<?php
class ShopDao extends Dao {
	/**
	 * A boltok listája
	 *
	 * @return array
	 */
	public function getShopList() {
		return $this->rConnection->getList("SELECT * FROM shop");
	}

	/**
	 * Egy bolt adatai
	 *
	 * @param  integer  $iIdShop
	 *
	 * @return array
	 */
	public function getShop($iIdShop) {
		return $this->rConnection->getRow("
			SELECT *
			FROM shop
			WHERE id_shop = :0
		", func_get_args());
	}

	/**
	 * Egy bolt adatainak lekérdezése a permalinkje alapján
	 *
	 * @param  string  $sPermalink
	 *
	 * @return array
	 */
	public function getShopByPermalink($sPermalink) {
		return $this->rConnection->getRow("
			SELECT *
			FROM shop
			WHERE permalink = :0
		", func_get_args());
	}

	/**
	 * Bolt törlése
	 *
	 * @param  integer  $iIdShop
	 *
	 * @return void
	 */
	public function deleteShop($iIdShop) {
		$this->rConnection->execute("
			DELETE FROM shop
			WHERE shop.id_shop=:0
		", func_get_args());
	}

	/**
	 * Létrehoz egy boltot
	 *
	 * @param  string   $sPermalink           A bolt permalinkje
	 * @param  string   $sName                A bolt neve
	 * @param  string   $sCompanyName         Cég neve
	 * @param  string   $sCompanyUrl          Cég weboldala
	 * @param  string   $sCompanyEmail        Cég email címe
	 * @param  string   $sCompanyPhone        Cég telefonszáma
	 * @param  string   $sCompanyCity         Cég címe (város)
	 * @param  string   $sCompanyAddress      Cég címe (utca/házszám)
	 * @param  string   $sCompanyPostcode     Cég címe (irányítószám)
	 * @param  string   $sCompanyCountry      Cég címe (ország)
	 *
	 * @return array    A bolt azonosítója
	 */
	public function insertShop(
		$sPermalink, $sName,
		$sCompanyName, $sCompanyUrl, $sCompanyEmail, $sCompanyPhone,
		$sCompanyCity, $sCompanyAddress, $sCompanyPostcode, $sCompanyCountry, $sCompanyDescription
	) {
		return $this->rConnection->insert('
			INSERT INTO shop (
				permalink, name,
				company_name, company_url, company_email, company_phone,
				company_city, company_address, company_postcode, company_country, company_description
			)
			VALUES (
				:0, :1,
				:2, :3, :4, :5,
				:6, :7, :8, :9, :10
			)', func_get_args());
	}

	/**
	 * Módosítja egy bolt adatait
	 *
	 * @param  integer  $iIdShop              A bolt azonosítója
	 * @param  string   $sPermalink           A bolt permalinkje
	 * @param  string   $sName                A bolt neve
	 * @param  string   $sCompanyName         Cég neve
	 * @param  string   $sCompanyUrl          Cég weboldala
	 * @param  string   $sCompanyEmail        Cég email címe
	 * @param  string   $sCompanyPhone        Cég telefonszáma
	 * @param  string   $sCompanyCity         Cég címe (város)
	 * @param  string   $sCompanyAddress      Cég címe (utca/házszám)
	 * @param  string   $sCompanyPostcode     Cég címe (irányítószám)
	 * @param  string   $sCompanyCountry      Cég címe (ország)
	 * @param  string   $sCompanyDescription  Rövid, egy mondatos leírás a cégről
	 *
	 * @return array    A bolt azonosítója
	 */
	public function updateShop(
		$iIdShop, $sPermalink, $sName,
		$sCompanyName, $sCompanyUrl, $sCompanyEmail, $sCompanyPhone,
		$sCompanyCity, $sCompanyAddress, $sCompanyPostcode, $sCompanyCountry, $sCompanyDescription
	) {
		return $this->rConnection->execute('
			UPDATE shop SET
				permalink = :1,
				name = :2,
				company_name = :3,
				company_url = :4,
				company_email = :5,
				company_phone = :6,
				company_city = :7,
				company_address = :8,
				company_postcode = :9,
				company_country = :10,
				company_description = :11
			WHERE
				id_shop = :0
		', func_get_args());
	}

	/**
	 *	Nyelveket kapcsol egy shophoz
	 *	
	 * @param  integer  $iIdShop              A bolt azonosítója
	 * @param  string   $aIdLanguageList      Tömb, ami nyelvek azonosítóját tartalmazza
	 */	 
	public function insertLanguages($iIdShop, $aIdLanguageList) {
		$aValues = array();
		foreach ($aIdLanguageList as $sKey=>$iIdLanguage) {
			$aValues[] = "(:iIdShop, :{$sKey})";
		}
		$sValues = implode(', ', $aValues);
		$this->rConnection->execute("
			INSERT INTO shop_language (id_shop, id_language)
			VALUES {$sValues}
		", array('iIdShop' => $iIdShop) + $aIdLanguageList);
	}

	/**
	 *	Törli a shophoz tartozó nyelveket
	 *	
	 * @param  integer  $iIdShop              A bolt azonosítója
	 */	 
	public function deleteLanguages($iIdShop) {
		$this->rConnection->execute('
			DELETE FROM shop_language
			WHERE id_shop = :0
		', func_get_args());
	}

	/**
	 *	Nyelveket kapcsol egy shophoz
	 *	
	 * @param  integer  $iIdShop              A bolt azonosítója
	 * @param  string   $aIdLanguageList      Tömb, ami nyelvek azonosítóját tartalmazza
	 */	 
	public function getLanguageList($iIdShop) {
		return $this->rConnection->getList('
			SELECT *
			FROM shop_language
			INNER JOIN language
			ON shop_language.id_language = language.id_language
			WHERE id_shop = :0
		', func_get_args());
	}

	/**
	 * Egy bolthoz hozzárendelt fizetési metódusok törlése
	 *
	 * @param  integer  $iIdShop
	 */
	public function unlinkPaymentMethods($iIdShop) {
		$this->rConnection->execute("
			DELETE FROM shop_payment_method
			WHERE id_shop=:0
		", func_get_args());
	}

	/**
	 * Hozzárendel egy bolthoz egy fizetési metódust
	 *
	 * @param  integer  $iIdShop, $iIdPaymentMethod
	 */
	public function linkPaymentMethod($iIdShop, $iIdPaymentMethod, $iPrice) {
		$this->rConnection->execute("
			INSERT INTO shop_payment_method
			VALUES (:0, :1, :2)
		", func_get_args());
	}

	/**
	 * Egy bolthoz hozzárendelt szállítási metódusok törlése
	 *
	 * @param  integer  $iIdShop
	 */
	public function unlinkShippingMethods($iIdShop) {
		$this->rConnection->execute("
			DELETE FROM shop_shipping_method
			WHERE id_shop=:0
		", func_get_args());
	}

	/**
	 * Hozzárendel egy termékhez egy szállítási metódust
	 *
	 * @param  integer  $iIdShop, $iIdShippingMethod
	 */
	public function linkShippingMethod($iIdShop, $iIdShippingMethod, $iPrice) {
		$this->rConnection->execute("
			INSERT INTO shop_shipping_method
			VALUES (:0, :1, :2)
		", func_get_args());
	}

	/**
	 * Egy szállítási metódus lekérdezése
	 * (azert nem a shippingmethod daoban van, mert az ar a bolthoz tartozik)	 
	 *
	 * @param  IdShop 
	 * @param  IdShippingMethod
	 * @param  Amount             A tranzakcio osszege - azert kell, mert 1-1 method tobbfele aron is letezhet a tranzakcio osszegetol fuggoen
	 * 	  
	 * @return array
	 */
	public function getShippingMethod($iIdShop, $iIdShippingMethod, $dAmount) {
		return $this->rConnection->getRow("
			SELECT shop_shipping_method.*, shipping_method.name
			FROM shop_shipping_method
			INNER JOIN shipping_method
			ON shipping_method.id_shipping_method = shop_shipping_method.id_shipping_method
			WHERE id_shop = :0
			AND shipping_method.name = :1
			AND (:2>=interval_min OR interval_min IS NULL)
			AND (:2<=interval_max OR interval_max IS NULL)
		", func_get_args());
	}

}
?>