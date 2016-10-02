<% switch from = $id_language %>
	<% case value='hu' %><% assign name='title' value='Megrendelés | '.$shop[name] %>
	<% case %><% assign name='title' value='Checkout review | '.$shop[name] %>
<% /switch %>
<% assign name='canonical' value=$siteconfig[site_url].'/paypal/review/' %>
<% include file='_header.tpl' %>

<% if $orderinfo[total] %>
<!-- Google Code for purchase Conversion Page -->
<script type="text/javascript">
/* <![CDATA[ */
<% if !$siteconfig[paypal_testmode] %>
var google_conversion_id = 963685446;
<% /if %>
var google_conversion_language = "en";
var google_conversion_format = "3";
var google_conversion_color = "ffffff";
var google_conversion_label = "tYVBCK6tv1gQxtjCywM";
var google_conversion_value = <% $orderinfo[total] %>;
var google_conversion_currency = "GBP";
var google_remarketing_only = false;
/* ]]> */
</script>
<script type="text/javascript" src="//www.googleadservices.com/pagead/conversion.js">
</script>
<noscript>
<div style="display:inline;">
<img height="1" width="1" style="border-style:none;" alt="" src="//www.googleadservices.com/pagead/conversion/963685446/?value=<% $orderinfo[total] %>&amp;currency_code=GBP&amp;label=tYVBCK6tv1gQxtjCywM&amp;guid=ON&amp;script=0"/>
</div>
</noscript>
<% /if %>

<div class="wrapper">
	<div class="content-box">
		<h1>
		<% switch from = $id_language %>
			<% case value='hu' %>Áttekintés
			<% case %>Order Review
		<% /switch %>
		</h1>

		<div class="checkout-review">
		
		<% switch from = $id_language %>
			<% case value='hu' %>
				Megrendelését rögzítettük<br />
				Köszönjük a vásárlást<br />
				<a href="<% $siteconfig[site_url] %>">Vissza a főoldalra</a>
			<% case %>
				<% if $successful %>
					<p>
						Thank you for choosing Ennie’s Garden.<br />
						We are confident that you will be delighted with your purchase, please don’t hesitate to share your feelings by email.
					</p>
					<p>
						<a class="btn important" href="<% $siteconfig[site_url] %>">Back to the index page</a>
					</p>
				<% else %>
					There was an error processing the payment. <br />
					Your card was <strong>not</strong> charged. <br />
					<a class="btn important" href="/basket/">Click here to try again</a><br />
					Or get in touch with our customer service.
				<% /if %>
		<% /switch %>
		
		</div>
	</div>
</div>

<% include file='_footer.tpl' %>