<?php
	/**
	 * Konstansok a debug osztályhoz
	 * Pl. ha a debuglevelt 6-ra állítjuk (DEBUG_LOG_QUERY + DEBUG_LOG_MAIL), akkor a queryket és az emaileket logolja
	 * (pontosabban azokat az eseményeket, amik DEBUG_LOG_QUERY, vagy DEBUG_LOG_MAIL levelt igényelnek)
	 * ha 134-re (DEBUG_LOG_QUERY + DEBUG_LOG_MAIL + DEBUG_RENDER), akkor megjelenik a debug box is az oldal alján
	 */
	define('DEBUG_LOG_ERROR', 1);   // Hibák logolása
	define('DEBUG_LOG_QUERY', 2);   // Query-k logolása
	define('DEBUG_LOG_MAIL',  4);   // Kimenő emailek logolása
	define('DEBUG_LOG_INFO',  8);   // Egyéb infok logolása
	define('DEBUG_MSG',       64);  // Üzenetek mentése fájlba
	define('DEBUG_RENDER',    128); // Üzenetek megjelenítése
?>