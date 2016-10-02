<?php
class ProductPhotoDao extends Dao {
	/**
	 * Egy kép adatai
	 *
	 * @param  integer  $iIdPhoto
	 *
	 * @return array
	 */
	public function getPhoto($iIdPhoto) {
		return $this->rConnection->getRow("
			SELECT *
			FROM product_photo
			WHERE id_photo = :0
		", func_get_args());
	}

	/**
	 * Egy termékhez tartozó képek listája
	 *
	 * @param integer $iIdProduct
	 *
	 * @return array
	 */
	public function getPhotoListByIdProduct($iIdProduct) {
		return $this->rConnection->getList("
			SELECT *
			FROM product_photo
			WHERE id_product = :0
			ORDER BY product_photo.order
		", func_get_args());
	}

	/**
	 * Egy kategória termékeihez tartozó képek listája
	 *
	 * @param integer $iIdCategory
	 *
	 * @return array
	 */
	public function getPhotoListByIdCategory($iIdCategory) {
		return $this->rConnection->getList("
			SELECT *
			FROM product_photo
			INNER JOIN product
			ON product_photo.id_product = product.id_product
			WHERE product.id_category = :0
			", func_get_args());
	}

	/**
	 * Egy bolt termékeihez tartozó képek listája
	 *
	 * @param integer $iIdShop
	 *
	 * @return array
	 */
	public function getPhotoListByIdShop($iIdShop) {
		return $this->rConnection->getList("
			SELECT *
			FROM product_photo
			INNER JOIN product
			ON product_photo.id_product = product.id_product
			INNER JOIN category
			ON product.id_category = category.id_category
			WHERE category.id_shop=:0
		", func_get_args());
	}

	/**
	 * Beírja az adatbázisba a feltöltött képhez tartozó adatokat
	 *
	 * @param  integer   $iIdProduct  A termék azonosítója, amihez a kép tartozik
	 * @param  string    $sFilename   A kép neve
	 *
	 * @return array
	 */
	public function insertPhoto($iIdProduct, $sFilename) {
		return $this->rConnection->insert('
			INSERT INTO product_photo (id_product, filename, product_photo.order)
			SELECT :0, :1, IFNULL(MAX(product_photo.order) + 1, 0) FROM product_photo WHERE id_product = :0
		', func_get_args());
	}

	/**
	 * Kép törlése az adatbázisból
	 *
	 * @param  integer  $iIdPhoto
	 *
	 * @return array
	 */
	public function deletePhoto($iIdPhoto) {
		$aPhotoInfo = $this->getPhoto($iIdPhoto);
		$this->rConnection->execute("
			DELETE FROM product_photo
			WHERE id_photo=:0
		", func_get_args());

		// az order field újra sorszámozása
		$this->rConnection->execute("
			UPDATE product_photo
			SET product_photo.order = product_photo.order - 1
			WHERE id_product=:0
			AND product_photo.order>:1
		", array($aPhotoInfo['id_product'],$aPhotoInfo['order']));
	}

	/**
	 * Képek sorrendjének beállítása
	 *
	 * @param  array  $aPhotoList
	 *                A tömb kulcsai a sorszámok
	 *                A tömb elemei a kép azonosítóját tartalmazzák
	 *
	 * @return array
	 */
	public function setOrder($aPhotoList) {
		// NULL-ra állítja a képek sorszámát, hogy sorszámozás közben ne legyen ütközés a kettős kulcsok miatt
		$aPhotoListSQL = array();
		foreach ($aPhotoList as $iOrder => $iIdPhoto) {
			$aPhotoListSQL[] = ":{$iIdPhoto}";
		}
		$sIdPhotoList = implode(',', $aPhotoList);
		$this->rConnection->execute("UPDATE product_photo SET product_photo.order=NULL WHERE id_photo IN ({$sIdPhotoList})", $aPhotoList);
		foreach ($aPhotoList as $iOrder => $iIdPhoto) {
			$this->rConnection->execute('
				UPDATE product_photo
				SET product_photo.order=:1
				WHERE id_photo=:0
			', array($iIdPhoto, $iOrder));
		}
	}
}
?>