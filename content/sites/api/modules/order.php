<?php
class OrderModule extends Module {
	protected function _access($sMethodName) {
		return TRUE;
	}

	public function path() {
		return array(
			'order' => array(
				'method'      => 'default',
			),
			'order/list' => array(
				'method'      => 'list',
			),
			'order/productlist' => array(
				'method'      => 'productlist',
			),
		);
	}


	/**
	 * Rendereli a "megrendelések listája" boxot
	 *
	 * @return string   A generált oldal tartalma
	 */
	protected function _reqList() {
		$oUserauth =& ModuleFactory::getModule('userauth');
		$aUserInfo = $oUserauth->getUser();

		$oOrderDao =& DaoFactory::getDao('order');
		$aOrderList = $oOrderDao->getActiveOrderListByIdShop($aUserInfo['id_shop']);
		return Output::render('order_list', getLayoutVars() + array(
			'list' => $aOrderList,
			'open' => (empty($_GET['open']) ? '' : $_GET['open']),
		));
	}

	/**
	 * Rendereli a megrendelt termékek listáját tartalmazó boxot
	 *
	 * @return string   A generált oldal tartalma
	 */
	protected function _reqProductlist($iIdOrder) {
		if (!isset($iIdOrder)) showErrorPage(404);
		if (!$this->isOwner($iIdOrder)) showErrorPage(403);

		$oOrderDao =& DaoFactory::getDao('order');
//		$oShopDao =& DaoFactory::getDao('shop');

		return Output::render('order_productlist', getLayoutVars() + array(
			'order'        => $oOrderDao->getOrder($iIdOrder),
			'productlist'  => $oOrderDao->getProductList($iIdOrder),
			'packlist'     => $oOrderDao->getPackList($iIdOrder),
		));
	}

	/**
	 * Webszolgáltatás: megrendelés státuszának módosítása
	 *
	 * @param  int      $iIdOrder  A megrendelés azonosítója
	 * @param  array    $aVars     A formból beérkező változók: status
	 *
	 * @return json     A feldolgozás közben bekövetkező hibák
	 */
	private function _wsUpdatestatus($iIdOrder, $aVars) {
		$aRes['error'] = array();

		$oOrderDao =& DaoFactory::getDao('order');
		if (!empty($aVars['shipping_status'])) $oOrderDao->updateShippingStatus($iIdOrder, $aVars['shipping_status']);
		if (!empty($aVars['payment_status'])) $oOrderDao->updatePaymentStatus($iIdOrder, $aVars['payment_status']);

		// email küldése a vásárlónak a státusz változásáról
		$aOrder = $oOrderDao->getOrder($iIdOrder);
		$sMessage = Output::render('_email_status', getLayoutVars() + array(
			'shipping_status' => $aVars['shipping_status'],
			'payment_status'  => $aVars['payment_status'],
			'productlist'     => $oOrderDao->getProductlist($iIdOrder),
		));
		mymail($aOrder['email'], 'Order status', $sMessage, $GLOBALS['siteconfig']['out_email'], $GLOBALS['siteconfig']['out_email_name']);

		return Output::json($aRes);
	}


	private function _corsHeader() {
		if ($_SERVER['REQUEST_METHOD'] == 'OPTIONS') {
			if (isset($_SERVER['HTTP_ACCESS_CONTROL_REQUEST_METHOD']))
				header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS");         

			if (isset($_SERVER['HTTP_ACCESS_CONTROL_REQUEST_HEADERS']))
				header("Access-Control-Allow-Headers: {$_SERVER['HTTP_ACCESS_CONTROL_REQUEST_HEADERS']}");
		}
	}
	/**
	 * A megrendeléssel kapcsolatos webszolgáltatások
	 *   GET    /order/              List of all orders
	 *   GET    /order/{idOrder}     Details of an order
	 *   PUT    /order/{idOrder}     Modify an order
	 *
	 * @param  int $idOrder          Optional
	 *
	 * @return json
	 */
	protected function _reqDefault($iIdOrder=0) {
		$oShopDao =& DaoFactory::getDao('shop');
		$aShop = $oShopDao->getShopByPermalink($GLOBALS['siteconfig']['shop_permalink']);
		$iIdShop = $aShop['id_shop'];

		$oOrderDao =& DaoFactory::getDao('order');
		//var_dump($oShopDao);
		//var_dump($oOrderDao);
		switch (Request::getRequestMethod()) {
			case 'GET':
				$aOrderList = $oOrderDao->getActiveOrderListByIdShop($iIdShop);
				$this->_corsHeader();
				return Output::json($aOrderList);
				break;
		}

/*
		$aVars = Request::getRequestVars();
		if (empty($iIdOrder)) {
			switch (Request::getRequestMethod()) {
				case 'GET':
					return Output::render('order', getLayoutVars());
					break;
			}
		} else {
			if (!$this->isOwner($iIdOrder)) showErrorPage(403);
			switch (Request::getRequestMethod()) {
				case 'PUT':
					if (array_key_exists('shipping_status', $aVars) || array_key_exists('payment_status', $aVars)) return $this->_wsUpdatestatus($iIdOrder, $aVars);
					break;
			}
		}
*/
	}
}
?>