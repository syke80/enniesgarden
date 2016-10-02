<?php
class OrderModule extends Module {
	protected function _access($sMethodName) {
		$oUserauth =& ModuleFactory::getModule('userauth');
		return $oUserauth->access('stock_admin');
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
	 * Megvizsgálja a bejelentkezett felhasználó hozzáférését
	 * a paraméterben megadott megrendeléshez.
	 * Ha a felhasználó boltjához tartozik a megrendelés, akkor TRUE.
	 *
	 * @param  integer  $iIdOrder  A megrendelés azonosítója
	 *
	 * @return bool     TRUE ha van hozzá joga, FALSE ha nincs
	 */
	public function isOwner($iIdOrder) {
		$oUserauth =& ModuleFactory::getModule('userauth');
		if ($oUserauth->access('root')) return TRUE;

		$oOrderDao =& DaoFactory::getDao('order');
		// Ha a megadott id hibás, akkor FALSE a visszatérési érték
		$aOrder = $oOrderDao->getOrder($iIdOrder);
		if (empty($aOrder)) return FALSE;

		$oUserauth =& ModuleFactory::getModule('userauth');
		$aLoggedinUser = $oUserauth->getUser();

		return $aOrder['id_shop'] == $aLoggedinUser['id_shop'];
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
	 * A megrendeléssel kapcsolatos webszolgáltatások
	 *   GET    /order               Rendereli a megrendelés admin index oldalát
	 *   PUT    /order/{id_order}    Módosítja a merdendelés státuszát
	 *
	 * @param  int $iIdOrder         Opcionális: A megrendelés azonosítója
	 *
	 * @return string|json           GET esetén a generált oldal tartalma
	 *                               PUT / POST / DELETE esetén a feldolgozás közben bekövetkező hibák
	 */
	protected function _reqDefault($iIdOrder=0) {
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
}
?>