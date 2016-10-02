<pre>
<?php
	/**
	 * Lekerdezi a "Master" listat
	 * Felirat egy subscribert - a confirmation emailt kikapcsolja, azonnal hozzaadodik a listahoz
	 * Listazza a "Master" lista subscribereit	 	 
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
	




	$subscriber = [
		'email' => htmlentities('syke@outlook.com'),
	];


	try {
		$res = $mc->lists->subscribe($lists['data'][0]['id'], $subscriber, ['FNAME'=>'Davy2', 'LNAME'=>'Jones2'], 'html', false);
	} catch (Mailchimp_Error $e) {
		if ($e->getMessage()) {
			die("error: ".$e->getMessage());
		} else {
		}
	}

	print_r($res);





/*
	try {
		$res = $mc->lists->clients($lists['data'][0]['id']);
	} catch (Mailchimp_Error $e) {
		if ($e->getMessage()) {
			die("error: ".$e->getMessage());
		} else {
		}
	}
	print_r($res);
*/


?>
</pre>
