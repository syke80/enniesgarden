<?php
class InterfaceModule extends Module {
	protected function _access($sMethodName) {
		return TRUE;
	}

	public function path() {
		return array(
			'interface/google-merchant.xml' => array(
				'method'      => 'googleMerchantXml',
			),
			'interface/google-merchant.json' => array(
				'method'      => 'googleMerchantJson',
			),
		);
	}

	protected function _reqGoogleMerchantJson() {
		require DIR_CORE.'/lib/html2text.php';
		require DIR_CORE.'/lib/html2textexception.php';
		$oProductDao =& DaoFactory::getDao('product');
		$oPackDao =& DaoFactory::getDao('pack');
		$oProductPhotoDao =& DaoFactory::getDao('product_photo');
		$oPackPhotoDao =& DaoFactory::getDao('pack_photo');

		$aOutput = [];

		$aResult = $oProductDao->getProductList($GLOBALS['siteconfig']['shop_permalink'], 'en');
		foreach ($aResult['list'] as $aItem) {
			if ($aItem['is_active'] == 'y') {
				$aPhotoList = $oProductPhotoDao->getPhotoListByIdProduct($aItem['id_product']);
				$aPhotoFilenameList = [];
				foreach ($aPhotoList as $aPhoto) {
					$aPhotoFilenameList[] = $GLOBALS['siteconfig']['site_url'].'/content/files/product/original/'.$aPhoto['filename'];
				}

				$aOutput[] = [
					'id'                    => $aItem['id_product'],
					'title'                 => $aItem['name'],
//					'description'           => empty($aItem['long_description']) ? '' : Html2Text\Html2Text::convert($aItem['long_description']),
					'description'           => !empty($aItem['short_description']) ? $aItem['short_description'] : ( !empty($aItem['long_description']) ? Html2Text\Html2Text::convert($aItem['long_description']) : ''),
					'googleProductCategory' => 'Food, Beverages & Tobacco > Food Items > Dips & Spreads > Jams & Jellies',
					'productType'           => $aItem['category_name'],
					'link'                  => $GLOBALS['siteconfig']['site_url'].'/'.$aItem['permalink'],
					'mobileLink'            => $GLOBALS['siteconfig']['site_url'].'/'.$aItem['permalink'],
					'imageLink'             => $aPhotoFilenameList[0],
					'additionalImageLinks'  => array_slice($aPhotoFilenameList, 1),
					'condition'              => 'new',
					'availability'           => 'in stock',
					'price'                  => $aItem['price'],
					'brand'                  => "Ennie's Garden",
					'gtin'                   => $aItem['barcode'],
					'mpn'                    => $aItem['id_product'],
					'shipping(country:service:price)'  => 'GB:Standard:2.99 GBP',
					'shippingWeight'         => '500 g',
	//				'adwordsGrouping'         => '',
	//				'adwordsLabels'           => '',
	//				'adwordsRedirect'         => '',
				];
			}
		}

		$aResult = $oPackDao->getPackList($GLOBALS['siteconfig']['shop_permalink'], 'en');
		foreach ($aResult['list'] as $aItem) {
			$aPhotoList = $oPackPhotoDao->getPhotoListByIdPack($aItem['id_pack']);
			$aPhotoFilenameList = [];
			foreach ($aPhotoList as $aPhoto) {
				$aPhotoFilenameList[] = $GLOBALS['siteconfig']['site_url'].'/content/files/pack/original/'.$aPhoto['filename'];
			}

			$aOutput[] = [
				'id'                    => 'p'.$aItem['id_pack'],
				'title'                 => $aItem['name'],
//				'description'           => empty($aItem['long_description']) ? '' : Html2Text\Html2Text::convert($aItem['long_description']),
				'description'           => !empty($aItem['short_description']) ? $aItem['short_description'] : ( !empty($aItem['long_description']) ? Html2Text\Html2Text::convert($aItem['long_description']) : ''),
				'googleProductCategory' => 'Food, Beverages & Tobacco > Food Items > Dips & Spreads > Jams & Jellies',
				'productType'           => $aItem['category_name'],
				'link'                  => $GLOBALS['siteconfig']['site_url'].'/'.$aItem['permalink'],
				'mobileLink'            => $GLOBALS['siteconfig']['site_url'].'/'.$aItem['permalink'],
				'imageLink'             => $aPhotoFilenameList[0],
				'additionalImageLinks'  => array_slice($aPhotoFilenameList, 1),
				'condition'             => 'new',
				'availability'          => 'in stock',
				'price'                 => $aItem['price'],
				'brand'                 => "Ennie's Garden",
				'gtin'                  => $aItem['barcode'],
				'mpn'                   => 'p'.$aItem['id_pack'],
				'shipping(country:service:price)' => 'GB:Standard:0 GBP',
//				'shippingWeight'          => '500 g',
//				'adwordsGrouping'         => '',
//				'adwordsLabels'           => '',
//				'adwordsRedirect'         => '',
			];
		}

		header('Content-Type: application/json');
		return Output::json($aOutput);
	}

	protected function _reqGoogleMerchantXml() {
		require DIR_CORE.'/lib/html2text.php';
		require DIR_CORE.'/lib/html2textexception.php';
		$oProductDao =& DaoFactory::getDao('product');
		$oPackDao =& DaoFactory::getDao('pack');
		$oProductPhotoDao =& DaoFactory::getDao('product_photo');
		$oPackPhotoDao =& DaoFactory::getDao('pack_photo');

		$aOutput = [];

		$aResult = $oProductDao->getProductList($GLOBALS['siteconfig']['shop_permalink'], 'en');
		foreach ($aResult['list'] as $aItem) {
			if ($aItem['is_active'] == 'y') {
				$aPhotoList = $oProductPhotoDao->getPhotoListByIdProduct($aItem['id_product']);
				$aPhotoFilenameList = [];
				foreach ($aPhotoList as $aPhoto) {
					$aPhotoFilenameList[] = $GLOBALS['siteconfig']['site_url'].'/content/files/product/original/'.$aPhoto['filename'];
				}

				$aOutput[] = [
					'id'                    => $aItem['id_product'],
					'title'                 => $aItem['name'],
//					'description'           => empty($aItem['long_description']) ? '' : Html2Text\Html2Text::convert($aItem['long_description']),
					'description'           => !empty($aItem['short_description']) ? $aItem['short_description'] : ( !empty($aItem['long_description']) ? Html2Text\Html2Text::convert($aItem['long_description']) : ''),
					'googleProductCategory' => 'Food, Beverages & Tobacco > Food Items > Dips & Spreads > Jams & Jellies',
					'productType'           => $aItem['category_name'],
					'link'                  => $GLOBALS['siteconfig']['site_url'].'/'.$aItem['permalink'],
					'mobileLink'            => $GLOBALS['siteconfig']['site_url'].'/'.$aItem['permalink'],
					'imageLink'             => $aPhotoFilenameList[0],
					'additionalImageLinks'  => array_slice($aPhotoFilenameList, 1),
					'condition'              => 'new',
					'availability'           => 'in stock',
					'price'                  => $aItem['price'],
					'brand'                  => "Ennie's Garden",
					'gtin'                   => $aItem['barcode'],
					'mpn'                    => $aItem['id_product'],
					'shipping'              => ['country' => 'GB', 'service' => 'Standard', 'price' => '0 GBP'],
					'shippingWeight'         => '500 g',
	//				'adwordsGrouping'         => '',
	//				'adwordsLabels'           => '',
	//				'adwordsRedirect'         => '',
				];
			}
		}

		$aResult = $oPackDao->getPackList($GLOBALS['siteconfig']['shop_permalink'], 'en');
		foreach ($aResult['list'] as $aItem) {
			$aPhotoList = $oPackPhotoDao->getPhotoListByIdPack($aItem['id_pack']);
			$aPhotoFilenameList = [];
			foreach ($aPhotoList as $aPhoto) {
				$aPhotoFilenameList[] = $GLOBALS['siteconfig']['site_url'].'/content/files/pack/original/'.$aPhoto['filename'];
			}

			$aOutput[] = [
				'id'                    => 'p'.$aItem['id_pack'],
				'title'                 => $aItem['name'],
//				'description'           => empty($aItem['long_description']) ? '' : Html2Text\Html2Text::convert($aItem['long_description']),
				'description'           => !empty($aItem['short_description']) ? $aItem['short_description'] : ( !empty($aItem['long_description']) ? Html2Text\Html2Text::convert($aItem['long_description']) : ''),
				'googleProductCategory' => 'Food, Beverages & Tobacco > Food Items > Dips & Spreads > Jams & Jellies',
				'productType'           => $aItem['category_name'],
				'link'                  => $GLOBALS['siteconfig']['site_url'].'/'.$aItem['permalink'],
				'mobileLink'            => $GLOBALS['siteconfig']['site_url'].'/'.$aItem['permalink'],
				'imageLink'             => $aPhotoFilenameList[0],
				'additionalImageLinks'  => array_slice($aPhotoFilenameList, 1),
				'condition'             => 'new',
				'availability'          => 'in stock',
				'price'                 => $aItem['price'],
				'brand'                 => "Ennie's Garden",
				'gtin'                  => $aItem['barcode'],
				'mpn'                   => 'p'.$aItem['id_pack'],
				'shipping'              => ['country' => 'GB', 'service' => 'Standard', 'price' => '2.99 GBP'],
//				'shippingWeight'          => '500 g',
//				'adwordsGrouping'         => '',
//				'adwordsLabels'           => '',
//				'adwordsRedirect'         => '',
			];
		}

		header('Content-Type: application/xml');
		return Output::render(
			'interface_googlemerchant_xml',
			['list' => $aOutput]
		);
	}
}
