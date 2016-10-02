<% switch from = $id_language %>
	<% case value='hu' %><% assign name='title' value='Megrendelés | '.$shop[name] %>
	<% case %><% assign name='title' value='Checkout | '.$shop[name] %>
<% /switch %>
<% include file='_header.tpl' %>

<div class="wrapper">
	<div class="content-box">
		<h1>
		<% switch from = $id_language %>
			<% case value='hu' %>Áttekintés
			<% case %>Review Checkout
		<% /switch %>
		</h1>

		<% assign name='checkout_page' value='3' %>
		<% include file='_checkout_steps.tpl' %>

		<div class="checkout-charityclear">
<% if !$error %>
			<p>
			Our secure payment partner is Charity Clear.<br /> 
			You will be redirected to charityclear.com's website.<br />
			100% of our payment costs go to charity.
			</p>
			<form action="https://gateway.charityclear.com/paymentform/" method="post">
				<p>
					<input type="hidden" name="merchantID" value="<% $fields[merchantID] %>" />
					<input type="hidden" name="merchantPwd" value="<% $fields[merchantPwd] %>" />
					<input type="hidden" name="amount" value="<% $fields[amount] %>" />
					<input type="hidden" name="countryCode" value="<% $fields[countryCode] %>" />
					<input type="hidden" name="currencyCode" value="<% $fields[currencyCode] %>" />
					<input type="hidden" name="transactionUnique" value="<% $fields[transactionUnique] %>" />
					<input type="hidden" name="redirectURL" value="<% $fields[redirectURL] %>" />
					<input type="hidden" name="callbackURL" value="<% $fields[callbackURL] %>" />
					<input type="hidden" name="action" value="<% $fields[action] %>" />
					<input type="hidden" name="customerName" value="<% $fields[customerName] %>" />
					<input type="hidden" name="customerAddress" value="<% $fields[customerAddress] %>" />
					<input type="hidden" name="customerPostcode" value="<% $fields[customerPostcode] %>" />
					<input type="hidden" name="customerEmail" value="<% $fields[customerEmail] %>" />
					<input type="hidden" name="customerPhone" value="<% $fields[customerPhone] %>" />
					<input type="hidden" name="signature" value="<% $signature %>" />
					<button type="submit">Click here to pay</button>
				</p>
			</form>
<% else %>
			<p class="error-message">
				<% switch from=$error %>
					<% case value='not_found' %>Order not found
					<% case value='status_success' %>Order is already success
					<% case value='status_confirmed' %>Order is already in progress
					<% case value='status_declined' %>Order is declined
				<% /switch %>
			</p>
			<div class="action">
				<a class="btn important" href="/">
					<% switch from = $id_language %>
						<% case value='hu' %>Vissza a főoldalra
						<% case %>Go back to the index page
					<% /switch %>		
				</a>
			</div>
<% /if %>
		</div>
	</div>
</div>
<% include file='_footer.tpl' %>
