<?php
class MenuModule extends Module {
	protected function _access($function) {
		$oUserauth =& ModuleFactory::getModule('userauth');
		return $oUserauth->access('stock_admin');
	}
	
	public function path() {
		return array(
			'menu' => array(
				'method' => 'default'
			),
			'menu/list' => array(
				'method' => 'list'
			),
			'menu/add' => array(
				'method' => 'add'
			),
			'menu/edit' => array(
				'method' => 'edit'
			),
			'menu/del' => array(
				'method' => 'del'
			),
		);
	}

	/**
	 * Menu szerkesztése
	 */ 	  	 	 	
	protected function _reqAdd() {
		$oMenuDao =& DaoFactory::getDao('menu'); 
		return Output::render('menu_add', getLayoutVars(), 'blank');
	}
	
	/**
	 * Menu szerkesztése
	 */ 	  	 	 	
	protected function _reqEdit($iIdMenu) {
		$oMenuDao =& DaoFactory::getDao('menu');
		
		$aMenu = $oMenuDao->getMenu($iIdMenu);
		
		return Output::render('menu_edit', getLayoutVars() + array(
			'menu' => $aMenu,
		), 'blank');

	}
	
	protected function _reqDel($iIdMenu) {
		$oMenuDao =& DaoFactory::getDao('menu');
		return Output::render('menu_del', getLayoutVars() + array(
			'menu' => $oMenuDao->getMenu($iIdMenu),
			'id_menu' => $iIdMenu
		), 'blank');
	}

	protected function _reqDefault() {
		$aVars = Request::getRequestVars();
		switch (Request::getRequestMethod()) {
			case 'GET':
				return Output::render('menu', getLayoutVars() );
				break;
			case 'POST':
				$aRequiredVars = array('name');
				if (array_keys_exists($aRequiredVars, $aVars)) return $this->_wsAdd($aVars);
				return Output::json(array('error'=>'invalid_webservice_call'));
				break;
			case 'PUT':
				$aRequiredVars = array('id_menu', 'name');
				if (array_keys_exists($aRequiredVars, $aVars)) return $this->_wsEdit($aVars);
				return Output::json(array('error'=>'invalid_webservice_call'));
				break;
			case 'DELETE':
				$aRequiredVars = array('id_menu');
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
	protected function _reqList() {
		$oMenuDao =& DaoFactory::getDao('menu');
		$aVars = Request::getRequestVars();

		return Output::json($oMenuDao->getMenuList($aVars['order'], $aVars['filter'], $aVars['limit'], $aVars['page'], true));
	}

	private function _wsAdd($aVars) {
		$aRes['error'] = array();
	
		$oMenuDao =& DaoFactory::getDao('menu');
		
		// Kötelezően kitöltendő mező(k)
		if (empty($aVars['name'])) {
			$aRes['error'][] = 'empty_name';
			return Output::json($aRes);
		}

		// Unique mező(k) ellenőrzése
		$aMenu = $oMenuDao->getMenuFromName($aVars['name']);
		if (!empty($aMenu)) {
			$aRes['error'][] = 'already_exists';
			return Output::json($aRes);
		}
		
		// Beírás az adatbázisba
		$aRes['id_menu'] = $oMenuDao->insertMenu($aVars['name']);
	
		return Output::json($aRes);
	}

	private function _wsEdit($aVars) {
		$aRes['error'] = array();
	
		$oMenuDao =& DaoFactory::getDao('menu');
		$aMenu = $oMenuDao->getMenu($aVars['id_menu']);

		// Adatok beírása az adatbázisba
		$oMenuDao->updateMenu($aVars['id_menu'], $aVars['name']);

		return Output::json($aRes);
	}

	private function _wsDel($aVars) {
		$aRes['error'] = array();
	
		$oMenuDao =& DaoFactory::getDao('menu');

		$oMenuDao->deleteMenu($aVars['id_menu']);
	
		return Output::json($aRes);
	}
}
?>