<%* "property_del" legyen a simplebox_id *%>

<script type="text/javascript">
$(document).ready(function() {
	$("#form_property_del").ajaxForm({
		dataType: "json",
		success: function(data) {
			if (data.error == "") {
				$.simplebox("destroy", "property_del");
			}
			else {
				<% include file="_js_error.tpl" %>
			}
		}
	});

	$("#del_cancel").click(function () {
		$.simplebox("destroy", "property_del");
	});
});
</script>

<form id="form_property_del" action="<% $siteconfig[site_url] %>/property/<% $info[id_property] %>/" method="delete">
<div class="del">
	<span>Are you sure you want to delete '<% $info[name] %>' property?</span>
	<div class="actions">
		<button id="del_ok" type="submit">Yes</button>
		<button id="del_cancel" type="button">No</button>
	</div>
</div>
</form>
