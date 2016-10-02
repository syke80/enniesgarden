<% assign name='id_language' value=$category[language_iso] %>
<% assign name='pageid' value='category' %>
<% assign name='title' value=$category[name].' | '.$shop[name] %>
<% assign name='description' value=$category[description] %>

<% if $productlist %>
	<% foreach from=$productlist item=product %>
		<% assign name='keywords' value=$keywords.$product[name].', ' %>
	<% /foreach %>
<% /if %>

<% assign name='canonical' value=$siteconfig[site_url].'/'.$category[permalink].'/' %>
<% include file='_header.tpl' %>

<div class="wrapper">
<div class="content-box">
	<h1><% $category[name] %></h1>
	<p class="description"><% $category[description] %></p>
	
	<% if $propertylist %>
	<button class="btn_show_filter" type="button">
		<% switch from = $id_language %>
			<% case value='hu' %>Szűrők megjelenítése
			<% case %>Show filters
		<% /switch %>
	</button>
	<div id="filter">
		<button class="btn_close" type="button">
			<% switch from = $id_language %>
				<% case value='hu' %>Bezárás
				<% case %>Close
			<% /switch %>
		</button>
		<form id="form_filter" action="<% $siteconfig[site_url] %>/<% $permalink_category %>" method="get">
		<fieldset>
			<input name="filter" type="hidden" />
	<% foreach from=$propertylist item=property %>
		<div id="property_<% $property[id_property] %>" class="property">
			<span class="property_name"><% $property[name] %></span>
			<ul>
				<% foreach from=$property[valuelist] item=value %>
				<li>
					<input id="property_value_<% $value[id_value] %>" type="checkbox" value="<% $value[id_value] %>" <% if $value[checked] %>checked="checked"<% /if %>/>
					<label for="property_value_<% $value[id_value] %>"><% $value[value] %></label>
				</li>
				<% /foreach %>
			</ul>
		</div>
	<% /foreach %>
		<button id="btn_filter_submit" type="submit">
		<% switch from = $id_language %>
			<% case value='hu' %>Szűrés
			<% case %>Submit
		<% /switch %>
		</button>
		</fieldset>
		</form>
	</div>
	<% /if %>
	
	<% if $productlist || $packlist %>
	<ul class="productlist results">
	<% foreach from=$productlist item=product %>
		<% include file='_list_item_product.tpl' %>
	<% /foreach %>
	<% foreach from=$packlist item=pack %>
		<% include file='_list_item_pack.tpl' %>
	<% /foreach %>
	</ul>
	<% else %>
	<div class="productlist_empty">
	<% switch from = $id_language %>
		<% case value='hu' %>Nincs megjeleníthető termék
		<% case %>There are no products in this category
	<% /switch %>
	</div>
	<% /if %>
</div>
</div>

<script>
onLoadFunctions.push( function() {
	$("#filter form input").change( function() {
		<%*
			Filter tömb létrehozása:
				A filter tömb kulcsai az id_property-k
				Az elemei olyan tömbök amikben az id_value-k vannak
		*%>
		var filter = new Array();
		$("#filter form input:checked").each( function() {
			var property_id = $(this).closest(".property").attr("id").substr(9);
			if (typeof(filter[property_id]) == "undefined") filter[property_id] = new Array();
			filter[property_id].push($(this).val());
		});
		var filter_serialized_parts = new Array();
		for (key in filter) {
			filter_serialized_parts.push(key+":"+filter[key].join(","));
		}
		var filter_serialized = filter_serialized_parts.join(";");
		$("input[name=filter]", $(this).closest("form")).val(filter_serialized);
	} );


	$("#filter form").submit( function() {
		window.location = $(this).attr("action")+"?filter="+$("input[name=filter]", this).val();
		return false;
	});
	
	$(".btn_show_filter").click( function() {
		$("#filter").animate({
			opacity: 'toggle',
			height: 'toggle'
			}, 500
		);
	});
	
	$("#filter .btn_close").click( function() {
		$("#filter").animate({
			opacity: 'toggle',
			height: 'toggle'
			}, 500
		);
	});
});
</script>

<% include file='_basket_script.tpl' %>

<% include file='_footer.tpl' %>

