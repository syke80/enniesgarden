<?php
class CartModule extends Module {
	protected function _access($sMethodName) {
		return TRUE;
	}
	
	public function path() {
		return array(
			'basket' => array(
				'method'      => 'default',
				'id_language' => 'en',
			),
			'basket/content' => array(
				'method'      => 'defaultContent',
				'id_language' => 'en',
			),
			'basket/gadget' => array(
				'method'      => 'gadget',
				'public'      => FALSE,
			),
			'basket/aside' => array(
				'method'      => 'aside',
				'public'      => FALSE,
			),
			'kosar' => array(
				'method'      => 'default',
				'id_language' => 'hu',
			),
		);
	}

	/**
	 * Rendereli a kosár gadgetet (ami a fejlécben van).
	 *
	 * @return string   A gadget tartalma
	 */
	protected function _reqGadget($sIdLanguage) {
		$aProductList = $this->_getProductListFull($sIdLanguage);
		$aPackList = $this->_getPackListFull($sIdLanguage);

		$iTotal = 0;
		$iCount = 0;
		foreach ($aProductList as $aProduct) {
			$iTotal += $aProduct['total'];
			$iCount += $aProduct['quantity'];
		}
		foreach ($aPackList as $aPack) {
			$iTotal += $aPack['total'];
			$iCount += $aPack['quantity'];
		}

		return Output::render('cart_gadget', getLayoutVars() + array(
			'count' => $iCount,
			'total' => $iTotal,
			'id_language' => $sIdLanguage,
		), 'blank');
	}

	/**
	 * Rendereli a kosár gadgetet (ami a fejlécben van).
	 *
	 * @return string   A gadget tartalma
	 */
	protected function _reqAside($sLanguageIso) {
		$aProductList = $this->_getProductListFull($sLanguageIso);
		$aPackList = $this->_getPackListFull($sLanguageIso);
		$iTotal = 0;
		foreach ($aProductList as $aProduct) {
			$iTotal += $aProduct['total'];
			$iCount += $aProduct['quantity'];
		}
		foreach ($aPackList as $aPack) {
			$iTotal += $aPack['total'];
			$iCount += $aPack['quantity'];
		}

		return Output::render('cart_aside', getLayoutVars() + array(
			'language_iso' => $sLanguageIso,
			'productlist'  => $aProductList,
			'packlist'     => $aPackList,
			'count'        => $iCount,
			'total'        => $iTotal,
		), 'blank');
	}

	/**
	 * A termékkel kapcsolatos webszolgáltatások
	 *   GET    /cart               Rendereli a kosár oldalt (a _page_default() metódus)
	 *   PUT    /cart               Módosítja egy termék mennyiségét a kosárban
	 *
	 * @return string|json          GET esetén a generált oldal tartalma
	 *                              PUT / POST / DELETE esetén a feldolgozás közben bekövetkező hibák
	 */
	protected function _reqDefault() {
		$aVars = Request::getRequestVars();
				switch (Request::getRequestMethod()) {
			case 'GET':
				return $this->_pageDefault();
				break;
			case 'POST':
				if (array_key_exists('id_product', $aVars) || array_key_exists('id_pack', $aVars)) return $this->_wsInc($aVars);
				break;
			case 'PUT':
				$aRequiredVars1 = array('id_product', 'quantity');
				$aRequiredVars2 = array('id_pack', 'quantity');
				if (array_keys_exists($aRequiredVars1, $aVars) || array_keys_exists($aRequiredVars2, $aVars)) return $this->_wsUpdate($aVars);
				break;
			case 'DELETE':
				return $this->_wsDelete($aVars);
				break;
		}
	}

	private function _getProductListFull($sLanguageIso) {
		$oProductDao =& DaoFactory::getDao('product');
		$aProductList = array();
		if (isset($_SESSION['cart']['product'])) {
			$iProductIndex = 0;
			foreach ($_SESSION['cart']['product'] as $iIdProduct=>$aItem) {
				$aProductList[$iProductIndex] = $oProductDao->getProductFull($iIdProduct, $sLanguageIso);
				$aProductList[$iProductIndex]['quantity'] = $aItem['quantity'];
				$aProductList[$iProductIndex]['total'] = $aProductList[$iProductIndex]['quantity'] * $aProductList[$iProductIndex]['price'];
//				$iTotal += $aProductList[$iProductIndex]['total'];
				$iProductIndex++;
			}
		}
		return $aProductList;
	}

	private function _getPackListFull($sLanguageIso) {
		$oPackDao =& DaoFactory::getDao('pack');
		$aPackList = array();
		if (isset($_SESSION['cart']['pack'])) {
			$iPackIndex = 0;
			foreach ($_SESSION['cart']['pack'] as $iIdPack=>$aItem) {
				$aPackList[$iPackIndex] = $oPackDao->getPackFull($iIdPack, $sLanguageIso);
				$aPackList[$iPackIndex]['quantity'] = $aItem['quantity'];
				$aPackList[$iPackIndex]['total'] = $aPackList[$iPackIndex]['quantity'] * $aPackList[$iPackIndex]['price'];
//				$iTotal += $aPackList[$iPackIndex]['total'];
				$iPackIndex++;
			}
		}
		return $aPackList;
	}

	/**
	 * Rendereli a kosár oldal tartalmat:
	 * A kosar oldalon egy script tolti be a dinamikus tartalmat, ami kivalasztott shipping method es kupon kod alapjan valtozik
	 *
	 * @return string   A generált oldal tartalma
	 */
	protected function _reqDefaultContent() {
		$aVars = Request::getRequestVars();
		if (isset($_SESSION['coupon'])) {
			$_SESSION['coupon'] = htmlspecialchars(trim($_SESSION['coupon'], " \""));
		}
		$aVars = cleanValues($aVars);

		// Termekek lekerdezese, arak osszeadasa
		$aProductList = $this->_getProductListFull($GLOBALS['id_language']);
		$aPackList = $this->_getPackListFull($GLOBALS['id_language']);

		$iSubtotalProducts = 0;
		$iCount = 0;
		foreach ($aProductList as $aProduct) {
			$iSubtotalProducts += $aProduct['total'];
			$iCount += $aProduct['quantity'];
		}
		foreach ($aPackList as $aPack) {
			$iSubtotalProducts += $aPack['total'];
			$iCount += $aPack['quantity'];
		}

		// Shipping lekerdezese
		$oShopDao =& DaoFactory::getDao('shop');
		$aShop = $oShopDao->getShopByPermalink($GLOBALS['siteconfig']['shop_permalink']);
		$aShippingInfo = $oShopDao->getShippingMethod($aShop['id_shop'], $aVars['shipping'], $iSubtotalProducts);

		// Total kiszamolasa
		$iTotal = $iSubtotalProducts + $aShippingInfo[price];

		// Kupon lekerdezese, total modositasa
		$aCoupon = '';
		$iDiscount = 0;
		if (isset($_SESSION['coupon'])) {
			$oCouponDao =& DaoFactory::getDao('coupon');
			$aCoupon = $oCouponDao->getCoupon($_SESSION['coupon']);
			
			if ($aCoupon['type'] == '10-percent') {
				$iDiscount = $iSubtotalProducts * 0.1;
				$iTotal -= $iDiscount;
			}

			if ($aCoupon['type'] == 'free-delivery') {
				$iTotal = $iSubtotalProducts;
			}

			if ($aCoupon['type'] == 'free-product') {
				$oProductDao =& DaoFactory::getDao('product');
				$aFreeProduct = $oProductDao->getProductByPermalinks($GLOBALS['siteconfig']['shop_permalink'], $aCoupon['info']);
			}
		}

		// Kimenet generalasa
		return Output::render('cart_content', getLayoutVars() + array(
			'id_language'       => $GLOBALS['id_language'],
			'productlist'       => $aProductList,
			'packlist'          => $aPackList,
			'subtotal_products' => $iSubtotalProducts,
			'total'             => $iTotal,
			'count'             => $iCount,
			'shipping_info'     => $aShippingInfo,
			'coupon'            => $aCoupon,
			'discount'          => $iDiscount,
			'free_product'      => isset($aFreeProduct) ? $aFreeProduct : NULL,
		));
	}

	/**
	 * Rendereli a kosár oldalt.
	 *
	 * @return string   A generált oldal tartalma
	 */
	private function _pageDefault() {
		$aProductList = $this->_getProductListFull($GLOBALS['id_language']);
		$aPackList = $this->_getPackListFull($GLOBALS['id_language']);

		$iTotal = 0;
		$iCount = 0;
		foreach ($aProductList as $aProduct) {
			$iTotal += $aProduct['total'];
			$iCount += $aProduct['quantity'];
		}
		foreach ($aPackList as $aPack) {
			$iTotal += $aPack['total'];
			$iCount += $aPack['quantity'];
		}

		return Output::render('cart', getLayoutVars() + array(
			'id_language' => $GLOBALS['id_language'],
			'productlist' => $aProductList,
			'packlist'    => $aPackList,
			'total'       => $iTotal,
			'count'       => $iCount,
		));
	}

	/**
	 * Webszolgáltatás, ami a kosárban eggyel növeli egy termék mennyiségét
	 *
	 * @param  array    $aVars  A formból beérkező változók: id_product, quantity (opcionális)
	 *                          check_stock (ellenőrzi a készletet, és ha nincs elég a raktárban, akkor nem engedi a kosárba rakni, hibaüzenetet küld vissza)	 
	 *
	 * @return json     A feldolgozás közben bekövetkező hibák
	 */
	private function _wsInc($aVars) {
		if (empty($aVars['quantity'])) $aVars['quantity'] = 1;
		if (isset($aVars['id_product']) && isset($_SESSION['cart']['product'][$aVars['id_product']])) {
			$aVars['quantity'] += $_SESSION['cart']['product'][$aVars['id_product']]['quantity'];
		}
		if (isset($aVars['id_pack']) && isset($_SESSION['cart']['pack'][$aVars['id_pack']])) {
			$aVars['quantity'] += $_SESSION['cart']['pack'][$aVars['id_pack']]['quantity'];
		}
		
		return self::_wsUpdate($aVars);
	}

	private function _count_product_in_cart($iIdProduct) {
		$iCount = 0;
		if (isset($_SESSION['cart']['product'][$iIdProduct])) $iCount += $_SESSION['cart']['product'][$iIdProduct]['quantity'];
		if (isset($_SESSION['cart']['pack'])) {
			$oPackDao =& DaoFactory::getDao('pack');
			foreach ($_SESSION['cart']['pack'] as $iIdPack=>$aItem) {
				$aProductList = $oPackDao->getLinkedProductList($iIdPack);
				$aProductList = $aProductList['list'];
				foreach ($aProductList as $aProduct) {
					if ($aProduct['id_product'] == $iIdProduct) $iCount += $aItem['quantity'] * $aProduct['quantity'];
				}
			}
		}
		return $iCount;
	}

	/**
	 * Webszolgáltatás, ami módosítja a kosárban egy termék mennyiségét
	 *
	 * @param  array    $aVars  A formból beérkező változók:
	 *                          id_product, quantity
	 *                          check_stock (ellenőrzi a készletet, és ha nincs elég a raktárban, akkor nem engedi a kosárba rakni, hibaüzenetet küld vissza)	 
	 *
	 * @return json     A feldolgozás közben bekövetkező hibák
	 *                  ['error'][0] = 'stock'	 
	 *                  ['warning'][0] = 'stock'
	 *                  product_type_count: hanyfele kulonbozo termek van a kosarban	 
	 *                  total: a rendeles erteke (shipping cost nelkul)
	 */
	private function _wsUpdate($aVars) {
		$aVars = cleanValues($aVars);
		$aRes['error'] = array();
		$aRes['warning'] = array();

		if (!isset($_SESSION['cart'])) $_SESSION['cart'] = array();

		// Ha product-ról van szó
		if (isset($aVars['id_product'])) {
			$aCartBackup = $_SESSION['cart'];
			$oProductDao =& DaoFactory::getDao('product');

			// Kosárba rakás
			if (!isset($_SESSION['cart']['product'])) $_SESSION['cart']['product'] = array();
			if (!isset($_SESSION['cart']['product'][$aVars['id_product']])) {
				$_SESSION['cart']['product'][$aVars['id_product']] = array();
				$_SESSION['cart']['product'][$aVars['id_product']]['quantity'] = $aVars['quantity'];
			}
			$aProduct = $oProductDao->getProduct($aVars['id_product']);
			$_SESSION['cart']['product'][$aVars['id_product']]['quantity'] = $aVars['quantity'];
			$_SESSION['cart']['product'][$aVars['id_product']]['total'] = $aProduct['price'] * $_SESSION['cart']['product'][$aVars['id_product']]['quantity'];

			// Készlet ellenőrzése
			$aProductInfo = $oProductDao->getProduct($aVars['id_product']);
			if (is_numeric($aProductInfo['quantity']) && $aProductInfo['quantity'] < self::_count_product_in_cart($aVars['id_product'])) {
				// Ha a check_stock opció be van kapcsolva, akkor nem rakja a kosárba, és hibaüzenettel tér vissza
				if (isset($aVars['check_stock']) && $aVars['check_stock']==true) {
					$_SESSION['cart'] = $aCartBackup;
					$aRes['error'][] = 'stock';
					return Output::json($aRes);
				}
				// Ha a chack_stock opció ki van kapcsolva, akkor a kosárban marad, és warninggal tér vissza
				else {
					$aRes['warning'][] = 'stock';
				}
			}
		}

		// Ha pack-ról van szó
		if (isset($aVars['id_pack'])) {
			$aCartBackup = $_SESSION['cart'];
			$oPackDao =& DaoFactory::getDao('pack');

			// Kosárba rakás
			if (!isset($_SESSION['cart']['pack'])) $_SESSION['cart']['pack'] = array();
			if (!isset($_SESSION['cart']['pack'][$aVars['id_pack']])) {
				$_SESSION['cart']['pack'][$aVars['id_pack']] = array();
				$_SESSION['cart']['pack'][$aVars['id_pack']]['quantity'] = $aVars['quantity'];
			}
			$aPack = $oPackDao->getPack($aVars['id_pack']);
			$_SESSION['cart']['pack'][$aVars['id_pack']]['quantity'] = $aVars['quantity'];
			$_SESSION['cart']['pack'][$aVars['id_pack']]['total'] = $aPack['price'] * $_SESSION['cart']['pack'][$aVars['id_pack']]['quantity'];

			// Készlet ellenőrzése
			$aProductList = $oPackDao->getLinkedProductList($aVars['id_pack']);
			$aProductList = $aProductList['list'];
			foreach ($aProductList as $aProduct) {
				if (is_numeric($aProductInfo['stock_quantity']) &&  $aProduct['stock_quantity'] < self::_count_product_in_cart($aProduct['id_product'])) {
					// Ha a check_stock opció be van kapcsolva, akkor nem rakja a kosárba, és hibaüzenettel tér vissza
					if (isset($aVars['check_stock']) && $aVars['check_stock']==true) {
						$_SESSION['cart'] = $aCartBackup;
						$aRes['error'][] = 'stock';
						return Output::json($aRes);
					}
					// Ha a chack_stock opció ki van kapcsolva, akkor a kosárban marad, és warninggal tér vissza
					else {
						$aRes['warning'][] = 'stock';
					}
				}
			}
		}

		$aRes['product_type_count'] =
			(isset($_SESSION['cart']['product']) ? count($_SESSION['cart']['product']) : 0)
			+ (isset($_SESSION['cart']['pack']) ? count($_SESSION['cart']['pack']) : 0);

		// Calculate total (needed for calculate shipping cost - and shipping method)
		$aProductList = $this->_getProductListFull($sIdLanguage);
		$aPackList = $this->_getPackListFull($sIdLanguage);
  		$iTotal = 0;
		foreach ($aProductList as $aProduct) {
			$iTotal += $aProduct['total'];
		}
		foreach ($aPackList as $aPack) {
			$iTotal += $aPack['total'];
		}
  		$aRes['total'] = $iTotal;

		return Output::json($aRes);
	}

	/**
	 * Webszolgáltatás, ami töröl egy terméket a kosárból
	 *
	 * @param  array    $aVars  A formból beérkező változó:
	 *                          id_product
	 *
	 * @return json     A feldolgozás közben bekövetkező hibák
	 */
	private function _wsDelete($aVars) {
		$aRes['error'] = array();
		if (!isset($aVars['id_product']) && !isset($aVars['id_pack'])) unset($_SESSION['cart']);
		if (isset($aVars['id_product']) && isset($_SESSION['cart']['product'][$aVars['id_product']])) unset($_SESSION['cart']['product'][$aVars['id_product']]);
		if (isset($aVars['id_pack']) && isset($_SESSION['cart']['pack'][$aVars['id_pack']])) unset($_SESSION['cart']['pack'][$aVars['id_pack']]);
		// Ha üres a kosár akkor meg kell semmisíteni a változót
		if (empty($_SESSION['cart'])) unset($_SESSION['cart']);
		return Output::json($aRes);
	}

}
?>