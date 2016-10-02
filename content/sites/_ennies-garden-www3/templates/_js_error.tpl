$("body").append("<div id=\"error-popup\" class=\"modal-content\" style=\"display: none\"><p class=\"message\"></p><p class=\"actions\"><button class=\"btn-close\" href=\"#\" onclick=\"$.sPopup('destroy'); return false;\">Continue filling the form</button></p></div>");

var msglist = "";
var error_id = "";
var msg = "";
for (var key in data.error) {
	error_id = data.error[key].split("|")[0];
	switch (error_id) {
		<% switch from = $id_language %>
			<% case value='hu' %>
				case "form":                    msg = "Hibás form"; break
				case "db":                      msg = "Adatbázis hiba"; break
				case "empty_phone":             msg = "Az telefonszám kitöltése kötelező"; break
				case "empty_shipping_name":     msg = "A név kitöltése kötelező (szállítás)"; break
				case "empty_shipping_address":  msg = "A cím kitöltése kötelező (szállítás)"; break
				case "empty_shipping_city":     msg = "A város kitöltése kötelező (szállítás)"; break
				case "empty_shipping_postcode": msg = "Az irányítószám kitöltése kötelező (szállítás)"; break
				case "empty_billing_name":      msg = "A név kitöltése kötelező (számlázás)"; break
				case "empty_billing_address":   msg = "A cím kitöltése kötelező (számlázás)"; break
				case "empty_billing_city":      msg = "A város kitöltése kötelező (számlázás)"; break
				case "empty_billing_postcode":  msg = "Az irányítószám kitöltése kötelező (számlázás)"; break
				case "empty_shipping_method":   msg = "A szállítás típusának kiválasztása kötelező"; break
				case "empty_payment_method":    msg = "A fizetés típusának kiválasztása kötelező"; break
				case "empty_email":             msg = "Az email cím kitöltése kötelező"; break
				case "error_email":             msg = "Hibás email cím"; break
				case "empty_passw":             msg = "A jelszó kitöltése kötelező"; break
				case "error_passw":             msg = "A két jelszó nem azonos"; break
				case "already_user_email":      msg = "A megadott emailcímmel már létezik felhasználó"; break
				case "customer_auth":           msg = "Nem regisztrált emailcím, vagy hibás jelszó"; break
				case "session":                 msg = "A kosár üres, lejárt a munkamenet"; break
				case "stock":                   msg = "A termékből nincs raktáron elegendő mennyiség"; break
				case "paypal":                  msg = "Nem sikerült a paypal fizetés létrehozása. Kérjük próbálja újra."; break
			<% case %>
				case "form":                    msg = "Invalid form"; break
				case "db":                      msg = "Database error"; break
				case "empty_phone":             msg = "Please fill out the <strong>phone number</strong> field"; break
				case "empty_shipping_name":     msg = "Please fill out the shipping <strong>name</strong> field"; break
				case "empty_shipping_address":  msg = "Please fill out the shipping <strong>address</strong> field"; break
				case "empty_shipping_city":     msg = "Please fill out the shipping <strong>city</strong> field"; break
				case "empty_shipping_postcode": msg = "Please fill out the shipping <strong>postcode</strong> field"; break
				case "empty_billing_name":      msg = "Please fill out the <strong>billing name</strong> field"; break
				case "empty_billing_address":   msg = "Please fill out the <strong>billing address</strong> field"; break
				case "empty_billing_city":      msg = "Please fill out the <strong>billing city</strong> field"; break
				case "empty_billing_postcode":  msg = "Please fill out the <strong>billing postcode</strong> field"; break
				case "empty_shipping_method":   msg = "Please choose a <strong>shipping method</strong>"; break
				case "empty_payment_method":    msg = "Please choose a <strong>payment method</strong>"; break
				case "empty_name":              msg = "Please fill out the <strong>name</strong> field"; break
				case "empty_message":           msg = "Please fill out the <strong>message</strong> field"; break
				case "empty_email":             msg = "Please fill out the <strong>email</strong> field"; break
				case "error_email":             msg = "Invalid email address"; break
				case "empty_passw":             msg = "Please fill out the <strong>password</strong> field"; break
				case "error_passw":             msg = "The <strong>two password fields</strong> must be the same."; break
				case "already_user_email":      msg = "This email is already registered"; break
				case "customer_auth":           msg = "Email is not registered or the password is invalid"; break
				case "session":                 msg = "The session is expired. Your cart is empty"; break
				case "stock":                   msg = "There are not enough items in stock"; break
				case "paypal":                  msg = "There was a problem connecting to paypal. Please try again."; break
		<% /switch %>
	}
	if (data.error[key].split("|")[1]) {
		msg += "("+data.error[key].split("|")[1]+")";
	}
	msglist += msg+"<br \/>"
}

$("#error-popup .message").html(msglist);

$.sPopup({
	object: "#error-popup"
});


