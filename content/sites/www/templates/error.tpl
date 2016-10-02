<!DOCTYPE html>
<html lang="hu">
	<head>
		<title><% $shop[name] %></title>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<link href="<% loadfromskin file="css/page.css" %>" rel="stylesheet" type="text/css" />
		<script src="//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
		<script src="<% $siteconfig[site_url] %>/content/javascript/jquery.scroll.js" type="text/javascript"></script>
	</head>

	<body>
		<div id="error_content">
			<div class="http_error">
				<span class="code"><% $errorcode %> Hiba</span><br />
				<span class="info">
				<% switch from=$errorcode %>
					<% case value="100" %>folyamatban (continue)
					<% case value="101" %>protokol váltás (switching protocols)
					<% case value="200" %>kérés sikeresen teljesítve (ok)
					<% case value="201" %>teljesítve (created)
					<% case value="202" %>elfogadva (accepted)
					<% case value="203" %>nem hitelesített információ (non-authoritative information)
					<% case value="204" %>nincs megjeleníthető tartalom (no content)
					<% case value="205" %>tartalom újratöltés (reset content)
					<% case value="206" %>részleges tartalom (partial content)
					<% case value="300" %>többirányú átirányítás (multiple choices)
					<% case value="301" %>állandó átirányítás (moved permanently)
					<% case value="302" %>url megtalálva (found)
					<% case value="303" %>a keresett fájl, vagy könyvtár máshol található (see other)
					<% case value="304" %>a tartalom nem változott (not modified)
					<% case value="305" %>proxy használat (use proxy)
					<% case value="306" %>már nem használatos kód (unused)
					<% case value="307" %>átmeneti, ideiglenes átirányítás (temporary redirect)
					<% case value="400" %>hibás lekérdezés (bad request)
					<% case value="401" %>jogosulatlan lekérdezés (unauthorized)
					<% case value="402" %>a lekérdezéshez fizetés, vagy előfizetés szükséges (payment required)
					<% case value="403" %>tiltott, hozzáférés megtagadva (forbidden)
					<% case value="404" %>az oldal nem található (not found)
					<% case value="405" %>a lekérdezés módszere nem engedélyezett (method not allowed)
					<% case value="406" %>nem elfogadható lekérdezés (not acceptable)
					<% case value="407" %>proxy hitelesítés szükséges (proxy authentication required)
					<% case value="408" %>lekérdezés nem teljesítve időtúllépés miatt (request timeout)
					<% case value="409" %>adategyeztetési hiba (conflict)
					<% case value="410" %>a keresett fájl, vagy könyvtár ismeretlen helyre költözött (gone)
					<% case value="411" %>adatméret lekérdezési hiba (length required)
					<% case value="412" %>a lekérdezés előfeltétele nem teljesült (precondition failed)
					<% case value="413" %>túl nagy méretű lekérdezés (request entity too large)
					<% case value="414" %>túl hosszú url (request-uri too long)
					<% case value="415" %>nem támogadott médiatípus (unsupported media type)
					<% case value="416" %>a kért tartomány nem meghatározható (requested range not satisfiable)
					<% case value="417" %>nem hitelesített elvárás (expectation failed)
					<% case value="500" %>belső szerverhiba (internal server error)
					<% case value="501" %>nem teljesített (not implemented)
					<% case value="502" %>hibás, vagy hibásan meghatározott átjáró (bad gateway)
					<% case value="503" %>a szolgáltatás nem elérhető (service unaviable)
					<% case value="504" %>átjáró időtúllépés hiba (gateway timeout)
					<% case value="505" %>nem támogatott http verzió (http version not supported)
				<% /switch %>
				</span>

			</div>

			<script type="text/javascript">
			$(document).ready( function() {
				$("#featured .list").load("<% $siteconfig[site_url] %>/list/featured", function() {
					if ($(this).html() == "") {
						$(this).parent().hide();
					}
					else {
						$(this).parent().scroll();
					}
				});
				$("#sale .list").load("<% $siteconfig[site_url] %>/list/sale", function() {
					if ($(this).html() == "") {
						$(this).parent().hide();
					}
					else {
						$(this).parent().scroll();
					}
				});
				$("#new .list").load("<% $siteconfig[site_url] %>/list/new", function() {
					if ($(this).html() == "") {
						$(this).parent().hide();
					}
					else {
						$(this).parent().scroll();
					}
				});
			});
			</script>

			<div id="featured" class="scroll">
				<h2>Ajánlott termékek</h2>
				<div class="list">
				</div>
			</div>

			<div id="sale" class="scroll">
				<h2>Akciós termékek</h2>
				<div class="list">
				</div>
			</div>

			<div id="new" class="scroll">
				<h2>Legújabb termékek</h2>
				<div class="list">
				</div>
			</div>
		</div>
	</body>
</html>