<?php
class PackModule extends Module {
	protected function _access($sMethodName) {
		return TRUE;
	}

	public function path() {
	}

	/**
	 * Rendereli a paraméterben megadott termékcsomag oldalát.
	 *
	 * @param  string   $sPermalink         A termékcsomag permalinkje
	 *
	 * @return string   A generált oldal tartalma
	 */
	protected function _reqDefault($sPermalink) {
		if (!isset($sPermalink)) return FALSE;

		$oPackDao =& DaoFactory::getDao('pack');
		$oPhotoDao =& DaoFactory::getDao('pack_photo');

		$aPack = $oPackDao->getPackByPermalink($GLOBALS['siteconfig']['shop_permalink'], $sPermalink);
		if (empty($aPack)) return FALSE;

		// Termékcsomag képei
		$aPhotoList = $oPhotoDao->getPhotoListByIdPack($aPack['id_pack']);

		return Output::render('pack', getLayoutVars() + array(
			'pack' => $aPack,
			'photolist' => $aPhotoList,
			'photolist_count' => count($aPhotoList),
		));
	}
}
?>