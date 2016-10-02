<div id="basket-popup" class="modal-content" style="display: none">
	<p>Product successfully added to your basket.</p>
	<p class="large-amount-message">Only <strong>6-day</strong> delivery available in this amount.</p>
	<p class="actions">
		<a class="btn btn-basket" href="/basket/#">Go to your basket</a>
	</p>
</div>
<script>

function showBasketPopup(contentId, $buttonObj) {
	var popupId = Math.floor((Math.random() * 1000) + 1);
	$("body").append("<div id=\"popup-"+popupId+"\" class=\"basket-popup init\"></div>");
	var $popup = $("#popup-"+popupId);
	console.log($popup);
	console.log($buttonObj);

	$popup.hide();
	$popup.html( $("#"+contentId).html() );

	$popup.css("right", $(window).width() - $buttonObj.offset().left - $buttonObj.outerWidth());
	$popup.css("top", $buttonObj.offset().top - $(window).scrollTop());

	$popup.show(0, function() {
		$popup.addClass("finish");
		$popup.removeClass("init");
	});

	var timeoutId = setPopupTimeout($popup);
	$popup.attr("data-timeout", timeoutId);

	$popup.mouseenter( function() {
		clearTimeout($(this).attr("data-timeout"));
		$(this).removeAttr("data-timeout");
	});
	
	$popup.mouseleave( function() {
		var timeoutId = setPopupTimeout($(this));
		$(this).attr("data-timeout", timeoutId);
	});
}

function setPopupTimeout($popup) {
	return setTimeout(function() {
		$popup.addClass("remove");
		$popup.removeClass("finish");
		setTimeout(function() {
			$popup.remove();
		}, 1000);
	}, 4000);
}

onLoadFunctions.push( function() {
	$(".form_add button[type=submit]").removeAttr("disabled");
	$(".form_add").ajaxForm({
		dataType: "json",
		beforeSubmit: function(arr, $form, options) {
			$("button", $form).addClass("inprogress");
			$("button", $form).attr("disabled", true);
			$("button", $form).attr("btn_label", $("button", $form).html());
			$("button", $form).html("Please wait");
		},
		success: function(data, statusText, xhr, $form) {
			$("button", $form).removeClass("inprogress");
			$("button", $form).attr("disabled", false);
			$("button", $form).html($("button", $form).attr("btn_label"));

			<%* Ha tobbet rendelt mint a raktarkeszlet, akkor hosszabb lesz a delivery time *%>

			if (data.warning[0] == "stock") $("#basket-popup .large-amount-message").show();
			else $("#basket-popup .large-amount-message").hide();

			showBasketPopup("basket-popup", $("button", $form));

			$("#cart").load("<% $siteconfig[site_url] %>/basket/gadget/<% $id_language %>/");
			$("input[name=quantity]", $form).val("1");
		}
	});

});
</script>