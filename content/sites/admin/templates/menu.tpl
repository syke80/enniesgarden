<% include file='_header.tpl' %>

<div id="menu_list">
</div>

<script>
$("#menu_list").conscendoTable({
	title_text: "Menu list",
	url: "<% $siteconfig[site_url] %>/menu/list/",
	fields: [ {
			name: "name",
			title: "Name",
			sortable: true,
			filter: "search_like"
		}
	],
	buttons: [ {
			name: "Edit",
			class: "btn_edit",
			classname: "btn_edit",
			show_fields: ["id_menu"]
		}, {
			name: "Del",
			class: "btn_del",
			classname: "btn_del",
			show_fields: ["id_menu"]
		}, {
			name: "Items",
			class: "btn_items",
			classname: "btn_items",
			show_fields: ["id_menu"]
		}
	],
	classes: "",
	id:  	"",
	limit: 10,
	onLoad: function() {
		$("#menu_list .btn_edit").click( function() {
			$.simplebox( {
				"simplebox_id": "edit_popup",
				"url": "<% $siteconfig[site_url] %>/menu/edit/"+$(this).attr("id_menu")+"/",
				"width": 1000,
				"height": 500
			} );								
		});
		$("#menu_list .btn_del").click( function() {
			$.simplebox( {
				"simplebox_id": "del_popup",
				"url": "<% $siteconfig[site_url] %>/menu/del/"+$(this).attr("id_menu")+"/",
				"width": 500,
				"height": 200
			} );								
		});
		$("#menu_list .btn_items").click( function() {
			window.location.href = "<% $siteconfig[site_url] %>/menuitem/"+$(this).attr("id_menu");
		});
	}
});
</script>

<div id="button_container">
	<button id="btn_add">Add new menu</button>
</div>

<script>
$("#btn_add").click( function() {
		$.simplebox( {
			"simplebox_id": "add_popup",
			"url": "<% $siteconfig[site_url] %>/menu/add/",
			"width": 600,
			"height": 160
		} );								
});
</script>
<% include file='_footer.tpl' %>
