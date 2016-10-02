<% include file='_header.tpl' %>

<script type="text/javascript">

$(document).ready( function() {
	$("#user .list").load("<% $siteconfig[site_url] %>/user/list");
	$("#btn_add").click( function() {
		$.simplebox( {
			"id": "user_add",
			"url": "<% $siteconfig[site_url] %>/user/add",
			"title": "Add new user",
			"width": 500,
			"height": 300
		})
	} );
});
</script>

<div id="user">
	<div class="list"></div>
	<div class="action">
		<button id="btn_add" type="button">Add new user</button>
	</div>
</div>

<% include file='_footer.tpl' %>
