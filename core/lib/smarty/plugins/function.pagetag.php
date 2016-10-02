<?php
/**
 * Smarty-Light plugin
 * -------------------------------------------------------------
 * Type:     function
 * Name:     pagetag
 * Purpose:  Az oldal title, description, keywords tag-jeit állítja be
 *           hogy a content templatekből fel lehessen tölteni értékekkel
 *           a tageket a layout template számára.
 * Input:
 *         - name:    a tag neve:        title | description | keywords
 *         - method:  a metódus típusa:  overwrite | append | get
 *                    ha nincs megadva value, akkor get az alapértelmezett,
 *                    ha meg van adva, akkor pedig overwrite
 *         - value:   a tag értéke
 *         - default: alapértelmezett érték. ezt adja vissza (írja ki),
 *                    ha a templatek nem töltötték fel tartalommal
 * -------------------------------------------------------------
 */
function tpl_function_pagetag($params, &$tpl) {
	static $pagetag;

	if (empty($params['method'])) {
		if (empty($params['value'])) $params['method'] = 'get';
		else $params['method'] = 'overwrite';
	}

	if (
		($params['name'] != 'title' && $params['name'] != 'description' && $params['name'] != 'keywords') ||
		($params['method'] != 'overwrite' && $params['method'] != 'append' && $params['method'] != 'get')
	) return;
	switch ($params['method']) {
		case 'overwrite':
			$pagetag[$params['name']] = $params['value'];
			break;
		case 'append':
			if (!isset($pagetag[$params['name']])) $pagetag[$params['name']] = '';
			if ($params['name'] == 'keywords' && !empty($pagetag[$params['name']])) {
				 $pagetag[$params['name']] .= ', ';
			}
			$pagetag[$params['name']] .= $params['value'];
			break;
		case 'get':
			if (!isset($params['default'])) $params['default'] = '';
			return isset($pagetag[$params['name']]) ? $pagetag[$params['name']] : $params['default'];
			break;
	}
}
?>
