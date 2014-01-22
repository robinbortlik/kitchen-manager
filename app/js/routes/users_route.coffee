App.UsersRoute = Ember.Route.extend(
  setupController: (controller, model) ->
    controller.set "selectedLetter", null
)