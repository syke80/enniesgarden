<form id="form_search" action="<% $siteconfig[site_url] %>/search" method="get">
<div id="search">
	<div class="item">
		<label for="search_str">
		<% switch from = $id_language %>
			<% case value='hu' %>Keresés
			<% case %>Search for
		<% /switch %>
		</label>
		<input type="text" id="search_str" name="str" placeholder="eg.: pear jam" />
	</div>
	<div class="item">
		<button class="imgreplace" type="submit">
		<% switch from = $id_language %>
			<% case value='hu' %>Keres
			<% case %>Search
		<% /switch %>
		</button>
	</div>
</div>
</form>
<script>
$("#form_search").submit( function() {
	window.location = $(this).attr("action")+"/"+$("input:[name=str]", this).val();
	return false;
});
</script>
