App.UsersView = Em.View.extend(
  template: Em.Handlebars.compile """
    <h1>Hi dude, so please first identify yourself</h1>
    <div class="row">
      {{#each controller.content}}
        {{view App.UserView contentBinding="this"}}
      {{/each}}
    </div>
  """
)