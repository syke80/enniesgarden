<script type="text/javascript">
$(document).ready(function() {
	$("#form_<% $id %>").ajaxForm({
		dataType: "json",
		beforeSerialize: function() {
			<% foreach from=$fieldsets value=fieldset %>
				<% foreach from=$fieldset[items] value=item %>
				<% if $item[type]=='password' %>
				var passw_md5 = $("#<% $id %>_<% $item[name] %>").val() == "" ? "" : $.md5($("#<% $id %>_<% $item[name] %>").val());
				$("#form_<% $id %> input[name=<% $item[name] %>]").val(passw_md5);
				<% /if %>
				<% if $item[type]=='chk_group' && $item[serialize]==true %>
					var value_list = new Array();
					$("#form_<% $id %> input[name=source_<% $item[name] %>]").each( function() {
						if ($(this).attr("checked")) value_list.push($(this).val());
					});
					$("#form_<% $id %> input[name=<% $item[name] %>]").val(value_list.join(','));
				<% /if %>
				<% /foreach %>
			<% /foreach %>
			<% if $function_beforeserialize %>
			<% $function_beforeserialize %>
			<% /if %>
		},
		beforeSubmit: function(arr, $form, options) {
			<% if $function_beforesubmit %>
			<% $function_beforesubmit %>
			<% /if %>
			$("button[type=submit]", $form).addClass("inprogress");
			$("button[type=submit]", $form).attr("disabled", true);
			$("button[type=submit]", $form).attr("btn_label", $("button[type=submit]", $form).html());
			<% if $msg_wait %>$("button[type=submit]", $form).html("<% $msg_wait %>");<% /if %>
		},
		success: function(data, statusText, xhr, $form) {
			$("button[type=submit]", $form).removeClass("inprogress");
			$("button[type=submit]", $form).attr("disabled", false);
			$("button[type=submit]", $form).html($("button[type=submit]", $form).attr("btn_label"));
			if ((typeof data.error == 'undefined') || data.error == "") {
				<% if $resetform %>
				$(":input:text", $form).val('');
				$("textarea", $form).val('');
				$(":input:password", $form).val('');
				$('input:checkbox').removeAttr('checked');
				<% /if %>
				<% if $msg_success %>
				$.jGrowl("<% $msg_success %>");
				<% /if %>
				<% if $function_success %>
				<% $function_success %>
				<% /if %>
			}
			else {
				<% if $function_error %>
				<% $function_error %>
				<% /if %>
				var msg = "";
				var error_id = "";
				for (var key in data.error) {
					<%* error id kimásolása a hibakódból. Pl.: already_permalink|en id: already_permalink, egyéb info: en *%>
					error_id = data.error[key].split("|")[0];
					switch (error_id) {
						<% foreach from=$error_msg value='item' key='key' %>
						case "<% $key %>":
							msg += "<\div>";
							msg += "<% $item %>";
							if (data.error[key].split("|")[1]) {
								msg += "("+data.error[key].split("|")[1]+")";
							}
							msg += "<\/div>";
							break
						<% /foreach %>
					}
				}
				$.jGrowl(msg);
			}
		}
	});

	$(".label_on_field input").val("");

	function form_label_on_field_set(obj) {
		<%*
			ha a focus inputon, vagy textarean van, akkor mindenkepp eltunik
			ha a focus selecten van, akkor mindenkepp eltunik
			ha nincs focus az objektumon, akkor a tartalomtol fugg hogy show vagy hide
		*%>
		if ($(".form_input_field", obj).is(":focus")) {
			if ($(".form_input_field", obj).prop('tagName') != "SELECT") $("label", obj).hide();
			else {
				if ($(".form_input_field", obj).val()=="") $("label", obj).show();
				else $("label", obj).hide();
			}
		}
		else {
			if ($(".form_input_field", obj).val()=="") $("label", obj).show();
			else $("label", obj).hide();
		}
	}

	setInterval(	function() {
		$("#form_<% $id %> .label_on_field").each( function() {
			form_label_on_field_set(this);
		});
	}, 100);
});
</script>
