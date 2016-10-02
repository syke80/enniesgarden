<% if $debugdata %>
<style type="text/css">
.debug { border: 1px solid black; font-size: 12px; text-align: left; line-height: 14px; padding: 2px 10px; margin-bottom: 10px; }
.debug ul { list-style: none; padding: 0px; margin: 0px; }
.debug ul li { margin: 0px; }
.debug span.sub { font-weight: bold; cursor: pointer; }
.debug ul.sub { margin-left: 10px; display: none; }
.debug .error { color: red; }
</style>
<% rand assign='debug_id' min=0 max=1000 %>
<div class="debug">
	<ul>
	<% foreach from=$debugdata[info] item=info_group key=key %>
		<li>
		<span class="sub" onclick="$('#debug_<% $debug_id %>_<% $key %>').toggle('slow');"><% $info_group[name] %></span>
		<ul id="debug_<% $debug_id %>_<% $key %>" class="sub">
		<% foreach from=$info_group[list] item=info_line %>
			<li><% $info_line|nl2br %></li>
		<% /foreach %>
		</ul>
		</li>
	<% /foreach %>
	</ul>
	Page generated in <% $debugdata[time] %>s
</div>
<% /if %>