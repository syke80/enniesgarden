<% if $customer %>
<div id="auth" class="auth_logout">
	<form id="form_logout" action="<% $siteconfig[site_url] %>/customerauth/" method="delete">
		You are logged in as <% $customer[email] %>.
		<button>Click here to log out</button>.
	</form>
</div>
<script>
onLoadFunctions.push( function() {
	$("#form_logout").ajaxForm({
		dataType: "json",
		success: function(data) {
			if (data.error == "") {
				<% switch from = $id_language %>
					<% case value='hu' %>window.location = "<% $siteconfig[site_url] %>/kijelentkezes";
					<% case %>window.location = "<% $siteconfig[site_url] %>/logout";
				<% /switch %>
			}
		}
	});
	$("#auth .txt").click( function() {
		$("#auth .contents").toggle(500);
	});
});
</script>
<% /if %>
