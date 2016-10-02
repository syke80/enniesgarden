<?php
class GalleryDao extends Dao {
	/**
	 * Egy kép adatai
	 *
	 * @param  integer  $iIdImage
	 *
	 * @return array
	 */
	public function getImage($iIdImage) {
		return $this->rConnection->getRow("
			SELECT *
			FROM gallery_image
			WHERE id_gallery_image = :0
		", func_get_args());
	}

	/**
	 * Egy shop galeria képeinek a listája
	 *
	 * @param integer $iIdShop
	 *
	 * @return array
	 */
	public function getImageList($iIdShop) {
		return $this->rConnection->getList("
			SELECT *
			FROM gallery_image
			WHERE id_shop=:0
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
	public function insertImage($iIdShop, $sFilename, $sTitle) {
		return $this->rConnection->insert('
			INSERT INTO gallery_image (id_shop, filename, title)
			VALUES (:0, :1, :2)
		', func_get_args());
	}


	/**
	 * Kép nevenek modositasa
	 *
	 * @param  integer  $iIdImage
	 *
	 * @return array
	 */
	public function updateTitle($iIdImage, $sTitle) {
		$this->rConnection->execute("
			UPDATE gallery_image
			SET title=:1
			WHERE id_gallery_image=:0
		", func_get_args());
	}

	/**
	 * Kép törlése az adatbázisból
	 *
	 * @param  integer  $iIdImage
	 *
	 * @return array
	 */
	public function delete($iIdImage) {
		$this->rConnection->execute("
			DELETE FROM gallery_image
			WHERE id_gallery_image=:0
		", func_get_args());
	}

}
?>