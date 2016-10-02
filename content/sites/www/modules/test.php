<?php
class TestModule extends Module {
	protected function _access($sMethodName) {
		return TRUE;
	}

	public function path() {
		return array(
			'test/mail' => array(
				'method'      => 'mail',
				'public'      => FALSE,
			),
			'test/popup' => array(
				'method'      => 'popup',
				'public'      => FALSE,
			),
		);
	}
	protected function _reqMail() {
		if (empty($_GET['recipient'])) return FALSE;
		mymail($_GET['recipient'], 'Order notification (test)', 'Lorem ipsum dolor sit amet consectetuer adipiscing elit', 'info@enniesgarden.co.uk', "Ennie's Garden");
	}
	protected function _reqPopup() {
		return Output::render('test-modal');
	}
}
