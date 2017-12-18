function selectParkingInfoTab(id) {
  $("#reviews-" + id).removeClass("is-active");
  $("#reviews-tab-" + id).attr("aria-selected", "false")
  $("#parking-info-" + id).addClass("is-active");
  $("#info-tab-" + id).attr("aria-selected", "true");
}

function selectReviewsTab(id) {
  $("#parking-info-" + id).removeClass("is-active");
  $("#info-tab-" + id).attr("aria-selected", "false");
  $("#reviews-" + id).addClass("is-active");
  $("#reviews-tab-" + id).attr("aria-selected", "true")
}
