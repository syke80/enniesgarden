<% assign name='id_language' value='en' %>
<% assign name='title' value='Page not found | Ennie\'s Garden' %>
<% assign name='pageid' value='error' %>
<% include file='_header.tpl' %>

<div class="wrapper">
	<div class="content-box error-page">
		<h1>
			404<br />
			Page not found
		</h1>
		<div class="textpage">
			<%* page id_site='www' permalink='_featured' region='Body' *%>
			<p>
				<span style="font-size: 2em;">Whoopsie!</span><br />
				We hate to say it, but we couldn't find that page you are looking for.<br />
				Here's a little map and a search box that might help you get back on track.
			</p>

			<p class="links">
				<a href="/">HOME</a>
				<a href="/jam/">JAM</a>
				<a href="/marmalade/">MARMALADE</a>
				<a href="/curd/">CURD</a>
				<a href="/gift-sets/">GIFT SETS</a>
				<a href="/contact/">CONTACT</a>
			</p>
			<form id="error-form-search" action="<% $siteconfig[site_url] %>/search/" method="get">
				<p>
					<input type="text" id="error-search-str" name="str" placeholder="eg.: strawberry jam" />
					<button type="submit">Search</button>
				</p>
				<script>
				onLoadFunctions.push( function() {
					$("#error-form-search").submit( function() {
						window.location = $(this).attr("action")+$("input[name=str]", this).val();
						return false;
					});
				});
				</script>
			</form>
		</div>
	</div>
</div>
<% include file='_footer.tpl' %>
