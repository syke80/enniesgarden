<% include file='_header.tpl' %>

<script type="text/javascript">
$(document).ready( function() {
	$("#order .list").load("<% $siteconfig[site_url] %>/order/list");
});
</script>

<div id="order">
	<div class="list"></div>
</div>

<% include file='_footer.tpl' %>
