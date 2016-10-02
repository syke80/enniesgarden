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
 *         - name:      A shipping method neve
 * -------------------------------------------------------------
 */
function tpl_function_get_shipping_id($params, &$tpl) {
	if (!isset($params['name'])) return;
	
	$oShippingMethodDao =& DaoFactory::getDao('shipping_method');
	return $oShippingMethodDao->getMethodId($params['name']);
}
?>
