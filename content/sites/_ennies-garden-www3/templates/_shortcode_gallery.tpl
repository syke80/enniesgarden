<div class="gallery">
<ul>
<% foreach from=$imagelist item=image %>
	<li data-id-image="<% $image[id_gallery_image] %>">
		<a href="<% imgresize file='content/files/gallery/original/'.$image[filename] resized_filename='content/files/gallery/resized/'.$image[filename].'_1080x600_keep' width=1080 height=600 type='keep' %>" data-alt="<% $image[title] %>" />
			<img src="<% imgresize file='content/files/gallery/original/'.$image[filename] resized_filename='content/files/gallery/resized/'.$image[filename].'_235x235_crop' width=235 height=235 type='crop' %>" alt="<% $image[title] %>" />
		</a>
		<a class="title" href="<% imgresize file='content/files/gallery/original/'.$image[filename] resized_filename='content/files/gallery/resized/'.$image[filename].'_1080x600_keep' width=1080 height=600 type='keep' %>" data-alt="<% $image[title] %>" />
			<% $image[title] %>
		</a>
	</li>
<% /foreach %>
</ul>
</div>

<div id="gallery-popup" style="display:none">
</div>

<script>
function calculateDimensions(img) {
	var maxWidth = $( window ).width();
	var maxHeight = $( window ).height();
	var width = img.width;
	var height = img.height;
	if (width > maxWidth) {
		width = maxWidth;
		height = width / (img.width / img.height);
	}
	if (height > maxHeight) {
		height = maxHeight;
		width = height * (img.width / img.height);
	}
	return {
		width: width,
		height: height
	};
}

onLoadFunctions.push( function() {
	$(".gallery ul li a").click( function() {
		$("#gallery-popup").html("<img src=\""+$(this).attr("href")+"\" alt=\""+$(this).attr("data-alt")+"\" />");
		$("#gallery-popup img").imagesLoaded( function() {
			var img = this[0];
			$.sPopup({
				object: "#gallery-popup",
				onArrange: function() {
					var dimensions = calculateDimensions(img);
					$(".spopup img").css("width", dimensions.width * 0.8);
					$(".spopup img").css("height", dimensions.height * 0.8);
				},
				onLoad: function() {
					$(".spopup").click( function() {
						$.sPopup('destroy');
					});
				}
			});
		});
		return false;
	});
});
</script>
