<?php
/**
 * Smarty-Light plugin
 * -------------------------------------------------------------
 * Type:     function
 * Name:     assign_array
 * Purpose:  Értéket ad a megadott tömb egy elemének.
 * Input:
 *         - name:  A tömb neve.
 *         - key:   A tömb kulcsa.
 *         - value: Az elem értéke.  
 * -------------------------------------------------------------
 */
function tpl_function_assign_array($params, &$tpl) {
	$tpl->_vars[$params['name']][$params['key']] = $params['value'];
}
?>
