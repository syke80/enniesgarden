<?php
class LanguageDao extends Dao {
	/**
	 * A rendszerben engedélyezett nyelvek listája
	 *
	 * @return array
	 */
	public function getLanguageList() {
		return $this->rConnection->getList("
			SELECT *
			FROM language
		");
	}

	public function getLanguageFromIso($sIso) {
		return $this->rConnection->getRow("
			SELECT *
			FROM language
			WHERE iso=:0
		", func_get_args());
	}
}
?>