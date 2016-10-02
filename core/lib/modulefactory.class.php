<?php
/**
 * Singleton példányokat hoz létre a Module osztály leszármazottaiból
 */
class ModuleFactory {
	private static $aModules;             // A létrehozott példányok
	private static $nullGuard = NULL;     // Ezzel a változóval tér vissza hiba esetén

	/**
	 * Includeolja és létrehozza a paraméterben megadott Module osztályt a common-ból
	 * Ha az osztályt tartalmazó fájl nem létezik, vagy az osztály nincs definiálva, akkor NULL-t ad vissza
	 *
	 * @return object|NULL  Visszatér az objektummal, vagy hiba esetén NULL értékkel
	 */

	public static function &getCommonModule($sModuleName) {
		$oModule =& self::getModule($sModuleName, '_common');
		return $oModule;
	}

	/**
	 * Includeolja és létrehozza a paraméterben megadott Module osztályt
	 * Ha az osztályt tartalmazó fájl nem létezik, vagy az osztály nincs definiálva, akkor NULL-t ad vissza
	 *
	 * @return object|NULL  Visszatér az objektummal, vagy hiba esetén NULL értékkel
	 */

	public static function &getModule($sModuleName, $sSiteEngine=NULL) {
		if (empty($sSiteEngine)) $sSiteEngine = $GLOBALS['siteconfig']['site_engine'];
		$sModuleRealName = toCamelCase(explode('_', $sModuleName))."Module";
		if (isset(self::$aModules[$sSiteEngine][$sModuleName])) return self::$aModules[$sSiteEngine][$sModuleName];

		$sModuleFile = DIR_CONTENT."/sites/{$sSiteEngine}/modules/{$sModuleName}.php";
		if (!file_exists($sModuleFile)) {
			Debug::addMsg("Module file not found: {$sModuleFile}", 'error', DEBUG_LOG_ERROR);
			return self::$nullGuard;
		}
		require_once $sModuleFile;
		if (!class_exists($sModuleRealName)) {
			Debug::addMsg("Error in module file ({$sModuleFile}), class not found: {$sModuleRealName}", 'error', DEBUG_LOG_ERROR);
			return self::$nullGuard;
		}

		self::$aModules[$sSiteEngine][$sModuleName] = new $sModuleRealName();

		return self::$aModules[$sSiteEngine][$sModuleName];
	}
}
?>