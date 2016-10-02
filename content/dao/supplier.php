<?php
class SupplierDao extends Dao {
	/**
	 * A shophoz tartozó beszállítók listája a conscendo_table által feldolgozható formában
	 */	 
	public function getDistinctSupplier($iIdShop) {
		return $this->rConnection->getValueList("
			SELECT supplier.name
			FROM supplier
			WHERE id_shop = :0
		", func_get_args());
	}
}
