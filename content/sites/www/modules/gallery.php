<?php
class GalleryModule extends Module {
	protected function _access($sMethodName) {
		return TRUE;
	}

	public function path() {
		return array(
			'gallery-1' => array(
				'method'      => 'default',
			),
		);
	}

	protected function _reqDefault() {
		$oShopDao =& DaoFactory::getDao('shop');
		$aShop = $oShopDao->getShopByPermalink($GLOBALS['siteconfig']['shop_permalink']);

		$oGalleryDao =& DaoFactory::getDao('gallery');
		return Output::render('gallery', getLayoutVars() + [
			'imagelist' => $oGalleryDao->getImageList($aShop['id_shop'])
		]);
	}
}
?>