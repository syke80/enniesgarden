<?php
class Debug {
	private static $iDebugLevel = 0;  // Debuglevel: ez alapján dönti el hogy mit kell debugolni
	private static $aInfo = array();  // Az osztályhoz beérkezett debug üzenetek
	private static $fTimeStart = 0;   // A debugolás idejének kezdete

	private static function startTimer() {
		self::$fTimeStart = microtime(TRUE);
	}

	/**
	 * Értéket ad a debuglevelnek és bekapcsolt debug esetén elindítja a timert.
	 * Csak akkor fut le, ha a _DEVEL konstans értéke nem 0 (a siteconfig/*conf.php-ben kell definiálni)
	 *
	 * 3 lehetséges eset van:
	 *   -GET-ben nincs debuglevel,
	 *    ilyenkor az index.php NULL-t ad át, a self::$iDebugLevel a sessionből kapja az értéket
	 *   -GET-ben meg van adva a debuglevel és 0 az értéke:
	 *    ilyenkor az index.php 0-t ad át a paraméterben,
	 *    megszűnik a $_SESSION['debuglevel'], a self::$iDebugLevel értéke 0 lesz
	 *   -GET-ben meg van adva a debuglevel és nem 0:
	 *    az index.php átadja az értéket,
	 *    a $_SESSION['debuglevel']-be menti az új értéket, a self::$iDebugLevel szintén az új érték lesz
	 *
	 * A debuglevel értékei a config.php-ben vannak meghatározva
	 *
	 */
	public static function init($iDebugLevel) {
		if (_DEVEL == 0) return;
		if (!file_exists(DIR_DEBUG)) mkdir(DIR_DEBUG, 0777, TRUE);
		if ($iDebugLevel === NULL) {
			self::$iDebugLevel = isset($_SESSION['debuglevel']) ? $_SESSION['debuglevel'] : 0;
		}
		else {
			if ($iDebugLevel >= 0) {
				self::$iDebugLevel =  $iDebugLevel;
				$_SESSION['debuglevel'] = $iDebugLevel;
			}
			else {
				self::$iDebugLevel = 0;
				unset($_SESSION['debuglevel']);
			}
		}
		if (self::$iDebugLevel) self::startTimer();
	}

	/**
	 * Átnevez egy szekciót
	 *
	 * @param  string  $sKey      A szekció azonosítója, pl. db_webshop
	 * @param  string  $sNewName  A szekció új neve
	 *
	 * @return void
	 */
	public static function rename($sKey, $sName) {
		self::$aInfo[$sKey]['name'] = $sName;
	}

	/**
	 * Üzenetet tárol csoportokba rendezve és log fájlba írja
	 *
	 * Csak akkor logol, ha a $iLogLevel-ben megadott érték lett van állítva
	 * az inicializálás során a $_SESSION['debuglevel'] változóban
	 */
	public static function addMsg($sTxt='', $sGroupId='', $iLogLevel=0) {
		// Hozzáadja az üzenetet az $aInfo tömbhöz
		if (empty(self::$aInfo[$sGroupId]['name'])) self::$aInfo[$sGroupId]['name'] = $sGroupId;
		if (!isset(self::$aInfo[$sGroupId]['list'])) self::$aInfo[$sGroupId]['list'] = array();
		self::$aInfo[$sGroupId]['list'][] = $sTxt;

		// Logolja az üzenetet
		if (self::getDebugLevel() & $iLogLevel) {
			$rHandle = fopen(DIR_DEBUG.'/log.txt', 'a');
			fwrite($rHandle, date("Y-m-d H:i:s")." {$sTxt}\r\n");
			fclose($rHandle);
		}
	}

	/**
	 * Visszaadja a beállított debuglevelt
	 *
	 * @return  integer
	 */
	public static function getDebugLevel() {
		return self::$iDebugLevel;
	}

	/**
	 * Visszaadja a futás közben kapott információkat,
	 * kiegészíti az inicializálás óta eltelt idővel
	 * és az include-olt fájlok listájával
	 *
	 * @return  array
	 */
	public static function getDebugData() {
		$aRes = array();
		if (isset(self::$aInfo['error'])) self::$aInfo['error']['name'] = count(self::$aInfo['error']['list']).'error(s)';
		self::$aInfo['include']['name'] = count(get_included_files())." files included";
		$aIncludeList = get_included_files();
		foreach ($aIncludeList as $sIncludeItem) {
			self::addMsg($sIncludeItem, 'include');
		}

		$aRes['info'] = self::$aInfo;
		$aRes['time'] = microtime(TRUE) - self::$fTimeStart;

		return $aRes;
	}

	/**
	 * Az msg.txt-be menti az információkat, amiket a getDebugData() metódus ad vissza
	 * (megfelelő debuglevel esetén)
	 *
	 * @return  void
	 */
	public static function saveMsg() {
		if (!(self::getDebugLevel() & DEBUG_MSG)) return;

		$aRes = self::getDebugData();
		$rHandle = fopen(DIR_DEBUG.'/msg.txt', 'a');
		fwrite($rHandle, "\r\n".date("Y-m-d H:i:s")." ".Request::getPath()."\r\n");
		foreach ($aRes['info'] as $aSection) {
			fwrite($rHandle, "\t{$aSection['name']}\r\n");
			foreach ($aSection['list'] as $sItem) {
				fwrite($rHandle, "\t\t{$sItem}\r\n");
			}
		}
		fwrite($rHandle, "\tPage generated in {$aRes['time']}s\r\n");
		fclose($rHandle);
	}
}
?>