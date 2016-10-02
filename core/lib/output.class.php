<?php
/**
 * A kimenet generálásáért felelős osztály
 */
class Output {
	/**
	 * Json kimenetet állít elő a paraméterben átadott tömbből
	 * 
	 * @param  array     $aVars  A változók, amiket át kell adni a kimenetnek
	 * @return string    A JSON enkódolt tömb
	 */
	public static function json($aVars = '') {
	  if (empty($aVars)) $aVars = array();
		header('Content-Type: application/json', TRUE, 200);
		return json_encode($aVars);
	}

	/**
	 * Renderel egy oldalt smarty-val
	 * 
	 * @param  string   $sTemplate        A template neve
	 * @param  array    $aParams          A template változóinak listája
	 * @param  string   $sLayoutTemplate  A layout template neve
	 * @return string   A generált HTML
	 */
	public static function render($sTemplate, $aParams = array(), $sLayoutTemplate='default') {	
		$oTpl = new template();
		$oTpl->compile_dir          = DIR_SMARTY_COMPILED;
		$oTpl->template_default_dir = DIR_SKIN_DEFAULT.'/templates';
		$oTpl->template_dir         = DIR_SKIN.'/templates';

		foreach ($aParams as $sVarName => $xValue) {
			$oTpl->assign($sVarName,$xValue);
		}

		$sContent = $oTpl->fetch($sTemplate.'.tpl');

		// Ha van layout template, akkor átadja neki a tartalmat, és rendereli
		if (file_exists(DIR_SKIN.'/templates/layout/'.$sLayoutTemplate.'.tpl') || file_exists(DIR_SKIN_DEFAULT.'/templates/layout/'.$sLayoutTemplate.'.tpl')) {
			$oTpl->assign('content', $sContent);
	
			$oTpl->template_default_dir = DIR_SKIN_DEFAULT.'/templates/layout';
			$oTpl->template_dir         = DIR_SKIN.'/templates/layout';
	
			$oTpl->assign("debugdata", (Debug::getDebugLevel() & DEBUG_RENDER) ? Debug::getDebugData() : '');
	
			return $oTpl->fetch($sLayoutTemplate.'.tpl');
		}
		else {
			return $sContent;
		}
	}
}
?>