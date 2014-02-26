App.LetterUsersView = Em.View.extend(
  classNameBindings: [":letter", "active"]

  active: (->
    @get('controller.availableLetters').contains(@get('content'))
  ).property('content', 'controller.availableLetters')

  click: ->
    if @get('active')
      App.get("selectedLetters.content").pushObject(@get("content"))


  template: Em.TEMPLATES['users/letter']
)