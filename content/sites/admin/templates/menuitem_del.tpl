<script>
function del_success(data) {
	$.simplebox('destroy', 'del_popup');
	$("#box_list").load('/menuitem/list/<% $menuitem[id_menu] %>/');
}
</script>

<span>Do you really want to delete '<% $menuitem[title] %>' item?</span>

<% form form_id='del' itemtype='form' action='/menuitem/' method='delete' %>
	<% form itemtype='hidden' name='id_menu_item' value=$menuitem[id_menu_item] %>
	<% form itemtype='fieldset' name='buttons' %>
	<% form itemtype='button' name='cancel' label='Cancel' %>
	<% form itemtype='submit' name='delete' label='Delete' %>
<% form cmd='render_form' %>
<% form cmd='render_javascript' function_success='del_success(data);' msg_success='Menu item deleted' %>


<script type="text/javascript">
$("#form_del button[name=cancel]").click( function() {
	$.simplebox('destroy', 'del_popup');
} );
</script>
