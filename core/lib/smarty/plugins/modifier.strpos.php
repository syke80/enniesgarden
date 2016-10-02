<?php
/**
 * Smarty-Light replace modifier plugin
 *
 * Type:     modifier
 * Name:     replace
 * Purpose:  Wrapper for the PHP 'strpos' function
 * Credit:   syke
 */
function tpl_modifier_strpos($tpl, $string, $search) {
	return strpos($string, $search);
}
?>