<?php
class PaypalModule extends Module {
	protected function _access($sMethodName) {
		return TRUE;
	}

	public function path() {
		return array(
			'paypaltest' => array(
				'method'      => 'test',
				'id_language' => 'en',
				'public'      => FALSE,
			),
			'paypal' => array(
				'method'      => 'default',
				'id_language' => 'en',
				'public'      => FALSE,
			),
			'paypal/review' => array(
				'method'      => 'review',
				'id_language' => 'en',
				'public'      => FALSE,
			),
			'paypal/ipn' => array(
				'method'      => 'ipn',
				'id_language' => 'en',
				'public'      => FALSE,
			),
		);
	}

	// Send a request to Paypal Name-Value Pair API
	function _sendNVP($aFields) {
		$sUrl = $GLOBALS['siteconfig']['paypal_testmode'] ? 'https://api-3t.sandbox.paypal.com/nvp' : 'https://api-3t.paypal.com/nvp';
		return $this->_send($sUrl, $aFields);
	}

	// Send a message to Paypal IPN
	function _sendIPN($aFields) {
		$sUrl = $GLOBALS['siteconfig']['paypal_testmode'] ? 'https://www.sandbox.paypal.com/cgi-bin/webscr' : 'https://www.paypal.com/cgi-bin/webscr';
		return $this->_send($sUrl, $aFields);
	}

	// Send POST message with cURL
	function _send($sUrl, $aFields) {
		//set POST variables
		$sFields = '';

		//url-ify the data for the POST
		foreach($aFields as $sKey=>$sValue) {
			$sFields .= $sKey.'='.$sValue.'&';
		}
		rtrim($sFields, '&');

		//open connection
		$rCh = curl_init();
		
		//set the url, number of POST vars, POST data
		curl_setopt($rCh, CURLOPT_URL, $sUrl);
		curl_setopt($rCh, CURLOPT_POST, count($aFields));
		curl_setopt($rCh, CURLOPT_POSTFIELDS, $sFields);
		curl_setopt($rCh, CURLOPT_RETURNTRANSFER, 1);

		//execute post
		$sResult = curl_exec($rCh);

		//close connection
		curl_close($rCh);

		return $sResult;
	}
	
	private function _setExpressCheckout($aVars) {
		$oProductDao =& DaoFactory::getDao('product');

		$aRes['error'] = array();

		$oCheckout =& ModuleFactory::getModule('checkout');
		$aCart = $oCheckout->getCartInfo();
		
		// TODO: Raktarkeszlet ellenorzesere kell egy fuggveny

		// Kupon lekerdezese, kedvezmeny kiszamolasa, free product lekerdezese
		$iDiscount = 0;
		$aCoupon = NULL;
		if (isset($_SESSION['coupon'])) {
			$oCouponDao =& DaoFactory::getDao('coupon');
			$aCoupon = $oCouponDao->getCoupon($_SESSION['coupon']);
			
			if (!empty($aCoupon)) {
				if ($aCoupon['type'] == '10-percent') {
					$iDiscount = $aCart['total'] * 0.1;
				}
				if ($aCoupon['type'] == 'free-product') {
					$aFreeProduct = $oProductDao->getProductByPermalinks($GLOBALS['siteconfig']['shop_permalink'], $aCoupon['info']);
					$aFreeProduct['order_quantity'] = 1;
				}
			}
		}

		// Shipping method lekérdezése
		$oShopDao =& DaoFactory::getDao('shop');
		$aShop = $oShopDao->getShopByPermalink($GLOBALS['siteconfig']['shop_permalink']);
		$aShippingInfo = $oShopDao->getShippingMethod($aShop['id_shop'], $aVars['shipping_method'], $aCart['total']);

		// Shipping adatok modositasa, ha van free-shipping coupon
		if (!empty($aCoupon) && $aCoupon['expiration'] > date("Y-m-d")) {
			if ($aCoupon['type'] == 'free-delivery') {
				$aShippingInfo['price'] = 0;
			}
		}
		
		$aFields = array(
			'METHOD'      => 'SetExpressCheckout',
			'VERSION'     => '109.0',
			'USER'        => $GLOBALS['siteconfig']['paypal_user'],
			'PWD'         => $GLOBALS['siteconfig']['paypal_password'],
			'SIGNATURE'   => $GLOBALS['siteconfig']['paypal_signature'],
			
			'ALLOWNOTE'   => 1,

			'RETURNURL' => $GLOBALS['siteconfig']['site_url'].'/paypal/review/',
			'CANCELURL' => $GLOBALS['siteconfig']['site_url'].'/paypal/review/',
			
			'CHANNELTYPE' => 'Merchant',
			'TOTALTYPE'   => 'total',
			
			'PAYMENTREQUEST_0_PAYMENTACTION' => 'Sale',
			'PAYMENTREQUEST_0_CURRENCYCODE' => 'GBP',
			'PAYMENTREQUEST_0_AMT'          => $aCart['total'] + $aShippingInfo['price'] - $iDiscount,
			'PAYMENTREQUEST_0_ITEMAMT'      => $aCart['total'] - $iDiscount,
			'PAYMENTREQUEST_0_SHIPPINGAMT'  => $aShippingInfo['price'],
			'PAYMENTREQUEST_0_DESC'         => "Ennie's Garden Webshop order",
		);

		$iCount = 0;
		foreach ($aCart['product'] as $aItem) {
			$aFields += array(
				"L_PAYMENTREQUEST_0_NAME{$iCount}" => $aItem['name'],
				"L_PAYMENTREQUEST_0_AMT{$iCount}"  => $aItem['item_price'],
				"L_PAYMENTREQUEST_0_QTY{$iCount}"  => $aItem['order_quantity'],
			);
			$iCount++;
		}
		foreach ($aCart['pack'] as $aItem) {
			$aFields += array(
				"L_PAYMENTREQUEST_0_NAME{$iCount}" => $aItem['name'],
				"L_PAYMENTREQUEST_0_AMT{$iCount}"  => $aItem['item_price'],
				"L_PAYMENTREQUEST_0_QTY{$iCount}"  => $aItem['order_quantity'],
			);
			$iCount++;
		}

		if (!empty($aFreeProduct)) {
			$aFields += array(
				"L_PAYMENTREQUEST_0_NAME{$iCount}" => $aFreeProduct['name'],
				"L_PAYMENTREQUEST_0_AMT{$iCount}"  => 0,
				"L_PAYMENTREQUEST_0_QTY{$iCount}"  => 1,
			);
			$iCount++;
		}

		if ($iDiscount) {
			$aFields += array(
				"L_PAYMENTREQUEST_0_NAME{$iCount}" => 'Discount',
				"L_PAYMENTREQUEST_0_AMT{$iCount}"  => 0 - $iDiscount,
				"L_PAYMENTREQUEST_0_QTY{$iCount}"  => '1',
			);
			$iCount++;
		}

		$sPaypalRes = $this->_sendNVP($aFields);
		parse_str($sPaypalRes, $aPaypalRes);
		
		// Log paypal request and response
		$sText = date("Y-m-d H:i:s")."\r\n";
		$sText .= "Variables sent:\r\n\r\n".print_r($aFields, 1);
		$sText .= "Response:\r\n".print_r($aPaypalRes, 1)."\r\n";
		file_put_contents(DIR_DEBUG.'/paypal-set.log', $sText, FILE_APPEND);
		
		if (empty($aPaypalRes) || $aPaypalRes['ACK'] != 'Success') {
			$aRes['error'][] = 'paypal'; 
			return Output::json($aRes);
		}

		$oOrderDao =& DaoFactory::getDao('order');
		// Megrendeles letrehozasa (a szallitasi adatok a checkout soran lesznek megadva, egyelore csak a termekek lesznek rogzitve)
		//   Rendelés adatainak beírása az adatbázisba
		$iIdOrder = $oOrderDao->insertOrder(
			$GLOBALS['id_language'],
			$GLOBALS['siteconfig']['shop_permalink'],
			$aCart['total'] + $aShippingInfo['price'] - $iDiscount,
			$aShippingInfo['price'],
			$aVars['id_payment_method'],
			$aShippingInfo['id_shipping_method'],
			(empty($aCoupon) ? NULL : $aCoupon['id_coupon'])
		);
		if (empty($iIdOrder)) {
			$aRes['error'][] = 'db';
			return Output::json($aRes);
		}

		//   Megrendelés tételeinek rögzítése
		$oOrderDao->insertProducts($iIdOrder, $aCart['product']);
		// free-product kuponhoz tartozo termek rogzitese
		$oOrderDao->insertProducts($iIdOrder, [$aFreeProduct]);
		// TODO: ez a method meg nem ok - miert???????
		$oOrderDao->insertPacks($iIdOrder, $aCart['pack']);
		                                                                                                                            
		// Token hozzakapcsolasa a megrendeleshez
		$oPaypalDao =& DaoFactory::getDao('paypal');
		$oPaypalDao->insert($iIdOrder, $aPaypalRes['TOKEN']);
		
		// Token visszaadasa a kliens oldalnak: ez alapjan lesz a megfelelo helyre redirectelve a bongeszo
		$aRes['token'] = $aPaypalRes['TOKEN'];
		       
		return Output::json($aRes);
	}

	private function _doExpressCheckoutPayment($sToken, $sPayerID, $aOrder) {
		$aRes['error'] = array();

		$oCheckout =& ModuleFactory::getModule('checkout');
		$aCart = $oCheckout->getCartInfo();
		
		$aFields = array(
			'METHOD'      => 'DoExpressCheckoutPayment',
			'VERSION'     => '109.0',
			'USER'        => $GLOBALS['siteconfig']['paypal_user'],
			'PWD'         => $GLOBALS['siteconfig']['paypal_password'],
			'SIGNATURE'   => $GLOBALS['siteconfig']['paypal_signature'],
			
			'TOKEN'       => $sToken,
			'PAYERID'     => $sPayerID,

			'ALLOWNOTE'   => 1,

			'CHANNELTYPE' => 'Merchant',
			'TOTALTYPE'   => 'total',
			
			'PAYMENTREQUEST_0_PAYMENTACTION' => 'Sale',
			'PAYMENTREQUEST_0_CURRENCYCODE' => 'GBP',
			'PAYMENTREQUEST_0_AMT'          => $aOrder['total'],
			'PAYMENTREQUEST_0_ITEMAMT'      => $aOrder['total'] - $aOrder['shipping_cost'],
			'PAYMENTREQUEST_0_SHIPPINGAMT'  => $aOrder['shipping_cost'],
		);


		$sPaypalRes = $this->_sendNVP($aFields);
		parse_str($sPaypalRes, $aPaypalRes);
		
		// Log error if occurred
		if ($aPaypalRes['ACK'] != 'Success') {
			$aRes['error'][] = 'paypal'; 
			$sText = date("Y-m-d H:i:s")."\r\n";
			$sText .= "Variables sent:\r\n".print_r($aFields, 1);
			$sText .= "Response:\r\n".print_r($aPaypalRes, 1)."\r\n";
			file_put_contents(DIR_DEBUG.'/paypal-error.log', $sText, FILE_APPEND);
		}
		       
		return $aPaypalRes;
	}

	private function _getExpressCheckoutDetails($sToken, $sPayerID) {
		$aFields = array(
			'METHOD'      => 'GetExpressCheckoutDetails',
			'VERSION'     => '109.0',
			'USER'        => $GLOBALS['siteconfig']['paypal_user'],
			'PWD'         => $GLOBALS['siteconfig']['paypal_password'],
			'SIGNATURE'   => $GLOBALS['siteconfig']['paypal_signature'],
			
			'TOKEN'       => $sToken,
		);
		$sRes = $this->_sendNVP($aFields);
		parse_str($sRes, $aRes);
		return $aRes;
	}

	/**
	 * A paypallal kapcsolatos webszolgáltatások
	 *   POST   /paypal                 Inicializal egy Express Checkout tranzakciot (SetExpressCheckout)
	 *
	 * @return string|json              a feldolgozás közben bekövetkező hibák
	 */
	protected function _reqDefault() {
		$aVars = Request::getRequestVars();
		switch (Request::getRequestMethod()) {
			case 'GET':
				break;
			case 'POST':
				$aVars = Request::getRequestVars();
				$aVars = cleanValues($aVars);
				return $this->_setExpressCheckout($aVars);
				break;
		}
	}

	/**
	 * Rendereli paypal folyamat visszateresi oldalát:
	 * Info a sikeres / sikertelen paymentrol.
	 * Ha sikeres a megrendeles, akkor
	 *   -befejezi az Express Checkout tranzakciot (DoExpressCheckoutPayment)	 
	 * 	 -kiuriti a kosarat
	 * 
	 * @return string   A generált oldal tartalma
	 */
	protected function _reqReview() {
		$oOrderDao =& DaoFactory::getDao('order');
		$oPaypalDao =& DaoFactory::getDao('paypal');

		$aPaypalInfo = $oPaypalDao->getOrderFromToken($_GET['token']);
		$aOrder = $oOrderDao->getOrder($aPaypalInfo['id_order']);

		// Ha sikertelen a checkout, akkor visszater a hibaoldallal
		if (empty($_GET['token'] || empty($_GET['PayerID']))) {
			return Output::render('paypal_review', getLayoutVars() + array(
				'successful' => FALSE,
			));
		}

		// Ha sikeres a checkout, akkor...
		// befejezi a tranzakciot
		$aDoRes = $this->_doExpressCheckoutPayment($_GET['token'], $_GET['PayerID'], $aOrder);
		// logoljuk a valaszt
		$sText = date("Y-m-d H:i:s")."\r\n";
		$sText .= "Variables sent:\r\n".print_r($_GET, 1)."\r\n";
		$sText .= "Response:\r\n".print_r($aDoRes, 1)."\r\n";
		file_put_contents(DIR_DEBUG.'/paypal-do.log', $sText, FILE_APPEND);
		// Beallitja, hogy slkuldtuk a docheckout-ot
		$oPaypalDao->setDoCheckoutSent($aOrder['id_order']);


		// ha sikeres a tranzakcio, akkor...
		if ($aDoRes['ACK'] == 'Success') {
			// Mentjuk a transactionID-t
			$oPaypalDao->updateWithTransactionID($aOrder['id_order'], $aDoRes['PAYMENTINFO_0_TRANSACTIONID']);

			// Tarolja a payerid-t
			$oPaypalDao->updateWithPayerID($aOrder['id_order'], $_GET['PayerID']);

			// Beallitja, hogy megtortent a docheckout
			$oPaypalDao->setDoCheckoutSuccessful($aOrder['id_order']);

			// Kiuriti a kosarat
			unset($_SESSION['cart']);
			$oOrderDao->updatePaymentResponse($aOrder['id_order'], serialize($aDoRes));
			$oOrderDao->updatePaymentStatus($aOrder['id_order'], 'confirmed');
			
			// Beirja a customer adatokat a megrendeleshez
			$aDetails = $this->_getExpressCheckoutDetails($_GET['token'], $_GET['PayerID']);
			$oOrderDao->updateCustomerData($aOrder['id_order'], $aDetails['EMAIL'], '', $aDetails['SHIPTONAME'], $aDetails['SHIPTOSTREET'], $aDetails['SHIPTOCITY'], $aDetails['SHIPTOZIP'], $aDetails['SHIPTONAME'], $aDetails['SHIPTOSTREET'], $aDetails['SHIPTOCITY'], $aDetails['SHIPTOZIP']);

			// Torli a kupont: exipred-re allitja, ha csak egyszer hasznalatos, majd torles a sessionbol
			if (isset($_SESSION['coupon'])) {
				$oCouponDao =& DaoFactory::getDao('coupon');
				$aCoupon = $oCouponDao->getCoupon($_SESSION['coupon']);
				if ($aCoupon['unlimited'] == 'n') {
					$oCouponDao->setCouponExpiration($_SESSION['coupon'], '0000-00-00');
					unset($_SESSION['coupon']);
				}
			}
		}

		// Ha Success vagy SuccessWithWarning (mar megvolt a do, de refresht nyomott a felhasznalo) akkor visszater successful oldallal
		if ($aDoRes['ACK'] == 'Success' || $aDoRes['ACK'] == 'SuccessWithWarning') {
			return Output::render('paypal_review', getLayoutVars() + array(
				'successful' => TRUE,
				'orderinfo'  => $aOrder,
			));
		}
		else {
			return Output::render('paypal_review', getLayoutVars() + array(
				'successful' => FALSE,
			));
		}
	}

	/**
	 * IPN
	 * Fogadja a paypal-tol erkezo IPN notification-oket es valaszol rajuk	 
	 * Beirja a customer adatait
	 * Updateli a payment statust (success)
	 * 	 	 	 
	 *   POST   /paypal/ipn/       Ertelmezi a POST-olt adatokat, és ha sikeres volt a tranzakció, akkor beállítja a successful statust. 
	 *
	 * @return void
	 */
	protected function _reqIpn() {
		if (Request::getRequestMethod() != 'POST') return;
		$aVars = Request::getRequestVars();
		$aVars = cleanValues($aVars);

		file_put_contents(DIR_DEBUG.'/paypal-ipn.log', date("Y-m-d H:i:s")."\r\n ".print_r($aVars, 1)."\r\n\r\n", FILE_APPEND);
		if (empty($aVars['txn_id'])) {
			file_put_contents(DIR_DEBUG.'/paypal-ipn.log', "ERROR: TRANSACTION ID WAS NOT SPECIFIED\r\n\r\n", FILE_APPEND);
			return;
		}
		
		// Valasz kuldese a paypalnak, hogy megkaptuk az IPN-t
		$sIPNRes = $this->_sendIPN(['cmd' => '_notify-validate'] + $_POST);
		file_put_contents(DIR_DEBUG.'/paypal-ipn.log', "Paypal IPN response: {$sIPNRes}\r\n", FILE_APPEND);
		
		// Lekerdezzuk az ordert, hogy mirol is van szo
		$oPaypalDao =& DaoFactory::getDao('paypal');
		$oOrderDao =& DaoFactory::getDao('order');
		$aPaypalInfo = $oPaypalDao->getOrderFromTransactionID($aVars['txn_id']);
		$aOrder = $oOrderDao->getOrder($aPaypalInfo['id_order']);
		
		// Ha nem tortent meg a doCheckout, akkor valami furcsa hiba van, beirjuk a logba, kilepunk
		if ($aPaypalInfo['docheckout_successful'] == 'n') {
			file_put_contents(DIR_DEBUG.'/paypal-ipn.log', "ERROR: DOCHECKOUT MISSED\r\n\r\n", FILE_APPEND);
			return;
		}
		
		if ($aVars['payment_status'] === 'Pending') {
			// Ha mar megkaptuk ezt az ertesitest, akkor nem foglalkozunk vele. Logoljuk a duplikalt ertesitest
			if ($aPaypalInfo['ipn_pending_notification'] == 'y') {
				file_put_contents(DIR_DEBUG.'/paypal-ipn.log', "NOTICE: \"Pending\" already noticed\r\n\r\n", FILE_APPEND);
				return;
			}
			// Beallitjuk, hogy megkaptuk a notificationt
			$oPaypalDao->setIPNPendingNotification($aOrder['id_order']);
		}

		if ($aVars['payment_status'] === 'Completed') {
			// Ha mar megkaptuk ezt az ertesitest, akkor nem foglalkozunk vele. Logoljuk a duplikalt ertesitest
			if ($aPaypalInfo['ipn_completed_notification'] == 'y') {
				file_put_contents(DIR_DEBUG.'/paypal-ipn.log', "NOTICE: \"Completed\" already noticed\r\n\r\n", FILE_APPEND);
				return;
			}
			// Beallitjuk, hogy megkaptuk a notificationt
			$oPaypalDao->setIPNCompletedNotification($aOrder['id_order']);
			$oOrderDao->updateCustomerData($aOrder['id_order'], $aVars['payer_email'], '', $aVars['address_name'], $aVars['address_street'], $aVars['address_city'], $aVars['address_zip'], $aVars['address_name'], $aVars['address_street'], $aVars['address_city'], $aVars['address_zip']);

			// Termekek lekerdezese: szukseg lesz rajuk a raktarkeszlet csokkentesenel es az emailnel
			$aProductList = $oOrderDao->getProductList($aOrder['id_order']);
			$aPackList = $oOrderDao->getPackList($aOrder['id_order']);
	
			// Raktárkészlet csökkentése
			$oProductDao =& DaoFactory::getDao('product');
			foreach ($aProductList as $aItem) {
				$oProductDao->reduceQuantity($aItem['id_product'], $aItem['quantity']);
			}
/*
			$oPackDao =& DaoFactory::getDao('pack');
			foreach ($aPackList as $aItem) {
				$oPackDao->reduceQuantity($aItem['id_pack'], $aItem['quantity']);
			}
	*/
			// Shipping method info lekérdezése - a checkout.php-ben is van hasonlo, oda is at kell masolni ha valtozas van
			$oShippingMethodDao =& DaoFactory::getDao('shipping_method');
			$aShippingInfo = $oShippingMethodDao->getMethod($aOrder['id_shipping_method']);
	
			// Customer email renderelése
			$sMessage = Output::render('_email_receipt', getLayoutVars() + array(
				'id_language'       => 'en',
				'orderinfo'         => $aOrder,
				'products'          => $aProductList,
				'packs'             => $aPackList,
				'shippinginfo'      => $aShippingInfo,
				'total'             => $aOrder['total'],
				'status'            => 'pending',
			), 'blank');
	
			// Customer email küldése
			mymail($aOrder['email'], 'Order notification', $sMessage, $GLOBALS['siteconfig']['out_email'], $GLOBALS['siteconfig']['out_email_name']);
	
			// Admin email küldése
			$sMessage = Output::render('_email_admin', getLayoutVars() + array(
				'id_language' => 'en',
				'id_order'    => $aOrder['id_order'],
			), 'blank');
			mymail($GLOBALS['siteconfig']['in_email'], 'Incoming order', $sMessage, $GLOBALS['siteconfig']['out_email'], $GLOBALS['siteconfig']['out_email_name']);
	
			// Status beallitasa
			$oOrderDao->updatePaymentStatus($aOrder['id_order'], 'success');
				
		}
	}

}
?>