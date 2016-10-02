<h2>Menu - <% $menu[name] %></h2>
<ul class="admin_list menulist">
	<% if $itemtree %>
		<% foreach from=$itemtree item=menuitem %>
			<% assign name='info' value=$menuitem %>
			<% include file='_menu_list_item.tpl' %>
		<% /foreach %>
	<% /if %>
</ul>

<script>
$(".menulist .item").hover(function () {
	$(this).addClass("hilite");
}, function () {
	$(this).removeClass("hilite");
});

$(".menulist .item .del").click(function() {
	$.simplebox( {
		"simplebox_id": "del_popup",
		"url": "<% $siteconfig[site_url] %>/menuitem/del/"+$(this).attr("id_menu_item")+"/",
		"width": 500,
		"height": 200
	} );								
});


$(".menulist .item .edit").click(function() {
	$.simplebox( {
		"simplebox_id": "edit_popup",
		"url": "<% $siteconfig[site_url] %>/menuitem/edit/"+$(this).attr("id_menu_item")+"/",
		"width": 500,
		"height": 200
	} );								
});


$(".parent select").change( function() {
	var id_menu = $(this).parent().parent().attr("id").substr(5);
	$.ajax({
		type: "put",
		url: "/menuitem/",
		data: {
			"id_menu_item": id_menu,
			"id_parent": $(this).val()
		}
	}).done(
		function (data, textStatus) {
			$("#box_list").load('/menuitem/list/<% $id_menu %>/');
		}
	);
});

$(".menulist, .menulist .submenulist").sortable({
	placeholder: "ui-state-highlight",
	forcePlaceholderSize: true,
	update: function() {
		$.ajax({
			type: "put",
			url: "/menuitem/",
			data: {
				"order": $(this).sortable("serialize")
			}
		});
	}
});
$( "#photo_list" ).disableSelection();
</script>
