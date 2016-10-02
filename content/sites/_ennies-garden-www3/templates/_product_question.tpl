<div class="question">
	Have a question about this product? Let us know!
	<form id="question-form" action="/contact/" method="post">
		<input type="hidden" name="subject" value="Question about product - <% $product[name] %>" />
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
	<script>
		onLoadFunctions.push( function() {
			$("#question-form").ajaxForm({
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
						alert("ok");
					}
					else {
						<% include file='_js_error.tpl' %>
					}
				}
			});
		})
	</script>
</div>
