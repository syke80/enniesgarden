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
			<% case %>
				case "form":                    msg = "Invalid form"; break
				case "db":                      msg = "Database error"; break
				case "empty_phone":             msg = "Please fill out the phone number field"; break
				case "empty_shipping_name":     msg = "Please fill out the shipping name field"; break
				case "empty_shipping_address":  msg = "Please fill out the shipping address field"; break
				case "empty_shipping_city":     msg = "Please fill out the shipping city field"; break
				case "empty_shipping_postcode": msg = "Please fill out the shipping postcode field"; break
				case "empty_billing_name":      msg = "Please fill out the billing name field"; break
				case "empty_billing_address":   msg = "Please fill out the billing address field"; break
				case "empty_billing_city":      msg = "Please fill out the billing city field"; break
				case "empty_billing_postcode":  msg = "Please fill out the billing postcode field"; break
				case "empty_shipping_method":   msg = "Please choose a shipping method"; break
				case "empty_payment_method":    msg = "Please choose a payment method"; break
				case "empty_email":             msg = "Please fill out the email field"; break
				case "error_email":             msg = "Invalid email address"; break
				case "empty_passw":             msg = "Please fill out the password field"; break
				case "error_passw":             msg = "The two password fields must be the same."; break
				case "already_user_email":      msg = "This email is already registered"; break
				case "customer_auth":           msg = "Email is not registered or the password is invalid"; break
				case "session":                 msg = "The session is expired. Your cart is empty"; break
				case "stock":                   msg = "There are not enough items in stock"; break
		<% /switch %>
	}
	if (data.error[key].split("|")[1]) {
		msg += "("+data.error[key].split("|")[1]+")";
	}
	msglist += "<\div>"+msg+"<\/div>"
}
$.jGrowl(msglist, { sticky: true});
