App.UsersView = Em.View.extend(
  actions:
    cancel: -> @set("controller.selectedLetters.content", [])

  keyPress: ->
    alert('a')

  didInsertElement: ->
    $(document).off 'keydown'
    $(document).on 'keydown', (e) =>
      return false if (e.keyCode < 65 || e.keyCode > 90) && e.keyCode != 8
      if e.keyCode == 8
        @get("controller.selectedLetters.content").popObject()
      else
        @get("controller.selectedLetters.content").pushObject(String.fromCharCode(e.keyCode))
      e.preventDefault()
      e.stopPropagation()

  willDestroyElement: ->
    $(document).off 'keydown'

  template: Em.Handlebars.compile """
    <div class="row">
      {{#each controller.letters}}
        {{view App.LetterUsersView contentBinding="this"}}
      {{/each}}
      {{#if controller.selectedLetters }}
        <p class="text-center">
          <small>You are searching for: {{controller.selectedLettersLabel}}</small>
          <span class="btn btn-danger btn-xs" {{action "cancel" target="view"}}>
            <i class="glyphicon glyphicon-remove"></i>
          </span>
        </p>
      {{/if}}
      <hr/>
    </div>

    {{#if controller.selectedUsers}}
      <div class="row">
        {{#each controller.selectedUsers}}
          {{view App.UserView contentBinding="this" controllerBinding="view.controller"}}
        {{/each}}
      </div>
    {{else}}
      <h1>There is not user with name including {{controller.selectedLettersLabel}}</h1>
    {{/if}}
  """
)