<?php
class DefaultModule extends Module {
	protected function _access($sMethodName) {
		return TRUE;
	}

	public function path() {
		return array(
			'' => array(
				'method'      => 'default',
			),
		);
	}

	
	/**
	 * Shortcodeok ertelmezese:
	 *  [getcategory jam]
	 *  [gallery]
	 */
	private function _parseShortcodes($sContent, $sLanguageIso) {
		preg_match_all('/\[([^\]]+)\]/', $sContent, $aMatches);
		foreach ($aMatches[1] as $iKey=>$sShortcode) {
			$sResult = '';
			$aShortcodeParts = explode(' ', $sShortcode);
			switch ($aShortcodeParts[0]) {
				case 'getcategory':
					$oProductDao =& DaoFactory::getDao('product');
					$oPackDao =& DaoFactory::getDao('pack');
					$oCategoryDao =& DaoFactory::getDao('category');
					$aCategory = $oCategoryDao->getCategoryByShopAndPermalink($GLOBALS['siteconfig']['shop_permalink'], $aShortcodeParts[1]);
					$sResult = Output::render('_shortcode_getcategory', getLayoutVars() + array(
						'productlist' => $oProductDao->getProductListByIdCategory($aCategory['id_category'], $aCategory['language_iso']),
						'packlist'    => $oPackDao->getPackListByIdCategory($aCategory['id_category'], $aCategory['language_iso']),
					));
				break;
				case 'gallery':
					$oShopDao =& DaoFactory::getDao('shop');
					$aShop = $oShopDao->getShopByPermalink($GLOBALS['siteconfig']['shop_permalink']);

					$oGalleryDao =& DaoFactory::getDao('gallery');
					$sResult = Output::render('_shortcode_gallery', getLayoutVars() + array(
						'imagelist' => $oGalleryDao->getImageList($aShop['id_shop']),
					));
				break;
			}
			$sContent = str_replace($aMatches[0][$iKey], $sResult, $sContent);
		}

		return $sContent;
	}
	/**
	 * Ha az URL alapján nem található a megfelelő modul (pl. cart/gadget),
	 * akkor ez a függvény próbálja meg értelmezni:
	 *   permalink alapján próbálja megkeresni a kért oldalt (a page modulban)
	 *     megpróbálja betölteni a page_permalink_elemei.tpl templatet
	 *     ha nincs, akkor a page.tpl-t tölti be	 
	 *   permalink alapján próbálja megkeresni a terméket (category/product)
	 *
	 * @return string   A generált oldal tartalma
	 */
	protected function _reqDefault() {
		$oPageDao =& DaoFactory::getDao('page');
		
		// Ha a permalink alapján azonosítható egy oldal (page)
		$oPageDao =& DaoFactory::getDao('page');
		$aPageInfo = $oPageDao->getContentListFromPath('www', Request::getPath());
		if ($aPageInfo) {
			// Ha van beágyazás, akkor az beolvassuk: {page _another_page Body}
			foreach ($aPageInfo as &$aRegionInfo) {
				$iCount = preg_match_all("/{(.*?)}/", $aRegionInfo['content'], $aMatches);
				if ($iCount) {
					for ($i = 0; $i < $iCount; $i++) {
						// PHP 5.3...
						$aFirstMatchExploded = explode(' ', $aMatches[1][$i]);
						$sRequestedPage = $aFirstMatchExploded[1];
						$sRequestedRegion = $aFirstMatchExploded[2];
						$aRegionData = $oPageDao->getContent('www', $sRequestedPage, $sRequestedRegion);
						$sEmbeddedText = $aRegionData['content'];
						$aRegionInfo['content'] = str_replace($aMatches[0][$i], $sEmbeddedText, $aRegionInfo['content']);

					}
				}
			}
		
			// Shortcode-ok ertelmezese
			// Language megkeresese (sajnos eleg bena igy ez a page modul...)
			foreach ($aPageInfo as &$aRegionInfo) {
				if ($aRegionInfo['region_name'] == 'Language code') $sLanguageIso = $aRegionInfo['content'];
			}
			foreach ($aPageInfo as &$aRegionInfo) {
				if ($aRegionInfo['region_name'] == 'Body') $aRegionInfo['content'] = $this->_parseShortcodes($aRegionInfo['content'], $sLanguageIso);
			}

			// Ha van az oldalhoz tartozó egyedi template, akkor azt rendereljük
			$sPath = Request::getPath();
			if (empty($sPath)) $sTemplateName = 'page_index';
			else $sTemplateName = 'page_'.str_replace('/', '_', trim($sPath, '/'));
			
			if (!file_exists(DIR_SKIN.'/templates/'.$sTemplateName.'.tpl')) $sTemplateName = 'page';
			
			$res = Output::render($sTemplateName, getLayoutVars()+array(
				'path'        => $sPath,
				'contentlist' => $aPageInfo,
			));
			return $res;
		}
		

		$aParameters = Request::getMethodParameterList();

		// ...megpróbáljuk termékként
		$oProductModule =& ModuleFactory::getModule('product');
		$aRes = $oProductModule->req('default', Request::getMethodParameterList());
		if ($aRes) return $aRes;

		// ...megpróbáljuk termékcsomagként
		$oPackModule =& ModuleFactory::getModule('pack');
		$aRes = $oPackModule->req('default', Request::getMethodParameterList());
		if ($aRes) return $aRes;

		// ...kategoriaként
		$oCategoryModule =& ModuleFactory::getModule('category');
		$aRes = $oCategoryModule->req('default', Request::getMethodParameterList());
		if ($aRes) return $aRes;

		// Ha kategóriaként és termékként sem azonosítható, akkor product-pack-ként próbáljuk
		$oPackModule =& ModuleFactory::getModule('pack');
		$aRes = $oPackModule->req('default', Request::getMethodParameterList());
		if ($aRes) return $aRes;
		
		// Ha nem sikerült értelmezni a path tartalmát, akkor rendereljük a hibaoldalt
		showErrorPage(404);
	}
}
?>