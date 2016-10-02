<?php
class ShippingMethodDao extends Dao {
	/**
	 * A rendszerben engedélyezett szállítási metódusok listája
	 *
	 * @param  IdShop  opcionális: ha meg van adva, akkor az is_linked fieldben jelzi, hogy az adott metódus a bolthoz van-e linkelve	 
	 * @return array
	 */
	public function getMethodList($iIdShop=0) {
		if ($iIdShop) {
			return $this->rConnection->getList("
				SELECT
					shipping_method.*,
					(shop_shipping_method.id_shop IS NOT NULL) AS is_linked,
					shop_shipping_method.price
				FROM shipping_method
				LEFT JOIN shop_shipping_method
				ON (
					shipping_method.id_shipping_method = shop_shipping_method.id_shipping_method
					AND id_shop = :0
				)
			", func_get_args());
		} else {
			return $this->rConnection->getList("
				SELECT *
				FROM shipping_method
			");
		}
	}

	/**
	 * Lekérdezi egy metodus azonositojat a neve alapjan
	 *
	 * @param  sName  	 
	 * @return int
	 */
	public function getMethodId($sName) {
			return $this->rConnection->getValue("
				SELECT id_shipping_method
				FROM shipping_method
				WHERE name=:0
			", func_get_args());
	}

	/**
	 * Lekérdezi egy metodus adatait
	 *
	 * @param  iIdShippingMethod  	 
	 * @return array
	 */
	public function getMethod($iIdShippingMethod) {
			return $this->rConnection->getValue("
				SELECT *
				FROM shipping_method
				WHERE id_shipping_method =:0
			", func_get_args());
	}
}
?>