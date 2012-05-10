$(function() {

    var offset = $("#sidebar").offset();
    var topPadding = 30;

    $(window).scroll(function() {
        if ($(window).scrollTop() > offset.top) {       
            $("#sidebar").stop().addClass('fixed');
        
        } else {
        
              $("#sidebar").stop().removeClass('fixed');
        
        }
    });

    $('a[href=#top]').click(function(){
        $('html, body').animate({scrollTop:0}, 'slow');
        return false;
    });
});
