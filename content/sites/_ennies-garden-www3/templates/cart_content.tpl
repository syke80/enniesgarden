<% if $productlist || $packlist %>
<script>
	$(".form_update").ajaxForm({
		dataType: "json",
		success: function(data) {
			if (data.error == "") {
				$(".form_update button").blur();
				loadContent();
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
			<% case value='en' %>window.location = "<% $siteconfig[site_url] %>/checkout/";
			<% case value='hu' %>window.location = "<% $siteconfig[site_url] %>/penztar/";
		<% /switch %>
	});
</script>

		<div class="cart productlist">
			<div class="title">
				<% switch from = $id_language %>
					<% case value='hu' %>
						<span class="product">Termék</span>
						<span class="quantity">Mennyiség</span>
						<span class="remove"></span>
						<span class="subtotal">Ár</span>
				<% case %>
						<span class="product">Product</span>
						<span class="quantity">Quantity</span>
						<span class="remove"></span>
						<span class="subtotal">Price</span>
				<% /switch %>
			</div>
		
			<% foreach from=$productlist item=product %>
			<div id="item_<% $product[id_product] %>" class="item">
				<div class="product">
					<a class="photo" href="<% $siteconfig[site_url] %>/<% $product[permalink] %>">
						<img src="<% imgresize file='content/files/product/original/'.$product[photo_filename] resized_filename='content/files/product/resized/'.$product[id_product]|id2dir.'/'.$product[permalink].'-'.$product[photo_id_photo].'-220x220-fill' width=220 height=220 type='fill' ratio=$pixel_ratio %>" alt="<% $product[name] %>" />
					</a>
					<a class="name" href="<% $siteconfig[site_url] %>/<% $product[permalink] %>"><% $product[name] %></a>
					<span class="price">£<% $product[price]|number_format:2:'.':' ' %> each</span>
				</div>
				<div class="quantity">
					<form class="form_update" action="<% $siteconfig[site_url] %>/basket/" method="put">
					<fieldset>
						<input name="id_product" value="<% $product[id_product] %>" type="hidden" />
						<input name="quantity" value="<% $product[quantity] %>" type="text" />
						<button type="submit">Update</button>
					</fieldset>
					</form>
				</div>
				<div class="remove">
					<form class="form_delete" action="<% $siteconfig[site_url] %>/basket/" method="delete">
					<fieldset>
						<input name="id_product" value="<% $product[id_product] %>" type="hidden" />
						<button class="btn_del" type="submit">
							<% switch from = $id_language %>
								<% case value='hu' %>Törlés
								<% case %>Remove
							<% /switch %>
						</button>
					</fieldset>
					</form>
				</div>
				<span class="subtotal">£<% $product[total]|number_format:2:'.':' ' %></span>
			</div>
			<% /foreach %>
		
			<% foreach from=$packlist item=pack %>
			<div id="item_<% $pack[id_pack] %>" class="item">
				<div class="product">
					<a class="photo" href="<% $siteconfig[site_url] %>/<% $pack[permalink] %>">
						<img src="<% imgresize file='content/files/pack/original/'.$pack[photo_filename] resized_filename='content/files/pack/resized/'.$pack[id_pack]|id2dir.'/'.$pack[permalink].'-'.$pack[photo_id_photo].'-220x220-fill' width=220 height=220 type='fill' ratio=$pixel_ratio %>" alt="<% $pack[name] %>" />
					</a>
					<a class="name" href="<% $siteconfig[site_url] %>/<% $pack[permalink] %>"><% $pack[name] %></a>
					<span class="price">£<% $pack[price]|number_format:2:'.':' ' %> each</span>
				</div>
				<div class="quantity">
					<form class="form_update" action="<% $siteconfig[site_url] %>/basket/" method="put">
					<fieldset>
						<input name="id_pack" value="<% $pack[id_pack] %>" type="hidden" />
						<input name="quantity" value="<% $pack[quantity] %>" type="text" />
						<button type="submit">Update</button>
					</fieldset>
					</form>
				</div>
				<div class="remove">
					<form class="form_delete" action="<% $siteconfig[site_url] %>/basket/" method="delete">
					<fieldset>
						<input name="id_pack" value="<% $pack[id_pack] %>" type="hidden" />
						<button class="btn_del" type="submit">
							<% switch from = $id_language %>
								<% case value='hu' %>Törlés
								<% case %>Remove
							<% /switch %>
						</button>
					</fieldset>
					</form>
				</div>
				<span class="subtotal">£<% $pack[total]|number_format:2:'.':' ' %></span>
			</div>
			<% /foreach %>

			<% if $free_product %>
			<% assign name='product' value=$free_product %>
			<div id="item_<% $product[id_product] %>" class="item">
				<div class="product">
					<a class="photo" href="<% $siteconfig[site_url] %>/<% $product[permalink] %>">
						<img src="<% imgresize file='content/files/product/original/'.$product[photo_filename] resized_filename='content/files/product/resized/'.$product[id_product]|id2dir.'/'.$product[permalink].'-'.$product[photo_id_photo].'-220x220-fill' width=220 height=220 type='fill' ratio=$pixel_ratio %>" alt="<% $product[name] %>" />
					</a>
					<a class="name" href="<% $siteconfig[site_url] %>/<% $product[permalink] %>"><% $product[name] %></a>
					<span class="price">£<% $product[price]|number_format:2:'.':' ' %> each</span>
				</div>
				<div class="quantity">
					1
				</div>
				<div class="remove">
				</div>
				<span class="subtotal free"><span class="old-price">£<% $product[price]|number_format:2:'.':' ' %></span><span class="new-price">FREE</span></span>
			</div>
			<% /if %>
		</div>

		<% if $discount %>
		<div class="discount">
			Coupon: 10% discount <span class="price">-£<% $discount %></span>
		</div>
		<% /if %>

		<div class="shipping">
			<% if $coupon[type]=='free-delivery' && $coupon_error=='' %>
			Free Leicester Delivery <span class="price">£0</span>
			<% else %>
			Standard Delivery<br /> (<strong>FREE</strong> delivery on all orders <strong>over £25</strong>) <span class="price">£<% $shipping_info[price] %></span>
			<% /if %>
		</div>
		<div class="total">
			<span class="info-count">
				<strong>
				<% switch from = $count %>
					<% case value=1 %><% $count %> item
					<% case %><% $count %> items
				<% /switch %>
				</strong>
				in your basket.
			</span>
			<span class="info-price">
				Total: <strong>£<% $total|number_format:2:'.':' ' %></strong>
			</span>
<%*
			<% switch from = $id_language %>
				<% case value='hu' %><button id="btn_checkout" class="important" type="button">Megrendelés</button>
				<% case %><button id="btn_checkout" class="important" type="button">Proceed to checkout</button>
			<% /switch %>
*%>
		</div>
		<div class="actions">
			<% include file='_paypal_button.tpl' %>
		</div>
		
		
		<% else %>
		<script>
		onLoadFunctions.push( function() {
			$("#btn_home").click( function() {
				window.location = "<% $siteconfig[site_url] %>";
			});
		});
		</script>
		<div class="empty">
		
		<% switch from = $id_language %>
			<% case value='hu' %>
				<p class="error-message">A kosár üres</p>
				<div class="action">
					<button id="btn_home" type="button">Vissza a főoldalra</button>
				</div>
			<% case %>
				<p class="error-message">Your cart is empty</p>
				<div class="action">
					<button id="btn_home" type="button">Back to the index page</button>
				</div>
		<% /switch %>
		
		</div>
		<% /if %>
	</div>
</div>
