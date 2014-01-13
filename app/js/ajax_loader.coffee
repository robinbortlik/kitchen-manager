$(document).ajaxStart ->
  $('<div class="spinner"></div>').prependTo("#ember-app")

$(document).ajaxStop ->
  $('.spinner').remove()