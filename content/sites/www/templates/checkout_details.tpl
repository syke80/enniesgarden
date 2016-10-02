<% switch from = $id_language %>
	<% case value='hu' %><% assign name='title' value='Megrendelés | '.$shop[name] %>
	<% case %><% assign name='title' value='Checkout | '.$shop[name] %>
<% /switch %>
<% include file='_header.tpl' %>

<h1>
<% switch from = $id_language %>
	<% case value='hu' %>Rendelés feladása - Részletek
	<% case %>Checkout - Details
<% /switch %>
</h1>

<% switch from = $id_language %>
	<% case value='hu' %><% assign name='checkout_url' value=$siteconfig[site_url].'/penztar' %>
	<% case %><% assign name='checkout_url' value=$siteconfig[site_url].'/checkout' %>
<% /switch %>

<div class="checkout_details">
<form id="form_details" action="<% $checkout_url %>" method="put">
	<div class="formdiv">
		<h2>
		<% switch from = $id_language %>
			<% case value='hu' %>Szállítási adatok
			<% case %>Shipping details
		<% /switch %>
		</h2>
		<div class="item">
			<label for="details_shipping_name">Név</label>
			<input id="details_shipping_name" name="shipping_name" type="text" value="<% if $customer %><% $customer[shipping_name] %><% /if %>" />
		</div>
		<div class="item">
			<label for="details_shipping_city">Város</label>
			<input id="details_shipping_city" name="shipping_city" type="text" value="<% if $customer %><% $customer[shipping_city] %><% /if %>" />
		</div>
		<div class="item">
			<label for="details_shipping_postcode">Irányítószám</label>
			<input id="details_shipping_postcode" name="shipping_postcode" type="text" value="<% if $customer %><% $customer[shipping_postcode] %><% /if %>" />
		</div>
		<div class="item">
			<label for="details_shipping_address">Cím</label>
			<input id="details_shipping_address" name="shipping_address" type="text" value="<% if $customer %><% $customer[shipping_address] %><% /if %>" />
		</div>
		<div class="item">
			<label for="details_phone">Telefonszám</label>
			<input id="details_phone" name="phone" type="text" value="<% if $customer %><% $customer[phone] %><% /if %>" />
		</div>
		<div class="item">
			<label for="details_email">Email</label>
			<input id="details_email" name="email" type="text" value="<% if $customer %><% $customer[email] %><% /if %>" />
		</div>
		<div class="item">
			<label for="details_billing_same">A számlázási adatok megegyeznek a szállítási adatokkal</label>
			<input id="details_billing_same" name="billing_same" class="checkbox" type="checkbox" />
		</div>
		<div id="billing">
			<h2>Számlázási adatok</h2>
			<div class="item">
				<label for="details_billing_name">Név</label>
				<input id="details_billing_name" name="billing_name" type="text" value="<% if $customer %><% $customer[billing_name] %><% /if %>" />
			</div>
			<div class="item">
				<label for="details_billing_city">Város</label>
				<input id="details_billing_city" name="billing_city" type="text" value="<% if $customer %><% $customer[billing_city] %><% /if %>" />
			</div>
			<div class="item">
				<label for="details_billing_postcode">Irányítószám</label>
				<input id="details_billing_postcode" name="billing_postcode" type="text" value="<% if $customer %><% $customer[shipping_postcode] %><% /if %>" />
			</div>
			<div class="item">
				<label for="details_billing_address">Cím</label>
				<input id="details_billing_address" name="billing_address" type="text" value="<% if $customer %><% $customer[shipping_address] %><% /if %>" />
			</div>
		</div>
<% if !$customer %>
		<div class="item">
			<label for="details_register">Szeretnék regisztrálni a megadott email címmel</label>
			<input id="details_register" name="register" class="checkbox" type="checkbox" />
		</div>
<% /if %>
		<div id="register">
			<div class="item">
				<label for="details_register_passw">Jelszó</label>
				<input name="register_passw" type="hidden" />
				<input id="details_register_passw" type="password" />
			</div>
			<div class="item">
				<label for="details_register_passw2">Jelszó mégegyszer</label>
				<input name="register_passw2" type="hidden" />
				<input id="details_register_passw2" type="password" />
			</div>
		</div>

		<div id="shipping_method">
			<div class="item">
				<label>Szállítás</label>
				<div id="details_register_shipping_method" class="radio_list">
				<% foreach from=$shipping_method_list value='shipping_method' %>
					<% switch from=$shipping_method[name] %>
						<% case value='personal' %><% assign name='shipping_method_text' value='Személyes átvétel' %>
						<% case value='post' %><% assign name='shipping_method_text' value='Posta' %>
						<% case value='post+cod' %><% assign name='shipping_method_text' value='Posta + utánvét' %>
						<% case value='free shipping' %><% assign name='shipping_method_text' value='Free shipping' %>
						<% case %><% assign name='shipping_method_text' value=$shipping_method[name] %>
					<% /switch %>
					<% if $shipping_method[is_linked] %>
					<div class="radio_item">
						<input id="details_register_shipping_method_<% $shipping_method[id_shipping_method] %>" type="radio" name="shipping_method" method_name="<% $shipping_method[name] %>" value="<% $shipping_method[id_shipping_method] %>" />
						<label for="details_register_shipping_method_<% $shipping_method[id_shipping_method] %>">
							<% $shipping_method_text %>
							<% if $shipping_method[price] %>( <% $shipping_method[price] %> Ft )<% /if %>
						</label>
					</div>
					<% /if %>
				<% /foreach %>
				</div>
			</div>
		</div>
		
		<script>
			$("#details_register_shipping_method").change( function() {
				switch ($("input[name=shipping_method]:checked").attr("method_name")) {
					case 'post+cod':
						$("#payment_method .radio_item").hide();
						$("#payment_method .radio_item input").attr("disabled", "disabled");
						$("#payment_method .radio_item[payment_method=cod]").show();
						$("#payment_method .radio_item[payment_method=cod] input").removeAttr("disabled");
						$("#payment_method").show(500);
						break;
					case 'personal':
						$("#payment_method .radio_item").hide();
						$("#payment_method .radio_item input").attr("disabled", "disabled");
						$("#payment_method .radio_item[payment_method=personal]").show();
						$("#payment_method .radio_item[payment_method=personal] input").removeAttr("disabled");
						$("#payment_method").show(500);
						break;
					default:
						$("#payment_method .radio_item").show();
						$("#payment_method .radio_item input").removeAttr("disabled");
						$("#payment_method .radio_item[payment_method=cod]").hide();
						$("#payment_method .radio_item[payment_method=cod] input").attr("disabled", "disabled");
						$("#payment_method .radio_item[payment_method=personal]").hide();
						$("#payment_method .radio_item[payment_method=personal] input").attr("disabled", "disabled");
						$("#payment_method").show(500);
						break;
				}
				refresh_preview();
			});
		</script>

		<div id="payment_method" style="display: none;">
			<div class="item">
				<label>Fizetés</label>
				<div id="details_register_payment_method" class="radio_list">
				<% foreach from=$payment_method_list value='payment_method' %>
					<% switch from=$payment_method[name] %>
						<% case value='personal' %><% assign name='payment_method_text' value='Személyesen az ügyfélszolgálatokon' %>
						<% case value='paypal' %><% assign name='payment_method_text' value='Paypal' %>
						<% case value='cc' %><% assign name='payment_method_text' value='Bankkártyás fizetés' %>
						<% case value='cod' %><% assign name='payment_method_text' value='Utánvét' %>
						<% case value='wire_transfer' %><% assign name='payment_method_text' value='Banki átutalás' %>
						<% case %><% assign name='payment_method_text' value=$payment_method[name] %>
					<% /switch %>
					<% if $payment_method[is_linked] %>
					<div class="radio_item" payment_method="<% $payment_method[name] %>">
						<input id="details_register_payment_method_<% $payment_method[id_payment_method] %>" type="radio" name="payment_method" value="<% $payment_method[id_payment_method] %>" />
						<label for="details_register_payment_method_<% $payment_method[id_payment_method] %>"><% $payment_method_text %></label>
					</div>
					<% /if %>
				<% /foreach %>
				</div>
			</div>
		</div>

		<div class="item item_btn_order">
			<button id="btn_order" type="submit">Megrendelés feladása</button>
		</div>
	</div>
</form>

	<div id="preview_container">
	</div>
	<script>
	refresh_preview();
	</script>


	<script>
	$("#form_details").ajaxForm({
		dataType: "json",
		beforeSerialize: function() {
			$("#form_details input[name=register_passw2]").val($.md5($("#details_register_passw2").val()));
			var passw_md5 = $("#details_register_passw").val() == "" ? "" : $.md5($("#details_register_passw").val());
			$("#form_details input[name=register_passw]").val(passw_md5);
			var passw2_md5 = $("#details_register_passw2").val() == "" ? "" : $.md5($("#details_register_passw2").val());
			$("#form_details input[name=register_passw2]").val(passw2_md5);
		},
		success: function(data) {
			if (data.error == "") {
				<% switch from = $id_language %>
					<% case value='en' %>window.location = "<% $siteconfig[site_url] %>/checkout/success";
					<% case value='hu' %>window.location = "<% $siteconfig[site_url] %>/penztar/sikeres-vasarlas";
				<% /switch %>
			}
			else {
				<% include file='_js_error.tpl' %>
			}
		}
	});
	
	<%* ha számlázási adatok megegyeznek a szállítási adatokkal akkor bezárja a számlázási adatokat is (akkor is ha nincs kitöltve) *%>
	
	if (
		$("#details_shipping_name").val() == $("#details_billing_name").val() &&
		$("#details_shipping_address").val() == $("#details_billing_address").val() &&
		$("#details_shipping_city").val() == $("#details_billing_city").val() &&
		$("#details_shipping_postcode").val() == $("#details_billing_postcode").val()
	) {
		$("#billing").hide();
		$("#details_billing_same").attr("checked", "checked");
	}
	
	<%* regisztráció bezárása *%>
	$("#register").hide();
	
	<%* billing_same checkbox működjön *%>
	$("#details_billing_same").click( function() {
		if ($(this).prop("checked")) $("#billing").hide("slow");
		else $("#billing").show("slow");
	})
	
	<%* register checkbox működjön *%>
	$("#details_register").click( function() {
		if ($(this).prop("checked")) $("#register").show("slow");
		else $("#register").hide("slow");
	})
	
	
	function refresh_preview() {
		$.ajax({
			type: "GET",
			url:  "<% $siteconfig[site_url] %>/checkout/preview/<% $id_language %>",
			data: $('#form_details').serialize(),
			success: function(response) {
				$("#preview_container").html(response);
			}
		});
	}
	</script>
	





	<% include file='_footer.tpl' %>
</div>

