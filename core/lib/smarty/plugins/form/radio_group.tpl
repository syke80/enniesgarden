<div id="item_<% $id %>_<% $item[name] %>" class="form_item">
	<label><% $item[label] %></label>
	<div id="<% $id %>_<% $item[name] %>" name="<% $item[name] %>" class="radio_list">
		<% foreach from=$item[radiobuttons] value='radiobutton' %>
		<div class="radio_item">
			<input id="<% $id %>_<% $item[name] %>_<% $radiobutton[value] %>" <% if $radiobutton[extraclass] %>class="<% $radiobutton[extraclass] %>"<% /if %> name="<% $item[name] %>" value="<% $radiobutton[value] %>" type="radio" />
			<label for="<% $id %>_<% $item[name] %>_<% $radiobutton[value] %>"><% $radiobutton[label] %></label>
		</div>
		<% /foreach %>
	</div>
</div>
