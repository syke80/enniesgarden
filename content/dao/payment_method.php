<?php
class PaymentMethodDao extends Dao {
	/**
	 * Egy fizetési metódus adatai
	 *
	 * @param  IdPaymentMethod  	 
	 * @return array
	 */
	public function getMethod($iIdPaymentMethod) {
		return $this->rConnection->getRow("
			SELECT *
			FROM payment_method
			WHERE id_payment_method = :0
		", func_get_args());
	}

	/**
	 * A rendszerben engedélyezett fizetési metódusok listája
	 *
	 * @param  IdShop  opcionális: ha meg van adva, akkor az is_linked fieldben jelzi, hogy az adott metódus a bolthoz van-e linkelve	 
	 * @return array
	 */
	public function getMethodList($iIdShop=0) {
		if ($iIdShop) {
			return $this->rConnection->getList("
				SELECT
					payment_method.*,
					(shop_payment_method.id_shop IS NOT NULL) AS is_linked,
					shop_payment_method.price
				FROM payment_method
				LEFT JOIN shop_payment_method
				ON (
					payment_method.id_payment_method = shop_payment_method.id_payment_method
					AND id_shop = :0
				)
			", func_get_args());
		} else {
			return $this->rConnection->getList("
				SELECT *
				FROM payment_method
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
				SELECT id_payment_method
				FROM payment_method
				WHERE name=:0
			", func_get_args());
	}
}
?>