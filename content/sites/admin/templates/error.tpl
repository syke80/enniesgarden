<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
	<head>
		<title>Webshop admin</title>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<link href="<% loadfromskin file="css/page.css" %>" rel="stylesheet" type="text/css" />
		<script src="//ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>

<% if $errorcode == 403 %>

		<script type="text/javascript">
			$.ajax({
				url: '<% $siteconfig[site_url] %>/userauth/',
				type: 'DELETE',
				success: function(result) {
					window.location = "<% $siteconfig[site_url] %>/userauth/";
				}
			});
		</script>
<% else %>

		<style type="text/css">
			.http_error { text-align: center; margin-top: 120px; }
			.http_error .code { display: inline; background: url(<% $siteconfig[site_url] %>/skins/<% $siteconfig[site_engine] %>/<% $siteconfig[skin] %>/images/error.png) no-repeat; color: #d42a2a; padding: 4px 0px 5px 40px; font-size: 24px; }
			.http_error .info { color: #d42a2a; line-height: 20px; }
		</style>
	</head>

	<body>
		<div class="http_error">
			<span class="code"><% $errorcode %> Error</span><br />
			<span class="info"><% $reason %></span>
		</div>
	</body>
<% /if %>

</html>
