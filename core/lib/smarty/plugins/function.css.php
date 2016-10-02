<?php
/**
 * Smarty-Light plugin
 * -------------------------------------------------------------
 * Type:     function
 * Name:     css
 * Purpose:  CSS-t lehet megadni az oldalnak a content template-ekből a layout template-be.
 *           A két paraméter közül egyiket kell megadni.
 *           Ha a name van megadva, akkor hozzáadja a listához.
 *           Ha az assign, akkor visszaadja a listát a megadott változóban.   
 * Input:
 *         - name:    a CSS neve.
 *                    Relatív útvonalat kell megadni, ugyanúgy tölti be, mint a loadfromskin:
 *                    ../_common/css/customer_care.css
 *                    css/component.css
 *         - assign:  a változó neve, amibe a CSS-ek listája kerül    
 * -------------------------------------------------------------
 */
function tpl_function_css($params, &$tpl) {
	static $css;

	if (empty($params['name']) && empty($params['assign'])) return;

	if (!empty($params['assign'])) {
		$tpl->assign($params['assign'], $css);
	}

	if (!empty($params['name'])) {
		$css[] = $params['name'];
	}
}
?>
