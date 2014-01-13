App.FlashMessageView = Em.View.extend
  template: Em.Handlebars.compile """
    <div {{bind-attr class=":alert view.messageType"}}>{{view.message}}</div>
  """

  didInsertElement: ->
    setTimeout =>
      @destroy()
    , 5000


App.FlashMessageView.reopenClass
  createMessage: (message, cssClass) ->
    @create(message: message, messageType: "alert-#{cssClass}").appendTo("#flash-message")