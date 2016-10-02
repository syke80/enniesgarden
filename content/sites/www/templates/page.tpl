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
<% include file='_header.tpl' %>

<div class="page<% if $aside=='' %> aside_empty<% /if %>">
<% $page_content %>
</div>
<aside class="page_aside<% if $aside=='' %> empty<% /if %>">
<% $aside %>
</aside>

<% include file='_footer.tpl' %>
