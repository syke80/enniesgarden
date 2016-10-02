<script type="text/javascript">
function refresh_shop() {
	if ($("#add_access").val() == 'root') $("#item_shop").hide();
	else $("#item_shop").show();
}

$(document).ready(function() {
	$("#form_add").ajaxForm({
		dataType: "json",
		beforeSerialize: function() {
			var passw_md5 = $("#add_passw").val() == "" ? "" : $.md5($("#add_passw").val());
			$("#form_add input[name=passw]").val(passw_md5);
			var passw2_md5 = $("#add_passw2").val() == "" ? "" : $.md5($("#add_passw2").val());
			$("#form_add input[name=passw2]").val(passw2_md5);
		},
		success: function(data) {
			if (data.error == "") {
				$.jGrowl("User was added");
				$("#user .list").load("<% $siteconfig[site_url] %>/user/list");
				$.simplebox("destroy");
			}
			else {
				<% include file='_js_error.tpl' %>
			}
		}
	});

	$("#add_access").change( function() {
		refresh_shop();
	});

	refresh_shop();
});
</script>

<form id="form_add" action="<% $siteconfig[site_url] %>/user/" method="put">
<div class="formdiv">
	<div class="item">
		<label for="add_username">User name *</label>
		<input id="add_username" name="username" type="text" value="" />
	</div>
	<div class="item">
		<label for="add_name">Name *</label>
		<input id="add_name" name="name" type="text" value="" />
	</div>
	<div class="item">
		<label for="add_passw">Password *</label>
		<input name="passw" type="hidden" />
		<input id="add_passw" type="password" value="" />
	</div>
	<div class="item">
		<label for="add_passw2">Confirm password *</label>
		<input name="passw2" type="hidden" />
		<input id="add_passw2" type="password" value="" />
	</div>
	<div class="item">
		<label for="add_email">Email *</label>
		<input id="add_email" name="email" type="text" value="" />
	</div>
	<div class="item">
		<label for="add_access">Permission</label>
		<select id="add_access" name="access">
			<% if $user[access] == 'root' %>
			<option value="root">Root</option>
			<% /if %>
			<option value="shop_admin">Shop administrator</option>
			<option value="stock_admin" selected="selected">Stock administrator</option>
		</select>
	</div>
	<div id="item_shop" class="item">
		<% if $user[access] == 'root' %>
			<% if $shoplist %>
			<label for="add_shop">Shop *</label>
			<select id="add_id_shop" name="id_shop">
				<option value="">&nbsp;</option>
				<% foreach from=$shoplist value=shop %>
				<option value="<% $shop[id_shop] %>"><% $shop[name] %></option>
				<% /foreach %>
			</select>
			<% else %>
			<span>Shop list is empty</span>
			<input id="add_id_shop" name="id_shop" value="" />
			<% /if %>
		<% else %>
			<input id="add_id_shop" name="id_shop" type="hidden" value="<% $user[id_shop] %>" />
			<% foreach from=$shoplist value=shop %>
			<% if $shop[id_shop] == $user[id_shop] %>
			<label>Shop</label>
			<span class="value"><% $shop[name] %></span>
			<% /if %>
			<% /foreach %>
		<% /if %>
	</div>
	<div class="item">
		<button id="btn_add_submit" type="submit"><span>Ok</span></button>
	</div>
</div>
</form>
