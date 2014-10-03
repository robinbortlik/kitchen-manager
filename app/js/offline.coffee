window.OfflineMessage = Em.Object.create
  create: ->
    unless $(".showSweetAlert.visible")[0]
      $(".sweet-alert").parent('div').show()
      sweetAlert(
        title: "Oops..."
        text: "We are sorry, but connection to server failed. Please contact your support."
        type: "error"
        showCancelButton: false
      )

  destroy: ->
    $(".sweet-alert").parent('div').hide()

window.Offline =
  check: ->
    setInterval Offline.ajax, 30000

  ajax: ->
    jQuery.ajax
      type: 'HEAD'
      url: '/health-check'
      success: ->
        OfflineMessage.destroy()
      error: ->
        OfflineMessage.create()