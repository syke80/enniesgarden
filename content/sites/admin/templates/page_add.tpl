<script type="text/javascript">
function add_success(data) {
	if (data.id_page>0) {
		$.simplebox('destroy', 'add_popup');
		$("#page_list").conscendoTable('load');
		$.simplebox( {
			"simplebox_id": "edit_popup",
			"url": "<% $siteconfig[site_url] %>/page/edit/"+data.id_page+"/",
			"width": 1000,
			"height": 500
		} );								
	}
}
</script>

<% form form_id='add' itemtype='form' action='/page/' method='post' %>
	<% form itemtype='hidden' name='id_site' value=$id_site %>
	<% form itemtype='text' name='permalink' label='Permalink *' %>
	<% form itemtype='select'   name='id_category'       label='Category' %>
		<% form itemtype='option' value='' label='' %>
		<% foreach from=$categorylist item=category %>
			<% form itemtype='option' value=$category[id_category] label=$category[name] %>
		<% /foreach %>
	<% form itemtype='text' name='new_category' label='Add new category' %>
	<% form itemtype='submit' name='ok' label='OK' %>

	<% form cmd='error_msg' id='empty_permalink' msg='Please fill the permalink field' %>
	<% form cmd='error_msg' id='already_exists' msg='Page with this permalink is already exists' %>
<% form cmd='render_form' %>
<% form cmd='render_javascript' function_success='add_success(data);' msg_success='Page was created' %>

<script>
$("#add_new_category").keydown( function() {
	$("#add_id_category").val("");
	$("#item_add_id_category .select_styled").html( $("#add_id_category option[value="+$("#add_id_category").val()+"]").html() );
});
</script>
