<% switch from = $id_language %>
	<% case value='hu' %><% assign name='cart_url' value=$siteconfig[site_url].'/kosar' %>
	<% case %><% assign name='cart_url' value=$siteconfig[site_url].'/cart' %>
<% /switch %>
<a id="cart_content" href="<% $cart_url %>" <% if $count %>class="empty"<% /if %>>
	<h3 class="imgreplace">
		<% switch from = $id_language %>
			<% case value='hu' %>Kosár
			<% case %>Shopping cart
		<% /switch %>
	</h3>
	<span class="count"><span class="value"><% $count %></span> <span class="unit">
		<% switch from = $id_language %>
			<% case value='hu' %>termék
			<% case %>article(s)
		<% /switch %>
	</span></span>
	<span class="total"><span class="value"><% $total|number_format:0:'':' ' %></span> <span class="currency">Ft</span></span>
</a>
