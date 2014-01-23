App.UsersRoute = Ember.Route.extend(
  setupController: (controller, model) ->
    controller.set "selectedLetters.content", []
)