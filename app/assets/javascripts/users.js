// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

function user_event_handler() {
  $('#user_email').keyup( function edit_user_email() {
    $('#current_email').text($(this).val());
  });
}

$(document).ready(user_event_handler);