<?php
class PageDao extends Dao {
	/**
	 * Oldal létrehozása
	 * 
	 * sIdSite        A site azonosítója (pl. www, travel-microsite, stb)
	 * sPermalink     Az oldalhoz tartozó path	 
	 * iIdCategory    Az oldalhoz kategóriájának az azonosítója (nem kötelező kategorizálni, lehet 0 is)	 
	 */  
	public function insertPage($sIdSite, $sPermalink, $iIdCategory=0) {
		return $this->rConnection->insert("
			INSERT INTO page (id_site, permalink, id_category, last_update)
			VALUES (:0, :1, " . ( $iIdCategory ? ":2" : "NULL" ) . ", NOW())
		", func_get_args());
	}

	/**
	 * Oldal törlése
	 * 
	 * sIdSite        A site azonosítója (pl. www, travel-microsite, stb)
	 * sPermalink     Az oldalhoz tartozó path	 
	 */  
	public function deletePage($iIdPage) {
		return $this->rConnection->insert("
			DELETE FROM page
			WHERE id_page = :0
		", func_get_args());
	}

	/**
	 * Oldal módosítása
	 * 
	 * iIdPage        Az oldal azonosítója
	 * sPermalink     Az oldalhoz tartozó path
	 * sIsPublic      Publikus oldal ('y' / 'n'). Ha publikus, akkor szerepel a sitemap-ben, es letezik az url-je:
	 *                  www.example.com/public-page/  -> 200
	 *                  www.example.com/private-page/ -> 404	 	 	 
	 * iIdCategory    Az oldalhoz kategóriájának az azonosítója (nem kötelező kategorizálni, lehet 0 is)	 
	 */  
	public function updatePage($sIdPage, $sPermalink, $sIsPublic = 'y', $iIdCategory=0) {
		return $this->rConnection->execute("
			UPDATE page
			SET
				permalink=:1,
				is_public=:2,
				id_category=" . ( $iIdCategory ? ":3" : "NULL" ) . ",
				last_update=NOW()
			WHERE id_page=:0
		", func_get_args());
	}

	/**
	 * Oldalak listája
	 * 
	 * sIdSite        A site azonosítója (pl. www, travel-microsite, stb)
	 */  
	public function getPageList($aOrderList='', $aFilterList='', $iLimit=0, $iPage=1, $bIncludeDistinctValues=FALSE) {
		$aForeignKeys = array(
			'category_name' => 'page_category.name',
		);
		
		$sQOrder = self::parseOrderList($aOrderList, $aForeignKeys);
		$sWhFilter = self::parseFilterList($aFilterList, $aForeignKeys);
		$sWhere = empty($sWhFilter) ? '' : "WHERE ".$sWhFilter;
		$sQLimit = empty($iLimit) ? '' : " LIMIT ".($iPage-1)*$iLimit.", {$iLimit}";

		$iRowCount = $this->rConnection->getValue("
			SELECT COUNT(*), page_category.name AS category_name
			FROM page
			LEFT JOIN page_category
			ON page_category.id_category = page.id_category
		".$sWhere);
		$aData = $this->rConnection->getList("
			SELECT page.*, page_category.name AS category_name
			FROM page
			LEFT JOIN page_category
			ON page_category.id_category = page.id_category
		".$sWhere.$sQOrder.$sQLimit);

    $aDistinct = array();
		if ($bIncludeDistinctValues) {
			$aDistinct['id_site'] = $this->rConnection->getValueList("SELECT DISTINCT id_site FROM page");
			$aDistinct['category_name'] = $this->rConnection->getValueList("SELECT DISTINCT name AS category_name FROM page_category");
		}

		return array(
			'rowcount' => $iRowCount,
			'pagecount' => self::calcPageCount($iRowCount, $iLimit),
			'list' => $aData,
			'distinct' => $aDistinct
		);
	}

	/**
	 * Tartalom felvitele. Ha még nem létezik az adatbázisban, akkor létrehozza
	 * 
	 * sIdSite        Az site azonosítója (pl. www, travel-microsite, stb)
	 * sPermalink     Az oldalhoz tartozó path (pl. ajanlataink/kepzesek)
	 * sRegionName	  Az oldalon belüli régió (pl. title, lead, body)
	 * sContent       A szöveges tartalom
	 */  
	public function replaceContent($iIdPage, $iIdRegion, $sContent) {
		$this->rConnection->execute("
			REPLACE INTO page_content (id_page, id_region, content)
			VALUES (:0, :1, :2)
		", func_get_args());
	}

	/**
	 * A weboldal régióinak listája (pl. title, lead, body)
	 */	 
	public function getRegionList($sIdSite) {
		return $this->rConnection->getList("
			SELECT *
			FROM page_region
			WHERE id_site=:0
		", func_get_args());
	}

	/**
	 * Az oldalhoz tartozó szöveges tartalmak listája (pl. title, lead, body mezők tartalma)
	 */	 
	public function getContentList($iIdPage) {
		return $this->rConnection->getList("
			SELECT *
			FROM page_content
			WHERE id_page=:0
		", func_get_args());
	}

	/**
	 * 
	 */	 
	public function getPage($iIdPage) {
		return $this->rConnection->getRow("
			SELECT *
			FROM page
			WHERE id_page=:0
		", func_get_args());
	}

	/**
	 * 
	 */	 
	public function getPageFromPermalink($sIdSite, $sPermalink) {
		return $this->rConnection->getRow("
			SELECT *
			FROM page
			WHERE id_site = :0
			AND permalink = :1
		", func_get_args());
	}

	/**
	 * 
	 */	 
	public function getContentListFromPath($sIdSite, $sPermalink) {
		return $this->rConnection->getList("
			SELECT page.*, page_content.*, page_region.name AS region_name
			FROM page
			INNER JOIN page_content
			ON page.id_page = page_content.id_page 
			INNER JOIN page_region
			ON page_content.id_region = page_region.id_region 
			WHERE page.id_site = :0
			AND page.permalink = :1
		", func_get_args());
	}

	/**
	 * 
	 */	 
	public function getContent($sIdSite, $sPermalink, $sRegionName) {
		return $this->rConnection->getRow("
			SELECT page_content.*
			FROM page_content
			INNER JOIN page
			ON page.id_page = page_content.id_page 
			INNER JOIN page_region
			ON page_content.id_region = page_region.id_region 
			WHERE page.id_site = :0
			AND page.permalink = :1
			AND page_region.name = :2
		", func_get_args());
	}
/*
	public function getPageList($iIdSite) {
	}
	   */

	/**
	 * Kategória létrehozása
	 * 
	 * sIdSite     A site azonosítója (pl. www, travel-microsite, stb)
	 * sName       Az oldalhoz tartozó path	 
	 */  
	public function insertCategory($sIdSite, $sName) {
		return $this->rConnection->insert("
			INSERT INTO page_category (id_site, name)
			VALUES (:0, :1)
		", func_get_args());
	}

	/**
	 * Kategória törlése
	 * 
	 * iIdCategory    A kategória azonosítója
	 */  
	public function deleteCategory($iIdCategory) {
		return $this->rConnection->insert("
			DELETE FROM page_category
			WHERE id_category = :0
		", func_get_args());
	}

	/**
	 * Kategória módosítása
	 * 
	 * iIdCategory    A kategória azonosítója
	 * sName          A kategória neve	 
	 */  
	public function updateCategory($iIdCategory, $sName) {
		return $this->rConnection->execute("
			UPDATE page_category
			SET name=:1
			WHERE id_page=:0
		", func_get_args());
	}

	/**
	 * Kategóriák listája
	 * 
	 * sIdSite        A site azonosítója (pl. www, travel-microsite, stb)
	 */  
	public function getCategoryList($sIdSite, $aOrderList='', $aFilterList='', $iLimit=0, $iPage=1, $bCountOnly = false) {
		$sQOrder = self::parseOrderList($aOrderList);
		$sWhFilter = self::parseFilterList($aFilterList);
		$sWhere = empty($sWhFilter) ? '' : " AND ".$sWhFilter;
		$sQLimit = empty($iLimit) ? '' : " LIMIT ".($iPage-1)*$iLimit.", {$iLimit}";

		$iRowCount = $this->rConnection->getValue("SELECT COUNT(*) FROM page_category WHERE id_site=:0".$sWhere, func_get_args());
		$aData = $this->rConnection->getList("SELECT * FROM page_category WHERE id_site=:0".$sWhere.$sQOrder.$sQLimit, func_get_args());

		return array(
			'rowcount' => $iRowCount,
			'pagecount' => self::calcPageCount($iRowCount, $iLimit),
			'list' => $aData,
		);
	}
}
?>