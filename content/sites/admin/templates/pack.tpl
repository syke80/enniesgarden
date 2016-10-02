<% include file='_header.tpl' %>

<% if $user[id_shop] %>
<div id="pack">
	<div id="list_language_select">
		<% foreach from=$languagelist item=language %>
		<button lang_iso="<% $language[iso] %>"><% $language[iso] %> - <% $language[name] %></button>
		<% /foreach %>
	</div>

	<div id="pack_list" class="list"></div>
	<div class="action">
		<button class="btn_add" type="button">Add new pack</button>
	</div>
</div>
<% /if %>

<script>

$("#list_language_select button").click( function() {
	$("#list_language_select button").removeClass("active");
	$(this).addClass("active");

	$("#pack_list").conscendoTable({
		title_text: "Pack list",
		url: "<% $siteconfig[site_url] %>/pack/list/"+$(this).attr("lang_iso")+"/",
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
				show_fields: ["id_pack"]
			}, {
				name: "Del",
				classname: "btn_del",
				show_fields: ["id_pack"]
			}
		],
		classes: "",
		id:  	"",
		limit: 10,
		onLoad: function() {
			$("#pack_list .btn_edit").click( function() {
				$.simplebox( {
					"simplebox_id": "pack_edit",
					"url": "<% $siteconfig[site_url] %>/pack/edit/"+$(this).attr("id_pack")+"/",
					"width": 1200,
					"height": 600
				} );								
			});
			$("#pack_list .btn_del").click( function() {
				$.simplebox( {
					"simplebox_id": "pack_del",
					"url": "<% $siteconfig[site_url] %>/pack/delete/"+$(this).attr("id_pack")+"/"+$("#list_language_select button.active").attr("lang_iso"),
					"width": 300,
					"height": 120
				} );								
			});
		}
	});

});
$("#list_language_select button:first").trigger("click");

$("#pack .action .btn_add").click( function() {
	$.simplebox( {
		"simplebox_id": "pack_add",
		"url": "<% $siteconfig[site_url] %>/pack/add",
		"title": "Add new pack",
		"width": 800,
		"height": 450
	} )
});
</script>

<% include file='_footer.tpl' %>
