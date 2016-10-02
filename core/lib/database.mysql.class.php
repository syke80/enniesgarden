<?php
class MysqlDatabase extends Database {
	protected function connect() {
		if (!$this->bConnected || !$this->oConnection) {
			if(!$this->oConnection = @mysqli_connect($this->sHost, $this->sUserName, $this->sPassword, $this->sDatabaseName, $this->iPort)) {
				trigger_error("Nem tudok csatlakozni az adatbázishoz (".mysqli_connect_error().") {$this->sHost}, {$this->sUserName}, {$this->sPassword}, {$this->sDatabaseName}, {$this->iPort}", E_USER_ERROR);
			}

			if(mysqli_select_db($this->oConnection, $this->sDatabaseName)) {
				$this->bConnected = TRUE;
			} else {
				$this->bConnected = FALSE;
				trigger_error("Nem tudok csatlakozni az adatbázishoz {$this->sDatabaseName}", E_USER_ERROR);
			}
			mysqli_query($this->oConnection, 'SET NAMES utf8');
		}
	}

	protected function disconnect() {
		if ($this->oConnection) {
			mysqli_close($this->oConnection);
			$this->oConnection = FALSE;
		}
	}

	protected function escape($sString) {
		if ($sString === NULL) return NULL;
		$this->connect();
		if (is_object($this->oConnection)) {
			return mysqli_real_escape_string($this->oConnection, $sString);
		}
	}

	protected function query($sQuery, $axValues) {
		$xResult = mysqli_query($this->oConnection, $sQuery);

		if (mysqli_errno($this->oConnection)) {
			$this->sError = "\r\n[ERROR] (".mysqli_errno($this->oConnection).") ".mysqli_error($this->oConnection);
		}

		return $xResult;
	}

	public function execute($sQuery, $axValues=array()) {
		$this->queryDebug($sQuery, $axValues);
	}

	public function insert($sQuery, $axValues=array()) {
		$this->queryDebug($sQuery, $axValues);
		return mysqli_insert_id($this->oConnection);
	}

	public function getValue($sQuery, $axValues=array()) {
		$xResult = $this->queryDebug($sQuery, $axValues);
		$aRow = mysqli_fetch_array($xResult);
		return $aRow[0];
	}

	public function getRow($sQuery, $axValues=array()) {
		$xResult = $this->queryDebug($sQuery, $axValues);

		if (empty($xResult) || mysqli_num_rows($xResult) == 0) return FALSE;

		return mysqli_fetch_assoc($xResult);
	}

	public function getList($sQuery, $axValues=array()) {
		$xResult = $this->queryDebug($sQuery, $axValues);
		$aList = array();
		if (empty($xResult) || mysqli_num_rows($xResult) == 0) return array();
		if ($xResult) {
			while ($aRow = mysqli_fetch_assoc($xResult)) $aList[] = $aRow;
		}
		return $aList;
	}

	public function getValueList($sQuery, $axValues=array()) {
		$xResult = $this->queryDebug($sQuery, $axValues);
		$aList = array();
		if (empty($xResult) || mysqli_num_rows($xResult) == 0) return array();
		if ($xResult) {
			while ($aRow = mysqli_fetch_array($xResult)) $aList[] = $aRow[0];
		}
		return $aList;
	}
}
?>