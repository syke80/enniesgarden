<!DOCTYPE html>
<html lang="hu">
	<head>
		<title><% $siteconfig[site_name] %></title>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

		<link href="<% loadfromskin file="/css/style.css" %>" rel="stylesheet" type="text/css" />
		<link href="<% mtimelink file='admin/css/jquery.jgrowl.css' %>" rel="stylesheet" type="text/css" />
		<link rel="icon" href="<% $siteconfig[site_url] %>/static/favicon.ico" type="image/x-icon" />
		<script src="//ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
		<script type="text/javascript" src="<% $siteconfig[site_url] %>/core/javascript/common.js"></script>
		<script type="text/javascript" src="<% $siteconfig[site_url] %>/core/javascript/jquery.imgreplace.js"></script>
		<script type="text/javascript" src="<% $siteconfig[site_url] %>/core/javascript/jquery.jgrowl.min.js"></script>
		<script type="text/javascript" src="<% $siteconfig[site_url] %>/core/javascript/jquery.form.js"></script>
		<script type="text/javascript" src="<% $siteconfig[site_url] %>/core/javascript/jquery.md5.js"></script>
	</head>

	<body class="page_<% $module %>">
		<div id="container">
			<div id="content">
