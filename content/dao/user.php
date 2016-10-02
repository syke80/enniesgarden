<?php
class UserDao extends Dao {
	/**
	 * Felhasználók listája
	 *
	 * @param  integer $iIdShop  Opcionális:
	 *                           Ha meg van adva, akkor a bolthoz tartozó felhasználókat listázza.
	 *                           Ha nincs megadva, akkor az összeset.
	 *
	 * @return array
	 */
	public function getUserList($iIdShop=0) {
		$sFilter = empty($iIdShop) ? '' : "WHERE shop.id_shop = :iIdShop";

		return $this->rConnection->getList("
			SELECT
				user.*,
				shop.name AS shop_name
			FROM
				user
			LEFT JOIN
				shop
			ON
				user.id_shop = shop.id_shop
			{$sFilter}
		", array(
			'iIdShop' => $iIdShop
		));
	}

	/**
	 * Egy felhasználó adatai
	 *
	 * @param  integer  $iIdUser
	 *
	 * @return array
	 */
	public function getUser($iIdUser) {
		return $this->rConnection->getRow("
			SELECT
				user.*,
				shop.name AS shop_name
			FROM
				user
			LEFT JOIN
				shop
			ON
				user.id_shop = shop.id_shop
			WHERE
				id_user = :iIdUser
		", array(
			'iIdUser' => $iIdUser
		));
	}

	/**
	 * Egy felhasználó adatainak lekérdezése a neve alapján
	 *
	 * @param  string  $sUsername
	 *
	 * @return array
	 */
	public function getUserByUsername($sUsername) {
		return $this->rConnection->getRow("
			SELECT
				user.*,
				shop.name AS shop_name
			FROM
				user
			LEFT JOIN
				shop
			ON
				user.id_shop = shop.id_shop
			WHERE
				username = :sUsername
		", array(
			'sUsername' => $sUsername
		));
	}

	/**
	 * Egy felhasználó adatainak lekérdezése a neve és jelszava alapján
	 *
	 * @param  string  $sUsername  A felhasználó neve
	 * @param  string  $sPassw     A jelszó MD5 enkódolva
	 *
	 * @return array
	 */
	public function getUserByUsernamePassword($sUsername, $sPassw) {
		$res = $this->rConnection->getRow("
			SELECT
				user.*,
				shop.name AS shop_name
			FROM user
			LEFT JOIN shop
			ON user.id_shop = shop.id_shop
			WHERE username = :sUsername
			AND passw = :sPassw
		", array(
			'sUsername' => $sUsername,
			'sPassw' => $sPassw
		));
		
		return $res;
	}

	/**
	 * Felhasználó törlése
	 *
	 * @param  integer  $iIdUser
	 *
	 * @return void
	 */
	public function deleteUser($iIdUser) {
		$this->rConnection->execute("DELETE FROM user WHERE id_user={$iIdUser}");
	}

	/**
	 * Létrehoz egy felhasználót
	 *
	 * @param  string   $sUsername          A felhasználó login neve
	 * @param  string   $sName              A felhasználó neve
	 * @param  string   $sPassw             Jelszó MD5 enkódolva
	 * @param  string   $sEmail             Email cím
	 * @param  string   $sAccess            Jogosultság ('root','shop_admin','stock_admin','inacive','disabled')
	 * @param  integer  $iIdShop            A shop azonosítója amihez a felhasználó hozzáfér
	 *                                      (Root esetén nincs figyelembe véve az értéke)
	 *
	 * @return void
	 */
	public function insertUser($sUsername, $sName, $sPassw, $sEmail, $sAccess, $iIdShop) {
		if (empty($iIdShop)) $iIdShop = NULL;
		return $this->rConnection->insert('
			INSERT INTO user (
				username, name, passw, email, reg_timestamp, access, id_shop
			)
			VALUES (
				:sUsername, :sName, :sPassw, :sEmail, NOW(), :sAccess, :iIdShop
			)
		', array(
			'sUsername' => $sUsername,
			'sName' => $sName,
			'sPassw' => $sPassw,
			'sEmail' => $sEmail,
			'sAccess' => $sAccess,
			'iIdShop' => $iIdShop
		));
	}

	/**
	 * Módosítja egy felhasználó adatait
	 *
	 * @param  integer  $iIdUser            A felhasználó azonosítója
	 * @param  string   $sUsername          A felhasználó login neve
	 * @param  string   $sName              A felhasználó neve
	 * @param  string   $sPassw             Jelszó MD5 enkódolva
	 * @param  string   $sEmail             Email cím
	 * @param  string   $sAccess            Jogosultság ('root','shop_admin','stock_admin','inacive','disabled')
	 * @param  integer  $iIdShop            A shop azonosítója amihez a felhasználó hozzáfér
	 *                                      (Root esetén nincs figyelembe véve az értéke)
	 *
	 * @return void
	 */
	public function updateUser($iIdUser, $sUsername, $sName, $sPassw, $sEmail, $sAccess, $iIdShop) {
		if (empty($iIdShop)) $iIdShop = NULL;
		return $this->rConnection->execute("
			UPDATE user SET
				username = :sUsername,
				name = :sName,
				email = :sEmail,
				id_shop = :iIdShop
				".( empty($sPassw) ? '' : ", passw = :sPassw" )."
				".( empty($sAccess) ? '' : ", access= :sAccess" )."
			WHERE
				id_user = :iIdUser
		", array(
			'iIdUser' => $iIdUser,
			'sUsername' => $sUsername,
			'sName' => $sName,
			'sPassw' => $sPassw,
			'sEmail' => $sEmail,
			'sAccess' => $sAccess,
			'iIdShop' => $iIdShop
		));
	}

}
?>