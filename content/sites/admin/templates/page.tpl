<% include file='_header.tpl' %>

<div id="page_list">
</div>

<script>
$("#page_list").conscendoTable({
	title_text: "Page list",
	url: "<% $siteconfig[site_url] %>/page/list/",
	fields: [ {
			name: "permalink",
			title: "Permalink",
			sortable: true,
			filter: "search_like"
		}, {
			name: "id_site",
			title: "Site ID",
			sortable: true,
			filter: "select"
		}, {
			name: "category_name",
			title: "Category",
			sortable: true,
			filter: "select"
		}
	],
	buttons: [ {
			name: "Edit",
			classname: "btn_edit",
			show_fields: ["id_page"]
		}, {
			name: "Del",
			classname: "btn_del",
			show_fields: ["id_page"]
		}
	],
	classes: "",
	id:  	"",
	limit: 12,
	onLoad: function() {
		$("#page_list .btn_edit").click( function() {
			$.simplebox( {
				"simplebox_id": "edit_popup",
				"url": "<% $siteconfig[site_url] %>/page/edit/"+$(this).attr("id_page"),
				"width": 1000,
				"height": 500
			} );								
		});
		$("#page_list .btn_del").click( function() {
			$.simplebox( {
				"simplebox_id": "del_popup",
				"url": "<% $siteconfig[site_url] %>/page/del/"+$(this).attr("id_page"),
				"width": 500,
				"height": 200
			} );								
		});
	}
});
</script>

<div id="button_container">
	<button id="btn_add">Add new page</button>
</div>

<script>
$("#btn_add").click( function() {
		$.simplebox( {
			"simplebox_id": "add_popup",
			"url": "<% $siteconfig[site_url] %>/page/add",
			"width": 600,
			"height": 160
		} );								
});
</script>
<% include file='_footer.tpl' %>
