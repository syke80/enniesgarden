var msg = "";
for (var key in data.error) {
	switch (data.error[key]) {
		case "form": msg += "<\div>Invalid form<\/div>"; break
		case "db": msg += "<\div>Database error<\/div>"; break
		case "403": msg += "<\div>You don't have permission to perform this operation<\/div>"; break
		case "user_auth": msg += "<\div>Invalid user name or password<\/div>"; break
		case "user_inactive": msg += "<\div>User is inactive<\/div>"; break
		case "user_disabled": msg += "<\div>User is disabled<\/div>"; break
		case "empty_username": msg += "<\div>User name is required<\/div>"; break
		case "empty_name": msg += "<\div>Name is required<\/div>"; break
		case "empty_passw": msg += "<\div>Password is required<\/div>"; break
		case "error_passw": msg += "<\div>Password confirm must be the same as password<\/div>"; break
		case "empty_email": msg += "<\div>E-mail address is required<\/div>"; break
		case "empty_shop": msg += "<\div>Please select a shop<\/div>"; break
		case "empty_descrtiption": msg += "<\div>Description is required<\/div>"; break
		case "empty_category": msg += "<\div>Please select a category<\/div>"; break
		case "empty_companydata": msg += "<\div>Please fill the company data fields<\/div>"; break
		case "empty_permalink": msg += "<\div>Please fill the permalink field<\/div>"; break
		case "already_permalink": msg += "<\div>Permalink is already in use<\/div>"; break
		case "already_username": msg += "<\div>User name is already in use<\/div>"; break
		case "already_permalink_in_category": msg += "<\div>Permalink is already in use in this category<\/div>"; break
		case "already_property_in_category": msg += "<\div>Property is already exists in this category<\/div>"; break
		case "already_value_in_property": msg += "<\div>Value is already exists<\/div>"; break
		case "error_upload": msg += "<\div>Upload error<\/div>"; break
		case "error_url": msg += "<\div>Invalid url<\/div>"; break
		case "error_format": msg += "<\div>Unknown format<\/div>"; break
	}
}
$.jGrowl(msg);
