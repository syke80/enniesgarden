<% if $siteconfig[ga_id] %>
<script>
	(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
	(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
	m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
	})(window,document,'script','/gateway/analytics.js','ga');

	(function() {
		var win = window;
		var removeUtms = function(){
			var location = win.location;
			if (location.search.indexOf('utm_') != -1 && history.replaceState) {
				history.replaceState({}, '', window.location.toString().replace(/([&?])utm([_a-z0-9=-]+)/ig, ""));
			}
		};
		ga('create', '<% $siteconfig[ga_id] %>', 'auto');
		ga('send', 'pageview', { 'hitCallback': removeUtms });
		ga('require', 'ec');
	})();
</script>
<% /if %>
