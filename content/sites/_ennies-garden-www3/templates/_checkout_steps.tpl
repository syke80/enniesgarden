<div class="steps">
	<ul class="steps">
		<li <% if $checkout_page>1 %>class="completed"<% /if %> <% if $checkout_page==1 %>class="active"<% /if %>><span class="order">1</span>Sign In</li>
		<li <% if $checkout_page>2 %>class="completed"<% /if %> <% if $checkout_page==2 %>class="active"<% /if %>><span class="order">2</span>Delivery details</li>
		<li <% if $checkout_page>3 %>class="completed"<% /if %> <% if $checkout_page==3 %>class="active"<% /if %>><span class="order">3</span>Payment</li>
		<li <% if $checkout_page==4 %>class="active"<% /if %>><span class="order">4</span>Order Review</li>
	</ul>
</div>
