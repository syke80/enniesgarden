<div class="productlist-box">
	<% if $productlist || $packlist %>
	<ul class="productlist results">
	<% foreach from=$productlist item=product %>
		<% include file='_list_item_product.tpl' %>
	<% /foreach %>
	<% foreach from=$packlist item=pack %>
		<% include file='_list_item_pack.tpl' %>
	<% /foreach %>
	</ul>
	<% else %>
	<div class="productlist_empty">
	<% switch from = $id_language %>
		<% case value='hu' %>Nincs megjeleníthető termék
		<% case %>There are no products in this category
	<% /switch %>
	</div>
	<% /if %>
</div>

<% include file='_basket_script.tpl' %>
