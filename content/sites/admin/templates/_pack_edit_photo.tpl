<script type="text/javascript">
jQuery.fn.refreshPhotoList = function() {
	$(this).find(".list").load('<% $siteconfig[site_url] %>/pack_photo/list/<% $info[id_pack] %>/');
}

$(document).ready(function() {
	$("#form_photo").ajaxForm({
		dataType: "json",
		success: function(data) {
			if (data.error == "") {
				$.jGrowl("Image is successfully uploaded");
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
	<form id="form_photo" action="<% $siteconfig[site_url] %>/pack_photo/" method="post" enctype="multipart/form-data">
		<div class="formdiv">
			<input name="id_pack" type="hidden" value="<% $info[id_pack] %>" />
			<div class="item">
				<label for="photo_uploadfile">File</label>
				<input name="uploadfile" id="photo_uploadfile" type="file" />
			</div>
			<div class="item">
				<button id="btn_photo_submit" type="submit"><span>Ok</span></button>
			</div>
		</div>
	</form>
	<div class="list"></div>
</div>
