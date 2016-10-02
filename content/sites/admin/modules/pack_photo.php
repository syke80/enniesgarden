<?php
class PackPhotoModule extends Module {
	/**
	 * Jogosultság ellenőrzése
	 */
	protected function _access($sMethodName) {
		$oUserauth =& ModuleFactory::getModule('userauth');
		return $oUserauth->access('stock_admin');
	}

	public function path() {
		return array(
			'pack_photo' => array(
				'method'      => 'default',
			),
			'pack_photo/list' => array(
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

		$oPhotoDao =& DaoFactory::getDao('pack_photo');
		// Ha a megadott id hibás, akkor FALSE a visszatérési érték
		$aPhoto = $oPhotoDao->getPhoto($iIdPhoto);
		if (empty($aPhoto)) return FALSE;

		$oPackModule = ModuleFactory::getModule('pack');
		return $oPackModule->isOwner($aPhoto['id_pack']);
	}

	/**
	 * Töröl egy termékképet (minden méretben) a tárhelyről
	 *
	 * @param  array  $aPhoto  A kép adatai (az adatbázisból)
	 *
	 * @return void
	 */
	public function unlinkPhoto($aPhoto) {
		unlink(DIR_FILES."/pack/original/{$aPhoto['filename']}");
		$iThousands = floor($aPhoto['id_photo'] / 1000);
		rrmdir(DIR_FILES.'/pack/resized/'.($i*1000).'-'.(($iThousands+1)*1000-1).'/'.$aPhoto['id_photo']);
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
	protected function _reqList($iIdPack) {
		if (!isset($iIdPack)) showErrorPage(404);

		$oPackDao =& DaoFactory::getDao('pack');
		$oPhotoDao =& DaoFactory::getDao('pack_photo');

		return Output::render('pack_photo_list', getLayoutVars() + array(
			'packinfo' => $oPackDao->getPack($iIdPack),
			'list' => $oPhotoDao->getPhotoListByIdPack($iIdPack)
		));
	}

	/**
	 * A képekkel kapcsolatos webszolgáltatások
	 *   POST   /pack_photo               Létrehoz egy képet (feltölti a szerverre, beírja az adatbázisba)
	 *   POST   /pack_photo               Beállítja az "order" POST paraméterben kapott sorrendet
	 *   DELETE /pack_photo/{id_order}    Törli a képet
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
					$aRequiredVars = array('id_pack');
					if (array_keys_exists($aRequiredVars, $aVars) && array_key_exists('uploadfile', $_FILES)) {
						return $this->_wsAdd($aVars, $_FILES);
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
	 * Webszolgáltatás: kép létrehozása
	 *
	 * @param  array    $aVars  A formból beérkező változó:
	 *                          id_pack
	 * @param  array    $_FILES
	 *
	 * @return json     A feldolgozás közben bekövetkező hibák
	 */
	private function _wsAdd($aVars, $aFiles) {
		$aRes['error'] = array();
		
		if (!file_exists((DIR_FILES."/pack/original"))) mkdir(DIR_FILES."/pack/original", 0777, TRUE);

		$oPhotoDao =& DaoFactory::getDao('pack_photo');

		if (empty($_FILES['uploadfile']['tmp_name']) || !file_exists($_FILES['uploadfile']['tmp_name'])) {
			$aRes['error'][] = 'error_upload';
			return Output::json($aRes);
		}

		// Beírás az adatbázisba
		$aRes['id_photo'] = $oPhotoDao->insertPhoto($aVars['id_pack'], '');

		// Kép másolása a megfelelő helyre. A filenév a kép azonosítója lesz. Pl.: {id_photo}.jpg.
		switch ($_FILES['uploadfile']['type']) {
			case 'image/jpeg':
				$sFilename = "{$aRes['id_photo']}.jpg";
				break;
			case 'image/png':
				$sFilename = "{$aRes['id_photo']}.png";
				break;
		}
		move_uploaded_file($_FILES['uploadfile']['tmp_name'], DIR_FILES."/pack/original/".$sFilename);
		
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

		$oPhotoDao =& DaoFactory::getDao('pack_photo');

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

		$oPhotoDao =& DaoFactory::getDao('pack_photo');
		$aPhoto = $oPhotoDao->getPhoto($iIdPhoto);

		$this->unlinkPhoto($aPhoto);
		$oPhotoDao->deletePhoto($iIdPhoto, $aPhoto['id_pack']);

		return Output::json($aRes);
	}
}
?>