<script type="text/javascript">
$(document).ready(function() {
	$("#form_logout").ajaxForm({
		dataType: "json",
		success: function(data) {
			if (data.error == "") {
				window.location = "<% $siteconfig[site_url] %>/userauth/logout";
			}
			else {
				<% include file='_js_error.tpl' %>
			}
		}
	});
	$("#form_shop").ajaxForm({
		dataType: "json",
		success: function(data) {
			if (data.error == "") {
				window.location.reload();
			}
			else {
				<% include file='_js_error.tpl' %>
			}
		}
	});
	$("#form_shop #select_shop").change( function() {
		$(this).closest("form").submit();
	});
});
</script>
<div id="userinfo">
	<span class="name">
		Logged in: <strong><% $user[name] %>
		<% switch from=$user[access] %>
			<% case value='root' %>
				(Root)
			<% case value='shop_admin' %>
				(Shop Administrator)
			<% case value='stock_admin' %>
				(Stock Administrator)
		<% /switch %>
		</strong>
	</span>
	<% if $user[access] != 'root' %>
	<span class="shop_name">Shop name: <strong><% $user[shop_name] %></strong></span>
	<% else %>
	<form id="form_shop" action="<% $siteconfig[site_url] %>/userauth/" method="put">
		<div class="shop_select">
			<label for="select_shop" class="shop_name">Shop name:</label>
			<select id="select_shop" name="id_shop">
				<option></option>
				<% foreach from=$shoplist item=shop %>
				<option <% if $shop[id_shop] == $user[id_shop] %>selected="selected"<% /if %>value="<% $shop[id_shop] %>"><% $shop[name] %></option>
				<% /foreach %>
			</select>
		</div>
	</form>
	<% /if %>
	<form id="form_logout" action="<% $siteconfig[site_url] %>/userauth/" method="delete">
		<div class="item">
			<button class="logout" type="submit">Log out</button>
		</div>
	</form>
</div>
