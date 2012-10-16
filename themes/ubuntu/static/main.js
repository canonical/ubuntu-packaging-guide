$(function() {

    var toc = "#sidebar";
    var offset = $(toc).offset();

    $(window).scroll(function() {
        if ($(window).height() > $(toc).height() &&   
            $(window).scrollTop() > offset.top) 
        {       
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


$(document).ready(function() {
    var text = 'Search';
    $('#input-search').val(text);

    // Clear and re-populate
    $('#input-search').bind({
        focus: function() {
            if ($(this).val() == text) {
                $(this).val('');
                $(this).css('font-style', 'normal');
                $(this).css('color', '#333');
            }
        },
        blur: function() {
            if ($(this).val() == '') {
                $(this).val(text);
                $(this).css('font-style', 'italic');
                $(this).css('color', '#ccc');
            }
        }
    })
    
    // Enter key submits form
    $('#input-search').keypress(function(e) {
        if (e.which == 13) {
            // Handle empty searches for WP
            if ($(this).val() == '') {
                $(this).val(' ');
            }
            $('#form-search').submit();
            e.preventDefault();
        }
    });
});
