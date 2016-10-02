<%*
	ha serialize=true, akkor a checkboxok értékei egy stringben lesznek továbbítva.
	ilyenkor az input neve source_ prefixet kap. az eredeti néven egy hidden mező lesz továbbítva, ami a serializált értékeket tartalmazza
	pl.:
	                    a szervernek küldött változó     a checkbox name attribútuma
	serialize=false     chkvar=1;chkvar=5;chkvar=15      chkvar
	serialize=true      chkvar=1,5,15                    source_chkvar
*%>
<div id="item_<% $id %>_<% $item[name] %>" class="form_item">
	<label><% $item[label] %></label>
	<div id="<% $id %>_<% $item[name] %>" class="chk_list">
		<% if $item[serialize]==true %>
		<input type="hidden" name="<% $item[name] %>" />
		<% /if %>
		<% foreach from=$item[checkboxes] value='checkbox' %>
		<div class="chk_item">
			<input id="<% $id %>_<% $item[name] %>_<% $checkbox[value] %>" <% if $checkbox[extraclass] %>class="<% $checkbox[extraclass] %>"<% /if %> name="<% if $item[serialize]==false %><% $item[name] %><% else %>source_<% $item[name] %><% /if %>" type="checkbox" value="<% $checkbox[value] %>" <% if $checkbox[checked] %>checked="checked"<% /if%> />
			<label for="<% $id %>_<% $item[name] %>_<% $checkbox[value] %>"><% $checkbox[label] %></label>
		</div>
		<% /foreach %>
	</div>
</div>
