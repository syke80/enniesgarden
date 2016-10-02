(function($) {
    var options = {};
    var methods = {
        init: function(initOptions) {
            options = initOptions;
            var popupId = Math.floor((Math.random() * 1000) + 1);
            $("body").append("<div class=\"spopup-overlay\"></div>");
            $("body").append("<div class=\"spopup build\"></div>");
            $(".spopup").html( $(options.object).html() );

            methods.arrange();
            $(".spopup").addClass("start");
            setTimeout( function() {
                $(".spopup, .spopup-overlay").addClass("finish");
            }, 100);

            $(".spopup-overlay").click( function() {
                methods.destroy();
            });
            $(window).resize( function() {
                methods.arrange();
            });
            if (options.onLoad !== undefined) options.onLoad();
        },
        updateDimensions: function(contentWidth, contentHeight) {
            options.contentWidth = contentWidth;
            options.contentHeight = contentHeight;
        },
        arrange: function() {
            if (options.onArrange !== undefined) options.onArrange();
            $(".spopup").css("margin-left", -$(".spopup").outerWidth()/2);
            $(".spopup").css("margin-top", -$(".spopup").outerHeight()/2);
        },
        destroy: function() {
            $("body").css("overflow", "auto");
            $(".spopup, .spopup-overlay").addClass("remove");
            setTimeout( function() {
                $(".spopup, .spopup-overlay").remove();
            }, 600);
        }
    };
    $.sPopup = function(method) {
        if ( methods[method] ) {
            return methods[method].apply( this, Array.prototype.slice.call( arguments, 1 ));
        } else if ( typeof method === 'object' || ! method ) {
            return methods.init.apply( this, arguments );
        } else {
            $.error( 'Method ' +  method + ' does not exist on jQuery.sPopup' );
        }
    };
})(jQuery);
