<div <% if $item[name] %>id="item_<% $id %>_<% $item[name] %>"<% /if %> class="form_item <% if $item[extraclass] %> <% $item[extraclass] %><% /if %>">
	<button type='button' name="<% $item[name] %>"><% $item[label] %></button>
</div>
