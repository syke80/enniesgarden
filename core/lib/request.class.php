<?php
/**
 * A http kérésekkel foglalkozó metódusok
 */

class Request {
	private static $sRequestKey = 'req';         // A GET változó neve amiben az apache átadja az útvonalat
	private static $sModuleName = NULL;          // A kért modul neve
	private static $sModulePath = NULL;          // Az URL path-ból az a rész, ami alapján a modult azonosította
	private static $sModuleMethodName = NULL;    // A kért metódus neve a modulban
	private static $aMethodParameterList = NULL; // A metódus paraméterei
	private static $sRequestMethod = NULL;       // A request metódusa: GET | POST | PUT | DELETE
	private static $sRequestValues = NULL;       // A beküldött változónevek és értékek


	/**
	 * Visszaadja a kért modul nevét
	 *
	 * @return string  A modul neve
	 */
	public static function getModuleName() {
		if (!isset(self::$sModuleName)) {
			self::parsePath();
		}

		return self::$sModuleName;
	}

	/**
	 * Visszaadja a végrehajtandó metódus nevét
	 *
	 * @return string  A metódus neve
	 */
	public static function getModuleMethodName() {
		if (!isset(self::$sModuleMethodName)) {
			self::parsePath();
		}

		return self::$sModuleMethodName;
	}

	/**
	 * Visszaadja a végrehajtandó metódus paramétereit
	 *
	 * @return string  A paraméterek listája
	 */
	public static function getMethodParameterList() {
		if (!isset(self::$aMethodParameterList)) {
			self::parsePath();
		}

		return self::$aMethodParameterList;
	}

	/**
	 * Visszaadja az oldal lekeresenek teljes utvonalat.
	 *
	 * @return string   A kert oldal teljes eleresi utvonala.
	 */
	public static function getPath() {
		return isset($_REQUEST[self::$sRequestKey]) ? $_REQUEST[self::$sRequestKey] : '';
	}

	/**
	 * Visszaadja a modulhoz tartozó URL-t: az URL-nek azt a részét, ami alapján a modult azonosította
	 *
	 * @return string  Az elérési útvonal
	 */
	public static function getModulePath() {
		if (!isset(self::$sModulePath)) {
			self::parsePath();
		}

		return self::$sModulePath;
	}

	/**
	 * Értelmezi a beérkezett HTTP változókat
	 *
	 * Értéket ad a $sRequestMethod és $sRequestValues változóknak
	 *
	 */
	private static function parseValues() {
		self::$sRequestMethod = $_SERVER['REQUEST_METHOD'];
		parse_str(file_get_contents('php://input'), self::$sRequestValues);
		// Ha fileküldés is volt (enctype = multipart/form-data),
		// akkor a php://input üres, a $_POST tömbből olvasható ki a változók tartalma
		if (!empty($_FILES)) self::$sRequestValues = $_POST;
		if (self::$sRequestMethod == 'GET') self::$sRequestValues = $_GET;
	}

	/**
	 * Visszaadja a HTTP request típusát
	 *
	 * @return  string  GET | POST | PUT | DELETE
	 */
	public static function getRequestMethod() {
		if (!isset(self::$sRequestMethod)) self::parseValues();
		return self::$sRequestMethod;
	}

	/**
	 * Visszaadja a HTTP változókat
	 *
	 * @return  array
	 */
	public static function getRequestVars() {
		if (!isset(self::$sRequestMethod)) self::parseValues();
		return self::$sRequestValues;
	}

	/**
	 * Átirányít a $sPath-ban megadott címre
	 *
	 * @param string  $sPath           A cím amire átirányítunk
	 * @param array   $aParameterList  Az oldal paraméterei asszociatív tömbben
	 *                                 Ha nem akarunk értéket megadni, akkor NULL legyen az értéke a tömbben
	 * @param string  $sFragment       Anchor neve
	 * @param string  $iCode           HTTP Response code
	 *
	 * @return void
	 */
	public static function redirect($sPath, $aParameterList = array(), $sFragment = NULL, $iCode = 301) {
		if (Debug::getDebugLevel()) {
			$aBacktrace = debug_backtrace();
			debug::addMsg("Redirect to {$sPath} - ".print_r($aBacktrace, TRUE), '', DEBUG_LOG_INFO);
		}

		$aUrlParts = parse_url($sPath);
		$aQuery = array();
		if (!empty($aUrlParts['query'])) $aQuery = !empty($aUrlParts['query']) ? explode('&', $aUrlParts['query']) : [];
		foreach ($aParameterList as $sParameterName => $sParameterValue) {
			$aQuery[] = urlencode($sParameterName).($sParameterValue !== NULL ? '='.urlencode($sParameterValue) : '');
		}
		$sQuery = implode($aQuery, '&');

		$sUrl =
			(
				!empty($aUrlParts['scheme'])
				? $aUrlParts['scheme'].'://'.$aUrlParts['host'].(
					!empty($aUrlParts['port']) ? ':'.$aUrlParts['port'] : ''
				)
				: ''
			)
			.(!empty($aUrlParts['path']) ? $aUrlParts['path'] : '')
			.(!empty($sQuery) ? "?{$sQuery}" : '')
			.(!empty($sFragment) ? "#{$sFragment}" : '');

		session_write_close();
		$sReason = httpCodes($iCode);
		header("HTTP/1.0 {$iCode} {$sReason}");
		header('Location: '.$sUrl, FALSE);
		die();
	}

	/**
	 * Elemzi az URL path részét, értéket ad a sModuleName sModuleMethodName, aMethodParameterList változóknak
	 *
	 * @return void
	 */
	public static function parsePath() {
		debug::addMsg("Request: parsing path \"".self::getPath()."\"", '', DEBUG_LOG_INFO);

		// Ha nem /-re vegzodik, akkor atiranyit
		$sPath = self::getPath();
		if (!empty($sPath) && strpos($sPath, '.') === false && substr($sPath, -1) != '/') self::Redirect('/'.$sPath.'/', 301);
		if (!empty($sPath) && strpos($sPath, '.') !== false && substr($sPath, -1) == '/') self::Redirect('/'.rtrim($sPath, '/'), 301);

		// Végignézi, hogy az url tömb melyik eleme illeszkedik a beérkező path-ra
		$sUrlHit = NULL;
		foreach ($GLOBALS['siteconfig']['path'] as $sUrl=>$aData) {
			if (
				/**
				 * Akkor van találat:
				 * - ha az sUrl=='', akkor biztos, hogy van találat, mert az minden url-re illik: ha van default oldalkezelő, akkor az mindenképp lefut
				 * VAGY				 				
				 * - ha a path eleje megegyezik az aktuális elemmel,
				 * - utána / van, vagy string vége (tehát egész szó)
				 * ÉS 
				 * - hosszabb mint a legutóbbi találat
				 */
				(
					$sUrl == '' ||				 
					(
						substr(self::getPath(), 0, strlen($sUrl)) == $sUrl
						&& (
							substr(self::getPath(), strlen($sUrl), 1) == '/'
							|| substr(self::getPath(), strlen($sUrl), 1) == ''
						)
					)
				)
				&& (!isset($sUrlHit) || strlen($sUrl) > strlen($sUrlHit))
			) {
				$sUrlHit = $sUrl;
			}
		}

		// Ha nincs definiálva az URL-ek listájában, akkor a modul és a metódus NULL
		// TODO: ez a feltetel sztm nem fut le soha
		if (!isset($sUrlHit)) {
			debug::addMsg("Request: Module not found", '', DEBUG_LOG_INFO);
			self::$sModuleName = NULL;
			self::$sModuleMethodName = NULL;
			return FALSE;
		}

		// A $aData-ba tölti a megadott path-hoz tartozó adatokat: module, method, country, id_language
		$aData = $GLOBALS['siteconfig']['path'][$sUrlHit];
		if (isset($aData['country'])) $GLOBALS['country'] = $aData['country'];
		if (isset($aData['id_language'])) $GLOBALS['id_language'] = $aData['id_language'];
		self::$sModuleName = $aData['module'];
		self::$sModuleMethodName = $aData['method'];
		self::$sModulePath = $sUrlHit;

		// Ha a default kezelő a találat, akkor a teljes path-ból kell létrehozni a paramétereket
		// Ha nem a default, akkor a path elejéről le kell vágni azt a részt, ami a modult azonosítja
		if ($sUrlHit=='') $sParameters = self::getPath();
		else $sParameters = substr(self::getPath(), strlen($sUrlHit)+1);
		self::$aMethodParameterList = $sParameters ? explode('/', trim($sParameters, '/')) : array();
		// Ha a configban van megadva parameter, akkor az az urlben erkezo parameterek ele kerul
		if (!empty($aData['parameters'])) self::$aMethodParameterList = $aData['parameters'] + self::$aMethodParameterList;

		debug::addMsg("Request: Module found. ModulePath: ".self::$sModulePath." | Module name: ".self::$sModuleName." | Method name: ".self::$sModuleMethodName, '', DEBUG_LOG_INFO);
	}
}
?>