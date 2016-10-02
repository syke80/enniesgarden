<script type="text/javascript">
function edit_success() {
	$("#page_list").conscendoTable('load');
}
</script>

<% form form_id='edit' itemtype='form' action=$siteconfig[site_url].'/menu/' method='put' %>
  <% form itemtype='hidden' name='id_menu' value=$menu[id_menu] %>
  <% form itemtype='text' name='name' label='Name' default=$menu[name] %>

	<% form itemtype='submit' name='ok' label='OK' %>
<% form cmd='render_form' %>
<% form cmd='render_javascript' function_success='edit_success();' msg_success='Menu saved' resetform=false %>

