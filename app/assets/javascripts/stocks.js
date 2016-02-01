var init_stock_lookup = function(){
  $('#stock-lookup-form').on('ajax:before', function(a, b, c){
    show_spinner();
  })
  $('#stock-lookup-form').on('ajax:after', function(a, b, c){
    hide_spinner();
  })
  $('#stock-lookup-form').on('ajax:success', function(event, data, status){
    $('#stock-lookup').replaceWith(data);
    init_stock_lookup();
  })
  $('#stock-lookup-form').on('ajax:error', function(event, xhr, data, status){
    $('#stock-lookup-results').replaceWith(" ");
    hide_spinner();
    $("#stock-lookup-errors").replaceWith("Stock was not found.");
  })
}

$(document).ready(function(){
  init_stock_lookup();
})