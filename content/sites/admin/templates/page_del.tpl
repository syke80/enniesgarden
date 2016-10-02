<script type="text/javascript">
function del_success(data) {
	$.simplebox('destroy', 'del_popup');
	$("#page_list").conscendoTable('load');
}
</script>

<span>Are you sure you want to delete '<% $page[permalink] %>' page on the '<% $page[id_site] %>' site?</span>

<% form form_id='del' itemtype='form' action='/page/' method='delete' %>
	<% form itemtype='hidden' name='id_page' value=$id_page %>
	<% form itemtype='fieldset' name='buttons' %>
	<% form itemtype='button' name='cancel' label='Cancel' %>
	<% form itemtype='submit' name='delete' label='Delete' %>
<% form cmd='render_form' %>
<% form cmd='render_javascript' function_success='del_success(data);' msg_success='Page deleted' %>


<script type="text/javascript">
$("#form_del button[name=cancel]").click( function() {
	$.simplebox('destroy', 'del_popup');
} );
</script>

