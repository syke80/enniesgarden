<?php
/**
 * Singleton példányokat hoz létre a Database osztály leszármazottaiból
 */
class DbFactory {
	private static $aConnections;       // A létrehozott példányok
	private static $nullGuard = NULL;   // Ezzel a változóval tér vissza hiba esetén

	/**
	 * Létrehozza a paraméterben megadott adatbázis-kapcsolatot
	 *
	 * A kapcsolat adatait a $GLOBALS['db_config'][{$sIdConnection}] változó
	 * tartalmazza a config.server.php fájlban
	 * Ha a kapcsolat nincs definiálva, akkor NULL-t ad vissza
	 *
	 * @return object|NULL  Visszatér az objektummal, vagy hiba esetén NULL értékkel
	 */
	public static function &getConnection($sIdConnection='default') {
		if (!isset($GLOBALS['db_config'][$sIdConnection])) {
			trigger_error("Undefined database connection: {$sIdConnection}", E_USER_ERROR);
			return self::$nullGuard;
		}
		if (isset(self::$aConnections[$sIdConnection])) return self::$aConnections[$sIdConnection];
		$aDbConfig = $GLOBALS['db_config'][$sIdConnection];
		switch ($aDbConfig['driver']) {
			case 'mysql':
				self::$aConnections[$sIdConnection] = new MysqlDatabase($aDbConfig['host'], $aDbConfig['port'], $aDbConfig['username'], $aDbConfig['password'], $aDbConfig['db']);
				break;
			default:
				trigger_error("Undefined database driver: {$aDbConfig['driver']}", E_USER_ERROR);
		}
		return self::$aConnections[$sIdConnection];
	}
}
?>