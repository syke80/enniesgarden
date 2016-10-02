<?php
/**
 * Ellenorzi a kupon ervenyesseget. Ha nem ervenyes, akkor hibauzenettel visszater.
 *
 */
function checkCoupon() {
	// Kupon lekerdezese, total modositasa
	$sCouponError = '';
	if (isset($_SESSION['coupon'])) {
		$oCouponDao =& DaoFactory::getDao('coupon');
		$aCoupon = $oCouponDao->getCoupon($_SESSION['coupon']);
		
		if (empty($aCoupon)) {
			$sCouponError = 'invalid';
		}
		else {
			if ($aCoupon['expiration'] && $aCoupon['expiration'] <= date("Y-m-d")) {
				$sCouponError = 'expired';
			}
		}
	}
	return $sCouponError;
}

function getLayoutVars() {
	$oCustomerauth = ModuleFactory::getModule('customerauth');
	$aLayoutVars['customer'] = $oCustomerauth->getCustomer();
	
	$aLayoutVars['siteconfig']   = $GLOBALS['siteconfig'];
	$aLayoutVars['module']       = Request::getModuleName();
	$aLayoutVars['modulemethod'] = Request::getModuleMethodName();
	
	if (isset($GLOBALS['id_language'])) $aLayoutVars['id_language']  = $GLOBALS['id_language'];

	// Info az aktuális shopról
	$oShopDao = DaoFactory::getDao('shop');
	$aLayoutVars['shop'] = $oShopDao->getShopByPermalink($GLOBALS['siteconfig']['shop_permalink']);
	
	// Kategóriák listája
	$oCategoryDao = DaoFactory::getDao('category');

	// Device pixel ratio stored in a cookie
	$aLayoutVars['pixel_ratio'] = isset($_COOKIE['pixelRatio']) ? $_COOKIE['pixelRatio'] : 1;

	// Kupon ellenorzese, kupon adatai
	if ($_GET['coupon']) {
		$aLayoutVars['new_coupon'] = TRUE;
	}
	global $sCouponError;
	$aLayoutVars['coupon_error'] = $sCouponError;

	return $aLayoutVars;
}

// Kupon tarolasa
if (isset($_GET['coupon'])) {
	$_SESSION['coupon'] = $_GET['coupon'];
}

// Kupon ellenorzese, ha invalid, akkor torlese
$sCouponError = checkCoupon();
if ($sCouponError) {
	unset($_SESSION['coupon']);
}

?>