<% assign name='pageid' value='feedback-thankyou' %>
<% assign name='title' value='Feedback received | '.$shop[name] %>
<% include file='_header.tpl' %>

<div class="wrapper">
	<div class="content-box">

		<h1>Feedback received</h1>
		<p>
			Thank you for your time and consideration.<br />
			Check your mailbox, we send your coupon very soon.
		</p>

		<% if $email %>
		<form class="form_newsletter" action="<% $siteconfig[site_url] %>/feedback/subscribe/" method="post">
		<input type="hidden" name="email" value="<% $email %>" />
		<input type="hidden" name="first_name" value="<% $first_name %>" />
		<input type="hidden" name="last_name" value="<% $last_name %>" />
		<p>
			Sign up for special offers, recipe ideas and kitchen practices. You will receive 1 or 2 emails per month.<br />
			<div class="formdiv">
				<div class="item">
					<input type="checkbox" id="signup_agree" name="signup_agree" type="text" checked="checked" />
					<label for="signup_agree">Yes, I want to sign up and receive special offers.</label>
				</div>
			</div>
			<div class="item">
				<button class="important" id="btn_signup" type="submit">Get the offers</button>
			</div>
		</p>
		</form>
		<script>
			onLoadFunctions.push( function() {
				$(".form_newsletter").ajaxForm({
					dataType: "json",
					beforeSubmit: function(arr, $form, options) {
						$("button", $form).addClass("inprogress");
						$("button", $form).attr("disabled", true);
						$("button", $form).attr("btn_label", $("button", $form).html());
						$("button", $form).html("Please wait");
					},
					success: function(data, statusText, xhr, $form) {
						$("button", $form).removeClass("inprogress");
						$("button", $form).attr("disabled", false);
						$("button", $form).html($("button", $form).attr("btn_label"));
						$.sPopup({
							object: "#subscribe-popup"
						});
					}
				});
/*
				$("#signup_agree").change( function() {
					if ($(this).prop("checked")) $(".form_newsletter button").removeAttr("disabled");
					else $(".form_newsletter button").attr("disabled", "disabled");
				});
*/
			});
		</script>

		<div id="subscribe-popup" class="modal-content" style="display: none">
			<p>Product successfully added to your basket.</p>
			<p class="large-amount-message">Only <strong>6-day</strong> delivery available in this amount.</p>
			<p class="actions">
				<a class="btn" href="/">Go to the index page</a>
			</p>
		</div>

		<% /if %>
	</div>
</div>

<% include file='_footer.tpl' %>