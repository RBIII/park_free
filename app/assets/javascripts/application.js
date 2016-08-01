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
//= require jquery_ujs
//= require foundation
//= require underscore
//= require gmaps/google
//= require_tree .

$(function() { $(document).foundation(); });

$(function() {
  $('.flash-messages').delay(1500).fadeOut(600);
});

$(document).ready(function() {
  $('.overlay').overlay();
});

function categoryGuide() {
  setTimeout(function() {
      $('a.overlay-link').click();
  }, 10);
};

function selectParkingInfoTab(id) {
  let commentsSelector = "#comments-" + id.toString()
  let commentsTabSelector = "#comments-tab-" + id.toString()
  let parkingInfoSelector = "#parking-info-" + id.toString()
  let parkingTabSelector = "#info-tab-" + id.toString()

  $(commentsSelector).removeClass("is-active");
  $(commentsTabSelector).attr("aria-selected", "false")
  $(parkingInfoSelector).addClass("is-active");
  $(parkingTabSelector).attr("aria-selected", "true");
}

function selectCommentsTab(id) {
  let commentsSelector = "#comments-" + id.toString()
  let commentsTabSelector = "#comments-tab-" + id.toString()
  let parkingInfoSelector = "#parking-info-" + id.toString()
  let parkingTabSelector = "#info-tab-" + id.toString()

  $(parkingInfoSelector).removeClass("is-active");
  $(parkingTabSelector).attr("aria-selected", "false");
  $(commentsSelector).addClass("is-active");
  $(commentsTabSelector).attr("aria-selected", "true")
}
