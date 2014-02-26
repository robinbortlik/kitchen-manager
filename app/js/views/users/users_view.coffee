App.UsersView = Em.View.extend(
  actions:
    cancel: -> App.set("selectedLetters.content", [])

  keyPress: ->
    alert('a')

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

  template: Em.Handlebars.compile """
    <div class="row">
      {{#each controller.letters}}
        {{view App.LetterUsersView contentBinding="this"}}
      {{/each}}
      {{#if App.selectedLetters }}
        <p class="text-center">
          <small>You are searching for: {{controller.selectedLettersLabel}}</small>
          <span class="btn btn-danger btn-xs" {{action "cancel" target="view"}}>
            <i class="glyphicon glyphicon-remove"></i> Clear
          </span>
        </p>
      {{/if}}
      <hr/>
    </div>

    {{#if controller.chunkedUsers}}
      {{#each users in controller.chunkedUsers}}
        <div class="row">
          {{#each users}}
            {{view App.UserView contentBinding="this" controllerBinding="view.controller"}}
          {{/each}}
        </div>
      {{/each}}
    {{else}}
      <h1>There is not user with name including {{controller.selectedLettersLabel}}</h1>
    {{/if}}
  """
)
