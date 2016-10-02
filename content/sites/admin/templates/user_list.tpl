<script type="text/javascript">
$(document).ready( function() {
	$("#user_list ul.admin_list li.item").mouseenter( function() {
		$(this).addClass("active");
	}).mouseleave( function() {
		$(this).removeClass("active");
	});

	$("#user_list .edit").click( function() {
		$.simplebox( {
			"url": "<% $siteconfig[site_url] %>/user/edit/"+$(this).parent().parent().attr("id").substr(5),
			"title": "Edit",
			"width": 600,
			"height": 300
		})
	} );
	$("#user_list .del").click( function() {
		$.simplebox( {
			"url": "<% $siteconfig[site_url] %>/user/delete/"+$(this).parent().parent().attr("id").substr(5),
			"simplebox_id": "user_del",
			"title": "Delete",
			"width": 300,
			"height": 100
		})
	} );
});
</script>

<div id="user_list" class="admin_box">
	<h2>Felhasználók</h2>
	<ul class="admin_list">
		<li class="head">
			<span class="username">User name</span>
			<span class="name">Name</span>
			<span class="email">Email</span>
			<span class="access">Permission</span>
			<span class="shopname">Shop</span>
		</li>
		<% if $list %>
			<% foreach from=$list item=item %>
			<li id="item_<% $item[id_user] %>" class="item">
				<span class="info">
					<span class="username"><% $item[username] %></span>
					<span class="name"><% $item[name] %></span>
					<span class="email"><% $item[email] %></span>
					<span class="access">
					<% switch from=$item[access] %>
					<% case value="root" %>
					Root
					<% case value="shop_admin" %>
					Shop administrator
					<% case value="stock_admin" %>
					Stock administrator
					<% case value="disabled" %>
					Disabled
					<% case value="inactive" %>
					Inactive
					<% /switch %>
					</span>
					<span class="shopname"><% $item[shop_name] %>&nbsp;</span>
					<span class="edit">Edit</span>
					<span class="del">Delete</span>
				</span>
			</li>
			<% /foreach %>
		<% /if %>
	</ul>
</div>