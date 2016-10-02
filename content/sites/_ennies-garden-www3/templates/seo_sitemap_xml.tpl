<?xml version="1.0" encoding="utf-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9"
xmlns:image="http://www.google.com/schemas/sitemap-image/1.1">
	<% foreach from=$url_list item='item' %>
		<url>
			<loc><% $item[location] %></loc>
			<% if $item[images] %>
				<% assign name='images' value=$item[images] %>
				<% foreach from=$images item='image' %>
					<image:image> 
						<image:loc><% $image[location] %></image:loc>
						<image:title>
						<![CDATA[
							<% $image[title] %>
						]]>
						</image:title>
					</image:image> 
				<% /foreach %>
			<% /if %>
			<%*
			<lastmod><% $item[lastmod] %></lastmod>
			<changefreq><% $item[changefreq] %></changefreq>
			<priority><% $item[lastmod] %></priority>
			*%>
		</url>
	<% /foreach %>

	<url>
		<loc><% $siteconfig[site_url] %>/gallery/</loc>
		<% foreach from=$image_list item='image' %>
			<image:image> 
				<image:loc><% $image[location] %></image:loc>
				<image:title>
					<![CDATA[
						<% $image[title] %>
					]]>
				</image:title>
			</image:image> 
		<% /foreach %>
	</url>
</urlset>