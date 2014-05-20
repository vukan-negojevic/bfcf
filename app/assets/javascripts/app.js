$(function(){

  var initHandlers = function() {
  /*
    $(".play-video").hover(hoverPlayButton, unHoverPlayButton);
    $(".play-video").click(function(e) {
      e.preventDefault();
      hideVideoOverlay();
      playVideo();
      return false;
    });
  */
    enableAccordions();
    enableVideoModal();
    $(window).scroll(checkDivPosition);
    checkDivPosition();
  };
  // VIDEO MODAL

  var enableVideoModal = function() {
    $('#open-modal-video').click(function(){
      uSwitch.modal.openModal(false,{
        'type':'ajax',
        'target':'video',
        'width':'l',
        'closedirection':'down'
      });
    });
  };

  // FAQ menu accordion
  var enableAccordions = function() {
    var answers = $('.section-faq .answer');
    answers.not(answers.first()).hide();

    var questions = $('.question');
    questions.first().addClass('active');

    questions.click(function (e) {
      e.preventDefault();
      questions.not(this).removeClass('active')
      $(this).toggleClass('active')
      answers.not($(this).next()).slideUp()
      $(this).next().slideToggle()
      return false;
    });
  };

  var checkDivPosition = function() {
    var $topbar = $('.top-bar');
    var windowPosition = $(window).scrollTop();

    if (windowPosition < 50) {
      $topbar.addClass("top-bar-hero");
    } else {
      $topbar.removeClass("top-bar-hero");
    }
  };
  
  jQuery.event.add(window, "load", resizeFrame);
  jQuery.event.add(window, "resize", resizeFrame);

  function resizeFrame() 
  {
			var h = $(window).height();
			var w = $(window).width();
			$("iframe").css('height', h - 400);
  }

  $(document).foundation();
  initHandlers();
});

// HERO SCREEN VIDEO

/*
var hoverPlayButton = function() {
  $(".play-svg").addClass("hover");
};

var unHoverPlayButton = function() {
  $(".play-svg").removeClass("hover");
};

var hideVideoOverlay = function() {
  $(".overlay-video-still").hide();
};

var playVideo = function() {
  var iframe = $(".video-preview-section iframe");
  iframe.attr('src', iframe.attr('src') + '?autoplay=1');
};
*/



