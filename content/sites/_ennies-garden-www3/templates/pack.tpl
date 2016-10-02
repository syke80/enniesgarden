<% assign name='id_language' value=$pack[language_iso] %>
<% assign name='pageid' value='product' %>

<% assign name='title' value=$pack[name].' | '.$shop[name] %>
<% assign name='keywords' value=$pack[name] %>
<% assign name='description' value=$pack[short_description] %>

<% foreach from=$propertylist item=property %>
	<% foreach from=$property[valuelist] item=value %>
		<% assign name="keywords" value=$keywords+$value[name]+', ' method="append" %>
	<% /foreach %>
<% /foreach %>

<% assign name='og_image' value=$siteconfig[site_url].'/content/files/pack/original/'.$pack[photo_filename] %>
<% assign name='canonical' value=$siteconfig[site_url].'/'.$pack[permalink].'/' %>
<% include file='_header.tpl' %>

<div class="wrapper">
	<div class="content-box" itemscope itemtype="http://schema.org/Product">
		<h1 class="name" itemprop="name"><% $pack[name] %></h1>
		<div id="photobox">
			<span id="photo">
				<img itemprop="image" class="photo" src="<% imgresize file='content/files/pack/original/'.$pack[photo_filename] resized_filename='content/files/pack/resized/'.$pack[id_pack]|id2dir.'/'.$pack[permalink].'-'.$pack[photo_id_photo].'-320x320-fill' width=320 height=320 type='fill' ratio=$pixel_ratio %>" alt="<% $pack[name] %>" />
			</span>
			<% if $photolist_count > 1 %>
				<ul id="thumbnails">
					<% foreach from=$photolist item=photo %>
						<li>
							<a href="<% imgresize file='content/files/pack/original/'.$photo[filename] resized_filename='content/files/pack/resized/'.$pack[id_pack]|id2dir.'/'.$pack[permalink].'_'.$pack[category_permalink].'_'.$pack[shop_permalink].'_'.$photo[id_photo].'_320x320_fill' width=320 height=320 type='fill' ratio=$pixel_ratio %>">
								<img src="<% imgresize file='content/files/pack/original/'.$photo[filename] resized_filename='content/files/pack/resized/'.$pack[id_pack]|id2dir.'/'.$pack[permalink].'_'.$pack[category_permalink].'_'.$pack[shop_permalink].'_'.$photo[id_photo].'_100x100_fill' width=100 height=100 type='fill' ratio=$pixel_ratio %>" alt="<% $pack[name] %>" />
							</a>
						</li>
					<% /foreach %>
				</ul>
			<% /if %>
		</div>

		<div id="info">
			<div itemprop="offers" itemscope itemtype="http://schema.org/Offer">
				<span itemprop="priceCurrency" class="currency" content="GBP">£</span>
				<span itemprop="price" class="price" content="<% $pack[price] %>"><% $pack[price]|number_format:2:'.':' ' %></span>
				<link itemprop="acceptedPaymentMethod" href=" http://purl.org/goodrelations/v1#PaymentMethodCreditCard" />
			</div>
			<div class="cart_add">
				<form class="form_add" action="<% $siteconfig[site_url] %>/basket/" method="post">
					<fieldset>
						<input name="id_pack" value="<% $pack[id_pack] %>" type="hidden" />
						<input name="quantity" value="1" />
						<button class="important" type="submit">Buy now!</button>
					</fieldset>
				</form>
			</div>
			<% if $propertylist %>
			<div class="property">
				<% foreach from=$propertylist item=property %>
				<ul>
					<li>
						<span class="property_name"><% $property[name] %>:</span>
						<ul>
							<% foreach from=$property[valuelist] item=value %>
							<li>
								<% $value[name] %>
							</li>
							<% /foreach %>
						</ul>
					</li>
				</ul>
				<% /foreach %>
			</div>
			<% /if %>
			<% if $pack[long_description] %>
			<div itemprop="description" class="long_description">
				<% $pack[long_description] %>
			</div>
			<% /if %>
			<div class="delivery-time">
			<% if $pack[quantity]===0 %>
			Available for 5-day delivery
			<% else %>
			Available for next day delivery
			<% /if %>
			</div>
			<div class="cart_add">
				<form class="form_add" action="<% $siteconfig[site_url] %>/basket/" method="post">
					<fieldset>
						<input name="id_pack" value="<% $pack[id_pack] %>" type="hidden" />
						<input name="quantity" value="1" />
						<button class="important" type="submit">Buy now!</button>
					</fieldset>
				</form>
			</div>

			<div class="share">
				<a
					href="https://www.facebook.com/sharer/sharer.php?u=<% $siteconfig[site_url] %>/<% $pack[permalink] %>/"
					target="_blank"
					class="icon-facebook"
					title="Share this on Facebook"
				>
					<span class="fa fa-facebook"></span>
				</a>
				<a
					href="https://plus.google.com/share?url=<% $siteconfig[site_url] %>/<% $pack[permalink] %>/"
					target="_blank"
					class="icon-google-plus"
					title="Share this on Google+"
				>
					<span class="fa fa-google-plus"></span>
				</a>
				<a
					href="https://twitter.com/intent/tweet?text=Check out this jam from Ennie's Garden Strawberry: <% $siteconfig[site_url] %>/<% $pack[permalink] %>/"
					target="_blank"
					class="icon-twitter"
					title="Share this on Twitter"
				>
					<span class="fa fa-twitter"></span>
				</a>
				<a
					href="//pinterest.com/pin/create/button/?url=<% $siteconfig[site_url] %>/<% $pack[permalink] %>/&amp;media=<% imgresize file='content/files/pack/original/'.$pack[photo_filename] resized_filename='content/files/pack/resized/'.$pack[id_pack]|id2dir.'/'.$pack[permalink].'-'.$pack[photo_id_photo].'-320x320-fill' width=320 height=320 type='fill' %>;description=<% $pack[name] %> from Ennie's Garden"
					target="_blank"
					class="icon-pinterest"
					title="Share this on Pinterest"
				>
					<span class="fa fa-pinterest"></span>
				</a>
				<a
					href="mailto:?subject=Thought you might like <% $pack[name] %> from Ennie's Garden&amp;body=Hey, I was browsing Ennie's Garden and found <% $pack[name] %>. I wanted to share it with you.%0D%0A%0D%0A<% $siteconfig[site_url] %>/<% $pack[permalink] %>/"
					target="_blank"
					class="icon-mail"
					title="Email this to a friend"
				>
					<span class="fa fa-envelope"></span>
				</a>
			</div>
		</div>
		<div class="clear"></div>
	</div>
</div>
<% include file='_basket_script.tpl' %>
<script>
onLoadFunctions.push( function() {
	$("#thumbnails li a").click( function() {
		$("#photo img").attr("src", $(this).attr("href"));
		return false;
	});
});
</script>


<% include file='_footer.tpl' %>
