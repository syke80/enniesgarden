<button id="search-button" class="fa fa-search">
</button>
<form id="form_search" action="<% $siteconfig[site_url] %>/search/" method="get">
<div id="search-container">
	<div class="item">
		<label for="search_str">
		<% switch from = $id_language %>
			<% case value='hu' %>Keresés
			<% case %>Search for
		<% /switch %>
		</label>
		<input type="text" id="search_str" name="str" placeholder="eg.: strawberry jam" />
	</div>
	<div class="item">
		<button type="submit">
		<% switch from = $id_language %>
			<% case value='hu' %>Keres
			<% case %>Search
		<% /switch %>
		</button>
	</div>
</div>
</form>
<script>
onLoadFunctions.push( function() {
	$("#form_search").submit( function() {
		window.location = $(this).attr("action")+$("input[name=str]", this).val();
		return false;
	});
	$("#search-button").click( function() {
		if (!$("#viewport-indicator .tablet").is(":visible")) $("#menu").slideUp(500);
		$("#cart-container").slideUp(500);
		$("#search-container").slideToggle(500);
		$(this).blur();
	});
});
</script>
