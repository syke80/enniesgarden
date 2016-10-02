<?php

class Img {
	/**
	 * Átméretez egy képet.
	 * Ha az arányok nem megfelelőek, akkor a kép tetejét/alját, vagy bal/jobb oldalát kitölti üres pixelekkel
	 *
	 * @param  string   $sFilenameIn   A bemeneti kép neve
	 * @param  string   $sFilenameOut  A kimeneti kép neve
	 * @param  integer  $iWidth        A kimeneti kép szélessége
	 * @param  integer  $iHeight       A kimeneti kép magassága
	 * @param  integer  $iFormat       A kimeneti kép formátuma (jpg | png). Ha nincs megadva, akkor megegyezik a bemeneti kép formátumával.
	 *
	 * @return void
	 */
	private static function _imgResizeFill($sFileNameIn, $sFileNameOut, $sFormatOut, $sExtensionOut, $iWidth, $iHeight) {
		$aImageInInfo = getimagesize($sFileNameIn);
		
		switch ($aImageInInfo['mime']) {
			case 'image/png':
				$rImageIn = imagecreatefrompng($sFileNameIn);
				break;
			case 'image/jpeg':
				$rImageIn = imagecreatefromjpeg($sFileNameIn);
				break;
			default:
				Debug::addMsg("SmartyLight imgresize error (ResizeFill): Unknown type {$aImageInInfo['mime']}", '', ERROR_ERRORLOG);
		}
		if (empty($rImageIn)) {
			Debug::addMsg("SmartyLight imgresize error (ResizeFill): Cannot open image: {$sFileNameIn}", '', ERROR_ERRORLOG);
			return;
		}
	
		$fImageInRatio = $aImageInInfo[0] / $aImageInInfo[1];
		$fImageOutRatio = $iWidth / $iHeight;
	
		// ha az arány egyforma, akkor az átméretezett kép akkora mint a kimeneti kép és a pozíciója 0, 0
		if ($fImageInRatio == $fImageOutRatio) {
			$iImageResizedWidth = $iWidth;
			$iImageResizedHeight = $iHeight;
			$iImageResizedX = 0;
			$iImageResizedY = 0;
		}
		else {
			// ha az out arány nagyobb (tehát a kimeneti kép szélesebb) akkor a jobb/bal oldalát kell kitölteni
			// a magassága maximális, y=0, ki kell számolni az x pozíciót és a szélességet
			if ($fImageOutRatio > $fImageInRatio) {
				$iImageResizedHeight = $iHeight;
				$iImageResizedY = 0;
				$iImageResizedWidth = round($iImageResizedHeight * $fImageInRatio);
				$iImageResizedX = round(($iWidth - $iImageResizedWidth) / 2);
			}
			// ha az in arány a nagyobb (a kimeneti kép magasabb), akkor ugyanez fordítva
			else {
				$iImageResizedWidth = $iWidth;
				$iImageResizedX = 0;
				$iImageResizedHeight = round($iImageResizedWidth / $fImageInRatio);
				$iImageResizedY = round(($iHeight - $iImageResizedHeight) / 2);
			}
		}
	
		$rImageResized = imagecreatetruecolor($iImageResizedWidth, $iImageResizedHeight);
		imagecopyresampled($rImageResized, $rImageIn, 0, 0, 0, 0, $iImageResizedWidth, $iImageResizedHeight, $aImageInInfo[0], $aImageInInfo[1]);
	
		// kimeneti kép létrehozása, kitöltése átlátszó "színnel"
		$rImageOut = imagecreatetruecolor($iWidth, $iHeight);
		$iCol = imagecolorallocatealpha($rImageOut, 255, 255, 255, 127);
		imagefill($rImageOut, 0, 0, $iCol);
	
		// az átméretezett kép rárakása az üres canvas-ra
		imagecopy($rImageOut, $rImageResized, $iImageResizedX, $iImageResizedY, 0, 0, $iImageResizedWidth, $iImageResizedHeight);
	
		imagesavealpha($rImageOut, TRUE);
		switch ($sFormatOut) {
			case 'png':
				imagepng($rImageOut, $sFileNameOut.$sExtensionOut);
				break;
			case 'jpg':
				imagejpeg($rImageOut, $sFileNameOut.$sExtensionOut);
				break;
		}
	}
	
	/**
	 * Átméretez egy képet.
	 * Ha az arányok nem megfelelőek, akkor a kép tetejét/alját, vagy bal/jobb oldalát levágja
	 *
	 * @param  string   $sFilenameIn   A bemeneti kép neve
	 * @param  string   $sFilenameOut  A kimeneti kép neve
	 * @param  integer  $iWidth        A kimeneti kép szélessége
	 * @param  integer  $iHeight       A kimeneti kép magassága
	 *
	 * @return void
	 */
	private static function _imgResizeCrop($sFileNameIn, $sFileNameOut, $sFormatOut, $sExtensionOut, $iWidth, $iHeight) {
		$aImageInInfo = getimagesize($sFileNameIn);
		switch ($aImageInInfo['mime']) {
			case 'image/png':
				$rImageIn = imagecreatefrompng($sFileNameIn);
				break;
			case 'image/jpeg':
				$rImageIn = imagecreatefromjpeg($sFileNameIn);
				break;
			default:
				Debug::addMsg("SmartyLight imgresize error (ResizeCrop): Unknown type {$aImageInInfo['mime']}", '', ERROR_ERRORLOG);
		}
		if (empty($rImageIn)) {
			Debug::addMsg("SmartyLight imgresize error (ResizeCrop): Cannot open image: {$sFileNameIn}", '', ERROR_ERRORLOG);
			return;
		}
	
		$fImageInRatio = $aImageInInfo[0] / $aImageInInfo[1];
		$fImageOutRatio = $iWidth / $iHeight;
	
		// létrehozunk egy keretet az eredeti képen aminek az aránya megegyezik a kimeneti kép arányával
		// ki kell számolni a keret méretét és pozícióját az eredeti képen
	
		// ha az arány egyforma, akkor a keret akkora mint a kép
		if ($fImageInRatio == $fImageOutRatio) {
			$iFrameWidth = $aImageInInfo[0];
			$iFrameHeight = $aImageInInfo[1];
			$iFrameX = 0;
			$iFrameY = 0;
		}
		else {
			// ha az out arány nagyobb (tehát a kimeneti kép szélesebb) akkor a kép tetejéből és aljából kell vágni:
			// a keret szélessége maximális, ki kell számolni az y koordinátákat
			if ($fImageOutRatio > $fImageInRatio) {
				$iFrameWidth = $aImageInInfo[0];
				$iFrameX = 0;
				$iFrameHeight = round($aImageInInfo[1] / ($fImageOutRatio / $fImageInRatio));
				$iFrameY = round(($aImageInInfo[1] - $iFrameHeight) / 2);
			}
			// ha az in arány a nagyobb akkor ugyanez fordítva
			else {
				$iFrameHeight = $aImageInInfo[1];
				$iFrameY = 0;
				$iFrameWidth = round($aImageInInfo[0] / ($fImageInRatio / $fImageOutRatio));
				$iFrameX = round(($aImageInInfo[0] - $iFrameWidth) / 2);
			}
		}
	
		$rImageOut = imagecreatetruecolor($iWidth, $iHeight);
	
		imagecopyresampled($rImageOut, $rImageIn, 0, 0, $iFrameX, $iFrameY, $iWidth, $iHeight, $iFrameWidth, $iFrameHeight);
	
		imagesavealpha($rImageOut, TRUE);
		switch ($sFormatOut) {
			case 'png':
				imagepng($rImageOut, $sFileNameOut.$sExtensionOut);
				break;
			case 'jpg':
				imagejpeg($rImageOut, $sFileNameOut.$sExtensionOut);
				break;
		}
	}
	
	/**
	 * Átméretez egy képet.
	 * Ha az arányok nem megfelelőek, akkor "szethuzza" a kepet
	 *
	 * @param  string   $sFilenameIn   A bemeneti kép neve
	 * @param  string   $sFilenameOut  A kimeneti kép neve
	 * @param  integer  $iWidth        A kimeneti kép szélessége
	 * @param  integer  $iHeight       A kimeneti kép magassága
	 *
	 * @return void
	 */
	private static function _imgResizeStretch($sFileNameIn, $sFileNameOut, $sFormatOut, $sExtensionOut, $iWidth, $iHeight) {
		$aImageInInfo = getimagesize($sFileNameIn);
		switch ($aImageInInfo['mime']) {
			case 'image/png':
				$rImageIn = imagecreatefrompng($sFileNameIn);
				break;
			case 'image/jpeg':
				$rImageIn = imagecreatefromjpeg($sFileNameIn);
				break;
			default:
				Debug::addMsg("SmartyLight imgresize error (ResizeScale): Unknown type {$aImageInInfo['mime']}", '', ERROR_ERRORLOG);
		}
		if (empty($rImageIn)) {
			Debug::addMsg("SmartyLight imgresize error (ResizeScale): Cannot open image: {$sFileNameIn}", '', ERROR_ERRORLOG);
			return;
		}
	
		$rImageOut = imagecreatetruecolor($iWidth, $iHeight);
	
		imagecopyresampled($rImageOut, $rImageIn, 0, 0, 0, 0, $iWidth, $iHeight, $aImageInInfo[0], $aImageInInfo[1]);
	
		imagesavealpha($rImageOut, TRUE);
		switch ($sFormatOut) {
			case 'png':
				imagepng($rImageOut, $sFileNameOut.$sExtensionOut);
				break;
			case 'jpg':
				imagejpeg($rImageOut, $sFileNameOut.$sExtensionOut);
				break;
		}
	}

	/**
	 * Átméretez egy képet.
	 * Az aranyokat megtartja, a width-t es height-t maximum ertekkent ertelmezi
	 *
	 * @param  string   $sFilenameIn   A bemeneti kép neve
	 * @param  string   $sFilenameOut  A kimeneti kép neve
	 * @param  integer  $iWidth        A kimeneti kép szélessége
	 * @param  integer  $iHeight       A kimeneti kép magassága
	 *
	 * @return void
	 */
	private static function _imgResizeKeep($sFileNameIn, $sFileNameOut, $sFormatOut, $sExtensionOut, $iWidth, $iHeight) {
		$aImageInInfo = getimagesize($sFileNameIn);

		$rRatio = $aImageInInfo[1] / $aImageInInfo[0];
		$iWidthCalc = $iWidth;
		$iHeightCalc = $iWidthCalc / $rRatio;
		if ($iHeightCalc>$iHeight) {
			$iHeightCalc = $iHeight;
			$iWidthCalc = $iHeightCalc / $rRatio;
		}
		return self::_imgResizeStretch($sFileNameIn, $sFileNameOut, $sFormatOut, $sExtensionOut, $iWidthCalc, $iHeightCalc);
	}
	
	/**
	 * file:             a bemeneti fájl neve (video_dir/filenev)
	 * width:            az átméretezett kép szélessége
	 * height:           az átméretezett kép magassága 
	 * resized_filename: az átméretezett kép neve
	 * type:             az átméretezés típusa: fill | crop | scale
	 * 
	 * return: az átméretezett kép útvonala  
	 */    
	public static function imgResize($sFile, $iWidth, $iHeight, $sResizedFilename='', $sType='', $sResizedFormat='') {
		if (!file_exists($sFile)) return '';
		if (is_dir($sFile)) return '';

		// Ha nincs beállítva kimeneti filenév, akkor generál egyet
		if (!in_array($sType, array('fill', 'crop', 'scale', 'keep'))) $sType = 'fill';
	  
		// Ha nincs beállítva kimeneti filenév, akkor generál egyet
		if (empty($sResizedFilename)) {
		  $iHash = md5($sFile); // Azért kell hash a filenévbe, hogy a /var/www/website/upload/serieslogo/12.jpg és a /var/www/website/upload/xy/12.jpg ne ugyanazt a nevet kapja
			$sOriginalFilename = substr($params['file'], strrpos($params['file'], '/')+1);
		  $sOriginalFilename = substr($sOriginalFilename, 0, strrpos($sOriginalFilename, '.'));
			$sResizedFilename = "{$GLOBALS['temp_dir']}/resized/{$iWidth}x{$iHeight}{$sType}_{$sOriginalFilename}_{$iHash}";
		}
	
		// Kimenő file kiterjesztésének beállítása a formátum alapján
		// Ha nincs megadva formátum, akkor
		//   a bemenő fájl formátumát használja
		//   az ehhez tartozó kiterjesztést használja
		switch ($sResizedFormat) {
			case 'png':
				$sResizedExtension = '.png';
				break;
			case 'jpg':
				$sResizedExtension = '.jpg';
				break;
			default:
				$aFileInfo = getimagesize($sFile);
				switch ($aFileInfo['mime']) {
					case 'image/png':
						$sResizedExtension = '.png';
						$sResizedFormat = 'png';
						break;
					case 'image/jpeg':
						$sResizedExtension = '.jpg';
						$sResizedFormat = 'jpg';
						break;
					default:
						Debug::addMsg("SmartyLight imgresize error: Unknown type {$aFileInfo['mime']}", '', ERROR_ERRORLOG);
				}
		}
	
		// Könyvtár létrehozása
		$aFileinfo = pathinfo($sResizedFilename);
		if (!file_exists($aFileinfo['dirname'])) mkdir($aFileinfo['dirname'], 0777, TRUE);

		// File átméretezése
		if (!file_exists("{$sResizedFilename}{$sResizedExtension}")) {
			switch ($sType) {
				case 'fill':
//					echo("resize: {$sFile}, {$sResizedFilename}, {$sResizedFormat}, {$sResizedExtension}, {$iWidth}, {$iHeight}");
					self::_imgResizeFill($sFile, $sResizedFilename, $sResizedFormat, $sResizedExtension, $iWidth, $iHeight);
					break;
				case 'crop':
					self::_imgResizeCrop($sFile, $sResizedFilename, $sResizedFormat, $sResizedExtension, $iWidth, $iHeight);
					break;
				case 'stretch':
					self::_imgResizeScale($sFile, $sResizedFilename, $sResizedFormat, $sResizedExtension, $iWidth, $iHeight);
					break;
				case 'keep':
					self::_imgResizeKeep($sFile, $sResizedFilename, $sResizedFormat, $sResizedExtension, $iWidth, $iHeight);
					break;
			}
		}

		return(array(
			'url' => "{$GLOBALS['siteconfig']['site_url']}/{$sResizedFilename}{$sResizedExtension}",
			'file' => "{$sResizedFilename}{$sResizedExtension}",
			'format' => $sResizedFormat,
		));
	}
}