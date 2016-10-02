<?php
/**
 * Smarty-Light basename modifier plugin
 *
 * Type:     modifier
 * Name:     nl2br
 * Purpose:  Wrapper for the PHP 'basename' function
 */
function tpl_modifier_basename($tpl, $string) {
	return basename($string);
}
?>