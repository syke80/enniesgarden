<table width="650" align="center" cellpadding="0" cellspacing="0">
<tr><td><img src="<% $siteconfig[shop_url] %>/content/sites/_ennies-garden-www3/images/email-header.jpg"></td></tr>
</table>
<br />
<table cellpadding="0" cellspacing="0" style="font-family: verdana; font-size: 14px; color: #333333; line-height: 1.75em;" width="650" align="center">
<tr>
<td align="center">
	<h1 style="font-size: 1.75em;">Dear <% $name %></h1>
	<%*
	<p>
	We are working to improve our products and website. That is why we want your help. Please fill up this questionnaire.<br />
	It takes <strong>only 1 minute</strong>.<br />
	To benefit your help you get a <strong>FREE tube of Luxury Butter Shortbread</strong> by your next order.
	</p>
	*%>

	<p>
	We need your help.<br />
	</p>

	<p style="font-size: 1.2em">
	Please fill this questionnaire, and<br /> <strong style="font-size: 1.1em">get a free tube of luxury butter shortbread</strong> <br />by your next order.
	</p>
</td>
</tr>
</table>
<br />
<br />
<form action="<% $siteconfig[shop_url] %>/feedback/" method="post">
<input type="hidden" name="email" value="<% $email %>" />
<input type="hidden" name="name" value="<% $name %>" />
	<table cellpadding="0" cellspacing="0" style="font-family: verdana; font-size: 14px; color: #333333; line-height: 1.5em;" width="630" align="center">
		<tr><td><h2 style="font-size: 1.25em;">How do the preserves taste?</h2></td></tr>
		<tr><td><label><input type="radio" name="taste" value="5" /> &nbsp; I adore them</label></td></tr>
		<tr><td><label><input type="radio" name="taste" value="4" /> &nbsp; Delicious</label></td></tr>
		<tr><td><label><input type="radio" name="taste" value="3" /> &nbsp; Nothing special</label></td></tr>
		<tr><td><label><input type="radio" name="taste" value="2" /> &nbsp; I don’t like them</label></td></tr>
		<tr><td><label><input type="radio" name="taste" value="1" /> &nbsp; I haven’t tasted them yet</label></td></tr>
		<tr><td>&nbsp;</td></tr>
		<tr><td><h2 style="font-size: 1.25em;">What is your opinion about the website<br /> and the shopping process?</h2></td></tr>
		<tr><td><label><input type="radio" name="process" value="5" /> &nbsp; Excellent</label></td></tr>
		<tr><td><label><input type="radio" name="process" value="4" /> &nbsp; Okay</label></td></tr>
		<tr><td><label><input type="radio" name="process" value="3" /> &nbsp; Average</label></td></tr>
		<tr><td><label><input type="radio" name="process" value="2" /> &nbsp; Poor</label></td></tr>
		<tr><td><label><input type="radio" name="process" value="1" /> &nbsp; Awful</label></td></tr>
		<tr><td>&nbsp;</td></tr>

		<tr><td><h2 style="font-size: 1.25em;">How could we make it better?</h2></td></tr>
		<tr><td><textarea style="width: 100%;" rows="5" cols="80" name="better"></textarea></td></tr>
		<tr><td>&nbsp;</td></tr>

		<tr><td><h2 style="font-size: 1.25em;">Other remark & proposal</h2></td></tr>
		<tr><td><textarea style="width: 100%;" rows="5" cols="80" name="other"></textarea></td></tr>
		<tr><td>&nbsp;</td></tr>

		<tr><td align="center"><button type="submit" style="font-size: 1.5em; padding: 0.25em 2em;">Send</button></td></tr>
	</table>
</form>
<br />
<br />
