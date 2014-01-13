App.LetterUsersView = Em.View.extend(
  filteredUsers: (->
    @get("controller.activeUsers").filterProperty("firstLetter", @get("content"))
  ).property('content')

  template: Em.Handlebars.compile """
    <div class="row">
      {{#each view.filteredUsers}}
        {{view App.UserView contentBinding="this"}}
      {{/each}}
    </div>
  """
)