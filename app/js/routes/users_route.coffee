App.UsersRoute = Ember.Route.extend(
  setupController: (controller, model) ->
    App.set "selectedLetters.content", []
)