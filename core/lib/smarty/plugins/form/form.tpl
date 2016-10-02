<form id="form_<% $id %>" action="<% $action %>" method="<% $method %>">
<% foreach from=$fieldsets value='fieldset' key='fieldset_name' %>
	<fieldset name="<% $fieldset_name %>"<% if $fieldset[extraclass] %> class="<% $fieldset[extraclass] %>"<% /if %>>
	<% if $fieldset[legend] %>
		<legend><% $fieldset[legend] %></legend>
	<% /if %>
	<% foreach from=$fieldset[items] value=item %>
	<% expression op1='form/' op2=$item[type] operator='.' assign='filename' %>
	<% expression op1=$filename op2='.tpl' operator='.' assign='filename' %>
	<% include file=$filename %>
	<% /foreach %>
	</fieldset>
<% /foreach %>
</form>