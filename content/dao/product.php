<?php
class ProductDao extends Dao {
	/**
	 * Egy bolt termékeinek listája
	 *
	 * @param integer $xShop           A bolt azonosítója, vagy permalinkje
	 * @param integer $iIdLanguageIso  A lekérdezés nyelvének azonosítója
	 *
	 * @return array
	 */
	public function getProductList($xShop, $sLanguageIso, $aOrderList='', $aFilterList='', $iLimit=0, $iPage=1, $bCountOnly = false) {
		$aForeignKeys = array(
			'permalink' => 'product_text.permalink',
			'name' => 'product_text.name',
			'category_name'=>'category_text.name',
		);

		$sQOrder = self::parseOrderList($aOrderList);
		$sWhere = self::parseFilterList($aFilterList, $aForeignKeys);
		if ($sWhere) $sWhere = "AND {$sWhere}";
		$sQLimit = empty($iLimit) ? '' : " LIMIT ".($iPage-1)*$iLimit.", {$iLimit}";

		$iRowCount = $this->rConnection->getValue('
			SELECT COUNT(*)
			FROM product
			INNER JOIN product_text
			ON product.id_product = product_text.id_product
			INNER JOIN category
			ON product.id_category = category.id_category
			INNER JOIN category_text
			ON category_text.id_category = category.id_category
			'.($xShop > 0 ? 'WHERE category.id_shop = :0' : 'INNER JOIN shop ON shop.id_shop = category.id_shop WHERE shop.permalink = :0').'
			'.$sWhere, func_get_args()
		);

		$aData = $this->rConnection->getList('
			SELECT 
				product.*,
				product_text.*,
				category_text.name AS category_name,
				category_text.permalink AS category_permalink,
				product_photo.filename AS photo_filename,
				supplier.name AS supplier_name
			FROM product
			INNER JOIN product_text
			ON product.id_product = product_text.id_product
			INNER JOIN category
			ON product.id_category = category.id_category
			INNER JOIN category_text
			ON category_text.id_category = category.id_category
			INNER JOIN language
			ON (product_text.id_language = language.id_language AND category_text.id_language=language.id_language)
			LEFT JOIN product_photo
			ON product.id_product = product_photo.id_product
			LEFT JOIN supplier
			ON supplier.id_supplier = product.id_supplier
			'.($xShop > 0 ? 'WHERE category.id_shop = :0' : 'INNER JOIN shop ON shop.id_shop = category.id_shop WHERE shop.permalink = :0').'
			AND language.iso = :1
			AND (product_photo.order = 0 OR product_photo.order IS NULL)
			'.$sWhere.$sQOrder.$sQLimit, func_get_args()
		);

		return array(
			'rowcount' => $iRowCount,
			'pagecount' => self::calcPageCount($iRowCount, $iLimit),
			'list' => $aData,
		);
	}

	/**
	 * Kulcsszó alapján megkeres egy terméket egy bolton belül
	 * névben, kategórianévben, termékekhez rendelt property értékek között
	 *
	 * @param integer $iIdShop
	 *
	 * @return array
	 */
	public function search($iIdShop, $sIdLanguage, $aSearchStringList) {
		$sQueryWhere = '';
		foreach ($aSearchStringList as $sSearchString) {
			$sQueryWhere .= "
				AND (
					product_text.name LIKE '%{$sSearchString}%'
					OR category_text.name LIKE '%{$sSearchString}%'
					OR product.id_product IN (
							SELECT product_property_value.id_product
							FROM product_property_value
							INNER JOIN property_value
							ON product_property_value.id_value = property_value.id_value
							INNER JOIN property_value_text
							ON property_value_text.id_property_value = property_value.id_value
							INNER JOIN language
							ON language.id_language = property_value_text.id_language
							WHERE property_value_text.value LIKE '%{$sSearchString}%'
							AND language.iso = :1
						)
				)";
		}

		return $this->rConnection->getList("
			SELECT
				product.*,
				product_text.*,
				category_text.name AS category_name,
				product_photo.filename AS photo_filename
			FROM product
			INNER JOIN product_text
			ON product.id_product = product_text.id_product
			INNER JOIN category
			ON product.id_category = category.id_category
			INNER JOIN category_text
			ON category.id_category = category_text.id_category
			INNER JOIN language
			ON product_text.id_language = language.id_language
			LEFT JOIN product_photo
			ON product.id_product = product_photo.id_product
			WHERE category.id_shop = :0
			AND product.is_active = 'y'
			AND language.iso = :1
			AND (product_photo.order = 0 OR product_photo.order IS NULL)
			{$sQueryWhere}
			ORDER BY product_text.name
			", func_get_args()
		);
	}

	/**
	 * Egy bolt termékeinek listája csökkenő időrendi sorrendben
	 *
	 * @param string  $sPermalink   A bolt permalinkje
	 * @param integer $iLimit       A találatok száma. Ha nincs megadva, akkor az összeset visszaadja
	 *
	 * @return array
	 */
	public function getNewList($sPermalink, $iLimit=0) {
		$sQueryLimit = empty($iLimit) ? '' : "LIMIT 0, :iLimit";
		return $this->rConnection->getList("
			SELECT product.*,	shop.permalink AS shop_permalink, category.permalink AS category_permalink, product_photo.filename AS photo_filename, product_photo.id_photo
			FROM product
			INNER JOIN category
			ON product.id_category = category.id_category
			INNER JOIN shop
			ON category.id_shop = shop.id_shop
			LEFT JOIN product_photo
			ON product.id_product = product_photo.id_product
			WHERE shop.permalink = :sPermalink
			AND (product_photo.order = 0 OR product_photo.order IS NULL)
			ORDER BY id_product
			DESC
			{$sQueryLimit}
		", array(
				'sPermalink' => $sPermalink,
				'iLimit' => $iLimit
			)
		);
	}

	/**
	 * Egy bolt ajánlóban szereplő termékeinek listája
	 *
	 * @param string  $sPermalink   A bolt permalinkje
	 * @param integer $iLimit       A találatok száma. Ha nincs megadva, akkor az összeset visszaadja
	 *
	 * @return array
	 */
	public function getFeaturedList($sPermalink, $iLimit=0) {
		$sQueryLimit = empty($iLimit) ? '' : "LIMIT 0, :iLimit";
		return $this->rConnection->getList("
			SELECT product.*,	shop.permalink AS shop_permalink, category.permalink AS category_permalink, product_photo.filename AS photo_filename, product_photo.id_photo
			FROM product
			INNER JOIN category
			ON product.id_category = category.id_category
			INNER JOIN shop
			ON category.id_shop = shop.id_shop
			LEFT JOIN product_photo
			ON product.id_product = product_photo.id_product
			WHERE shop.permalink = :sPermalink
			AND is_featured = 'y'
			AND (product_photo.order = 0 OR product_photo.order IS NULL)
			ORDER BY id_product
			DESC
			{$sQueryLimit}
			", array(
				'sPermalink' => $sPermalink,
				'iLimit' => $iLimit
			)
		);
	}

	/**
	 * Egy bolt akciós termékeinek listája
	 *
	 * @param string  $sPermalink   A bolt permalinkje
	 * @param integer $iLimit       A találatok száma. Ha nincs megadva, akkor az összeset visszaadja
	 *
	 * @return array
	 */
	public function getSaleList($sPermalink, $iLimit=0) {
		$sQueryLimit = empty($iLimit) ? '' : "LIMIT 0, :iLimit";
		return $this->rConnection->getList("
			SELECT product.*,	shop.permalink AS shop_permalink, category.permalink AS category_permalink, product_photo.filename AS photo_filename, product_photo.id_photo
			FROM product
			INNER JOIN category
			ON product.id_category = category.id_category
			INNER JOIN shop
			ON category.id_shop = shop.id_shop
			LEFT JOIN product_photo
			ON product.id_product = product_photo.id_product
			WHERE shop.permalink = :sPermalink
			AND is_sale = 'y'
			AND (product_photo.order = 0 OR product_photo.order IS NULL)
			ORDER BY id_product
			DESC
			{$sQueryLimit}
			", array(
				'sPermalink' => $sPermalink,
				'iLimit' => $iLimit
			)
		);
	}

	/**
	 * Egy termék adatai
	 *
	 * @param  integer  $iIdProduct
	 *
	 * @return array
	 */
	public function getProduct($iIdProduct, $sLanguageIso='') {
		if ($sLanguageIso) {
			$sQuery = "
				SELECT
					product.*,
					product_text.permalink,
					product_text.name,
					product_text.short_description,
					product_text.long_description
				FROM product
				INNER JOIN product_text
				ON product.id_product = product_text.id_product
				INNER JOIN language
				ON product_text.id_language = language.id_language
				WHERE product.id_product = :0
				AND language.iso = :1
			";
		}
		else {
			$sQuery = "
				SELECT *
				FROM product
				WHERE id_product = :0
			";
		}

		return $this->rConnection->getRow($sQuery, func_get_args());
	}

	/**
	 * Egy termék szöveges adatai a megadott nyelven (név, permalink, rövid leírás, hosszú leírás)
	 *
	 * @param  integer  $iIdProduct
	 * @param  integer  $iIdLanguage
	 *
	 * @return array
	 */
	public function getText($iIdProduct, $iIdLanguage) {
		return $this->rConnection->getRow("
			SELECT *
			FROM product_text
			WHERE id_product = :0
			AND id_language = :1
		", func_get_args());
	}

	/**
	 * Egy termék adatai az összes kapcsolódó infoval (kategória és shop) együtt
	 *
	 * @param  integer  $iIdProduct
	 *
	 * @return array
	 */
	public function getProductFull($iIdProduct, $xLanguage=NULL) {
		// Ha meg van adva language paraméter, akkor visszaadja a szöveges tartalmakat is
		// Ha az xLanguage>0, akkor id-t tartalmaz a paraméter
		// Különben ISO-ként értelmezzük
		if ($xLanguage) {
				$sSelectLang = "
					product_text.name,
					product_text.permalink,
					product_text.short_description,
					product_text.long_description,
					category_text.name AS category_name,
					category_text.permalink AS category_permalink,
				";
				$sJoinLang = "
					INNER JOIN product_text
					ON product.id_product = product_text.id_product
					INNER JOIN category_text
					ON category.id_category = category_text.id_category
					INNER JOIN language
					ON (language.id_language=product_text.id_language AND language.id_language=category_text.id_language)
				";
			if ($xLanguage>0) $sWhereLang = "AND language.id_language = :1";
			else $sWhereLang = "AND language.iso = :1";
		} else {
				$sSelectLang = '';
				$sJoinLang = '';
				$sWhereLang = '';
		} 
		return $this->rConnection->getRow("
			SELECT
				{$sSelectLang}
				product.*,
				category.id_shop,
				shop.permalink AS shop_permalink,
				shop.name AS shop_name,
				product_photo.filename AS photo_filename,
				product_photo.id_photo AS photo_id_photo
			FROM product
			INNER JOIN category
			ON product.id_category = category.id_category
			INNER JOIN shop
			ON category.id_shop = shop.id_shop
			LEFT JOIN product_photo
			ON product.id_product = product_photo.id_product
			{$sJoinLang}
			WHERE product.id_product = :0
			AND (product_photo.order = 0 OR product_photo.order IS NULL)
			{$sWhereLang}
		", func_get_args());
	}

	/**
	 * Egy termék adatainak lekérdezése a permalinkje és a kategória azonosító alapján
	 * A permalink csak egy kategórián belül egyedi, ezért van szükség a kategória id-ra
	 *
	 * @param  integer  $iIdProduct
	 *
	 * @return array
	 */
	public function getProductByPermalink($iIdCategory, $iIdLanguage, $sPermalink) {
		return $this->rConnection->getRow('
			SELECT product.*, product_photo.filename AS photo_filename
			FROM product
			INNER JOIN product_text
			ON product_text.id_product = product.id_product
			LEFT JOIN product_photo
			ON product.id_product = product_photo.id_product
			WHERE product.id_category = :0
			AND product_text.id_language = :1
			AND product_text.permalink = :2
			AND (product_photo.order = 0 OR product_photo.order IS NULL)
		', func_get_args());
	}

	/**
	 * Egy termék adatainak lekérdezése
	 * 	 a bolt és a termék permalinkje alapján
	 * 	 vagy	 
	 * 	 a bolt, a lategoria és a termék permalinkje alapján
	 *
	 * @param  string  $sPermalinkShop
	 * @param  string  $sPermalink1      A kategoria, vagy a termek permalinkje
	 * @param  string  $sPermalink2      A termek permalinkje (ha a permalink1-ben a kategoria permalink erkezik)
	 *
	 * @return array
	 */
	public function getProductByPermalinks($sPermalinkShop, $sPermalink1, $sPermalink2='') {
		if (empty($sPermalink2)) {
			return $this->rConnection->getRow("
				SELECT
					product.*,
					product_text.*,
					category_text.name AS category_name,
					category_text.permalink AS category_permalink,
					product_photo.filename AS photo_filename,
					product_photo.id_photo AS photo_id_photo,
					language.iso AS language_iso
				FROM product
				INNER JOIN product_text
				ON product.id_product = product_text.id_product
				INNER JOIN category
				ON product.id_category = category.id_category
				INNER JOIN category_text
				ON category.id_category = category_text.id_category
				INNER JOIN language
				ON (language.id_language=product_text.id_language AND language.id_language=category_text.id_language)
				INNER JOIN shop
				ON category.id_shop = shop.id_shop
				LEFT JOIN product_photo
				ON product.id_product = product_photo.id_product
				WHERE shop.permalink = :0
				AND product_text.permalink = :1
				AND (product_photo.order = 0 OR product_photo.order IS NULL)
			", func_get_args());
		}
		else {
			return $this->rConnection->getRow("
				SELECT
					product.*,
					product_text.*,
					category_text.name AS category_name,
					category_text.permalink AS category_permalink,
					product_photo.filename AS photo_filename,
					product_photo.id_photo AS photo_id_photo,
					language.iso AS language_iso
				FROM product
				INNER JOIN product_text
				ON product.id_product = product_text.id_product
				INNER JOIN category
				ON product.id_category = category.id_category
				INNER JOIN category_text
				ON category.id_category = category_text.id_category
				INNER JOIN language
				ON (language.id_language=product_text.id_language AND language.id_language=category_text.id_language)
				INNER JOIN shop
				ON category.id_shop = shop.id_shop
				LEFT JOIN product_photo
				ON product.id_product = product_photo.id_product
				WHERE shop.permalink = :0
				AND category_text.permalink = :1
				AND product_text.permalink = :2
				AND (product_photo.order = 0 OR product_photo.order IS NULL)
			", func_get_args());
		}
	}

	/**
	 * Egy kategória termékeinek lekérdezése, szűrése
	 *
	 * @param  integer  $iIdCategory  A kategória azonosítója
	 * @param  array    $aFilter      A szűrők listája:
	 *                                A tömb kulcsai a property azonosítói,
	 *                                az értékek a product_property_value.id_value-k
	 *                                (Amelyik propertynél nincs beikszelve semmilyen érték, arra nem szűr,
	 *                                mert a tömbben nem lesz olyan kulcs)
	 *
	 * @return array
	 */
	public function getProductListByIdCategory($iIdCategory, $sLanguageIso, $aFilter=array()) {
		if (!empty($aFilter)) {
			$sQueryFilter = '';
			foreach ($aFilter as $iIdProperty=>$aValueList) {
				$sQueryFilter .= "
					AND product.id_product
					IN (
						SELECT product.id_product
						FROM product
						INNER JOIN product_property_value
						ON product.id_product = product_property_value.id_product
						WHERE id_value
						IN
							(".implode(',', $aValueList).")
					)
				";
			}
		}
		else $sQueryFilter = '';

		return $this->rConnection->getList("
			SELECT
				product.*,
				product_text.*,
				category_text.permalink AS category_permalink,
				category_text.name AS category_name,
				product_photo.filename AS photo_filename,
				product_photo.id_photo AS photo_id_photo
			FROM product
			INNER JOIN product_text
			ON product.id_product=product_text.id_product
			INNER JOIN category
			ON category.id_category = product.id_category
			INNER JOIN category_text
			ON category.id_category = category_text.id_category
			INNER JOIN language
			ON product_text.id_language=language.id_language AND category_text.id_language=language.id_language
			INNER JOIN product_photo
			ON product.id_product = product_photo.id_product
			WHERE product.id_category = :0
			AND product.is_active = 'y'
			AND language.iso = :1
			AND (product_photo.order = 0 OR product_photo.order IS NULL)
			{$sQueryFilter}
		", func_get_args());
	}

	/**
	 * Termék törlése
	 *
	 * @param  integer  $iIdProduct
	 *
	 * @return void
	 */
	public function deleteProduct($iIdProduct) {
		$this->rConnection->execute("
			DELETE FROM
				product
			WHERE
				product.id_product=:iIdProduct
			", array(
				'iIdProduct' => $iIdProduct
			)
		);
	}

	/**
	 * Létrehoz egy terméket
	 *
	 * @param  integer  $iIdCategory        A kategória azonosítója amihez a termék tartozik
	 * @param  string   $sIsFeatured        Része az ajánlónak ('y', vagy 'n')
	 * @param  string   $sIsSale            Akciós termék ('y', vagy 'n')
	 * @param  integer  $iPrice             Ár
	 * @param  integer  $iQuantity          Raktárkészlet mennyiség. Ha '', akkor NULL lesz tarolva
	 *
	 * @return array    A termék azonosítója
	 */
	public function insertProduct($iIdCategory, $sIsFeatured, $sIsSale, $iPrice, $sBarcode, $sProductCode, $iQuantity = NULL, $iSupplier = NULL, $sIsActive = NULL) {
		$sFields = 'id_category, is_featured, is_sale, price, barcode, product_code';
		$sValues = ':0, :1, :2, :3, :4, :5';

		$iFieldId = 6;
		if (isset($iQuantity)) {
			$sFields .= ', quantity';
			$sValues .= ", :{$iFieldId}";
			$iFieldId ++;
		} 
		if (isset($iQuantity)) {
			$sFields .= ', id_supplier';
			$sValues .= ", :{$iFieldId}";
			$iFieldId ++;
		}
		if (isset($iQuantity) && is_numeric($iQuantity)) {
			$sFields .= ', is_active';
			$sValues .= ", :{$iFieldId}";
			$iFieldId ++;
		}

		return $this->rConnection->insert("
			INSERT INTO product (
				{$sFields}
			)
			VALUES ({$sValues})
		", func_get_args());
	}

	public function reduceQuantity($iIdProduct, $iQuantity) {
		return $this->rConnection->execute('
			UPDATE product
			SET quantity = quantity - :1
			WHERE id_product = :0
		', func_get_args());
	}

	/**
	 * Módosítja a termékhez tartozó szövegeket a megadott nyelven
	 *
	 * @param  integer  $iIdProduct         A termék azonosítója
	 * @param  integer  $iIdLanguage        A nyelv azonosítója
	 * @param  string   $sPermalink         A termék permalinkje
	 * @param  string   $sName              A termék neve
	 * @param  string   $sShortDescription  Rövid leírás a termékről. Ez jelenik meg a keresőben a termék linkjén
	 * @param  string   $sLongDescription   Hosszú leírás a termékről.
	 */
	public function replaceText($iIdProduct, $iIdLanguage, $sPermalink, $sName, $sShortDescription, $sLongDescription) {
		return $this->rConnection->insert('
			REPLACE INTO product_text (id_product, id_language, permalink, name, short_description, long_description)
			VALUES (:0, :1, :2, :3, :4, :5)
		', func_get_args());
	}

	/**
	 * Módosítja egy termék adatait
	 *
	 * @param  integer  $iIdProduct         A termék azonosítója
	 * @param  integer  $iIdCategory        A kategória azonosítója amihez a termék tartozik
	 * @param  string   $sIsFeatured        Része az ajánlónak ('y', vagy 'n')
	 * @param  string   $sIsSale            Akciós termék ('y', vagy 'n')
	 * @param  integer  $iPrice             Ár
	 * @param  integer  $iQuantity          Raktárkészlet mennyiség
	 */
	public function updateProduct($iIdProduct, $iIdCategory, $sIsFeatured, $sIsSale, $iPrice, $sBarcode, $sProductCode, $iQuantity, $iIdSupplier, $sIsActive) {
		$this->rConnection->execute('
			UPDATE product
			SET
				id_category = :1,
				is_featured = :2,
				is_sale = :3,
				price = :4,
				barcode = :5,
				product_code = :6,
				'. (is_numeric($iQuantity) ? 'quantity = :7,' : 'quantity = NULL,').'
				id_supplier = :8,
				is_active = :9
			WHERE id_product = :0
		', func_get_args());
	}

	/**
	 * Egy termék összes property értékének a törlése
	 *
	 * @param  integer  $iIdProduct
	 */
	public function unlinkPropertyValues($iIdProduct) {
		$this->rConnection->execute("
			DELETE FROM
				product_property_value
			WHERE
				id_product=:iIdProduct
		", array(
				'iIdProduct' => $iIdProduct
			)
		);
	}

	/**
	 * Egy termék összes property értékének a törlése
	 *
	 * @param  integer  $iIdProduct
	 * @param  array    $aIdPropertyValueList  Az értékek listája
	 *
	 * @return void
	 */
	public function linkPropertyValueList($iIdProduct, $aIdPropertyValueList) {
		$aIdPropertyValueList = array_unique($aIdPropertyValueList);
		$aQueryValues = array();
		foreach ($aIdPropertyValueList as $iIdPropertyValue) {
			$aQueryValues[] = "({$iIdProduct}, {$iIdPropertyValue})";
		}
		$sQueryValues = implode(', ', $aQueryValues);

		$this->rConnection->execute("
			INSERT INTO
				product_property_value
			VALUES
				{$sQueryValues}
		");
	}

	/**
	 * Egy termékhez hozzárendelt property értékek listája
	 *
	 * @param  integer  $iIdProduct
	 * @param  array    $aIdPropertyValueList  Az értékek azonosítóinak listája
	 *
	 * @return array
	 */
	public function getLinkedPropertyValueList($iIdProduct, $sLanguageIso) {
		return $this->rConnection->getList("
			SELECT
				product_property_value.*,
				property_value_text.value AS value_name,
				property.id_property AS id_property,
				property_text.name AS property_name
			FROM product_property_value
			INNER JOIN property_value
			ON product_property_value.id_value = property_value.id_value
			INNER JOIN property_value_text
			ON property_value.id_value = property_value_text.id_property_value
			INNER JOIN property
			ON property_value.id_property = property.id_property
			INNER JOIN property_text
			ON property.id_property = property_text.id_property
			INNER JOIN language
			ON property_text.id_language = language.id_language AND property_value_text.id_language = language.id_language 
			WHERE id_product = :0
			AND language.iso = :1
		", func_get_args());
	}

	/**
	 * Egy termékhez hozzárendelt fizetési metódusok törlése
	 *
	 * @param  integer  $iIdProduct
	 */
	public function unlinkPaymentMethods($iIdProduct) {
		$this->rConnection->execute("
			DELETE FROM product_payment_method
			WHERE id_product=:0
		", func_get_args());
	}

	/**
	 * Hozzárendel egy termékhez egy fizetési metódust
	 *
	 * @param  integer  $iIdProduct, $iIdPaymentMethod
	 */
	public function linkPaymentMethod($iIdProduct, $iIdPaymentMethod, $iPrice) {
		if (!$iPrice) $iPrice = 0;
		$this->rConnection->execute("
			INSERT INTO product_payment_method
			VALUES (:0, :1, :2)
		", func_get_args());
	}

	/**
	 * Egy termékhez hozzárendelt szállítási metódusok törlése
	 *
	 * @param  integer  $iIdProduct
	 */
	public function unlinkShippingMethods($iIdProduct) {
		$this->rConnection->execute("
			DELETE FROM product_shipping_method
			WHERE id_product=:0
		", func_get_args());
	}

	/**
	 * Hozzárendel egy termékhez egy szállítási metódust
	 *
	 * @param  integer  $iIdProduct, $iIdShippingMethod
	 */
	public function linkShippingMethod($iIdProduct, $iIdShippingMethod, $iPrice) {
		if (!$iPrice) $iPrice = 0;
		$this->rConnection->execute("
			INSERT INTO product_shipping_method
			VALUES (:0, :1, :2)
		", func_get_args());
	}
}
?>