App.UsersView = Em.View.extend(
  template: Em.Handlebars.compile """
    <h1>Hi dude, so please first identify yourself</h1>

    {{#each controller.letters}}
      <h2>{{this}}</h2><hr />
      <div class="row">
        {{view App.LetterUsersView contentBinding="this"}}
      </div>
    {{/each}}
  """
)