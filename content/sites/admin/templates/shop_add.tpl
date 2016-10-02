<script>
function add_success(data) {
	if (data.id_shop>0) {
//		$("#page_list").conscendoTable('load');
		$("#shop .list").load("<% $siteconfig[site_url] %>/shop/list/");
		$.simplebox('destroy', 'add_popup');
		$.simplebox( {
			"simplebox_id": "edit_popup",
			"url": "<% $siteconfig[site_url] %>/shop/edit/"+data.id_shop+"/",
			"title": "Edit",
			"width": 500,
			"height": 400
		} );								
	}
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

<% form form_id='add' itemtype='form' action='/shop/' method='put' %>
	<% form itemtype='text' name='name' label='Name' %>
	<% form itemtype='text' name='permalink' label='Permalink' %>

	<% form itemtype='chk_group' name='language[]' label='Language' %>
		<% foreach from=$languagelist item=language %>
			<% form itemtype='chk' value=$language[id_language] label=$language[iso].' - '.$language[name] checked=$language[checked] %>
		<% /foreach %>

	<% form itemtype='text' name='company_name'        label='Company name' %>
	<% form itemtype='text' name='company_url'         label='Company website' %>
	<% form itemtype='text' name='company_email'       label='Company contact | email' %>
	<% form itemtype='text' name='company_phone'       label='Company contact | phone number' %>
	<% form itemtype='text' name='company_city'        label='Company contact | city' %>
	<% form itemtype='text' name='company_address'     label='Company contact | address' %>
	<% form itemtype='text' name='company_postcode'    label='Company contact | postal code' %>
	<% form itemtype='text' name='company_country'     label='Company contact | country' %>
	<% form itemtype='text' name='company_description' label='Description of company' %>

	<% form itemtype='submit' name='ok' label='OK' %>

	<% form cmd='error_msg' id='empty_permalink' msg='Please fill the permalink field' %>
	<% form cmd='error_msg' id='empty_name' msg='Please fill the name field' %>
	<% form cmd='error_msg' id='empty_language' msg='Please select at least one language' %>
	<% form cmd='error_msg' id='already_permalink' msg='Permalink is already in use' %>
<% form cmd='render_form' %>
<% form cmd='render_javascript' function_success='add_success(data);' msg_success='Shop was successfully created' %>
