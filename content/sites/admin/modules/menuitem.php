<?php
class MenuitemModule extends Module {
	protected function _access($function) {
		$oUserauth =& ModuleFactory::getModule('userauth');
		return $oUserauth->access('stock_admin');
	}
	
	public function path() {
		return array(
			'menuitem' => array(
				'method' => 'default'
			),
			'menuitem/list' => array(
				'method' => 'list'
			),
			'menuitem/add' => array(
				'method' => 'add'
			),
			'menuitem/edit' => array(
				'method' => 'edit'
			),
			'menuitem/del' => array(
				'method' => 'del'
			),
		);
	}

	protected function _reqList($iIdMenu) {
		$oMenuDao =& DaoFactory::getDao('menu'); 
		return Output::render('menuitem_list', array(
			'id_menu' => $iIdMenu,
			'menu' => $oMenuDao->getMenu($iIdMenu),
			'itemlist' => $oMenuDao->getAllMenuItem($iIdMenu),
			'itemtree' => $this->_get_menu_tree($iIdMenu)
		), 'blank');
	}

	protected function _reqAdd($iIdMenu) {
		$oMenuDao =& DaoFactory::getDao('menu'); 
		return Output::render('menuitem_add', getLayoutVars() + array(
			'id_menu' => $iIdMenu,
		), 'blank');
	}
	
	protected function _reqEdit($iIdMenuItem) {
		$oMenuDao =& DaoFactory::getDao('menu');
		return Output::render('menuitem_edit',array(
			'menuitem' => $oMenuDao->getMenuItem($iIdMenuItem)
		),0,'blank');
	}
	
	protected function _reqDel($iIdMenuItem) {
		$oMenuDao =& DaoFactory::getDao('menu');
		return Output::render('menuitem_del',array(
			'menuitem' => $oMenuDao->getMenuItem($iIdMenuItem)
		),0,'blank');
	}

	/**
	 * A szöveges tartalmakkal kapcsolatos webszolgáltatások
	 *   GET    /page                   Rendereli az article admin főoldalát
	 *   PUT    /page                   Létrehoz/módosít egy article-t (id_site, page)
	 *   DELETE /page/{id_page)         Törli az article-t (id_article)
	 *
	 * @return string|json           GET esetén a generált oldal tartalma
	 *                               PUT / POST / DELETE esetén a feldolgozás közben bekövetkező hibák
	 */
	protected function _reqDefault($iIdMenu=0) {
		$aVars = Request::getRequestVars();
		switch (Request::getRequestMethod()) {
			case 'GET':
				if ($iIdMenu==0) Request::redirect('/menu');
				return Output::render('menuitem', getLayoutVars() + array(
					'id_menu' => $iIdMenu,
				));
				break;
			case 'POST':
				$aRequiredVars = array('title', 'url');
				if (array_keys_exists($aRequiredVars, $aVars)) return $this->_wsAdd($aVars);
				return Output::json(array('error'=>'invalid_webservice_call'));
				break;
			case 'PUT':
				$aRequiredVars = array('id_menu_item', 'title', 'url');
				if (array_keys_exists($aRequiredVars, $aVars)) return $this->_wsEdit($aVars);
				$aRequiredVars = array('id_menu_item', 'id_parent');
				if (array_keys_exists($aRequiredVars, $aVars)) return $this->_wsSetparent($aVars);
				$aRequiredVars = array('order');
				if (array_keys_exists($aRequiredVars, $aVars)) return $this->_wsSetorder($aVars);
				return Output::json(array('error'=>'invalid_webservice_call'));
				break;
			case 'DELETE':
				$aRequiredVars = array('id_menu_item');
				if (array_keys_exists($aRequiredVars, $aVars)) return $this->_wsDel($aVars);
				return Output::json(array('error'=>'invalid_webservice_call'));
				break;
			default:
				return Output::json(array('error'=>'invalid_webservice_call'));
				break;
		}
	}
	
	private function _wsAdd($aVars) {
		$aRes['error'] = array();
	
		$oMenuDao =& DaoFactory::getDao('menu');
		
		// Kötelezően kitöltendő mező(k)
		if (empty($aVars['title'])) {
			$aRes['error'][] = 'empty_menu_title';
			return Output::json($aRes);
		}

		$id_menu_item = $oMenuDao->insertMenuItem($_POST['id_menu'], $_POST['title'], $_POST['url'], $_POST['is_popup']);
		return Output::json(array('id_menu_item' => $id_menu_item));
	}

	private function _wsEdit($aVars) {
		$aRes['error'] = array();
	
		$oMenuDao =& DaoFactory::getDao('menu');
		
		// Kötelezően kitöltendő mező(k)
		if (empty($aVars['title'])) {
			$aRes['error'][] = 'empty_menu_title';
			return Output::json($aRes);
		}

		$oMenuDao->updateMenuItem($aVars['id_menu_item'], $aVars['title'], $aVars['url'], $aVars['is_popup']);

		return Output::json($aRes);
	}

	private function _wsDel($aVars) {
		$aRes['error'] = array();
	
		$oMenuDao =& DaoFactory::getDao('menu');

		$oMenuDao->deleteMenuItem($aVars['id_menu_item']);
	
		return Output::json($aRes);
	}

	function _wsSetparent($aVars) {
		$aRes['error'] = array();

		$oMenuDao =& DaoFactory::getDao('menu');
	
		$aTv = $oMenuDao->getMenuItem($aVars['id_menu_item']);
		$oMenuDao->setMenuItemParent($aVars['id_menu_item'], $aVars['id_parent']);
		$this->_renumber();
	
		return Output::json($aRes);
	}

	// újra sorszámozza: order szerint lekérdezi, aztán végigmegy a fastruktúrán
	// megjelenítéskor így nem kell felépíteni a fát, csak sorban végigmenni az elemeken
	function _renumber() {
		$oMenuDao =& DaoFactory::getDao('menu');
		$aMenuList = $oMenuDao->getAllMenuItem();
		$iOrder = 0;
		foreach ($aMenuItemList as $aMenuItem) {
			if ($aMenuItem['id_parent'] == 0) {
				$aOrderList[$iOrder++] = $aMenuItem['id_menu_item'];
				foreach ($aMenuItemList as $aSubMenuItem) {
					if ($aSubMenuItem['id_parent'] == $aMenuItem['id_menu_item']) {
						$aOrderList[$iOrder++] = $aSubMenuItem['id_menu_item'];
					}
				}
			}
		}
		$oMenuDao->setMenuItemOrder($aOrderList);
	}

	private function _wsSetorder($aVars) {
		$oMenuDao =& DaoFactory::getDao('menu');

		$error = array();
		parse_str($aVars['order']);
		$oMenuDao->setMenuItemOrder($menu_item);
		$this->_renumber();
		return Output::json(array('error' => $error));
	}

	function _get_menu_tree($iIdMenu) {
		$oMenuDao =& DaoFactory::getDao('menu'); 
		$aMenuItemList = $oMenuDao->getAllMenuItem($iIdMenu);
		if (empty($aMenuItemList)) return false;
		$aMenuItemTree = array();
		foreach ($aMenuItemList as $aMenuItem) {
			if ($aMenuItem['id_parent'] == 0) {
				if (!isset($aMenuItemTree[$aMenuItem['id_menu_item']])) $aMenuItemTree[$aMenuItem['id_menu_item']] = array();
				$aMenuItemTree[$aMenuItem['id_menu_item']] = array_merge($aMenuItemTree[$aMenuItem['id_menu_item']], $aMenuItem);
			}
			else {
				$aMenuItemTree[$aMenuItem['id_parent']]['children'][$aMenuItem['id_menu_item']] = $aMenuItem;
			}
		}
		return $aMenuItemTree;
	}
}
?>