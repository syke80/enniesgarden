<?php
class UserModule extends Module {
	protected function _access($sMethodName) {
		$oUserauth =& ModuleFactory::getModule('userauth');
		return $oUserauth->access('shop_admin');
	}

	public function path() {
		return array(
			'user' => array(
				'method'      => 'default',
			),
			'user/add' => array(
				'method'      => 'add',
			),
			'user/edit' => array(
				'method'      => 'edit',
			),
			'user/list' => array(
				'method'      => 'list',
			),
			'user/delete' => array(
				'method'      => 'delete',
			),
		);
	}

	/**
	 * Megvizsgálja a bejelentkezett felhasználó hozzáférését
	 * a paraméterben megadott felhasználóhoz.
	 * Ha ugyanahhoz a shophoz tartoznak, akkor TRUE.
	 *
	 * @param  integer  $iIdUser  A felhasználó azonosítója
	 *
	 * @return bool     TRUE ha van hozzá joga, FALSE ha nincs
	 */
	public function isOwner($iIdUser) {
		$oUserauth =& ModuleFactory::getModule('userauth');
		if ($oUserauth->access('root')) return TRUE;

		$oUserDao =& DaoFactory::getDao('user');
		// Ha a megadott id hibás, akkor FALSE a visszatérési érték
		$aUser = $oUserDao->getUser($iIdUser);
		if (empty($aUser)) return FALSE;

		$aLoggedinUser = $oUserauth->getUser();
		return $aUser['id_shop'] == $aLoggedinUser['id_shop'];
	}

	/**
	 * Rendereli a felvitel oldalt.
	 *
	 * @return string   A generált oldal tartalma
	 */
	protected function _reqAdd() {
		$oShopDao =& DaoFactory::getDao('shop');

		return Output::render('user_add', getLayoutVars() + array(
			'shoplist' => $oShopDao->getShopList()
		));
	}

	/**
	 * Rendereli a "felhasználók listája" boxot
	 *
	 * @return string   A generált oldal tartalma
	 */
	protected function _reqList() {
		$oUserDao =& DaoFactory::getDao('user');

		$oUserauth =& ModuleFactory::getModule('userauth');
		$aLoggedinUser = $oUserauth->getUser();
		$aUserList = $oUserauth->access('root') ? $oUserDao->getUserList() : $oUserDao->getUserList($aLoggedinUser['id_shop']);

		return Output::render('user_list', getLayoutVars() + array(
			'list' => $aUserList
		));
	}

	/**
	 * Rendereli a szerkesztés oldalt
	 *
	 * @param  int      $iIdUser
	 *
	 * @return string   A generált oldal tartalma
	 */
	protected function _reqEdit($iIdUser) {
		if (!isset($iIdUser)) showErrorPage(404);
		$aVars = Request::getRequestVars();
		if (!$this->isOwner($iIdUser)) showErrorPage(403);

		$oUserDao =& DaoFactory::getDao('user');
		$oShopDao =& DaoFactory::getDao('shop');
		return Output::render('user_edit', getLayoutVars() + array(
			'info' => $oUserDao->getUser($iIdUser),
			'shoplist' => $oShopDao->getShopList()
		));
	}

	/**
	 * Rendereli a törlés oldalt
	 *
	 * @param  int      $iIdUser
	 *
	 * @return string   A generált oldal tartalma
	 */
	protected function _reqDelete($iIdUser) {
		if (!isset($iIdUser)) showErrorPage(404);
		$aVars = Request::getRequestVars();
		if (!$this->isOwner($iIdUser)) showErrorPage(403);

		$oUserDao =& DaoFactory::getDao('user');

		return Output::render('user_delete', getLayoutVars() + array(
			'info' => $oUserDao->getUser($iIdUser)
		));
	}

	/**
	 * A felhasználóval kapcsolatos webszolgáltatások
	 *   GET    /user                Rendereli a felhasználó admin index oldalát
	 *   PUT    /user                Létrehoz egy felhasználót
	 *   PUT    /user/{id_user}      Módosítja a felhasználó adatait
	 *   DELETE /user/{id_user}      Törli a felhasználót
	 *
	 * @param  int $iIdUser          Opcionális: A felhasználó azonosítója
	 *
	 * @return string|json           GET esetén a generált oldal tartalma
	 *                               PUT / POST / DELETE esetén a feldolgozás közben bekövetkező hibák
	 */
	protected function _reqDefault($iIdUser=0) {
		$aVars = Request::getRequestVars();
		if (empty($iIdUser)) {
			switch (Request::getRequestMethod()) {
				case 'GET':
					return Output::render('user', getLayoutVars());
					break;
				case 'PUT':
					$aRequiredVars = array('username', 'name', 'passw', 'passw2', 'email', 'access', 'id_shop');
					if (array_keys_exists($aRequiredVars, $aVars)) return $this->_wsAdd($aVars);
					break;
			}
		} else {
			if (!$this->isOwner($aVars['id_user'])) showErrorPage(403);
			switch (Request::getRequestMethod()) {
				case 'PUT':
					$aRequiredVars = array('username', 'name', 'passw', 'passw2', 'email', 'access', 'id_shop');
					if (array_keys_exists($aRequiredVars, $aVars)) return $this->_wsEdit($iIdUser, $aVars);
					break;
				case 'DELETE':
					return $this->_wsDelete($iIdUser, $aVars);
					break;
			}
		}
	}

	/**
	 * Webszolgáltatás: felhasználó létrehozása
	 *
	 * @param  array    $aVars  A formból beérkező változók:
	 *                          username, name, email access, id_shop, passw, passw2 (MD5 hashelve)
	 *
	 * @return json     A feldolgozás közben bekövetkező hibák
	 */
	private function _wsAdd($aVars) {
		// Változó(k)hoz való jogosultság ellenőrzése
		$oShop =& ModuleFactory::getModule('shop');
		if (!$oShop->isOwner($aVars['id_shop'])) showErrorPage(403);

		$aVars = cleanValues($aVars);
		$aRes['error'] = array();

		$oUserDao =& DaoFactory::getDao('user');

		// Kötelezően kitöltendő mezők ellenőrzése
		if (empty($aVars['username'])) $aRes['error'][] = 'empty_username';
		if (empty($aVars['name'])) $aRes['error'][] = 'empty_name';
		if (empty($aVars['passw'])) $aRes['error'][] = 'empty_passw';
		if (empty($aVars['email'])) $aRes['error'][] = 'empty_email';
		if ($aVars['passw'] != $aVars['passw2']) $aRes['error'][] = 'error_passw';
		if (($aVars['access'] != 'root') && empty($aVars['id_shop'])) $aRes['error'][] = 'empty_shop';
		if (!empty($aRes['error'])) {
			return Output::json($aRes);
		}

		// Unique mezők ellenőrzése
		$aUser = $oUserDao->getUserByUsername($aVars['username']);
		if (!empty($aUser)) { $aRes['error'][] = 'already_username'; return Output::json($aRes); }

		$aRes['id_user'] = $oUserDao->insertUser(
			$aVars['username'], $aVars['name'], $aVars['passw'], $aVars['email'], $aVars['access'], $aVars['id_shop']);

		return Output::json($aRes);
	}

	/**
	 * Webszolgáltatás: felhasználó szerkesztése
	 *
	 * @param  int      $iIdUser  A felhasználó azonosítója
	 * @param  array    $aVars    A formból beérkező változók:
	 *                            username, name, email access, id_shop, passw, passw2 (MD5 hashelve)
	 *
	 * @return json     A feldolgozás közben bekövetkező hibák
	 */
	private function _wsEdit($iIdUser, $aVars) {
		// Változó(k)hoz való jogosultság ellenőrzése
		$oShop =& ModuleFactory::getModule('shop');
		if (!$oShop->isOwner($aVars['id_shop'])) showErrorPage(403);

		$aVars = cleanValues($aVars);
		$aRes['error'] = array();

		$oUserDao =& DaoFactory::getDao('user');

		if (empty($aVars['username'])) $aRes['error'][] = 'empty_username';
		if (empty($aVars['name'])) $aRes['error'][] = 'empty_name';
		if (empty($aVars['email'])) $aRes['error'][] = 'empty_email';
		if ($aVars['passw'] != $aVars['passw2']) $aRes['error'][] = 'error_passw';
		if (($aVars['access'] != 'root') && empty($aVars['id_shop'])) $aRes['error'][] = 'empty_shop';
		if (!empty($aRes['error'])) {
			return Output::json($aRes);
		}

		// Unique mezők ellenőrzése
		$aUser = $oUserDao->getUserByUsername($aVars['username']);
		if (!empty($aUser) && $aUser['id_user'] != $iIdUser) {
			$aRes['error'][] = 'already_username';
			return Output::json($aRes);
		}

		$oUserDao->updateUser(
			$iIdUser, $aVars['username'], $aVars['name'], $aVars['passw'], $aVars['email'],
			$aVars['access'], $aVars['id_shop']
		);

		return Output::json($aRes);
	}

	/**
	 * Webszolgáltatás: felhasználó törlése
	 *
	 * @param  int      $iIdUser  A felhasználó azonosítója
	 *
	 * @return json     Üres error tömb (nincs hibalehetőség)
	 */
	private function _wsDelete($iIdUser) {
		$aRes['error'] = array();

		$oUserDao =& DaoFactory::getDao('user');
		$oUserDao->deleteUser($iIdUser);

		return Output::json($aRes);
	}
}
?>