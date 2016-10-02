<% assign name='title' value=$search_str.' | '.$shop[name] %>
<% foreach from=$productlist item=product %>
<% assign name='keywords' value=$keywords.$product[name].', ' %>
<% assign name='description' value=$description.$product[name].', ' %>
<% /foreach %>
<% assign name='description' value=$description.'...' %>

<% include file='_header.tpl' %>

<div class="wrapper">
<div class="content-box">
	<h1>
	<% switch from = $id_language %>
		<% case value='hu' %>Találatok a(z) "<% $search_str %>" kifejezésre
		<% case %>Results for "<% $search_str %>"
	<% /switch %>
	</h1>
	<% if $productlist %>
	<ul class="productlist results">
	<% foreach from=$productlist item=product %>
		<% include file='_list_item_product.tpl' %>
	<% /foreach %>
	</ul>
	<% else %>
	<p class="error-message">
		<% switch from = $id_language %>
			<% case value='hu' %>Nincs találat a(z) "<% $search_str %>" kifejezésre
			<% case %>
			There are no results for "<% $search_str %>".<br />
			Sorry we have not been able to find the item you specified.<br />
			Click <a href="<% $siteconfig[site_url] %>/">here</a> to return to the home page.
<%*
			Click <a href="<% $siteconfig[site_url] %>/">here</a> to return to the home page, or check out the most popular products at Ennie’s Garden.
*%>
		<% /switch %>
	</p>
	<% /if %>
</div>
</div>
<% include file='_basket_script.tpl' %>
<% include file='_footer.tpl' %>
