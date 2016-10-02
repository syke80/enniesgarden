<% if $customer %>
<script type="text/javascript">
$(document).ready(function() {
	$("#form_logout").ajaxForm({
		dataType: "json",
		success: function(data) {
			if (data.error == "") {
				<% switch from = $id_language %>
					<% case value='hu' %>window.location = "<% $siteconfig[site_url] %>/kijelentkezes";
					<% case %>window.location = "<% $siteconfig[site_url] %>/logout";
				<% /switch %>
			}
			else {
				<% include file='_js_error.tpl' %>
			}
		}
	});
});
</script>

<div id="auth" class="auth_logout">
	<span>
		<% switch from = $id_language %>
			<% case value='hu' %>Bejelentkezve
			<% case %>Logged in
		<% /switch %>
	</span>
	<span class="value"><% $customer[email] %></span>
	<form id="form_logout" action="<% $siteconfig[site_url] %>/customerauth" method="delete">
		<button id="btn_logout" type="submit">
			<% switch from = $id_language %>
				<% case value='hu' %>Kijelentkezés
				<% case %>Logout
			<% /switch %>
		</button>
	</form>
</div>
<% else %>

<button id="btn_show_login" type="button">
	<% switch from = $id_language %>
		<% case value='hu' %>Bejelentkezés
		<% case %>Login
	<% /switch %>
</button>

<div id="auth">
<% form form_id='auth_login' itemtype='form' action=$siteconfig[site_url].'/customerauth' method='put' %>
	<% form itemtype='text' name='email' label='Email' label_on_field=true %>
	<% form itemtype='text' name='password' label='Jelszó' label_on_field=true %>
	<% form itemtype='submit' name='ok' label='OK' %>

	<% form cmd='error_msg' id='empty_email' msg='Az email cím kitöltése kötelező' %>
	<% form cmd='empty_passw' id='empty_email' msg='A jelszó kitöltése kötelező' %>
<% form cmd='render_form' %>
<% form cmd='render_javascript' function_success='window.location.reload();' %>
</div>

<script type="text/javascript">
$("#btn_show_login").click( function() {
	$(this).toggle(500);
	$("#form_auth_login").toggle(500);
});

$("#form_login").ajaxForm({
	dataType: "json",
	beforeSerialize: function() {
		var passw_md5 = $("#login_passw").val() == "" ? "" : $.md5($("#login_passw").val());
		$("#form_login input[name=passw]").val(passw_md5);
	},
	success: function(data) {
		if (data.error == "") {
			<% if $module=='customerauth' && $modulemethod=='logout' %>
			window.location = "<% $siteconfig[site_url] %>";
			<% else %>
			window.location.reload();
			<% /if %>
		}
		else {
			<% include file='_js_error.tpl' %>
		}
	}
});
</script>
<% /if %>
