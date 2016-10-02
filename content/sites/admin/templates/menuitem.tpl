<% include file='_header.tpl' %>

<div class="box menu_box">
	<div id="box_list">
	</div>
	<div id="button_container">
		<button id="btn_add">Add new menu item</button>
	</div>
</div>
<script type="text/javascript">
$("#box_list").load('/menuitem/list/<% $id_menu %>/');
</script>

<script>
$("#btn_add").click(function() {
	$.simplebox( {
		"simplebox_id": "add_popup",
		"url": "<% $siteconfig[site_url] %>/menuitem/add/<% $id_menu %>/",
		"width": 600,
		"height": 160
	} );								
});
</script>
<% include file='_footer.tpl' %>
