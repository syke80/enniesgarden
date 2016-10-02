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
	<ul>
		<% foreach from=$orderitems item='item' %>
		<li>
			<span class="product"><% $item[name] %></span>
			<span class="unit_price"><% $item[price]|number_format:0:'':' ' %></span>
			<span class="quantity"><% $item[quantity] %></span>
			<span class="price">£<% $item[total]|number_format:0:'':' ' %></span>
		</li>
		<% /foreach %>
	</ul>
	<% if $shippinginfo%>
	<div class="shipping">
		<% switch from=$shippinginfo[name] %>
			<% case value='personal' %><% assign name='shipping_method_text' value='Személyes átvétel' %>
			<% case value='post' %><% assign name='shipping_method_text' value='Posta' %>
			<% case value='post+cod' %><% assign name='shipping_method_text' value='Posta + utánvét' %>
			<% case %><% assign name='shipping_method_text' value=$shipping_method[name] %>
		<% /switch %>
		<span class="name">Szállítási költség (<% $shipping_method_text %>)</span>
		<span class="value">£<% $shippinginfo[price]|number_format:0:'':' ' %></span>
	</div>
	<% /if %>
	<div class="total">£<% $total|number_format:0:'':' ' %></div>
</section>

<%*
<table width="600" align="center" cellspacing="0" cellpadding="0" style="margin-bottom: 20px;">
	<tr>
		<% switch from = $language_iso %>
			<% case value='en' %>
				<td style="text-align: left; padding: 5px;" width="300">Product</td>
				<td style="text-align: right; padding: 5px;" width="100">Unit price</td>
				<td style="text-align: right; padding: 5px;" width="100">Quantity</td>
				<td style="text-align: right; padding: 5px;" width="100">Price</td>
			<% case value='hu' %>
				<td style="text-align: left; padding: 5px;" width="300">Termék</td>
				<td style="text-align: right; padding: 5px;" width="100">Egységár</td>
				<td style="text-align: right; padding: 5px;" width="100">Mennyiség</td>
				<td style="text-align: right; padding: 5px;" width="100">Ár</td>
		<% /switch %>
	</tr>
	<tr>
		<td colspan="4" style="border-top: 1px solid #999999;"></td>
	</tr>
	<% foreach from=$orderitems item='item' %>
	<tr>
		<td style="text-align: left; padding: 5px;"><% $item[name] %></td>
		<td style="text-align: right; padding: 5px;"><% $item[price]|number_format:0:'':' ' %></td>
		<td style="text-align: right; padding: 5px;"><% $item[quantity] %></td>
		<td style="text-align: right; padding: 5px;"><% $item[total]|number_format:0:'':' ' %> Ft</td>
	</tr>
	<% /foreach %>
	<tr>
		<td colspan="4" style="border-top: 1px solid #999999;"></td>
	</tr>
	<tr>
		<td colspan="4" style="text-align: right; padding: 5px;"><% $total|number_format:0:'':' ' %> Ft</td>
	</tr>
	<tr>
		<td colspan="4" style="border-top: 1px solid #999999;"></td>
	</tr>
</table>
*%>