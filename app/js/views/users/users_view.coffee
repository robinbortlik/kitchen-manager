App.UsersView = Em.View.extend(
  actions:
    cancel: -> @set("controller.selectedLetters.content", [])

  template: Em.Handlebars.compile """
    <div class="row">
      {{#each controller.letters}}
        {{view App.LetterUsersView contentBinding="this"}}
      {{/each}}
      {{#if controller.selectedLetters }}
        <br/>
        <span class="btn btn-danger" {{action "cancel" target="view"}}>
          <i class="glyphicon glyphicon-remove">&nbsp;</i>
        </span>
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