<table width="600" align="center" cellspacing="0" cellpadding="0" style="margin-top: 20px;">
	<tr>
		<td>
				<% switch from = $id_language %>
					<% case value='hu' %>
						Köszönjük a megrendelést<br />
						Megrendelés státusza: Beérkezett<br />
						Rendelés azonosító: <% $id_order %><br />
					<% case %>
						Thank you for your purchase<br />
						Order status: Received<br />
						Order #<% $id_order %><br />
				<% /switch %>
			<br />
			<strong>
				<% switch from = $id_language %>
					<% case value='hu' %>Szállítási cím
					<% case %>Shipping address
				<% /switch %>
			</strong><br />
			<% $shipping_postcode %><br />
			<% $shipping_city %><br />
			<% $shipping_address %><br />
			<br />
			<strong>
				<% switch from = $id_language %>
					<% case value='hu' %>Számlázási cím
					<% case %>Billing address
				<% /switch %>
			</strong><br />
			<% $billing_postcode %><br />
			<% $billing_city %><br />
			<% $billing_address %><br />
		</td>
	</tr>
</table>
<br />
<table width="600" align="center" cellspacing="0" cellpadding="0" style="margin-bottom: 20px;">
	<tr>
		<% switch from = $id_language %>
			<% case value='hu' %>
				<td style="text-align: left; padding: 5px;" width="300">Termék</td>
				<td style="text-align: right; padding: 5px;" width="100">Egységár</td>
				<td style="text-align: right; padding: 5px;" width="100">Mennyiség</td>
				<td style="text-align: right; padding: 5px;" width="100">Ár</td>
			<% case %>
				<td style="text-align: left; padding: 5px;" width="300">Product</td>
				<td style="text-align: right; padding: 5px;" width="100">Unit price</td>
				<td style="text-align: right; padding: 5px;" width="100">Quantity</td>
				<td style="text-align: right; padding: 5px;" width="100">Price</td>
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
		<% switch from = $id_language %>
			<% case value='hu' %>
				<% switch from=$shippinginfo[name] %>
					<% case value='personal' %><% assign name='shipping_method_text' value='Személyes átvétel' %>
					<% case value='post' %><% assign name='shipping_method_text' value='Posta' %>
					<% case value='post+cod' %><% assign name='shipping_method_text' value='Posta + utánvét' %>
					<% case %><% assign name='shipping_method_text' value=$shipping_method[name] %>
				<% /switch %>
				<td colspan="3" style="text-align: left; padding: 5px;">Szállítási költség (<% $shipping_method_text %>)</td>
				<td style="text-align: right; padding: 5px;"><% $shippinginfo[price] %> Ft</td>
			<% case %>
				<% switch from=$shippinginfo[name] %>
					<% case value='personal' %><% assign name='shipping_method_text' value='Personal' %>
					<% case value='post' %><% assign name='shipping_method_text' value='Post' %>
					<% case value='post+cod' %><% assign name='shipping_method_text' value='Post + collect on demand' %>
					<% case %><% assign name='shipping_method_text' value=$shipping_method[name] %>
				<% /switch %>
				<td colspan="3" style="text-align: left; padding: 5px;">Shipping cost (<% $shipping_method_text %>)</td>
				<td style="text-align: right; padding: 5px;"><% $shippinginfo[price] %> Ft</td>
		<% /switch %>
	</tr>
	<tr>
		<td colspan="4" style="border-top: 1px solid #999999;"></td>
	</tr>
	<tr>
		<% switch from = $id_language %>
			<% case value='hu' %>
				<td colspan="3" style="text-align: left; padding: 5px;">Végösszeg</td>
			<% case %>
				<td colspan="3" style="text-align: left; padding: 5px;">Total</td>
		<% /switch %>
		<td style="text-align: right; padding: 5px;"><% $total|number_format:0:'':' ' %> Ft</td>
	</tr>
	<tr>
		<td colspan="4" style="border-top: 1px solid #999999;"></td>
	</tr>
</table>
