$(function() {
    $(window).scroll(function() {
        // Make toc visibile always
        var toc = "#sidebar";
        var offset = $(toc).offset();
        var topPadding = 30;

        // Permit only if window is enough big
        if( $(window).height() > $(toc).height() &&
            $(window).scrollTop() > offset.top ){
                $(toc).stop().addClass('fixed');
        } else {
                $(toc).stop().removeClass('fixed');
        }
    });

    $('a[href=#top]').click(function(){
        $('html, body').animate({scrollTop:0}, 'slow');
        return false;
    });
});
