<script type="text/javascript">
function add_success(data) {
	if (data.id_menu>0) {
		$.simplebox('destroy', 'add_popup');
		$("#menu_list").conscendoTable('load');
	}
}
</script>

<% form form_id='add' itemtype='form' action='/menu/' method='post' %>
	<% form itemtype='text' name='name' label='Name *' %>
	<% form itemtype='submit' name='ok' label='OK' %>

	<% form cmd='error_msg' id='empty_name' msg='Name is required' %>
	<% form cmd='error_msg' id='already_exists' msg='Menu with this name is already exists' %>
<% form cmd='render_form' %>
<% form cmd='render_javascript' function_success='add_success(data);' msg_success='Menu created' %>
