<% assign name='pageid' value='index' %>
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
<% assign name='canonical' value=$siteconfig[site_url] %>
<% include file='_header.tpl' %>

<div class="page<% if $aside=='' %> aside_empty<% /if %>">
	<div class="wrapper">
		<section class="featured">
			<% page id_site='www' permalink='_featured' region='Body' %>
		</section>
		

		<section class="categories">
			<section class="item">
				<figure>
					<a href="/jam/">
						<img
							src="/content/sites/_ennies-garden-www3/images/categories-jam<% if $pixel_ratio>1 && $pixel_ratio<='1.5' %>@1.5<% elseif $pixel_ratio>='1.5' %>@2<% /if %>.jpg"
							alt="Jam"
						/>
					</a>
				</figure>
				<h1>Jams</h1>
				<p>                                                                   
					We have carefully selected a range of luxury, hand-crafted Jams to satisfy all tastes, from our ‘classic’ Strawberry Jam, to our unique Morello Cherry and Port recipe.
				</p>
				<a class="btn" href="/jam/">Take a look at our Jams</a>
			</section>
			<section class="item">
				<figure>
					<a href="/marmalade/">
						<img
							src="/content/sites/_ennies-garden-www3/images/categories-marmalade<% if $pixel_ratio>1 && $pixel_ratio<='1.5' %>@1.5<% elseif $pixel_ratio>='1.5' %>@2<% /if %>.jpg"
							alt="Marmalade"
						/>
					</a>
				</figure>
				<h1>Marmalades</h1>
				<p>
					In pursuit of the ideal marriage of sweetness and bitterness for our Marmalade, we have travelled the globe in search of the perfect citrus fruits, including wild Moroccan Oranges and Pink Grapefruit.
				</p>
				<a class="btn" href="/marmalade/">Take a look at our Marmalades</a>
			</section>
			<section class="item">
				<figure>
					<a href="/curd/">
						<img
							src="/content/sites/_ennies-garden-www3/images/categories-curd<% if $pixel_ratio>1 && $pixel_ratio<='1.5' %>@1.5<% elseif $pixel_ratio>='1.5' %>@2<% /if %>.jpg"
							alt="Curd"
						/>
					</a>
				</figure>
				<h1>Curds</h1>
				<p>
					We believe that the best Curds should be velvety soft and bursting with flavour. Add some zing to your mornings with our exciting flavours like Passion Fruit and Raspberry.
				</p>
				<a class="btn" href="/curd/">Take a look at our Curds</a>
			</section>
		</section>
		<section class="why-better">
			<ul>
				<li>100% satisfaction guarantee</li>
				<li>Made from real fruit</li>
				<li>Made in England</li>
				<li>No added preservatives</li>
			</ul>
		</section>
	</div>
</div>

<% if $aside=='' %>
<aside class="page_aside">
	<% $aside %>
</aside>
<% /if %>

<% include file='_footer.tpl' %>
