<script type="text/javascript">
function add_success(data) {
	$.simplebox('destroy', 'category_add_popup');
	$("#category_list").conscendoTable("load");
	$.simplebox( {
		"simplebox_id": "category_edit_popup",
		"url": "<% $siteconfig[site_url] %>/category/edit/"+data.id_category,
		"width": 1000,
		"height": 500
	} );								
}
$(document).ready(function() {
	// Suggest
	$.permalink_suggest = true;
	$("#add_name").keyup( function() {
		if (!$.permalink_suggest) return;
		$("#add_permalink").val( this.value.URLize() );
	});
	$("#add_permalink").keypress( function() {
		$.permalink_suggest = false;
	});
});
</script>

<% form form_id='add' itemtype='form' action='/category/' method='put' %>
	<% form itemtype='hidden' name='id_shop' value=$user[id_shop] %>
	<% foreach from=$languagelist item=language %>
		<% assign name='id_language' value=$language[id_language] %>
		<% assign name='text_info' value=$text[$id_language] %>
		<% form itemtype='fieldset' name=$language[iso].'_text' extraclass='add_text' %>
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
<% form cmd='render_javascript' function_success='add_success(data);' msg_success='Category was successfully added' %>

<div id="add_language_select">
	<% foreach from=$languagelist item=language %>
	<button lang_iso="<% $language[iso] %>"><% $language[iso] %> - <% $language[name] %></button>
	<% /foreach %>
</div>

<script>
$("#add_language_select button").click( function() {
	$("#add_language_select button").removeClass("active");
	$(this).addClass("active");
	$("#form_add .add_text").hide();
	$("#form_add fieldset[name="+$(this).attr("lang_iso")+"_text]").show();
});
$("#add_language_select button:first").trigger("click");
</script>
