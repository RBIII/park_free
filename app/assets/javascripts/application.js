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
//= require jquery.raty
//= require jquery_ujs
//= require ratyrate
//= require turbolinks
//= require foundation
//= require underscore
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

function toggleOverlayButtonColor(overlay) {
  if(overlay.hasClass('shown')) {
    $('#marker_guide_link').addClass('secondary');
    $('#marker_guide_link').removeClass('success');
  } else {
    $('#marker_guide_link').addClass('success');
    $('#marker_guide_link').removeClass('secondary');
  }
}

function categoryGuide() {
  setTimeout(function() {
      $('a.overlay-link').click();
  }, 10);
};

function selectParkingInfoTab(id) {
  var reviewSelector = "#reviews-" + id.toString()
  var reviewTabSelector = "#reviews-tab-" + id.toString()
  var parkingInfoSelector = "#parking-info-" + id.toString()
  var parkingTabSelector = "#info-tab-" + id.toString()

  $(reviewSelector).removeClass("is-active");
  $(reviewTabSelector).attr("aria-selected", "false")
  $(parkingInfoSelector).addClass("is-active");
  $(parkingTabSelector).attr("aria-selected", "true");
}

function selectReviewsTab(id) {
  var reviewSelector = "#reviews-" + id.toString()
  var reviewTabSelector = "#reviews-tab-" + id.toString()
  var parkingInfoSelector = "#parking-info-" + id.toString()
  var parkingTabSelector = "#info-tab-" + id.toString()

  $(parkingInfoSelector).removeClass("is-active");
  $(parkingTabSelector).attr("aria-selected", "false");
  $(reviewSelector).addClass("is-active");
  $(reviewTabSelector).attr("aria-selected", "true")
}
