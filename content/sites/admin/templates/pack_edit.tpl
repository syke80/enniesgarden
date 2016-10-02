<script>
function edit_success(data) {
	$("#pack_list").conscendoTable("load");
	$.simplebox("destroy", "pack_edit");
}
</script>


<% form form_id='edit' itemtype='form' action='/pack/'.$info[id_pack].'/' method='put' %>
	<% form itemtype='fieldset' name='basic_data' %>
		<% form itemtype='text'     name='price'             label='Price'              default=$info[price] %>
		<% form itemtype='select'   name='id_category'       label='Category'           default=$info[id_category] %>
			<% foreach from=$categorylist item=category %>
				<% form itemtype='option' value=$category[id_category] label=$category[name] %>
			<% /foreach %>

	<% foreach from=$languagelist item=language %>
		<% assign name='id_language' value=$language[id_language] %>
		<% assign name='text_info' value=$text[$id_language] %>
		<% form itemtype='fieldset' name=$language[iso].'_text' extraclass='edit_text' %>
			<% form itemtype='text'     name=$language[iso].'_name'              label='Name ('.$language[iso].')'              default=$text_info[name] %>
			<% form itemtype='text'     name=$language[iso].'_permalink'         label='Permalink ('.$language[iso].')'         default=$text_info[permalink] %>
			<% form itemtype='textarea' name=$language[iso].'_short_description' label='Short description ('.$language[iso].')' default=$text_info[short_description] %>
			<% form itemtype='textarea' name=$language[iso].'_long_description'  label='Long description ('.$language[iso].')'  default=$text_info[long_description] %>
	<% /foreach %>

	<% form itemtype='fieldset' name='buttons' %>
		<% form itemtype='submit'   name='ok' label='OK' %>

	<% form cmd='error_msg' id='empty_name' msg='Please fill the name field' %>
	<% form cmd='error_msg' id='empty_permalink' msg='Please fill the permalink field' %>
	<% form cmd='error_msg' id='already_permalink' msg='Permalink is already in use' %>
	<% form cmd='error_msg' id='invalid_price' msg='Invalid price' %>
<% form cmd='render_form' %>
<% form cmd='render_javascript' function_success='edit_success(data);' msg_success='The changes has been successfully saved' %>

<div id="edit_language_select">
	<% foreach from=$languagelist item=language %>
	<button lang_iso="<% $language[iso] %>"><% $language[iso] %> - <% $language[name] %></button>
	<% /foreach %>
</div>
<script>
$("#edit_language_select button").click( function() {
	$("#edit_language_select button").removeClass("active");
	$(this).addClass("active");
	$("#form_edit .edit_text").hide();
	$("#form_edit fieldset[name="+$(this).attr("lang_iso")+"_text]").show();

	$("#all_products").conscendoTable({
		title_text: "All products",
		url: "<% $siteconfig[site_url] %>/product/list/"+$(this).attr("lang_iso"),
		fields: [ {
				name: "name",
				title: "Name",
				sortable: true,
			}, {
				name: "category_name",
				title: "Category",
				sortable: true,
			}
		],
		buttons: [ {
				name: "Add to pack",
				classname: "btn_add",
				show_fields: ["id_product"]
			}
		],
		classes: "",
		id:  	"",
		limit: 10,
		onLoad: function() {
			$("#all_products .btn_add").click( function() {
				$.ajax({
					"type": "POST",
					"url": "<% $siteconfig[site_url] %>/pack/product/<% $info[id_pack] %>/",
					"data": {
						"id_product": $(this).attr("id_product"),
						"quantity": 1
					}
				}).done( function() {
					$("#linked_products").conscendoTable("load");
				});
			})
		}
	});

	$("#linked_products").conscendoTable({
		title_text: "Linked products",
		url: "<% $siteconfig[site_url] %>/pack/product/<% $info[id_pack] %>/"+$(this).attr("lang_iso"),
		fields: [ {
				name: "name",
				title: "Name",
				sortable: true
			}, {
				name: "quantity",
				title: "Quantity",
				editable: true
			}
		],
		buttons: [ {
				name: "Set quantity",
				classname: "btn_set",
				show_fields: ["id_product"]
			}
		],
		classes: "",
		id:  	"",
		limit: 10,
		onLoad: function() {
			$("#linked_products .btn_set").click( function() {
				console.log();
				$.ajax({
					"type": "PUT",
					"url": "<% $siteconfig[site_url] %>/pack/product/<% $info[id_pack] %>/",
					"data": {
						"id_product": $(this).attr("id_product"),
						"quantity": $("td[field=quantity] input", $(this).parent().parent()).val()
					}
				}).done( function() {
					$("#linked_products").conscendoTable("load");
				});
			})
		}
	});

});
$("#edit_language_select button:first").trigger("click");

<% foreach from=$languagelist item=language %>
if (CKEDITOR.instances.edit_<% $language[iso] %>_long_description) CKEDITOR.instances.edit_<% $language[iso] %>_long_description.destroy(true);
$('#edit_<% $language[iso] %>_long_description').ckeditor({
	toolbar: 	[
		<% if $user[access_value]>=$siteconfig[access][root] %>
		{ name: 'document', items : [ 'Source' ] },
		<% /if %>
		{ name: 'clipboard', items : [ 'Cut','Copy','Paste','PasteText','PasteFromWord','-','Undo','Redo' ] },
		{ name: 'editing', items : [ 'Find','Replace','-','SelectAll' ] },
		'/',
		{ name: 'basicstyles', items : [ 'Bold','Italic','Underline','Strike','Subscript','Superscript','-','RemoveFormat' ] },
		{ name: 'paragraph', items : [ 'NumberedList','BulletedList','-','Outdent','Indent','-','Blockquote','CreateDiv', '-','JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock','-','BidiLtr','BidiRtl' ] },
		{ name: 'links', items : [ 'Link','Unlink','Anchor' ] },
		{ name: 'insert', items : [ 'Image', 'Table','HorizontalRule','SpecialChar' ] },
		{ name: 'styles', items : [ 'Format' ] },
		{ name: 'tools', items : [ 'ShowBlocks' ] }
		],
	filebrowserBrowseUrl : '<% $siteconfig[site_url] %>/content/javascript//kcfinder/browse.php?type=files',
	filebrowserImageBrowseUrl : '<% $siteconfig[site_url] %>/content/javascript/kcfinder/browse.php?type=images&dir=content/files/page',
	filebrowserUploadUrl : '<% $siteconfig[site_url] %>/content/javascript//kcfinder/upload.php?type=files',
	filebrowserImageUploadUrl : '<% $siteconfig[site_url] %>/content/javascript/kcfinder/upload.php?type=images&dir=content/files/page',
	width: 700,
	height: 300,
	indentOffset: 20,
	entities: false,
	bodyClass: 'page',
	colorButton_enableMore: false,
	colorButton_colors: '58585A,88952B,555555'
//	forcePasteAsPlainText: true
});
<% /foreach %>

</script>

<div id="linking_box">
	<div id="all_products">
	</div>
	
	<div id="linked_products">
	</div>
</div>
<% include file='_pack_edit_photo.tpl' %>
