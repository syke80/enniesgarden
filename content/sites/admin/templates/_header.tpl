<!DOCTYPE html>
<html lang="hu">
	<head>
		<title>Webshop admin</title>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

		<link href="<% mtimelink file='admin/css/style.css' %>" rel="stylesheet" type="text/css" />
		<link href="<% mtimelink file='admin/css/jquery.jgrowl.css' %>" rel="stylesheet" type="text/css" />
		<link href="<% mtimelink file='admin/css/simplebox.css' %>" rel="stylesheet" type="text/css" />
		<link href="<% mtimelink file='admin/css/form.css' %>" rel="stylesheet" type="text/css" />
		<link href="<% mtimelink file='admin/css/dropzone.css' %>" rel="stylesheet" type="text/css" />
		<link href="<% $siteconfig[site_url] %>/core/javascript/conscendo_table/table.css" rel="stylesheet" type="text/css" />
		<link href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css" rel="stylesheet" type="text/css" />
		<link rel="icon" href="<% $siteconfig[site_url] %>/static/favicon.ico" type="image/x-icon" />
		<script src="//ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
		<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
		<script src="<% $siteconfig[site_url] %>/core/javascript/common.js"></script>
		<script src="<% $siteconfig[site_url] %>/core/javascript/jquery.simplebox.js"></script>
		<script src="<% $siteconfig[site_url] %>/core/javascript/jquery.imgreplace.js"></script>
		<script src="<% $siteconfig[site_url] %>/core/javascript/jquery.jgrowl.min.js"></script>
		<script src="<% $siteconfig[site_url] %>/core/javascript/jquery.form.js"></script>
		<script src="<% $siteconfig[site_url] %>/core/javascript/jquery.md5.js"></script>
		<script src="<% $siteconfig[site_url] %>/core/javascript/jquery.conscendo_table.js"></script>
		<script src="<% $siteconfig[site_url] %>/content/javascript/ckeditor/ckeditor.js"></script>
		<script src="<% $siteconfig[site_url] %>/content/javascript/ckeditor/adapters/jquery.js"></script>
		<script src="<% $siteconfig[site_url] %>/content/javascript/jquery.conscendo_table.js"></script>
		<script src="<% $siteconfig[site_url] %>/core/javascript/jquery-scrollto.js"></script>
		<script src="<% $siteconfig[site_url] %>/content/javascript/dropzone.js"></script>
	</head>

	<body class="page_<% $module %>">
		<div id="container">
			<ul id="menu">
				<% if $user[access] == 'root' || $user[access] == 'shop_admin' %><li><a href="<% $siteconfig[site_url] %>/user">Users</a></li><% /if %>
				<% if $user[access] == 'root' %><li><a href="<% $siteconfig[site_url] %>/shop">Shops</a></li><% /if %>
				<% if $user[access] == 'root' || $user[access] == 'shop_admin' %><li><a href="<% $siteconfig[site_url] %>/page">Pages</a></li><% /if %>
				<% if $user[access] == 'root' || $user[access] == 'shop_admin' %><li><a href="<% $siteconfig[site_url] %>/menu">Menu</a></li><% /if %>
				<li><a href="<% $siteconfig[site_url] %>/category">Categories</a></li>
				<li><a href="<% $siteconfig[site_url] %>/product">Products</a></li>
				<li><a href="<% $siteconfig[site_url] %>/pack">Packs</a></li>
				<li><a href="<% $siteconfig[site_url] %>/gallery/">Gallery</a></li>
				<li><a href="<% $siteconfig[site_url] %>/order">Orders</a></li>
				<li><a href="<% $siteconfig[site_url] %>/feedback">Feedback</a></li>
			</ul>
			<% include file='_header_user.tpl' %>
			<div id="content">
