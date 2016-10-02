<?php
class ProductPhotoModule extends Module {
	/**
	 * Jogosultság ellenőrzése
	 */
	protected function _access($sMethodName) {
		$oUserauth =& ModuleFactory::getModule('userauth');
		return $oUserauth->access('stock_admin');
	}

	public function path() {
		return array(
			'product_photo' => array(
				'method'      => 'default',
			),
			'product_photo/list' => array(
				'method'      => 'list',
			),
		);
	}

	/**
	 * Megvizsgálja a bejelentkezett felhasználó hozzáférését
	 * a paraméterben megadott képhez.
	 * Ha a felhasználó boltjának egy termékéhez tartozik a kép, akkor TRUE.
	 *
	 * @param  integer  $iIdPhoto  A kép azonosítója
	 *
	 * @return bool     TRUE ha van hozzá joga, FALSE ha nincs
	 */
	public function isOwner($iIdPhoto) {
		$oUserauth =& ModuleFactory::getModule('userauth');
		if ($oUserauth->access('root')) return TRUE;

		$oPhotoDao =& DaoFactory::getDao('product_photo');
		// Ha a megadott id hibás, akkor FALSE a visszatérési érték
		$aPhoto = $oPhotoDao->getPhoto($iIdPhoto);
		if (empty($aPhoto)) return FALSE;

		$oProductModule = ModuleFactory::getModule('product');
		return $oProductModule->isOwner($aPhoto['id_product']);
	}

	/**
	 * Töröl egy termékképet (minden méretben) a tárhelyről
	 *
	 * @param  array  $aPhoto  A kép adatai (az adatbázisból)
	 *
	 * @return void
	 */
	public function unlinkPhoto($aPhoto) {
		unlink(DIR_FILES."/product/original/{$aPhoto['filename']}");
		$iThousands = floor($aPhoto['id_photo'] / 1000);
		rrmdir(DIR_FILES.'/product/resized/'.($i*1000).'-'.(($iThousands+1)*1000-1).'/'.$aPhoto['id_photo']);
	}

	/**
	 * Termékképeket töröl (minden méretben) a tárhelyről
	 *
	 * @param  array  $aPhotoList  A képek listája (az adatbázisból)
	 *
	 * @return void
	 */
	public function unlinkPhotoList($aPhotoList) {
		foreach ($aPhotoList as $aPhoto) {
			$this->unlinkPhoto($aPhoto);
		}
	}

	/**
	 * Rendereli a "képek listája"  boxot
	 *
	 * @return string   A generált oldal tartalma
	 */
	protected function _reqList($iIdProduct) {
		if (!isset($iIdProduct)) showErrorPage(404);

		$oProductDao =& DaoFactory::getDao('product');
		$oPhotoDao =& DaoFactory::getDao('product_photo');

		return Output::render('product_photo_list', getLayoutVars() + array(
			'productinfo' => $oProductDao->getProductFull($iIdProduct),
			'list' => $oPhotoDao->getPhotoListByIdProduct($iIdProduct)
		));
	}

	/**
	 * A képekkel kapcsolatos webszolgáltatások
	 *   POST   /product_photo               Létrehoz egy termékképet (feltölti a szerverre, beírja az adatbázisba)
	 *   POST   /product_photo               Beállítja az "order" POST paraméterben kapott sorrendet
	 *   DELETE /product_photo/{id_order}    Törli a termékképet
	 *
	 * @param  int $iIdPhoto         Opcionális: A termékkép azonosítója
	 *
	 * @return string|json           GET esetén a generált oldal tartalma
	 *                               PUT / POST / DELETE esetén a feldolgozás közben bekövetkező hibák
	 */
	protected function _reqDefault($iIdPhoto=0) {
		$aVars = Request::getRequestVars();
		if (empty($iIdPhoto)) {
			switch (Request::getRequestMethod()) {
				case 'POST':
					$aRequiredVars = array('id_product');
					if (array_keys_exists($aRequiredVars, $aVars) && array_key_exists('uploadfile', $_FILES)) {
						return $this->_wsAdd($aVars, $_FILES);
					}

					$aRequiredVars = array('id_product', 'uploadurl');
					if (array_keys_exists($aRequiredVars, $aVars)) {
						return $this->_wsDownload($aVars, $_FILES);
					}

					$aRequiredVars = array('order');
					if (array_keys_exists($aRequiredVars, $aVars)) {
						return $this->_wsOrder($aVars);
					}
					break;
			}
		} else {
			switch (Request::getRequestMethod()) {
				case 'DELETE':
					return $this->_wsDelete($iIdPhoto);
					break;
			}
		}
	}

	/**
	 * Webszolgáltatás: termékkép létrehozása
	 *
	 * @param  array    $aVars  A formból beérkező változó:
	 *                          id_product
	 * @param  array    $_FILES
	 *
	 * @return json     A feldolgozás közben bekövetkező hibák
	 */
	private function _wsAdd($aVars, $aFiles) {
		$aRes['error'] = array();
		
		if (!file_exists((DIR_FILES."/product/original"))) mkdir(DIR_FILES."/product/original", 0777, TRUE);

		$oProductDao =& DaoFactory::getDao('product');
		$oPhotoDao =& DaoFactory::getDao('product_photo');

		$aProductInfo = $oProductDao->getProductFull($aVars['id_product']);

		if (empty($_FILES['uploadfile']['tmp_name']) || !file_exists($_FILES['uploadfile']['tmp_name'])) {
			$aRes['error'][] = 'error_upload';
			return Output::json($aRes);
		}

		// Beírás az adatbázisba (egyelőre név nélkül, mert a filenév majd az id alapján lesz generálva: {id}.jpg|{id}.png)
		$aRes['id_photo'] = $oPhotoDao->insertPhoto($aVars['id_product'], '');

		// Kép másolása a megfelelő helyre. A filenév a kép azonosítója lesz. Pl.: {id_photo}.jpg.
		switch ($_FILES['uploadfile']['type']) {
			case 'image/jpeg':
				$sFilename = "{$aRes['id_photo']}.jpg";
				break;
			case 'image/png':
				$sFilename = "{$aRes['id_photo']}.png";
				break;
		}
		move_uploaded_file($_FILES['uploadfile']['tmp_name'], DIR_FILES."/product/original/".$sFilename);
		
		// Kép nevének tárolása az adatbázisban
		$oPhotoDao->renamePhoto($aRes['id_photo'], $sFilename);
		
		return Output::json($aRes);
	}

	/**
	 * Webszolgáltatás: termékkép létrehozása, letöltése külső URL-ről
	 *
	 * @param  array    $aVars  A formból beérkező változó:
	 *                          id_product, uploadurl
	 * @param  array    $_FILES
	 *
	 * @return json     A feldolgozás közben bekövetkező hibák
	 */
	private function _wsDownload($aVars, $aFiles) {
		$aRes['error'] = array();
		
		if (!file_exists((DIR_FILES."/product/original"))) mkdir(DIR_FILES."/product/original", 0777, TRUE);

		$oProductDao =& DaoFactory::getDao('product');
		$oPhotoDao =& DaoFactory::getDao('product_photo');

		$aProductInfo = $oProductDao->getProductFull($aVars['id_product']);

		$data = file_get_contents($aVars['uploadurl']);
		if (empty($data)) {
			$aRes['error'][] = 'error_url';
			return Output::json($aRes);
		}

		// Beírás az adatbázisba (egyelőre név nélkül, mert a filenév majd az id alapján lesz generálva: {id}.jpg|{id}.png)
		$aRes['id_photo'] = $oPhotoDao->insertPhoto($aVars['id_product'], '');

		// Kép másolása a megfelelő helyre. A filenév a kép azonosítója lesz. Pl.: {id_photo}.jpg.
		switch (getImageMimeType($data)) {
			case 'image/jpeg':
				$sFilename = "{$aRes['id_photo']}.jpg";
				break;
			case 'image/png':
				$sFilename = "{$aRes['id_photo']}.png";
				break;
		}
		file_put_contents(DIR_FILES."/product/original/".$sFilename, $data);
		
		// Kép nevének tárolása az adatbázisban
		$oPhotoDao->renamePhoto($aRes['id_photo'], $sFilename);
		
		return Output::json($aRes);
	}

	/**
	 * Webszolgáltatás: termékkép létrehozása
	 *
	 * @param  array    $aVars  A formból beérkező változó:
	 *                          order: egy serializált tömb, ami termékképek azonosítóit tartalmazza
	 *                                 a változóban szereplő sorrendet rendeli hozzá a képekhez
	 *
	 * @return json     A feldolgozás közben bekövetkező hibák
	 */
	private function _wsOrder($aVars) {
		$aRes['error'] = array();

		$oPhotoDao =& DaoFactory::getDao('product_photo');

		parse_str($aVars['order']);  // ez a változó tartalmazza a $photo tömböt serializált formában
		$oPhotoDao->setOrder($photo);
		return Output::json($aRes);
	}

	/**
	 * Webszolgáltatás: termékkép törlése
	 *
	 * @param  int      $iIdPhoto  A kép azonosítója
	 *
	 * @return json     Üres error tömb (nincs hibalehetőség)
	 */
	private function _wsDelete($iIdPhoto) {
		$aRes['error'] = array();

		$oPhotoDao =& DaoFactory::getDao('product_photo');
		$aPhoto = $oPhotoDao->getPhoto($iIdPhoto);

/*
		// Szükség lesz a termékinfora, hogy megtaláljuk az átméretezett képek helyét
		$oProductDao =& DaoFactory::getDao('product');
		$aProductInfo = $oProductDao::getProductFull($aPhoto['id_product']);
	*/

		$this->unlinkPhoto($aPhoto);
		$oPhotoDao->deletePhoto($iIdPhoto, $aPhoto['id_product']);

		return Output::json($aRes);
	}
}
?>