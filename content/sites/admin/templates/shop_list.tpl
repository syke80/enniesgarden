<div id="shop_list" class="admin_box">
	<h2>Boltok listája</h2>
	<ul class="admin_list">
		<li class="head">
			<span class="permalink">Permalink</span>
			<span class="name">Name</span>
		</li>
		<% if $list %>
			<% foreach from=$list item=item %>
			<li id="item_<% $item[id_shop] %>" class="item">
				<span class="info">
					<span class="permalink"><% $item[permalink] %></span>
					<span class="name"><% $item[name] %></span>
					<span class="edit">Edit</span>
					<span class="del">Delete</span>
				</span>
			</li>
			<% /foreach %>
		<% /if %>
	</ul>
</div>

<script type="text/javascript">
$("#shop_list ul.admin_list li.item").mouseenter( function() {
	$(this).addClass("active");
}).mouseleave( function() {
	$(this).removeClass("active");
});

$("#shop_list .edit").click( function() {
	$.simplebox( {
		"simplebox_id": "edit_popup",
		"url": "<% $siteconfig[site_url] %>/shop/edit/"+$(this).parent().parent().attr("id").substr(5),
		"title": "Edit",
		"width": 500,
		"height": 400
	})
} );

$("#shop_list .del").click( function() {
	$.simplebox( {
		"simplebox_id": "del_popup",
		"url": "<% $siteconfig[site_url] %>/shop/delete/"+$(this).parent().parent().attr("id").substr(5),
		"simplebox_id": "shop_del",
		"title": "Delete",
		"width": 300,
		"height": 100
	})
} );
</script>
