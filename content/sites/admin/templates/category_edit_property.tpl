<div class="propertybox" language_iso="<% $language_iso %>">
	<div class="list">
		<span class="property_title">Properties</span>
		<% if $list %>
			<% foreach from=$list item=item %>
			<div id="property_item_<% $item[id_property] %>" class="property_item">
				<% if $item[id_property]==$id_property_edit %>
					<% form form_id='property_edit_'.$language_iso itemtype='form' action='/property/'.$item[id_property].'/' method='put' %>
						<% form itemtype='hidden' name='language_iso' value=$language_iso %>
						<% form itemtype='text'   name='name' default=$item[name] %>
						<% form itemtype='submit' label='Ok' extraclass='item_submit' %>
					
						<% form cmd='error_msg' id='already_property_in_category' msg='The property is already exists in this category' %>
						<% form cmd='error_msg' id='empty_property'               msg='Please fill the property field' %>
					<% form cmd='render_form' %>
					<% form cmd='render_javascript' function_success='$(".property_container").refreshPropertyBox();' %>
				<% else %>
				<span class="name"><% $item[name] %></span>
				<% /if %>
				<a class="btn_edit imgreplace" id_property="<% $item[id_property] %>" language_iso="<% $language_iso %>">Edit</a>
				<a class="btn_delete imgreplace">Delete</a>
			</div>
			<% /foreach %>
		<% /if %>
	</div>

<% form form_id='property_add_'.$language_iso itemtype='form' action='/property/' method='put' extraclass='property_add' %>
	<% form itemtype='hidden' name='id_category'  value=$id_category %>
	<% form itemtype='hidden' name='language_iso' value=$language_iso %>
	<% form itemtype='text'   name='name' %>
	<% form itemtype='submit' label='Add' extraclass='item_submit' %>

	<% form cmd='error_msg' id='already_property_in_category' msg='The property is already exists in this category' %>
	<% form cmd='error_msg' id='empty_property'               msg='Please fill the property field' %>
<% form cmd='render_form' %>
<% form cmd='render_javascript' function_success='$(".property_container").refreshPropertyBox();' %>

</div>

<script>
$(".propertybox .list").imgReplace();

$(".propertybox[language_iso=<% $language_iso %>] .list .property_item").mouseenter( function() {
	$(this).addClass("active");
}).mouseleave( function() {
	$(this).removeClass("active");
});

$(".propertybox[language_iso=<% $language_iso %>] .list .property_item .btn_delete").click( function() {
	$.simplebox( {
		"url": "<% $siteconfig[site_url] %>/property/delete/"+$(this).parent().attr("id").substr(14),
		"simplebox_id": "property_del",
		"title": "Delete",
		"width": 360,
		"height": 100,
		"destroy_callback": function() { $(".property_container").refreshPropertyBox(); }
	})
});

$(".propertybox[language_iso=<% $language_iso %>] .list .property_item .btn_edit").click( function() {
	$(".property_container[language_iso="+$(this).attr("language_iso")+"]").refreshPropertyBox($(this).attr("id_property"));
});
</script>
