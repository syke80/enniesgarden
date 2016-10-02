			</div>
		</div>
		<footer>
			<div class="wrapper">
				<% page permalink='_footer-'.$id_language region='body' id_site='www' %>
<%*
				<section class="partners">
					<a class="quaestor valign" href="http://www.quaestor.hu"><img alt="Quaestor" src="<% $siteconfig[site_url] %>/content/sites/_immunforte-www/images/logo-quaestor.jpg" /></a>
					<a class="onco-shop valign" href="http://oncoshop.hu/"><img alt="Onco-Shop" src="<% $siteconfig[site_url] %>/content/sites/_immunforte-www/images/logo-onco-shop.jpg" /></a>
					<a class="herba-fitt valign" href="http://herba-fitt.hu/immunrendszererosito-;cid:59;l:hu;p:22;s:abc;o:asc"><img alt="HERBA-FITT" src="<% $siteconfig[site_url] %>/content/sites/_immunforte-www/images/logo-herba-fitt.jpg" /></a>
					<a class="medi-line valign" href="http://www.mediline.hu/"><img alt="MediLine" src="<% $siteconfig[site_url] %>/content/sites/_immunforte-www/images/logo-mediline.jpg" /></a>
					<a class="biopiac valign" href="http://bolt.biopiac.info/kategoria/gyogygomba_keszitmenyek.html?mind"><img alt="Biopiac" src="<% $siteconfig[site_url] %>/content/sites/_immunforte-www/images/logo-biopiac.jpg" /></a>
					<a class="magyartermek valign" href="http://www.amagyartermek.hu/partner/50/"><img alt="Magyar termék" src="<% $siteconfig[site_url] %>/content/sites/_immunforte-www/images/logo-magyar-termek.jpg" /></a>
				</section>
				<ul class="links">
					<li><a href="<% $siteconfig[site_url] %>/rolunk">Rólunk</a></li>
					<li><a href="<% $siteconfig[site_url] %>/altalanos-szerzodesi-feltetelek">Általános szerződési feltételek</a></li>
					<li><a href="<% $siteconfig[site_url] %>/adatvedelmi-nyilatkozat">Adatvédelmi nyilatkozat</a></li>
					<li><a href="<% $siteconfig[site_url] %>/gyik">Gyakran ismételt kérdések</a></li>
				</ul>
				<section itemscope itemtype="http://schema.org/Organization" class="company">
					<span itemprop="name" class="name"><% $shop[company_name] %></span>
					<a itemprop="url" class="url" href="<% $shop[company_url] %>"><% $shop[company_url] %></a>
					<a itemprop="email" class="email" href="mailto:<% $shop[company_email] %>"><% $shop[company_email] %></a>
					<span itemprop="telephone" class="telephone"><% $shop[company_phone] %></span>
					<span itemprop="address" itemscope itemtype="http://schema.org/PostalAddress" class="address">
						<span itemprop="postalCode"><% $shop[company_postcode] %></span>,
						<span itemprop="addressLocality"><% $shop[company_city] %></span>,
						<span itemprop="streetAddress" class="street"><% $shop[company_address] %></span>,
						<span itemprop="addressCountry" class="country-name"><% $shop[company_country] %></span>
					</span>
					<span class="description"><% $shop[company_description] %></span>
				</section>
*%>
			</div>
		</footer>
		<% include file="../../_common/templates/_debug.tpl" %>
	</body>
</html>
