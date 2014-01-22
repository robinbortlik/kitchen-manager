App.LetterUsersView = Em.View.extend(
  classNameBindings: [":letter", "active"]

  active: (->
    @get('controller.availableLetters').contains(@get('content'))
  ).property('content', 'controller.availableLetters')

  click: ->
    if @get('active')
      @get("controller.selectedLetters.content").pushObject(@get("content"))


  template: Em.Handlebars.compile """{{view.content}}"""
)