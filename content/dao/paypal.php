<?php
class PaypalDao extends Dao {
	public function insert($iIdOrder, $sToken) {
		return $this->rConnection->insert('
			INSERT INTO paypal (id_order, token)
			VALUES (:0, :1)
		', func_get_args());
	}

	public function getOrderFromToken($sToken) {
		return $this->rConnection->getRow('
			SELECT *
			FROM paypal
			WHERE token = :0
			AND timestamp > (SELECT CURRENT_TIMESTAMP - INTERVAL 3 HOUR)
		', func_get_args());
	}
	
	public function getOrderFromTransactionID($sTransactionID) {
		return $this->rConnection->getRow('
			SELECT *
			FROM paypal
			WHERE transaction_id = :0
		', func_get_args());
	}
	
	public function updateWithPayerID($iIdOrder, $sPayerID) {
		return $this->rConnection->execute('
			UPDATE paypal
			SET payer_id = :1
			WHERE id_order = :0
		', func_get_args());
	}

	public function updateWithTransactionID($iIdOrder, $sTransactionID) {
		return $this->rConnection->execute('
			UPDATE paypal
			SET transaction_id = :1
			WHERE id_order = :0
		', func_get_args());
	}

	public function setDoCheckoutSent($iIdOrder) {
		return $this->rConnection->execute("
			UPDATE paypal
			SET docheckout_sent = 'y'
			WHERE id_order = :0
		", func_get_args());
	}

	public function setDoCheckoutSuccessful($iIdOrder) {
		return $this->rConnection->execute("
			UPDATE paypal
			SET docheckout_successful = 'y'
			WHERE id_order = :0
		", func_get_args());
	}

	public function setIPNPendingNotification($iIdOrder) {
		return $this->rConnection->execute("
			UPDATE paypal
			SET ipn_pending_notification = 'y'
			WHERE id_order = :0
		", func_get_args());
	}

	public function setIPNCompletedNotification($iIdOrder) {
		return $this->rConnection->execute("
			UPDATE paypal
			SET ipn_completed_notification = 'y'
			WHERE id_order = :0
		", func_get_args());
	}
}