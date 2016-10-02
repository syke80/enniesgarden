<form id="form_search" action="<% $siteconfig[site_url] %>/search" method="get">
<div id="search">
	<div class="item">
		<label for="search_str">Keresés</label>
		<input type="text" id="search_str" name="str" value="eg.: black dainese leather jacket" />
	</div>
	<div class="item">
		<button class="imgreplace" type="submit">Keres</button>
	</div>
</div>
</form>
<script>
$("#form_search").submit( function() {
	window.location = $(this).attr("action")+"/"+$("input:[name=str]", this).val();
	return false;
});
</script>
