<?php
session_start();
// Szerverkonfig beolvasása
include_once 'config.server.php';

// A keretrendszer konfigja
require_once DIR_CORE.'/config.sys.php';

// Általános függvények
require_once DIR_CORE.'/lib/common.php';

// Debug osztály
require_once DIR_CORE.'/lib/debug.class.php';
Debug::init(isset($_GET['debug']) ? $_GET['debug'] : NULL);

// Hibakezelés (a debug osztályt használja)
require_once  DIR_CORE.'/lib/errorhandler.inc.php';

// Lib a request feldolgozásához
require_once DIR_CORE.'/lib/httpcodes.php';
require_once DIR_CORE.'/lib/request.class.php';

// Lib az oldal megjelenítéséhez
require_once DIR_CORE.'/lib/smarty/class.template.php';
if (!file_exists(DIR_SMARTY_COMPILED)) mkdir(DIR_SMARTY_COMPILED, 0777, TRUE);
require_once DIR_CORE.'/lib/output.class.php';

// Lib az adatbázishoz
require_once DIR_CORE.'/lib/dbfactory.class.php';
require_once DIR_CORE.'/lib/database.class.php';
require_once DIR_CORE.'/lib/database.mysql.class.php';
require_once DIR_CORE.'/lib/dao.class.php';
require_once DIR_CORE.'/lib/daofactory.class.php';

// Lib a modulokhoz
require_once DIR_CORE.'/lib/module.class.php';
require_once DIR_CORE.'/lib/modulefactory.class.php';

// Domainekhez tartozó konfig beolvasása
require_once 'sites.php';

// Ha nincs a host nincs domain configban, akkor hibát dob és kilép
$sCurrentUrl = ((isset($_SERVER["HTTPS"]) && $_SERVER["HTTPS"]=="on") ? "https://" : "http://").$_SERVER['HTTP_HOST'];
if (array_key_exists($sCurrentUrl, $GLOBALS['sites'])) $GLOBALS['siteconfig'] = $GLOBALS['sites'][$sCurrentUrl];
else trigger_error("A site nem szerepel a configban: /sites.php ({$_SERVER['HTTP_HOST']})", E_USER_ERROR);
if (isset($GLOBALS['siteconfig']['redirect'])) {
	Request::Redirect($GLOBALS['siteconfig']['redirect'], NULL, NULL, 301);
}

if (!isset($GLOBALS['siteconfig']['site_url'])) $GLOBALS['siteconfig']['site_url'] = $sCurrentUrl;

// Beolvassa az oldalhoz path listát. Ha változás volt a modulokban, akkor újragenerálja
if (checkModuleModifications()) {
	parseModulePath();
	saveModulePath();
}
else $GLOBALS['siteconfig']['path'] = loadModulePath();

// Skin dir beállítása
// Ha létezik skin directory (több skin van a sitehoz)
if (file_exists(DIR_CONTENT.'/sites/_'.$GLOBALS['siteconfig']['id_site'])) {
	define('DIR_SKIN_DEFAULT', DIR_CONTENT.'/sites/'.$GLOBALS['siteconfig']['site_engine']);
	define('DIR_SKIN', DIR_CONTENT.'/sites/_'.$GLOBALS['siteconfig']['id_site']);
	define('URL_SKIN_DEFAULT', $GLOBALS['siteconfig']['site_url'].'/content/sites/'.$GLOBALS['siteconfig']['site_engine']);
	define('URL_SKIN', $GLOBALS['siteconfig']['site_url'].'/content/sites/_'.$GLOBALS['siteconfig']['id_site']);
}
else {
	define('DIR_SKIN_DEFAULT', DIR_CONTENT.'/sites/'.$GLOBALS['siteconfig']['site_engine']);
	define('URL_SKIN_DEFAULT', $GLOBALS['siteconfig']['site_url'].'/content/sites/'.$GLOBALS['siteconfig']['site_engine']);
	define('DIR_SKIN', DIR_SKIN_DEFAULT);
	define('URL_SKIN', URL_SKIN_DEFAULT);
}

// Végrehajtja az oldalhoz tarozó inicializálást (ha van ilyen)
if (file_exists(DIR_CONTENT.'/sites/'.$GLOBALS['siteconfig']['site_engine'].'/init.php')) include_once DIR_CONTENT.'/sites/'.$GLOBALS['siteconfig']['site_engine'].'/init.php';

// A kérés feldolgozása, modul létrehozása
Request::parsePath();

$oModule =& ModuleFactory::getModule(Request::getModuleName());
// Ha az URL lista alapján beazonosított modul nem létezik
if (!isset($oModule)) showErrorPage(404);

// A kért függvény futtatása, eredmény kiírása
$sContent = $oModule->req(Request::getModuleMethodName(), Request::getMethodParameterList());

// Ha a visszatérési érték FALSE, akkor nincs jogunk a tartalomhoz
if ($sContent===FALSE) showErrorPage(403);

//$sContent = str_replace(["\t", "\r", "\n", '  '], ['', '', '', ' '], $sContent);
echo trim($sContent);
?>