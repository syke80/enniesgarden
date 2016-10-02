<script type="text/javascript">
$(document).ready(function() {
	$("#form_del").ajaxForm({
		dataType: "json",
		success: function(data) {
			if (data.error == "") {
				$.jGrowl("Category was successfully deleted");
				$("#category_list").conscendoTable("load");
				$.simplebox('destroy', 'category_del_popup');
			}
		}
	});

	$("#del_cancel").click(function () {
		$.simplebox("destroy", "category_del");
	});
});
</script>

<form id="form_del" action="<% $siteconfig[site_url] %>/category/<% $info[id_category] %>/" method="delete">
<div class="del">
	<span>Are you sure you want to delete '<% $info[name] %>' category?</span>
	<div class="actions">
		<button id="del_ok" type="submit">Igen</button>
		<button id="del_cancel" type="button">Nem</button>
	</div>
</div>
</form>
