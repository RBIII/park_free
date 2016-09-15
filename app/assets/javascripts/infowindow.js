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

function upvoting(e, id) {
  e.preventDefault();
  e.stopPropagation();
  var upvoting = $("#" + id.toString() + "-upvoting");
  var sum = $("#" + id.toString() + "-sum");
  var newSum = +sum[0].innerHTML + 1;

  upvoting.addClass("upvoted");
  sum[0].innerHTML = newSum.toString();
}

function upvoted(e, id) {
  e.preventDefault();
  e.stopPropagation();
  var upvoted = $("#" + id.toString() + "-upvoted");
  var sum = $("#" + id.toString() + "-sum");
  var newSum = +sum[0].innerHTML - 1;

  upvoted.removeClass("upvoted");
  sum[0].innerHTML = newSum.toString();
}

function downvoting(e, id) {
  e.preventDefault();
  e.stopPropagation();
  var downvoting = $("#" + id.toString() + "-downvoting");
  var sum = $("#" + id.toString() + "-sum");
  var newSum = +sum[0].innerHTML - 1;

  downvoting.addClass("downvoted");
  sum[0].innerHTML = newSum.toString();
}

function downvoted(e, id) {
  e.preventDefault();
  e.stopPropagation();
  var downvoted = $("#" + id.toString() + "-downvoted");
  var sum = $("#" + id.toString() + "-sum");
  var newSum = +sum[0].innerHTML + 1;

  downvoted.removeClass("downvoted");
  sum[0].innerHTML = newSum.toString();
}
