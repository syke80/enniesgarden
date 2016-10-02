<ul>
<% foreach from=$imagelist item=image %>
	<li data-id-image="<% $image[id_gallery_image] %>">
		<img src="<% imgresize file='content/files/gallery/original/'.$image[filename] resized_filename='content/files/gallery/resized/'.$image[filename].'_160x160_crop' width=160 height=160 type='crop' %>" />
		<span class="filename"><% $image[filename] %></span>
		<form class="gallery-image-update" action="<% $siteconfig[site_url] %>/gallery/<% $image[id_gallery_image] %>" method="put">
			<div class="title">
				<input name="title" type="text" value="<% $image[title] %>" />
				<button type="submit">Update title</button>
			</div>
		</form>
		<form class="gallery-image-delete" action="<% $siteconfig[site_url] %>/gallery/<% $image[id_gallery_image] %>" method="delete">
			<button class="btn-del" type="submit">Delete</button>
		</form>
	</li>
<% /foreach %>
</ul>

<script>
$(".gallery-image-update").ajaxForm({
		dataType: "json",
		success: function(data) {
			$("#imagelist").load("<% $siteconfig[site_url] %>/gallery/imagelist/");
		}
});
$(".gallery-image-delete").ajaxForm({
		dataType: "json",
		success: function(data) {
			$("#imagelist").load("<% $siteconfig[site_url] %>/gallery/imagelist/");
		}
});
</script>
