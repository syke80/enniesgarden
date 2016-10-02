<?php
class UserauthModule extends Module {
	/**
	 * Ha létezik a session, akkor ellenőrizni kell a sessionlopás miatt mentett adatokat
	 *
	 * @return void
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
			'userauth' => array(
				'method'      => 'default',
			),
			'userauth/login' => array(
				'method'      => 'login',
			),
			'userauth/logout' => array(
				'method'      => 'logout',
			),
		);
	}

	protected function _access($sMethodName) {
		return TRUE;
	}

	/**
	 * Megvizsgálja hogy be van-e jelentkezve a felhasználó
	 *
	 * @return bool     TRUE ha be van jelentkezve, FALSE ha nincs
	 */
	public function isLoggedIn() {
		return isset($_SESSION['user']['id_user']);
	}

	/**
	 * Kilépteti a bejelentkezett felhasználót
	 *
	 * @return void
	 */
	public function logout() {
		session_unset();
		session_destroy();
	}

	/**
	 * Lekérdezi a bejelentkezett felhasználó adatait
	 *
	 * @return array|NULL
	 */
	public function getUser() {
		return $this->isLoggedIn() ? $_SESSION['user'] : NULL;
	}

	/**
	 * Összehasonlítja a bejelentkezett felhasználó jogosultsági szintjét a paraméterben megadott szinttel
	 *
	 * A jogosultságok sorrendje a /config.php-ben van definiálva
	 *
	 * @param  string   $sAccess    A szükséges jogosultság ('stock_admin', 'shop_admin', etc.)
	 *
	 * @return bool     TRUE ha a felhasználónak legalább akkora a jogosultsági szintje mint a paraméterben megadott
	 *                  FALSE ha kisebb
	 */
	public function access($sAccess) {
		return $this->isLoggedIn() ? ($_SESSION['user']['access_value'] >= $GLOBALS['siteconfig']['access'][$sAccess]) : FALSE;
	}

	/**
	 * Rendereli a logout ("Sikeres kijelentkezés") oldalt.
	 * Ha be van jelentkezve a felhasználó, akkor átirányítja a főoldalra.
	 *
	 * @return string   A generált oldal tartalma
	 */
	protected function _reqLogout() {
		if ($this->isLoggedIn()) Request::redirect($GLOBALS['siteconfig']['site_url']);
		return Output::render('userauth_logout', getLayoutVars());
	}

	/**
	 * Rendereli a login oldalt.
	 * Ha már be van jelentkezve a felhasználó, akkor átirányítja a főoldalra.
	 *
	 * @return string   A generált oldal tartalma
	 */
	protected function _reqLogin() {
		if ($this->isLoggedIn()) Request::redirect($GLOBALS['siteconfig']['site_url']);
		return Output::render('userauth', getLayoutVars());
	}

	/**
	 * A felhasználó autentikációval kapcsolatos webszolgáltatások
	 *   GET    /userauth            Rendereli a login oldalt
	 *   PUT    /userauth            Belépteti a felhasználót, beállítja az aktuális boltot (root esetén)
	 *   DELETE /userauth            Kilépteti a felhasználót
	 *
	 * @return string|json           GET esetén a generált oldal tartalma
	 *                               PUT / DELETE esetén a feldolgozás közben bekövetkező hibák
	 */
	protected function _reqDefault() {
		$aVars = Request::getRequestVars();
		switch (Request::getRequestMethod()) {
			case 'GET':
				Request::redirect("{$GLOBALS['siteconfig']['site_url']}/userauth/login");
				break;
			case 'PUT':
				$aRequiredVars = array('id_shop');
				if (array_keys_exists($aRequiredVars, $aVars)) return $this->_wsSetIdShop($aVars);
				$aRequiredVars = array('username', 'passw');
				if (array_keys_exists($aRequiredVars, $aVars)) return $this->_wsLogin($aVars);
				break;
			case 'DELETE':
				return $this->_wsLogout();
				break;
		}
	}

	/**
	 * Webservice, ami belépteti a felhasználót
	 *
	 * @param  array      $aVars      A formból beérkező változók:
	 *                                username, passw MD5 hashelve
	 *
	 * @return json       A beléptetés közben bekövetkező hibák
	 */
	private function _wsLogin($aVars) {
		$aRes['error'] = array();

		$oUserDao =& DaoFactory::getDao('user');

		// Felhasználó beléptetése
		$_SESSION['user'] = $oUserDao->getUserByUsernamePassword($aVars['username'], $aVars['passw']);

		if (empty($_SESSION['user'])) {
			$aRes['error'][] = 'user_auth';
			return Output::json($aRes);
		}

		if ($_SESSION['user']['access'] == 'inactive') {
			$this->logout();
			$aRes['error'][] = 'user_inactive';
		}

		if ($_SESSION['user']['access'] == 'disabled') {
			$this->logout();
			$aRes['error'][] = 'user_disabled';
		}
		
		// Access value beállítása (a szintek egymás alá-fölé vannak rendelve, mindegyikhez tartozik egy érték, ami a config.sys-ben van meghatározva)
		$_SESSION['user']['access_value'] = $GLOBALS['siteconfig']['access'][$_SESSION['user']['access']];

		// Néhány adat a felhasználó azonosításágoz session lopás ellen
		$_SESSION['user_agent'] = $_SERVER['HTTP_USER_AGENT'];
		$_SESSION['remote_addr'] = $_SERVER['REMOTE_ADDR'];

		return Output::json($aRes);
	}

	/**
	 * Webservice, ami kilépteti a bejelentkezett felhasználót
	 *
	 * @return json   Üres error tömb (nincs hibalehetőség)
	 */
	private function _wsLogout() {
		$aRes['error'] = array();
		$this->logout();
		return Output::json($aRes);
	}

	/**
	 * Webservice, ami beállítja hogy melyik shop jelenjen meg a rootnak
	 *
	 * @return json   Üres error tömb (nincs hibalehetőség)
	 */
	private function _wsSetIdShop($aVars) {
		$aRes['error'] = array();
		if (!$this->access('root')) showErrorPage(403);

		$_SESSION['user']['id_shop'] = $aVars['id_shop'];
		return Output::json($aRes);
	}
}
?>