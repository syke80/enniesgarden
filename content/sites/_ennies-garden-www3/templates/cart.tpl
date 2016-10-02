<% switch from = $id_language %>
	<% case value='hu' %><% assign name="title" value="Kosár | ".$shop[name] %>
	<% case %><% assign name="title" value="Basket | ".$shop[name] %>
<% /switch %>

<% include file='_header.tpl' %>

<div class="wrapper">
	<div class="content-box">
		<h1>
			<% switch from = $id_language %>
				<% case value='en' %>Basket
				<% case value='hu' %>Kosár
			<% /switch %>
		</h1>
		<script>
			function loadContent() {
				var parameters = "shipping=hermes";
				if ($("#coupon").val()) parameters += "&coupon="+encodeURIComponent($("#coupon").val());
				$(".cart-content").load("<% $siteconfig[site_url] %>/basket/content/?"+parameters);
			}
			onLoadFunctions.push( function() {
				loadContent();
				$("#coupon-form").submit( function() {
					$("#coupon-form button, #coupon-form input").blur();
					loadContent();
					return false;
				});
			});
		</script>
<%*
		<form id="coupon-form">
			<input id="coupon" name="coupon" placeholder="Have you got a coupon code? Type here!" />
			<button id="btn-apply-coupon" type="submit">Apply coupon!</button>
		</form>
*%>
		<div class="cart-content">
		</div>
	</div>
</div>

<% include file='_footer.tpl' %>
