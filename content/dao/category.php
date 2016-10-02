<?php
class CategoryDao extends Dao {
	/**
	 * Egy bolthoz tartozó kategóriák listája
	 *
	 * @param integer $xShop           A bolt azonosítója, vagy permalinkje
	 *
	 * @return array
	 */
	public function getCategoryList($xShop, $sLanguageIso, $aOrderList='', $aFilterList='', $iLimit=0, $iPage=1) {
		$aForeignKeys = array(
			'name' => 'category_text.name',
			'permalink' => 'category_text.permalink',
		);

		$sQOrder = self::parseOrderList($aOrderList, $aForeignKeys);
		$sWhere = self::parseFilterList($aFilterList, $aForeignKeys);
		$sQLimit = empty($iLimit) ? '' : " LIMIT ".($iPage-1)*$iLimit.", {$iLimit}";

		$iRowCount = $this->rConnection->getValue('
			SELECT COUNT(*)
			FROM category
			'.($xShop > 0 ? 'WHERE category.id_shop = :0' : 'INNER JOIN shop ON shop.id_shop = category.id_shop WHERE shop.permalink = :0')
		.$sWhere, func_get_args());

		$aData = $this->rConnection->getList('
			SELECT category.*, category_text.*
			FROM category
			INNER JOIN category_text
			ON category.id_category = category_text.id_category
			INNER JOIN language
			ON category_text.id_language = language.id_language
			'.($xShop > 0 ? 'WHERE category.id_shop = :0' : 'INNER JOIN shop ON shop.id_shop = category.id_shop WHERE shop.permalink = :0').'
			AND language.iso = :1'
		.$sWhere.$sQOrder.$sQLimit, func_get_args());

		return array(
			'rowcount' => $iRowCount,
			'pagecount' => self::calcPageCount($iRowCount, $iLimit),
			'list' => $aData,
		);
	}

	/**
	 * A shophoz tartozó kategóriák listája a conscendo_table által feldolgozható formában
	 */	 
	public function getDistinctCategory($iIdShop, $sLanguageIso) {
		return $this->rConnection->getValueList("
			SELECT category_text.name
			FROM category
			INNER JOIN category_text
			ON category.id_category = category_text.id_category
			INNER JOIN language
			ON category_text.id_language = language.id_language
			WHERE id_shop = :0
			AND language.iso = :1
			ORDER BY category_text.name
		", func_get_args());
	}

	/**
	 * Egy kategória adatai
	 *
	 * @param  integer  $iIdCategory
	 *
	 * @return array
	 */
	public function getCategory($iIdCategory, $sLanguageIso='') {
		if ($sLanguageIso) {
			return $this->rConnection->getRow("
				SELECT category.*, category_text.*
				FROM category
				INNER JOIN category_text
				ON category_text.id_category = category.id_category
				INNER JOIN language
				ON language.id_language = category_text.id_language
				WHERE category.id_category = :0
				AND language.iso = :1
			", func_get_args());
		}
		else {
			return $this->rConnection->getRow("
				SELECT *
				FROM category
				WHERE id_category = :0
			", func_get_args());
		}
	}

	/**
	 * Egy kategória szöveges adatai a megadott nyelven (név, permalink)
	 *
	 * @param  integer  $iIdCategory
	 * @param  integer  $iIdLanguage
	 *
	 * @return array
	 */
	public function getText($iIdCategory, $iIdLanguage) {
		return $this->rConnection->getRow("
			SELECT *
			FROM category_text
			WHERE id_category = :0
			AND id_language = :1
		", func_get_args());
	}

	/**
	 * Egy kategória adatainak lekérdezése a bolt azonosítója és a kategória permalinkje alapján
	 *
	 * @param  integer  $iIdShop
	 * @param  string   $sPermalink
	 *
	 * @return array
	 */
	public function getCategoryByIdShopAndPermalink($iIdShop, $sPermalink) {
		return $this->rConnection->getRow(
			"SELECT * FROM category WHERE id_shop = :iIdShop AND permalink = :sPermalink",
			array(
				'iIdShop' => $iIdShop,
				'sPermalink' => $sPermalink
			)
		);
	}

	/**
	 * Egy kategória adatainak lekérdezése a bolt permalinkje és a kategória permalinkje alapján
	 *
	 * @param  string  $sPermalinkShop
	 * @param  string  $sPermalinkCategory
	 *
	 * @return array
	 */
	public function getCategoryByShopAndPermalink($sPermalinkShop, $sPermalinkCategory) {
		return $this->rConnection->getRow("
			SELECT
				category.*,
				category_text.name,
				category_text.permalink,
				category_text.description,
				shop.permalink AS shop_permalink,
				shop.name AS shop_name,
				language.iso AS language_iso
			FROM category
			INNER JOIN shop
			ON category.id_shop = shop.id_shop
			INNER JOIN category_text
			ON category_text.id_category = category.id_category
			INNER JOIN language
			ON category_text.id_language = language.id_language
			WHERE shop.permalink = :0
			AND category_text.permalink = :1
		", func_get_args());
	}

	/**
	 * Kategória törlése
	 *
	 * @param  integer  $iIdCategory
	 *
	 * @return array
	 */
	public function deleteCategory($iIdCategory) {
		$this->rConnection->execute("
			DELETE FROM
				category
			WHERE
				category.id_category=:iIdCategory
		", array(
				'iIdCategory' => $iIdCategory
			)
		);
	}

	/**
	 * Létrehoz egy kategóriát
	 *
	 * @param  integer  $iIdShop     A shop azonosítója amihez a kategória tartozik
	 * @param  string   $sPermalink  A kategória permalinkje
	 * @param  string   $sName       A kategória neve
	 *
	 * @return array
	 */
	public function insertCategory($iIdShop, $sPermalink, $sName) {
		return $this->rConnection->insert('
			INSERT INTO category (id_shop)
			VALUES (:0)
		', func_get_args());
	}

	/**
	 * Módosítja a kategóriához tartozó szövegeket a megadott nyelven
	 *
	 * @param  integer  $iIdCategory        A kategória azonosítója
	 * @param  integer  $iIdLanguage        A nyelv azonosítója
	 * @param  string   $sPermalink         A kategória permalinkje
	 * @param  string   $sName              A kategória neve
	 */
	public function replaceText($iIdCategory, $iIdLanguage, $sPermalink, $sName, $sDescription) {
		return $this->rConnection->insert('
			REPLACE INTO category_text (id_category, id_language, permalink, name, description)
			VALUES (:0, :1, :2, :3, :4)
		', func_get_args());
	}

	/**
	 * Megnézi, hogy létezik-e a megadott kategória
	 * 
	 * @param  integer  $iIdShop            A shop azonosítója
	 * @param  string   $sPermalink         A kategória permalinkje
	 * @param  string   $iIdCategory        (Opcionális) A kategória azonosítója
	 *                                      Ha pl 15-os kategoriat _updatelem_ akkor a permalinkjere
	 *                                      rakeresve 15 lesz az eredmeny, tehat pozitiv.
	 *                                      Updatekor tehát meg kell adni a kategória azonosítóját
	 *                                      és azt kiveszi a "haystackből"	 	  	 
	 */
	public function checkPermalinkExists($iIdShop, $sPermalink, $iIdCategory=0) {
		$iTest = $this->rConnection->getValue("
			SELECT id_category
			FROM category
			INNER JOIN category_text
			ON category_text.id_category = category.id_category
			WHERE id_shop=:0
			AND category_text.permalink = :1
			".( $iIdCategory ? "AND id_category != :2" : "" ),
			func_get_args()
		);
		return !empty($iTest);
	}
}
?>