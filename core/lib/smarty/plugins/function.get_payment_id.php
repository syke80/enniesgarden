<?php
/*
 * Smarty-Light plugin
 * -------------------------------------------------------------
 * Type:     function
 * Name:     page
 * Purpose:  Lekérdezi egy payment method azonositojat a nev alapjan
 * Credit:   syke
 *
 * Input:  
 *         - name:      A payment method neve
 * -------------------------------------------------------------
 */
function tpl_function_get_payment_id($params, &$tpl) {
	if (!isset($params['name'])) return;
	
	$oPaymentMethodDao =& DaoFactory::getDao('payment_method');
	return $oPaymentMethodDao->getMethodId($params['name']);
}
?>
