<script type="text/javascript">
jQuery.fn.refreshPhotoList = function() {
	$(this).find(".list").load('<% $siteconfig[site_url] %>/product_photo/list/<% $info[id_product] %>');
}

$(document).ready(function() {
	$("#form_photo, #form_dlphoto").ajaxForm({
		dataType: "json",
		success: function(data) {
			if (data.error == "") {
				$.jGrowl("Image is successfully uploaded");
				$("#dlphoto_uploadurl").val("");
				$("#dlphoto_uploadurl").focus();
				$("#photo").refreshPhotoList();
			}
			else {
				<% include file='_js_error.tpl' %>
			}
		}
	});
	$("#photo").refreshPhotoList();
});
</script>

<div id="photo">
	<form id="form_photo" action="<% $siteconfig[site_url] %>/product_photo/" method="post" enctype="multipart/form-data">
		<div class="formdiv">
			<input name="id_product" type="hidden" value="<% $info[id_product] %>" />
			<div class="item">
				<label for="photo_uploadfile">File</label>
				<input name="uploadfile" id="photo_uploadfile" type="file" />
			</div>
			<div class="item">
				<button id="btn_photo_submit" type="submit"><span>Ok</span></button>
			</div>
		</div>
	</form>
	<form id="form_dlphoto" action="<% $siteconfig[site_url] %>/product_photo/" method="post">
		<div class="formdiv">
			<input name="id_product" type="hidden" value="<% $info[id_product] %>" />
			<div class="item">
				<label for="dlphoto_uploadurl">File from external url</label>
				<input name="uploadurl" id="dlphoto_uploadurl" />
			</div>
			<div class="item">
				<button id="btn_photo_submit" type="submit"><span>Ok</span></button>
			</div>
		</div>
	</form>
	<div class="list"></div>
</div>
