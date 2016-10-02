<script type="text/javascript">
function toggle_details(item_obj, speed) {
	if ($(".details", item_obj).html() == "") {
		console.log("opening "+$(item_obj).attr("id_order"));
		$(".details", item_obj).load(
			"<% $siteconfig[site_url] %>/order/productlist/"+$(item_obj).attr("id_order"),
			function() {
				$(this).toggle(speed);
				$(item_obj).ScrollTo();
			}
		);
	}
	else {
		console.log("closing "+$(item_obj).attr("id_order"));
		$(".details", item_obj).toggle(speed);
	}
}

$(document).ready( function() {
	$("#order_list ul.admin_list li.item").mouseenter( function() {
		$(this).addClass("active");
	}).mouseleave( function() {
		$(this).removeClass("active");
	});

	$("#order_list .admin_list .item .details").hide();
	$("#order_list .admin_list .item .info").click( function() {
		toggle_details($(this).parent(), 500);
	});
});
</script>

<div id="order_list" class="admin_box">
	<h2>Orders</h2>
	<ul class="admin_list">
		<li class="head">
			<span class="name">Name</span>
			<span class="email">Email</span>
			<span class="phone">Phone number</span>
			<span class="shipping_status">Shipping status</span>
			<span class="payment_status">Payment status</span>
			<span class="date_order">Date of order</span>
			<span class="date_modified">Date of modify</span>
		</li>
		<% if $list %>
		<% foreach from=$list item=item %>
		<li id_order="<% $item[id_order] %>" id="item_<% $item[id_order] %>" class="item">
			<span class="info">
				<span class="name"><% $item[shipping_name] %></span>
				<span class="email"><% $item[email] %></span>
				<span class="phone"><% $item[phone] %></span>
				<span class="shipping_status"><% $item[shipping_status] %></span>
				<span class="payment_status"><% $item[payment_status] %></span>
				<span class="date_order"><% $item[date_order] %></span>
				<span class="date_modified"><% $item[date_modified] %></span>
			</span>
			<span class="details"></span>
		</li>
		<% /foreach %>
		<% /if %>
	</ul>
</div>

<script>
//toggle_details($("#order_list li[id_order=7]"), 0);
if ('<% $open %>') {
	toggle_details($("#order_list li[id_order=<% $open %>]"), 0);
}
$("#btn_test").click( function() {
	//$("#order_list li[id_order=68]").scrollTop();
	//console.log($("#order_list li[id_order=68]").position());
//	alert($("#order_list li[id_order=68]").position()['top'] + $("#order_list li[id_order=68]").height());
//	alert($("#order_list li[id_order=1]").offset()['top']);
$("#order_list li[id_order=68]").ScrollTo();

});
</script>
