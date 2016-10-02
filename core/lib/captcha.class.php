<?php
/**
 * Captcha generalo osztaly. Jelenleg egy suru hatterrel rendelkezo kepet general png-be.
 */
class Captcha
{
	/** Alapertelmezett betukeszlet a capcha-hoz */
	public $font = 'core/lib/fonts/swz721ka.ttf';
	/** Megjelenitendo kod szovege */
	private $code = '';
	/** Kod hossza */
	private $codeLength = 6;
	/** Captcha kep valtozoja */
	private $image = null;

	/**
	 * General egy veletlenszeru CAPTCHA szoveget.
	 * 
	 * @param int		$length		Generalt szoveg hossza.
	 * 
	 * @return string A CAPTCHA szoveg.
	 */
	function generateText($length = null)
	{
		if (!is_null($length)) {
			$this->codeLength = $length;
		}
		// Nem minden betut hasznalunk a CAPTCHA-hoz, mert nemelyiket nehez felismerni
		static $consonants = array('B', 'C', 'D', 'G', 'J', 'M', 'N', 'P', 'R', 'S', 'T', 'V', 'X');
		static $vowels = array('A', 'E', 'I', 'O', 'U');

		for ($i = 0; $i < $this->codeLength; $i++) {
			// CVCCVC format kovetunk, hogy nagyjabol kiejtheto CAPTCHA szovegek legyenek
			$letters = ($i % 3 == 1 ? $vowels : $consonants);
			$this->code .= $letters[array_rand($letters)];
		}
		return $this->code;
	}

	/**
	 * Legeneralja s visszaadja a legeneralt captcha kepet.
	 * 
	 * @param int		$width		Kep szelessege.
	 * @param int		$height		Kep magassaga.
	 * 
	 * @return void
	 */
	public function generateCaptchaImage($width = 250, $height = 60)
	{
		// Letrehozzuk a kepet
		$this->image = imagecreatetruecolor($width, $height);
		// Tovabbi beallitasok
		$lineDistance = 8;
		$fontSize = 18;
		$fontColor = imagecolorallocatealpha($this->image, 0x00, 0x18, 0x20, floor(0.15*127));
		$bgColor = imagecolorallocate($this->image, 0xB8, 0xDD, 0xE9);
		$lineColor = imagecolorallocatealpha($this->image, 0x00, 0x18, 0x20, floor(0.6*127));
		// Feltoltjuk a hatteret
		imagefilledrectangle($this->image, 0, 0, imagesx($this->image), imagesy($this->image), $bgColor);
		// Fuggoleges vonalak
		for ($x = 4; $x < $width; $x += $lineDistance) {
			imageline($this->image, $x + rand(-3, 3), 0, $x + rand(-3, 3), $height, $lineColor);
		}
		// Vizszintes vonalak
		for ($y = 5; $y < $height; $y += $lineDistance) {
			imageline($this->image, 0, $y + rand(-3, 3), $width, $y + rand(-3, 3), $lineColor);
		}
		// Atlos vonalak
		for ($x = -($height) - 1; $x < $width; $x += $lineDistance) {
			imageline($this->image, $x + rand(-3, 3), 0, $x + $height + rand(-3, 3), $height, $lineColor);
		}
		for ($x = $width + $height + 2; $x > 0; $x -= $lineDistance) {
			imageline($this->image, $x + rand(-3, 3), 0, $x - $height + rand(-3, 3), $height, $lineColor);
		}
		// Bekeretezzuk a hatteret
		imagerectangle($this->image, 0, 0, $width - 1, $height - 1, imagecolorallocate($this->image, 0, 0, 0));
		// Kirajzoljuk a szoveget
		$x = 5;
		$yCenter = floor($height / 2 + $fontSize / 2);
		$yMin = $yCenter - 3;
		$yMax = $yCenter + 3;
		// Betunkent kiirjuk elforgatva a szoveget
		for ($i = 0; $i < $this->codeLength; $i++) {
			$angle = rand(-20, 20);
			$y = rand($yMin, $yMax);
			imagettftext($this->image, $fontSize, $angle, $x, $y, $fontColor, $this->font, $this->code[$i]);
			$x += $fontSize;
		}
	}

	/**
	 * Visszaaadja az osztaly image valtozojat.
	 * 
	 * @return gd		Az osztaly image valtozoja, ha nincs meg generalva akkor null az erteke.
	 */
	public function getCaptchaImage()
	{
		return $this->image;
	}

	/**
	 * Kiirja a legeneralt captcha kepet ha van
	 *
	 * @return mixed		Kiiratja az outputra a kepet, vagy false ha nincs meg forras kep
	 */
	public function writeCaptcha()
	{
		if (!is_null($this->image)) {
			// fejlecek kiiratasa
			header('Expires: Mon, 01 Jan 1997 05:00:00 GMT');
			header('Cache-Control: no-store, no-cache, must-revalidate');
			header('Cache-Control: post-check=0, pre-check=0', false);
			header('Pragma: no-cache');
			header('Content-type: image/jpeg');
			// png kepet generalunk
			imagepng($this->image);
			// megsemmisitjuk a kepet
			imagedestroy($this->image);
		}
		return false;
	}
}
?>