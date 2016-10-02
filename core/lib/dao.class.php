<?php
/**
 * DAO ősosztály
 * Ennek az osztálynak a leszármazottai tartalmazzák azokat a függvényeket,
 * amik az egyes táblákon végeznek műveleteket
 */
class Dao {
	protected $rConnection;

	/**
	 * Létrehozza a kapcsolatot az adatbázissal
	 */
	public function __construct($sIdConnection='default') {
		$this->rConnection =& DbFactory::getConnection($sIdConnection);
	}

	/**
	 * Order feldolgozása
	 * In: $aOrderList, $aForeignKeys
	 * Out: $sQOrder = "field1 ASC, field2 DESC";
	 */		 
	public static function parseOrderList($aOrderList, $aForeignKeys) {
		$sQOrder = '';
		if (!empty($aOrderList)) {
			$aQOrder = array();
			foreach ($aOrderList as $aOrder) {
				$aQOrder[] = "{$aOrder['field']} {$aOrder['direction']}";
			}
			$sQOrder = "ORDER BY ".implode(',', $aQOrder);
			if (!empty($aForeignKeys)) $sQOrder = str_replace(array_keys($aForeignKeys), array_keys($aForeignKeys), $sQOrder);
		}
		return $sQOrder;
	}
	
	/**
	 * Filter feldolgozása
	 * Az eredményt be kell rakni a WHERE-be		 
	 * In: $aFilterList, $aMap
	 * 	 
	 * A filterlist felépítése:	 
	 * 	 [0] => Array
	 *        (
	 *            [field] => permalink
	 *            [value] => test1
	 *            [type] => 'like' | ''
	 *        )
	 *
	 * Out: $sWhFilter = "field1='value1' AND field2='value2'"
	 * 
	 * $aMap a fieldhez hozzárendeli a valódi (teljes) nevét
	 *   Pl. "Column in field list is ambiguous" hibánál: 'status' => 'universal_device.status'
	 *   Vagy joinolt, atnevezett fieldnel: 'user_name' => 'user.name' (user tabla van joinolva, es SELECT user.name AS user_name)
	 */		 
	public static function parseFilterList($aFilterList, $aMap=array()) {
		$sWhFilter = '';
		if (!empty($aFilterList)) {
			$aQFilter = array();
			foreach ($aFilterList as $aFilter) {
				$sFieldName = isset($aMap[$aFilter['field']]) ? $aMap[$aFilter['field']] : $aFilter['field'];
				if (isset($aFilter['type']) && $aFilter['type'] == 'like') $aQFilter[] = "{$sFieldName} LIKE '%{$aFilter['value']}%'";
				else $aQFilter[] = "{$sFieldName} = '{$aFilter['value']}'";
			}
			$sWhFilter = implode(' AND ', $aQFilter);
		}
		return $sWhFilter;
	}
	
	public static function calcPageCount($iRowCount, $iLimit) {
		if ($iLimit) {
			return $iRowCount ? ( floor( ( $iRowCount - 1 ) / $iLimit ) + 1 ) : 0;
		}
		else {
			return $iRowCount ? 1 : 0;
		}
	}

}
?>