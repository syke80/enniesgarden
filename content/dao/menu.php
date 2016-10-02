<?php
class MenuDAO extends Dao {
	public function insertMenu($sName) {
		return $this->rConnection->insert("
			INSERT INTO menu (name)
			VALUES (:0)
		", func_get_args());
	}
	public function deleteMenu($iIdMenu) {
		return $this->rConnection->execute("
			DELETE FROM menu
			WHERE id_menu = :0
		", func_get_args());
	}
	public function updateMenu($iIdMenu, $sName) {
		return $this->rConnection->execute("
			UPDATE menu
			SET name=:1
			WHERE id_menu=:0
		", func_get_args());
	}
	public function getMenuList($aOrderList='', $aFilterList='', $iLimit=0, $iPage=1, $bIncludeDistinctValues=FALSE) {
		$sQOrder = self::parseOrderList($aOrderList);
		$sWhFilter = self::parseFilterList($aFilterList);
		$sWhere = empty($sWhFilter) ? '' : "WHERE ".$sWhFilter;
		$sQLimit = empty($iLimit) ? '' : " LIMIT ".($iPage-1)*$iLimit.", {$iLimit}";

		$iRowCount = $this->rConnection->getValue("
			SELECT COUNT(*)
			FROM menu
		".$sWhere);
		$aData = $this->rConnection->getList("
			SELECT *
			FROM menu
		".$sWhere.$sQOrder.$sQLimit);

		$aDistinct = array();

		return array(
			'rowcount' => $iRowCount,
			'pagecount' => self::calcPageCount($iRowCount, $iLimit),
			'list' => $aData,
			'distinct' => $aDistinct
		);
	}
	public function getMenu($iIdMenu) {
		return $this->rConnection->getRow("SELECT * FROM menu WHERE id_menu=:0", func_get_args());
	}
	public function getMenuFromName($sName) {
		return $this->rConnection->getRow("SELECT * FROM menu WHERE name=:0", func_get_args());
	}


	public function getAllMenuItem($iIdMenu) {
		return $this->rConnection->getList("SELECT * FROM menu_item WHERE id_menu=:0 ORDER BY menu_item.order ASC", func_get_args());
	}

	public function getMenuItem($iIdMenuItem) {
		return $this->rConnection->getRow("SELECT * FROM menu_item WHERE id_menu_item={$iIdMenuItem}");
	}

	public function deleteMenuItem($iIdMenuItem) {
		$this->rConnection->execute("DELETE FROM menu_item WHERE id_menu_item={$iIdMenuItem}");
	}

	public function insertMenuItem($iIdMenu, $sTitle, $sUrl, $sIsPopup) {
		return $this->rConnection->insert("
			INSERT INTO menu_item (
				id_menu,
				title,
				url,
				is_popup
			) VALUES (
				'{$iIdMenu}',
				'{$sTitle}',
				'{$sUrl}',
				'{$sIsPopup}'
			)");
	}

	public function updateMenuItem($iIdMenuItem, $sTitle, $sUrl, $sIsPopup) {
		$this->rConnection->execute("
			UPDATE menu_item SET
				title = '{$sTitle}',
				url = '{$sUrl}',
				is_popup = '{$sIsPopup}'
			WHERE
				id_menu_item = {$iIdMenuItem}
			");
	}

	public function setMenuItemParent($iIdMenuItem, $iIdParent) {
		$this->rConnection->execute("
			UPDATE menu_item SET
				id_parent = $iIdParent
			WHERE
				id_menu_item = {$iIdMenuItem}
			");
		// ha a menüpontnak voltak gyerekei, akkor ők is ezt az id_parentet kapják
		$this->rConnection->execute("
			UPDATE menu_item SET
				id_parent = $iIdParent
			WHERE
				id_parent = {$iIdMenuItem}
			");
	}

	public function setMenuItemOrder($aMenuList) {
		$aValues = array();
		foreach ($aMenuList as $iOrder => $iIdMenuItem) {
			$this->rConnection->execute("UPDATE menu_item SET menu_item.order={$iOrder} WHERE id_menu_item={$iIdMenuItem}");
		}
	}
}
?>