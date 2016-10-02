<?php
/**
 * Abstract adatbázis osztály
 */
abstract class Database {
	protected $sHost;
	protected $iPort;
	protected $sUserName;
	protected $sPassword;
	protected $sDatabaseName;

	protected $bConnected = FALSE;
	protected $oConnection;

	// változók a debugoláshoz
	protected $fTimeAll = 0;
	protected $iCount = 0;

	// hibás query esetén a hibaüzenet szövege
	protected $sError;

	/**
	 * Idézőjelek közé rakja -ha kell- a paraméter értékét
	 *
	 * @param  mixed  $xValue
	 * @return mixed
	 */
	protected function quoteSmart($xValue) {
		if ($xValue === NULL) $xValue = 'NULL';
		elseif(!preg_match('/^-{0,1}\d*\.{0,1}\d+$/', $xValue)) {
			$xValue = "'" . $xValue . "'";
		}

		return $xValue;
	}

	/**
	 * Kitölti a queryt a megadott értékekkel.
	 * A változót escapeli, idézőjelek közé teszi ha szükséges
	 *
	 * Pl. :sVariable értéket cseréli $axValues['sVariable'] értékére
	 *
	 * @param  string  $sQuery
	 * @param  mixed   $axValues
	 *
	 * @return mixed
	 */
	protected function fillQueryFields($sQuery, $axValues) {
		$axReplaceArray = array();
		foreach($axValues as $sKey => $sValue) {
			$axReplaceArray[":" . $sKey] = $this->quoteSmart($this->escape($sValue));
		}

		return strtr($sQuery, $axReplaceArray);
	}

	/**
	 * Továbbítja a lekérdezést a query() metódusnak, információkat küld a Debug osztálynak
	 * Ezt hívja az execute, az insert, a getList, a getRow és a getValue
	 *
	 * Cseréli a :key változókat a $axValues['key'] értékekre.
	 * Ha szükséges akkor az értéket idézőjelek közé rakja.
	 *
	 * @param  string  $sQuery     Query string
	 * @param  array   $axParams   Tömb, ami a változók értékeit tartalmazza
	 *
	 * @return string  A kitöltött query string
	 */
	protected function queryDebug($sQuery, $axValues) {
		if ($sQuery === NULL) return NULL;

		if (Debug::getDebugLevel()) $fTimeStart = microtime(TRUE);

		$this->connect();
		if (!empty($axValues)) $sQuery = $this->fillQueryFields($sQuery, $axValues);

		$xResult = $this->query($sQuery, $axValues);

		if (Debug::getDebugLevel()) {
			$sDebugMsg = '';
			
			$fTimeEnd = microtime(TRUE);
			$this->fTimeAll += $fTimeEnd - $fTimeStart;
			
			$aBacktrace = debug_backtrace();
			if (isset($aBacktrace[2])) {
				$sDebugMsg = $aBacktrace[2]['class'].'::'.$aBacktrace[2]['function']."()\r\n";
			}
			
			$sDebugMsg .= $sQuery;
			if ($this->sError) {
				$sDebugMsg .= $this->sError;
				$this->sError = '';
			}
			Debug::addMsg($sDebugMsg, "db_{$this->sDatabaseName}", DEBUG_LOG_QUERY);
			$this->iCount++;
			Debug::rename("db_{$this->sDatabaseName}", "db_{$this->sDatabaseName} {$this->iCount} queries in {$this->fTimeAll}s");
		}

		return $xResult;
	}

	/**
	 * Feltölti értékekkel az adatbáziskapcsolat létrehozásához szükséges változókat
	 *
	 * @param string  $sHost
	 * @param int     $iPort
	 * @param string  $sUserName
	 * @param string  $sPassword
	 * @param string  $sDatabaseName
	 */
	public function __construct($sHost, $iPort, $sUserName, $sPassword, $sDatabaseName) {
		$this->sHost = $sHost;
		$this->iPort = $iPort;
		$this->sUserName = $sUserName;
		$this->sPassword = $sPassword;
		$this->sDatabaseName = $sDatabaseName;
	}

	/**
	 * Megszünteti a kapcsolatot az adatbázissal
	 *
	 * @return void
	 */
	public function __destruct() {
		$this->disconnect();
	}

	/**
	 * Csatlakozik a konstruktornak megadott adatbázishoz.
	 *
	 * @return void
	 */
	protected abstract function connect();

	/**
	 * Megszünteti a kapcsolatot az adatbázissal.
	 *
	 * @return void
	 */
	protected abstract function disconnect();

	/**
	 * Escapeli a paraméterben megadott stringet
	 *
	 * @param  string  $sStr
	 *
	 * @return string
	 */
	protected abstract function escape($sStr);

	/**
	 * Ténylegesen ez a metódus futtatja a lekérdezést az adatbázison.
	 *
	 * Behelyettesíti a querybe a $axValues tömb értékeit:
	 * $oDb->query('SELECT * FROM mytable WHERE name=:name', array('name' => 15));
	 *
	 * A behelyettesített értékeket escapeli
	 *
	 * @param  string  $sQuery           Az sql query string. Az
	 * @param  array   $axValues         A query stringben átadott azonosítók értékei
	 *
	 * @return resource | boolean        Az eredményt tartalmazó erőforrás,
	 *                                   vagy False ha nem sikerült a lekérdezés
	 */
	protected abstract function query($sQuery, $axValues);

	/**
	 * Végrehajtja a paraméterben megadott lekérdezést az adatbázison az osztály query_debug() metódusán keresztül
	 *
	 * <code>
	 * execute(
	 *   "SELECT * FROM mytable WHERE name=:value",
	 *   array(
	 *     "value"=>$sPostedValue
	 *   )
	 * )
	 * </code>
	 *
	 * @param  string  $sQuery   A query string
	 * @param  array   $axValues
	 *
	 * @return void
	 */
	public abstract function execute($sQuery, $axValues=array());

	/**
	 * Végrehajtja a paraméterben megadott lekérdezést az adatbázison az osztály query_debug() metódusán keresztül
	 * és visszatér a beszúrt record azonosítójával.
	 * Ha több record is létrejön, akkor az utolsó record azonosítója lesz a visszatérési érték.
	 *
	 * A paraméterezésről bővebb információ az execute metódusnál található.
	 * @see    subclass::execute()
	 *
	 * @param  string  $sQuery   A query string
	 * @param  array   $axValues
	 *
	 * @return mixed   Az azonosító
	 */
	public abstract function insert($sQuery, $axValues=array());

	/**
	 * Végrehajtja a paraméterben megadott lekérdezést az adatbázison
	 * és visszatér egy értékkel.
	 * Ha több mező is van, akkor csak az elsőt veszi figyelembe.
	 *
	 * Olyan lekérdezéseknél kell használni, ahol egy érték lesz az eredmény.
	 * Pl.: SELECT SUM(field) FROM mytable GROUP BY field
	 *
	 * A paraméterezésről bővebb információ az execute metódusnál található.
	 * @see subclass::execute()
	 *
	 * @param  string  $sQuery   A query string
	 * @param  array   $axValues
	 *
	 * @return mixed   A lekérdezés eredménye
	 */
	public abstract function getValue($sQuery, $axValues=array());

	/**
	 * Végrehajtja a paraméterben megadott lekérdezést az adatbázison
	 * és visszatér egy asszociatív tömbbel.
	 * Ha több találat is van, akkor csak az első sort veszi figyelembe.
	 *
	 * Olyan lekérdezéseknél kell használni, ahol egy record lesz az eredmény.
	 * Pl.: SELECT * FROM mytable WHERE id=1
	 *
	 * A paraméterezésről bővebb információ az execute metódusnál található.
	 * @see subclass::execute()
	 *
	 * @param  string  $sQuery   A query string
	 * @param  array   $axValues
	 * @return array   A lekérdezés eredménye egy asszociatív tömbben.
	 *                 A mezők nevei a kulcsok
	 */
	public abstract function getRow($sQuery, $axValues=array());

	/**
	 * Végrehajtja a paraméterben megadott lekérdezést az adatbázison és visszatér egy listával.
	 *
	 * Olyan lekérdezéseknél kell használni, ahol egy lista lesz az eredmény.
	 * Pl.: SELECT * FROM mytable
	 *
	 * A paraméterezésről bővebb információ az execute metódusnál található.
	 * @see subclass::execute()
	 *
	 * @param  string  $sQuery   A query string
	 * @param  array   $axValues
	 * @return array   A lekérdezést találatainak listája
	 *                 A tömb elemei asszociatív tömbök. Ezekben mezők nevei a kulcsok
	 */
	public abstract function getList($sQuery, $axValues=array());

	/**
	 * Végrehajtja a paraméterben megadott lekérdezést az adatbázison és visszatér egy listával.
	 *
	 * A lista elemei nem tömbök, hanem értékek.
	 * Olyan lekérdezéseknél kell használni, ahol egy field elemeit tartalmazza az eredménylista.
	 * Pl.: SELECT field1 FROM mytable
	 *
	 * A paraméterezésről bővebb információ az execute metódusnál található.
	 * @see subclass::execute()
	 *
	 * @param  string  $sQuery   A query string
	 * @param  array   $axValues
	 * @return array   A lekérdezést találatainak listája
	 *                 A tömb elemei asszociatív tömbök. Ezekben mezők nevei a kulcsok
	 */
	public abstract function getValueList($sQuery, $axValues=array());
}
?>