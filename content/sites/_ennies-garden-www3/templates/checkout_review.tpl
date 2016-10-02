<% switch from = $id_language %>
	<% case value='hu' %><% assign name='title' value='Megrendelés | '.$shop[name] %>
	<% case %><% assign name='title' value='Checkout review | '.$shop[name] %>
<% /switch %>
<% include file='_header.tpl' %>

<div class="wrapper">
	<div class="content-box">
		<h1>
		<% switch from = $id_language %>
			<% case value='hu' %>Áttekintés
			<% case %>Order Review
		<% /switch %>
		</h1>
		<% assign name='checkout_page' value='4' %>
		<% include file='_checkout_steps.tpl' %>

		<div class="checkout-review">
		
		<% switch from = $id_language %>
			<% case value='hu' %>
				Megrendelését rögzítettük<br />
				Köszönjük a vásárlást<br />
				<a href="<% $siteconfig[site_url] %>">Vissza a főoldalra</a>
			<% case %>
				<% if $order[payment_status]=='confirmed' || $order[payment_status]=='success'%>
					<p>
						Thank you for choosing Ennie’s Garden.<br />
						We are confident that you will be delighted with your purchase, please don’t hesitate to share your feelings by email.
					</p>
					<p>
						<a class="btn important" href="<% $siteconfig[site_url] %>">Back to the index page</a>
					</p>
				<% else %>
					There was an error processing the payment.<br />
					<a class="btn important" href="/checkout/charityclear/<% $hash %>/">Click here to try again</a><br />
					Or get in touch with our customer service.
				<% /if %>
		<% /switch %>
		
		</div>
	</div>
</div>

<%* fizetes utan a kupon ervenytelenne valik, de ezen az oldalon normalis, ezert torolni kell a hibauzenetet *%>
<%  assign name='coupon_error' value='' %>

<% include file='_footer.tpl' %>