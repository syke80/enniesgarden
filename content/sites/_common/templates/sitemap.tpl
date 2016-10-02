<urlset xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="http://www.sitemaps.org/schemas/sitemap/0.9" xsi:schemaLocation="http://www.sitemaps.org/schemas/sitemap/0.9 http://www.sitemaps.org/schemas/sitemap/0.9/sitemap.xsd">
<% foreach from=$url_list item=item %>
<url>
<loc><% $siteconfig[site_url] %>/<% $item[url] %></loc>
</url>
<% /foreach %>
</urlset>