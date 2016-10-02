<?php
class QrModule extends Module {
	protected function _access($sMethodName) {
		return TRUE;
	}

	public function path() {
		return array(
			'qr' => array(
				'method'      => 'default',
			),
		);
	}
	protected function _reqDefault($sPermalink) {
		$aUtm = [
			'utm_source'   => isset($_GET['utm_source']) ? $_GET['utm_source'] : 'jar',
			'utm_medium'   => isset($_GET['utm_medium']) ? $_GET['utm_medium'] : 'qr',
			'utm_campaign' => isset($_GET['utm_campaign']) ? $_GET['utm_campaign'] : 'product',
		];
		if (empty($sPermalink)) Request::redirect($GLOBALS['site_url'].'/', $aUtm);
		else Request::redirect($GLOBALS['site_url']."/{$sPermalink}/", $aUtm);
	}
}
