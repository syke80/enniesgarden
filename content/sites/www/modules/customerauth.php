<?php
class CustomerauthModule extends Module {
	/**
	 * Ha létezik a session, akkor ellenőrizni kell a sessionlopás miatt mentett adatokat
	 *
	 * @return bool     TRUE ha be van jelentkezve, FALSE ha nincs
	 */
	public function __construct() {
		if (
			(isset($_SESSION['user_agent']) && $_SESSION['user_agent'] != $_SERVER['HTTP_USER_AGENT']) ||
			(isset($_SESSION['remote_addr']) && $_SESSION['remote_addr'] != $_SERVER['REMOTE_ADDR'] )
		) {
			$this->logout();
		}
	}

	public function path() {
		return array(
			'customerauth' => array(
				'method'      => 'default',
				'public'      => FALSE,
			),
			'logout' => array(
				'method'      => 'logout',
				'id_langauge' => 'en',
			),
			'kijelentkezes' => array(
				'method'      => 'logout',
				'id_langauge' => 'hu',
			),
		);
	}

	protected function _access($sMethodName) {
		return TRUE;
	}

	/**
	 * Megvizsgálja hogy be van-e jelentkezve a vásárló
	 *
	 * @return bool     TRUE ha be van jelentkezve, FALSE ha nincs
	 */
	public function isLoggedIn() {
		return isset($_SESSION['customer']);
	}

	/**
	 * Kilépteti a bejelentkezett vásárlót
	 *
	 * @return void
	 */
	public function logout() {
		session_unset();
		session_destroy();
	}

	/**
	 * Beléptet egy vásárlót az azonosítója alapján
	 *
	 * @param  string  $iIdCustomer  A vásárló azonosítója
	 *
	 * @return void
	 */
	public function setCustomer($iIdCustomer) {
		$oCustomerDao =& DaoFactory::getDao('customer');
		$_SESSION['customer'] = $oCustomerDao->getCustomer($iIdCustomer);

		// Néhány adat a felhasználó azonosításágoz session lopás ellen
		$_SESSION['user_agent'] = $_SERVER['HTTP_USER_AGENT'];
		$_SESSION['remote_addr'] = $_SERVER['REMOTE_ADDR'];
	}

	/**
	 * Lekérdezi a bejelentkezett vásárló adatait
	 *
	 * @return array|NULL
	 */
	public function getCustomer() {
		return $this->isLoggedIn() ? $_SESSION['customer'] : NULL;
	}

	/**
	 * Rendereli a logout ("Sikeres kijelentkezés") oldalt.
	 * Ha be van jelentkezve a vásárló, akkor átirányítja a főoldalra.
	 *
	 * @return string   A generált oldal tartalma
	 */
	protected function _reqLogout() {
		if ($this->isLoggedIn()) Request::redirect($GLOBALS['siteconfig']['site_url']);
		return Output::render('auth_logout', getLayoutVars());
	}

	/**
	 * A vásárló autentikációval kapcsolatos webszolgáltatások
	 *   PUT    /customerauth        Belépteti a felhasználót
	 *   DELETE /customerauth        Kilépteti a felhasználót
	 *
	 * @return string|json           A feldolgozás közben bekövetkező hibák
	 */
	protected function _reqDefault() {
		$aVars = Request::getRequestVars();
		switch (Request::getRequestMethod()) {
			case 'PUT':
				$aRequiredVars = array('email', 'passw');
				if (array_keys_exists($aRequiredVars, $aVars)) return $this->_wsLogin($aVars);
				break;
			case 'DELETE':
				return $this->_wsLogout();
				break;
		}
	}

	/**
	 * Webservice, ami belépteti a vásárlót
	 *
	 * @param  array      $aVars      A formból beérkező változók:
	 *                                username, passw MD5 hashelve
	 *
	 * @return json       A beléptetés közben bekövetkező hibák
	 */
	private function _wsLogin($aVars) {
		$aRes['error'] = array();

		$oCustomerDao =& DaoFactory::getDao('customer');

		// Vásárló beléptetése
		$_SESSION['customer'] = $oCustomerDao->getCustomerByShopEmailPassword($GLOBALS['siteconfig']['shop_permalink'], $aVars['email'], $aVars['passw']);
		if (empty($_SESSION['customer'])) {
			$aRes['error'][] = 'customer_auth';
			return Output::json($aRes);
		}

		// Néhány adat a felhasználó azonosításágoz session lopás ellen
		$_SESSION['user_agent'] = $_SERVER['HTTP_USER_AGENT'];
		$_SESSION['remote_addr'] = $_SERVER['REMOTE_ADDR'];

		return Output::json($aRes);
	}

	/**
	 * Webservice, ami kilépteti a bejelentkezett vásárlót
	 *
	 * @return json   Üres error tömb (nincs hibalehetőség)
	 */
	private function _wsLogout() {
		$aRes['error'] = array();
		$this->logout();
		return Output::json($aRes);
	}
}
?>