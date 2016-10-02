<?php

/**
 * splits single name string into salutation, first, last, suffix
 * 
 * @param string $name
 * @return array
 */
function splitName($name) {
	$results = array();
	
	$r = explode(' ', $name);
	$size = count($r);
	
	//check first for period, assume salutation if so
	if (mb_strpos($r[0], '.') === false) {
		$results['salutation'] = '';
		$results['first'] = $r[0];
	}
	else {
		$results['salutation'] = $r[0];
		$results['first'] = $r[1];
	}
	
	//check last for period, assume suffix if so
	if (mb_strpos($r[$size - 1], '.') === false) {
		$results['suffix'] = '';
	}
	else {
		$results['suffix'] = $r[$size - 1];
	}
	
	//combine remains into last
	$start = ($results['salutation']) ? 2 : 1;
	$end = ($results['suffix']) ? $size - 2 : $size - 1;
	
	$last = '';
	for ($i = $start; $i <= $end; $i++) {
		$last .= ' '.$r[$i];
	}
	$results['last'] = trim($last);
	
	return $results;
}

function map_assoc($array, $function = NULL) {
	$result = array();
	foreach ($array as $value) {
		$result[$value] = $value;
	}
	return $result;
}

/**
 * Recursive rmdir()
 */ 
function rrmdir($dir) { 
  foreach(glob($dir . '/*') as $file) { 
    if(is_dir($file)) rrmdir($file); else unlink($file); 
  } rmdir($dir); 
}

function _windows_recent_date($path) {
	$recentDate = 0;
	foreach (glob($path.'/*') as $filename) if (filemtime($filename) >= $recentDate) $recentDate = filemtime($filename); 
	return $recentDate;
}

function sort_by_mtime($file1,$file2) {
	$time1 = filemtime($file1);
	$time2 = filemtime($file2);
	if ($time1 == $time2) {
		return 0;
	}
	return ($time1 < $time2) ? -1 : 1;
}

function checkModuleModifications() {
	//$iMTimes = (int)(filemtime(DIR_SITES.'/'.$GLOBALS['site_engine']));
	$iMTime = (int)(_windows_recent_date(DIR_CONTENT.'/sites/'.$GLOBALS['siteconfig']['site_engine'].'/modules'));
	$sPathFilename = DIR_CACHE.'/'.$GLOBALS['siteconfig']['site_engine'].'.path.php';
	return (!file_exists($sPathFilename) || filemtime($sPathFilename) < $iMTime);
}

/**
 * Az oldalhoz tartozó összes modulból létrehoz egy-egy példányt
 * A path metódusokból kiolvassa a modulokhoz tartozó permalinkeket
 * Ez alapján felépít egy ilyesmi tömböt:
 *    [] => Array
 *        (
 *            [method] => default
 *            [module] => default
 *        )
 *
 *    [order] => Array
 *        (
 *            [method] => default
 *            [module] => order
 *        )
 *
 *    [order/list] => Array
 *        (
 *            [method] => list
 *            [module] => order
 *        )
 *    [category] => Array
 *        (
 *            [method] => default
 *            [module] => category
 *        )
 */  
function parseModulePath() {
	$GLOBALS['siteconfig']['path'] = array();
	$aFileList = scandir(DIR_CONTENT.'/sites/'.$GLOBALS['siteconfig']['site_engine'].'/modules');
	foreach ($aFileList as $sFileName) {
		if (preg_match('#([^\.|\.\.$]+).php#i', $sFileName, $aFileNameParts)) {
			$oModule =& ModuleFactory::getModule($aFileNameParts[1]);
			if (!empty($oModule)) {
				// path metódus eredményének kiolvasása
				$aModulePathList = $oModule->path();
				// Csak akkor foglalkoyunk vele, ha tömböt ad vissza. Pl. lehet olyan modul is, ami kívülről nem elérhető, abban csak egy return van.
				if (is_array($aModulePathList)) {
					// Ha valamelyik elemnel nincs definialva a module, akkor definialjuk
					foreach ($aModulePathList as &$aModulePath) {
						if (!isset($aModulePath['module'])) $aModulePath['module'] = $aFileNameParts[1];
					}
					$GLOBALS['siteconfig']['path'] += $aModulePathList;
				}
			}
		}
	}
}

function saveModulePath() {
	file_put_contents(DIR_CACHE.'/'.$GLOBALS['siteconfig']['site_engine'].'.path.php', serialize($GLOBALS['siteconfig']['path']));
}

function loadModulePath($sSiteEngine='') {
	if (empty($sSiteEngine)) $sSiteEngine = $GLOBALS['siteconfig']['site_engine'];
	return unserialize(file_get_contents(DIR_CACHE.'/'.$sSiteEngine.'.path.php'));
}

/**
 * Wrapper a htmlspecialchars függvényhez
 *
 * Ha a bejövő változó string, akkor megtisztítja a html kódtól
 * Visszatérési értéke nincs, mert a változót cím szerint kapja meg
 *
 * @param  mixed
 *
 * @return void
 */
function _htmlspecialchars_wrapper(&$xVar) {
	if (gettype($xVar) == 'string') $xVar = htmlspecialchars($xVar);
}

/**
 * Wrapper a htmlspecialchars függvényhez
 *
 * Ha a bejövő változó string, akkor megtisztítja a html kódtól
 * Visszatérési értéke nincs, mert a változót cím szerint kapja meg
 *
 * @param  mixed
 *
 * @return void
 */
function deaccent($sText) {
	$aTrans = array(
		"Ó" => "O",
		"Á" => "A",
		"É" => "E",
		"Í" => "I",
		"Ö" => "O",
		"Ő" => "O",
		"Ű" => "U",
		"Ü" => "U",
		"Ú" => "U",
		"ó" => "o",
		"á" => "a",
		"é" => "e",
		"í" => "i",
		"ö" => "o",
		"ő" => "o",
		"ű" => "u",
		"ú" => "u",
		"ü" => "u"
	);
	return strtr($sText, $aTrans);
}

/**
 * A tömb elemeit megtisztítja a HTML kódoktól
 *
 * @param  array  $aVars
 *
 * @return array
 */
function cleanValues($aVars) {
	if (!empty($aVars)) array_walk($aVars, '_htmlspecialchars_wrapper');
	return $aVars;
}

/**
 * Egy tömb elemeiből camelcase stílusú stringet generál
 *
 * @param  array  $aVars
 *
 * @return string
 */
function toCamelCase($aItems) {
	$sResult = '';
	foreach ($aItems as $sItem) {
		$sResult .= ucfirst(strtolower($sItem));
	}
	return $sResult;
}

/**
 * Ellenőrzi a megadott kulcsok létezését a tömbben
 *
 * @param  array    $aKeyList  A keresett kulcsok listája
 * @param  array    $aArray    A tömb aminek a kulcsait vizsgáljuk
 *
 * @return boolean  TRUE ha minden kulcs létezik, FALSE ha nem
 */
function array_keys_exists($aKeyList, $aArray) {
	foreach ($aKeyList as $sKey) {
		if (!array_key_exists($sKey, $aArray)) {
			Debug::addMsg("Array key not found: {$sKey}", '', DEBUG_LOG_INFO);
			return FALSE;
		}
	}
	return TRUE;
}

/**
 * Emailt küld a phpmailer osztályon keresztül
 *
 * @param  string   $sTo              Címzett
 * @param  string   $sSubject         Tárgy
 * @param  string   $sMessage         Üzenet
 * @param  string   $sFromEmail       Feladó email címe
 * @param  string   $sFromName        Feladó neve
 * @param  string   $aAttachmentList  Csatolt fájlok listája
 * $aImageList Embedded Image (filename, cid, name) 
 *
 * @return void
 */
function mymail($sTo, $sSubject, $sMessage, $sFromEmail='', $sFromName='', $aAttachmentList='', $aImageList=NULL) {
	require_once(DIR_CORE.'/lib/phpmailer/class.phpmailer.php');
	$sFrom = "{$sFromName} <{$sFromEmail}>";

	$sMessagePlaintext = strip_tags(str_replace(array('<br>','<br\>','<br \>'),"\r\n",$sMessage));

	$sHeaders = "From: {$sFrom}" . "\r\n";
	$sHeaders .= "Reply-To: {$sFrom}" . "\r\n";
	$sHeaders .= "Return-Path: {$sFrom}" . "\r\n";
	Debug::addMsg("to: {$sTo}\r\nsubject: {$sSubject}\r\nfrom: {$sFromEmail} ({$sFromName})\r\nmessage: {$sMessage}\r\nplain text: {$sMessagePlaintext}\r\n", 'email', DEBUG_LOG_MAIL);

	$oMail = new PHPMailer(TRUE);
	$oMail->CharSet = "utf-8";
	$oMail->From = $sFromEmail;
	$oMail->Sender = $sFromEmail;
	$oMail->FromName = $sFromName;
	$oMail->WordWrap = 50;
	//$oMail->SMTPDebug  = 2;
 	try {
		$oMail->AddAddress($sTo);
	} catch (phpmailerException $e) {
		Debug::addMsg('PhpMailer error: '.$e->getMessage(), 'email', DEBUG_LOG_MAIL);
  }
  $oMail->Subject = $sSubject;
  $oMail->Body = $sMessage;
  $oMail->AltBody = $sMessagePlaintext;
  $oMail->IsHTML(TRUE);

  if (!empty($aAttachmentList)) {
  	foreach ($aAttachmentList as $xAttachment) {
			if (is_array($xAttachment)) {
				call_user_func_array(array($oMail, "AddAttachment"), $xAttachment);
			}
			else {
				$oMail->AddAttachment($xAttachment);
			}
		}
	}

  if (!empty($aImageList)) {
  	foreach ($aImageList as $aImage) {
			call_user_func_array(array($oMail, "AddEmbeddedImage"), $aImage);
		}
	}

	if (!empty($GLOBALS['smtp_config']['host'])) {
		$oMail->IsSMTP();
		$oMail->SMTPAuth = $GLOBALS['smtp_config']['auth'];
		$oMail->Host = $GLOBALS['smtp_config']['host'];
		$oMail->Port = $GLOBALS['smtp_config']['port'];
		$oMail->Username = $GLOBALS['smtp_config']['username'];
		$oMail->Password = $GLOBALS['smtp_config']['password'];
		if (isset($GLOBALS['smtp_config']['secure'])) $oMail->SMTPSecure = $GLOBALS['smtp_config']['secure'];

	}

	try {
		$bResult = $oMail->Send();
  } catch (phpmailerException $e) {
		Debug::addMsg('PhpMailer error: '.$e->getMessage(), 'email', DEBUG_LOG_MAIL);
  }

	if (isset($bResult)) {
		if ($bResult) Debug::addMsg("PhpMailer: mail sent", 'email', DEBUG_LOG_MAIL);
		else Debug::addMsg("PhpMailer error: {$oMail->ErrorInfo}", 'email', DEBUG_LOG_MAIL);
	}
}

/**
 * Megjeleniti az error lap template-jet
 *
 * @param  integer  $iErrorCode   A hibakód
 *
 * @return void
 */
function showErrorPage($iErrorCode, $sLanguageIso='en') {
	$sReason = httpCodes($iErrorCode);
	header("HTTP/1.0 {$iErrorCode} {$sReason}");
	echo Output::render('error',
		array(
			'siteconfig'  => $GLOBALS['siteconfig'],
			'language_iso' => $sLanguageIso,
			'errorcode'   => $iErrorCode,
			'reason'      => $sReason
		),
		'blank'
	);
	die();
}

function realip() {
	// No IP found (will be overwritten by for
	// if any IP is found behind a firewall)
	$ip = FALSE;
	
	// If HTTP_CLIENT_IP is set, then give it priority
	if (!empty($_SERVER["HTTP_CLIENT_IP"])) {
		$ip = $_SERVER["HTTP_CLIENT_IP"];
	}
	
	// User is behind a proxy and check that we discard RFC1918 IP addresses
	// if they are behind a proxy then only figure out which IP belongs to the
	// user.  Might not need any more hackin if there is a squid reverse proxy
	// infront of apache.
	if (!empty($_SERVER['HTTP_X_FORWARDED_FOR'])) {
		
		// Put the IP's into an array which we shall work with shortly.
		$ips = explode (", ", $_SERVER['HTTP_X_FORWARDED_FOR']);
		if ($ip) {
			array_unshift($ips, $ip); $ip = FALSE;
		}
		
		for ($i = 0; $i < count($ips); $i++) {
			// Skip RFC 1918 IP's 10.0.0.0/8, 172.16.0.0/12 and
			// 192.168.0.0/16
			if (!preg_match('/^(?:10|172\.(?:1[6-9]|2\d|3[01])|192\.168)\./', $ips[$i])) {
				if (ip2long($ips[$i]) != false) {
					$ip = $ips[$i];
					break;
				}
			}
		}
	}
	
	// Return with the found IP or the remote address
	return ($ip ? $ip : $_SERVER['REMOTE_ADDR']);
}

function getBytesFromHexString($hexdata) {
	for($count = 0; $count < strlen($hexdata); $count+=2) {
		$bytes[] = chr(hexdec(substr($hexdata, $count, 2)));
	}
	return implode($bytes);
}

function getImageMimeType($imagedata) {
	$imagemimetypes = array( 
		"image/jpeg" => "FFD8", 
		"image/png" => "89504E470D0A1A0A", 
		"image/gif" => "474946",
		"image/bmp" => "424D", 
		"image/tiff" => "4949",
		"image/tiff" => "4D4D"
	);
	
	foreach ($imagemimetypes as $mime => $hexbytes) {
		$bytes = getBytesFromHexString($hexbytes);
		if (substr($imagedata, 0, strlen($bytes)) == $bytes) return $mime;
	}
	
	return NULL;
}
?>