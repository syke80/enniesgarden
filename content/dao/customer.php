<?php
class CustomerDao extends Dao {
	/**
	 * Vásárlók listája
	 *
	 * @return array
	 */
	public function getCustomerList() {
		return $this->rConnection->getList("SELECT * FROM customer");
	}

	/**
	 * Egy vásárló adatai
	 *
	 * @param  integer  $iIdCustomer
	 *
	 * @return array
	 */
	public function getCustomer($iIdCustomer) {
		return $this->rConnection->getRow("
			SELECT * FROM customer WHERE id_customer = :iIdCustomer
		", array(
			'iIdCustomer' => $iIdCustomer
		));
	}

	/**
	 * A paraméterben megadott bolthoz tartozó vásárló adatainak lekérdezése
	 * a bolt permalinkje, a vásárló emailcíme és jelszava alapján
	 *
	 * @param  string  $sPermalinkShop
	 * @param  string  $sEmail
	 * @param  string  $sPassw
	 *
	 * @return array
	 */
	public function getCustomerByShopEmailPassword($sPermalinkShop, $sEmail, $sPassw) {
		return $this->rConnection->getRow("
			SELECT
				customer.*
			FROM
				customer
			INNER JOIN
				shop
			ON
				customer.id_shop = shop.id_shop
			WHERE
				customer.email = :sEmail
			AND
				customer.passw = :sPassw
			AND
				shop.permalink = :sPermalinkShop
		", array(
			'sPermalinkShop' => $sPermalinkShop,
			'sEmail' => $sEmail,
			'sPassw' => $sPassw
		));
	}

	/**
	 * A paraméterben megadott bolthoz tartozó vásárló adatainak lekérdezése
	 * a bolt permalinkje és a vásárló emailcíme alapján
	 *
	 * @param  string  $sPermalinkShop
	 * @param  string  $sEmail
	 *
	 * @return array
	 */
	public function getCustomerByShopEmail($sPermalinkShop, $sEmail) {
		return $this->rConnection->getRow("
			SELECT
				*
			FROM
				customer
			INNER JOIN
				shop
			ON
				customer.id_shop = shop.id_shop
			WHERE
				shop.permalink = :sPermalinkShop
			AND
				customer.email = :sEmail
		", array(
			'sPermalinkShop' => $sPermalinkShop,
			'sEmail' => $sEmail
		));
	}

	/**
	 * Vásárló törlése
	 *
	 * @param  integer  $iIdCustomer
	 *
	 * @return array
	 */
	public function deleteCustomer($iIdCustomer) {
		$this->rConnection->execute("DELETE FROM customer WHERE id_customer={$iIdCustomer}");
	}

	/**
	 * Létrehoz egy vásárlót
	 *
	 * @param  string   $sPermalinkShop      A bolt permalinkje amihez a vásárló tartozik
	 * @param  string   $sEmail              A vásárló email címe
	 * @param  string   $sPassw              -jelszava
	 * @param  string   $sPhone              -telefonszáma
	 * @param  string   $sShippingName       -szállítási címhez tartozó neve
	 * @param  string   $sShippingAddress    -szállítási címe (utca / házszám)
	 * @param  string   $sShippingCity       -szállítási címhez tartozó város
	 * @param  string   $sShippingPostcode   -szállítási címhez tartozó irányítószám
	 * @param  string   $sBillingName        -számlán szereplő név
	 * @param  string   $sBillingAddress     -számlán szereplő cím (utca / házszám)
	 * @param  string   $sBillingCity        -számlán szereplő város
	 * @param  string   $sBillingPostcode    -számlán szereplő irányítószám
	 *
	 * @return array
	 */
	public function insertCustomer($sPermalinkShop, $sEmail, $sPassw, $sPhone, $sShippingName, $sShippingAddress, $sShippingCity, $sShippingPostcode, $sBillingName, $sBillingAddress, $sBillingCity, $sBillingPostcode) {
		$iIdShop = $this->rConnection->getValue('SELECT id_shop FROM shop WHERE permalink = :sPermalinkShop', array(
			'sPermalinkShop' => $sPermalinkShop
		));

		return $this->rConnection->insert('
			INSERT INTO customer (
				id_shop, email, passw, phone,
				shipping_name, shipping_address, shipping_city, shipping_postcode,
				billing_name, billing_address, billing_city, billing_postcode
			)
			VALUES (
				:iIdShop, :sEmail, :sPassw, :sPhone,
				:sShippingName, :sShippingAddress, :sShippingCity, :sShippingPostcode,
				:sBillingName, :sBillingAddress, :sBillingCity, :sBillingPostcode
			)
		', array(
			'iIdShop' => $iIdShop,
			'sEmail' => $sEmail,
			'sPassw' => $sPassw,
			'sPhone' => $sPhone,
			'sShippingName' => $sShippingName,
			'sShippingAddress' => $sShippingAddress,
			'sShippingCity' => $sShippingCity,
			'sShippingPostcode' => $sShippingPostcode,
			'sBillingName' => $sBillingName,
			'sBillingAddress' => $sBillingAddress,
			'sBillingCity' => $sBillingCity,
			'sBillingPostcode' => $sBillingPostcode
		));
	}
}
?>