<li class="product" itemscope itemtype="http://schema.org/Product">
	<a class="photo" href="<% $siteconfig[site_url] %>/<% $product[permalink] %>">
		<img itemprop="image" class="photo" src="<% imgresize file='content/files/product/original/'.$product[photo_filename] resized_filename='content/files/product/resized/'.$product[id_product]|id2dir.'/'.$product[permalink].'-'.$product[photo_id_photo].'-220x220-fill' width=220 height=220 type='fill' ratio=$pixel_ratio %>" alt="<% $product[name] %>" />
		<% if $product[is_featured] == 'y' %>
			<span class="premium-line">Premium Line</span>
		<% /if %>
	</a>
	<span class="name">
		<a href="<% $siteconfig[site_url] %>/<% $product[permalink] %>" itemprop="name">
			<% $product[name] %>
		</a>
	</span>
	<span class="price" itemprop="offers" itemscope itemtype="http://schema.org/Offer">
		<span itemprop="priceCurrency" content="GBP">£</span>
		<span itemprop="price" content="<% $product[price] %>"><% $product[price]|number_format:2:'.':' ' %></span>
		<link itemprop="acceptedPaymentMethod" href=" http://purl.org/goodrelations/v1#PayPal" />
	</span>
	<div class="cart_add">
		<form class="form_add" action="<% $siteconfig[site_url] %>/basket/" method="post">
			<fieldset>
				<input name="id_product" value="<% $product[id_product] %>" type="hidden" />
				<input name="quantity" value="1" />
				<button class="important" type="submit">Buy now!</button>
			</fieldset>
		</form>
	</div>
	<span class="detailed-information">
		<a class="btn" href="<% $siteconfig[site_url] %>/<% $product[permalink] %>">
			Read more
		</a>
	</span>
</li>
