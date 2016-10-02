<?php
class OrderDao extends Dao {
	/**
	 * Egy bolthoz tartozó aktív megrendelések listája
	 *
	 * @param  integer  $iIdShop  A bolt azonosítója
	 *
	 * @return array
	 */
	public function getActiveOrderListByIdShop($iIdShop) {
		return $this->rConnection->getList("
			SELECT *
			FROM `order`
			WHERE id_shop = :0
			AND shipping_status IN ('pending', 'approved')
			ORDER BY date_order
			ASC
		", func_get_args());
	}

	/**
	 * Egy megrendelés adatai
	 *
	 * @param  integer  $iIdOrder
	 *
	 * @return array
	 */
	public function getOrder($iIdOrder) {
		return $this->rConnection->getRow("
			SELECT
				`order`.*,
				shipping_method.name AS shipping_method_name,
				payment_method.name AS payment_method_name
			FROM `order`
			INNER JOIN shop_shipping_method
			ON shop_shipping_method.id_shipping_method = `order`.id_shipping_method
			INNER JOIN shipping_method
			ON shop_shipping_method.id_shipping_method = shipping_method.id_shipping_method
			INNER JOIN shop_payment_method
			ON shop_payment_method.id_payment_method = `order`.id_payment_method
			INNER JOIN payment_method
			ON shop_payment_method.id_payment_method = payment_method.id_payment_method
			WHERE order.id_order = :0
		", func_get_args());
	}

	/**
	 * Egy megrendelés adatai
	 *
	 * @param  integer  $iIdOrder
	 *
	 * @return array
	 */
	public function getOrderFromHash($sHash) {
		return $this->rConnection->getRow("
			SELECT
				`order`.*,
				shipping_method.name AS shipping_method_name,
				payment_method.name AS payment_method_name
			FROM `order`
			INNER JOIN shop_shipping_method
			ON shop_shipping_method.id_shipping_method = `order`.id_shipping_method
			INNER JOIN shipping_method
			ON shop_shipping_method.id_shipping_method = shipping_method.id_shipping_method
			INNER JOIN shop_payment_method
			ON shop_payment_method.id_payment_method = `order`.id_payment_method
			INNER JOIN payment_method
			ON shop_payment_method.id_payment_method = payment_method.id_payment_method
			WHERE order.hash = :0
		", func_get_args());
	}

	/**
	 * Egy megrendeléshez tartozó termékek listája
	 *
	 * @param  integer  $iIdOrder
	 *
	 * @return array
	 */
	public function getProductList($iIdOrder) {
		return $this->rConnection->getList("
			SELECT *
			FROM order_product
			WHERE id_order = :0
		", func_get_args());
	}

	/**
	 * Egy megrendeléshez tartozó csomagok listája
	 *
	 * @param  integer  $iIdOrder
	 *
	 * @return array
	 */
	public function getPackList($iIdOrder) {
		return $this->rConnection->getList("
			SELECT *
			FROM order_pack
			WHERE id_order = :0
		", func_get_args());
	}


	/**
	 * Létrehoz egy megrendelést
	 *
	 * @param  string   $sPermalinkShop      A bolt permalinkje amihez a vásárló tartozik
	 * @param  string   $sEmail              A vásárló email címe
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
	public function insertOrder($sLanguageIso, $sPermalinkShop, $iTotal, $iShippingCost, $iIdPaymentMethod, $iIdShippingMethod, $iIdCoupon=NULL, $sEmail='', $sPhone='', $sShippingName='', $sShippingAddress='', $sShippingCity='', $sShippingPostcode='', $sBillingName='', $sBillingAddress='', $sBillingCity='', $sBillingPostcode='') {
		$iIdShop = $this->rConnection->getValue('SELECT id_shop FROM shop WHERE permalink = :sPermalinkShop', array(
			'sPermalinkShop' => $sPermalinkShop
		));

		$iIdLanguage = $this->rConnection->getValue('SELECT id_language FROM language WHERE iso = :sLanguageIso', array(
			'sLanguageIso' => $sLanguageIso
		));

		$sHash = bin2hex(openssl_random_pseudo_bytes(16));
		while ($aTest = $this->getOrderFromHash($sHash)) {
			$sHash = bin2hex(openssl_random_pseudo_bytes(16));
		}

		return $this->rConnection->insert('
			INSERT INTO `order` (
				hash,
				id_language,
				id_shop,
				email,
				phone,
				shipping_name,
				shipping_address,
				shipping_city,
				shipping_postcode,
				billing_name,
				billing_address,
				billing_city,
				billing_postcode,
				id_shipping_method,
				id_payment_method,
				id_coupon,
				shipping_cost,
				total,
				date_order,
				date_modified
			)
			VALUES (
				:sHash,
				:iIdLanguage,
				:iIdShop,
				:sEmail,
				:sPhone,
				:sShippingName,
				:sShippingAddress,
				:sShippingCity,
				:sShippingPostcode,
				:sBillingName,
				:sBillingAddress,
				:sBillingCity,
				:sBillingPostcode,
				:iIdShippingMethod,
				:iIdPaymentMethod,
				:iIdCoupon,
				:iShippingCost,
				:iTotal,
				NOW(),
				NOW()
			)
		', array(
			'sHash'             => $sHash,
			'iIdLanguage'       => $iIdLanguage,
			'iIdShop'           => $iIdShop,
			'sEmail'            => $sEmail,
			'sPhone'            => $sPhone,
			'sShippingName'     => $sShippingName,
			'sShippingAddress'  => $sShippingAddress,
			'sShippingCity'     => $sShippingCity,
			'sShippingPostcode' => $sShippingPostcode,
			'sBillingName'      => $sBillingName,
			'sBillingAddress'   => $sBillingAddress,
			'sBillingCity'      => $sBillingCity,
			'sBillingPostcode'  => $sBillingPostcode,
			'iIdShippingMethod' => $iIdShippingMethod,
			'iIdPaymentMethod'  => $iIdPaymentMethod,
			'iIdCoupon'         => $iIdCoupon,
			'iShippingCost'     => $iShippingCost,
			'iTotal'            => $iTotal,
		));
	}

	/**
	 * Termékeket kapcsol a megrendeléshez
	 *
	 * @param  integer  $iIdOrder    A megrendelés azonosítója
	 * @param  string   $aCart       A kosár tartalma
	 *
	 * @return array
	 */
	public function insertProducts($iIdOrder, $aOrderItems) {
		if (empty($aOrderItems)) return FALSE;

		foreach ($aOrderItems as $aItem) {
			$aInsertValues[] = "({$iIdOrder}, '{$aItem['barcode']}', '{$aItem['id_product']}', '".str_replace("'", "\'", $aItem['name'])."', '{$aItem['order_quantity']}', '{$aItem['order_price']}')";
		}
		$sInsertValues = implode(',', $aInsertValues);

		$this->rConnection->execute("
			INSERT INTO order_product (id_order, barcode, id_product, name, quantity, total)
			VALUES {$sInsertValues}
		");
	}

	/**
	 * Termékcsomagokat kapcsol a megrendeléshez
	 *
	 * @param  integer  $iIdOrder      A megrendelés azonosítója
	 * @param  string   $aProductList  A kosár tartalma (termékek)
	 *
	 * @return array
	 */
	public function insertPacks($iIdOrder, $aPackList) {
		if (empty($aPackList)) return FALSE;

		foreach ($aPackList as $aItem) {
			$aInsertValues[] = "({$iIdOrder}, '{$aItem['barcode']}', '{$aItem['id_pack']}', '".str_replace("'", "\'", $aItem['name'])."', '{$aItem['order_quantity']}', '{$aItem['order_price']}')";
		}
		$sInsertValues = implode(',', $aInsertValues);

		$this->rConnection->execute("
			INSERT INTO order_pack (id_order, barcode, id_pack, name, quantity, total)
			VALUES {$sInsertValues}
		");
/*
		$oPackDao =& DaoFactory::getDao('pack');

		// Elkészítjük a queryhez a sorokat amiket insertelni kell majd
		// Az aEscapeValues tömbben lesznek a változók amiket át lehet adni escapeléshez
		$aInsertValues = array();

		foreach ($aPackList as $iIdPack=>$aPackItem) {
			// Csak számokat fogadunk el
			if ($iIdPack > 0) {
				$aPackInfo = $oPackDao->getPack($iIdPack, $sLanguageIso);

				// PHP 5.3 miatt...
				$aProductList = $oPackDao->getLinkedProductList($iIdPack, $sLanguageIso);
				$aProductList = $aProductList['list'];

				$iPackFullPrice = 0;
				foreach ($aProductList as $aProduct) {
					$aProduct['total'] = $aProduct['price'] * $aProduct['quantity'];
					// Nem kell escapelni, mert db-ből jönnek az adatok
					$aInsertValues[] = "({$iIdOrder}, '{$aProduct['stock_id']}', '{$aProduct['name']}', ".$aPackItem['quantity'] * $aProduct['quantity'].", ".$aPackItem['quantity'] * $aProduct['total'].")";
					// Közben számoljuk a csomag teljes árát, amit akkor kellene fizetni, ha nem csomagban venné a termékeket
					$iPackFullPrice += $aProduct['total'];
				}
				// Csomag vásárlása miatti árengedmény beszúrása
				// A pack árából ki kell vonni a termékek árának összegét
				$iPackDiscount = $aPackInfo['price'] - $iPackFullPrice;
				$aInsertValues[] = "({$iIdOrder}, '', 'Csomagkedvezmény ({$aPackInfo['name']})', {$aPackItem['quantity']}, ".($aPackItem['quantity'] * $iPackDiscount).")";
			}
		}
		$sInsertValues = implode(',', $aInsertValues);

		$this->rConnection->execute("
			INSERT INTO order_product (id_order, stock_id, name, quantity, total)
			VALUES {$sInsertValues}
		");
*/
	}

	/**
	 * Módosítja egy megrendelés státuszát
	 *
	 * @param  integer  $iIdOrder         A megrendelés azonosítója
	 * @param  string   $sShippingStatus  A szállítás státusza
	 *
	 * @return array
	 */
	public function updateShippingStatus($iIdOrder, $sShippingStatus) {
		$this->rConnection->execute("
			UPDATE `order`
			SET shipping_status = :1,
			date_modified = NOW()
			WHERE id_order = :0
		", func_get_args());
	}

	/**
	 * Módosítja egy megrendelés státuszát
	 *
	 * @param  integer  $iIdOrder        A megrendelés azonosítója
	 * @param  string   $sPaymentStatus  A fizetés státusza
	 *
	 * @return array
	 */
	public function updatePaymentStatus($iIdOrder, $sPaymentStatus) {
		$this->rConnection->execute("
			UPDATE `order`
			SET payment_status = :1,
			date_modified = NOW()
			WHERE id_order = :0
		", func_get_args());
	}

	/**
	 * Módosítja egy megrendeléshez tartozó payment response-t
	 *
	 * @param  integer  $iIdOrder          A megrendelés azonosítója
	 * @param  string   $sPaymentResponse  A payment gateway-től érkezett válasz
	 *
	 * @return array
	 */
	public function updatePaymentResponse($iIdOrder, $sResponse) {
		$this->rConnection->execute("
			UPDATE `order`
			SET payment_response = :1,
			date_modified = NOW()
			WHERE id_order = :0
		", func_get_args());
	}

	/**
	 * Módosítja egy megrendeléshez tartozó megrendelo adatokat (ha egy payment gatewaytol -pl paypal- kapjuk)
	 * Ha a teljes checkout folyamat egy kulso szolgaltatonal -pl paypal- van	 
	 *
	 * @param  integer  $iIdOrder          A megrendelés azonosítója
	 * @param  string   $sPaymentResponse  A payment gateway-től érkezett válasz
	 *
	 * @return array
	 */
	public function updateCustomerData($iIdOrder, $sEmail, $sPhone, $sShippingName, $sShippingAddress, $sShippingCity, $sShippingPostcode, $sBillingName, $sBillingAddress, $sBillingCity, $sBillingPostcode) {
		$this->rConnection->execute("
			UPDATE `order`
			SET
			email = :1,
			phone = :2,
			shipping_name = :3,
			shipping_address = :4,
			shipping_city = :5,
			shipping_postcode = :6,
			billing_name = :7,
			billing_address = :8,
			billing_city = :9,
			billing_postcode = :10,
			date_modified = NOW()
			WHERE id_order = :0
		", func_get_args());
	}

	/**
	 * Módosítja egy megrendeléshez tartozó billing informaciot (ha egy payment gatewaytol kapjuk)
	 *
	 * @param  integer  $iIdOrder          A megrendelés azonosítója
	 * @param  string   $sPaymentResponse  A payment gateway-től érkezett válasz
	 *
	 * @return array
	 */
	public function updateBillingData($iIdOrder, $sBillingName, $sBillingAddress, $sBillingCity, $sBillingPostcode) {
		$this->rConnection->execute("
			UPDATE `order`
			SET billing_name = :1,
			billing_address = :2,
			billing_city = :3,
			billing_postcode = :4,
			date_modified = NOW()
			WHERE id_order = :0
		", func_get_args());
	}
}
?>