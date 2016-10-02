<?php
class PackDao extends Dao {
	/**
	 * Egy bolt csomagjainak listája
	 *
	 * @param integer $xShop           A bolt azonosítója
	 * @param integer $iIdLanguageIso  A lekérdezés nyelvének azonosítója
	 *
	 * @return array
	 */
	public function getPackList($xShop, $sLanguageIso, $aOrderList='', $aFilterList='', $iLimit=0, $iPage=1) {
		$sQOrder = self::parseOrderList($aOrderList);
		$sWhere = self::parseFilterList($aFilterList);
		$sQLimit = empty($iLimit) ? '' : " LIMIT ".($iPage-1)*$iLimit.", {$iLimit}";

		$iRowCount = $this->rConnection->getValue('
			SELECT COUNT(*)
			FROM pack
			INNER JOIN category
			ON pack.id_category = category.id_category
			INNER JOIN shop
			ON category.id_shop = shop.id_shop
			INNER JOIN pack_text
			ON pack.id_pack = pack_text.id_pack
			INNER JOIN language
			ON pack_text.id_language = language.id_language
			'.($xShop > 0 ? 'WHERE shop.id_shop = :0' : 'WHERE shop.permalink = :0').'
			AND language.iso = :1
			'.$sWhere, func_get_args()
		);

		$aData = $this->rConnection->getList('
			SELECT
				pack.*,
				pack_text.*,
				category_text.name AS category_name,
				category_text.permalink AS category_permalink,
				pack_photo.filename AS photo_filename,
				pack_photo.id_photo
			FROM pack
			INNER JOIN category
			ON pack.id_category = category.id_category
			INNER JOIN category_text
			ON category_text.id_category = category.id_category
			INNER JOIN shop
			ON category.id_shop = shop.id_shop
			INNER JOIN pack_text
			ON pack.id_pack = pack_text.id_pack
			INNER JOIN language
			ON (pack_text.id_language = language.id_language AND category_text.id_language=language.id_language)
			LEFT JOIN pack_photo
			ON pack.id_pack = pack_photo.id_pack
			'.($xShop > 0 ? 'WHERE shop.id_shop = :0' : 'WHERE shop.permalink = :0').'
			AND language.iso = :1
			AND (pack_photo.order = 0 OR pack_photo.order IS NULL)
			'.$sWhere.$sQOrder.$sQLimit, func_get_args()
		);

		return array(
			'rowcount' => $iRowCount,
			'pagecount' => self::calcPageCount($iRowCount, $iLimit),
			'list' => $aData,
		);
	}

	/**
	 * Egy kategoria csomagjainak listája
	 *
	 * @param integer $iIdCategory     A kategoria azonosítója
	 * @param integer $iIdLanguageIso  A lekérdezés nyelvének azonosítója
	 *
	 * @return array
	 */
	public function getPackListByIdCategory($iIdCategory, $sLanguageIso) {
		return $this->rConnection->getList('
			SELECT
				pack.*,
				pack_text.*,
				pack_photo.filename AS photo_filename,
				pack_photo.id_photo AS photo_id_photo
			FROM pack
			INNER JOIN category
			ON pack.id_category = category.id_category
			INNER JOIN shop
			ON category.id_shop = shop.id_shop
			INNER JOIN pack_text
			ON pack.id_pack = pack_text.id_pack
			INNER JOIN language
			ON pack_text.id_language = language.id_language
			LEFT JOIN pack_photo
			ON pack.id_pack = pack_photo.id_pack
			WHERE pack.id_category = :0
			AND language.iso = :1
			AND (pack_photo.order = 0 OR pack_photo.order IS NULL)
			', func_get_args()
		);

		return array(
			'rowcount' => $iRowCount,
			'pagecount' => self::calcPageCount($iRowCount, $iLimit),
			'list' => $aData,
		);
	}

	/**
	 * Egy csomaghoz hozzárendelt termékek listája
	 *
	 * @param integer $iIdPack         A bolt azonosítója
	 * @param integer $iIdLanguageIso  A lekérdezés nyelvének azonosítója
	 *
	 * @return array
	 */
	public function getLinkedProductList($iIdPack, $sLanguageIso='', $aOrderList='', $aFilterList='', $iLimit=0, $iPage=1, $bCountOnly = false) {
		$sQOrder = self::parseOrderList($aOrderList);
		$sWhere = self::parseFilterList($aFilterList);
		$sQLimit = empty($iLimit) ? '' : " LIMIT ".($iPage-1)*$iLimit.", {$iLimit}";

		$iRowCount = $this->rConnection->getValue('
			SELECT COUNT(*)
			FROM pack_product
			INNER JOIN product
			ON product.id_product = pack_product.id_product
			WHERE pack_product.id_pack = :0
			'.$sWhere, func_get_args()
		);

		if ($sLanguageIso) {
			$sQuery = '
				SELECT
					pack_product.*,
					product.price,
					product.is_featured,
					product.is_sale,
					product.barcode,
					product.quantity AS stock_quantity,
					product_text.permalink,
					product_text.name,
					product_text.short_description,
					product_text.long_description 
				FROM pack_product
				INNER JOIN product
				ON product.id_product = pack_product.id_product
				INNER JOIN product_text
				ON product.id_product = product_text.id_product
				INNER JOIN language
				ON product_text.id_language = language.id_language
				WHERE pack_product.id_pack = :0
				AND language.iso = :1
			';
		}
		else {
			$sQuery = '
				SELECT
					pack_product.*,
					product.price,
					product.is_featured,
					product.is_sale,
					product.barcode,
					product.quantity AS stock_quantity
				FROM pack_product
				INNER JOIN product
				ON product.id_product = pack_product.id_product
				WHERE pack_product.id_pack = :0
			';
		}

		$aData = $this->rConnection->getList($sQuery.$sWhere.$sQOrder.$sQLimit, func_get_args());

		return array(
			'rowcount' => $iRowCount,
			'pagecount' => self::calcPageCount($iRowCount, $iLimit),
			'list' => $aData,
		);
	}

	/**
	 * Egy csomag adatai
	 *
	 * @param  integer  $iIdPack
	 *
	 * @return array
	 */
	public function getPack($iIdPack, $sLanguageIso='') {
		if ($sLanguageIso) {
			return $this->rConnection->getRow('
				SELECT pack.*, category.id_shop, pack_text.*
				FROM pack
				INNER JOIN category
				ON pack.id_category = category.id_category
				INNER JOIN pack_text
				ON pack.id_pack = pack_text.id_pack
				WHERE pack.id_pack = :0
			', func_get_args());
		}
		else {
			return $this->rConnection->getRow('
				SELECT pack.*, category.id_shop
				FROM pack
				INNER JOIN category
				ON pack.id_category = category.id_category
				WHERE id_pack = :0
			', func_get_args());
		}
	}

	/**
	 * Egy csomag adatai az összes kapcsolódó infoval (shop) együtt
	 *
	 * @param  integer  $iIdPack
	 *
	 * @return array
	 */
	public function getPackFull($iIdPack, $xLanguage) {
		// Ha az xLanguage>0, akkor id-t tartalmaz a paraméter
		// Különben ISO-ként értelmezzük
		if ($xLanguage > 0) $sWhLang = "AND pack_text.id_language = :1";
		else $sWhLang = "AND language.iso = :1";
		
		return $this->rConnection->getRow("
			SELECT
				pack.*,
				pack_text.name,
				pack_text.permalink,
				pack_text.short_description,
				pack_text.long_description,
				shop.permalink AS shop_permalink,
				shop.name AS shop_name,
				pack_photo.id_photo,
				pack_photo.filename AS photo_filename,
				pack_photo.id_photo AS photo_id_photo
			FROM pack
			INNER JOIN pack_text
			ON pack.id_pack = pack_text.id_pack
			INNER JOIN category
			ON pack.id_category = category.id_category
			INNER JOIN shop
			ON category.id_shop = shop.id_shop
			LEFT JOIN pack_photo
			ON pack.id_pack = pack_photo.id_pack
			LEFT JOIN language
			ON pack_text.id_language = language.id_language
			WHERE pack.id_pack = :0
			AND (pack_photo.order = 0 OR pack_photo.order IS NULL)
			{$sWhLang}
		", func_get_args());
	}

	/**
	 * Egy csomag szöveges adatai a megadott nyelven (név, permalink, rövid leírás, hosszú leírás)
	 *
	 * @param  integer  $iIdPack
	 * @param  integer  $iIdLanguage
	 *
	 * @return array
	 */
	public function getText($iIdPack, $iIdLanguage) {
		return $this->rConnection->getRow("
			SELECT *
			FROM pack_text
			WHERE id_pack = :0
			AND id_language = :1
		", func_get_args());
	}

	/**
	 * A csomagban szereplő egyik termék mennyisége
	 *
	 * @param  integer  $iIdPack
	 * @param  integer  $iIdProduct
	 *
	 * @return array
	 */
	public function getProductQuantity($iIdPack, $iIdProduct) {
		return $this->rConnection->getValue('
			SELECT quantity
			FROM pack_product
			WHERE id_pack = :0
			AND id_product = :1
		', func_get_args());
	}

	/**
	 * Egy csomag adatainak lekérdezése a permalinkje és a shop azonosító alapján
	 *
	 * @param  integer  $iIdShop
	 * @param  integer  $iIdLanguage
	 * @param  string   $sPermalink
	 *
	 * @return array
	 */
	public function getPackByPermalink($xShop, $sPermalink) {
		if ($xShop > 0) {
			return $this->rConnection->getRow('
				SELECT
					pack.*,
					pack_text.*,
					language.iso AS language_iso,
					pack_photo.filename AS photo_filename,
					pack_photo.id_photo AS photo_id_photo
				FROM pack
				INNER JOIN category
				ON category.id_category = pack.id_category
				INNER JOIN pack_text
				ON pack_text.id_pack = pack.id_pack
				INNER JOIN language
				ON pack_text.id_language = language.id_language
				LEFT JOIN pack_photo
				ON pack.id_pack = pack_photo.id_pack
				WHERE category.id_shop = :0
				AND pack_text.permalink = :1
				AND (pack_photo.order = 0 OR pack_photo.order IS NULL)
			', func_get_args());
		}
		else {
			return $this->rConnection->getRow('
				SELECT
					pack.*,
					pack_text.*,
					language.iso AS language_iso,
					pack_photo.filename AS photo_filename,
					pack_photo.id_photo AS photo_id_photo
				FROM pack
				INNER JOIN category
				ON category.id_category = pack.id_category
				INNER JOIN pack_text
				ON pack_text.id_pack = pack.id_pack
				INNER JOIN language
				ON pack_text.id_language = language.id_language
				INNER JOIN shop
				ON shop.id_shop = category.id_shop
				LEFT JOIN pack_photo
				ON pack.id_pack = pack_photo.id_pack
				WHERE shop.permalink = :0
				AND pack_text.permalink = :1
				AND (pack_photo.order = 0 OR pack_photo.order IS NULL)
			', func_get_args());
		}
	}

	/**
	 * Csomag törlése
	 *
	 * @param  integer  $iIdPack
	 *
	 * @return void
	 */
	public function deletePack($iIdPack) {
		$this->rConnection->execute('
			DELETE FROM pack
			WHERE pack.id_pack = :0
		', func_get_args());
	}

	/**
	 * Létrehoz egy csomagot
	 *
	 * @param  integer  $iIdCategory        A kategoria azonosítója, amihez a csomag tartozik
	 * @param  integer  $iPrice             A csomag ára
	 *
	 * @return array    A csomag azonosítója
	 */
	public function insertPack($iIdCategory, $iPrice) {
		return $this->rConnection->insert('
			INSERT INTO pack (id_category, price)
			VALUES (:0, :1)
		', func_get_args());
	}

	/**
	 * Módosítja egy csomag adatait
	 *
	 * @param  integer  $iIdPack            A csomag azonosítója
	 * @param  integer  $iPrice             Ár
	 */
	public function updatePack($iIdPack, $iIdCategory, $iPrice) {
		$this->rConnection->execute('
			UPDATE pack
			SET id_category = :1, price = :2
			WHERE id_pack = :0
		', func_get_args());
	}

	/**
	 * Módosítja a csomaghoz tartozó szövegeket a megadott nyelven
	 *
	 * @param  integer  $iIdPack            A csomag azonosítója
	 * @param  integer  $iIdLanguage        A nyelv azonosítója
	 * @param  string   $sPermalink         A csomag permalinkje
	 * @param  string   $sName              A csomag neve
	 */
	public function replaceText($iIdPack, $iIdLanguage, $sPermalink, $sName, $sShortDescription, $sLongDescription) {
		return $this->rConnection->insert('
			REPLACE INTO pack_text (id_pack, id_language, permalink, name, short_description, long_description)
			VALUES (:0, :1, :2, :3, :4, :5)
		', func_get_args());
	}

	/**
	 * Termék mennyiségének beállítása egy csomagban
	 *
	 * @param  integer  $iIdPack            A csomag azonosítója
	 * @param  integer  $iIdProduct         A termék azonosítója
	 * @param  integer  $iQuantity          Mennyiség
	 */
	public function setProductQuantity($iIdPack, $iIdProduct, $iQuantity) {
		if ($iQuantity > 0) {
			return $this->rConnection->insert('
				REPLACE INTO pack_product (id_pack, id_product, quantity)
				VALUES (:0, :1, :2)
			', func_get_args());
		}
		else {
			return $this->rConnection->insert('
				DELETE FROM pack_product
				WHERE id_pack = :0
				AND id_product = :1
			', func_get_args());
		}
/*
		return $this->rConnection->insert('
			INSERT INTO pack_product (id_pack, id_product, quantity)
			VALUES (:0, :1, 1)
			ON DUPLICATE KEY UPDATE quantity = quantity + 1;
		', func_get_args());
*/		
  
	}

	/**
	 * Töröl egy terméket a csomagból
	 *
	 * @param  integer  $iIdPack            A csomag azonosítója
	 * @param  integer  $iIdProduct         A termék azonosítója
	 */
	public function deleteProductFromPack($iIdPack, $iIdProduct) {
		return $this->rConnection->insert('
			DELETE FROM pack_product (id_pack, id_product)
			WHERE id_pack = :0
			AND id_product = :1
		', func_get_args());
	}
}