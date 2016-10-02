<script type="text/javascript">
function edit_success(data) {
	$("#shop .list").load("<% $siteconfig[site_url] %>/shop/list");
	$.simplebox('destroy', 'edit_popup');
//		$("#page_list").conscendoTable('load');
}
</script>

<% form form_id='edit' itemtype='form' action='/shop/'.$info[id_shop].'/' method='put' %>
	<% form itemtype='text'   name='name'                label='Name'                            default=$info[name] %>
	<% form itemtype='text'   name='permalink'           label='Permalink'                       default=$info[permalink] %>

	<% form itemtype='chk_group' name='language[]' label='Language' %>
		<% foreach from=$languagelist item=language %>
			<% form itemtype='chk' value=$language[id_language] label=$language[iso].' - '.$language[name] checked=$language[checked] %>
		<% /foreach %>

	<% form itemtype='text'   name='company_name'        label='Company name'                   default=$info[company_name] %>
	<% form itemtype='text'   name='company_url'         label='Company website'                default=$info[company_url] %>
	<% form itemtype='text'   name='company_email'       label='Company contact | email'        default=$info[company_email] %>
	<% form itemtype='text'   name='company_phone'       label='Company contact | phone number' default=$info[company_phone] %>
	<% form itemtype='text'   name='company_city'        label='Company contact | city'         default=$info[company_city] %>
	<% form itemtype='text'   name='company_address'     label='Company contact | address'      default=$info[company_address] %>
	<% form itemtype='text'   name='company_postcode'    label='Company contact | postal code'  default=$info[company_postcode] %>
	<% form itemtype='text'   name='company_country'     label='Company contact | country'      default=$info[company_country] %>
	<% form itemtype='text'   name='company_description' label='Description of company'         default=$info[company_description] %>

	<% form itemtype='fieldset' name='shipping' legend='Shipping methods and costs' %>
	<% foreach from=$shipping_method_list item=shipping_method %>
		<% form itemtype='text' name='shipping_'.$shipping_method[id_shipping_method] label=$shipping_method[name] default=$shipping_method[price] extraclass='shipping_method' %>
	<% /foreach %>

	<% form itemtype='fieldset' name='payment' legend='Payment methods' %>
	<% foreach from=$payment_method_list item=payment_method %>
		<% form itemtype='text' name='payment_'.$payment_method[id_payment_method] label=$payment_method[name] default=$payment_method[price] extraclass='payment_method' %>
	<% /foreach %>

	<% form itemtype='submit' name='ok' label='OK' %>

	<% form cmd='error_msg' id='empty_permalink' msg='Please fill the permalink field' %>
	<% form cmd='error_msg' id='empty_name' msg='Please fill the name field' %>
	<% form cmd='error_msg' id='empty_language' msg='Please select at least one language' %>
	<% form cmd='error_msg' id='already_permalink' msg='Permalink is already in use' %>
<% form cmd='render_form' %>
<% form cmd='render_javascript' function_success='edit_success(data);' msg_success='The changes has been successfully saved' %>
<script>
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
</script>