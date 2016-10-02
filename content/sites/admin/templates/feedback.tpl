<% include file='_header.tpl' %>
<h1>Feedback's recipient</h1>

<form action="<% $site[site_url] %>/feedback/" method="post">
	<div>
		<h2>Name</h2>
		<input name="name">
	</div>
	<div>
		<h2>Email</h2>
		<input name="email">
	</div>
	<div>
		<button type="submit">Send</button>
	</div>
</form>
<% include file='_footer.tpl' %>
