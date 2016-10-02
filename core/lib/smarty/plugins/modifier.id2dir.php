<?php
/**
 * Smarty-Light id2dir modifier plugin
 *
 * Type:     modifier
 * Name:     id2dir
 * Purpose:  If you use an id for directory name, and there are too many ids,
 *           you need to split them into sub dirs.
 *           For example:
 *           id 15    -> 0-999/15
 *           id 1234  -> 1000-1999/1234
 *           id 12345 -> 10000-10999/12345
 * 
 *  $params['id']
 */
function tpl_modifier_id2dir($tpl, $string) {
	$i = floor($string / 1000);
	return ($i*1000).'-'.(($i+1)*1000-1).'/'.$string;
}
?>