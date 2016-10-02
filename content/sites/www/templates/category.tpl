<% assign name='id_language' value=$category[language_iso] %>
<% assign name='pageid' value='category' %>
<% assign name='title' value=$category[name].' | '.$shop[name] %>
<% assign name='description' value=$category[name] %>

<% if $productlist %>
	<% foreach from=$productlist item=product %>
		<% assign name='keywords' value=$keywords.$product[name].', ' %>
		<% assign name='description' value=$description.$product[name].', ' %>
	<% /foreach %>
	<% pagetag name="description" value="..." method="append" %>
<% /if %>


<% include file='_header.tpl' %>

<h1><% $category[name] %></h1>

<% if $propertylist %>
<button class="btn_show_filter" type="button">
	<% switch from = $id_language %>
		<% case value='hu' %>Szűrők megjelenítése
		<% case %>Show filters
	<% /switch %>
</button>
<div id="filter">
	<button class="imgreplace btn_close" type="button">
		<% switch from = $id_language %>
			<% case value='hu' %>Bezárás
			<% case %>Close
		<% /switch %>
	</button>
	<form id="form_filter" action="<% $siteconfig[site_url] %>/<% $permalink_category %>" method="get">
	<fieldset>
		<input name="filter" type="hidden" />
<% assign name='divisor2' value='0' %>
<% assign name='divisor3' value='0' %>
<% assign name='divisor4' value='0' %>
<% assign name='divisor5' value='0' %>
<% foreach from=$propertylist item=property %>
	<div id="property_<% $property[id_property] %>" class="property
	<% expression op1=$divisor2 op2=1 operator='+' assign='divisor2' %><% if $divisor2==2 %>divisor-2<% assign name='divisor2' value='0' %><% /if %>
	<% expression op1=$divisor3 op2=1 operator='+' assign='divisor3' %><% if $divisor3==3 %>divisor-3<% assign name='divisor3' value='0' %><% /if %>
	<% expression op1=$divisor4 op2=1 operator='+' assign='divisor4' %><% if $divisor4==4 %>divisor-4<% assign name='divisor4' value='0' %><% /if %>
	<% expression op1=$divisor5 op2=1 operator='+' assign='divisor5' %><% if $divisor5==5 %>divisor-5<% assign name='divisor5' value='0' %><% /if %>
	">
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
<script>
  $("#filter .property ul").niceScroll({
	touchbehavior: false,
	cursorcolor:"#000000",
	cursoropacitymax:0.7,
	cursorwidth:11,
	cursorborder:"1px solid #000000",
	cursorborderradius:"0px",
	background:"#ccc",
	autohidemode:"false"
}).cursor.css({"background-image":"url(img/mac6scroll.png)"}); // MAC like scrollbar
</script>


<% if $productlist %>
<ul class="productlist">
<% assign name='divisor2' value='0' %>
<% assign name='divisor3' value='0' %>
<% assign name='divisor4' value='0' %>
<% assign name='divisor5' value='0' %>
<% foreach from=$productlist item=product %>
<li class="product 
	<% expression op1=$divisor2 op2=1 operator='+' assign='divisor2' %><% if $divisor2==2 %>divisor-2<% assign name='divisor2' value='0' %><% /if %>
	<% expression op1=$divisor3 op2=1 operator='+' assign='divisor3' %><% if $divisor3==3 %>divisor-3<% assign name='divisor3' value='0' %><% /if %>
	<% expression op1=$divisor4 op2=1 operator='+' assign='divisor4' %><% if $divisor4==4 %>divisor-4<% assign name='divisor4' value='0' %><% /if %>
	<% expression op1=$divisor5 op2=1 operator='+' assign='divisor5' %><% if $divisor5==5 %>divisor-5<% assign name='divisor5' value='0' %><% /if %>
">
	<a class="photo" href="<% $siteconfig[site_url] %>/<% $product[category_permalink] %>/<% $product[permalink] %>">
		<img src="<% imgresize file='content/files/product/original/'.$product[photo_filename] resized_filename='content/files/product/resized/'.$product[id_product]|id2dir.'/'.$product[permalink].'_'.$product[category_permalink].'_'.$product[shop_permalink].'_'.$product[id_photo].'_220x220_fill' width=220 height=220 type='fill' %>" />
	</a>
	<span class="name">
		<a href="<% $siteconfig[site_url] %>/<% $product[category_permalink] %>/<% $product[permalink] %>">
			<% $product[name] %>
		</a>
	</span>
	<span class="short_description">
		<a href="<% $siteconfig[site_url] %>/<% $product[category_permalink] %>/<% $product[permalink] %>">
			<% $product[short_description] %>
		</a>
	</span>
	<span class="price"><% $product[price]|number_format:0:'':' ' %></span>
</li>
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

<script type="text/javascript">
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
</script>

<% include file='_footer.tpl' %>

