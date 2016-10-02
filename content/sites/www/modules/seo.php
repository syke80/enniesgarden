<?php
class SeoModule extends Module {
	protected function _access($sMethodName) {
		return TRUE;
	}

	public function path() {
		return array(
			'sitemap' => array(
				'method'      => 'sitemap',
			),
			'sitemap.xml' => array(
				'method'      => 'sitemapXml',
			),
			'robots.txt' => array(
				'method'      => 'robotsTxt',
			),
		);
	}

	/**
	 * Rendereli a sitemap.xml oldalt.
	 *
	 * @return string   A generált oldal tartalma
	 */
	protected function _reqSitemapXml() {
		$oShopDao =& DaoFactory::getDao('shop');
		$oPageDao =& DaoFactory::getDao('page');
		$oProductDao =& DaoFactory::getDao('product');
		$oProductPhotoDao =& DaoFactory::getDao('product_photo');
		$oPackDao =& DaoFactory::getDao('pack');
		$oPackPhotoDao =& DaoFactory::getDao('pack_photo');
		$oCategoryDao =& DaoFactory::getDao('category');
		$oGalleryDao =& DaoFactory::getDao('gallery');

		$aUrlList = [];
		
		// Pages
		$aPageList = $oPageDao->getPageList()['list'];
		foreach ($aPageList as $aItem) {
			if (empty($aItem['permalink'])) {
				$sLocation = $GLOBALS['siteconfig']['site_url'];
			}
			else {
				$sLocation = $GLOBALS['siteconfig']['site_url'].'/'.$aItem['permalink'];
				if (substr($sLocation, -1) != '/') $sLocation = $sLocation.'/';
			}
			if ($aItem['is_public'] == 'y') {
				$aUrlList[] = [
					'location' => $sLocation,
				];
			}
		}

		// Categories
		$aCategoryList = $oCategoryDao->getCategoryList($GLOBALS['siteconfig']['shop_permalink'], 'en')['list'];
		foreach ($aCategoryList as $aItem) {
			$sLocation = $GLOBALS['siteconfig']['site_url'].'/'.$aItem['permalink'];
			if (substr($sLocation, -1) != '/') $sLocation = $sLocation.'/';
			$aUrlList[] = [
				'location' => $sLocation,
			];
		}

		// Pack
		$aPackList = $oPackDao->getPackList($GLOBALS['siteconfig']['shop_permalink'], 'en')['list'];
		foreach ($aPackList as $aItem) {
			$sLocation = $GLOBALS['siteconfig']['site_url'].'/'.$aItem['permalink'];
			if (substr($sLocation, -1) != '/') $sLocation = $sLocation.'/';
			// Get image list
			$aImageList = [];
			$aPhotoList = $oPackPhotoDao->getPhotoListByIdPack($aItem['id_pack']);
			foreach ($aPhotoList as $aPhoto) {
				$aImageList[] = [
					'location' => $GLOBALS['siteconfig']['site_url'].'/content/files/pack/original/'.$aPhoto['filename'],
					'title'    => $aItem['name'],
				];
			}
			$aUrlList[] = [
				'location' => $sLocation,
				'images'   => $aImageList,
			];
		}
		
		// Products
		$aProductList = $oProductDao->getProductList($GLOBALS['siteconfig']['shop_permalink'], 'en')['list'];
		foreach ($aProductList as $aItem) {
			if ($aItem['is_active'] == 'y') {
				// Build URL
				$sLocation = $GLOBALS['siteconfig']['site_url'].'/'.$aItem['permalink'];
				if (substr($sLocation, -1) != '/') $sLocation = $sLocation.'/';
				// Get image list
				$aImageList = [];
				$aPhotoList = $oProductPhotoDao->getPhotoListByIdProduct($aItem['id_product']);
				foreach ($aPhotoList as $aPhoto) {
					$aImageList[] = [
						'location' => $GLOBALS['siteconfig']['site_url'].'/content/files/product/original/'.$aPhoto['filename'],
						'title'    => $aItem['name'],
					];
				}
				// Add to the array
				$aUrlList[] = [
					'location' => $sLocation,
					'images'   => $aImageList,
				];
			}
		}

		// Gallery
		$aShop = $oShopDao->getShopByPermalink($GLOBALS['siteconfig']['shop_permalink']);
		$aGalleryImageList = $oGalleryDao->getImageList($aShop['id_shop']);
		foreach ($aGalleryImageList as $aGalleryImage) {
			$aImageList[] = [
				'location' => $GLOBALS['siteconfig']['site_url'].'/content/files/gallery/original/'.$aGalleryImage['filename'],
				'title'    => $aGalleryImage['title'],
			];
		}

		// Send data to output
		header('Content-type: text/xml');
		return Output::render('seo_sitemap_xml', getLayoutVars() + array(
			'url_list' => $aUrlList,
			'image_list' => $aImageList,
		));
	}
	/**
	 * Rendereli a robots.txt oldalt.
	 *
	 * @return string   A generált oldal tartalma
	 */
	protected function _reqRobotsTxt() {
		header('Content-type: text/plain');
		return Output::render('seo_robots_txt', getLayoutVars() + array(
		));
	}
}
