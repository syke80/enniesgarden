<?php
/**
 * Smarty-Light isset modifier plugin
 *
 * Type:     modifier
 * Name:     isset
 * Purpose:  Wrapper for the PHP 'isset' function
 */
function tpl_modifier_isset($tpl, $varname) {
	return(isset($tpl->_vars[$varname]));
}
?>