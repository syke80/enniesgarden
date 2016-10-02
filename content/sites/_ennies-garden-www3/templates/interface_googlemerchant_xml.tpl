<?xml version="1.0" encoding="UTF-8" ?>
<rss version="2.0" xmlns:g="http://base.google.com/ns/1.0">
<channel>
	<title>Ennie's Garden products</title>
	<link><% $siteconfig[site_url] %>/interface/google-merchant.xml</link>
	<description>All products of Ennie's Garden webshop</description>

	<% foreach from=$list item='item' %>
	<item>
		<g:id><% $item[id] %></g:id>
		<title><![CDATA[<% $item[title] %>]]></title>
		<description><![CDATA[<% $item[description] %> ]]></description>
		<link><% $item[link] %></link>
		<g:mobile_link><% $item[link] %></g:mobile_link>
		<g:image_link><% $item[imageLink] %></g:image_link>
		<% if $item[additionalImageLinks] %>
		<% foreach from=$item[additionalImageLinks] item='additionalImage' %>
		<g:additional_image_link><% $additionalImage %></g:additional_image_link>
		<% /foreach %>
		<% /if %>
		<g:google_product_category><% $item[googleProductCategory]|htmlspecialchars %></g:google_product_category>
		<g:product_type><% $item[productType]|htmlspecialchars %></g:product_type>
		<g:price><% $item[price] %></g:price>
		<g:condition><% $item[condition] %></g:condition>
		<g:availability><% $item[availability] %></g:availability>
		<g:brand><% $item[brand] %></g:brand>
		<g:gtin><% $item[gtin] %></g:gtin>
		<g:mpn><% $item[mpn] %></g:mpn>
		<g:price><% $item[price] %></g:price>
		<g:shipping>
			<% foreach from=$item[shipping] item='value' key='key' %>
			<g:<% $key %>><% $value %></g:<% $key %>>
			<% /foreach %>
		</g:shipping>
	</item>
	<% /foreach %>

</channel>
</rss>