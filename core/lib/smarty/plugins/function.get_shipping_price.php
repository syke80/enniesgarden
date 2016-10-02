<?php
/*
 * Smarty-Light plugin
 * -------------------------------------------------------------
 * Type:     function
 * Name:     page
 * Purpose:  Lekérdezi egy shipping method azonositojat a nev alapjan
 * Credit:   syke
 *
 * Input:  
 *         - id_shop:   A bold azonositoja
 *         - name:      A shipping method neve
 *         - amount:    A vasarlas erteke (a shipping price fugg az artol, pl ha £25 folott free shipping van)
 * -------------------------------------------------------------
 */
function tpl_function_get_shipping_price($params, &$tpl) {
	if (!isset($params['id_shop']) || !isset($params['name']) || !isset($params['amount'])) return;
	
	$oShopDao =& DaoFactory::getDao('shop');
	return $oShopDao->getShippingMethod($params['id_shop'], $params['name'], $params['amount'])['price'];
}
?>
