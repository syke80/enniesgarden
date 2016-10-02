<% include file='_header_authpage.tpl' %>

<script type="text/javascript">
$(document).ready(function() {
	$("#form_login").ajaxForm({
		dataType: "json",
		beforeSerialize: function() {
			var passw_md5 = $("#login_passw").val() == "" ? "" : $.md5($("#login_passw").val());
			$("#form_login input[name=passw]").val(passw_md5);
		},
		success: function(data) {
			if (data.error == "") {
				window.location="<% $siteconfig[site_url] %>";
			}
			else {
				<% include file='_js_error.tpl' %>
			}
		}
	});
});
</script>

<div class="userauth_login_container">
<h1>Webshop admin login</h1>
<form id="form_login" action="<% $siteconfig[site_url] %>/userauth/" method="put">
	<div class="formbox">
		<div class="item">
			<label for="login_username">User name</label>
			<input id="login_username" name="username" type="text" />
		</div>
		<div class="item">
			<label for="id_passw">Password</label>
			<input name="passw" type="hidden" id="test" />
			<input id="login_passw" type="password" />
		</div>
		<div id="login_item_submit" class="item">
			<button type="submit">Login</button>
		</div>
	</div>
</form>

<% include file='_footer.tpl' %>