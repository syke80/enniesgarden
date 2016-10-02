<?php
class CheckoutModule extends Module {
	protected function _access($sMethodName) {
		return TRUE;
	}

	public function path() {
		return array(
			'checkout' => array(
				'method'      => 'default',
				'id_language' => 'en',
				'public'      => FALSE,
			),
			'checkout/login' => array(
				'method'      => 'login',
				'id_language' => 'en',
			),
			'checkout/preview' => array(
				'method'      => 'preview',
			),
			'checkout/details' => array(
				'method'      => 'details',
				'id_language' => 'en',
			),
			'checkout/charityclear' => array(
				'method'      => 'charityclear',
				'id_language' => 'en',
			),
			'checkout/charityclear/callback' => array(
				'method'      => 'charityclearCallback',
				'id_language' => 'en',
			),
			'checkout/review' => array(
				'method'      => 'review',
				'id_language' => 'en',
			),
			'penztar' => array(
				'method'      => 'default',
				'id_language' => 'hu',
			),
			'penztar/bejelentkezes' => array(
				'method'      => 'login',
				'id_language' => 'hu',
			),
			'penztar/reszletek' => array(
				'method'      => 'details',
				'id_language' => 'hu',
			),
			'penztar/attekintes' => array(
				'method'      => 'review',
				'id_language' => 'hu',
			),
		);
	}

	/**
	 * Rendereli checkout folyamat első oldalát:
	 * A megrendelő választhat hogy belép, vagy továbbmegy és megadja az adatait
	 *
	 * @return string   A generált oldal tartalma
	 */
	protected function _reqLogin() {
		// Ha a kosár üres, akkor az "üres a kosár" oldallal tér vissza
		if (empty($_SESSION['cart'])) {
			return Output::render('checkout_empty_cart', getLayoutVars());
		}

		// Ha be van jelentkezve, akkor továbbdobja a következő oldalra
		$oCustomerauth = ModuleFactory::getModule('customerauth');
		if ($oCustomerauth->isLoggedIn()) {
			switch ($GLOBALS['id_language']) {
				case 'en':
					Request::redirect("{$GLOBALS['siteconfig']['site_url']}/checkout/details/");
					break;
				case 'hu':
					Request::redirect("{$GLOBALS['siteconfig']['site_url']}/penztar/reszletek/");
					break;
				}
		}

		return Output::render('checkout_login', getLayoutVars());
	}

	/**
	 * Rendereli checkout folyamat második oldalát:
	 * Szállítási/számlázási adatok, regisztráció
	 * Az adatokat elküldi a /checkout webszolgáltatásnak
	 *
	 * @return string   A generált oldal tartalma
	 */
	protected function _reqDetails() {
		if (empty($_SESSION['cart'])) {
			return Output::render('checkout_empty_cart', getLayoutVars());
		}
		
		$oShopDao =& DaoFactory::getDao('shop');
		$aShop = $oShopDao->getShopByPermalink($GLOBALS['siteconfig']['shop_permalink']);
		
		$oShippingMethodDao =& DaoFactory::getDao('shipping_method');
		$oPaymentMethodDao =& DaoFactory::getDao('payment_method');

		return Output::render('checkout_details', getLayoutVars() + array(
			'shipping_method_list' => $oShippingMethodDao->getMethodList($aShop['id_shop']),
			'payment_method_list'  => $oPaymentMethodDao->getMethodList($aShop['id_shop']),
			'total'                => $this->getCartInfo()['total'],
		));
	}

	/**
	 * Rendereli checkout folyamat harmadik oldalát a charityclear-hez szukseges adatokkal
	 *
	 * @return string   A generált oldal tartalma
	 */
	protected function _pageCharityclear($sHash) {
		$oOrderDao =& DaoFactory::getDao('order');
		$aOrder = $oOrderDao->getOrderFromHash($sHash);
		if (empty($aOrder)) $sError = 'not_found';
		else {
			if ($aOrder['payment_status'] == 'success') $sError = 'status_success';
			if ($aOrder['payment_status'] == 'confirmed') $sError = 'status_confirmed';
			if ($aOrder['payment_status'] == 'declined') $sError = 'status_declined';
		}

		if (!empty($sError)) {
			return Output::render('checkout_charityclear', getLayoutVars() + array(
				'error' => $sError,
			));
        }

		$sPreSharedKey = "Circle4Take40Idea";
		$aFields = array(
			"merchantID" => $GLOBALS['siteconfig']['charityclear_merchant_id'],
			"merchantPwd" => "",
			"amount" => $aOrder['total'] * 100,
			"countryCode" => "826",
			"currencyCode" => "826",
			"transactionUnique" => $sHash,
			"redirectURL" => "{$GLOBALS['siteconfig']['site_url']}/checkout/charityclear/{$sHash}/", // do nothing with the POST data, redirects to the success GET page
			"callbackURL" => "{$GLOBALS['siteconfig']['site_url']}/checkout/charityclear/callback/", // process the POST data
			"action" => "PREAUTH",
			"customerName" => $aOrder['billing_name'],
			"customerAddress" => $aOrder['billing_address'].', '.$aOrder['billing_city'],
			"customerPostcode" => $aOrder['billing_postcode'],
			"customerEmail" => $aOrder['email'],
			"customerPhone" => $aOrder['phone'],
		);
		// Sort the array
		ksort($aFields);

		return Output::render('checkout_charityclear', getLayoutVars() + array(
			'fields' => $aFields,
			'signature' => hash("SHA512",  http_build_query($aFields) . $sPreSharedKey),
			'order' => $aOrder,
		));
	}


	/**
	 * Rendereli a rendelés preview-ját, ami a jelenlegi állapot alapján az adatbázisba kerülne (ha a felhasználó submitolná a formot)
	 *
	 * @return string   A generált oldal tartalma
	 */
	protected function _reqPreview($sLanguageIso) {
		if (empty($_SESSION['cart'])) return;

		$GLOBALS['id_language'] = $sLanguageIso;

		$aVars = Request::getRequestVars();
		$aVars = cleanValues($aVars);

		$oOrderDao =& DaoFactory::getDao('order');
		$oCustomerDao =& DaoFactory::getDao('customer');

		$aCartInfo = $this->getCartInfo();
	
		// Shipping method info lekérdezése
		$oShopDao =& DaoFactory::getDao('shop');
		$aShop = $oShopDao->getShopByPermalink($GLOBALS['siteconfig']['shop_permalink']);
		$aShippingInfo = empty($aVars['shipping_method']) ? '' : $oShopDao->getShippingMethod($aShop['id_shop'], $aVars['shipping_method']);

		$aCartInfo['total'] += $aShippingInfo['price'];

		// Rendelés adatainak beírása az adatbázisba
		return Output::render('checkout_preview', array(
			'language_iso'  => $sLanguageIso,
			'cartinfo'      => $aCartInfo,
			'shippinginfo'  => $aShippingInfo,
		));
	}

	/**
	 * Rendereli checkout folyamat utolsó oldalát:
	 * Info a sikeres / sikertelen megrendelésről.
	 *
	 * @return string   A generált oldal tartalma
	 */
	protected function _reqReview($sHash='') {
		// Oldal renderelese
		$oOrderDao =& DaoFactory::getDao('order');
		$aOrder = $oOrderDao->getOrderFromHash($sHash);
		return Output::render('checkout_review', getLayoutVars() + array(
			'hash' => $sHash,
			'order' => $aOrder,
		));
	}

	/**
	 * A termékkel kapcsolatos webszolgáltatások
	 *   GET    /checkout               Átirányít a checkout első oldalára
	 *   POST   /checkout               Létrehoz egy megrendelést
	 *
	 * @return string|json              GET esetén a generált oldal tartalma
	 *                                  PUT esetén a feldolgozás közben bekövetkező hibák
	 */
	protected function _reqDefault() {
		$aVars = Request::getRequestVars();
		switch (Request::getRequestMethod()) {
			case 'GET':
				switch ($GLOBALS['id_language']) {
					case 'en':
						Request::redirect("{$GLOBALS['siteconfig']['site_url']}/checkout/login");
						break;
					case 'hu':
						Request::redirect("{$GLOBALS['siteconfig']['site_url']}/penztar/bejelentkezes");
						break;
				}
				break;
			case 'POST':
				$aRequiredVars = array(
					'shipping_name', 'shipping_address', 'shipping_city', 'shipping_postcode',
					'phone', 'email',
				);
				if (array_keys_exists($aRequiredVars, $aVars)) return $this->_wsInsert($aVars);
				break;
		}
	}

	/**
	 * A Charity Clear-rel kapcsolatos webszolgáltatások
	 *   GET    /checkout/charityclear/            Letrehozza a formot amit a charity clear-nek kell postolni
	 *   POST   /checkout/charityclear/            Ertelmezi a POST-olt adatokat, majd airanyit a success oldalra
	 *   POST   /checkout/charityclear/{id_order}  Ertelmezi a POST-olt adatokat, majd beirja az adatbazisba az orderhez
	 *                                             Az id_order titkos, sehol nem szerepel, csak a charityclear tudja, igy ez bizonyitja, hogy a charityclear-től jött a POST	  
	 *
	 * @return string|json              GET esetén a generált oldal tartalma
	 *                                  POST esetén a feldolgozás közben bekövetkező hibák
	 */
	protected function _reqCharityclear($sHash='') {
		switch (Request::getRequestMethod()) {
			case 'GET':
				return $this->_pageCharityClear($sHash);
				break;
			case 'POST':
				$aVars = Request::getRequestVars();
				$oOrderDao =& DaoFactory::getDao('order');
				$aOrder = $oOrderDao->getOrderFromHash($sHash);

				// Ha sikeres a payment, akkor...
				if ($aVars['responseCode'] === "0") {
					// Kiuriti a kosarat
					unset($_SESSION['cart']);
					// Csak akkor irja be, ha pending a status, hogy ne irja felul az esetlegesen korabban beerkezo success-t
					if ($aOrder['payment_status'] == 'pending') {
						$oOrderDao->updatePaymentResponse($aOrder['id_order'], serialize($aVars));
						$oOrderDao->updatePaymentStatus($aOrder['id_order'], 'confirmed');
					}
				}
				
				// ONLY FOR TESTING ! ! !
				Debug::addMsg("mailchimp: ".$GLOBALS['siteconfig']['charityclear_test']?'charityclear in testmode':'charityclear not in testmode', '', DEBUG_LOG_INFO);
				if (isset($GLOBALS['siteconfig']['charityclear_test']) && $GLOBALS['siteconfig']['charityclear_test']===TRUE) $this->_reqCharityclearCallback();
				
				Request::redirect("{$GLOBALS['siteconfig']['site_url']}/checkout/review/{$sHash}/");
				break;
		}
	}

	/**
	 * A Charity Clear callback. Nem publikus url, ide -is- küld értesítést a paymentről.
	 * Az ide beérkező kérések alapján lesz beállítva a payment = success status.
	 * Tehat ez az IPN	 	 
	 *   POST   /checkout/charityclear/callback/       Ertelmezi a POST-olt adatokat, és ha sikeres volt a tranzakció, akkor beállítja a successful statust. 
	 *
	 * @return void
	 */
	protected function _reqCharityclearCallback() {
		file_put_contents(DIR_DEBUG.'/charityclear.txt', date("Y-m-d H:i:s")." ".serialize($aVars)."\r\n", FILE_APPEND);
		// Bejovo adatok ertelmezese, rendeles lekerdezese
		$aVars = Request::getRequestVars();
		$oOrderDao =& DaoFactory::getDao('order');
		$oProductDao =& DaoFactory::getDao('product');
		$aOrder = $oOrderDao->getOrderFromHash($aVars['transactionUnique']);
		$aProductList = $oOrderDao->getProductList($aOrder['id_order']);

		// Charityclear valasz beirasa az order-hez
		$oOrderDao->updatePaymentResponse($aOrder['id_order'], serialize($aVars));

		// Billing adatok beallitasa
		if (!empty($aVars['customerName']) || $aVars['customerAddress'] || $aVars['customerPostcode']) {
			$oOrderDao->updateBillingData($aOrder['id_order'], $aVars['customerName'], $aVars['customerAddress'], '', $aVars['customerPostcode']);

			// Order lekerdezese megint: a megvaltozott billing adatokkal
			$aOrder = $oOrderDao->getOrderFromHash($aVars['transactionUnique']);
        }

		if ($aVars['responseCode'] === "0") {
			// Raktárkészlet csökkentése
			foreach ($aProductList as $aItem) {
				$oProductDao->reduceQuantity($aItem['id_product'], $aItem['quantity']);
			}
	
			// Shipping method info lekérdezése
			$oShippingMethodDao =& DaoFactory::getDao('shipping_method');
			$aShippingInfo = $oShippingMethodDao->getMethod($aOrder['id_shipping_method']);
	
			// Email renderelése
			$sMessage = Output::render('_email_receipt', getLayoutVars() + array(
				'id_language'       => 'en',
				'orderinfo'         => $aOrder,
				'orderitems'        => $aProductList,
				'shippinginfo'      => $aShippingInfo,
				'total'             => $aOrder['total'],
				'status'            => 'pending',
			), 'blank');
	
			// Email küldése a vásárlónak
			mymail($aOrder['email'], 'Order receipt', $sMessage, $GLOBALS['siteconfig']['out_email'], $GLOBALS['siteconfig']['out_email_name']);
	
			// Email küldése a boltnak
			$sMessage = Output::render('_email_admin', getLayoutVars() + array(
				'id_language' => 'en',
				'id_order'    => $aOrder['id_order'],
			), 'blank');
			mymail($GLOBALS['siteconfig']['in_email'], 'Incoming order', $sMessage, $GLOBALS['siteconfig']['out_email'], $GLOBALS['siteconfig']['out_email_name']);
	
			// Status beallitasa
			$oOrderDao->updatePaymentStatus($aOrder['id_order'], 'success');
			
Debug::addMsg("mailchimp: subscribe", '', DEBUG_LOG_INFO);

			$this->_mailchimpSubscribe($GLOBALS['siteconfig']['mailchimp_list'], $aOrder['email'], splitName($aOrder['shipping_name'])['first'], splitName($aOrder['shipping_name'])['last']);

		} else {
			// Status beallitasa
			$oOrderDao->updatePaymentStatus($aOrder['id_order'], 'declined');
		}
	}

	/**
	 * A kosar tartalma reszletesen
	 *	 	
	 * Egy ilyen tombot ad vissza:	
	 * products[]
	 *   id_product
	 *   name
	 *   stock_quantity
	 *   order_quantity
	 *   item_price
	 *   order_price	 
	 * pack[]
	 *   id_pack
	 *   name
	 *   order_quantity
	 *   item_price
	 *   order_price	 
	 * total	 	 
	 */	 	
	public function getCartInfo() {
		$oProductDao =& DaoFactory::getDao('product');
		$oPackDao =& DaoFactory::getDao('pack');

		$aCartInfo = [];
		$aCartInfo['product'] = [];
		$aCartInfo['pack'] = [];
		$aCartInfo['total'] = 0;

		if (!empty($_SESSION['cart']['product'])) {
			foreach ($_SESSION['cart']['product'] as $iIdProduct=>$aCartItem) {
				// Csak számokat fogadunk el
				if ($iIdProduct > 0) {
					$aProduct = $oProductDao->getProduct($iIdProduct, $GLOBALS['id_language']);
					$aCartInfo['product'][] = array(
						'id_product'     => $aProduct['id_product'],
						'name'           => $aProduct['name'],
						'stock_quantity' => $aProduct['quantity'],
						'order_quantity' => $aCartItem['quantity'],
						'item_price'     => $aProduct['price'], 
						'order_price'    => $aCartItem['quantity'] * $aProduct['price'],
					);
					$aCartInfo['total'] += $aCartItem['quantity'] * $aProduct['price'];
				}
			}
		}

		if (!empty($_SESSION['cart']['pack'])) {
			foreach ($_SESSION['cart']['pack'] as $iIdPack=>$aCartItem) {
				// Csak számokat fogadunk el
				if ($iIdPack > 0) {
					$aPack = $oPackDao->getPack($iIdPack, $GLOBALS['id_language']);
					$aCartInfo['pack'][] = array(
						'id_pack'        => $aPack['id_pack'],
						'name'           => $aPack['name'],
						'order_quantity' => $aCartItem['quantity'],
						'item_price'     => $aPack['price'], 
						'order_price'    => $aCartItem['quantity'] * $aPack['price'],
					);
					$aCartInfo['total'] += $aCartItem['quantity'] * $aPack['price'];
				}
			}
		}

		return $aCartInfo;
	}

	/**
	 * MAR NINCS HASZNALATBAN, TOROLNI KELL MINEL ELOBB (miutan kipuskaztam belole mindent ami szukseges lehet)	
	 * A kosár alapján összeállítja a tételek listáját
	 * -Minden tétel tartalmazza a vonalkódot, nevet, darabszámot, árat, subtotal-t (az adott termék ára * darabszám)	 
	 * -A termékcsomagokat termékenként viszi fel, a csomagkedvezmény külön tétel lesz
	 * -Összeszámolja a termékek végösszegét (csak a termékek árának összegét, a szállítási költség nélkül)	 
	 */	 	
	private function _buildOrderInfo() {
		$oProductDao =& DaoFactory::getDao('product');
		$oPackDao =& DaoFactory::getDao('pack');
		// A megrendelés tételeinek összeállítása (ez megy majd az order_products táblába)
		// A total-t újraszámoljuk, mert ha a kosár átkerül szerver oldalról (session) kliens oldalra (cookie-ba), akkor nem lesz tárolva a végösszeg
		$iOrderTotal = 0;
		$aOrderItems = array();

		if (!empty($_SESSION['cart']['product'])) {
			foreach ($_SESSION['cart']['product'] as $iIdProduct=>$aCartItem) {
				// Csak számokat fogadunk el
				if ($iIdProduct > 0) {
					$aProduct = $oProductDao->getProduct($iIdProduct, $GLOBALS['id_language']);
					$aOrderItems[] = array(
						'id_product'     => $aProduct['id_product'],
						'barcode'        => $aProduct['barcode'],
						'name'           => $aProduct['name'],
						'stock_quantity' => $aProduct['quantity'],
						'quantity'       => $aCartItem['quantity'],
						'price'          => $aProduct['price'], 
						'total'          => $aCartItem['quantity'] * $aProduct['price'],
					);
					$iOrderTotal += $aCartItem['quantity'] * $aProduct['price'];
				}
			}
		}

		if (!empty($_SESSION['cart']['pack'])) {
			foreach ($_SESSION['cart']['pack'] as $iIdPack=>$aCartItem) {
				// Csak számokat fogadunk el
				if ($iIdPack > 0) {
					$aPackInfo = $oPackDao->getPack($iIdPack, $GLOBALS['id_language']);
					
					// PHP 5.3...
					$aLinkedProductList = $oPackDao->getLinkedProductList($iIdPack, $GLOBALS['id_language']);
					$aLinkedProductList = $aLinkedProductList['list'];
					
					$iPackFullPrice = 0;
					foreach ($aLinkedProductList as $aProduct) {
						$aProduct['total'] = $aProduct['price'] * $aProduct['quantity']; // A csomagban levő adott termék összértéke, pl ha a vizsgált termékből 3 db van a csomagban, és 5000 Ft/db, akkor a változó értéke 15000 
						$aOrderItems[] = array(
							'id_product'     => $aProduct['id_product'],
							'barcode'        => $aProduct['barcode'],
							'name'           => $aProduct['name'],
							'stock_quantity' => $aProduct['quantity'],
							'quantity'       => $aCartItem['quantity'] * $aProduct['quantity'],  // a kosárban a csomag darabszáma * a csomagban levő termékek darabszáma
							'price'          => $aProduct['price'],                              // a csomagban levő termék ára 
							'total'          => $aCartItem['quantity'] * $aProduct['total'],     // a kosárban a csomag darabszáma * a csomagban levő termék összértéke 
						);
						// Közben számoljuk a csomag teljes árát, amit akkor kellene fizetni, ha nem csomagban venné a termékeket
						$iPackFullPrice += $aProduct['total'];
					}
					// Csomag vásárlása miatti árengedmény beszúrása: a pack árából ki kell vonni a termékek árának összegét
					$iPackDiscount = $aPackInfo['price'] - $iPackFullPrice;
					$aOrderItems[] = array(
						'name'     => "Csomagkedvezmény ({$aPackInfo['name']})",
						'quantity' => $aCartItem['quantity'],                          // a kosárban a csomag darabszáma
						'price'    => $iPackDiscount,                                  // a kedvezmény "ára" 
						'total'    => $aCartItem['quantity'] * $iPackDiscount,         // a kosárban a csomag darabszáma * az adott csomaghoz tartozó árengedmény 
					);
					$iOrderTotal += $aCartItem['quantity'] * $aPackInfo['price'];
				}
			}
		}

		return array(
			'items' => $aOrderItems,
			'total' => $iOrderTotal,
		);
	}

	/**
	 * Webszolgáltatás, ami elküld egy rendelést:
	 * -Beírja a megrendelés adatait és a megrendelt termékek listáját az adatbázisba
	 * -Emailt küld a bolt tulajdonosának és a megrendelőnek
	 *
	 * @param  array    $aVars       A formból beérkező változók:
	 *                               shipping_name, shipping_address, shipping_city, shipping_postcode
	 *                               phone, email,
	 *                               register, (opcionális)
	 *                               billing_name, billing_address, billing_city, billing_postcode,
	 *                               register_passw, register_passw2: A jelszavak MD5 hashelve
	 *                               check_stock (ellenőrzi a készletet, és ha nincs elég a raktárban, akkor nem engedi a kosárba rakni, hibaüzenetet küld vissza)	 
	 *
	 * @return json       A feldolgozás közben bekövetkező hibák
	 */
	private function _wsInsert($aVars) {
		$aVars = cleanValues($aVars);
		$aRes['error'] = array();

		$oOrderDao =& DaoFactory::getDao('order');
		$oCustomerDao =& DaoFactory::getDao('customer');
		$oProductDao =& DaoFactory::getDao('product');
		$oPaymentMethodDao =& DaoFactory::getDao('payment_method');

		if (empty($_SESSION['cart'])) {
			$aRes['error'][] = 'session';
			return Output::json($aRes);
		}

		// Kötelezően kitöltendő mezők ellenőrzése
		if (empty($aVars['email']))              $aRes['error'][] = 'empty_email';
		if (empty($aVars['phone']))              $aRes['error'][] = 'empty_phone';
		if (empty($aVars['shipping_name']))      $aRes['error'][] = 'empty_shipping_name';
		if (empty($aVars['shipping_address']))   $aRes['error'][] = 'empty_shipping_address';
		if (empty($aVars['shipping_city']))      $aRes['error'][] = 'empty_shipping_city';
		if (empty($aVars['shipping_postcode']))  $aRes['error'][] = 'empty_shipping_postcode';
		if (empty($aVars['shipping_method']))    $aRes['error'][] = 'empty_shipping_method';
		if (empty($aVars['payment_method']))     $aRes['error'][] = 'empty_payment_method';
		// Ha mi számlázunk és a szállítási cím nem azonos a számlázási címmel, akkor a számlázási adatokat is kötelező kitölteni
		if ($oPaymentMethodDao->getMethod($aVars['payment_method'])['external_billing'] == 'n' && empty($aVars['billing_same'])) {
			if (empty($aVars['billing_name']))     $aRes['error'][] = 'empty_billing_name';
			if (empty($aVars['billing_address']))  $aRes['error'][] = 'empty_billing_address';
			if (empty($aVars['billing_city']))     $aRes['error'][] = 'empty_billing_city';
			if (empty($aVars['billing_postcode'])) $aRes['error'][] = 'empty_billing_postcode';
		}
		if (!empty($aVars['register']) && empty($aVars['register_passw'])) $aRes['error'][] = 'empty_passw';
		if (!empty($aRes['error'])) return Output::json($aRes);

		// Mezők érvényességének ellenőrzése
		if (!empty($aVars['register'])) {
			if ($aVars['register_passw'] != $aVars['register_passw2']) $aRes['error'][] = 'error_passw';
			$aUserInfo = $oCustomerDao->getCustomerByShopEmail($GLOBALS['siteconfig']['shop_permalink'], $aVars['email']);
			if (!empty($aUserInfo)) $aRes['error'][] = 'already_user_email';
		}
		if (!filter_var($aVars['email'], FILTER_VALIDATE_EMAIL)) $aRes['error'][] = 'error_email';
		if (!empty($aRes['error'])) return Output::json($aRes);

		$aCartInfo = $this->getCartInfo();

		// Raktarkeszlet ellenőrzése
		foreach ($aOrderInfo['items'] as $aItem) {
			if (is_numeric($aItem['stock_quantity']) && $aItem['quantity'] > $aItem['stock_quantity']) {
				if (isset($aVars['check_stock']) && $aVars['check_stock']==true) $aRes['error'][] = 'stock|'.$aItem['name'];
				else $aRes['warning'][] = 'stock|'.$aItem['name'];
			}
		}
		if (!empty($aRes['error'])) return Output::json($aRes);

		// Shipping method lekérdezése, az ár hozzáadása a végösszeghez
		$oShopDao =& DaoFactory::getDao('shop');
		$aShop = $oShopDao->getShopByPermalink($GLOBALS['siteconfig']['shop_permalink']);
		$aShippingInfo = $oShopDao->getShippingMethod($aShop['id_shop'], $aVars['shipping_method'], $aOrderInfo['total']);
		$aOrderInfo['total'] += $aShippingInfo['price'];
	
		// Rendelés adatainak beírása az adatbázisba
		$iIdOrder = $oOrderDao->insertOrder(
			$GLOBALS['id_language'],
			$GLOBALS['siteconfig']['shop_permalink'],
			$aOrderInfo['total'],
			$aShippingInfo['price'],
			$aVars['shipping_method'],
			$aVars['payment_method'],
			$aVars['email'],
			$aVars['phone'],
			$aVars['shipping_name'],
			$aVars['shipping_address'],
			$aVars['shipping_city'],
			$aVars['shipping_postcode'],
			empty($aVars['billing_same']) ? (isset($aVars['billing_name']) ? $aVars['billing_name'] : '') : $aVars['shipping_name'],
			empty($aVars['billing_same']) ? (isset($aVars['billing_address']) ? $aVars['billing_address'] : '') : $aVars['shipping_address'],
			empty($aVars['billing_same']) ? (isset($aVars['billing_city']) ? $aVars['billing_city'] : '') : $aVars['shipping_city'],
			empty($aVars['billing_same']) ? (isset($aVars['billing_postcode']) ? $aVars['billing_postcode'] : '') : $aVars['shipping_postcode']
		);
		if (empty($iIdOrder)) {
			$aRes['error'][] = 'db';
			return Output::json($aRes);
		}

		// Megrendelés tételeinek rögzítése
		$oOrderDao->insertProducts($iIdOrder, $aCartInfo['product']);
		$oOrderDao->insertPacks($iIdOrder, $aCartInfo['pack']);

		// Vásárló regisztrálása
		if (!empty($aVars['register'])) {
			$iIdCustomer = $oCustomerDao->insertCustomer(
				$GLOBALS['siteconfig']['shop_permalink'],
				$aVars['email'],
				$aVars['register_passw'],
				$aVars['phone'],
				$aVars['shipping_name'],
				$aVars['shipping_address'],
				$aVars['shipping_city'],
				$aVars['shipping_postcode'],
				(empty($aVars['billing_same']) ? $aVars['billing_name'] : $aVars['shipping_name']),
				(empty($aVars['billing_same']) ? $aVars['billing_address'] : $aVars['shipping_address']),
				(empty($aVars['billing_same']) ? $aVars['billing_city'] : $aVars['shipping_city']),
				(empty($aVars['billing_same']) ? $aVars['billing_postcode'] : $aVars['shipping_postcode'])
			);
			$oCustomer =& ModuleFactory::getModule('customerauth');
			$oCustomer->setCustomer($iIdCustomer);
		}

		// A megrendelés lekérdezése (a generált hash lekérdezése miatt)
		$aOrder = $oOrderDao->getOrder($iIdOrder);
		if (empty($aOrder) || empty($aOrder['hash'])) {
			$aRes['error'][] = 'db';
			return Output::json($aRes);
		}

		$aRes['hash'] = $aOrder['hash'];
		return Output::json($aRes);
	}

	function _mailchimpSubscribe($sList, $sEmail, $sFirstName, $sLastName) {
		include 'vendor/mailchimp/mailchimp/src/Mailchimp.php';
		$mc = new Mailchimp($GLOBALS['siteconfig']['mailchimp_id']); //your api key here
	
		$lists = $mc->lists->getList( [ 'list_name' => $sList ] );
	
		$res = $mc->lists->subscribe($lists['data'][0]['id'], ['email' => $sEmail], ['FNAME'=>$sFirstName, 'LNAME'=>$sLastName], 'html', FALSE);

		return($res);
	}
}
?>