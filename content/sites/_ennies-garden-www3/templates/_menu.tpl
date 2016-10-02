<button id="menu-button" class="fa fa-bars"></button>
<nav id="menu">
	<ul>
	<% menu name=$siteconfig[shop_permalink].'-'.$id_language.'-1' assign='menutree' %>
	<% counter start=1 print=false assign='menu_counter' %>
	<% foreach from=$menutree item=menu %>
	<li class="main-menu-item main-menu-item-<% $menu_counter %>">
		<a href="<% $menu[url] %>"<% if $menu[is_popup]=='y' %> target="_blank"<% /if %>><% $menu[title] %></a>
	</li>
	<% counter %>
	<% /foreach %>
	</ul>
	<ul>
	<% menu name=$siteconfig[shop_permalink].'-'.$id_language.'-2' assign='menutree' %>
	<% counter start=1 print=false assign='menu_counter' %>
	<% foreach from=$menutree item=menu %>
	<li class="main-menu-item main-menu-item-<% $menu_counter %>">
		<a href="<% $menu[url] %>"<% if $menu[is_popup]=='y' %> target="_blank"<% /if %>><% $menu[title] %></a>
	</li>
	<% counter %>
	<% /foreach %>
	</ul>
</nav>
<script>
	onLoadFunctions.push( function() {
		$("#menu-button").click( function() {
			$("#menu").slideToggle(500);
			$("#cart-container").slideUp(500);
			$("#search-container").slideUp(500);
			$(this).blur();
		});
	});
</script>
