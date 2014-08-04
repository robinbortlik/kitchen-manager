$(document).ajaxStart ->
  Pace.restart()

$(document).ajaxStop ->
  Pace.stop()