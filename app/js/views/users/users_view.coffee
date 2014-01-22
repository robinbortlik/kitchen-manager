App.UsersView = Em.View.extend(
  actions:
    cancel: -> @set("controller.selectedLetter", null)

  template: Em.Handlebars.compile """
    {{#if controller.selectedLetter}}
      <h1>Now identify yourself <small class="small" {{action "cancel" target="view"}}>or return back</small></h1>
      <div class="row">
        {{#each controller.selectedUsers}}
          {{view App.UserView contentBinding="this" controllerBinding="view.controller"}}
        {{/each}}
      </div>
    {{else}}
      <h1>Hi dude, please select first letter of your surname</h1>
      {{#each controller.letters}}
        {{view App.LetterUsersView contentBinding="this"}}
      {{/each}}
    {{/if}}
  """
)