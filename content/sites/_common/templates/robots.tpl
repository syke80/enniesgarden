User-agent: *
<% foreach from=$url_list item=item %>
Disallow: /<% $item[url] %>
<% /foreach %>
Sitemap: <% $siteconfig[site_url] %>/sitemap.xml