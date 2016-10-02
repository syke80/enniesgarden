<script type="text/javascript">
$(document).ready( function() {
	$(this).imgReplace();

	$("#photo_list .btn_fullscreen").hide();
	$("#photo_list li").mouseenter( function() { $(".btn_fullscreen", this).fadeIn("slow"); } );
	$("#photo_list li").mouseleave( function() { $(".btn_fullscreen", this).fadeOut("slow"); } );

	$("#photo_list .btn_delete").hide();
	$("#photo_list li").mouseenter( function() { $(".btn_delete", this).fadeIn("slow"); } );
	$("#photo_list li").mouseleave( function() { $(".btn_delete", this).fadeOut("slow"); } );

	$("#photo_list .btn_fullscreen").click( function() {
		var th_filename = $(this).parent().find("img").attr("src");
		window.open($(this).attr("image"));
	} );

	$("#photo_list .form_delete").ajaxForm({
			dataType: "json",
			success: function(data) {
				$("#photo").refreshPhotoList();
			}
	});

	<%* drag n drop rendezés *%>
	$("#photo_list").sortable({
		placeholder: "ui-state-highlight",
		forcePlaceholderSize: true,
		update: function() {
			$.post(
				"<% $siteconfig[site_url] %>/pack_photo/",
				{
					order: $("#photo .admin_list").sortable("serialize")
				}
			);

		}
	});
	$( "#photo_list" ).disableSelection();
});
</script>

<ul id="photo_list" class="admin_list">
	<% if $list %>
		<% foreach from=$list item=item %>
		<li id="photo_<% $item[id_photo] %>" class="item">
			<img src="<% imgresize file='content/files/pack/original/'.$item[filename] resized_filename='content/files/pack/resized/'.$packinfo[id_photo]|id2dir.'/'.$packinfo[permalink].'_'.$packinfo[category_permalink].'_'.$packinfo[shop_permalink].'_'.$item[id_photo].'_100x160_crop' width=100 height=160 type='crop' %>" alt="pack photo" />
			<button class="btn_fullscreen imgreplace" image="content/files/pack/original/<% $item[filename] %>">Full screen</button>
			<form class="form_delete" action="<% $siteconfig[site_url] %>/pack_photo/<% $item[id_photo] %>/" method="delete">
			<button class="btn_delete imgreplace">Delete</button>
			</form>
		</li>
		<% /foreach %>
	<% /if %>
</ul>
