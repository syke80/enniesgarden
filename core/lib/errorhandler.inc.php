<?php
/**
 * A futás befejezésekor lefuttatja a Debug osztály megfelelő metódusát.
 * Ha a futás hibával állt le és engedélyezve van a debugolás, akkor kiírja a kimenetre.
 *
 * A paraméterezésről bővebb információ a register_shutdown_function() függvény leírásában található.
 *
 * @return  void
 */
function shutdownFunction() {
	$aError = error_get_last();
	if($aError !== NULL){
		$sMsg = "[SHUTDOWN] file: {$aError['file']} | ln: {$aError['line']} | msg: {$aError['message']}";
		Debug::addMsg($sMsg, 'error', DEBUG_LOG_ERROR);
		if (Debug::getDebugLevel()) echo $sMsg;
	}
	Debug::saveMsg();
}

/**
 * A futás közben bekövetkező hibákat továbbítja a Debug osztálynak.
 *
 * A paraméterezésről bővebb információ a set_error_handler() függvény leírásában található.
 *
 * @return  void
 */
function errorHandler($iErrNo, $sErrStr, $sErrFile, $iErrLine) {
	switch ($iErrNo) {
		case E_USER_ERROR:
			$sMsg = "[ERROR] [$iErrNo] {$sErrStr} in {$sErrFile} on line {$iErrLine}";
			Debug::addMsg($sMsg, 'error', DEBUG_LOG_ERROR);
			if (Debug::getDebugLevel()) echo $sMsg;
			exit(1);
			break;
		case E_USER_WARNING:
			$sMsg = "[WARNING] [{$iErrNo}] {$sErrStr} in {$sErrFile} on line {$iErrLine}";
			break;
		case E_USER_NOTICE:
			$sMsg = "[NOTICE] [{$iErrNo}] {$sErrStr} in {$sErrFile} on line {$iErrLine}";
			break;
		default:
			$sMsg = "Unknown error type: [{$iErrNo}] {$sErrStr} in {$sErrFile} on line {$iErrLine}";
	}

	Debug::addMsg($sMsg, 'error', DEBUG_LOG_ERROR);

	return TRUE; // hogy ne fusson le a PHP hibakezelője
}

/**
 * A futás közben bekövetkező kivételeket továbbítja a Debug osztálynak.
 *
 * A paraméterezésről bővebb információ a set_exception_handler() függvény leírásában található.
 *
 * @return  void
 */
function exceptionHandler($exception) {
	$sMsg = "EXCEPTION: ".$exception->getMessage();
	Debug::addMsg($sMsg, 'error', DEBUG_LOG_ERROR);

	return TRUE;
}

set_error_handler('errorHandler');
set_exception_handler('exceptionHandler');
register_shutdown_function('shutdownFunction');
?>