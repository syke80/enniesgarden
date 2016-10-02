<?php
class GatewayModule extends Module {
	protected function _access($sMethodName) {
		return TRUE;
	}

	public function path() {
		return array(
			'gateway/analytics.js' => array(
				'method'      => 'analytics',
			),
		);
	}

	protected function _reqAnalytics() {
		header('Cache-Control: max-age='.(60*60*2));
		return file_get_contents("http://www.google-analytics.com/analytics.js");
	}
}