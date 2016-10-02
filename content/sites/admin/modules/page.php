<?php
class PageModule extends Module {
	protected function _access($function) {
		$oAuth =& ModuleFactory::getModule('userauth');
		return $oAuth->isLoggedIn();
	}
	
	public function path() {
		return array(
			'page' => array(
				'method' => 'default'
			),
			'page/list' => array(
				'method' => 'list'
			),
			'page/add' => array(
				'method' => 'add'
			),
			'page/edit' => array(
				'method' => 'edit'
			),
			'page/del' => array(
				'method' => 'del'
			),
		);
	}

	/**
	 * Page szerkesztése
	 */ 	  	 	 	
	protected function _reqAdd($sIdSite='www') {
		$oPageDao =& DaoFactory::getDao('page'); 
		$aCategoryList = $oPageDao->getCategoryList($sIdSite);
		return Output::render('page_add', getLayoutVars() + array(
			'id_site' => $sIdSite,
			'categorylist' => $aCategoryList['list'],
		), 'blank');
	}
	
	/**
	 * Page szerkesztése
	 *	 	
	 * A függvény több paramétert is kap, de az sIdSite utáni paraméterekre egy darabban lesz szükség
	 * Pl page/edit/www/valami/hosszu/page/utvonal
	 * Itt az sIdSite a "www", az sPage pedig a "valami/hosszu/page/utvonal" lesz
	 */ 	  	 	 	
	protected function _reqEdit($iIdPage) {
		$oPageDao =& DaoFactory::getDao('page');
		
		// Oldal alapadatai (id, permalink)
		$aPage = $oPageDao->getPage($iIdPage);
		
		// A sitehoz tartozó kategóriák listája
		$aCategoryList = $oPageDao->getCategoryList($aPage['id_site']);

		// A sitehoz tartozó régiók listája
		$aRegionList = $oPageDao->getRegionList($aPage['id_site']);
		
		// Az oldalhoz tartozó tartalmak listája
		$aContentList = $oPageDao->getContentList($iIdPage);
		
		return Output::render('page_edit', getLayoutVars() + array(
			'categorylist' => $aCategoryList['list'],
			'id_page' => $iIdPage,
			'page' => $aPage,
			'regionlist' => $aRegionList,
			'contentlist' => $aContentList,
		), 'blank');

/*
		// $iIdSite-hoz tartozó page lista beolvasása az interfaceről
		foreach ($GLOBALS['sites'] as $sUrl=>$aSite) {
			if ($aSite['id_site'] == $sIdSite) $aSiteconfig = $aSite+array('site_url' => $sUrl);
		}
		$aPagesFromInterface = array();
		$aFileList = scandir(DIR_CONTENT.'/sites/'.$sIdSite.'/modules');
		foreach ($aFileList as $sFileName) {
			if (preg_match('#([^\.|\.\.$]+).php#i', $sFileName, $aFileNameParts)) {
				$sInterfacePath = $aSiteconfig['site_url'].'/interface/page/'.$aFileNameParts[1];
				$sHeaders = @get_headers($sInterfacePath);
				if (strpos($sHeaders[0], '200') !== FALSE) {
					$sPathEncoded = file_get_contents($sInterfacePath);
					$aPagesFromInterface += json_decode($sPathEncoded, TRUE);
				}
			}
		}

		return Output::render('page_edit', getLayoutVars() + array(
			'id_site' => $sIdSite,
			'pageinfo' => $aPagesFromInterface[$sIdContent]
		), 'blank');
*/
	}
	
	protected function _reqDel($iIdPage) {
		$oPageDao =& DaoFactory::getDao('page');
		return Output::render('page_del', getLayoutVars() + array(
			'page' => $oPageDao->getPage($iIdPage),
			'id_page' => $iIdPage
		), 'blank');
	}

	/**
	 * A szöveges tartalmakkal kapcsolatos webszolgáltatások
	 *   GET    /page                   Rendereli az page admin főoldalát
	 *   PUT    /page                   Létrehoz/módosít egy page-t (id_site, page)
	 *   DELETE /page/{id_page)         Törli az page-t (id_page)
	 *
	 * @return string|json           GET esetén a generált oldal tartalma
	 *                               PUT / POST / DELETE esetén a feldolgozás közben bekövetkező hibák
	 */
	protected function _reqDefault($sIdSite='') {
		$aVars = Request::getRequestVars();
		switch (Request::getRequestMethod()) {
			case 'GET':
				return Output::render('page', getLayoutVars() + array(
					'sites' => $GLOBALS['sites']
				));
				break;
			case 'POST':
				$aRequiredVars = array('id_site', 'permalink');
				if (array_keys_exists($aRequiredVars, $aVars)) return $this->_wsAdd($aVars);
				return Output::json(array('error'=>'invalid_webservice_call'));
				break;
			case 'PUT':
				$aRequiredVars = array('id_page', 'permalink');
				if (array_keys_exists($aRequiredVars, $aVars)) return $this->_wsEdit($aVars);
				return Output::json(array('error'=>'invalid_webservice_call'));
				break;
			case 'DELETE':
				$aRequiredVars = array('id_page');
				if (array_keys_exists($aRequiredVars, $aVars)) return $this->_wsDel($aVars);
				return Output::json(array('error'=>'invalid_webservice_call'));
				break;
			default:
				return Output::json(array('error'=>'invalid_webservice_call'));
				break;
		}
	}
	
	/**
	 * A megadott siteon belüli oldalak listája
	 * 
	 */	 	 	 	                                                                                                                              
	protected function _reqList($sIdSite='www') {
		$oPageDao =& DaoFactory::getDao('page');
		$aVars = Request::getRequestVars();

		return Output::json($oPageDao->getPageList($aVars['order'], $aVars['filter'], $aVars['limit'], $aVars['page'], true));
	}

	private function _wsAdd($aVars) {
		$aRes['error'] = array();
	
		$oPageDao =& DaoFactory::getDao('page');
		
/*
		// Kötelezően kitöltendő mező(k): a permalinket nem kotelezo kitolteni, mert a fooldal az ures permalink
		if (empty($aVars['permalink'])) {
			$aRes['error'][] = 'empty_permalink';
			return Output::json($aRes);
		}
*/

		// Unique mező(k) ellenőrzése
		$aPage = $oPageDao->getPageFromPermalink($aVars['id_site'], $aVars['permalink']);
		if (!empty($aPage)) {
			$aRes['error'][] = 'already_exists';
			return Output::json($aRes);
		}
		
		// Kategória létrehozása, ha szükséges
		if (!empty($aVars['new_category'])) $aVars['id_category'] = $oPageDao->insertCategory($aVars['id_site'], $aVars['new_category']);
		
		// Beírás az adatbázisba
		$aRes['id_page'] = $oPageDao->insertPage($aVars['id_site'], $aVars['permalink'], $aVars['id_category']);
	
		return Output::json($aRes);
	}

	private function _wsEdit($aVars) {
		$aRes['error'] = array();
	
		$oPageDao =& DaoFactory::getDao('page');
		$aPage = $oPageDao->getPage($aVars['id_page']);

		// Kategória létrehozása, ha szükséges
		if (!empty($aVars['new_category'])) $aVars['id_category'] = $oPageDao->insertCategory($aPage['id_site'], $aVars['new_category']);

		// Adatok beírása az adatbázisba
		$oPageDao->updatePage($aVars['id_page'], $aVars['permalink'], $aVars['is_public'], $aVars['id_category']);

		// Szöveges tartalmak beírása az adatbázisba
		$aRegionList = $oPageDao->getRegionList($aPage['id_site']);
		foreach ($aRegionList as $aRegion) {
			if (isset($aVars["content_{$aRegion['id_region']}"])) {
				$oPageDao->replaceContent($aVars['id_page'], $aRegion['id_region'], $aVars["content_{$aRegion['id_region']}"]);
			}
		}
	
		return Output::json($aRes);
	}

	private function _wsDel($aVars) {
		$aRes['error'] = array();
	
		$oPageDao =& DaoFactory::getDao('page');

		$oPageDao->deletePage($aVars['id_page']);
	
		return Output::json($aRes);
	}
}
?>