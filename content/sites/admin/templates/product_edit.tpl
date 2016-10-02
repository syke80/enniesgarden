<script>
jQuery.fn.refreshPropertyBox = function() {
	this.each(function(i){
		$(this).load("<% $siteconfig[site_url] %>/product/edit/property/"+$("#edit_id_category").val()+"/<% $info[id_product] %>/"+$(this).attr("language_iso"));
	});
}
function edit_success(data) {
	$("#product_list").conscendoTable("load");
	$.simplebox("destroy", "product_edit");
}

</script>

<% form form_id='edit' itemtype='form' action='/product/'.$info[id_product].'/' method='put' %>
	<% form itemtype='fieldset' name='basic_data' %>
		<% form itemtype='select'   name='id_category'       label='Category'           default=$info[id_category] %>
			<% foreach from=$categorylist item=category %>
				<% form itemtype='option' value=$category[id_category] label=$category[name] %>
			<% /foreach %>
		<% form itemtype='select'   name='is_featured'       label='Is featured'        default=$info[is_featured] %>
			<% form itemtype='option' value='n' label='No' %>
			<% form itemtype='option' value='y' label='Yes' %>
		<% form itemtype='select'   name='is_sale'           label='Sale'               default=$info[is_sale] %>
			<% form itemtype='option' value='n' label='No' %>
			<% form itemtype='option' value='y' label='Yes' %>
		<% form itemtype='text'     name='product_code'      label='Product code'       default=$info[product_code] %>
		<% form itemtype='text'     name='barcode'           label='Barcode'            default=$info[barcode] %>
		<% form itemtype='text'     name='price'             label='Price'              default=$info[price] %>
		<% form itemtype='text'     name='quantity'          label='Quantity'           default=$info[quantity] %>
		<% form itemtype='hidden'   name='id_supplier'       value=$info[id_supplier] %>
		<% form itemtype='select'   name='is_active'         label='Is active'          default=$info[is_active] %>
			<% form itemtype='option' value='y' label='Yes' %>
			<% form itemtype='option' value='n' label='No' %>
<%*
		<% form itemtype='fieldset' name='shipping' legend='Shipping methods and costs' %>
		<% foreach from=$shipping_method_list item=shipping_method %>
			<% form itemtype='text' name='shipping_'.$shipping_method[id_shipping_method] label=$shipping_method[name] default=$shipping_method[price] extraclass='shipping_method' %>
		<% /foreach %>

		<% form itemtype='fieldset' name='payment' legend='Payment methods and costs' %>
		<% foreach from=$payment_method_list item=payment_method %>
			<% form itemtype='text' name='payment_'.$payment_method[id_payment_method] label=$payment_method[name] default=$payment_method[price] extraclass='payment_method' %>
		<% /foreach %>
*%>
	<% foreach from=$languagelist item=language %>
		<% assign name='id_language' value=$language[id_language] %>
		<% assign name='text_info' value=$text[$id_language] %>
		<% form itemtype='fieldset' name=$language[iso].'_text' extraclass='edit_text' %>
			<% form itemtype='text'     name=$language[iso].'_name'              label='Name ('.$language[iso].')'              default=$text_info[name] extraclass='input_name' %>
			<% form itemtype='text'     name=$language[iso].'_permalink'         label='Permalink ('.$language[iso].')'         default=$text_info[permalink] extraclass='input_permalink' %>
			<% form itemtype='button'   name=$language[iso].'_create_permalink'  label='Create Permalink' type='button'         extraclass='btn_create_permalink' %>
			<% form itemtype='textarea' name=$language[iso].'_short_description' label='Short description ('.$language[iso].')' default=$text_info[short_description] extraclass='short_description' %>
			<% form itemtype='textarea' name=$language[iso].'_long_description'  label='Long description ('.$language[iso].')'  default=$text_info[long_description]  extraclass='long_description' %>
	<% /foreach %>

	<% form itemtype='fieldset' name='buttons' %>
		<% form itemtype='submit'   name='ok' label='OK' %>

	<% form cmd='error_msg' id='empty_name' msg='Please fill the name field' %>
	<% form cmd='error_msg' id='empty_category' msg='Please fill the category field' %>
	<% form cmd='error_msg' id='empty_permalink' msg='Please fill the permalink field' %>
	<% form cmd='error_msg' id='already_permalink_in_category' msg='Permalink is already in use' %>
	<% form cmd='error_msg' id='invalid_price' msg='Invalid price' %>
<% form cmd='render_form' %>
<% form cmd='render_javascript' function_success='edit_success(data);' msg_success='The changes has been successfully saved' %>

<div id="edit_language_select">
	<% foreach from=$languagelist item=language %>
	<button lang_iso="<% $language[iso] %>"><% $language[iso] %> - <% $language[name] %></button>
	<% /foreach %>
</div>

<script>
$("#edit_id_category").change( function () {
	$(".property_container").refreshPropertyBox();
});

$(".form_item.shipping_method, .form_item.payment_method").each( function() {
	if ($("input[type=text]", this).val() == "") {
		$("input", this).attr("disabled", "disabled");
		$("<input type=\"checkbox\" />").insertAfter( $("label", this) );
	}
	else {
		$("<input type=\"checkbox\" checked=\"checked\" />").insertAfter( $("label", this) );
	}
});

$(".form_item.shipping_method input[type=checkbox], .form_item.payment_method input[type=checkbox]").click( function() {
	if ($(this).prop("checked")) $("input[type=text]", $(this).parent()).removeAttr("disabled");
	else $("input[type=text]", $(this).parent()).attr("disabled", "disabled");
});

$("#edit_language_select button").click( function() {
	$("#edit_language_select button").removeClass("active");
	$(this).addClass("active");
	$("#form_edit .edit_text").hide();
	$("#form_edit fieldset[name="+$(this).attr("lang_iso")+"_text]").show();
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
		//filebrowserBrowseUrl : '<% $siteconfig[site_url] %>/content/javascript/jasfinder/index.html',
		filebrowserBrowseUrl : '<% $siteconfig[site_url] %>/content/javascript//kcfinder/browse.php?type=files',
		filebrowserImageBrowseUrl : '<% $siteconfig[site_url] %>/content/javascript/kcfinder/browse.php?type=images&dir=content/files/page',
		//filebrowserFlashBrowseUrl : '<% $siteconfig[site_url] %>/content/javascript//kcfinder/browse.php?type=flash',
		filebrowserUploadUrl : '<% $siteconfig[site_url] %>/content/javascript//kcfinder/upload.php?type=files',
		filebrowserImageUploadUrl : '<% $siteconfig[site_url] %>/content/javascript/kcfinder/upload.php?type=images&dir=content/files/page',
		//filebrowserFlashUploadUrl : '<% $siteconfig[site_url] %>/content/javascript//kcfinder/upload.php?type=flash',
		width: 700,
		height: 300,
		indentOffset: 20,
		entities: false,
		bodyClass: 'page',
		colorButton_enableMore: false,
		colorButton_colors: '58585A,88952B,555555'
//		forcePasteAsPlainText: true
	});
/*
	var textfield_id = "item_edit_<% $language[iso] %>_long_description .textarea_container";
	$("#"+textfield_id).css( "position", "absolute");
	$("#"+textfield_id).css( "top", $(window).height() / 2 - $("#"+textfield_id).outerHeight() / 2 );
	$("#"+textfield_id).css( "left", $(window).width() / 2 - $("#"+textfield_id).outerWidth() / 2 );
  */
/*
	$('#edit_<% $language[iso] %>_long_description .textarea_container').hide();
	$('#edit_<% $language[iso] %>_long_description label').click( function() {
		$('#edit_<% $language[iso] %>_long_description .textarea_container').show();
	});
*/
	<% /foreach %>

<% foreach from=$languagelist item=language %>
//$("fieldset[name=<% $language[iso] %>_text] .short_description").insertBefore("<div class=\"property_container\" language_iso=\"<% $language[iso] %>\">TEST</div>");
$("<div class=\"property_container\" language_iso=\"<% $language[iso] %>\"></div>").insertBefore("fieldset[name=<% $language[iso] %>_text] .short_description");
<% /foreach %>
$(".property_container").refreshPropertyBox();

$(".btn_create_permalink button").click( function() {
	$(".input_permalink input", $(this).closest("form")).val(
		$(".input_name input", $(this).closest("form")).val().URLize()
	);
});

</script>



<% include file='_product_edit_photo.tpl' %>
