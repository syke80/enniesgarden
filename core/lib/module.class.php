<?php
abstract class Module {
	/**
	 * Ellenőrzi a felhasználó hozzáférését a paraméterben megadott metódushoz
	 *
	 * @param string    $sMethodName    A metódus neve
	 *
	 * @return bool     TRUE, ha a felhasználónak van joga futtatni a metódust, FALSE ha nincs
	 */
	protected abstract function _access($sMethodName);

	/**
	 * A path-ok és függvények egymáshoz rendelése
	 *
	 * A függvény egy olyan tömbbel tér vissza, aminek a kulcsai a path-ok,
	 * az elemei pedig olyan tömbök, amik a path-hoz tartozó információkat tartalmazzák.
	 * Mindenképp definiálni kell a 'method' elemet, mert az azonosítja hogy melyik	függvényt kell futtatni.
	 *   return array(
	 *     'path/example' => array(
	 *       'method'      => 'default',
	 *     ),
	 *  );
	 *  
	 * További értékek:
	 *   return array(
	 *     'path/example' => array(
	 *       'method'      => 'default',
	 *       'id_language' => 'en',
	 *       'country'     => 'usa',
	 *       'parameters'  =>  array('value'),
	 *     ),
	 *   );
	 * Az id_language értéke a $GLOBALS['id_language'] változóba kerül. A formátuma ISO 639-1. 
	 * A country értéke a $GLOBALS['country'] változóba kerül. A formátuma ISO 3166-1 alpha-3.
	 * A parameters változó értékeit a végrehajtott függvény paraméterként kapja meg:
	 *   function _reqDefault($sVar) { ... }	 	  
	 *
	 * Az oldalakhoz egyéb beállítást is fel lehet vinni, amit nem a keretrendszer értelmez,
	 * hanem valamelyik modul.
	 * Pl. a sitemap modul kihagyja a sitemapból azokat az oldalakat, amelyeknél public=>FALSE érték van beállítva.
	 *   return array(
	 *     'path/example' => array(
	 *       'method'      => 'default',
	 *       'id_language' => 'en',
	 *       'public'      => 'FALSE',
	 *     ),
	 *  );
	 *
	 * @return array  A pathok listája
	 */
	public abstract function path();

	/**
	 * Meghív egy request metódust a modulon belül
	 * A meghívott metódusok kimenetét az Output osztály generálja
	 * Egy stringgel térnek vissza, aminek tartalma a generált HTML oldal, vagy egy JSON enkódolt tömb
	 * Ha a felhasználónak a metódus futtatásához nincs joga, akkor 403-as hibával kilép
	 *
	 * @param string    $sMethodName       A metódus neve
	 * @param array     $aParameterList    A metódusnak küldött paraméterek listája
	 *
	 * @return string   A generált oldal tartalma
	 */
	public function req($sMethodName, $aParameterList) {
		return $this->_access($sMethodName) ? call_user_func_array(array($this, "_req{$sMethodName}"), $aParameterList) : FALSE;
	}
}
?>