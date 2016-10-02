<% include file='_header.tpl' %>

<% if $user[id_shop] %>
<div id="category">
	<div id="list_language_select">
		<% foreach from=$languagelist item=language %>
		<button lang_iso="<% $language[iso] %>"><% $language[iso] %> - <% $language[name] %></button>
		<% /foreach %>
	</div>

	<div id="category_list" class="list"></div>
	<div class="action">
		<button class="btn_add" type="button">Add new category</button>
	</div>
</div>


<script type="text/javascript">

$("#list_language_select button").click( function() {
	var lang_iso = $(this).attr("lang_iso");

	$("#list_language_select button").removeClass("active");
	$(this).addClass("active");

	$("#category_list").conscendoTable({
		title_text: "Category list",
		url: "<% $siteconfig[site_url] %>/category/list/"+lang_iso+"/",
		fields: [ {
				name: "permalink",
				title: "Permalink",
				sortable: true,
			}, {
				name: "name",
				title: "Name",
				sortable: true,
			}
		],
		buttons: [ {
				name: "Edit",
				classname: "btn_edit",
				show_fields: ["id_category"]
			}, {
				name: "Del",
				classname: "btn_del",
				show_fields: ["id_category"]
			}
		],
		classes: "",
		id:  	"",
		limit: 25,
		onLoad: function() {
			$("#category_list .btn_edit").click( function() {
				$.simplebox( {
					"simplebox_id": "category_edit_popup",
					"url": "<% $siteconfig[site_url] %>/category/edit/"+$(this).attr("id_category")+"/",
					"width": 1200,
					"height": 600
				} );								
			});
			$("#category_list .btn_del").click( function() {
				$.simplebox( {
					"simplebox_id": "category_del_popup",
					"url": "<% $siteconfig[site_url] %>/category/delete/"+$(this).attr("id_category")+"?language="+lang_iso,
					"width": 300,
					"height": 120
				} );								
			});
		}
	});

});
$("#list_language_select button:first").trigger("click");

$("#category .action .btn_add").click( function() {
	$.simplebox( {
		"simplebox_id": "category_add_popup",
		"url": "<% $siteconfig[site_url] %>/category/add",
		"title": "Add new category",
		"width": 800,
		"height": 450
	} )
});
</script>

<% /if %>

<% include file='_footer.tpl' %>
