(function($) {
	/**
	 * Ez tömmbben keresi a searchString-t tartalmazó elem (tömb[].field = searchString) indexét
	 */	 	
	function searchField(arr, searchString) {
		if (arr.length == 0) return false;
		for (var i = 0; i<arr.length; i++) {
			if (arr[i].field == searchString) return i;
		}
		return false;
	}
	
	/**
	 * Ez tömmbből törli a searchString-t tartalmazó elemet (tömb[].field = searchString)
	 */	 	
	function deleteField(arr, searchString) {
		if (searchField(arr, searchString) !== false) {
			arr.splice(searchField(arr, searchString), 1);
		}
		return arr;
	}

	var methods = {
		init: function(init_options) {
			// default configuration properties
			var defaults = {
				"url": "",                        // az url ahonnan a lista adatait kapjuk
				"fields": "",                     //
				"buttons": "",
				"onLoad": function() {}, 
				"sortable": "",                   //
				"editable": "",                   //
				"title_text": "",
				"btn_first_text": "First page", 
				"btn_last_text": "Last page", 
				"btn_previous_text": "Previous page", 
				"btn_next_text": "Next page", 
				"classes": "",                    // 
				"id": "",                         // 
				"limit": 0,                       // 
				"page": 1                         // 
			}; 

			this.options = $.extend(defaults, init_options);

			this.order = new Array();
			this.filter = new Array();

      // Default values of filters
      for (i in this.options.fields) {
      	if (typeof this.options.fields[i].filter != "undefined" && typeof this.options.fields[i].filter_value != "undefined") {
      		this.filter.unshift({
						field: this.options.fields[i].name,
						value: this.options.fields[i].filter_value
					});
				} 
			}

			this.load();
		},
		load: function(refresh_only) {
			var plugin_obj = this;
			var dom_obj = this.dom_obj;
			// Adatok betöltése
			$.get(
				plugin_obj.options.url,
				{
					'order': plugin_obj.order,
					'filter': plugin_obj.filter,
					'limit': plugin_obj.options.limit,
					'page': plugin_obj.options.page
				},
				function(data) {
					var html_content_table = "<table class=\"conscendo_table\">" + (plugin_obj.options.title_text ? "<caption>"+plugin_obj.options.title_text+"</caption>" : "") + "</table>";
					var html_content_head = "";
					var html_content_body = "";
					var html_content_controls = "";

					// HTML: Tábla fejléc
					html_content_head += "<thead><tr class=\"head\">";
					for (i in plugin_obj.options.fields) {
						// Ha rendezhető, akkor a fejléc megkapja a szükséges classokat és gombokat
						if ((plugin_obj.options.fields[i].sortable === true)) {
							var field_idx = searchField(plugin_obj.order, plugin_obj.options.fields[i].name);
							var field_order = field_idx === false ? 'none' : plugin_obj.order[field_idx].direction;
							html_content_head += "<th class=\"sortable\" order=\""+field_order+"\" orderpriority=\""+field_idx+"\" field=\""+plugin_obj.options.fields[i].name+"\">";
							html_content_head += "<button type=\"button\" class=\"btn_order\" order=\""+field_order+"\" field=\""+plugin_obj.options.fields[i].name+"\"></button>";
							html_content_head += "<span class=\"name\">"+plugin_obj.options.fields[i].title+"</span>";
						}
						// Ha nem rendezhető, akkor nincs semmilyen class a fejlécben
						else {
							html_content_head += "<th field=\""+plugin_obj.options.fields[i].name+"\">";
							html_content_head += "<span class=\"name\">"+plugin_obj.options.fields[i].title+"</span>";
						}
						
						// Ha szűrhető a field, akkor egy select is lesz a fejlécben, benne a field lehetséges értékeivel
						if (plugin_obj.options.fields[i].filter == "select") {
							html_content_head += "<select>";
							html_content_head += "<option value=\"\" reset=\"reset\">--- Empty filter ---</option>";
							// Ha a webservice kuldott distinct infokat és a distinct tömbben szerepel az adott field, akkor feltölti a select tartalmát
							if (typeof data.distinct != "undefined" && typeof data.distinct[plugin_obj.options.fields[i].name] != "undefined") {
								for (j in data.distinct[plugin_obj.options.fields[i].name]) {
									html_content_head += "<option value=\""+data.distinct[plugin_obj.options.fields[i].name][j]+"\"";
									if (
										searchField(plugin_obj.filter, plugin_obj.options.fields[i].name)!==false
										&& plugin_obj.filter[searchField(plugin_obj.filter, plugin_obj.options.fields[i].name)]['value'] == data.distinct[plugin_obj.options.fields[i].name][j]
									) html_content_head += "selected=\"selected\"";
									html_content_head += ">";
									html_content_head += data.distinct[plugin_obj.options.fields[i].name][j]+"</option>";
								}
							}
							html_content_head += "</select>";
						}
						
						// Search input: ha a filter search_equal, vagy search_like típusú, akkor egy input mező lesz a fejlécben
						// Ha a field szerepel a filter tömbben (tehát szűrve van rá a táblázat), akkor az inputba be kell írni a tartalmát
						var val = "";
						if (searchField(plugin_obj.filter, plugin_obj.options.fields[i].name)!==false) val = plugin_obj.filter[searchField(plugin_obj.filter, plugin_obj.options.fields[i].name)]['value']
						// ...az input mező
						if (plugin_obj.options.fields[i].filter == "search_equal") {
							html_content_head += "<input class=\"search_equal\" field=\""+plugin_obj.options.fields[i].name+"\" value=\""+val+"\" />";
						}
						if (plugin_obj.options.fields[i].filter == "search_like") {
							html_content_head += "<input class=\"search_like\" field=\""+plugin_obj.options.fields[i].name+"\" value=\""+val+"\" />";
						}

						html_content_head += "</th>";
					}

					if (typeof plugin_obj.options.buttons!="undefined") {
						for (var j in plugin_obj.options.buttons) {
							html_content_head += "<th>&nbsp;</th>";
						}
					}

					html_content_head += "</tr></thead>";

					// HTML: Tábla tartalma
					html_content_body += "<tbody>";
					for (var i in data.list) {
						html_content_body += "<tr class=\"item\">";
						for (var j in plugin_obj.options.fields) {
							if (typeof plugin_obj.options.fields[j].editable != "undefined" && plugin_obj.options.fields[j].editable == true) {
								html_content_body += "<td field=\""+plugin_obj.options.fields[j].name+"\"><input name=\""+plugin_obj.options.fields[j].name+"\" value=\""+data.list[i][plugin_obj.options.fields[j].name]+"\" /></td>";
							}
							else {
								html_content_body += "<td field=\""+plugin_obj.options.fields[j].name+"\">"+data.list[i][plugin_obj.options.fields[j].name]+"</td>";
							}
						}
						if (typeof plugin_obj.options.buttons!="undefined") {
							for (var j in plugin_obj.options.buttons) {
								var html_fields="";
								if (typeof plugin_obj.options.buttons[j].show_fields!="undefined") {
									for (var k in plugin_obj.options.buttons[j].show_fields) {
										html_fields += plugin_obj.options.buttons[j].show_fields[k] + "=\""+data.list[i][plugin_obj.options.buttons[j].show_fields[k]]+"\"";
									}
								}
								html_content_body += "<td><button "+html_fields+" class=\""+plugin_obj.options.buttons[j].classname+"\">"+plugin_obj.options.buttons[j].name+"</button></td>";
							}
						}
						html_content_body += "</tr>";
					}
					html_content_body += "</tbody>";
					
					// HTML: Lapozó
					html_content_controls += "<div class=\"conscendo_navigation\">";
					html_content_controls += "<button type=\"button\" class=\"btn_first imgreplace\">"+plugin_obj.options.btn_first_text+"</button>";
					html_content_controls += "<button type=\"button\""; 
					if (plugin_obj.options.page == 1) html_content_controls += "disabled=\"disabled\""; 
					html_content_controls += " class=\"btn_previous imgreplace\">"+plugin_obj.options.btn_previous_text+"</button>";
					html_content_controls += "<select>";
					for (var i=1; i<=data.pagecount; i++) {
						html_content_controls += "<option value=\""+i+"\"";
						if (plugin_obj.options.page == i) html_content_controls += "selected=\"selected\"";
						html_content_controls += ">"+i+"</option>";
					}
					html_content_controls += "</select>"; 
					html_content_controls += "<button type=\"button\"";
					if (plugin_obj.options.page == data.pagecount) html_content_controls += "disabled=\"disabled\""; 
					html_content_controls += " class=\"btn_next imgreplace\">"+plugin_obj.options.btn_next_text+"</button>";
					html_content_controls += "<button type=\"button\" class=\"btn_last imgreplace\">"+plugin_obj.options.btn_last_text+"</button>";
					html_content_controls += "</div>"; 
					
					if (refresh_only){
						$("table tbody", dom_obj).remove();
						$(".conscendo_navigation", dom_obj).remove();
						$(html_content_body).insertAfter("table thead", dom_obj);
						$(html_content_controls).insertAfter("table", dom_obj);
					}
					else {
						$(dom_obj).html(html_content_table + html_content_controls);
						$("table", dom_obj).append(html_content_head);
						$("table", dom_obj).append(html_content_body);
					}
					
					// Ha a css-ben van az elemekhez rendelve kep, akkor eltuntetjuk a szoveget
					$(dom_obj).imgReplace();

					// Események hozzáadása

					// A fejléc eseményeit csak akkor kell hozzárendelni, ha a teljes táblát újratölti
					if (!refresh_only) {
						// Sorbarendezés
						$("th.sortable .btn_order", dom_obj).click( function() {
							if (searchField(plugin_obj.order, $(this).attr("field")) === false) {
								plugin_obj.order.unshift({field: $(this).attr("field"), direction: "asc"});
							}
							else {
								if (plugin_obj.order[searchField(plugin_obj.order, $(this).attr("field"))].direction == "asc") {
									// Kiveszi a fieldet a filter listából
									plugin_obj.order.splice(searchField(plugin_obj.order, $(this).attr("field")), 1);
									// És berakja az elejére
									plugin_obj.order.unshift({field: $(this).attr("field"), direction: "desc"});
								}
								else {
									plugin_obj.order.splice(searchField(plugin_obj.order, $(this).attr("field")), 1);
								}
							}
							plugin_obj.load();
						});

						// Filter
						$("th select", dom_obj).change( function() {
							plugin_obj.filter = deleteField(plugin_obj.filter, $(this).parent().attr("field"));
							if (!$(":selected", this).attr("reset")) plugin_obj.filter.unshift({field: $(this).parent().attr("field"), value: $(this).val()});
							plugin_obj.load();
						});
	
						// Search_equal
						$("th input.search_equal", dom_obj).keyup( function() {
							plugin_obj.filter = deleteField(plugin_obj.filter, $(this).attr("field"));
							if ($(this).val()) plugin_obj.filter.unshift({field: $(this).attr("field"), value: $(this).val()});
							plugin_obj.load(true);
						});

						// Search_like
						$("th input.search_like", dom_obj).keyup( function() {
							plugin_obj.filter = deleteField(plugin_obj.filter, $(this).attr("field"));
							if ($(this).val()) plugin_obj.filter.unshift({field: $(this).attr("field"), value: $(this).val(), type: "like"});
							plugin_obj.load(true);
						});
          }

					// Lapozó
					$(".conscendo_navigation select", dom_obj).change( function() {
						plugin_obj.options.page = $(this).val();
						plugin_obj.load();
					});
					$(".conscendo_navigation .btn_first", dom_obj).click( function() {
						plugin_obj.options.page = 1;
						plugin_obj.load();
					});
					$(".conscendo_navigation .btn_last", dom_obj).click( function() {
						plugin_obj.options.page = data.pagecount;
						plugin_obj.load();
					});
					$(".conscendo_navigation .btn_previous", dom_obj).click( function() {
						plugin_obj.options.page = parseInt(plugin_obj.options.page)-1;
						plugin_obj.load();
					});
					$(".conscendo_navigation .btn_next", dom_obj).click( function() {
						plugin_obj.options.page = parseInt(plugin_obj.options.page)+1;
						plugin_obj.load();
					});

					// Highlight
					$("tr.item", dom_obj).mouseover( function() {
						$(this).addClass("mouseover");
					});
					$("tr.item", dom_obj).mouseout( function() {
						$(this).removeClass("mouseover");
					});

					// set navigation size to box size
					$(".conscendo_navigation", dom_obj).width(
						$(".conscendo_table", dom_obj).width()
					);

					// run onLoad callback
					plugin_obj.options.onLoad();
				},
				"json"
			);
		}
	}

		// Ez akaszkodik ra a jqueryn keresztul az objektumokra
		$.fn.conscendoTable = function(method) {
			/**
			 * Ha metodushivas van, pl. $("#testdiv").pluginName("methodname");
			 *   Ilyenkor a DOM objektumhoz kapcsolt plugin objektum megfelelo metodusa fut le
			 *   (Az initbol kiderul hogy mi ez)
			 * Ha nincs megadva parameter, pl. $("#testdiv").pluginName();
			 *   Letrejon egy instance a pluginbol
			 *   Hozzakapcsolja a DOM objektumhoz pl #testdiv-hez
			 *   Majd lefut az init()
			 * Ha a megadott metodusnev nem letezik, akkor hibat ir
			 */			 			 			 			 
			if ( methods[method] ) {
				var obj = $(this).data("conscendoTable");
				obj[method].apply(obj, Array.prototype.slice.call( arguments, 1 ));
			} else if ( typeof method === 'object' || ! method ) {
				var obj = new $.conscendoTable();
				obj.dom_obj = this;
				this.data("conscendoTable", obj);
				obj.init.apply(obj, arguments);
			} else {
				$.error( 'Method ' +  method + ' does not exist on jQuery.conscendoTable' );
			}
		};
		// Ez egy sima objektum, ebbol lesznek majd instanceok
		$.conscendoTable = function(dom_obj, args_obj) {
		}
		// Kiegeszitjuk a metodusokkal
		$.extend($.conscendoTable.prototype, methods); 
})(jQuery);
