<script type="text/javascript">
$(document).ready(function() {
	$("#form_del").ajaxForm({
		dataType: "json",
		success: function(data) {
			if (data.error == "") {
				$.jGrowl("Shop was successfully deleted");
				$("#shop .list").load("<% $siteconfig[site_url] %>/shop/list");
				$.simplebox("destroy", "shop_del");
			}
			else {
				<% include file="_js_error.tpl" %>
			}
		}
	});

	$("#del_cancel").click(function () {
		$.simplebox("destroy");
	});
});
</script>

<form id="form_del" action="<% $siteconfig[site_url] %>/shop/<% $info[id_shop] %>/" method="delete">
<div class="del">
	<span>Are you sure you want to delete '<% $info[name] %>' shop?</span>
	<div class="actions">
		<button id="del_ok" type="submit">Yes</button>
		<button id="del_cancel" type="button">No</button>
	</div>
</div>
</form>
