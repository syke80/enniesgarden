<?php
/**
 * Smarty-Light var_dump modifier plugin
 *
 * Type:     modifier
 * Name:     wordwrap
 * Purpose:  Wrapper for the PHP 'var_dump' function
 */
function tpl_modifier_var_dump($tpl, $string) {
	if (is_array($string)) {
		var_dump($string);
	}
}
?>