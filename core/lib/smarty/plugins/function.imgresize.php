<?php
/*
 * Smarty-Light plugin
 * -------------------------------------------------------------
 * Type:     function
 * Name:     imgresize
 * 
 *  $params['width']
 *  $params['height']  
 *  $params['type']  
 *  $params['file']
 *  $params['ratio']: device pixel ratio
 *     
 * Purpose:  
 * Credit:   syke
 * -------------------------------------------------------------
 */

include_once DIR_CORE.'/lib/img.php';

function tpl_function_imgresize($params, &$tpl) {
	if ($params['ratio'] > 1 && $params['ratio'] <= 1.5) {
		$params['resized_filename'] .= '@1.5';
		$params['width'] *= 1.5;
		$params['height'] *= 1.5;
	}
	elseif ($params['ratio'] > 1.5) {
		$params['resized_filename'] .= '@2';
		$params['width'] *= 2;
		$params['height'] *= 2;
	}

	$aImgData = Img::imgResize($params['file'], $params['width'], $params['height'], $params['resized_filename'], $params['type']);
	return $aImgData['url'];
}
?>