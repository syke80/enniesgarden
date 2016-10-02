<% assign name='id_language' value=$pack[language_iso] %>
<%*
<% pagetag name="title" value=$product[name] %>
<% pagetag name="title" value=" | " method="append" %>
<% pagetag name="title" value=$category[name] method="append" %>
<% pagetag name="title" value=" - " method="append" %>
<% pagetag name="title" value=$siteconfig[site_name] method="append" %>
<% pagetag name="description" value=$product[name] %>
<% pagetag name="description" value=" | " method="append" %>
<% pagetag name="description" value=$category[name] method="append" %>
<% pagetag name="description" value=" | " method="append" %>
<% pagetag name="description" value=$product[short_description] method="append" %>
<% pagetag name="keywords" value=$product[name] %>
<% pagetag name="keywords" value=$category[name] %>
*%>
<% include file='_header.tpl' %>

<script type="text/javascript">
$(document).ready( function() {
	$(".form_add").ajaxForm({
		dataType: "json",
		beforeSubmit: function(arr, $form, options) {
			$("button", $form).addClass("inprogress");
			$("button", $form).attr("disabled", true);
			$("button", $form).attr("btn_label", $("button", $form).html());
			$("button", $form).html("Kérem várjon");
		},
		success: function(data, statusText, xhr, $form) {
			$("button", $form).removeClass("inprogress");
			$("button", $form).attr("disabled", false);
			$("button", $form).html($("button", $form).attr("btn_label"));
			if (data.error == "") {
				$.jGrowl("A termékcsomag a kosárba került");
				$("#cart").load("<% $siteconfig[site_url] %>/basket/gadget/<% $id_language %>");
			}
			else {
				<% include file='_js_error.tpl' %>
			}
		}
	});

	$("#thumbnails li a").click( function() {
		var th_url = $("img", this).attr("src");
		var img_url = th_url.substr(th_url,th_url.length-7)+".png";
		$("#photo img").attr("src", img_url);
		return false;
	});
});
</script>

<div itemscope itemtype="http://schema.org/Product">
<div id="photobox">
	<span id="photo">
		<img itemprop="image" class="photo" src="<% imgresize file='content/files/pack/original/'.$pack[photo_filename] resized_filename='content/files/pack/resized/'.$pack[id_pack]|id2dir.'/'.$pack[permalink].'_'.$pack[shop_permalink].'_'.$pack[id_photo].'_200x320_crop' width=200 height=320 type='crop' %>" alt="<% $pack[name] %>" />
	</span>
	<ul id="thumbnails">
		<% foreach from=$photolist item=photo %>
		<li><a href="#"><img src="<% imgresize file='content/files/pack/original/'.$pack[photo_filename] resized_filename='content/files/pack/resized/'.$pack[id_pack]|id2dir.'/'.$pack[permalink].'_'.$pack[shop_permalink].'_'.$pack[id_photo].'_100x160_crop' width=100 height=160 type='crop' %>" alt="<% $pack[name] %>" /></a></li>
		<% /foreach %>
	</ul>
</div>

<div id="info">
	<h1 class="name" itemprop="name"><% $pack[name] %></h1>
	<% if $pack[short_description] %>
	<p class="short_description">
		<% $pack[short_description]|nl2br %>
	</p>
	<% /if %>
	<div itemprop="offers" itemscope itemtype="http://schema.org/Offer">
		<span itemprop="price" class="price" content="<% $pack[price] %>"><% $pack[price]|number_format:0:'':' ' %></span>
		<span itemprop="priceCurrency" class="currency" content="HUF">Ft</span>
	</div>
	<% if $propertylist %>
	<div class="property">
		<% foreach from=$propertylist item=property %>
		<ul>
			<li>
				<span class="property_name"><% $property[name] %>:</span>
				<ul>
					<% foreach from=$property[valuelist] item=value %>
					<li>
						<% $value[name] %>
						<% pagetag name="keywords" value=$value[name] method="append" %>
					</li>
					<% /foreach %>
				</ul>
			</li>
		</ul>
		<% /foreach %>
	</div>
	<% /if %>
	<div class="cart_add">
		<form class="form_add" action="<% $siteconfig[site_url] %>/basket/" method="post">
		<fieldset>
			<input name="id_pack" value="<% $pack[id_pack] %>" type="hidden" />
			<button type="submit">Kosárba</button>
		</fieldset>
		</form>
	</div>
	<% if $pack[long_description] %>
	<p itemprop="description" class="long_description">
		<% $pack[long_description]|nl2br %>
	</p>
	<% /if %>
</div>
<div class="clear"></div>
</div>
<% include file='_footer.tpl' %>
