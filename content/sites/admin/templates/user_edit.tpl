<script type="text/javascript">
function refresh_shop() {
	if ($("#edit_access").val() == 'root') $("#item_shop").hide();
	else $("#item_shop").show();
}

$(document).ready(function() {
	$("#form_edit").ajaxForm({
		dataType: "json",
		beforeSerialize: function() {
			var passw_md5 = $("#edit_passw").val() == "" ? "" : $.md5($("#edit_passw").val());
			$("#form_edit input[name=passw]").val(passw_md5);
			var passw2_md5 = $("#edit_passw2").val() == "" ? "" : $.md5($("#edit_passw2").val());
			$("#form_edit input[name=passw2]").val(passw2_md5);
		},
		success: function(data) {
			if (data.error == "") {
				$.jGrowl("The changes has been successfully saved");
				$("#user .list").load("<% $siteconfig[site_url] %>/user/list");
			}
			else {
				<% include file='_js_error.tpl' %>
			}
		}
	});

	$("#edit_access").change( function() {
		refresh_shop();
	});

	refresh_shop();
});
</script>

<form id="form_edit" action="<% $siteconfig[site_url] %>/user/<% $info[id_user] %>/" method="put">
<div class="formdiv">
	<div class="item">
		<label for="edit_username">User name *</label>
		<input id="edit_username" name="username" type="text" value="<% $info[username] %>" />
	</div>
	<div class="item">
		<label for="edit_name">Name *</label>
		<input id="edit_name" name="name" type="text" value="<% $info[name] %>" />
	</div>
	<div class="item">
		<label for="edit_passw">Password *</label>
		<input name="passw" type="hidden" />
		<input id="edit_passw" type="password" value="" />
	</div>
	<div class="item">
		<label for="edit_passw2">Confirm password *</label>
		<input name="passw2" type="hidden" />
		<input id="edit_passw2" type="password" value="" />
	</div>
	<div class="item">
		<label for="edit_email">Email *</label>
		<input id="edit_email" name="email" type="text" value="<% $info[email] %>" />
	</div>

	<div class="item">
		<label for="edit_access">Permission</label>
		<select id="edit_access" name="access">
			<% if $user[access] == 'root' %>
			<option value="root" <% if $info[access]=="root" %>selected="selected"<% /if %>>Root</option>
			<% /if %>
			<option value="shop_admin" <% if $info[access]=="shop_admin" %>selected="selected"<% /if %>>Shop administrator</option>
			<option value="stock_admin" <% if $info[access]=="stock_admin" %>selected="selected"<% /if %>>Stock administrator</option>
			<option value="disabled" <% if $info[access]=="disabled" %>selected="selected"<% /if %>>Disabled</option>
			<option value="inactive" <% if $info[access]=="inactive" %>selected="selected"<% /if %>>Inactive</option>
		</select>
	</div>
	<div id="item_shop" class="item">
		<% if $user[access] == 'root' %>
			<% if $shoplist %>
			<label for="edit_id_shop">Shop</label>
			<select id="edit_id_shop" name="id_shop">
				<option value="">&nbsp;</option>
				<% foreach from=$shoplist value=shop %>
				<option value="<% $shop[id_shop] %>" <% if $shop[id_shop] == $info[id_shop] %>selected="selected"<% /if %>><% $shop[name] %></option>
				<% /foreach %>
			</select>
			<% else %>
			<span>Shop list is empty</span>
			<input id="edit_id_shop" name="id_shop" value="" />
			<% /if %>
		<% else %>
			<input id="edit_id_shop" name="id_shop" type="hidden" value="<% $user[id_shop] %>" />
			<% foreach from=$shoplist value=shop %>
			<% if $shop[id_shop] == $user[id_shop] %>
			<label>Shop</label>
			<span class="value"><% $shop[name] %></span>
			<% /if %>
			<% /foreach %>
		<% /if %>
	</div>
	<div class="item">
		<button id="btn_edit_submit" type="submit"><span>Ok</span></button>
	</div>
</div>
</form>
