<script type="text/javascript">
$(document).ready( function() {
	$("#form_shipping_status_<% $order[id_order] %>").ajaxForm({
		dataType: "json",
		success: function(data) {
			if (data.error == "") {
				$.jGrowl("The changes has been successfully saved.");
				// adatok frissítése a #details-ben
				$("#form_shipping_status_<% $order[id_order] %>").parent().load("<% $siteconfig[site_url] %>/order/productlist/<% $order[id_order] %>");
				// ha shipped, vagy canceled, akkor eltűnik a listából, frissíteni kell
				if ($("#form_shipping_status_<% $order[id_order] %> [name=shipping_status]").val() == 'shipped' || $("#form_shipping_status_<% $order[id_order] %> [name=shipping_status]").val() == 'canceled') {
					$("#order .list").load("<% $siteconfig[site_url] %>/order/list");
				}
			}
			else {
				<% include file='_js_error.tpl' %>
			}
		}
	});
	$("#form_payment_status_<% $order[id_order] %>").ajaxForm({
		dataType: "json",
		success: function(data) {
			if (data.error == "") {
				$.jGrowl("The changes has been successfully saved.");
				// adatok frissítése a #details-ben
//				$("#form_payment_status_<% $order[id_order] %>").parent().load("<% $siteconfig[site_url] %>/order/productlist/<% $order[id_order] %>");
				$("#order .list").load("<% $siteconfig[site_url] %>/order/list?open=<% $order[id_order] %>");
/*
				// ha shipped, vagy canceled, akkor eltűnik a listából, frissíteni kell
				if (
					($("#form_shipping_status_<% $order[id_order] %> [name=shipping_status]").val() == 'shipped' && $("#form_shipping_status_<% $order[id_order] %> [name=shipping_status]").val() == 'success')
					|| $("#form_shipping_status_<% $order[id_order] %> [name=shipping_status]").val() == 'canceled'
				) {
					$("#order .list").load("<% $siteconfig[site_url] %>/order/list");
				}
*/
			}
			else {
				<% include file='_js_error.tpl' %>
			}
		}
	});
});
</script>
<span class="shipping">
	<span class="title">Shipping details</span>
	<span class="shipping_name sub_item">
		<span class="sub_item_title">Name</span>
		<span class="sub_item_value"><% $order[shipping_name] %></span>
	</span>
	<span class="shipping_postcode sub_item">
		<span class="sub_item_title">Postal code</span>
		<span class="sub_item_value"><% $order[shipping_postcode] %></span>
	</span>
	<span class="shipping_city sub_item">
		<span class="sub_item_title">City</span>
		<span class="sub_item_value"><% $order[shipping_city] %></span>
	</span>
	<span class="shipping_address sub_item">
		<span class="sub_item_title">Address</span>
		<span class="sub_item_value"><% $order[shipping_address] %></span>
	</span>
</span>
<span class="billing">
	<span class="title">Billing details</span>
	<span class="billing_name sub_item">
		<span class="sub_item_title">Name</span>
		<span class="sub_item_value"><% $order[billing_name] %></span>
	</span>
	<span class="billing_postcode sub_item">
		<span class="sub_item_title">Postal code</span>
		<span class="sub_item_value"><% $order[billing_postcode] %></span>
	</span>
	<span class="billing_city sub_item">
		<span class="sub_item_title">City</span>
		<span class="sub_item_value"><% $order[billing_city] %></span>
	</span>
	<span class="billing_address sub_item">
		<span class="sub_item_title">Address</span>
		<span class="sub_item_value"><% $order[billing_address] %></span>
	</span>
</span>

<span class="shipping_method">
		<span class="label">Shipping method</span>
		<span class="value">
		<% $order[shipping_method_name] %>
		</span>
</span>

<span class="payment_method">
		<span class="label">Payment method</span>
		<span class="value">
		<% $order[payment_method_name] %>
		</span>
</span>

<ul class="productlist">
	<% foreach from=$productlist item=item %>
	<li>
		<span class="name"><% $item[name] %></span>
		<span class="quantity"><% $item[quantity] %> pc</span>
		<span class="subtotal">£<% $item[total]|number_format:2:'.':' ' %></span>
	</li>
	<% /foreach %>
	<% foreach from=$packlist item=item %>
	<li>
		<span class="name"><% $item[name] %></span>
		<span class="quantity"><% $item[quantity] %> pc</span>
		<span class="subtotal">£<% $item[total]|number_format:2:'.':' ' %></span>
	</li>
	<% /foreach %>
</ul>
<span class="shipping_cost">
		<span class="label">Shipping cost</span>
		<span class="value">£<% $order[shipping_cost]|number_format:2:'.':' ' %></span>
</span>
<span class="order_total">
		<span class="label">Total</span>
		<span class="value">£<% $order[total]|number_format:2:'.':' ' %></span>
</span>

<form id="form_shipping_status_<% $order[id_order] %>" action="<% $siteconfig[site_url] %>/order/<% $order[id_order] %>/" method="put">
<span class="sub_item">
	<span class="sub_item_title">Shipping Status</span>
	<span class="sub_item_value">
	<select name="shipping_status">
		<% switch from=$order[shipping_status] %>
		<% case value='pending' %>
		<option value="" selected="selected">Pending</option>
		<option value="approved">Approved</option>
		<option value="shipped">Shipped</option>
		<option value="canceled">Canceled</option>
		<% case value='approved' %>
		<option value="" selected="selected">Approved</option>
		<option value="shipped">Shipped</option>
		<option value="canceled">Canceled</option>
		<% case value='shipped' %>
		<option value="" selected="selected">Shipped</option>
		<option value="canceled">Canceled</option>
		<% /switch %>
	</select>
	<button class="btn_update_shipping_status" type="submit">Update shipping status</button>
	</span>
</span>
</form>
<script>
	$("#form_shipping_status_<% $order[id_order] %> button").attr("disabled", "disabled");
	$("#form_shipping_status_<% $order[id_order] %> select").change( function() {
		if ($(this).val() == "") $("button", $(this).parent()).attr("disabled", "disabled");
		else $("button", $(this).parent()).removeAttr("disabled");
	});
</script>

<form id="form_payment_status_<% $order[id_order] %>" action="<% $siteconfig[site_url] %>/order/<% $order[id_order] %>/" method="put">
<span class="sub_item">
	<span class="sub_item_title">Payment Status</span>
	<span class="sub_item_value">
	<select name="payment_status">
		<% switch from=$order[payment_status] %>
		<% case value='pending' %>
		<option value="" selected="selected">Pending</option>
		<option value="confirmed">Confirmed</option>
		<option value="success">Success</option>
		<option value="canceled">Canceled</option>
		<% case value='confirmed' %>
		<option value="" selected="selected">Confirmed</option>
		<option value="success">Success</option>
		<option value="canceled">Canceled</option>
		<% case value='success' %>
		<option value="" selected="selected">Success</option>
		<% case value='declined' %>
		<option value="" selected="selected">Declined</option>
		<% case value='canceled' %>
		<option value="" selected="selected">Canceled</option>
		<% /switch %>
	</select>
	<button class="btn_update_payment_status" type="submit">Update payment status</button>
	</span>
</span>
</form>
<script>
	$("#form_payment_status_<% $order[id_order] %> button").attr("disabled", "disabled");
	$("#form_payment_status_<% $order[id_order] %> select").change( function() {
		if ($(this).val() == "") $("button", $(this).parent()).attr("disabled", "disabled");
		else $("button", $(this).parent()).removeAttr("disabled");
	});
</script>
