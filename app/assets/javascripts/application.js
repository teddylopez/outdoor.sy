// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require rails-ujs
//= require activestorage
//= require_tree .

$(document).ready(function () {
  autoSubmitForms();
  clickableTableRows();
});

function autoSubmitForms() {
  $(".autosubmit").change(function () {
    $(this).closest("form").submit();
  });

  var urlParams = new URLSearchParams(window.location.search);
  var type = urlParams.get("vehicle_type");
  $("option[value='" + type + "']").attr("selected", true);
}

function clickableTableRows() {
  $("tr[data-link]").click(function () {
    window.location = $(this).data("link");
  });
}
