<% rand assign='unique_id' min=100000 max=999999 %> 

<div id="item_<% $id %>_<% $item[name] %>" class="form_item<% if $item[label_on_field] %> label_on_field<% /if %>">
	<span class="select_styled"></span>
	<label for="<% $id %>_<% $item[name] %>"><% $item[label] %></label>
	<select id="<% $id %>_<% $item[name] %>" name="<% $item[name] %>" class="form_input_field">
		<% foreach from=$item[options] value='option' %>
		<option <% if $option[extraclass] %>class="<% $option[extraclass] %>" <% /if %>value="<% $option[value] %>"<% if $item[default]==$option[value] %> selected="selected"<% /if %>><% $option[label] %></option>
		<% /foreach %>
	</select>
</div>
<script type="text/javascript">
	$("#item_<% $id %>_<% $item[name] %> .select_styled").width( $("#item_<% $id %>_<% $item[name] %> select").width() );
	var select_position = $("#item_<% $id %>_<% $item[name] %> select").position();
	var select_margin_left = parseInt($("#item_<% $id %>_<% $item[name] %> select").css('margin-left'));
	var select_margin_top = parseInt($("#item_<% $id %>_<% $item[name] %> select").css('margin-top'));
	if (isNaN(select_margin_left)) select_margin_left=0;
	if (isNaN(select_margin_top)) select_margin_top=0;
	$("#item_<% $id %>_<% $item[name] %> .select_styled").css({
		'left': select_position.left+select_margin_left+'px',
		'top': select_position.top+select_margin_top+'px'
	});
</script>
<script type="text/javascript">
function refresh_select_<% $unique_id %>() {
<%*
	<% if $item[label_on_field] %>
	if ($("#<% $id %>_<% $item[name] %>").val()=='') $(this).parent().find("label").show();
	else $("#<% $id %>_<% $item[name] %>").parent().find("label").hide();
	<% /if %>
*%>
	$("#item_<% $id %>_<% $item[name] %> .select_styled").html( $("#item_<% $id %>_<% $item[name] %> select option:selected").html() );
}

refresh_select_<% $unique_id %>();

$("#<% $id %>_<% $item[name] %>").change( function() {
	refresh_select_<% $unique_id %>()
} );
</script>
