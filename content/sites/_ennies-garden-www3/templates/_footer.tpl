			</div>
		</div>
		<footer>
			<div class="top"></div>
			<div class="body">
				<div class="wrapper">
<%*
					<% page permalink='_footer-'.$id_language region='body' id_site='www' %>
*%>
					<div>
						<div class="product-links">
<%*
							<a href="/made-with-alcohol/">Alcohol products</a>
							<a href="/made-from-single-fruit/">Single fruit products</a>
							<a href="/made-from-multi-fruit/">Multi fruit products</a>
*%>
							<a href="/jam/">Jams</a>
							<a href="/curd/">Curds</a>
							<a href="/marmalade/">Marmalades</a>
							<a href="/perfect-dunking/">Perfect dunking</a>
						</div>
						<div class="info-links">
							<a href="/about-us/">About us</a>
							<a href="/contact-us/">Contact us</a>
<%*
							<a href="/meet-us/">Meet us</a>
*%>							
							<a href="/gallery/">Gallery</a>
							<a href="/faq/">FAQ</a>
							<a href="/sitemap/">Sitemap</a>
							<a href="/shipping-information/">Shipping information</a>
							<a href="/terms-and-conditions/">Terms and conditions</a>
						</div>
						<div class="our-partners">
							Complete your dining table with <a href="/our-partners/">our partners</a>' premium quality products.
						</div>
					</div>

					<div>
						<div class="contact-text">
							<h3>Get in touch!</h3>
							<p>We pride ourselves on being a friendly company, we’d love to know how you feel about our products and we would be happy to answer any questions you may have.</p>
							<p>If you have any ideas or suggestions please don’t hesitate to share them with us.</p>
							<p>Feel free to contact us via any of the methods listed, or fill in our enquiry form.</p>
						</div>
					</div>
					<div>
						<div class="contact">
							<h3>Pop us an email</h3>
							<p>
								<a href="mailto:ennie@enniesgarden.co.uk">ennie@enniesgarden.co.uk</a>
							</p>
	
							<h3>Chat with us on Skype</h3>
							<p>
								enniesgarden
							</p>
<%*	
							<h3>Give us a ring</h3>
							<p>
								7472 741264
							</p>
*%>	
							<h3>Get Social with us</h3>
							<p itemscope itemtype="http://schema.org/Organization">
								<link itemprop="url" href="<% $siteconfig[site_url] %>"> 
								<span class="social-links">
									<a itemprop="sameAs" href="https://www.facebook.com/enniesgarden" target="_blank"><span class="fa fa-facebook"></span></a>
									<a itemprop="sameAs" href="http://google.com/+EnniesgardenCoUk" target="_blank"><span class="fa fa-google-plus"></span></a>
									<a itemprop="sameAs" href="http://www.pinterest.com/enniesgarden/" target="_blank"><span class="fa fa-pinterest"></span></a>
								</span>
							</p>
							<p>
								<span class="tag">
									Don't Forget<br />
									Use <strong>#enniesgarden</strong> on <br />
									your related pics & posts
								</span>
							</p>
						</div>
					</div>
					<div>
						<div class="contact-form-container">
							<form id="contact-form" action="/contact/" method="post">
								<input type="hidden" name="subject" value="Enquiry from the website" />
								<div class="item">
									<label>Your name</label>
									<input name="name" type="text" placeholder="e.g. John Doe" />
								</div>
								<div class="item">
									<label>Your email</label>
									<input name="email" type="text" placeholder="e.g. address@example.ext" />
								</div>
								<div class="item">
									<label>Message</label>
									<textarea name="message" placeholder="Your message goes here"></textarea>
								</div>
								<div class="item">
									<button type="submit">Send message</button>
								</div>
							</form>
						</div>
						<script>
							onLoadFunctions.push( function() {
								$("#contact-form").ajaxForm({
									dataType: "json",
									beforeSubmit: function(arr, $form, options) {
										$("button", $form).addClass("inprogress");
										$("button", $form).attr("disabled", true);
										$("button", $form).attr("btn_label", $("button", $form).html());
										$("button", $form).html("Please wait");
									},
									success: function(data, statusText, xhr, $form) {
										$("button", $form).removeClass("inprogress");
										$("button", $form).attr("disabled", false);
										$("button", $form).html($("button", $form).attr("btn_label"));
										if (data.error == "") {
											$("input[type=text], textarea", $form).val("");

											$.sPopup({
												object: "#footer-contact-popup"
											});
										}
										else {
											<% include file='_js_error.tpl' %>
										}
									}
								});
							})
						</script>
					</div>
				</div>
			</div>
		</footer>
		<div id="footer-contact-popup" class="modal-content" style="display: none">
			<p>
				Your message has been sent successfully. <br />
				We will contact you very soon!
			</p>
			<p class="actions">
				<a class="btn btn-close" href="#" onclick="$.sPopup('destroy'); return false;">Ok</a>
			</p>
		</div>
		<link href='http://fonts.googleapis.com/css?family=Merriweather|IM+Fell+English' rel='stylesheet' type='text/css'>
		<% loadcss files="below-the-fold.css, jquery.spopup.css, font-awesome.css" output="enniesgarden-below.css" test=$siteconfig[debug] %>
		<!--[if lt IE 9]>
		<script src="//html5shim.googlecode.com/svn/trunk/html5.js"></script>
		<![endif]-->
		<script src="//ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
		<script src="//ajax.googleapis.com/ajax/libs/jqueryui/1.10.3/jquery-ui.min.js"></script>
		<script src="<% $siteconfig[site_url] %>/content/javascript/jquery.spopup.min.js"></script>
		<script src="<% $siteconfig[site_url] %>/content/javascript/jquery.imagesloaded.min.js"></script>
		<script src="<% $siteconfig[site_url] %>/core/javascript/jquery.form.min.js"></script>
		<script>
		for (i in onLoadFunctions) {
			onLoadFunctions[i]();
		}

		// Store pixel ratio in a cookie
		var d = new Date();
		d.setTime(d.getTime() + (24 * 60 * 60 * 1000));
		var expires = "expires=" + d.toUTCString();
		document.cookie = "pixelRatio=" + window.devicePixelRatio + "; " + expires;
		</script>
		<% include file="_coupon.tpl" %>
		<% include file="_google_analytics.tpl" %>
		<% include file="_heatmap.tpl" %>
	</body>
</html>
