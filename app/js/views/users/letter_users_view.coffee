App.LetterUsersView = Em.View.extend(
  classNames: ['letter']
  click: -> @set("controller.selectedLetter", @get("content"))
  template: Em.Handlebars.compile """{{view.content}}"""
)