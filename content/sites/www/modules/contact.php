<?php
class ContactModule extends Module {
	protected function _access($sMethodName) {
		return TRUE;
	}

	public function path() {
		return array(
			'contact' => array(
				'method'      => 'default',
				'id_language' => 'en',
				'public'      => FALSE,
			),
		);
	}

	/**
	 * Contact web service
	 *
	 *   POST   /contact/               Kuld egy emailt a bolt tulajdonosanak
	 *
	 * @return string|json              a feldolgozás közben bekövetkező hibák
	 */
	protected function _reqDefault() {
		$aVars = Request::getRequestVars();
		switch (Request::getRequestMethod()) {
			case 'POST':
				$aRes['error'] = array();
				$aRequiredVars = array(
					'name', 'email', 'subject', 'message',
				);
				if (array_keys_exists($aRequiredVars, $aVars)) {
					if (empty($aVars['name'])) $aRes['error'][] = 'empty_name';
					if (empty($aVars['email'])) $aRes['error'][] = 'empty_email';
					if (empty($aVars['subject'])) $aRes['error'][] = 'empty_subject';
					if (empty($aVars['message'])) $aRes['error'][] = 'empty_message';
					if (!empty($aVars['email']) && !filter_var($aVars['email'], FILTER_VALIDATE_EMAIL)) $aRes['error'][] = 'error_email';
					if (empty($aRes['error'])) {
						$sMsgBody = Output::render('_contact_email', $aVars);
						mymail($GLOBALS['siteconfig']['in_email'], $aVars['subject'], $sMsgBody, $GLOBALS['siteconfig']['out_email'], $GLOBALS['siteconfig']['out_email_name']);
					}
				}
				else {
					$aRes['error'][] = 'form';
				}
				return Output::json($aRes);
				break;
		}
	}
}
?>