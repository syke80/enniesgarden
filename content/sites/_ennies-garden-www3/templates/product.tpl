<% assign name='id_language' value=$product[language_iso] %>
<% assign name='pageid' value='product' %>

<% assign name='title' value=$product[name].' | '.$shop[name] %>
<% assign name='keywords' value=$product[name] %>
<% assign name='description' value=$product[short_description] %>

<% foreach from=$propertylist item=property %>
	<% foreach from=$property[valuelist] item=value %>
		<% assign name="keywords" value=$keywords+$value[name]+', ' method="append" %>
	<% /foreach %>
<% /foreach %>

<% assign name='og_image' value=$siteconfig[site_url].'/content/files/product/original/'.$product[photo_filename] %>
<% assign name='canonical' value=$siteconfig[site_url].'/'.$product[permalink].'/' %>
<% include file='_header.tpl' %>

<div class="wrapper">
	<div class="content-box" itemscope itemtype="http://schema.org/Product">
		<h1 class="name" itemprop="name"><% $product[name] %></h1>
<%*
		<div class="breadcrumb">
			<a href="<% $siteconfig[site_url] %>">Home</a> >
			<a href="<% $siteconfig[site_url] %>/<% $product[category_permalink] %>"><% $product[category_name] %></a> >
			<a href="<% $siteconfig[site_url] %>/<% $product[category_permalink] %>/<% $product[permalink] %>"><% $product[name] %></a>
		</div>
*%>
		<div id="photobox">
			<span id="photo">
				<img itemprop="image" class="photo" src="<% imgresize file='content/files/product/original/'.$product[photo_filename] resized_filename='content/files/product/resized/'.$product[id_product]|id2dir.'/'.$product[permalink].'-'.$product[photo_id_photo].'-320x320-fill' width=320 height=320 type='fill' ratio=$pixel_ratio %>" alt="<% $product[name] %>" />
			</span>
			<% if $photolist_count > 1 %>
				<ul id="thumbnails">
					<% foreach from=$photolist item=photo %>
						<li>
							<a href="<% imgresize file='content/files/product/original/'.$photo[filename] resized_filename='content/files/product/resized/'.$product[id_product]|id2dir.'/'.$product[permalink].'-'.$photo[id_photo].'-320x320-fill' width=320 height=320 type='fill' ratio=$pixel_ratio %>">
								<img src="<% imgresize file='content/files/product/original/'.$photo[filename] resized_filename='content/files/product/resized/'.$product[id_product]|id2dir.'/'.$product[permalink].'_'.$photo[id_photo].'_100x100_fill' width=100 height=100 type='fill' ratio=$pixel_ratio %>" alt="<% $product[name] %>" />
							</a>
						</li>
					<% /foreach %>
				</ul>
			<% /if %>
		</div>
		
		<div id="info">
			<div itemprop="offers" itemscope itemtype="http://schema.org/Offer">
				<span itemprop="priceCurrency" class="currency" content="GBP">£</span>
				<span itemprop="price" class="price" content="<% $product[price] %>"><% $product[price]|number_format:2:'.':' ' %></span>
				<link itemprop="acceptedPaymentMethod" href=" http://purl.org/goodrelations/v1#PayPal" />
			</div>
			<div class="cart_add">
				<form class="form_add" action="<% $siteconfig[site_url] %>/basket/" method="post">
					<fieldset>
						<input name="id_product" value="<% $product[id_product] %>" type="hidden" />
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
			<% if $product[long_description] %>
			<div itemprop="description" class="long_description">
				<% $product[long_description] %>
			</div>
			<% /if %>
			<div class="delivery-time">
			<% if $product[quantity]===0 %>
			Available for 5-day delivery
			<% else %>
			Available for next day delivery
			<% /if %>
			</div>
			<div class="cart_add">
				<form class="form_add" action="<% $siteconfig[site_url] %>/basket/" method="post">
					<fieldset>
						<input name="id_product" value="<% $product[id_product] %>" type="hidden" />
						<input name="quantity" value="1" />
						<button class="important" type="submit">Buy now!</button>
					</fieldset>
				</form>
			</div>

			<div class="share">
				<a
					href="https://www.facebook.com/sharer/sharer.php?u=<% $siteconfig[site_url] %>/<% $product[permalink] %>/"
					target="_blank"
					class="icon-facebook"
					title="Share this on Facebook"
				>
					<span class="fa fa-facebook"></span>
				</a>
				<a
					href="https://plus.google.com/share?url=<% $siteconfig[site_url] %>/<% $product[permalink] %>/"
					target="_blank"
					class="icon-google-plus"
					title="Share this on Google+"
				>
					<span class="fa fa-google-plus"></span>
				</a>
				<a
					href="https://twitter.com/intent/tweet?text=Check out this <% $product[name] %> from Ennie's Garden: <% $siteconfig[site_url] %>/<% $product[permalink] %>/"
					target="_blank"
					class="icon-twitter"
					title="Share this on Twitter"
				>
					<span class="fa fa-twitter"></span>
				</a>
				<a
					href="//pinterest.com/pin/create/button/?url=<% $siteconfig[site_url] %>/<% $product[permalink] %>/&amp;media=<% imgresize file='content/files/product/original/'.$product[photo_filename] resized_filename='content/files/product/resized/'.$product[id_product]|id2dir.'/'.$product[permalink].'-'.$product[photo_id_photo].'-320x320-fill' width=320 height=320 type='fill' %>;description=<% $product[name] %> from Ennie's Garden"
					target="_blank"
					class="icon-pinterest"
					title="Share this on Pinterest"
				>
					<span class="fa fa-pinterest"></span>
				</a>
				<a
					href="mailto:?subject=Thought you might like <% $product[name] %> from Ennie's Garden&amp;body=Hey, I was browsing Ennie's Garden and found <% $product[name] %>. I wanted to share it with you.%0D%0A%0D%0A<% $siteconfig[site_url] %>/<% $product[permalink] %>/"
					target="_blank"
					class="icon-mail"
					title="Email this to a friend"
				>
					<span class="fa fa-envelope"></span>
				</a>
			</div>
<%*
			<% inclide file='_product_question.tpl'%>
   *%>
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
