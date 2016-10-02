<% assign name='id_language' value=$product[language_iso] %>
<% assign name='pageid' value='product' %>

<% assign name='title' value=$product[name].' | '.$category[name].' | '.$shop[name] %>
<% assign name='keywords' value=$product[name].', '.$category[name] %>
<% assign name='description' value=$product[name].' | '.$category[name].' | '.$product[short_description] %>

<% include file='_header.tpl' %>

<div class="content-box">
	<div class="outline">

		<div itemscope itemtype="http://schema.org/Product">
		<div id="photobox">
			<span id="photo">
				<img itemprop="image" class="photo" src="<% imgresize file='content/files/product/original/'.$product[photo_filename] resized_filename='content/files/product/resized/'.$product[id_product]|id2dir.'/'.$product[permalink].'_'.$product[category_permalink].'_'.$product[shop_permalink].'_'.$product[id_photo].'_320x320_fill' width=320 height=320 type='fill' %>" alt="<% $product[name] %>" />
			</span>
			<% if $photolist_count > 1 %>
				<ul id="thumbnails">
					<% foreach from=$photolist item=photo %>
						<li><a href="#"><img src="<% imgresize file='content/files/product/original/'.$photo[filename] resized_filename='content/files/product/resized/'.$product[id_product]|id2dir.'/'.$product[permalink].'_'.$product[category_permalink].'_'.$product[shop_permalink].'_'.$photo[id_photo].'_50x50_fill' width=50 height=50 type='fill' %>" alt="<% $product[name] %>" /></a></li>
					<% /foreach %>
				</ul>
			<% /if %>
		</div>
		
		<div id="info">
			<h1 class="name" itemprop="name"><% $product[name] %></h1>
			<% if $product[short_description] %>
			<p class="short_description">
				<% $product[short_description] %>
			</p>
			<% /if %>
			<div itemprop="offers" itemscope itemtype="http://schema.org/Offer">
				<span itemprop="priceCurrency" class="currency" content="GBP">£</span>
				<span itemprop="price" class="price" content="<% $product[price] %>"><% $product[price]|number_format:0:'':' ' %></span>
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
								<% pagetag name="keywords" value=$value[name] method="append" %>
							</li>
							<% /foreach %>
						</ul>
					</li>
				</ul>
				<% /foreach %>
			</div>
			<% /if %>
			<% if $product[long_description] %>
			<p itemprop="description" class="long_description">
				<% $product[long_description] %>
			</p>
			<% /if %>
			<div class="cart_add">
				<form class="form_add" action="<% $siteconfig[site_url] %>/basket/" method="post">
					<fieldset>
						<input name="id_product" value="<% $product[id_product] %>" type="hidden" />
						<input name="quantity" value="1" />
						<button class="important" type="submit">Add to basket</button>
					</fieldset>
				</form>
			</div>

			<div class="share">
<a
	href="https://www.facebook.com/sharer/sharer.php?u=<% $siteconfig[site_url] %>/<% $product[category_permalink] %>/<% $product[permalink] %>/"
	target="_blank"
	class="icon-facebook"
	title="Share this on Facebook"
>
	<span class="fa fa-facebook">
</a>
<a
	href="https://plus.google.com/share?url=<% $siteconfig[site_url] %>/<% $product[category_permalink] %>/<% $product[permalink] %>/"
	target="_blank"
	class="icon-google-plus"
	title="Share this on Google+"
>
	<span class="fa fa-google-plus">
</a>
<a
	href="https://twitter.com/intent/tweet?text=Check out this jam from Ennie's Garden Strawberry: <% $siteconfig[site_url] %>/<% $product[category_permalink] %>/<% $product[permalink] %>/"
	target="_blank"
	class="icon-twitter"
	title="Share this on Twitter"
>
	<span class="fa fa-twitter">
</a>
<a
	href="//pinterest.com/pin/create/button/?url=<% $siteconfig[site_url] %>/<% $product[category_permalink] %>/<% $product[permalink] %>/&amp;media=<% imgresize file='content/files/product/original/'.$product[photo_filename] resized_filename='content/files/product/resized/'.$product[id_product]|id2dir.'/'.$product[permalink].'_'.$product[category_permalink].'_'.$product[shop_permalink].'_'.$product[id_photo].'_320x320_fill' width=320 height=320 type='fill' %>;description=<% $product[name] %> from Ennie's Garden"
	target="_blank"
	class="icon-pinterest"
	title="Share this on Pinterest"
>
	<span class="fa fa-pinterest">
</a>
<a
	href="mailto:?subject=Thought you might like <% $product[name] %> from Ennie's Garden&amp;body=Hey, I was browsing Ennie's Garden and found <% $product[name] %>. I wanted to share it with you.%0D%0A%0D%0A<% $siteconfig[site_url] %>/<% $product[category_permalink] %>/<% $product[permalink] %>/"
	target="_blank"
	class="icon-mail"
	title="Email this to a friend"
>
	<span class="fa fa-envelope">
</a>



			</div>

		</div>
		<div class="clear"></div>
		</div>
	</div>
</div>

<script>
$(".form_add").ajaxForm({
	dataType: "json",
	beforeSubmit: function(arr, $form, options) {
		$("button", $form).addClass("inprogress");
		$("button", $form).attr("disabled", true);
		$("button", $form).attr("btn_label", $("button", $form).html());
		$("button", $form).html("Kérem várjon");
	},
	success: function(data, statusText, xhr, $form) {
		$("button", $form).removeClass("inprogress");
		$("button", $form).attr("disabled", false);
		$("button", $form).html($("button", $form).attr("btn_label"));
		if (data.error == "") {
			<% switch from = $id_language %>
				<% case value='hu' %>$.jGrowl("A termék a kosárba került");
				<% case %>$.jGrowl("Product successfully added to the cart");
			<% /switch %>
			$("#cart").load("<% $siteconfig[site_url] %>/basket/gadget/<% $id_language %>");
		}
		else {
			<% include file='_js_error.tpl' %>
		}
	}
});

$("#thumbnails li a").click( function() {
	var th_url = $("img", this).attr("src");
	var img_url = th_url.substr(th_url,th_url.length-7)+".png";
	$("#photo img").attr("src", img_url);
	return false;
});
</script>


<% include file='_footer.tpl' %>
