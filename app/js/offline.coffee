window.OfflineMessage = Em.Object.create
  create: ->
    unless $("#offlineBox")[0]
      $("body").append(
        """
          <div id="offlineBox" class="modal fade in" style="display:block;" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-dialog">
              <div class="modal-content">
                <div class="modal-header">
                  <h4 class="modal-title">Connection to server failed</h4>
                </div>
                <div class="modal-body">
                  <h3>We are sorry, but connection to server failed.</h3>
                  <h3>Please contact your support.</h3>
                </div>
              </div><!-- /.modal-content -->
            </div><!-- /.modal-dialog -->
          </div><!-- /.modal -->
          <div id="offlineBoxBackdrop" class="modal-backdrop fade in"></div>
      """)

  destroy: ->
    $("#offlineBox, #offlineBoxBackdrop").remove()

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