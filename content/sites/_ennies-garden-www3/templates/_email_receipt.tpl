<table width="600" align="center" cellspacing="0" cellpadding="0" style="margin-top: 20px;">
	<tr>
		<td>
				<% switch from = $id_language %>
					<% case value='hu' %>
						Köszönjük a megrendelést<br />
						Megrendelés státusza: Beérkezett<br />
					<% case %>
						Thank you for your purchase<br />
						Order status: Received<br />
				<% /switch %>
			<br />
			<strong>
				<% switch from = $id_language %>
					<% case value='hu' %>Szállítási cím
					<% case %>Shipping address
				<% /switch %>
			</strong><br />
			<% $orderinfo[shipping_postcode] %><br />
			<% $orderinfo[shipping_city] %><br />
			<% $orderinfo[shipping_address] %><br />
			<br />
			<% if $orderinfo[billing_postcode] || $orderinfo[billing_city] || $orderinfo[billing_address] %>
			<strong>
				<% switch from = $id_language %>
					<% case value='hu' %>Számlázási cím
					<% case %>Billing address
				<% /switch %>
			</strong><br />
			<% $orderinfo[billing_postcode] %><br />
			<% $orderinfo[billing_city] %><br />
			<% $orderinfo[billing_address] %><br />
			<% /if %>
		</td>
	</tr>
</table>
<br />
<table width="600" align="center" cellspacing="0" cellpadding="0" style="margin-bottom: 20px;">
	<tr>
		<% switch from = $id_language %>
			<% case value='hu' %>
				<td style="text-align: left; padding: 5px;" width="300">Termék</td>
				<td style="text-align: center; padding: 5px;" width="100">Mennyiség</td>
				<td style="text-align: right; padding: 5px;" width="100">Ár</td>
			<% case %>
				<td style="text-align: left; padding: 5px;" width="300">Product</td>
				<td style="text-align: center; padding: 5px;" width="100">Quantity</td>
				<td style="text-align: right; padding: 5px;" width="100">Price</td>
		<% /switch %>
	</tr>
	<tr>
		<td colspan="4" style="border-top: 1px solid #999999;"></td>
	</tr>
	<% foreach from=$products item='item' %>
	<tr>
<%*
		<td style="text-align: left; padding: 5px;"><a href="<% $siteconfig[site_url] %>/<% $item[permalink] %>" target="_blank"><% $item[name] %></a></td>
*%>
		<td style="text-align: left; padding: 5px;"><% $item[name] %></td>
		<td style="text-align: center; padding: 5px;"><% $item[quantity] %></td>
		<td style="text-align: right; padding: 5px;">£<% $item[total]|number_format:2:'.':' ' %></td>
	</tr>
	<% /foreach %>
	<% foreach from=$packs item='item' %>
	<tr>
<%*
		<td style="text-align: left; padding: 5px;"><a href="<% $siteconfig[site_url] %>/<% $item[permalink] %>" target="_blank"><% $item[name] %></a></td>
*%>
		<td style="text-align: left; padding: 5px;"><% $item[name] %></td>
		<td style="text-align: center; padding: 5px;"><% $item[quantity] %></td>
		<td style="text-align: right; padding: 5px;">£<% $item[total]|number_format:2:'.':' ' %></td>
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
				<td style="text-align: right; padding: 5px;">£<% $orderinfo[shipping_cost] %></td>
			<% case %>
				<% switch from=$shippinginfo[name] %>
					<% case value='personal' %><% assign name='shipping_method_text' value='Personal' %>
					<% case value='post' %><% assign name='shipping_method_text' value='Post' %>
					<% case value='post+cod' %><% assign name='shipping_method_text' value='Post + collect on demand' %>
					<% case value='hermes' %><% assign name='shipping_method_text' value='Next day delivery' %>
					<% case %><% assign name='shipping_method_text' value=$shipping_method[name] %>
				<% /switch %>
				<td colspan="2" style="text-align: left; padding: 5px;">Shipping cost (<% $shipping_method_text %>)</td>
				<td style="text-align: right; padding: 5px;">£<% $orderinfo[shipping_cost] %></td>
		<% /switch %>
	</tr>
	<tr>
		<td colspan="4" style="border-top: 1px solid #999999;"></td>
	</tr>
	<tr>
		<% switch from = $id_language %>
			<% case value='hu' %>
				<td colspan="2" style="text-align: left; padding: 5px;">Végösszeg</td>
			<% case %>
				<td colspan="2" style="text-align: left; padding: 5px;">Total</td>
		<% /switch %>
		<td style="text-align: right; padding: 5px;">£<% $total|number_format:2:'.':' ' %></td>
	</tr>
	<tr>
		<td colspan="3" style="border-top: 1px solid #999999;"></td>
	</tr>
</table>
