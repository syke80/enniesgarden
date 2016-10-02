<?php
public function testDoSplitName() {
	$array = array(
		'FirstName LastName',
		'Mr. First Last',
		'First Last Jr.',
		'Shaqueal O\'neal',
		'D’angelo Hall',
		'Václav Havel',
		'Oscar De La Hoya',
		'АБВГҐД ЂЃЕЀЁЄЖЗ', //cyrillic
		'דִּיש מַחֲזֹור', //yiddish
	);
		
	$assertions = array(
		array(
			'salutation' => '',
			'first' => 'FirstName',
			'last' => 'LastName',
			'suffix' => ''
		),
		array(
			'salutation' => 'Mr.',
			'first' => 'First',
			'last' => 'Last',
			'suffix' => ''
		),
		array(
			'salutation' => '',
			'first' => 'First',
			'last' => 'Last',
			'suffix' => 'Jr.'
		),
		array(
			'salutation' => '',
			'first' => 'Shaqueal',
			'last' => 'O\'neal',
			'suffix' => ''
		),
		array(
			'salutation' => '',
			'first' => 'D’angelo',
			'last' => 'Hall',
			'suffix' => ''
		),
		array(
			'salutation' => '',
			'first' => 'Václav',
			'last' => 'Havel',
			'suffix' => ''
		),
		array(
			'salutation' => '',
			'first' => 'Oscar',
			'last' => 'De La Hoya',
			'suffix' => ''
		),
		array(
			'salutation' => '',
			'first' => 'АБВГҐД',
			'last' => 'ЂЃЕЀЁЄЖЗ',
			'suffix' => ''
		),
		array(
			'salutation' => '',
			'first' => 'דִּיש',
			'last' => 'מַחֲזֹור',
			'suffix' => ''
		),
	);
	
	foreach ($array as $key => $name) {
		$result = Customer::doSplitName($name);
		
		$this->assertEquals($assertions[$key], $result);
	}
}