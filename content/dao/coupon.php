<?php
class CouponDao extends Dao {
	public function getCoupon($sCode) {
		return $this->rConnection->getRow("
			SELECT *
			FROM coupon
			WHERE code=:0
		", func_get_args());
	}

	public function setCouponExpiration($sCode, $sDate) {
		return $this->rConnection->getRow("
			UPDATE coupon
			SET expiration=:1
			WHERE code=:0
		", func_get_args());
	}

	public function createCoupon($sCode, $sType, $sInfo, $sExpiration, $cUnlimited) {
		$iId = $this->rConnection->insert('
			INSERT INTO coupon (code, type, info, expiration, unlimited)
			VALUES (:0, :1, :2, :3, :4)
		', func_get_args());

		return $this->rConnection->getValue("
			SELECT code
			FROM coupon
			WHERE id_coupon={$iId}
		", func_get_args());
	}
}
?>