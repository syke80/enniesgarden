<?php
/**
 * Smarty-Light plugin
 * -------------------------------------------------------------
 * Type:     function
 * Name:     load
 * Purpose:  Betölti egy url tartalmát
 * Input:
 *         - url
 * -------------------------------------------------------------
 */
function tpl_function_load($params, &$tpl) {
	return file_get_contents($params['url']);
}
?>
