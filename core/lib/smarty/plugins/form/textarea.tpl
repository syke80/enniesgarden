<div id="item_<% $id %>_<% $item[name] %>" class="form_item<% if $item[label_on_field] %> label_on_field<% /if %><% if $item[extraclass] %> <% $item[extraclass] %><% /if %>">
	<label for="<% $id %>_<% $item[name] %>"><% $item[label] %></label>
	<div class="textarea_container">
		<textarea id="<% $id %>_<% $item[name] %>" class="form_input_field" name="<% $item[name] %>"><% $item[default] %></textarea>
	</div>
	<% if $item[note] %><span class="note"><% $item[note] %></span><% /if %>
</div>
<%*
<% if $item[label_on_field] %>
<script type="text/javascript">
$("#item_<% $id %>_<% $item[name] %> label").click( function() {
	$(this).parent().find("input").focus();
	$(this).hide();
} );
$("#item_<% $id %>_<% $item[name] %> input").focus( function() {
	$(this).parent().find("label").hide();
} );
$("#item_<% $id %>_<% $item[name] %> input").blur( function() {
	if ($(this).val()=="") $(this).parent().find("label").show();
} );

$(document).ready( function() {
	if ($("#item_<% $id %>_<% $item[name] %> input").val()=="") $("#item_<% $id %>_<% $item[name] %> input").parent().find("label").show();
	else $("#item_<% $id %>_<% $item[name] %> input").parent().find("label").hide();
});
</script>
<% /if %>
*%>