# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

  $('#start').datetimepicker();
  $('#end').datetimepicker({
    useCurrent: false
  });

  $("#start").on "dp.change", (e) ->
    $('#end').data("DateTimePicker").minDate(e.date);
  return
  $("#end").on "dp.change", (e) ->
    $('#start').data("DateTimePicker").maxDate(e.date)
  return
