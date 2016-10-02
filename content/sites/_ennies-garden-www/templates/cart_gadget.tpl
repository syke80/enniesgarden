<% switch from = $id_language %>
	<% case value='hu' %><% assign name='cart_url' value=$siteconfig[site_url].'/kosar' %>
	<% case %><% assign name='cart_url' value=$siteconfig[site_url].'/basket/' %>
<% /switch %>
<a id="cart_content" href="<% $cart_url %>" <% if $count==0 %>class="empty"<% /if %>>
	<h3 class="imgreplace">
		<% switch from = $id_language %>
			<% case value='hu' %>Kosár
			<% case %>Shopping cart
		<% /switch %>
	</h3>
	<span class="count">
		<% switch from = $id_language %>
			<% case value='hu' %><span class="value"><% $count %></span> <span class="unit">termék</span>
			<% case %>
				<% switch from = $count %>
					<% case value=0 %><span class="value">Your basket is empty</span>
					<% case value=1 %><span class="value"><% $count %></span> <span class="unit">item</span>
					<% case %><span class="value"><% $count %></span> <span class="unit">items</span>
				<% /switch %>
		<% /switch %>
	</span>
	<span class="total">(<span class="currency">£</span><span class="value"><% $total|number_format:0:'':' ' %></span>)</span>
</a>
