<section id="checkout_preview">
	<h2>
		<% switch from = $language_iso %>
			<% case value='hu' %>Összesítés
			<% case %>Order Summary
		<% /switch %>
	</h2>
	<div class="title">
		<% switch from = $language_iso %>
			<% case value='hu' %>
				<span class="product">Termék</span>
				<span class="unit_price">Egységár</span>
				<span class="quantity">Mennyiség</span>
				<span class="price">Ár</span>
			<% case %>
				<span class="product">Product</span>
				<span class="unit_price">Unit price</span>
				<span class="quantity">Quantity</span>
				<span class="price">Price</span>
		<% /switch %>
	</div>
	<% if $cartinfo[product] %>
	<ul class="productlist">
		<% foreach from=$cartinfo[product] item='item' %>
		<li>
			<span class="product"><% $item[name] %></span>
			<span class="unit_price">£<% $item[price]|number_format:2:'.':' ' %></span>
			<span class="quantity"><% $item[quantity] %></span>
			<span class="price">£<% $item[order_price]|number_format:2:'.':' ' %></span>
		</li>
		<% /foreach %>
	</ul>
	<% /if %>
	<% if $cartinfo[pack] %>
	<ul>
		<% foreach from=$cartinfo[pack] item='item' %>
		<li>
			<span class="product"><% $item[name] %></span>
			<span class="unit_price"><% $item[item_price]|number_format:2:'.':' ' %></span>
			<span class="quantity"><% $item[order_quantity] %></span>
			<span class="price">£<% $item[order_price]|number_format:2:'.':' ' %></span>
		</li>
		<% /foreach %>
	</ul>
	<% /if %>

	<% if $shippinginfo %>
	<div class="shipping">
		<% switch from=$shippinginfo[name] %>
			<% case value='personal' %><% assign name='shipping_method_text' value='Personal collection' %>
			<% case value='post-3-day' %><% assign name='shipping_method_text' value='Royal Mail 3-5 day' %>
			<% case value='post+cod' %><% assign name='shipping_method_text' value='Post + Cash on delivery' %>
			<% case value='free-post-3-day' %><% assign name='shipping_method_text' value='Royal Mail 3-5 day' %>
			<% case value='post-1-day' %><% assign name='shipping_method_text' value='Royal Mail 1 day' %>
			<% case value='locker-drop-off' %><% assign name='shipping_method_text' value='Locker Drop Off' %>
			<% case value='free-post-1-day' %><% assign name='shipping_method_text' value='Royal Mail 1 day' %>
			<% case value='free-locker-drop-off' %><% assign name='shipping_method_text' value='Locker Drop Off' %>
			<% case %><% assign name='shipping_method_text' value=$shipping_method[name] %>
		<% /switch %>
		<span class="name">Delivery cost (<% $shipping_method_text %>)</span>
		<span class="price">£<% $shippinginfo[price]|number_format:2:'.':' ' %></span>
	</div>
	<% /if %>
	<div class="total">£<% $cartinfo[total]|number_format:2:'.':' ' %></div>
</section>
