<% switch from = $id_language %>
	<% case value='hu' %><% assign name="title" value="Kosár | ".$shop[name] %>
	<% case %><% assign name="title" value="Cart | ".$shop[name] %>
<% /switch %>
<% pagetag name="title" value=$siteconfig[site_name] method="append" %>
<% include file='_header.tpl' %>

<div class="content-box">
	<div class="outline">
<% if $productlist || $packlist %>
<script type="text/javascript">
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
		<% switch from = $id_language %>
			<% case value='en' %>window.location = "<% $siteconfig[site_url] %>/checkout";
			<% case value='hu' %>window.location = "<% $siteconfig[site_url] %>/penztar";
		<% /switch %>
	});
});
</script>

		<h1>
			<% switch from = $id_language %>
				<% case value='en' %>Basket
				<% case value='hu' %>Kosár
			<% /switch %>
		</h1>
		<div class="cart productlist">
			<div class="title">
				<% switch from = $id_language %>
					<% case value='hu' %>
						<span class="product">Termék</span>
						<span class="quantity">Mennyiség</span>
						<span class="subtotal">Ár</span>
						<span class="remove"></span>
				<% case %>
						<span class="product">Product</span>
						<span class="quantity">Quantity</span>
						<span class="subtotal">Price</span>
						<span class="remove"></span>
				<% /switch %>
			</div>
		
			<% foreach from=$productlist item=product %>
			<div id="item_<% $product[id_product] %>" class="item">
				<div class="product">
					<a class="photo" href="<% $siteconfig[site_url] %>/<% $product[category_permalink] %>/<% $product[permalink] %>">
						<img src="<% imgresize file='content/files/product/original/'.$product[photo_filename] resized_filename='content/files/product/resized/'.$product[id_product]|id2dir.'/'.$product[permalink].'_'.$product[category_permalink].'_'.$product[shop_permalink].'_'.$product[id_photo].'_220x220_fill' width=220 height=220 type='fill' %>" />
					</a>
					<a class="name" href="<% $siteconfig[site_url] %>/<% $product[category_permalink] %>/<% $product[permalink] %>"><% $product[name] %></a>
					<span class="price">£<% $product[price]|number_format:0:'':' ' %> each</span>
				</div>
				<div class="quantity">
					<form class="form_update" action="<% $siteconfig[site_url] %>/basket/" method="put">
					<fieldset>
						<input name="id_product" value="<% $product[id_product] %>" type="hidden" />
						<input name="quantity" value="<% $product[quantity] %>" type="text" />
						<button type="submit">Ok</button>
					</fieldset>
					</form>
				</div>
				<span class="subtotal">£<% $product[total]|number_format:0:'':' ' %></span>
				<div class="remove">
					<form class="form_delete" action="<% $siteconfig[site_url] %>/basket/" method="delete">
					<fieldset>
						<input name="id_product" value="<% $product[id_product] %>" type="hidden" />
						<button class="btn_del imgreplace" type="submit">
							<% switch from = $id_language %>
								<% case value='hu' %>Törlés
								<% case %>Remove
							<% /switch %>
						</button>
					</fieldset>
					</form>
				</div>
			</div>
			<% /foreach %>
		
			<% foreach from=$packlist item=pack %>
			<div id="item_<% $pack[id_pack] %>" class="item">
				<div class="product">
					<a class="photo" href="<% $siteconfig[site_url] %>/<% $pack[permalink] %>">
						<img src="<% imgresize file='content/files/pack/original/'.$pack[photo_filename] resized_filename='content/files/pack/resized/'$pack[id_pack]|id2dir.'/'.$pack[permalink].'_'.$pack[shop_permalink].'_'.$pack[id_photo].'_100x160_crop' width=100 height=160 type='crop' %>" alt="<% $pack[name] %>"/>
					</a>
					<a class="name" href="<% $siteconfig[site_url] %>/<% $pack[permalink] %>"><% $pack[name] %></a>
					<span class="price"><% $pack[price]|number_format:0:'':' ' %> / db</span>
				</div>
				<div class="quantity">
					<form class="form_update" action="<% $siteconfig[site_url] %>/basket/" method="put">
					<fieldset>
						<input name="id_pack" value="<% $pack[id_pack] %>" type="hidden" />
						<input name="quantity" value="<% $pack[quantity] %>" type="text" />
						<button type="submit">Ok</button>
					</form>
					<form class="form_delete" action="<% $siteconfig[site_url] %>/basket/" method="delete">
					<fieldset>
						<input name="id_pack" value="<% $pack[id_pack] %>" type="hidden" />
						<button class="btn_del imgreplace" type="submit">Törlés</button>
					</fieldset>
					</form>
				</div>
				<span class="subtotal">£<% $pack[total]|number_format:0:'':' ' %></span>
			</div>
			<% /foreach %>
		
		</div>
		<div class="total">
			<span class="info">
				<strong>
				<% switch from = $count %>
					<% case value=1 %><% $count %> item
					<% case %><% $count %> items
				<% /switch %>
				</strong>
				in your basket. Total: <strong>£<% $total|number_format:0:'':' ' %></strong>
			</span>
			<% switch from = $id_language %>
				<% case value='hu' %><button id="btn_checkout" class="important" type="button">Megrendelés</button>
				<% case %><button id="btn_checkout" class="important" type="button">Proceed to checkout</button>
			<% /switch %>
		</div>
		
		
		<% else %>
		<script type="text/javascript">
		$(document).ready( function() {
			$("#btn_home").click( function() {
				window.location = "<% $siteconfig[site_url] %>";
			});
		});
		</script>
		<div class="empty">
		
		<% switch from = $id_language %>
			<% case value='hu' %>
				<span>A kosár üres</span>
				<div class="action">
					<button id="btn_home" type="button">Vissza a főoldalra</button>
				</div>
			<% case %>
				<span>Your cart is empty</span>
				<div class="action">
					<button id="btn_home" type="button">Back to the index page</button>
				</div>
		<% /switch %>
		
		</div>
		<% /if %>
	</div>
</div>

<% include file='_footer.tpl' %>
