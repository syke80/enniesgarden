<% include file='_header.tpl' %>

<% if $user[id_shop] %>
<div id="product">
	<div id="list_language_select">
		<% foreach from=$languagelist item=language %>
		<button lang_iso="<% $language[iso] %>"><% $language[iso] %> - <% $language[name] %></button>
		<% /foreach %>
	</div>

	<div id="product_list" class="list"></div>
	<div class="action">
		<button class="btn_add" type="button">Add new product</button>
	</div>
</div>
<% /if %>

<script type="text/javascript">

$("#list_language_select button").click( function() {
	$("#list_language_select button").removeClass("active");
	$(this).addClass("active");

	$("#product_list").conscendoTable({
		title_text: "Product list",
		url: "<% $siteconfig[site_url] %>/product/list/"+$(this).attr("lang_iso")+"/",
		fields: [
			{
				name: "product_code",
				title: "Product code",
				sortable: true,
				filter: "search_like",
			}, {
				name: "permalink",
				title: "Permalink",
				sortable: true,
				filter: "search_like",
			}, {
				name: "name",
				title: "Name",
				sortable: true,
				filter: "search_like",
			}, {
				name: "category_name",
				title: "Category",
				filter: "select",
				sortable: true,
			}, {
				name: "supplier_name",
				title: "Supplier",
				filter: "select",
				sortable: true,
			}
		],
		buttons: [ {
				name: "Edit",
				classname: "btn_edit",
				show_fields: ["id_product"]
			}, {
				name: "Del",
				classname: "btn_del",
				show_fields: ["id_product"]
			}
		],
		classes: "",
		id:  	"",
		limit: 30,
		onLoad: function() {
			$("#product_list .btn_edit").click( function() {
				$.simplebox( {
					"simplebox_id": "product_edit",
					"url": "<% $siteconfig[site_url] %>/product/edit/"+$(this).attr("id_product"),
					"width": 1150,
					"height": 600
				} );								
			});
			$("#product_list .btn_del").click( function() {
				$.simplebox( {
					"simplebox_id": "product_del",
					"url": "<% $siteconfig[site_url] %>/product/delete/"+$(this).attr("id_product")+"/"+$("#list_language_select button.active").attr("lang_iso"),
					"width": 300,
					"height": 120
				} );								
			});
		}
	});

});
$("#list_language_select button:first").trigger("click");


$("#product .action .btn_add").click( function() {
	$.simplebox( {
		"simplebox_id": "product_add",
		"url": "<% $siteconfig[site_url] %>/product/add",
		"title": "Add new product",
		"width": 800,
		"height": 450
	} )
});
</script>

<% include file='_footer.tpl' %>
