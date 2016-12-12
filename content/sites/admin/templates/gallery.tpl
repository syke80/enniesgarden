<% include file='_header.tpl' %>

<form action="<% $siteconfig[site_url] %>/gallery/" class="dropzone" id="my-dropzone">
  <div class="dz-message">
    Drop files here or click to upload.<br />
  </div>
</form>
<div id="imagelist">
</div>

<script>
$("#imagelist").load("<% $siteconfig[site_url] %>/gallery/imagelist/");

Dropzone.options.myDropzone = {
	paramName: "file",
	maxFilesize: 8, // MB
	accept: function(file, done) {
		done();
	},
	success: function() {
		$("#imagelist").load("<% $siteconfig[site_url] %>/gallery/imagelist/");
	}
};

$(".btn-del").click( function() {
	$(this).parent().attr("data-id-image");
});
</script>

<% include file='_footer.tpl' %>
