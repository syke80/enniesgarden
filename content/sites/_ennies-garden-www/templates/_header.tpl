<!DOCTYPE html>
<html lang="hu">
	<head>
		<title><% $title %></title>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<meta name="description" content="<% pagetag name="description" %>" />
		<meta name="keywords" content="<% pagetag name="keywords" %>" />
		<link href='http://fonts.googleapis.com/css?family=Lato|Merriweather|Open+Sans|IM+Fell+English' rel='stylesheet' />
		<link href="<% loadfromskin file="images/favicon.png" %>" rel="icon" type="image/png" />

		<% loadcss files="style.css, page.css, form.css, jquery.jgrowl.css, debug.css, font-awesome.css" output=$siteconfig[id_site].".css" test=true %>

		<link href='http://fonts.googleapis.com/css?family=Dancing+Script' rel='stylesheet' type='text/css'>

		<script src="//ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
		<script src="//ajax.googleapis.com/ajax/libs/jqueryui/1.10.3/jquery-ui.min.js"></script>
 		<script src="<% $siteconfig[site_url] %>/core/javascript/jquery.imgreplace.js"></script>
		<script src="<% $siteconfig[site_url] %>/core/javascript/jquery.jgrowl.min.js"></script>
		<script src="<% $siteconfig[site_url] %>/core/javascript/jquery.form.js"></script>
		<script src="<% $siteconfig[site_url] %>/core/javascript/jquery.md5.js"></script>
		<script src="<% $siteconfig[site_url] %>/content/javascript/jquery.cookie.js"></script>
		<script src="<% $siteconfig[site_url] %>/core/javascript/jquery.valign.js"></script>
		<script src="<% $siteconfig[site_url] %>/content/javascript/jquery.nicescroll.min.js"></script>
		<script>
		$.jGrowl.defaults.closerTemplate = '<div>Hide all</div>';
		
		function set_content_size() {
/*
			var content_size = 
			if ( $(window).height() > ($("header").height() + $("#content").height() + $("footer").height()) ) $("#content").height( $(window).height() - $("header").height() - $("footer").height() );
*/
		}

		$(document).ready( function() {
			$("#cart").load("<% $siteconfig[site_url] %>/basket/gadget/<% $id_language %>/");
			$("body").imgReplace();
			$(".valign").vAlign();
			console.log("window: "+$(window).height() + " header: " + $("header").height() + " content: " + $("#content").height() + " footer: " + $("footer").height());
			console.log("window: "+$(window).outerHeight() + " header: " + $("header").outerHeight() + " content: " + $("#content").outerHeight() + " footer: " + $("footer").outerHeight());
			set_content_size();
		});

		$(window).resize( function() {
			set_content_size();
		});			
		</script>
	</head>

	<body class="page_<% $pageid %> page_<% $module %>">
		<header>
			<div class="wrapper">
				<div class="header-box">
					<div class="outline">
						<div class="utility">
							<% include file="_header_search.tpl" %>
							<%* include file="_header_auth.tpl" *%>
							<div id="cart">
							</div>
						</div>
		
						<a href="<% $siteconfig[site_url] %>" id="home">
							<span id="logo">Ennie's Garden</span><br />
							<span id="slogan">
							Real fruit, Unreal flavour
							</span>
						</a>
	
						<nav id="menu">
							<ul>
							<% menu name=$siteconfig[shop_permalink].'-'.$id_language assign='menutree' %>
							<% counter start=1 print=false assign='menu_counter' %>
							<% foreach from=$menutree item=menu %>
							<li class="main-menu-item main-menu-item-<% $menu_counter %>">
								<% if $menu[url] %>
								<a href="<% $menu[url] %>"<% if $menu[is_popup]=='y' %> target="_blank"<% /if %>><% $menu[title] %></a>
								<% else %>
								<span class="title"><% $menu[title] %></span>
								<% /if %>
								<% if $menu[children] %>
								<ul class="submenu">
									<% foreach from=$menu[children] item=menuitem %>
									<li><a href="<% $menuitem[url] %>"<% if $menuitem[is_popup]=='y' %> target="_blank"<% /if %>><% $menuitem[title] %></a></li>
									<% /foreach %>
								</ul>
								<% /if %>
							</li>
							<% counter %>
							<% /foreach %>
							</ul>
						</nav>
						<div style="float: none; clear: both;"></div>
					</div>
				</div>
			</div>

		</header>

		<div id="container">
			<div class="wrapper">
				<div id="content">
