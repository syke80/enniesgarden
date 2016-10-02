<% switch from = $id_language %>
	<% case value='hu' %><% assign name='title' value='Kijelentkezés | '.$shop[name] %>
	<% case %><% assign name='title' value='Logout | '.$shop[name] %>
<% /switch %>
<% assign name='canonical' value=$siteconfig[site_url].'/logout/' %>
<% include file='_header.tpl' %>
<div class="wrapper">
	<div class="content-box">
		<div class="auth-logout">
	<% switch from = $id_language %>
		<% case value='hu' %>
			<h1>Kijelentkezés</h1>
			<p>Sikeres kijelentkezés</p>
			<p><a class="btn important" href="<% $siteconfig[site_url] %>">Tovább a főoldalra</a></p>
		<% case %>
			<h1>Logout</h1>
			<p>You have successfully logged out.</p>
			<p><a class="btn important" href="<% $siteconfig[site_url] %>">Back to the home page</a></p>
	<% /switch %>
		</div>
	</div>
</div>
<% include file='_footer.tpl' %>
