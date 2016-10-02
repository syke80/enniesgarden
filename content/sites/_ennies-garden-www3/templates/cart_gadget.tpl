<% switch from = $id_language %>
	<% case value='hu' %>
		<% assign name='cart_url' value=$siteconfig[site_url].'/kosar/' %>
		<% assign name='checkout_url' value=$siteconfig[site_url].'/penztar/' %>
	<% case %>
		<% assign name='cart_url' value=$siteconfig[site_url].'/basket/' %>
		<% assign name='checkout_url' value=$siteconfig[site_url].'/checkout/' %>
<% /switch %>
<button id="cart-button" class="fa fa-shopping-cart">
	<span class="count">
		<% $count %>
	</span>
</button>
<div id="cart-container">
	<a id="cart_content" href="<% $cart_url %>" <% if $count==0 %>class="empty"<% /if %>>
		<span class="count-text">
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
		<span class="total">(<span class="currency">£</span><span class="value"><% $total|number_format:2:'.':' ' %></span>)</span>
	</a>
	<a class="btn continue-cart-button" href="<% $cart_url %>">
		Basket details
	</a>
	<a class="btn continue-checkout-button" href="<% $checkout_url %>">
		Checkout now
	</a>
</div>
<script>
$("#cart-button").click( function() {
	if (!$("#viewport-indicator .tablet").is(":visible")) $("#menu").slideUp(500);
	$("#cart-container").slideToggle(500);
	$("#search-container").slideUp(500);

	$(this).blur();
});
</script>
