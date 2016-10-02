<% include file='_header.tpl' %>
<div class="content_logout">
	<% switch from = $id_language %>
		<% case value='hu' %>
			<h1>Kijelentkezés</h1>
			<p>Sikeres kijelentkezés</p>
			<p><a href="<% $siteconfig[site_url] %>">Tovább a főoldalra...</a></p>
		<% case %>
			<h1>Logout</h1>
			<p>You have successfully logged out.</p>
			<p><a href="<% $siteconfig[site_url] %>">Back to the index page...</a></p>
	<% /switch %>
</div>
<% include file='_footer.tpl' %>
