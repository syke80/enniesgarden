<% if $productlist || $packlist %>
<script>
$(document).ready( function() {
	$(".form_update").ajaxForm({
		dataType: "json",
		success: function(data) {
			if (data.error == "") {
				window.location.reload();
			}
			else {
				<% include file='_js_error.tpl' %>
			}
		}
	});

	$(".cart_quantity").change( function() {
		$(this).closest("form").submit();
	});

	$(".form_delete").ajaxForm({
		dataType: "json",
		success: function(data) {
			if (data.error == "") {
				window.location.reload();
			}
			else {
				<% include file='_js_error.tpl' %>
			}
		}
	});

	$("#btn_checkout").click( function() {
		<% switch from = $language_iso %>
			<% case value='hu' %>window.location = "<% $siteconfig[site_url] %>/penztar";
			<% case %>window.location = "<% $siteconfig[site_url] %>/checkout";
		<% /switch %>
	});
});
</script>
<h3>
	<% switch from = $id_language %>
		<% case value='hu' %>Szűrők megjelenítése
		<% case %>Show filters
	<% /switch %>
</h3>
<div class="productlist">
	<% foreach from=$productlist item=product %>
	<div id="item_<% $product[id_product] %>" class="item">
		<div class="product">
			<a class="photo" href="<% $siteconfig[site_url] %>/<% $product[category_permalink] %>/<% $product[permalink] %>">
				<img src="<% imgresize file='content/files/product/original/'.$product[photo_filename] resized_filename='content/files/product/resized/'$product[id_product]|id2dir.'/'.$product[permalink].'_'.$product[category_permalink].'_'.$product[shop_permalink].'_'.$product[id_photo].'_40x64_crop' width=40 height=64 type='crop' %>" alt="<% $product[name] %>"/>
			</a>
			<a class="name" href="<% $siteconfig[site_url] %>/<% $product[category_permalink] %>/<% $product[permalink] %>"><% $product[name] %></a>
			<span class="price"><% $product[price]|number_format:0:'':' ' %> / db</span>
		</div>
		<div class="quantity">
			<form class="form_update" action="<% $siteconfig[site_url] %>/cart" method="put">
				<fieldset>
					<input name="id_product" value="<% $product[id_product] %>" type="hidden" />
					<input name="quantity" value="<% $product[quantity] %>" type="text" /> db
					<button type="submit">Ok</button>
				</fieldset>
			</form>
			<form class="form_delete" action="<% $siteconfig[site_url] %>/cart" method="delete">
				<fieldset>
					<input name="id_product" value="<% $product[id_product] %>" type="hidden" />
					<button class="btn_del" type="submit">Törlés</button>
				</fieldset>
			</form>
		</div>
		<span class="subtotal"><% $product[total]|number_format:0:'':' ' %> Ft</span>
	</div>
	<% /foreach %>

	<% foreach from=$packlist item=pack %>
	<div id="item_<% $pack[id_pack] %>" class="item">
		<div class="product">
			<a class="photo" href="<% $siteconfig[site_url] %>/<% $pack[permalink] %>">
				<img src="<% imgresize file='content/files/pack/original/'.$pack[photo_filename] resized_filename='content/files/pack/resized/'.$pack[id_pack]|id2dir.'/'.$pack[permalink].'_'.$pack[shop_permalink].'_'.$pack[id_photo].'_40x64_crop' width=40 height=64 type='crop' %>" alt="<% $pack[name] %>"/>
			</a>
			<a class="name" href="<% $siteconfig[site_url] %>/<% $pack[permalink] %>"><% $pack[name] %></a>
			<span class="price"><% $pack[price]|number_format:0:'':' ' %> / db</span>
		</div>
		<div class="quantity">
			<form class="form_update" action="<% $siteconfig[site_url] %>/cart" method="put">
			<fieldset>
				<input name="id_pack" value="<% $pack[id_pack] %>" type="hidden" />
				<input name="quantity" value="<% $pack[quantity] %>" type="text" />
				<button type="submit">Ok</button>
			</fieldset>
			</form>
			<form class="form_delete" action="<% $siteconfig[site_url] %>/cart" method="delete">
			<fieldset>
				<input name="id_pack" value="<% $pack[id_pack] %>" type="hidden" />
				<button class="btn_del" type="submit">Törlés</button>
			</fieldset>
			</form>
		</div>
		<span class="subtotal"><% $pack[total]|number_format:0:'':' ' %> Ft</span>
	</div>
	<% /foreach %>

</div>
<div class="total">
	<span><% $total %> Ft</span>
</div>

<div class="action">
	<button id="btn_cart" type="button">
		<% switch from = $language_iso %>
			<% case value='hu' %>Kosár megtekintése
			<% case %>View cart
		<% /switch %>
	</button>
	<button id="btn_checkout" type="button">
		<% switch from = $language_iso %>
			<% case value='hu' %>Pénztár
			<% case %>Checkout
		<% /switch %>
	</button>
</div>
<% else %>
<div class="empty">
<span>
	<% switch from = $language_iso %>
		<% case value='hu' %>A kosár üres
		<% case %>The cart is empty
	<% /switch %>
</span>
<div class="action">
	<button id="btn_home" type="button">
	<% switch from = $language_iso %>
		<% case value='hu' %>Vissza a főoldalra
		<% case %>Back to the index page
	<% /switch %>
	</button>
</div>
</div>
<% /if %>
<script>
set_content_size();
</script>