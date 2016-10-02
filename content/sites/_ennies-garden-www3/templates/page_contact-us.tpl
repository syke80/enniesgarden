<% assign name='pageid' value='contact-us' %>
<% foreach from=$contentlist item='region' %>
	<% switch from = $region[region_name] %>
		<% case value='Language code' %>
			<% assign name='id_language' value=$region[content] %>
		<% case value='Title' %>
			<% assign name='title' value=$region[content] %>
		<% case value='Keywords' %>
			<% assign name='keywords' value=$region[content] %>
		<% case value='Description' %>
			<% assign name='description' value=$region[content] %>
		<% case value='Body' %>
			<% assign name='page_content' value=$region[content] %>
		<% case value='Aside' %>
			<% assign name='aside' value=$region[content] %>
	<% /switch %>
<% /foreach %>
<% assign name='canonical' value=$siteconfig[site_url].'/contact-us/' %>
<% include file='_header.tpl' %>
<div class="wrapper">
	<div class="content-box">
		<div class="textpage">

			<div>
			<% $page_content %>
			</div>
	
			<div class="contact-methods">
				<ul>
					<li>
						<a href="https://www.facebook.com/enniesgarden" target="_blank">
							<span class="fa fa-facebook"></span>
							facebook.com/enniesgarden
						</a>
					</li>
					<li>
						<a href="http://google.com/+EnniesgardenCoUk" target="_blank">
							<span class="fa fa-google-plus"></span>
							google.com/+EnniesgardenCoUk
						</a>
					</li>
					<li>
						<a href="http://www.pinterest.com/enniesgarden/" target="_blank">
							<span class="fa fa-pinterest"></span>
							pinterest.com/enniesgarden/
						</a>
					</li>
					<li>
						<a href="mailto:ennie@enniesgarden.co.uk">
							<span class="fa fa-envelope"></span>
							ennie@enniesgarden.co.uk
						</a>
					</li>
					<li>
						<span class="fa fa-skype"></span>
						enniesgarden
					</li>
				<ul>
			</div>
	
			<div class="contact-page-form-container">
				<form id="page-contact-form" action="/contact/" method="post">
					<input type="hidden" name="subject" value="Enquiry from the website" />
					<div class="item">
						<label>Your name</label>
						<input name="name" />
					</div>
					<div class="item">
						<label>Your email</label>
						<input name="email" />
					</div>
					<div class="item">
						<label>Message</label>
						<textarea name="message"></textarea>
					</div>
					<div class="item">
						<button type="submit">Send message</button>
					</div>
				</form>
			</div>
			<script>
				onLoadFunctions.push( function() {
					$("#page-contact-form").ajaxForm({
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

<% include file='_footer.tpl' %>
