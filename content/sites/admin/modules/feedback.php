<?php
class FeedbackModule extends Module {
	protected function _access($sMethodName) {
		return TRUE;
	}

	public function path() {
		return array(
			'feedback' => array(
				'method'      => 'default',
				'id_language' => 'en',
				'public'      => FALSE,
			),
		);
	}

	protected function _reqDefault() {
		$aVars = Request::getRequestVars();
		switch (Request::getRequestMethod()) {
			case 'GET':
				return Output::render('feedback', getLayoutVars());
			break;
			case 'POST':
				$sMsgBody = Output::render('_email_feedback', getLayoutVars() + $aVars);
//				echo $sMsgBody;
				mymail($aVars['email'], 'Your Opinion Matters!', $sMsgBody, $GLOBALS['siteconfig']['out_email'], $GLOBALS['siteconfig']['out_email_name']);
				return Output::render('feedback_sent', getLayoutVars() + $aVars);
			break;
		}
	}
}
?>