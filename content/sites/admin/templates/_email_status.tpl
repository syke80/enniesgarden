<% switch from=$shipping_status %>
	<% case value="approved" %>
		Thank you for shopping with us. <br />Your order has been accepted and is currently being processed by enniesgarden.co.uk.
	<% case value="shipped" %>
		We have dispatched your order and it is now on its way to you!
		<%*
		Below are the details of the shipping method used along with an estimated time it will take for the order to reach you.
		*%>
	<% case value="canceled" %>
		Your order has been canceled.
<% /switch %>
<br /><br />
Ordered products:<br />
<% foreach from=$productlist item=product %>
<% $product[name] %><br />
<% /foreach %>
