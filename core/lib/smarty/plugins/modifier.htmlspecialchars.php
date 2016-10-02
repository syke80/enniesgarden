<?php
/**
 * Smarty-Light replace modifier plugin
 *
 * Type:     modifier
 * Name:     htmlspecialchars
 * Purpose:  Wrapper for the PHP 'htmlspecialchars' function
 * Credit:   syke
 */
function tpl_modifier_htmlspecialchars($tpl, $string) {
	return htmlspecialchars($string);
}
?>