jQuery(window).scroll(function(){
    jQuery(".top").css("opacity", 1 - jQuery(window).scrollTop() / 250);
  });
