<script>
function add_success(data) {
	$("#product_list").conscendoTable("load");
	$.simplebox("destroy", "product_add");
	$.simplebox( {
		"url": "<% $siteconfig[site_url] %>/product/edit/"+data.id_product+"/",
		"simplebox_id": "product_edit",
		"width": 1150,
		"height": 600
	} )
}
</script>

<% form form_id='add' itemtype='form' action='/product/' method='put' %>
	<% form itemtype='fieldset' name='basic_data' %>
		<% form itemtype='select'   name='id_category'       label='Category' %>
			<% foreach from=$categorylist item=category %>
				<% form itemtype='option' value=$category[id_category] label=$category[name] %>
			<% /foreach %>
		<% form itemtype='select'   name='is_featured'       label='Is featured' %>
			<% form itemtype='option' value='n' label='No' %>
			<% form itemtype='option' value='y' label='Yes' %>
		<% form itemtype='select'   name='is_sale'           label='Sale' %>
			<% form itemtype='option' value='n' label='No' %>
			<% form itemtype='option' value='y' label='Yes' %>
		<% form itemtype='text'     name='product_code'      label='Product code' %>
		<% form itemtype='text'     name='barcode'           label='Barcode' %>
		<% form itemtype='text'     name='price'             label='Price' %>
		<% form itemtype='text'     name='quantity'          label='Quantity' %>
<%*
		<% form itemtype='select'   name='id_supplier'       label='Supplier' %>
			<% foreach from=$supplierlist item=supplier %>
				<% form itemtype='option' value=$supplier[id_supplier] label=$supplier[name] %>
			<% /foreach %>
*%>
		<% form itemtype='select'   name='is_active'         label='Is active' %>
			<% form itemtype='option' value='y' label='Yes' %>
			<% form itemtype='option' value='n' label='No' %>

	<% foreach from=$languagelist item=language %>
		<% assign name='id_language' value=$language[id_language] %>
		<% assign name='text_info' value=$text[$id_language] %>
		<% form itemtype='fieldset' name=$language[iso].'_text' extraclass='add_text' %>
			<% form itemtype='text'     name=$language[iso].'_name'              label='Név ('.$language[iso].')'           default=$text_info[name] %>
			<% form itemtype='text'     name=$language[iso].'_permalink'         label='Permalink ('.$language[iso].')'     default=$text_info[permalink] %>
			<% form itemtype='textarea' name=$language[iso].'_short_description' label='Rövid leírás ('.$language[iso].')'  default=$text_info[short_description] %>
			<% form itemtype='textarea' name=$language[iso].'_long_description'  label='Hosszú leírás ('.$language[iso].')' default=$text_info[long_description] %>
	<% /foreach %>

	<% form itemtype='fieldset' name='buttons' %>
		<% form itemtype='submit'   name='ok' label='OK' %>

	<% form cmd='error_msg' id='empty_name' msg='Please fill the name field' %>
	<% form cmd='error_msg' id='empty_category' msg='Please select a category' %>
	<% form cmd='error_msg' id='empty_permalink' msg='Please fill the permalink field' %>
	<% form cmd='error_msg' id='already_permalink_in_category' msg='Permalink is already in use' %>
	<% form cmd='error_msg' id='invalid_price' msg='Invalid price' %>
<% form cmd='render_form' %>
<% form cmd='render_javascript' function_success='add_success(data);' msg_success='Product was successfully added' %>

<div id="add_language_select">
	<% foreach from=$languagelist item=language %>
	<button lang_iso="<% $language[iso] %>"><% $language[iso] %> - <% $language[name] %></button>
	<% /foreach %>
</div>
<script>
$("#add_language_select button").click( function() {
	$("#add_language_select button").removeClass("active");
	$(this).addClass("active");
	$("#form_add .add_text").hide();
	$("#form_add fieldset[name="+$(this).attr("lang_iso")+"_text]").show();
});
$("#add_language_select button:first").trigger("click");

// Suggest
<% foreach from=$languagelist item=language %>
	$.<% $language[iso] %>_permalink_suggest = true;
	$("#add_<% $language[iso] %>_name").keyup( function() {
		if (!$.<% $language[iso] %>_permalink_suggest) return;
		$("#add_<% $language[iso] %>_permalink").val( this.value.URLize() );
	});
	$("#add_<% $language[iso] %>_permalink").keypress( function() {
		$.<% $language[iso] %>_permalink_suggest = false;
	});
<% /foreach %>
</script>
