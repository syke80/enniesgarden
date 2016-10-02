<% switch from = $id_language %>
	<% case value='hu' %><% assign name='title' value='Megrendelés | '.$shop[name] %>
	<% case %><% assign name='title' value='Checkout | '.$shop[name] %>
<% /switch %>
<% include file='_header.tpl' %>

<div class="wrapper">
	<div class="content-box">
		<h1>
			<% switch from = $id_language %>
				<% case value='hu' %>Kosár
				<% case %>Basket
			<% /switch %>
		</h1>
		<div class="empty-cart">
			<p class="error-message">
			<% switch from = $id_language %>
				<% case value='hu' %>A kosár üres
				<% case %>Your cart is empty
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
		</div>
	</div>
</div>
<% include file='_footer.tpl' %>
