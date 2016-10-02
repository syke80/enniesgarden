<?php
class InfoModule extends Module {
	protected function _access($sMethodName) {
		return TRUE;
	}

	public function path() {
		return array(
			'info' => array(
				'method'      => 'default',
			),
		);
	}

	/**
	 * Ellenőrzi a paraméterben megadott template létezését
	 *
	 * @param  string  $sTplName  A template neve
	 *
	 * @return bool    TRUE ha létezik, FALSE ha nem
	 */
	private function _tplExists($sTplName) {
		if (file_exists("{$GLOBALS['site_dir']}/skins/{$GLOBALS['site_engine']}/{$GLOBALS['skin']}/templates/{$sTplName}.tpl")) return TRUE;
		if (file_exists("{$GLOBALS['site_dir']}/skins/{$GLOBALS['site_engine']}/default/templates/{$sTplName}.tpl")) return TRUE;
		return FALSE;
	}

	/**
	 * Renderel egy templatet dinamikus adatok nélkül.
	 *
	 * @param  string   $sPage  A megjelenítendő oldal neve.
	 *                          A templatenek info_{$sPage}.tpl fájlban kell lennie
	 *
	 * @return string   A generált oldal tartalma
	 */
	protected function _reqDefault($sPage) {
		if (!isset($sPage)) showErrorPage(404);

		$sTplName = "info_{$sPage}";
		if (!$this->_tplExists($sTplName)) showErrorPage(404);

		return Output::render($sTplName, getLayoutVars());
	}
}
?>