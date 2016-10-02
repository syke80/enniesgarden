<li id="menu_item_<% $info[id_menu_item] %>">
	<div id="item_<% $info[id_menu_item] %>" class="item">
		<span class="title cell"><% $info[title] %></span>
		<span class="url cell"><% $info[url] %>&nbsp;</span>
		<span class="parent cell">
			<select>
				<option value="0">-- Main menu --</option>
				<% foreach from=$itemlist item=parentmenu %>
				<% if $parentmenu[id_parent]==0 && $parentmenu[id_menu_item]!=$info[id_menu_item] %>
				<option value="<% $parentmenu[id_menu_item] %>"<% if $parentmenu[id_menu_item]==$info[id_parent] %>selected="selected"<% /if %>><% $parentmenu[title] %></option>
				<% /if %>
				<% /foreach %>
			</select>
		</span>
		<span id_menu_item="<% $info[id_menu_item] %>" class="edit cell">Edit</span>
		<span id_menu_item="<% $info[id_menu_item] %>" class="del cell">Del</span>

	</div>
	<% if $info[children] %>
	<ul class="submenulist">
		<% assign name='submenulist' value=$info[children] %>
		<% foreach from=$submenulist item=submenu %>
			<% assign name='info' value=$submenu %>
			<% include file='_menu_list_item.tpl' %>
		<% /foreach %>
	</ul>
	<% /if %>
</li>
