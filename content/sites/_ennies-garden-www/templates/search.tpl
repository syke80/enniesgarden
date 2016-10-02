<% assign name='title' value=$search_str.' | '.$shop[name] %>
<% if $productlist %>
<% foreach from=$productlist item=product %>
<% assign name='keywords' value=$keywords.$product[name].', ' %>
<% assign name='description' value=$description.$product[name].', ' %>
<% /foreach %>
<% assign name='description' value=$description.'...' %>

<h1>
<% switch from = $id_language %>
	<% case value='hu' %>Találatok a(z) "<% $search_str %>" kifejezésre
	<% case %>Results for "<% $search_str %>"
<% /switch %>
</h1>
<ul class="productlist">
<% foreach from=$productlist item=product %>
<li>
	<a class="photo" href="<% $siteconfig[site_url] %>/product/<% $product[permalink] %>">
		<img src="<% $siteconfig[upload_image_url] %>/<% $product[photo_filename] %>_th.png" alt="<% $product[name] %>"/>
	</a>
	<span class="name">
		<a href="<% $siteconfig[site_url] %>/product/<% $product[permalink] %>">
			<% $product[name] %>
		</a>
	</span>
	<span class="short_description">
		<a href="<% $siteconfig[site_url] %>/product/<% $product[permalink] %>">
			<% $product[short_description] %>
		</a>
	</span>
	<span class="price"><% $product[price]|number_format:0:'':' ' %></span>
</li>
<% /foreach %>
</ul>
<% else %>
<span>
	<% switch from = $id_language %>
		<% case value='hu' %>Nincs találat a(z) "<% $search_str %>" kifejezésre
		<% case %>No results for "<% $search_str %>"
	<% /switch %>
</span>
<% /if %>