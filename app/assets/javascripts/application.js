// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery.turbolinks
//= require jquery_ujs
//= require turbolinks
//= require foundation
//= require gmaps/google
//= require_tree .

$(function() { $(document).foundation(); });

$(function() {
  $('.flash-messages').delay(1500).fadeOut(600);
});

$(document).on('ready page:load', function () {
  var overlay = $('.overlay')
  overlay.overlay();

  overlay.unbind('click').bind('click', function() {
    toggleOverlayButtonColor(overlay);

    $(this).removeClass('shown');
    return true;
  });
});

$(document).ajaxError(function (e, xhr, settings) {
  if (xhr.status == 401) {
    window.location.replace('/users/sign_in');
  }
});

function toggleOverlayButtonColor(overlay) {
  if(overlay.hasClass('shown')) {
    $('#marker_guide_link').addClass('secondary');
  } else {
    $('#marker_guide_link').removeClass('secondary');
  }
};

function categoryGuide() {
  setTimeout(function() {
      $('a.overlay-link').click();
  }, 10);
};

function closeMenuIfOpen(event) {
  var dropdownMenu = $('#dropdown-menu')

  if(dropdownMenu.hasClass("is-open")) {
    dropdownMenu.removeClass("is-open");
    event.stopPropagation();
  }
};
