var init_friend_lookup = function(){
  $('#friend-lookup-form').on('ajax:before', function(a, b, c){
    show_spinner();
  })
  $('#friend-lookup-form').on('ajax:after', function(a, b, c){
    hide_spinner();
  })
  $('#friend-lookup-form').on('ajax:success', function(event, data, status){
    $('#friend-lookup').replaceWith(data);
    init_friend_lookup();
  })
  $('#friend-lookup-form').on('ajax:error', function(event, xhr, data, status){
    $('#friend-lookup-results').replaceWith(" ");
    hide_spinner();
    $("#friend-lookup-errors").replaceWith("Person was not found.");
  })
}

$(document).ready(function(){
  init_friend_lookup();
})