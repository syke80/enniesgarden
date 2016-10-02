<script type="text/javascript">
function edit_success() {
	$.simplebox('destroy', 'edit_popup');
	$("#box_list").load('/menuitem/list/<% $menuitem[id_menu] %>/');
}
</script>

<% form form_id='edit' itemtype='form' action=$siteconfig[site_url].'/menuitem/' method='put' %>
	<% form itemtype='hidden' name='id_menu_item' value=$menuitem[id_menu_item] %>
	<% form itemtype='text' name='title' label='Title' default=$menuitem[title] %>
	<% form itemtype='text' name='url'   label='URL'   default=$menuitem[url] %>
	<% form itemtype='select' name='is_popup' label='Popup' default=$menuitem[is_popup] %>
		<% form itemtype='option' value='y' label='Yes' %>
		<% form itemtype='option' value='n' label='No' %>

	<% form itemtype='submit' name='ok' label='OK' %>
<% form cmd='render_form' %>
<% form cmd='render_javascript' function_success='edit_success();' msg_success='Menu item saved' resetform=false %>
