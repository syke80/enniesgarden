<?php
	/**
	 * Ezeket a domaineket kezeli a keretrendszer.
	 * A tömb kulcsa a domain, az értéke a site beállításai.
	 * Az id_site-ot és a site_engine-t mindenképp definiálni kell.
	 *   id_site: A weboldal egyedi azonosítója, az értéke bármi lehet. Célszerű ugyanarra állítani a tesztkörnyezetben, mint az éles rendszeren, mert pl ez alapján kapcsolja az oldalhoz a page modul a tartalmat.
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
		'http://website.com'  => array(
			redirect      => 'http://www.website.com',
		),
		'http://admin.website.com'  => array(
			'id_site'     => 'admin',
			'site_engine' => 'admin',
		),
		'http://www.website.com'  => array(
			'id_site'     => 'www',
			'site_engine' => 'www',
			'languages'   => array('en', 'hr', 'hu')
		),
		'http://products.website.com'  => array(
			'id_site'     => 'products',
			'site_engine' => 'products',
			'languages'   => array('en', 'hr', 'hu')
		),
		'http://services.website.com'  => array(
			'id_site'     => 'services',
			'site_engine' => 'services',
			'languages'   => array('en', 'hr', 'hu')
		),
	);
?>