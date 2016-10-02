<?php
class GalleryModule extends Module {
	protected function _access($sMethodName) {
		$oUserauth =& ModuleFactory::getModule('userauth');
		return $oUserauth->access('stock_admin');
	}

	public function path() {
		return array(
			'gallery' => array(
				'method'      => 'default',
			),
			'gallery/imagelist/' => array(
				'method'      => 'imagelist',
			),
		);
	}

	protected function _reqImagelist() {
		$oUserauth =& ModuleFactory::getModule('userauth');
		$aUserInfo = $oUserauth->getUser();
		$oGalleryDao =& DaoFactory::getDao('gallery');
		return Output::render('gallery_imagelist', getLayoutVars() + [
			'imagelist' => $oGalleryDao->getImageList($aUserInfo['id_shop'])
		]);
	}

	protected function _reqDefault($iIdGalleryImage=NULL) {
		$aVars = Request::getRequestVars();
		switch (Request::getRequestMethod()) {
			case 'GET':
				$oUserauth =& ModuleFactory::getModule('userauth');
				$aUserInfo = $oUserauth->getUser();
				$oGalleryDao =& DaoFactory::getDao('gallery');
				return Output::render('gallery', getLayoutVars() + [
					'imagelist' => $oGalleryDao->getImageList($aUserInfo['id_shop'])
				]);
				break;
			case 'POST':
				//$aRequiredVars = array('name');
				//if (array_keys_exists($aRequiredVars, $aVars)) return $this->_wsAdd($aVars);
				return $this->_wsAdd($aVars);
				return Output::json(array('error'=>'invalid_webservice_call'));
				break;
			case 'PUT':
				$aRes['error'] = array();
				$oGalleryDao =& DaoFactory::getDao('gallery');
				$oGalleryDao->updateTitle($iIdGalleryImage, $aVars['title']);
				return Output::json($aRes);
				break;
			case 'DELETE':
				$aRes['error'] = array();
				$oGalleryDao =& DaoFactory::getDao('gallery');
				$aImage = $oGalleryDao->getImage($iIdGalleryImage);
				$oGalleryDao->delete($iIdGalleryImage);
				unlink(DIR_FILES."/gallery/original/".$aImage['filename']);
				return Output::json($aRes);
				break;
			default:
				return Output::json(array('error'=>'invalid_webservice_call'));
				break;
		}
	}

	protected function _wsAdd() {
		$aRes['error'] = array();

		if (!file_exists((DIR_FILES."/gallery/original"))) mkdir(DIR_FILES."/gallery/original", 0777, TRUE);
		
		$oGalleryDao =& DaoFactory::getDao('gallery');
		
		if (empty($_FILES['file']['tmp_name']) || !file_exists($_FILES['file']['tmp_name'])) {
			$aRes['error'][] = 'error_upload';
			return Output::json($aRes);
		}
		
		// Kép tárolása az adatbázisban
		$oUserauth =& ModuleFactory::getModule('userauth');
		$aUserInfo = $oUserauth->getUser();
		$oGalleryDao->insertImage($aUserInfo['id_shop'], $_FILES['file']['name'], '');

		move_uploaded_file($_FILES['file']['tmp_name'], DIR_FILES."/gallery/original/".$_FILES['file']['name']);
		
		return Output::json($aRes);
	}

	protected function _wsEdit($iIdImage, $sTitle) {
		$aRes['error'] = array();

		$oGalleryDao =& DaoFactory::getDao('gallery');
		$oGalleryDao->updateTitle($iIdImage, $sTitle);
		
		return Output::json($aRes);
	}
}
?>