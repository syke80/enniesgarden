<% switch from = $id_language %>
	<% case value='hu' %><% assign name='title' value='Megrendelés | '.$shop[name] %>
	<% case %><% assign name='title' value='Checkout | '.$shop[name] %>
<% /switch %>
<% include file='_header.tpl' %>

<div class="wrapper">
	<div class="content-box">
		<h1>
		<% switch from = $id_language %>
			<% case value='hu' %>Rendelés feladása - Részletek
			<% case %>Checkout - Details
		<% /switch %>
		</h1>
		<% assign name='checkout_page' value='2' %>
		<% include file='_checkout_steps.tpl' %>

		<% switch from = $id_language %>
			<% case value='hu' %><% assign name='checkout_url' value=$siteconfig[site_url].'/penztar/' %>
			<% case %><% assign name='checkout_url' value=$siteconfig[site_url].'/checkout/' %>
		<% /switch %>
		
		<div class="checkout_details">
		<form id="form_details" action="<% $checkout_url %>" method="post">
			<div class="formdiv">
				<h2>
				<% switch from = $id_language %>
					<% case value='hu' %>Szállítási adatok
					<% case %>Delivery details
				<% /switch %>
				</h2>
				<div class="item">
					<label for="details_shipping_name">Name *</label>
					<input id="details_shipping_name" name="shipping_name" type="text" value="<% if $customer %><% $customer[shipping_name] %><% /if %>" />
				</div>
				<div class="item">
					<label for="details_shipping_city">Town / City *</label>
					<input id="details_shipping_city" name="shipping_city" type="text" value="<% if $customer %><% $customer[shipping_city] %><% /if %>" />
				</div>
				<div class="item">
					<label for="details_shipping_postcode">Postcode *</label>
					<input id="details_shipping_postcode" name="shipping_postcode" type="text" value="<% if $customer %><% $customer[shipping_postcode] %><% /if %>" />
				</div>
				<div class="item">
					<label for="details_shipping_address">Address *</label>
					<input id="details_shipping_address" name="shipping_address" type="text" value="<% if $customer %><% $customer[shipping_address] %><% /if %>" />
				</div>
				<div class="item">
					<label for="details_phone">Phone number *</label>
					<input id="details_phone" name="phone" type="text" value="<% if $customer %><% $customer[phone] %><% /if %>" />
				</div>
				<div class="item">
					<label for="details_email">Email *</label>
					<input id="details_email" name="email" type="text" value="<% if $customer %><% $customer[email] %><% /if %>" />
				</div>
				<div class="item">
					<input id="details_billing_same" name="billing_same" class="checkbox" type="checkbox" checked="checked" />
					<label for="details_billing_same">Billing address are the same as shipping.</label>
				</div>
				<div id="billing" style="display: none;">
					<h2>Billing details</h2>
					<div class="item">
						<label for="details_billing_name">Name *</label>
						<input id="details_billing_name" name="billing_name" type="text" value="<% if $customer %><% $customer[billing_name] %><% /if %>" />
					</div>
					<div class="item">
						<label for="details_billing_city">Town / City *</label>
						<input id="details_billing_city" name="billing_city" type="text" value="<% if $customer %><% $customer[billing_city] %><% /if %>" />
					</div>
					<div class="item">
						<label for="details_billing_postcode">Postcode *</label>
						<input id="details_billing_postcode" name="billing_postcode" type="text" value="<% if $customer %><% $customer[billing_postcode] %><% /if %>" />
					</div>
					<div class="item">
						<label for="details_billing_address">Address *</label>
						<input id="details_billing_address" name="billing_address" type="text" value="<% if $customer %><% $customer[billing_address] %><% /if %>" />
					</div>
				</div>
		<% if !$customer %>
				<div class="item">
					<p>
						<strong>Sign up</strong>, and you can <strong>buy more easily</strong> next time.<br />
						You have only to choose a password.
					</p>
					<input id="details_register" name="register" class="checkbox" type="checkbox" checked="checked" />
					<label for="details_register">Yes, I want to sign up and make the next order easier.</label>
				</div>
				<div id="register">
					<div class="item">
						<label for="details_register_passw">Password</label>
						<input name="register_passw" type="hidden" />
						<input id="details_register_passw" type="password" />
					</div>
					<div class="item">
						<label for="details_register_passw2">Password again</label>
						<input name="register_passw2" type="hidden" />
						<input id="details_register_passw2" type="password" />
					</div>
				</div>
		<% /if %>
		
<% if $shipping_method_list %>
				<div id="shipping_method">
					<div class="item">
						<label>Shipping</label>
						<div id="details_shipping_method" class="radio_list">
						
						
						<% foreach from=$shipping_method_list value='shipping_method' %>
							<% if $total < 20 %>
								<% if $shipping_method[name] == 'personal' || $shipping_method[name] == 'post-3-day' || $shipping_method[name] == 'post+cod' || $shipping_method[name] == 'post-1-day' || $shipping_method[name] == 'locker-drop-off' %>
									<% assign name='is_available' value=TRUE %>
								<% else %>
									<% assign name='is_available' value=FALSE %>
								<% /if %>
							<% else %>
								<% if $shipping_method[name] == 'personal' || $shipping_method[name] == 'free-post-3-day' || $shipping_method[name] == 'post+cod' || $shipping_method[name] == 'post-1-day' || $shipping_method[name] == 'free-locker-drop-off' %>
									<% assign name='is_available' value=TRUE %>
								<% else %>
									<% assign name='is_available' value=FALSE %>
								<% /if %>
							<% /if %>
							
							<% switch from=$shipping_method[name] %>
								<% case value='personal' %><% assign name='shipping_method_text' value='Personal collection' %>
								<% case value='post-3-day' %><% assign name='shipping_method_text' value='Royal Mail 3-5 day' %>
								<% case value='post+cod' %><% assign name='shipping_method_text' value='Post + Cash on delivery' %>
								<% case value='free-post-3-day' %><% assign name='shipping_method_text' value='Royal Mail 3-5 day' %>
								<% case value='post-1-day' %><% assign name='shipping_method_text' value='Royal Mail 1 day' %>
								<% case value='locker-drop-off' %><% assign name='shipping_method_text' value='Locker Drop Off' %>
								<% case value='free-post-1-day' %><% assign name='shipping_method_text' value='Royal Mail 1 day' %>
								<% case value='free-locker-drop-off' %><% assign name='shipping_method_text' value='Locker Drop Off' %>
								<% case %><% assign name='shipping_method_text' value=$shipping_method[name] %>
							<% /switch %>
							<% if $shipping_method[is_linked] && $is_available%>
							<div class="radio_item">
								<input id="details_shipping_method_<% $shipping_method[id_shipping_method] %>" type="radio" name="shipping_method" method_name="<% $shipping_method[name] %>" value="<% $shipping_method[id_shipping_method] %>" />
								<label for="details_shipping_method_<% $shipping_method[id_shipping_method] %>">
									<% $shipping_method_text %>
									<% if $shipping_method[price] != '0.00'%>( £<% $shipping_method[price] %> )
									<% else %><strong>(Free)</strong><% /if %>
								</label>
							</div>
							<% /if %>
						<% /foreach %>
						</div>
					</div>
				</div>
<% /if %>

				<% foreach from=$payment_method_list value='payment_method' %>
					<% if $payment_method[name]=='cc' %>
					<input type="hidden" name="payment_method" value="<% $payment_method[id_payment_method] %>" />
					<% /if %>
				<% /foreach %>

				<div class="item item_btn_order">
					<button class="important" id="btn_order" type="submit">Continue checkout</button>
				</div>

			</div>
		</form>
		
		<div id="preview_container">
		</div>
	</div>
</div>

	<script>
	onLoadFunctions.push( function() {
		$("#form_details").ajaxForm({
			dataType: "json",
			beforeSubmit: function(arr, $form, options) {
				$("button", $form).addClass("inprogress");
				$("button", $form).attr("disabled", true);
				$("button", $form).attr("btn_label", $("button", $form).html());
				$("button", $form).html("Please wait");
			},
			beforeSerialize: function() {
				<% if !$customer %>
				$("#form_details input[name=register_passw2]").val($.md5($("#details_register_passw2").val()));
				var passw_md5 = $("#details_register_passw").val() == "" ? "" : $.md5($("#details_register_passw").val());
				$("#form_details input[name=register_passw]").val(passw_md5);
				var passw2_md5 = $("#details_register_passw2").val() == "" ? "" : $.md5($("#details_register_passw2").val());
				$("#form_details input[name=register_passw2]").val(passw2_md5);
				<% /if %>
			},
			success: function(data, statusText, xhr, $form) {
				$("button", $form).removeClass("inprogress");
				$("button", $form).attr("disabled", false);
				$("button", $form).html($("button", $form).attr("btn_label"));
				if (data.error == "") {
					<% switch from = $id_language %>
						<% case value='en' %>window.location = "<% $siteconfig[site_url] %>/checkout/charityclear/"+data.hash;
						<% case value='hu' %>window.location = "<% $siteconfig[site_url] %>/penztar/charityclear/"+data.hash;
					<% /switch %>
				}
				else {
					<% include file='_js_error.tpl' %>
				}
			}
		});
		
		<%* register checkbox *%>
		$("#details_register").click( function() {
			if ($(this).prop("checked")) $("#register").show("slow");
			else $("#register").hide("slow");
		})
		
		<%* billing_same checkbox *%>
		$("#details_billing_same").click( function() {
			if ($(this).prop("checked")) $("#billing").hide("slow");
			else $("#billing").show("slow");
		})
		
	});
	function refresh_preview() {
		$.ajax({
			type: "GET",
			url:  "<% $siteconfig[site_url] %>/checkout/preview/<% $id_language %>/",
			data: $('#form_details').serialize(),
			success: function(response) {
				$("#preview_container").html(response);
			}
		});
	}
	</script>
	

	<script>
	onLoadFunctions.push( function() {

		$("#details_shipping_method").change( function() {
			refresh_preview();
		});
		refresh_preview();

<%*
		// ugy kell megcsinalni, hogy ne fixed legyen, hanem js szamolja ki a koordinatat
		// azert kell igy, mert ha az alja kilogna a contentbol, akkor mar ne vigye lejjebb
		// es ha az alja nem fer bele a viewportba, akkor meg egyaltalan ne is legyen sticky
		// didScroll event handler
		var didScroll = false;
		 
		$(window).scroll(function() {
			didScroll = true;
		});
		 
		setInterval(function() {
			if ( didScroll ) {
				didScroll = false;
				$(window).trigger("didScroll");
			}
		}, 100);
		
		// Check scrolled out header
		$(window).on("didScroll", function() {
			console.log("qwe"+$("#preview_container").offset().top);
			if ($(window).scrollTop() >= $("#preview_container").offset().top) {
				$("#preview_container").addClass("sticky");
			}
			else {
				$("#preview_container").removeClass("sticky");
			}
		});
*%>
	});
	</script>

</div>

<% include file='_footer.tpl' %>
