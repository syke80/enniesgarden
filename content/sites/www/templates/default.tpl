<% assign name='title' value='' %>
<% foreach from=$categorylist item='category' %>
<% assign name='title' value=$title.$category[name].' | ' %>
<% assign name='keywords' value=$keywords.$category[name].' | ' %>
<% /foreach %>
<% assign name='title' value=$title.$shop[name] %>
<% assign name='description' value=$shop[description] %>


<% include file='_header.tpl' %>
<script type="text/javascript">
$(document).ready( function() {
	$(".scroll").each( function() {
		if ($(this).html() == "") {
			$(this).parent().hide();
		}
	});

	$(".scroll").scroll();
});
</script>

<h1><% $siteconfig[site_name] %></h1>

<div id="featured" class="scroll">
	<h2>Ajánlott termékek</h2>
	<div class="list">
	<% load url=$siteconfig[site_url].'/list/featured/10' %>
	</div>
</div>

<div id="sale" class="scroll">
	<h2>Akciós termékek</h2>
	<div class="list">
	<% load url=$siteconfig[site_url].'/list/sale/10' %>
	</div>
</div>

<div id="new" class="scroll">
	<h2>Legújabb termékek</h2>
	<div class="list">
	<% load url=$siteconfig[site_url].'/list/new/10' %>
	</div>
</div>
<% include file='_footer.tpl' %>
