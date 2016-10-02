<section id="checkout_preview">
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
	<ul>
		<% foreach from=$cartinfo[product] item='item' %>
		<li>
			<span class="product"><% $item[name] %></span>
			<span class="unit_price"><% $item[item_price]|number_format:0:'':' ' %></span>
			<span class="quantity"><% $item[order_quantity] %></span>
			<span class="price"><% $item[order_price]|number_format:0:'':' ' %> Ft</span>
		</li>
		<% /foreach %>
	</ul>
	<% /if %>

	<% if $cartinfo[pack] %>
	<ul>
		<% foreach from=$cartinfo[pack] item='item' %>
		<li>
			<span class="product"><% $item[name] %></span>
			<span class="unit_price"><% $item[item_price]|number_format:0:'':' ' %></span>
			<span class="quantity"><% $item[order_quantity] %></span>
			<span class="price"><% $item[order_price]|number_format:0:'':' ' %> Ft</span>
		</li>
		<% /foreach %>
	</ul>
	<% /if %>
	<% if $shippinginfo%>
	<div class="shipping">
		<% switch from=$shippinginfo[name] %>
			<% case value='personal' %><% assign name='shipping_method_text' value='Személyes átvétel' %>
			<% case value='post' %><% assign name='shipping_method_text' value='Posta' %>
			<% case value='post+cod' %><% assign name='shipping_method_text' value='Posta + utánvét' %>
			<% case %><% assign name='shipping_method_text' value=$shipping_method[name] %>
		<% /switch %>
		<span class="name">Szállítási költség (<% $shipping_method_text %>)</span>
		<span class="value"><% $shippinginfo[price]|number_format:0:'':' ' %> Ft</span>
	</div>
	<% /if %>
	<div class="total"><% $cartinfo[total]|number_format:0:'':' ' %> Ft</div>
</section>
