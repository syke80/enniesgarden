<script>
jQuery.fn.refreshPropertyBox = function(id_property_edit) {
	this.each(function(i){
		var url = "<% $siteconfig[site_url] %>/category/edit/property/<% $info[id_category] %>/"+$(this).attr("language_iso");
		if (typeof id_property_edit != "undefined") url += "/"+id_property_edit;
		$(this).load(url);
	});
}

function edit_success(data) {
	$("#category_list").conscendoTable("load");
	$.simplebox('destroy', 'category_edit_popup');
}
</script>

<% form form_id='edit' itemtype='form' action='/category/'.$info[id_category].'/' method='put' %>
	<% foreach from=$languagelist item=language %>
		<% assign name='id_language' value=$language[id_language] %>
		<% assign name='text_info' value=$text[$id_language] %>
		<% form itemtype='fieldset' name=$language[iso].'_text' extraclass='edit_text' %>
			<% form itemtype='text'     name=$language[iso].'_name'              label='Name ('.$language[iso].')'          default=$text_info[name] %>
			<% form itemtype='text'     name=$language[iso].'_permalink'         label='Permalink ('.$language[iso].')'     default=$text_info[permalink] %>
			<% form itemtype='textarea' name=$language[iso].'_description'       label='Description ('.$language[iso].')'   default=$text_info[description] %>
	<% /foreach %>

	<% form itemtype='fieldset' name='buttons' %>
		<% form itemtype='submit'   name='ok' label='OK' %>

	<% form cmd='error_msg' id='empty_name' msg='Please fill the name field' %>
	<% form cmd='error_msg' id='empty_permalink' msg='Please fill the permalink field' %>
	<% form cmd='error_msg' id='already_permalink' msg='Permalink is already in use' %>
<% form cmd='render_form' %>
<% form cmd='render_javascript' function_success='edit_success(data);' msg_success='The changes have been saved' %>

<div id="edit_language_select">
	<% foreach from=$languagelist item=language %>
	<button lang_iso="<% $language[iso] %>"><% $language[iso] %> - <% $language[name] %></button>
	<% /foreach %>
</div>

<script>
$("#edit_language_select button").click( function() {
	$("#edit_language_select button").removeClass("active");
	$(this).addClass("active");
	$("#form_edit .edit_text").hide();
	$("#form_edit fieldset[name="+$(this).attr("lang_iso")+"_text]").show();
});
$("#edit_language_select button:first").trigger("click");

<% foreach from=$languagelist item=language %>
$("fieldset[name=<% $language[iso] %>_text]").append("<div class=\"property_container\" language_iso=\"<% $language[iso] %>\"></div>");
<% /foreach %>
$(".property_container").refreshPropertyBox();
</script>
