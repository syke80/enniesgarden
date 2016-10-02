<% switch from=$id_language %>
	<% case value='hu' %><% assign name='title' value='Megrendelés - bejelentkezés | '.$shop[name] %>
	<% case %><% assign name='title' value='Checkout - login | '.$shop[name] %>
<% /switch %>
<% include file='_header.tpl' %>
<h1>Rendelés feladása - Belépés</h1>

<div class="login_options">

	<div id="checkout_continue">
		<h2>Először vásárol nálunk?</h2>
		<span class="info">Amennyiben vásárlásával egy időben szeretne regisztrálni áruházunkban, ezt a következő lépésben megteheti, azonban a regisztráció nem kötelező.</span>
		<button id="btn_continue" type="button">Folytatás belépés nélkül</button>
	</div>

	<div id="checkout_login">
		<h2>Ön regisztrált vásárlónk?</h2>
		<span>Kérjük, jelentkezzen be</span>
		<form id="form_checkout_login" action="<% $siteconfig[site_url] %>/customerauth" method="put">
		<div class="formdiv">
			<div class="item">
				<label for="checkout_login_email">Email</label>
				<input id="checkout_login_email" name="email" type="text" />
			</div>
			<div class="item">
				<label for="checkout_login_passw">Jelszó</label>
				<input name="passw" type="hidden"/>
				<input id="checkout_login_passw" type="password" />
			</div>
			<div class="item">
				<button type="submit">Belépés</button>
			</div>
		</div>
		</form>
	</div>
</div>

<script>
$("#form_checkout_login").ajaxForm({
	dataType: "json",
	beforeSerialize: function() {
		var passw_md5 = $("#checkout_login_passw").val() == "" ? "" : $.md5($("#checkout_login_passw").val());
		$("#form_checkout_login input[name=passw]").val(passw_md5);
	},
	success: function(data) {
		if (data.error == "") {
			<% switch from = $id_language %>
				<% case value='en' %>window.location = "<% $siteconfig[site_url] %>/checkout/details";
				<% case value='hu' %>window.location = "<% $siteconfig[site_url] %>/penztar/reszletek";
			<% /switch %>
		}
		else {
			<% include file='_js_error.tpl' %>
		}
	}
});

$("#btn_continue").click( function() {
	<% switch from = $id_language %>
		<% case value='en' %>window.location = "<% $siteconfig[site_url] %>/checkout/details";
		<% case value='hu' %>window.location = "<% $siteconfig[site_url] %>/penztar/reszletek";
	<% /switch %>
});
</script>
<% include file='_footer.tpl' %>
