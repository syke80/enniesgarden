<% foreach from=$contentlist item='region' %>
	<% switch from = $region[region_name] %>
		<% case value='Language code' %>
			<% assign name='id_language' value=$region[content] %>
		<% case value='Title' %>
			<% assign name='title' value=$region[content] %>
		<% case value='Keywords' %>
			<% assign name='keywords' value=$region[content] %>
		<% case value='Description' %>
			<% assign name='description' value=$region[content] %>
		<% case value='Body' %>
			<% assign name='page_content' value=$region[content] %>
		<% case value='Aside' %>
			<% assign name='aside' value=$region[content] %>
	<% /switch %>
<% /foreach %>
<% assign name='canonical' value=$siteconfig[site_url].'/'.$path %>
<% include file='_header.tpl' %>

<div class="wrapper">
<div class="content-box">
	<div class="textpage<% if $aside=='' %> aside_empty<% /if %>">
	<% $page_content %>
	</div>
	<% if $aside!='' %>
	<aside class="page_aside">
	<% $aside %>
	</aside>
	<% /if %>
</div>
</div>

<% include file='_footer.tpl' %>
