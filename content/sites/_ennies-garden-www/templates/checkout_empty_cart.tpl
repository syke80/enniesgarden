<% switch from = $id_language %>
	<% case value='hu' %><% assign name='title' value=Megrendelés | '.$shop[name] %>
	<% case %><% assign name='title' value='Checkout | '.$shop[name] %>
<% /switch %>
<% include file='_header.tpl' %>
<div class="empty">
	<h1>
	<% switch from = $id_language %>
		<% case value='hu' %>A kosár üres
		<% case %>Your cart is empty
	<% /switch %>
	</h1>
	<div class="action">
		<button id="btn_home" type="button">
			<% switch from = $id_language %>
				<% case value='hu' %>A kosár üres
				<% case %>Your cart is empty
			<% /switch %>		
		</button>
	</div>
</div>
<% include file='_footer.tpl' %>
