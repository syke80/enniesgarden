<script type="text/javascript">
function add_success(data) {
	$.simplebox('destroy', 'add_popup');
	$("#box_list").load('/menuitem/list/<% $id_menu %>/');
}
</script>

<% form form_id='add' itemtype='form' action='/menuitem/' method='post' %>
	<% form itemtype='hidden' name='id_menu'  value=$id_menu %>
	<% form itemtype='text'   name='title'    label='Title *' %>
	<% form itemtype='text'   name='url'      label='Url' %>
	<% form itemtype='select' name='is_popup' label='Popup' default='n' %>
		<% form itemtype='option' value='y' label='Yes' %>
		<% form itemtype='option' value='n' label='No' %>
	<% form itemtype='submit' name='ok'      label='OK' %>

	<% form cmd='error_msg' id='empty_title' msg='Title is required' %>
<% form cmd='render_form' %>
<% form cmd='render_javascript' function_success='add_success(data);' msg_success='Menu item created' %>
<script>
$("#add_title").focus();
</script>