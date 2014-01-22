App.UsersView = Em.View.extend(
  template: Em.Handlebars.compile """
    <h1>Hi dude, so please first identify yourself</h1>
    {{#if controller.selectedLetter}}
      <div class="row">
        {{#each controller.selectedUsers}}
          {{view App.UserView contentBinding="this" controllerBinding="view.controller"}}
        {{/each}}
      </div>
    {{else}}
      {{#each controller.letters}}
        {{view App.LetterUsersView contentBinding="this"}}
      {{/each}}
    {{/if}}
  """
)