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

<div class="webshop list">
<% product list='all' limit=10 lang_iso=$id_language %>
</div>

<aside class="webshop_aside">
	<% $aside %>
	<div class="cart">
	</div>
</aside>

<script>
$("aside .cart").load("<% $siteconfig[site_url] %>/cart/aside/<% $id_language %>");
</script>

<% $page_content %>

<% include file='_footer.tpl' %>
