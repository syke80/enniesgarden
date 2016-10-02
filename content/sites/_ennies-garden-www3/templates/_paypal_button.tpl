<button id="btn_paypal">
	<img src="https://www.paypal.com/en_GB/GB/i/btn/btn_xpressCheckout.gif" align="left" style="margin-right:7px;" alt="PayPal express checkout button">
</button>

<div id="closed-popup" class="modal-content" style="display: none">
	<p>
		Our shop is temporarily closed. <br />
		Please try again later.
	</p>
	<p class="actions">
		<a class="btn btn-close" href="#" onclick="$.sPopup('destroy'); return false;">Ok</a>
	</p>
</div>

<script>
$("#btn_paypal").click( function() {
	$.sPopup({
		object: "#closed-popup"
	});
/*
		$(this).append("<span class=\"in-progress-text\">Please wait</span>");
		$.post(
			"<% $siteconfig[site_url] %>/paypal/",
			{
				id_payment_method: "<% get_payment_id name='paypal' %>",
				shipping_method: "hermes",
				coupon: $("#coupon").val()
			},
			function(data) {
				if (data.error == "") {
					<% if $siteconfig[paypal_testmode] %>
						window.location = "https://www.sandbox.paypal.com/cgi-bin/webscr?cmd=_express-checkout&token="+data.token;
					<% else %>
						window.location = "https://www.paypal.com/cgi-bin/webscr?cmd=_express-checkout&token="+data.token;
					<% /if %>
				}
				else {
					$(".in-progress-text", this).remove();
					<% include file='_js_error.tpl' %>
				}
			}
		);
*/
	}
);
</script>
