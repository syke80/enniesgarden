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
	<div class="featured">
		<% $page_content %>
	</div>
	<div class="categories">
		<div class="item">
			<h3><a href="/jam/">Jams</a></h3>
			<div class="outline">
				<p>
					We have carefully selected a range of luxury, hand-crafted jams to satisfy all tastes, from our ‘classic’ Strawberry Jam, to our unique Morello Cherry and Port recipe.
				</p>
				<a class="btn" href="/jam/">Take a look at our Jams</a>
			</div>
		</div>
		<div class="item">
			<h3><a href="/marmalade/">Marmalades</a></h3>
			<div class="outline">
				<p>
					We believe that the best curds should be velvety soft and bursting with flavour. Add some zing to your mornings with our exciting flavours like passion fruit and very ginger.
				</p>
				<a class="btn" href="/marmalade/">Take a look at our Marmalades</a>
			</div>
		</div>
		<div class="item">
			<h3><a href="/curd/">Curds</a></h3>
			<div class="outline">
				<p>
					We have reinvented a favourite breakfast item with this marmalade, in which a hint of whisky provides a flavourful twist to a classic product.
				</p>
				<a class="btn" href="/curd/">Take a look at our Curds</a>
			</div>
		</div>
	</div>
	<div class="why-better">
		<ul>
			<li>Made from real fruit</li>
			<li>Made in England</li>
			<li>No added preservative</li>
		</ul>
	</div>
</div>

<aside class="page_aside<% if $aside=='' %> empty<% /if %>">
	<% $aside %>
</aside>

<% include file='_footer.tpl' %>
