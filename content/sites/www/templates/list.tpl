<ul>

<% if $productlist %>
<% foreach from=$productlist item=product %>
<li>
	<span class="name">
		<a href="<% $siteconfig[site_url] %>/<% $product[category_permalink] %>/<% $product[permalink] %>">
			<% $product[name] %>
		</a>
	</span>
	<span class="short_description">
		<a href="<% $siteconfig[site_url] %>/<% $product[category_permalink] %>/<% $product[permalink] %>">
			<% $product[short_description] %>
		</a>
	</span>
	<a class="photo" href="<% $siteconfig[site_url] %>/<% $product[category_permalink] %>/<% $product[permalink] %>">
		<img src="<% imgresize file='content/files/product/original/'.$product[photo_filename] resized_filename='content/files/product/resized/'.$product[id_product]|id2dir.'/'.$product[permalink].'_'.$product[category_permalink].'_'.$product[shop_permalink].'_'.$product[id_photo].'_100x160_crop' width=100 height=160 type='crop' %>" alt="product photo" />
	</a>
	<span class="price"><% $product[price]|number_format:0:'':' ' %> Ft</span>
	<div class="cart"><input type="text" name="quantity" value="1" /><button class="btn_cart" id_product="<% $product[id_product] %>">Kosárba</button></div>
</li>
<% /foreach %>
<% /if %>

<% if $packlist %>
<% foreach from=$packlist item=pack %>
<li>
	<span class="name">
		<a href="<% $siteconfig[site_url] %>/<% $pack[permalink] %>">
			<% $pack[name] %>
		</a>
	</span>
	<span class="short_description">
		<a href="<% $siteconfig[site_url] %>/<% $pack[category_permalink] %>/<% $pack[permalink] %>">
			<% $pack[short_description] %>
		</a>
	</span>
	<a class="photo" href="<% $siteconfig[site_url] %>/<% $pack[permalink] %>">
		<img src="<% imgresize file='content/files/pack/original/'.$pack[photo_filename] resized_filename='content/files/pack/resized/'.$pack[id_pack]|id2dir.'/'.$pack[permalink].'_'.$pack[category_permalink].'_'.$pack[shop_permalink].'_'.$pack[id_photo].'_100x160_crop' width=100 height=160 type='crop' %>" alt="pack photo" />
	</a>
	<span class="price"><% $pack[price]|number_format:0:'':' ' %> Ft</span>
	<div class="cart">
		<input type="text" name="quantity" value="1" />
		<button class="btn_cart" id_pack="<% $pack[id_pack] %>">Kosárba</button>
	</div>
</li>
<% /foreach %>

<% /if %>

<script>
$(".btn_cart").click( function() {
	var btn_obj = this;
	$(btn_obj).addClass("inprogress");
	$(btn_obj).attr("disabled", true);
	$(btn_obj).attr("btn_label", $(btn_obj).html());
	$(btn_obj).html("Kérem várjon");
	$.ajax({
		type: "POST",
		url: "<% $siteconfig[site_url] %>/cart",
		data: {
			id_product: $(this).attr("id_product"),
			id_pack: $(this).attr("id_pack"),
			quantity: $("input[name=quantity]", $(this).parent()).val()
		},
		dataType: "json",
		success: function(data) {
			$(btn_obj).removeClass("inprogress");
			$(btn_obj).attr("disabled", false);
			$(btn_obj).html($(btn_obj).attr("btn_label"));

			if (data.error == "") {
				$.jGrowl("A termék a kosárba került");
				$("#cart").load("<% $siteconfig[site_url] %>/cart/gadget/<% $lang_iso %>");
				$("aside .cart").load("<% $siteconfig[site_url] %>/cart/aside/<% $lang_iso %>");
			}
			else {
				<% include file='_js_error.tpl' %>
			}
		}
	});
});
</script>
</ul>
