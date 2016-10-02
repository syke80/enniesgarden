<?php
/**
 * Singleton példányokat hoz létre a Dao osztály leszármazottaiból
 */
class DaoFactory {
	private static $aDaos;              // A létrehozott példányok
	private static $nullGuard = NULL;   // Ezzel a változóval tér vissza hiba esetén

	/**
	 * Includeolja és létrehozza a paraméterben megadott DAO osztályt
	 * Ha az osztályt tartalmazó fájl nem létezik, vagy az osztály nincs definiálva, akkor NULL-t ad vissza
	 *
	 * @return object|NULL  Visszatér az objektummal, vagy hiba esetén NULL értékkel
	 */
	public static function &getDao($sDaoName, $sIdConnection='default') {
		$sDaoFile = DIR_CONTENT."/dao/{$sDaoName}.php";
		if (!file_exists($sDaoFile)) return self::$nullGuard;
		require_once $sDaoFile;
		$sDaoRealName = toCamelCase(explode('_', $sDaoName))."Dao";
		if (!class_exists($sDaoRealName)) return self::$nullGuard;
		if (isset(self::$aDaos[$sDaoName])) return self::$aDaos[$sDaoName];

		self::$aDaos[$sDaoName] = new $sDaoRealName($sIdConnection);

		return self::$aDaos[$sDaoName];
	}
}
?>