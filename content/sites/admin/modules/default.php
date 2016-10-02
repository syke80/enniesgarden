<?php
class DefaultModule extends Module {
	protected function _access($sMethodName) {
		$oUserauth =& ModuleFactory::getModule('userauth');
		return $oUserauth->isLoggedIn();
	}

	public function path() {
		return array(
			'' => array(
				'method'      => 'default',
			),
		);
	}

	/**
	 * Rendereli az admin főoldalát
	 *
	 * @return string   A generált oldal tartalma
	 */
	protected function _reqDefault() {
		return Output::render('default', getLayoutVars());
	}
}
?>