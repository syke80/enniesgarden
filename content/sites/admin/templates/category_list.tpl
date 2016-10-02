<script type="text/javascript">
$(document).ready( function() {
	$("#category_list ul.admin_list li.item").mouseenter( function() {
		$(this).addClass("active");
	}).mouseleave( function() {
		$(this).removeClass("active");
	});

	$("#category_list .edit").click( function() {
		$.simplebox( {
			"simplebox_id": "edit_popup",
			"url": "<% $siteconfig[site_url] %>/category/edit/"+$(this).parent().parent().attr("id").substr(5),
			"title": "Edit",
			"width": 500,
			"height": 600
		})
	} );
	$("#category_list .del").click( function() {
		$.simplebox( {
			"simplebox_id": "del_popup",
			"url": "<% $siteconfig[site_url] %>/category/delete/"+$(this).parent().parent().attr("id").substr(5),
			"title": "Delete",
			"width": 300,
			"height": 100
		})
	} );
});
</script>

<div id="category_list" class="admin_box">
	<h2>Categories</h2>
	<ul class="admin_list">
		<li class="head">
			<span class="permalink">Permalink</span>
			<span class="name">Name</span>
		</li>
		<% if $list %>
			<% foreach from=$list item=item %>
			<li id="item_<% $item[id_category] %>" class="item">
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