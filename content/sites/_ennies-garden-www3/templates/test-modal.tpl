<% include file='_header.tpl' %>
Popup test page
<div id="popup" class="modal-content" style="display: none">
	<p>
		Test message in a popup.
	</p>
	<p class="actions">
		<a class="btn btn-close" href="#" onclick="$.sPopup('destroy'); return false;">Ok</a>
	</p>
</div>
<script>
onLoadFunctions.push( function() {
	$.sPopup({
		object: "#popup"
	});
});
</script>
<% include file='_footer.tpl' %>
