<% include file='_header.tpl' %>

<div id="shop">
	<div class="list"></div>
	<div class="action">
		<button id="btn_add" type="button">Add new shop</button>
	</div>
</div>

<script>
$("#shop .list").load("<% $siteconfig[site_url] %>/shop/list");
$("#btn_add").click( function() {
	$.simplebox( {
		"simplebox_id": "add_popup",
		"url": "<% $siteconfig[site_url] %>/shop/add",
		"title": "Add new shop",
		"width": 500,
		"height": 350
	})
} );
</script>

<% include file='_footer.tpl' %>
