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

function _tpl_form_render($sTemplate, $aParams) {
		$oTpl = new template();
		$oTpl->compile_dir          = DIR_SMARTY_COMPILED;
		$oTpl->template_default_dir = DIR_CORE.'/lib/smarty/plugins';
		$oTpl->template_dir         = DIR_SKIN.'/templates';

		foreach ($aParams as $sVarName => $xValue) {
			$oTpl->assign($sVarName,$xValue);
		}

		return $oTpl->fetch($sTemplate.'.tpl');
}

function tpl_function_form($params, &$tpl) {
	static $forms;
	static $last_used_form_id;
	static $last_used_fieldset = '';
	static $last_used_select_name;
	static $last_used_chk_name;
	static $last_used_radio_name;

	// Ha nincs megadva form_id, akkor az utoljara megadott azonosítót használja. Ha az sincs, akkor kilép
	if (!isset($params['form_id'])) $params['form_id'] = $last_used_form_id;
	else $last_used_form_id = $params['form_id'];
	if (empty($params['form_id'])) return;

	// Ha nincs megadva fieldset, akkor az utoljara megadott fieldsetet használja. Ha az sincs, akkor a defaultot: ''
	if (!isset($params['fieldset'])) $params['fieldset'] = $last_used_fieldset;
	else $last_used_fieldset = $params['fieldset'];

	if (!isset($params['cmd'])) $params['cmd'] = '';
	switch ($params['cmd']) {
		case 'render_form':
			return _tpl_form_render('form/form', $forms[$params['form_id']]);
			break;
		case 'render_javascript':
			if (!isset($params['resetform'])) $params['resetform'] = true;
			return _tpl_form_render(
				'form/js',
				$forms[$params['form_id']] + $params + array_fill_keys(array('msg_wait', 'msg_success','function_beforesubmit','function_beforeserialize','function_success','function_error'), '')
			);
			break;
		case 'error_msg':
			$forms[$params['form_id']]['error_msg'][$params['id']] = $params['msg'];
			break;
		default: // A form elemeinek beállítása
			// A $form változóba tölti a form adatait. Ha még nem létezik a form, akkor létrehozza.
			if (!isset($forms[$params['form_id']])) $forms[$params['form_id']] = array();
			$form =& $forms[$params['form_id']];
			
			if (isset($params['itemtype'])) {
				switch ($params['itemtype']) {
					case 'form':
						$form['id']             = $params['form_id'];
						$form['action']         = $params['action'];
						$form['method']         = $params['method'];
						$form['extraclass']     = isset($params['extraclass']) ? $params['extraclass'] : '';
						if (!isset($form['fieldsets'][$params['fieldset']])) $form[$params['fieldset']] = array();
						if (!isset($form['fieldsets'][$params['fieldset']]['items'])) $form[$params['fieldset']]['items'] = array();
						if (!isset($form['fieldsets'][$params['fieldset']]['extraclass'])) $form['fieldsets'][$params['fieldset']]['extraclass'] = '';
						if (!isset($form['error_msg'])) $form['error_msg'] = array();
						break;
					case 'fieldset':
						if (!isset($form['fieldsets'][$params['name']])) $form['fieldsets'][$params['name']] = array();
						$current_fieldset =& $form['fieldsets'][$params['name']];
						$current_fieldset['extraclass'] = isset($params['extraclass']) ? $params['extraclass'] : '';
						$current_fieldset['legend']     = isset($params['legend']) ? $params['legend'] : '';
						if (!isset($current_fieldset['items'])) $current_fieldset['items'] = array();
						$last_used_fieldset = $params['name'];
						break;
					case 'select':
						$last_used_select_name = $params['name'];
						$formitem =& $form['fieldsets'][$params['fieldset']]['items'][];
						$formitem['type']           = $params['itemtype'];
						$formitem['label']          = $params['label'];
						$formitem['name']           = $params['name'];
						$formitem['extraclass']     = isset($params['extraclass']) ? $params['extraclass'] : '';
						$formitem['note']           = isset($params['note']) ? $params['note'] : '';
						$formitem['default']        = isset($params['default']) ? $params['default'] : '';
						$formitem['options']        = array();
						$formitem['label_on_field'] = isset($params['label_on_field']) ? $params['label_on_field'] : FALSE;
						break;
					case 'option':
						if (!isset($params['name'])) $params['name'] = $last_used_select_name;
						else $last_used_select_name = $params['name'];
						if (empty($params['name'])) return;
						foreach ($form['fieldsets'][$params['fieldset']]['items'] as &$formitem) {
							if ($formitem['name'] == $params['name']){
								$option =& $formitem['options'][];
								$option['label']      = $params['label'];
								$option['value']      = $params['value'];
								$option['extraclass'] = isset($params['extraclass']) ? $params['extraclass'] : '';
							}
						}
						break;
					case 'chk_group':
						$last_used_chk_name = $params['name'];
						$formitem =& $form['fieldsets'][$params['fieldset']]['items'][];
						$formitem['type']           = $params['itemtype'];
						$formitem['label']          = $params['label'];
						$formitem['name']           = $params['name'];
						$formitem['serialize']      = $params['serialize'];
						$formitem['extraclass']     = isset($params['extraclass']) ? $params['extraclass'] : '';
						$formitem['checkboxes']     = array();
						break;
					case 'chk':
						if (!isset($params['name'])) $params['name'] = $last_used_chk_name;
						else $last_used_chk_name = $params['name'];
						if (empty($params['name'])) return;
						foreach ($form['fieldsets'][$params['fieldset']]['items'] as &$formitem) {
							if ($formitem['name'] == $params['name']){
								$checkbox =& $formitem['checkboxes'][];
								$checkbox['label']      = $params['label'];
								$checkbox['value']      = $params['value'];
								$checkbox['checked']    = $params['checked'];
								$checkbox['extraclass'] = isset($params['extraclass']) ? $params['extraclass'] : '';
							}
						}
						break;
					case 'radio_group':
						$last_used_radio_name = $params['name'];
						$formitem =& $form['fieldsets'][$params['fieldset']]['items'][];
						$formitem['type']           = $params['itemtype'];
						$formitem['label']          = $params['label'];
						$formitem['name']           = $params['name'];
						$formitem['extraclass']     = isset($params['extraclass']) ? $params['extraclass'] : '';
						$formitem['radiobuttons']   = array();
						break;
					case 'radio':
						if (!isset($params['name'])) $params['name'] = $last_used_radio_name;
						else $last_used_radio_name = $params['name'];
						if (empty($params['name'])) return;
						foreach ($form['fieldsets'][$params['fieldset']]['items'] as &$formitem) {
							if ($formitem['name'] == $params['name']){
								$radiobutton =& $formitem['radiobuttons'][];
								$radiobutton['label']      = $params['label'];
								$radiobutton['value']      = $params['value'];
								$radiobutton['extraclass'] = isset($params['extraclass']) ? $params['extraclass'] : '';
							}
						}
						break;
					case 'text':
						$formitem =& $form['fieldsets'][$params['fieldset']]['items'][];
						$formitem['type']           = $params['itemtype'];
						$formitem['label']          = $params['label'];
						$formitem['name']           = $params['name'];
						$formitem['autocomplete']   = isset($params['autocomplete']) ? $params['autocomplete'] : '';
						$formitem['default']        = isset($params['default']) ? $params['default'] : '';
						$formitem['readonly']       = isset($params['readonly']) ? $params['readonly'] : '';
						$formitem['extraclass']     = isset($params['extraclass']) ? $params['extraclass'] : '';
						$formitem['note']           = isset($params['note']) ? $params['note'] : '';
						$formitem['label_on_field'] = isset($params['label_on_field']) ? $params['label_on_field'] : FALSE;
						$formitem['disabled']       = isset($params['disabled']) ? $params['disabled'] : FALSE;
						$formitem['dontsend']       = isset($params['dontsend']) ? $params['dontsend'] : FALSE;
						$formitem['tabindex']       = isset($params['tabindex']) ? $params['tabindex'] : FALSE;
						break;
					case 'password':
						$formitem =& $form['fieldsets'][$params['fieldset']]['items'][];
						$formitem['type']           = $params['itemtype'];
						$formitem['label']          = $params['label'];
						$formitem['name']           = $params['name'];
						$formitem['autocomplete']   = isset($params['autocomplete']) ? $params['autocomplete'] : '';
						$formitem['extraclass']     = isset($params['extraclass']) ? $params['extraclass'] : '';
						$formitem['note']           = isset($params['note']) ? $params['note'] : '';
						$formitem['label_on_field'] = isset($params['label_on_field']) ? $params['label_on_field'] : FALSE;
						break;
					case 'textarea':
						$formitem =& $form['fieldsets'][$params['fieldset']]['items'][];
						$formitem['type']           = $params['itemtype'];
						$formitem['label']          = $params['label'];
						$formitem['name']           = $params['name'];
						$formitem['default']        = isset($params['default']) ? $params['default'] : '';
						$formitem['extraclass']     = isset($params['extraclass']) ? $params['extraclass'] : '';
						$formitem['note']           = isset($params['note']) ? $params['note'] : '';
						$formitem['label_on_field'] = isset($params['label_on_field']) ? $params['label_on_field'] : FALSE;
						break;
					case 'hidden':
						$formitem =& $form['fieldsets'][$params['fieldset']]['items'][];
						$formitem['type']           = $params['itemtype'];
						$formitem['name']           = $params['name'];
						$formitem['value']          = $params['value'];
						break;
					case 'submit':
						$formitem =& $form['fieldsets'][$params['fieldset']]['items'][];
						$formitem['type']           = $params['itemtype'];
						$formitem['label']          = $params['label'];
						$formitem['name']           = isset($params['name']) ? $params['name'] : '';
						$formitem['extraclass']     = isset($params['extraclass']) ? $params['extraclass'] : '';
						break;
					case 'button':
						$formitem =& $form['fieldsets'][$params['fieldset']]['items'][];
						$formitem['type']           = $params['itemtype'];
						$formitem['label']          = $params['label'];
						$formitem['name']           = isset($params['name']) ? $params['name'] : '';
						$formitem['extraclass']     = isset($params['extraclass']) ? $params['extraclass'] : '';
						break;
				}
		}
	}
}
?>