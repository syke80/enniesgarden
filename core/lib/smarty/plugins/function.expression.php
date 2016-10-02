<?php
/**
 * Smarty-Light plugin
 * -------------------------------------------------------------
 * Type:     function
 * Name:     expression
 * Purpose:  Műveletet végez két bemenő paraméterrel,
 *           az eredményt egy változóba menti, vagy kiírja a kimenetre
 * Input:
 *         - op1, op2: a két operandus
 *         - operator: + - * / % .
 *         - assign:   a változó neve, amibe az eredmény kerül.
 *                     ha nincs megadva, akkor kiírja a kimenetre.
 * -------------------------------------------------------------
 */
function tpl_function_expression($params, &$tpl) {
	switch ($params['operator']) {
		case '+':
			$result = $params['op1'] + $params['op2'];
			break;
		case '-':
			$result = $params['op1'] - $params['op2'];
			break;
		case '*':
			$result = $params['op1'] * $params['op2'];
			break;
		case '/':
			$result = $params['op2'] != 0 ? $params['op1'] / $params['op2'] : 0;
			break;
		case '%':
			$result = $params['op2'] != 0 ? $params['op1'] % $params['op2'] : 0;
			break;
		case '.':
			$result = $params['op1'] . $params['op2'];
			break;
	}

	if (!empty($params['assign'])) {
		$tpl->assign($params['assign'], $result);
		return false;
	}
	else {
		return $result;
	}
}
?>