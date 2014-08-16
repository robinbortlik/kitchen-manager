$(document).ajaxStart ->
  Pace.restart()

$(document).ajaxStop ->
  Pace.stop()
  $('body').removeClass('pace-running')