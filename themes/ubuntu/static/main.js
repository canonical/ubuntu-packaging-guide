$(function() {

    var toc = "#sidebar";
    var offset = $(toc).offset();

    $(window).scroll(function() {
        if ($(window).height() > $(toc).height() &&   
            $(window).scrollTop() > offset.top) 
        {       
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
