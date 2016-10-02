<pre>
<?php
	/**
	 * Felsorolja a mail listakat
	 * Az elso lekerdezes a "Master" nevut
	 * A masodik lekerdezes meg az osszeset
	 */	 	 	 	

	include 'vendor/mailchimp/mailchimp/src/Mailchimp.php';
	try {
		$mc = new Mailchimp('8029b15cf36b9131b8d6c80bb8ca1059-us3'); //your api key here
	} catch (Mailchimp_Error $e) {
		die('You have not set an API key. Set it in Controller/AppController.php');
	}

	try {
		$lists = $mc->lists->getList( [ 'list_name' => 'Master' ] );
		print_r($lists['data']);
	} catch (Mailchimp_Error $e) {
		if ($e->getMessage()) {
			die($e->getMessage());
		} else {
			echo('An unknown error occurred');
		}
	}

	try {
		$lists = $mc->lists->getList();
		print_r($lists['data']);
	} catch (Mailchimp_Error $e) {
		if ($e->getMessage()) {
			die($e->getMessage());
		} else {
			echo('An unknown error occurred');
		}
	}
?>
</pre>
