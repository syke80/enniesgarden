<table>
<tr>
<% foreach from=$titles item='title' %>
	<td><% $title %></td>
<% /foreach %>
</tr>

<% foreach from=$data item='record' %>
<tr>
	<% foreach from=$fields item='field' %>
		<td><% $record[$field] %></td>
	<% /foreach %>
</tr>
<% /foreach %>
</table>
