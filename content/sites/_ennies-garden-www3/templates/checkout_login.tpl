<% switch from=$id_language %>
	<% case value='hu' %><% assign name='title' value='Megrendelés - bejelentkezés | '.$shop[name] %>
	<% case %><% assign name='title' value='Checkout - Step 1/3 - Sign In | '.$shop[name] %>
<% /switch %>
<% include file='_header.tpl' %>

<div class="wrapper">
	<div class="content-box">
		<h1>Checkout</h1>
		<div class="steps">
			<ul class="steps">
				<li class="active"><span class="order">1</span>Sign In</li>
				<li><span class="order">2</span>Delivery details</li>
				<li><span class="order">3</span>Payment</li>
				<li><span class="order">4</span>Confirm</li>
			</ul>
		</div>
		
		<div class="login_options">
		
			<div id="checkout_login">
				<h2>Sign In</h2>
				<form id="form_checkout_login" action="<% $siteconfig[site_url] %>/customerauth/" method="put">

				<div class="formdiv">
					<div class="item">
						<label for="checkout_login_email">Email address *</label>
						<input id="checkout_login_email" name="email" type="text" />
					</div>
					<div class="item">
						<label for="checkout_login_passw">Password *</label>
						<input name="passw" type="hidden" />
						<input id="checkout_login_passw" type="password" />
					</div>
					<div class="item">
						<button type="submit">Sign in</button>
					</div>
				</div>
				</form>
<%*
				<div class="facebook-login">
					<h2>Or sign in with your Facebook or Google account</h2>
					<div class="fb-login-button" data-max-rows="1" data-size="large" data-show-faces="false" data-auto-logout-link="false"></div>
					<span id="signinButton">
					  <span
					    class="g-signin"
					    data-callback="signinCallback"
					    data-clientid="<% $siteconfig[google_client_id] %>"
					    data-cookiepolicy="single_host_origin"
					    data-requestvisibleactions="http://schema.org/AddAction"
					    data-scope="profile">
					  </span>
					</span>
				</div>
*%>
			</div>

			<div id="checkout_continue">
				<h2>Guest & New Customers</h2>
				<p class="info">
					You can place an order without registering. <br />
					You can register and create an account after checkout.
				</p>
				<button id="btn_continue" type="button">Checkout now</button>
			</div>

		</div>
	</div>
</div>

<script>
onLoadFunctions.push( function() {
	$("#form_checkout_login").ajaxForm({
		dataType: "json",
		beforeSerialize: function() {
			var passw_md5 = $("#checkout_login_passw").val() == "" ? "" : $.md5($("#checkout_login_passw").val());
			$("#form_checkout_login input[name=passw]").val(passw_md5);
		},
		success: function(data) {
			if (data.error == "") {
				<% switch from = $id_language %>
					<% case value='en' %>window.location = "<% $siteconfig[site_url] %>/checkout/details";
					<% case value='hu' %>window.location = "<% $siteconfig[site_url] %>/penztar/reszletek";
				<% /switch %>
			}
			else {
				<% include file='_js_error.tpl' %>
			}
		}
	});
	
	$("#btn_continue").click( function() {
		<% switch from = $id_language %>
			<% case value='en' %>window.location = "<% $siteconfig[site_url] %>/checkout/details";
			<% case value='hu' %>window.location = "<% $siteconfig[site_url] %>/penztar/reszletek";
		<% /switch %>
	});
});
</script>

<div id="fb-root"></div>
<script>(function(d, s, id) {
  var js, fjs = d.getElementsByTagName(s)[0];
  if (d.getElementById(id)) return;
  js = d.createElement(s); js.id = id;
  js.src = "//connect.facebook.net/en_US/sdk.js#xfbml=1&appId=&version=v2.0";
  fjs.parentNode.insertBefore(js, fjs);
}(document, 'script', 'facebook-jssdk'));</script>

<script>
/*
  (function() {
   var po = document.createElement('script'); po.type = 'text/javascript'; po.async = true;
   po.src = 'https://apis.google.com/js/client:plusone.js';
   var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(po, s);
 })();
*/
</script>

<% include file='_footer.tpl' %>