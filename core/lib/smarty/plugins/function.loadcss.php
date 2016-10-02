<?php
/*
 * Smarty-Light plugin
 * -------------------------------------------------------------
 * Type:     function
 * Name:     loaccss
 * 
 *  Exmples:
 *  <% loadcss files="style.css, page.css, form.css" %> 
 *  <% loadcss files="style.css, page.css, form.css" output="packed.css" %> 
 *  <% loadcss files="style.css, page.css, form.css" output="packed.css" test=true %> 
 *     
 * Purpose:  
 * Credit:   syke
 * -------------------------------------------------------------
 */

function _packCSS($s) {
	$s = str_replace(array("\n", "\r", "\t", "\v", "\0", "\x0B"), '', preg_replace("/[^\x20-\xFF]/", "", trim(@strval($s))));
	
	$a = array("/[\ ]+/s" => " ",
		"/\; \}/s" => "}",
		"/\;\}/s" => "}",
		"/\}\ /s" => "}",
		"/\: /s" => ":",
		"/\ \{/s" => "{",
		"/\{\ /s" => "{",
		"/\; /s" => ";",
		"/\,\ /s" => ",",
		"/\/\*(.*?)\*\//s" => "");
	
	foreach($a as $k => $v) {
		$s = preg_replace($k, $v, $s);
	}
	
	return $s;
}

/**
 * Teszteleskor visszaadja a css behuzasokat. Nem tomorit, nem mergel.
 */ 
function _loadcss_test($params, &$tpl) {
	$in_filelist = explode(',', $params['files']);
	$out = '';
	foreach ($in_filelist as $in_filename) {
		$in_filename = trim($in_filename);
		$in_full_filename = DIR_CONTENT."/sites/_{$GLOBALS['siteconfig']['id_site']}/css/{$in_filename}";
		if (file_exists($in_full_filename)) {
			$out .= "<link rel=\"stylesheet\" href=\"/content/sites/_{$GLOBALS['siteconfig']['id_site']}/css/{$in_filename}\" />\r\n";
		}
		else {
			$in_full_filename = DIR_CONTENT."/sites/{$GLOBALS['siteconfig']['site_engine']}/css/{$in_filename}";
			if (file_exists($in_full_filename)) {
				$out .= "<link rel=\"stylesheet\" href=\"/content/sites/{$GLOBALS['siteconfig']['site_engine']}/css/{$in_filename}\" />\r\n";
			}
			else $rebuild = TRUE;
		}
	}
	return $out;
}

function tpl_function_loadcss($params, &$tpl) {
	if (isset($params['test']) && $params['test']=='true') return _loadcss_test($params, $tpl);

	if (!file_exists(DIR_TEMP."/css")) mkdir(DIR_TEMP."/css", 0777, TRUE);

	$out_filename = isset($params['output']) ? $params['output'] : $GLOBALS['siteconfig']['site_engine'].'.css';
	$out_full_filename = DIR_TEMP."/css/{$out_filename}";

	$in_filelist = explode(',', $params['files']);

	// Megnezi hogy kell-e uj out css-t generalni:
	// -ha nem letezik a file
	// -ha regebbi mint barmelyik file a listaban
	$rebuild = FALSE;
	if (!file_exists($out_full_filename)) $rebuild = TRUE;
	else {
		$out_mtime = filemtime($out_full_filename);
		foreach ($in_filelist as $in_filename) {
			$in_filename = trim($in_filename);
			$in_full_filename = DIR_CONTENT."/sites/_{$GLOBALS['siteconfig']['id_site']}/css/{$in_filename}";
			if (file_exists($in_full_filename)) {
				if (filemtime($in_full_filename) > $out_mtime) $rebuild = TRUE;
			}
			else {
				$in_full_filename = DIR_CONTENT."/sites/{$GLOBALS['siteconfig']['site_engine']}/css/{$in_filename}";
				if (file_exists($in_full_filename)) {
					if (filemtime($in_full_filename) > $out_mtime) $rebuild = TRUE;
				}
				else $rebuild = TRUE;
			}
		}
	}

	if ($rebuild) {
		// Build compressed content
		$out_content = '';
		foreach ($in_filelist as $in_filename) {
			$in_filename = trim($in_filename);
			$in_full_filename = DIR_CONTENT."/sites/_{$GLOBALS['siteconfig']['id_site']}/css/{$in_filename}";
			if (file_exists($in_full_filename)) $out_content .= _packCSS(file_get_contents($in_full_filename));
			else {
				$in_full_filename = DIR_CONTENT."/sites/{$GLOBALS['siteconfig']['site_engine']}/css/{$in_filename}";
				if (file_exists($in_full_filename)) $out_content .= _packCSS(file_get_contents($in_full_filename));
			}
		}
		file_put_contents($out_full_filename, $out_content);
		$out_mtime = filemtime($out_full_filename);
	}

	return "<link rel=\"stylesheet\" href=\"/temp/css/{$out_filename}?{$out_mtime}\" />";
}
?>