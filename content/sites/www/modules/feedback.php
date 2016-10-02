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
			'feedback/thankyou' => array(
				'method'      => 'thankyou',
				'id_language' => 'en',
				'public'      => FALSE,
			),
			'feedback/subscribe' => array(
				'method'      => 'subscribe',
				'id_language' => 'en',
				'public'      => FALSE,
			),
		);
	}

	protected function _reqThankyou() {
		return Output::render('feedback_thankyou', getLayoutVars() + [
			'email'       => isset($_GET['email']) ? $_GET['email'] : '',
			'first_name'  => isset($_GET['first_name']) ? $_GET['first_name'] : '',
			'last_name'   => isset($_GET['last_name']) ? $_GET['last_name'] : '',
		]);
	}

	protected function _reqSubscribe() {
		$aVars = Request::getRequestVars();

		if (empty($aVars['email']) || empty($aVars['first_name']) || empty($aVars['last_name'])) {
			$res['error'] = 'not_set';
			return Output::json($res);
		}

		include 'vendor/mailchimp/mailchimp/src/Mailchimp.php';
		try {
			$mc = new Mailchimp('8029b15cf36b9131b8d6c80bb8ca1059-us3'); //your api key here
		} catch (Mailchimp_Error $e) {
			die('You have not set an API key. Set it in Controller/AppController.php');
		}

		try {
			$lists = $mc->lists->getList( [ 'list_name' => 'Test' ] );
		} catch (Mailchimp_Error $e) {
			if ($e->getMessage()) {
				$res['error'] = $e->getMessage();
				return Output::json($res);
			} else {
				$res['error'] = 'An unknown error occurred';
				return Output::json($res);
			}
		}

		$subscriber = [
			'email' => htmlentities($aVars['email']),
		];


		try {
			$res = $mc->lists->subscribe($lists['data'][0]['id'], $subscriber, ['FNAME'=>$aVars['first_name'], 'LNAME'=>$aVars['last_name']], 'html', false);
		} catch (Mailchimp_Error $e) {
			if ($e->getMessage()) {
				$res['error'] = $e->getMessage();
				return Output::json($res);
			} else {
			}
		}

		return Output::json($res);
	}

	protected function _reqDefault() {
		$aVars = Request::getRequestVars();
		switch (Request::getRequestMethod()) {
			case 'GET':
				return Output::render('feedback', getLayoutVars());
			break;
			case 'POST':
				// Collects incoming data
				if (!file_exists((DIR_FILES."/feedback"))) mkdir(DIR_FILES."/feedback", 0777, TRUE);
				file_put_contents(DIR_FILES.'/feedback/feedback.txt', date('Y-m-d H:i:s')."\r\n".print_r($aVars, true), FILE_APPEND);

				$oCouponDao =& DaoFactory::getDao('coupon');
				$sExpiration = date("Y-m-d",strtotime("+1 month"));
				$sExpirationTxt = date("d/F/Y",strtotime("+1 month"));
				$sCouponCode = $oCouponDao->createCoupon(time(), 'free-product', 'butter-shortbread', $sExpiration, 'n');
				$sMessage = Output::render('_email_feedback_coupon', getLayoutVars() + [
					'name'       => $aVars['name'],
					'email'      => $aVars['email'],
					'couponcode' => $sCouponCode,
					'expiration' => $sExpirationTxt,
				]);
/*
print_r($aVars);
print_r($sMessage);
die();
*/
				mymail($aVars['email'], '"Free Shortbread" coupon', $sMessage, $GLOBALS['siteconfig']['out_email'], $GLOBALS['siteconfig']['out_email_name']);

				Request::redirect($GLOBALS['siteconfig']['site_url'].'/feedback/thankyou/');
			break;
		}
	}
}
?>