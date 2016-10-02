<?php
class PackPhotoDao extends Dao {
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
			FROM pack_photo
			WHERE id_photo = :0
		", func_get_args());
	}

	/**
	 * Egy csomaghoz tartozó képek listája
	 *
	 * @param integer $iIdPack
	 *
	 * @return array
	 */
	public function getPhotoListByIdPack($iIdPack) {
		return $this->rConnection->getList("
			SELECT *
			FROM pack_photo
			WHERE id_pack = :0
			ORDER BY pack_photo.order
		", func_get_args());
	}


	/**
	 * Egy bolt csomagjaihoz tartozó képek listája
	 *
	 * @param integer $iIdShop
	 *
	 * @return array
	 */
	public function getPhotoListByIdShop($iIdShop) {
		return $this->rConnection->getList("
			SELECT *
			FROM pack_photo
			INNER JOIN pack
			ON pack_photo.id_pack = pack.id_pack
			WHERE pack.id_shop=:0
		", func_get_args());
	}

	/**
	 * Beírja az adatbázisba a feltöltött képhez tartozó adatokat
	 *
	 * @param  integer   $iIdPack     A csomag azonosítója, amihez a kép tartozik
	 * @param  string    $sFilename   A kép neve
	 *
	 * @return array
	 */
	public function insertPhoto($iIdPack, $sFilename) {
		return $this->rConnection->insert('
			INSERT INTO pack_photo (id_pack, filename, pack_photo.order)
			SELECT :0, :1, IFNULL(MAX(pack_photo.order) + 1, 0) FROM pack_photo WHERE id_pack = :0
		', func_get_args());
	}

	/**
	 * Módosítja a képhez tartozó fájlnevet
	 *
	 * @param  integer   $iIdPhoto    A kép azonosítója
	 * @param  string    $sFilename   A kép neve
	 *
	 * @return array
	 */
	public function renamePhoto($iIdPhoto, $sFilename) {
		return $this->rConnection->execute('
			UPDATE pack_photo
			SET filename = :1
			WHERE id_photo = :0
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
			DELETE FROM pack_photo
			WHERE id_photo=:0
		", func_get_args());

		// az order field újra sorszámozása
		$this->rConnection->execute("
			UPDATE pack_photo
			SET pack_photo.order = pack_photo.order - 1
			WHERE id_pack=:0
			AND pack_photo.order>:1
		", array($aPhotoInfo['id_pack'], $aPhotoInfo['order']));
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
		$this->rConnection->execute("UPDATE pack_photo SET pack_photo.order=NULL WHERE id_photo IN ({$sIdPhotoList})", $aPhotoList);
		foreach ($aPhotoList as $iOrder => $iIdPhoto) {
			$this->rConnection->execute('
				UPDATE pack_photo
				SET pack_photo.order=:1
				WHERE id_photo=:0
			', array($iIdPhoto, $iOrder));
		}
	}
}
?>