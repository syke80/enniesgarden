<?php
/**
 * Smarty-Light plugin
 * -------------------------------------------------------------
 * Type:     function
 * Name:     form
 * Purpose:  Formot es hozza tartozo ajax scriptet general
 * Input:
 *         - form_id:  a form azonositoja
 *         - itemtype: az elem tipusa: form, text, select
 *         - method:   get, post, put, delete
 *         - action:   a form action attributuma
 *         - name:     a field neve (ezt postolja majd a script)
 *         - label:    a field cimkeje
 * -------------------------------------------------------------
 */

function _tpl_list_render($sTemplate, $aParams) {
		$oTpl = new template();
		$oTpl->compile_dir          = DIR_SMARTY_COMPILED;
		$oTpl->template_default_dir = DIR_CORE.'/lib/smarty/plugins';
		$oTpl->template_dir         = DIR_SKIN.'/templates';

		foreach ($aParams as $sVarName => $xValue) {
			$oTpl->assign($sVarName,$xValue);
		}

		return $oTpl->fetch($sTemplate.'.tpl');
}

function tpl_function_list($params, &$tpl) {
	$data = file_get_contents($params['url']);

	if (empty($params['fields'])) {
	}
	else {
		$fields = array_map('trim', explode(',',$params['fields']));
	}

	return _tpl_list_render('list/list', array(
		'data' => json_decode($data, TRUE),
		'fields' => $fields,
		'titles' => empty($params['titles']) ? $fields : explode('|', $params['titles']),
	));
}
?>