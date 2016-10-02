<!DOCTYPE html>
<html>
	<head prefix="og: http://ogp.me/ns# fb: http://ogp.me/ns/fb#">
		<title><% $title %></title>
		<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no;">
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<meta name="description" content="<% $description %>" />
		<meta name="keywords" content="<% $keywords %>" />
		<link href="<% loadfromskin file="images/favicon.png" %>" rel="icon" type="image/png" />
		<% if $canonical %>
		<link rel="canonical" href="<% $canonical %>" />
		<% /if %>
		<meta property="og:locale" content="en_GB" />
		<% if !$og_image %>
		<% assign name='og_image' value=$siteconfig[site_url].'/content/sites/_ennies-garden-www3/images/facebook-home.jpg' %>
		<% /if %>
		<meta property="og:image" content="<% $og_image %>" />
<%*
		<meta property="og:image:secure_url" content="http://ia.media-imdb.com/images/rock.jpg" />
*%>
		<meta property="og:site_name" content="Ennie's Garden" />
		<meta property="og:title" content="<% $title %>" />
		<meta property="og:type" content="website" />
		<% if $canonical %>
		<meta property="og:url" content="<% $canonical %>" />
		<% /if %>
		<meta property="fb:app_id" content="<% $siteconfig[fb_app_id] %>" />
<%*
		<meta property="fb:admins" content="1044298481, 1648071681" />
*%>
		<meta property="og:description" content="<% $description %>"/>

		<% loadcss files="style.css, smartphone.css, tablet.css, desktop.css" output="enniesgarden-above.css" test=$siteconfig[debug] %>
		<!--[if lt IE 9]>
				<script src="/content/javascript/modernizr.custom.76717.js"></script>
				<link rel="stylesheet" href="<% $siteconfig[site_url] %>/content/sites/_ennies-garden-www3/css/test/style.css" />
				<link rel="stylesheet" href="<% $siteconfig[site_url] %>/content/sites/_ennies-garden-www3/css/ie8.css" />
		<![endif]-->

		<script>
			var onLoadFunctions = []; 
			onLoadFunctions.push( function() {
				$("#cart").load("<% $siteconfig[site_url] %>/basket/gadget/<% $id_language %>/");
				$("<div id=\"viewport-indicator\"><div class=\"smartphone\"></div><div class=\"tablet\"></div><div class=\"desktop\"></div></div>").insertAfter("#container");
			});
		</script>
	</head>

	<body class="<% if $pageid %>page_<% $pageid %><% /if %> page_<% $module %>">
		<header>
			<div class="wrapper">
				<div class="utility">
					<% include file="_header_auth.tpl" %>
					<% include file="_header_search.tpl" %>
					<div id="cart">
					</div>
					<span class="shipping-info">Enjoy <strong>FREE delivery</strong> on all orders <strong>over £25</strong> (£2.99&nbsp;otherwise)</span>
				</div>

				<a href="<% $siteconfig[site_url] %>" id="home"></a>

				<% include file='_menu.tpl' %>

				<div style="float: none; clear: both;"></div>
			</div>

		</header>

		<div id="container">
			<div id="content">
