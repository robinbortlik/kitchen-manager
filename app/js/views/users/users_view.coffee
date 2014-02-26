App.UsersView = Em.View.extend(
  template: Em.TEMPLATES['users/list']
  actions:
    cancel: -> App.set("selectedLetters.content", [])

  didInsertElement: ->
    $(document).off 'keydown'
    $(document).on 'keydown', (e) =>
      return false if (e.keyCode < 65 || e.keyCode > 90) && e.keyCode != 8
      if e.keyCode == 8
        App.get("selectedLetters.content").popObject()
      else
        App.get("selectedLetters.content").pushObject(String.fromCharCode(e.keyCode))
      e.preventDefault()
      e.stopPropagation()

  willDestroyElement: ->
    $(document).off 'keydown'
)
