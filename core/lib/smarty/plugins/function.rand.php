<?php
/**
 * Smarty-Light plugin
 * -------------------------------------------------------------
 * Type:     function
 * Name:     rand
 * Purpose:  Wrapper a php 'rand' függvényéhez (véletlenszámot generál)
 * Credit:   syke
 * 
 * Input:
 *         - assign: A változó neve, amibe az eredmény kerül. 
 *         - min:    A szám minimum értéke.
 *         - max:    A szám maximum értéke.    
 * -------------------------------------------------------------
 */
function tpl_function_rand($params, &$tpl) {
	$tpl->assign($params['assign'], rand($params['min'], $params['max']));
}
?>