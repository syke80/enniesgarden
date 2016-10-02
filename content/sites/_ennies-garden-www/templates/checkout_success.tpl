<% switch from = $id_language %>
	<% case value='hu' %><% assign name='title' value='Megrendelés | '.$shop[name] %>
	<% case %><% assign name='title' value='Checkout | '.$shop[name] %>
<% /switch %>
<% include file='_header.tpl' %>

<div class="content-box">
	<div class="outline">
		<div class="checkout_success">
		
		<% switch from = $id_language %>
			<% case value='hu' %>
				<h1>Megrendelését rögzítettük</h1>
				<span>Köszönjük a vásárlást</span><br />
				<a href="<% $siteconfig[site_url] %>">Vissza a főoldalra</a>
			<% case %>
				<h1>We’ll let you know once your package has dispatched.</h1>
				<span>Thanks for your order.</span><br />
				<a href="<% $siteconfig[site_url] %>">Back to the index page</a>
		<% /switch %>
		
		</div>
	</div>
</div>

<% include file='_footer.tpl' %>