<% if $propertylist %>

<div class="propertybox" language_iso="<% $language_iso %>">
	<span class="property_title">Properties</span>
	<% foreach from=$propertylist item=property %>
	<div id="property_item_<% $property[id_property] %>" class="property_item">
		<span class="property_name"><% $property[name] %></span>
		<% if $property[valuelist] %>
		<% foreach from=$property[valuelist] item=value %>
		<div class="property_value">
			<input id="property_value_<% $value[id_value] %>" class="checkbox" name="id_value[]" type="checkbox" value="<% $value[id_value] %>" <% if $value[ischecked] %>checked="checked"<% /if %>/>
			<label for="property_value_<% $value[id_value] %>"><% $value[value] %></label>
			<a class="btn_delete imgreplace" id_property_value="<% $value[id_value] %>">Delete</a>
		</div>
		<% /foreach %>
		<% /if %>
		<input id="new_property_<% $property[id_property] %>" class="new_property" />
		<button class="btn_new_property" type="button">Add</button>
	</div>
	<% /foreach %>
</div>

<script>
$(".propertybox[language_iso=<% $language_iso %>] .btn_new_property").click(function () {
	var new_property_obj = $(".new_property",$(this).parent());
	$.ajax({
		type: "put",
		url: "<% $siteconfig[site_url] %>/property/value/",
		dataType: "json",
		data: {
			id_property: new_property_obj.attr("id").substr(13),
			language_iso: '<% $language_iso %>',
			name: new_property_obj.val()
		},
		success: function (data, textStatus) {
			if (data.error == "") {
				$(".property_container").refreshPropertyBox();
			}
			else {
				<% include file='_js_error.tpl' %>
			}
		}
	});
	return false;
})

// Enter kezelése az add fieldben
$(".propertybox[language_iso=<% $language_iso %>] .new_property").keypress( function(event) {
	if (event.which == 13) {
		$(".btn_new_property", $(this).parent()).trigger("click");
		return false;
	}
});

$(".propertybox[language_iso=<% $language_iso %>]").imgReplace();

$(".propertybox[language_iso=<% $language_iso %>] .property_value").mouseenter( function() {
	$(this).addClass("active");
}).mouseleave( function() {
	$(this).removeClass("active");
});

$(".propertybox[language_iso=<% $language_iso %>] .property_value .btn_delete").click( function() {
	$.simplebox( {
		"url": "<% $siteconfig[site_url] %>/property/value/delete/"+$(this).attr("id_property_value"),
		"simplebox_id": "property_value_del",
		"title": "Delete",
		"width": 360,
		"height": 100,
		"destroy_callback": function() {
			$(".property_container").refreshPropertyBox();
		}
	})
});

// Checkboxok szinkronizalasa: ha kivalaszt egy checkboxot, akkor a tobbi nyelven is legyen bejelolve
$(".propertybox[language_iso=<% $language_iso %>] input[type=checkbox]").change( function() {
	$(".propertybox input[type=checkbox][value="+$(this).val()+"]").prop("checked", $(this).prop("checked"));
});

</script>
<% /if %>
