<?php
	/**
	 * Ezeket a domaineket kezeli a keretrendszer.
	 * A tömb kulcsa a domain, az értéke a site beállításai.
	 * Az id_site-ot és a site_engine-t mindenképp definiálni kell.
	 *   id_site: A weboldal egyedi azonosítója, az értéke bármi lehet. Célszerű ugyanarra állítani a tesztkörnyezetben, mint az éles rendszeren, mert pl ez alapján kapcsolja az oldalhoz az article modul a tartalmat.
	 *   site_engine: A site_engine-t azonosítja. Ez határozza meg, hogy melyik site-t kell futtatni az adott domain esetén. A /content/sites/[site_engine] könyvtárban levő modulokat használja majd a rendszer.	  
	 *
	 *  $GLOBALS['sites'] = array(
	 *    'www.example.com' => array(
	 *      'id_site'     => 'example',
	 *      'site_engine' => 'www',
	 *      'skin'        => 'default'
	 *    ),	 	 
	 *  );
	 *  
	 *  Ha több skin is van a site_engine-hez, akkor itt lehet megadni, hogy az adott domain esetén melyiket használja.
	 */
	$GLOBALS['sites'] = array(
		'http://local.enniesgarden.co.uk'  => array(
			'redirect' => 'http://local.www.enniesgarden.co.uk',
		),
		'http://local.www.enniesgarden.co.uk'  => array(
			'id_site'              => 'ennies-garden-www3',
			'site_engine'          => 'www',
			'shop_permalink'       => 'ennies-garden',
			'in_email'             => 'syke80@gmail.com',
			'out_email'            => 'syke80@gmail.com',
			'out_email_name'       => 'Ennie\'s Garden - Syke Notebook',
			'google_client_id'     => '165614317917-ffebfvsegnhis3mrkr31hvamh7a27gqs.apps.googleusercontent.com',
			'google_client_secret' => '2ywwiOXXFHctqcQphHlnbHB1',
			'fb_app_id'            => '1462315397371091',
			'fb_app_secret'        => '81c01935ce055a8b73b760406006f91b',
			'charityclear_merchant_id' => '100003',
			//'charityclear_merchant_id' => '100936',
			//'mailchimp_client_id'  => '113104897318',
			//'mailchimp_client_secret' => '878a8f99353a7102d6b2cbccd524a2b1',
			'mailchimp_api_key'  => '8029b15cf36b9131b8d6c80bb8ca1059-us3',
			'mailchimp_id'       => '8029b15cf36b9131b8d6c80bb8ca1059-us3',
			'mailchimp_list'     => 'Test',
			'charityclear_test'  => TRUE,
			'debug'              => FALSE,
			'heatmap_active'     => FALSE,
			'paypal_testmode'    => TRUE,
			'paypal_user'        => 'info-facilitator_api1.enniesgarden.co.uk',
			'paypal_password'    => 'GFDGDJARCKHX64DD',
			'paypal_signature'   => 'AQYgIKTexUubMT86lDYBHu1AKJa4AEeYjCVoApxOiBFznt04565t1pjO',
			'ga_id'              => 'UA-XXXXX-XX',
		),
		'http://local.admin.enniesgarden.co.uk'  => array(
			'id_site'        => 'admin',
			'site_engine'    => 'admin',
			'in_email'       => 'syke80@gmail.com',
			'out_email'      => 'syke80@gmail.com',
			'out_email_name' => 'Ennie\'s Garden - Syke Notebook',
			'shop_url'       => 'http://local.www.enniesgarden.co.uk',
			'access' => array(
				'disabled'     => 0x0001,
				'inactive'     => 0x0010,
				'stock_admin'  => 0x0100,
				'shop_admin'   => 0x1000,
				'root'         => 0x1100,
			),
		),
		'http://local.api.enniesgarden.co.uk'  => array(
			'id_site'        => 'api',
			'site_engine'    => 'api',
			'shop_permalink' => 'ennies-garden',
			'in_email'       => 'syke80@gmail.com',
			'out_email'      => 'syke80@gmail.com',
			'out_email_name' => 'Ennie\'s Garden API - Syke Notebook',
			'shop_url'       => 'http://local.www.enniesgarden.co.uk',
		),
	);
?>