<% if $coupon_error %>
	<div id="coupon-error-popup" class="modal-content" style="display: none">
		<p>
			<% switch from=$coupon_error %>
				<% case value='invalid' %>
				The coupon you entered is invalid.<br /> Maybe you misspelled it?
				<% case value='expired' %>
				The coupon you entered is expired.
			<% /switch %>
		</p>
		<p class="actions">
			<a class="btn btn-close" href="#" onclick="$.sPopup('destroy'); return false;">Ok</a>
		</p>
	</div>
	<script>
	$.sPopup({
		object: "#coupon-error-popup"
	});
	</script>
<% /if %>

<% if $new_coupon && !$coupon_error %>
	<div id="coupon-ok-popup" class="modal-content" style="display: none">
		<p>
			Coupon code applied successfully.
		</p>
		<p class="actions">
			<a class="btn btn-close" href="#" onclick="$.sPopup('destroy'); return false;">Ok</a>
		</p>
	</div>
	<script>
	$.sPopup({
		object: "#coupon-ok-popup"
	});
	</script>
<% /if %>
