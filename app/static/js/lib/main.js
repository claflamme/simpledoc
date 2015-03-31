  $(document).ready(function() {
    var left = $('#left');
    var mobileNav = $('#mobileNav');
    mobileNav.on('click', function() {
      left.removeClass('mobileHide');
    });
    $('a', left).on('click', function() {
      left.addClass('mobileHide');
    });
});
