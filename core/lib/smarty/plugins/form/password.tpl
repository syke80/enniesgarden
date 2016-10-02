<div id="item_<% $id %>_<% $item[name] %>" class="form_item<% if $item[label_on_field] %> label_on_field<% /if %>">
	<label for="<% $id %>_<% $item[name] %>"><% $item[label] %></label>
	<input name="<% $item[name] %>" type="hidden" />
	<input id="<% $id %>_<% $item[name] %>" class="form_input_field" type="password" <% if $item[autocomplete] %> autocomplete="<% $item[autocomplete] %>"<% /if %> />
</div>
<%*
<% if $item[label_on_field] %>
<script type="text/javascript">
$("#item_<% $id %>_<% $item[name] %> input").val("");
$("#item_<% $id %>_<% $item[name] %> label").click( function() {
	$(this).parent().find("input").focus();
	$(this).hide();
} );
$("#item_<% $id %>_<% $item[name] %> input:password").focus( function() {
	$(this).parent().find("label").hide();
} );
$("#item_<% $id %>_<% $item[name] %> input:password").blur( function() {
	if ($(this).val()=="") $(this).parent().find("label").show();
} );

$(document).ready( function() {
	if ($("#item_<% $id %>_<% $item[name] %> input:password").val()=="") $("#item_<% $id %>_<% $item[name] %> input:password").parent().find("label").show();
	else $("#item_<% $id %>_<% $item[name] %> input:password").parent().find("label").hide();
});
</script>
<% /if %>
*%>